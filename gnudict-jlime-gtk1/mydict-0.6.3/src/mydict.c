#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif

#include "callbacks.h"
#include "interface.h"
#include "support.h"
#include "mydict.h"
#include "plugin.h"
#include "mydict_plugin.h"
#include <unistd.h>
#include <stdlib.h> /* for sprintf */
#include <dirent.h> /* for readdir */
#include <sys/stat.h> /* for stat */

#define MAX_MYDICT_DICTS 30
extern MydictPlugin * plugin_load(const char pluginFile[]);
extern void plugin_closeall();

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
	GdkFont *fixed_font,*c128_font,*phonetic_font,*bold_font;
} myDictsTable;
int mytotaldicts=0;
myDictsTable mydicts[MAX_MYDICT_DICTS];

char reciteTitle[100]="En-Ch(2)"; 
char reciteFormat[100]="ASCII";

// comments from popolon@popolon.org to use MACRO define
char mydict_root_dir[200]=PACKAGE_DATA_DIR;

int bufferLast=0;
int bufferCurrent=0;
const int bufferTotal=20;	
const unsigned int WORDLENGTH = 20;
char buffer[bufferTotal+1][20];
	
GdkColormap *cmap;
GdkColor blueColor,greenColor;

const int MAXDBFILE=5;
const int OWNDBFILE=MAXDBFILE-1;
gchar gdict_dbfile[MAXDBFILE][200]={
	"/.gdictrc",  /* /.mydict/recite.txt */
	"ck-is.gds", // gds format , see http://www.pgy.com.cn
	"ck-ly.gds", // 
	"ck-ts.gds", // 
	"phase.txt", // ndict format
};

const int DEF_RCDB=0; /* ~/.mydict/recite.txt */
int selectedDb;

const int DEF_RECITE_INTERVAL=3;

struct _display rpref;
struct _preference {
	gboolean recite_enable;
	int recite_interval;
	gboolean recite_popup;
	int recite_dict;
	gboolean debug;
	gboolean noneng_platform;
	gboolean autosearch; /* for swicth among dictionaries */
	int gdict_rc_db; /* only RC database 0 can be modified */
} gpref;

GSList *Rhead=(GSList *)NULL;
GSList *Rcurrent=Rhead;
GSList *Rreverse=Rhead;

GtkWidget *gdictwin=(GtkWidget *)NULL;	
GtkWidget *gdictpref=(GtkWidget *)NULL;
GtkWidget *gdictrecite=(GtkWidget *)NULL;
GtkWidget *gdictfile=(GtkWidget *)NULL;
GtkWidget *gdictnotebook=(GtkWidget *)NULL;

GdkFont *fixed_font,*c128_font,*phonetic_font,*bold_font;

void gdict_set_icon ()
{	
    GdkPixmap *icon=(GdkPixmap *)NULL;
    GdkBitmap *mask;

	gchar *sys_icons;
	sys_icons=g_strconcat(mydict_root_dir,"/pixmaps/mydict.xpm",NULL);
	icon = gdk_pixmap_create_from_xpm(gdictwin->window,&mask,(GdkColor *)NULL,sys_icons);
	if(icon==NULL) {
		printf("can't create icon %s\n",sys_icons);
		return;
	}
    gdk_window_set_icon(gdictwin->window, (GdkWindow *)NULL, icon, mask);
	gdk_window_set_icon_name(gdictwin->window, "myDict  ");   
}
unsigned int utf8toascii(unsigned int utf1,unsigned int utf2)
{
	/* U-00000080 - U-000007FF: 110xxxxx 10xxxxxx */
	return ( utf1 & 0x3)*64 + (utf2 & 0x3f);
}

void update_entry(gchar *result)
{
	GtkWidget *entry;

	entry = lookup_widget(gdictwin,"entry1"); 
	gtk_entry_set_text(GTK_ENTRY(entry),result);
    gtk_entry_select_region(GTK_ENTRY(entry),
             0, GTK_ENTRY(entry)->text_length); 
}	
		
void update_list(gchar **list, gchar *str)
{
	GtkWidget *clist;
	int i;
	clist = lookup_widget(gdictwin,"clist1"); 

	gtk_clist_freeze(GTK_CLIST(clist));
	gtk_clist_clear(GTK_CLIST(clist));
	for(i=0;list[i]!=NULL;i++) 
	{
		gtk_clist_append(GTK_CLIST(clist),&list[i]);
	}
        if(str!=NULL) {
          for(i=0; list[i]!=NULL; i++){
            if(strcmp(str, list[i]) == 0)
                break;
          }
          if(i<10) i++;
          GTK_CLIST(clist)->focus_row = i;
        }
	gtk_clist_thaw(GTK_CLIST(clist));
}

