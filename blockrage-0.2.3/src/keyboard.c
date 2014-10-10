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
  This module provides key names, key-to-character mapping
  and interfaces SDL keyboard.
*/

#include <stdio.h>
#include <SDL.h>
#include <string.h>
#include "global.h"
#include "main.h"
#include "keyboard.h"

int keyboard_state[KSTAT_SIZE];
static int (*k_hnd)(int sym, int mod, int press);

static void input_clearstate(void) {
  int i;
  for(i=0;i<KSTAT_SIZE;i++) keyboard_state[i]=0;
}

int input_init(int (*_k_hnd)(int,int,int)) {
  k_hnd = _k_hnd;
  input_clearstate();
  return 1;
}

void input_deinit(void) {

}

/*
  Map the keypress into a character.
  
  Curently uses trivial mapping, relies on the fact
  that the keysyms for characters map onto ASCII codes
  in sdl_keysym.h
*/
static int key_2_char(SDL_KeyboardEvent *keyev) {
  int sym,mod;
  int shift, caps;
  
  sym = keyev->keysym.sym;
  mod = keyev->keysym.mod;
  
  shift = mod & KMOD_SHIFT;
  caps = mod & KMOD_CAPS;
  
  /* No corresponding character */
  if(sym<32 || sym>127)
    return 0; 
    
  /* No modifier */
  if(!shift && !caps) {
    return sym;
  }
  
  /* CAPS LOCK only */
  if(!shift) {
    if(sym>='a' && sym<='z') return sym-32;
    return sym;
  }

  /* SHIFT [+CAPS] */
  if(sym>127) return 0;
  if(sym>='a' && sym<='z') {
    if(!caps) return sym-32;
      else return sym;
  }
  switch(sym) {
    case '`': return '~'; case '1': return '!'; case '2': return '@';
    case '3': return '#'; case '4': return '$'; case '5': return '%';
    case '6': return '^'; case '7': return '&'; case '8': return '*';
    case '9': return '('; case '0': return ')'; case '-': return '_';
    case '=': return '+'; case '[': return '{'; case ']': return '}';
    case ';': return ':'; case '\'': return '"';
    case '\\': return '|'; case ',': return '<'; case '.': return '>';
    case '/': return '?';
  }
  return sym-16;
}

int key_get(int *code, int *press) {
  SDL_Event event;
  SDL_KeyboardEvent *keyev;
  
  while(SDL_PollEvent(&event)) {
    switch(event.type) {
      case SDL_QUIT:
        quit=1;
	break;
	
      case SDL_KEYDOWN:
      case SDL_KEYUP:
        keyev = (SDL_KeyboardEvent *)&event;
        if(k_hnd(keyev->keysym.sym, keyev->keysym.mod,
	         event.type == SDL_KEYDOWN)) {  
	  *code = keyev->keysym.sym;
	  *press = event.type == SDL_KEYDOWN;
          return 1;
	}
	break;
      default:
        break;
    }
  }
  return 0;
}

int key_get_press_char(int *character) {
  SDL_Event event;
  SDL_KeyboardEvent *keyev;
  
  while(SDL_PollEvent(&event)) {
    switch(event.type) {
      case SDL_QUIT:
        quit=1;
	break;

      case SDL_KEYDOWN:
	keyev = (SDL_KeyboardEvent *)&event;
        if(k_hnd(keyev->keysym.sym, keyev->keysym.mod,
	         event.type == SDL_KEYDOWN)) {
          *character = key_2_char(keyev);
          return keyev->keysym.sym;
	}
	break;
      default:
        break;
    }
  }
  return 0;
}


int key_get_press(void) {
  int character;
  return key_get_press_char(&character);
}



