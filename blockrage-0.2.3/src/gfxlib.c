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
  This module implements a portable graphics library.
*/


#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>

#include "global.h"
#include "gfxout.h"
#include "gfxlib.h"

pix_t *vscr;
int clip_x0,clip_y0,clip_x1,clip_y1;
font_t font[2];
int t_align;

void v_fillscr(pix_t color) {
  int i,len=scr_x_size*scr_y_size;
  pix_t *p=vscr;
  
  for(i=0;i<len;i++)
    *p++=color;
}

void v_fillbox(int x, int y, int w, int h, pix_t color) {
  int xx,yy;
  
  for(yy=0;yy<h;yy++)
    for(xx=0;xx<w;xx++)
      vscr[(yy+y)*scr_x_size+x+xx]=color;
}

void v_drawbmp(int x0, int y0, pix_t keycolor, int xs, int ys, pix_t *data) {
  int x,y,LX,RX,TY,BY;
  pix_t *c,*s;
  pix_t *d;
  
//  printf("drawframe..");
  
  LX=MAX(x0,clip_x0);
  RX=MIN(x0+xs-1,clip_x1);
  TY=MAX(y0,clip_y0);
  BY=MIN(y0+ys-1,clip_y1);
  //printf("%d,%d,%d,%d c_y0=%d, b=%d\n",LX,TY,RX,BY,clip_y0,y0+b->ys-1);
  c=data;
  
  for(y=TY; y<=BY; y++) {
    s=&c[(y-y0)*xs+LX-x0];
    d=&vscr[y*scr_x_size+x0];
    for(x=LX; x<=RX; x++) {
      if(*s != keycolor)
        *d=*s;
      d++;s++;
    }
  }
	
//  printf("COLOR=%d..%d",c[0],c[(BY-y0)*(b->xs)+RX-x0]);
}

void v_copyarea(pix_t *src, pix_t *dst,
		int ssw, int dsw,
                int x0,int y0,int w,int h,int dx0,int dy0) {
  int x,y;
  pix_t *sp,*dp;
  
  //printf("void copyarea/for y\n");
  
  for(y=0;y<h;y++) {
    dp=&(dst[(dy0+y)*dsw+dx0]);
    sp=&(src[(y0+y)*ssw+x0]);
//    printf("void copyarea/for x\n");
    for(x=0;x<w;x++)  {
     //  printf("void copyarea/copypix\n");
       *dp++=*sp++;
    }
  }      
}

void v_drawscrarea(pix_t *src, int x0,int y0,int w,int h) {
  int x,y;
  pix_t *sp,*dp;
    
  for(y=0;y<h;y++) {
    dp=&(vscr[(y0+y)*scr_x_size+x0]);
    sp=&(src[(y0+y)*scr_x_size+x0]);
    for(x=0;x<w;x++)  {
       *dp++=*sp++;
    }
  }      
}


void virt_cpy(void) {
  gfx_virt_cpy(vscr);
}

void virt_cpyarea(int x0, int y0, int w, int h) {
  gfx_virt_cpyarea(vscr,x0,y0,w,h);
}

int strpixlen(char *s, int fontn) {
  int pixs=0;
  font_t *fnt=&font[fontn];
  
  while (*s) {
    if(pixs>0) pixs+=fnt->hspac;
    pixs+= fnt->rm[(int)*s] - fnt->lm[(int)*s];
    s++;
  }
  
  return pixs;
}

static void v_putglyph(int x0, int y0, int fontn, int g) {
  int x,y,sx0,sy0,sx1;
  pix_t *p=vscr;
  pix_t b;
  int cr;
  font_t *fnt = &font[fontn];

  cr = g / fnt->cells_row;
    
  sx0 = fnt->lm[g];
  sx1 = fnt->rm[g];
  sy0 = fnt->cy0 + cr*fnt->cyd;

  for(y=0;y<fnt->ch;y++) {
    for(x=0;x<sx1-sx0;x++) {
      b=fnt->bmp.data[(sy0+y)*fnt->bmp.xs+sx0+x];
      if(b!=fnt->bmp.key_color) p[(y+y0)*scr_x_size+x+x0]=b;
    }
  }
}