char toybchar(char ich)
{
	char ch;
	switch(ich) {
		case 'E': ch='W'; break;
		case '2': ch='E'; break;
		case 'A': ch='K'; break;
		case '8': ch='Q'; break;
		case '&': ch='J'; break;
		case 'c': ch='C'; break;
		case '^': ch='V'; break;
		case 'N': ch='G'; break;			
		default : ch=ich;
	}
	return ch;
}
char* gds_phonetic(char *str)
{
	int i,len;
	char ch;
	len=strlen(str);
	for(i=0;i<len;i++) {
		ch=str[i];
		switch(ch) {
			case '3': ch= '2' ; break;
			case '5': ch= 'A' ; break;
			case '7': ch= 'S' ; break;
			case '2': ch= '^' ; break;
			case '0': ch= '8' ; break;	
			case '=': ch= '3' ; break;		
			case '6': ch= 'c' ; break;									
			case '1': ch= 'a' ; break;
			case '9': ch= 'N' ; break;
			case '4': ch= 'E' ; break;
		}
		str[i]=ch;
	}
	return str;
}
void update_display(
	GtkWidget *text,
	gchar *word,gchar *yb,gchar *trans,
	GdkFont *f_font,GdkFont *c_font,GdkFont *b_font,GdkFont *p_font,
	const char *type,const char *format)
{
	guint length,i,j;
    gchar ch;
   
	gtk_text_freeze(GTK_TEXT(text));  

	length = gtk_text_get_length(GTK_TEXT(text));
	gtk_text_set_point(GTK_TEXT(text),length);
	gtk_text_backward_delete(GTK_TEXT(text),length);
	
	j = strlen(word);
	ch=' ';
	gtk_text_insert(GTK_TEXT(text), f_font,(GdkColor *)NULL,(GdkColor *)NULL,&ch, 1);
	for(i=0;i<j;i++) {
		if((unsigned char)word[i] > 127) 
		{
			gtk_text_insert(GTK_TEXT(text), c_font,(GdkColor *)NULL,(GdkColor *)NULL,
          &word[i], 1);
		}
		else {
			gtk_text_insert(GTK_TEXT(text), b_font,(GdkColor *)NULL,(GdkColor *)NULL,
          &word[i], 1);
		}
	}
	
	j = strlen(yb);
	
/*	g_print("yinbiao: %s\n",yb);
*/	
	if((yb[0]!='\0') && (yb[0]!=' ')) {
		ch=' ';
		gtk_text_insert(GTK_TEXT(text), p_font,(GdkColor *)NULL,(GdkColor *)NULL,&ch, 1);
		ch='[';
		gtk_text_insert(GTK_TEXT(text), p_font,(GdkColor *)NULL,(GdkColor *)NULL,&ch, 1);

		for(i=0;i<j;i++) {
			if((unsigned char)yb[i] > 127) 
				gtk_text_insert(GTK_TEXT(text), c_font,&blueColor,(GdkColor *)NULL,
        	  &yb[i], 1);
			else {
				ch=toybchar(yb[i]);
				gtk_text_insert(GTK_TEXT(text), p_font,&blueColor,(GdkColor *)NULL,&ch, 1);
			}
		}
		ch=']';
		gtk_text_insert(GTK_TEXT(text), p_font,(GdkColor *)NULL,(GdkColor *)NULL,&ch, 1);
	}
	ch='\n';
	gtk_text_insert(GTK_TEXT(text), p_font,(GdkColor *)NULL,(GdkColor *)NULL,&ch, 1);
	
	j = strlen(trans);
	
	if(gpref.noneng_platform==TRUE) {
		gtk_text_insert(GTK_TEXT(text), 
			(GdkFont *)NULL,
			&greenColor,
			(GdkColor *)NULL,
			trans, -1);
		gtk_text_thaw(GTK_TEXT(text));	
		return;
	}

	int checkWord=0; /* need check {Welcome} in DICT type */
	int state = 0;    
	
	if(!strcmp(type,"DICT")){
		checkWord=1;
	}
	for(i=0;i<j;i++) {
		if(trans[i]==13) continue; // remove '\r'  
		if( (trans[i]=='{') && checkWord==1) { // Check {Wecome} in DICT format
			state = 1;
			continue;
		}
		if( (trans[i]=='}') && checkWord==1) {
			state = 0;
			continue;
		}
		if((unsigned char)trans[i] > 127){  
			if(!strcmp(format,"UTF-8")) { // utf-8
				ch = utf8toascii((unsigned char)trans[i],(unsigned char)trans[i+1]); 
				i++;
			}else {
				ch = trans[i];
			}
	
			gtk_text_insert(GTK_TEXT(text), c_font,&greenColor,(GdkColor *)NULL,
          &ch, 1);
		}
		else {
			if(state==1)
				gtk_text_insert(GTK_TEXT(text), f_font,
					&blueColor,(GdkColor *)NULL,&trans[i], 1);
		  	else
				gtk_text_insert(GTK_TEXT(text), f_font,
					&greenColor,(GdkColor *)NULL,&trans[i], 1);
		}
	}
	
	gtk_text_thaw(GTK_TEXT(text));		
}

