/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#include <assert.h>
#include <math.h>
#include <time.h>

#include "core.h"
#include "Model.h"


double  degrees_to_32 = 4294967296.0 / 360;


#define  FULL_CIRCLE  ( 2.0 * M_PI)
double  to_radians = FULL_CIRCLE / 360.0;
double  to_degrees = 360.0 / FULL_CIRCLE;


void normalise_azimuth( double *azimuth)
{
  while ( *azimuth < 0.0)
    *azimuth += 360.0;
  while ( 360.0 < *azimuth)
    *azimuth -= 360.0;
}


void precompute_location( Location *location)
{
  location->sine_of_latitude = sin( location->latitude * to_radians);
  location->cosine_of_latitude = cos( location->latitude * to_radians);
}


void precompute_object( Object* object)
{
  object->sine_of_declination = sin( object->declination * to_radians);
  object->cosine_of_declination = cos( object->declination * to_radians);
}


double sidereal_time( time_t time)
{
  struct tm  t;
  gmtime_r( &time, &t);
  // parts copied from http://www.atnf.csiro.au/people/Enno.Middelberg/python/gd2jd.py
  int  year = 1900 + t.tm_year;
  int  month = 1 + t.tm_mon;
  double  proportion_of_day = (double) ( 3600 * t.tm_hour + 60 * t.tm_min + t.tm_sec) / ( 24 * 60 * 60);
  double  sig = 0.0 < ( 100*year + month - 190002.5) ? 1.0 : -1.0;

  double  julian_date = 367*year - (int)( 7*(year+(int)((month+9)/12.0+0.5))/4.0+0.5) + (int)(275*month/9.0 + 0.5) + t.tm_mday + 1721013.5 + proportion_of_day - 0.5*sig + 0.5;
  double  epoch2000 = 2451544.5; // julian date of 1st Jan 2000
  double  julian_days_since_2000 = julian_date - epoch2000;
  return 99.967794687 + 360.98564736628603 * julian_days_since_2000;
}


void object_place_in_sky( Object *object, double sidereal_time, Location *location)
{
  double  hour_angle = remainder( sidereal_time - location->longitude - object->right_ascension * 15.0, 360.0); // 15 degs/hr
  double  h = hour_angle * to_radians;
  double  cos_dec = object->cosine_of_declination;
  double  cos_lat = location->cosine_of_latitude;
  double  sin_dec = object->sine_of_declination;
  double  sin_lat = location->sine_of_latitude;
  double  cos_h = cos( h);
  object->place_in_sky.azimuth = atan2(-sin(h)*cos_dec, cos_lat*sin_dec - sin_lat*cos_dec*cos_h );
  object->place_in_sky.azimuth *= to_degrees;
  normalise_azimuth( &object->place_in_sky.azimuth);
  object->place_in_sky.elevation = asin( sin_lat*sin_dec + cos_lat*cos_dec*cos_h) * to_degrees;
}


double parse_right_ascension( char *representation)
{
  unsigned int  hours;
  unsigned int  minutes;
  double        seconds;
  int  items = sscanf( representation, "%u %u %lf", &hours, &minutes, &seconds);
  if ( 3 == items)
    return (double) hours + (double) minutes / 60.0 + (double) seconds / 3600.0;
  else
    return NAN;
}


double parse_declination( char *representation)
{
  double  degrees;
  double  minutes;
  double  seconds;
  int  items = sscanf( representation, "%lf %lf %lf", &degrees, &minutes, &seconds);
  if ( 3 == items)
    if ( 0 < degrees)
      return degrees + minutes/60 + seconds/3600;
    else
      return degrees - minutes/60 - seconds/3600;
  else
    return NAN;
}


typedef enum
{
  EXPECTING_HEADER,
  EXPECTING_DIVIDER,
  EXPECTING_DATA,
}
ParserState;


