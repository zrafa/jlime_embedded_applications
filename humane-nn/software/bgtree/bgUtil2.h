#ifndef BGUTIL2_H_
#define BGUTIL2_H_ 1

#include <stdio.h>
#include <stdint.h>
#include "bgDefines.h"

int UnpackStringFromFile(FILE *f, char *buf, int buflen);

int32_t UnpackIntFromFile(FILE *f);

uint32_t UnpackUIntFromFile(FILE *f);

/** Returns number of bytes written to output **/
int UnpackAndPrintStringFromFile(FILE *blob, FILE *output);

uint32_t SchemaGetOffset(FILE *blob, char *schema, int field);
uint32_t SchemaGetUInt(FILE *blob, char *schema, int field);
int32_t SchemaGetInt(FILE *blob, char *schema, int field);
uint32_t SchemaGetString(FILE *blob, char *schema, int field, char *outBuf, int bufLen);
uint32_t SchemaGetStringLen(FILE *blob, char *schema, int field);

int PrintVisitor(BAT block, Node *n);

/** Tests integrity of B-tree **/
int TestSanityVisitor(BAT block, Node *n);

#endif // BGUTIL2_H_
