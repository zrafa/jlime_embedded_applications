#include <string.h>
#include "WikiApp.h"
#include "vt52.h"
#include "crc32.h"
#include "bgUtil2.h"

void PrintHexBlock(unsigned char *buf, int buflen) {
  for (int i=1; i<buflen; ++i) {
    printf_P(PSTR("%x%x"), (unsigned int) (buf[i] >> 4) & 0xf, (unsigned int) buf[i] & 0xf);
    if (!(i % 16))
      OutC('\n');
  }
  OutC('\n');
}

uint64_t SeekAndRead(uint32_t offset) {
  FileSeek(offset);
  ERRORassert();
  uint64_t i;
  int res = FileRead((char *) &i, sizeof(uint64_t));
  ERRORassert();
  assert(res == sizeof(uint64_t));
  return i;
}

void TestLargeSeek() {
  OutP("TestLargeSeek.");

  FileOpenRO("sec.bgb"); //800Mbyte+
  ERRORassert();

  const int nsample=23;
  uint32_t samples[] = {0x63612072, 0x70206120, 0x61747365, 0x6e45202e, 0x6f697461, 0x34312f70, 0x41202e6b, 0x20796220, 0x6e6f6974, 0x7665696c, 0x2e47412f, 0x6c746e65, 0x726f7461, 0x7861206f, 0x20206f66, 0x65636966, 0x797c3830, 0x497b7b6e, 0x2c6e6f69, 0x6c676e45, 0x7542202c, 0x6c6f6f68, 0x68742066};
  uint32_t samples2[nsample];

  // warm continuity record 
  printf("%lu\n", 128LU << 22LU);
  SeekAndRead(128LU << 22);
  uint32_t a=128;
  for (int i=0; i<nsample; ++i) {
    uint32_t readCount = FileSectorReadCount();
    samples2[i] = SeekAndRead(a);
    if (samples[i] != samples2[i]) {
      OutX(a);OutP(" Bad match "); OutX(samples[i]); OutP("!="); OutX(samples2[i]);OutP("\n");
    } else {
      OutX(a);OutP(" match "); OutX(samples[i]); OutP("=="); OutX(samples2[i]);
      OutP(" # Reads=");OutI(FileSectorReadCount() - readCount); OutP("\n");
      OutC('.');
    }
    a = a << 1;
  }
  OutC('\n');
 
#if 0 
  a=128 << nsample;
  for (int i=nsample-1; i>=0; --i) {
    a = a >> 1;
    samples2[i] = SeekAndRead(a);
    if (samples[i] != samples2[i]) {
      OutX(a);OutP(" rev bad match "); OutX(samples[i]); OutP("!="); OutX(samples2[i]);OutP("\n");
    } else {
      //OutX(a);OutP(" rev match "); OutX(samples[i]); OutP("=="); OutX(samples2[i]);OutP("\n");
    }
  }
#endif

  OutP("uint32_t samples[] = {");
  for (int i=0; i<nsample; ++i)
    printf_P(PSTR("0x%08x, "), (unsigned int) samples2[i]);
  OutP("};\n");
}

void TestNodesValid(WikiApp *wapp) {
  OutP("Test NodesValid..");
  const int nsample=18;
  uint32_t samples[] = {0x00000000, 0x00000080, 0x00000180, 0x00000280, 0x00000280, 0x00000a80, 0x00001a80, 0x00003a80, 0x00007b00, 0x0000fb80, 0x0001fc80, 0x0003fe80, 0x0007fb00, 0x000ffc00, 0x001ffe00, 0x003ffa80, 0x007ffb80, 0x00fffd00};
  uint64_t samples2[nsample];

  uint32_t a=0x1;
  for (int i=0; i<nsample; ++i) {
    Node n;
    LoadBlock(a*sizeof(Node), &n, &wapp->pageContext);
    ERRORassert();
    if (n.length > ItemsPerNode) {
      OutP("Invalid len "); OutI(n.length); OutP(" addr 0x");
      OutX(a*sizeof(Node)); OutP("\n");
    }
    if (n.depth > 9) {
      OutP("Invalid depth "); OutI(n.depth); OutP(" addr 0x");
      OutX(a*sizeof(Node)); OutP("\n");
    }
    if (n.parentNode == BAInvalid) { // only node 0 has parent Invalid
      OutP("Invalid parent "); OutI(n.parentNode); OutP(" addr 0x");
      OutX(a*sizeof(Node)); OutP("\n");
    }
    samples2[i] = *((uint32_t *) &n);
    if (samples2[i] != samples[i]) {
      OutP("Bad match "); OutX(samples[i]); OutP("!="); OutX(samples2[i]);OutP("\n");
    }
    a = a << 1;
    OutC('.');
  }
  OutC('\n');

  OutP("uint32_t samples = {");
  for (int i=0; i<nsample; ++i)
    printf_P(PSTR("0x%08x, "), (unsigned int) samples2[i]);
  OutP("}\n");
}

