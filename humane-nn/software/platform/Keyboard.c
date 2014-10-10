#include <avr/pgmspace.h>

#include "Keyboard.h"

// Unshifted characters
const unsigned char unshifted[][2] PROGMEM = {
  {0x0d,9}, {0x0e,'|'}, {0x15,'q'}, {0x16,'1'}, {0x1a,'z'}, {0x1b,'s'}, {0x1c,'a'},
  {0x1d,'w'}, {0x1e,'2'}, {0x21,'c'}, {0x22,'x'}, {0x23,'d'}, {0x24,'e'}, {0x25,'4'},
  {0x26,'3'}, {0x29,' '}, {0x2a,'v'}, {0x2b,'f'}, {0x2c,'t'}, {0x2d,'r'}, {0x2e,'5'},
  {0x31,'n'}, {0x32,'b'}, {0x33,'h'}, {0x34,'g'}, {0x35,'y'}, {0x36,'6'}, {0x39,','},
  {0x3a,'m'}, {0x3b,'j'}, {0x3c,'u'}, {0x3d,'7'}, {0x3e,'8'}, {0x41,','}, {0x42,'k'},
  {0x43,'i'}, {0x44,'o'}, {0x45,'0'}, {0x46,'9'}, {0x49,'.'}, {0x4a,'-'}, {0x4b,'l'},
  {0x4d,'p'}, {0x4e,'+'}, {0x55,'\\'}, {0x5a,10}, {0x5b,'"'}, {0x5d,'\''}, {0x61,'<'},
  {0x66,8}, {0x69,'1'}, {0x6b,'4'}, {0x6c,'7'}, {0x70,'0'}, {0x71,','}, {0x72,'2'},
  {0x73,'5'}, {0x74,'6'}, {0x75,'8'}, {0x79,'+'}, {0x7a,'3'}, {0x7b,'-'}, {0x7c,'*'},
  {0x7d,'9'}, {0,0}
};

// Shifted characters
const unsigned char shifted[][2] PROGMEM = {
  {0x0d,9}, {0x15,'Q'}, {0x16,'!'}, {0x1a,'Z'}, {0x1b,'S'}, {0x1c,'A'}, {0x1d,'W'}, {0x1e,'"'},
  {0x21,'C'}, {0x22,'X'}, {0x23,'D'}, {0x24,'E'}, {0x26,'#'}, {0x29,' '}, {0x2a,'V'}, {0x2b,'F'},
  {0x2c,'T'}, {0x2d,'R'}, {0x2e,'%'}, {0x31,'N'}, {0x32,'B'}, {0x33,'H'}, {0x34,'G'}, {0x35,'Y'},
  {0x36,'&'}, {0x39,'L'}, {0x3a,'M'}, {0x3b,'J'}, {0x3c,'U'}, {0x3d,'/'}, {0x3e,'('}, {0x41,';'},
  {0x42,'K'}, {0x43,'I'}, {0x44,'O'}, {0x45,'='}, {0x46,')'}, {0x49,':'}, {0x4a,'_'}, {0x4b,'L'},
  {0x4d,'P'}, {0x4e,'?'}, {0x55,'`'}, {0x5a,10}, {0x5b,'^'}, {0x5d,'*'}, {0x61,'>'}, {0x66,8},
  {0x69,'1'}, {0x6b,'4'}, {0x6c,'7'}, {0x70,'0'}, {0x71,','}, {0x72,'2'}, {0x73,'5'}, {0x74,'6'},
  {0x75,'8'}, {0x79,'+'}, {0x7a,'3'}, {0x7b,'-'}, {0x7c,'*'}, {0x7d,'9'}, {0,0} 
};

unsigned char GetShifted(int i, int j) {
  return pgm_read_byte(&shifted[i][j]);
}

unsigned char GetUnshifted(int i, int j) {
  return pgm_read_byte(&unshifted[i][j]);
}

int KeyboardDecode(unsigned char sc, char *outBuf) {
  static unsigned char is_up=0, shift = 0, mode = 0, escState = 0;
  unsigned char i;
  int buflen = 0;

  if (!is_up) {                // Last data received was the up-key identifier
    if (escState == 1) {
      switch (sc) {
        case 0x72 :
          outBuf[0] = 27; outBuf[1] = '['; outBuf[2] = 'B';
          buflen = 3;
          break;
        case 0x75 :
          outBuf[0] = 27; outBuf[1] = '['; outBuf[2] = 'A';
          buflen = 3;
          break;
        case 0x6b :
          outBuf[0] = 27; outBuf[1] = '['; outBuf[2] = 'D';
          buflen = 3;
          break;
        case 0x74 :
          outBuf[0] = 27; outBuf[1] = '['; outBuf[2] = 'C';
          buflen = 3;
          break;
        case 0xF0:
          is_up = 1;
          break;
      }
      escState = 0; 
    } else {
      switch (sc) {
        case 0xF0 :        // The break up-key identifier
          is_up = 1;
          break;
        case 0x12 :        // Left SHIFT
          shift = 1;
          break;
        case 0x59 :        // Right SHIFT
          shift = 1;
          break;
        case 0xe0 :
          escState = 1;
          break;
        case 0x05 :        // F1
          if(mode == 0)
            mode = 1;    // Enter scan code mode
          if(mode == 2)
            mode = 3;    // Leave scan code mode
          break;
        default:
          if(mode == 0 || mode == 3) {       // If ASCII mode
            if(!shift) {  // If shift not pressed, do table look-up
              //for(i = 0; unshifted[i][0]!=sc && unshifted[i][0]; i++);
              for(i = 0; GetUnshifted(i,0)!=sc && GetUnshifted(i,0); i++);
              if (GetUnshifted(i,0) == sc) {
                outBuf[0] = GetUnshifted(i,1);
                buflen = 1;
              } else {
                outBuf[0] = 'x';
                buflen = 1;
              }
            } else {                    // If shift pressed
              for(i = 0; GetShifted(i,0)!=sc && GetShifted(i,0); i++);
              if (GetShifted(i,0) == sc) {
                outBuf[0] = GetShifted(i,1);
                buflen = 1;
              } else {
                outBuf[0] = 'X';
                buflen = 1;
              }
            }
          } else{                            // Scan code mode - print hex
            unsigned char v = (sc >> 4) & 0xf;
            outBuf[0] = v < 10 ? v + '0' : 'A' + v - 10;
            v = sc & 0xf;
            outBuf[1] = v < 10 ? v + '0' : 'A' + v - 10;
            buflen = 2;
          }
          break;
      }
    }
  } else {
    is_up = 0;                            // Two 0xF0 in a row not allowed
    switch (sc) {
      case 0x12 :                        // Left SHIFT
        shift = 0;
        break;

      case 0x59 :                        // Right SHIFT
        shift = 0;
        break;

      case 0x05 :                        // F1
        if(mode == 1)
          mode = 2;
        if(mode == 3)
          mode = 0;
        break;
    } 
  }    
  return buflen;
}

