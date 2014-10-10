#include "Platform.h"

int main(int argc, char **argv) {
  PlatformInit();
  unsigned char escState = 0;
  while (1) {
    int r = InputCheck();
    int r2 = InputUnescape(r, &escState);
    if ((r != -1) || (r2 != -1))
      printf("[%x=_%c_->%i]\n", (unsigned int) r, (char) r, r2);
  }
  return 0;
}
