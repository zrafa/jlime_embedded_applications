/* 
 * Gmu Music Player
 *
 * Copyright (c) 2006-2010 Johannes Heimansberg (wejp.k.vu)
 *
 * File: sdl.c  Created: 060929
 *
 * Description: Gmu SDL frontend
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 2 of
 * the License. See the file COPYING in the Gmu's main directory
 * for details.
 */
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <pthread.h>
#include "SDL.h"
#include "SDL_image.h"
#include "../../util.h"
#include "../../gmufrontend.h"
#include "../../core.h"
#include "../../fileplayer.h"
#include "../../playlist.h"
#include "../../trackinfo.h"
#include "../../decloader.h"  /* for decoders list */
#include "../../gmudecoder.h" /* for decoders list */

#include "../../hw.h"
#include "../../wejpconfig.h"
#include "../../m3u.h"
#include "../../pbstatus.h"

#include "textrenderer.h"
#include "filebrowser.h"
#include "plbrowser.h"
#include "coverviewer.h"
#include "kam.h"
#include "skin.h"
#include "textbrowser.h"
#include "playerdisplay.h"
#include "question.h"
#include "about.h"
#include "plmanager.h"
#include "inputconfig.h"

#define FPS          10
#define FRAME_SKIP    1
#define NOTICE_DELAY  8

#define TIMER_ELAPSED -1234

#define CPU_CLOCK_NORMAL       200
#define CPU_CLOCK_LOW_PLAYBACK 150

#define SCREEN_UPDATE_TIMER_ELAPSED 42

static ConfigFile  *config = NULL;
Skin                skin;
static View         view, old_view;
static CoverViewer  cv;
static Question     dlg;
static SDL_TimerID  tid;

typedef enum Update { UPDATE_NONE = 0, UPDATE_DISPLAY = 2, UPDATE_HEADER = 4,
                      UPDATE_FOOTER = 8, UPDATE_TEXTAREA = 16, UPDATE_ALL = 2+4+8+16 } Update;
static Update       update = UPDATE_ALL;
static int          initialized = 0;

static char         base_dir[256];

typedef enum Quit { DONT_QUIT, QUIT_WITH_ERROR, QUIT_WITHOUT_ERROR } Quit;
static Quit         quit = DONT_QUIT;

typedef enum GlobalCommand { NO_CMD, PLAY, PAUSE, STOP, NEXT, PREVIOUS, PLAY_ITEM } GlobalCommand;
GlobalCommand      global_command = NO_CMD;
int                global_param = 0;

static GmuEvent    update_event = 0;


static SDL_Surface *init_sdl(int with_joystick)
{
	SDL_Surface *display;

	if (SDL_InitSubSystem(SDL_INIT_VIDEO | (with_joystick ? SDL_INIT_JOYSTICK : 0)) < 0) {
		printf("sdl_frontend: ERROR: Could not initialize SDL: %s\n", SDL_GetError());
		exit(1);
	}

	display = SDL_SetVideoMode(HW_SCREEN_WIDTH, HW_SCREEN_HEIGHT, HW_COLOR_DEPTH, SDL_HWSURFACE | SDL_HWACCEL | SDL_RESIZABLE);
	if (display == NULL) {
		printf("sdl_frontend: ERROR: Could not initialize screen: %s\n", SDL_GetError());
		exit(1);
	}
#ifndef _UNKNOWN_SYSTEM
	SDL_ShowCursor(0);
#endif
	if (with_joystick) {
		printf("sdl_frontend: Opening joystick device.\n");
		SDL_JoystickOpen(0);
	}
	SDL_WM_SetCaption("Gmu", NULL);
	SDL_EnableUNICODE(1);
	printf("sdl_frontend: SDL-Video init done.\n");
	return display;
}

static Uint32 timer_callback(Uint32 interval, void *param)
{
	SDL_Event     event;
	SDL_UserEvent userevent;

	userevent.type  = SDL_USEREVENT;
	userevent.code  = SCREEN_UPDATE_TIMER_ELAPSED;
	userevent.data1 = NULL;
	userevent.data2 = NULL; 

	event.type = SDL_USEREVENT;
	event.user = userevent;

	SDL_PushEvent(&event);
	return interval;
}

static PB_Status play_file(char *file, TrackInfo *ti, CoverViewer *cv)
{
	gmu_core_play_file(file);
	return file_player_get_playback_status();
}

static int play_next(TrackInfo *ti, CoverViewer *cv)
{
	return gmu_core_next();
}

static int play_previous(TrackInfo *ti, CoverViewer *cv)
{
	return gmu_core_previous();
}

static void add_m3u_contents_to_playlist(char *filename)
{
	M3u m3u;
	if (m3u_open_file(&m3u, filename)) {
		while (m3u_read_next_item(&m3u)) {
		   gmu_core_playlist_add_item(m3u_current_item_get_full_path(&m3u),
		                              m3u_current_item_get_title(&m3u));
		}
		m3u_close_file(&m3u);
	}
}

struct _fb_delete_params {
	char        *file;
	FileBrowser *fb;
};

static void fb_delete_func(void *arg)
{
	struct _fb_delete_params *p = (struct _fb_delete_params *)arg;
	if (p->file != NULL) {
		printf("sdl_frontend: Delete file %s\n", p->file);
		if (remove(p->file) == 0) {
			player_display_set_notice_message("FILE DELETED!", NOTICE_DELAY);
			file_browser_change_dir(p->fb, ".");
		} else {
			player_display_set_notice_message("COULD NOT DELETE FILE!", NOTICE_DELAY);
		}
	}
}

