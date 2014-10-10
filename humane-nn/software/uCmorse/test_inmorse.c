#include <stdio.h>
#include "inmorse.h"

#ifndef AVR
#include <termios.h>
#include <unistd.h>
struct termios tios, orig_tios;

int SetupTerminal() { // VT52 interactive mode 
  if (tcgetattr(0, &orig_tios)) {
    fprintf(stderr,"Error getting tios terminal settings\n");
    return -3;
  }

  /* copy that to tios and play with it */
  tios = orig_tios;

  /* We want to disable the canonical mode */
  tios.c_lflag &= ~ICANON;

  /* And make sure ECHO is disabled */
  tios.c_lflag &= ~ECHO;

  /* Apply our settings */
  if (tcsetattr(0, TCSANOW, &tios)){
    printf("Error applying terminal settings\n");
    return 3;
  }

  /* Check whether our settings were correctly applied */
  if (tcgetattr(0, &tios)){
    tcsetattr(0, TCSANOW, &orig_tios);
    printf("Error while asserting terminal settings\n");
    return 3;
  }

  if ((tios.c_lflag & ICANON) || (tios.c_lflag & ECHO)) {
    tcsetattr(0, TCSANOW, &orig_tios);
    printf("Could not apply all terminal settings\n");
    return 3;
  }
  return 0;
}

void RestoreTerminal() {
  /* Restore terminal settings */
  tcsetattr(0, TCSANOW, &orig_tios);
}
#else
int SetupTerminal() {return 0;}
void RestoreTerminal() {}
#endif

#if 000
    printf("Type something!\n");
    fflush(stdout);
    for (int i=0; i<10; ++i) {
      char c;
      read(0, &c, 1);
      printf("\ngot %c\n", c);
    }
#endif

int main(int argc, char **argv) {
  if (argc < 2) {
    fprintf(stderr,"USAGE: %s <code>\nEXAMPLE: %s .--\n",argv[0],argv[0]);
    return 0;
  }
  char *c = argv[1];
  char *p=0x0;
  int pLen=63;
  if (argv[1][1] != 'i') {
    while (*c != 0x0) {
      char res = InMorseNext(*c, &p, &pLen);
      if (res == -1) {
        fprintf(stderr, "ERROR: expected a dot or a dash, but got a '%c' == %i\n", *c, *c);
        return -1;
      } else if (res == -2) {
        fprintf(stderr, "ERROR: sequence too long\n");
        return -2;
      }
      printf("RES = %c\n", res);
      for (int i=0; i<pLen; ++i) 
        printf("%c", *(p + i));
      printf("\n");
      printf("%c",*c);
      for (int i=0; i<(pLen-1)/2 - 1; ++i) 
        printf(" ");
      printf("^\n");

      c++;
    }

    printf("You selected a %c, p=%li\n",  *(p + (pLen -1)/2), (long int) (p - codetree));
  } else  { // vt52 interactive mode
    int res = SetupTerminal();
    if (res != 0) return res;

    // 2-line output format.  
    // First line is codetree state, second line is accumulated output
    char input[40]; // accumulated input
    int inputLen=0;
    for (int i=0; i<40; ++i) 
      input[i] = 0x0;
    printf("\n"); // move to lower line, so that we can clear
    while (1) {
      // Get New Character
      char *p = codetree;
      int pLen = 63;
      while (1) {
        // Move up and clear to home position
        printf("\033[2K\r"); // clear second line, move to col 0
        printf("\033[1A"); // cursor up
        printf("\033[2K\r"); // clear first line, move to col 0
        // Print codetree status
        for (int i=0; i<(p - codetree); ++i)
          printf(" ");
        for (int i=0; i<pLen; ++i) {
          if (i == (pLen - 1)/2)
            printf("\033[7m"); // reverse video
          printf("%c", p[i]);
          if (i == (pLen - 1)/2)
            printf("\033[0m"); // normal video
        }
        // Print accumulated input
        printf("\n> ");
        for (int i=0; i<inputLen; ++i)
          printf("%c", input[i]);
        fflush(stdout);
        // Get new input
        char c;
        fread(&c, 1, 1, stdin);
        if (c == '[') c = '.';
        if (c == ']') c = '-';
        if (c == '.' || c == '-') {
          int res = InMorseNext(c, &p, &pLen);
          if (res < 0)
            break; // start over
        } else if (c == '\n') {
          input[inputLen++] = *(p + (pLen - 1)/2);
          break;
        } else {
          break;
        }
      }

    }

    RestoreTerminal();
  }
  return 0;
}
