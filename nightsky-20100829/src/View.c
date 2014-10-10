/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#include <SDL_image.h>

#include "core.h"
#include "Font.h"
#include "View.h"


extern SDL_Surface  *screen;
extern Font         *font;


Uint32  black;
Uint32  blue;
Uint32  grey[ 256];


double inline min( double a, double b)
{
  return ( a < b) ? a : b;
}


double inline max( double a, double b)
{
  return ( a < b) ? b : a;
}


void subtract_vector( Vector *v1, Vector *v2, Vector *result)
{
  result->x = v1->x - v2->x;
  result->y = v1->y - v2->y;
}


int outcode( Vector *vec, int left, int right, int top, int bottom)
{
  bool  left_of = vec->x < left;
  bool  right_of = right < vec->x;
  bool  above = vec->y < top;
  bool  below = bottom < vec->y;
  return left_of  |  ( right_of << 1)  |  ( below << 2)  |  ( above << 3);
}


// Uses Cohen-Sutherland line clipping.
//
bool clip_line( Line *line, SDL_Surface *surf)
{
  int  max_y = surf->h - 1;
  int  max_x = surf->w - 1;
  int  outcode0 = outcode( &line->begins_at, 0, max_x, 0, max_y);
  int  outcode1 = outcode( &line->ends_at, 0, max_x, 0, max_y);
  int  either = outcode0 | outcode1;
  if ( 0 == either)
  {
    return true;
  }
  else if ( outcode0 & outcode1)
  {
    return false;
  }
  else {
    // clip and repeat
    if ( either & 3) // crosses LEFT or RIGHT
    {
      // Compute intersection.  have to decide whether to replace begins_at or ends_at
      bool  left_to_right = line->begins_at.x < line->ends_at.x;
      bool  cuts_left_edge = either & 1;
      // left_to_right  cuts_left_edge  end_to_move
      //       1               1        beginning
      //       0               1        end
      //       1               0        end
      //       0               0        beginning
      Vector  *end_to_move = left_to_right ^ cuts_left_edge ? &line->ends_at : &line->begins_at;
      Vector  *other_end = left_to_right ^ cuts_left_edge ? &line->begins_at : &line->ends_at;
      int  edge_x = cuts_left_edge ? 0 : max_x;
      Vector  gradient;
      subtract_vector( other_end, end_to_move, &gradient);
      end_to_move->y = end_to_move->y + gradient.y * ( edge_x - end_to_move->x) / gradient.x;
      end_to_move->x = edge_x;
    }
    else {
      bool  up_to_down = line->begins_at.y < line->ends_at.y;
      bool  cuts_top_edge = ( either & 8) != 0;
      Vector  *end_to_move = up_to_down ^ cuts_top_edge ? &line->ends_at : &line->begins_at;
      Vector  *other_end = up_to_down ^ cuts_top_edge ? &line->begins_at : &line->ends_at;
      int  edge_y = cuts_top_edge ? 0 : max_y;
      Vector  gradient;
      subtract_vector( other_end, end_to_move, &gradient);
      end_to_move->x = end_to_move->x + gradient.x * ( edge_y - end_to_move->y) / gradient.y;
      end_to_move->y = edge_y;
    }
    return clip_line( line, surf);
  }
}


