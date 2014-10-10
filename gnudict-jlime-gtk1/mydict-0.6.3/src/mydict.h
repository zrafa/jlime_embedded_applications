#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif

#include "callbacks.h"
#include "interface.h"
#include "support.h"
#include <gdk/gdkkeysyms.h>

#include <stdio.h>
#include <string.h>
#include <sys/stat.h>

#define TIMEOUT 0
#define ADD_WORD 1
#define DEL_WORD 2
#define NEXT_WORD 3
#define PREV_WORD 4

#define EC_DICT  0
#define EE_DICT  1 
#define EC_DICT2 2 

struct _display {
	gboolean word;
	gboolean phonetic;
	gboolean trans;
	gboolean pause;
};

typedef enum { DBFILE_WIN,PREF_WIN,COLOR_WIN,RECITE_WIN} GdictWin;

extern struct _display rpref;

/*extern GSList *Rhead,*Rcurrent;
*/
extern GtkWidget *gdictwin;	
extern GtkWidget *gdictpref;
extern GtkWidget *gdictcolor;
extern GtkWidget *gdictrecite;
extern GtkWidget *gdictfile;

extern int selectedDb;

/* Function in soapfunc.cpp */
void myGetWord(void);

void gdict_set_icon (void );
void update_entry(gchar *result);
void update_list(gchar **list, gchar *str);
void update_text(gchar *result);
void update_recite(gchar *result);
void update_disp(void);
void update_db(int);
void update_popup(gboolean);
void update_debug(gboolean);
void eng_platform(gboolean);
void update_autosearch(gboolean);
void update_switch(int);
void update_recitedb_list(void);

void showNextBuffer();
void showPreviousBuffer();

void add_rc(gchar *);
void update_rc(int reason);
void init_gdict(GtkWidget *widget,char *);
gint on_timeout_received(gpointer data);
void update_timer(gint timer);
void reset_timer(void);

void gdict_widget_show(GtkWidget *,GdictWin);
void mydict_reloadplugins(void);
