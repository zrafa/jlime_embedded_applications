/* 
 * Gmu Music Player
 *
 * Copyright (c) 2006-2010 Johannes Heimansberg (wejp.k.vu)
 *
 * File: hw_dingoo.h  Created: 090623
 *
 * Description: Dingoo specific stuff (button mapping etc.)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 2 of
 * the License. See the file COPYING in the Gmu's main directory
 * for details.
 */
#ifndef _HW_DINGOO_H
#define _HW_DINGOO_H

#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <linux/fb.h>
#include <unistd.h>

#define HW_COLOR_DEPTH 16
#define HW_SCREEN_WIDTH 320
#define HW_SCREEN_HEIGHT 240

#define SAMPLE_BUFFER_SIZE 4096

#define MAX_COVER_IMAGE_PIXELS 400000

#define BUTTON_UP     (273)
#define BUTTON_DOWN   (274)
#define BUTTON_LEFT   (276)
#define BUTTON_RIGHT  (275)
#define BUTTON_ESCAPE (27)
#define BUTTON_START  (13)
#define BUTTON_SELECT (27)
#define BUTTON_A      (306)
#define BUTTON_B      (308)
#define BUTTON_Y      (304)
#define BUTTON_X      (32)
#define BUTTON_R      (8)
#define BUTTON_L      (9)
#define VOLUME_UP     (0)
#define VOLUME_DOWN   (0)
#define BUTTON_CLICK  (0)

int         hw_open_mixer(int mixer_channel);
void        hw_close_mixer(void);
void        hw_set_volume(int volume);
void        hw_display_off(void);
void        hw_display_on(void);
void        hw_detect_device_model(void);
const char *hw_get_device_model_name(void);
#endif