static int file_browser_process_action(FileBrowser *fb, PlaylistBrowser *pb, 
                                       TrackInfo   *ti, CoverViewer *cv,
                                       int          user_key_action,
                                       int          items_skip)
{
	Update                          update = UPDATE_NONE;
	char                            cwd[256];
	static char                     path[256];
	static struct _fb_delete_params fdp;

	switch (user_key_action) {
		case FB_PLAY_FILE:
			if (!file_browser_selection_is_dir(fb)) {
				gmu_core_playlist_set_current(NULL);
				if (getcwd(cwd, 255) != NULL) {
					snprintf(path, 255, "%s/%s", cwd,
					         file_browser_get_selected_file(fb));
					play_file(path, ti, cv);
				}
			}
			break;
		case FB_ADD_DIR_TO_PL:
			if (file_browser_selection_is_dir(fb)) {
				if (gmu_core_playlist_add_dir(file_browser_get_selected_file(fb)))
					player_display_set_notice_message("ADDING DIRECTORY...", NOTICE_DELAY);
				else
					player_display_set_notice_message("ALREADY ADDING A DIRECTORY", NOTICE_DELAY);
				update = UPDATE_ALL;
			} else {
				player_display_set_notice_message("NOT A DIRECTORY", NOTICE_DELAY);
			}
			break;
		case FB_NEW_PL_FROM_DIR:
			if (file_browser_selection_is_dir(fb)) {
				pl_browser_playlist_clear(pb);
				player_display_set_notice_message("CREATING NEW PLAYLIST...", NOTICE_DELAY);
				if (gmu_core_playlist_add_dir(file_browser_get_selected_file(fb)))
					player_display_set_notice_message("DIRECTORY ADDED", NOTICE_DELAY);
				update = UPDATE_ALL;
			} else {
				player_display_set_notice_message("NOT A DIRECTORY", NOTICE_DELAY);
			}
			break;
		case FB_DIR_UP:
			file_browser_change_dir(fb, "..");
			update = UPDATE_ALL;
			break;
		case FB_CHDIR:
			if (file_browser_selection_is_dir(fb)) {
				file_browser_change_dir(fb, file_browser_get_selected_file(fb));
				update = UPDATE_ALL;
			}
			break;
		case FB_ADD_FILE_TO_PL_OR_CHDIR:
		case FB_INSERT_FILE_INTO_PL:
			if (file_browser_selection_is_dir(fb)) {
				file_browser_change_dir(fb, file_browser_get_selected_file(fb));
				update = UPDATE_ALL;
			} else {
				char  filetype[16] = "(none)";
				char *tmp = get_file_extension(file_browser_get_selected_file(fb));
				if (tmp != NULL)
					strtoupper(filetype, tmp, 15);
				if (strcmp(filetype, "M3U") == 0) {
					printf("sdl_frontend: M3U detected.\n");
					add_m3u_contents_to_playlist(file_browser_get_selected_file(fb));
					player_display_set_notice_message("M3U ADDED TO PLAYLIST", NOTICE_DELAY);
				} else {
					if (getcwd(cwd, 255) != NULL) {
						snprintf(path, 255, "%s/%s", cwd,
						         file_browser_get_selected_file(fb));
						if (user_key_action == FB_INSERT_FILE_INTO_PL) { /* insert item */
							Entry *sel_entry = gmu_core_playlist_get_first();
							int    i;

							printf("sdl_frontend: Inserting entry after %d...\n", pl_browser_get_selection(pb));
							for (i = 0;
							     i < gmu_core_playlist_get_length() && i != pl_browser_get_selection(pb);
							     i++) {
								sel_entry = playlist_get_next(sel_entry);
							}
							gmu_core_playlist_insert_file_after(sel_entry, path);
							pl_brower_move_selection_down(pb);
							player_display_set_notice_message("ITEM INSERTED IN PLAYLIST", NOTICE_DELAY);
						} else { /* add item */
							gmu_core_playlist_add_file(path);
							player_display_set_notice_message("ITEM ADDED TO PLAYLIST", NOTICE_DELAY);
						}
					}
				}
			}
			break;
		case FB_DELETE_FILE:
			if (!file_browser_selection_is_dir(fb)) {
				char buf[128], *bufptr;
				if (getcwd(cwd, 255) != NULL) {
					snprintf(path, 255, "%s/%s", cwd,
				         	file_browser_get_selected_file(fb));
				}
				bufptr = file_browser_get_selected_file(fb);
				bufptr = charset_filename_convert_alloc(bufptr);
				snprintf(buf, 127, "Delete \"%s\"?", bufptr);
				free(bufptr);
				fdp.fb = fb;
				fdp.file = path;
				question_set(&dlg, FILE_BROWSER, &view, buf, &fb_delete_func, &fdp);
				view = QUESTION;
				update = UPDATE_ALL;
			} else {
				player_display_set_notice_message("CANNOT DELETE DIRECTORIES!", NOTICE_DELAY);
			}
			break;
		case MOVE_CURSOR_DOWN:
			file_browser_move_selection_n_items_down(fb, items_skip);
			update = UPDATE_TEXTAREA;
			break;
		case MOVE_CURSOR_UP:
			file_browser_move_selection_n_items_up(fb, items_skip);
			update = UPDATE_TEXTAREA;
			break;
		case MOVE_CURSOR_LEFT:
			file_browser_scroll_horiz(fb, -1);
			update = UPDATE_TEXTAREA;
			break;
		case MOVE_CURSOR_RIGHT:
			file_browser_scroll_horiz(fb, +1);
			update = UPDATE_TEXTAREA;
			break;
		case PAGE_DOWN:
			file_browser_move_selection_n_items_down(fb, skin_textarea_get_number_of_lines((Skin *)fb->skin));
			update = UPDATE_TEXTAREA;
			break;
		case PAGE_UP:
			file_browser_move_selection_n_items_up(fb, skin_textarea_get_number_of_lines((Skin *)fb->skin));
			update = UPDATE_TEXTAREA;
			break;
	}
	return update;
}

struct _pb_delete_params {
	PlaylistBrowser *pb;
	CoverViewer     *cv;
	TrackInfo       *ti;
};

