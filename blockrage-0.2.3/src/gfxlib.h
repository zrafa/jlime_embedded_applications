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

#ifndef _GFXLIB_H
#define _GFXLIB_H


/* maximal length of a formatted string to be drawn on screen */
#define MAXVSTR 128

extern pix_t *vscr;
extern int clip_x0,clip_y0,clip_x1,clip_y1;
extern font_t font[2];
extern int t_align;

#define T_LEFT 0
#define T_CENTER 1

void v_fillscr(pix_t color);
void v_fillbox(int x, int y, int w, int h, pix_t color);
void v_drawbmp(int x0, int y0, pix_t keycolor, int xs, int ys, pix_t *data);
void v_copyarea(pix_t *src, pix_t *dst,
		int ssw, int dsw,
                int x0,int y0,int w,int h,int dx0,int dy0);
void v_drawscrarea(pix_t *src,int x0,int y0,int w,int h);
void virt_cpy(void);
void virt_cpyarea(int x0, int y0, int w, int h);
int strpixlen(char *s, int fnt);
void v_print(int x0, int y0, int fnt, char *s);
void v_printf(int x0, int y0, int fnt, char *fmt, ...);

int font_load(char *name, font_t *fnt);

unsigned char *pal_load(char *name);
int pcx_load(bmp_t *bmp, char *name);

#ifdef DIRECT_COLOR
void pcx_save(int xs, int ys, pix_t *data,
              unsigned char *pal, char *name);
#else
void pcx_save(int xs, int ys, unsigned char *data,
              unsigned char *pal, char *name);

#endif

#define FONT_NORMAL 0
#define FONT_HIGHLIGHTED 1

#endif
