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
  This module implements the gameplay itself, as well as
  argument parsing, rc and configfile parsing.
*/


#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <SDL.h>
#include "global.h"
#include "gfxout.h"
#include "gfxlib.h"
#include "menus.h"
#include "keyboard.h"
#include "bg.h"
#include "sound.h"
#include "timer.h"

#include "main.h"

static int first_execution;

player_t player[2];
int players;
int piecetypes;
static float fl_piecetypes;
int startinglevel;
static int board_x_size,board_y_size;
static int board_x_center;
int box_x_size,box_y_size;
int endgame,gameover;
int pausemenu;
static int paused;
static int board_left[3], board_bottom[3], board_top[3];

unsigned char *mypal;
#ifdef DIRECT_COLOR
pix_t mypalx[256];
#endif

unsigned char *fontn;
bmp_t bmp_menu;
bmp_t bmp_pmenu,bmp_intro;
unsigned char *bground;
bmp_t bmp_game[2];
static piece_t *piece;
static float piece_spd,piece_spd_drop; /* time in secs it takes the piece to fall 
 				          all the way down */
static float fall_spd, rise_spd;
float framerate;
static float gravity,maxdefspd;
int board_y_pix_size,board_x_pix_size;
static int nx_x0[3],nx_y0[3]; /* "NEXT" block coordinates for P1,P2, single P.*/
static int nx_t_x0[3],nx_t_y0[3]; /* "NEXT" label coordinates for P1,P2, single P.*/

static int key_quit;
int key_left[2],key_right[2],key_drop[2],key_shift_up[2],key_shift_down[2];

static int level,blocksleft;
static int lnumframes;
int bgnumframes;	/* game frames till bg display */

int dbackground; /* 1: draw background effects, 0: bitmap background */
int showintro;

static int turndone;
char dataset[100];
static char *sys_config_file;
static char *usr_config_file;
char *datadir;
char *topten_file;

int immedstart;
int quit;
static int statx[6],staty[6];
int diffx,diffy;   /* coordinates of the difficulty level display box */
int ts_x0,ts_x1;   /* x-coordinates of the top-ten names(ts_x0) & scores(ts_x1) */
int no_of_sets;
int setn;
static int p_curframe[6]; /* piece: current frame number */
static float p_timeleft[6];  /* piece:remaining time for current frame (in secs) */
static float gboomdelay; /* delay(in secs) between line blowing when gameover */
int dispframenum;
static int framenum;

static int no_of_particle_frames;
static frame_t *particle_frame;

// returns an int between <base> and <base+range-1>
long randint(long base,long range) {
  float frange=range;
  
  return base+(int) (frange*rand()/(RAND_MAX+1.0));
}

// returns a float between <base> and <base+range>
static float randfloat(float base,float range) { 
  return base+(range*rand()/RAND_MAX);
}


void box_draw(int x0, int y0, int type)
{
  int x,y;
  pix_t c,*sp;
  pix_t *dp;
  pix_t key_color;
  piece_t *piecep;
  
  piecep = &piece[setn*P_PER_S+type-1];
  
  sp=&(piecep->bmp[p_curframe[type-1]*(box_x_size*box_y_size)]);
  key_color = piecep->key_color;
  
  if(type) {
    for(y=0;y<box_y_size;y++) {
      dp=&(vscr[(y0+y)*scr_x_size+x0]);
      for(x=0;x<box_x_size;x++) {
        if((c=*sp++)!=key_color) *dp=c;
	dp++;
      }
    }  
  }	
}


static void piece_drawnext(player_t *p, int redraw) {
  int i,animated;
  int bi=(players==1) ? 2 : (p->number);
  
  animated=0;
  
  for(i=0;i<3;i++)
    if(piece[setn*P_PER_S+(p->p_nxt[i]-1)].frames>1) animated=1;
  
  if(animated || redraw) {
  
    t_align = T_CENTER;
    v_print(nx_t_x0[bi],nx_t_y0[bi],FONT_NORMAL,"NEXT");
    virt_cpyarea(nx_t_x0[bi],nx_t_y0[bi],
               strpixlen("NEXT",FONT_NORMAL),font[FONT_NORMAL].ch);

    v_copyarea(bmp_game[players-1].data,vscr,scr_x_size,scr_x_size,
               nx_x0[bi],nx_y0[bi],
               box_x_size,3*box_y_size,
	       nx_x0[bi],nx_y0[bi]);

    for(i=0;i<3;i++)
      box_draw(nx_x0[bi],nx_y0[bi]+i*box_y_size,p->p_nxt[2-i]);

    virt_cpyarea(nx_x0[bi],nx_y0[bi],box_x_size,3*box_y_size);
  }
}

static void game_over(void) { /* someone has died */
  if(!gameover) {
    gameover=1;
    sound_fx(2);
  }
}

static void game_drawscore(player_t *p, int bgvcpy) {
  if(bgvcpy) {
    v_drawscrarea(bmp_game[players-1].data,statx[1],staty[1],
                strpixlen("0000000",FONT_HIGHLIGHTED),font[FONT_HIGHLIGHTED].ch);
  }
  t_align=T_LEFT;
  v_printf(statx[1],staty[1],FONT_HIGHLIGHTED,"%07d",p->score);
  
  if(bgvcpy) {
    virt_cpyarea(statx[1],staty[1],
               strpixlen("00000000",FONT_HIGHLIGHTED),font[FONT_HIGHLIGHTED].ch);
  }
}

static void game_drawlevelnum(int bgvcpy) {

  if(bgvcpy) {
    v_drawscrarea(bmp_game[players-1].data,statx[3],staty[3],
                strpixlen("00",FONT_HIGHLIGHTED),font[FONT_HIGHLIGHTED].ch);
  }
  t_align=T_LEFT;
  v_printf(statx[3],staty[3],FONT_HIGHLIGHTED,"%02d",level);
  
  if(bgvcpy) {
    virt_cpyarea(statx[3],staty[3],
               strpixlen("00",FONT_HIGHLIGHTED),font[FONT_HIGHLIGHTED].ch);
  }
}

static void game_drawblocksleft(int bgvcpy) {
  if(bgvcpy) {
    v_drawscrarea(bmp_game[players-1].data,statx[5],staty[5],
                strpixlen("00",FONT_HIGHLIGHTED),font[FONT_HIGHLIGHTED].ch);
  }
  t_align=T_LEFT;
  v_printf(statx[5],staty[5],FONT_HIGHLIGHTED,"%02d",blocksleft);
  
  if(bgvcpy) {
    virt_cpyarea(statx[5],staty[5],
               strpixlen("00",FONT_HIGHLIGHTED),font[FONT_HIGHLIGHTED].ch);
  }
}

