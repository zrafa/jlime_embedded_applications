#include "Platform.h"

int InputUnescape(int in, unsigned char *state) {
  assert((*state < 3) && (*state >= 0));
  if (in == -1) return -1;
  int ret=in;
  if (*state == 0) {
    if (in == 27) {
      *state = 1;
      ret = -1;
    }
  } else if (*state == 1) {
    if (in == '[') {
      *state = 2;
      ret = -1;
    } else {
      *state = 0; // fluke?
    }
  } else if (*state == 2) {
    ret = in << 8; // escape code
    *state = 0;
  }
  return ret;
}

void OutS(const char *s) {
  for (; *s != 0x0; s++)
    OutC(*s);
}

void OutXByte(unsigned char byte) {
  unsigned char nibble;
  nibble=(byte>>4);
  OutC(nibble + (nibble < 10 ? '0' : '7'));
  nibble=(byte&0xf);
  OutC(nibble + (nibble < 10 ? '0' : '7'));
}

void OutX(uint32_t v) {
  OutXByte((v >> 24) & 0xff);
  OutXByte((v >> 16) & 0xff);
  OutXByte((v >> 8) & 0xff);
  OutXByte(v & 0xff);
}

void OutI(uint32_t val) {
  unsigned char c;
  long v2,p,vlen;
  if (val < 0) {
    OutC('-');
    val = -val;
  } else if (val == 0) {
    OutC('0');
    return;
  }
  /* Determine number of digits */
  v2 = val;
  p = 1;
  for (vlen=0; v2 != 0; v2 = v2 / 10)
    p *= 10;

  do {
    p = p/10;
    c = (val / p) % 10;
    OutC(c + '0');
    val = val - c*p;
  } while (p != 1);
}

