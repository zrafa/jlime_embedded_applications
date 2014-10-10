/** Utility Functions for bgTree which DO NOT RELY
 * UPON STANDARD LIBRARIES **/
#ifndef BGUTIL_H_
#define BGUTIL_H_ 1

#include "bgDefines.h"

#ifndef NO_STDIO
#  include <stdio.h>
#endif

/** ** Basic Node Cache ** **/

typedef struct {
  BlockAddrT addr[2];
  Node block[2];
  int locks[2];
} BlockCache;

typedef struct {
#ifndef NO_STDIO
  FILE *f;
#endif
  uint32_t offset;
  BlockCache cache;
} BlockContext;

void InitBlockCache(BlockCache *cache);

Node *LockBlockInCache(BlockCache *cache, BlockAddrT addr);

Node *AllocBlockFromCache(BlockCache *cache, BlockAddrT addr);

void UnlockBlockInCache(BlockCache *cache, BlockAddrT addr);

/** ** Serialization Routines ** **/

int32_t UnpackBlobInt(char *blob);

uint32_t UnpackBlobUInt(char *blob);

int UnpackString(char *blob, char *buf, int buflen);

#endif // BGUTIL_H_
