/* ldcache.c
 * sdyoung@well.com
 *
 * This file contains all the code for the match/define caching code.
 * Each connection has two caches associated with it, one for MATCH
 * results and one for DEFINE results.  The reason there are two caches
 * when a single shared cache would do is that they have much different
 * memory consumption characteristics, thus they need different size limits.
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
 * $History$
 * $Log: ldcache.c,v $
 * Revision 1.4  2002/07/04 04:39:52  sdyoung
 * Minor changes.
 *
 * Revision 1.3  2002/07/04 02:18:59  sdyoung
 * More source cleanup; fixed comments.
 *
 * Revision 1.2  2002/07/04 01:49:56  sdyoung
 * The Great Function Renaming - internal functions now start
 * with _ld_, external functions start with ld_.
 *
 * Revision 1.1  2002/07/04 00:44:52  sdyoung
 * Initial revision
 *
 */
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "libdict.h"
#include "ldutil.h"
#include "ldcache.h"

/* Create and initialize a new cache object. */
struct ld_cacheinfo *_ld_newcache(int cachesize) {
	struct ld_cacheinfo *newcache;

	newcache = _ld_xmalloc(sizeof(struct ld_cacheinfo));
	bzero(newcache, sizeof(struct ld_cacheinfo));

	/* Here we always calculate the number of buckets to be one
	 * tenth of the total cache size.  The cost of a bucket is
	 * only 4 bytes of memory. */
	newcache->cachesize = cachesize;
	newcache->buckets = cachesize / 10;
	newcache->cachebuckets = _ld_xmalloc(sizeof(struct ld_cacheent *) * 
										 newcache->buckets);
	bzero(newcache->cachebuckets, sizeof(struct ld_cacheent *) *
								  newcache->buckets);

	return(newcache);
}


/* Free an entry in a bucket's linked list. */
void _ld_freecacheent(struct ld_cacheent *ent, ld_bool isdefine) {
	/* we just test for danswer here because it's a union. */
	if(ent->answers.danswer) {
		if(isdefine) 
			_ld_freedefans(ent->answers.danswer);
		else
			_ld_freematans(ent->answers.manswer);
	}

	_ld_xfree(ent->word);
	_ld_xfree(ent);
}

/* Free an entire cache. */
void _ld_freecache(struct ld_cacheinfo *cacheptr, ld_bool isdefine) {
	struct ld_cacheent *entptr, *nextptr;
	int i;

	/* Iterate through each bucket */
	for(i = 0; i < cacheptr->buckets; i++) {
		entptr = cacheptr->cachebuckets[i];
		/* Iterate through each item in the bucket */
		while(entptr) {
			nextptr = entptr->next;
			_ld_freecacheent(entptr, isdefine);
			entptr = nextptr;
		}
	}

	_ld_xfree(cacheptr);
}

/* a very simple hash function that seems to produce a reasonably
 * even distribution for ASCII text. */
unsigned int _ld_gethash(char *word, int buckets) {
	unsigned int i = 1;
	char *p, lowerch;

	for(p = word; *p; p++) {
		lowerch = tolower(*p);
		i *= lowerch;
		if(lowerch < 'm')
			i++;
	}

	if(!(word[0]%2)) i++;

	return(i % buckets);
}

/* Move a cache entry to the top of it's bucket.  This is done every time
 * there is a cache hit on an entry.  The idea is that it will keep
 * frequently-hit words at the front of the bucket so it is found faster
 * by the get...cache functions. */
void _ld_movetotop(struct ld_cacheinfo *cacheptr, struct ld_cacheent *entptr,
				   struct ld_cacheent *oldptr, int bucket) {

	/* it's already at the top, just return. */
	if(!oldptr) 
		return;
	
	oldptr->next = entptr->next;
	entptr->next = cacheptr->cachebuckets[bucket];
	cacheptr->cachebuckets[bucket] = entptr;
}

