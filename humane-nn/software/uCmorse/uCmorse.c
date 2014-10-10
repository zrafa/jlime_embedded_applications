#include "uCmorse.h"

unsigned char morse[] = {0x3f, 0x3e, 0x3c, 0x38, 0x30, 0x20, 0x21, 
  0x23, 0x27, 0x2f, 0x47, 0x55, 0x2d, 0x31, 0x6d, 0x4c, 0x56, 0x06, 
  0x11, 0x15, 0x09, 0x02, 0x14, 0x0b, 0x10, 0x04, 0x1e, 0x0d, 0x12, 
  0x07, 0x05, 0x0f, 0x16, 0x1b, 0x0a, 0x08, 0x03, 0x0c, 0x18, 0x0e, 
  0x19, 0x1d, 0x13};

void tapGap(int units) { sounder(0, UNITS2MSEC(units)); }
void tapDit() { sounder(1, UNITS2MSEC(DIT)); }
void tapDash() { sounder(1, UNITS2MSEC(DASH));}

void tapChar(char ch) {
  unsigned char c, i, bit;
  if (ch == ' ') {
    tapGap(WORD_GAP);
    return;
  }
  if ((ch <'0') || (ch > 'Z')) ch = '?';
  c = morse[ch - '0'];
  for (i=0; i<8; ++i) {
    bit = c & 0x1;
    c >>= 1;
    if (!c) break; // Character complete, 100.. encountered
    bit ? tapDash() : tapDit();
    tapGap(CHARACTER_GAP); // even at end, to ensure spacing
  }
  tapGap(LETTER_GAP); // even at end, to ensure spacing
}

void tapString(const char *s) {
  const char *sp;
  for(sp = s; *sp; ++sp) 
    tapChar(*sp);
}

void tapNibbleHex(unsigned char v) {
  v = v & 0xf;
  if (v < 10) {
    tapChar('0' + v);
  } else {
    tapChar('A' + (v-10));
  }
}

void tapByteHex(unsigned char v) {
  tapNibbleHex(v >> 4);
  tapNibbleHex(v & 0xf);
}

