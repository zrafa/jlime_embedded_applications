/* libdict.h
 * sdyoung@well.com
 *
 * This is the main header file for libdict.  All programs that want to use
 * libdict should include this file or things will go horribly amiss.
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
 * $Header: /home/sdyoung/cstuff/libdict-1.0-pre/src/include/libdict.h,v 1.18 2002/07/04 04:47:19 sdyoung Exp $
 * $Log: libdict.h,v $
 * Revision 1.18  2002/07/04 04:47:19  sdyoung
 * Minor changes - more comments.
 *
 * Revision 1.17  2002/07/04 01:50:50  sdyoung
 * The Great Function Renaming - internal functions now start
 * with _ld_, external functions start with ld_.
 *
 * Revision 1.16  2002/07/04 00:46:42  sdyoung
 * Added caching support: new variables in ld_conn and a change
 * to the ld_newconn prototype.
 *
 * Revision 1.15  2002/06/04 22:49:16  sdyoung
 * Minor cosmetic changes to version string.
 *
 * Revision 1.14  2002/03/15 18:42:31  sdyoung
 * Added license info to comment lbock.
 *
 * Revision 1.13  2002/03/15 18:10:59  sdyoung
 * minor typofix; Maybe now known as LD_Maybe.
 *
 * Revision 1.12  2002/03/14 05:22:25  sdyoung
 * Added ld_manswers/danswers to dictconn so we can free the match/define
 * results ourselves.
 *
 * Revision 1.11  2002/03/13 21:39:32  sdyoung
 * Minor cleanup (changed version number)
 *
 * Revision 1.10  2002/03/13 21:06:29  sdyoung
 * Made changes to support ld_errno being in dictconn now.
 *
 * Revision 1.9  2002/03/12 18:11:54  sdyoung
 * changed true and false to LD_True / LD_False
 *
 * Revision 1.8  2002/03/12 18:00:30  sdyoung
 * Renamed bool to ld_bool.
 *
 * Revision 1.7  2002/03/12 17:59:55  sdyoung
 * Modified to incorporate ld_setstrat/db's ability to return success/fail.
 *
 * Revision 1.6  2001/11/02 00:11:42  sdyoung
 * Added support for client argument to ld_newconn.
 * Also updated ld_sendclient.
 *
 * Revision 1.5  2001/11/01 20:16:55  sdyoung
 * Added support for enum ld_servcode.
 *
 * Revision 1.4  2001/10/18 02:12:00  sdyoung
 * Added dmalloc support (-DMDEBUG)
 *
 * Revision 1.3  2001/03/08 13:52:57  sdyoung
 * Revised version number in LD_VERSION and friends.
 *
 * Revision 1.2  2001/03/03 23:16:49  sdyoung
 * Added proto for ld_getsrvreply.
 *
 * Revision 1.1  2001/03/03 10:09:03  sdyoung
 * Initial revision
 *
 */
#ifndef _LIBDICT_H
#define _LIBDICT_H
#include "ldservcodes.h"

#ifdef LD_MDEBUG
#include "dmalloc.h"
#endif

/* first, some basic #defines .. */
#define LD_VERSION "1.0-pre"
#define LD_MAJVER 1
#define LD_MINVER 0

#define LD_DEFPORT 2628

/* second, some typedefs */
typedef enum { LD_False = 0, LD_True, LD_Maybe } ld_bool;

/* third, structures. */
/* this structure is the principle 'connection handle' that gets passed
 * to all libdict functions */
struct ld_conn {
	/* information about the TCP/IP connection: */
	char *ld_host;
	int ld_port;
	int ld_timeout;
	int ld_srvfd;
	int ld_errno;
	ld_bool ld_debug;
	/* Information about the server. */
	char *ld_srvreply;
	char *ld_srvbanner;
	struct ld_dbs **ld_dbs;
	struct ld_dbs **ld_strats;
	/* State information */
	char *ld_srchdb;
	char *ld_srchstrat;
	struct ld_matchanswer **ld_manswers;
	struct ld_defanswer **ld_danswers;
	/* the MATCH cache */
	struct ld_cacheinfo *ld_mconncache;
	/* the DEFINE cache */
	struct ld_cacheinfo *ld_dconncache;
};

/* this is a list, either of databases or strategies.  either way we
 * store it the same. */
struct ld_dbs {
	char *ld_dbname;
	char *ld_dbdesc;
};

/* this is where match results get stored */
struct ld_matchanswer {
	char *ld_ansdict;
	char *ld_answord;
};

/* this is a list of answers from the server for a particular define/
 * match. */
struct ld_defanswer {
	char *ld_answord;
	char *ld_ansdict;
	char *ld_ansdef;
};

/* fourth, prototypes */
enum ld_servcode ld_getrespno(char *msg);
ld_bool ld_checkok(int respno);
ld_bool _ld_docommand(struct ld_conn *conn, ld_bool getr, char *fmt, ...);
struct ld_conn *ld_newconn(char *host, int port, int timeout, char *client, int defcachesz, int matchcachesz, ld_bool debug);
void ld_freeconn(struct ld_conn *conn);
ld_bool ld_closeconn(struct ld_conn *conn);
ld_bool ld_auth(struct ld_conn *conn, char *user, char *pw);
char *ld_serverinfo(struct ld_conn *conn);
struct ld_dbs **ld_getdbs(struct ld_conn *conn);
struct ld_dbs **ld_getstrats(struct ld_conn *conn);
ld_bool ld_setstrat(struct ld_conn *conn, char *strat);
ld_bool ld_setdb(struct ld_conn *conn, char *db);
struct ld_defanswer **ld_define(struct ld_conn *conn, char *word);
struct ld_matchanswer **ld_match(struct ld_conn *conn, char *word);
void _ld_freedefans(struct ld_defanswer **answers);
void _ld_freematans(struct ld_matchanswer **answers);
char *ld_getsrvreply(struct ld_conn *conn);
int ld_geterrno(struct ld_conn *conn);

/* finally, one last thing to do. */
#include "lderrno.h"

#endif /* !_LIBDICT_H */
