/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#ifndef __CLOCK_H
#define __CLOCK_H


#include <SDL.h>


typedef struct
{
  Uint32  time_between_frames;
  Uint32  when_last_ticked;
}
Clock;


extern
void target_frame_rate( Clock *clock, int target_frame_rate)
;

// Sleeps if necessary to achieve the target frame rate of the given clock.
// Returns the numbers of milliseconds since the last tick
extern
Uint32 tick( Clock *clock)
;


#endif