static void pb_delete_func(void *arg)
{
	struct _pb_delete_params *p = (struct _pb_delete_params *)arg;
	Entry                    *entry = gmu_core_playlist_get_first();
	int                       i = 0;
	if (entry != NULL) {
		char *f;
		while (i < pl_browser_get_selection(p->pb)) {
			entry = playlist_get_next(entry);
			i++;
		}
		if (pl_browser_are_selection_and_current_entry_equal(p->pb)) {
			if (!play_next(p->ti, p->cv)) {
				gmu_core_stop();
			}
		}
		f = gmu_core_playlist_get_entry_filename(entry);
		printf("sdl_frontend: Delete file %s.\n", f);
		if (remove(f) == 0)
			player_display_set_notice_message("FILE DELETED!", NOTICE_DELAY);
		else
			player_display_set_notice_message("COULD NOT DELETE FILE!", NOTICE_DELAY);
		pl_browser_playlist_remove_selection(p->pb);
	}
}

static int playlist_browser_process_action(PlaylistBrowser *pb, TrackInfo *ti,
                                           CoverViewer     *cv,
                                           int              user_key_action,
                                           int              items_skip)
{
	Entry                           *entry;
	int                              i;
	Update                           update = UPDATE_NONE;
	static struct _pb_delete_params  pdp;
	static char                      buf[128];
	char                            *notice_msg = NULL;

	switch (user_key_action) {
		case PL_TOGGLE_RANDOM:
			switch (gmu_core_playlist_cycle_play_mode()) {
				case PM_CONTINUE:
					notice_msg = "PLAYMODE: CONTINUE";
					break;
				case PM_RANDOM:
					notice_msg = "PLAYMODE: RANDOM";
					break;
				case PM_RANDOM_REPEAT:
					notice_msg = "PLAYMODE: RANDOM+REPEAT";
					break;
				case PM_REPEAT_1:
					notice_msg = "PLAYMODE: REPEAT TRACK";
					break;
				case PM_REPEAT_ALL:
					notice_msg = "PLAYMODE: REPEAT ALL";
					break;
			}
			player_display_set_notice_message(notice_msg, NOTICE_DELAY);
			break;
		case PL_PLAY_ITEM:
			gmu_core_play_pl_item(pl_browser_get_selection(pb));
			/*entry = playlist_get_entry(pb->pl, pl_browser_get_selection(pb));
			if (entry != NULL) {
				if (playlist_get_play_mode(gmu_core_get_playlist()) == PM_RANDOM ||
				    playlist_get_play_mode(gmu_core_get_playlist()) == PM_RANDOM_REPEAT)
					playlist_reset_random(pb->pl);
				playlist_set_current(pb->pl, entry);
				play_file(playlist_get_entry_filename(entry), ti, cv);
			} else {
				player_display_set_notice_message("PLAYLIST IS EMPTY", NOTICE_DELAY);
			}*/
			update = UPDATE_ALL;
			break;
		case PL_CLEAR_PLAYLIST:
			pl_browser_playlist_clear(pb);
			player_display_set_notice_message("PLAYLIST CLEARED", NOTICE_DELAY);
			update = UPDATE_ALL;
			break;					
		case PL_REMOVE_ITEM:
			if (pl_browser_are_selection_and_current_entry_equal(pb)) {
				if (!play_next(ti, cv)) {
					gmu_core_stop();
				}
			}
			pl_browser_playlist_remove_selection(pb);
			update = UPDATE_ALL;
			break;
		case PL_DELETE_FILE:
			pdp.pb = pb;
			pdp.ti = ti;
			pdp.cv = cv;
			entry = gmu_core_playlist_get_first();
			i = 0;
			if (entry != NULL) {
				char buf2[128], *bufptr;
				if (gmu_core_playlist_get_play_mode() == PM_RANDOM ||
				    gmu_core_playlist_get_play_mode() == PM_RANDOM_REPEAT)
					gmu_core_playlist_reset_random();
				while (i < pl_browser_get_selection(pb)) {
					entry = playlist_get_next(entry);
					i++;
				}
				bufptr = strrchr(gmu_core_playlist_get_entry_filename(entry), '/')+1;
				if (pl_browser_get_filenames_charset(pb) == UTF_8) {
					charset_utf8_to_iso8859_1(buf2, bufptr, 127);
					bufptr = buf2;
				}
				snprintf(buf, 127, "Delete \"%s\"?", bufptr);
				question_set(&dlg, PLAYLIST, &view, buf, &pb_delete_func, (void *)&pdp);
				view = QUESTION;
				update = UPDATE_ALL;
			}
			break;
		case PL_SAVE_PLAYLIST:
			view = PLAYLIST_SAVE;
			update = UPDATE_ALL;
			break;
		case PL_ENQUEUE:
			gmu_core_playlist_entry_enqueue(pl_browser_get_selected_entry(pb));
			update = UPDATE_TEXTAREA;
			break;
		case MOVE_CURSOR_DOWN:
			pl_brower_move_selection_n_items_down(pb, items_skip);
			update = UPDATE_TEXTAREA;
			break;
		case MOVE_CURSOR_UP:
			pl_brower_move_selection_n_items_up(pb, items_skip);
			update = UPDATE_TEXTAREA;
			break;
		case MOVE_CURSOR_LEFT:
			pl_browser_scroll_horiz(pb, -1);
			update = UPDATE_TEXTAREA;
			break;
		case MOVE_CURSOR_RIGHT:
			pl_browser_scroll_horiz(pb, +1);
			update = UPDATE_TEXTAREA;
			break;
		case PAGE_DOWN:
			pl_brower_move_selection_n_items_down(pb, skin_textarea_get_number_of_lines((Skin *)pb->skin));
			update = UPDATE_TEXTAREA;
			break;
		case PAGE_UP:
			pl_brower_move_selection_n_items_up(pb, skin_textarea_get_number_of_lines((Skin *)pb->skin));
			update = UPDATE_TEXTAREA;
			break;
	}
	return update;
}