void update_trans(gchar *word,gchar *yb,gchar *trans)
{
	GtkWidget *text;
	int ind;
	char str[100];			

	ind = gtk_notebook_get_current_page(GTK_NOTEBOOK(gdictnotebook));

	sprintf(str,"mytext%d",ind);
	text = lookup_widget(gdictwin,str);	
	
	update_display(text,word,yb,trans,
		mydicts[ind].fixed_font,
		mydicts[ind].c128_font,
		mydicts[ind].bold_font,
		mydicts[ind].phonetic_font,
		mydicts[ind].type,
		mydicts[ind].format);
}

void update_text(gchar *result)
{
	GtkWidget *text;
	int ind;	
	char str[100];		
	
	ind = gtk_notebook_get_current_page(GTK_NOTEBOOK(gdictnotebook));


/*	printf("current notebook is %d\n",ind); */
	sprintf(str,"mytext%d",ind);
	text = lookup_widget(gdictwin,str);

	update_display(text,"","",result,
		mydicts[ind].fixed_font,
		mydicts[ind].c128_font,
		mydicts[ind].bold_font,
		mydicts[ind].phonetic_font,
		mydicts[ind].type,
		mydicts[ind].format);
}

void update_recite(gchar *result)
{
	GtkWidget *text;
	gchar *word=" ";
	gchar *yb=" ";
	gchar *trans=" ";
	gchar **list;
	
	if(TRUE!=gpref.recite_popup) {
		return;
	}
	if(!GTK_IS_WIDGET(gdictrecite)) 
		return;

	text = lookup_widget(gdictrecite,"recitePopupText");
/* 
   Format <word> /// <yinbiao> /// <trans> 
   Old    <word>
*/   
	list=g_strsplit(result," /// ",3); /* will be 3 */
    if(list[0]!=NULL) {
		word=list[0];
	}
	if(list[1]!=NULL) {
		yb=list[1];
		if(list[2]!=NULL) {
			trans=list[2];
		}
	}
	if(true != rpref.word)
		word="";
	if(true != rpref.phonetic) 
		yb="";
	if(true != rpref.trans) 
		trans="";
	update_display(text,word,yb,trans,
		fixed_font,
		c128_font,
		bold_font,
		phonetic_font,
		"LOCAL",
		reciteFormat);
}
void addBuffer(char *str)
{
	if(strlen(str)>=WORDLENGTH)
		str[WORDLENGTH]='\0';
	if(bufferLast!=bufferTotal)
		bufferLast=bufferLast+1;
	else
		bufferLast=0;
	strcpy(buffer[bufferLast],str);
	bufferCurrent = bufferLast;
//	printf("current [%d] = %s\n",bufferLast,buffer[bufferLast]);
}
void showPreviousBuffer()
{
	if(bufferCurrent!=0)
		bufferCurrent=bufferCurrent-1;
	else
		bufferCurrent=bufferTotal;
	update_entry(buffer[bufferCurrent]);
//	printf("current [%d] = %s\n",bufferCurrent,buffer[bufferCurrent]);	
}
void showNextBuffer()
{
	if(bufferCurrent!=bufferTotal)
		bufferCurrent=bufferCurrent+1;
	else
		bufferCurrent=0;
	update_entry(buffer[bufferCurrent]);		
//	printf("current [%d] = %s\n",bufferCurrent,buffer[bufferCurrent]);	
}
void update_disp(void)
{
	GtkWidget *entry;

	char *str;
	gchar **lists;
	char match[100] ; /* yes,no ,error */
	char word[100] ; /* returned word */
	char yinbiao[100] ; /* Yin Biao */
	char list[300]; /* relative words */
	char information[65535]; 
	int option;

	entry = lookup_widget(gdictwin,"entry1"); 
	str = gtk_entry_get_text(GTK_ENTRY(entry));
				
	option = gtk_notebook_get_current_page(GTK_NOTEBOOK(gdictnotebook));

//	g_print("Sending .. %s,%d -> %d\n",str,option,mydicts[option].dictionary);
//	g_print(" %s \n",	mydicts[option].title);

	printf("claudio222\n");
	char palabra[100];
//	strcpy(palabra, str);
	sprintf(palabra, "Looking '%s'. Please wait..", str);
//	strcat(palabra, " - Please wait..."); 
		update_entry(palabra);
        gtk_entry_select_region(GTK_ENTRY(entry),
                               0, GTK_ENTRY(entry)->text_length); 

//	addBuffer(word);
/*
	char w[80], w2[10], w3[10];
	strcpy(w, "Please wait, this may take a while...");
	strcpy(w2, "Please wait, this may take a while...");
	strcpy(w3, "Please wait, this may take a while...");
	update_trans(w, w2, w3);
	printf("claudio222, %s, %s, %s\n", w, w2, w3);
*/

	mydicts[option].myPlugins->plugin_lookup(
		mydicts[option].dictionary,str,"moose",
		match,word,yinbiao,list,information);
		
	g_print("[%s][%s][%s]\n",word,yinbiao,information);	
	update_trans(word,yinbiao,information);
	
	if(strcmp(match,"yes")) 
		update_entry(word);

	/* agregado por rafa */
	//strncpy(word, str, strlen(str-1));
	update_entry(word);
	/* agregado por rafa */

	addBuffer(word);
		
//	g_print("Lists : %s\n",list);
	if(strcmp(match,"error"))
	{
		lists = g_strsplit(list,"+",11);

        str = gtk_entry_get_text(GTK_ENTRY(entry));	
		update_list(lists, str);
	
		g_strfreev(lists);
	}

        gtk_entry_select_region(GTK_ENTRY(entry),
                               0, GTK_ENTRY(entry)->text_length); 
}