/* Search a cache for an item. */
ld_bool _ld_isxcached(struct ld_cacheinfo *cacheptr, char *word) {
	struct ld_cacheent *entptr = NULL, *oldptr;
	unsigned int wordhash = _ld_gethash(word, cacheptr->buckets);

	oldptr = cacheptr->cachebuckets[wordhash];
	
	/* See if the bucket is empty .. */
	if(!oldptr) {
		/* It is.  We know right away word is not cached.  Zero
		 * out the quick pointers. */
		cacheptr->oquickptr = NULL;
		cacheptr->quickptr = NULL;
#ifdef LD_DEBUGCACHE
		cacheptr->stats.misses++;
#endif
		return(LD_False);
	}

	/* This tests if the first element in the bucket is a hit.  This
	 * is a special case. */
	if(!_ld_qstrcmp(word, oldptr->word)) {
		/* we set quickptr to NULL because get*cache will start looking 
		 * at the beginning of the bucket anyway */
		cacheptr->quickptr = NULL;
#ifdef LD_DEBUGCACHE
		cacheptr->stats.hits++;
#endif
		return(LD_True);
	}

	/* Iterate through the rest of the bucket. */
	for(entptr = oldptr->next; entptr;
	    entptr = entptr->next) {
		if(!_ld_qstrcmp(word, entptr->word)) {
			/* If there's a hit, set quickptr to point to the 
			 * object we found, ... */
			cacheptr->oquickptr = oldptr;
			cacheptr->quickptr = entptr;
#ifdef LD_DEBUGCACHE
			cacheptr->stats.hits++;
#endif
			return(LD_True);
		}
		oldptr = oldptr->next;
	}
			
#ifdef LD_DEBUGCACHE
	cacheptr->stats.misses++;
#endif

	/* No hit. */
	return(LD_False);
}

/* Reset caches.  This frees a cache and then initializes
 * a new one.  We need to do this whenever the strategy
 * or database is changed. */
void _ld_resetcache(struct ld_conn *conn) {
	int dsz = conn->ld_dconncache->cachesize;
	int msz = conn->ld_mconncache->cachesize;

	_ld_freecache(conn->ld_dconncache, LD_True);
	_ld_freecache(conn->ld_mconncache, LD_False);
	conn->ld_dconncache = _ld_newcache(dsz);
	conn->ld_mconncache = _ld_newcache(msz);
}

/* Duplicate a define answer.  This is used to return structures
 * to the user without giving them pointers into the cache. */
struct ld_defanswer **_ld_dupdefanswer(struct ld_defanswer **ans) {
	struct ld_defanswer **newans = NULL;
	int szcount, i;

	if(!ans)
		return(NULL);

	for(szcount = 0; ans[szcount]; szcount++);

	newans = _ld_xmalloc(sizeof(struct ld_defanswer *) * (szcount + 2));

	for(i = 0; ans[i]; i++) {
		newans[i] = _ld_xmalloc(sizeof(struct ld_defanswer));
		newans[i]->ld_answord = _ld_xstrdup(ans[i]->ld_answord);
		newans[i]->ld_ansdict = _ld_xstrdup(ans[i]->ld_ansdict);
		newans[i]->ld_ansdef = _ld_xstrdup(ans[i]->ld_ansdef);
	};

	newans[i] = NULL;
	return(newans);
}

/* Duplicate a match answer.  This is used to return structures
 * to the user without giving them pointers into the cache. */
struct ld_matchanswer **_ld_dupmatchanswer(struct ld_matchanswer **ans) {
    struct ld_matchanswer **newans = NULL;
    int szcount, i;

	if(!ans)
		return(NULL);

    for(szcount = 0; ans[szcount]; szcount++);

    newans = _ld_xmalloc(sizeof(struct ld_matchanswer *) * (szcount + 2));

    for(i = 0; ans[i]; i++) {
        newans[i] = _ld_xmalloc(sizeof(struct ld_matchanswer));
        newans[i]->ld_answord = _ld_xstrdup(ans[i]->ld_answord);
        newans[i]->ld_ansdict = _ld_xstrdup(ans[i]->ld_ansdict);
    };

    newans[i] = NULL;
    return(newans);
}

/* This is the garbage collection routine.  It works as follows:
 * It is called each time a new element is added to the cache.
 * If there are more objects than there should be, performs an
 * incremental garbage collection. 
 * Each incremental garbage collection checks one entire bucket
 * for expired objects.  Thus it takes as many calls as there
 * are buckets to perform a garbage collection on the entire cache. 
 * Age is determined based on the 'serial' variable in ld_cacheent. */
