#ifndef WIKIAPP_H
#define WIKIAPP_H

#include "Platform.h"
#include "ListCmdr.h"
#include "bgApi.h"
#include "WikiUtil.h"

enum WikiAppState {
  WAGlobalSearch,
  WATocList,
  WATextViewer,
  WATocTextCombo
};

typedef struct {
  DbContext pageContext;
  DbContext prefixContext;

  TocView toc; /**< Table of Contents **/
  SectionView section;
  SearchView search;

  enum WikiAppState state;
} WikiApp;

void WikiAppInit(WikiApp *wa);

/** Sets title for app from Wikipedia DB. 
 *  Returns 0 if title not found, else 1 on success **/
char WikiAppSetTitle(WikiApp *wa, const char *title);

char WikiAppDraw(WikiApp *wa);

char WikiAppPushEvent(WikiApp *wa, int r);

#endif //WIKIAPP_H