void update_popup(gboolean status)
{
	gpref.recite_popup=status;
}
void update_debug(gboolean status)
{
	int option;
	
    gpref.debug=status;
	
	option = gtk_notebook_get_current_page(GTK_NOTEBOOK(gdictnotebook));

	mydicts[option].myPlugins->plugin_debug((status==TRUE) ? 1:0);	
	
}
void eng_platform(gboolean status)
{
   gpref.noneng_platform=!status;
}
void update_autosearch(gboolean status)
{
	gpref.autosearch=status;
}

void read_rc(void)
{
	FILE * fp;
	char buffer[65536];
	char *str=buffer;
	gchar *file;
	gchar *data;
	GSList *tmp;
	char *buf;
	struct stat stats;
	long i,j;
	if(gpref.gdict_rc_db==DEF_RCDB)
		file = g_strconcat(g_get_home_dir(),gdict_dbfile[DEF_RCDB], NULL);
	else 
		file = g_strconcat(gdict_dbfile[gpref.gdict_rc_db],NULL);
	
    gtk_window_set_title (GTK_WINDOW (gdictrecite), file);

	if(Rhead!=NULL){ /* Remove list */
		tmp = Rhead;
		while(tmp!=NULL) {
			data = (gchar *)tmp->data;
			if(data !=NULL) {
				g_free(data);
			}else {
				g_print("point error\n");
			}
			
			tmp = (GSList *)g_slist_next(tmp);
		}
		g_slist_free(Rhead); /* ? */
		Rhead=(GSList *)NULL;
		Rcurrent=Rhead;		
	}
				
	if(!(fp=fopen(file,"r")) ) 
	{
/*		g_print("Can't open file %s\n",file);  */
		return;
	}
	if(strstr(file,".gds")) {  // gds format
		if (lstat (file, &stats) == -1)
			return ;

		buf = (char *) malloc (stats.st_size + 1);
		if (fread (buf, 1, stats.st_size, fp) != (unsigned int) stats.st_size)
		{
			fclose (fp);
			return ;
		}
		buf[stats.st_size] = '\0';

		i=290; // position of first words 290
		j=0;
		while (i<stats.st_size)
		{
	 		*(buf+i+29)='\0';
			*(buf+i+59)='\0';
			*(buf+i+99)='\0';

			sprintf(str,"%s /// %s /// %s",
				g_strstrip(buf+i),
				gds_phonetic(g_strstrip(buf+i+30)),
				g_strstrip(buf+i+60) );
			if(gpref.debug)
				printf("=>%s \n",str);

			Rhead=g_slist_append(Rhead,g_strdup(str));
			i+=128;
		}	
		free(buf);	
	}
	else { // treat ndict format 
		while(!feof(fp))
		{
			fgets(str,65535,fp);
			if(!feof(fp)) {
				if(strlen(str)<2) /* fix a bug for empty line */
					continue;
				str[strlen(str)-1] = '\0';  /* remove \n */
				Rhead=g_slist_append(Rhead,g_strdup(str));
			}
		}
	}
	Rcurrent = Rhead;
	fclose(fp);	
}
void gdict_timer_reset() 
{
	static int timer=0;
	if(timer != 0) /* First time */
		gtk_timeout_remove(timer);
	timer=gtk_timeout_add(gpref.recite_interval*1000,on_timeout_received,NULL);
}
void update_db(int db)
{
	gpref.gdict_rc_db=db;
	if(db>=MAXDBFILE) {
		g_print("Error db file, contact author\n");
		return;
	}
	if(gpref.debug)
		printf("%s\n",gdict_dbfile[db]);
	read_rc();
}
void add_rc(char *str)
{
	FILE * fp;
	gchar *file;
    int length,pos;

	if(gpref.gdict_rc_db!=DEF_RCDB)
		return;
		
	file = g_strconcat(g_get_home_dir(),gdict_dbfile[DEF_RCDB], NULL);

	if(!(fp=fopen(file,"a")) ) 
	{
		printf("Can't append file %s\n",file);
		return ;
	}
		Rhead=g_slist_append(Rhead,g_strdup(str));
	
	/* Try to locate added words's previous */
	length = g_slist_length(Rhead);

	if(length==1)
		pos=0;
	else 
		pos=length-2;
	Rcurrent=g_slist_nth(Rhead,pos);
/*  
	tmp=Rhead;
	while(tmp!=NULL) {
		g_print("List:%s\n",(gchar *)tmp->data);
		tmp=(GSList *)g_slist_next(tmp);
	}
*/
	fputs(str,fp);
/*	fputs("\n",fp);
*/	fclose(fp);
	update_rc(ADD_WORD);
}
void update_rc(int reason)
{
	FILE * fp;
	char *file;

	GSList *tmp;
		
	if(TIMEOUT != reason) {
		gdict_timer_reset();
	}
/*
	if(true == rpref.pause ) {
		return;
	}
*/
        if(true == rpref.pause && 
                   (NEXT_WORD != reason && PREV_WORD != reason)) {
                return;
        }

	if(DEL_WORD == reason) {
		if(gpref.gdict_rc_db != DEF_RCDB)  /* Only default can update */
			return;
		file = g_strconcat(g_get_home_dir(), gdict_dbfile[DEF_RCDB], NULL);

		if(Rcurrent == NULL)
			return;

/*		g_print("Remove: %s \n",Rcurrent->data);  */
		
		tmp = (GSList *)g_slist_next(Rcurrent); 

		Rhead = g_slist_remove(Rhead,Rcurrent->data);

		Rcurrent = tmp;
		if(Rcurrent == NULL)
			Rcurrent=Rhead;
/*		g_print("Current: %s\n",Rcurrent->data); */
		
		if(!(fp=fopen(file,"w")) ) 
		{
			return;
		}
		tmp = Rhead;
		while(tmp !=NULL) {
			fputs((gchar *)tmp->data,fp);
			fputs("\n",fp);
			tmp = (GSList *)g_slist_next(tmp);
		}

		fclose(fp);
							
		if(Rhead==NULL) { /* last one is removed */
			Rcurrent = Rhead;
			return;
		}
		
	}
        else if(PREV_WORD == reason) {
                if(Rhead == NULL) return;
                if(Rcurrent == NULL) return;
                if(Rreverse == NULL){
                  Rreverse = g_slist_reverse(Rhead);
                  Rcurrent = g_slist_find(Rreverse, Rcurrent->data);
                }

                Rcurrent = Rcurrent->next;
                if(Rcurrent == NULL)
                  Rcurrent = Rreverse;
        }
	else {  /* NEXT_WORD or Timeout */
		if(Rhead==NULL) return;
		if(Rcurrent== NULL) return;

                if(Rreverse != NULL) {
                  Rhead = g_slist_reverse(Rreverse);
                  Rcurrent = g_slist_find(Rhead,Rcurrent->data);
                  Rreverse = (GSList *)NULL;
                }
		Rcurrent = Rcurrent->next;
		if(Rcurrent == NULL)
			Rcurrent = Rhead;
	}
/*	g_print("Hello: %s\n",Rcurrent->data);	 */
		
	update_recite((gchar *)Rcurrent->data);
}	

