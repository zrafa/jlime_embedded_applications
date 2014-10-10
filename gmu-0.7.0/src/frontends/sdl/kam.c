/* 
 * Gmu Music Player
 *
 * Copyright (c) 2006-2010 Johannes Heimansberg (wejp.k.vu)
 *
 * File: kam.c  Created: 061102
 *
 * Description: Key mapping stuff
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 2 of
 * the License. See the file COPYING in the Gmu's main directory
 * for details.
 */
#include <string.h>
#include "SDL.h"
#include "kam.h"
#include "hw.h"
#include "wejpconfig.h"
#include "inputconfig.h"

void key_action_mapping_init(KeyActionMapping *kam)
{
	int i;
	for (i = LAST_ACTION; i--; ) {
		kam[i].button_name[0] = '\0';
		kam[i].button         = -1;
		kam[i].modifier       = 0;
	}

	kam[FB_DIR_UP].scope =                   FILE_BROWSER;
	kam[FB_DIR_UP].description =                  "Dir up";
	kam[FB_CHDIR].scope =                    FILE_BROWSER;
	kam[FB_CHDIR].description =                   "Ch.dir";
	kam[FB_ADD_FILE_TO_PL_OR_CHDIR].scope =  FILE_BROWSER;
	kam[FB_ADD_FILE_TO_PL_OR_CHDIR].description = "Add file/Ch.dir";
	kam[FB_ADD_DIR_TO_PL].scope =            FILE_BROWSER;
	kam[FB_ADD_DIR_TO_PL].description =           "Add dir";
	kam[FB_INSERT_FILE_INTO_PL].scope =      FILE_BROWSER;
	kam[FB_INSERT_FILE_INTO_PL].description =     "Insert file";
	kam[FB_PLAY_FILE].scope =                FILE_BROWSER;
	kam[FB_PLAY_FILE].description =               "Play file";
	kam[FB_DELETE_FILE].scope =              FILE_BROWSER;
	kam[FB_DELETE_FILE].description =             "Delete file";
	kam[FB_NEW_PL_FROM_DIR].scope =          FILE_BROWSER;
	kam[FB_NEW_PL_FROM_DIR].description =         "New PL from dir";
	kam[PL_PLAY_ITEM].scope =                PLAYLIST;
	kam[PL_PLAY_ITEM].description =               "Play item";
	kam[PL_REMOVE_ITEM].scope =              PLAYLIST;
	kam[PL_REMOVE_ITEM].description =             "Remove item";
	kam[PL_CLEAR_PLAYLIST].scope =           PLAYLIST;
	kam[PL_CLEAR_PLAYLIST].description =          "Clear list";
	kam[PL_TOGGLE_RANDOM].scope =            PLAYLIST;
	kam[PL_TOGGLE_RANDOM].description =           "Change play mode";
	kam[PL_DELETE_FILE].scope =              PLAYLIST;
	kam[PL_DELETE_FILE].description =             "Delete file";
	kam[PL_SAVE_PLAYLIST].scope =            PLAYLIST;
	kam[PL_SAVE_PLAYLIST].description =           "Save/Load list";
	kam[PL_ENQUEUE].scope =                  PLAYLIST;
	kam[PL_ENQUEUE].description =                 "Enqueue item";
	kam[PLMANAGER_SELECT].scope =            PLAYLIST_SAVE;
	kam[PLMANAGER_SELECT].description =           "Save";
	kam[PLMANAGER_CANCEL].scope =            PLAYLIST_SAVE;
	kam[PLMANAGER_CANCEL].description =           "Cancel";
	kam[PLMANAGER_LOAD].scope =              PLAYLIST_SAVE;
	kam[PLMANAGER_LOAD].description =             "Load";
	kam[PLMANAGER_LOAD_APPEND].scope =       PLAYLIST_SAVE;
	kam[PLMANAGER_LOAD_APPEND].description =      "Append to cur. list";
	kam[ABOUT_OKAY].scope =                  ABOUT;
	kam[ABOUT_OKAY].description =                 "Okay";
	kam[SETUP_SELECT].scope =                SETUP;
	kam[SETUP_SELECT].description =               "Select item";
	kam[SETUP_SAVE_AND_EXIT].scope =         SETUP;
	kam[SETUP_SAVE_AND_EXIT].description =        "Save&Exit";
	kam[SETUP_SAVE_AND_RUN_GMU].scope =      SETUP;
	kam[SETUP_SAVE_AND_RUN_GMU].description =     "Save&Run Gmu";
	kam[SETUP_FB_SELECT].scope =             SETUP_FILE_BROWSER;
	kam[SETUP_FB_SELECT].description =            "Select item";
	kam[SETUP_FB_CHDIR].scope =              SETUP_FILE_BROWSER;
	kam[SETUP_FB_CHDIR].description =             "Change dir";
	kam[SETUP_FB_CANCEL].scope =             SETUP_FILE_BROWSER;
	kam[SETUP_FB_CANCEL].description =            "Cancel";
	kam[TRACKINFO_TOGGLE_COVER].scope =      TRACK_INFO;
	kam[TRACKINFO_TOGGLE_COVER].description =     "Toggle cover";
	kam[TRACKINFO_TOGGLE_TEXT].scope =       TRACK_INFO;
	kam[TRACKINFO_TOGGLE_TEXT].description =      "Toggle text";
	kam[TRACKINFO_DELETE_FILE].scope =       TRACK_INFO;
	kam[TRACKINFO_DELETE_FILE].description =      "Delete file";
	kam[QUESTION_YES].scope =                QUESTION;
	kam[QUESTION_YES].description =               "Yes";
	kam[QUESTION_NO].scope =                 QUESTION;
	kam[QUESTION_NO].description =                "No";
	kam[GLOBAL_PROGRAM_INFO].scope =         ANY;
	kam[GLOBAL_PROGRAM_INFO].description =        "About";
	kam[GLOBAL_EXIT].scope =                 ANY;
	kam[GLOBAL_EXIT].description =                "Exit";
	kam[GLOBAL_HOLD].scope =                 ANY;
	kam[GLOBAL_HOLD].description =                "Hold";
	kam[GLOBAL_TOGGLE_VIEW].scope =          ANY;
	kam[GLOBAL_NEXT].scope =                 ANY;
	kam[GLOBAL_PAUSE].scope =                ANY;
	kam[GLOBAL_STOP].scope =                 ANY;
	kam[GLOBAL_PREV].scope =                 ANY;
	kam[GLOBAL_SEEK_FWD].scope =             ANY;
	kam[GLOBAL_SEEK_BWD].scope =             ANY;
	kam[GLOBAL_INC_VOLUME].scope =           ANY;
	kam[GLOBAL_DEC_VOLUME].scope =           ANY;
	kam[GLOBAL_TOGGLE_TIME].scope =          ANY;
	kam[GLOBAL_SET_SHUTDOWN_TIMER].scope =   ANY;
	kam[GLOBAL_SET_SHUTDOWN_TIMER].description =  "Shutdown timer";
	kam[MOVE_CURSOR_UP].scope =              ANY;
	kam[MOVE_CURSOR_DOWN].scope =            ANY;
	kam[MOVE_CURSOR_LEFT].scope =            ANY;
	kam[MOVE_CURSOR_RIGHT].scope =           ANY;
	kam[MODIFIER].scope =                    ANY;
}

