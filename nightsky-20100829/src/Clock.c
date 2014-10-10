/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#include "Clock.h"


void target_frame_rate( Clock *clock, int target_frame_rate)
{
  // 1000 milliseconds each second
  clock->time_between_frames = 1000 / target_frame_rate;
  clock->when_last_ticked = SDL_GetTicks();
}


Uint32 tick( Clock *clock)
{
  Uint32  now = SDL_GetTicks();

  // Work out how much time has passed since the last invocation of this method
  Uint32  time_passed = now - clock->when_last_ticked;

  // If the frame that just finished took less than the target period to
  // complete..
  if ( time_passed < clock->time_between_frames)
  {
    SDL_Delay( clock->time_between_frames - time_passed);
    // Assuming SDL_Delay is accurate then it will wake up for the next frame
    // at this time:
    clock->when_last_ticked += clock->time_between_frames;
    return clock->time_between_frames;
  }
  else {  // The system is thrashed and is running slower than the target
    clock->when_last_ticked = now;
    return time_passed;
  }
}

