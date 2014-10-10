/*
 * Original from 
 *  libbab.cc -- BabyTrans ( Babylon Translator front-end for GTK )
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
#include "../mydict_plugin.h"

#include <string.h>

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <list>
#include <cctype>
#include <cerrno>

#ifdef HONOR_STD
using std::istream ;
using std::ostream ;
using std::ifstream ;
using std::endl ;
#endif

#ifdef ENABLE_NLS
#include <libintl.h>
#define _(str) gettext(str)
#else
#define _(str) (str)
#endif
#define N_(str) (str)

#include "babylon.h"

const int MAXDICTS = 5;
const char *diclist[MAXDICTS]={"engtoger.dic","engtoeng.dic","engtoswe.dic","engtofre.dic","engtochs.dic"};

/* some utilities functions */

inline
unsigned long
read_val( istream& is , int n )
{
    unsigned long       r = 0 ;
    for ( int i = 0 ; i < n ; ++ i )
        r |= ( (unsigned long)(unsigned char)is.get() ) << 8*i ;
    return r ;
}

/* Initialisation */
bool
babylon::open( const string& language )
{
    close();

    file_def.open( ( my_path + '/' + language ).c_str() ) ;
    if ( ! file_def.is_open() ) {
        set_error( my_path + '/' + language + ":\n"
                   + strerror( errno ) ) ;
        ok = false ;
        return ok ;
    }
    const char*         file_list[] = {
        "english.dic" , "English.dic" , "ENGLISH.DIC"
    } ;
    int                 i ;
    for ( i = 0 ; i < 3 ; ++ i ) {
        file_idx.open( ( my_path + '/' + file_list[ i ] ) .c_str() ) ;
        if ( file_idx.is_open() )
            break ;
	file_idx.clear() ;
    }
    if ( i == 3 ) {
        set_error( my_path + '/' + file_list[ 0 ] + ":\n"
                   + strerror( errno ) ) ;
        ok = false ;
        return ok ;
    }

    ok = true ;
    return ok ;
}

void
babylon::close()
{
    if ( file_def.is_open() ) {
        file_def.close() ;
    }
    if ( file_idx.is_open() ) {
        file_idx.close() ;
    }
    ok = false ;
}

/* Cleanup */
babylon::~babylon()
{
    close() ;
}

/* Compute a index from word's first 3 characters */
long
babylon::word_index( const string& word )
{
    long                idx = 0 ;
    struct {
        int                 operator()( char c ) {
            if ( c >= 'a' && c <= 'z' )
                return c - 'a' + 2 ;
            if ( c >= 'A' && c <= 'Z' )
                return c - 'A' + 2 ;
            if ( c == '\'' )
                return 1 ;
            return 0 ;
        }
    } char_index ;

    switch( word.size() ) {
    default:
        idx += char_index( word[ 2 ] ) ;
    case 2:
        idx += char_index( word[ 1 ] ) * 28 ;
    case 1:
        idx += char_index( word[ 0 ] ) * 28 * 28;
    case 0:
        break ;
    }
    return idx ;
}

inline
char
babylon::bab_to_char( int c )
{
    return "abcdefghijklmnopqrstuvwxyz* **'*"[ c ] ;
}

string
babylon::read_word( unsigned int length )
{
    static char*        compact_table[] = {
        "<0>" , "ion" , "ies" , "ing" , "ous" , "ses" ,        /*  0 ..  5 */
        "al" , "an" ,                                          /*  6 ..  7 */
        "at" , "ed" , "en" , "er" , "es" , "ia" , "ic" , "ie", /*  8 .. 15 */
        "in" , "io" , "is" , "it" , "le" , "ly" , "ne" , "on", /* 16 .. 23 */
        "or" , "ra" , "se" , "ss" , "st" , "te" , "ti" , "th"  /* 24 .. 31 */
    } ;

    string              def ;
    u16                 data ;

    def.reserve( length ) ;

    while ( length > 0 ) {
        data = read_val( file_def , 2 ) ;
        if ( data < 32768 ) {
            def += bab_to_char( (int)( data & 0x1F ) ) ;
            data >>= 5 ;
            def += bab_to_char( (int)( data & 0x1F ) ) ;
            data >>= 5 ;
            def += bab_to_char( (int)( data & 0x1F ) ) ;
            length -= 3 ;
        } else {
            int                 lsb = (int)( data & 0x7F ) ;
            int                 msb = (int)( ( data >> 8 ) & 0x7F ) ;

            if ( lsb >= 32 ) {
                def += (char)lsb ;
                -- length ;
            } else if ( lsb >= 6 ) {
                def += compact_table[ lsb ] ;
                length -= 2 ;
            } else {
                def += compact_table[ lsb ] ;
                length -= 3 ;
            }
            if ( length == 0 )
                break ;
            if ( length < 0 ) {
#ifdef DEBUG
                warn( "buffer underflow" ) ;
#endif
                return string() ;
            }

            if ( msb >= 32 ) {
                def += (char)msb ;
                -- length ;
            } else if ( msb >= 6 ) {
                def += compact_table[ msb ] ;
                length -= 2 ;
            } else {
                def += compact_table[ msb ] ;
                length -= 3 ;
            }
        }
    }
    return def ;
}

