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
  This module implements all the menus - the main menu,
  the options menu, the pause menu and the hall of fame.
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <SDL.h>
#include "global.h"
#include "gfxout.h"
#include "gfxlib.h"
#include "keyboard.h"
#include "bg.h"
#include "main.h"
#include "timer.h"

#include "menus.h"

top_score_t topscore[NO_TOPSCORES];

int turnssincekey;

/* Function declarations */
static void topten_save(void);

void topten_draw(int cursoratline)
{
  int i,x0,y0;
  char s[TOPSC_NAME_SIZE+1];
  
  for(i=0;i<scr_x_size*scr_y_size;i++)
    vscr[i]=bmp_menu.data[i];
  
  y0 = scr_y_size/2 - (font[0].ch*8)/2;
  t_align=T_CENTER;
  v_print(scr_x_size/2,y0,FONT_HIGHLIGHTED,"Top Scores");
  t_align=T_LEFT;
  for(i=0;i<NO_TOPSCORES;i++) {
    strncpy(s,topscore[i].name,TOPSC_NAME_SIZE-1);
    s[TOPSC_NAME_SIZE-1]=0;
    if(cursoratline==i) strcat(s,"_");
    v_print(ts_x0,y0+font[0].ch*(i+3),FONT_NORMAL,s);
    v_printf(ts_x1,y0+font[0].ch*(i+3),FONT_NORMAL,"%08ld",topscore[i].score);
  }
  
  
  x0=diffx-(box_x_size*piecetypes/2);
  for(i=0;i<piecetypes;i++) {
    box_draw(x0+i*box_x_size,diffy,i+1);
  }
    
  virt_cpy();
}


int topten_update(int newscore) {
  int i,j,k,finished,turnssincekey,l,turns;
  char *user_name;
  int character;

  i=0;
  while(newscore<topscore[i].score) {
    i++;
    if(i>=NO_TOPSCORES) return 0;
  }
  
  // Wow, a new record !
  
  for(j=NO_TOPSCORES-1;j>i;j--)			// shift names down by one row
    topscore[j]=topscore[j-1];
  
  /* Set new score */
  topscore[i].score=newscore;
  
  /* Init name with the contents of USER environment variable */
  /* (if available) */
  user_name = getenv("USER");
  if(user_name) {
    strncpy(topscore[i].name,user_name,TOPSC_NAME_SIZE-1);
    topscore[i].name[TOPSC_NAME_SIZE-1]=0;
  } else {
    topscore[i].name[0]=0;
  }
  
  turns=1; finished=0;
  
  turnssincekey=0;
  do {
    if(turns<=1) {
      topten_draw(i);
    }

    pieces_anim_update();
    
    do {
      k=key_get_press_char(&character);
      switch(k) {
        case 0: break;
	
	case SDLK_RETURN:
	  if(topscore[i].name[0]!=0) finished=1;
	  break;
	  
	case SDLK_BACKSPACE:
	  l=strlen(topscore[i].name);
	  if(l>0)
	    topscore[i].name[l-1]=0;
	  break;
	  
	default:
	  if(character!=0) {
	    l=strlen(topscore[i].name);
	     if(l<TOPSC_NAME_SIZE) {
	       topscore[i].name[l+1]=0;
	       topscore[i].name[l]=character;
	     }
	  }
	  break;
      }
    } while (!(turns=is_next_turn()));
    
    SDL_Delay(SLEEP_MS);
    
    /* may be used to knock the user if asleep
       "hey! you're asleep ? you won, so enter your name!"
       
    if(k==0) turnssincekey+=turns; else turnssincekey=0;
    if(turnssincekey/framerate > TOPTENDURATION) cancel=1;*/
    
  } while(!finished && !quit);
  
  /* Do not save topten if interrupted by 'quit' */
  if(finished)
    topten_save();
  
  turnssincekey=0;
  
  return 1;
}

static void topten_save(void) {
  FILE *f;
  int i;
    
  if((f=fopen(topten_file,"wt"))==NULL) return;
  
  for(i=0;i<NO_TOPSCORES;i++)
    fprintf(f,"%s\n%ld\n",topscore[i].name,topscore[i].score);
    
  fclose(f); /* this may also cause an error */
}

