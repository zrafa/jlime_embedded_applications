#include <util/delay.h>
#include <avr/io.h>
#include <avr/pgmspace.h>
#include <avr/interrupt.h>
#include <avr/sleep.h>

#include "uCmorse.h"

#ifdef USE_LED
void sounder(int onOrOff, int msec) {
  DDRB = 0xff;
  if (onOrOff) {
    PORTB = 0x0;
  } else  {
    PORTB = 0xff;
  }
  _delay_ms((float)msec);
  PORTB = 0xff; // high at end
}
#else
void sounder(int onOrOff, int msec) {
  DDRD = 0xff;
  if (onOrOff) {
    PORTD = 0xff;
  } else  {
    PORTD = 0x0;
  }
  _delay_ms((float)msec);
  PORTD = 0x0; // high at end
}
#endif

/** Put all IO pins into pull-up mode, and verify that they are all high **/
uint32_t PullupTest() {
  SPCR &= ~(1 << SPE); // disable SPI
  DDRB = 0x0; // direction input
  DDRC = 0x0;
  DDRD = 0x0;
  PORTB = 0xff; // set pull-up
  PORTC = 0xff;
  PORTD = 0xff;
  uint32_t v = 0x0;
  v |= ((~PINB) & 0xff);
  v |= ((uint32_t)((~PINC) & 0xff)) << 8;
  v |= ((uint32_t)((~PIND) & 0xff)) << 16;
  PORTB = 0x0; // unset pull-up
  PORTC = 0x0;
  PORTD = 0x0;
  return v;
}

uint32_t ShortTest() {
  DDRB = 0x0; // direction input
  DDRC = 0x0;
  DDRD = 0x0;
  PORTB = 0xff; // set pull-up
  PORTC = 0xff;
  PORTD = 0xff;
  uint32_t v = 0x0; // accumulator
  // PORT B
  // turn off pins one-by-one and check for shorts
  for (int i=0; i<8; ++i) {
    DDRB |= 1 << i; // set pin to output
    PORTB &= ~(1 << i); // turn off pin
    // check for any change to baseline
    uint32_t a = 0x0;
    a |= PINB;
    a |= PINC << 8;
    a |= ((uint32_t)PIND) << 16;
    a |= (1 << i); // should be all ones
    v |= ~a; //accumulate errors
  }
  return v;
}

int main(int argc, char **argv) {
  while (1) {
    // 1Hz sounder test to verify speed
    sounder(1, 500);
    sounder(0, 500);
    sounder(1, 500);
    sounder(0, 500);
    uint32_t pu = PullupTest();
    uint32_t st = ShortTest(); 
    tapString("PT");
    tapByteHex((pu >> 16) & 0xf);
    tapByteHex((pu >> 8) & 0xf);
    tapByteHex(pu & 0xf);
    tapString("ST");
    tapByteHex((st >> 16) & 0xff);
    tapByteHex((st >> 8) & 0xff);
    tapByteHex(st & 0xff);
    tapString("K");
  }

  return 0;
}