// The surface must be locked before invocation of this method.
//
void DrawLine( SDL_Surface *surf, Line *line, Uint32 color)
{
  if ( ! clip_line( line, surf))
    return;

  // Work out the gradient of the line
  Vector  gradient;
  subtract_vector( &line->ends_at, &line->begins_at, &gradient);
  int  adx = abs( gradient.x);
  int  ady = abs( gradient.y);
  int  pixels_to_draw;
  int  error;
  int  major_error;
  int  minor_error;
  int  orthogonal;
  int  diagonal;
  int  i;
  int  adjusted_pitch = surf->pitch / surf->format->BytesPerPixel;

  // If the line is closer to horizontal than vertical..
  if ( adx < ady)
  {
    // The Y axis is the "major" axis
    pixels_to_draw = ady; // The actual number of pixels drawn is ady+1 but the loop takes care of this
    major_error = ady;
    minor_error = adx;
    error = ady - adx/2 + 1;
    orthogonal = 0 < gradient.y ? adjusted_pitch : -adjusted_pitch;
    diagonal = ( 0 < gradient.x ? 1 : -1) + orthogonal;
  }
  else {
    // The X axis is the "major" axis
    pixels_to_draw = adx;
    major_error = adx;
    minor_error = ady;
    error = adx - ady/2 + 1;
    orthogonal = 0 < gradient.x ? 1 : -1;
    diagonal = ( 0 < gradient.y ? adjusted_pitch : -adjusted_pitch) + orthogonal;
  }

  if ( 16 == surf->format->BitsPerPixel)
  {
    Uint16  *pixel_address = surf->pixels +
                             surf->pitch * line->begins_at.y +
                             surf->format->BytesPerPixel * line->begins_at.x;
    for ( i = pixels_to_draw;  0 <= i;  -- i)
    {
      *pixel_address = color;
      error -= minor_error;
      if ( error < 0)
      {
        error += major_error;
        pixel_address += diagonal;
      }
      else {
        pixel_address += orthogonal;
      }
    }
  }
  else if ( 32 == surf->format->BitsPerPixel)
  {
    Uint32  *pixel_address = surf->pixels +
                             surf->pitch * line->begins_at.y +
                             surf->format->BytesPerPixel * line->begins_at.x;
    for ( i = pixels_to_draw;  0 <= i;  -- i)
    {
      *pixel_address = color;
      error -= minor_error;
      if ( error < 0)
      {
        error += major_error;
        pixel_address += diagonal;
      }
      else {
        pixel_address += orthogonal;
      }
    }
  }
}


void prime_view( View *view, Model *model, char *path_to_cursor)
{
  view->model = model;
  view->direction.azimuth   =  0.0;  // Begin by looking North
  view->direction.elevation = 45.0;  // 45 degrees up from the horizon
  view->field_of_view       = 90.0;  // ..and the screen shows the whole sky from the horizon to the zenith
  precompute_location( &view->from_location);
  view->pan_up.azimuth = 0;
  view->pan_down.azimuth = 0;
  view->pan_left.elevation = 0;
  view->pan_right.elevation = 0;
  update_bounds( view);
  update_edges( view);
  SDL_Surface  *source = IMG_Load( path_to_cursor);
  view->cursor = SDL_DisplayFormatAlpha( source);
  SDL_FreeSurface( source);
  view->show_cursor = true;
  view->show_constellations = true;
  view->fine_panning = false;
  black = SDL_MapRGB( screen->format, 0x00, 0x00, 0x00);
  blue  = SDL_MapRGB( screen->format, 0x33, 0x33, 0x99);
  int  i;
  for ( i = 0;  i < 256;  ++ i)
  {
    grey[ i] = SDL_MapRGB( screen->format, i, i, i);
  }
}


// This method should be invoked whenever either the field of view or the
// viewing direction has changed.
//
void update_edges( View *view)
{
    view->azimuth_at_left     = view->direction.azimuth   - view->angle_across_screen * 0.5;
    normalise_azimuth( &view->azimuth_at_left);
    view->elevation_at_top    = view->direction.elevation + view->field_of_view       * 0.5;
    view->elevation_at_bottom = view->direction.elevation - view->field_of_view       * 0.5;
}


// This method should be invoked when the field of view has changed.
//
void update_bounds( View *view)
{
  view->angle_across_screen = view->field_of_view / screen->h * screen->w;
  double  pan_rate = view->fine_panning ? 0.2 : 1.4;
  view->pan_up.elevation   = view->field_of_view * pan_rate; // per second
  view->pan_down.elevation = view->field_of_view * -pan_rate;
  view->pan_left.azimuth   = view->field_of_view * -pan_rate;
  view->pan_right.azimuth  = view->field_of_view * pan_rate;
  view->screen_scale_x = screen->w / view->angle_across_screen;
  view->screen_scale_y = screen->h / view->field_of_view;
}


