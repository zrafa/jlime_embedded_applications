#include "bgApi.h"
#include <assert.h>
#include <stdlib.h>

BAT CursorKeyNext(Cursor *c) {
  if (c->u.keyInfo.row.node == BAInvalid)
    return BAInvalid;
  SetUserData(c->u.keyInfo.row.tree.userData);
  // key == BAInvalid indicates a SelectAll()
  if (c->u.keyInfo.key != BAInvalid) { 
    BAT key = NodeKeyLoad(c->u.keyInfo.row.node, c->u.keyInfo.row.index);
    if (key != c->u.keyInfo.key)
      return BAInvalid;
  }
  BAT value = NodeItemLoad(c->u.keyInfo.row.node, c->u.keyInfo.row.index);
  c->u.keyInfo.row = RowPtrNext(c->u.keyInfo.row);
  SetUserData(0x0); // catch errors quicker
  return value;
}

BAT CursorConsecutiveKeysNext(Cursor *c) {
  if (c->u.keyInfo.row.node == BAInvalid)
    return BAInvalid;
  SetUserData(c->u.keyInfo.row.tree.userData);
  // key == BAInvalid indicates a SelectAll()
  if (c->u.keyInfo.key != BAInvalid) { 
    BAT key = NodeKeyLoad(c->u.keyInfo.row.node, c->u.keyInfo.row.index);
    if ((key != c->u.keyInfo.key) && (key != c->u.keyInfo.key + 1))
      return BAInvalid;
    c->u.keyInfo.key = key;
  }
  BAT value = NodeItemLoad(c->u.keyInfo.row.node, c->u.keyInfo.row.index);
  c->u.keyInfo.row = RowPtrNext(c->u.keyInfo.row);
  SetUserData(0x0); // catch errors quicker
  return value;
}

BAT CursorUnionNext(Cursor *c) {
  BAT value = CursorNext(c->u.binaryInfo.a);
  if (value != BAInvalid)
    return value;
  value = CursorNext(c->u.binaryInfo.b);
  return value;
}

BAT CursorIntersectionNext(Cursor *c) {
  while (1) {
    while (c->u.binaryInfo.aLastValue > c->u.binaryInfo.bLastValue) {
      c->u.binaryInfo.bLastValue = CursorNext(c->u.binaryInfo.b);
    }
    while (c->u.binaryInfo.bLastValue > c->u.binaryInfo.aLastValue) {
      c->u.binaryInfo.aLastValue = CursorNext(c->u.binaryInfo.a);
    }
    if (c->u.binaryInfo.aLastValue == c->u.binaryInfo.bLastValue) {
      BAT value = c->u.binaryInfo.aLastValue; 
      c->u.binaryInfo.aLastValue = CursorNext(c->u.binaryInfo.a);
      c->u.binaryInfo.bLastValue = CursorNext(c->u.binaryInfo.b);
      return value;
    }
  }
}

BAT CursorUniqueNext(Cursor *c) {
  return BAInvalid;
}

BAT CursorNext(Cursor *c) {
  return (*c->nextFunc)(c);
}

Cursor CursorInit(BgTree table, BAT (*nextFunc)(Cursor *c)) {
  Cursor c;
  c.u.keyInfo.row = RowPtrInit(table);
  c.u.keyInfo.key = 0;
  c.nextFunc = nextFunc;
  return c;
}

Cursor SelectKey(BgTree table, KeyT key) {
  Cursor c;
  c.u.keyInfo.row = RowPtrInit(table);
  c.u.keyInfo.key = key;
  c.nextFunc = &CursorKeyNext;
  SetUserData(table.userData);
  FindInternal(table.topNode, key, &c.u.keyInfo.row.node, &c.u.keyInfo.row.index);
  SetUserData(0x0);
  return c;
}

Cursor SelectConsecutiveKeys(BgTree table, KeyT key) {
  Cursor c;
  c.u.keyInfo.row = RowPtrInit(table);
  c.u.keyInfo.key = key;
  c.nextFunc = &CursorConsecutiveKeysNext;
  SetUserData(table.userData);
  FindInternal(table.topNode, key, &c.u.keyInfo.row.node, &c.u.keyInfo.row.index);
  SetUserData(0x0);
  return c;
}

Cursor SelectAll(BgTree table) {
  Cursor c;
  SetUserData(table.userData);
  c.u.keyInfo.row = RowPtrInit(table);
  c.u.keyInfo.row.node = NodeFindFirstChild(table.topNode);
  c.u.keyInfo.row.index = 0;
  c.u.keyInfo.key = BAInvalid;
  c.nextFunc = &CursorKeyNext;
  SetUserData(0x0);
  return c;
}