void _ld_expirycheck(struct ld_cacheinfo *cacheptr, ld_bool isdefine) {
	struct ld_cacheent *entptr, *oldptr;
	int workbucket;

	/* The cache isn't too big yet, don't do anything. */
	if(cacheptr->objcount < cacheptr->cachesize)
		return;

#ifdef LD_DEBUGCACHE
	cacheptr->stats.gcs++;
#endif

	/* Reset the quickptrs - they might not make sense anymore after
	 * this is complete. */
	cacheptr->oquickptr = cacheptr->quickptr = NULL;

	/* Increment the bucket we are currently working on. */
	cacheptr->curgcbucket++;
	/* If we have scanned all the buckets then start over. */
	if(cacheptr->curgcbucket == cacheptr->buckets)
		cacheptr->curgcbucket = 0;

	workbucket = cacheptr->curgcbucket;

	entptr = cacheptr->cachebuckets[workbucket];

	/* Nothing in this bucket, return. */
	if(!cacheptr->cachebuckets[workbucket]) return;

	/* Special case: This code handles the event that the very first
	 * element in a bucket is expired.  It will keep deleting the
	 * first element and moving the beginning of the cache 
	 * until it finds one that is not expired. */
	while(cacheptr->cachebuckets[workbucket] && (cacheptr->curserial - entptr->serial > cacheptr->cachesize)) {
		cacheptr->cachebuckets[workbucket] = entptr->next;
		_ld_freecacheent(entptr, isdefine);
#ifdef LD_DEBUGCACHE
		cacheptr->stats.removes++;
#endif
		cacheptr->objcount--;
		entptr = cacheptr->cachebuckets[workbucket];
	}

	/* If there are no more elements in this bucket, return. */
	if(!cacheptr->cachebuckets[workbucket]) return;

	/* Iterate through the rest of the bucket, deleting expired entries. */
	for(oldptr = cacheptr->cachebuckets[workbucket], 
		entptr = cacheptr->cachebuckets[workbucket]->next; 
		entptr; entptr = entptr->next) {
		if(cacheptr->curserial - entptr->serial > cacheptr->cachesize) {
			oldptr->next = entptr->next;
			_ld_freecacheent(entptr, isdefine);
#ifdef LD_DEBUGCACHE
			cacheptr->stats.removes++;
#endif
			cacheptr->objcount--;
			entptr = oldptr;
		} else {
			oldptr = entptr;
		}
	}
}

/* Pull an item out of the DEFINE cache. */
struct ld_defanswer **_ld_getdefinecache(struct ld_conn *conn, char *word) {
	struct ld_cacheinfo *cacheptr;
	struct ld_cacheent *entptr = NULL, *oldptr;
	unsigned int wordhash = _ld_gethash(word, conn->ld_dconncache->buckets);

	cacheptr = conn->ld_dconncache;

	/* See if ld_isdefinecached set quickptr for us. */
	if(cacheptr->quickptr) {
		/* It is.  Move the hit to the front of the bucket. */
		_ld_movetotop(cacheptr, cacheptr->quickptr, cacheptr->oquickptr, wordhash);
		/* Update the serial so _expirycheck doesn't delete it. */
		cacheptr->quickptr->serial = cacheptr->curserial++;
		/* Return the results from the cache. */
		return(_ld_dupdefanswer(cacheptr->quickptr->answers.danswer));
	}

	oldptr = cacheptr->cachebuckets[wordhash];

	/* If this bucket is empty, go home. */
	if(!oldptr)
		return(NULL);
	
	/* Special case: Check the first element to see if it's a hit. */
	if(!_ld_qstrcmp(oldptr->word, word)) {
		oldptr->serial = cacheptr->curserial++;
		return(_ld_dupdefanswer(oldptr->answers.danswer));
	}

	/* Otherwise, iterate through the bucket .. */
	for(entptr = oldptr->next; entptr; entptr = entptr->next) {
		/* Check to see if it's a hit. */
		if(!_ld_qstrcmp(entptr->word, word)) {
			/* If it is, move that element to the front of the 
			 * bucket. */
			_ld_movetotop(cacheptr, entptr, oldptr, wordhash);
			/* Update the serial so it doesn't expire. */
			entptr->serial = cacheptr->curserial++;
			/* Return to user. */
			return(_ld_dupdefanswer(entptr->answers.danswer));
		}
		oldptr = oldptr->next;
	}

	return(NULL);
}

/* Pull an entry out of the match cache.  This is mostly the same as
 * ld_getdefinecache - see that for more comments.  Some code
 * needs to be factored out between the two. */
struct ld_matchanswer **_ld_getmatchcache(struct ld_conn *conn, char *word) {
    struct ld_cacheinfo *cacheptr;
    struct ld_cacheent *entptr = NULL, *oldptr;
    unsigned int wordhash = _ld_gethash(word, conn->ld_mconncache->buckets);

    cacheptr = conn->ld_mconncache;

	/* See if ismatchcached set quickptr for us. */
	if(cacheptr->quickptr) {
		/* It did. */
		_ld_movetotop(cacheptr, cacheptr->quickptr, cacheptr->oquickptr, wordhash);
		cacheptr->quickptr->serial = cacheptr->curserial++;
		return(_ld_dupmatchanswer(cacheptr->quickptr->answers.manswer));
	}

