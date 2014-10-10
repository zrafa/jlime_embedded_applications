#include "ar.h"
#include <stdio.h>

int main(int argc, char **argv) {
  if (argc < 3) {
    fprintf(stderr, "USAGE: %s <archive>\n", argv[0]);
    //fprintf(stderr, "       %s x <archive> <filename>\n", argv[0]);
    return -1;
  }

  FILE *f = fopen(argv[2],"rb");
  if (!f) {
    fprintf(stderr, "Failed to open archive %s\n", argv[2]);
    return -1;
  }

  /* Read headers */
  const int maxRecords = 8;
  ArFileRecord records[maxRecords];
  int numRecords=0;
  char buf[60];
  uint32_t position=0;

  /* Read global header */
  do {
    ++position; // eat first line
  } while (fgetc(f) != '\n');

  do {
    int n = fread(buf, 1, 1, f);
    if (n != 1) //end of archive
      break;
    if (buf[0] == '\n') // record terminator
      break;

    n = fread(buf+1, 1, 59, f);
    if (n < 59) {
      fprintf(stderr, "Premature end of archive during header read\n");
      return -4;
    }
    ArParseHeader(&records[numRecords++], buf, &position);
    fprintf(stdout, "%2i: sz=%10u pos=%10u name=%s\n", numRecords, records[numRecords-1].sz, records[numRecords-1].position, records[numRecords-1].fname);
    n = fseek(f, position, SEEK_SET);
    if (n != 0) {
      fprintf(stderr, "Attempted seek in archive failed\n");
      return -4;
    }
  } while (1); 

  if (argv[1][0] == 't') { // archive listing
  }
  return 0;
}
