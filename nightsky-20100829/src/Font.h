/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#ifndef __FONT_H
#define __FONT_H


#include <SDL.h>
#include "core.h" // for Vector


typedef struct
{
  SDL_Surface  *glyph_sheet;
  Uint8        height;
  Uint8        advance;
}
Font;


extern
Font *load_font( char *path_to_glyph_sheet)
;


extern
void render_text( Font *font, SDL_Surface *to_surf, Vector *top_left, char *format, ...)
;


extern
void free_font( Font *font)
;


#endif

