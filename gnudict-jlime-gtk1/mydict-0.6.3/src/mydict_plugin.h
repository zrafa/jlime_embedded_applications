#ifndef __MYDICT_PLUG_H
#define __MYDICT_PLUG_H

// Created by Larry <caiyu@yahoo.com>
// see http://sourceforge.net/projects/gnudict
//

#ifdef __cplusplus
extern "C" {
#endif

#define MYDICTPLUGIN_VERSION 1
//----------------------------------------------------------------------------
class MydictPlugin
{
  public:
   /*
   	plugin_init main send the client version to plugins , 
	and get plugins version to check whether they can support each.
   */
   virtual int plugin_init(
   	const int versionno,	   // client support version
	const char path[100],    // plugin path
	int *plugin_version)=0;  // plugin version
	
   virtual int plugin_lookup(
   	const int dictionary,
   	const char *word,
	const char *match,
	char matchedword[20],
	char matched[10],
	char phonetic[100],
	char translation[65536],
	char rlist[1000])=0;
   
   virtual int plugin_getDictInfo(
   	const int dictionary,     	/* dictionary */
   	char title[100],       /* title for display */
	char description[1000], /* detail description */
	char type[100],    	/* LOCAL , DICT , WEBDICT ,NONDICT */
	char format[100],  	/* ASCII , BASE64 , UTF-8,UNICODE */
	char fonts[600])=0;  	/* font+boldfont+phoneticfont+cclibfont+ */

   
   virtual void plugin_debug(
   	int level)=0;
};

//----------------------------------------------------------------------------
// This is the plugin function each plugin overrides for the main app to
// create an instance of the plugin child class.
extern MydictPlugin * CreateMydictPlug();
//----------------------------------------------------------------------------
typedef MydictPlugin * (*CREATEPLUG_PROC)();
//----------------------------------------------------------------------------
#ifdef __cplusplus
}
#endif
//----------------------------------------------------------------------------
#endif
//----------------------------------------------------------------------------
