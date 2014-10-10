/*
  Block Rage - the arcade game
  Copyright (C) 1999-2005 Jiri Svoboda

  This file is part of Block Rage.

  Block Rage is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.

  Block Rage is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with Block Rage; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

  Jiri Svoboda
  jirik.svoboda@seznam.cz
*/

/*
  This module provides timing.
  
  Since SDL does not provide a time source suitable for initialising
  a random number generator (but only time relative to library initialisation),
  this has to be OS-specific.
  
  Currently UNIX-like OSes and Windows are supported.
*/

#include <stdlib.h>
#include "timer.h"

int turn_interval_usec;

#ifdef _WIN32

/* Windows */

#include <windows.h>
#include <mmsystem.h>

static unsigned long lastturnt,ltusec;

void time_init(void) {
  lastturnt = timeGetTime();
  ltusec = 0;
}

/* FIXME: we could have better entropy than this! */
void random_init(void) {
  srand(timeGetTime());
}

int is_next_turn(void) {
  long usec;
  unsigned long t;
  
  t = timeGetTime();
  usec = (t-lastturnt)*1000-ltusec;
  
  if(t<lastturnt || usec>=turn_interval_usec) {
    ltusec += turn_interval_usec % 1000;
    lastturnt += turn_interval_usec / 1000;
    if(ltusec>=1000) {
      ltusec -= 1000;
      lastturnt++;
    }
    return (int)(usec/turn_interval_usec);
  } 
  else 
  {
    return 0;
  }    
}


#else

/* UNIX-compatible OS */

#include <sys/time.h>

static struct timeval lastturntv;
static struct timezone tz;

void time_init(void) {
  gettimeofday(&lastturntv,&tz);
}

// should only be called after time_init, otherwise has no effect
void random_init(void) {
  srand(lastturntv.tv_sec ^ lastturntv.tv_usec);
}

int is_next_turn(void) {
  struct timeval tv;
  long sec,usec;
  
  gettimeofday(&tv,&tz);
  usec=tv.tv_usec-lastturntv.tv_usec;
  sec=tv.tv_sec-lastturntv.tv_sec;
  if(usec<0) {
    sec--;
    usec+=1000000L;
  }
  if(usec>=turn_interval_usec) {
    lastturntv.tv_usec+=turn_interval_usec;
    if(lastturntv.tv_usec>1000000L) {
      lastturntv.tv_usec-=1000000L;
      lastturntv.tv_sec++;
    }
    return (int)(usec/turn_interval_usec);
  } 
  else 
  {
    return 0;
  }    
}


#endif

