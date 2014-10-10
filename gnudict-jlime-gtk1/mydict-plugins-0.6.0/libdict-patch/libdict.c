/* libdict.c
 * sdyoung@well.com
 *
 * This is where the higher-level functions are handled.  Low-level
 * (and mostly internal) functions are in ldsock.c and
 * ldutil.c.
 *
 * The guideline is that this file is where all exported functions
 * go.  This guideline is gleefully violated with considerable frequency.
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
 * $Header: /home/sdyoung/cstuff/libdict-1.0-pre/src/libdict.c,v 1.21 2002/07/04 01:54:39 sdyoung Exp $
 * $Log: libdict.c,v $
 * Revision 1.21  2002/07/04 01:54:39  sdyoung
 * Changed all calls to strcmp/strcasecmp to use our own
 * _ld_qstrcmp function.
 *
 * Revision 1.20  2002/07/04 01:49:56  sdyoung
 * The Great Function Renaming - internal functions now start
 * with _ld_, external functions start with ld_.
 *
 * Revision 1.19  2002/07/04 00:45:27  sdyoung
 * Changes to support caching.
 *
 * Revision 1.18  2002/03/15 19:09:07  steve
 * One last bugfix to ld_newconn.
 *
 * Revision 1.17  2002/03/15 18:39:03  sdyoung
 * Added license to the comment header.
 *
 * Revision 1.16  2002/03/15 18:34:13  sdyoung
 * Moved some stuff around in newconn to give better error reporting.
 *
 * Revision 1.15  2002/03/15 18:17:55  sdyoung
 * Made ld_newconn always return something so we can return error
 * status of connection attempt in dictconn->ld_errno.
 *
 * Revision 1.14  2002/03/14 05:23:08  sdyoung
 * Added support for ld_manswers/danswers - we can free it ourselves now.
 *
 * Revision 1.13  2002/03/13 21:08:20  sdyoung
 * Added ld_geterrno function; also made changes to support ld_errno being
 * in dictconn structure now.
 *
 * Revision 1.12  2002/03/12 18:13:26  sdyoung
 * Change true/false to ld_true/ld_false.
 *
 * Revision 1.11  2002/03/12 17:59:16  sdyoung
 * Changed all bool's to ld_bools (to avoid C++ conflict)
 *
 * Revision 1.10  2001/11/13 00:01:58  sdyoung
 * Made all functions that deal with quoted server replies automatically
 * unquote (eg, ld_match).
 *
 * Revision 1.9  2001/11/12 21:52:41  sdyoung
 * ld_newconn now gets the database and strategy lists automatically;
 * ld_getdbs and ld_getstrats just return pointers to the lists which
 * are stored in ld_conn structures.  This means that the library can
 * now automatically take care of ld_freedbs.
 *
 * Revision 1.8  2001/11/09 06:35:45  sdyoung
 * Added some comments.
 *
 * Revision 1.7  2001/11/02 00:11:26  sdyoung
 * Added capability to specify what CLIENT greeting will be used.
 *
 * Revision 1.6  2001/11/01 20:16:22  sdyoung
 * Added support for enum ld_servcode.
 *
 * Revision 1.5  2001/10/18 21:54:17  sdyoung
 * Corrected a whack of fairly serious memory leaks.
 *
 * Revision 1.4  2001/03/08 20:28:45  sdyoung
 * Fixed a memory leak in ld_define.
 *
 * Revision 1.3  2001/03/05 16:23:00  sdyoung
 * Added a few missing ld_xfrees to ld_freeconn().
 *
 * Revision 1.2  2001/03/03 23:16:04  sdyoung
 * Added ld_getsrvreply.
 *
 * Revision 1.1  2001/03/03 10:07:02  sdyoung
 * Initial revision
 *
 */
#include <stdio.h>
#include <netdb.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <ctype.h>
#include <stdarg.h>

#include "libdict.h"
#include "ldutil.h"
#include "ldsock.h"
#include "ldcache.h"

/* get server response number.  returns 0 on error with ld_errno set. */
/* note: now uses the ld_servcode enumerated type.  see ldservcodes.h */
enum ld_servcode ld_getrespno(char *msg) {
	char num[4];

	if((strlen(msg) < 3) || ((!isdigit(msg[0])) || (!isdigit(msg[1])) || (!isdigit(msg[2])))) {
		return(LD_None);
	} 

	memcpy(num, msg, 3);
	num[3] = '\0';

	return((enum ld_servcode) atoi(num));
}