void topten_load(void) {
  FILE *f;
  int i,l;
  char s[TOPSC_NAME_SIZE];
  
  if((f=fopen(topten_file,"rt"))==NULL) return;
  
  for(i=0;i<NO_TOPSCORES;i++) {
    fgets(s,TOPSC_NAME_SIZE,f);
    l=strlen(s);
    if(l>0) {
      if(s[l-1]=='\n') s[l-1]=0;
    }
    
    /* Being a bit paranoid here */
    strncpy(topscore[i].name,s,TOPSC_NAME_SIZE-1);
    topscore[i].name[TOPSC_NAME_SIZE-1]=0;
    
    fgets(s,TOPSC_NAME_SIZE,f);
    sscanf(s,"%ld",&topscore[i].score);
  }
  fclose(f);
}

void menu_draw(int menupos) {
  int i,x0,y0;
  
  for(i=0;i<scr_x_size*scr_y_size;i++)
    vscr[i]=bmp_menu.data[i];

  DEBUG2(
  t_align=T_LEFT;
  v_print(0,0,FONT_HIGHLIGHTED," !\"#$%&'()*+,-./");
  v_print(0,32,FONT_HIGHLIGHTED,"0123456789:;<=>?");
  v_print(0,64,FONT_HIGHLIGHTED,"@ABCDEFGHIJKLMNO");
  v_print(0,96,FONT_HIGHLIGHTED,"PQRSTUVWXYZ[\\]^_");
  v_print(0,128,FONT_HIGHLIGHTED,"`abcdefghijklmno");
  v_print(0,160,FONT_HIGHLIGHTED,"pqrstuvwxyz{|}~.");)
    
  y0 = scr_y_size/2 - (font[0].ch*5)/2;
  t_align=T_CENTER;
  v_print(scr_x_size/2,y0,             menupos==0,"1P Game");
  v_print(scr_x_size/2,y0+  font[0].ch,menupos==1,"2P vs. Game");
  v_print(scr_x_size/2,y0+2*font[0].ch,menupos==2,"Options");
  v_print(scr_x_size/2,y0+3*font[0].ch,menupos==3,"Instructions");
  v_print(scr_x_size/2,y0+4*font[0].ch,menupos==4,"Exit to system");

  x0=diffx-(box_x_size*piecetypes/2);
  for(i=0;i<piecetypes;i++) {
    box_draw(x0+i*box_x_size,diffy,i+1);
  }

  /*
  v_fillbox(0,0,80,60,127);
  clip_x0=0; clip_x1=160; clip_y0=0; clip_y1=100;
  v_drawframe(0,0,255,&(particle_frame[no_of_particle_frames-1]));
  v_copyarea(piece[0].bmp,vscr,
  box_x_size,scr_x_size,
  0,0,
  box_x_size,
  box_y_size,
  0,40);
  v_copyarea(particle_frame[no_of_particle_frames-1].data,vscr,
  particle_frame[no_of_particle_frames-1].xs,scr_x_size,
  0,0,
  particle_frame[no_of_particle_frames-1].xs,
  particle_frame[no_of_particle_frames
  -1].ys,
  40,40);
  
  for(y0=0;y0<particle_frame[no_of_particle_frames-1].ys;y0++)
    for(x0=0;x0<particle_frame[no_of_particle_frames-1].xs;x0++)
    vscr[y0*scr_x_size+x0+40]=
      pabmp.data[y0*particle_frame[no_of_particle_frames-1].xs+x0];
 
    */
  virt_cpy();
}

void topten(void) {
  int k,turns=1,cancel=0;
  
  turnssincekey=0;
  
  do {
    if(turns<=1) {
      topten_draw(-1);
    }
    
    pieces_anim_update();
    
    do {
      k=key_get_press();
      switch(k) {
//        case -1: quit=1; break;			// alt-x
	case 0: break;
	default: cancel=1; break;
      }
    } while (!(turns=is_next_turn()));
    
    SDL_Delay(SLEEP_MS);
    
    if(k==0) turnssincekey+=turns; else turnssincekey=0;
    if(turnssincekey/framerate > TOPTENDURATION) cancel=1;
    
  } while(!quit && !cancel);
  
  turnssincekey=0;
}

void rdk_draw(void) {
  int i,x0,y0;
  
  for(i=0;i<scr_x_size*scr_y_size;i++)
    vscr[i]=bmp_menu.data[i];
      
  y0 = scr_y_size/2 - (font[0].ch*1)/2;
  t_align=T_CENTER;
  v_print(scr_x_size/2,y0+0*font[0].ch,FONT_NORMAL,"Please press the desired key");
  
  x0=diffx-(box_x_size*piecetypes/2);
  for(i=0;i<piecetypes;i++) {
    box_draw(x0+i*box_x_size,diffy,i+1);
  }
    
  virt_cpy();
}

