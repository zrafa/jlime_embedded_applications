/* Utility objects for WikiApp */
#ifndef WIKIUTIL_H
#define WIKIUTIL_H

#define WIKI_SCHEMA "iIss"
#define WIKI_LEVEL 0
#define WIKI_PARENT 1
#define WIKI_TITLE 2
#define WIKI_TEXT 3

typedef struct {
  BgTree pageTree;
  KeyT titleCrc;
  ListCmdr cmdr; /**< Table of Contents Widget **/
  Cursor startCur; /**< Cursor to start of article **/
  Cursor cur; /**< Cursor for toc **/
} TocView;

typedef struct {
  DbContext *pageContext;
  Cursor cursor;
  ListView textView; /**< Text widget **/
  uint32_t textStartOffset; /**< blob offset in file **/
  uint32_t textOffset; /**< current pos in file **/
  uint32_t textLength; /** Blob length **/
} SectionView;

typedef struct {
  BgTree pageTree;
  BgTree prefixTree;
  ListCmdr searchCmdr; /**< Search text entry box **/
  ConcatGen concatGen;
  Cursor searchCur; /**< Potential titles list **/
  Cursor prefixCur; /**< Title prefix list **/
} SearchView;


KeyT CalcUpperCRC(const char *b);

extern Cursor tocLastCur;

void TocInit(TocView *toc, KeyT titleCrc, DbContext *pageContext, unsigned char startRow, unsigned char nRows);

void TocDestroy(TocView *toc);

void SearchViewInit(SearchView *sv, DbContext *pageContext, DbContext *prefixContext, unsigned char startRow, unsigned char nRows);

void SectionViewInit(SectionView *sc, Cursor *cur, DbContext *context, unsigned char startRow, unsigned char nRows);

void SectionViewDestroy(SectionView *sc);

#endif // WIKIUTIL_H
