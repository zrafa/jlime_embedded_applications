/* 
 * Gmu Music Player
 *
 * Copyright (c) 2006-2010 Johannes Heimansberg (wejp.k.vu)
 *
 * File: hw_gp2x.h  Created: ?
 *
 * Description: GP2X specific stuff (button mapping etc.)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 2 of
 * the License. See the file COPYING in the Gmu's main directory
 * for details.
 */
#ifndef _HW_GP2X_H
#define _HW_GP2X_H

#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <linux/fb.h>
#include <unistd.h>
#include <stropts.h>

#define HW_COLOR_DEPTH 16
#define HW_SCREEN_WIDTH 320
#define HW_SCREEN_HEIGHT 240

#define SAMPLE_BUFFER_SIZE 4096

#define MAX_COVER_IMAGE_PIXELS 400000

#define BUTTON_UP     (0)
#define BUTTON_DOWN   (4)
#define BUTTON_LEFT   (2)
#define BUTTON_RIGHT  (6)
#define BUTTON_ESCAPE (9)
#define BUTTON_START  (8)
#define BUTTON_SELECT (9)
#define BUTTON_A      (12)
#define BUTTON_B      (13)
#ifndef _OPEN2X
#define BUTTON_Y      (14)
#define BUTTON_X      (15)
#define BUTTON_R      (10)
#define BUTTON_L      (11)
#else
#define BUTTON_Y      (15)
#define BUTTON_X      (14)
#define BUTTON_R      (11)
#define BUTTON_L      (10)
#endif
#define VOLUME_UP     (16)
#define VOLUME_DOWN   (17)
#define BUTTON_CLICK  (18)

typedef enum GP2XModel { MODEL_UNKNOWN, MODEL_F100, MODEL_F200, MODEL_WIZ } GP2XModel;

void          gp2x_set_cpu_clock(unsigned int MHz);
unsigned char gp2x_init_phys(void);
void          gp2x_close_phys(void);
GP2XModel     gp2x_get_model(void);

int           hw_open_mixer(int mixer_channel);
void          hw_close_mixer(void);
void          hw_set_volume(int volume);
void          hw_display_off(void);
void          hw_display_on(void);
void          hw_detect_device_model(void);
const char   *hw_get_device_model_name(void);
#endif