void v_print(int x0, int y0, int fontn, char *s) {
  font_t *fnt = &font[fontn];
  int c;
  
  if(t_align==T_CENTER) x0-=strpixlen(s,fontn)/2;
  
  while (*s) {
    c = *s++;
    if(c>=fnt->gmin && c<=fnt->gmax) {
      c -= fnt->gmin;
      v_putglyph(x0,y0,fontn,c);
    }
    x0 += fnt->rm[c]-fnt->lm[c] + fnt->hspac;
  }
}

void v_printf(int x0, int y0, int fnt, char *fmt, ...) {
  va_list ap;
  char s[MAXVSTR];
  
  va_start(ap,fmt);
  vsnprintf(s,MAXVSTR,fmt,ap);
  v_print(x0,y0,fnt,s);
  va_end(ap);
}

int font_load(char *name, font_t *fnt) {
  FILE *f;
  int i;
  char *fname;
  char *txt_ext = ".txt";
  char *pcx_ext = ".pcx";
  int txt_ext_l,pcx_ext_l;
  int ext_l;
  int name_l;
  
  name_l = strlen(name);
  if(name_l>SANE_PATH_LEN) {
    fprintf(stderr,"font_load(): length of name is not sane\n");
    exit(1);
  }
  
  txt_ext_l = strlen(txt_ext);
  pcx_ext_l = strlen(pcx_ext);
  ext_l = txt_ext_l > pcx_ext_l ? txt_ext_l : pcx_ext_l;
  fname = malloc_verify(name_l+ext_l+1);

  strncpy(fname,name,name_l);
  strncpy(fname+name_l,txt_ext,txt_ext_l);
  fname[name_l+txt_ext_l]=0;

  if((f=file_open(fname,"rt"))==NULL) {
    fprintf(stderr,"font_load(): can't open %s\n",fname);
    free(fname);
    return 0;
  }

  fscanf(f,"%d%d",&(fnt->gmin),&(fnt->gmax));
  fscanf(f,"%d%d",&(fnt->cxd),&(fnt->cyd));
  fscanf(f,"%d%d",&(fnt->cx0),&(fnt->cy0));
  fscanf(f,"%d%d",&(fnt->cw),&(fnt->ch));
  fscanf(f,"%d",&(fnt->cells_row));

  fscanf(f,"%d",&(fnt->hspac));
  fscanf(f,"%d",&(fnt->vspac));

  for(i=0;i<256;i++) {
    fnt->lm[i]=fnt->cx0 + (i%fnt->cells_row)*fnt->cxd;
    fnt->rm[i]=fnt->lm[i]+fnt->cw;
  }
  
  strncpy(fname,name,name_l);
  strncpy(fname+name_l,".pcx",pcx_ext_l);
  fname[name_l+pcx_ext_l]=0;
  
  if(!pcx_load(&fnt->bmp,fname)) {
    fprintf(stderr,"font_load(): can't open %s\n",fname);
    free(fname);
    return 0;
  }
  fclose(f);
  
  free(fname);
  return 1;
}

unsigned char *pal_load(char *name) {
  unsigned char *aapal, *pal;
  int i;
  
  aapal=file_load(name);
  if(!aapal) return 0;
  pal=malloc_verify(768);
  for(i=0;i<768;i++)
    pal[i]=aapal[i+8] >> 2;
    
  free(aapal);
  
  return pal;
}