/* ld_checkok will take an integer response number and simplify it for
 * you: is it success (LD_True), failure (LD_False), or was it an intermittent
 * failure (Maybe). */
ld_bool ld_checkok(int respno) {
	if(respno < 300)
		return(LD_True);
	if(respno > 399)
		return(LD_False);
	return(LD_Maybe);
}

/* free a database list */
void _ld_freedbs(struct ld_dbs **dbs) {
	int i = 0;

	if(!dbs) return;

	while(dbs[i]) {
		if(dbs[i]->ld_dbname) _ld_xfree(dbs[i]->ld_dbname);
		if(dbs[i]->ld_dbdesc) _ld_xfree(dbs[i]->ld_dbdesc);
		_ld_xfree(dbs[i]);
		i++;
	}

	_ld_xfree(dbs);
}
	
/* get a server reply; check it for okayness.  this is used by some
 * of the simpler commands that don't deal with variable-length
 * responses */
ld_bool _ld_docommand(struct ld_conn *conn, ld_bool getr, char *fmt, ...) {
	ld_bool retv = LD_True;
	va_list args;
	/* sorry guys - 8k command limit */
	char buf[BUFSIZ];

	/* first, send the command */
	va_start(args, fmt);
	vsnprintf(buf, BUFSIZ, fmt, args);
	va_end(args);

	if((_ld_sockprintf(conn, buf) == LD_False)) {
		retv = LD_False;
		/* getr tells us if we need to grab and do minimal processing
		 * on the return string ourselves.  this can save a lot of 
		 * time. */
	} else if(getr == LD_True && _ld_xreadline(conn, &conn->ld_srvreply) == LD_False) {
		retv = LD_False;
	} else if(getr == LD_True) {
		retv = ld_checkok(ld_getrespno(conn->ld_srvreply));
	}

	return(retv);
}

/* send the CLIENT info to the server */
ld_bool _ld_sendclient(struct ld_conn *conn, char *client) {
	if(client) 
		return(_ld_docommand(conn, LD_True, "CLIENT %s\r\n", client));
	return(_ld_docommand(conn, LD_True, "CLIENT %s\r\n", LD_VERSION));
}

/* get database list.  also used to retrieve strategies */
struct ld_dbs **_ld_getdblist(struct ld_conn *conn, char *cmd) {
    char *tmpbuf = NULL;
    struct ld_dbs **retv = NULL;
    int dbcount = 0;
    char *p;
    ld_bool readok;

    /* execute the command (show db or show strat) */
    if(_ld_docommand(conn, LD_True, "%s\r\n", cmd) == LD_False)
        return(NULL);

    while((readok = _ld_xreadline(conn, &tmpbuf)) == LD_True) {
        /* while the data hasn't ended ... */
        if(!_ld_qstrcmp(tmpbuf, ".")) break;

        /* create an array to hold our answer's attributes.
         * or, resize it upwards for new entries */
        retv = _ld_xrealloc(retv, sizeof(struct ld_dbs *) * (dbcount + 2));
        /* point our array slot to attribute structure */
        retv[dbcount] = _ld_xmalloc(sizeof(struct ld_dbs));
        bzero(retv[dbcount], sizeof(struct ld_dbs));

        if((p = strchr(tmpbuf, ' '))) {
            *p = '\0';
            retv[dbcount]->ld_dbname = _ld_xstrdup(_ld_unquote(tmpbuf));
            retv[dbcount]->ld_dbdesc = _ld_xstrdup(_ld_unquote(p+1));
        } else {
            retv[dbcount]->ld_dbname = _ld_xstrdup(_ld_unquote(tmpbuf));
        }
        dbcount++;
    }

    retv[dbcount] = NULL;

    if(!readok) {
        _ld_freedbs(retv);
        return(NULL);
    } else {
        if(_ld_xreadline(conn, &conn->ld_srvreply) == LD_False) {
            _ld_freedbs(retv);
            return(NULL);
        }
    }

    if(tmpbuf) {
        _ld_xfree(tmpbuf);
        tmpbuf = NULL;
    }

    return(retv);
}

/* get a list of databases (internal) */
struct ld_dbs **_ld_igetdbs(struct ld_conn *conn) {
    return(_ld_getdblist(conn, "SHOW DB"));
}

/* get a list of strategies (internal) */
struct ld_dbs **_ld_igetstrats(struct ld_conn *conn) {
    return(_ld_getdblist(conn, "SHOW STRAT"));
}

