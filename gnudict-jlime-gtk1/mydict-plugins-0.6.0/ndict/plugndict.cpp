#include "../mydict_plugin.h"
#include "plugndict.h"
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdio.h>

int check_yindiao(char *word, int len)
{
  int i, flag=0;

  for(i = 0; i < len; i++) {
    if(isdigit(word[i])) break;
  }
  
  if(i != len) flag = 1;
  else flag = 0;

  return (flag);
}

void erase_yindiao(char *str, int len)
{
  int i, j;
  char buffer[100];

  j = 0;
  for(i = 0; i < len; i++) {
    if(!isdigit(str[i])) {
      buffer[j] = str[i];
      j++;
    }
  }
  buffer[j] = '\0';
  strcpy(str, buffer);
}
      
void add_info(char *dest_str, char *str, int len)
{
  char *ptr;

  ptr = strstr(str, " ///");
  *ptr = '\0';
  
//  strcat(dest_str, "\n");
  strcat(dest_str, &ptr[5]);
}

int find_in_C_E_dic(FILE *fp, char *word, char *sword, char *match, char *line)
{
  int i, found, cmp, sec_cmp, len;
  char line1[65535], foundword[65535], *p1;
  char firstword[5000], firstline[5000];
  int  yindiao_flag = 0, single_flag = 0;

  yindiao_flag = check_yindiao(word, strlen(word));
  
  found = 0;
  while(!feof(fp)) {
    fgets(line1, 65535, fp);
    strcpy(line, line1);

    p1 = strstr(line1, " ///");
    if(p1 == NULL) {
      fprintf(stderr, "%s Dict format error\n",line1);
      continue;
    }
    *p1 = '\0';

    strcpy(firstword, word);
    p1 = strstr(firstword, " ");
    if(p1 == NULL) single_flag = 1;
    else  *p1 = '\0';

    if(yindiao_flag == 0) 
      erase_yindiao(line1, strlen(line1));
 
    strcpy(firstline, line1);
    p1 = strstr(firstline, " ");
    if(p1!=NULL) *p1 = '\0';

    cmp = strcasecmp(firstword, firstline);
    if(cmp) {
      if(cmp > 0) continue;
      if(cmp < 0) break;
    }
    else {
      sec_cmp = strcasecmp(word, line1);
      if(!sec_cmp) {
        if(!found) {
          found = 1;
          strcpy(foundword, line);
        }
        else add_info(foundword, line, strlen(line));
        continue;
      }
    }
  }

  if(found == 1) {
    strcpy(line, foundword);
  }

  strcpy(line1, line);
  p1 = strstr(line1, " ///");
  *p1 = '\0';
  strcpy(sword, line1);

  strcpy(line, &p1[5]);

  if(found == 1)
    strcpy(match, "yes");
  else strcpy(match, "no");

  len = strlen(line);
  for(i=0; i<len; i++) {
    if ( (line[i] == '\\') && (line[i+1] == 'n') ) {
      line[i] = ' ';
//      line[i+1] = '\n';
      line[i+1] = ' ';
    }
  }

  return 1;
}
  
void adjudgement_word(char *str, int len)
{
  for(;;) {
    if(!isalpha(str[len-1]) && !isdigit(str[len-1])) {
      len--;
      str[len] = '\0';
    }
    else break;
  }
}

