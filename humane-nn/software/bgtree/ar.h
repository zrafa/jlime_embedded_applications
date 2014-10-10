#ifndef AR_H_
#define AR_H_ 1

#include <stdint.h>

typedef struct {
  char fname[16];
  uint32_t position;
  uint32_t sz;
} ArFileRecord;

uint32_t ArParseHeader(ArFileRecord *record, const char *buf, uint32_t *position);

#endif // AR_H_
