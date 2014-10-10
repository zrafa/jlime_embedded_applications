#include "WikiApp.h"
#include "vt52.h"
#include <string.h>
#include <ctype.h> // toupper
#include "crc32.h"
#include "bgUtil.h"
#include "bgUtil2.h"
#include "WikiUtil.h"

void WikiAppInit(WikiApp *wa) {
  const unsigned char nRows=17;
  memset(wa, 0, sizeof(WikiApp));

  /* Page Context Init */
  wa->pageContext.tableFname = "sec.bgt";
  wa->pageContext.blobFname  = "sec.bgb";
  wa->pageContext.fileStateVersion = -1;

  /* Title Prefix Table */
  wa->prefixContext.tableFname = "pre.bgt";
  wa->prefixContext.fileStateVersion = -1;

  wa->state = WAGlobalSearch;

  SearchViewInit(&wa->search, &wa->pageContext, &wa->prefixContext, 1, nRows);
}

char WikiAppSetTitle(WikiApp *wa, const char *title) {
  /* Hash title string */
  KeyT key = CalcUpperCRC(title);
  /* Perform search for title hash */
  TocInit(&wa->toc, key, &wa->pageContext, wa->search.searchCmdr.topRow, wa->search.searchCmdr.nRows);
  // Notifty List layer that content has been modified
  ListGenModified(&wa->search.searchCmdr.view.gen);
  if (CursorPeek(&wa->toc.startCur) == BAInvalid)
    return 0;
  return 1;
}

char WikiAppSetText(WikiApp *wa, const char *section) {
  /* Find actual section from section title */
  char b[MORSEBOX_MAX];
  
  /* Find matching cursor */
  ListGenRestart(&wa->toc.cmdr.filter.gen);
  Cursor cur = CursorCreateInvalid();
  char moreToCome;
  do {
    //CursorDup(&cur, &wa->toc.cur); // save one behind
    // tocCmdr.filter.gen will increment tocCur
    moreToCome = ListGenNext(&wa->toc.cmdr.filter.gen, b, MORSEBOX_MAX);
  } while (moreToCome && strncmp(b, section, MORSEBOX_MAX));
  if (!moreToCome) {
    printf_P(PSTR("FAILED TO MATCH %s\n"),b);
    return 0;
  }

  /* Extract text location from cursor */
  SectionViewInit(&wa->section, &tocLastCur, &wa->pageContext,wa->search.searchCmdr.topRow, wa->search.searchCmdr.nRows); 
  CursorDestroy(&cur);
  return 1;
}

char WikiAppDraw(WikiApp *wa) {
  //fprintf(stdout, VERASE_SCR);
  printf(VDISABLE_LINE_WRAP);
  if (wa->state == WAGlobalSearch) {
    printf(VHOME VERASE_LINE_CUR);
    printf_P(PSTR("     -=[ Title Search ]=-"));
    return ListCmdrDraw(&wa->search.searchCmdr);
  } else if (wa->state == WATocList) {
    printf(VHOME VERASE_LINE_CUR);
    printf_P(PSTR("-=[ %s Table of Contents ]=-"), ListCmdrGetValue(&wa->search.searchCmdr));
    return ListCmdrDraw(&wa->toc.cmdr);
  } else if (wa->state == WATextViewer) {
    printf(VHOME VERASE_LINE_CUR);
    printf_P(PSTR("     -=[ %s Article Text ]=-"), ListCmdrGetValue(&wa->search.searchCmdr));
    return ListViewDraw(&wa->section.textView);
  }
  return 1;
}

char TitleSearchPushEvent(WikiApp *wa, int r) {
  ListCmdrPushEvent(&wa->search.searchCmdr, r);
  if (ListCmdrIsFinished(&wa->search.searchCmdr)) {
    if (ListCmdrGetValue(&wa->search.searchCmdr)) {
      WikiAppSetTitle(wa, ListCmdrGetValue(&wa->search.searchCmdr));
      wa->state = WATocList;
      wa->toc.cmdr.finished = 0;
      fprintf(stdout, VERASE_SCR);
      ListCmdrForceRedraw(&wa->toc.cmdr);
    } else { // user Abort - already at top
      wa->search.searchCmdr.finished = 0;
    }
  }
  return 1;
}

char TocPushEvent(WikiApp *wa, int r) {
  ListCmdrPushEvent(&wa->toc.cmdr, r);
  if (ListCmdrIsFinished(&wa->toc.cmdr)) {
    if (ListCmdrGetValue(&wa->toc.cmdr)) {
      WikiAppSetText(wa, ListCmdrGetValue(&wa->toc.cmdr));
      wa->state = WATextViewer;
      fprintf(stdout, VERASE_SCR);
    } else { // user abort
      TocDestroy(&wa->toc);
      MorseBoxReset(&wa->search.searchCmdr.mbox);
      //MorseBoxSetBuffer(&wa->search.searchCmdr.mbox, "");
      //ListViewSetFocus(&wa->search.searchCmdr.view, -1);
      wa->search.searchCmdr.finished = 0;
      ListCmdrPushEvent(&wa->search.searchCmdr, -1);
      wa->state = WAGlobalSearch;
      fprintf(stdout, VERASE_SCR);
      ListCmdrForceRedraw(&wa->search.searchCmdr);
    }
  }
  return 1;
}

char WTextViewerPushEvent(WikiApp *wa, int r) {
  if (r == UP_ARROW) {
    ListViewFocusPrev(&wa->section.textView);
  } else if (r == DOWN_ARROW) {
    ListViewFocusNext(&wa->section.textView);
  }
  if (r == LEFT_ARROW) { // return to ToC
    wa->toc.cmdr.finished = 0;
    MorseBoxReset(&wa->toc.cmdr.mbox);
    MorseBoxSetBuffer(&wa->toc.cmdr.mbox, "");
    //ListViewSetFocus(&wa->tocCmdr.view, -1);
    ListCmdrPushEvent(&wa->toc.cmdr, -1);
    SectionViewDestroy(&wa->section);
    wa->state = WATocList;
    fprintf(stdout, VERASE_SCR);
    ListCmdrForceRedraw(&wa->toc.cmdr);
  }
  return 1;
}

char WikiAppPushEvent(WikiApp *wa, int r) {
  static unsigned char escState = 0;
  r = InputUnescape(r, &escState);
  if (r == -1) return 0;
  if (wa->state == WAGlobalSearch) {
    return TitleSearchPushEvent(wa, r);
  } else if (wa->state == WATocList) {
    return TocPushEvent(wa, r);
  } else if (wa->state == WATextViewer) {
    return WTextViewerPushEvent(wa, r);
  } else {
    return 1;
  }
}
