#include "Platform.h"
#include "stdio.h"
#ifdef AVR
#  include <util/delay.h>
#  include <avr/io.h>
#endif

int main(int argc, char **argv) {
  const char *fileName="test.txt";
  DelayMs(1000);
  PlatformInit();
  ERRORassert();
  StackPrintInfo(stdout);
  DelayMs(1000);

  FileOpenRO(fileName);
  if (IsError) {
    ERRORprint();
    printf_P(PSTR("Failed to open for reading"));
    while (InputCheck() == -1)
      ;
    return -1;
  }

  int ln=0;
  while (1) {
    const int bufSize=20;
    char buf[bufSize];
    int r = FileRead(buf, bufSize);
    if (r == _FDEV_EOF)
      break;
    fwrite(buf, r, 1, stdout); 
    for (int i=0; i<r; ++i) {
      if (buf[i] == 10) {
        ++ln;
        if (!(ln % 24)) {
          while (InputCheck() != -1) // clear anything pending
            ;
          while (InputCheck() == -1) // wait for new input
            ;
          ++ln;
        }
      }
    }
  }
  OutP("\n\n -- END OF FILE -- \n\n");
  DelayMs(10000);
  return 0;
}