void read_star_catalog( char *path_to_file, Catalog *catalog)
{
  catalog->object    = NULL;
  catalog->objects   = 0;
  catalog->brightest = 19.0;
  catalog->dimmest   = -9.0;
  DoubleRange  right_ascension_range = { NAN, NAN};
  DoubleRange  declination_range = { NAN, NAN};

  FILE  *f = fopen( path_to_file, "r");
  if ( f != NULL)
  {
    ParserState  state = EXPECTING_HEADER;
    char         buf[ 240];

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

      // Skip comments and blank lines
      if ( '#' == line[0]  ||  0 == strlen( line))
        continue;
      else if ( EXPECTING_HEADER == state)
      {
        assert( 0 == strcmp("HIP\tRA2000\tDE2000\tVmag\tName", line));
        state = EXPECTING_DATA;
      }
      else if ( EXPECTING_DATA == state)
      {
        char  *value[ 9];
        int  values = split( line, '\t', value, LENGTH_OF(value));
        if ( 5 == values)
        {
          // Extend the array to accomodate the new object
          ++ catalog->objects;
          grow_array( &catalog->object, sizeof(Object), catalog->objects);
          Object  *ob = &catalog->object[ catalog->objects - 1];

          // Initialise the new object
          ob->name = 0 == strlen(value[4]) ? "" : strdup(value[4]);
          bool  err = false;
          int  items = sscanf( value[0], "%i", &ob->id);
          err ^= !items;
          items = sscanf( value[1], "%lf", &ob->right_ascension);
          err ^= !items;
          items = sscanf( value[2], "%lf", &ob->declination);
          err ^= !items;
          items = sscanf( value[3], "%lf", &ob->magnitude);
          err ^= !items;

          // If data is missing then remove the object from the catalog
          if ( err)
          {
            -- catalog->objects;
            error("Bad: %s", line);
            continue;
          }

          // Keep track of the dimmest and brightest objects in the catalog
          if ( catalog->dimmest < ob->magnitude)
            catalog->dimmest = ob->magnitude;
          if ( ob->magnitude < catalog->brightest)
            catalog->brightest = ob->magnitude;
          update_double_range( &right_ascension_range, ob->right_ascension);
          update_double_range( &declination_range, ob->declination);

          precompute_object( ob);
          ob->in_constellation_id = NO_CONSTELLATION;
          ob->place_is_valid = false;
        }
        else {
          error("Bad: %s", line);
        }
      }
    }

    fclose( f);

    // Convert the brightness of each object to the intensity of the pixel used
    // to represent the object
    double  light_range = catalog->brightest - catalog->dimmest;
    int  i;
    for ( i = catalog->objects - 1;  0 <= i;  -- i)
    {
      Object  *object = &catalog->object[ i];
      object->brightness = 255 * ( object->magnitude - catalog->dimmest) / light_range;
    }

    DR2S( &right_ascension_range, ra_to_s);
    DR2S( &declination_range, de_to_s);
    debug("ra:%s de:%s", ra_to_s, de_to_s);
  }
  else {
    error("Could not read %s.", path_to_file);
  }
}


void void_catalog( Catalog *catalog)
{
  int  i;
  for ( i = 0;  i < catalog->objects;  ++ i)
  {
    char  *name = catalog->object[ i].name;
    if ( 0 < strlen(name))
      free( name);
  }
  free( catalog->object);
  catalog->object = NULL;
  catalog->objects = 0;
}


Object *object_with_id( Catalog *catalog, int id)
{
  int  i;
  for ( i = 0;  i < catalog->objects;  ++ i)
  {
    Object  *ob = &catalog->object[ i];
    if ( ob->id == id)
      return ob;
  }
  return NULL;
}


void read_constellations( char *path_to_file, Model *model)
{
  //DoubleRange  length_range = { NAN, NAN};
  FILE  *f = fopen( path_to_file, "r");
  if ( f != NULL)
  {
    char  buf[ 800];

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

      char  *value[ 99];
      int  values = split( line, '\t', value, LENGTH_OF(value));

      // Extend the array to accomodate the new constellation
      ++ model->constellations;
      grow_array( &model->constellation, sizeof(Constellation), model->constellations);
      int  con_id = model->constellations - 1;
      Constellation  *con = &model->constellation[ con_id];
      con->name = strdup( value[0]);
      con->lines = values - 1;
      con->line = malloc( sizeof(ConstellationLine) * con->lines);
      int  i;
      for ( i = 0;  i < con->lines;  ++ i)
      {
        ConstellationLine  *line = &con->line[ i];
        int  from_id, to_id;
        sscanf( value[1+i], "%i-%i", &from_id, &to_id);
        line->from_object = object_with_id( &model->catalog, from_id);
        line->to_object = object_with_id( &model->catalog, to_id);
        if ( NULL == line->from_object  ||  NULL == line->to_object)
        {
          -- model->constellations;
          error("Unknown: %i or %i", from_id, to_id);
          continue;
        }
        line->from_object->in_constellation_id = con_id;
        line->to_object->in_constellation_id = con_id;
        /*
        double  ra_span = fabs( line->from_object->right_ascension - line->to_object->right_ascension) * 15;
        if ( 180 < ra_span)
        {
          ra_span = 360 - ra_span;
        }
        double  de_span = fabs( line->from_object->declination - line->to_object->declination);
        double  length = sqrt( ra_span*ra_span + de_span*de_span);
        update_double_range( &length_range, length);
        */
      }
    }
    fclose( f);
    //DR2S( &length_range, lr_to_s);
    //debug("line length range: %s", lr_to_s);
  }
  else {
    error("Could not read %s.", path_to_file);
  }
}


void void_constellations( Model *model)
{
  int  i;
  for ( i = 0;  i < model->constellations;  ++ i)
  {
    Constellation  *con = &model->constellation[ i];
    free( con->name);
    free( con->line);
  }
  free( model->constellation);
  model->constellation = NULL;
  model->constellations = 0;
}

