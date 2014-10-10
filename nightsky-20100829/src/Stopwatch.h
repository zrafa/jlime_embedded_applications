/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#ifndef __STOPWATCH_H
#define __STOPWATCH_H


#include <sys/time.h>


typedef struct
{
  struct timeval  when_started;
  struct timeval  when_stopped;
}
Stopwatch;


extern
void start_stopwatch( Stopwatch *sw)
;

extern
void stop_stopwatch( Stopwatch *sw)
;

// Returns the number of nanoseconds between when the stopwatch was started and
// when it was stopped.
extern
long time_on_stopwatch( Stopwatch *sw)
;


#endif
