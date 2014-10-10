#include <stdio.h>
#include "uCmorse.h"

void sounder(int onOrOff, int msec) {
  int i;
  int units = MSEC2UNITS(msec);
  fprintf(stderr, "sounder(%i, %i)\n", onOrOff, msec);
  if (onOrOff && (units == DIT))
    printf(".");
  else if (onOrOff && (units == DASH))
    printf("-");
  else
    for (i = 0; i< units - 1; ++i) printf(" ");
}

void tapString(const char *s);

int main() {
  const char *s="HELLO WORLD";
  tapString(s);
  printf(" 0xab = ");
  tapByteHex(0xab);
}