/* connect to a dict server.  everything except the host argument is optional
 * and can be set to 0 or NULL (whichever is appropriate).
 * this will spit you back a filled out ld_conn structure, or NULL upon
 * error. */
struct ld_conn *ld_newconn(char *host, int port, int timeout, char *client, int defcachesz, int matchcachesz, ld_bool debug) {
	struct ld_conn *srvhandle;
	struct servent *dictport;

	srvhandle = _ld_xmalloc(sizeof(struct ld_conn));
	bzero(srvhandle, sizeof(struct ld_conn));
	
	srvhandle->ld_host = _ld_xstrdup(host);
	srvhandle->ld_timeout = timeout;
	srvhandle->ld_debug = debug;

	/* try and work out the port number for ourselves if it's not passed. */
	if(!port) {
		if(!(dictport = getservbyname("dict", "tcp"))) {
			port = LD_DEFPORT;
		} else {
			port = dictport->s_port;
		}
	}
	
	srvhandle->ld_port = port;

	if(_ld_tcpopen(srvhandle) == LD_False) 
		return(srvhandle);

	/* ld_tcpopen has filled out ld_srvfd for us */
	
	/* now we just slurp the banner and we're done. */
	if(_ld_readline(srvhandle, &srvhandle->ld_srvbanner) == LD_False) {
		srvhandle->ld_errno = LDERRNO;
		close(srvhandle->ld_srvfd);
		srvhandle->ld_srvfd = 0;
		return(srvhandle);
	}

	if((ld_checkok(ld_getrespno(srvhandle->ld_srvbanner)) != LD_True) ||
	   (_ld_sendclient(srvhandle, client) == LD_False)) {
		srvhandle->ld_errno = LDBADPROTO;
		return(srvhandle);
	}

	/* get databases */
	if((srvhandle->ld_dbs = _ld_igetdbs(srvhandle))) 
		srvhandle->ld_strats = _ld_igetstrats(srvhandle);

	/* initialize the caches */
	srvhandle->ld_dconncache = _ld_newcache(defcachesz ? defcachesz : DEFAULT_DCACHE);
	srvhandle->ld_mconncache = _ld_newcache(matchcachesz ? matchcachesz : DEFAULT_MCACHE);

	return(srvhandle);
}

/* free the memory structures for conn */
void ld_freeconn(struct ld_conn *conn) {
	/* this does NOT set ld_errno because it is called after
	 * ld_errno has been set all over the place. */
	if(!conn) return;
	if(conn->ld_srvfd) 
		ld_closeconn(conn);
	if(conn->ld_host)
		_ld_xfree(conn->ld_host);
	if(conn->ld_srvreply)
		_ld_xfree(conn->ld_srvreply);
	if(conn->ld_srvbanner)
		_ld_xfree(conn->ld_srvbanner);
	if(conn->ld_srchdb)
		_ld_xfree(conn->ld_srchdb);
	if(conn->ld_srchstrat)
		_ld_xfree(conn->ld_srchstrat);
	if(conn->ld_dbs) 
		if(*conn->ld_dbs) 
			_ld_freedbs(conn->ld_dbs);
	if(conn->ld_strats) 
		if(*conn->ld_strats)
			_ld_freedbs(conn->ld_strats);
	if(conn->ld_manswers)
		_ld_freematans(conn->ld_manswers);
	if(conn->ld_danswers)
		_ld_freedefans(conn->ld_danswers);
	if(conn->ld_mconncache)
		_ld_freecache(conn->ld_mconncache, LD_False);
	if(conn->ld_dconncache)
		_ld_freecache(conn->ld_dconncache, LD_True);

	_ld_xfree(conn);
}

/* Perform the protocol-level teardown of connection conn.  We don't
 * check a lot of return values here since we don't really care. 
 * it will return true if the disconnect went smoothly and 
 * conn->ld_srvreply has the server's goodbye message in it.
 * false if things didn't go so well in which case conn->srvreply
 * is unspecified. */
ld_bool ld_closeconn(struct ld_conn *conn) {
	ld_bool retv = LD_False;
	/* tell the server we want to quit */
	if(conn && (_ld_sockprintf(conn, "QUIT\r\n") == LD_True)) {
		/* the server connection is still open, so we
		 * politely wait for the server to say goodbye */
		_ld_xreadline(conn, &conn->ld_srvreply); 
		retv = LD_True;
		if(conn->ld_srvfd) {
			close(conn->ld_srvfd);
			conn->ld_srvfd = 0;
		}
	}
	return(retv);
}