void board_draw(player_t *p, int hidepieces, int vcpy) {
  int i,x,y,yshift,x0,y0;
  int pn=p->number;
  int bi=(players==1)?2:pn;
  char s[20];
  p_list_t *pp;
  unsigned char *ucp;
  
  /* board background */
  if(dbackground) {     /* special effects */
    if(bgnumframes==0) {
      ucp=bground;	
      for(y=0;y<board_y_pix_size;y++)
        for(x=0;x<board_x_pix_size;x++) {
          vscr[(y+board_top[bi])*scr_x_size+x+board_left[bi]]=
#ifdef DIRECT_COLOR
            mypalx[(*ucp++)+BGPALBASE];
#else
	    (*ucp++)+BGPALBASE;
#endif	    
        }
    } else { /* black */
      ucp=bground;	
      for(y=0;y<board_y_pix_size;y++)
        for(x=0;x<board_x_pix_size;x++) {
          vscr[(y+board_top[bi])*scr_x_size+x+board_left[bi]]=0;
        }
    }
  } else { /* bitmap bacground */
    v_copyarea(bmp_game[players-1].data,vscr,scr_x_size,scr_x_size,
             board_left[bi],board_top[bi],
             board_x_size*box_x_size,board_y_size*box_y_size,
	     board_left[bi],board_top[bi]);
  }
  
  if(!hidepieces) {
    /* pieces stuck on board */
    for(y=0;y<board_y_size;y++)
      for(x=0;x<board_x_size;x++) {
       if((p->bflags[y*board_x_size+x] != BF_BLOW) 
          || /*!(p->explode_frames & 1)*/ (dispframenum & 1)) {
  	     switch(p->status) {
	       case S_FALL:  yshift=(p->bflags[y*board_x_size+x]==BF_FALL)?
	              -p->fall_pix : 0; break;
	       case S_RISE: yshift=p->rise_pix; break;
	       default: yshift=0; break;
	     }
             box_draw(board_left[bi]+x*box_x_size,
                      board_bottom[bi]-y*box_y_size+yshift,
                      p->board[y*board_x_size+x]);		 
		    
       }	      
    }
  
    /* falling piece */
    if(p->status==S_NORMAL && !gameover) {
      for(i=0;i<3;i++) if(p->piecey+i<board_y_size) {
        box_draw(board_left[bi]+p->piecex*box_x_size,
                 board_bottom[bi]-(p->piecey+i)*box_y_size-p->pieceypix,
                 p->p_cur[i]);	       
      }
    }
    
    /* clean some garbage above and below the board */
    v_copyarea(bmp_game[players-1].data,vscr,scr_x_size,scr_x_size,
               board_left[bi],board_top[bi]-box_y_size,
               board_x_size*box_x_size,box_y_size,
    	       board_left[bi],board_top[bi]-box_y_size);
	     
    v_copyarea(bmp_game[players-1].data,vscr,scr_x_size,scr_x_size,
               board_left[bi],board_bottom[bi]+box_y_size,
               board_x_size*box_x_size,box_y_size,
               board_left[bi],board_bottom[bi]+box_y_size);     

    /* adjust clipping for particle drawing */
    clip_x0=board_left[bi]; clip_y0=board_top[bi];
    clip_x1=clip_x0+board_x_pix_size-1;
    clip_y1=clip_y0+board_y_pix_size-1;
  

  
    // Draw all the particles
    pp=p->particles;
    while(pp) {
      v_drawbmp(board_left[bi] + pp->x,
                  board_top[bi] + board_y_pix_size - pp->y,
  	  	  particle_frame[pp->frame].bmp.key_color,
		  particle_frame[pp->frame].bmp.xs,
		  particle_frame[pp->frame].bmp.ys,
		  particle_frame[pp->frame].bmp.data);
      pp=pp->next;
    }
  }
  
  if(paused) {
    t_align=T_CENTER;
    x0=board_left[bi]+(board_x_pix_size/2);
    y0=board_top[bi]+(board_y_pix_size/2);
    
    v_print(x0,y0-(font[0].ch/2),FONT_NORMAL,"PAUSED");
  }
	
  /* loser/winner/gameover text */
  if(gameover) {
    t_align=T_CENTER;
    x0=board_left[bi]+(board_x_pix_size/2);
    y0=board_top[bi]+(board_y_pix_size/2);
    
    if(players==2) {
      if(player[0].loser && player[1].loser) strcpy(s,"TIE");
       else {
         if(p->loser) strcpy(s,"LOSER");
           else strcpy(s,"WINNER");
       }
    } else {
      if(player[0].loser) strcpy(s,"GAME OVER");
	else strcpy(s,"GAME COMPLETED");
    }

    v_print(x0,y0-(font[0].ch),FONT_NORMAL,s);
  } 
  else if(lnumframes>0) {	/* level %d text */
    t_align=T_CENTER;
    x0=board_left[bi]+board_x_pix_size/2;
    y0=board_top[bi]+board_y_pix_size/2;

    v_printf(x0,y0-font[0].ch/2,FONT_NORMAL,"Level %d",level);
  }
  
  /* copy to screen */
  if(vcpy) {
    virt_cpyarea(board_left[bi],board_top[bi],
                 board_x_size*box_x_size,board_y_size*box_y_size);
  }
}

void game_statistics_draw(void) {
  if(players==1) {
    t_align=T_LEFT;
    v_print(statx[0],staty[0],FONT_NORMAL,"Score:");
    v_print(statx[2],staty[2],FONT_NORMAL,"Level:");
    v_print(statx[4],staty[4],FONT_NORMAL,"Blocks:");
    game_drawlevelnum(0);
    game_drawblocksleft(0);
    game_drawscore(&(player[0]),0);
  }
}

static void game_draw(void) {
  int i;
#ifdef DEBUG
  char s[30];
#endif
  
  for(i=0;i<scr_x_size*scr_y_size;i++)
    vscr[i]=bmp_game[players-1].data[i];

  game_statistics_draw();
  
  if(!paused) {
    for(i=0;i<players;i++)    
      piece_drawnext(&(player[i]),1);
  }
  
  for(i=0;i<players;i++)
    board_draw(&(player[i]),paused,1);

#ifdef DEBUG 
  t_align=T_LEFT;
  v_printf(0,0,FONT_HIGHLIGHTED,"%f",
              (float)framerate*(float)dispframenum/(float)framenum);
#endif

  virt_cpy();
}

static p_list_t *particle_create(p_list_t *next, 
            float x, float y, float vx, float vy, float fr_age, int frame) {
  p_list_t *tmp;
  
  tmp=calloc_verify(1,sizeof(p_list_t));
  
  tmp->x=x;
  tmp->y=y;
  tmp->vx=vx;
  tmp->vy=vy;
  tmp->fr_age=fr_age;
  tmp->next=next;
  tmp->frame=frame;
  
  return tmp;
}

static int piece_collides(player_t *p, int x, int y) {
  return y<0 ? 1 : (p->board[y*board_x_size+x] |
                    p->board[(y+1)*board_x_size+x] |
		    p->board[(y+2)*board_x_size+x])!=0;
}

static void player_givepiece(player_t *p) {
  int i;
  
  
  for(i=0;i<3;i++) {

    p->p_cur[i]=p->p_nxt[i];
    fl_piecetypes=piecetypes;
    p->p_nxt[i]=randint(1,fl_piecetypes); // 1..fl_piecetypes
  }
  p->piecey=board_y_size-1;
  p->pieceypix=box_y_size;
  p->piecex=board_x_center;
  p->pieceyfrac=0;

  if(piece_collides(p,p->piecex,p->piecey)) {
    //game_over();
    p->loser=1;
  }

  if(!gameover)
    piece_drawnext(p,1);
}

