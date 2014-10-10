/* lderrno.c
 * sdyoung@well.com
 *
 * Functions pertaining to the ld_errno variable. 
 *
 *   Copyright (c) 2001, 2002 Steven Young
 *
 *   Permission is hereby granted, free of charge, to any person obtaining
 *   a copy of this software and associated documentation files (the
 *   "Software"), to deal in the Software without restriction, including
 *   without limitation the rights to use, copy, modify, merge, publish,
 *   distribute, sublicense, and/or sell copies of the Software, and to
 *   permit persons to whom the Software is furnished to do so, subject to
 *   the following conditions:
 *
 *   The above copyright notice and this permission notice shall be
 *   included in all copies or substantial portions of the Software.
 *
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 *   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 *   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 *   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 *   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 *   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * $Header: /home/sdyoung/cstuff/libdict-1.0-pre/src/lderrno.c,v 1.5 2002/03/15 18:39:27 sdyoung Exp $
 * $Log: lderrno.c,v $
 * Revision 1.5  2002/03/15 18:39:27  sdyoung
 * Added license information to comment header.
 *
 * Revision 1.4  2002/03/14 18:17:33  sdyoung
 * Made ld_strerror handle errno errors too.  i.e. the user
 * will no longer have to test for LDERRNO and call strerror itself.
 *
 * Revision 1.3  2002/03/13 21:07:50  sdyoung
 * Got rid of global ld_errno variable.  It's in dictconn now.
 *
 * Revision 1.2  2001/10/18 00:51:30  sdyoung
 * Added support for LDTIMEOUT.
 *
 * Revision 1.1  2001/03/03 10:06:28  sdyoung
 * libdict errno code
 *
 */
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <errno.h>
#include "libdict.h"

/* convert an ld_errno value to a string */
char *ld_strerror(int errval) {
	char *txt[] = { "No error",
					"See errno",
					"Bad argument passed to libdict function",
					"No matches found",
					"Protocol problems (unexpected response)",
					"Operation timed out" };

	if(errval > LDERRMAX) 
		return("Out-of-range ld_errno");
	
	if(errval == LDERRNO)
		return(strerror(errno));

	return(txt[errval]);
}
