#include "../mydict_plugin.h"
#include "plugdemo.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <zlib.h>

#include <ctype.h>
#include "dict_engine.h"

const char archivo[] = "dictionary-gcide.txt.gz";

int bufs = 1024;

int offsets[30] = {0, 19284, 2374881, 4406571, 8027889, 10187160, 11668102, 13248030, 14403215, 15759101, 17300062, 17620768, 17919825, 19219912, 21159671, 21844490, 22733526, 25775553, 25976398, 27720800, 31777440, 33719308, 34381624, 35006248, 36010201, 36046258, 36165362};
/* OFFSETS IN THE FILE
19284:A \A\ (named [=a] in the English, and most
2374881:B \B\ (b[=e]) is the second letter of the
4406571:C \C\ (s[=e]) 
8027889:D \D\ (d[=e]) 
10187160:E \E\ ([=e]).  
11668102:F \F\ ([e^]f).  
13248030:G \G\ (j[=e]) 
14403215:H \H\ ([=a]ch), the eighth letter of the
15759101:I \I\ ([imac]).  
17300062:J \J\ (j[=a]).  J is the tenth letter of the
17620768:K \K\, (k[=a]), the eleventh letter of the
17919825:L \L\ ([e^]l) n.  
19219912:M \M\ ([e^]m).  
21159671:N \N\ ([e^]n), the fourteenth letter of
21844490:O \O\ ([=o]).  
22733526:P \P\ (p[=e]), the sixteenth letter of the
25775553:Q \Q\ (k[=u]), the seventeenth letter of the
25976398:R.
27720800:S \S\ ([e^]s), the nineteenth letter of the
31777440:T \T\ (t[=e]), the twentieth letter of the
33719308:U \U\ ([=u]), the twenty-first letter of the
34381624:V \V\ (v[=e]).  
35006248:W \W\ (d[u^]b"'l [=u]), the twenty-third
36010201:X \X\ ([e^]ks).  X, the twenty-fourth letter
36046258:Y \Y\ (w[imac]).  Y, the twenty-fifth letter
36165362:Z \Z\ (z[=e]; in England commonly, and in
*/


void PlugDemo::str_to_lower (char * s) 
{
	int i;
  for(i = 0; s[ i ]; i++)
    s[i] = tolower(s[ i ]);
}


//void PlugDemo::get_pronun (const char *s, char *w, int c)
void PlugDemo::get_pronun (char *s, char *w, int c)
{
        int i = 1;
        char ct;
        char *st;
        st = strchr(s, c);
        while ((c = st[i]) != '\\') {
                w[(i-1)] = c;
                i++;
        }
        w[i-1] = '\0';

}

//FILE *f;
gzFile f;

