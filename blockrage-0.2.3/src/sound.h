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

#ifndef _SOUND_H
#define _SOUND_H

#define FX_BLOW 0
#define FX_HIT  1
#define FX_RISE 2

#define MAX_VOICES 4

typedef struct {
  void *sample; /* points at the current position in the current sample */
  long left;    /* bytes left to play (NOT samples) */
} voice_info_t;

void sound_fx(int stype);
int sound_init(void);
void sound_done(void);
void sound_cfg_defaults(void);
void sound_cfg_8bit(void);

#endif
