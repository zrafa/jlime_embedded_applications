#include "vt52.h"

#ifdef USE_VT52
void vposition(FILE *f, int row, int col) {
  fprintf(f, VESC "Y");
  char r = 32 + row;
  char c = 32 + col;
  fwrite(&r, 1, 1, f);
  fwrite(&c, 1, 1, f);
}
#else
void vposition(FILE *f, int row, int col) {
  fprintf(f, VESC);
  row += 1;
  col += 1;
  char c;
  c = '0' + row/10;
  fwrite(&c, 1, 1, f);
  c = '0' + (row % 10);
  fwrite(&c, 1, 1, f);
  fwrite(";", 1, 1, f);
  c = '0' + col/10;
  fwrite(&c, 1, 1, f);
  c = '0' + (col % 10);
  fwrite(&c, 1, 1, f);
  fprintf(f, "f");
}
#endif

void vclearlines(FILE *f, int startRow, int endRow) {
  vposition(f, startRow, 0);
  for (int i=startRow; i <= endRow; ++i)
    fprintf(f, VERASE_LINE_CUR"\n");
  vposition(f, startRow, 0);
}