#define SAFETYDELAY 20

void redefinekey(int *key) {
  int rmain=0,k,turns=1;
  
  gameover=1; // to prevent key_handler() from doing some weird things
    
  turnssincekey=0;
  
  do {
    if(turns<=1) {
      rdk_draw();
    }
    
    pieces_anim_update();
    
    do {
      k=key_get_press();
    
      if(k>0) {				/* a key has been pressed */
        *key=k;				/* set the new key */
        rmain=1;
      }
    
    } while (!(turns=is_next_turn()));
    
    SDL_Delay(SLEEP_MS);
    
    if(k==0) turnssincekey+=turns; else turnssincekey=0;
    if(turnssincekey/framerate > SAFETYDELAY) rmain=1;
    
  } while(!rmain && !quit);
}

void rdks_draw(int menupos, int pnum) {
  int i,x0,y0;
  char s1[100];
  
  for(i=0;i<scr_x_size*scr_y_size;i++)
    vscr[i]=bmp_menu.data[i];
  
  y0 = scr_y_size/2 - (font[0].ch*6)/2;
  t_align=T_CENTER;
  
  key_2_str(key_left[pnum],s1);
  v_printf(scr_x_size/2,y0+0*font[0].ch,menupos==0,"Move piece left:%s",s1);
  
  key_2_str(key_right[pnum],s1);
  v_printf(scr_x_size/2,y0+1*font[0].ch,menupos==1,"Move piece right:%s",s1);
  
  key_2_str(key_shift_up[pnum],s1);
  v_printf(scr_x_size/2,y0+2*font[0].ch,menupos==2,"Shift piece up:%s",s1);
  
  key_2_str(key_shift_down[pnum],s1);
  v_printf(scr_x_size/2,y0+3*font[0].ch,menupos==3,"Shift piece down:%s",s1);
  
  key_2_str(key_drop[pnum],s1);
  v_printf(scr_x_size/2,y0+4*font[0].ch,menupos==4,"Drop piece:%s",s1);
  
  v_print(scr_x_size/2,y0+5*font[0].ch,menupos==5,"Return to Options Menu");
  
  
  x0=diffx-(box_x_size*piecetypes/2);
  for(i=0;i<piecetypes;i++) {
    box_draw(x0+i*box_x_size,diffy,i+1);
  }
    
  virt_cpy();
}

void redefinekeys(int pnum) {
  int rmain=0,menupos=0,k,turns=1;
  
  turnssincekey=0;
  
  do {
    if(turns<=1) {
      rdks_draw(menupos,pnum);
    }
    
    pieces_anim_update();
    
    do {
      k=key_get_press();
      switch(k) {
        case 0: break;
        case SDLK_UP:   if(menupos>0) menupos--; break;	// up arrow
        case SDLK_DOWN: if(menupos<5) menupos++; break;	// down arrow
//        case -1: rmain=1; quit=1; break;		// alt-x
        case SDLK_RETURN: {				// return
          switch(menupos) {
	    case 0: redefinekey(&key_left[pnum]); break;
	    case 1: redefinekey(&key_right[pnum]); break;
	    case 2: redefinekey(&key_shift_up[pnum]); break;
	    case 3: redefinekey(&key_shift_down[pnum]); break;
	    case 4: redefinekey(&key_drop[pnum]); break;
	    case 5: rmain=1; break;
	  }    
        }; break;
      }
    } while (!(turns=is_next_turn()));
    
    SDL_Delay(SLEEP_MS);
    
    if(k==0) turnssincekey+=turns; else turnssincekey=0;
    //if(turnssincekey/framerate > TOPTENDELAY) topten();
    
  } while(!rmain && !quit);

}