int pcx_load(bmp_t *bmp, char *name) {
  pix_t *up, *upp;
  int xsize,ysize,bleftu,lpos;
  unsigned char code,pval;
  pix_t pval_mapped;
  FILE *f;
#ifdef DIRECT_COLOR
  pix_t pal[256];
  unsigned char rv,gv,bv;
  int i;
#endif
  
  /* PCX header entries */
  unsigned identifier,encoding,bitsperpixel;
  unsigned xstart,ystart,xend,yend;
  unsigned numbitplanes,bytesperline;

  bmp->xs=-1;
  bmp->ys=-1; 
  bmp->data=NULL;

  f=file_open(name,"rb");
  if(!f) return 0;

  /* Read the PCX header */
  identifier = fget_u8(f);
  /* version */ fget_u8(f);
  encoding = fget_u8(f);
  bitsperpixel = fget_u8(f);
  xstart = fget_u16l(f);
  ystart = fget_u16l(f);
  xend = fget_u16l(f);
  yend = fget_u16l(f);
  /* horzres */ fget_u16l(f);
  /* vertres */ fget_u16l(f);
  /* palette */ fseek(f,48,SEEK_CUR);
  /* reserved1 */ fget_u8(f);
  numbitplanes = fget_u8(f);
  bytesperline = fget_u16l(f);
  /* palettetype */ fget_u16l(f);
  /* horzscreensize */ fget_u16l(f);
  /* vertscreensize */ fget_u16l(f);
  /* reserved2 */ fseek(f,54,SEEK_CUR);

  /* total 128 bytes in header */

  if(identifier!=0x0a || encoding!=1 || numbitplanes!=1
     || bitsperpixel!=8) return 0;

  /* Read the palette */
#ifdef DIRECT_COLOR
  fseek(f,-3*256-1,SEEK_END);
  code = fget_u8(f);
  if(code!=0x0c) return 0;
  
  for(i=0;i<256;i++) {
    rv=fget_u8(f)>>3;
    gv=fget_u8(f)>>2;
    bv=fget_u8(f)>>3;
    pal[i] = bv|(gv<<5)|(rv<<11);
  }
  
  fseek(f,128,SEEK_SET);
  
  bmp->key_color=pal[255];
#else
  bmp->key_color=255;
#endif

  /* Read the pixels */

  xsize=xend - xstart +1;
  ysize=yend - ystart +1;

/*  printf("pcx_load: %dx%d, bpl:%d",
  xsize,ysize,phead->bytesperline);*/

  up=calloc_verify(xsize*(ysize+10),sizeof(pix_t));

  bleftu=xsize*ysize;

  upp=up;
  lpos=0;
  while(bleftu>0) {
    code=fget_u8(f);
    if((code & 0xc0)==0xc0) {
      pval=fget_u8(f);
//      printf("[c:%03d,%03d]",code,pval);
      code &= 0x3f;
    } else {
//      printf("[u:     %03d]",code);
      pval=code; code=1;
    }
#ifdef DIRECT_COLOR
    pval_mapped=pal[pval];
#else
    pval_mapped=pval;
#endif
    while(code-- && bleftu>0) { 
      if(lpos<xsize) { 
        *upp++=pval_mapped;
        bleftu--; 
      }
      if(++lpos>=bytesperline) lpos=0;
    }
  }
  
  bmp->xs=xsize;
  bmp->ys=ysize;
  bmp->data=up;

  return 1;
}

