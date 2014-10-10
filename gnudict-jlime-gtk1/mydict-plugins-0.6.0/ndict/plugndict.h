#ifndef _PLUGNDICT_H_
#define _PLUGNDICT_H_

#include "../mydict_plugin.h"

class PlugNdict : public MydictPlugin
{
  private:
	int level;
	char pluginpath[100];
	
	int maxdicts;
	char title[20][100];
	char desc[20][1000];
	char format[20][20];
	char type[20][20];
	char fixedfont[20][100];
	char boldfont[20][100];
	char phoneticfont[20][100];
	char c128font[20][100];
	char dictfile[20][100];
  public:
  	PlugNdict() {level=0;maxdicts=0;}
	void read_config(const char *);
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