void options_draw(int menupos) {
  int i,x0,y0;
  char s[100];
  
  for(i=0;i<scr_x_size*scr_y_size;i++)
    vscr[i]=bmp_menu.data[i];
    
    
  y0 = scr_y_size/2 - (font[0].ch*8)/2;
  t_align=T_CENTER;
  strcpy(s,"Difficulty:");
  switch(piecetypes) {
    case 4: strcat(s,"Easy"); break;
    case 5: strcat(s,"Medium"); break;
    case 6: strcat(s,"Hard"); break;
  }
  v_print (scr_x_size/2,y0,menupos==0,             s);
  v_printf(scr_x_size/2,y0+  font[0].ch,menupos==1,"Starting Level:%d",startinglevel);
  v_printf(scr_x_size/2,y0+2*font[0].ch,menupos==2,"Block Set:%d",setn);
  v_printf(scr_x_size/2,y0+3*font[0].ch,menupos==3,"Background:%s",dbackground?"Yes":"No");
  v_printf(scr_x_size/2,y0+4*font[0].ch,menupos==4,"Intro:%s",showintro?"Yes":"No");
  v_print (scr_x_size/2,y0+5*font[0].ch,menupos==5,"Redefine P1 keys");
  v_print (scr_x_size/2,y0+6*font[0].ch,menupos==6,"Redefine P2 keys");
  v_print (scr_x_size/2,y0+7*font[0].ch,menupos==7,"Return to Main Menu");
  
  x0=diffx-(box_x_size*piecetypes/2);
  for(i=0;i<piecetypes;i++) {
    box_draw(x0+i*box_x_size,diffy,i+1);
  }
    
  virt_cpy();
}


void options(void) {
  int rmain=0,menupos=0,k,turns=1;
  
  turnssincekey=0;
  
  do {
    if(turns<=1) {
      options_draw(menupos);
    }
    
    pieces_anim_update();
    
    do {
      k=key_get_press();
      switch(k) {
        case 0: break;
        case SDLK_UP:   if(menupos>0) menupos--; break;	// up arrow
        case SDLK_DOWN: if(menupos<7) menupos++; break;	// down arrow
        case SDLK_LEFT: // left arrow
          switch(menupos) {
  	    case 0: if(piecetypes>MIN_PIECE_TYPES) piecetypes--; break;
	    case 1: if(startinglevel>1) startinglevel--; break;
	    case 2: if(setn>0) setn--; pieces_checkfnum(); break;
	    case 3: dbackground=0; break;
	    case 4: showintro=0; break;
	  }
          break;
        case SDLK_RIGHT: // right arrow
          switch(menupos) {
	    case 0: if(piecetypes<MAX_PIECE_TYPES) piecetypes++; break;
	    case 1: if(startinglevel<10) startinglevel++; break;
	    case 2: if(setn<no_of_sets-1) setn++; pieces_checkfnum(); break;
	    case 3: dbackground=1; break;
	    case 4: showintro=1; break;
	  }
          break;
//        case 0x1b78   : rmain=1; quit=1; break;		// alt-x
        case SDLK_RETURN: {					// return
          switch(menupos) {
	    case 5: redefinekeys(0); break;
	    case 6: redefinekeys(1); break;
	    case 7: rmain=1; break;
	  }    
        }; break;
      }
    } while (!(turns=is_next_turn()));
    
    SDL_Delay(SLEEP_MS);
    
    if(k==0) turnssincekey+=turns; else turnssincekey=0;
    if(turnssincekey/framerate > TOPTENDELAY) topten();
    
  } while(!rmain && !quit);
}

void textmode(void) {
  int k;
  
//  gfx_deinit();
  printf("\n\nPress RETURN to go back to graphics...\n");
  
  do {
    k=key_get_press();
  } while(!k);
  
//  gfx_init();
//  screen_setpal();
}

void pause_menu_draw(int menupos) {
  int i,y0;
      
  for(i=0;i<scr_x_size*scr_y_size;i++)
    vscr[i]=bmp_game[players-1].data[i];
    
  for(i=0;i<players;i++) {
    board_draw(&(player[i]),1,0);
  }
  

  game_statistics_draw();
  
  /* draw the pause menu */
  clip_x0=0;clip_y0=0; clip_x1=scr_x_size-1; clip_y1=scr_y_size-1;
  v_drawbmp((scr_x_size-bmp_pmenu.xs)/2,
            (scr_y_size-bmp_pmenu.ys)/2,
	    bmp_pmenu.key_color,bmp_pmenu.xs,bmp_pmenu.ys,bmp_pmenu.data);
    
  /* and its text */
  y0 = scr_y_size/2 - (font[0].ch*4)/2;
  t_align=T_CENTER;
  v_print (scr_x_size/2,y0+0*font[0].ch,menupos==0,"Back to Game");
  v_print (scr_x_size/2,y0+1*font[0].ch,menupos==1,"Exit to Main Menu");
  v_printf(scr_x_size/2,y0+2*font[0].ch,menupos==2,"Block Set:%d",setn);
  v_printf(scr_x_size/2,y0+3*font[0].ch,menupos==3,"Background:%s",dbackground?"Yes":"No");
//  v_print (scr_x_size/2,y0+4*font[0].ch,menupos==4,"Jump to Text Mode");
    
  virt_cpy();
}


