/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#ifndef __CORE_H
#define __CORE_H


typedef  char  bool;
#define  false  0
#define  true   1


// This is a multi-purpose structure for referrring to individual pixels on the
// screen.  The location of each pixel is a "vector" from the origin ( 0, 0) -
// the pixel in the top-left corner of the screen.  The same structure is also
// used for actual vectors.
typedef struct
{
  int  x;
  int  y;
}
Vector;


typedef struct
{
  Vector  begins_at;
  Vector  ends_at;
}
Line;


#ifndef NAN
#define  NAN  (0/0.0)
#endif


#define STRBEGINS( text, subtext)  ( 0 == strncmp( text, subtext, strlen(subtext)) )


extern
int split( char *text, char separator, char **field, int field_capacity)
;


extern
int heap_free()
;


#define  LENGTH_OF( array)  ( sizeof(array) / sizeof(array[0]))

// Grows an array stored on the heap
// An array is always a pointer but p2array_uncast is a pointer to the address
// at which the array pointer is kept.  It's only void* to obviate a cast to
// void**
extern
void grow_array( void *p2array_uncast, int bytes_per_element, int element_count)
;


// ----------------------------------------------------------------- DoubleRange

typedef struct
{
  double  min;
  double  max;
}
DoubleRange;

extern
void update_double_range( DoubleRange *range, double value)
;

extern
void double_range_to_s( DoubleRange *range, char *text, int capacity)
;

#define  DR2S( range, var)  char var[ 240]; double_range_to_s( range, var, sizeof(var));


// --------------------------------------------------------------------- logging

extern
void debug( char *message, ...)
;


extern
void error( char *message, ...)
;


// ---------------------------------------------------------------------- status
// "status" is a way for many parts of unrelated code to jointly update a block
// of text which can then be rendered to the view each frame.

extern
char  status[];

extern
void rewind_status()
;

extern
void append_status( char *format, ...)
;


#endif

