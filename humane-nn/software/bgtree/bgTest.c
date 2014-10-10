#include "bgApi.h"
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdlib.h>
#include "bgUtil2.h"
#include "Errors.h"

ErrorsGlobals

#define MEMSIZE BlockSize*4096
char mem[MEMSIZE];
uint32_t memLast=0;

void LoadBlock(BlockAddrT addr, Node *ptr, void *userData) {
  assert(addr != BAInvalid);
  memcpy(ptr, &mem[addr], BlockSize);
}

void UnloadBlock(BlockAddrT addr, Node *ptr) {
  assert(addr != BAInvalid);
  assert(ptr);
  // nop
}

/** User supplied function to allocate a new block **/
BlockAddrT AllocBlock(void *userData) {
  BlockAddrT p = memLast;
  memLast += BlockSize;
  assert(memLast < MEMSIZE); 
  return p;
}

void SaveBlock(BlockAddrT addr, Node *buffer, void *userData) {
  if ((char *) buffer == &mem[addr]) 
    return;
  memcpy(&mem[addr], buffer, BlockSize);
}

void Test1() {
}

void Test2() {
  KeyT keys[1024];
  BlockAddrT values[1024];
  for (int i=0; i<1024; ++i) {
    keys[i] = i;
    values[i] = 10*i;
  }
  BgTree tree = TreeCreate(1024, 0x0);
  for (int i=0; i<1024; ++i) {
    //printf("%i", i);
    TreeAppend(tree, keys[i], values[i]);
  }

  NodeVisitDFS(tree, &PrintVisitor, tree.topNode);

  int cnt=0;
  for (int wanted=0; wanted<1024; wanted++) {
    BAT outParent;
    int outIndex;
    BAT found = FindInternal(tree.topNode, wanted, &outParent, &outIndex);
    if (found == BAInvalid) {
      printf("%i NOT FOUND!\n", wanted);
    } else {
      //printf("%i WAS FOUND!", wanted);
      cnt++;
    }
  }
  assert(cnt == 1024);

  int count=0;
  Cursor c = SelectConsecutiveKeys(tree, 237);
  for (int res = CursorNext(&c); res != BAInvalid; res = CursorNext(&c)) {
    assert(res == 10*(237 + count));
    ++count;
  }
  assert(count == 1024 - 237);
  CursorDestroy(&c);
}

/** Tests use of the new API defined in bgApi.h **/
void Test3() {
  char *db1 = "abcdefghijklmnop";
  char *db2 = "mnopqrstuvwxyz";
  BgTree tree = TreeCreate(strlen(db1),0x0);
  NodeVisitDFS(tree, &PrintVisitor, tree.topNode);
  for (char *p=db1; *p; p++) 
    TreeAppend(tree, p-db1, *p);
  printf("New Populated Tree\n");
  NodeVisitDFS(tree, &PrintVisitor, tree.topNode);
  Cursor c = SelectKey(tree, 3);
  BAT v = CursorNext(&c);
  assert(v == 'd');
  v = CursorNext(&c);
  assert(v == BAInvalid);
  v = CursorNext(&c);
  assert(v == BAInvalid);
  CursorDestroy(&c);

  c = SelectAll(tree);
  for (char *p=db1; *p; p++) {
    v = CursorNext(&c);
    assert(v == *p);
    printf("%c=%c ",*p, v);
  }
  assert(CursorNext(&c) == BAInvalid);
  CursorDestroy(&c);

  c = SelectKey(tree,4);
  Cursor c2 = SelectKey(tree,10);
  Cursor cunion = Union(&c, &c2);
  v = CursorNext(&cunion);
  assert(v == ('a' + 4));
  v = CursorNext(&cunion);
  assert(v == ('a' + 10));
  CursorDestroy(&c);

  // Create second table
  BgTree tree2 = TreeCreate(strlen(db2), 0x0);
  for (char *p=db2; *p; p++) 
    TreeAppend(tree2, p-db2, *p);
 
  // Intesection of both tables
  c = SelectAll(tree);
  c2 = SelectAll(tree2);
  Cursor icpt = Intersection(&c, &c2);
  for (v = CursorNext(&icpt); v != BAInvalid; v = CursorNext(&icpt)) {
    printf("%c",v);
  }
  CursorDestroy(&icpt);
}

void Test4() {
  BgTree tree = TreeCreate(2371, 0x0);
  for (int i=0; i<2371; ++i)
    TreeAppend(tree, i, i+1);
  //NodeVisitDFS(tree, &PrintVisitor, tree.topNode);
  NodeVisitDFS(tree, &TestSanityVisitor, tree.topNode);
  Cursor c = SelectAll(tree);
  int count=0;
  for (int res = CursorNext(&c); res != BAInvalid; res = CursorNext(&c)) {
    assert(res = count + 1);
    ++count;
  }
  assert(count == 2371);
  CursorDestroy(&c);

  int v[]={111, 2370, 0};  // test vector
  for (int i=0; i<3; ++i) {
    c = SelectKey(tree, v[i]);
    count = 0;
    for (int res = CursorNext(&c); res != BAInvalid; res = CursorNext(&c))  {
      assert(res == v[i]+1);
      ++count;
    }
    assert(count == 1);
    CursorDestroy(&c);
  }

  for (int i=0; i<1000; ++i) {
    KeyT key = 101*i % 2371;
    c = SelectConsecutiveKeys(tree, key);
    count = 0;
    for (int res = CursorNext(&c); res != BAInvalid; res = CursorNext(&c))  {
      assert(res == count + key + 1);
      ++count;
    }
    assert(count == 2371 - key);
    CursorDestroy(&c);
  }
}

int main(int argc, char **argv) {
#ifdef AVR
  PlatformInit();
#endif
  Test1();
  Test2();
  Test3();
  Test4();
  return 0;
}
