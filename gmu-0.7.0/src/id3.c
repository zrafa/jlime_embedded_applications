/* 
 * Gmu GP2X Music Player
 *
 * Copyright (c) 2006-2010 Johannes Heimansberg (wejp.k.vu)
 *
 * File: id3.c  Created: 061030
 *
 * Description: Wejp's ID3 parser
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; version 2 of
 * the License. See the file COPYING in the Gmu's main directory
 * for details.
 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "trackinfo.h"
#include "charset.h"
#define ID3V2_MAX_SIZE 262144

int id3_read_id3v1(FILE *file, TrackInfo *ti, const char *file_type)
{
	int result = 0;

	if (fseek(file, -128, SEEK_END) == 0) {
		char id[3];

		/* Search for a ID3v1 tag: */
		if (fread(id, 3, 1, file) && strncmp(id, "TAG", 3) == 0) {
			char title[31], artist[31], album[31], year[5], comment[31];
			int  tracknr = 0;

			if (fread(title, 30, 1, file)  &&
			    fread(artist, 30, 1, file) &&
			    fread(album, 30, 1, file)  &&
			    fread(year, 4, 1, file)    &&
			    fread(comment, 30, 1, file)) {
				title[30] = '\0';
				artist[30] = '\0';
				album[30] = '\0';
				year[4] = '\0';
				comment[30] = '\0';
				printf("id3: ID3v1.%d detected!\n", (comment[28] == '\0' ? 1 : 0));
				if (comment[28] == '\0') {
					snprintf(ti->file_type, SIZE_FILE_TYPE-1, "%s (ID3v1.1)", file_type);
					tracknr = comment[29];
				} else {
					snprintf(ti->file_type, SIZE_FILE_TYPE-1, "%s (ID3v1)", file_type);
				}
				if (strlen(title) > 0)
					strncpy(ti->title, title, SIZE_TITLE-1);
				strncpy(ti->artist, artist, SIZE_ARTIST-1);
				strncpy(ti->album, album, SIZE_ALBUM-1);
				strncpy(ti->comment, comment, SIZE_COMMENT-1);
				strncpy(ti->date, year, SIZE_DATE-1);
				snprintf(ti->tracknr, SIZE_TRACKNR-1, "%d", tracknr);
				result = 1;
			}
		}
	}
	return result;
}

static int calc_size_unsync(const unsigned char *four_bytes)
{
	return (four_bytes[3])       + (four_bytes[2] << 7) + 
	       (four_bytes[1] << 14) + (four_bytes[0] << 21);
}

static int calc_size(const unsigned char *four_bytes)
{
	return (four_bytes[3])       + (four_bytes[2] << 8) + 
	       (four_bytes[1] << 16) + (four_bytes[0] << 24);
}

static void set_title(TrackInfo *ti, char *str, int str_size, Charset charset)
{
	if (str[0] != '\0') {
		switch (charset) {
			case ISO_8859_1:
				strncpy(ti->title, str, SIZE_TITLE-1);
				break;
			case UTF_8:
				charset_utf8_to_iso8859_1(ti->title, str, SIZE_TITLE-1);
				break;
			case UTF_16:
				charset_utf16_to_iso8859_1(ti->title, SIZE_TITLE-1, str, str_size, BE);
				break;
			case UTF_16_BOM:
				charset_utf16_to_iso8859_1(ti->title, SIZE_TITLE-1, str, str_size, BOM);
				break;
			default:
				break;
		}
	}
}

static void set_artist(TrackInfo *ti, char *str, int str_size, Charset charset)
{
	if (str[0] != '\0') {
		switch (charset) {
			case ISO_8859_1:
				strncpy(ti->artist, str, SIZE_ARTIST-1);
				break;
			case UTF_8:
				charset_utf8_to_iso8859_1(ti->artist, str, SIZE_ARTIST-1);
				break;
			case UTF_16:
				charset_utf16_to_iso8859_1(ti->artist, SIZE_ARTIST-1, str, str_size, BE);
				break;
			case UTF_16_BOM:
				charset_utf16_to_iso8859_1(ti->artist, SIZE_ARTIST-1, str, str_size, BOM);
				break;
			default:
				break;
		}
	}
}