void key_action_mapping_set_defaults(KeyActionMapping *kam)
{
	int i;

	kam[FB_ADD_FILE_TO_PL_OR_CHDIR].button =   BUTTON_B;
	kam[FB_ADD_FILE_TO_PL_OR_CHDIR].modifier = 0;

	kam[FB_ADD_DIR_TO_PL].button =             BUTTON_Y;
	kam[FB_ADD_DIR_TO_PL].modifier =           0;

	kam[FB_INSERT_FILE_INTO_PL].button =       BUTTON_B;
	kam[FB_INSERT_FILE_INTO_PL].modifier =     1;

	kam[FB_PLAY_FILE].button =                 BUTTON_A;
	kam[FB_PLAY_FILE].modifier =               0;

	kam[FB_NEW_PL_FROM_DIR].button =           BUTTON_Y;
	kam[FB_NEW_PL_FROM_DIR].modifier =         1;

	kam[PL_PLAY_ITEM].button =                 BUTTON_B;
	kam[PL_PLAY_ITEM].modifier =               0;

	kam[PL_REMOVE_ITEM].button =               BUTTON_Y;
	kam[PL_REMOVE_ITEM].modifier =             0;

	kam[PL_CLEAR_PLAYLIST].button =            BUTTON_Y;
	kam[PL_CLEAR_PLAYLIST].modifier =          1;

	kam[PL_TOGGLE_RANDOM].button =             BUTTON_A;
	kam[PL_TOGGLE_RANDOM].modifier =           0;
	
	kam[PL_ENQUEUE].button =                   VOLUME_UP;
	kam[PL_ENQUEUE].modifier =                 1;

	kam[ABOUT_OKAY].button =                   BUTTON_B;
	kam[ABOUT_OKAY].modifier =                 0;

	kam[SETUP_SELECT].button =                 BUTTON_B;
	kam[SETUP_SELECT].modifier =               0;

	kam[SETUP_SAVE_AND_EXIT].button =          BUTTON_X;
	kam[SETUP_SAVE_AND_EXIT].modifier =        0;

	kam[SETUP_SAVE_AND_RUN_GMU].button =       BUTTON_Y;
	kam[SETUP_SAVE_AND_RUN_GMU].modifier =     0;

	kam[SETUP_FB_SELECT].button =              BUTTON_B;
	kam[SETUP_FB_SELECT].modifier =            0;

	kam[SETUP_FB_CHDIR].button =               BUTTON_A;
	kam[SETUP_FB_CHDIR].modifier =             0;
	
	kam[SETUP_FB_CANCEL].button =              BUTTON_X;
	kam[SETUP_FB_CANCEL].modifier =            0;

	kam[TRACKINFO_TOGGLE_COVER].button =       BUTTON_A;
	kam[TRACKINFO_TOGGLE_COVER].modifier =     0;

	kam[TRACKINFO_TOGGLE_TEXT].button =        BUTTON_B;
	kam[TRACKINFO_TOGGLE_TEXT].modifier =      0;

	kam[QUESTION_YES].button =                 BUTTON_B;
	kam[QUESTION_YES].modifier =               0;

	kam[QUESTION_NO].button =                  BUTTON_A;
	kam[QUESTION_NO].modifier =                0;

	kam[MOVE_CURSOR_UP].button =               BUTTON_UP;
	kam[MOVE_CURSOR_UP].modifier =             0;

	kam[MOVE_CURSOR_DOWN].button =             BUTTON_DOWN;
	kam[MOVE_CURSOR_DOWN].modifier =           0;

	kam[MOVE_CURSOR_LEFT].button =             BUTTON_LEFT;
	kam[MOVE_CURSOR_LEFT].modifier =           0;

	kam[MOVE_CURSOR_RIGHT].button =            BUTTON_RIGHT;
	kam[MOVE_CURSOR_RIGHT].modifier =          0;

	kam[GLOBAL_PROGRAM_INFO].button =          BUTTON_A;
	kam[GLOBAL_PROGRAM_INFO].modifier =        1;

	kam[GLOBAL_EXIT].button =                  BUTTON_START;
	kam[GLOBAL_EXIT].modifier =                1;

	kam[GLOBAL_HOLD].button =                  BUTTON_SELECT;
	kam[GLOBAL_HOLD].modifier =                1;

	kam[GLOBAL_TOGGLE_VIEW].button =           BUTTON_SELECT;
	kam[GLOBAL_TOGGLE_VIEW].modifier =         0;

	kam[GLOBAL_NEXT].button =                  BUTTON_R;
	kam[GLOBAL_NEXT].modifier =                0;

	kam[GLOBAL_PAUSE].button =                 BUTTON_START;
	kam[GLOBAL_PAUSE].modifier =               0;

	kam[GLOBAL_STOP].button =                  BUTTON_X;
	kam[GLOBAL_STOP].modifier =                0;

	kam[GLOBAL_PREV].button =                  BUTTON_L;
	kam[GLOBAL_PREV].modifier =                0;

	kam[GLOBAL_SEEK_FWD].button =              BUTTON_R;
	kam[GLOBAL_NEXT].modifier =                1;

	kam[GLOBAL_SEEK_BWD].button =              BUTTON_L;
	kam[GLOBAL_NEXT].modifier =                1;

	kam[GLOBAL_INC_VOLUME].button =            VOLUME_UP;
	kam[GLOBAL_INC_VOLUME].modifier =          0;

	kam[GLOBAL_DEC_VOLUME].button =            VOLUME_DOWN;
	kam[GLOBAL_DEC_VOLUME].modifier =          0;

	kam[MODIFIER].button =                     BUTTON_CLICK;
	kam[MODIFIER].modifier =                   0;

	for (i = LAST_ACTION; i--; ) {
		char *mod, *but = "";
		if (kam[i].modifier) mod = "Mod+"; else mod = "";
		switch (kam[i].button) {
			case BUTTON_A:
				but = "A";
				break;
			case BUTTON_B:
				but = "B";
				break;
			case BUTTON_X:
				but = "X";
				break;
			case BUTTON_Y:
				but = "Y";
				break;
			case BUTTON_L:
				but = "L";
				break;
			case BUTTON_R:
				but = "R";
				break;
			case BUTTON_START:
				but = "START";
				break;
			case BUTTON_SELECT:
				but = "SELECT";
				break;
			case BUTTON_CLICK:
				but = "STICK_CLICK";
				break;
			case BUTTON_LEFT:
				but = "LEFT";
				break;
			case BUTTON_RIGHT:
				but = "RIGHT";
				break;
			case BUTTON_UP:
				but = "UP";
				break;
			case BUTTON_DOWN:
				but = "DOWN";
				break;
		}
		snprintf(kam[i].button_name, BUTTON_NAME_MAX_LENGTH-1, "%s%s", mod, but);
		kam[i].button_name[BUTTON_NAME_MAX_LENGTH-1] = '\0';
	}
}

