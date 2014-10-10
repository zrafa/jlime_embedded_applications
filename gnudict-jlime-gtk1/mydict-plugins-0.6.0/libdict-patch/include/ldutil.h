/* ldutil.h
 * sdyoung@well.com
 *
 * This is the header file for ldutil.c - see that file for details
 * on what this is all about.  This is just prototypes.
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
 * $Header: /home/sdyoung/cstuff/libdict-1.0-pre/src/include/ldutil.h,v 1.6 2002/07/04 01:50:50 sdyoung Exp $
 * $Log: ldutil.h,v $
 * Revision 1.6  2002/07/04 01:50:50  sdyoung
 * The Great Function Renaming - internal functions now start
 * with _ld_, external functions start with ld_.
 *
 * Revision 1.5  2002/07/04 00:45:54  sdyoung
 * Added prototype for ld_qstrcmp.
 *
 * Revision 1.4  2002/03/15 18:42:18  sdyoung
 * Added license info to comment block.
 *
 * Revision 1.3  2002/03/12 18:01:36  sdyoung
 * Added ld_unquote definition.
 *
 * Revision 1.2  2001/10/18 02:37:11  sdyoung
 * Added support for dmalloc.
 *
 * Revision 1.1  2001/03/03 10:08:55  sdyoung
 * Initial revision
 *
 */
#ifndef _LDUTIL_H
#define _LDUTIL_H
#include <stdlib.h>
#include "libdict.h"

#ifndef MDEBUG
void *_ld_xmalloc(size_t sz);
char *_ld_xstrdup(char *s);
void _ld_xfree(void *p);
void *_ld_xrealloc(void *p, size_t sz);
#else
#define _ld_xmalloc malloc
#define _ld_xstrdup strdup
#define _ld_xfree free
#define _ld_xrealloc realloc
#endif /* !MDEBUG */

char *_ld_unquote(char *str);
int _ld_qstrcmp(char *s1, char *s2);

#endif /* !_LDUTIL_H */