/* Make a new definition node */
/* pos indicate the position of the definition in file_def file */
babylon::item
babylon::make_definition( size_t pos )
{
    item                def ;

    file_def.seekg( pos ) ;

    def.attrib.erase() ;
    for ( int i = 0 ; i < 7 ; ++ i ) {
        int                 v = (int)read_val( file_def , 1 ) ;
        def.attrib += "0123456789ABCDEF"[ v/16 ] ;
        def.attrib += "0123456789ABCDEF"[ v%16 ] ;
    }

    int                 sz = (int)read_val( file_def , 1 ) ;

    def.word = read_word( sz ) ;

    sz = (int)read_val( file_def , 1 ) ;
#ifdef DEBUG
    if ( sz == 0 )
        warn( "Null definition" ) ;
#endif

    int                 mask = 0 ;
    int                 c = 0 ;
    int                 prev_c ;

    string              definition ;

    while ( sz > 0 ) {
        prev_c = c ;
        c = (int)read_val( file_def , 1 ) ^ mask ;
        mask ^= 0x80 ;
        if ( c == 0 )
            continue ;
        if ( prev_c == 0x7D ) {
            if ( c == 0XEF ) {
                definition += ",  " ;
                sz -= 3 ;
            } else {
                definition += prev_c ;
                definition += c ;
                sz -= 2 ;
            }
        } else if ( prev_c == 0x7F ) {
            if ( c == 0xEF ) {
                definition += ". " ;
                sz -= 3 ; // Considered as 3 chars.. Hum..
            }
        } else if ( prev_c == 0xFF ) {
            if ( c == 0xF3 ) { // [FF F3]
                definition += "..;" ;
            } else if ( c == 0xEF ) { // [FF EF]
                definition += ".. " ;
            } else if ( c == 0xFF ) { // [FF FF]
                definition += "..." ;
            }
            sz -= 3 ;
            c = 0 ; // 'clear previous char'
        } else if ( prev_c == 0xFB ) {
            if ( c == 0xFF ) {
                definition += ".." ;
                sz -= 3 ; // Considered as 3 chars.. Hum..
                c = 0 ; // 'clear previous char'
            } else {
                definition += prev_c ;
                definition += c ;
                sz -= 2 ;
            }
            continue ;
        } else if ( c == 0xFB || c == 0xFF || c == 0x7D || c == 0x7F ) {
            ; /* wait */
        } else {
            definition += c ;
            -- sz ;
        }
    }
    def.definition = definition ;
    return def ;
}

