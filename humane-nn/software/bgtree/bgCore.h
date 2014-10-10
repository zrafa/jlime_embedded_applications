#ifndef BGCORE2_H_
#define BGCORE2_H_ 1
#include "bgDefines.h"

typedef struct {
  BlockAddrT topNode;
  void *userData;
} BgTree;

/** References a row within the tree. **/
typedef struct {
  BgTree tree;
  BAT node;
  int index;
} RowPtr;

/** Contains a few key pieces of information which I often need from a Node,
 * without needed to keep the full node in memory. **/
typedef struct {
  BlockAddrT parentNode;
  uint8_t depth;
  uint8_t length;
  BlockAddrT firstItem, lastItem;
} NodeSummary;

/** Set/Get the global user data pointer passed to Load/Unload/SaveBlock
 * user-provided functions.  This is usually handled by the bgApi routines,
 * with a unique user data pointer associated with a BgTree structure **/
void SetUserData(void *userData);
void *GetUserData();

/** Like NodeLoad(), but throws away everything and only keeps a NodeSummary
 * structure **/
NodeSummary NodeSummaryLoad(BAT node);
void NodeInit(Node *n);
BAT NodeItemLoad(BAT node, int idx);
KeyT NodeKeyLoad(BAT node, int idx);
BAT NodeParent(BAT node);
BAT NodeLen(BAT node);
int8_t NodeDepth(BAT node);
void NodeLoad(Node *n, BAT addr);
void NodeSave(Node *n, BAT addr);

/* Inefficient, should probably stash parent index in Node
 * structure. */
uint16_t FindIndexOfChild(BAT parent, BAT child);

typedef int (*NodeVisitor)(BAT block, Node *node);
BAT NodeVisitDFS(BgTree tree, NodeVisitor func, BAT node);
/** Finds the left-most leaf child node (assumes that there IS one) **/
BAT NodeFindFirstChild(BAT node);

int SetKeysVisitor(BAT block, Node *n);
BAT FindInternal(BAT nodeAddr, KeyT key, BAT *outParent, int *outIndex);

/** Calculates the number of bytes to hold a tree for a set number of elements
 *  May be slightly larger than actually required (by a few blocks) **/
int CalcTreeSize2(int numItems, int depth);

/** Calculate the Minimum tree depth given the number of items to store and the
 * tree parameters.  Might be a little conservative (aka, sloppy). **/
int CalcMinimumDepth(int numItems);

BAT NodeNextLeaf(BAT node, BAT child);

RowPtr RowPtrInit(BgTree table);
RowPtr RowPtrNext(RowPtr row);

/** Returns the last leaf node under the spcified node.  depth = 0 = leaf node **/
BAT GetLastNodeOfDepth(BAT node, uint8_t depth);

/** Adds a new node to a full tree **/
BAT AppendNewLeafNode(BAT topNode);

#endif // BGCORE2_H_
