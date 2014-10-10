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
  This module contains a simple 8-bit/16-bit audio mixer
  and interfaces SDL audio.
*/


#ifdef NOSOUND

void sound_fx(int stype) {
}

int sound_init(void) {
  return 1;
}

void sound_done(void) {
}

#V*
#else

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <SDL.h>
#include "global.h"
#include "sound.h"

#define PRE_DIVIDE 2

#define FMT_8BIT AUDIO_U8

#if SDL_BYTEORDER == SDL_LIL_ENDIAN
#define FMT_16BIT AUDIO_S16LSB
#else
#define FMT_16BIT AUDIO_S16MSB
#endif

typedef struct {
  unsigned char *data;
  long size;
} snd_t;

static int sound_inited = 0;

static long mixspeed;
static long mixfmt;

static int mixbuf_size;
static int mixbuf_size_b;

static void *mixbuf; 				/* the mixing buffer */
static int mixbuf_out_b;

static int audio_queue_size;

/* Available sound effects */
static snd_t sfx[4];

/* BEGIN SHARED DATA = subject to collisions */
static voice_info_t voice[MAX_VOICES];         /* voice states */
/* END SHARED DATA */

static void mix_fillbuf(void);

/*
  **** This parts gets executed in the audio thread ****
*/

static void my_audio_callback(void *udata, Uint8 *b_buf, int len) {
  Uint8 *mixbuf8 = (Uint8 *)mixbuf;
  
  int now;
  
  while(len>0) {
    if(mixbuf_out_b>=mixbuf_size_b) {
      mix_fillbuf();
      mixbuf_out_b=0;
    }
    now=mixbuf_size_b-mixbuf_out_b;
    if(now>len) now=len;
    memcpy(b_buf,mixbuf8+mixbuf_out_b,now);    
    b_buf+=now;
    mixbuf_out_b+=now;
    len-=now;
  }
}

static void mix_mixvoice_u8(int vn) {
  long bytes,i;
  unsigned char *smp,*buf;
  int c;
  
  buf=(unsigned char *)mixbuf;
  
  if(voice[vn].left>0) {
    bytes=voice[vn].left;
    if(bytes<0) bytes=0;
    if(bytes>mixbuf_size_b) bytes=mixbuf_size_b;
    
    smp=(unsigned char *)voice[vn].sample;
    
    for(i=0;i<bytes;i++) {
      c=buf[i];
      c-=128;
      c = c / PRE_DIVIDE;
      c+=*smp++;
      buf[i]=c;
    }
      
    voice[vn].sample=(void *)smp;
    
    voice[vn].left-=bytes;
        
    if(voice[vn].left<=0) {
      voice[vn].left=0;
      voice[vn].sample=NULL;
      DEBUG2(printf("blockrage/sound: done playing sfx at voice %d\n",vn);)
    }
  }
}

static void mix_mixvoice_s16(int vn) {
  long bytes,i;
  signed short *smp,*buf;
  
  buf=(signed short *)mixbuf;
  
  if(voice[vn].left>0) {
    bytes=voice[vn].left;
    if(bytes<0) bytes=0;
    if(bytes>mixbuf_size_b) bytes=mixbuf_size_b;
    
    smp=(signed short *)voice[vn].sample;
    
    for(i=0;i<bytes;i+=2) {
      (*buf++)+=(*smp++)/PRE_DIVIDE;
    }
      
    voice[vn].sample=(void *)smp;
    
    voice[vn].left-=bytes;
        
    if(voice[vn].left<=0) {
      voice[vn].left=0;
      voice[vn].sample=NULL;
      DEBUG2(printf("blockrage/sound: done playing sfx at voice %d\n",vn);)
    }
  }
}

static void mix_clearbuf_u8(void) {
  int i;
  unsigned char *buf;
  
  buf=(unsigned char *)mixbuf;
  
  for(i=0;i<mixbuf_size;i++)
      buf[i]=128;
}

static void mix_clearbuf_s16(void) {
  int i;
  signed short *buf;
  
  buf=(signed short *)mixbuf;
  
  for(i=0;i<mixbuf_size;i++)
      buf[i]=0;
}

static void mix_fillbuf(void) {
  int i;
  
  if(mixfmt==FMT_16BIT) {
    mix_clearbuf_s16();
    for(i=0;i<MAX_VOICES;i++) 
      mix_mixvoice_s16(i);
    
  } else {
  
    mix_clearbuf_u8();
    for(i=0;i<MAX_VOICES;i++) 
      mix_mixvoice_u8(i);
      
  }
}

/*
  **** This gets executed in the main thread, concurrently ****
*/

/* This function must be called with the audio lock active */
static int voices_findidlevoice(void) {
  int i;
  
  for(i=0;i<MAX_VOICES;i++) {
    if(voice[i].left==0) return i;
  }
  
  return -1;
}

/* This function must be called with the audio lock active */
static void voices_playsample(int vn, snd_t smp) {
  voice[vn].sample=smp.data;
  voice[vn].left=smp.size;
}