static int cover_viewer_process_action(CoverViewer *cv, int user_key_action)
{
	Update update = UPDATE_NONE;
	switch (user_key_action) {
		case TRACKINFO_TOGGLE_COVER:
			cover_viewer_toggle_cover_visible(cv);
			update = UPDATE_TEXTAREA | UPDATE_HEADER;
			break;
		case TRACKINFO_TOGGLE_TEXT:
			cover_viewer_toggle_text_visible(cv);
			update = UPDATE_TEXTAREA | UPDATE_HEADER;
			break;
		case TRACKINFO_DELETE_FILE:
			printf("sdl_frontend: Cannot delete file from here.\n");
			break;
		case MOVE_CURSOR_DOWN:
			cover_viewer_scroll_down(cv);
			update = UPDATE_TEXTAREA | UPDATE_HEADER;
			break;
		case MOVE_CURSOR_UP:
			cover_viewer_scroll_up(cv);
			update = UPDATE_TEXTAREA | UPDATE_HEADER;
			break;
		case MOVE_CURSOR_LEFT:
			cover_viewer_scroll_left(cv);
			update = UPDATE_TEXTAREA | UPDATE_HEADER;
			break;
		case MOVE_CURSOR_RIGHT:
			cover_viewer_scroll_right(cv);
			update = UPDATE_TEXTAREA | UPDATE_HEADER;
			break;
	}
	return update;
}

