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

#ifndef _GLOBAL_H
#define _GLOBAL_H

#include <stdio.h>

/* config file version */
#define VER1 0
#define VER2 2
#define VER3 1

#define DEBUG1(x)
#define DEBUG2(x)

#define DIRECT_COLOR

#define __UC_SOUND

#define SANE_PATH_LEN 8192

#define BF_BLOW 1
#define BF_FALL 2

#define S_NORMAL 0
#define S_CHECKX 1
#define S_BLOW   2
#define S_CHECKF 3
#define S_FALL   4
#define S_CHECKR 5
#define S_RISE   6

#define P_PER_S 6  /* number of pieces per set */

#define MIN_PIECE_TYPES 4
#define MAX_PIECE_TYPES P_PER_S

typedef unsigned char       _U8;
typedef unsigned short int  _U16;
typedef unsigned long int   _U32;

typedef signed short int    _S16;

/* a pixel */
#ifdef DIRECT_COLOR
typedef _U16 pix_t;
#else
typedef _U8 pix_t;
#endif

typedef struct p_list_s {	// p_list_t
  float x,y;
  float vx,vy;
  float fr_age;			// age in seconds
  int frame;
  struct p_list_s *next;
} p_list_t;

typedef struct {
  int number;
  int score;
  char *board,*bflags;
  int piecex, piecey, pieceypix;
  float pieceyfrac;
  int piece_dropping;
  char p_cur[3],p_nxt[3];
  int explode_frames, fall_pix, rise_pix, status;
  float fall_frac, rise_frac;
  int rows2rise;
  int lines[3],chain;
  int loser;
  int gboomy; /* gameoverboom-y */
  float gttb; /* gameovertimetoboom */
  p_list_t *particles;
} player_t;

typedef struct {		// flp_t
  float *data;
} flp_t;

typedef struct {		// bmp_t
  int xs,ys;
  pix_t *data;
  pix_t key_color;
} bmp_t;

typedef struct {		// frame_t
  bmp_t bmp;
  float delay;
} frame_t;

typedef struct {		// piece_t
  int frames;
  flp_t delay;      /* a delay time for each frame (in secs) */
  pix_t *bmp;
  pix_t key_color;
} piece_t;

typedef struct {		// font_t
  bmp_t bmp;
/*  int xs, ys;
  int ofs[256],width[256],lspac[256],rspac[256];
  int h;	* line distance (top-top) - in font bitmap *
  int sh;	* line distance (top-top) - on screen *
  int y0;	* y of first line - in font bitmap *
*/
  
  /* Font bitmap description */
  int gmin,gmax; /* Minimal and maximal glyph number */
  int cxd,cyd;   /* Cell X and Y distance */
  int cx0,cy0;   /* Left top corner of first cell */
  int cw,ch;     /* Width and height of a cell */
  int cells_row; /* Number of cells on a row */
  
  /* Font redering metrics */
  int hspac;     /* Horizontal spacing between characters */
  int vspac;     /* Vertical spacing between lines */
  int lm[256];   /* Left margins of glyphs */
  int rm[256];   /* Right margins of glyphs */
} font_t;

#define TOPSC_NAME_SIZE 40

typedef struct {
  unsigned char name[TOPSC_NAME_SIZE];
  long score;
} top_score_t;

/* miliseconds to sleep when not busy */
#define SLEEP_MS 5

#define TOPTENDELAY 10
#define TOPTENDURATION 10

#define INTRODELAY 10

#define MAX(x,y) (((x)>(y)) ? (x) : (y))
#define MIN(x,y) (((x)<(y)) ? (x) : (y))

void *malloc_verify(size_t size);
void *calloc_verify(size_t nmemb, size_t size);
void *realloc_verify(void *ptr, size_t size);

extern long fload_len;
unsigned char *file_load(char *name);
FILE *file_open(char *name, char *mode);
void cat_with_slash(char *buf, char *file);

unsigned fget_u8(FILE *f);
unsigned fget_u16l(FILE *f);

void fput_u8(FILE *f, unsigned val);
void fput_u16l(FILE *f, unsigned val);

#endif