void update_timer(gint timer)
{
	GtkWidget *spin;
	gpref.recite_interval	= timer;

	gdict_timer_reset();
	
	spin = lookup_widget(gdictpref,"spinbutton1"); 
	gtk_spin_button_set_value(GTK_SPIN_BUTTON(spin),timer);
}

void reset_timer(void)
{	
	update_timer(DEF_RECITE_INTERVAL);
}
void myGetWord(void)
{
	GtkWidget *entry;
	
	char match[100] ; /* yes,no ,error */
    char word[100] ; /* returned word */
    char yinbiao[100] ; /* Yin Biao */
    char list[300]; /* relative words */
    char information[65535];
	char searchStr[200];
	long i,len;
	char str[65535];
	int ind;
	
	entry = lookup_widget(gdictwin,"entry1"); 
	strcpy(searchStr,gtk_entry_get_text(GTK_ENTRY(entry)));
		
	ind = gtk_notebook_get_current_page(GTK_NOTEBOOK(gdictnotebook));
	if(ind!=gpref.recite_dict) // Only wanted dict can be added
		return;
//	g_print("Sending .. %s,%d -> %d\n",searchStr,ind,mydicts[ind].dictionary);
//	g_print(" %s \n",	mydicts[ind].title);
	
	mydicts[ind].myPlugins->plugin_lookup(
		mydicts[ind].dictionary,searchStr,"moose",
		match,word,yinbiao,list,information);

	len=strlen(information);
	/* remove the garbage Yin biao in dict 2*/
	for(i=0;i<len;i++)
		if((unsigned char)information[i]>127) break;
	g_snprintf(str,65535,"%s /// %s /// %s",word,yinbiao,&information[i]);
	
	add_rc(str);
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
/*		printf("Got dir entry: %s\n",dirp->d_name); */
		if(strstr(dirp->d_name,".so")) {
			i++;
			strcat(list,dirp->d_name);
			strcat(list,"+");
		}
	}
	if(i)
		list[strlen(list)-1]='\0'; // remove the end +
	closedir(dirh);
	return i;
}