bool
babylon::translate_priv( const string& word , list< babylon::item >& lst )
{
    long                main_index ;
    u32                 idx_idx , idx_def ;
    int                 wc ;
    size_t              byte_to_skip ;
    int                 c ;

    /* 1) Compute main index .. */

    main_index = 100 + 4 * word_index( word ) ;

    /* 2) .. then seek to both file */

    file_idx.seekg( main_index ) ;
    file_def.seekg( main_index ) ;

    /* 3) Read corresponding indexes */

    idx_idx = read_val( file_idx , 4 ) ;
    idx_def = read_val( file_def , 4 ) ;
    if ( idx_def == read_val( file_def , 4 ) ) {
#ifdef DEBUG
        warn( "No prefix index\n" ) ;
#endif
        return true ;
    }

    file_idx.seekg( idx_idx ) ;

    size_t              min_size , max_size ;
    min_size = (int)read_val( file_idx , 1 ) ;
    max_size = (int)read_val( file_idx , 1 ) ;

    if ( ( word.size() < min_size ) || ( word.size() > max_size ) ) {
		std::cout << "No word of this size\n" ;
        return true ;
    }

    u16             nw ; /* number of word */

    wc = 0 ;
    byte_to_skip = 0 ;
    for ( size_t i = min_size ; i < word.size() ; ++ i ) {
        nw = (int)read_val( file_idx , 2 ) ;
        wc += nw ;
        byte_to_skip += ( i - 3 ) * nw ;
    }
    nw = (int)read_val( file_idx , 2 ) ;
    byte_to_skip += ( max_size - word.size() ) * 2 ;

    file_idx.seekg( byte_to_skip , ifstream::cur ) ;

    /* Search word index */

    for ( int i = 0 ; i < (int)nw ; ++ i ) {
        string::size_type   j ;
        for ( j = 3 ;
	      j < word.size()
              && word[ j ] == file_idx.get() ;
              ++ j )
	    ;
        if ( j == word.size() ) {
            u32 def ;
            file_def.seekg( idx_def + 4 * wc ) ;
            def = read_val( file_def , 4 ) ;

            if ( def & 0xFF000000UL ) { /* Another definition reference */
                main_index = 100 + 4 * ( ( def >> 16 ) & 0xFFFF ) ;
                file_def.seekg( main_index ) ;
                idx_def = read_val( file_def , 4 ) ;

                file_def.seekg( idx_def + 4 * ( def & 0xFFFF ) ) ;
                def = read_val( file_def , 4 ) ;
            }
            item                current = make_definition( def ) ;
            lst.push_back( current ) ;
        } else {
            /* A character has been read without j incremented */
            file_idx.seekg( word.size() - j - 1 , ifstream::cur ) ;
        }
        ++ wc ;
    }

    return true ;
}

