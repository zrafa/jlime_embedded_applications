/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#include "Stopwatch.h"

#include <stdio.h>


inline long usecs_between( struct timeval *instant1, struct timeval *instant2)
{
  return (instant2->tv_usec - instant1->tv_usec) +
         1000000L * (instant2->tv_sec - instant1->tv_sec);
}


void start_stopwatch( Stopwatch *sw)
{
  gettimeofday( &sw->when_started, NULL);
}


void stop_stopwatch( Stopwatch *sw)
{
  gettimeofday( &sw->when_stopped, NULL);
}


long time_on_stopwatch( Stopwatch *sw)
{
  return usecs_between( &sw->when_started, &sw->when_stopped);
}