int PlugNdict::plugin_lookup(const int dictionary,const char *oword,const char *imatch,char *rmatch,char *rword,char *ryinbiao,char *rrlist,char *rinformation)
{
  FILE *fp;
  char indexfile[150];
  char ind[1000][3];
  long pos[1000], pos1, pos2;
  int i = 0, found, total, head, tail, middle=0;
  int notfound, cmp, len;
  char line[65535], line1[65535], foundword[65535], *p1,*p2;
  char match[5], sword[100];
  char yinbiao[100] = " ", lists[11][100];
  char rlist[1000]="";
  int Re_value = 0;
  char dictname[200];
  char word[200];
  
  // change to lower case for the original word
  	for(i=0;i<strlen(oword);i++)
  		word[i]=tolower(oword[i]);
	word[i]='\0';
	
	
  if(this->level>0)
	  printf("welcome , request for %s on dictionary %d \n",word,dictionary); 
  for(i = 0; i < 11; i++) {
     memset(lists[i], 0, sizeof(char)*100);
     lists[i][0]='\0';
  }
  strcpy(rmatch,"");
  strcpy(rword,"");
  strcpy(ryinbiao,"");

  if (dictionary >= maxdicts || dictionary < 0) { 
//  	printf("%d ,%d : %s\n",dictionary,maxdicts,word);
  	strcpy(rinformation,"Incorrect dictionary");
    return 0;
  }
  strcpy(dictname,dictfile[dictionary]);
  strcpy(indexfile,dictname);
  strcat(indexfile, ".index");
  fp = fopen(indexfile, "r");
  if(fp == NULL){
  	sprintf(rinformation,"can't open indexfile %s , check config file",indexfile);
    return 0;
  }

  i = 0;
  while(!feof(fp)) {
    fgets(line, 256, fp);
    p1 = strchr(line, '\t');
    ind[i][0] = p1[1];
    ind[i][1] = p1[2];
    ind[i][2] = '\0';
    pos[i] = atol(&p1[4]);
    i++;
  }
  fclose(fp);
  total = i - 1;

  found = 0;
  head = 0;
  tail = total;
  while (head <= tail) {
    middle = (head + tail)/2;
    if(ind[middle][0] > word[0]) tail = middle - 1;
    else if (ind[middle][0] < word[0]) head = middle + 1;
    else {
      if(ind[middle][1] > word[1]) tail = middle - 1;
      else if (ind[middle][1] < word[1]) head = middle + 1;
      else {
        found = 1;
        break;
      }
    }
  }
  
  pos1 = pos[middle];
  pos2 = pos[middle + 1];

  line[0] = '\0';

	char aword[100];
	strcpy(aword,word);
//  printf("before adj %s \n",aword);	
  adjudgement_word(aword, strlen(aword)); // erase the useless char at the end of word

  fp = fopen(dictname, "r");
  if (fp == NULL) {
    return 0;
  }

  fseek(fp, pos1, SEEK_SET);
//printf("file %s\n",dictfile[dictionary]);
  if(strstr(dictfile[dictionary],"cedict.txt")) { // last one , chinese - english
//  	printf("then .. [%s]\n",aword);
//	printf("  len :%d\n",strlen(aword));
  	if(aword==NULL || aword[0]=='\0') { // input chinese ? 
    	strcpy(rrlist,rlist);
    	strcpy(rinformation,"Please input Yin Biao to look up instead \nÇëÊäÈëÒô±ê²éÕÒ\n");	
		return 0;
	}
		
    Re_value = find_in_C_E_dic(fp, aword, sword, match, line);
    fclose(fp);
    strcpy(rmatch,match);
    strcpy(rword,word);
    strcpy(ryinbiao,yinbiao);
    strcpy(rrlist,rlist);
    strcpy(rinformation,line);
	if(this->level>0)
	 	printf(" [%s][%s][%s]\n",rword , ryinbiao , rinformation);
	return 0;
  }

  found = 0;
  notfound = 0;
  i = 0;
  while(!feof(fp)) {
    fgets(line1, 65535, fp);
    strcpy(line, line1);

    p1 = strstr(line1, " ///");
    if(p1 == NULL) {
      fprintf(stderr, "[%s] Dict format Error\n",line1);
      return 0;
    }
    *p1 = '\0';
  
    if(found == 0) {
      if(notfound && i < 11) {
        strcpy(lists[i], line1);
        i++;
        continue;
      }
      else if(notfound && i >= 10) break;
    }
    
    cmp = strcasecmp(word, line1);
    if(cmp) {
      if(cmp < 0) {
        if((!found) && (!notfound)) {
          notfound = 1;
          strcpy(lists[i], line1);
          strcpy(foundword, line);
          if (i > 5) {
            int j = 0;
            for(j=0; j<6; j++)
              strcpy(lists[j], lists[j+i-5]);
            i = j - 1;
          }
          i++;
          continue;
        }
      }
      if((found == 0) && (i >= 11)) i = 0;
      strcpy(lists[i], line1);
      if( (found == 1) && (i >= 10)) break;
      i++;
    }
    else {
      found = 1;
      strcpy(foundword, line);
      strcpy(lists[i],line1);
      if(i > 5) {
        int j;
        for(j = 0; j < 6; j++)
          strcpy(lists[j], lists[j+i-5]);
        i = j - 1;
      }
      i++;
      continue;
    }
  }
  fclose(fp);

//  fprintf(stderr, "%s\n", line);
  if(found == 1 || notfound == 1) {
    strcpy(line1, foundword);
    strcpy(line, foundword);
  }

  p1 = strstr(line1, " ///");
  *p1 = '\0';
  strcpy(sword, line1);

  strcpy(line, &p1[5]);
  
// Searching YinBiao start
// Format /// \...\ \\n */
  strcpy(line1,line);
  yinbiao[0]=' ';
  yinbiao[1]='\0';
  if(line1[0]=='\\') {
  	p1 = strstr(line1,"\\ \\n");
	if(p1!=NULL) {
		p2=&line1[0];
		if( (p1-p2) < 50 ) {
			*p1='\0';
			p2=p1+4;
			strcpy(yinbiao,&line1[1]);
			strcpy(line,p2);
		}
//		else {
//			yinbiao[0]='A';
//		}
	}
//	else {
//			yinbiao[0]='B';
//	}
// }else {
//			yinbiao[0]='C';

  }
  
// Searching Yinbiao end.

  if(found == 1) 
    strcpy(match, "yes");
  else strcpy(match, "no");

  len = strlen(line);
  for(i = 0; i < len; i++) {
    if ( (line[i] == '\\') && (line[i+1] == 'n') ) {
      line[i] = ' ';
      line[i+1] = '\n';
    }
  }
//  fprintf(stderr, "%s", line);

  strcpy(rmatch,match);
  strcpy(rword,sword);
  strcpy(ryinbiao,yinbiao);
  strcpy(rrlist,rlist);
  strcat(rrlist,lists[0]);
  for(i = 1; i < 11; i++) {
  	strcat(rrlist,"+");
   	strcat(rrlist,lists[i]);
  }
  strcpy(rinformation,line);
//  if(level>0)
// 	 printf(" %s,%s,%s \n",rword , ryinbiao , rinformation);
  return 0;
}
void PlugNdict::read_config(const char *path)
{
	FILE *fp;
	char config[300];
	char line[1000];
	char *list[2];
	sprintf(config,"%s/plugndict.ini",path);
	
	if((fp=fopen(config,"r"))==NULL) {
		return ;
	}
	int i=0;
	char *pos;
	int status=0;
	while(!feof(fp)) {
		fgets(line,1000,fp);
		if(feof(fp)) continue;
		line[strlen(line)-1]='\0'; /* remove \n */
//		printf("%s\n",line);
		if( (line[0]=='#') || (line[0]==' '))
			continue;
		if((line[0]=='=') && (strstr(line,"DICT"))) {
			if(status==0)
				status=1;
			else 
				i++;
			strcpy(desc[i],"");
			continue;
		}
		if((pos=strchr(line,'='))==NULL)
			continue;
		list[0]=line;
		list[1]=pos+1;
		*pos='\0';
		if(list[0]!=NULL && list[1]!=NULL)  {
//			printf("%s : [%s] \n",list[0],list[1]);
			
			if(!strcmp(list[0],"fixedfont")) {
				strcpy(fixedfont[i],list[1]); 
			}else if(!strcmp(list[0],"boldfont")) {
				strcpy(boldfont[i],list[1]);
			}else if(!strcmp(list[0],"phoneticfont")) {
				strcpy(phoneticfont[i],list[1]);
			}else if(!strcmp(list[0],"c128font")) {
				strcpy(c128font[i],list[1]);
			}else if(!strcmp(list[0],"title")) {
				strcpy(title[i],list[1]);
			}else if(!strcmp(list[0],"type")) {
				strcpy(type[i],list[1]);
			}else if(!strcmp(list[0],"format")) {
				strcpy(format[i],list[1]);
			}else if(!strcmp(list[0],"file")) {
				strcpy(dictfile[i],list[1]);
			}else if(!strcmp(list[0],"desc")) {
				strcat(desc[i],list[1]);
				strcat(desc[i],"\n");
			}				
		}
	}
//	printf(" total %d \n",i+1);
//	printf(" %s\n",desc[i]);
	maxdicts=i+1;
}
int PlugNdict::plugin_getDictInfo(
   					int  dictionary,
   					char title[100], 
					char description[1000],
					char type[100],
					char format[100],
					char *fonts)
{
	if(dictionary<maxdicts) 
	{
		strcpy(title,this->title[dictionary]);
		sprintf(fonts,"%s+%s+%s+%s+",
			this->fixedfont[dictionary],
			this->boldfont[dictionary],
			this->phoneticfont[dictionary],
			this->c128font[dictionary]);
		strcpy(format,this->format[dictionary]);
		strcpy(type,this->type[dictionary]);
		strcpy(description,
			"\n Mydict ndict plugins , developed by Larry & Niu\n\n");
		strcat(description,this->desc[dictionary]);
	}
	return 0;
}
   
