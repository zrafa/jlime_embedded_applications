/* Simple app which blinks all of the IO lines of PORTD at successively
 * doubling speeds.  Actually sends (100 ms)/(2**i) of "on", followed by
 * the same period of "off", followed by the value i in morse code scaled
 * accordingly.
 */

#include <util/delay.h>
#include <avr/io.h>
#include <avr/pgmspace.h>
#include <avr/interrupt.h>
#include <stdlib.h> 
#include <math.h> 
#include <util/delay.h>  
#include <avr/sleep.h>

#include "uCmorse.h"

int sounderScale = 1;

void sounder(int onOrOff, int msec) {
  msec /= sounderScale;
  DDRD = 0xff;
  if (onOrOff) {
    PORTD = 0xff;
  } else  {
    PORTD = 0x0;
  }
  _delay_ms((float)msec);
  PORTD = 0x0; // high at end
}

int main(int argc, char **argv) {
  while (1) {
    sounder(1, 500);
    sounder(0, 500);
  }
  while (1) {
    for (int i=9; i>=0; --i) {
      sounderScale = 1 << i;
      sounder(1, 100);
      sounder(0, 100);
      tapChar('0' + i); 
    }
  }
  return 0;
}
