#ifndef CRC32_H_
#define CRC32_H_

/** Use this for simple one-shot CRC's because it does added finalization
 * steps.  -bcg **/
unsigned long CalcCRC(const char *buffer, int length);
unsigned long CalcCRCBase (unsigned long crc, const char *buffer, int length);

#endif
