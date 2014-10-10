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
  This module is responsible for rendering the animated backgrounds
*/

#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "global.h"
#include "main.h"
#include "bg.h"


int counter;
unsigned char *b0;
int bglevel;

void bg0_update(void)
{
   int y,x,i;
   
   for(x=0;x<board_x_pix_size;x++)
     b0[(board_y_pix_size-1)*board_x_pix_size+x]=0;
   
   for(i=0;i<50;i++) {
     b0[(board_y_pix_size-1)*board_x_pix_size+randint(0,board_x_pix_size)]=200;
   }
   
   for(y=0;y<board_y_pix_size-1;y++)
     for(x=0;x<board_x_pix_size;x++)
       b0[y*board_x_pix_size+x]=b0[(y+1)*board_x_pix_size+x];

   for(y=1;y<board_y_pix_size-1;y++)
     for(x=1;x<board_x_pix_size-1;x++)
       bground[y*board_x_pix_size+x]=
         ((long)(b0[(y+1)*board_x_pix_size+x-1])+
         (long)(b0[(y+1)*board_x_pix_size+x  ])+
         (long)(b0[(y+1)*board_x_pix_size+x+1])+
	 (long)(b0[(y  )*board_x_pix_size+x-1])+
	 (long)(b0[(y  )*board_x_pix_size+x  ])+
         (long)(b0[(y  )*board_x_pix_size+x+1])+
	 (long)(b0[(y-1)*board_x_pix_size+x-1])+
         (long)(b0[(y-1)*board_x_pix_size+x  ])+
         (long)(b0[(y-1)*board_x_pix_size+x+1]))/9;
	 

   for(y=0;y<board_y_pix_size;y++)
     for(x=0;x<board_x_pix_size;x++)
       b0[y*board_x_pix_size+x]=bground[y*board_x_pix_size+x];

   counter++;
}

void bg0_init(void) {
  int pixels;
  unsigned char *p;
  int i;
  
  b0=calloc_verify(board_x_pix_size*board_y_pix_size,sizeof(char));
  
  p=bground;
  pixels=board_x_pix_size*board_y_pix_size;
  while(--pixels) *p++=0;
  
/*  for(i=0;i<96;i++) {
    mypal[(BGPALBASE+i)*3]=mypal[(BGPALBASE+i)*3+1]=mypal[(BGPALBASE+i)*3+2]=i*2/3;
  }   */
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+i)*3]   = i*2;
    mypal[(BGPALBASE+i)*3+1] = 0;
    mypal[(BGPALBASE+i)*3+2] = 0;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+32+i)*3]   = 63;
    mypal[(BGPALBASE+32+i)*3+1] = i*2;
    mypal[(BGPALBASE+32+i)*3+2] = 0;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+64+i)*3]   = 63;
    mypal[(BGPALBASE+64+i)*3+1] = 63;
    mypal[(BGPALBASE+64+i)*3+2] = i*2;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+i)*3]   = 0;
    mypal[(BGPALBASE+i)*3+1] = i*2;
    mypal[(BGPALBASE+i)*3+2] = 0;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+32+i)*3]   = 0;
    mypal[(BGPALBASE+32+i)*3+1] = 63;
    mypal[(BGPALBASE+32+i)*3+2] = i*2;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+64+i)*3]   = i*2;
    mypal[(BGPALBASE+64+i)*3+1] = 63;
    mypal[(BGPALBASE+64+i)*3+2] = 63;
  }
     
  screen_setpal();
}

void bg0_done(void)
{
  free(b0);
}

/*************************************************************************/

#define ABS(x) ((x)<0?-(x):(x))

int wnxs,wnys;
unsigned char *w0,*w1;
//unsigned char pal[256*3];

unsigned char w0getpixel(int x, int y) {
  if(x>=0 && y>=0 && x<wnxs && y<wnys)
      return w0[y*wnxs+x];
    else return 0;
}
	    
void w0putpixel(int x, int y, unsigned char c) {
  if(x>=0 && y>=0 && x<wnxs && y<wnys)
    w0[y*wnxs+x]=c;
}

void w0maxpixel(int x, int y, unsigned char c) {
  if(x>=0 && y>=0 && x<wnxs && y<wnys && w0[y*wnxs+x]<c)
    w0[y*wnxs+x]=c;
}
      
void w1putpixel(int x, int y, unsigned char c) {
  if(x>=0 && y>=0 && x<wnxs && y<wnys)
    w1[y*wnxs+x]=c;
}