void run_player(char *skin_name, char *decoders_str)
{
	SDL_Surface     *display = NULL;
	SDL_Surface     *buffer = NULL;
	SDL_Event        event;

	FileBrowser      fb;
	PlaylistBrowser  pb;
	TextBrowser      tb_about;
	PlaylistManager  ps;

	int              button = -1;
	int              modifier = 0, hold_state = 0, allow_volume_control_in_hold_state = 0;
	int              time_remaining = 0;
	int              update_display = 1;
	int              button_repeat_timer = -1, items_skip = 1, frame_skip_counter = FRAME_SKIP;
	int              seconds_until_backlight_poweroff = 0, backlight_poweroff_timer = -1;
	int              backlight_poweron_on_track_change = 0, auto_select_cur_item = 1;
	int              seek_step = 10;

	KeyActionMapping kam[LAST_ACTION];
	int              user_key_action = -1;
	TrackInfo       *ti = gmu_core_get_current_trackinfo_ref();

	/* Input device configuration */
	{
		char tmp[256], *inputconf = NULL;
		inputconf = cfg_get_key_value(*config, "InputConfigFile");
		if (!inputconf) inputconf = "gmuinput.conf";
		snprintf(tmp, 255, "%s/%s", gmu_core_get_config_dir(), inputconf);
		input_config_init(tmp);
	}

	display = init_sdl(input_config_has_joystick());

	auto_select_cur_item = strncmp(cfg_get_key_value(*config, 
	                               "AutoSelectCurrentPlaylistItem"),
	                               "yes", 3) == 0 ? 1 : 0;

	time_remaining = strncmp(cfg_get_key_value(*config, "TimeDisplay"), 
	                         "remaining", 9) == 0 ? 1 : 0;

	backlight_poweron_on_track_change = strncmp(cfg_get_key_value(*config, 
	                                            "BacklightPowerOnOnTrackChange"),
	                                            "yes", 3) == 0 ? 1 : 0;

	file_player_set_lyrics_file_pattern(cfg_get_key_value(*config, "LyricsFilePattern"));

	old_view = view = FILE_BROWSER;

	/* Initialize and load button mapping */
	{
		char tmp[256], *keymap_file;
		key_action_mapping_init(kam);
		keymap_file = cfg_get_key_value(*config, "KeyMap");
		if (keymap_file) {
			snprintf(tmp, 255, "%s/%s", gmu_core_get_config_dir(), keymap_file);
			if (!key_action_mapping_load_config(kam, tmp))
				quit = QUIT_WITH_ERROR;
		} else {
			quit = QUIT_WITH_ERROR;
		}
	}

	if (!skin_init(&skin, skin_name)) quit = QUIT_WITH_ERROR;

	if (quit == DONT_QUIT) {
		SDL_Surface *tmp = SDL_CreateRGBSurface(SDL_SWSURFACE, HW_SCREEN_WIDTH,
		                                        HW_SCREEN_HEIGHT, HW_COLOR_DEPTH, 0, 0, 0, 0);
		buffer = SDL_DisplayFormat(tmp);
		SDL_FreeSurface(tmp);

		question_init(&dlg, &skin);

		dir_set_ext_filter(gmu_core_get_file_extensions(), 1);
		if (strncmp(cfg_get_key_value(*config, "FileSystemCharset"), "UTF-8", 5) == 0) {
			file_browser_init(&fb, &skin, UTF_8);
			pl_browser_init(&pb, &skin, UTF_8);
			charset_filename_set(UTF_8);
		} else {
			file_browser_init(&fb, &skin, ISO_8859_1);
			pl_browser_init(&pb, &skin, ISO_8859_1);
			charset_filename_set(ISO_8859_1);
		}

		{
			int directories_first = 0;
			directories_first = strncmp(cfg_get_key_value(*config, 
														  "FileBrowserFoldersFirst"),
														  "yes", 3) == 0 ? 1 : 0;
			file_browser_set_directories_first(&fb, directories_first);
			if (!chdir(cfg_get_key_value(*config, "DefaultFileBrowserPath"))) {
				printf("sdl_frontend: WARNING: Could not open DefaultFileBrowserPath for reading!\n");
				printf("sdl_frontend: The current directory will be used instead.\n");
			}
			dir_read(&fb.dir, ".", directories_first);
		}

		about_init(&tb_about, &skin, decoders_str);
		cover_viewer_init(&cv, &skin, 
		                  strncmp(cfg_get_key_value(*config, "CoverArtworkLarge"), "yes", 3) == 0 ? 
		                  1 : 0,
		                  strncmp(cfg_get_key_value(*config, "SmallCoverArtworkAlignment"), "left", 4) == 0 ?
		                  ALIGN_LEFT : ALIGN_RIGHT,
		                  strncmp(cfg_get_key_value(*config, "LoadEmbeddedCoverArtwork"), "first", 5) == 0 ? 
		                  EMBEDDED_COVER_FIRST : 
		                  (strncmp(cfg_get_key_value(*config, "LoadEmbeddedCoverArtwork"), "last", 4) == 0 ?
		                  EMBEDDED_COVER_LAST : EMBEDDED_COVER_NO));
		plmanager_init(&ps, cfg_get_key_value(*config, "PlaylistSavePresets"), &skin);

		if (strncmp(cfg_get_key_value(*config, "Scroll"), "auto", 3) == 0)
			player_display_set_scrolling(SCROLL_AUTO);
		if (strncmp(cfg_get_key_value(*config, "Scroll"), "always", 3) == 0)
			player_display_set_scrolling(SCROLL_ALWAYS);
		if (strncmp(cfg_get_key_value(*config, "Scroll"), "never", 3) == 0)
			player_display_set_scrolling(SCROLL_NEVER);
		player_display_set_notice_message("GMU "VERSION_NUMBER, 10);

		if (strncmp(cfg_get_key_value(*config, "AllowVolumeControlInHoldState"), "yes", 3) == 0)
			allow_volume_control_in_hold_state = 1;

		seconds_until_backlight_poweroff = 
			atoi(cfg_get_key_value(*config, "SecondsUntilBacklightPowerOff"));
		seconds_until_backlight_poweroff = (seconds_until_backlight_poweroff > 0 ? 
		                                    seconds_until_backlight_poweroff : -1);

		backlight_poweroff_timer = seconds_until_backlight_poweroff * FPS;
		tid = SDL_AddTimer(1000 / FPS, timer_callback, NULL);

		if (gmu_core_playlist_get_length() > 0) {
			view = PLAYLIST;
			/*if (playlist_next(gmu_core_get_playlist())) {
				Entry *entry = playlist_get_current(gmu_core_get_playlist());
				if (entry != NULL)
					play_file(playlist_get_entry_filename(entry), ti, &cv);
			}*/
			update = UPDATE_ALL;
		} else {
			if (strncmp(cfg_get_key_value(*config, "RememberLastPlaylist"), "yes", 3) == 0) {
				char temp[256];
				snprintf(temp, 255, "%s/playlist.m3u", base_dir);
				add_m3u_contents_to_playlist(temp);
				if (gmu_core_playlist_get_length() > 0) {
					view = PLAYLIST;
					if (strncmp(cfg_get_key_value(*config, "AutoPlayOnProgramStart"), "yes", 3) == 0) {
						if (play_next(ti, &cv)) {
							if (auto_select_cur_item)
								pl_browser_set_selection(&pb, gmu_core_playlist_get_current_position());
						}
					}
				}
			}
		}
	}

	initialized = 1;

	while (SDL_WaitEvent(&event) && quit == DONT_QUIT) {
		switch (event.type) {
			case SDL_VIDEORESIZE: {
				SDL_Surface *tmp = SDL_CreateRGBSurface(SDL_SWSURFACE, event.resize.w, event.resize.h, HW_COLOR_DEPTH, 0, 0, 0, 0);
				SDL_FreeSurface(buffer);
				buffer = SDL_DisplayFormat(tmp);
				SDL_FreeSurface(tmp);
				/*printf("sdl_frontend: Window resized: %d x %d\n", event.resize.w, event.resize.h);*/
				display = SDL_SetVideoMode(event.resize.w, event.resize.h, HW_COLOR_DEPTH, SDL_HWSURFACE | SDL_HWACCEL | SDL_RESIZABLE);
				if (!display) exit(-2); /* should not happen */
				update = UPDATE_ALL;
				break;
			}
			case SDL_KEYUP:
			case SDL_JOYBUTTONUP:
				switch (event.type) {
					case SDL_KEYUP:       button = event.key.keysym.sym; break;
					case SDL_JOYBUTTONUP: button = event.jbutton.button; break;
					default: break;
				}

				if (modifier && key_action_mapping_get_action(kam, button, 0, view) == MODIFIER) {
					modifier = 0;
					update = UPDATE_FOOTER;
				}
				button_repeat_timer = -1;
				seek_step = 10;
				break;
			case SDL_JOYAXISMOTION:
				/*printf("sdl_frontend: Joy axis motion: %d (axis %d)\n", event.jaxis.value, event.jaxis.axis);*/
				break;
			case SDL_JOYHATMOTION:
				printf("sdl_frontend: Joy Hat motion\n");
				break;
			default:
				break;
		}

		if (button_repeat_timer == 0) {
			backlight_poweroff_timer = seconds_until_backlight_poweroff * FPS;
			items_skip = 2;
		} else {
			items_skip = 1;
		}

		if (event.type == SDL_KEYDOWN || event.type == SDL_JOYBUTTONDOWN ||
		    (button_repeat_timer == 0 && user_key_action > 0)) {
			switch (event.type) {
				case SDL_KEYDOWN:       button = event.key.keysym.sym; break;
				case SDL_JOYBUTTONDOWN: button = event.jbutton.button; break;
				default: break;
			}

			/*printf("sdl_frontend: button=%d char=%c\n", button, event.key.keysym.unicode <= 127 && event.key.keysym.unicode >= 32 ? event.key.keysym.unicode : '?');*/

			/* Reinitialize random seed each time a button is pressed: */
			srand(time(NULL));

			if (backlight_poweroff_timer == TIMER_ELAPSED && !hold_state) {
				/* Restore background: */
				skin_update_bg(&skin, display, buffer);
				update_display = 1;
				hw_display_on();
			}

			backlight_poweroff_timer = seconds_until_backlight_poweroff * FPS;

			if (button_repeat_timer != 0) {
				button_repeat_timer = 2;
				user_key_action = key_action_mapping_get_action(kam, button, modifier, view);
			} else {
				/* Disable button repeat for everything but scroll actions,
				 * volume control and seeking: */
				if (user_key_action != MOVE_CURSOR_UP   &&
				    user_key_action != MOVE_CURSOR_DOWN &&
				    user_key_action != MOVE_CURSOR_LEFT &&
				    user_key_action != MOVE_CURSOR_RIGHT &&
				    user_key_action != PAGE_UP &&
				    user_key_action != PAGE_DOWN &&
					user_key_action != GLOBAL_INC_VOLUME &&
					user_key_action != GLOBAL_DEC_VOLUME &&
					user_key_action != GLOBAL_SEEK_FWD &&
					user_key_action != GLOBAL_SEEK_BWD)
				    user_key_action = -1;
			}

			switch (user_key_action) {
				case MODIFIER:
					button_repeat_timer = -1;
					modifier = 1;
					update = UPDATE_FOOTER;
					break;
				case GLOBAL_HOLD:
					if (!hold_state) {
						hw_display_off();
						update_display = 0;
						/* Clear the whole screen: */
						SDL_FillRect(display, NULL, 0);
						SDL_UpdateRect(display, 0, 0, 0, 0);
					} else {
						/* Restore background: */
						skin_update_bg(&skin, display, buffer);
						update_display = 1;
						hw_display_on();
					}
					hold_state = !hold_state;
					break;
			}

			if (!hold_state) {
				switch (user_key_action) { /* global actions */
					case GLOBAL_TOGGLE_VIEW:
						if (view == TRACK_INFO) {
							view = FILE_BROWSER;
						} else if (view == PLAYLIST) {
							view = TRACK_INFO;
						} else {
							view = PLAYLIST;
						}
						update = UPDATE_ALL;
						break;
					case GLOBAL_STOP:
						gmu_core_stop();
						update = UPDATE_ALL;
						break;
					case GLOBAL_PROGRAM_INFO:
						if (view != ABOUT) old_view = view;
						view = ABOUT;
						update = UPDATE_ALL;
						break;
					case GLOBAL_NEXT:
						if (play_next(ti, &cv)) {
							if (auto_select_cur_item)
								pl_browser_set_selection(&pb, gmu_core_playlist_get_current_position());
						} else {
							player_display_set_notice_message("CANNOT JUMP TO NEXT TRACK", NOTICE_DELAY);
						}
						update = UPDATE_ALL;
						break;
					case GLOBAL_PREV:
						if (play_previous(ti, &cv)) {
							if (auto_select_cur_item)
								pl_browser_set_selection(&pb, gmu_core_playlist_get_current_position());
						} else {
							player_display_set_notice_message("CANNOT JUMP TO PREV TRACK", NOTICE_DELAY);
						}
						update = UPDATE_ALL;
						break;
					case GLOBAL_PAUSE:
						if (file_player_get_playback_status())
							gmu_core_pause();
						SDL_Delay(50);
						break;
					case GLOBAL_SEEK_FWD:
						seek_step = (seek_step < 60 ? seek_step+1 : seek_step);
						file_player_seek(seek_step);
						break;
					case GLOBAL_SEEK_BWD:
						seek_step = (seek_step < 60 ? seek_step+1 : seek_step);
						file_player_seek(-1 * seek_step);
						break;
					case GLOBAL_EXIT:
						quit = QUIT_WITHOUT_ERROR;
						break;
					case GLOBAL_TOGGLE_TIME:
						time_remaining = !time_remaining;
						break;
					case GLOBAL_SET_SHUTDOWN_TIMER: {
						char *timer_msg = NULL;
						switch (gmu_core_get_shutdown_time_total()) {
							default:
							case 0: /* Timer disabled */
								gmu_core_set_shutdown_time(15);
								timer_msg = "SHUT DOWN IN 15 MINUTES";
								break;
							case 15: /* 15 minutes */
								gmu_core_set_shutdown_time(30);
								timer_msg = "SHUT DOWN IN 30 MINUTES";
								break;
							case 30:
								gmu_core_set_shutdown_time(60);
								timer_msg = "SHUT DOWN IN 60 MINUTES";
								break;
							case 60:
								gmu_core_set_shutdown_time(-1);
								timer_msg = "SHUT DOWN AFTER LAST TRACK";
								break;
							case -1: /* Shutdown after last track */
								gmu_core_set_shutdown_time(0);
								timer_msg = "SHUT DOWN TIMER DISABLED";
								break;
						}
						player_display_set_notice_message(timer_msg, NOTICE_DELAY);
						break;
					}
				}
				switch (view) { /* view specific actions */
					case FILE_BROWSER:
						update |= file_browser_process_action(&fb, &pb, ti, &cv, user_key_action, items_skip);
						break;				
					case PLAYLIST:
						update |= playlist_browser_process_action(&pb, ti, &cv, user_key_action, items_skip);
						break;
					case ABOUT:
						if (about_process_action(&tb_about, &view, old_view, user_key_action))
							update |= UPDATE_TEXTAREA | UPDATE_HEADER | UPDATE_FOOTER;
						break;
					case TRACK_INFO:
						update |= cover_viewer_process_action(&cv, user_key_action);
						break;
					case QUESTION:
						question_process_action(&dlg, user_key_action);
						update = UPDATE_ALL;
						break;
					case PLAYLIST_SAVE:
						plmanager_process_action(&ps, &view, user_key_action);
						switch(plmanager_get_flag(&ps)) {
							char buf23[64], buf42[64], temp[256];

							case PLMANAGER_SAVE_LIST:
								plmanager_reset_flag(&ps);
								snprintf(temp, 255, "%s/%s", base_dir, plmanager_get_selection(&ps));
								printf("sdl_frontend: Playlist file: %s\n", temp);
								strtoupper(buf42, plmanager_get_selection(&ps), 63);
								if (gmu_core_export_playlist(temp)) {
									snprintf(buf23, 63, "SAVED AS %s\n", buf42);
								} else {
									snprintf(buf23, 63, "FAILED SAVING %s\n", buf42);
								}
								player_display_set_notice_message(buf23, NOTICE_DELAY);
								break;
							case PLMANAGER_LOAD_LIST:
								gmu_core_playlist_clear();
							case PLMANAGER_APPEND_LIST:
								plmanager_reset_flag(&ps);
								snprintf(temp, 255, "%s/%s", base_dir, plmanager_get_selection(&ps));
								add_m3u_contents_to_playlist(temp);
								player_display_set_notice_message("M3U ADDED TO PLAYLIST", NOTICE_DELAY);
								break;
							default:
								break;
						}
						update = UPDATE_ALL;
						break;
					default:
						break;
				}
			}
			if (!hold_state || allow_volume_control_in_hold_state) {
				char volnotice[20];

				switch (user_key_action) {
					case GLOBAL_INC_VOLUME:
						gmu_core_set_volume(gmu_core_get_volume()+1);
						break;
					case GLOBAL_DEC_VOLUME:
						gmu_core_set_volume(gmu_core_get_volume()-1);
						break;
				}
				if (user_key_action == GLOBAL_INC_VOLUME || user_key_action == GLOBAL_DEC_VOLUME) {
					snprintf(volnotice, 19, "VOLUME: %d/%d", gmu_core_get_volume(), gmu_core_get_volume_max());
					player_display_set_notice_message(volnotice, NOTICE_DELAY);
				}
			}
		}

		if (event.type == SDL_USEREVENT) {
			Entry *tmp_item;

			switch (global_command) {
				case NEXT:
					if (play_next(ti, &cv)) {
						if (auto_select_cur_item)
							pl_browser_set_selection(&pb, gmu_core_playlist_get_current_position());
					} else {
						player_display_set_notice_message("CANNOT JUMP TO NEXT TRACK", NOTICE_DELAY);
					}
					update = UPDATE_ALL;
					break;
				case PAUSE:
					gmu_core_pause();
					update = UPDATE_ALL;
					break;
				case PLAY_ITEM:
					tmp_item = gmu_core_playlist_get_entry(global_param);
					if (tmp_item != NULL) {
						gmu_core_playlist_set_current(tmp_item);
						/*play_file(gmu_core_playlist_get_entry_filename(tmp_item), ti, &cv);*/
					}
					break;
				default:
					break;
			}

			/*if (global_command == NO_CMD &&
			    file_player_get_item_status() == STOPPED &&
			    file_player_get_playback_status() != STOPPED && 
			    playlist_get_current(gmu_core_get_playlist()) != NULL) {
				if (!play_next(gmu_core_get_playlist(), ti, &cv)) {
					playlist_reset_random(gmu_core_get_playlist());
					playlist_set_current(gmu_core_get_playlist(), NULL);
				} else {
					if (auto_select_cur_item)
						pl_browser_set_selection(&pb, playlist_get_current_position(gmu_core_get_playlist()));
				}
				update = UPDATE_ALL;

				if (backlight_poweron_on_track_change && !hold_state) {
					backlight_poweroff_timer = seconds_until_backlight_poweroff * FPS;
					update_display = 1;
					hw_display_on();
				}
			}*/

			global_command = NO_CMD;

			if (update_event == GMU_TRACK_CHANGE) {
				update = UPDATE_ALL;
				update_event = GMU_NO_EVENT;
			}

			if (button_repeat_timer > 0)      button_repeat_timer--;
			if (backlight_poweroff_timer > 0) backlight_poweroff_timer--;

			if (backlight_poweroff_timer == 0) {
				hw_display_off();
				/* Clear the whole screen: */
				SDL_FillRect(display, NULL, 0);
				SDL_UpdateRect(display, 0, 0, 0, 0);
				update_display = 0;
				backlight_poweroff_timer = TIMER_ELAPSED;
			}
			if (frame_skip_counter > 0)
				frame_skip_counter--;
			else
				update |= UPDATE_DISPLAY;

			/* When in trackinfo view, update view every few seconds */
			if (view == TRACK_INFO && !(update & UPDATE_TEXTAREA)) {
				static int cnt = 0;
				if (cnt == 30) {
					update |= UPDATE_TEXTAREA;
					cnt = 0;
				}
				cnt++;
			}
			if (view == PLAYLIST &&
			    playlist_is_recursive_directory_add_in_progress())
				update |= UPDATE_TEXTAREA | UPDATE_HEADER;
		}

		if (update != UPDATE_NONE && update_display) {
			char buf[128];

			if ((update & UPDATE_DISPLAY) && frame_skip_counter == 0) {
				frame_skip_counter = FRAME_SKIP;
				skin_draw_display_bg(&skin, buffer);
				player_display_draw(&skin.font_display, ti,
									(file_player_get_item_status() == STOPPED ? STOPPED : 
									 (gmu_core_playback_is_paused() ? PAUSED : PLAYING)),
									file_player_playback_get_time(), time_remaining,
									(10 * gmu_core_get_volume()) / (gmu_core_get_volume_max()-1),
									playlist_is_recursive_directory_add_in_progress(),
									gmu_core_get_shutdown_time_remaining(),
									buffer);
				skin_update_display(&skin, display, buffer);
			}

			if (update & UPDATE_FOOTER) {
				skin_draw_footer_bg(&skin, buffer);
				key_action_mapping_generate_help_string(kam, buf, 127, modifier, view);
				skin_draw_footer_text(&skin, buf, buffer);
				skin_update_footer(&skin, display, buffer);
			}

			if (update & UPDATE_HEADER)
				skin_draw_header_bg(&skin, buffer);

			if (update & UPDATE_TEXTAREA) {
				skin_draw_textarea_bg(&skin, buffer);
				switch (view) {
					case FILE_BROWSER:
						file_browser_draw(&fb, buffer);
						break;
					case PLAYLIST:
						pl_browser_draw(&pb, buffer);
						break;
					case ABOUT:
						text_browser_draw(&tb_about, buffer);
						break;
					case TRACK_INFO:
						if (file_player_is_metadata_loaded()) cover_viewer_update_data(&cv, ti);
						cover_viewer_show(&cv, buffer, ti);
						break;
					case QUESTION:
						question_draw(&dlg, buffer);
						break;
					case PLAYLIST_SAVE:
						plmanager_draw(&ps, buffer);
						break;
					default:
						break;
				}
				skin_update_textarea(&skin, display, buffer);
			}

			if (update & UPDATE_HEADER)
				skin_update_header(&skin, display, buffer);

			update = UPDATE_NONE;
		}
	}

	gmu_core_stop();
	input_config_free();

	if (quit != QUIT_WITH_ERROR) {
		if (strncmp(cfg_get_key_value(*config, "RememberSettings"), "yes", 3) == 0) {
			cfg_add_key(config, "TimeDisplay", time_remaining ? 
			                                   "remaining" : "elapsed");
		}
		dir_free(&fb.dir);
		SDL_FreeSurface(buffer);
		cover_viewer_free(&cv);
		skin_free(&skin);
	}
}

