#include "ar.h"

#define ARMAXFILES 8
ArFileRecord arRecords[ARMAXFILES];

/** Parse a header.  Returns record size, or 0 if last record. **/
uint32_t ArParseHeader(ArFileRecord *record, const char *buf, uint32_t *position) {
  if (buf[0] == '\n') // empty line indicates last record
    return 0;
  for (int i=0; i<16; ++i)
    record->fname[i] = buf[i];
  //right-trim spaces
  char *bp;
  for (bp=record->fname+15; *bp==' ' || *bp=='/'; --bp);
  *(bp+1) = '\000';
  record->position = *position;
  record->sz = 0;
  uint32_t mult=1;
  for (int i=57; i>47; --i) {
    if (*(buf+i) != ' ') {
      record->sz += mult * (*(buf+i) - '0');
      mult *= 10;
    }
  }
  *position += record->sz + 60;
  return record->sz;
}

