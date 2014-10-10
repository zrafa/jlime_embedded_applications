#include "bgCore.h"
#include "Platform.h"
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>

void *bgUserData;

void SetUserData(void *userData) {
  bgUserData = userData;
}
void *GetUserData() {
  return bgUserData;
}

/* Inefficient, should probably stash parent index in Node
 * structure. */
// accesses on parent: NodeLen, items[]
uint16_t FindIndexOfChild(BAT parent, BAT child) {
  Node n;
  NodeLoad(&n, parent);
  for (int i=0; i<n.length; ++i)
    if (n.items[i] == child)
      return i;
  return (uint16_t) -1;
}

int FindInternalNode(BAT *ret, BAT nodeAddr, KeyT key, BAT *outParent, int *outIndex, BAT *child) {
  Node node; 
  NodeLoad(&node, nodeAddr);
  if (node.depth == 0) { // leaf nodes special case
    for (int i=0; (i<node.length) && (key >= node.keys[i]); i++) {
      if (key == node.keys[i]) { // found it!
        *outParent = nodeAddr;
        *outIndex = i;
        *ret = node.items[i];
        return 1;
      }
    }
    // didn't find it. fail.
    *ret = BAInvalid;
    return 1;
  }

  int i; // position us so that i is the child we want
  for (i = 0; (i < node.length) && (key > node.keys[i]); i++)
    ;
  if (i >= node.length) {
    *ret = BAInvalid;
    return 1;
  }
  *child = node.items[i]; 
  return 0;
}

// accesses on nodeAddr: len, depth, keys, item[i] (if match)
BAT FindInternal(BAT nodeAddr, KeyT key, BAT *outParent, int *outIndex) {
  BAT child=nodeAddr;
  BAT ret;
  while (1) { // this is a tail recursion
    if (FindInternalNode(&ret, child, key, outParent, outIndex, &child)) {
      return ret;
    }
  }
}

void NodeInit(Node *n) {
  int i;
  n->parentNode = BAInvalid;
  n->depth = 0;
  n->length = 0;
  for (i=0; i<ItemsPerNode; ++i)
    n->items[i] = BAInvalid;
  for (i=0; i<ItemsPerNode; ++i)
    n->keys[i] = BAInvalid;
}

/** Returns the last leaf node under the spcified node.  depth = 0 = leaf node **/
// accesses on node: depth
BAT GetLastNodeOfDepth(BAT node, uint8_t depth) {
  if (node == BAInvalid)
    return BAInvalid;
  NodeSummary ns = NodeSummaryLoad(node);
  if (ns.depth == depth)
    return node;
  else
    return GetLastNodeOfDepth(ns.lastItem, depth);
}

/** Create a NodeSummary structure from a full Node structure **/
NodeSummary NodeSummaryCreate(Node *n) {
  NodeSummary h;
  h.parentNode = n->parentNode;
  h.depth = n->depth;
  h.length = n->length;
  h.firstItem = n->length ? n->items[0] : BAInvalid;
  h.lastItem = n->length ? n->items[n->length -1] : BAInvalid;
  return h;
}

/** Like NodeLoad(), but throws away everything and only keeps a NodeSummary
 * structure **/
NodeSummary NodeSummaryLoad(BAT node) {
  NodeSummary ns;
  if (node == BAInvalid) // basically returns nonsense
    return ns;
  Node n;
  NodeLoad(&n, node);
  return NodeSummaryCreate(&n);
}

BAT NodeItemLoad(BAT node, int idx) {
  Node n;
  NodeLoad(&n, node);
  return n.items[idx];
}

KeyT NodeKeyLoad(BAT node, int idx) {
  Node n;
  NodeLoad(&n, node);
  return n.keys[idx];
}

BAT NodeParent(BAT node) {
  Node ns;
  NodeLoad(&ns, node);
  return ns.parentNode;
}

BAT NodeLen(BAT node) {
  Node ns;
  NodeLoad(&ns, node);
  return ns.length;
}

int8_t NodeDepth(BAT node) {
  Node ns;
  NodeLoad(&ns, node);
  return ns.depth;
}

void NodeLoad(Node *n, BAT addr) {
  LoadBlock(addr, n, bgUserData);
}

void NodeSave(Node *n, BAT addr) {
  SaveBlock(addr, n, bgUserData);
}

/** Returns last non-full non-leaf node, or invalid if there is none **/
// accesses on node: IsLeaf, len
BAT GetLastNonFullDescendant(BAT node) {
  if (node == BAInvalid)
    return BAInvalid;
  NodeSummary nnode = NodeSummaryLoad(node);
  if (nnode.depth == 0) // is leaf
    return BAInvalid;
  BAT nonFull = GetLastNonFullDescendant(nnode.lastItem);
  if ((nonFull == BAInvalid) && (nnode.length < ItemsPerNode))
    return node;
  return nonFull;
}

