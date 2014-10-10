#include "Platform.h"
#include "stdio.h"
#ifdef AVR
#  include <util/delay.h>
#  include <avr/io.h>
#endif

int main(int argc, char **argv) {
  PlatformInit();
  ERRORassert();
  StackPrintInfo(stdout);
  DelayMs(1000);
#if 0
  while (1) {
    static int pos=0;
    int c = InputCheck();
    if (c != -1) {
      printf("%c", c);
      if (pos-- == 0) {
        printf("\n> ");
        pos = 16;
      }
    }
  }
#endif
  int i=0;
  while (1) {
    //printf("\n -=[ Hello World! %i %lu \n", i++, TimerCount());
    //printf("    / %lu =", TimerCountPerMillisec());
    //printf(" %lu ms PORTD=%x]=-\n", TimerMillisec(), PIND);
    OutS_P(PSTR("\n -=[ Hello World! ")); OutI(i++); OutC(' '); OutI(TimerCount()); OutC('\n');
    OutS_P(PSTR("    / ")); OutI(TimerCountPerMillisec()); OutS_P(PSTR(" = ")); OutI(TimerMillisec()); 
    OutS_P(PSTR(" ms PORTD=")); OutX(PIND); OutS_P(PSTR(" ]=-\n"));
    OutS_P(PSTR(" ms PORTC=")); OutX(PINC); OutS_P(PSTR(" ]=-\n"));
    StackPrintInfo(stdout);
    for (int j=0; j<10; ++j) {
      int c = InputCheck();
      if (c != -1)
        printf("INPUT> %c\n", c);
      DelayMs(100);
    }
  }
  return 0;
}

