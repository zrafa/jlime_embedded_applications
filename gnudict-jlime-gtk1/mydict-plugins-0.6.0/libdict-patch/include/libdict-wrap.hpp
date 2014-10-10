// libdict.hpp
// sdyoung@well.com
//
// This is the header file for the dictConn C++ wrapper.
// 
//   Copyright (c) 2001, 2002 Steven Young
//
//   Permission is hereby granted, free of charge, to any person obtaining
//   a copy of this software and associated documentation files (the
//   "Software"), to deal in the Software without restriction, including
//   without limitation the rights to use, copy, modify, merge, publish,
//   distribute, sublicense, and/or sell copies of the Software, and to
//   permit persons to whom the Software is furnished to do so, subject to
//   the following conditions:
//
//   The above copyright notice and this permission notice shall be
//   included in all copies or substantial portions of the Software.
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// $History$
// $Log: libdict-wrap.hpp,v $
// Revision 1.4  2002/07/04 00:46:19  sdyoung
// Added support for cache arguments to newconn.
//
// Revision 1.3  2002/03/15 18:43:07  sdyoung
// Added license info to comment block.
//
// Revision 1.2  2002/03/13 21:07:36  sdyoung
// Added strError and getError functions to deal with ld_errno.
//
// Revision 1.1  2002/03/12 18:42:42  sdyoung
// Initial revision
//
extern "C" {
#include "libdict.h"
}

class dictConn {
	public:
		dictConn();
		~dictConn();
		int getRespNo(char *msg);
		bool checkOk(int respno);
		bool newConn(char *host, int port = 0, int timeout = 0, char *client = NULL, int defcachesz = 0, int matchcachesz = 0, bool debug = false);
		bool closeConn();
		bool auth(char *user, char *pw);
		char *getServerInfo();
		struct ld_dbs **getDbs();
		struct ld_dbs **getStrats();
		bool setDb(char *db);
		bool setStrat(char *strat);
		struct ld_defanswer **define(char *word);
		struct ld_matchanswer **match(char *word);
		char *getSrvReply();
		char *strError(int errnum);
		int getError();
	private:
		bool convToBool(ld_bool val);
		ld_bool convToLDBool(bool val);
		struct ld_conn *ldconn;
};