void cone(int x0, int y0, int r, int cmax) {
  int x,y;
  float dist;
    
  for(y=-r;y<=+r;y++) {
    for(x=-r;x<=+r;x++) {
      dist=sqrt(((float)x/r)*((float)x/r)+((float)y/r)*((float)y/r));
      dist=1-dist;
      if(dist<0) dist=0;
      
      w0maxpixel(x0+x,y0+y,(float)cmax*dist);
    }
  }
}

void hcone(int x0, int y0, int r, int cmax) {
  int x;
  float dist;
    
  for(x=-r;x<=+r;x++) {
    dist=(float)(r-ABS(x))/r;
	  
    w0maxpixel(x0+x,y0,(float)cmax*dist);
  }
}
		
float alpha=0;
void fxs_wave(void) {
  int i,j;
  int nwv;
  float r,ph;
  float rwf[4],rws[4],rwa[4];
	
  rwa[0]=1; rwf[0]=2; rws[0]=-0.3;
  rwa[1]=1; rwf[1]=0.3; rws[1]=0.7;

  nwv=2;
  for(i=0;i<wnys;i++) {
    r=1;
    for(j=0;j<nwv;j++) {
      ph= rwf[j]*(float)i/(float)wnys
         +rws[j]*alpha;
      r*=rwa[j]*sin(ph*2*M_PI);
    }
    hcone(wnxs/2+(wnxs/2)*r,i,30,90);
    /*w0putpixel(wnxs/2+(wnxs/2)*r,i,90);
    w0putpixel(wnxs/2+(wnxs/2)*r,1+i,90);
    w0putpixel(1+wnxs/2+(wnxs/2)*r,i,90);
    w0putpixel(1+wnxs/2+(wnxs/2)*r,1+i,90);*/
  }
   
  alpha+=0.06;
}

void bg1_darken(void) {
  int wx,wy;
    
  for(wy=0;wy<wnys;wy++) {
    for(wx=0;wx<wnxs;wx++) {
      w0putpixel(wx,wy,((unsigned short)w0getpixel(wx,wy)*250)>>8);
    }
  }
}

void bg1_init(void) {
  int i;
  
  wnxs=board_x_pix_size;
  wnys=board_y_pix_size;
	
  /*for(i=0;i<96;i++) {
    mypal[(BGPALBASE+i)*3]=mypal[(BGPALBASE+i)*3+1]=mypal[(BGPALBASE+i)*3+2]=i*2/3;
  }*/
  
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+i)*3]   = 0;
    mypal[(BGPALBASE+i)*3+1] = 0;
    mypal[(BGPALBASE+i)*3+2] = i*2;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+32+i)*3]   = 0;
    mypal[(BGPALBASE+32+i)*3+1] = i*2;
    mypal[(BGPALBASE+32+i)*3+2] = 63;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+64+i)*3]   = i*2;
    mypal[(BGPALBASE+64+i)*3+1] = 63;
    mypal[(BGPALBASE+64+i)*3+2] = 63;
  }
		
  w0=calloc_verify(wnxs*wnys,1);
  w1=calloc_verify(wnxs*wnys,1);
      
  screen_setpal();
}

void disp(unsigned char *w) {
/*  int pixels;
  unsigned char *dp;
  
  
  dp=bground;
  for(pixels=board_x_pix_size*board_y_pix_size;pixels>0;pixels--)
    *dp++=(*w++)+BGPALBASE;*/
  memcpy(bground,w,board_x_pix_size*board_y_pix_size);
}

void bg1_update(void) {
    //fxs_randpix();
    fxs_wave();
    bg1_darken();
    disp(w0);
/*    memcpy(w0,w1,wnxs*wnys);*/
}

void bg1_done(void) {
  free(w0);
  free(w1);
}

/*************************************************************************/

#define BG2S 30
#define BG2SDS 5
int bg2x[BG2S],bg2a[BG2S];

