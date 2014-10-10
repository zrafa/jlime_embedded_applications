/** Filesystem abstraction level for testing on "real" OS targets **/

#include "pff.h"
#include "diskio.h"
#include "Platform.h"
#include "Errors.h"
#include <assert.h>

#include <stdio.h>
#ifndef AVR
#  include <stdlib.h> //getenv()
#endif

FATFS fatfs;
const char *diskfilename=0x0;
static int fileStateVersion=0;
#ifdef AVR
FILE libcFile = FDEV_SETUP_STREAM(NULL, FileGetC, _FDEV_SETUP_READ); // for avr-libc stdio interface
#endif

void FileInit() {
  fprintf_P(stderr, PSTR("FileInit()\n"));
#ifdef AVR
  fprintf_P(stderr, PSTR("Probing for SD Card...\n"));
#else
  diskfilename = getenv("FAT");
  if (!diskfilename)
    ERRORreturn("No FAT environment variable set to fat image\n");
  else
    fprintf(stderr, "FileInit trying to use image %s\n",diskfilename);
#endif
  int res = disk_initialize();
  if (res != FR_OK)
    ERRORreturn("disk_initialize failed");
  fprintf_P(stderr, PSTR("pf_mount...\n"));
  res = pf_mount(&fatfs);
  if (res != FR_OK)
    ERRORreturn("pf_mount failed");
}

/** Returns File Exception on failure **/
void FileOpenRO(const char *fname) {
  ++fileStateVersion;
  if (pf_open(fname) != FR_OK)
    ERRORreturn("pf_open Failed to open file");
}

void FileClose() {
  // this doesn't do anything - shhh, don't tell
}

/** Returns exception on error, number of bytes read on success (or partial
 * success) **/
int FileRead(char *buf, uint32_t len) {
  ++fileStateVersion;
  WORD bytesRead=0;
  if (pf_read(buf, len, &bytesRead) != RES_OK)
    ERRORreturn2("FileRead failed",0);
  return bytesRead;
}

void FileSeek(uint32_t pos) {
  ++fileStateVersion;
  if (pf_lseek(pos) != FR_OK)
    ERRORreturn("FileSeek Failure");
}

int FileGetC(FILE *f) {
  unsigned char c;
  int r = FileRead((char*)&c, 1);
  if ((r != 1) || IsError) // FIXME: should return _FDEV_ERR?
    return _FDEV_EOF;
  return (int) c;
}

#ifndef AVR
FILE *FileGetHandle() {
  return 0x0;
}
#else
FILE *FileGetHandle() {
  return &libcFile;
}
#endif

extern DWORD sdCacheMiss;
uint32_t FileSectorReadCount() {
  return sdCacheMiss;
}

int FileStateVersion() { return fileStateVersion; }
