
#include "../mydict_plugin.h"
#include "rfc2229.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h> // for atoi()
#include <ctype.h>
#include <errno.h>
#include <unistd.h>
#include "libdict-wrap.hpp"

class dictConn dc;

int PlugRFC2229::plugin_lookup(const int dictionary,const char *word,const char *imatch,char *rmatch,char *rword,char *ryinbiao,char *rrlist,char *rinformation)
{	
	char *dict=(char *)NULL;

	struct ld_defanswer **defs;
	struct ld_matchanswer **ms;

	int idx = 0;
	char compare[100]="";
	char dword[1000]=""; 
//	printf("connect to %s on %d\n",server,port);

	strcpy(rword,word);
	strcpy(rmatch,"no");
	strcpy(rinformation,"");
	strcpy(ryinbiao,"");
	strcpy(rrlist,"");
//	printf("[word]%s\n[list]%s\n",rword,rrlist);
	if(dc.newConn((char *)server, port, timeout, NULL, false) == false) {
		strcpy(rinformation,"Unable to connect to server.\n");
		return 1;
	}
	if(dictionary < dictTotalDb)
		dict = dblist[dictionary]->ld_dbname;
//	printf( "Server info: %s\n",dc.getServerInfo());
	if(dict) {
		if(!dc.setDb(dict)) {
			printf( "Invalid database specified.\n");
			return 1;
		}
	}
	dc.setStrat("prefix");
	sprintf(dword,"\"%s\"",word); // carbon paper should be "carbon paper"
	if(!(defs = dc.define((char *)dword))) {
		;
	} else {
		strcpy(rmatch,"yes");
		strcpy(rinformation,"");
		idx = 0;
		while(defs[idx]) {
//			printf( "Word: %s (%s) \n",defs[idx]->ld_answord, defs[idx]->ld_ansdict);
//			printf( "Definition: \n%s\n\n", defs[idx]->ld_ansdef );

//			strcat(rinformation,"From dictionary: ");
//			strcat(rinformation,defs[idx]->ld_ansdict);
//			strcat(rinformation,"\n");
//			strcat(rinformation,"Definition: \n");
			if(defs[idx]->ld_ansdef) // avoid NULL
				strcat(rinformation,defs[idx]->ld_ansdef);
			strcat(rinformation,"\n\n");
			
			idx++;
		}
	}	
	if(!(ms = dc.match((char *)dword))) {
		strcat(rinformation,"no macthed \n");
	} else {
	
		idx = 0;
		
		while(
			ms[idx] 
			&& (idx<11) 
			&& (strlen(rrlist)+strlen(ms[idx]->ld_answord) < 1000) 
			) {
//			printf( "Word: %s (%s) \n",ms[idx]->ld_answord, ms[idx]->ld_ansdict);
			if(strcmp(compare,ms[idx]->ld_answord))
			{
				strcpy(compare,ms[idx]->ld_answord);
				strcat(rrlist,ms[idx]->ld_answord);
				strcat(rrlist,"+");
			}
			idx++;
		}
		if(strlen(rrlist)>1)
			rrlist[strlen(rrlist)-1]='\0';
	}	
//	printf("[word]%s\n[list]%s\n[info]%s\n",rword,rrlist,rinformation);
	return 0;
}
int PlugRFC2229::plugin_getDictInfo(
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
	if(dictionary<dictTotalDb)
	{
		strcpy(title,dblist[dictionary]->ld_dbname); // not matched
		sprintf(description,"\n\nDICT database (connect to %s:%d)\n\n %s\n",
			server,port, dblist[dictionary]->ld_dbdesc);
		strcpy(type,"DICT");
		if(!strstr(dblist[dictionary]->ld_dbdesc,"Freedict")) {
			strcpy(format,"ASCII");
			strcpy(fonts,"-adobe-courier-medium-r-*-*-*-120-*-*-*-*-iso8859-*+");
			strcat(fonts,"-adobe-times-bold-i-*-*-*-180-*-*-*-*-iso8859-*+");
		}
		else {
			strcpy(format,"UTF-8");
			strcpy(fonts,"-adobe-courier-medium-r-*-*-*-120-*-*-*-*-iso8859-*+");
			strcat(fonts,"-adobe-times-bold-i-*-*-*-180-*-*-*-*-iso8859-*+");
		}
	}else {
		return 1;
	}
}
   
void PlugRFC2229::plugin_debug(int level)
{
	this->level=level;
	return;
}

void PlugRFC2229::read_config(const char *path)
{
	FILE *fp;
	char config[300];
	char line[1000];
	char *list[2];
	sprintf(config,"%s/rfc2229.ini",path);
	
	if((fp=fopen(config,"r"))==NULL) {
		return;
	}
	char *pos;
	while(!feof(fp)) {
		fgets(line,1000,fp);
		if(feof(fp)) continue;
		line[strlen(line)-1]='\0'; /* remove \n */
//		printf("%s\n",line);
		if( (line[0]=='#') || (line[0]==' '))
			continue;
		if((pos=strchr(line,'='))==NULL)
			continue;
		list[0]=line;
		list[1]=pos+1;
		*pos='\0';
		if(list[0]!=NULL && list[1]!=NULL)  {
//			printf("%s : [%s] \n",list[0],list[1]);
			
			if(!strcmp(list[0],"host")) {
				strcpy(server,list[1]); 
			}else if(!strcmp(list[0],"port")) {
				if(atoi(list[1])>2)
					port=atoi(list[1]);
			}else if(!strcmp(list[0],"timeout")) {
				if(atoi(list[1])>0)
					timeout=atoi(list[1]);
			}			
		}
	}
}
int PlugRFC2229::plugin_init(const int versionno,const char *path,int *version)
{
	int i=0;

	read_config(path);
	
	printf("Checking dictd server %s, port %d, timeout %d\n", server, port, timeout);
	if(dc.newConn((char *)server, port, timeout, NULL, false) == false) {
		printf(" Please check dictd server %s on port %d.\n",server,port);
		printf(" or change the code if you want to connect to www.dict.org\n");
		printf(" it will be fixed later \n");
		return 0;
	}
//	printf("Server info: %s\n",dc.getServerInfo());
	dblist = dc.getDbs();
	if(dblist==NULL) 
	{
		printf(" I can't fetch db list from dictd server %s on port %d.\n",server,port);
		return 0;
	}
    while(dblist[i]) {
        i++;
        if(i>10) break; // BUG, only 10 dictonary are allowed here
    }
	dictTotalDb = i;
	*version = MYDICTPLUGIN_VERSION;
	return dictTotalDb;
}
MydictPlugin * CreateMydictPlug()
{
   	return new PlugRFC2229();
}
