#include "MorseBox.h"
#include "vt52.h"

int main(int argc, char **argv) {
  unsigned char escState=0;
  PlatformInit();
  MorseBox mb;
  MorseBoxInit(&mb,0);
  while (1) {
    MorseBoxDraw(&mb);
    int r = fgetc(stdin);
    r = InputUnescape(r, &escState);
    if (r != -1)
      MorseBoxPushEvent(&mb, r);
  }
}