static void set_album(TrackInfo *ti, char *str, int str_size, Charset charset)
{
	switch (charset) {
		case ISO_8859_1:
			strncpy(ti->album, str, SIZE_ALBUM-1);
			break;
		case UTF_8:
			charset_utf8_to_iso8859_1(ti->album, str, SIZE_ALBUM-1);
			break;
		case UTF_16:
			charset_utf16_to_iso8859_1(ti->album, SIZE_ALBUM-1, str, str_size, BE);
			break;
		case UTF_16_BOM:
			charset_utf16_to_iso8859_1(ti->album, SIZE_ALBUM-1, str, str_size, BOM);
			break;
		default:
			break;
	}
}

static void set_comment(TrackInfo *ti, char *str, int str_size, Charset charset)
{
	if (str[0] != '\0') {
		switch (charset) {
			case ISO_8859_1:
				strncpy(ti->comment, str, SIZE_COMMENT-1);
				break;
			case UTF_8:
				charset_utf8_to_iso8859_1(ti->comment, str, SIZE_COMMENT-1);
				break;
			case UTF_16:
				charset_utf16_to_iso8859_1(ti->comment, SIZE_COMMENT-1, str, str_size, BE);
				break;
			case UTF_16_BOM:
				charset_utf16_to_iso8859_1(ti->comment, SIZE_COMMENT-1, str, str_size, BOM);
				break;
			default:
				break;
		}
	}
}

static void set_date(TrackInfo *ti, char *str, int str_size, Charset charset)
{
	if (str[0] != '\0') {
		switch (charset) {
			case ISO_8859_1:
				strncpy(ti->date, str, SIZE_DATE-1);
				break;
			case UTF_8:
				charset_utf8_to_iso8859_1(ti->date, str, SIZE_DATE-1);
				break;
			case UTF_16:
				charset_utf16_to_iso8859_1(ti->date, SIZE_DATE-1, str, str_size, BE);
				break;
			case UTF_16_BOM:
				charset_utf16_to_iso8859_1(ti->date, SIZE_DATE-1, str, str_size, BOM);
				break;
			default:
				break;
		}
	}
}

static void set_cover_art(TrackInfo *ti, char *data, int data_size, Charset charset)
{
	char *mime_type = data, *descr = NULL;
	int   m, pic_type = -1;
	/* skip over mime type: */
	for (m = 0; data[m] != '\0' && m < data_size - 1; m++);
	m++;
	pic_type = *(data+m);
	m++; /* skip over picture type byte */
	descr = data+m;
	/* skip over description: */
	for (; data[m] != '\0' && m < data_size - 1; m++);
	m++;
	if (charset == UTF_16 || charset == UTF_16_BOM) m++;
	/*printf("id3: APIC: mime type: %s pic type: %d description: %s\n",
	        mime_type, pic_type, descr);
	printf("id3: APIC: size = %d (header: %d)\n", data_size-m, m);*/
	trackinfo_set_image(ti, data+m, data_size-m, mime_type);
}

static void set_tracknr(TrackInfo *ti, char *str, int str_size, Charset charset)
{
	if (str[0] != '\0') {
		switch (charset) {
			case ISO_8859_1:
				strncpy(ti->tracknr, str, SIZE_TRACKNR-1);
				break;
			case UTF_8:
				charset_utf8_to_iso8859_1(ti->tracknr, str, SIZE_TRACKNR-1);
				break;
			case UTF_16:
				charset_utf16_to_iso8859_1(ti->tracknr, SIZE_TRACKNR-1, str, str_size, BE);
				break;
			case UTF_16_BOM:
				charset_utf16_to_iso8859_1(ti->tracknr, SIZE_TRACKNR-1, str, str_size, BOM);
				break;
			default:
				break;
		}
	}
}