Cursor Union(Cursor *a, Cursor *b) {
  Cursor c;
  Cursor *aa = (Cursor *) malloc(sizeof(Cursor));
  *aa = CursorCreateInvalid();
  Cursor *bb = (Cursor *) malloc(sizeof(Cursor));
  *bb = CursorCreateInvalid();
  CursorDup(aa, a);
  CursorDup(bb, b);
  c.u.binaryInfo.a = aa;
  c.u.binaryInfo.b = bb;
  c.nextFunc = &CursorUnionNext;
  return c;
}

Cursor Intersection(Cursor *a, Cursor *b) {
  Cursor c;
  Cursor *aa = (Cursor *) malloc(sizeof(Cursor));
  *aa = CursorCreateInvalid();
  Cursor *bb = (Cursor *) malloc(sizeof(Cursor));
  *bb = CursorCreateInvalid();
  CursorDup(aa, a);
  CursorDup(bb, b);
  c.u.binaryInfo.a = aa;
  c.u.binaryInfo.b = bb;
  c.u.binaryInfo.aLastValue = CursorNext(a);
  c.u.binaryInfo.bLastValue = CursorNext(b);
  c.nextFunc = &CursorIntersectionNext;
  return c;
}

void CursorDup(Cursor *dest, Cursor *src) {
  CursorDestroy(dest);
  *dest = *src;
  if (src->nextFunc == &CursorIntersectionNext
      || src->nextFunc == &CursorUnionNext) 
  {
    Cursor *aa = (Cursor *) malloc(sizeof(Cursor));
    *aa = CursorCreateInvalid();
    Cursor *bb = (Cursor *) malloc(sizeof(Cursor));
    *bb = CursorCreateInvalid();
    CursorDup(aa, src->u.binaryInfo.a);
    CursorDup(bb, src->u.binaryInfo.b);
    dest->u.binaryInfo.a = aa;
    dest->u.binaryInfo.b = bb;
  }
}

void CursorDestroy(Cursor *c) {
  if (CursorIsInvalid(c))
    return;
  if (c->nextFunc == &CursorIntersectionNext
      || c->nextFunc == &CursorUnionNext) 
  {
    if (c->u.binaryInfo.a) {
      CursorDestroy(c->u.binaryInfo.a);
      free(c->u.binaryInfo.a);
    }
    if (c->u.binaryInfo.b) {
      CursorDestroy(c->u.binaryInfo.b);
      free(c->u.binaryInfo.b);
    }
  }
}

BAT CursorPeek(Cursor *c) {
  Cursor d = CursorCreateInvalid();
  CursorDup(&d, c);
  BAT b = CursorNext(&d);
  CursorDestroy(&d);
  return b;
}

int CalcTreeSize(int numItems) {
  return CalcTreeSize2(numItems, CalcMinimumDepth(numItems));
}

BgTree TreeCreate(int numItems, void *userData) {
  int depth = CalcMinimumDepth(numItems);
  BlockAddrT top = AllocBlock(GetUserData());
  Node topNode;
  NodeInit(&topNode);
  topNode.depth = depth;
  NodeSave(&topNode, top);
  BgTree tree;
  tree.topNode = top;
  tree.userData = userData;
  return tree;
}

void TreeInit(BgTree *t, void *userData) {
  t->topNode = 0x0;
  t->userData = userData;
}

void TreeAppend(BgTree tree,  KeyT key, BAT value) {
  int n;
  SetUserData(tree.userData);
  BAT topNode = tree.topNode;
  BAT last = GetLastNodeOfDepth(topNode, 0);
  if ((last == BAInvalid) || (NodeLen(last) == ItemsPerNode)) { // filled, create one or more new nodes
    last = AppendNewLeafNode(topNode);
    assert(last != BAInvalid);
    n = 0;
  } else {
    n = NodeLen(last);
  }
  {Node nLast; NodeLoad(&nLast, last);
    nLast.keys[n] = key;
    nLast.items[n] = value;
    nLast.length = n+1;
    NodeSave(&nLast, last);
  }
  // key is by definition the highest in the tree so far
  for (BAT upNode = NodeParent(last); upNode != BAInvalid; upNode = NodeParent(upNode)) {
    Node up; NodeLoad(&up, upNode);
    up.keys[up.length - 1] = key;
    NodeSave(&up, upNode);
  }
  SetUserData(0x0);
}

