/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#include <SDL_keyboard.h>
#include <pthread.h>
#include <unistd.h>  // for usleep
#include <pwd.h>  // for getuid and getpwuid

#include "core.h"
#include "Stopwatch.h"
#include "Clock.h"
#include "Font.h"
#include "Model.h"
#include "View.h"

/*

PLAN
 + check it looks like the night sky
 + objects within this solar system
 + show progress reading stars
 + search for named object
 + refactor: each_line_from_file()  auto-strip terminators
 + optional filter to limit to only the brightest objects
 + change format of stars.tsv and constellations.tsv to YAML ( future proofs
   against format changes) - or maybe not depending on how slow it is to start
 + make view panning less jarring ( using acceleration and deceleration)

DONE
 / change the help text to refer to vol up and down for the NanoNote
 / release once this item is at the top of the list
 X constellations: might need binary search of HIP ID to Object*
 / file stellarium bug: out-of-control/constellation_names.eng.fab Umi should be UMi
 / show the name of the constellation closest to the cursor
 / the time no longer shows 0:45PM
 / can't put the cursor on objects if the view would be out of bounds
 / options.yml should be read from the user's home directory
 X the sky should be dark blue, not black.  makes font look shoddy
 X find a way to create a nice cursor without requiring SDL_image.  Font requires SDL_image anyway
 / F1 should show the keys
 / key to turn constellations on and off
 / there should be a void_constellations to release memory
 / void_catalog should free ALL memory allocated by read_star_catalog
 / code tidy up
 / constellation lines partly or completely off screen are now handled properly
 / common names for stars
 / show the name of the object within the cursor
 / latitude is now loaded properly
 / draw a circle around the star closest to the middle of the screen
 / numerically lower magnitudes are now considered brightest instead of the opposite way around
 / show time on HUD
 / wait for update thread to finish first run before rendering maybe
 / read location from options.yml
 / when zoom out, should check view elevation is within range!
 / separate thread to update place_in_sky of objects

*/


char         *path_to_data;
SDL_Surface  *screen;
Font         *font;
Model        model;
View         view;
bool         should_show_keys = false;

pthread_t        update_thread;
bool volatile    update_should_run;
Uint16 volatile  update_took = 0;


void read_options()
{
  char  path_to_file[ 256];
  snprintf( path_to_file, sizeof(path_to_file), "%s/.nightsky.yml", getpwuid( getuid())->pw_dir);

  FILE  *f = fopen( path_to_file, "r");
  if ( f != NULL)
  {
    char  buf[ 240];

    while ( true)
    {
      char  *line = fgets( buf, sizeof(buf), f);

      // If the end of the file has been reached
      if ( NULL == line)
        break;

      // Remove the line terminator
      char  *terminator = index( line, '\n');
      if ( terminator != NULL)
        *terminator = '\0';

      if ( STRBEGINS( line, "  latitude:")  ||  STRBEGINS( line, "  longitude:"))
      {
        // Skip over the colon and any spaces after the colon
        char  *value = index( line, ':');
        ++ value;
        while ( ' ' == *value)
          ++ value;
        double  *part = STRBEGINS( line, "  la") ? &view.from_location.latitude : &view.from_location.longitude;
        sscanf( value, "%lf", part);
      }
      else if ( STRBEGINS( line, "path_to_data: "))
      {
        // Skip over the colon and any spaces after the colon
        char  *value = index( line, ':');
        ++ value;
        while ( ' ' == *value)
          ++ value;
        path_to_data = strdup( value);
      }
    }
  }
  else {
    error("Could not read %s", path_to_file);
  }
}


// Floating point operations are too slow to use every frame on some platforms.
// The "update_thread" works continuously in the background re-calculating the
// place in the sky of each object and scaling the floating-point
// Azimuth&Elevation positions to an unsigned 32-bit integer range.
//
// Real ranges:
//  + Right Ascension:   0.0 to  23.9r hours
//  + Declination:     -90.0 to  90.0  degrees
//  + Azimuth:           0.0 to 359.9r degrees
//  + Elevation:       -90.0 to  90.0  degrees
//
// An Azimuth of 0.0 degrees is scaled to "0" while 359.9r degrees is scaled to
// 2^32-1.
//
void *update_main( void *arg)
{
  // When the software has only just begun, the position of each star in the
  // sky has not yet been calculated so this thread hurries through the first
  // update but chills out for subsequent updates to reduce CPU usage.
  bool  first_update = true;

  while ( update_should_run)
  {
    model.when_updated = time( NULL);
    double  star_time = sidereal_time( model.when_updated);

    // Go through each object in the catalog
    Stopwatch  sw;
    start_stopwatch( &sw);
    int  i;
    for ( i = model.catalog.objects - 1;  0 <= i;  -- i)
    {
      Object  *object = &model.catalog.object[ i];
      object_place_in_sky( object, star_time, &view.from_location);
      object->x = object->place_in_sky.azimuth * degrees_to_32;
      object->y = object->place_in_sky.elevation * degrees_to_32;
      object->place_is_valid = true;

      // Stop this thread without finishing the update if so requested
      if ( ! update_should_run)
        break;

      if ( first_update)
        continue;

      // Give the UI ( main) thread priority
      sched_yield();
      usleep( 250);
    }
    stop_stopwatch( &sw);
    update_took = time_on_stopwatch( &sw) / 1000;
    //debug("updated position of all stars");
    first_update = false;
  }
  return NULL;
}