void *start_player(void *arg)
{
	int             /*i,*/ start = 1, setup = 0;
	char            skin_name[128] = "";

	if (!getcwd(base_dir, 255)) start = 0;

	/*for (i = 1; argv[i]; i++) {
		if (argv[i][0] == '-') {
			switch (argv[i][1]) {
				case '-':
				case 'h':
					print_cmd_help(argv[0]);
					start = 0;
					break;
				case 's':
					if (argc >= i+2) {
						strncpy(skin_name, argv[i+1], 127);
						skin_name[127] = '\0';
						i++;
					} else {
						printf("Invalid usage of -s: Skin name required.\n");
						start = 0;
					}
					break;
				case 'c':
					start = 0;
					setup = 1;
					break;
				default:
					printf("gmu: Unknown parameter (-%c). Try -h for help.\n", argv[i][1]);
					start = 0;
					break;
			}
		} else {
			char  filetype[16] = "(none)";
			char *filename = strrchr(argv[i], '/');
			char *tmp;

			if (filename == NULL) 
				filename = argv[i];
			else
				filename++;
			tmp = get_file_extension(filename);
			if (tmp != NULL)
				strtoupper(filetype, tmp, 15);
			if (strcmp(filetype, "M3U") == 0) {
				add_m3u_contents_to_playlist(gmu_core_get_playlist(), argv[i]);
			} else {
				playlist_add_item(gmu_core_get_playlist(), argv[i], filename);
			}
		}
	}*/

	if (start || setup) {
		config = gmu_core_get_config();
		if (skin_name[0] == '\0') {
			strncpy(skin_name, cfg_get_key_value(*config, "DefaultSkin"), 127);
			skin_name[127] = '\0';
		}
	}
	/*if (setup) {
		start = run_setup(config, skin_name);
		strncpy(skin_name, cfg_get_key_value(*config, "DefaultSkin"), 127);
		skin_name[127] = '\0';
	}*/
	if (start) {
		char       *decoders_str = NULL;
		GmuDecoder *gd = NULL;

		/* SDL_EnableKeyRepeat(200, 80); */

		/* Prepare list of loaded decoders for the about dialog */
		gd = decloader_decoder_list_get_next_decoder(1);
		while (gd) {
			const char *tmp = (*gd->get_name)();
			int         len = 0;

			if (decoders_str != NULL) len = strlen(decoders_str);
			if (decoders_str == NULL)
				decoders_str = malloc(strlen(tmp) + 4);
			else
				decoders_str = realloc(decoders_str, strlen(decoders_str) + strlen(tmp) + 4);
			snprintf(decoders_str+len, strlen(tmp) + 4, "- %s\n", tmp);
			gd = decloader_decoder_list_get_next_decoder(0);
		}
		if (decoders_str == NULL)
			run_player(skin_name, "No decoders have been loaded.");
		else
			run_player(skin_name, decoders_str);
		if (decoders_str) free(decoders_str);
	}
	gmu_core_quit();
	return 0;
}

