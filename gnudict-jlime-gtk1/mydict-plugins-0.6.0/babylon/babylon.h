/*
 *  original from
 *
 *  libbab.h -- BabyTrans ( Babylon Translator front-end for GTK )
 *
 *  Copyright (C) 1999  Frederic Jolliton -- <fjolliton@fnac.net>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 */

#ifndef BABYLON_H
#define BABYLON_H

#include <fstream>
#include <list>
#include <vector>
#include <string>

using namespace std ;

#include "../mydict_plugin.h"

#define PATH_SEPARATOR "/"
#define MAX_WORD_LENGTH 63

class babylon : public MydictPlugin
{
public:
   virtual int plugin_init(
   	const int versionno,	   // client support version
	const char client[100],    // client name
	int *plugin_version);  // plugin version
	
   virtual int plugin_lookup(
   	const int dictionary,
   	const char *word,
	const char *match,
	char matchedword[20],
	char matched[10],
	char phonetic[100],
	char translation[65536],
	char rlist[1000]);
   
   virtual int plugin_getDictInfo(
   	const int dictionary,     	/* dictionary */
   	char title[100],       /* title for display */
	char description[1000], /* detail description */
	char type[100],    	/* LOCAL , DICT , WEBDICT ,NONDICT */
	char format[100],  	/* ASCII , BASE64 , UTF-8,UNICODE */
	char fonts[400]);  	/* font+boldfont+phoneticfont+cclibfont+ */

   
   virtual void plugin_debug(
   	int level);  
public:
    struct item {
                            item() { }
                            item( const item& other ) {
            word = other.word ;
            attrib = other.attrib ;
            definition = other.definition ;
        }
        item&               operator=( const item& other ) {
            word = other.word ;
            attrib = other.attrib ;
            definition = other.definition ;
            return *this ;
        }
        string              word ;
        string              attrib ;
        string              definition ;
    } ;
    typedef list< item >
                        container_type ;
private:
	int maxdicts;
    /* System dependant definitions ! */
    typedef unsigned char   u8 ;
    typedef unsigned short  u16 ;
    typedef unsigned long   u32 ;

    bool                ok ;
    ifstream            file_idx ;
    ifstream            file_def ;
    long                word_index( const string& word ) ;
    char                bab_to_char( int c ) ;
    bool                translate_priv( const string& word , container_type& ) ;
    string              read_word( unsigned int length ) ;
    u8                  read_u8( istream& is ) ;
    u16                 read_u16( istream& is ) ;
    u32                 read_u32( istream& is ) ;
    item                make_definition( size_t ) ;

    string              my_path ;
    string              error_msg ;
    void                set_error( const string& err ) {
        error_msg = err ;
    }
	vector<string> mydiclist;
public:
                        ~babylon() ;
    void                set_path( const string& path ) {
        my_path = path ;
    }
    bool                open( const string& filename ) ;
    void                close() ;
    bool                translate( const string& word , container_type& ) ;
    string              get_error() { return error_msg ; }
	void				read_config(const string &path);
} ;

#endif /* BABYLON_H */
