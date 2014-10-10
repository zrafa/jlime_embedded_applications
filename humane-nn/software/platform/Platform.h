/** By Braddock Gaskill, 8/9/09 **/

#ifndef TVIKI_PLATFORM_HPP_
#define TVIKI_PLATFORM_HPP_ 1
#ifdef __cplusplus
 extern "C" {
#endif 

#include <stdint.h>
#include <stdio.h>
#if defined(AVR)
#  include <avr/pgmspace.h>
#  define OutP(x) OutS_P(PSTR(x))
#else
#  define PSTR(x) (x)
#  define fprintf_P fprintf
#  define printf_P printf
#  define OutS_P(x) OutS(x)
#  define OutP(x) OutS(x)
#  define _FDEV_EOF -1
#endif

#include "Errors.h"

/* ***** Files ***** */

/** File Options - high level file routines, based on PetiteFatFs, which can
 * only open one read-only file at a time **/
void FileInit();

/** Opens file or returns exception.
    Returns File Exception on failure.
    If a file is already open, this will close it before opening the new file.
 **/
void FileOpenRO(const char *fname);
void FileClose();
int  FileRead(char *buf, uint32_t len);
void FileSeek(uint32_t pos);
int  FileGetC(FILE *f);

/** For debug and performance tuning only, this returns a count of the number
 * of sector reads that were made to the filesystem, or 0 if unsupported **/
uint32_t FileSectorReadCount();

#if 0
#ifndef AVR
FILE *FileGetHandle();
#else
extern FILE libcFile;
static inline FILE *FileGetHandle() {
  return &libcFile;
}
#endif
#else
FILE *FileGetHandle();
#endif

/** Returns a magic number which will be incremeted whenever any file operations is
 * conducted (seek, open, read, etc). **/
int FileStateVersion();

/** Perform a check for stack overflow **/
void StackCheck();
/** Print information about the stack **/
void StackPrintInfo(FILE *f);

#define UP_ARROW ('A' << 8)
#define DOWN_ARROW ('B' << 8)
#define RIGHT_ARROW ('C' << 8)
#define LEFT_ARROW ('D' << 8)

/** Processes input in the context of state to handle escape
 * sequences.  Returns -1 if no valid character produced, else
 * returns the value of "in" if no escape code, or a charcter
 * << 8 for an escape code, such as UP_ARROW, DOWN_ARROW,
 * etc**/
int InputUnescape(int in, unsigned char *state);

/** Returns -1 if no input is available, else the input **/
int InputCheck();

/** Basic output functions **/
void OutC(char c);
/** Output string **/
void OutS(const char *s);
#ifdef AVR
void OutS_P(PGM_P s);
#endif
/** Output byte in hex **/
void OutX(uint32_t byte);
/** Output a long int **/
void OutI(uint32_t val);

#define DBG_MARK do {OutS_P(PSTR("DBG: ")); OutS(__func__); OutC(':'); OutI(__LINE__); /*OutS(" in "); OutS(__FILE__); */OutC('\n');} while (0)

/** Setup a real-time timer **/
void TimerInit();

uint64_t TimerCount();

/** Return value of millisecond timer **/
uint32_t TimerMillisec();

uint32_t TimerCountPerMillisec();

void PlatformInit();

/** Context used for all BTree database backends **/
typedef struct {
  int fileStateVersion;
  char *tableFname;
  char *blobFname;
} DbContext;

/** Delay specified number of millisecs **/
void DelayMs(unsigned int t);

#ifdef __cplusplus
}
#endif 
#endif //TVIKI_PLATFORM_HPP_