void pause_menu(void) {
  int rmain=0,menupos=0,k,turns=1;
  
  turnssincekey=0;
  
  do {
    if(turns<=1) {
      if(dbackground && bgnumframes==0) bg_update();
      pause_menu_draw(menupos);
      dispframenum++;
    }
    
    pieces_anim_update();
    
    do {
      k = key_get_press();
      switch(k) {
        case 0: break;
        case SDLK_UP: if(menupos>0) menupos--; break;	// up arrow
        case SDLK_DOWN: if(menupos<3) menupos++; break;	// down arrow
        case SDLK_LEFT: // left arrow
          switch(menupos) {
	    case 2: if(setn>0) setn--; pieces_checkfnum(); break;
	    case 3: dbackground=0; break;
	  }
          break;
        case SDLK_RIGHT: // right arrow
          switch(menupos) {
	    case 2: if(setn<no_of_sets-1) setn++; pieces_checkfnum(); break;
	    case 3: dbackground=1; break;
	  }
          break;
//        case -1: rmain=1; quit=1; break;		// alt-x
        case SDLK_RETURN: {				// return
          switch(menupos) {
	    case 0: rmain=1; break;
	    case 1: rmain=1; endgame=1; break;
//	    case 4: textmode(); break;
	  }    
        }; break;
      }
    } while (!(turns=is_next_turn()));
    
    SDL_Delay(SLEEP_MS);
    
    if(k==0) turnssincekey+=turns; else turnssincekey=0;
    //if(turnssincekey/framerate > TOPTENDELAY) topten();
    
  } while(!rmain && !quit);
  
  pausemenu=0;
}



void menu(void) {
  int menupos=0,k,turns=1;
  
  turnssincekey=0;
  
  if(immedstart) game();
    
  time_init();
  random_init();
    
  do {
    if(turns<=1) {
      menu_draw(menupos);
    }
    
    pieces_anim_update();
    
    do {
      k=key_get_press();
      switch(k) {
        case 0: break;
	case SDLK_f: gfx_set_fullscreen(!gfx_get_fullscreen()); break;
        case SDLK_UP: if(menupos>0) menupos--; break;	// up arrow
        case SDLK_DOWN: if(menupos<4) menupos++; break;	// down arrow
//        case -1: quit=1; break;				// alt-x
        case SDLK_RETURN: {				// return
          switch(menupos) {
  	    case 0: players=1; game(); break;
	    case 1: players=2; game(); break;
	    case 2: options(); break;
	    case 4: quit=1; break;
	  }    
        }; break;
      }
    } while (!(turns=is_next_turn()));
    
    SDL_Delay(SLEEP_MS);
    
    if(k==0) turnssincekey+=turns; else turnssincekey=0;
    if(turnssincekey/framerate > TOPTENDELAY) { 
     /* printf("k=0x%x turns=%d tsk=%d (TTDT=%f).. entering topten\n",
      k,turns,turnssincekey,TOPTENDELAY*framerate);*/
      topten();
    }
  } while(!quit);
}


/* in the case no topscores file is present */
void topscores_default(void) {
  topscore[0].score=100000; strcpy(topscore[0].name,"Brain");
  topscore[1].score= 80000; strcpy(topscore[1].name,"Pinky");
  topscore[2].score= 60000; strcpy(topscore[2].name,"Chip");
  topscore[3].score= 40000; strcpy(topscore[3].name,"Jazz");
  topscore[4].score= 20000; strcpy(topscore[4].name,"Pac");
//  topscore[5].score= 10000; strcpy(topscore[5].name,"Indy");
}


void intro(void) {
  int k,turns=1,i;
  
  turnssincekey=0;
  
  time_init();
  
  for(i=0;i<scr_x_size*scr_y_size;i++)
    vscr[i]=bmp_intro.data[i];
    
  virt_cpy();
  
  do {
    do {
      k=key_get_press();
      if(k!=0) quit=1;
    } while (!(turns=is_next_turn()));
    
    SDL_Delay(SLEEP_MS);
    
    if(k==0) turnssincekey+=turns; else turnssincekey=0;
    if(turnssincekey/framerate > INTRODELAY) { 
      quit=1;
    }
  } while(!quit);
}

