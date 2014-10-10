// Found this posted by "Peret" at
// http://www.avrfreaks.net/index.php?name=PNphpBB2&file=viewtopic&t=28214&highlight=crc32

// CCITT CRC-32 (Autodin II) polynomial:
// X32+X26+X23+X22+X16+X12+X11+X10+X8+X7+X5+X4+X2+X+1

unsigned long CalcCRCBase (unsigned long crc, const char *buffer, int length)
{
  int   i,j ;
  for (i=0; i<length; i++)
  {
    crc = crc ^ *buffer++ ;
    for (j=0; j<8; j++)
    {
      if (crc & 1)
        crc = (crc>>1) ^ 0xEDB88320 ;
      else
        crc = crc >>1 ;
    }
  }
  return crc ;
}

unsigned long CalcCRC(const char *buffer, int length) {
  unsigned long k = CalcCRCBase(0xFFFFFFFF, buffer, length);
  k ^= 0xffffffff;
  k &= 0xffffffff;
  return k;
}
