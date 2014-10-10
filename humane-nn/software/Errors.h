#ifndef ERRORS_H_
#define ERRORS_H_

#include <assert.h>
#include <stdio.h>

#ifndef AVR
#  define fprintf_P fprintf
#  define PSTR(x) (x)
#else
#  include <avr/pgmspace.h>
#endif
/**
 * A little error reporting mechanism so that I can live without exceptions.
 * To set an error, a function simply calls the Error() macro with a descriptive string.
 * On embedded platforms, this macro throws away the string and replaces it
 * with a one-byte NUL string so that it doesn't take up space.  Unique error
 * ID's are the unique string addresses.
 *
 * To use this in your program, you must invoke the macro
 * ErrorsGlobals
 * in your main object file.  This defines the global variables used by the
 * system.
 **/

#define ErrorsGlobals \
  const char* errorFile;\
  int errorLine;\
  const char* errorFunc;\
  const char* errorMsg;

extern const char* errorFile;
extern int errorLine;
extern const char* errorFunc;
extern const char* errorMsg;

//To help with debugging, try:
//include <assert.h>
//define ERRORimmediate assert(0 && errorMsg);
#ifndef ERRORimmediate
#define ERRORimmediate
#endif

/* Set and error */
#ifndef TINYERRORS
#  define ERROR(msg) do {errorFile = __FILE__; errorLine = __LINE__; errorFunc = __func__; errorMsg = PSTR(msg); ERRORimmediate} while (0)
#  define ERRORprint() do {ERRORprint2(__func__,__FILE__,__LINE__);} while (0)
#  define require(x) do {if (!(x)) {fprintf_P(stderr, "REQUIRE FAILURE %s\n", "UNK");}} while(0)
#else
#  define ERROR(msg) do {errorFile = 0x0; errorLine = __LINE__; errorFunc = 0x0; errorMsg = PSTR(""); ERRORimmediate} while (0)
#  define ERRORprint() ERRORprint3(__LINE__)
#  define require(x) do {if (!(x)) {fprintf_P(stderr, "REQUIRE FAILURE %s\n", #x);}} while(0)
#endif

/** Assert if error and pretty print error message **/
#define ERRORassert() if (IsError) {ERRORprint(); assert(0);}

/* Set error and return, with no return code */
#define ERRORreturn(msg) do{ ERROR(msg); return; } while (0)
/* Set error and return, with return code */
#define ERRORreturn2(msg, a) do{ ERROR(msg); return a; } while (0)

void ERRORprint2(const char *func, const char *file, int line);
void ERRORprint3();

#define IsError (errorMsg != 0x0)

#define ClearError() do {errorFile = 0x0; errorLine = -1; errorFunc = 0x0; errorMsg = 0x0; } while (0)

// We throw this declaration in so we don't hve to include all of stdlib.h to use assert
#ifdef __cplusplus
extern void abort (void) throw() __attribute__ ((__noreturn__));
#else
extern void abort (void) __attribute__ ((__noreturn__));
#endif

// Avoid the avr/include/assert.h, it just hangs
//#ifdef AVR
//#  undef assert
//#  define assert(x) require(x)
//#endif

#endif
