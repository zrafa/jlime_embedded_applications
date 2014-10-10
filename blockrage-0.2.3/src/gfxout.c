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
  This module interfaces SDL video.
*/


#include <stdio.h>
#include <stdlib.h>
#include <SDL.h>
#include <string.h>

#include "global.h"
#include "gfxout.h"

static const char *wnd_caption = "Block Rage";

static SDL_Surface *screen = NULL;
static int full_screen = 0;
SDL_Color colors[256];
int scr_x_size, scr_y_size;
int scr_bytes_pp;

static int double_size=1;

void screen_lock(void) {
  if( SDL_MUSTLOCK(screen) ) {
    if( SDL_LockSurface(screen)<0) {
      fprintf(stderr,"Can't lock screen: %s\n", SDL_GetError());
    }
  }
}

void screen_unlock(void) {
  if( SDL_MUSTLOCK(screen) ) {
    SDL_UnlockSurface(screen);
  }
}

void gfx_virt_cpy(pix_t *scr) {
  pix_t *dst,*src;
  int x,y;
  
  screen_lock();
  src = (pix_t *)scr;
  dst = (pix_t *)(void *)screen->pixels;
  
  if(double_size) {
    for(y=0;y<scr_y_size;y++) {
      for(x=0;x<scr_x_size;x++)
        dst[x*2]=dst[x*2+1]=src[x];
	
      dst+=screen->pitch/scr_bytes_pp;
      
      for(x=0;x<scr_x_size;x++)
        dst[x*2]=dst[x*2+1]=src[x];
      src+=scr_x_size;
      dst+=screen->pitch/scr_bytes_pp;
    }
  } else {
    for(y=0;y<scr_y_size;y++) {
      memcpy(dst,src,scr_x_size*scr_bytes_pp);
      src+=scr_x_size;
      dst+=screen->pitch/scr_bytes_pp;
    }
  }
  screen_unlock();
  SDL_UpdateRect(screen,0,0,screen->w,screen->h);
}

void gfx_virt_cpyarea(pix_t *scr, int x0, int y0, int w, int h) {
  pix_t *src;
  int x,y;
  pix_t *dst;
  
  screen_lock();
  
  src = (pix_t *)(void *)scr + y0*scr_x_size + x0;
  
  if(double_size) {
    dst = (pix_t *)(void *)screen->pixels + 2*y0*(screen->pitch/scr_bytes_pp)+2*x0;
    for(y=0;y<h;y++) {
      for(x=0;x<w;x++) {
        dst[x*2]=dst[x*2+1]=src[x];
      }
      dst+=screen->pitch/scr_bytes_pp;
      
      for(x=0;x<w;x++) {
        dst[x*2]=dst[x*2+1]=src[x];
      }
      src+=scr_x_size;
      dst+=screen->pitch/scr_bytes_pp;
    }
    SDL_UpdateRect(screen,2*x0,2*y0,2*w,2*h);
  } else {
    dst = (pix_t *)(void *)screen->pixels + y0*(screen->pitch/scr_bytes_pp)+x0;
    for(y=0;y<h;y++) {
      memcpy(dst,src,w*scr_bytes_pp);
      src += scr_x_size;
      dst += screen->pitch/scr_bytes_pp;
    }
    SDL_UpdateRect(screen,x0,y0,w,h);
  }
}

static int gfx_mode_init(void) {
  int f = double_size ? 2 : 1;
  int bits;

#ifdef DIRECT_COLOR  
  bits=16;
  scr_bytes_pp=2;
#else
  bits=8;
  scr_bytes_pp=1;
#endif

  SDL_WM_SetCaption(wnd_caption,wnd_caption);

  screen = SDL_SetVideoMode(scr_x_size*f,scr_y_size*f,
    bits,SDL_SWSURFACE | (full_screen ? SDL_FULLSCREEN : 0));
  
  if(screen == NULL) {
    fprintf(stderr,"blockrage: could not setup mode %dx%dx%dbit: %s\n",
      scr_x_size*f,scr_y_size*f,bits,SDL_GetError());
    return 0;
  }
  
  return 1;
}

int gfx_init(void) {

  if(SDL_Init(SDL_INIT_VIDEO)<0) {
    fprintf(stderr,"error initialising SDL: %s\n", SDL_GetError());
    return 0;
  }
  
  atexit(SDL_Quit);

  return gfx_mode_init();
}

int gfx_deinit(void) {
  SDL_FreeSurface(screen); screen=NULL;
  return 1;
}	

int gfx_get_fullscreen(void) {
  return full_screen;
}

static int gfx_reinit(void) {
  int r;

  SDL_FreeSurface(screen); screen = NULL;
  SDL_QuitSubSystem(SDL_INIT_VIDEO);
  SDL_InitSubSystem(SDL_INIT_VIDEO);
  r = gfx_mode_init();
  if(r) {
    SDL_SetPalette(screen, SDL_PHYSPAL, colors, 0, 256);
    return 1;
  }
  return 0;
}

int gfx_set_fullscreen(int value) {
  full_screen = value;
  if(screen) return gfx_reinit();
  else return 1;
}

int gfx_get_doublesize(void) {
  return double_size;
}

int gfx_set_doublesize(int value) {
  double_size = value;
  if(screen) return gfx_reinit();
  else return 1;
}


void gfx_setpalette(unsigned char *pal, int c0, int n) {
  int i;
  
  if(n>256) n=256;
  
  for(i=0;i<n;i++) {
    colors[i].r=pal[3*i]<<2;
    colors[i].g=pal[3*i+1]<<2;
    colors[i].b=pal[3*i+2]<<2;
  }
  
  SDL_SetPalette(screen, SDL_PHYSPAL, colors, c0, n);
}