#ifdef DIRECT_COLOR
void pcx_save(int xs, int ys, pix_t *data, unsigned char *pal,
              char *name) {
  unsigned char *up, *upp;
  int x,y, i;
  unsigned char count;
  unsigned char *planes;
  FILE *f;

  if(!(f=fopen(name,"wb"))) return;

  fput_u8(f,0x0a); /* identifier */
  fput_u8(f,5);    /* version */
  fput_u8(f,1); /* encoding */
  fput_u8(f,8); /* bitsperpixel */
  fput_u16l(f,0); /* xstart */
  fput_u16l(f,0); /* ystart */
  fput_u16l(f,xs-1); /* xend */
  fput_u16l(f,ys-1); /* yend */
  fput_u16l(f,0); /* horzres */
  fput_u16l(f,0); /* vertres */

  for(i=0;i<48;i++) /* palette */
    fput_u8(f,0);

  fput_u8(f,0); /* reserved1 */
  fput_u8(f,3); /* numbitplanes */
  fput_u16l(f,xs); /* bytesperline */
  fput_u16l(f,1); /* palettetype */
  fput_u16l(f,scr_x_size); /* horzscreensize */
  fput_u16l(f,scr_y_size); /* vertscreensize */
  for(i=0;i<54;i++) /* reserved2 */
    fput_u8(f,0);
  
  planes=malloc_verify(xs*ys*3);

  for(y=0;y<ys;y++) {
    for(x=0;x<xs;x++)
      planes[y*scr_x_size*3+x]=(data[y*scr_x_size+x]>>11)<<3;

    for(x=0;x<xs;x++)
      planes[y*scr_x_size*3+scr_x_size+x]=((data[y*scr_x_size+x]>>5)&0x3f)<<2;

    for(x=0;x<xs;x++)
      planes[y*scr_x_size*3+2*scr_x_size+x]=(data[y*scr_x_size+x]&0x1f)<<3;
  }

  up=planes;
  for(i=0;i<3;i++) {
    for(y=0;y<ys;y++) {
      upp=&up[xs*ys*i + y*xs];
      x=0;
      while(x<xs) {
        count=1;
        /* compression. chunks cannot cross between lines */
        while((count<63 && x+count<xs)?(upp[0]==upp[count]):0) count++;
        if(count>1) { /* rle chunk */
          fput_u8(f, 0xc0 | count);
          fput_u8(f, upp[0]);
          upp=&upp[count];
          x+=count;
        } else { /* only 1 pixel */
	  if(*upp<0xc0) fput_u8(f,*upp); /* save as one byte */
	    else {
	      fput_u8(f,0xc1); /* one-pixel rle chunk (bad luck) */
	      fput_u8(f,*upp);
	    }
	    
	  upp++;
	  x++;
	}
      }
    }
  }
  
  free(planes);

  fput_u8(f,0x0c);
  for(i=0;i<256*3;i++) {
    fput_u8(f,pal[i]<<2);
  }
  
  fclose(f);
}

#else

void pcx_save(int xs, int ys, unsigned char *data, unsigned char *pal,
              char *name) {
  unsigned char *up, *upp;
  int x,y, i;
  unsigned char count;
  FILE *f;

  if(!(f=fopen(name,"wb"))) return;

  fput_u8(f,0x0a); /* identifier */
  fput_u8(f,5);    /* version */
  fput_u8(f,1); /* encoding */
  fput_u8(f,8); /* bitsperpixel */
  fput_u16l(f,0); /* xstart */
  fput_u16l(f,0); /* ystart */
  fput_u16l(f,xs-1); /* xend */
  fput_u16l(f,ys-1); /* yend */
  fput_u16l(f,0); /* horzres */
  fput_u16l(f,0); /* vertres */

  for(i=0;i<48;i++) /* palette */
    fput_u8(f,0);

  fput_u8(f,0); /* reserved1 */
  fput_u8(f,1); /* numbitplanes */
  fput_u16l(f,xs); /* bytesperline */
  fput_u16l(f,1); /* palettetype */
  fput_u16l(f,scr_x_size); /* horzscreensize */
  fput_u16l(f,scr_y_size); /* vertscreensize */
  for(i=0;i<54;i++) /* reserved2 */
    fput_u8(f,0);
		      
  up=(unsigned char *)data;
  
  for(y=0;y<ys;y++) {
      upp=&up[y*xs];
      x=0;
      while(x<xs) {
        count=1;
        /* compression. chunks cannot cross between lines */
        while((count<63 && x+count<xs)?(upp[0]==upp[count]):0) count++;
        if(count>1) { /* rle chunk */
          fput_u8(f, 0xc0 | count);
          fput_u8(f, upp[0]);
          upp=&upp[count];
          x+=count;
        } else { /* only 1 pixel */
	  if(*upp<0xc0) fput_u8(f,*upp); /* save as one byte */
	    else {
	      fput_u8(f,0xc1); /* one-pixel rle chunk (bad luck) */
	      fput_u8(f,*upp);
	    }
	    
	  upp++;
	  x++;
	}
      }
  }
  
  fput_u8(f,0x0c);
  for(i=0;i<256*3;i++) {
    fput_u8(f,pal[i]<<2);
  }
  
  fclose(f);
}
#endif
