/** Test of stdio backend for Petite FatFS
 *  By Braddock Gaskill 8/18/09 
 *  This code is declared by the author to be in the public domain. **/

#include <stdio.h>
#include <pff.h>

const char *diskfilename=0x0;

int main(int argc, char **argv) {
  if (argc < 3) {
    fprintf(stderr, "USAGE: %s <imgname> <filename>\n", argv[0]);
    fprintf(stderr, "  Reads a file within a FAT16 image file to stdout\n");
    return -1;
  }

  diskfilename = argv[1];
  FATFS fatfs;
  if (pf_mount(&fatfs) != FR_OK) {
    fprintf(stderr, "pf_mount failed\n");
    return -2;
  }
 
  if (pf_open(argv[2]) != FR_OK) {
    fprintf(stderr, "pf_open(%s) failed\n", argv[2]);
    return -3;
  } 

  char buf[128];
  WORD bytesRead=0;
  do {
    if (pf_read(buf, 128, &bytesRead)) {
      fprintf(stderr, "pf_read failed\n");
      return -4;
    }
    fwrite(buf, 1, bytesRead, stdout);
  } while (bytesRead == 128);

  return 0;
}
