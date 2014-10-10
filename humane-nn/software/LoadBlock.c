#include "Platform.h"
#include "bgtree/bgDefines.h"
#include <string.h> //memcpy

/* ** LoadBlock, AllocBlock, etc are used by the bgtree
 * implementation to load blocks from our storage media. 
 * As written here they are platform independent thanks to
 * the FileStdio abstraction library, but this could be
 * changed in the future for improved performance. ** */

/** BGTree - User-supplied function loads block as addr, returning result in buffer.
 * buffer is a pre-allocated array of size blkSize **/
void LoadBlock(BlockAddrT addr, Node *ptr, void *userData) {
#ifdef USE_BGTREE_CACHE
  static Node cacheBlock;
  static BAT cacheAddr = BAInvalid;
  static void *cacheUserData=0x0;
#endif
  //OutP("LoadBlock(");OutX(addr);OutP(")\n");
	/* rafa */
  // ERRORassert(); // DEBUG - remove me
	/* rafa */
  //BlockContext *bgtreeContext = (BlockContext*) userData;
#ifdef USE_BGTREE_CACHE
  if ((addr == cacheAddr) && (userData == cacheUserData)) { // cache hit?
    memcpy(ptr, &cacheBlock, BlockSize);
    return;
  }
#endif
  DbContext *c = (DbContext *) userData;
  assert(c);
  // Get block from disk
  if (c->fileStateVersion != FileStateVersion()) { // has anyone changed the currently open file?
    FileOpenRO(c->tableFname);
  }
	/* rafa */
  //ERRORassert();
	/* rafa */
  FileSeek(addr);
	/* rafa */
  //ERRORassert();
	/* rafa */
  int rd = FileRead((char *) ptr, BlockSize);
  if (rd != BlockSize) {
    printf_P(PSTR("DEBUG: Short Read, %i of %i at %08x!\n"), rd, BlockSize, addr);
    ERRORreturn("Short Read");
  }
	/* rafa */
  //ERRORassert();
	/* rafa */
#ifdef USE_BGTREE_CACHE
  cacheAddr = addr;
  cacheUserData = userData;
  memcpy(&cacheBlock, ptr, BlockSize);
#endif
  c->fileStateVersion = FileStateVersion();
}

/** User supplied function to allocate a new block **/
BlockAddrT AllocBlock(void *userData) { assert(0); } // read only

void SaveBlock(BlockAddrT addr, Node *buffer, void *userData) { assert(0); } // read only

