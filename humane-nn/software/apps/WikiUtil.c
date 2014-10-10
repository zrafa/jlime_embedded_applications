#include "vt52.h"
#include <string.h>
#include <ctype.h> // toupper
#include "crc32.h"
#include "bgUtil.h"
#include "bgUtil2.h"
#include "Platform.h"
#include "ListCmdr.h"
#include "bgApi.h"
#include "WikiUtil.h"

static inline uint32_t GetUInt(uint32_t offset, char *schema, int field) {
  FILE *blob = FileGetHandle();
  FileSeek(offset);
  return SchemaGetUInt(blob, schema, field);
}

static inline int32_t GetInt(uint32_t offset, char *schema, int field) {
  ///printf_P(PSTR("GetInt(%lu, 0x%lx, %i) = "), (unsigned long) offset, (unsigned long) schema, field);
  FILE *blob = FileGetHandle();
  FileSeek(offset);
  int res = SchemaGetInt(blob, schema, field);
  return res;
}

static inline int GetString(uint32_t offset, char *schema, int field, char *outBuf, int bufLen) {
  ///printf_P(PSTR("GetString(%li, %s, %i, ..)\n"),(unsigned long) offset, schema, field);
  FILE *blob = FileGetHandle();
  FileSeek(offset);
  if (IsError) return 0;
  return SchemaGetString(blob, schema, field, outBuf, bufLen);
}

static inline uint32_t GetStringLen(uint32_t offset, char *schema, int field) {
  FILE *blob = FileGetHandle();
  FileSeek(offset);
  return SchemaGetStringLen(blob, schema, field);
}

static inline char ToUpper(char a) {
  if ((a >= 'a') && (a <= 'z'))
    return a - ('a' - 'A');
  else
    return a;
}

KeyT CalcUpperCRC(const char *b) {
  assert(b);
  int blen = strlen(b);
  blen = blen > MORSEBOX_MAX-1 ? MORSEBOX_MAX-1 : blen;
  char up[MORSEBOX_MAX];
  for (int i=0; b[i] != 0x0; ++i)
    up[i] = ToUpper(b[i]);
  //  up[i] = toupper(b[i]);
  up[blen] = 0x0;
  return CalcCRC(up, blen);
}

Cursor tocLastCur;

char TocNext(ListGen *gen, char *outBuf, unsigned char outBufLen) {
  TocView *wa = (TocView *) gen->userData;
  while (1) {
    CursorDup(&tocLastCur, &wa->cur);
    BAT found = CursorNext(&wa->cur);
    if (found == BAInvalid)
      return 0;
    FileOpenRO(((DbContext*)wa->pageTree.userData)->blobFname);
    //ERRORassert();
    int level = GetInt(found, WIKI_SCHEMA, WIKI_LEVEL);
    int parent = GetUInt(found, WIKI_SCHEMA, WIKI_PARENT);
    if ((level == 0) && (parent != 0)) // redirect to self - filter
      continue;
    for (int i=0; i<level; ++i)
      outBuf[i] = '+';
    GetString(found, WIKI_SCHEMA, WIKI_TITLE, outBuf + level, outBufLen - level);
    //ERRORassert();
    return 1;
  }
}

void TocRestart(ListGen *gen) {
  TocView *wa = (TocView *) gen->userData;
  CursorDup(&wa->cur, &wa->startCur);
}

void TocInit(TocView *toc, KeyT titleCrc, DbContext *pageContext, unsigned char startRow, unsigned char nRows) {
  TreeInit(&toc->pageTree, pageContext);
  toc->titleCrc = titleCrc;
  ListGen tocGen = ListGenCreate(TocNext, TocRestart, (void*) toc);
  ListCmdrInit(&toc->cmdr, tocGen, startRow, nRows, 1, nRows/2);
  toc->startCur = SelectConsecutiveKeys(toc->pageTree, titleCrc);
  ListGenRestart(&toc->cmdr.filter.gen);
}

void TocDestroy(TocView *toc) {
  CursorDestroy(&toc->startCur);
  CursorDestroy(&toc->cur);
}

char SearchNext(ListGen *gen, char *outBuf, unsigned char outBufLen) {
  while (1) {
    SearchView *wa = (SearchView *) gen->userData;
    if (CursorIsInvalid(&wa->searchCur))
      return 0;
    BAT found = CursorNext(&wa->searchCur);
    if (found == BAInvalid)
      return 0;
    FileOpenRO(((DbContext*)wa->pageTree.userData)->blobFname);
    //ERRORassert();
    int level = GetInt(found, WIKI_SCHEMA, WIKI_LEVEL);
    int parent = GetUInt(found, WIKI_SCHEMA, WIKI_PARENT);
    if ((level == 0) && (parent != 0)) // redirect to self - filter
      continue;
    if (level != 0)
      return 0;
    if (outBuf)
      GetString(found, WIKI_SCHEMA, WIKI_TITLE, outBuf, outBufLen);
    return 1;
  }
}