static void pgoto_normal(player_t *p) {
  p->status=S_NORMAL;
  player_givepiece(p);
}

static int player_init(player_t *p, int pn) {
  int x,y;
  
  p->number=pn;
  
  p->score=0;
  
  p->board=malloc_verify((board_y_size+5)*board_x_size);
  if(!(p->board)) return 0;
  
  p->bflags=malloc_verify((board_y_size+5)*board_x_size);
  if(!(p->bflags)) return 0;
  
  /* clear game board */
  for(y=0;y<board_y_size+3;y++)
    for(x=0;x<board_x_size;x++) {
      p->board[y*board_x_size+x]=0;
      p->bflags[y*board_x_size+x]=0;
    }  
      
  p->piece_dropping=0;
  
  p->explode_frames=-1; /* nothing exploding right now */
  p->fall_pix=-1;    /* nothing falling */
  p->fall_frac=0;
  p->rise_pix=-1;    /* and we're not raising */
  p->rise_frac=0;
  
  p->status=S_NORMAL;
  
  p->rows2rise=0;
  p->loser=0;
  
  p->particles=NULL;
  p->gboomy=board_y_size-1;
  p->gttb=gboomdelay;
  
  p->chain=-1;
  p->lines[0]=0;
  p->lines[1]=0;
  p->lines[2]=0;
      
  return 1; 
}

static void player_done(player_t *p) {
  free(p->board);
  free(p->bflags);
}

static void game_level_init(void) {
  blocksleft+=35+5*level;
  piece_spd=board_y_pix_size/framerate/(30/(level+2));
  piece_spd_drop=board_y_pix_size/framerate/0.80;
  if(piece_spd>piece_spd_drop) piece_spd_drop=piece_spd;
  
  lnumframes=framerate*3; /* show for 3 seconds */
  bgnumframes=framerate*2; /* display ater 2 seconds */
}

static void blocks_sub(int num) {
  if(players==1) {
    blocksleft-=num;
    while(blocksleft<=0) {  /* advance level */
      if(level<99) level++; /* I DOUBT anybody will get to the level 99,
                               but I don't take any risks */
	else game_over(); /* otherwise end the game and congratulate the player */
      bg_done();
      game_level_init();
      bg_init(level);
      
      DEBUG1(printf("bg_init(level=%d)\n",level));
    }
  }
}

/*
  Add one row to the bottom of ones playfield.
  
  The trick is that this row contains random tiles,
  but must not trigger any explosions.
*/
static void player_rise(player_t *p) {
  int x,y;
  int i,t,nsuit;
  float fnsuit;
  int suits[MAX_PIECE_TYPES];
  
//  suits = malloc_verify(sizeof(int)*(piecetypes+1));
  
  for(y=board_y_size-1;y>0;y--)
    for(x=0;x<board_x_size;x++)
      p->board[y*board_x_size+x]=p->board[(y-1)*board_x_size+x];
 
  for(i=1;i<=piecetypes;i++) suits[i]=1;    
  suits[(int)p->board[board_x_size+board_x_center-1]]=0;
  suits[(int)p->board[board_x_size+board_x_center  ]]=0;
  suits[(int)p->board[board_x_size+board_x_center+1]]=0;
      
  nsuit=0;
  for(i=1;i<=piecetypes;i++) if(suits[i]) nsuit++;
      
  t=1; 
  fnsuit=nsuit;
  x=randint(0,fnsuit);  // 0 ..fnsuit-1
  while(!suits[t]) t++;
  for(i=0;i<x;i++) {
    t++;
    while(!suits[t]) t++;
  }
  p->board[board_x_center]=t;
  
  /* The center square -1 */  
  for(i=1;i<=piecetypes;i++) suits[i]=1;
  suits[(int)p->board[board_x_size+board_x_center-1  ]]=0;
  suits[(int)p->board[board_x_size+board_x_center-1+1]]=0;    
  suits[(int)p->board[             board_x_center-1+1]]=0;
    
  nsuit=0;for(i=1;i<=piecetypes;i++) if(suits[i]) nsuit++;
      
  t=1;
  fnsuit=nsuit;
  x=randint(0,fnsuit);  // 0 ..fnsuit-1
  while(!suits[t]) t++;
  for(i=0;i<x;i++) {
    t++;
    while(!suits[t]) t++;
  }
  p->board[board_x_center-1]=t;
  
  /* The center square +1 */  
  for(i=1;i<=piecetypes;i++) suits[i]=1;
  suits[(int)p->board[board_x_size+board_x_center+1-1]]=0;
  suits[(int)p->board[board_x_size+board_x_center+1  ]]=0;    
  suits[(int)p->board[             board_x_center+1-1]]=0;
    
  nsuit=0;for(i=1;i<=piecetypes;i++) if(suits[i]) nsuit++;
      
  t=1; //x=rand()%nsuit;
  fnsuit=nsuit;
  x=randint(0,fnsuit);  // 0 ..fnsuit-1
  while(!suits[t]) t++;
  for(i=0;i<x;i++) {
    t++;
    while(!suits[t]) t++;
  }
  p->board[board_x_center+1]=t;  
  
  /* The left square */  
  for(i=1;i<=piecetypes;i++) suits[i]=1;
  suits[(int)p->board[board_x_size  ]]=0;
  suits[(int)p->board[board_x_size+1]]=0;    
  suits[(int)p->board[            +1]]=0;
    
  nsuit=0;for(i=1;i<=piecetypes;i++) if(suits[i]) nsuit++;
      
  t=1;
  fnsuit=nsuit;
  x=randint(0,fnsuit);  // 0 ..fnsuit-1
  while(!suits[t]) t++;
  for(i=0;i<x;i++) {
    t++;
    while(!suits[t]) t++;
  }
  p->board[board_x_center-2]=t;
    
  
  /* The right square */  
  for(i=1;i<=piecetypes;i++) suits[i]=1;
  suits[(int)p->board[board_x_size+4-1]]=0;
  suits[(int)p->board[board_x_size+4  ]]=0;    
  suits[(int)p->board[             4-1]]=0;
    
  nsuit=0;for(i=1;i<=piecetypes;i++) if(suits[i]) nsuit++;
      
  t=1;
  fnsuit=nsuit;
  x=randint(0,fnsuit);  // 0 ..fnsuit-1
  while(!suits[t]) t++;
  for(i=0;i<x;i++) {
    t++;
    while(!suits[t]) t++;
  }
  p->board[board_x_center+2]=t;  
  
//  free(suits);  
}

static void player_checkrows2rise(player_t *p) {
  if(p->rows2rise>0) {
    player_rise(p);
    p->rise_pix+=box_y_size;
    p->rise_frac=1;
  
    p->rows2rise--;
    p->status=S_RISE;
  } else pgoto_normal(p);
}

static void piece_shift_up(player_t *p) {
  char tmp;
  
  tmp        =p->p_cur[2];
  p->p_cur[2]=p->p_cur[1];
  p->p_cur[1]=p->p_cur[0];
  p->p_cur[0]=tmp;
  
}

static void piece_shift_down(player_t *p) {
  char tmp;
  
  tmp        =p->p_cur[0];
  p->p_cur[0]=p->p_cur[1];
  p->p_cur[1]=p->p_cur[2];
  p->p_cur[2]=tmp;

}

