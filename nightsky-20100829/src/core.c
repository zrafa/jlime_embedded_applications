/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#include <stdlib.h>
#include <math.h> // for isnan
#include <stdarg.h> // for varargs
#include <stdio.h> // for *printf
#include <string.h> // for index, strcmp, memmove

#include "core.h"


// NOTE: field_capacity MUST be at least 1
int split( char *text, char separator, char **field, int field_capacity)
{
  int  fields = 1;
  field[ 0] = text;
  while ( true)
  {
    text = index( text, separator);
    if ( text != NULL)
    {
      *text = '\0';
      ++ text;
      if ( fields < field_capacity)
      {
        field[ fields] = text;
        ++fields;
      }
    }
    else
      break;
  }
  return fields;
}


#ifdef DEBUG
int heap_free()
{
    struct mallinfo  mi;
    mi = mallinfo();
    return mi.uordblks + mi.usmblks;
}
#endif


void grow_array( void *p2array_uncast, int bytes_per_element, int element_count)
{
  void  **p2array = p2array_uncast;
  *p2array = realloc( *p2array, bytes_per_element * ( element_count + 1));
}


void update_double_range( DoubleRange *range, double value)
{
  if ( value < range->min  ||  isnan(range->min))
    range->min = value;
  if ( range->max < value  ||  isnan(range->max))
    range->max = value;
}


void double_range_to_s( DoubleRange *range, char *text, int capacity)
{
  snprintf( text, capacity, "%.2lf-%.2lf", range->min, range->max);
}


void debug( char *message, ...)
{
  va_list  arg_ptr;
  va_start( arg_ptr, message);
  vprintf( message, arg_ptr);
  va_end( arg_ptr);
  printf( "\n");
}


void error( char *message, ...)
{
  va_list  arg_ptr;
  va_start( arg_ptr, message);
  vfprintf( stderr, message, arg_ptr);
  va_end( arg_ptr);
  fprintf( stderr, "\n");
}


char  status[512];
char  *status_cursor;


void rewind_status()
{
  status_cursor = status;
  status[ 0] = '\0';
}


void append_status( char *format, ...)
{
  va_list  args;
  va_start( args, format);
  int  so_far = status_cursor - status;
  int  count = vsnprintf( status_cursor, sizeof(status) - so_far, format, args);
  if ( 0 < count)
    status_cursor += count;
  else
    error("vsnprintf fault");
  va_end( args);
}