#define format( path, file_name)  snprintf( path, sizeof(path), "%s/%s", path_to_data, file_name)


int main( int argc, char **argv)
{
  char  path_to_file[ 128];

  read_options();

  format( path_to_file, "stars.tsv");
  read_star_catalog( path_to_file, &model.catalog);

  format( path_to_file, "constellations.tsv");
  read_constellations( path_to_file, &model);

  debug("%i objects. dimmest:%.02lf brightest:%.02lf. %i constellations",
        model.catalog.objects, model.catalog.dimmest, model.catalog.brightest,
        model.constellations);

  if ( SDL_Init( SDL_INIT_VIDEO) != 0) {
    printf("Unable to initialize SDL: %s\n", SDL_GetError());
    return 1;
  }

  atexit( SDL_Quit);

  // Do not show the SDL mouse cursor
  SDL_ShowCursor( false);

  // Get a surface in the same pixel format as the real display
  int  default_bits_per_pixel = 0;
  screen = SDL_SetVideoMode( 320, 240, default_bits_per_pixel, SDL_DOUBLEBUF+SDL_RESIZABLE);
  if ( NULL == screen) {
    printf("Unable to set video mode: %s\n", SDL_GetError());
    return 1;
  }

  debug("Display has %i bits per pixel", screen->format->BitsPerPixel);

  format( path_to_file, "font.png");
  font = load_font( path_to_file);

  format( path_to_file, "cursor.png");
  prime_view( &view, &model, path_to_file);

  free( path_to_data);
  path_to_data = NULL;

  // The view must be primed -before- the update thread is started
  update_should_run = true;
  pthread_create( &update_thread, NULL, update_main, NULL);
  //pthread_setschedprio( &update_thread, prio);

  Clock  clock;
  target_frame_rate( &clock, 20);

  bool  should_run = true;

  while( should_run)
  {
    Uint32  time_passed = tick( &clock);

    rewind_status();

    SDL_Event  event;

    while( SDL_PollEvent( &event))
    {
      switch( event.type)
      {
        case SDL_KEYUP:
          switch( event.key.keysym.sym)
          {
          case SDLK_ESCAPE: should_run = false; break;
          case SDLK_SPACE: view.fine_panning ^= true; update_bounds(&view); break;
          case 'c': view.show_constellations ^= true; break;
          case SDLK_TAB: view.show_cursor ^= true; break;
          case SDLK_F1: should_show_keys ^= true; break;
          case SDLK_F11: zoom_view_in( &view); break;
          case SDLK_F12: zoom_view_out( &view); break;
          default:
            ;
          }
          break;
        case SDL_VIDEORESIZE:
          screen = SDL_SetVideoMode( event.resize.w, event.resize.h, default_bits_per_pixel, SDL_DOUBLEBUF+SDL_RESIZABLE);
          update_bounds( &view);
          update_edges( &view);
          break;
        case SDL_QUIT:
          should_run = false;
          break;
      }
    }

    Uint8  *held_down = SDL_GetKeyState( NULL);
    if ( held_down[ SDLK_UP] )    pan_view( &view, view.pan_up,    time_passed);
    if ( held_down[ SDLK_DOWN] )  pan_view( &view, view.pan_down,  time_passed);
    if ( held_down[ SDLK_LEFT] )  pan_view( &view, view.pan_left,  time_passed);
    if ( held_down[ SDLK_RIGHT] ) pan_view( &view, view.pan_right, time_passed);

    // Render the view and time how long it takes
    Stopwatch  sw;
    start_stopwatch( &sw);
    render_view( &view);
    stop_stopwatch( &sw);

    if ( should_show_keys)
    {
      char *keys = "[F1]    help\n"
                   #ifdef NANONOTE
                   "[vol \200] zoom in\n"
                   "[vol \201] zoom out\n"
                   #else
                   "[F11]   zoom in\n"
                   "[F12]   zoom out\n"
                   #endif
                   "arrows  pan view\n"
                   "[Space] toggle fine panning\n"
                   "[c]     toggle constellations\n"
                   "[tab]   toggle cursor\n"
                   "[Esc]   quit\n"
                   ;
      Vector  at = { x: ( screen->w - font->advance*28) / 2,
                     y: ( screen->h - font->height*8) / 2
                   };
      render_text( font, screen, &at, keys);
    }

    append_status("%li ms, %i ms, %i ms", time_on_stopwatch(&sw) / 1000, time_passed, update_took);
    Vector  place = { x:8, y:8};
    render_text( font, screen, &place, "%s", status);

    SDL_Flip( screen);
  }

  // The Update thread must finish -before- the Star Catalog is voided
  debug("waiting for update thread to finish");
  update_should_run = false;
  pthread_join( update_thread, NULL);

  free_font( font);

  SDL_VideoQuit();
  SDL_Quit();

  void_constellations( &model);
  void_catalog( &model.catalog);

#ifdef DEBUG
  printf("heap: %i bytes\n", heap_free());
#endif

  return 0;
}

