/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#ifndef __MODEL_H
#define __MODEL_H


#include <SDL.h>
#include <time.h>
#include "core.h"


// ----------------------------------------------------------------------- types

typedef struct
{
  double  latitude;
  double  longitude;
  double  sine_of_latitude;
  double  cosine_of_latitude;
}
Location;


typedef struct
{
  double  azimuth;
  double  elevation;
}
Point;


typedef struct
{
  int     id;  // Hipparcos catalogue number
  char    *name;
  double  right_ascension;
  double  declination;
  double  magnitude;
  Point   place_in_sky;
  int     brightness;  // 0x00..0xff relative to other stars. For faster rendering
  double  sine_of_declination;
  double  cosine_of_declination;
  Uint32  x; // 360.0 of azimuth mapped to 32-bit integer space
  int     y;
  bool    place_is_valid;  // Has its location been calculated yet or not?
  Uint8   in_constellation_id;
}
Object;


typedef struct
{
  Object  *object;
  int     objects;
  double  brightest;
  double  dimmest;
}
Catalog;


typedef struct
{
  Object  *from_object;
  Object  *to_object;
}
ConstellationLine;


typedef struct
{
  char               *name;
  ConstellationLine  *line;
  int                lines;
}
Constellation;


typedef struct
{
  Catalog        catalog;
  int            constellations;
  Constellation  *constellation;
  time_t         when_updated;
}
Model;


// ------------------------------------------------------------------------ data

// This is the scale factor to convert from degrees ( 0.0 to 359.9r) to a 32-bit
// integer scale ( 0 to 2^32-1).
double extern  degrees_to_32;

#define NO_CONSTELLATION  0xff


// --------------------------------------------------------------------- methods

extern
void normalise_azimuth( double *azimuth)
;

extern
void precompute_location( Location *location)
;

extern
double sidereal_time( time_t time)
;

// Calculates the point in the sky of this object as seen from the given
// location and time.
// Azimuth will be between 0.0 and 359.9r and Elevation will be between -90.0
// and 90.0
extern
void object_place_in_sky( Object *object, double sidereal_time, Location *location)
;

extern
void read_star_catalog( char *path_to_file, Catalog *catalog)
;

extern
void void_catalog( Catalog *catalog)
;

extern
void read_constellations( char *path_to_file, Model *model)
;

extern
void void_constellations( Model *model)
;


#endif