/* authenticate user with the server */
ld_bool ld_auth(struct ld_conn *conn, char *user, char *pw) {
	return(_ld_docommand(conn, LD_True, "AUTH %s %s\r\n", user, pw));
}

/* return server banner */
char *ld_serverinfo(struct ld_conn *conn) {
	return(conn->ld_srvbanner);
}

struct ld_dbs **ld_getdbs(struct ld_conn *conn) {
	return(conn->ld_dbs);
}

struct ld_dbs **ld_getstrats(struct ld_conn *conn) {
	return(conn->ld_strats);
}

/* set the strategy to use */
ld_bool ld_setstrat(struct ld_conn *conn, char *strat) {
	int x = 0;
	ld_bool stratok = LD_False;

	while(conn->ld_strats[x]) {
		if(!_ld_qstrcmp(conn->ld_strats[x]->ld_dbname, strat)) {
			stratok = LD_True;
			break;
		}
		x++;
	}

	if(stratok == LD_False) {
		conn->ld_errno = LDBADARG;
		return(LD_False);
	}

	if(conn->ld_srchstrat) _ld_xfree(conn->ld_srchstrat);

	conn->ld_srchstrat = _ld_xstrdup(strat);

	_ld_resetcache(conn);

	return(LD_True);
}

/* set the current db to be searched */
ld_bool ld_setdb(struct ld_conn *conn, char *db) {
	int x = 0;
	ld_bool dbok = LD_False;

	if(_ld_qstrcmp(db, "*")) {
		while(conn->ld_dbs[x]) {
			if(!_ld_qstrcmp(conn->ld_dbs[x]->ld_dbname, db)) {
				dbok = LD_True;
				break;
			}
			x++;
		}
	} else {
		dbok = LD_True;
	}

	if(dbok == LD_False) {
		conn->ld_errno = LDBADARG;
		return(LD_False);
	}

	if(conn->ld_srchdb) _ld_xfree(conn->ld_srchdb);
	
	conn->ld_srchdb = _ld_xstrdup(db);

	_ld_resetcache(conn);

	return(LD_True);
}

/* define a word.  we're not as paranoid as we should be here */
struct ld_defanswer **ld_define(struct ld_conn *conn, char *word) {
	char *tmpbuf = NULL, *p, *p2;
	int anscount = 0, anssz, cmdret;
	ld_bool readok;

	if(conn->ld_danswers) {
		_ld_freedefans(conn->ld_danswers);
		conn->ld_danswers = NULL;
	}

	if(_ld_isdefinecached(conn, word)) {
		conn->ld_danswers = _ld_getdefinecache(conn, word);
		return(conn->ld_danswers);
	}

	/* send the initial command */
	if(_ld_docommand(conn, LD_False, "DEFINE %s %s\r\n", 
	                conn->ld_srchdb ? conn->ld_srchdb : "*",
					word) == LD_False) 
		return(NULL);
	
	/* get response.. */
	if(_ld_xreadline(conn, &tmpbuf) == LD_False) 
		return(NULL);

	cmdret = ld_getrespno(tmpbuf);

	/* check there are some answers */
	if(cmdret != LD_DefsFollow) {
		conn->ld_errno = LDNOMATCH;
		_ld_xfree(tmpbuf);
		tmpbuf = NULL;
		return(NULL);
	}