void SearchRestart(ListGen *gen) {
  SearchView *wa = (SearchView *) gen->userData;
  char *b = MorseBoxGetBuffer(&wa->searchCmdr.mbox);
  KeyT key = CalcUpperCRC(b);
  CursorDestroy(&wa->searchCur);
  wa->searchCur = SelectKey(wa->pageTree, key);
}

char PreNext(ListGen *gen, char *outBuf, unsigned char outBufLen) {
  while (1) {
    SearchView *wa = (SearchView *) gen->userData;
    assert(!CursorIsInvalid(&wa->prefixCur));
    BAT found = CursorNext(&wa->prefixCur);
    if (found == BAInvalid)
      return 0;
    if (!outBuf)
      return 1;
    Cursor cur = SelectKey(wa->pageTree, found);
    BAT sec = CursorNext(&cur);
    if (sec == BAInvalid) {
      snprintf(outBuf, outBufLen, "%x", (unsigned int) found);
      return 1;
    }
    FileOpenRO(((DbContext*)wa->pageTree.userData)->blobFname);
    //ERRORassert();
    GetString(sec, WIKI_SCHEMA, WIKI_TITLE, outBuf, outBufLen);
    return 1;
  }
}

void PreRestart(ListGen *gen) {
  SearchView *wa = (SearchView *) gen->userData;
  char *b = MorseBoxGetBuffer(&wa->searchCmdr.mbox);
  KeyT key = CalcUpperCRC(b);
  CursorDestroy(&wa->prefixCur);
  wa->prefixCur = SelectKey(wa->prefixTree, key);
}

void SearchViewInit(SearchView *sv, DbContext *pageContext, DbContext *prefixContext, unsigned char startRow, unsigned char nRows) {
  TreeInit(&sv->pageTree, pageContext);
  TreeInit(&sv->prefixTree, prefixContext);

  ListGen searchGen = ListGenCreate(SearchNext, SearchRestart, (void*) sv);
  ListGen prefixGen = ListGenCreate(PreNext, PreRestart, (void*) sv);
  ListGen concatGen = ConcatGenCreate(&sv->concatGen, searchGen, prefixGen);
  ListCmdrInit(&sv->searchCmdr, concatGen, startRow, nRows, 0, nRows/2);
}

char SectionNext(ListGen *gen, char *outBuf, unsigned char outBufLen) {
  SectionView *wa = (SectionView *) gen->userData;
  char buf[LISTGEN_STRING_MAX];
  if (!wa->textLength)
    return 0;
  if (wa->textOffset >= wa->textStartOffset + wa->textLength)
    return 0;
  FileOpenRO(wa->pageContext->blobFname);
  FileSeek(wa->textOffset);
  //ERRORassert();
  uint32_t len = wa->textLength - (wa->textOffset - wa->textStartOffset);
  assert(outBufLen <= LISTGEN_STRING_MAX);
  len = len < outBufLen-1 ? len : outBufLen-1;
  char r = fread(buf, len, 1, FileGetHandle());
  if (r != 1)
    ERRORreturn2("SectionNext: Failure to read text", 0);
  buf[len] = 0x0;
  /* Check for newlines, which immediately terminate line */
  for (int i=0; i<len; ++i) {
    if (buf[i] == '\n') {
      buf[i] = 0x0;
      len = i + 1;
    }
  }
  /* Prevent orphaned char word splits */
  if (len > 3 && buf[len-1] != ' ') {
    if (buf[len-3] == ' ') {
      buf[len-3] = 0x0;
      len -= 2;
    } else if (buf[len-2] == ' ') {
      buf[len-2] = 0x0;
      len -= 1;
    }
  }
  if (outBuf)
    strncpy(outBuf, buf, outBufLen);
  wa->textOffset += len;
  return 1;
}

void SectionRestart(ListGen *gen) {
  SectionView *wa = (SectionView *) gen->userData;
  wa->textOffset = wa->textStartOffset;
}

void SectionViewInit(SectionView *sc, Cursor *cur, DbContext *context, unsigned char startRow, unsigned char nRows) {
  sc->pageContext = context;
  CursorDup(&sc->cursor, cur);
  ListGen textGen = ListGenCreate(SectionNext, SectionRestart, (void*) sc);
  sc->textView = ListViewCreate(textGen, startRow+1, nRows-1, 0, nRows/2);
  KeyT pos = CursorNext(cur);
  assert(pos != BAInvalid);
  FileOpenRO(context->blobFname);
  FileSeek(pos);
  sc->textOffset = sc->textStartOffset = pos + 4 + SchemaGetOffset(FileGetHandle(), WIKI_SCHEMA, WIKI_TEXT);
  sc->textLength = GetStringLen(pos, WIKI_SCHEMA, WIKI_TEXT);
}

void SectionViewDestroy(SectionView *sc) {
  CursorDestroy(&sc->cursor);
}