// Provides the position on screen that corresponds to the given azimuth and elevation.
void project( View *view, Point *place, Vector *on_screen)
{
  // The -0.5 below is to align real numbers to pixels.  there are 320 pixels
  // across the screen so in real terms 320 * 1.0 pixel width.  The centre of a
  // pixel is 0.5 from its left edge, so a real X of 0.5 is bang in the middle
  // of the pixel
  double  relative_azimuth = place->azimuth - view->azimuth_at_left;
  normalise_azimuth( &relative_azimuth);
  on_screen->x = relative_azimuth * view->screen_scale_x - 0.5;
  on_screen->y = ( screen->h - 0.5) - ( place->elevation - view->elevation_at_bottom) * view->screen_scale_y;
}


char  *cardinal_point[] = {"N", "NE", "E", "SE", "S", "SW", "W", "NW"};


void render_view( View *view)
{
  SDL_FillRect( screen, NULL, black);

  SDL_LockSurface( screen);

  Uint32  view_x = view->azimuth_at_left * degrees_to_32;
  int     view_y = view->elevation_at_bottom * degrees_to_32;
  int     divisor = 4294967296.0 / 360 * view->angle_across_screen / screen->w;
  int     half_width = screen->w / 2;
  int     half_height = screen->h / 2;
  int     last_row = screen->h - 1;

  // Render the constellation lines -before- the objects so that the objects
  // are rendered over the top of the lines

  int  i, j;

  if ( view->show_constellations)
  {
    // Go through all the constellations
    for ( i = 0;  i < view->model->constellations;  ++ i)
    {
      Constellation  *con = &view->model->constellation[ i];
      // Go through each line in the constellations
      for ( j = 0;  j < con->lines;  ++ j)
      {
        ConstellationLine  *con_line = &con->line[ j];
        if ( con_line->from_object->place_is_valid  &&
             con_line->to_object->place_is_valid)
        {
          // An object is represented by a pixel so it is either on-screen or
          // not.  Constellation lines are drawn between two objects.  One or
          // both objects might be off-screen even though the line still cuts
          // across the screen and should be drawn.

          // The longest constellation line spans 135 degrees.
          //
          // When the view is zoomed out as far as possible it shows from the
          // horizon to the zenith ( 90 degrees up the screen and 120 degrees
          // across the screen - assuming a 4:3 aspect screen).
          //
          int  from_relative_x = con_line->from_object->x - view_x;
          int  to_relative_x = con_line->to_object->x - view_x;
          // Calculate the number of pixels across the pixel space that the line
          // SHOULD span
          int  ideal_pixels = abs( from_relative_x - to_relative_x) / divisor;
          int  from_screen_x = from_relative_x / divisor;
          int  to_screen_x = to_relative_x / divisor;
          // Calculate the number of pixels across the pixel space that the
          // scaled line wants to span
          int  actual_pixels = abs( from_screen_x - to_screen_x);
          // If the two are significantly different then this line is behind the
          // observer
          if ( 1 < abs( ideal_pixels - actual_pixels))
          {
            continue;
          }

          Line  line = {
            { from_screen_x,
              last_row - ( con_line->from_object->y - view_y) / divisor,
            },
            { to_screen_x,
              last_row - ( con_line->to_object->y - view_y) / divisor,
            },
          };

          DrawLine( screen, &line, blue);
        }
      }
    }
  }

  Object  *closest = NULL;
  int  closest_dist = 2147483647;

  for ( i = view->model->catalog.objects - 1;  0 <= i;  -- i)
  {
    Object  *object = &view->model->catalog.object[ i];

    if ( object->place_is_valid  &&
         view->elevation_at_bottom < object->place_in_sky.elevation  &&
         object->place_in_sky.elevation < view->elevation_at_top)
    {
      // Note: when object->x < view_x there will be 32-bit underflow but the
      // result will still show the object's position relative to the view.
      int  x = ( object->x - view_x) / divisor;
      int  y = last_row - ( object->y - view_y) / divisor;
      // To check that the integer maths get at least within 1 pixel of the slow version:
      //int  x2, y2;
      //project( view, &object->place_in_sky, &x2, &y2);
      //if ( 1 < abs(x- x2) || 1 < abs(y - y2))
      //{
      //  debug("%i != %i or %i != %i", x, x2, y, y2);
      //}
      if ( 0 <= x  &&  x < screen->w  &&  0 <= y  &&  y < screen->h)
      {
        switch ( screen->format->BitsPerPixel)
        {
          case 16:
          {
            Uint16*  pixel_in_column = screen->pixels + screen->pitch * y;
            pixel_in_column[ x] = grey[ object->brightness];
            break;
          }
          case 24:
          {
            Uint8  *pixel = screen->pixels + screen->pitch * y + screen->format->BytesPerPixel * x;
            pixel[ 0] = object->brightness;
            pixel[ 1] = object->brightness;
            pixel[ 2] = object->brightness;
            break;
          }
          case 32:
          {
            Uint32*  pixel_in_column = screen->pixels + screen->pitch * y;
            pixel_in_column[ x] = grey[ object->brightness];
            break;
          }
        }
        // Determine which object is closest to the centre of the screen
        int  dx = x - half_width;
        int  dy = y - half_height;
        int  dist = dx*dx + dy*dy;
        if ( dist < closest_dist)
        {
          closest = object;
          closest_dist = dist;
        }
      }
    }
  }
  SDL_UnlockSurface( screen);

  // Show the cursor
  if ( view->show_cursor  &&  closest != NULL)
  {
    SDL_Rect  target = { (closest->x - view_x) / divisor - view->cursor->w/2,
                         last_row - ( closest->y - view_y) / divisor - view->cursor->h/2,
                         view->cursor->w,
                         view->cursor->h};
    SDL_BlitSurface( view->cursor, &view->cursor->clip_rect, screen, &target);
    Vector  place = { x: target.x + target.w + 4,
                      y: target.y + target.h/2 - font->height/3
                    };
    int  con_id = closest->in_constellation_id;
    bool  in_con = con_id != NO_CONSTELLATION;
    char  *con_name = in_con ? view->model->constellation[con_id].name : "";
    char  *con_label = in_con ? "Con:" : "";
    render_text( font, screen, &place, "%s\n%s%s", closest->name, con_label, con_name);
  }

  // Show the Cardinal points
  for ( i = 0;  i < LENGTH_OF(cardinal_point);  ++ i)
  {
    Vector  on_screen;
    Point  place_in_sky = { 45*i, 7};
    project( view, &place_in_sky, &on_screen);
    on_screen.x = on_screen.x - font->advance / 2;
    on_screen.y = on_screen.y - font->height / 2;
    render_text( font, screen, &on_screen, cardinal_point[i]);
  }

  struct tm  *time = localtime( &view->model->when_updated);
  Vector  place = { x:2, y: screen->h - font->height - 2};
  render_text( font, screen, &place, "%0.1lf\260 @ %.1lf\260, %.1lf\260AH from %.2lf,%.2lf  %u:%02u %cM",
                                     view->field_of_view,
                                     view->direction.azimuth,
                                     view->direction.elevation,
                                     view->from_location.latitude,
                                     view->from_location.longitude,
                                     ( time->tm_hour % 12) ? time->tm_hour % 12 : 12,
                                     time->tm_min,
                                     "PA"[ time->tm_hour < 12]);
}


void keep_elevation_within_bounds( View *view)
{
  view->direction.elevation = min( view->direction.elevation, 90);
  view->direction.elevation = max( view->direction.elevation, 0);
}


void pan_view( View *view, Point direction, Uint32 time_passed)
{
  view->direction.azimuth   += direction.azimuth * time_passed / 1000.0;
  view->direction.elevation += direction.elevation * time_passed / 1000.0;
  normalise_azimuth( &view->direction.azimuth);
  keep_elevation_within_bounds( view);
  update_edges( view);
}


void zoom_view_in( View *view)
{
  view->field_of_view *= 0.5;
  if ( view->field_of_view < 1.0)
    view->field_of_view = 1.0;
  update_bounds( view);
  update_edges( view);
}


void zoom_view_out( View *view)
{
  view->field_of_view *= 2.0;
  if ( 90.0 < view->field_of_view)
    view->field_of_view = 90.0;
  update_bounds( view);
  keep_elevation_within_bounds( view);
  update_edges( view);
}

