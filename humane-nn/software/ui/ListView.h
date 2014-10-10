#ifndef LISTview_H_
#define LISTview_H_ 1

#include "Platform.h"

struct ListGen_;

#define LISTGEN_STRING_MAX 37

typedef char (*NextFunc)(struct ListGen_ *lst, char *outBuf, unsigned char outBufLen);
typedef void (*RestartFunc)(struct ListGen_ *lst);

/** List Generator Class **/
typedef struct ListGen_ {
  NextFunc next;
  RestartFunc restart;
  char *userData;
  int lastIndex; /**< index of last item retrieved - optimization **/
  int length;
  char dirty; /**< does list need to be redrawn? **/
} ListGen;

ListGen ListGenCreate(NextFunc next, RestartFunc restart, char *userData);

/** Write the next list item into outBuf, up to a maximum of outBufLen.
 *  Not output is written if outBuf == outBufLen == 0
 *  Returns 1 if an item was output, 0 if there are no more items **/
char ListGenNext(ListGen *gen, char *outBuf, unsigned char outBufLen);

/** Restart the list from the beginning **/
void ListGenRestart(ListGen *gen);

/** Get a particular list item, if it exists - not necessarily efficient **/
char ListGenGet(ListGen *gen, int index, char *outBuf, unsigned char outBufLen);

/** Is list long enough that index exists? **/
char ListGenExists(ListGen *gen, int index, unsigned char outBufLen);

/** Must be called if the underlying list is modified **/
void ListGenModified(ListGen *gen);

typedef struct ListView_ {
  ListGen gen;
  int offset; /**< Display offset into list **/
  unsigned char rows; /**< Number of display rows **/
  unsigned char y; /**< Coordinate of first row **/
  int focus; /**< list item with current focus **/
  int lastDrawnRow; /**< last row drawn **/
  int lastDrawnFocus; 
  int minFocus; /**< smallest allowable focus = usually 0 or -1 **/
  unsigned char scrollJump; /**< number of lines to jump at begin/end of screen **/
} ListView;

ListView ListViewCreate(ListGen gen, unsigned char y, unsigned char rows, int minFocus, unsigned char scrollJump);

/** Incrementally draw the list to screen.  Returns 1 if
 * drawing is complete, else zero **/
char ListViewDraw(ListView *view);

void ListViewSetFocus(ListView *view, int position);
int ListViewGetFocus(ListView *view);
void ListViewFocusNext(ListView *view);
void ListViewFocusPrev(ListView *view);
void ListViewForceRedraw(ListView *view);

/** PrefixFilter is a list generator which filters all elements which do not
 * match an assigned prefix, case insensitive **/
typedef struct {
  ListGen gen;
  char *prefix;
} PrefixFilter;

char PrefixFilterNext(ListGen *gen, char *outBuf, unsigned char outBufLen);

void PrefixFilterRestart(ListGen *gen);

char PrefixCompare(char *prefix, char *buf);

ListGen PrefixFilterCreate(PrefixFilter *filt, char *prefix, ListGen gen);

/** A Concat filter concatenates two list generators into one **/
typedef struct {
  ListGen gen1;
  ListGen gen2;
} ConcatGen;

char ConcatGenNext(ListGen *gen, char *outBuf, unsigned char outBufLen);

void ConcatGenRestart(ListGen *gen);

ListGen ConcatGenCreate(ConcatGen *filt, ListGen gen1, ListGen gen2);

#endif 

