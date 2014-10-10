#ifndef BGDEFINES_H_
#define BGDEFINES_H_ 1

#include <stdint.h>

#define BlockSize 128

/** Type of block address.  
 * The meaning of this is opaque to Low level routines **/
typedef uint32_t BlockAddrT;
typedef BlockAddrT BAT; /**< Shorthand because we use it so much **/

/** Special "Invalid" address is used for empty responses, etc 
 *  BA stands for BlockAddr **/
#define BAInvalid ((BlockAddrT) -1)

/** Type of B-tree keys.  
 * Compromise between size and collisions.  The key must have comparable and
 * equality funcs.  Otherwise it is treated as an opaque blob**/
typedef uint32_t KeyT; 

#define NodeHeadSize (sizeof(BlockAddrT) + 4*sizeof(uint8_t))
#define ItemsPerNode ((BlockSize - NodeHeadSize)/(sizeof(KeyT) + sizeof(BlockAddrT)))
typedef struct {
  BlockAddrT parentNode;
  uint8_t depth; /**< 0 = leaf node, else height of node **/
  uint8_t length; /**< number of items in node **/
  uint8_t dummy2; /**< alignment only **/
  uint8_t dummy3;
  KeyT keys[ItemsPerNode];
  BlockAddrT items[ItemsPerNode];
} Node;

/** User-supplied function loads block as addr, returning result in buffer.
 * buffer is a pre-allocated array of size blkSize **/
void LoadBlock(BlockAddrT addr, Node *n, void *userData);

/** User supplied function to allocate a new block **/
BlockAddrT AllocBlock(void *userData);

void SaveBlock(BlockAddrT addr, Node *buffer, void *userData);

#endif /* BGDEFINES_H_ */
