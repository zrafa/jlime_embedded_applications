#ifndef BGAPI_H
#define BGAPI_H 1

#include "bgCore.h"

typedef struct Cursor_ {
  BAT (*nextFunc)(struct Cursor_ *);
  union {
    struct {
      RowPtr row;
      KeyT key;
    } keyInfo;
    struct {
      struct Cursor_ *a;
      struct Cursor_ *b;
      BAT aLastValue, bLastValue;
    } binaryInfo;
    struct {
      struct Cursor_ *a;
      BAT lastValue;
    } uniqueInfo;
  } u;
} Cursor;

/** Allocate and initialize a new BgTree capable of holding
 * the specified number of items **/
BgTree TreeCreate(int numItems, void *userData);

void TreeInit(BgTree *t, void *userData);

/** Append a key/value pair to the tree **/
void TreeAppend(BgTree tree,  KeyT key, BAT value);

/** Calculate the size in bytes of storage space required to
 * hold a tree containing the specified number of items.  Use
 * this for pre-allocation of space if required **/
int CalcTreeSize(int numItems);

/** Returns a Cursor to all items in table with key **/
Cursor SelectKey(BgTree table, KeyT key);

/** Returns a Cursor to all items in table **/
Cursor SelectAll(BgTree table);

/** Returns a Cursor to item which matches with key, and all
 * items following with consecutive keys **/
Cursor SelectConsecutiveKeys(BgTree table, KeyT key);

/** Creates a new Cursor which iterates over all items in
 * either Cursor a or b.  Note: This does not preserve order. **/
Cursor Union(Cursor *a, Cursor *b);
/** Creates a new Cursor which iterates over all items which are BOTH in a and b. **/
Cursor Intersection(Cursor *a, Cursor *b);
/** TODO: Not Implemented **/
Cursor Unique(Cursor *a);

/** Get the current value from cursor and advance **/
BAT CursorNext(Cursor *c);

/** Duplicate a cursor.  Will call CursorDestroy(dest) first. **/
void CursorDup(Cursor *dest, Cursor *src);

/** Peek at the cursor's next value without incrementing the cursor.  Uses CursorDup() to make a copy and retrieve the result **/
BAT CursorPeek(Cursor *c);


/** Returns true if cursor is invalid **/ 
static inline int CursorIsInvalid(Cursor *c) {
  return !c->nextFunc;
}

/** Returns an invalid cursor **/
static inline Cursor CursorCreateInvalid() {
  Cursor c;
  c.nextFunc = 0x0;
  return c;
}

void CursorDestroy(Cursor *c);

#endif // BGAPI_H