int recur(int i) {
  uint64_t j = i*i;
  printf_P(PSTR("recur %i %i %lu\n"),i,(unsigned int) j,(unsigned long) (TimerCount() >> 8) & 0xffffffff);
  StackPrintInfo(stdout);
  DelayMs(100);
  --i;
  if (i)
    recur(i);
  return j;
}

int main(int argc, char **argv) {
  PlatformInit();
  OutP("test_WikiApp\n");

  assert(sizeof(Node) == BlockSize);
  assert(sizeof(unsigned long) >= 4); // Needed for pf_fseek to function

  WikiApp wapp;
  WikiAppInit(&wapp);
  ERRORassert();

  //recur(10000);

  TestLargeSeek();
  TestNodesValid(&wapp);

#if 0
  uint64_t addr[] = {0x0, 0x00d3e200};
  for (int i=0; i<2; ++i) {
    Node n;
    uint64_t sample;
    OutP("Block "); OutX(addr[i]); OutP("\n");
    LoadBlock(addr[i], &n, &wapp.pageContext); 
    PrintHexBlock((unsigned char *) &n, BlockSize/2);
    sample = SeekAndRead(addr[i]);
    OutP("SAMPLE=");
    PrintHexBlock((unsigned char *) &sample, sizeof(uint64_t));
    assert(sample == *((uint64_t *) &n));
  }
#endif

  //NodeVisitDFS(wapp.pageTree, &TestSanityVisitor, wapp.pageTree.topNode);
  //NodeVisitDFS(wapp.pageTree, &PrintVisitor, wapp.pageTree.topNode);

  const char *titles[] = {"ARMADILLO", "CADILLAC","GHOST", "A", 0x0};
  uint32_t crcs[] = {0x517bfbb3, 0x4f93eba7, 0xf4075211, 0xd3d99e8b};

  StackPrintInfo(stdout);


  for (int i=0; titles[i] != 0x0; ++i) {
    OutP("Searching for "); OutS(titles[i]); 
    OutP("..");
    uint32_t crc = CalcCRC(titles[i], strlen(titles[i]));
    if (crc != crcs[i]) {
      printf_P(PSTR("Bad crc %lx != %lx\n"), (unsigned long)crc, (unsigned long)crcs[i]);
    }
    require(crc == crcs[i]);
    int res = WikiAppSetTitle(&wapp, titles[i]);
    ERRORassert();
    if (res) {
      OutP("FOUND \n");
    } else {
      OutP("NOT FOUND\n");
    }
    BAT found = CursorNext(&wapp.toc.startCur);
    require(found != BAInvalid);
    FileOpenRO(wapp.pageContext.blobFname);
    ERRORassert();
    FILE *blob = FileGetHandle();
    ERRORassert();
    FileSeek(found);
    ERRORassert();
    uint32_t level = SchemaGetInt(blob, WIKI_SCHEMA, WIKI_LEVEL);
    OutP(" level="); OutI(level); OutP(" ");
    ERRORassert();
    FileSeek(found);
    ERRORassert();
    char outBuf[12];
    SchemaGetString(blob, WIKI_SCHEMA, WIKI_TITLE, outBuf, 12);
    OutP("title="); OutS(outBuf); OutC('\n'); 
  }
  StackPrintInfo(stdout);

  OutP("DONE\n");
  return 0;
}