void init_db(const char *path)
{
	char lists[2000];
	gchar **plugin_list;
	
	int numberofplugin = getPluginList(path,lists);
	if(numberofplugin == 0)
		return ;
	plugin_list = g_strsplit(lists,"+",numberofplugin);
	
	gchar *pluginname;
	int count=mytotaldicts; /* for simple type */
	for(int p=0;p<numberofplugin;p++) {
		pluginname = g_strconcat(path, "/",plugin_list[p], NULL);
		MydictPlugin *plugin = plugin_load(pluginname);
		if(plugin == NULL) {
			printf(" Load plugin: [%s] failed\n",pluginname);
			continue;
		}
		int version;
		int dicts=plugin->plugin_init(MYDICTPLUGIN_VERSION,path,&version);
		if(version != MYDICTPLUGIN_VERSION)
			printf("plugin version %d is not matched with my version %d\n",
				version,MYDICTPLUGIN_VERSION);

		char str[100];

		GtkWidget *scrolledwindow,*text,*label;

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
			if(!strcmp(reciteTitle,mydicts[count].title))
				gpref.recite_dict=count;

//			printf("  =>load %s dictionary\n",mydicts[count].title);
			scrolledwindow = gtk_scrolled_window_new ((GtkAdjustment *)NULL,(GtkAdjustment *)NULL);
			gtk_widget_ref (scrolledwindow);
			sprintf(str,"myscrolledwindow%d",count);
			gtk_object_set_data_full (GTK_OBJECT (gdictwin), str, scrolledwindow,
                        			(GtkDestroyNotify) gtk_widget_unref);
			gtk_widget_show (scrolledwindow);
			gtk_container_add (GTK_CONTAINER (gdictnotebook), scrolledwindow);
			gtk_scrolled_window_set_policy (GTK_SCROLLED_WINDOW (scrolledwindow), GTK_POLICY_AUTOMATIC, GTK_POLICY_AUTOMATIC);

			text = gtk_text_new ((GtkAdjustment *)NULL, (GtkAdjustment *)NULL);
			gtk_widget_ref (text);
			gtk_text_set_word_wrap(GTK_TEXT(text),true);

			sprintf(str,"mytext%d",count);
			gtk_object_set_data_full (GTK_OBJECT (gdictwin), str, text,
                        			(GtkDestroyNotify) gtk_widget_unref);
			gtk_widget_show (text);
			gtk_container_add (GTK_CONTAINER (scrolledwindow), text);

			label = gtk_label_new (mydicts[count].title);
			gtk_widget_ref (label);
			sprintf(str,"mydict%d",count);
			gtk_object_set_data_full (GTK_OBJECT (gdictwin), str, label,
                        			(GtkDestroyNotify) gtk_widget_unref);
			gtk_widget_show (label);
			gtk_notebook_set_tab_label (
				GTK_NOTEBOOK (gdictnotebook), 
				gtk_notebook_get_nth_page (GTK_NOTEBOOK (gdictnotebook), count), label);

	/*		lists = g_strsplit(mydicts[count].fonts,"+",11);
	//		int num=atoi(mydicts[count].fonts);
	*/
			char *pos,*p2;
			pos = mydicts[count].fonts;
			if( (pos != NULL) && ((p2 = strchr(pos,'+'))!=NULL) )
			{
				*p2='\0';
//				printf("Loading fonts %s\n",pos);
				mydicts[count].fixed_font = gdk_font_load(pos); 
				if(NULL ==  mydicts[count].fixed_font )
				{
//					printf("Can't load fonts %s , load default instead\n",pos);
					mydicts[count].fixed_font = fixed_font;
				}
				pos=p2+1;
			}else
				mydicts[count].fixed_font = fixed_font;

			if( (pos != NULL) && ((p2 = strchr(pos,'+'))!=NULL) )
			{
				*p2='\0';
//				printf("Loading fonts %s\n",pos);
				mydicts[count].bold_font = gdk_font_load(pos); 
				if(NULL ==  mydicts[count].bold_font )
				{
//					printf("Can't load fonts %s , load default instead\n",pos);
					mydicts[count].bold_font = bold_font;
				}
				pos=p2+1;
			}else
				mydicts[count].bold_font = fixed_font;

			if( (pos != NULL) && ((p2 = strchr(pos,'+'))!=NULL) )
			{
				*p2='\0';
//				printf("Loading fonts %s\n",pos);
				mydicts[count].phonetic_font = gdk_font_load(pos); 
				if(NULL ==  mydicts[count].phonetic_font )
				{
//					printf("Can't load fonts %s , load default instead\n",pos);
					mydicts[count].phonetic_font = fixed_font;
				}
				pos=p2+1;
			}else
				mydicts[count].phonetic_font = fixed_font;	

			if( (pos != NULL) && ((p2 = strchr(pos,'+'))!=NULL) )
			{
				*p2='\0';
//				printf("Loading fonts %s\n",pos);
				mydicts[count].c128_font = gdk_font_load(pos); 
				if(NULL ==  mydicts[count].c128_font  )
				{
//					printf("Can't load fonts %s , load default instead\n",pos);
					mydicts[count].c128_font  = fixed_font;
				}
				pos=p2+1;
			}else
				mydicts[count].c128_font  = fixed_font;
			gtk_notebook_set_page(GTK_NOTEBOOK(gdictnotebook),count);
			gchar *dictinfo;
			dictinfo = g_strconcat("\n Plugin: [", pluginname, "]\n",
					mydicts[count].description, NULL);
			
			update_text(dictinfo);
			
			count++;
			mytotaldicts=count;
			if(count==MAX_MYDICT_DICTS)
				break; 
		}
	}
	g_strfreev(plugin_list);
}
void update_version()
{
	gchar *title;
	title = g_strconcat(GTK_WINDOW(gdictwin)->title," ",VERSION,NULL);
	gtk_window_set_title (GTK_WINDOW (gdictwin), title);

}
static int init_timer=0;