static int less_num(int a, int b) {
  return (a<b)?a:b;
}

static int player_checkexplosions_line(player_t *p, 
  int x0, int y0, int dx, int dy, int len) {
  int i=0,anyboom=0,n,b;
  
  while (i<len) {
      n=1;
      if(p->board[(y0+i*dy)*board_x_size+x0+i*dx] != 0) {
        while ( (i+n < len) &&
	     (p->board[(y0+(i+n)*dy)*board_x_size+x0+(i+n)*dx]
             ==p->board[(y0+i*dy)*board_x_size+x0+i*dx])) n++;
      }     
      if(n>=3) {
        for(b=0;b<n;b++) {
	  p->bflags[(y0+(i+b)*dy)*board_x_size+x0+((i+b)*dx)] = BF_BLOW;
	}
	anyboom=1;
	p->lines[n-3]++;
      }
      i+=n;
    }
  return anyboom;
}

static int player_checkexplosions(player_t *p) {
  int i,anyboom=0;
  int oldscore;
  
  /* rows */
  for(i=0;i<board_y_size;i++) {
    anyboom |= player_checkexplosions_line(p,0,i,1,0,board_x_size);
  }
  
  /* columns */
  for(i=0;i<board_x_size;i++) {
    anyboom |= player_checkexplosions_line(p,i,0,0,1,board_y_size);
  }
  
  /* "/" diagonal */
  for(i=board_x_size-1;i>0;i--) {
    anyboom |= player_checkexplosions_line(p,i,0,1,1,
      less_num(board_x_size-i,board_y_size));
  }
  for(i=0;i<board_y_size;i++) {
    anyboom |= player_checkexplosions_line(p,0,i,1,1,
      less_num(board_x_size,board_y_size-i));
  }
  
  /* "\" diagonal */
  for(i=board_x_size-1;i>0;i--) {
    anyboom |= player_checkexplosions_line(p,i,board_y_size-1,1,-1,
      less_num(board_x_size-i,board_y_size));
  }
  for(i=board_y_size-1;i>=0;i--) {
    anyboom |= player_checkexplosions_line(p,0,i,1,-1,
      less_num(board_x_size,i+1));
  }
  
    
  if(anyboom) {
    p->explode_frames=0.25*framerate;
    p->status=S_BLOW;
    p->chain++;
  } else {
    oldscore= p->score;
    p->status=S_CHECKR;
    p->rise_pix=-1;
    if(players==2 && p->chain>0) player[1-(p->number)].rows2rise+=p->chain;
    if(p->chain>0) p->score+=p->chain*1000;
    p->score+=(p->lines[0]*500)+(p->lines[1]*1000)+(p->lines[2]*1500);
    if(players==1 && oldscore!=p->score) {
      //game_draw();
      game_drawscore(p,1);
    }
  }    
  return anyboom;
}

static void player_fixpiece(player_t *p) {
  int i;
  
  if(p->piecey+2>=board_y_size) {
    //game_over();
    p->loser=1;
  }
  
  for(i=0;i<3;i++) {
    p->board[(p->piecey + i)*board_x_size+(p->piecex)] 
      = p->p_cur[i];
  }
  if(!gameover) {
    p->status=S_CHECKX;  
    p->chain=-1;
    p->lines[0]=0;
    p->lines[1]=0;
    p->lines[2]=0;
  }
}

static void board_clearflags(player_t *p) {
  int x,y;
  
  for(y=0;y<board_y_size;y++)
    for(x=0;x<board_x_size;x++)
      p->bflags[y*board_x_size+x]=0;
}

static void player_spawnparticles(player_t *p, int x, int y) {
  int i;
  for(i=0;i<2;i++) {
    p->particles=particle_create(p->particles, x*box_x_size,y*box_y_size,
				randfloat(-maxdefspd,2*maxdefspd),
				randfloat(-maxdefspd,2*maxdefspd),
				0,no_of_particle_frames-1);
  }
}

static void player_blow(player_t *p) {
  int x,y,oldlevel,oldscore,oldblocks,anyblow=0;
  
  oldlevel=level;
  oldscore=p->score;
  oldblocks=blocksleft;
  
  for(y=0;y<board_y_size;y++) {
    for(x=0;x<board_x_size;x++) {
      if(p->bflags[y*board_x_size+x]!=0) {
        if(p->bflags[y*board_x_size+x]==BF_BLOW) {
          p->board[y*board_x_size+x]=0;
	  blocks_sub(1);
	  player_spawnparticles(p,x,y);
	  anyblow=1;
        }
	p->bflags[y*board_x_size+x]=0;
      }
    }
  }
  if(players==1) {
/*    if(level!=oldlevel || p->score!=oldscore || blocksleft!=oldblocks) {

      game_draw();
      
    }*/
    if(p->score!=oldscore) {
      game_drawscore(p,1);
    }
    if(level!=oldlevel) {
      game_drawlevelnum(1);
    }
    if(blocksleft!=oldblocks) {
      game_drawblocksleft(1);
    }
  }
  if(anyblow) sound_fx(FX_BLOW);    
}

static void player_checkfall(player_t *p) {
  int x,y,anyfall=0;  
  
  for(y=1;y<board_y_size;y++) {
    for(x=0;x<board_x_size;x++) {
      if ((p->board[y*board_x_size+x]!=0)
        && (p->board[(y-1)*board_x_size+x]==0)) {
	
	  p->board[(y-1)*board_x_size+x]=p->board[y*board_x_size+x];
	  p->board[y*board_x_size+x]=0;
          p->bflags[(y-1)*board_x_size+x]=BF_FALL;
	  anyfall=1;
      }
    }
  }
  if(anyfall) {
    //p->fall_pix=box_y_size-1;
    p->status=S_FALL;
  } else {
    p->status=S_CHECKX;
  }
}



static void player_updatepiece(player_t *p) {
  if(!gameover)
    p->pieceyfrac -= (p->piece_dropping ? piece_spd_drop : piece_spd);
    
  while (p->pieceyfrac < 0.0) {
    p->pieceypix--;
    p->pieceyfrac+=1.0;
  }
  while (p->pieceypix < 0) {
    if (piece_collides(p,p->piecex,p->piecey-1)) {
      player_fixpiece(p);
      sound_fx(FX_HIT);
      return;
    } else {
      //p->score++;
      p->piecey--;
      p->pieceypix+=box_y_size;
    }  
  }
  turndone=1;
}

static void player_updateblow(player_t *p) {
  p->explode_frames--;
  if(p->explode_frames<0) {
    player_blow(p);
    p->status=S_CHECKF;
    p->fall_pix=box_y_size-1;
  }
  turndone=1;
}

static void player_updatefall(player_t *p) {
  p->fall_frac-=fall_spd;
  while (p->fall_frac < 0.0) {
    p->fall_pix--;
    p->fall_frac+=1.0;
  }
  if(p->fall_pix<=0) {
    p->status=S_CHECKF;
    p->fall_pix+=box_y_size;
    board_clearflags(p);
  }
  turndone=1;
}

