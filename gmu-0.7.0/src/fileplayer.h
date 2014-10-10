/* 
 * Gmu Music Player
 *
 * Copyright (c) 2006-2010 Johannes Heimansberg (wejp.k.vu)
 *
 * File: fileplayer.h  Created: 070107
 *
 * Description: Functions for audio file playback
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 2 of
 * the License. See the file COPYING in the Gmu's main directory
 * for details.
 */
#ifndef _FILEPLAYER_H
#define _FILEPLAYER_H
#include "trackinfo.h"
#include "pbstatus.h"
typedef enum Action { VORBIS_PLAYER, MODULE_PLAYER, MPEG_PLAYER, MPC_PLAYER, FLAC_PLAYER, ADPLUG_PLAYER, NOTHING } Action;

typedef struct Filetype
{
	char   filetype[32];
	Action action;
} Filetype;

static const Filetype ft[] =
{
	{ "669",  MODULE_PLAYER },
	{ "AMF",  MODULE_PLAYER },
	{ "AMS",  MODULE_PLAYER },
	{ "DBM",  MODULE_PLAYER },
	{ "DMF",  MODULE_PLAYER },
	{ "FAR",  MODULE_PLAYER },
	{ "IT",   MODULE_PLAYER },
	{ "MDL",  MODULE_PLAYER },
	{ "MED",  MODULE_PLAYER },
	{ "MOD",  MODULE_PLAYER },
	{ "MT2",  MODULE_PLAYER },
	{ "MTM",  MODULE_PLAYER },
	{ "OKT",  MODULE_PLAYER },
	{ "PSM",  MODULE_PLAYER },
	{ "PTM",  MODULE_PLAYER },
	{ "S3M",  MODULE_PLAYER },
	{ "STM",  MODULE_PLAYER },
	{ "ULT",  MODULE_PLAYER },
	{ "XM",   MODULE_PLAYER },
	{ "OGG",  VORBIS_PLAYER },
	{ "MP3",  MPEG_PLAYER },
	{ "MP2",  MPEG_PLAYER },
	{ "MPC",  MPC_PLAYER },
	{ "MP+",  MPC_PLAYER },
	{ "MPP",  MPC_PLAYER },
	{ "FLAC", FLAC_PLAYER },
	{ "A2M",  ADPLUG_PLAYER },
	{ "ADL",  ADPLUG_PLAYER },
	{ "AMD",  ADPLUG_PLAYER },
	{ "BAM",  ADPLUG_PLAYER },
	{ "CFF",  ADPLUG_PLAYER },
	{ "CMF",  ADPLUG_PLAYER },
	/*{ "D00",  ADPLUG_PLAYER },*/
	{ "DFM",  ADPLUG_PLAYER },
	{ "DMO",  ADPLUG_PLAYER },
	{ "DRO",  ADPLUG_PLAYER }, 
	{ "DTM",  ADPLUG_PLAYER },
	{ "HSC",  ADPLUG_PLAYER },
	{ "HSP",  ADPLUG_PLAYER },
	{ "IMF",  ADPLUG_PLAYER },
	{ "KSM",  ADPLUG_PLAYER },
	{ "LAA",  ADPLUG_PLAYER },
	{ "LDS",  ADPLUG_PLAYER },
	{ "M",    ADPLUG_PLAYER },
	{ "MAD",  ADPLUG_PLAYER },
	{ "MID",  ADPLUG_PLAYER },
	{ "MSC",  ADPLUG_PLAYER },
	{ "MTK",  ADPLUG_PLAYER },
	{ "RAD",  ADPLUG_PLAYER },
	{ "RIX",  ADPLUG_PLAYER },
	{ "ROL",  ADPLUG_PLAYER },
	{ "SA2",  ADPLUG_PLAYER },
	{ "SAT",  ADPLUG_PLAYER },
	{ "SCI",  ADPLUG_PLAYER },
	{ "SNG",  ADPLUG_PLAYER },
	{ "XAD",  ADPLUG_PLAYER },
	{ "XAS",  ADPLUG_PLAYER },
	{ "XSM",  ADPLUG_PLAYER },
	{ "",     NOTHING }
};

void      file_player_set_lyrics_file_pattern(char *pattern);
int       file_player_playback_get_time(void);
PB_Status file_player_get_playback_status(void);
PB_Status file_player_get_item_status(void);
void      file_player_stop_playback(void);
int       file_player_play_file(char *file, TrackInfo *ti);
int       file_player_read_tags(char *file, char *file_type, TrackInfo *ti);
int       file_player_seek(long offset);
int       file_player_is_metadata_loaded(void);
int       file_player_is_thread_running(void);
#endif
