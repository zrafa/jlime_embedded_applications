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

#ifndef _MENUS_H
#define _MENUS_H

#define NO_TOPSCORES 5

extern top_score_t topscore[NO_TOPSCORES];

void topten_draw(int cursoratline);
int topten_update(int newscore);
void topten_load(void);
void menu_draw(int menupos);
void topten(void);
void rdk_draw(void);
void redefinekey(int *key);
void rdks_draw(int menupos, int pnum);
void redefinekeys(int pnum);
void options_draw(int menupos);
void options(void);
void textmode(void);
void pause_menu_draw(int menupos);
void pause_menu(void);
void menu(void);

void topscores_default(void);

void intro(void);

#endif