	/* read in all the defs */
	while((readok = _ld_xreadline(conn, &tmpbuf)) == LD_True) {
		if(ld_getrespno(tmpbuf) == LD_OK)
			break;
		anssz = 0;
		conn->ld_danswers = _ld_xrealloc(conn->ld_danswers, sizeof(struct ld_defanswer *) * (anscount + 2));
		conn->ld_danswers[anscount] = _ld_xmalloc(sizeof(struct ld_defanswer));
		bzero(conn->ld_danswers[anscount], sizeof(struct ld_defanswer));

		if(ld_getrespno(tmpbuf) != LD_WordDBName) {
			readok = LD_False;
			conn->ld_errno = LDBADPROTO;
			break;
		}

		/* ok, let's deal with the 151 line */
		if(!(p=strchr(tmpbuf + 4, ' '))) {
			readok = LD_False;
			conn->ld_errno = LDBADPROTO;
			break;
		}

		if(!(p2=strchr(p + 1, ' '))) {
			readok = LD_False;
			conn->ld_errno = LDBADPROTO;
			break;
		}

		*p2 = '\0';

		conn->ld_danswers[anscount]->ld_ansdict = _ld_xstrdup(_ld_unquote(p + 1));

		*p = '\0';

		conn->ld_danswers[anscount]->ld_answord = _ld_xstrdup(_ld_unquote(tmpbuf + 4));

		while((readok = _ld_xreadline(conn, &tmpbuf)) == LD_True) {
			if(!_ld_qstrcmp(tmpbuf, ".")) {
				break;
			}
			if(conn->ld_danswers[anscount]->ld_ansdef) {
				conn->ld_danswers[anscount]->ld_ansdef = _ld_xrealloc(conn->ld_danswers[anscount]->ld_ansdef, strlen(conn->ld_danswers[anscount]->ld_ansdef) + strlen(tmpbuf) + 3);
				strcat(conn->ld_danswers[anscount]->ld_ansdef, "\r\n");
				strcat(conn->ld_danswers[anscount]->ld_ansdef, tmpbuf);
			} else {
				conn->ld_danswers[anscount]->ld_ansdef = _ld_xstrdup(tmpbuf);
			}
		}

		if(readok == LD_False)
			break;

		anscount++;
	}

	if(readok == LD_False) {
		if(conn->ld_danswers[anscount]) {
			if(conn->ld_danswers[anscount]->ld_ansdict) _ld_xfree(conn->ld_danswers[anscount]->ld_ansdict);
			if(conn->ld_danswers[anscount]->ld_answord) _ld_xfree(conn->ld_danswers[anscount]->ld_answord);
			if(conn->ld_danswers[anscount]->ld_ansdef) _ld_xfree(conn->ld_danswers[anscount]->ld_ansdef);
			_ld_xfree(conn->ld_danswers[anscount]);
			conn->ld_danswers[anscount] = NULL;
		}
		_ld_freedefans(conn->ld_danswers);
		conn->ld_danswers = NULL;
	}

	if(readok) {
		conn->ld_danswers[anscount] = NULL;
	}

	if(tmpbuf) {
		_ld_xfree(tmpbuf);
		tmpbuf = NULL;
	}

	_ld_adddefinecache(conn, word, conn->ld_danswers);

	return(conn->ld_danswers);
}

/* free an answer */
void _ld_freedefans(struct ld_defanswer **answers) {
	int x = 0;

	if(!answers) return;

	while(answers[x]) {
		if(answers[x]->ld_ansdict) _ld_xfree(answers[x]->ld_ansdict);
		if(answers[x]->ld_answord) _ld_xfree(answers[x]->ld_answord);
		if(answers[x]->ld_ansdef) _ld_xfree(answers[x]->ld_ansdef);
		_ld_xfree(answers[x]);
		x++;
	}

	_ld_xfree(answers);
}

/* free the answer to a match */
void _ld_freematans(struct ld_matchanswer **answers) {
	int x=0;

	if(!answers) return;

	while(answers[x]) {
		if(answers[x]->ld_ansdict) _ld_xfree(answers[x]->ld_ansdict);
		if(answers[x]->ld_answord) _ld_xfree(answers[x]->ld_answord);
		_ld_xfree(answers[x]);
		x++;
	}

	_ld_xfree(answers);
}

/* this kind of shames me .. watch out for some casting */
struct ld_matchanswer **ld_match(struct ld_conn *conn, char *word) {
	char tmpbuf[BUFSIZ];

	if(conn->ld_manswers) {
		_ld_freematans(conn->ld_manswers);
		conn->ld_manswers = NULL;
	}

	if(_ld_ismatchcached(conn, word)) {
		conn->ld_manswers = _ld_getmatchcache(conn, word);
		return(conn->ld_manswers);
	}

	snprintf(tmpbuf, BUFSIZ, "MATCH %s %s %s", 
		     conn->ld_srchdb ? conn->ld_srchdb : "*",
		     conn->ld_srchstrat ? conn->ld_srchstrat : "exact",
		     word);

	conn->ld_manswers = (struct ld_matchanswer **)_ld_getdblist(conn, tmpbuf);

	_ld_addmatchcache(conn, word, conn->ld_manswers);

	return(conn->ld_manswers);
}

/* this will return the server's response to the last command */
char *ld_getsrvreply(struct ld_conn *conn) {
	return(conn->ld_srvreply);
}

/* return error value from a connection */
int ld_geterrno(struct ld_conn *conn) {
	return(conn->ld_errno);
}
