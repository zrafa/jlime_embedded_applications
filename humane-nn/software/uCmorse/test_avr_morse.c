#include <util/delay.h>
#include <avr/io.h>
#include <avr/pgmspace.h>
#include <avr/interrupt.h>
#include <stdlib.h> 
#include <math.h> 
#include <util/delay.h>  
#include <avr/sleep.h>

void tapString(const char *s);

void sounder(int onOrOff, int msec) {
  DDRB |= 1 << PORTB5;
  if (onOrOff) {
    PORTB |= 1 << PORTB5; // led on
  } else  {
    PORTB &= ~(1 << PORTB5); // led off
  }
  _delay_ms((float)msec);
  PORTB |= 1 << PORTB5; // off at end
}

int main() {
  const char *s=" 123 HELLO WORLD     ";
  sounder(1,1000);
  for (int i=0; 1; ++i) {
    tapString(s);
    char c[2];
    c[0] = (i % 42) + '0';
    c[1] = 0x0;
    tapString(c);
  }
}