static void player_updaterise(player_t *p)
{
  p->rise_frac-=rise_spd;
  while (p->rise_frac < 0.0) {
    p->rise_pix--;
    p->rise_frac+=1.0;
  }
  if(p->rise_pix<=0) {
    p->status=S_CHECKR;
  }
  turndone=1;    
}

static void player_updateparticles(player_t *p) {
  p_list_t *tmp, *pp=p->particles, *last=NULL;
  int something,xsize;
  
  while(pp) {
    pp->fr_age+= 1/framerate;
    while(pp->fr_age>particle_frame[pp->frame].delay) {
      pp->frame--;
      pp->fr_age=0;
    }
    pp->x += pp->vx*(1/framerate);
    xsize=particle_frame[pp->frame].bmp.xs;
    do {
      something=0;
      if(pp->vx<0  &&  pp->x < 0) {
        pp->vx= -pp->vx;
        pp->x = -pp->x;
	something=1;
      }
      if(pp->vx>0  &&  pp->x > board_x_pix_size-xsize) {
        pp->vx= -pp->vx;
        pp->x = (board_x_pix_size)-(pp->x+xsize-(board_x_pix_size))-xsize;
	something=1;
      }
    } while(something);
    
    pp->vy -= gravity*(1/framerate);
    pp->y += pp->vy*(1/framerate);
    
    if(pp->y < 0 || pp->frame<0) {
      tmp=pp->next;
      if(last) last->next=tmp; else p->particles=tmp;
      free(pp);
      pp=tmp;
    } else {
      last=pp;
      pp=pp->next;
    }
  }
}

static void player_blowline(player_t *p, int y) {
  int x;
  
  for(x=0;x<board_x_size;x++) {
    if(p->board[y*board_x_size+x]>0) {
      player_spawnparticles(p,x,y);
      p->board[y*board_x_size+x]=0;
      p->bflags[y*board_x_size+x]=0;
    }
  }
}

static void player_update(player_t *p) {
  player_updateparticles(p);
  
  /* blowing the blocks line by line, when game over */
  if(p->loser && p->gboomy>=0) {
    p->gttb -= 1/framerate;
    while(p->gttb<0) {
      player_blowline(p,p->gboomy--);
      p->gttb += gboomdelay;
    }
  }
  do {
    //if(gameover) return;
    turndone=0;
    switch(p->status) {
      case S_NORMAL: player_updatepiece(p); break;
      case S_CHECKX: player_checkexplosions(p); break;
      case S_BLOW:   player_updateblow(p); break;
      case S_CHECKF: player_checkfall(p); break;
      case S_FALL:   player_updatefall(p); break;
      case S_CHECKR: player_checkrows2rise(p); break;
      case S_RISE:   player_updaterise(p); break;
    }
  } while (!turndone);
}

/*
  Make a screenshot and save it to blockrage-scr.pcx in the
  $HOME directory. If HOME is not set, save it to the working
  directory.
*/
static void make_screenshot(void) {
  char *home;
  char *fpathname;
  char *fname = "blockrage-scr.pcx";
  int home_l;
  
  home = getenv("HOME");
  home_l = strlen(home);
  
  if(home_l > SANE_PATH_LEN) {
    fprintf(stderr,"HOME length is not sane\n");
    home=NULL;
  }
  
  if(!home) {
    fputs("Saving screenshot to ./blockrage-scr.pcx\n",stdout);
    pcx_save(scr_x_size,scr_y_size,vscr,mypal, "./blockrage-scr.pcx");
  } else {
    fpathname = malloc_verify(home_l+1+strlen(fname)+1);
    strncpy(fpathname,home,home_l);
    fpathname[home_l]=0;
    cat_with_slash(fpathname,fname);
    
    printf("Saving screenshot to %s\n",fpathname);
    pcx_save(scr_x_size,scr_y_size,vscr,mypal, fpathname);
    
    free(fpathname);
  }
}

static int global_key_hnd(int sym, int mod, int press) {
  mod = mod & ~(KMOD_CAPS|KMOD_NUM);
  if(press && mod == KMOD_LALT) {
    switch(sym) {
      case SDLK_x:
        quit=1;
	return 0;
	
      case SDLK_RETURN:
        gfx_set_fullscreen(!gfx_get_fullscreen());
	virt_cpy();
	return 0;

      case SDLK_BACKSLASH:
        gfx_set_doublesize(!gfx_get_doublesize());
	virt_cpy();
	return 0;

      default:
        break;
    }
  }

  if(press) {
    switch(sym) {
      case SDLK_PRINT:
        make_screenshot();
	return 0;

      default:
        break;
    }
  }
    
  return 1;
}

static void key_handler(int scancode, int press) {
  int i;
  
 // printf("[KP:%d,%d]",scancode,press);
  if(scancode>=KSTAT_SIZE) return;         /* error! */
  keyboard_state[scancode]=press;
  
  if(!gameover && !paused) {
    for(i=0;i<players;i++) {
      if(scancode==key_left[i] && press) {
        if(!piece_collides(&(player[i]),player[i].piecex-1,player[i].piecey)) {
          if(player[i].piecex>0) player[i].piecex--;
        }
      }  
      if(scancode==key_right[i] && press) {
        if(!piece_collides(&(player[i]),player[i].piecex+1,player[i].piecey)) {
          if(player[i].piecex+1<board_x_size) player[i].piecex++;
        } 
      }
      if(scancode==key_shift_up[i] && press)
        piece_shift_up(&(player[i]));
      if(scancode==key_shift_down[i] && press)
        piece_shift_down(&(player[i]));  
      if(scancode==key_drop[i])
        player[i].piece_dropping = !!press;
    }
  }
  if(scancode==key_quit && press) {
    if(gameover) endgame=1;		/* go to main menu */
      else pausemenu=1;			/* show the pause-menu */
  }
  if(scancode==SDLK_1 && press) sound_fx(0); 
  if(scancode==SDLK_2 && press) sound_fx(1);
  if(scancode==SDLK_3 && press) sound_fx(2);
  if(scancode==SDLK_4 && press) sound_fx(3);
  if(scancode==SDLK_5 && press) sound_fx(4);
  if(scancode==SDLK_6 && press) sound_fx(5);
  if(scancode==SDLK_7 && press) sound_fx(6);
  if(scancode==SDLK_8 && press) sound_fx(7);
  if(scancode==SDLK_9 && press) sound_fx(8);
  if(scancode==SDLK_0 && press) sound_fx(9);
  
//  if(scancode==SDLK_PRINT && press) make_screenshot();
  
  if(scancode==SDLK_p && press) {
    if(!gameover) {
      paused ^=1;
      if(paused) {
        game_draw();
      }
    }
  }
}

static void input_update(void) {
  int code, press;
  
  while(key_get(&code,&press)!=0) {
    key_handler(code,press);
  }
}

