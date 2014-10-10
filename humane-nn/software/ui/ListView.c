#include "ListView.h"
#include "vt52.h"
#include <ctype.h> // toupper

ListGen ListGenCreate(NextFunc next, RestartFunc restart, char *userData) {
  ListGen gen;
  gen.next = next;
  gen.restart = restart;
  gen.userData = userData;
  gen.lastIndex = -1;
  gen.length = -1;
  gen.dirty = 1;
  return gen;
}

/** Write the next list item into outBuf, up to a maximum of outBufLen.
 *  Not output is written if outBuf == outBufLen == 0
 *  Returns 1 if an item was output, 0 if there are no more items **/
inline char ListGenNext(ListGen *gen, char *outBuf, unsigned char outBufLen) {
  if ((gen->length >= 0) && (gen->lastIndex+1 >= gen->length))
    return 0;
  assert(gen->next);
  char res = (*gen->next)(gen, outBuf, outBufLen);
  if (res == 1) 
    ++gen->lastIndex;
  if ((gen->length < 0) && (-gen->length - 1 <= gen->lastIndex))
    gen->length = -(gen->lastIndex + 2);
  return res;
}

/** Restart the list from the beginning **/
inline void ListGenRestart(ListGen *gen) {
  gen->lastIndex = -1;
  assert(gen->restart);
  (*gen->restart)(gen);
}

/** Get a particular list item, if it exists - not necessarily efficient **/
char ListGenGet(ListGen *gen, int index, char *outBuf, unsigned char outBufLen) {
  /* Is index past known end of list */
  if ((gen->length >= 0) && (index >= gen->length))
    return 0;
  /* Must we start from 0? */
  if (gen->lastIndex >= index)
    ListGenRestart(gen);
  for (int i=gen->lastIndex; i<index-1; ++i) {
    if (!ListGenNext(gen, 0x0, outBufLen))
      return 0;
  }
  return ListGenNext(gen, outBuf, outBufLen);
}

char ListGenExists(ListGen *gen, int index, unsigned char outBufLen) {
  if ((gen->length < 0) && (index < -gen->length - 1))
    return 1; // smaller than known minimum length
  else if (gen->length >= 0) 
    return index < gen->length;
  return ListGenGet(gen, index, 0x0, outBufLen);
}

void ListGenModified(ListGen *gen) {
  gen->length = -1;
  gen->dirty = 1;
  ListGenRestart(gen);
}

ListView ListViewCreate(ListGen gen, unsigned char y, unsigned char rows, int minFocus, unsigned char scrollJump) {
  ListView view;
  view.gen = gen;
  view.offset = 0;
  view.rows = rows;
  view.y = y;
  view.focus = minFocus;
  view.minFocus = minFocus;
  view.lastDrawnRow = 0;
  view.lastDrawnFocus = -1;
  view.scrollJump = scrollJump;
  return view;
}

void DrawFocusChar(int focus, int offset, int rows, int y, char c) {
  if (focus == -1)
    return;
  int f = focus - offset;
  if ((f < 0) || (f > rows))
    return;
  vposition(stdout, f + y, 0);
  printf("%c", c);
}

void ListViewDrawFocus(ListView *view) {
  DrawFocusChar(view->lastDrawnFocus, view->offset, view->rows, view->y, ' ');
  DrawFocusChar(view->focus, view->offset, view->rows, view->y, '>');
  view->lastDrawnFocus = view->focus;
}

/** Draw the list to screen **/
char ListViewDraw(ListView *view) {
  ListViewDrawFocus(view);

  /* Restart if list redraw is dirty */
  if (view->gen.dirty) {
    view->gen.dirty = 0;
    view->lastDrawnRow = 0;
    /* Reset list */
    ListGenRestart(&view->gen);
  }

  /* Apply offset */
  if (view->lastDrawnRow < view->offset) {
    ListGenNext(&view->gen, 0x0, LISTGEN_STRING_MAX);
    ++view->lastDrawnRow;
    return 0;
  }

  int startRow = view->y + view->lastDrawnRow - view->offset;
  vposition(stdout, startRow, 0);
  vclearlines(stdout, startRow, view->y + view->rows);

  /* Output rows */
  if (view->lastDrawnRow - view->offset < view->rows) {
    char out[LISTGEN_STRING_MAX];
    int moreToCome = ListGenNext(&view->gen, out, LISTGEN_STRING_MAX);
    if (!moreToCome) {
      view->gen.dirty = 1; // will always restart
      return 1;
    }
    //printf(" %i %s", view->lastDrawnRow - view->offset, out);
    printf(" %s", out);
    ++view->lastDrawnRow;
    return 0;
  }

  return 1;
}

