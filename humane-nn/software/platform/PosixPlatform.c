void sounder(int onOrOff, int msec) { }

/** Under Posix we use the normal stdio, set to non-blocking cannonical mode **/
#include <signal.h>
#include <termios.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/time.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/select.h>
#include "Errors.h"
#include "Platform.h"

struct termios tios, orig_tios;

void StdioDestroy() {
  fprintf(stderr,"DEBUG: StdioDestroy()\n");
  /* Restore terminal settings */
  tcsetattr(0, TCSANOW, &orig_tios);
}

void StdioInit() {
  struct sigaction saio;           /* definition of signal action */

  /* install the signal handler before making the device asynchronous */
  saio.sa_handler = StdioDestroy;
  sigemptyset(&saio.sa_mask);
  saio.sa_flags = 0;
  saio.sa_restorer = NULL;
  sigaction(SIGIO,&saio,NULL);
  atexit(StdioDestroy);

  /* Put terminal in immediate input mode */
  if (tcgetattr(0, &orig_tios))
    ERRORreturn("Error getting tios terminal settings");

  /* copy that to tios and play with it */
  tios = orig_tios;

  /* We want to disable the canonical mode */
  tios.c_lflag &= ~ICANON;

  /* And make sure ECHO is disabled */
  tios.c_lflag &= ~ECHO;

  /* Apply our settings */
  if (tcsetattr(0, TCSANOW, &tios))
    ERRORreturn("Error applying terminal settings");

  /* Check whether our settings were correctly applied */
  if (tcgetattr(0, &tios)){
    tcsetattr(0, TCSANOW, &orig_tios);
    ERRORreturn("Error while asserting terminal settings");
  }

  if ((tios.c_lflag & ICANON) || (tios.c_lflag & ECHO)) {
    tcsetattr(0, TCSANOW, &orig_tios);
    ERRORreturn("Could not apply all terminal settings");
  }
}

void StackCheck() {}
void StackPrintInfo(FILE *f) {}

void PlatformInit() { 
  StdioInit();
  ERRORassert();
  TimerInit();
  ERRORassert();
  FileInit();
  if (IsError) {
    ERRORprint();
    fprintf(stderr, "Error during FileInit, no File I/O\n");
  } 
}

void OutC(char c) {
  fputc(c, stdout);
}

uint64_t startTime;

uint64_t GetTimeOfDayMilli() {
  struct timeval tv;
  gettimeofday(&tv,0x0);
  return 1000LU*tv.tv_sec + tv.tv_usec/1000LU;
}

void TimerInit() {
  startTime = GetTimeOfDayMilli();
}

/** Return value of millisecond timer **/
uint32_t TimerMillisec() {
  return GetTimeOfDayMilli() - startTime;
}

uint64_t TimerCount() {
  return TimerMillisec();
}

uint32_t TimerCountPerMillisec() {
  return 1;
}

void DelayMs(unsigned int t) {
  usleep(1000*t);
}

char InputIsReady() {
  fd_set rfds;
  FD_ZERO(&rfds);
  FD_SET(fileno(stdin), &rfds);
  struct timeval tv;
  tv.tv_sec = 0;
  tv.tv_usec = 0;
  int ready = select(fileno(stdin) + 1, &rfds, 0x0, 0x0, &tv);
  return ready;
}

int InputCheck() {
  int ready = InputIsReady();
  if (ready) {
    char c;
    read(fileno(stdin),&c, 1); //not fread because of buffer
    return c;
  } else {
    return -1;
  }
}

