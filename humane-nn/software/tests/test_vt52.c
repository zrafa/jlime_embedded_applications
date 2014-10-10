#include <stdio.h>
#include "vt52.h"
#include "Platform.h"

int main(int argc, char **argv) {
  PlatformInit();
  printf(VERASE_SCR);
  for (int i=0; i<16; ++i) {
    vposition(stdout, i, 0);
    printf("%x",i);
  }
  for (int i=0; i<16; ++i) {
    vposition(stdout, 0, i);
    printf("%x",i);
  }

  printf(VHOME);
  printf("HOME");
  printf(VDOWN);
  printf("DOWN");
  printf(VDOWN);
  printf("STORE");
  printf(VDOWN);
  printf(VSTORE);
  printf(VUP);
  printf("UP ");
  printf("RIGHT" VRIGHT "RIGHT");

  vposition(stdout, 7, 0);
  printf("YOU SHOULD NOT SEE THIS LINE\n");
  printf("DONT SEE THIS LINE");
  vclearlines(stdout, 7, 8);

  vposition(stdout, 10, 10);
  printf("10,10");
  vposition(stdout, 13, 20);
  printf("13,20");
  printf(VRESTORE"RESTORE\n");
  vposition(stdout, 15, 0);
}
