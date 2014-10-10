#ifdef HAVE_CONFIG_H
#  include <config.h>
#endif

#include "callbacks.h"
#include "interface.h"
#include "support.h"

#include "mydict.h"

void
on_window1_destroy                     (GtkObject       *object,
                                        gpointer         user_data)
{
	gtk_main_quit();
}

gboolean
on_entry1_key_press_event              (GtkWidget       *widget,
                                        GdkEventKey     *event,
                                        gpointer         user_data)
{
	switch(event->keyval) {
		case GDK_Return:
			update_disp();
			break;
		case GDK_Page_Down:
			showNextBuffer();
			break;
		case GDK_Page_Up:
			showPreviousBuffer();
			break;
	}
	
  	return FALSE;
}

/* Add word in recite list */
void
on_button1_clicked                     (GtkButton       *button,
                                        gpointer         user_data)
{
	myGetWord();
}


gint on_timeout_received(gpointer data)
{
	update_rc(TIMEOUT);
	return TRUE;
}

/* This is for removing the words */
void
on_removebutton_clicked                (GtkButton       *button,
                                        gpointer         user_data)
{
	update_rc(DEL_WORD);
}

void on_debugbutton_toggled                 (GtkToggleButton *togglebutton,
                                        gpointer         user_data)
{
    if(GTK_TOGGLE_BUTTON(togglebutton)->active) {
        update_debug(TRUE);
    }else
        update_debug(FALSE);
}

void
on_clist1_select_row                   (GtkCList        *clist,
                                        gint             row,
                                        gint             column,
                                        GdkEvent        *event,
                                        gpointer         user_data)
{
	gchar *text;
	gtk_clist_get_text(clist,row,column,&text);	
//	gtk_clist_set_background(GTK_CLIST(clist),row,&listbg);
//	g_print(" Sending .. %s \n",text);
	update_entry(text);
	update_disp();
}

void
on_button3_clicked                     (GtkButton       *button,
                                        gpointer         user_data)
{
	update_disp();
}

/* Popup Recite */
void
on_popupbutton_clicked                 (GtkButton       *button,
                                        gpointer         user_data)
{
 	update_popup(TRUE);
	if(!GTK_IS_WIDGET(gdictrecite)) {
		gdictrecite=create_popupRecite();
	}
	gtk_widget_show(gdictrecite);

}

void
on_button4_clicked                     (GtkButton       *button,
                                        gpointer         user_data)
{
	gtk_main_quit();
}

gboolean
on_entry1_button_press_event           (GtkWidget       *widget,
                                        GdkEventButton  *event,
                                        gpointer         user_data)
{
	if(event->type == GDK_BUTTON_PRESS && event->button == 3 )
		update_entry("");
	
	return FALSE;
}


gboolean
on_clist1_key_release_event            (GtkWidget       *widget,
                                        GdkEventKey     *event,
                                        gpointer         user_data)
{
  GtkCList *clist;
  gchar *text;
  gint row;

  clist = (GtkCList *) user_data;

  if(event->type != GDK_KEY_RELEASE )
    return FALSE;

  switch(event->keyval) {
    case GDK_Return: row = GTK_CLIST(clist)->focus_row;
                     gtk_clist_get_text(clist, row, 0, &text);
                     update_entry(text);
                     update_disp();
                     break;
    default: break;
  }
  return TRUE;
}

void
on_button11_clicked                    (GtkButton       *button,
                                        gpointer         user_data)
{
	gtk_widget_hide(gdictpref);
}

void
on_quitReciteButton_clicked            (GtkButton       *button,
                                        gpointer         user_data)
{
	update_popup(FALSE);
	gtk_widget_hide(gdictrecite);
}

void
on_update_timer_clicked                (GtkButton       *button,
                                        gpointer         user_data)
{
	GtkWidget *spin;
	gint timer;
	spin = lookup_widget(gdictpref,"spinbutton1"); 
	timer=gtk_spin_button_get_value_as_int(GTK_SPIN_BUTTON(spin));
	update_timer(timer);
}


void
on_default_timer_clicked               (GtkButton       *button,
                                        gpointer         user_data)
{
	reset_timer();
}

void
on_reference_button_clicked            (GtkButton       *button,
                                        gpointer         user_data)
{
	if(!GTK_IS_WIDGET(gdictpref)) {
		gdictpref=create_preference();
	}
	gtk_widget_show(gdictpref);
}

void
on_wordcheck_toggled                   (GtkToggleButton *togglebutton,
                                        gpointer         user_data)
{
	rpref.word= GTK_TOGGLE_BUTTON(togglebutton)->active;
}


void
on_phoncheck_toggled                   (GtkToggleButton *togglebutton,
                                        gpointer         user_data)
{
	rpref.phonetic= GTK_TOGGLE_BUTTON(togglebutton)->active;
}


void
on_transcheck_toggled                  (GtkToggleButton *togglebutton,
                                        gpointer         user_data)
{
	rpref.trans= GTK_TOGGLE_BUTTON(togglebutton)->active;
}


void
on_pausecheck_toggled                  (GtkToggleButton *togglebutton,
                                        gpointer         user_data)
{
	rpref.pause= GTK_TOGGLE_BUTTON(togglebutton)->active;
}


gboolean
on_recitePopupText_button_press_event  (GtkWidget       *widget,
                                        GdkEventButton  *event,
                                        gpointer         user_data)
{
	if(event->type == GDK_BUTTON_PRESS && event->button == 3 ) {
		if(!GTK_IS_WIDGET(gdictpref)) {
			gdictpref=create_preference();
		}
  		gtk_widget_show(gdictpref);
	}
  	return FALSE;
}

void
on_nextbutton_clicked                  (GtkButton       *button,
                                        gpointer         user_data)
{
	update_rc(NEXT_WORD);
}


void
on_Backbutton_clicked                  (GtkButton       *button,
                                        gpointer         user_data)
{
	update_rc(PREV_WORD);
}


void
on_reloadbutton_clicked                (GtkButton       *button,
                                        gpointer         user_data)
{
	mydict_reloadplugins();
}

gboolean
on_myNotebook_button_press_event       (GtkWidget       *widget,
                                        GdkEventButton  *event,
                                        gpointer         user_data)
{
	if(event->type == GDK_BUTTON_RELEASE && event->button == 3 )
	{
		update_disp();
	}
  	return FALSE;
}


void
on_nonengbutton_toggled                (GtkToggleButton *togglebutton,
                                        gpointer         user_data)
{
    if(GTK_TOGGLE_BUTTON(togglebutton)->active) {
        eng_platform(FALSE);
    }else
        eng_platform(TRUE);
}

void
on_recitelist_select_row               (GtkCList        *clist,
                                        gint             row,
                                        gint             column,
                                        GdkEvent        *event,
                                        gpointer         user_data)
{
	gchar *text;
	gtk_clist_get_text(clist,row,column,&text);	
	update_db(row);
}

void
on_recitedb_clicked                    (GtkButton       *button,
                                        gpointer         user_data)
{
	update_recitedb_list();
}