static int game_init(void) {
  int i;
  
  DEBUG2(printf("running game_init\n");)
  
  level=startinglevel;
  blocksleft=0;
  
  lnumframes=0;
  gboomdelay=0.1; /* in secs */
  
  paused=0;
  
  board_bottom[0]=board_top[0]+(board_y_size-1)*box_y_size;
  board_bottom[1]=board_top[1]+(board_y_size-1)*box_y_size;
  board_bottom[2]=board_top[2]+(board_y_size-1)*box_y_size;
  
  board_x_pix_size=board_x_size*box_x_size;
  board_y_pix_size=board_y_size*box_y_size;
  
  /* the number equals the time it takes for the piece to fall
     from the top to the bottom (in seconds) */ 
  rise_spd = board_y_pix_size/framerate/2.00;
  fall_spd = board_y_pix_size/framerate/2.00;
  
  dispframenum=0; /* init displayed frames' counter */
  framenum=0;
  
  game_level_init();
  
  player[1].loser=0;
  for(i=0;i<players;i++) {
    if(!player_init(&(player[i]),i)) {
      DEBUG1(printf("game_init failed on player_init\n");)
      return 0;
    }
  }    
  
  for(i=0;i<players;i++) {
    player_givepiece(&(player[i]));
    player_givepiece(&(player[i]));
  }
  
  bg_init(level);
  DEBUG1(printf("bg_init(level=%d)\n",level));
  
//  printf("time_init\n");
  
  time_init();
  
 // printf("game_i done\n");
  
  return 1;
}

static void game_deinit(void) {
  int i;
  
  bg_done();
  
  for(i=0;i<players;i++)
    player_done(&(player[i]));
}



void pieces_anim_update(void) {
  int i;
  
  for(i=0;i<P_PER_S;i++) {
    p_timeleft[i] -= 1/framerate;
    if(p_timeleft[i]<0) {
      p_curframe[i]++;
      if(p_curframe[i]>=piece[setn*P_PER_S+i].frames) p_curframe[i]=0;
      p_timeleft[i] += piece[setn*P_PER_S+i].delay.data[p_curframe[i]];
    }
  }
}


static int piece_readinfo(char *name, int *frames, flp_t *delay) {
  FILE *f;
  int i;

  f = file_open(name,"rb");
  if(!f) {
    fprintf(stderr,"blockrage: cannot open %s in data dir\n",name);
    return 0;
  }
  
  fscanf(f,"%d",frames);
  delay->data=calloc_verify(*frames,sizeof(float));
  
  for(i=0;i<*frames;i++) {
    fscanf(f,"%f",&(delay->data[i]));
  }
  
  fclose(f);
  return 1;
}

void screen_setpal(void) {
#ifdef DIRECT_COLOR
  int i;
  unsigned rv,gv,bv;
  
  for(i=0;i<256;i++) {
    rv=mypal[3*i]>>1;
    gv=mypal[3*i+1];
    bv=mypal[3*i+2]>>1;
    mypalx[i]=bv|(gv<<5)|(rv<<11);
  }
#else
  gfx_setpalette(mypal,0,256);
#endif
}

static int screen_init(void) {
  int i,j;
  char s[30];
  bmp_t tempbmp;
  int ok;
  
  if(!gfx_init()) return 0;
  vscr=malloc_verify(scr_x_size*scr_y_size*sizeof(pix_t));
  bground=calloc_verify(board_x_size*box_x_size*board_y_size*box_y_size,sizeof(pix_t));
  
  if(!(mypal=pal_load("game.col"))) return 0;
  screen_setpal();
    
  ok =       pcx_load(&bmp_menu,"menu.pcx");
  ok = ok && pcx_load(&bmp_pmenu,"pmenu.pcx");
  ok = ok && pcx_load(&bmp_game[0],"g1p.pcx");
  ok = ok && pcx_load(&bmp_game[1],"g2p.pcx");
  ok = ok && pcx_load(&bmp_intro,"logo.pcx");
  
  if(!ok) return 0;
  
  piece=calloc_verify(no_of_sets*P_PER_S,sizeof(piece_t));
  
  for(j=0;j<no_of_sets;j++) {
    for(i=0;i<P_PER_S;i++) {
      sprintf(s,"s%02dp%d.pcx",j,i+1);
      if(!pcx_load(&tempbmp,s)) return 0;
      piece[j*P_PER_S+i].bmp=tempbmp.data;
      piece[j*P_PER_S+i].key_color = tempbmp.key_color;
      sprintf(s,"s%02dp%d.txt",j,i+1);
      if( !piece_readinfo(s,&(piece[j*P_PER_S+i].frames),
        &(piece[j*P_PER_S+i].delay) ) ) return 0;
    }
  }
  
  /* init frame counters for the pieces */
  for(i=0;i<P_PER_S;i++) {
    p_curframe[i]=0;
    p_timeleft[i]=piece[setn*P_PER_S+i].delay.data[0];
  }
  
  /* load particle bitmaps */
  for(i=0;i<no_of_particle_frames;i++) {
    sprintf(s,"pa%d.pcx",i);
    DEBUG2(printf("reading %s\n",s);)
    if(!pcx_load(&particle_frame[i].bmp,s)) return 0;
  }
  
  if(!font_load("fonth",&(font[FONT_HIGHLIGHTED])))
    return 0;
  
  if(!font_load("fontn",&(font[FONT_NORMAL])))
    return 0;

  return 1;
}

static void screen_deinit(void) {
//  free(bmp_piece);
  gfx_deinit();
}

static int init(void) {
  /* sound MUST be initialised BEFORE video (because this forks a child
     process */
  if(!sound_init()) {
    /* we can live even without this */
    fprintf(stderr,"sound could not be initialised.\n");
  } 
  if(!screen_init()) return 0;
  if(!input_init(global_key_hnd)) return 0;
  topten_load();
  return 1;
}

static void deinit(void) {
  DEBUG1(printf("sound_done()...\n"));
  sound_done();
  DEBUG1(printf("input_deinit()...\n"));
  input_deinit();
  DEBUG1(printf("screen_deinit()...\n"));
  screen_deinit();
}

void pieces_checkfnum(void) {
  int i;
  
  for(i=0;i<6;i++) {
    p_curframe[i] %= piece[setn*P_PER_S].frames;
    p_timeleft[i]=piece[setn*P_PER_S].delay.data[p_curframe[i]];
  }
}

void game(void) {
  int i,turns=1;
  
  endgame=0; gameover=0; pausemenu=0;
  
  if(!game_init()) return;
 
  game_draw();
  
  while (!endgame && !quit) {
    if(turns<=1) {
      if(dbackground && bgnumframes==0) bg_update();
      for(i=0;i<players;i++) {
        board_draw(&(player[i]),paused,1);
	
	if(!paused) piece_drawnext(&(player[i]),0);
      }
      dispframenum++;
    }
    framenum+=turns;
    if(!paused) {
      for(i=0;i<players;i++) {
        player_update(&(player[i]));
      }
      if(player[0].loser || player[1].loser) game_over();
    }
    
    pieces_anim_update();
    
    input_update();
    
    //sound_update();
    
    if(lnumframes>0) lnumframes--;
    if(bgnumframes>0) bgnumframes--;
    
    while (!(turns=is_next_turn()))
      SDL_Delay(SLEEP_MS);
    
    if(pausemenu) {
      pause_menu();
      game_draw();
    }
  }
  game_deinit();
  if(players==1) {
    if(topten_update(player[0].score)) {
      topten();
    };
  }
}