gint on_init_timeout(gpointer data)
{
	
	gtk_notebook_remove_page( GTK_NOTEBOOK(gdictnotebook), 0);  /* remove garbage from glade */
	
	gchar *sys_plugin_dir;
	sys_plugin_dir = g_strconcat(mydict_root_dir,"/plugins", NULL);
	init_db(sys_plugin_dir);

	gchar *own_plugin_dir;
	own_plugin_dir = g_strconcat(g_get_home_dir(),"/.mydict/plugins", NULL);	
    init_db(own_plugin_dir);
	gtk_timeout_remove(init_timer);
	if(mytotaldicts<1) {
		printf(">> At least you need install one plugin from mydict-plugins package \n");
		printf(">> Download from http://sourceforge.net/projects/gnudict \n");
		printf(">> or contact caiyu@yahoo.com \n");
//		exit(1);
	}
	return TRUE;
}		
void init_plugins()
{
	init_timer=gtk_timeout_add(1000,on_init_timeout,NULL);
}
void mydict_reloadplugins()
{
	plugin_closeall();
	for(int i=0;i<mytotaldicts;i++) 
		gtk_notebook_remove_page( GTK_NOTEBOOK(gdictnotebook),0);

	mytotaldicts = 0;
	init_plugins();
}

void update_recitedb_list(void)
{
	GtkWidget *clist;
	int i;
	char str[1000];

	FILE *fp;
	char line[1000];
	gchar *config;
	gchar **cfglist;
	char *pos;
	char info[100];
	
	clist = lookup_widget(gdictpref,"recitelist"); 
	gtk_clist_freeze(GTK_CLIST(clist));
	gtk_clist_clear(GTK_CLIST(clist));
	
	config = g_strconcat(g_get_home_dir(),"/.mydict/mydict.ini", NULL);
	if((fp=fopen(config,"r"))==NULL) {
		config = g_strconcat(mydict_root_dir,"/mydict.ini", NULL);
		if((fp=fopen(config,"r"))==NULL) {
			return;
		}
	}
	i=0;
	while(!feof(fp)) {
		if(i==DEF_RCDB) {
			pos = gdict_dbfile[i];
			gtk_clist_append(GTK_CLIST(clist),&pos);
			i++;
		}
		if(i>=MAXDBFILE)
			break;
		fgets(line,1000,fp);
		if(feof(fp)) continue;
		line[strlen(line)-1]='\0'; /* remove \n */

		if( (line[0]=='#') || (line[0]==' '))
			continue;
		cfglist=g_strsplit(line,"=",2);
		if(cfglist[0]!=NULL && cfglist[1]!=NULL)  {
//			printf("%s : [%s] \n",cfglist[0],cfglist[1]);
			
			if(!strcmp(cfglist[0],"recitefile")) {
				pos=strchr(cfglist[1],':');
				if(pos) {
					*pos='\0';
					strcpy(info,pos+1);
				}

				strcpy(gdict_dbfile[i],cfglist[1]);
				if(strrchr(gdict_dbfile[i],'/') != NULL )
					sprintf(str,"%s",gdict_dbfile[i]);
				else
					sprintf(str,"%s/recitedb/%s",mydict_root_dir,gdict_dbfile[i]);
				strcpy(gdict_dbfile[i],str);
				pos=info;
				gtk_clist_append(GTK_CLIST(clist),&pos);	
				i++;
			}				
		}
	}
	gtk_clist_thaw(GTK_CLIST(clist));
}	

