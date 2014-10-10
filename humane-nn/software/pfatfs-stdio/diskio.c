/*-----------------------------------------------------------------------*/
/* Low level disk I/O module skeleton for Petit FatFs (C)ChaN, 2009      */
/*-----------------------------------------------------------------------*/

#include "diskio.h"
#include <stdio.h>
#include <assert.h>

FILE *diskfile=0x0;
extern const char *diskfilename;

DWORD sdCacheMiss=0;

/*-----------------------------------------------------------------------*/
/* Initialize Disk Drive                                                 */
/*-----------------------------------------------------------------------*/

DSTATUS disk_initialize (void)
{
	// Put your code here
  if (!diskfilename) return RES_ERROR;
  diskfile = fopen(diskfilename,"rb");
  if (!diskfile) return RES_ERROR;

	return RES_OK;
}



/*-----------------------------------------------------------------------*/
/* Read Partial Sector                                                   */
/*-----------------------------------------------------------------------*/

DRESULT disk_readp (
	BYTE* dest,			/* Pointer to the destination object */
	DWORD sector,		/* Sector number (LBA) */
	WORD sofs,			/* Offset in the sector */
	WORD count			/* Byte count (bit15:destination) */
)
{
  assert(diskfile);

  ++sdCacheMiss;

  if (fseek(diskfile, sector*512 + sofs, SEEK_SET))
    return RES_ERROR;
  if (fread(dest, 1, count, diskfile) != count)
    return RES_ERROR;

	return RES_OK;
}



/*-----------------------------------------------------------------------*/
/* Write Partial Sector                                                  */
/*-----------------------------------------------------------------------*/

DRESULT disk_writep (
	const BYTE* buff,		/* Pointer to the data to be written, NULL:Initiate/Finalize write operation */
	DWORD sc		/* Sector number (LBA) or Number of bytes to send */
)
{
	DRESULT res;


	if (!buff) {
		if (sc) {

			// Initiate write process

		} else {

			// Finalize write process

		}
	} else {

		// Send data to the disk

	}

	return RES_ERROR;
}