void key_2_str(int key, char *dst) {
  switch(key) {
    case SDLK_ESCAPE: 		strcpy(dst,"escape");		break;
    case SDLK_1:		strcpy(dst,"1");		break;
    case SDLK_2: 		strcpy(dst,"2");		break;
    case SDLK_3: 		strcpy(dst,"3");		break;
    case SDLK_4: 		strcpy(dst,"4");		break;
    case SDLK_5: 		strcpy(dst,"5");		break;
    case SDLK_6: 		strcpy(dst,"6");		break;
    case SDLK_7: 		strcpy(dst,"7");		break;
    case SDLK_8: 		strcpy(dst,"8");		break;
    case SDLK_9: 		strcpy(dst,"9");		break;
    case SDLK_0: 		strcpy(dst,"0");		break;
    case SDLK_MINUS: 		strcpy(dst,"-");		break;
    case SDLK_EQUALS: 		strcpy(dst,"=");		break;
    case SDLK_BACKSPACE: 	strcpy(dst,"bspace");		break;
    case SDLK_TAB: 		strcpy(dst,"tab");		break;
    case SDLK_q: 		strcpy(dst,"q");		break;
    case SDLK_w: 		strcpy(dst,"w");		break;
    case SDLK_e: 		strcpy(dst,"e");		break;
    case SDLK_r: 		strcpy(dst,"r");		break;
    case SDLK_t: 		strcpy(dst,"t");		break;
    case SDLK_y: 		strcpy(dst,"y");		break;
    case SDLK_u: 		strcpy(dst,"u");		break;
    case SDLK_i: 		strcpy(dst,"i");		break;
    case SDLK_o: 		strcpy(dst,"o");		break;
    case SDLK_p: 		strcpy(dst,"p");		break;
    case SDLK_LEFTBRACKET: 	strcpy(dst,"[");		break;
    case SDLK_RIGHTBRACKET: 	strcpy(dst,"]");		break;
    case SDLK_RETURN: 		strcpy(dst,"return");		break;
    case SDLK_LCTRL: 		strcpy(dst,"left ctrl");	break;
    case SDLK_a: 		strcpy(dst,"a");		break;
    case SDLK_s: 		strcpy(dst,"s");		break;
    case SDLK_d: 		strcpy(dst,"d");		break;
    case SDLK_f: 		strcpy(dst,"f");		break;
    case SDLK_g: 		strcpy(dst,"g");		break;
    case SDLK_h: 		strcpy(dst,"h");		break;
    case SDLK_j: 		strcpy(dst,"j");		break;
    case SDLK_k: 		strcpy(dst,"k");		break;
    case SDLK_l: 		strcpy(dst,"l");		break;
    case SDLK_SEMICOLON: 	strcpy(dst,";");		break;
    case SDLK_QUOTE: 		strcpy(dst,"'");		break;
    case SDLK_BACKQUOTE:	strcpy(dst,"`");		break;
    case SDLK_LSHIFT: 		strcpy(dst,"left shft");	break;
    case SDLK_BACKSLASH: 	strcpy(dst,"\\");		break;
    case SDLK_z: 		strcpy(dst,"z");		break;
    case SDLK_x: 		strcpy(dst,"x");		break;
    case SDLK_c: 		strcpy(dst,"c");		break;
    case SDLK_v: 		strcpy(dst,"v");		break;
    case SDLK_b: 		strcpy(dst,"b");		break;
    case SDLK_n: 		strcpy(dst,"n");		break;
    case SDLK_m: 		strcpy(dst,"m");		break;
    case SDLK_COMMA: 		strcpy(dst,",");		break;
    case SDLK_PERIOD: 		strcpy(dst,".");		break;
    case SDLK_SLASH: 		strcpy(dst,"/");		break;
    case SDLK_RSHIFT: 		strcpy(dst,"right shft");	break;
    case SDLK_KP_MULTIPLY: 	strcpy(dst,"keypad *");		break;
    case SDLK_LALT: 		strcpy(dst,"left alt");		break;
    case SDLK_SPACE: 		strcpy(dst,"space");		break;
    case SDLK_CAPSLOCK: 	strcpy(dst,"caps lock");	break;
    case SDLK_F1: 		strcpy(dst,"f1");		break;
    case SDLK_F2: 		strcpy(dst,"f2");		break;
    case SDLK_F3: 		strcpy(dst,"f3");		break;
    case SDLK_F4: 		strcpy(dst,"f4");		break;
    case SDLK_F5: 		strcpy(dst,"f5");		break;
    case SDLK_F6: 		strcpy(dst,"f6");		break;
    case SDLK_F7: 		strcpy(dst,"f7");		break;
    case SDLK_F8: 		strcpy(dst,"f8");		break;
    case SDLK_F9: 		strcpy(dst,"f9");		break;
    case SDLK_F10: 		strcpy(dst,"f10");		break;
    case SDLK_F11: 		strcpy(dst,"f11");		break;
    case SDLK_F12: 		strcpy(dst,"f12");		break;
    case SDLK_NUMLOCK: 		strcpy(dst,"num lock");		break;
    case SDLK_SCROLLOCK: 	strcpy(dst,"scroll lock");	break;
    case SDLK_KP7: 		strcpy(dst,"keypad 7");		break;
    case SDLK_KP8: 		strcpy(dst,"keypad 8");		break;
    case SDLK_KP9: 		strcpy(dst,"keypad 9");		break;
    case SDLK_KP_MINUS: 	strcpy(dst,"keypad -");		break;
    case SDLK_KP4: 		strcpy(dst,"keypad 4");		break;
    case SDLK_KP5: 		strcpy(dst,"keypad 5");		break;
    case SDLK_KP6: 		strcpy(dst,"keypad 6");		break;
    case SDLK_KP_PLUS: 		strcpy(dst,"keypad +");		break;
    case SDLK_KP1: 		strcpy(dst,"keypad 1");		break;
    case SDLK_KP2: 		strcpy(dst,"keypad 2");		break;
    case SDLK_KP3: 		strcpy(dst,"keypad 3");		break;
    case SDLK_KP0: 		strcpy(dst,"keypad 0");		break;
    case SDLK_KP_PERIOD: 	strcpy(dst,"keypad .");		break;
    case SDLK_KP_ENTER: 	strcpy(dst,"keypad return");	break;
    case SDLK_RCTRL: 		strcpy(dst,"right ctrl");	break;
    case SDLK_KP_DIVIDE: 	strcpy(dst,"keypad /");		break;
    case SDLK_PRINT:	 	strcpy(dst,"prnscr");		break;
    case SDLK_RALT: 		strcpy(dst,"ralt");		break;
    case SDLK_BREAK: 		strcpy(dst,"break");		break;
    case SDLK_SYSREQ:		strcpy(dst,"sysreq");		break;
    case SDLK_HOME: 		strcpy(dst,"home");		break;
    case SDLK_UP: 		strcpy(dst,"up arrow");		break;
    case SDLK_PAGEUP: 		strcpy(dst,"pageup");		break;
    case SDLK_LEFT: 		strcpy(dst,"left arrow");	break;
    case SDLK_RIGHT: 		strcpy(dst,"right arrow");	break;
    case SDLK_END: 		strcpy(dst,"end");		break;
    case SDLK_DOWN: 		strcpy(dst,"down arrow");	break;
    case SDLK_PAGEDOWN: 	strcpy(dst,"pagedown");		break;
    case SDLK_INSERT: 		strcpy(dst,"ins");		break;
    case SDLK_DELETE: 		strcpy(dst,"del");		break;
    case SDLK_LSUPER: 		strcpy(dst,"left OS key");	break;
    case SDLK_RSUPER: 		strcpy(dst,"right OS key");	break;
    case SDLK_MENU:		strcpy(dst,"menu key");		break;
    default: 			sprintf(dst,"unknown(%d)",key);	break;
  }
}
