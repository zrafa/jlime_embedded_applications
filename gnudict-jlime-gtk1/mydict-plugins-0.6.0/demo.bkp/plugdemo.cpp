#include "../mydict_plugin.h"
#include "plugdemo.h"
#include <string.h>
#include <stdio.h>

int PlugDemo::plugin_lookup(const int dictionary,const char *word,const char *imatch,char *rmatch,char *rword,char *ryinbiao,char *rrlist,char *rinformation)
{
	switch (dictionary)
	{
		case 0:
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
		case 1:
			strcpy(rmatch,"yes"); // not matched
			strcpy(rword,word);
			strcpy(ryinbiao,"");
			strcpy(rrlist,"hello+I+am+OK");
			sprintf(rinformation,"lookup %s is a good idea",word);
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
		case 0:
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
		case 1:
			strcpy(title,"sample"); // not matched
			strcpy(description,"it is another sample dictionary");
			strcpy(type,"SAMPLE");
			strcpy(format,"ASCII");
			strcpy(fonts,"");
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
	return 2;
}
MydictPlugin * CreateMydictPlug()
{
   return new PlugDemo;
}