void ListViewSetFocus(ListView *view, int position) {
  if (position < 0) {
    position = view->minFocus;
    view->focus = view->minFocus;
  }
  if (!ListGenExists(&view->gen, position, LISTGEN_STRING_MAX))
    return; // do nothing, past end of list
  view->focus = position;
  if (position != -1 && position < view->offset) {
    int x = position - view->scrollJump;
    view->offset = x > 0 ? x : 0;
    view->gen.dirty = 1;
  }
  if (position != -1 && position >= view->offset + view->rows) {
    view->offset = position - view->rows + 1 + view->scrollJump;
    view->gen.dirty = 1;
  }
}

int ListViewGetFocus(ListView *view) {
  return view->focus;
}

void ListViewFocusNext(ListView *view) {
  ListViewSetFocus(view, ListViewGetFocus(view) + 1);  
}

void ListViewFocusPrev(ListView *view) {
  ListViewSetFocus(view, ListViewGetFocus(view) - 1);  
}

void ListViewForceRedraw(ListView *view) {
  view->gen.dirty = 1;
}

char PrefixCompare(char *prefix, char *buf) {
  /* ignore preceeding whitespace */
  for (; (*buf == ' '); ++buf)
    ;
  int i;
  for (i=0; prefix[i] != 0x0; ++i) {
    char bufcap = toupper(buf[i]);
    char prefixcap = toupper(prefix[i]);
    if (bufcap != prefixcap)
      return 1;
  }
  return 0;
}

char PrefixFilterNext(ListGen *gen, char *outBuf, unsigned char outBufLen) {
  PrefixFilter *filt = (PrefixFilter*) gen->userData;
  char buf[LISTGEN_STRING_MAX];
  while (1) {
    char notend = ListGenNext(&filt->gen, buf, LISTGEN_STRING_MAX);
    if (!notend)
      return 0;
    if (!PrefixCompare(filt->prefix, buf)) {
      if (outBuf) {
        int i;
        for (i=0; (i < outBufLen-1) && (buf[i] != 0x0); ++i)
          outBuf[i] = buf[i];
        outBuf[i] = 0x0;
      }
      return 1;
    }
  }
}

void PrefixFilterRestart(ListGen *gen) {
  PrefixFilter *filt = (PrefixFilter*) gen->userData;
  ListGenRestart(&filt->gen);
}

ListGen PrefixFilterCreate(PrefixFilter *filt, char *prefix, ListGen gen) {
  assert(filt && prefix);
  filt->prefix = prefix;
  filt->gen = gen;
  ListGen filtgen = ListGenCreate(PrefixFilterNext, PrefixFilterRestart, (void *) filt);
  return filtgen;
}

char ConcatGenNext(ListGen *gen, char *outBuf, unsigned char outBufLen) {
  ConcatGen *ccgen = (ConcatGen *) gen->userData;
  int notend = ListGenNext(&ccgen->gen1, outBuf, outBufLen);
  if (notend)
    return notend;
  else
    return ListGenNext(&ccgen->gen2, outBuf, outBufLen);
}

void ConcatGenRestart(ListGen *gen) {
  ConcatGen *ccgen = (ConcatGen *) gen->userData;
  ListGenRestart(&ccgen->gen1);
  ListGenRestart(&ccgen->gen2);
}

ListGen ConcatGenCreate(ConcatGen *ccgen, ListGen gen1, ListGen gen2) {
  assert(ccgen);
  ccgen->gen1 = gen1;
  ccgen->gen2 = gen2;
  return ListGenCreate(ConcatGenNext, ConcatGenRestart, (void *) ccgen);
}

