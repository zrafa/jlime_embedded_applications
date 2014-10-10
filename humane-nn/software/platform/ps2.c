/* PS/2 Keyboard Interface */
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include <avr/pgmspace.h>

#include "ps2.h"

#include <stdio.h> 
#ifndef AVR
#  define printf_P printf
#  define PSTR(x) (x)
#endif

uint8_t g_portc_old=1;
uint8_t g_kbd_shift=0;
uint8_t g_kbd_parity=0;
uint8_t g_kbd_count=0;
uint8_t g_kbd_buf[KBD_BUF_SIZE];
uint8_t g_kbd_buf_len=0;
uint8_t g_kbd_buf_start=0;

void kbd_init(void) {
  // keyboard interrupt
  g_portc_old = PINC;
}

void kbd_suspend(void) {
  DDRC  &= ~0b1; // Set clock line as output
  PORTC &= ~0b1; // pull clock line low
  PCICR &= ~0b10; // interrupt PCINT8 on falling edge
  PCMSK1 &= ~0b01; // enable PCINT8 interrupt
}

void kbd_resume(void) {
  g_kbd_shift=0;
  g_kbd_parity=0;
  g_kbd_count=0;
  DDRC  |= 0b11; // Set clock line and KBDATA as input
  PORTC |= 0b11; // enable pull-up on KBCLK and KBDATA
  g_portc_old=PINC;
  PCICR |= 0b10; // interrupt PCINT8 on falling edge
  PCMSK1 |= 0b01; // enable PCINT8 interrupt
}

ISR(PCINT1_vect) { /* Note: PCINT1 _GROUP_ includes PCINT8-14 */
  if ((g_portc_old & 0x1) && (~PINC & 0x1)) { // falling clock
    g_kbd_parity ^= (PINC & 0x2) >> 1;
    if ((g_kbd_count == 0) && !(PINC & 0x2 >> 1)) { // start bit
      ++g_kbd_count;
    } else if (g_kbd_count == 10) { // stop bit - reset
      g_kbd_buf[g_kbd_buf_len] = g_kbd_shift;
      g_kbd_buf_len = (g_kbd_buf_len + 1) % KBD_BUF_SIZE;
      g_kbd_parity = 0;
      g_kbd_count = 0;
      g_kbd_shift = 0;
      InputCollect();
    } else if (g_kbd_count == 9) {
      /* Optionally check parity */
      if (g_kbd_parity == 0x0) {// error
        kbd_suspend();  //pause keyboard to resume in sync
        _delay_ms(1);
        printf_P(PSTR("KBD PARITY ERROR\n"));
        kbd_resume(); // reset state
      } else {
        ++g_kbd_count;
      }
    } else { 
      g_kbd_shift >>= 1;
      g_kbd_shift |= ((PINC & 0x2) >> 1) << 7;
      ++g_kbd_count;
    }
  }
  g_portc_old = PINC;
}