static int process_args(int argc,char *argv[]) {
  int i=1,j,res;
 
  while (i<argc) {

    if(strcmp(argv[i],"+p")==0) {

      if(i>=argc) {
        fprintf(stderr,"missing value\n");
        return 0;
      }
      i++;
      res=sscanf(argv[i],"%d",&players);
      if(res==1 && players>=1 && players<=2) {
        immedstart=1;
      }
      else {
        fprintf(stderr,"Wrong # of players param %d '%s'\n",i,argv[i]);
	return 0;
      }
    } else
    if(strcmp(argv[i],"+d")==0) {

      if(i>=argc) {
        fprintf(stderr,"missing value\n");
        return 0;
      }
      i++;
      res=sscanf(argv[i],"%d",&piecetypes);
      if(res!=1 || piecetypes<MIN_PIECE_TYPES || piecetypes>MAX_PIECE_TYPES) {
        fprintf(stderr,"Wrong difficulty #(must be %d-%d) param %d '%s'\n",
	  MIN_PIECE_TYPES,MAX_PIECE_TYPES,i,argv[i]);
	return 0;
      }
    } else
    if(strcmp(argv[i],"+l")==0) {

      if(i>=argc) {
        fprintf(stderr,"missing value\n");
        return 0;
      }
      i++;
      res=sscanf(argv[i],"%d",&startinglevel);
      if(res==1 && startinglevel>=1 && startinglevel<=10) {
        ;
      }
      else {
        fprintf(stderr,"Wrong startinglevel #(must be 1-10) param %d '%s'\n",i,argv[i]);
	return 0;
      }
    } else
    if(strcmp(argv[i],"+b")==0) {

      if(i>=argc) {
        fprintf(stderr,"missing value\n");
        return 0;
      }
      i++;
      res=sscanf(argv[i],"%d",&setn);
      if(res==1 && setn>=0) {
        ;
      }
      else {
        fprintf(stderr,"Wrong blockset #(must be >=0) param %d '%s'\n",i,argv[i]);
	return 0;
      }
    } else
    if(strcmp(argv[i],"+k1")==0 || strcmp(argv[i],"+k2")==0) {
      j=argv[i][2]-'1'; // player's number ( 0 / 1 )

      if(i+4>=argc) {
        fprintf(stderr,"missing value\n");
        return 0;
      }
      
      res=1;
      res*=sscanf(argv[++i],"%d",&key_left[j]);
      res*=sscanf(argv[++i],"%d",&key_right[j]);
      res*=sscanf(argv[++i],"%d",&key_shift_up[j]);
      res*=sscanf(argv[++i],"%d",&key_shift_down[j]);
      res*=sscanf(argv[++i],"%d",&key_drop[j]);
      if(res!=1) {
        fprintf(stderr,"Wrong keys for player 1 (param %d \"%s\")\n",i,argv[i]);
	return 0;
      }
      
    }
    else if(strcmp(argv[i],"+data")==0) {

      if(i>=argc) return 0;
      i++;
      if(strlen(argv[i])<=32) {
        strcpy(dataset,argv[i]);
      } else {
        fprintf(stderr,"dataset name too long\n");
	return 0;
      }
    }
    else if(strcmp(argv[i],"+a8")==0) {
      sound_cfg_8bit();
    }
    else {
      fprintf(stderr,"Wrong param #%d '%s'\n",i,argv[i]);
      return 0;
    }
    i++;
  }
  return 1;
}

static int dataconfig_read(void) {
  FILE *f;
  int i;
  
  f = file_open("dataset.cfg","rb");
  if(!f) {
    fprintf(stderr,"blockrage: cannot open dataset.cfg in data dir\n");
    return 0;
  }
  
  fscanf(f,"%d %d",&scr_x_size,&scr_y_size);
  fscanf(f,"%d %d",&box_x_size,&box_y_size);
  
  fscanf(f,"%d %d %d",&board_left[0],&board_left[1],&board_left[2]);
  fscanf(f,"%d %d %d",&board_top[0],&board_top[1],&board_top[2]);

  fscanf(f,"%d %d %d %d %d %d",&nx_t_x0[0],&nx_t_y0[0],
  &nx_t_x0[1],&nx_t_y0[1],&nx_t_x0[2],&nx_t_y0[2]);
  
  fscanf(f,"%d %d %d %d %d %d",&nx_x0[0],&nx_y0[0],
  &nx_x0[1],&nx_y0[1],&nx_x0[2],&nx_y0[2]);
  
  fscanf(f,"%d %d %d %d",&statx[0],&staty[0],&statx[1],&staty[1]);
  fscanf(f,"%d %d %d %d",&statx[2],&staty[2],&statx[3],&staty[3]);
  fscanf(f,"%d %d %d %d",&statx[4],&staty[4],&statx[5],&staty[5]);
  
  fscanf(f,"%d %d",&diffx,&diffy);
  fscanf(f,"%d %d",&ts_x0,&ts_x1);
  
  fscanf(f,"%d",&no_of_sets);
  
  
  fscanf(f,"%f %f",&gravity,&maxdefspd);
  fscanf(f,"%d",&no_of_particle_frames);

  particle_frame=calloc_verify(no_of_particle_frames,sizeof(frame_t));
  
  for(i=0;i<no_of_particle_frames;i++)
    fscanf(f,"%f",&(particle_frame[i].delay));
  
 /* printf("%d %d\n%d %d\n%d %d %d\n%d %d %d\n%d %d %d %d %d %d\n",
  scr_x_size,scr_y_size,
  box_x_size,box_y_size,
  board_left[0],board_left[1],board_left[2],
  board_top[0],board_top[1],board_top[2],
  nx_x0[0],nx_y0[0],nx_x0[1],nx_y0[1],nx_x0[2],nx_y0[2]);*/

  fclose(f);
  
  return 1;
}

static void keys_default(void) {
  
  key_left[0]=SDLK_LEFT;
  key_right[0]=SDLK_RIGHT;
  key_drop[0]=SDLK_RSHIFT;
  key_shift_up[0]=SDLK_UP;
  key_shift_down[0]=SDLK_DOWN;
  key_left[1]=SDLK_a;
  key_right[1]=SDLK_d;
  key_drop[1]=SDLK_q;
  key_shift_up[1]=SDLK_w;
  key_shift_down[1]=SDLK_s;
}

static char *fget_rc_line(FILE *f) {
  char *buf;
  int buf_size;
  int c;
  int buf_pos;
  char *home;
  int home_l;
  
  buf_size=64;
  buf_pos=0;
  
  buf=malloc_verify(buf_size);
  
  while(1) {
    c = fgetc(f);
    if(c==EOF || c=='\n') break;
    
    if(!buf_pos && c=='~') {
      /* tilde expansion */
      home=getenv("HOME");
      if(!home) {
        fprintf(stderr,"error: HOME environment variable is not set.\n");
	return NULL;
      }
      home_l = strlen(home);
      if(home_l+1>buf_size) {
        buf_size=home_l+1;
	buf=realloc_verify(buf, buf_size);
      }
      buf_pos=home_l;
      strncpy(buf,home,home_l);
    } else {
    
      if(buf_pos+1>=buf_size) {
        buf_size = 2*buf_size;
        buf = realloc(buf, buf_size);
        if(!buf) return NULL;
      }
      buf[buf_pos++]=c;
    }
  }
  buf[buf_pos]=0;
  
  return buf;
}

