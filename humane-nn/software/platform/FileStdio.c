/** Filesystem abstraction level for testing on "real" OS targets **/

#include <stdio.h>
#include "Platform.h"
#include "Errors.h"
#include <assert.h>

#define _FDEV_EOF -1

FILE *fsFile=0x0;
static int fileStateVersion=1;
static int readCount=0;

void FileInit(const char *opt) {}

/** Returns File Exception on failure **/
void FileOpenRO(const char *fname) {
  ++fileStateVersion;
  if (fsFile != 0x0) // can't open until closed
    fclose(fsFile);
  fsFile = fopen(fname, "rb");
  if (!fsFile)
    ERRORreturn("Failed to open file");
}

void FileClose() {
  ++fileStateVersion;
  assert(fsFile);
  fclose(fsFile);
}

/** Returns exception on error, number of bytes read on success (or partial
 * success) **/
int FileRead(char *buf, uint32_t len) {
  ++fileStateVersion;
  ++readCount;
  assert(fsFile);
  size_t sz = fread(buf, 1, len, fsFile);
  if ((sz < len) && !feof(fsFile))
    ERRORreturn2("FileRead Short Read", 0);
  return sz;
}

void FileSeek(uint32_t pos) {
  ++fileStateVersion;
  ++readCount;
  assert(fsFile);
  if (fseek(fsFile, pos, SEEK_SET))
    ERRORreturn("FileSeek Failure");
}

int FileGetC(FILE *f) {
  char c;
  int r = FileRead(&c, 1);
  if ((r != 1) || IsError) // FIXME: should return _FDEV_ERR?
    return _FDEV_EOF;
  return c;
}

FILE *FileGetHandle() {return fsFile;}

int FileStateVersion() { return fileStateVersion; }

uint32_t FileSectorReadCount() {
  return readCount;
}