void bg2_update(void)
{
   int y,x,i,amp;
   unsigned char *p;
   
   for(i=0;i<BG2S;i++) {
     bg2x[i]+=randint(-1,3);
     if(bg2x[i]<0 || bg2x[i]>=board_x_pix_size)
       bg2x[i]=randint(0,board_x_pix_size);
       
     bg2a[i]+=randint(-2,5);
     if(bg2a[i]<30) bg2a[i]=30;
     if(bg2a[i]>95) bg2a[i]=95;
   }
   
   for(x=0;x<board_x_pix_size;x++)
     b0[(board_y_pix_size-1)*board_x_pix_size+x]=0;
   
/*   for(i=0;i<BG2S;i++) {
     b0[(board_y_pix_size-1)*board_x_pix_size+bg2x[i]]=90;
   }*/
   p=&b0[(board_y_pix_size-1)*board_x_pix_size];
   for(i=0;i<BG2S;i++) {
     amp=bg2a[i];
     for(x=0;x<BG2SDS && (bg2x[i]-x)>=0 && (bg2x[i]+x)<board_x_pix_size;x++) {
       p[bg2x[i]-x]=amp-x*(amp/BG2SDS);
       p[bg2x[i]+x]=amp-x*(amp/BG2SDS);
     }
   }
   
   for(y=0;y<board_y_pix_size-2;y++)
     for(x=0;x<board_x_pix_size;x++)
       b0[y*board_x_pix_size+x]=b0[(y+2)*board_x_pix_size+x];

   for(y=1;y<board_y_pix_size-1;y++)
     for(x=1;x<board_x_pix_size-1;x++)
       bground[y*board_x_pix_size+x]=
         ((long)(b0[(y+1)*board_x_pix_size+x-1])+
         (long)(b0[(y+1)*board_x_pix_size+x  ])+
         (long)(b0[(y+1)*board_x_pix_size+x+1])+
	 (long)(b0[(y  )*board_x_pix_size+x-1])+
	 (long)(b0[(y  )*board_x_pix_size+x  ])+
         (long)(b0[(y  )*board_x_pix_size+x+1])+
	 (long)(b0[(y-1)*board_x_pix_size+x-1])+
         (long)(b0[(y-1)*board_x_pix_size+x  ])+
         (long)(b0[(y-1)*board_x_pix_size+x+1]))/9;
	 

   for(y=0;y<board_y_pix_size;y++)
     for(x=0;x<board_x_pix_size;x++)
       b0[y*board_x_pix_size+x]=bground[y*board_x_pix_size+x];

   counter++;
}

void bg2_init(void) {
  int pixels;
  unsigned char *p;
  int i;
  
  b0=calloc_verify(board_x_pix_size*board_y_pix_size,sizeof(char));
  
  for(i=0;i<BG2S;i++)
    bg2x[i]=randint(0,board_x_pix_size);

  for(i=0;i<BG2S;i++)
    bg2a[i]=randint(30,66);
  
  p=bground;
  pixels=board_x_pix_size*board_y_pix_size;
  while(--pixels) *p++=0;
  
/*  for(i=0;i<96;i++) {
    mypal[(BGPALBASE+i)*3]=mypal[(BGPALBASE+i)*3+1]=mypal[(BGPALBASE+i)*3+2]=i*2/3;
  }   */
  /*
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+i)*3]   = 0;
    mypal[(BGPALBASE+i)*3+1] = i*2;
    mypal[(BGPALBASE+i)*3+2] = 0;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+32+i)*3]   = 0;
    mypal[(BGPALBASE+32+i)*3+1] = 63;
    mypal[(BGPALBASE+32+i)*3+2] = i*2;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+64+i)*3]   = i*2;
    mypal[(BGPALBASE+64+i)*3+1] = 63;
    mypal[(BGPALBASE+64+i)*3+2] = 63;
  }
  */
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+i)*3]   = i*2;
    mypal[(BGPALBASE+i)*3+1] = 0;
    mypal[(BGPALBASE+i)*3+2] = 0;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+32+i)*3]   = 63;
    mypal[(BGPALBASE+32+i)*3+1] = i*2;
    mypal[(BGPALBASE+32+i)*3+2] = 0;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+64+i)*3]   = 63;
    mypal[(BGPALBASE+64+i)*3+1] = 63;
    mypal[(BGPALBASE+64+i)*3+2] = i*2;
  }
     
  screen_setpal();
}

void bg2_done(void)
{
  free(b0);
}

/*************************************************************************/

#define BG3S 30
#define BG3SDS 5
int bg3x[BG3S],bg3a[BG3S];

