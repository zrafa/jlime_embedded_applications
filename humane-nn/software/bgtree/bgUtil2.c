/** Utility Functions for bgTree which MAY RELY
 * UPON STANDARD LIBRARIES **/

#include <stdio.h>
#include <string.h>
#include "Errors.h"
#include "bgCore.h"
#include "bgUtil2.h"

#ifndef AVR
#  define fprintf_P fprintf
#  define printf_P printf
#  define PSTR(x) (x)
#else
#  include <avr/pgmspace.h>
#endif

int UnpackStringFromFile(FILE *f, char *buf, int buflen) {
  /** Read size **/
  uint32_t sz;
  int r;
  r = fread(&sz, 4, 1, f);
  if (r != 1) {
    ERRORreturn2("Unable to read size int from file", -1);
  }
  uint32_t sz2 = (buflen > sz) ? sz : buflen;

  /** Read string **/
  r = fread(buf, 1, sz2, f);
  if (r != sz2) {
    ERRORreturn2("Unable to read string from filen",-2);
    return -4;
  }
  return sz + 4;
}

int32_t UnpackIntFromFile(FILE *f) {
  int r;
  int32_t v;
  r = fread(&v, 4, 1, f);
  if (r != 1)
    ERRORreturn2("Unable to read size int from file", -999);
  return v;
}

uint32_t UnpackUIntFromFile(FILE *f) {
  int r;
  uint32_t v;
  r = fread(&v, 4, 1, f);
  if (r != 1)
    ERRORreturn2("Unable to read size int from file", -999);
  return v;
}

uint32_t SchemaGetOffset(FILE *blob, char *schema, int field) {
  uint32_t offset = 0;
  uint32_t buf;
  for (int i=0; i<field; ++i) {
    assert(schema[i]);
    if (schema[i] == 'I' || schema[i] == 'i' 
        || schema[i] == 'x' || schema[i] == 'X') 
    {
      offset += 4;
      int r = fread(&buf, 4, 1, blob);
      if (r != 1) {
        if (IsError) {
          ERRORprint();
        }
        ERRORreturn2("Unable to read int from file", 0);
      }
    } else if (schema[i] == 's' || schema[i] == 'K') {
      offset += 4;
      int r = fread(&buf, 4, 1, blob);
      if (r != 1) 
        ERRORreturn2("Unable to read int from file", 0);
      offset += buf;
      for (int j=0; j<buf; ++j) {
        char c;
        int r = fread(&c, 1, 1, blob);
        if (r != 1) 
          ERRORreturn2("Unable to read string from file", 0);
      }
    } else {
      assert(!"Invalid Schema");
    }
  }
  return offset;
}

uint32_t SchemaGetUInt(FILE *blob, char *schema, int field) {
  require(schema[field] == 'I' || schema[field] == 'x' || schema[field] == 'X');
  SchemaGetOffset(blob, schema, field);
  return UnpackUIntFromFile(blob);
}

int32_t SchemaGetInt(FILE *blob, char *schema, int field) {
  require(schema[field] == 'i');
  SchemaGetOffset(blob, schema, field);
  return UnpackIntFromFile(blob);
}

uint32_t SchemaGetString(FILE *blob, char *schema, int field, char *outBuf, int bufLen) {
  assert(schema[field] == 's' || schema[field] == 'K');
  SchemaGetOffset(blob, schema, field);
  if (IsError) return 0;
  uint32_t sz;
  int r = fread(&sz, 4, 1, blob);
  if (r != 1) 
    ERRORreturn2("Unable to read string size from file", 0);
  uint32_t sz2 = bufLen - 1;
  if (sz2 < sz) sz = sz2;
  r = fread(outBuf, sz, 1, blob);
  if (r != 1)
    ERRORreturn2("Unable to read full string from file", 0);
  outBuf[sz] = 0x0;
  return sz; 
}

uint32_t SchemaGetStringLen(FILE *blob, char *schema, int field) {
  assert(schema[field] == 's' || schema[field] == 'K');
  SchemaGetOffset(blob, schema, field);
  uint32_t sz;
  int r = fread(&sz, 4, 1, blob);
  if (r != 1) 
    ERRORreturn2("Unable to read string size from file", 0);
  return sz; 
}

int UnpackAndPrintStringFromFile(FILE *blob, FILE *output) {
  uint32_t textSize = UnpackUIntFromFile(blob);
  for (int i=0; i<textSize; ++i) {
    char buf;
    int n = fread(&buf, 1, 1, blob); // kinda inefficient
    assert(n == 1);
    fputc(buf, output);
  }
  return textSize;
}

int PrintVisitor(BAT block, Node *n) {
  int depth = n->depth;
  for (int i=0; i<depth; i++)
    printf_P(PSTR("LV%i\t"), i);
  printf_P(PSTR("%08x "), block);
  if (n->length > 0)
    printf_P(PSTR("(%i - %i+)"), n->keys[0], n->keys[NodeLen(block)-1]);
  else
    printf_P(PSTR("LENGTH=0!"));
  printf_P(PSTR(" parent=%x"), n->parentNode);
  printf_P(PSTR("\n"));
  int nlen = NodeLen(block);
  printf_P(PSTR("  "));
  if (depth == 0) { // leaf
    for (int i=0; i<nlen; i++)
      printf_P(PSTR("%i:%i "), n->keys[i], n->items[i]);
    printf_P(PSTR("\n"));
  } else {
    for (int i=0; i<nlen; i++)
      printf_P(PSTR("%i:0x%x "), n->keys[i], n->items[i]);
    printf_P(PSTR("\n"));
  }
  return 0;
}

int TestSanityVisitor(BAT block, Node *n) {
  printf_P(PSTR("TestSanityVisitor %08x\n"),block);
  assert(NodeLen(block) > 0);
  assert(NodeParent(block) != block);
  if (NodeParent(block) != BAInvalid)
    assert(NodeDepth(NodeParent(block)) > NodeDepth(block));
  assert((NodeDepth(block)==0) == (NodeDepth(block) == 0));
  return 0;
}

