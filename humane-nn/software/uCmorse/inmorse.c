#include <assert.h>
#include <stdlib.h> // for assert()

#if defined(AVR)
#  include <avr/pgmspace.h>
#else
#  define PROGMEM
#  define pgm_read_byte(x) *(x)
#endif

char codetree[] PROGMEM = "5H4S V3IU F   2E L R+  A P W J1 6B=D/X N C K Y T7Z G Q M8  O9 0";

char InMorseCodeTree(int idx) {
#ifdef AVR
  return pgm_read_byte(codetree + idx);
#else
  return codetree[idx];
#endif
}

char InMorseNext(char dotOrDash, char **p, int *pLen) {
  assert(p);
  if (!*p) { // New character
    *p = codetree;
    *pLen = 63;
  }
  *pLen = (*pLen - 1)/2;

  if (dotOrDash == '-') {
    *p += *pLen + 1;
  } else if (dotOrDash == '.') {
    // no change, we take the first half
  } else {
    return -1;
  }
  if (*pLen == 0) 
    return -2;
  return pgm_read_byte(*p + (*pLen-1)/2);
}