void bg3_update(void)
{
   int y,x,i,amp;
   unsigned char *p;
   
   for(i=0;i<BG3S;i++) {
     /*bg3x[i]+=randint(-1,3);
     if(bg3x[i]<0 || bg2x[i]>=board_x_pix_size)
       bg3x[i]=randint(0,board_x_pix_size);*/
       
     bg3a[i]+=randint(-2,5);
     if(bg3a[i]<0) bg3a[i]=0;
     if(bg3a[i]>95) bg3a[i]=95;
   }
   
   for(x=0;x<board_x_pix_size;x++)
     b0[(board_y_pix_size-1)*board_x_pix_size+x]=0;
   
/*   for(i=0;i<BG3S;i++) {
     b0[(board_y_pix_size-1)*board_x_pix_size+bg3x[i]]=90;
   }*/
   p=&b0[(board_y_pix_size-1)*board_x_pix_size];
   for(i=0;i<BG3S;i++) {
     amp=bg3a[i];
     for(x=0;x<BG3SDS && (bg3x[i]-x)>=0 && (bg3x[i]+x)<board_x_pix_size;x++) {
       p[bg3x[i]-x]=amp-x*(amp/BG3SDS);
       p[bg3x[i]+x]=amp-x*(amp/BG3SDS);
     }
   }
   
   for(y=0;y<board_y_pix_size-2;y++)
     for(x=0;x<board_x_pix_size;x++)
       b0[y*board_x_pix_size+x]=b0[(y+2)*board_x_pix_size+x];

   for(y=1;y<board_y_pix_size-1;y++)
     for(x=1;x<board_x_pix_size-1;x++)
       bground[y*board_x_pix_size+x]=
         ((long)(b0[(y+1)*board_x_pix_size+x-1])+
         (long)(b0[(y+1)*board_x_pix_size+x  ])+
         (long)(b0[(y+1)*board_x_pix_size+x+1])+
	 (long)(b0[(y  )*board_x_pix_size+x-1])+
	 (long)(b0[(y  )*board_x_pix_size+x  ])+
         (long)(b0[(y  )*board_x_pix_size+x+1])+
	 (long)(b0[(y-1)*board_x_pix_size+x-1])+
         (long)(b0[(y-1)*board_x_pix_size+x  ])+
         (long)(b0[(y-1)*board_x_pix_size+x+1]))/9;
	 

   for(y=0;y<board_y_pix_size;y++)
     for(x=0;x<board_x_pix_size;x++)
       b0[y*board_x_pix_size+x]=bground[y*board_x_pix_size+x];

   counter++;
}

void bg3_init(void) {
  int pixels;
  unsigned char *p;
  int i;
  
  b0=calloc_verify(board_x_pix_size*board_y_pix_size,sizeof(char));
  
  for(i=0;i<BG3S;i++)
    bg3x[i]=randint(0,board_x_pix_size);

  for(i=0;i<BG3S;i++)
    bg3a[i]=randint(0,96);
  
  p=bground;
  pixels=board_x_pix_size*board_y_pix_size;
  while(--pixels) *p++=0;
  
/*  for(i=0;i<96;i++) {
    mypal[(BGPALBASE+i)*3]=mypal[(BGPALBASE+i)*3+1]=mypal[(BGPALBASE+i)*3+2]=i*2/3;
  }   */
  /*
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+i)*3]   = 0;
    mypal[(BGPALBASE+i)*3+1] = i*2;
    mypal[(BGPALBASE+i)*3+2] = 0;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+32+i)*3]   = 0;
    mypal[(BGPALBASE+32+i)*3+1] = 63;
    mypal[(BGPALBASE+32+i)*3+2] = i*2;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+64+i)*3]   = i*2;
    mypal[(BGPALBASE+64+i)*3+1] = 63;
    mypal[(BGPALBASE+64+i)*3+2] = 63;
  }
  */
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+i)*3]   = i*2;
    mypal[(BGPALBASE+i)*3+1] = i;
    mypal[(BGPALBASE+i)*3+2] = 0;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+32+i)*3]   = 63;
    mypal[(BGPALBASE+32+i)*3+1] = 32+i;
    mypal[(BGPALBASE+32+i)*3+2] = 0;
  }
  for(i=0;i<32;i++) {
    mypal[(BGPALBASE+64+i)*3]   = 63;
    mypal[(BGPALBASE+64+i)*3+1] = 63;
    mypal[(BGPALBASE+64+i)*3+2] = i*2;
  }
     
  screen_setpal();
}

void bg3_done(void)
{
  free(b0);
}

/*************************************************************************/
/***************************************************************************/

void bg_init(int level)
{
  bglevel=(level+1)%4;
  switch(bglevel) {
    case 3: bg3_init(); break;
    case 2: bg2_init(); break;
    case 1: bg1_init(); break;
    default:
    case 0: bg0_init(); break;
  }
}

void bg_update(void)
{
  switch(bglevel) {
    case 3: bg3_update(); break;
    case 2: bg2_update(); break;
    case 1: bg1_update(); break;
    default:
    case 0: bg0_update(); break;
  }
}

void bg_done(void)
{
  switch(bglevel) {
    case 3: bg3_done(); break;
    case 2: bg2_done(); break;
    case 1: bg1_done(); break;
    default:
    case 0: bg0_done(); break;
  }
}
