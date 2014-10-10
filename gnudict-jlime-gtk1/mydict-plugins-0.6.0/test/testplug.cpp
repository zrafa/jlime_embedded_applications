#include "../mydict_plugin.h"
#include <stdio.h>
#include <string.h>
#include <dlfcn.h> // dynamic library stuff 
#include <sys/types.h> // for read dir
#include <dirent.h>

const int MAX_MYDICT_DICTS=100;
typedef struct _plugin_info {
        char plugin[100];
        char stamps[100];
        int dictionary;
        MydictPlugin *myPlugins;
        char fonts[200];
        char title[100];
        char format[100];
        char description[1000];
        char type[100];
} myDictsTable;
int mytotaldicts=0;
myDictsTable mydicts[MAX_MYDICT_DICTS];

void *handleList[100];
int numberofhandle=0;
void plugin_closeall()
{
    int i=0;
    for(i=0;i<numberofhandle;i++)
        if ( handleList[i] != NULL)
        {
            dlclose( handleList[i] );
            handleList[i] = NULL;
        }       
    numberofhandle = 0;     
}
MydictPlugin * plugin_load(const char pluginFile[])
{
    CREATEPLUG_PROC createproc;
    MydictPlugin *  myPlugins;

    void *          handle;
    char *          error;

    // Load plugin dynamic library
    if (NULL == (handle = dlopen(pluginFile, RTLD_NOW )))
    {
        handle = NULL;
        printf( "dlopen error (%s)\n", pluginFile );
        error=dlerror();
        printf("error : %s\n",error);
        return NULL;
    }
    else
    {
        // Get address of CreatePlug function
        createproc = (CREATEPLUG_PROC)dlsym( handle, "CreateMydictPlug" );
        if ((error = dlerror()) != NULL)
        {
                dlclose( handle );
                handle = NULL;
                printf( "dlsym error (%s)\n", pluginFile );
                printf("error : %s\n",error);
                return NULL;
        }
        else
        {
                // Create an instance of the derived plugin class
                myPlugins = createproc();
                handleList[numberofhandle++]=handle;
                return myPlugins;
        }
    }
}

int getPluginList(const char *path,char *list)
{ 
    DIR *dirh;
    struct dirent *dirp;
    int i;
    strcpy(list,"");
    if ((dirh = opendir(path)) == NULL)
    {
	    return 0;
    }
    i =0;
    for (dirp = readdir(dirh); dirp != NULL; dirp = readdir(dirh))
    {
/*              printf("Got dir entry: %s\n",dirp->d_name); */
        if(strstr(dirp->d_name,".so")) {
            i++;
            strcat(list,dirp->d_name);
            strcat(list,"+");
        }
    }
//    if(i)
//        list[strlen(list)-1]='\0'; // remove the end +
    closedir(dirh);
    return i;
}
void load_plugins(const char *path)
{
	char lists[2000];
	int numberofplugin = getPluginList(path,lists);
    if(numberofplugin == 0)
       return ;
        
	char pluginname[1000];
    int count=mytotaldicts; /* for simple type */
	char *p1,*p2;
	p1=lists;
    for(int p=0;p<numberofplugin;p++) {
		p2=p1;
		if((p1=strchr(p2,'+'))==NULL)
			break;
		*p1='\0'; p1++;
        sprintf(pluginname,"%s/%s",path,p2);
        MydictPlugin *plugin = plugin_load(pluginname);
        if(plugin == NULL) {
            printf(" Load plugin: %s failed\n",pluginname);
            continue;
        }
        int version;
        int dicts=plugin->plugin_init(MYDICTPLUGIN_VERSION,path,&version);
        char str[100];

        for(int i=0;i<dicts;i++)
        {
            plugin->plugin_getDictInfo(i,
                            mydicts[count].title,
                            mydicts[count].description,
                            mydicts[count].type,
                            mydicts[count].format,
                            mydicts[count].fonts);
            strcpy(mydicts[count].plugin,pluginname);
			mydicts[count].dictionary=i;
            mydicts[count].myPlugins = plugin;
			count++;
            mytotaldicts=count;
            if(count==MAX_MYDICT_DICTS)
                break;
		}
	}
}
int main(int argc,char *argv[])
{
	char path[200]="/usr/local/share/mydict/plugins";
	if(argc>1) {
		strcpy(path,argv[1]);
	}
	printf("Checking plugins under %s \n",path);
	load_plugins(path);
	
	printf("Total %d dictionaries exist \n",mytotaldicts);
	if(mytotaldicts==0)
		return 1;
	printf("====================================================\n");
	for(int i=0;i<mytotaldicts;i++){
		printf("%d[%d]:%s:%s\n",i,mydicts[i].dictionary,mydicts[i].title,mydicts[i].type);
	}
	char word[100]="welcome";
	char match[100],rword[100],yinbiao[100],list[4000],information[65536];
	
	for(int i=0;i<mytotaldicts;i++){
		mydicts[i].myPlugins->plugin_lookup(
                mydicts[i].dictionary,word,"similar",
                match,rword,yinbiao,list,information);

		printf("====== %d ========\n",i);
		printf("Lookup %s in %s\n",word,mydicts[i].title);
		printf("Matched %s : return word %s\n",match,rword);
		printf("Trans: %s\n",information);
	}
}
