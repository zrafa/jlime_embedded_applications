#include "MorseBox.h"

void MorseBoxInit(MorseBox *mb, int row) {
  mb->buffer[0] = 0x0;
  mb->bufferPos = 0;
  mb->p = codetree;
  mb->pLen = 63;
  mb->row = row;
  mb->escState = 0;
  mb->prompt[0] = ' ';
  mb->prompt[1] = '$';
}

void MorseBoxSetPrompt(MorseBox *mb, char prompt1, char prompt2) {
  assert(prompt1 && prompt2);
  mb->prompt[0] = prompt1;
  mb->prompt[1] = prompt2;
}

void MorseBoxSetBuffer(MorseBox *mb, char *data) {
  mb->bufferPos = 0;
  for (; *data; ++data) {
    if (mb->bufferPos >= MORSEBOX_MAX -1)
      break;
    mb->buffer[mb->bufferPos] = *data;
    ++mb->bufferPos;
  }
  mb->buffer[mb->bufferPos] = 0x0; // null terminate
}

inline char *MorseBoxGetBuffer(MorseBox *mb) {
  return mb->buffer;
}

void MorseBoxReset(MorseBox *mb) {
  mb->p = codetree;
  mb->pLen = 63;
  mb->buffer[mb->bufferPos] = 0x0; // always null-terminate
}

int MorseBoxPushEvent(MorseBox *mb, int r) {
  if (r == -1) {
    return 0;
  } else if (r == '\b' || r == 127) {
    if (mb->bufferPos > 0) mb->bufferPos--;
    MorseBoxReset(mb);
    return 1;
  } else if (r == UP_ARROW) {
    if (mb->bufferPos && mb->buffer[mb->bufferPos-1] == ' ') {
      //Double space is a backspace!
      if (mb->bufferPos == 1)
        mb->bufferPos = 0;
      else
        mb->bufferPos -= 2;
      MorseBoxReset(mb);
      return 1;
    }
    if (mb->bufferPos >= MORSEBOX_MAX-1) {
      return 0; // buffer full
    }
    mb->buffer[mb->bufferPos++] = InMorseCodeTree((mb->p - codetree) + (mb->pLen - 1)/2);
    MorseBoxReset(mb);
    return 1;
  } else if (r == LEFT_ARROW) { // left arrow - dit
    InMorseNext('.', &mb->p, &mb->pLen);
  } else if (r == RIGHT_ARROW) { // right arrow - dash
    InMorseNext('-', &mb->p, &mb->pLen);
  } else if (r < ' ' || r > '~') {
    return 0; // unknown character
  } else {
    mb->buffer[mb->bufferPos++] = r;
    MorseBoxReset(mb);
    return 1;
  }
  return 0;
}

char IsPrintable(char c) {
   return ((c >= '0') && (c <= '9')) || ((c >= 'A') && (c <= 'Z'));
}

void MorseBoxDraw(MorseBox *mb) {
  vposition(stdout, mb->row, 0);
  vclearlines(stdout, mb->row, mb->row + 2);

  int pOffset = mb->p - codetree;
  // Print codetree status
  for (int i=0; i<pOffset; ++i)
    if (IsPrintable(InMorseCodeTree(i))
        || (i == 31)) 
      printf(" ");
  for (int i=0; i<mb->pLen; ++i) {
    if (IsPrintable(InMorseCodeTree(pOffset + i))
        || (i == 31)) 
    {
      if (i == (mb->pLen - 1)/2)
        printf(VINVERT); // reverse video
      printf("%c", InMorseCodeTree(pOffset + i));
      if (i == (mb->pLen - 1)/2)
        printf(VNORMAL); // normal video
    }
  }
  printf("\n");
  // Print pointer
  for (int i=0; i < pOffset + ((mb->pLen -1)/2); ++i) {
    if (IsPrintable(InMorseCodeTree(i))
        || (i == 31)) 
    {
      printf("-");
    }
  }
  printf("^\n");
  // Print accumulated input
  putc(mb->prompt[0], stdout);
  putc(mb->prompt[1], stdout);
  putc(' ', stdout);
  for (int i=0; i<mb->bufferPos; ++i)
    printf("%c", mb->buffer[i]);
  fflush(stdout);
}

