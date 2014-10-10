#ifndef VT52_H_
#define VT52_H_

#include <stdio.h>

/** This contains definitions for a vt52 terminal, a vt102 terminal, or a TellyMate (mostly vt52). 
 *  Gnome-Terminal does not emulate vt52 unfortunately, thus the need for vt102 abstraction.
 * **/

#ifdef USE_VT52
#  define VESC "\033"
#else
#  define VESC "\033["
#endif

// Common Sequences (except for escape)
#define VUP VESC "A"
#define VDOWN VESC "B"
#define VRIGHT VESC "C"
#define VLEFT VESC "D"

#define VHOME VESC "H"

// Clear down to end-of-screen
#define VERASE_DOWN VESC "J"
// Clear to end of line
#define VERASE_RIGHT VESC  "K" 

#ifdef USE_VT52
#  define VERASE_SCR VESC "E"
#  define VERASE_UP VESC "b"
#  define VERASE_LEFT VESC "o"
#  define VERASE_LINE_CUR VESC "l"

#  define VENABLE_LINE_WRAP VESC "v"
#  define VDISABLE_LINE_WRAP VESC "w"

#  define VSTORE VESC "j"
#  define VRESTORE VESC "k"

#  define VINVERT ""
#  define VNORMAL ""

///  define VPOS(row,col) VESC "Y" (' ' + row) (' ' + col)
#else
#  define VERASE_SCR VESC "2J" VHOME
#  define VERASE_UP VESC "1J"
#  define VERASE_LEFT VESC "1K"
#  define VERASE_LINE_CUR VESC "2K" "\r"

#  define VENABLE_LINE_WRAP VESC "7h"
#  define VDISABLE_LINE_WRAP VESC "7l"

#  define VSTORE VESC "s"
#  define VRESTORE VESC "u"

#  define VINVERT VESC "7m"
#  define VNORMAL VESC "0m"
///  define VPOS(row,col) VESC row ";" col "f"
#endif

void vposition(FILE *f, int row, int col);

/** Clear a range of lines.  End position of cursor is at
 *  start of startRow **/
void vclearlines(FILE *f, int startRow, int endRow);
#endif //VT52_H_