static pthread_t fe_thread;

void init(void)
{
	pthread_create(&fe_thread, NULL, start_player, NULL);
}

void shut_down(void)
{
	printf("sdl_frontend: Shutting down now!\n");
	SDL_QuitSubSystem(SDL_INIT_VIDEO);
	quit = QUIT_WITHOUT_ERROR;
	if (pthread_join(fe_thread, NULL) == 0)
		printf("sdl_frontend: Thread stopped.\n");
	else
		printf("sdl_frontend: ERROR stopping thread.\n");
}

const char *get_name(void)
{
	return "Gmu SDL frontend v0.9";
}

static int event_callback(GmuEvent event)
{
	TrackInfo *ti;

	/*printf("sdl_frontend: Got event: %d\n", event);*/
	switch (event) {
		case GMU_QUIT:
			quit = QUIT_WITHOUT_ERROR;
			break;
		case GMU_TRACK_CHANGE:
			if (initialized) {
				ti = gmu_core_get_current_trackinfo_ref();
				SDL_RemoveTimer(tid);
				cover_viewer_update_data(&cv, ti);
				if (strcmp(cfg_get_key_value(*config, "EnableCoverArtwork"), "yes") == 0)
					cover_viewer_load_artwork(&cv, ti, trackinfo_get_file_name(ti), 
											  cfg_get_key_value(*config, "CoverArtworkFilePattern"),
											  (int *)&update);
				update_event = event;
				tid = SDL_AddTimer(1000 / FPS, timer_callback, NULL);
			}
			break;
		default:
			break;
	}
	return 0;
}

static GmuFrontend gf = {
	"SDL_frontend",
	get_name,
	init,
	shut_down,
	NULL,
	event_callback
};

GmuFrontend *gmu_register_frontend(void)
{
	return &gf;
}
