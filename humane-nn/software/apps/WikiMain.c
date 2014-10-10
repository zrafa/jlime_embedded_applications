#include "WikiApp.h"
#include "vt52.h"
#include <string.h>
#ifndef AVR
#  include <unistd.h>
#endif

int main(int argc, char **argv) {
#ifndef AVR
  if ((argc > 2) && (!strcmp(argv[1], "--chdir"))) {
    int res = chdir(argv[2]);
    if (res) {
      fprintf(stderr, "ERROR: --chdir %s failed\n", argv[2]);
      return -1;
    }
  }
#endif
  PlatformInit();

  WikiApp wapp;
  WikiAppInit(&wapp);

  // preload continuities in database file
  FileOpenRO("sec.bgb");
  FileSeek(1574387021);
  FileOpenRO("sec.bgt");
  FileSeek(37550590);
  FileOpenRO("pre.bgt");
  FileSeek(0xffffffff); // will get truncated to file end

  int changed = 1;
  int r = -1;
  int fullyDrawn = 1;
  printf(VERASE_SCR);
  while (1) {
    if ((r == -1) && (changed || !fullyDrawn)) {
      fullyDrawn = WikiAppDraw(&wapp);
      changed = 0;
    }
    r = InputCheck();
    changed |= WikiAppPushEvent(&wapp, r);
  }
  return 0;
}