int PlugDemo::plugin_lookup(const int dictionary,const char *word,const char *imatch,char *rmatch,char *rword,char *ryinbiao,char *rrlist,char *rinformation)
{
	char *res;
	char buf[bufs];
	int not_found, len, i;
	char pronun[80];

	char palabra[80];
	char palabrat[80];
	strncpy(palabra, word, 79);
	this->str_to_lower(palabra);
	strcpy(palabrat, palabra);

	len = strlen(palabra);
	palabra[len] = ' ';
	palabra[len+1] = '\0';
	strcpy(palabrat, palabra);
    	palabra[0] = toupper(palabra[ 0 ]);
	len = strlen(palabra);
//	const char* word = "House";



	int last_empty = 1;

	switch (dictionary)
	{
/*
		case 0:
			printf("palabra:%s\n",word);
			if(strstr(word,"tar")) {
				strcpy(rmatch,"no"); // not matched
				strcpy(rword,"baobao");
				strcpy(ryinbiao,"2'brid3");
				strcpy(rrlist,"tar+gtar+zip+gzip");
				strcpy(rinformation,"normally you mean gtar \n gtar -zxvf baobao.tar.gz");
			}else {
				strcpy(rmatch,"no"); // not matched
				strcpy(rword,"mydict");
				strcpy(ryinbiao,"2'brid3");
				strcpy(rrlist,"hello+I+am+OK");
				strcpy(rinformation,"s我要一本书\n       A student came to see me.");
			}
			break;
*/
		case 0:

	
	not_found = 1;
	if ((palabra[0]>='A') && (palabra[0]<='Z'))
		//fseek(f, offsets[(palabra[0]-64)], SEEK_SET);
		gzseek(f, offsets[(palabra[0]-64)], SEEK_SET);
	else
		//fseek(f, 0, SEEK_SET);
		gzseek(f, 0, SEEK_SET);
	
	//res = fgets(buf, bufs, f);
	res = gzgets(f, buf, bufs);
	
	while ((res != NULL) && (not_found)) {

		if ((buf[0]>='a') && (buf[0]<='z'))
			buf[0] -= 32;	/* convert to UPPER */
		
		if ( ( (last_empty) && (buf[0]>='A') && (buf[0]<='Z') && (buf[0] > palabra[0]) ) ||
		   ( (last_empty) && (buf[1]>='A') && (buf[1]<='Z') && (buf[1] > palabra[1]) )) {
			res = NULL;
			//printf("buf=%s, pal=%s, palt=%s\n", buf, palabra, palabrat);
		} else if ((buf[0] == ' ') || (buf[0] == '\n')) {
			if (buf[0] == '\n') last_empty = 1; else last_empty = 0;
			res = gzgets(f, buf, bufs);
			//printf("PRIMERA-LETRA=%d, buf=%s, pal=%s, palt=%s, len=%d\n", buf[0], buf, palabra, palabrat, len);
		} else if  (! strncmp(buf, palabra, len) ) {
			this->get_pronun(buf, pronun, '\\');
			not_found = 0;
			//printf("PRIMERA-LETRA=%d, buf=%s, pal=%s, palt=%s\n", buf[0], buf, palabra, palabrat);
		} else {
			if (buf[0] == '\n') last_empty = 1; else last_empty = 0;
			//printf("PRIMERA-LETRA=%d, buf=%s, pal=%s, palt=%s, len=%d\n", buf[0], buf, palabra, palabrat, len);
			res = gzgets(f, buf, bufs);
		}

	}

	if (not_found == 0) {
			strcpy(rmatch,"yes"); // not matched
			strcpy(rword,palabra);
			strcpy(ryinbiao,pronun);
			strcpy(rrlist,"hello+I+am+OK");
		
				strcpy(rinformation, buf );
		last_empty = 1;
		res = gzgets(f, buf, bufs);
		if ((buf[0]>='a') && (buf[0]<'z'))
			buf[0] -= 32;	/* convert to UPPER */

		while ( (res != NULL) && ((buf[0] == '\n') || (buf[0] == ' ') ||
			(! strncmp(buf, palabra, len)) || 
			(((buf[0]>='A') && (buf[0]<='Z')) && ( strncmp(buf, palabra, len)) && (! last_empty) ) )) {

			strncat(rinformation, buf, strlen(buf));
			if (buf[0] == '\n') last_empty = 1; else last_empty = 0;
			res = gzgets(f, buf, bufs);
			if ((buf[0]>='a') && (buf[0]<='z'))
				buf[0] -= 32;	/* convert to UPPER */
		
		}


	} else {
			strcpy(rmatch,"yes"); // not matched
			strcpy(rword,word);
			strcpy(ryinbiao,"");
			strcpy(rrlist,"hello+I+am+OK");
			sprintf(rinformation,"Not Found");

	}


//	fclose(f);



/*
			strcpy(rmatch,"yes"); // not matched
			strcpy(rword,word);
			strcpy(ryinbiao,"");
			strcpy(rrlist,"hello+I+am+OK");
			sprintf(rinformation,"lookup %s is a good idea",word);
*/
			break;
		default: // no 
			return 1;
	}
	
  	return 0;
}

int PlugDemo::plugin_getDictInfo(
   					const int  dictionary,
   					char title[100], 
					char description[1000],
					char type[100],
					char format[100],
					char fonts[400])
{
	if(level!=0) // need print
	{
		printf("fetch information for dictionary %d \n",dictionary); 
	}
	switch (dictionary)
	{
//		case 0:
/*
			strcpy(title,"demo_gb"); // not matched
			strcpy(description,
				"it is a sample english-chinese\n"
				"great"
				"Hope it is ok "
				);
			strcpy(type,"SAMPLE");
			strcpy(format,"ASCII");
			strcpy(fonts,"-adobe-times-medium-r-*-*-*-120-*-*-*-*-iso8859-*+-adobe-times-bold-i-*-*-*-180-*-*-*-*-iso8859-*+yb10x20+-cclib-song-delicate-r-normal-*-16-240-*-*-*-*-gb2312.1980-1+");
			break;
*/
		case 0:
			strcpy(title,"en_dict"); // not matched
			strcpy(description,"Jlime Plugin for GNUDict - mydict gtk1 client.\n\n \
HOW TO USE\n \
==========\n \
TAB: change focus\n \
ALT+F4: exit\n \
arrow up/down: up/down\n \
Vol up/down: page up/down\n\n \
ABOUT\n \
=====\n \
This plugin contains the GNU \n \
version of the Collaborative\n \
International Dictionary of English, \n \
formatted for use by the dictionary \n \
server in the dictd package. The GCIDE\n \
contains the full text of the 1913\n \
Webster's Unabridged Dictionary, supplemented\n \
by many definitions from WordNet, the Century\n \
Dictionary, 1906, and many additional\n \
definitions contributed by volunteers.\n \
");
			strcpy(type,"SAMPLE");
			strcpy(format,"ASCII");
			strcpy(fonts,"");

			//f = fopen(archivo, "r");
			f = gzopen(archivo, "r");
			if ( f == NULL) {
				printf("error open dict.txt");
				exit(1);
				//return(1);
			}

			break;
		default: // no 
			return 1;
	}
	return 0;
}
   
void PlugDemo::plugin_debug(int level)
{
	this->level=level;
	return;
}
int PlugDemo::plugin_init(const int versionno,const char *client,int *version)
{
	*version = MYDICTPLUGIN_VERSION;
	if(versionno>MYDICTPLUGIN_VERSION)
	{
		printf("I am old for %s\n it can't be loaded\n",client);
		return 0;
	}
	return 1;
}
MydictPlugin * CreateMydictPlug()
{
   return new PlugDemo;
}