static void set_lyrics(TrackInfo *ti, char *str, int str_size, Charset charset)
{
	if (str[0] != '\0') {
		int i = 0;
		/* skip lyrics description */
		if (charset == UTF_16 || charset == UTF_16_BOM)
			for (i = 0; !(str[i] == '\0' && str[i+1] == '\0') && i < str_size; i++);
		else
			for (i = 0; !(str[i] == '\0') && i < str_size; i++);
		if (charset == UTF_16 || charset == UTF_16_BOM) i++;
		i++;
		/*printf("i=%d str_size=%d str=%s\n", i, str_size, str);*/
		switch (charset) {
			case ISO_8859_1:
				strncpy(ti->lyrics, str+i, SIZE_LYRICS-1);
				break;
			case UTF_8:
				charset_utf8_to_iso8859_1(ti->lyrics, str+i, SIZE_LYRICS-1);
				break;
			case UTF_16:
				charset_utf16_to_iso8859_1(ti->lyrics, SIZE_LYRICS-1, str+i, str_size-i, BE);
				break;
			case UTF_16_BOM:
				charset_utf16_to_iso8859_1(ti->lyrics, SIZE_LYRICS-1, str+i, str_size-i, BOM);
				break;
			default:
				break;
		}
		ti->has_lyrics = 1;
	}
}

int fread_unsync(char *frame_data, int fsize, FILE *file)
{
	int j;

	for (j = 0; j < fsize; j++) {
		unsigned char uc = fgetc(file);
		frame_data[j] = (char)uc;
		if (uc == 0xFF) {
			uc = fgetc(file);
			if (uc != 0) {
				j++;
				frame_data[j] = (char)uc;
			}
		}
	}
	return j;
}

