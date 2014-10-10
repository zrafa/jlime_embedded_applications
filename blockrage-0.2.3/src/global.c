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
  This module implements useful file and memory manipulation routines
*/


#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "global.h"
#include "main.h"

long fload_len;
int file_error;

/* adds a trailing slash to a path string, if not present */
void add_trailing_slash(char *s) {
  if(s[strlen(s)-1]!='/') strcat(s,"/");
}

void cat_with_slash(char *buf, char *file) {
  add_trailing_slash(buf);
  strcat(buf,file);
}

/*
  Do a malloc and verify that it succeeded.
  Otherwise terminate the program
*/
void *malloc_verify(size_t size) {
  void *p;
  
  p = malloc(size);
  if(!p) {
    fprintf(stderr,"blockrage: malloc failed!\n");
    exit(1);
  }
  
  return p;
}

/*
  Do a calloc and verify that it succeeded.
  Otherwise terminate the program
*/
void *calloc_verify(size_t nmemb, size_t size) {
  void *p;
  
  p = calloc(nmemb,size);
  if(!p) {
    fprintf(stderr,"blockrage: malloc failed!\n");
    exit(1);
  }
  
  return p;
}

/*
  Do a realloc and verify that it succeeded.
  Otherwise terminate the program
*/
void *realloc_verify(void *ptr, size_t size) {
  void *p;
  
  p = realloc(ptr,size);
  if(!p) {
    fprintf(stderr,"blockrage: malloc failed!\n");
    exit(1);
  }
  
  return p;
}


FILE *file_open(char *name, char *mode) {
  FILE *f;
  char *fname;
  int name_l, datadir_l, dataset_l;
  int fname_maxsiz;
  
  name_l = strlen(name);
  datadir_l = strlen(datadir);
  dataset_l = strlen(dataset);
  
  fname_maxsiz = datadir_l+1+dataset_l+1+name_l+1;
  if(fname_maxsiz>SANE_PATH_LEN) {
    fprintf(stderr,"file_open(): path length is not sane\n");
    exit(1);
  }
  
  fname = malloc_verify(fname_maxsiz);
 
  strncpy(fname,datadir,datadir_l+1);
  cat_with_slash(fname,dataset);
  cat_with_slash(fname,name);
  
  f = fopen(fname,mode);
  free(fname);
  
  return f;
}

/*
  Load a data file to a newly allocated block of memory
  The file path is relative to the dataset directory.
*/
unsigned char *file_load(char *name) {
  FILE *f;
  unsigned char *tmp;
  
  char *fname;
  int name_l, datadir_l, dataset_l;
  int fname_maxsiz;
  long fsize;

  name_l = strlen(name);
  datadir_l = strlen(datadir);
  dataset_l = strlen(dataset);
  
  fname_maxsiz = datadir_l+1+dataset_l+1+name_l+1;
  if(fname_maxsiz>SANE_PATH_LEN) {
    fprintf(stderr,"file_open(): path length is not sane\n");
    exit(1);
  }

  fname = malloc_verify(fname_maxsiz);
 
  strncpy(fname,datadir,datadir_l+1);
  cat_with_slash(fname,dataset);
  cat_with_slash(fname,name);
   
  f=fopen(fname,"rb");
  if(f==NULL) {
    fprintf(stderr,"blockrage/file_load: file %s not found\n",fname);
    free(fname);
    return NULL;
  }
  
  /* Determine file size */
  if(fseek(f,0,SEEK_END)!=0) {
    perror("blockrage/file_load");
    return NULL;
  }
  fsize = ftell(f);
  if(fsize<0) {
    perror("blockrage/file_load");
    return NULL;
  }
  if(fseek(f,0,SEEK_SET)!=0) {
    perror("blockrage/file_load");
    return NULL;
  }
  
  tmp=malloc_verify(fsize>0 ? fsize : 1);
  
  fread(tmp,1,fsize,f);
  fload_len=fsize;
  fclose(f);
  
  free(fname);
  
  return tmp;
}

unsigned fget_u8(FILE *f) {
  unsigned char res;
  
  file_error = file_error | (fread(&res,1,1,f)<1);
  return res;
}

unsigned fget_u16l(FILE *f) {
  unsigned res;
  
  res = fget_u8(f);
  res = res | (fget_u8(f)<<8);
  return res;
}

void fput_u8(FILE *f, unsigned val) {
  unsigned char tmp;
  
  tmp = val;
  file_error = file_error | (fwrite(&tmp,1,1,f)<1);
}

void fput_u16l(FILE *f, unsigned val) {
  fput_u8(f,val&0xff);
  fput_u8(f,val>>8);
}