static int get_button(char *button_name, int *button, int *modifier)
{
	int result = 0, but = -99, mod = 0;

	if (button_name != NULL) {
		char *bname = button_name;
		int   offset = 0;

		if (strncmp(bname, "Mod+", 4) == 0) {
			mod = 1;
			bname += 4;
			offset = 4;
		}
		but = input_config_get_val(bname);
		result = 1;
		if (but != -99) {
			*button = but;
			*modifier = mod;
		}
	}
	return result;
}

int key_action_mapping_load_config(KeyActionMapping *kam, char *keymap_file)
{
	int        result = 0;
	ConfigFile keymapconf;

	cfg_init_config_file_struct(&keymapconf);
	if (cfg_read_config_file(&keymapconf, keymap_file) != 0) {
		printf("keymap: Could not read \"%s\". Assuming defaults.\n", keymap_file);
		key_action_mapping_set_defaults(kam);
		result = 1;
	} else {
		/* Check if all required key mappings are defined */
		if (!cfg_is_key_available(keymapconf, "Modifier") ||
		    !cfg_is_key_available(keymapconf, "Up") ||
		    !cfg_is_key_available(keymapconf, "Down") ||
		    !cfg_is_key_available(keymapconf, "Pause") ||
		    !cfg_is_key_available(keymapconf, "ProgramInfo") ||
		    !cfg_is_key_available(keymapconf, "Exit") ||
		    !cfg_is_key_available(keymapconf, "PlaylistPlayItem") ||
		    !cfg_is_key_available(keymapconf, "PlaylistClear") ||
		    !cfg_is_key_available(keymapconf, "FileBrowserAddFileToPlaylistOrChDir")) {
		    	result = 0;
		    	printf("keymap: At least one required key definition is missing!\n");
		} else { /* all required keys available */
			char *button_name;
			/* Assign key mappings as defined in the config file */
			button_name = cfg_get_key_value(keymapconf, "Modifier");
			get_button(button_name, &kam[MODIFIER].button, &kam[MODIFIER].modifier);
			if (button_name) strncpy(kam[MODIFIER].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "Left");
			get_button(button_name, &kam[MOVE_CURSOR_LEFT].button, &kam[MOVE_CURSOR_LEFT].modifier);
			if (button_name) strncpy(kam[MOVE_CURSOR_LEFT].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "Right");
			get_button(button_name, &kam[MOVE_CURSOR_RIGHT].button, &kam[MOVE_CURSOR_RIGHT].modifier);
			if (button_name) strncpy(kam[MOVE_CURSOR_RIGHT].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "Up");
			get_button(button_name, &kam[MOVE_CURSOR_UP].button, &kam[MOVE_CURSOR_UP].modifier);
			if (button_name) strncpy(kam[MOVE_CURSOR_UP].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "Down");
			get_button(button_name, &kam[MOVE_CURSOR_DOWN].button, &kam[MOVE_CURSOR_DOWN].modifier);
			if (button_name) strncpy(kam[MOVE_CURSOR_DOWN].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PageUp");
			get_button(button_name, &kam[PAGE_UP].button, &kam[PAGE_UP].modifier);
			if (button_name) strncpy(kam[PAGE_UP].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PageDown");
			get_button(button_name, &kam[PAGE_DOWN].button, &kam[PAGE_DOWN].modifier);
			if (button_name) strncpy(kam[PAGE_DOWN].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "IncreaseVolume");
			get_button(button_name,
			           &kam[GLOBAL_INC_VOLUME].button, &kam[GLOBAL_INC_VOLUME].modifier);
			if (button_name) strncpy(kam[GLOBAL_INC_VOLUME].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "DecreaseVolume");
			get_button(button_name,
			           &kam[GLOBAL_DEC_VOLUME].button, &kam[GLOBAL_DEC_VOLUME].modifier);
			if (button_name) strncpy(kam[GLOBAL_DEC_VOLUME].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "ToggleTime");
			get_button(button_name,
			           &kam[GLOBAL_TOGGLE_TIME].button, &kam[GLOBAL_TOGGLE_TIME].modifier);
			if (button_name) strncpy(kam[GLOBAL_TOGGLE_TIME].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "Pause");
			get_button(button_name, &kam[GLOBAL_PAUSE].button, &kam[GLOBAL_PAUSE].modifier);
			if (button_name) strncpy(kam[GLOBAL_PAUSE].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "Stop");
			get_button(button_name, &kam[GLOBAL_STOP].button, &kam[GLOBAL_STOP].modifier);
			if (button_name) strncpy(kam[GLOBAL_STOP].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "ToggleView");
			get_button(button_name, &kam[GLOBAL_TOGGLE_VIEW].button, &kam[GLOBAL_TOGGLE_VIEW].modifier);
			if (button_name) strncpy(kam[GLOBAL_TOGGLE_VIEW].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PreviousTrack");
			get_button(button_name, &kam[GLOBAL_PREV].button, &kam[GLOBAL_PREV].modifier);
			if (button_name) strncpy(kam[GLOBAL_PREV].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "NextTrack");
			get_button(button_name, &kam[GLOBAL_NEXT].button, &kam[GLOBAL_NEXT].modifier);
			if (button_name) strncpy(kam[GLOBAL_NEXT].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "SeekForward");
			get_button(button_name, &kam[GLOBAL_SEEK_FWD].button, &kam[GLOBAL_SEEK_FWD].modifier);
			if (button_name) strncpy(kam[GLOBAL_SEEK_FWD].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "SeekBackward");
			get_button(button_name, &kam[GLOBAL_SEEK_BWD].button, &kam[GLOBAL_SEEK_BWD].modifier);
			if (button_name) strncpy(kam[GLOBAL_SEEK_BWD].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "Hold");
			get_button(button_name, &kam[GLOBAL_HOLD].button, &kam[GLOBAL_HOLD].modifier);
			if (button_name) strncpy(kam[GLOBAL_HOLD].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "Exit");
			get_button(button_name, &kam[GLOBAL_EXIT].button, &kam[GLOBAL_EXIT].modifier);
			if (button_name) strncpy(kam[GLOBAL_EXIT].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "ProgramInfo");
			get_button(button_name, &kam[GLOBAL_PROGRAM_INFO].button, &kam[GLOBAL_PROGRAM_INFO].modifier);
			if (button_name) strncpy(kam[GLOBAL_PROGRAM_INFO].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "ShutdownTimer");
			get_button(button_name, &kam[GLOBAL_SET_SHUTDOWN_TIMER].button, &kam[GLOBAL_SET_SHUTDOWN_TIMER].modifier);
			if (button_name) strncpy(kam[GLOBAL_SET_SHUTDOWN_TIMER].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "SetupSelect");
			get_button(button_name, &kam[SETUP_SELECT].button, &kam[SETUP_SELECT].modifier);
			if (button_name) strncpy(kam[SETUP_SELECT].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "SetupSaveAndExit");
			get_button(button_name, &kam[SETUP_SAVE_AND_EXIT].button, &kam[SETUP_SAVE_AND_EXIT].modifier);
			if (button_name) strncpy(kam[SETUP_SAVE_AND_EXIT].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "SetupSaveAndRunGmu");
			get_button(button_name, &kam[SETUP_SAVE_AND_RUN_GMU].button, &kam[SETUP_SAVE_AND_RUN_GMU].modifier);
			if (button_name) strncpy(kam[SETUP_SAVE_AND_RUN_GMU].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "SetupFileBrowserSelect");
			get_button(button_name, &kam[SETUP_FB_SELECT].button, &kam[SETUP_FB_SELECT].modifier);
			if (button_name) strncpy(kam[SETUP_FB_SELECT].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "SetupFileBrowserChDir");
			get_button(button_name, &kam[SETUP_FB_CHDIR].button, &kam[SETUP_FB_CHDIR].modifier);
			if (button_name) strncpy(kam[SETUP_FB_CHDIR].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "SetupFileBrowserCancel");
			get_button(button_name, &kam[SETUP_FB_CANCEL].button, &kam[SETUP_FB_CANCEL].modifier);
			if (button_name) strncpy(kam[SETUP_FB_CANCEL].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "FileBrowserDirUp");
			get_button(button_name, &kam[FB_DIR_UP].button, &kam[FB_DIR_UP].modifier);
			if (button_name) strncpy(kam[FB_DIR_UP].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "FileBrowserChDir");
			get_button(button_name, &kam[FB_CHDIR].button, &kam[FB_CHDIR].modifier);
			if (button_name) strncpy(kam[FB_CHDIR].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "FileBrowserPlayFile");
			get_button(button_name, &kam[FB_PLAY_FILE].button, &kam[FB_PLAY_FILE].modifier);
			if (button_name) strncpy(kam[FB_PLAY_FILE].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "FileBrowserAddFileToPlaylistOrChDir");
			get_button(button_name,
			           &kam[FB_ADD_FILE_TO_PL_OR_CHDIR].button, &kam[FB_ADD_FILE_TO_PL_OR_CHDIR].modifier);
			if (button_name) strncpy(kam[FB_ADD_FILE_TO_PL_OR_CHDIR].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "FileBrowserAddDirToPlaylist");
			get_button(button_name,
			           &kam[FB_ADD_DIR_TO_PL].button, &kam[FB_ADD_DIR_TO_PL].modifier);
			if (button_name) strncpy(kam[FB_ADD_DIR_TO_PL].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "FileBrowserInsertFileIntoPlaylist");
			get_button(button_name,
			           &kam[FB_INSERT_FILE_INTO_PL].button, &kam[FB_INSERT_FILE_INTO_PL].modifier);
			if (button_name) strncpy(kam[FB_INSERT_FILE_INTO_PL].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "FileBrowserDeleteFile");
			get_button(button_name,
			           &kam[FB_DELETE_FILE].button, &kam[FB_DELETE_FILE].modifier);
			if (button_name) strncpy(kam[FB_DELETE_FILE].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "FileBrowserNewPlFromDir");
			get_button(button_name,
			           &kam[FB_NEW_PL_FROM_DIR].button, &kam[FB_NEW_PL_FROM_DIR].modifier);
			if (button_name) strncpy(kam[FB_NEW_PL_FROM_DIR].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PlaylistPlayItem");
			get_button(button_name, &kam[PL_PLAY_ITEM].button, &kam[PL_PLAY_ITEM].modifier);
			if (button_name) strncpy(kam[PL_PLAY_ITEM].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PlaylistToggleRandomMode");
			get_button(button_name, &kam[PL_TOGGLE_RANDOM].button, &kam[PL_TOGGLE_RANDOM].modifier);
			if (button_name) strncpy(kam[PL_TOGGLE_RANDOM].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PlaylistRemoveItem");
			get_button(button_name, &kam[PL_REMOVE_ITEM].button, &kam[PL_REMOVE_ITEM].modifier);
			if (button_name) strncpy(kam[PL_REMOVE_ITEM].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PlaylistClear");
			get_button(button_name, &kam[PL_CLEAR_PLAYLIST].button, &kam[PL_CLEAR_PLAYLIST].modifier);
			if (button_name) strncpy(kam[PL_CLEAR_PLAYLIST].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PlaylistDeleteFile");
			get_button(button_name,
			           &kam[PL_DELETE_FILE].button, &kam[PL_DELETE_FILE].modifier);
			if (button_name) strncpy(kam[PL_DELETE_FILE].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PlaylistSave");
			get_button(button_name,
			           &kam[PL_SAVE_PLAYLIST].button, &kam[PL_SAVE_PLAYLIST].modifier);
			if (button_name) strncpy(kam[PL_SAVE_PLAYLIST].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PlaylistQueue");
			get_button(button_name,
			           &kam[PL_ENQUEUE].button, &kam[PL_ENQUEUE].modifier);
			if (button_name) strncpy(kam[PL_ENQUEUE].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PlaylistSaveSelect");
			get_button(button_name,
			           &kam[PLMANAGER_SELECT].button, &kam[PLMANAGER_SELECT].modifier);
			if (button_name) strncpy(kam[PLMANAGER_SELECT].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PlaylistSaveCancel");
			get_button(button_name,
			           &kam[PLMANAGER_CANCEL].button, &kam[PLMANAGER_CANCEL].modifier);
			if (button_name) strncpy(kam[PLMANAGER_CANCEL].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PlaylistSaveLoadList");
			get_button(button_name,
			           &kam[PLMANAGER_LOAD].button, &kam[PLMANAGER_LOAD].modifier);
			if (button_name) strncpy(kam[PLMANAGER_LOAD].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "PlaylistSaveAppendList");
			get_button(button_name,
			           &kam[PLMANAGER_LOAD_APPEND].button, &kam[PLMANAGER_LOAD_APPEND].modifier);
			if (button_name) strncpy(kam[PLMANAGER_LOAD_APPEND].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "ProgramInfoOkay");
			get_button(button_name, &kam[ABOUT_OKAY].button, &kam[ABOUT_OKAY].modifier);
			if (button_name) strncpy(kam[ABOUT_OKAY].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "TrackInfoToggleCover");
			get_button(button_name,
			           &kam[TRACKINFO_TOGGLE_COVER].button, &kam[TRACKINFO_TOGGLE_COVER].modifier);
			if (button_name) strncpy(kam[TRACKINFO_TOGGLE_COVER].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "TrackInfoToggleText");
			get_button(button_name,
			           &kam[TRACKINFO_TOGGLE_TEXT].button, &kam[TRACKINFO_TOGGLE_TEXT].modifier);
			if (button_name) strncpy(kam[TRACKINFO_TOGGLE_TEXT].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			/*button_name = cfg_get_key_value(keymapconf, "TrackInfoDeleteFile");
			get_button(button_name,
			           &kam[TRACKINFO_DELETE_FILE].button, &kam[TRACKINFO_DELETE_FILE].modifier);
			if (button_name) strncpy(kam[TRACKINFO_DELETE_FILE].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);*/

			button_name = cfg_get_key_value(keymapconf, "QuestionYes");
			get_button(button_name,
			           &kam[QUESTION_YES].button, &kam[QUESTION_YES].modifier);
			if (button_name) strncpy(kam[QUESTION_YES].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			button_name = cfg_get_key_value(keymapconf, "QuestionNo");
			get_button(button_name,
			           &kam[QUESTION_NO].button, &kam[QUESTION_NO].modifier);
			if (button_name) strncpy(kam[QUESTION_NO].button_name, button_name, BUTTON_NAME_MAX_LENGTH-1);

			result = 1;
			printf("keymap: Key map \"%s\" loaded successfully.\n", keymap_file);
		}		
	}
	cfg_free_config_file_struct(&keymapconf);
	return result;
}

int key_action_mapping_get_action(KeyActionMapping *kam, int button, int modifier, View view)
{
	int user_key_action = -1, i;
	for (i = 0; i < LAST_ACTION; i++) {
		if (kam[i].button == button && kam[i].modifier == modifier &&
		    (kam[i].scope == ANY || kam[i].scope == view)) {
			user_key_action = i;
			break;
		}
	}
	return user_key_action;
}

char *key_action_mapping_get_button_name(KeyActionMapping *kam, UserAction action)
{
	return (kam[action].modifier ? kam[action].button_name+4 : kam[action].button_name);
}

void key_action_mapping_generate_help_string(KeyActionMapping *kam, char *target, int target_size, int modifier, View view)
{
	char tmp1[256] = "", tmp2[256] = "";
	int  i, toggle = 0;

	for (i = 0; i <= GLOBAL_HOLD; i++) {
		if ((kam[i].scope == view || kam[i].scope == ANY) &&
		    kam[i].modifier == modifier && kam[i].button >= 0) {
			if (!toggle)
				snprintf(tmp2, 255, "%s**%s:**%s ", tmp1,
				         key_action_mapping_get_button_name(kam, i), kam[i].description);
			else
				snprintf(tmp1, 255, "%s**%s:**%s ", tmp2,
				         key_action_mapping_get_button_name(kam, i), kam[i].description);
			toggle = !toggle;
		}
	}
	if (toggle)
		strncpy(target, tmp2, target_size);
	else
		strncpy(target, tmp1, target_size);
	target[target_size-1] = '\0';
}
