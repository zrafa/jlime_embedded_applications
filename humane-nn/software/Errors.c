#include "Errors.h"
#include <stdio.h>

#ifdef AVR
#  include <avr/pgmspace.h>
#else
#  define PSTR(x) (x)
#  define fprintf_P fprintf
#endif


const char* errorFile;
int errorLine;
const char* errorFunc;
const char* errorMsg;

void ERRORprint2(const char *func, const char *file, int line) {
  if (IsError) {
    //fprintf_P(stderr,PSTR("\nERROR: %s in %s()\n %s:%i,\n reported from %s()\n %s:%i\n"), 
    //    errorMsg ? errorMsg : "UNK", errorFunc ? errorFunc : "UNK", errorFile ? errorFile : "UNK", errorLine, 
    //    func ? func : "UNK", file ? file : "UNK", line);
    fprintf_P(stderr,PSTR("\nERROR: "));
    fprintf_P(stderr, errorMsg ? errorMsg : PSTR("UNK"));
    fprintf_P(stderr, PSTR(" in %s()\n %s:%i,\n reported from %s()\n %s:%i\n"), 
        errorFunc ? errorFunc : "UNK", errorFile ? errorFile : "UNK", errorLine, 
        func ? func : "UNK", file ? file : "UNK", line);
  } else {
    fprintf_P(stderr,PSTR("No Error\n"));
  }
}

void ERRORprint3(int line) {
  ERRORprint2(0x0, 0x0, line);
}