	oldptr = cacheptr->cachebuckets[wordhash];

	if(!oldptr) return(NULL);

	if(!_ld_qstrcmp(oldptr->word, word)) {
		oldptr->serial = cacheptr->curserial++;
		return(_ld_dupmatchanswer(oldptr->answers.manswer));
	}

    for(entptr = oldptr->next; entptr; entptr = entptr->next) {
        if(!_ld_qstrcmp(entptr->word, word)) {
			_ld_movetotop(cacheptr, entptr, oldptr, wordhash);
			entptr->serial = cacheptr->curserial++;
            return(_ld_dupmatchanswer(entptr->answers.manswer));
		}
		oldptr = oldptr->next;
	}

    return(NULL);
}

/* add the results of a DEFINE to the DEFINE cache. */
void _ld_adddefinecache(struct ld_conn *conn, char *word, struct ld_defanswer **ans) {
	unsigned int wordhash;
	struct ld_cacheent *entptr;

	/* Create a new cache element. */
	entptr = _ld_xmalloc(sizeof(struct ld_cacheent));
	bzero(entptr, sizeof(struct ld_cacheent));

	/* Fill it out with the answer */
	entptr->answers.danswer = _ld_dupdefanswer(ans);
	entptr->word = _ld_xstrdup(word);

	entptr->serial = conn->ld_dconncache->curserial++;

	wordhash = _ld_gethash(word, conn->ld_dconncache->buckets);

	/* Add it to the front of the bucket. */
	entptr->next = conn->ld_dconncache->cachebuckets[wordhash];
	conn->ld_dconncache->cachebuckets[wordhash] = entptr;

	conn->ld_dconncache->objcount++;
#ifdef LD_DEBUGCACHE
	conn->ld_dconncache->stats.adds++;
#endif

	/* Call the garbage collector. */
	_ld_expirycheck(conn->ld_dconncache, LD_True);
}

/* add the results of a MATCH to the MATCH cache.  This is mostly the 
 * same as ld_adddefinecache - see it for more comments.  Some code
 * needs to be factored out here. */
void _ld_addmatchcache(struct ld_conn *conn, char *word, struct ld_matchanswer **ans) {
	unsigned int wordhash;
	struct ld_cacheent *cacheptr;

	cacheptr = _ld_xmalloc(sizeof(struct ld_cacheent));
	bzero(cacheptr, sizeof(struct ld_cacheent));

	cacheptr->answers.manswer = _ld_dupmatchanswer(ans);

	cacheptr->word = _ld_xstrdup(word);
	cacheptr->serial = conn->ld_mconncache->curserial++;
	wordhash = _ld_gethash(word, conn->ld_mconncache->buckets);
	cacheptr->next = conn->ld_mconncache->cachebuckets[wordhash];
	conn->ld_mconncache->cachebuckets[wordhash] = cacheptr;

	conn->ld_mconncache->objcount++;
#ifdef LD_DEBUGCACHE
	conn->ld_mconncache->stats.adds++;
#endif

	_ld_expirycheck(conn->ld_mconncache, LD_False);
};

#ifdef LD_DEBUGCACHE
/* internal debugging function - display cache stats */
void ld_dbg_dispcache(struct ld_cacheinfo *cache) {
	struct ld_cacheent *entptr;
	int i, c;

	printf("%u garbage collections.\n", cache->stats.gcs);
	printf("%u cache adds.\n", cache->stats.adds);
	printf("%u cache removes.\n", cache->stats.removes);
	printf("%u cache hits.\n", cache->stats.hits);
	printf("%u cache misses.\n", cache->stats.misses);
	printf("serial %u, objcount %u, size %u, curgc %u, buckets %u.\n",
		   cache->curserial,
		   cache->objcount,
		   cache->cachesize,
		   cache->curgcbucket,
		   cache->buckets);
	printf("Bucket usage:\n");
	for(i = 0; i<cache->buckets; i++) {
		for(entptr = cache->cachebuckets[i], c=0; entptr; entptr=entptr->next)
			c++;
		printf("[%d] %u\t", i, c);
	}
	printf("\n");
}

/* internal debugging function - display cache stats for both caches. */
void ld_dbg_dispcachestats(struct ld_conn *conn) {
	printf("DEFINE cache:\n");
	ld_dbg_dispcache(conn->ld_dconncache);
	printf("MATCH cache:\n");
	ld_dbg_dispcache(conn->ld_mconncache);
}
#endif /* LD_DEBUGCACHE */