int id3_read_id3v2(FILE *file, TrackInfo *ti, const char *file_type)
{
	char id[3];
	int  result = 0;

	rewind(file);
	if (fread(id, 3, 1, file) && strncmp(id, "ID3", 3) == 0) {
		unsigned char ver_major, ver_minor, flags, size[4];

		ver_major = fgetc(file);
		ver_minor = fgetc(file);
		flags     = fgetc(file);
		if (fread(size, 4, 1, file)) {
			printf("id3: ID3v2.%d.%d detected!\n", ver_major, ver_minor);
			snprintf(ti->file_type, SIZE_FILE_TYPE, "%s (ID3v2.%d.%d)",
					 file_type, ver_major, ver_minor);
			if (ver_major > 4 || ver_major < 3) {
				printf("id3: Unsupported ID3 version.\n");
			} else if ((flags & (1+2+4+8)) > 0) {
				printf("id3: Tag error!\n");
			} else {
				int           i, error = 0, global_unsync = 0, real_size = 0;
				unsigned char frame_size[5];

				if ((flags & 16) > 0) /* bit 4 */
					printf("ID3v2: Footer present.\n");
				if ((flags & 32) > 0) /* bit 5 */
					printf("ID3v2: Experimental indicator is set.\n");
				if ((flags & 64) > 0) /* bit 6 */
					printf("ID3v2: Extended header bit is set.\n");
				if ((flags & 128) > 0) { /* bit 7 */
					printf("ID3v2: Unsynchronisation bit is set.\n");
					global_unsync = 1;
				}
				real_size = calc_size_unsync(size);
				printf("id3: Tag size: %d bytes\n", real_size);
				for (i = 0; i < 4; i++)
					if (size[i] > 127) {
						printf("id3: Error in ID3 tag.\n");
						error = 1;
						break;
					}
				if (!error) {
					int  byte_counter = 0;
					char frame_id[5] = "X", frame_flags[3];

					if (real_size - 10 > ID3V2_MAX_SIZE) frame_id[0] = 0;
					while (byte_counter < real_size - 10 && frame_id[0] != 0) {
						int fsize, frame_unsync = 0;

						if (fread(frame_id,    4, 1, file) &&
						    fread(frame_size,  4, 1, file) &&
						    fread(frame_flags, 2, 1, file)) {
							byte_counter += 10;
							fsize = calc_size(frame_size);
							/*printf("id3: Frame ID: %s - Frame size: %d bytes\n", frame_id, fsize);*/

							if (ver_major == 4)
								frame_unsync = (frame_flags[1] & 2) ? 1 : 0;
							/*printf("id3: bytecounter=%d fsize=%d realsize=%d r-b=%d\n",
									byte_counter, fsize, real_size, real_size - byte_counter);*/
							if (fsize > 0 && fsize <= real_size - byte_counter) {
								char    *frame_data = malloc(fsize+1);
								Charset  charset    = ISO_8859_1;

								if ((global_unsync && ver_major == 3 ) || frame_unsync) {
									fread_unsync(frame_data, fsize, file);
									/*printf("id3: Decoded unsync scheme.\n");*/
								} else {
									if (!fread(frame_data, fsize, 1, file)) {
										printf("id3: ERROR: Incomplete data.\n");
										break;
									}
								}
								byte_counter += fsize;
								frame_data[fsize] = '\0';
								printf("id3: %s charset: ", frame_id);
								switch(frame_data[0]) {
									case 0:
										charset = ISO_8859_1;
										printf("ISO-8859-1");							
										break;
									case 1:
										charset = UTF_16_BOM;
										printf("UTF-16 (with BOM)");
										break;
									case 2:
										charset = UTF_16;
										printf("UTF-16 (without BOM)");
										break;
									case 3:
										charset = UTF_8;
										printf("UTF-8");
										break;
									default:
										printf("unknown (%d)", frame_data[0]);
										break;
								}
								printf("\n");
								/*printf("ID3: Frame data: %s\n", frame_data+1);*/

								if (strncmp(frame_id, "TIT2", 4) == 0) {
									set_title(ti, frame_data+1, fsize-1, charset);
									result = 1;
								} else if (strncmp(frame_id, "TPE1", 4) == 0) {
									set_artist(ti, frame_data+1, fsize-1, charset);
									result = 1;
								} else if (strncmp(frame_id, "TALB", 4) == 0) {
									set_album(ti, frame_data+1, fsize-1, charset);	
								} else if (strncmp(frame_id, "TRCK", 4) == 0) {
									set_tracknr(ti, frame_data+1, fsize-1, charset);
								} else if (strncmp(frame_id, "TYER", 4) == 0) { /* 2.3.0 */
									set_date(ti, frame_data+1, fsize-1, charset);						
								} else if (strncmp(frame_id, "TDRC", 4) == 0) { /* 2.4.0 */
									set_date(ti, frame_data+1, fsize-1, charset);
								} else if (strncmp(frame_id, "COMM", 4) == 0) {
									set_comment(ti, frame_data+1, fsize-1, charset);
								} else if (strncmp(frame_id, "APIC", 4) == 0) {
									set_cover_art(ti, frame_data+1, fsize-1, charset);
								} else if (strncmp(frame_id, "USLT", 4) == 0) {
									set_lyrics(ti, frame_data+4, fsize-1, charset);
								}
								free(frame_data);
							} else {
								break;
							}
						} else {
							break;
						}
					}
				}
			}
		}
	}
	return result;
}

int id3_read_tag(const char *filename, TrackInfo *ti, const char *file_type)
{
	int   result = 0;
	FILE *file;

	if ((file = fopen(filename, "r"))) {
		char *filename_without_path = strrchr(filename, '/');

		if (filename_without_path != NULL)
			filename_without_path++;
		else
			filename_without_path = (char *)filename;

		filename_without_path = charset_filename_convert_alloc(filename_without_path);
		trackinfo_clear(ti);
		strncpy(ti->title, filename_without_path, SIZE_TITLE-1);
		free(filename_without_path);
		strncpy(ti->file_type, "MP3", SIZE_FILE_TYPE-1);
		if (!(result = id3_read_id3v2(file, ti, file_type)))
			result = id3_read_id3v1(file, ti, file_type);
		fclose(file);
	}
	return result;
}
