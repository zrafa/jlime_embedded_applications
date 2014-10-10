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

#ifndef _MAIN_H
#define _MAIN_H

extern player_t player[2];
extern int players;
extern int piecetypes;
extern int startinglevel;

extern int box_x_size,box_y_size;

extern int endgame;
extern int gameover;
extern int pausemenu;

extern unsigned char *mypal;
extern bmp_t bmp_menu,bmp_pmenu,bmp_intro;

extern unsigned char *bground;

extern bmp_t bmp_game[2];
extern float framerate;
extern int board_y_pix_size,board_x_pix_size;
extern int key_left[2],key_right[2],key_drop[2],key_shift_up[2],key_shift_down[2];

extern int bgnumframes;
extern int dbackground; 
extern int showintro;

extern char dataset[100];

extern char *datadir;
extern char *topten_file;
extern int immedstart;
extern int quit;

extern int diffx,diffy;
extern int ts_x0,ts_x1;   
extern int no_of_sets;
extern int setn;

extern int dispframenum;

void screen_setpal(void);

long randint(long base,long range);

void board_draw(player_t *p, int hidepieces, int vcpy);
void game_statistics_draw(void);

void box_draw(int x0, int y0, int type);
void pieces_anim_update(void);

void pieces_checkfnum(void);
void game(void);

#endif
