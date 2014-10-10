/* **** BRADDOCK'S TVIKIA PLATFORM CODE for use with pfatfs or fatfs **** */
#ifndef TVIKIA_H
#define TVIKIA_H

#include <avr/io.h>
#include "integer.h"

/* SPI control functions */
void init_spi (void);
void xmit_spi (BYTE);
BYTE rcv_spi (void);
void power_on(void);
void power_off(void);
int chk_power(void);	/* Socket power state: 0=off, 1=on */

#define DDR_SPI DDRB
#define PORT_SPI PORTB

#define DD_SS DDB2
#define PIN_SS PORTB2
#define DD_MOSI DDB3
#define PIN_MOSI PORTB3
#define DD_MISO DDB4
#define PIN_MISO PORTB4
#define DD_SCK  DDB5
#define PIN_SCK PORTB5

/* Port Controls  (Platform dependent) */
#define SELECT()	PORT_SPI &= ~(1 << PIN_SS)	/* MMC CS = L */
#define	DESELECT()	PORT_SPI |=  (1 << PIN_SS) /* MMC CS = H */

#define CS_LOW() SELECT()
#define CS_HIGH() DESELECT()
#define rcvr_spi() rcv_spi()

/* Port Controls (Platform dependent) */
#define	MMC_SEL		!(PORT_SPI & (1 << PIN_SS))	/* MMC CS status (true:selected) */
#define	INIT_SPI()	init_spi()		/* Initialize SPI port */

/* FIXME: We have no contact pin!  FAKING IT! */
#define SOCKPORT	0			/* Socket contact port */
#define SOCKWP		0			/* Write protect switch (PB5) */
#define SOCKINS		0			/* Card detect switch (PB4) */

/* Alternative macro to receive data fast */
#define rcvr_spi_m(dst)	SPDR=0xFF; loop_until_bit_is_set(SPSR,SPIF); *(dst)=SPDR

#endif // TVIKIA_H

