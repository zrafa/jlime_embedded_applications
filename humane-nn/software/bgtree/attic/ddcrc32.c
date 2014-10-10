/*
 * Found at: http://wiki.wxwidgets.org/Development:_Small_Table_CRC
 *     
 * This set of implementations was written by David M. Dantowitz, and
 * has been placed in the public domain, to be used at the user's
 * discretion.  The original code was implemented in Turbo Pascal 3.0
 * this submission is a version written in C.
 * */

#include <stdio.h>
#include <string.h>

#define INITIAL_CRC 0xFFFFFFFF

/* This result was obtained by calling make_crc_table(0xedb88320). */

int crc_table[16] =
{
  0x00000000,
  0xfdb71064,
  0xfb6e20c8,
  0x06d930ac,
  0xf6dc4190,
  0x0b6b51f4,
  0x0db26158,
  0xf005713c,
  0xedb88320,
  0x100f9344,
  0x16d6a3e8,
  0xeb61b38c,
  0x1b64c2b0,
  0xe6d3d2d4,
  0xe00ae278,
  0x1dbdf21c
};

void make_crc_table(crc_poly)
  int crc_poly;
{
  int i, val, result;

  for (val = 0; val < 16; val++)
  {
    result = val;

    for (i = 0; i < 4; i++)
      if (result & 1)
        result = (result >> 1) ^ crc_poly;
      else
        result >>= 1;

    crc_table[val] = result;

    printf("0x%08x\n", result);
  }
}

int compute_crc(old_crc, s, len)
  unsigned int old_crc;
  char *s;
  unsigned int len;
{
  unsigned int i;

  for (i = 0; i < len; i++)
  {
    printf("%c.",s[i]);
    /* XOR in the data. */
    old_crc ^= s[i];

    /* Perform the XORing for each nybble */
    old_crc = (old_crc >> 4) ^ crc_table[old_crc & 0x0f];
    old_crc = (old_crc >> 4) ^ crc_table[old_crc & 0x0f];
  }

  return (old_crc);
}

#if 0
main()
{
  char line[100];
  int crc_val;
  int len;

  /* make_crc_table(0xedb88320); done at compile time... */

  /* initialize the crc -- start with this value each time you start a session. */
  crc_val = INITIAL_CRC;

  strcpy(line, "This will test the crc function");
  len = strlen(line);

  crc_val = compute_crc(crc_val, line, len);

  /* let's add MORE text to the CRC -- they can be cumulative across many blocks of data. */
  strcpy(line, "More text to add");
  len = strlen(line);

  crc_val = compute_crc(crc_val, line, len);
}
#endif
