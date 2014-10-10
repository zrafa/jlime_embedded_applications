#ifndef LISTCMDR_H_
#define LISTCMDR_H_ 1

#include "MorseBox.h"
#include "ListView.h"

/** Flags for ListCmdr behavior **/
#define LC_ListOnlyMode 0x1
#define LC_NoEmptyResult 0x2
#define LC_NoLeadingSpace 0x4

typedef struct {
  unsigned char topRow, nRows; /**< Position on screen **/
  MorseBox mbox; /**< Morse code/keyboard Input box **/
  PrefixFilter filter; /**< Data for list filter based on input **/
  ListView view; /**< Renderer for list **/
  int finished;
  int escState;
  unsigned char flags; /**< No morse box if set **/
} ListCmdr;

/** Creates a new List Commander pane based on gen **/
void ListCmdrInit(ListCmdr *cmdr, ListGen gen, unsigned char topRow, unsigned char nRows, unsigned char flags, unsigned char scrollJump);

/** Process a key press.  Returns 1 if keypress consumes, else 0 **/
void ListCmdrPushEvent(ListCmdr *cmdr, int key);

static inline int ListCmdrIsFinished(ListCmdr *cmdr) {
  return !!cmdr->finished;
}

/** Returns a pointer to the final selection.  If there is no final
 * selection yet, then returns NULL **/
char *ListCmdrGetValue(ListCmdr *cmdr);

/** Renders the List Commander on screen.
 * Returns 0 if still more to draw, else 1 **/
int ListCmdrDraw(ListCmdr *cmdr);

void ListCmdrForceRedraw(ListCmdr *cmdr);

#endif // LISTCMDR_H_