// accesses depth, InitNode(), SaveBlock, keys, items, everythgin
BAT CreateDescendingNodes(int depth, KeyT lowest) {
  BAT n = AllocBlock(bgUserData);
  {Node nn;
    NodeInit(&nn);
    nn.depth = depth;
    NodeSave(&nn, n);
  }
  if (depth == 0)
    return n;
  BAT child = CreateDescendingNodes(depth - 1, lowest);
  {Node nn; NodeLoad(&nn, n);
    nn.keys[0] = lowest;
    nn.items[0] = child;
    nn.length=1;
    NodeSave(&nn, n);
  }
  {Node nchild; NodeLoad(&nchild, child);
    nchild.parentNode = n;
    NodeSave(&nchild, child);
  }
  return n;
}

/** Adds a new node to a full tree **/
BAT AppendNewLeafNode(BAT topNode) {
  BAT nonFull = GetLastNonFullDescendant(topNode);
  if (nonFull == BAInvalid)
    return BAInvalid; /** The tree is entirely full.  You'd need to add levels.  We dont support that. **/
  NodeSummary nfSummary = NodeSummaryLoad(nonFull);
  /* Build out string of nodes to the leaf level */
  BAT newNodes = CreateDescendingNodes(nfSummary.depth - 1, 0);
  {Node nfNode; NodeLoad(&nfNode, nonFull);
    nfNode.keys[nfNode.length] = 0; // fixed later
    nfNode.items[nfNode.length] = newNodes;
    nfNode.length++;
    NodeSave(&nfNode, nonFull);
  }
  {Node nNewNodes; NodeLoad(&nNewNodes, newNodes);
    nNewNodes.parentNode = nonFull;
    NodeSave(&nNewNodes, newNodes);
  }
  /* Return the leaf level node of the new nodes */
  BAT n = newNodes;
  for (int i=nfSummary.depth - 2; i >= 0; i--) {
    Node nn; NodeLoad(&nn, n);
    n = nn.items[0];
  }
  return n;
}

/** A traversal which invokes NodeVisitor on each node.  If NodeVisitor returns
 * a non-zero value, then the traversal is terminated and the current node is
 * returned to the caller **/
BAT NodeVisitDFS(BgTree tree, NodeVisitor func, BAT node) {
  if (node == BAInvalid)
    return BAInvalid;
  SetUserData(tree.userData);
  NodeSummary snode = NodeSummaryLoad(node);
  /** Traverse children **/
  if (snode.depth != 0) {
    for (int i=0; i<snode.length; i++)
      NodeVisitDFS(tree, func, NodeItemLoad(node, i));    
  }
  /** Call user visitor **/
  {Node nnode; NodeLoad(&nnode, node);
    int ret = (*func)(node, &nnode);
    if (ret) // Visitor is done, return node where he finished
      return node;
  }
  return BAInvalid;
}

/** Calculates the number of bytes to hold a tree for a set number of elements
 *  May be slightly larger than actually required (by a few blocks) **/
int CalcTreeSize2(int numItems, int depth) {
  int summ=0;
  int n = numItems;
  for (int i=0; i<depth; i++) {
    printf("L%i = %lu\n", i, (unsigned long int) n/ItemsPerNode + 1);
    n = n/ItemsPerNode + 1; /* 1 is a slop factor - could be more precise */
    summ += n;
  }
  return summ * BlockSize;
}

/** Calculate the Minimum tree depth given the number of items to store and the
 * tree parameters.  Might be a little conservative (aka, sloppy). **/
int CalcMinimumDepth(int numItems) {
  int priorn = -999;
  int n = numItems;
  for (int i=0; i<99; i++) {
    n = n/ItemsPerNode + 1; /* 1 is a slop factor - could be more precise */
    if ((n == priorn) && (n == 1))
      return i + 1 + (i == 0);
    priorn = n;
  }
  assert(0);
}

BAT NodeNextLeaf(BAT node, BAT child) {
  if (node == BAInvalid)
    return BAInvalid;
  int index = FindIndexOfChild(node, child);
  assert(index != (uint16_t) -1);
  if (index < NodeLen(node)-1) {
    // descend to the left
    BAT nextChild = NodeItemLoad(node, index + 1);
    while (NodeDepth(nextChild) != 0) {
      nextChild = NodeItemLoad(nextChild, 0);
      assert(nextChild != BAInvalid);
    }
    return nextChild;
  }
  return NodeNextLeaf(NodeParent(node), node);
}

RowPtr RowPtrInit(BgTree table) {
  RowPtr rp;
  rp.tree = table;
  rp.node = BAInvalid;
  rp.index = (uint16_t) -1;
  return rp;
}

RowPtr RowPtrNext(RowPtr row) {
  if (row.node == BAInvalid) {
    return row;
  } if (row.index < NodeLen(row.node) - 1) {
    row.index += 1;
    return row;
  }
  BAT nextLeaf = NodeNextLeaf(NodeParent(row.node), row.node);
  row.node = nextLeaf;
  row.index = 0;
  return row;
}

/** Finds the left-most leaf child node (assumes that there IS one) **/
BAT NodeFindFirstChild(BAT node) {
  if (node == BAInvalid)
    return BAInvalid;
  if (NodeDepth(node) == 0)
    return node;
  return NodeFindFirstChild(NodeItemLoad(node, 0));
}
