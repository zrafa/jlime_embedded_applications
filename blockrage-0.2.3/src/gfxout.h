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

#ifndef _GFXOUT_H
#define _GFXOUT_H

extern int scr_x_size;
extern int scr_y_size;

void gfx_virt_cpy(pix_t *scr);
void gfx_virt_cpyarea(pix_t *scr, int x0, int y0, int w, int h);

int gfx_init();
int gfx_deinit(void);

int gfx_get_fullscreen(void);
int gfx_set_fullscreen(int value);

int gfx_get_doublesize(void);
int gfx_set_doublesize(int value);

void gfx_setpalette(unsigned char *pal, int c0, int n);

#endif