void PlugNdict::plugin_debug(int level)
{
	this->level=level;
	printf("Set debug level %d\n",this->level);
	return; 
}
int PlugNdict::plugin_init(const int versionno,const char *client,int *version)
{
	*version = MYDICTPLUGIN_VERSION;
	if(versionno>MYDICTPLUGIN_VERSION)
	{
		printf("I am old for %s\n, it can't be loaded",client);
		return 0;
	}
	if(client==NULL) 
	{
		printf(" please use the new version \n");
		return 0;
	}
	strcpy(pluginpath,client);
	read_config(pluginpath);
	
  	return maxdicts;
}
MydictPlugin * CreateMydictPlug()
{
   return new PlugNdict;
}

int main(int argc,char *argv[])
{
	PlugNdict myDict;
	myDict.read_config(".");
	
	char oword[100]="hello";
	
	char imatch[100]="";
	char rmatch[100]="";
	char rword[100]="";
	char ryinbiao[100]="";
	char rrlist[13][100];
	char rinformation[65536]="";
	
	if(argc>1)
		strcpy(oword,argv[1]);
	int code=myDict.plugin_lookup(0,(const char*)oword,(const char*)imatch,(char *)rmatch,(char *)rword,(char *)ryinbiao,(char *)rrlist,(char *)rinformation);
	printf("return %s\n",rinformation);
}