/*
  Load the blockrage.rc file containing paths to Block Rage files
  and directories
*/
static int rc_load(char *fname) {
  FILE *f;
  char *tmp;

  if((f=fopen(fname,"rt"))==NULL) return 0;
  sys_config_file = fget_rc_line(f);
  usr_config_file = fget_rc_line(f);
  datadir = fget_rc_line(f);
  topten_file = fget_rc_line(f);
  tmp = fget_rc_line(f);
  if(strlen(tmp)>32) {
    fprintf(stderr,"rc_load(): dataset name too long\n");
    return 0;
  }
  if(tmp) {
    strcpy(dataset,tmp);
    free(tmp);
  }
  fclose(f);
  
  if(!datadir || !topten_file) return 0;
  
  return 1;
}

/*
  Find a rc file in one of the possible locations and load it.
  Returns 1 on success, 0 on failure.
*/
static int rc_find_load(void) {
  int rc_loaded;
  char *home;
  char *fpathname;
  char *frelname = ".blockrage/blockrage.rc";
  int home_l;
  
  rc_loaded = rc_load("./blockrage.rc");
  if(!rc_loaded) {
    home = getenv("HOME");
    home_l = strlen(home);
    if(home_l > SANE_PATH_LEN) {
      fprintf(stderr,"Length of HOME is not sane\n");
      home=NULL;
    }
    if(home) {
      fpathname = malloc_verify( home_l + 1 + strlen(frelname) + 1);
      strncpy(fpathname,home,home_l);
      fpathname[home_l]=0;
      cat_with_slash(fpathname,frelname);
      
      rc_loaded=rc_load(fpathname);
      
      free(fpathname);
    }
  }
  if(!rc_loaded) {
    rc_loaded=rc_load(SYSCONFDIR "/blockrage.rc");
  }
  if(!rc_loaded) {
    fprintf(stderr,"cannot open any rc file, including %s\n",SYSCONFDIR "/blockrage.rc");
  }
  return rc_loaded;
}

static int config_load(char *fname) {
  FILE *f;
  int v1,v2,v3;
  int cfg_fs,cfg_ds;

  if((f=fopen(fname,"rt"))==NULL) return 0;
  fscanf(f,"%d %d %d\n",&v1,&v2,&v3);
  if(v1!=VER1 || v2!=VER2 || v3!=VER3) {
    fclose(f);
    return 0;
  }
  
  fscanf(f,"%d%d%d%d%d",&piecetypes,&startinglevel,&setn,&dbackground,
         &showintro);
  fscanf(f,"%d%d%d%d%d",&key_left[0],&key_right[0],&key_drop[0],
    &key_shift_up[0],&key_shift_down[0]);
  fscanf(f,"%d%d%d%d%d\n",&key_left[1],&key_right[1],&key_drop[1],
    &key_shift_up[1],&key_shift_down[1]);
    
  fscanf(f,"%d%d\n",&cfg_fs,&cfg_ds);
  gfx_set_fullscreen(cfg_fs);
  gfx_set_doublesize(cfg_ds);
  fclose(f);
    
  return 1;
}

/*
  Create a directory
*/
static int make_dir(char *fname, int mode) {
#ifdef _WIN32
  return mkdir(fname);
#else
  return mkdir(fname,mode);
#endif
}

/*
  Create any nonexistent directories in the file's path.
*/
static int make_pdir(char *fname) {
  char *p;
  int len;
  char *buf;
  int res;
  
  printf("make_pdir('%s');\n",fname);
  
  buf = NULL;
  
  p= strrchr(fname,'/');
  if(!p) return 0;
  
  len=p-fname;
  if(!len) return 0;
  buf=malloc_verify(len+1);
  strncpy(buf,fname,len);
  buf[len]=0;
  
  res = 1;
  
  printf("try mkdir('%s')\n",buf);
  if(make_dir(buf,0755)<0 && errno==ENOENT) {
    /* Probably neither the parent of this directory exists.
       Make it recursively. (Do some memory wasting...) */
    if(make_pdir(buf)==0) {
      res=0;
    } else {
      if(make_dir(buf,0755)<0)
        res=0;
    }
  }
  free(buf);
  return res;
}

static int config_save(char *fname) {
  FILE *f;
  
  if((f=fopen(fname,"wt"))==NULL) {
    /* Maybe we need to create some directories in which
       the file resides */
    if(errno==ENOENT) {
      if(!make_pdir(fname)) {
        return 0;
      } else {
        f=fopen(fname,"wt");
	if(!f) return 0;
      }
    }
  }
  
  fprintf(f,"%d %d %d\n",VER1,VER2,VER3);
  fprintf(f,"%d\n%d\n%d\n%d\n%d\n",piecetypes,startinglevel,setn,dbackground,
  showintro);
  fprintf(f,"%d %d %d %d %d\n",key_left[0],key_right[0],key_drop[0],
    key_shift_up[0],key_shift_down[0]);
  fprintf(f,"%d %d %d %d %d\n",key_left[1],key_right[1],key_drop[1],
    key_shift_up[1],key_shift_down[1]);
  fprintf(f,"%d %d\n",gfx_get_fullscreen(),gfx_get_doublesize());
  fclose(f);
  return 1;
}

static void config_default(void) {
  /* default config */
  
  piecetypes=5;
  startinglevel=1;
  setn=0;
  dbackground=1;
  showintro=0;
  
  keys_default();
}


int main(int argc, char *argv[]) {
  
  key_quit=SDLK_ESCAPE;		/* important! */
  
  framerate=50;
  turn_interval_usec=1000000L/framerate;
    
  topscores_default();
  sound_cfg_defaults();
  
  strcpy(dataset,"br320");
  
  immedstart=0;
  
  players=1;
  
  board_x_size=5; board_y_size=13; 
  board_x_center=2;
  
  first_execution=0;

  if(!rc_find_load())
    return EXIT_FAILURE;

  if(!config_load(usr_config_file)) {
    first_execution = 1;
    printf("Welcome to Block Rage!\n");
  
    if(!config_load(sys_config_file)) {
      fprintf(stderr,"No config file found, assuming defaults.\n");
      config_default();
    }
  }
  
  if(!process_args(argc,argv)) return -1;
  if(!dataconfig_read()) return -1;
  
  if(setn>=no_of_sets) {
    fprintf(stderr,"Wrong blockset # (must be 0-%d)\n",no_of_sets-1);
    return EXIT_FAILURE;
  }
  
  
  if(!init())
    return EXIT_FAILURE;

  DEBUG1(printf("initied.\n"));
    
  quit=0; 
  if(first_execution || showintro) intro();
  
  DEBUG1(printf("run menu...\n"));
    
  quit=0; 
  menu();
  
  DEBUG1(printf("deinit...\n"));

  deinit();
  
  DEBUG1(printf("save config...\n"));
  
  if(!config_save(usr_config_file)) {
    fprintf(stderr,"blockrage error: cannot write user config file '%s'\n",
      usr_config_file);
  }
  
  DEBUG1(printf("exit...\n"));
  
  return EXIT_SUCCESS;
}
