#include "Platform.h"

const char *fileName="test.txt";

void RndSeekTest() {
  FileOpenRO(fileName);
  ERRORassert();
  
  const int posSize=5; 
  unsigned long pos[]={27*128, 13*128, 7*128, 0, 21*128};

  OutP("RANDOM SEEK SPEED\n");
  OutI(posSize); OutP(" seek&reads of 128 bytes: ");

  char buf[128]; // same as node size
  unsigned long start = TimerCount();
  for (int i=0; i<posSize; ++i) {
    FileSeek(pos[i]);
    FileRead(buf, 128);
  }
  unsigned long end = TimerCount();
  unsigned long t = ((1000UL*128*TimerCountPerMillisec())/(end - start));
  OutI(t); OutP(" Bps\n");
}

void ReadSpeedTest() {
  FileOpenRO(fileName);
  ERRORassert();

  const int maxSize=600;
  int sizes[]={1,10,100,200,500,600};
  const int numSizes=6;

  OutP("SEQUENTIAL READ SPEED TESTS\n");

  for (int j = 0; j < numSizes; ++j) {
    int sz = sizes[j];
    unsigned long start = TimerCount();
    char buf[maxSize];
    unsigned long i=0;
    StackPrintInfo(stdout);
    OutP("Rd "); OutI(sz); OutP(" at a time,"); OutI(maxSize); OutP(" bytes: "); 
    for (i=0; i<maxSize; i += sz) {
      int r = FileRead(buf, sz);
      if (r < sz || IsError)
        break;
    }
    unsigned long end = TimerCount();
    //OutP("TimeCounterPerMillisec = "); OutI((unsigned long) TimerCountPerMillisec()); OutP("\n");
    //OutP("end - start = "); OutI((unsigned long) end); OutC('-'); OutI(start); 
    //OutP(" = "); OutI(end - start); OutP("\n");
    unsigned long t = ((1000UL*i*TimerCountPerMillisec())/(end - start));
    OutI(t); OutP(" Bps\n");

    FileSeek(0);
  }
}

int main(int argc, char **argv) {
  PlatformInit();
  RndSeekTest();
  ReadSpeedTest();
  return 0;
}
