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

#ifndef _KEYBOARD_H
#define _KEYBOARD_H

int input_init(int (*_k_hnd)(int,int,int));
void input_deinit(void);
int key_get(int *code, int *press);
int key_get_press_char(int *character);
int key_get_press(void);
void key_2_str(int key, char *dst);

#define KSTAT_SIZE SDLK_LAST

extern int keyboard_state[KSTAT_SIZE];

#endif
