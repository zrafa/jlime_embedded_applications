/* ldutil.c
 * sdyoung@well.com
 *
 * Various utility functions that are used throughout libdict can
 * be found here. 
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
 * $Header: /home/sdyoung/cstuff/libdict-1.0-pre/src/ldutil.c,v 1.7 2002/07/04 01:49:56 sdyoung Exp $
 * $Log: ldutil.c,v $
 * Revision 1.7  2002/07/04 01:49:56  sdyoung
 * The Great Function Renaming - internal functions now start
 * with _ld_, external functions start with ld_.
 *
 * Revision 1.6  2002/07/04 00:45:10  sdyoung
 * Added ld_qstrcmp to support caching functions.
 *
 * Revision 1.5  2002/03/15 18:38:50  sdyoung
 * Added license to the header.
 *
 * Revision 1.4  2001/11/13 00:01:37  sdyoung
 * Added ld_unquote function.
 *
 * Revision 1.3  2001/11/09 06:29:04  sdyoung
 * Added comments.
 *
 * Revision 1.2  2001/10/18 02:35:15  sdyoung
 * Added support for dmalloc.
 *
 * Revision 1.1  2001/03/03 10:06:47  sdyoung
 * Initial revision
 *
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "libdict.h"
#include "ldutil.h"

/* All this is pretty self-explanitory.  If MDEBUG is defined, we're 
 * using dmalloc, in which case all these functions are macros for
 * the "real" function (ld_xmalloc becomes malloc, etc) so dmalloc
 * can give meaningful results. */
#ifndef LD_MDEBUG
void *_ld_xmalloc(size_t sz) {
	void *p;

	if(!(p = malloc(sz))) {
		fprintf(stderr, "libdict panic: out of memory?");
		/* we will surely core now */
		return(NULL);
	}

	return(p);
}

char *_ld_xstrdup(char *s) {
	char *p;

	if(!(p = strdup(s))) {
		fprintf(stderr, "libdict panic: unable to strdup %p\n", s);
		return(NULL);
	}

	return(p);
}

void _ld_xfree(void *p) {
	if(p) free(p);
}

void *_ld_xrealloc(void *p, size_t sz) {
	if(!(p = realloc(p, sz))) {
		fprintf(stderr, "libdict panic: unable to realloc\n");
		return(NULL);
	}
	
	return(p);
}
#endif /* !MDEBUG */

/* unquote a string */
char *_ld_unquote(char *str) {
	static char buf[BUFSIZ];
	char *cpstart;
	int sz;

	if(str[0] == '\"') 
		cpstart = str + 1;
	else
		cpstart = str;
	
	if(str[strlen(str)-1] == '\"') 
		sz = (strlen(str) - 2);
	else
		sz = (strlen(str));

	memcpy(buf, cpstart,  sz);

	buf[sz] = '\0';

	return(buf);
}

/* quick strcasecmp */
int _ld_qstrcmp(char *s1, char *s2) {
	while(*s1 && *s2) {
		if(tolower(*s2) != tolower(*s1))
			return(1);
		s1++; s2++;
	}

	return(0);
}
