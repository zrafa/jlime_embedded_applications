#ifndef _PLUGRFC2229_H_
#define _PLUGRFC2229_H_
#include <string.h>
#include "../mydict_plugin.h"

class PlugRFC2229 : public MydictPlugin
{
  private:
  	int level;
	char server[100]; 
	int port;
	int timeout;

	int dictTotalDb;
	struct ld_dbs **dblist;
  public:
  	PlugRFC2229(char *defserver="localhost",int defport=2628) {level=0;strcpy(server,defserver);port=defport;dictTotalDb=0;timeout=0;}
	void read_config(const char *path);
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
};
#endif
