/* **** BRADDOCK'S TVIKIA PLATFORM CODE for use with pfatfs or fatfs **** */
#include "TvikiaSDCard.h"
#include "diskio.h"

#include <stdio.h>

/* Defined in mmc.c */
DRESULT disk_readp_real(
	BYTE *buff,		/* Pointer to the read buffer (NULL:Read bytes are forwarded to the stream) */
	DWORD lba,		/* Sector number (LBA) */
	WORD ofs,		/* Byte offset to read from (0..511) */
	WORD cnt		/* Number of bytes to read (ofs + cnt mus be <= 512) */
);

void init_spi(void) {
  // Set MOSI, SS and SCK output, all others input
  DDR_SPI = _BV(DD_MOSI) | _BV(DD_SCK) | _BV(DD_SS);
  DESELECT();
  //Enable SPI, Master, clock rate f_osc/128
  //SPCR = (1 << SPE) | (1 << MSTR) | (1 << SPR1) | (1 << SPR0);
  //Enable SPI, Master, clock rate f_osc/2 = 10 MHz
  SPCR = (1 << SPE) | (1 << MSTR) | (0 << SPR1) | (0 << SPR0); //f_osc/4
  SPSR |= (1 << SPI2X); //double clock = f_osc/2
}

void xmit_spi(BYTE b) {
  SPDR = b;
  while (!(SPSR & (1 << SPIF)))
    ;
}

BYTE rcv_spi(void) {
  xmit_spi(0xff);
  return SPDR;
}

void power_on(void) {
  init_spi();
}

void power_off(void) { }

int chk_power(void) {		/* Socket power state: 0=off, 1=on */
  return 1;
}

#ifndef USE_SD_CACHE
DRESULT disk_readp (
	BYTE *buff,		/* Pointer to the read buffer (NULL:Read bytes are forwarded to the stream) */
	DWORD lba,		/* Sector number (LBA) */
	WORD ofs,		/* Byte offset to read from (0..511) */
	WORD cnt		/* Number of bytes to read (ofs + cnt mus be <= 512) */
) {
  return disk_readp_real(buff, lba, ofs, cnt);
}
#else
BYTE sdCache[SD_CACHE_SIZE];
DWORD sdCacheN = 0xffffffff;
DWORD sdCacheHit=0;
DWORD sdCacheMiss=0;

DRESULT disk_readp (
	BYTE *buff,		/* Pointer to the read buffer (NULL:Read bytes are forwarded to the stream) */
	DWORD lba,		/* Sector number (LBA) */
	WORD ofs,		/* Byte offset to read from (0..511) */
	WORD cnt		/* Number of bytes to read (ofs + cnt mus be <= 512) */
) {
#if 0
  uint64_t pos = (512*lba + (uint64_t)ofs);
  DWORD n = pos/(uint64_t)SD_CACHE_SIZE;
  DWORD n2 = (pos + (uint64_t)cnt - 1)/(uint64_t)SD_CACHE_SIZE;
  DWORD r = pos % SD_CACHE_SIZE;
#else
  DWORD n = (512/SD_CACHE_SIZE)*lba + ofs/SD_CACHE_SIZE;
  DWORD n2 = (512/SD_CACHE_SIZE)*lba + (ofs + cnt - 1)/SD_CACHE_SIZE;
  DWORD r = ofs % SD_CACHE_SIZE;
#endif
  if (n != n2) { // strattling our block: we don't handle this
    ++sdCacheMiss;
    return disk_readp_real(buff, lba, ofs, cnt);
  }
#if 0
  if (!((sdCacheHit + sdCacheMiss) % 5000)) {
    printf("Hit %li Mis %li\n",sdCacheHit, sdCacheMiss);
    printf("readp(%li, %i, %i) ",lba, ofs, cnt);
    printf(" n=%li r=%li \n", n, r);
  }
#endif
  if (n == sdCacheN) {
    ++sdCacheHit;
    for (int i=0; i<cnt; ++i)
      buff[i] = sdCache[r + i];
    return RES_OK;
  }
  ++sdCacheMiss;
  sdCacheN = n;
  DRESULT res = disk_readp_real(sdCache, (((uint64_t)n)*SD_CACHE_SIZE)/512, (((uint64_t)n)*SD_CACHE_SIZE) % 512, SD_CACHE_SIZE);
  if (res != RES_OK) {
    sdCacheN = 0xffffffff;
    return res;
  }
  for (int i=0; i<cnt; ++i)
    buff[i] = sdCache[r + i];
  return RES_OK;
}

#endif

