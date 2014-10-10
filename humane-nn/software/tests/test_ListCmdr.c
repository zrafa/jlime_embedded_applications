#include "ListView.h"
#include "ListCmdr.h"
#include "vt52.h"
#include <string.h>
#ifndef AVR
#  include <unistd.h>
#else
#  define usleep(x)
#endif

char *strings[]={"apple","banana","crepe","croissant","dessert","edible","fromage",0x0};
int stringsIndex=0;

char StringsNextFunc(ListGen *gen, char *outBuf, unsigned char outBufLen) {
  if (strings[stringsIndex] == 0x0)
    return 0;
  if (outBuf)
    strncpy(outBuf, strings[stringsIndex], outBufLen);
  ++stringsIndex;
  return 1;
}

void StringsRestartFunc(ListGen *gen) {
  stringsIndex = 0;
}

void Test1() {
  ListGen gen = ListGenCreate(StringsNextFunc, StringsRestartFunc, 0x0);
  char buf[LISTGEN_STRING_MAX];
  int notend = ListGenNext(&gen, buf, LISTGEN_STRING_MAX);
  assert(notend);
  assert(!strcmp(buf, "apple"));
  notend = ListGenNext(&gen, buf, LISTGEN_STRING_MAX);
  assert(notend);
  assert(!strcmp(buf, "banana"));

  ListGenRestart(&gen);
  for (int i=0; i<7; ++i) {
    notend = ListGenNext(&gen, buf, LISTGEN_STRING_MAX);
    assert(notend);
    assert(!strcmp(buf, strings[i]));
  }
  notend = ListGenNext(&gen, buf, LISTGEN_STRING_MAX);
  assert(!notend);

  for (int i=6; i>=0; --i) {
    notend = ListGenGet(&gen, i, buf, LISTGEN_STRING_MAX);
    assert(notend);
    assert(!strcmp(buf, strings[i]));
  }
}

void Test2() {
  ListView view = ListViewCreate(ListGenCreate(StringsNextFunc, StringsRestartFunc, 0x0), 3, 4, -1, 1);
  printf(VERASE_SCR);
  vposition(stdout, 0,0);
  while (!ListViewDraw(&view));

  usleep(200);
  ListViewSetFocus(&view, 3);
  assert(ListViewGetFocus(&view) == 3);
  printf(VERASE_SCR);
  vposition(stdout, 0,0);
  while (!ListViewDraw(&view));

  usleep(200);
  ListViewFocusNext(&view);
  assert(ListViewGetFocus(&view) == 4);
  assert(view.offset == 1);
  printf(VERASE_SCR);
  vposition(stdout, 0,0);
  while (!ListViewDraw(&view));

  usleep(200);
  ListViewFocusPrev(&view);
  ListViewFocusPrev(&view);
  assert(ListViewGetFocus(&view) == 2);
  printf(VERASE_SCR);
  vposition(stdout, 0,0);
  while (!ListViewDraw(&view));

  ListViewSetFocus(&view, 10);
  assert(ListViewGetFocus(&view) == 2);
  
  usleep(200);
  ListViewSetFocus(&view, 0);
  assert(view.offset == 0);
  printf(VERASE_SCR);
  vposition(stdout, 0,0);
  while (!ListViewDraw(&view));
}

void Test3() {
  char prefix[LISTGEN_STRING_MAX];
  prefix[0] = 0x0;
  StringsRestartFunc(0x0);
  assert(!PrefixCompare("apP","aPple"));
  PrefixFilter pf;
  ListGen gen = PrefixFilterCreate(&pf, prefix, ListGenCreate(StringsNextFunc, StringsRestartFunc, 0x0));
  assert(ListGenGet(&gen, 4, 0x0, 0));
  prefix[0] = 'b';
  prefix[1] = 0x0;
  assert(!ListGenGet(&gen, 4, 0x0, 0));
  char buf[LISTGEN_STRING_MAX];
  ListGenRestart(&gen);
  assert(ListGenNext(&gen, buf, LISTGEN_STRING_MAX));
  assert(!strcmp(buf, "banana"));
  assert(!ListGenNext(&gen, buf, LISTGEN_STRING_MAX));
}

void Test4() {
  PlatformInit();
  printf(VERASE_SCR);

  ListGen gen = ListGenCreate(StringsNextFunc, StringsRestartFunc, 0x0);
  ListCmdr cmdr;
  ListCmdrInit(&cmdr, gen, 1, 7, 0, 1);
  assert(ListCmdrGetValue(&cmdr) == 0x0);
  while (!ListCmdrDraw(&cmdr));

  usleep(500);
  ListCmdrPushEvent(&cmdr, 'a');
  while (!ListCmdrDraw(&cmdr));

  usleep(500);
  ListCmdrPushEvent(&cmdr, '\b');
  while (!ListCmdrDraw(&cmdr));

  unsigned char escState = 0;
  while (!ListCmdrGetValue(&cmdr)) {
    int r = fgetc(stdin);
    vposition(stdout, 15, 0);
    printf(VERASE_LINE_CUR "%i -> ",r);
    r = InputUnescape(r, &escState);
    printf("%i",r);
    if (r != -1)
      ListCmdrPushEvent(&cmdr, r);
    while (!ListCmdrDraw(&cmdr));
  }
  printf("VALUE = %s\n", ListCmdrGetValue(&cmdr));
}

int main(int argc, char **argv) {
  Test1();
  Test2();
  Test3();
  Test4();
  return 0;
}