void sound_fx(int sfxnum) {
  int v;
  
  if(!sound_inited) return;
  if(sfxnum<-1 || sfxnum>3) return;
  if(!sfx[sfxnum].size) return;
  
  SDL_LockAudio(); /* Lock access to voice[] variable */
  v=voices_findidlevoice();
  if(v!=-1) {
    DEBUG2(printf("blockrage/sound: playing sfx at voice %d\n",v);)
    voices_playsample(v,sfx[sfxnum]);
  } else {
    DEBUG1(printf("blockrage/sound: no free voices\n");)
  }
  SDL_UnlockAudio(); /* Unlock access to voice[] variable */
}

/*
  **** The rest does not share data / run concurrently with
       the audio thread  ****
*/

static void voices_init(void) {
  int i;
  
  for(i=0;i<MAX_VOICES;i++) {
    voice[i].sample=NULL;
    voice[i].left=0;
  }
}


/*
  Set up default configuration
  
  This should be called as the very first function from
  the module.
*/
void sound_cfg_defaults(void) {
  mixspeed=44100;
  mixfmt = FMT_16BIT;  

  mixbuf_size = 1024;
  
  audio_queue_size = 2048;
}

/*
  Request 8-bit mixing and audio output
*/
void sound_cfg_8bit(void) {
  mixfmt = FMT_8BIT;
}

/*
  Load a raw 16-bit LSB 1-channel sample from a file,
  possibly doing an endianity conversion
  and/or downsampling to 8-bit depth.
*/
void sound_file_load(snd_t *snd, char *fname) {
  _S16 *p;
  _U8 *p8;
  int l;
  
  snd->data = file_load(fname);
  snd->size = fload_len;
  if(!snd->data)
    snd->size = 0;
  DEBUG2(printf("len:%ld\n",fload_len);)
 
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
  /* 
    Sound files are stored in little endian.
    Since we are on a big-endian machine, convert them
  */
  p = snd->data;
  l = snd->size >> 1;
  while(l> 0) {
    *p = ((*p & 0xff) << 8) | (*p >> 8);
    p++; l--;
  }
#endif

  /*
    If 8-bit mixing is selected, we need to strip down
    the sample depth.
  */
  if(mixfmt == FMT_8BIT) {
    l = snd->size >> 1;
    p = (_S16 *)(void *)snd->data;
    snd->data = malloc_verify(l);
  
    p8 = snd->data;
    while(l>0) {
      *p8 = 128+(*p >> 8);
      p8++; p++; l--;
    }
    
//    free(p);
    snd->size = snd->size >> 1;
  }
}

static int sound_device_init(void) {
  SDL_AudioSpec desired, obtained;

  desired.freq = mixspeed;
  desired.format = mixfmt;
  desired.channels = 1; /* mono */
  desired.samples = audio_queue_size;
  desired.callback = my_audio_callback;
  desired.userdata = NULL;
  
  mixbuf_out_b=0;
  
  if( SDL_OpenAudio(&desired, &obtained) < 0) {
    fprintf(stderr, "Cannot open audio: %s\n", SDL_GetError());
    return 0;
  }
  
  mixspeed = obtained.freq;
  mixfmt = obtained.format;
  audio_queue_size = desired.samples;
  
  if(mixfmt!=FMT_16BIT && mixfmt!=FMT_8BIT) {
    fprintf(stderr,"unsupported audio output format\n");
    return 0;
  }
  
  return 1;
}

/*
  Open the audio device and load all sound files
*/
int sound_init(void) {
  voices_init();

  if(!sound_device_init()) {
    if(mixfmt==FMT_16BIT) {
      fputs("Trying 8-bit audio format\n",stderr);
      sound_cfg_8bit();
      if(!sound_device_init())
        return 0;
    }
  }
  
  /* Allocate the mixing buffer */
  mixbuf_size_b = mixbuf_size * (mixfmt==FMT_16BIT ? 2 : 1);
  
  mixbuf=calloc_verify(mixbuf_size_b,1);

  /*
    Files must be loaded after opening the sound device
    so that sound_file_load can convert them to the proper
    format
  */  
  sound_file_load(&sfx[0],"sfx0.snd");
  sound_file_load(&sfx[1],"sfx1.snd");
  sound_file_load(&sfx[2],"sfx2.snd");
//  sound_file_load(&sfx[3],"sfx3.snd");
  sfx[3].size=0;

  DEBUG2(printf("starting audio\n"));
  SDL_PauseAudio(0);
  
  sound_inited = 1;
  return 1;
}

void sound_done(void) {
  if(!sound_inited) return;
  sound_inited = 0;
  
  DEBUG1(printf("SDL_CloseAudio...\n"));
  SDL_CloseAudio();
  DEBUG1(printf("free mixbuf...\n"));
  free(mixbuf);
  DEBUG1(printf("ok\n"));
}

#endif
