#include "Platform.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

int main(int argc, char **argv) {
  if (argc != 2) {
    fprintf(stderr,"USAGE: %s <filename>\n", argv[0]);
    return -1;
  }
  fprintf(stderr, "Opening %s\n", argv[1]);
  FileOpenRO(argv[1]);
  char buf[256];
  for (int i=0; i<256; ++i)
    buf[i] = i;
  FileRead(buf, 32);
  buf[32]=0x0;
  fprintf(stderr, "Read Data: %s\n", buf);
  FileSeek(16);
  FileRead(&buf[100], 16);
  for (int i=0; i<16; ++i)
    assert(buf[16+i] == buf[100+i]);
  FileClose();
  return 0;
}
