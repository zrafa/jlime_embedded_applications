/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#ifndef __VIEW_H
#define __VIEW_H


#include "Model.h"


// direction:     The place in the sky at the centre of the view
// field_of_view: The angle down the screen in degrees
//
typedef struct
{
  Model        *model;
  Location     from_location;
  Point        direction;
  double       field_of_view;
  double       angle_across_screen;
  double       azimuth_at_left;
  double       elevation_at_bottom;
  double       elevation_at_top;
  Point        pan_up;
  Point        pan_down;
  Point        pan_left;
  Point        pan_right;
  SDL_Surface  *cursor;
  bool         show_cursor;
  bool         show_constellations;
  bool         fine_panning;
  double       screen_scale_x;
  double       screen_scale_y;
}
View;

extern
void prime_view( View *view, Model *model, char *path_to_cursor)
;

extern
void update_edges( View *view);
;

extern
void update_bounds( View *view);
;

extern
void render_view( View *view)
;

extern
void pan_view( View *view, Point direction, Uint32 time_passed)
;

extern
void zoom_view_in( View *view)
;

extern
void zoom_view_out( View *view)
;


#endif