void read_config()
{
	FILE *fp;
	char line[1000];
//printf("hello\n");
	gchar *config;
	gchar **list;
	config = g_strconcat(g_get_home_dir(),"/.mydict/mydict.ini", NULL);
	if((fp=fopen(config,"r"))==NULL) {
		config = g_strconcat(mydict_root_dir,"/mydict.ini", NULL);
		if((fp=fopen(config,"r"))==NULL) {
			fprintf(stderr,">> Can't open mydict.ini config file \n mydict <mydict root dir>\n");
			exit(1);
		}
	}
	while(!feof(fp)) {
		fgets(line,1000,fp);
		if(feof(fp)) continue;
		line[strlen(line)-1]='\0'; /* remove \n */

		if( (line[0]=='#') || (line[0]==' '))
			continue;
		list=g_strsplit(line,"=",2);
		if(list[0]!=NULL && list[1]!=NULL)  {
//			printf("%s : [%s] \n",list[0],list[1]);
			
			if(!strcmp(list[0],"fixedfont")) {
				fixed_font = gdk_font_load(list[1]); 
				if(NULL ==  fixed_font )
				{
					;
				//	printf("Can't load correct fixed fonts  \n");
				}
			}else if(!strcmp(list[0],"boldfont")) {
				bold_font = gdk_font_load(list[1]); 
				if(NULL == bold_font)
				{
					;
				//	printf("Can't load correct bold fonts\n");
				}
			}else if(!strcmp(list[0],"phoneticfont")) {
				phonetic_font = gdk_font_load(list[1]); 
				if(NULL == phonetic_font)
				{
					;
				//	printf("Can't load correct phonetic fonts\n");
				}
			}else if(!strcmp(list[0],"c128font")) {
				c128_font = gdk_font_load(list[1]); 
				if(NULL == c128_font)
				{
					;
				//	printf("Can't load correct c128 fonts\n");
				}
			}else if(!strcmp(list[0],"recitedb")) {
				strcpy(reciteTitle,list[1]);
			}else if(!strcmp(list[0],"reciteformat")) {
				strcpy(reciteFormat,list[1]);
			}				
		}
	}
}
void init_gdict(GtkWidget *widget,char *para)
{	
	GtkWidget *text;
	GtkWidget *togglebutton;
 	gdictwin = widget;
	gdictpref = create_preference();
	gdictrecite= create_popupRecite();
	gdictnotebook = lookup_widget(gdictwin, "myNotebook");

	if(NULL!=para) 
	{
		strcpy(mydict_root_dir,para);
	}
	gdict_set_icon();

	for(int i=0;i<=bufferTotal;i++)
		strcpy(buffer[i],"mydict");
	bufferCurrent=bufferLast=0;
		
	gpref.recite_popup      = FALSE;
	gpref.debug				= FALSE;
	gpref.autosearch		= TRUE;
	if(getenv("LANG") && strncmp(getenv("LANG"),"en",2)) 
		gpref.noneng_platform	= TRUE;
	else
		gpref.noneng_platform	= FALSE;
		
	togglebutton = lookup_widget(gdictpref, "nonengbutton");
	gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON (togglebutton), gpref.noneng_platform);
		
	gpref.recite_dict		= -1;
	
	read_config();

	/* Read into buffer first time */
	read_rc();
		
	rpref.word 		= true;
	rpref.phonetic 	= true;
	rpref.trans		= true;
	rpref.pause		= false;
	reset_timer();

	text = lookup_widget(gdictrecite,"recitePopupText");
	gtk_text_set_word_wrap(GTK_TEXT(text),true);
		
	update_recitedb_list();	
	
	update_version();	
	
	cmap = gdk_colormap_get_system();
    blueColor.red = 0;
    blueColor.green = 0;
    blueColor.blue = 0xffff;
	
    if (!gdk_color_alloc(cmap, &blueColor)) {
      g_error("couldn't allocate color");
    }

    greenColor.red = 0;
    greenColor.green = 0x8080;
    greenColor.blue = 0x8080;
	
    if (!gdk_color_alloc(cmap, &greenColor)) {
      g_error("couldn't allocate color");
    }	
	
	init_plugins();
}
