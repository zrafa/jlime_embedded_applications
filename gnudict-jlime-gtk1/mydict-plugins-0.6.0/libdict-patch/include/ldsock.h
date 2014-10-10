/* ldsock.h
 * sdyoung@well.com
 *
 * This is where all the socket code is prototyped.  A few structures,
 * #defines and typedefs might be slipped in here too.
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
 * $Header: /home/sdyoung/cstuff/libdict-1.0-pre/src/include/ldsock.h,v 1.5 2002/07/04 01:50:50 sdyoung Exp $
 * $Log: ldsock.h,v $
 * Revision 1.5  2002/07/04 01:50:50  sdyoung
 * The Great Function Renaming - internal functions now start
 * with _ld_, external functions start with ld_.
 *
 * Revision 1.4  2002/03/15 18:41:58  sdyoung
 * Added license info to comment block.
 *
 * Revision 1.3  2002/03/12 18:01:10  sdyoung
 * Renamed bool to ld_bool.
 *
 * Revision 1.2  2001/10/21 18:07:58  sdyoung
 * Where did LD_READBLOCK go?
 *
 * Revision 1.1  2001/03/03 10:08:47  sdyoung
 * Initial revision
 *
 */
#ifndef _LDSOCK_H
#define _LDSOCK_H
#include "libdict.h"

/* first, defines. */
#define LD_READBLOCK 2048

/* second, protos */
ld_bool _ld_tcpopen(struct ld_conn *conn);
ld_bool _ld_sockprintf(struct ld_conn *, char *fmt, ...);
ld_bool _ld_readline(struct ld_conn *, char **sptr);
ld_bool _ld_xreadline(struct ld_conn *, char **sptr);

#endif /* !_LDSOCK_H */
