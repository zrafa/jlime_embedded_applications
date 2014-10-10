/** Utility Functions for bgTree which DO NOT RELY
 * UPON STANDARD LIBRARIES **/
#include "bgUtil.h"
#include <assert.h>
#include <string.h>

void InitBlockCache(BlockCache *cache) {
  for (int i=0; i<2; ++i) {
    cache->addr[i] = BAInvalid;
    cache->locks[i] = 0;
  }
}

Node *LockBlockInCache(BlockCache *cache, BlockAddrT addr) {
  for (int i=0; i<2; ++i) {
    if (cache->addr[i] == addr) {
      ++cache->locks[i];
      return &cache->block[i];
    }
  }
  return 0x0; // not in cache
}

Node *AllocBlockFromCache(BlockCache *cache, BlockAddrT addr) {
  // find space
  for (int i=0; i<2; ++i) {
    assert(cache->addr[i] != addr); // should not already exist in cache
    if (!cache->locks[i]) {
      cache->addr[i] = addr;
      cache->locks[i]++;
      return &cache->block[i];
    }
  }
  return 0x0; // no unlocked space!
}

void UnlockBlockInCache(BlockCache *cache, BlockAddrT addr) {
  for (int i=0; i<2; ++i) {
    if (cache->addr[i] == addr) {
      assert(cache->locks[i] != 0);
      --cache->locks[i];
      return;
    }
  }
  assert(0 && "UnlockBlockInCache: Attempt to unlock block which was not allocated!");
}

/** Serialization Routines **/

int32_t UnpackBlobInt(char *blob) {
  return *((int32_t*)blob);
}

uint32_t UnpackBlobUInt(char *blob) {
  return *((uint32_t*)blob);
}

int UnpackString(char *blob, char *buf, int buflen) {
  uint32_t sz = UnpackBlobUInt(blob);
  blob += 4;
  uint32_t sz2 = (buflen > sz) ? sz : buflen;
  memcpy(buf, blob, sz2);
  return sz + 4;
}


