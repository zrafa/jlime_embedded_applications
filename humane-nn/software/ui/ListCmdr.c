#include "ListCmdr.h"

void ListCmdrInit(ListCmdr *cmdr, ListGen gen, unsigned char topRow, unsigned char nRows, unsigned char flags, unsigned char scrollJump) {
  cmdr->topRow = topRow;
  cmdr->nRows = nRows;
  cmdr->finished = 0;
  cmdr->escState = 0;
  cmdr->flags = flags;
  MorseBoxInit(&cmdr->mbox, topRow);
  int rOffset = 0;
  if (!(flags & LC_ListOnlyMode)) {
    rOffset = 4;
  }
  cmdr->view = ListViewCreate(
      PrefixFilterCreate(&cmdr->filter, cmdr->mbox.buffer, gen), 
      topRow + rOffset, nRows - rOffset, (flags & LC_ListOnlyMode) ? 0 : -1, scrollJump);
}

void ListCmdrPushEvent(ListCmdr *cmdr, int r) {
  if (ListViewGetFocus(&cmdr->view) != -1) {
    if ((r == '\n') || (r == '\r') || (r == RIGHT_ARROW)) {
      ListGenGet(&cmdr->view.gen, ListViewGetFocus(&cmdr->view), cmdr->mbox.buffer, MORSEBOX_MAX);
      cmdr->finished = 1;
    } else if (r == UP_ARROW) {
      ListViewFocusPrev(&cmdr->view);
    } else if (r == LEFT_ARROW) {
      cmdr->finished = 2; // User abort from ListCmdr
    } else if ((r != DOWN_ARROW) && !(cmdr->flags & LC_ListOnlyMode)) { // any other input resets pointer to morse box
      ListViewSetFocus(&cmdr->view, -1);
    }
  } 
  if (ListViewGetFocus(&cmdr->view) == -1) {
    if (!(cmdr->flags & LC_ListOnlyMode)) {
      int consumed = MorseBoxPushEvent(&cmdr->mbox, r);
      if (consumed)
        ListGenModified(&cmdr->view.gen);
    }
  }
  if (r == DOWN_ARROW) { // down arrow 
    ListViewFocusNext(&cmdr->view);
  }
  if (ListViewGetFocus(&cmdr->view) == -1) {
    MorseBoxSetPrompt(&cmdr->mbox, '>', '$');
  } else {
    MorseBoxSetPrompt(&cmdr->mbox, ' ', '$');
  }
}

char *ListCmdrGetValue(ListCmdr *cmdr) {
  if (cmdr->finished == 1)
    return cmdr->mbox.buffer;
  else
    return 0x0;
}

int ListCmdrDraw(ListCmdr *cmdr) {
  vposition(stdout, cmdr->topRow, 0);
  if (!(cmdr->flags & LC_ListOnlyMode)) {
    MorseBoxDraw(&cmdr->mbox);
    vposition(stdout, cmdr->topRow + 3, 0);
  }
  int res = ListViewDraw(&cmdr->view);
  
  // move blinking cursor back to prompt
  vposition(stdout, cmdr->topRow + 2, cmdr->mbox.bufferPos + 3);
  return res;
}

void ListCmdrForceRedraw(ListCmdr *cmdr) {
  ListViewForceRedraw(&cmdr->view);
}
