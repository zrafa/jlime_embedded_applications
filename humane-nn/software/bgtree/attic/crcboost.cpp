#include <boost/crc.hpp>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
  const char *s = "Hello, World!";
  //const char *s = "Test vector from febooti.com";
  int sl = strlen(s);

  boost::crc_32_type hash;
  hash.process_bytes(s, sl);

  unsigned int k = hash.checksum();
  fprintf(stderr, "CRC(Hello, World!) = %x = %u - boost::crc_32_type\n", k, k);

}
