/*
 * Copyright (C) 2010 Neil Stockbridge
 * LICENSE: GPL
 */

#include <stdarg.h>
#include <SDL.h>
#include <SDL_image.h>

#include "Font.h"


Font *load_font( char *path_to_glyph_sheet)
{
  Font  *font = malloc( sizeof(Font));
  font->glyph_sheet = IMG_Load( path_to_glyph_sheet);
  font->advance = font->glyph_sheet->w / 32;  // 32 glyphs per row
  font->height  = font->glyph_sheet->h / 8; // 8 rows
  return font;
}


void free_font( Font *font)
{
  SDL_FreeSurface( font->glyph_sheet);
  free( font);
}


void render_text( Font *font, SDL_Surface *to_surf, Vector *place, char *format, ...)
{
  va_list  args;
  va_start( args, format);
  char  text[ 800];
  vsnprintf( text, sizeof(text), format, args);
  va_end( args);
  // The "& ~1" ensures that text is only rendered from evenly numbered rows
  // and columns, which is required because the un-fuzzy font uses different
  // colours depending on the odd and even rows
  SDL_Rect  cursor = { place->x & ~1, place->y & ~1, font->advance, font->height};

  // Go through each character in the text..
  int  i;
  for ( i = 0;  i < strlen(text);  ++ i)
  {
    unsigned char  code_point = text[ i];
    if ('\n' == code_point)
    {
      cursor.x = place->x;
      cursor.y += font->height;
    }
    else {
      // There are 32 glyphs across a sheet
      Uint8  glyph_sheet_row = ( code_point) >> 5;
      Uint8  glyph_sheet_column = ( code_point) & 0x1f;
      SDL_Rect  glyph_rect = { font->advance * glyph_sheet_column,
                               font->height * glyph_sheet_row,
                               font->advance,
                               font->height};
      SDL_BlitSurface( font->glyph_sheet, &glyph_rect, to_surf, &cursor);
      cursor.x += font->advance;
    }
  }
}