bool
babylon::translate( const string& word , list< babylon::item >& lst )
{
    if ( ! ok ) {
        set_error( _( "libbab incorrectly initialized" ) ) ;
        return false ;
    }

    string              trimed_word ;
    string::size_type   beg , end ;
    beg = word.find_first_not_of( " \t\n" ) ; /* FIXME: add vertical tab ? */
    if ( beg == string::npos ) {
        set_error( _( "Invalid word" ) ) ;
        return false ;
    }
    for ( end = beg ; isalpha( word[ end ] ) || word[ end ] == '\'' ; ++ end )
        ;
    if ( end != word.size()
         && word[ end ] != ' '
         && word[ end ] != '\t'
         && word[ end ] != '\n' ) {
        set_error( _( "Invalid word" ) ) ;
        return false ;
    }
    trimed_word = word.substr( beg , end - beg ) ;

#if DEBUG
    print_var( trimed_word ) ;
#endif

    if  ( trimed_word.size() >= MAX_WORD_LENGTH ) {
#if 0
        set_error( "Word is tool long" ) ;
        return false ;
#endif
        lst.clear() ;
        return true ;
    }

    for ( size_t i = 0 ; i < trimed_word.size() ; ++ i )
        trimed_word[ i ] = tolower( trimed_word[ i ] ) ;

	while ( trimed_word.size() < 3 )
		trimed_word += '_' ;

    return translate_priv( trimed_word , lst ) ;
}
int babylon::plugin_lookup(const int dictionary,const char *word,const char *imatch,char *rmatch,char *rword,char *ryinbiao,char *rrlist,char *rinformation)
{
	strcpy(ryinbiao,"");
	strcpy(rrlist,"");
	strcpy(rinformation,"");
	strcpy(rword,word);
	strcpy(rmatch,"no");
	if(dictionary>=maxdicts)
	{
		strcpy(rinformation,"dic not found");
		return 1;
	}

	this->open(mydiclist[dictionary]) ;
	
    babylon::container_type
                        lst ;
    if ( ! this->translate( string( word ) , lst ) )
	{
		strcpy(rinformation,"not found");
	    return 1;
	}
	string str;

    for ( babylon::container_type::const_iterator
          it = lst.begin() ;
          it != lst.end() ;
          ++ it ) {
		str = "- "+ it->word 
			+ ":\n";
		// fix a bug for handling chinese
		// add 0x80 for every second byte.  
		if(mydiclist[dictionary].find("tochs")!=string::npos){	
			for(int i=0;i<it->definition.length();i++){
				str+=it->definition[i++];
				if(i<it->definition.length())
					str+=it->definition[i]+128;
			}
		}else {
			str += it->definition;
		}
		str+= "\n";
		
		strcat(rinformation,str.c_str());
    }	
	
	strcpy(rmatch,"yes");
	return 0;
}
int babylon::plugin_getDictInfo(
   					int  dictionary,
   					char title[100], 
					char description[1000],
					char type[100],
					char format[100],
					char *fonts)
{
	if(dictionary<maxdicts) 
	{
		strcpy(title,mydiclist[dictionary].c_str());
		char *pos=strchr(title,'.');
		*pos='\0';
		strcpy(fonts,"-adobe-times-medium-r-*-*-*-120-*-*-*-*-iso8859-*+");
		strcat(fonts,"-adobe-times-bold-i-*-*-*-180-*-*-*-*-iso8859-*+");
		if(mydiclist[dictionary].find("tochs")!=string::npos)
		{
			strcat(fonts,"yb10x20+");
			strcat(fonts,"-cclib-song-delicate-r-normal-*-16-240-*-*-*-*-gb2312.1980-1+");
		}
		strcpy(format,"ASCII");
		strcpy(type,"BABYLON");
		strcpy(description,
			"\n Mydict babylon plugins , developed by Larry \n\n"
			" Library (libbab) from http://fjolliton.free.fr/babytrans/ \n"
			" Dictionaries from http://futureware.at/equick.htm\n"
			" Babylon is copyright of http://www.babylon.com \n\n"
			" ==> current dict : "
			);
		strcat(description,mydiclist[dictionary].c_str());
	}
	return 0;
}
void babylon::plugin_debug(int level)
{
	cout << "Set debug level "<< level << endl;
	return; 
}
void babylon::read_config(const string &pluginpath)
{
	ifstream cfg;
	string line;
    cfg.open( ( pluginpath + '/' + "babylon.ini" ).c_str() ) ;
    if (cfg.is_open() ) {
		while(!cfg.eof()) {
			cfg >> line;
			if(string::npos!=line.find("database=")){
				this->set_path(line.substr(9));
			}else if(string::npos!=line.find("dictionary=")) {
				mydiclist.push_back(line.substr(11));
			}
			line=""; // remove dupicate ??
		}
	}else{ // open .ini config failed 
		this->set_path(pluginpath + "/../babylon");
		for(int i=0;i<MAXDICTS;i++) {
			if(this->open(diclist[i])) {
				mydiclist.push_back(diclist[i]);
			}else {
				cout << "== babylon's dictionary "
					 << diclist[i]	 
					 << " is not valid" << endl;	
			}
		}
	}
	maxdicts=mydiclist.size();
	return ;
}
	
int babylon::plugin_init(const int versionno,const char *client,int *version)
{
	*version = MYDICTPLUGIN_VERSION;
	if(versionno>MYDICTPLUGIN_VERSION)
	{
		cout << "I am old " << endl;
		return 0;
	}
	read_config(client);

	return this->maxdicts;
}
MydictPlugin * CreateMydictPlug()
{
   return new babylon;
}

#ifdef TEST
int main( int argc , char * argv[] )
{
    if ( argc < 2 ) {
        cout << "Usage: " << argv[ 0 ] << " word" << endl ;
        return EXIT_FAILURE ;
    }

    babylon             bab ;
    bab.set_path( "/usr/share/mydict/babylon" ) ;
	
	if(argc>2) {
	    bab.open(argv[2]) ;
	}else {
		bab.open("engtoeng.dic" ) ;
	}
    babylon::container_type
                        lst ;
    if ( ! bab.translate( string( argv[ 1 ] ) , lst ) )
    return EXIT_FAILURE ;
    for ( babylon::container_type::const_iterator
          it = lst.begin() ;
          it != lst.end() ;
          ++ it ) {
        cout << "- " << it->word ;
#ifdef WANT_ATTRIB
        cout << "(" << it->attrib << ")" ;
#endif
    cout << ":\n" ;
        cout << it->definition << '\n' ;
    cout << endl ;
    }

    return 0 ;
}
#endif
