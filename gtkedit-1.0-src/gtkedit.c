/* 
 gtkedit.c
 Version 1.0 - March 5th, 2006
 A simple notepad-like editor, based on GTK+ 1.2

 How to build:
    gcc gtkedit.c -o gtkedit `gtk-config --cflags --libs` 
 To generate pot (translation template) file:
    xgettext -d gtkedit --keyword=_ --keyword=N_  -o gtkedit.pot gtkedit.c
    
 NEW: internationalization (with gettext)

 TODO: Printing, session management...
  
 gtkedit is released under the MIT license:

 Copyright (c) 2005-2006 Daniel Guerrero Miralles
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
----+----|----+----|----+----|----+----|----+----|----+----|----+----|----+----|
*/

#include <gtk/gtk.h>
#include <gdk/gdkkeysyms.h>	/* GDK_Escape */
#include <stdlib.h> 		/* atoi */
#include <stdio.h> 		/* fopen, fread, etc */
#include <unistd.h>		/* access, chdir */
#include <errno.h>		/* errno */
#include <string.h>		/* strlen */
#include <ctype.h>		/* toupper */

/* gettext stuff */
#include <libintl.h>		/* gettext */
#define _(x) gettext(x)		/* to make code more readable */
#define N_(x) (x)		/* no-op for gettext */

/* default window size */
#define DEFAULT_WIDTH 600
#define DEFAULT_HEIGHT 400

#define ACTION_WRAP 1 /* action code for word wrap */

#define BUFFER_MAX (64 * 1024) /* disk i/o buffer size */

/* global application status */
static struct Application {
	GtkWidget * window;
	GtkWidget * vscroll;
	GtkWidget * text_widget;
	GtkWidget * line_wrap_menu_item;
	gchar * file_name;
	gboolean unsaved_changes; 
	gchar * font_name;
} app = { 
	NULL, /* window */
	NULL, /* vscroll */
	NULL, /* text_widget */
	NULL, /* line_wrap_menu_item */
	NULL, /* file_name */
	FALSE, /* unsaved_changes */
	NULL, /* font_name */
};

/* the same for the find dialog */
static struct FindDialog {
	GtkWidget * dlg;
	GtkWidget * find_entry;
	GtkWidget * case_check;
	GtkWidget * backwards_check;
	GtkWidget * replace_label;
	GtkWidget * replace_entry;
	GtkWidget * replace_button;
	GtkWidget * replace_all_button;
} find_dlg = {
	NULL, /* dlg */
	NULL, /* find_entry */
	NULL, /* case_check */
	NULL, /* backwards_check */
	NULL, /* replace_label */
	NULL, /* replace_entry */
	NULL, /* replace_button */
	NULL, /* replace_all_button */
};

/* undo "buffer" status */
static struct Action {
	gboolean valid;
	gboolean was_delete;
	gboolean was_undo;
	gint pos;
	gchar * text;
	gint len;
} last_action = {
	FALSE, /* valid */
	FALSE, /* was_delete */
	FALSE, /* was_undo */
	0, /* pos */
	NULL, /* text */
	0, /* len */
};

/* CONFIG FILE CODE 
 *
 * code to load, save and set persistent settings */

/* Returns the config file full name, including path */
static gchar * rc_name (void)
{
	static gchar * name = NULL;

	/* construct only the first time */	
	if (NULL == name) {
		name = g_strconcat (g_get_home_dir (), 	
			G_DIR_SEPARATOR_S ".gtkeditrc",	NULL);
	}
	
	return name;
}

/* Save current settings in a file */
static void save_cfg (void)
{
	FILE * f;
	gchar * font_name;
	
	f = fopen (rc_name (), "w+");
	if (NULL == f) {
		g_printerr ("Error %d opening file '%s' for writting.\n",
			errno, rc_name ());
		return;
	}
	
	font_name = (NULL == app.font_name) ? "-" : app.font_name;
	
	fprintf (f, "font=%s\nlinewrap=%d\nwidth=%d\nheight=%d\n", 
		font_name, 
		GTK_CHECK_MENU_ITEM (app.line_wrap_menu_item)->active, 
		GTK_WIDGET (app.window)->allocation.width,
		GTK_WIDGET (app.window)->allocation.height);
				
	fclose (f);
}

/* Change the text font to the named one. Returns FALSE on failure. */
static gboolean set_font (gchar * name)
{
	GtkStyle * style;
	GdkFont * font;

	g_assert (NULL != name);
	g_assert ('\0' != name [0]);
	
	font = gdk_font_load (name);
	if (NULL == font) {
		return FALSE;
	}
	style = gtk_style_copy (gtk_widget_get_style (app.text_widget));
	gdk_font_unref (style->font);
	style->font = font;
	gtk_widget_set_style (app.text_widget, style);
	g_free (app.font_name);
	app.font_name = g_strdup (name);
	return TRUE;
}

/* Load and set the saved configuration or defaults if it is not found
 * or is broken. */
static void load_cfg (void)
{
	FILE * f;
	gchar font_name[256];
	gint wrap, width, height;
	int num;

	f = fopen (rc_name (), "r");
	if (NULL == f) {
		g_printerr ("Error %d opening file '%s' for reading\n", 
			errno, rc_name ());
		num = 0;
	} else {
		num = fscanf (f, "font = %255[^\n] linewrap = %d width = "
			"%d height = %d", font_name, &wrap, &width, &height);
		fclose (f);
	}
	
	if (num == 4) {
		gtk_check_menu_item_set_active (
			GTK_CHECK_MENU_ITEM (app.line_wrap_menu_item), wrap);
		
		gtk_window_set_default_size (GTK_WINDOW (app.window), 
			width, height);
		if (0 != strcmp ("-", font_name)) {
			set_font (font_name);
		}
	} else {
		/* use defaults */
		gtk_check_menu_item_set_active (
			GTK_CHECK_MENU_ITEM (app.line_wrap_menu_item), TRUE);
		gtk_window_set_default_size (GTK_WINDOW (app.window), 
			DEFAULT_WIDTH, DEFAULT_HEIGHT);
	}
}

/* DIALOG CODE 
 *
 * This code deals with things like adding shortcuts to dialog buttons, making
 * dialogs modal, showing simple messages and such. */ 

/* create a new button with shortcut. Actually two shortcuts are added, 
 * <char> and <Alt>+<char>, for dialogs with editables where <char> alone
 * is grabed by the editable. */
static GtkWidget * accel_button_new (const gchar * caption, GtkAccelGroup * 
accel_group)
{
	GtkWidget * button;
	GtkWidget * label;
	guint keyval;

	button = gtk_button_new ();
	GTK_WIDGET_SET_FLAGS (button, GTK_CAN_DEFAULT);
	label = gtk_label_new (NULL);
	gtk_container_add (GTK_CONTAINER (button), label);
	keyval = gtk_label_parse_uline (GTK_LABEL (label), caption);
	gtk_widget_add_accelerator (button, "clicked", accel_group, keyval, 
		0, GTK_ACCEL_LOCKED);
	gtk_widget_add_accelerator (button, "clicked", accel_group, keyval, 
		GDK_MOD1_MASK, GTK_ACCEL_LOCKED);
	return button;
}

/* set some common settings and show the dialog */
static void show_dlg (GtkWidget * dlg)
{
	gtk_window_set_transient_for (GTK_WINDOW (dlg), GTK_WINDOW (
		app.window));
	/* not user-resizable */
	gtk_window_set_policy (GTK_WINDOW (dlg), FALSE, FALSE, TRUE);
	gtk_window_set_position (GTK_WINDOW (dlg), GTK_WIN_POS_CENTER);
	gtk_widget_show_all (dlg);
}

/* Show a modal dialog. This function will not return until the dialog 
 * has been dismised. */
static void do_modal_dlg (GtkWidget * dlg)
{
	gtk_window_set_modal (GTK_WINDOW (dlg), TRUE);
	gtk_signal_connect (GTK_OBJECT (dlg), "destroy", GTK_SIGNAL_FUNC 
		(gtk_main_quit), NULL);
	show_dlg (dlg);
	gtk_main (); 
}

/* Called when a button is pressed in a msg dialog. Sets the variable pointed
 * by data (a guint) with the value of the "index" property, this way the
 * dialog can discover which button was pressed. */
static void on_msg_btn (GtkWidget * widget, gpointer data)
{
	guint index;

	index = GPOINTER_TO_UINT (gtk_object_get_data (GTK_OBJECT (widget), 
		"index"));
	*(guint *)data = index;
}

/* Show a modal dialog with a message and several buttons. It expects a 
 * NULL terminated list of button captions. The def_btn parameter is the index 
 * of the default button (0 beeing the first one). If no valid default is 
 * provided the user will not be able to dismiss the dialog with return or
 * escape.
 * The function returns the index of the pressed button. */
static guint show_msg2 (const gchar * msg, const guint def_btn, ...)
{
	va_list vl;
	const gchar * button_caption;
	GtkWidget * dlg;
	GtkWidget * box;
	GtkWidget * w;
	GtkAccelGroup * accel_group;
	guint result;
	guint index;
	gboolean have_default;

	dlg = gtk_dialog_new ();
	gtk_container_set_border_width (GTK_CONTAINER (GTK_DIALOG (dlg)->vbox),
		5);
	w = gtk_label_new (msg);
	gtk_container_add (GTK_CONTAINER (GTK_DIALOG (dlg)->vbox), w);
	/* a HButtonBox is better than a regular HBox for buttons */
	box = gtk_hbutton_box_new ();
	gtk_container_add (GTK_CONTAINER (GTK_DIALOG (dlg)->action_area), 
		box);
	accel_group = gtk_accel_group_new ();
	gtk_window_add_accel_group (GTK_WINDOW (dlg), accel_group);

	va_start (vl, def_btn);
	index = 0;
	have_default = FALSE;
	button_caption = va_arg (vl, const gchar *);
	while (NULL != button_caption) {
		w = accel_button_new (button_caption, accel_group);
		gtk_signal_connect (GTK_OBJECT (w), "clicked", 
			GTK_SIGNAL_FUNC (on_msg_btn), (gpointer) &result);
		gtk_signal_connect_object (GTK_OBJECT (w), "clicked", 
			GTK_SIGNAL_FUNC (gtk_widget_destroy), (gpointer) dlg);
		gtk_object_set_data (GTK_OBJECT (w), "index", 
			GUINT_TO_POINTER (index));
		gtk_box_pack_start_defaults (GTK_BOX (box), w);
		if (def_btn == index) {
			have_default = TRUE;
			gtk_window_set_default (GTK_WINDOW (dlg), w);
			gtk_widget_add_accelerator (w, "clicked", 
				accel_group, GDK_Escape, 0, GTK_ACCEL_LOCKED);
			result = def_btn;
		}
		index++;
		button_caption = va_arg (vl, const gchar *);
	};
	va_end (vl);
	if (!have_default) {
		/* do not allow to close unless something is chosen */
		gtk_signal_connect (GTK_OBJECT (dlg), "delete_event", 
			GTK_SIGNAL_FUNC (gtk_true), NULL);
	}
	do_modal_dlg (dlg);

	return result;
}

/* show a message with an OK button */
#define show_msg(m) show_msg2 (m, 0, _("_OK"), NULL)

/* show a message with Yes and No buttons. You can provide the default answer,
 * YN_YES / YN_NO, or YN_NODEFAULT if you want the user to choose explicitly 
 * Yes or No. */
enum YesNoDefault { YN_NO, YN_YES, YN_NODEFAULT };
#define show_yesno(m, d) show_msg2 (m, d, _("_No"), _("_Yes"), NULL)

#define should_discard_changes() (1 == show_msg2 (_("Unsaved changes will be"\
	" lost. Continue ?"), 0, _("_Cancel"), _("_OK"), NULL))

/* show a system error (similar to perror, but you provide the error code) */
static void show_error (const gchar * prefix, const int code)
{
	gchar * str;

	str = g_strconcat (prefix, ":\n", g_strerror (code), NULL);
	show_msg (str);
	g_free (str);
}

/* BASIC FUNCTIONALITY */

/* the name says it all */
static void update_window_title (void)
{
	const gchar * fname;
	const gchar * saved;
	gchar * str;

	fname = (NULL == app.file_name) ? _("Untitled") : g_basename (
		app.file_name);
	saved = (app.unsaved_changes) ? _(" [not saved]") : "";
	str = g_strconcat (fname, saved, " - gtkedit", NULL);
	gtk_window_set_title (GTK_WINDOW (app.window), str);
	g_free (str);
}

/* called every time the text widget content changes */
static void on_text_changed (GtkWidget * widget, gpointer data)
{
	if (!app.unsaved_changes) {
		app.unsaved_changes = TRUE;
		update_window_title ();
	}
}

/* called when the user selects File>Quit */
static void on_file_quit (GtkWidget * widget, gpointer data)
{
	GdkEvent event;

	/* simulate a delete event */
	event.any.type = GDK_DELETE;
	event.any.window = GTK_WIDGET (app.window)->window;
	event.any.send_event = TRUE;
	gtk_main_do_event (&event);
}

/* called when the main window is closed by the window manager */
static gint on_delete_event (GtkWidget * widget, GdkEvent * event, 
gpointer data)
{
	if (app.unsaved_changes) {
		if (!should_discard_changes ()) {
			/* return TRUE to prevent closing */
			return TRUE;
		}
	} 
	
	/* save config file before quiting */
	save_cfg ();
	
	return FALSE;
}

/* called when the user selects Edit>Cut on the menu */
static void on_edit_cut (GtkWidget * widget, gpointer data)
{
	gtk_editable_cut_clipboard (GTK_EDITABLE (app.text_widget));
}

/* called when the user selects Edit>Copy on the menu */
static void on_edit_copy (GtkWidget * widget, gpointer data)
{
	gtk_editable_copy_clipboard (GTK_EDITABLE (app.text_widget));
}

/* called when the user selects Edit>Paste on the menu */
static void on_edit_paste (GtkWidget * widget, gpointer data)
{
	gtk_editable_paste_clipboard (GTK_EDITABLE (app.text_widget));
}

/* called when the user selects Edit>Select All on the menu */
static void on_edit_select_all (GtkWidget * widget, gpointer data)
{
	gtk_editable_select_region (GTK_EDITABLE (app.text_widget), 0, -1);
}

/* called when the user selects Format>Wrap long lines */
static void on_format_line_wrap (GtkWidget * widget, gpointer data)
{
	guint wrap;

	wrap = GTK_CHECK_MENU_ITEM (app.line_wrap_menu_item)->active;
	gtk_text_set_line_wrap (GTK_TEXT (app.text_widget), wrap);
}

/* called when the user selects Help>About */
static void on_help_about (GtkWidget * widget, gpointer data)
{
	GString * s;
	
	s = g_string_new (NULL);
	g_string_sprintf (s, _("gtkedit %s\n\n" \
		"A minimalistic text editor based on GTK+\n" \
		"Copyright (c) %s Daniel Guerrero Miralles\n"
		"\n"
		"This program is released under the MIT license.\n"
		"Read the accompanying LICENSE.txt file for details."), 
		"1.0", "2005-2006");
	show_msg (s->str);
	g_string_free (s, TRUE);
}

/* UNDO/REDO CODE 
 * 
 * This code saves informaction to revert edit actions (insertions or 
 * deletions). If the previous action is the same as the current one, 
 * it gets merged instead of replaced. This allows decent undo functionality 
 * withou much complexity. */

/* this function gets called when new text is inserted into the text widget */
static void on_insert_text (GtkEditable * editable, const gchar * new_text, 
const gint text_len, const gint * pos, gpointer user_data)
{
	gchar * text;
	gchar * tmp_text;
	
	text = g_strndup (new_text, text_len); /* null terminate it */
	if (!last_action.was_delete 
	&& (*pos == last_action.pos + last_action.len) 
	&& last_action.valid 
	&& !last_action.was_undo) {
		tmp_text = g_strconcat (last_action.text, text, NULL);
		g_free (last_action.text);
		last_action.text = tmp_text;
		last_action.len += text_len;
	} else {
		last_action.valid = TRUE;
		last_action.was_delete = FALSE;
		g_free (last_action.text);
		last_action.text = text;
		text = NULL;
		last_action.pos = *pos;
		last_action.len = text_len;
	}
	g_free (text);
	last_action.was_undo = FALSE;
}

/* in the same vein, this function is called when text is deleted. */
static void on_delete_text (GtkEditable * editable, const gint start_pos, 
const gint end_pos, gpointer user_data)
{
	gchar * text;
	gchar * tmp_text;

	text = gtk_editable_get_chars (GTK_EDITABLE (app.text_widget), 
		start_pos, end_pos);
	if (last_action.was_delete 
	&& (start_pos == last_action.pos || end_pos == last_action.pos) 
	&& last_action.valid 
	&& !last_action.was_undo) {
		last_action.len += (end_pos - start_pos);
		if (start_pos != last_action.pos) {
			last_action.pos = start_pos;
			tmp_text = g_strconcat (text, last_action.text, NULL);
		} else {
			tmp_text = g_strconcat (last_action.text, text, NULL);
		}
		g_free (last_action.text);
		last_action.text = tmp_text;
	} else {
		last_action.valid = TRUE;
		last_action.was_delete = TRUE;
		g_free (last_action.text);
		last_action.text = text;
		text = NULL;
		last_action.pos = start_pos;
		last_action.len = end_pos - start_pos;
	}
	g_free (text);
	last_action.was_undo = FALSE;
}

#define reset_undo() {last_action.valid = FALSE; g_free (last_action.text); \
	last_action.text = NULL;}

/* called when the user selects Edit>Undo */
static void on_edit_undo (GtkWidget * widget, gpointer data)
{
	gint pos;

	if (last_action.valid) {
		if (last_action.was_delete) {
			pos = last_action.pos;
			gtk_editable_insert_text (GTK_EDITABLE (
				app.text_widget), last_action.text, 
				last_action.len, &pos);
			last_action.was_delete = FALSE;
		} else {
			gtk_editable_delete_text (GTK_EDITABLE (
				app.text_widget), last_action.pos, 
				last_action.pos + last_action.len);
			last_action.was_delete = TRUE;
		}
		last_action.was_undo = TRUE;
	}
}

/* FILE IO CODE 
 * 
 * Easy there. Files are read and written in chunks of MAX_BUFFER to avoid
 * hogging the memory in case the user tries to load some GigaBytes. */

/* check file existence */
#define file_exists(f) (0 == access (f, 0))

/* clear the text widget and app status */
static void discard_current_file (void)
{
	g_free (app.file_name);
	app.file_name = NULL;
	gtk_editable_delete_text (GTK_EDITABLE (app.text_widget), 0, -1);
	reset_undo ();
	app.unsaved_changes = FALSE;
}

/* called when the user selects File>New on the menu */
static void on_file_new (GtkWidget * widget, gpointer data)
{
	if (app.unsaved_changes) {
		if (!should_discard_changes ()) {
			return;
		}
	} 
	discard_current_file ();
	update_window_title ();
}

/* Take the dir from the file name and make it the current dir. 
 * We should probably make it an absolute path first, but the file selector
 * always returns an absolute path, even if nowhere says it should. */
static void change_to_file_dir (const gchar * name)
{
	gchar * dir;

	dir = g_dirname (name);
	if (NULL != dir) {
		chdir (dir);
		g_free (dir);
	}
}

/* Read a file into the text widget. If there is an error the text widget is
 * cleared and the error is shown to the user. If all is OK, stores the current
 * file name. It resets the undo buffer. */
/* FIXME: actually this function does too much */
static gboolean read_file (const gchar * name)
{
	FILE * f;
	gchar buffer [BUFFER_MAX];
	size_t chars_read;
	gint pos;
	int error;

	/* all previous content should have been discarded */
	g_assert (NULL == app.file_name);
	gtk_text_freeze (GTK_TEXT (app.text_widget));
	error = 0;
	f = fopen (name, "r");
	if (NULL != f) {
		pos = 0;
		do {
			chars_read = fread (buffer, sizeof (gchar), 
				sizeof (buffer), f);
			gtk_editable_insert_text (GTK_EDITABLE (
				app.text_widget), buffer, chars_read, &pos);
		} while (0 != chars_read);
		if (ferror (f)) {
			error = errno;
			discard_current_file ();
		}
		fclose (f);
	} else {
		error = errno;
	}
	reset_undo ();
	app.unsaved_changes = FALSE;
	change_to_file_dir (name);
	gtk_text_thaw (GTK_TEXT (app.text_widget));
	if (0 != error) {
		show_error (name, error);
		return FALSE;
	}
	/* everything went OK, now we can save the name */
	app.file_name = g_strdup (name);
	return TRUE; 
}

/* Create or overwrite the file with the text widget contents.
 * Errors are displayed to the user. */
static void save_file (void)
{
	gchar * buffer;
	size_t chars_written;
	FILE * f;
	guint size, buffer_len;
	gint pos;

	g_assert (NULL != app.file_name);
	change_to_file_dir (app.file_name);
	f = fopen (app.file_name, "w");
	if (NULL != f) {
		pos = 0;
		size = gtk_text_get_length (GTK_TEXT (app.text_widget));
		do {
			buffer_len = MIN (BUFFER_MAX, size);
			buffer = gtk_editable_get_chars (GTK_EDITABLE (
				app.text_widget), pos, pos + buffer_len);
			pos += buffer_len;
			size -= buffer_len;
			chars_written = fwrite (buffer, sizeof (gchar), 
				buffer_len, f);
			g_free (buffer);
		} while (chars_written != 0);
		if (ferror (f)) {
			show_error (app.file_name, errno);
		} else {
			app.unsaved_changes = FALSE;
		}
		fclose (f);
		update_window_title ();
	} else {
		show_error (app.file_name, errno);
	} 
}

/* Called when the user selects a file to open from the selection dialog.
 * If the file can be loaded the file selector is closed. */
static void on_open_file_selected (GtkWidget * widget, gpointer data)
{
	gchar * name;

	name = gtk_file_selection_get_filename (GTK_FILE_SELECTION (data));
	if (NULL == name) {
		return;
	}
	discard_current_file ();
	if (read_file (name)) {
		/* close the file selector */
		gtk_widget_destroy (GTK_WIDGET (data));
		update_window_title ();
	}
}

/* called when the user has chosen a name to save the file with. If the file
 * can be saved the file selector is closed. */
static void on_save_file_selected (GtkWidget * widget, gpointer data)
{
	gchar * name;

	name = gtk_file_selection_get_filename (GTK_FILE_SELECTION (data));
	if (NULL == name) {
		return;
	}
	if (file_exists (name)) {
		if (YN_NO == show_yesno (_("Overwrite this file ?"), YN_NO)) {
			return;
		}
	}
	g_free (app.file_name);
	app.file_name = g_strdup (name);
	gtk_widget_destroy (GTK_WIDGET (data));
	save_file ();
}

/* show the Open/Save file selector.
 * The dialog is modal to avoid problems if the user tries to open it more 
 * than once. */ 
enum selector_kind { OPEN_SELECTOR, SAVE_SELECTOR };
static void do_file_selector (enum selector_kind mode)
{
	GtkWidget * selector;
	GtkAccelGroup * accel_group;

	if (OPEN_SELECTOR == mode) {
		selector = gtk_file_selection_new (_("Open file"));
		gtk_signal_connect (GTK_OBJECT (GTK_FILE_SELECTION (
			selector)->ok_button), "clicked", GTK_SIGNAL_FUNC (
			on_open_file_selected), (gpointer) selector);
	} else { /* save selector */
		selector = gtk_file_selection_new (_("Save file"));
		if (NULL != app.file_name) {
			gtk_file_selection_set_filename (
				GTK_FILE_SELECTION (selector), app.file_name);
		}
		gtk_signal_connect (
			GTK_OBJECT (GTK_FILE_SELECTION (selector)->ok_button), 
			"clicked", GTK_SIGNAL_FUNC (on_save_file_selected), 
			(gpointer) selector);
	}
	gtk_signal_connect_object (
		GTK_OBJECT (GTK_FILE_SELECTION (selector)->cancel_button), 
		"clicked", GTK_SIGNAL_FUNC (gtk_widget_destroy), 
		(gpointer) selector);
	accel_group = gtk_accel_group_new ();
	gtk_window_add_accel_group (GTK_WINDOW (selector), accel_group);
	gtk_widget_add_accelerator (
		GTK_FILE_SELECTION (selector)->cancel_button, 
		"clicked", accel_group, GDK_Escape, 0, GTK_ACCEL_LOCKED);
	do_modal_dlg (selector);
}

/* called when the user selects the File>Open menu option. */
static void on_file_open (GtkWidget * widget, gpointer data)
{
	if (app.unsaved_changes) {
		if (!should_discard_changes ()) {
			return;
		}
	} 
	do_file_selector (OPEN_SELECTOR);
}

/* called when the user selects the File>Save As menu option */
static void on_file_save_as (GtkWidget * widget, gpointer data)
{
	do_file_selector (SAVE_SELECTOR);
}

/* called when the user selects the File>Save menu option */
static void on_file_save (GtkWidget * widget, gpointer data)
{
	/* if there's no name yet ask for it */
	if (NULL == app.file_name) {
		do_file_selector (SAVE_SELECTOR);
	} else {
		save_file ();
	}
}

/* DRAG AND DROP CODE
 *
 * The editor accepts files dragged from the file manager. These files are
 * file names in the form of URIs (Uniform Resource Identifiers), that 
 * look like: "todo.txt", but also "file:todo.txt" or even
 * "file://localhost/home/daniel/things%20to%20do.txt" */

/* Calculate the value of an hex digit from its ASCII representation.
 * This code only takes the lowest 5 bits into account, so it will only
 * work if d is really the ASCII representation of an hex digit.*/
static const gchar xval_lookup [32] = { 
	0, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 0, 0, 0, 0, 0 };
#define xval(d) xval_lookup[(d) & 31]

/* URIs escape some characters (spaces for instance) as %hh, where hh are
 * hex digits. This code unescapes them. The resulting string must be 
 * freed with g_free() when no longer needed, and is guaranteed to be
 * null-terminated. Returns NULL on error. */
static gchar * unescape (const gchar * escaped, size_t len)
{
	gchar * result;
	gchar * pr;

	if (1 > len) {
		return NULL;
	}
	result = g_malloc (len + 1);
	pr = result;
	while (0 < len) {
		if ('%' != *escaped) {
			*pr = *escaped;
			escaped++;
			len--;
		} else {
			if ((len < 3) || !isxdigit (escaped[1]) 
			|| !isxdigit (escaped[2])) {
				/* invalid escapement */
				g_free (result);
				return NULL;
			}
			*pr = xval (escaped[1]) << 4 | xval (escaped[2]);
			escaped += 3;
			len -= 3;
		}
		pr++;
	}
	*pr = '\0';
	return result;
}

/* Naive uri parser. Only works for local file uris. Returns NULL on error or
 * a string that must be disposed with g_free (). */
static gchar * path_from_local_uri (const gchar * uri)
{
	size_t len;

	g_assert (NULL != uri);
	len = strcspn (uri, ":/?#");
	if (':' == uri[len]) {
		if ((4 != len) || 0 != strncmp ("file", uri, 4)) {
			/* invalid scheme */
			return NULL;
		}
		uri += 5;
	}
	if (0 == strncmp ("//", uri, 2)) {
		uri += 2;
		if (0 == strncmp ("localhost/", uri, 10)) {
			uri += 9;
		} else if ('/' != *uri) {
			/* invalid authority */
			return NULL;
		}
	}
	len = strcspn (uri, "?#");
	return unescape (uri, len);
}

/* open a file coming from drag and drop */
static void drag_open (const gchar * name)
{
	if (app.unsaved_changes) {
		if (!should_discard_changes ()) {
			return;
		}
	}
	discard_current_file ();
	if (read_file (name)) {
		update_window_title ();
	}
}

/* Called when the user drags a URI list over the text widget */
static void on_drag_data (GtkWidget * widget, GdkDragContext * drag_context, 
gint x, gint y, GtkSelectionData * sel_data, guint info, gpointer user_data)
{
	gchar * path;
	gchar ** uris;
	int i;

	/* sanity checks */
	if ((0 != info) || (NULL == sel_data)) {
		return;
	}
	if ((NULL == sel_data->data) || (0 == sel_data->length)) {
		return;
	}

	/* use the first valid uri */
	uris = g_strsplit ((gchar *) sel_data->data, "\r\n", -1);
	path = NULL;
	for (i = 0; NULL == path && NULL != uris [i]; i++) {
		path = path_from_local_uri (uris [i]);
	}
	if (NULL != path) {
		drag_open (path);
		g_free (path);
	} else {
		show_msg (_("The file is not local or the name is invalid"));
	}
	g_strfreev (uris);
}

/* FIND, REPLACE AND GO TO LINE CODE 
 * 
 * Find and replace use a single dialog that is created at startup and hidden 
 * when not in use. This way, we don't need to save its status. 
 * The seach algorithm is very simple, but works well and fast enough. */

/* return the position of the next match, begining from the cursor pos. */
static guint next_match_pos (const guint from, const gchar * text, 
const gboolean match_case, const gboolean backwards)
{
	guint pos, pos_max;
	guint to_match, find_len;
	gchar * find_text;
	gchar c;
	GtkText * text_widget;

	/* we don't want to modify the parameter, make a copy */
	find_text = g_strdup (text);
	if (!match_case) {
		g_strup (find_text);
	}
	g_assert (NULL != find_text);
	find_len = strlen (find_text);
	text_widget = GTK_TEXT (app.text_widget);
	pos_max = gtk_text_get_length (text_widget);
	to_match = find_len;
	if (backwards) {
		for (pos = MIN (from, pos_max); pos > 0 && 0 != to_match; 
		pos--) {
			c = GTK_TEXT_INDEX (text_widget, pos - 1);
			if (!match_case) {
				c = toupper (c);
			}
			if (find_text [to_match - 1] == c) {
				to_match--;
			} else {
				to_match = find_len;
			}
		}
	} else {
		for (pos = from; pos < pos_max && 0 != to_match; pos++) {
			c = GTK_TEXT_INDEX (text_widget, pos);
			if (!match_case) {
				c = toupper (c);
			}
			if (find_text [find_len - to_match] == c) {
				to_match--;
			} else {
				to_match = find_len;
			}
		}
		pos -= find_len;
	}
	g_free (find_text);
	return (0 == to_match) ? pos : (guint) -1;
}

/* Ensure that the line containing the character pos is visible. This is a hack 
 * to prevent the text widget from doing the scroll itself, because it is 
 * painfully slow. */
static void scroll_to_pos (const guint dest_pos)
{
	guint pos, pos_max;
	guint dest_line, cur_line;
	GtkAdjustment * adj;
	gfloat scroll_pos;
	GtkText * text_widget;

	cur_line = 1;
	text_widget = GTK_TEXT (app.text_widget);
	pos_max = gtk_text_get_length (text_widget);
	for (pos = 0; pos < pos_max && pos < dest_pos; pos++) {
		if ('\n' == GTK_TEXT_INDEX (text_widget, pos)) {
			cur_line++;
		}
	}
	dest_line = cur_line;
	for (; pos < pos_max; pos++) {
		if ('\n' == GTK_TEXT_INDEX (text_widget, pos)) {
			cur_line++;
		}
	}
	adj = text_widget->vadj;
	scroll_pos = dest_line * (adj->upper - adj->lower) / cur_line;
	gtk_adjustment_clamp_page (adj, scroll_pos, scroll_pos);
}

/* find the next occurrence of the search string in the find/replace dialog */
static void find_next (void)
{
	guint pos, len;
	gchar * find_text;
	gboolean match_case, backwards;

	backwards = gtk_toggle_button_get_active (
		GTK_TOGGLE_BUTTON (find_dlg.backwards_check));
	match_case = gtk_toggle_button_get_active (
		GTK_TOGGLE_BUTTON (find_dlg.case_check));
	pos = gtk_editable_get_position (GTK_EDITABLE (app.text_widget));
	find_text = gtk_entry_get_text (GTK_ENTRY (find_dlg.find_entry));
	if (NULL == find_text) {
		return;
	}
	len = strlen (find_text);
	pos = next_match_pos (pos, find_text, match_case, backwards);
	if (-1 != (guint) pos) {
		scroll_to_pos (pos);
		if (backwards) {
			gtk_editable_set_position (GTK_EDITABLE (
				app.text_widget), pos);
		} else {
			gtk_editable_set_position (GTK_EDITABLE (
				app.text_widget), pos + len);
		}
		gtk_editable_select_region (GTK_EDITABLE (app.text_widget), 
			pos, pos + len);
	} else {
		show_msg (_("No more ocurrences found"));
	}
}

/* Called when the user selects the Find button on the find dialog */
static void on_find_selected (GtkWidget * widget, gpointer data)
{
	find_next ();
}

/* Called when the user select the Replace button on the find dialog 
 * It replaces the current selection and finds the next match. */
static void on_replace_selected (GtkWidget * widget, gpointer data)
{
	gchar * replace_text;
	gint replace_len;
	gint pos;

	if (GTK_EDITABLE (app.text_widget)->has_selection) {
		replace_text = gtk_entry_get_text (GTK_ENTRY (
			find_dlg.replace_entry));
		if (NULL == replace_text) {
			return;
		}
		replace_len = strlen (replace_text);
		gtk_editable_delete_selection (GTK_EDITABLE (
			app.text_widget));
		pos = gtk_editable_get_position (GTK_EDITABLE (
			app.text_widget));
		gtk_editable_insert_text (GTK_EDITABLE (app.text_widget),
			replace_text, replace_len, &pos);
	} 
	find_next ();
}

/* Called when the user hits the Replace All button on the find dialog */
static void on_replace_all_selected (GtkWidget * widget, gpointer data)
{
	gint pos;
	gchar * find_text, * replace_text;
	gint find_len, replace_len;
	gboolean match_case, backwards;

	find_text = gtk_entry_get_text (GTK_ENTRY (find_dlg.find_entry));
	if (NULL == find_text) {
		return;
	}
	find_len = strlen (find_text);
	replace_text = gtk_entry_get_text (GTK_ENTRY (
		find_dlg.replace_entry));
	if (NULL == replace_text) {
		return;
	}
	backwards = gtk_toggle_button_get_active (
		GTK_TOGGLE_BUTTON (find_dlg.backwards_check));
	match_case = gtk_toggle_button_get_active (
		GTK_TOGGLE_BUTTON (find_dlg.case_check));
	replace_len = strlen (replace_text);
	if (YN_YES == show_yesno (_("Replace all occurrences from the"\
	" current position ?"), YN_NO)) {
		pos = gtk_editable_get_position (GTK_EDITABLE (
			app.text_widget));
		pos = next_match_pos (pos, find_text, match_case, backwards);
		while ((guint) -1 != pos) {
			gtk_editable_delete_text (GTK_EDITABLE (
				app.text_widget), pos, pos + find_len);
			gtk_editable_insert_text (GTK_EDITABLE (
				app.text_widget), replace_text, replace_len, 
				&pos);
			pos = next_match_pos (pos, find_text, match_case, 
				backwards);
		}
	}
}

/* Called when the user selects Edit>Find on the menu. Displays the find 
 * dialog. */
static void on_edit_find (GtkWidget * widget, gpointer data)
{
	gtk_widget_hide (find_dlg.replace_all_button);
	gtk_widget_hide (find_dlg.replace_button);
	gtk_widget_hide (find_dlg.replace_entry);
	gtk_widget_hide (find_dlg.replace_label);
	gtk_window_set_title (GTK_WINDOW (find_dlg.dlg), _("Find text"));
	gtk_widget_show (find_dlg.dlg);
}

/* Called when the user selects Edit>Find Again on the menu. Finds next match 
 * without displaying the find dialog. */
static void on_edit_find_again (GtkWidget * widget, gpointer data)
{
	gchar * find_text;

	/* if there's no previous seach, this is the same as "find" */
	find_text = gtk_entry_get_text (GTK_ENTRY (find_dlg.find_entry));
	if (NULL == find_text || '\0' == *find_text) {
		on_edit_find (widget, data);
	} else {
		find_next ();
	}
}

/* Called when the user selects Edit>Replace on the menu. Displays the find 
 * dialog. */
static void on_edit_replace (GtkWidget * widget, gpointer data)
{
	gtk_widget_show (find_dlg.replace_all_button);
	gtk_widget_show (find_dlg.replace_button);
	gtk_widget_show (find_dlg.replace_entry);
	gtk_widget_show (find_dlg.replace_label);
	gtk_window_set_title (GTK_WINDOW (find_dlg.dlg), _("Replace text"));
	gtk_widget_show (find_dlg.dlg);
}

/* Create the (initially) hidden find/replace dialog */
static void init_find_dialog (void) 
{
	GtkWidget * dlg;
	GtkWidget * w;
	GtkWidget * table;
	GtkAccelGroup * accel_group;
	GtkWidget * box;

	dlg = gtk_dialog_new ();
	find_dlg.dlg = dlg;
	gtk_signal_connect_object (GTK_OBJECT (dlg), "delete_event", 
		GTK_SIGNAL_FUNC (gtk_widget_hide), GTK_OBJECT (dlg));
	gtk_signal_connect (GTK_OBJECT (dlg), "delete_event", 
		GTK_SIGNAL_FUNC (gtk_true), NULL);
	accel_group = gtk_accel_group_new ();
	gtk_window_add_accel_group (GTK_WINDOW (dlg), accel_group);
	table = gtk_table_new (2, 2, FALSE);
	gtk_box_pack_start (GTK_BOX (GTK_DIALOG (dlg)->vbox), table, TRUE, 
		TRUE,0);
	w = gtk_label_new (_("Find :"));
	gtk_table_attach_defaults (GTK_TABLE (table), w, 0, 1, 0, 1);
	w = gtk_entry_new ();
	find_dlg.find_entry = w;
	gtk_signal_connect_object (GTK_OBJECT (w), "activate", 
		GTK_SIGNAL_FUNC (gtk_window_activate_default), 
		GTK_OBJECT (dlg));
	gtk_table_attach_defaults (GTK_TABLE (table), w, 1, 2, 0, 1);
	gtk_window_set_focus (GTK_WINDOW (dlg), w);
	w = gtk_label_new (_("Replace with: "));
	find_dlg.replace_label = w;
	gtk_table_attach_defaults (GTK_TABLE (table), w, 0, 1, 1, 2);
	w = gtk_entry_new ();
	find_dlg.replace_entry = w;
	gtk_signal_connect_object (GTK_OBJECT (w), "activate", 
		GTK_SIGNAL_FUNC (gtk_window_activate_default), 
		GTK_OBJECT (dlg));
	gtk_table_attach_defaults (GTK_TABLE (table), w, 1, 2, 1, 2);
	w = gtk_check_button_new_with_label (_("Case sensitive"));
	find_dlg.case_check = w;
	gtk_box_pack_start (GTK_BOX (GTK_DIALOG (dlg)->vbox), w, TRUE, TRUE, 
		0);
	w = gtk_check_button_new_with_label (_("Find backwards"));
	find_dlg.backwards_check = w;
	gtk_box_pack_start (GTK_BOX (GTK_DIALOG (dlg)->vbox), w, TRUE, TRUE, 
		0);
	box = gtk_hbutton_box_new ();
	gtk_container_add (GTK_CONTAINER (GTK_DIALOG (dlg)->action_area), 
		box);
	w = accel_button_new (_("_Find"), accel_group);
	gtk_signal_connect (GTK_OBJECT (w), "clicked", 
		GTK_SIGNAL_FUNC (on_find_selected), NULL);
	gtk_window_set_default (GTK_WINDOW (dlg), w);
	gtk_box_pack_start_defaults (GTK_BOX (box), w);
	w = accel_button_new (_("_Replace"), accel_group);
	find_dlg.replace_button = w;
	gtk_signal_connect (GTK_OBJECT (w), "clicked", 
		GTK_SIGNAL_FUNC (on_replace_selected), NULL);
	gtk_box_pack_start_defaults (GTK_BOX (box), w);
	w = accel_button_new (_("Replace _All"), accel_group);
	find_dlg.replace_all_button = w;
	gtk_signal_connect (GTK_OBJECT (w), "clicked", 
		GTK_SIGNAL_FUNC (on_replace_all_selected), NULL);
	gtk_box_pack_start_defaults (GTK_BOX (box), w);
	w = accel_button_new (_("_Close"), accel_group);
	gtk_signal_connect_object (GTK_OBJECT (w), "clicked", 
		GTK_SIGNAL_FUNC (gtk_widget_hide), GTK_OBJECT (dlg));
	gtk_widget_add_accelerator (w, "clicked", accel_group, GDK_Escape,
		0, GTK_ACCEL_LOCKED);
	gtk_box_pack_start_defaults (GTK_BOX (box), w);
	gtk_window_set_transient_for (GTK_WINDOW (dlg), GTK_WINDOW (
		app.window));
	gtk_window_set_policy (GTK_WINDOW (dlg), FALSE, FALSE, TRUE);
	gtk_widget_show_all (GTK_DIALOG (dlg)->vbox);
}

/* Called when the user presses the OK button in the Go To Line dialog. 
 * Finds and scrolls to the requested line number. */
static void on_line_number_selected (GtkWidget * widget, gpointer data)
{
	gchar * buffer;
	int dest_line, line;
	guint pos, bol_pos, eol_pos, max;
	gfloat scroll_pos;
	GtkAdjustment * adj;
	GtkText * text_widget;

	buffer = gtk_entry_get_text (GTK_ENTRY (data));
	dest_line = atoi (buffer);
	dest_line = MAX (dest_line, 1);
	line = 1;
	text_widget = GTK_TEXT (app.text_widget);
	max = gtk_text_get_length (text_widget);
	for (pos = 0; pos < max && line < dest_line; pos++) {
		if ('\n' == GTK_TEXT_INDEX (text_widget, pos)) {
			line++;
		}
	}
	bol_pos = pos;
	for (pos++; pos < max; pos++) {
		if ('\n' == GTK_TEXT_INDEX (text_widget, pos)) {
			line++;
			break;
		}
	}
	eol_pos = pos;
	for (pos++; pos < max; pos++) {
		if ('\n' == GTK_TEXT_INDEX (text_widget, pos)) {
			line++;
		}
	}
	g_assert (0 != line);
	adj = text_widget->vadj;
	scroll_pos = dest_line * (adj->upper - adj->lower) / line;
	gtk_adjustment_clamp_page (adj, scroll_pos, scroll_pos);
	gtk_editable_set_position (GTK_EDITABLE (app.text_widget), bol_pos);
	gtk_editable_select_region (GTK_EDITABLE (app.text_widget), bol_pos, 
		eol_pos);
}

/* Called when the user selects Edit>Go To Line in the menu. Shows the modal
 * go to line dialog, to prevent the user from opening more than one. */
static void on_edit_go_to_line (GtkWidget * widget, gpointer data)
{
	GtkWidget * dlg;
	GtkWidget * entry;
	GtkWidget * w;
	GtkAccelGroup * accel_group;

	dlg = gtk_dialog_new ();
	gtk_window_set_title (GTK_WINDOW (dlg), _("Go to line"));
	gtk_container_set_border_width (GTK_CONTAINER (GTK_DIALOG (
		dlg)->vbox), 0);
	accel_group = gtk_accel_group_new ();
	gtk_window_add_accel_group (GTK_WINDOW (dlg), accel_group);
	entry = gtk_entry_new ();
	gtk_window_set_focus (GTK_WINDOW (dlg), entry);
	gtk_signal_connect_object (GTK_OBJECT (entry), "activate", 
		GTK_SIGNAL_FUNC (gtk_window_activate_default), 
		GTK_OBJECT (dlg));
	gtk_box_pack_start (GTK_BOX (GTK_DIALOG (dlg)->vbox), entry, TRUE, 
		TRUE, 0);
	w = accel_button_new (_("_OK"), accel_group);
	gtk_window_set_default (GTK_WINDOW (dlg), w);
	gtk_signal_connect (GTK_OBJECT (w), "clicked", 
		GTK_SIGNAL_FUNC (on_line_number_selected), (gpointer) entry);
	gtk_signal_connect_object (GTK_OBJECT (w), "clicked", 
		GTK_SIGNAL_FUNC (gtk_widget_destroy), GTK_OBJECT (dlg));
	gtk_box_pack_start (GTK_BOX (GTK_DIALOG (dlg)->action_area), w, TRUE, 
		TRUE, 0);
	w = accel_button_new (_("_Cancel"), accel_group);
	gtk_signal_connect_object (GTK_OBJECT (w), "clicked", 
		GTK_SIGNAL_FUNC (gtk_widget_destroy), GTK_OBJECT (dlg));
	gtk_box_pack_start (GTK_BOX (GTK_DIALOG (dlg)->action_area), w, TRUE, 
		TRUE, 0);
	gtk_widget_add_accelerator (w, "clicked", accel_group, GDK_Escape,
		0, GTK_ACCEL_LOCKED);

	do_modal_dlg (dlg);
}

/* FONT CHANGE CODE */

/* Called when the user selects Apply or OK on the font selector dialog. 
 * Modifies the text widget style to use the new font. */
static void font_selection_apply (GtkWidget * widget, gpointer data)
{
	gchar * name;

	name = gtk_font_selection_dialog_get_font_name (
		GTK_FONT_SELECTION_DIALOG (data));
	if (NULL == name) {
		return;
	}
	if (!set_font (name)) {
		show_msg (_("Cannot set the new font"));
	}
}

/* Called when the user selects Format>Change Font on the menu */
static void on_format_change_font (GtkWidget * widget, gpointer data)
{
	GtkWidget * dlg;
	GtkAccelGroup * accel_group;

	dlg = gtk_font_selection_dialog_new (_("Select font"));
	if (NULL != app.font_name) {
		gtk_font_selection_dialog_set_font_name (
			GTK_FONT_SELECTION_DIALOG (dlg), app.font_name);
	}
	gtk_signal_connect (
		GTK_OBJECT (GTK_FONT_SELECTION_DIALOG (dlg)->ok_button), 
		"clicked", GTK_SIGNAL_FUNC (font_selection_apply), 
		(gpointer) dlg);
	gtk_signal_connect_object (
		GTK_OBJECT (GTK_FONT_SELECTION_DIALOG (dlg)->ok_button), 
		"clicked", GTK_SIGNAL_FUNC (gtk_widget_destroy), 
		GTK_OBJECT (dlg));
	gtk_signal_connect (
		GTK_OBJECT (GTK_FONT_SELECTION_DIALOG (dlg)->apply_button), 
		"clicked", GTK_SIGNAL_FUNC (font_selection_apply), 
		(gpointer) dlg);
	gtk_signal_connect_object (
		GTK_OBJECT (GTK_FONT_SELECTION_DIALOG (dlg)->cancel_button), 
		"clicked", GTK_SIGNAL_FUNC (gtk_widget_destroy), 
		GTK_OBJECT (dlg));
	accel_group = gtk_accel_group_new ();
	gtk_window_add_accel_group (GTK_WINDOW (dlg), accel_group);
	gtk_widget_add_accelerator (
		GTK_FONT_SELECTION_DIALOG (dlg)->cancel_button, 
		"clicked", accel_group, GDK_Escape, 0, GTK_ACCEL_LOCKED);
	do_modal_dlg (dlg);
}

/* MAIN MENU CODE */

/* data describing the menu layout and its callbacks */
static GtkItemFactoryEntry MAIN_MENU [] = {
	{ N_("/_File"), NULL, NULL, 0, "<Branch>" },
	{ N_("/File/_New"), "<control>N", on_file_new, 0, NULL },
	{ N_("/File/_Open..."), "<control>O", on_file_open, 0, NULL },
	{ N_("/File/_Save"), "<control>S", on_file_save, 0, NULL },
	{ N_("/File/Save _As..."), NULL, on_file_save_as, 0, NULL },
	{ "/File/sep1",	NULL, NULL, 0, "<Separator>" },
	{ N_("/File/_Quit"), "<control>Q", on_file_quit, 0, NULL },

	{ N_("/_Edit"), NULL, NULL, 0, "<Branch>" },
	{ N_("/Edit/_Undo"), "<control>Z", on_edit_undo, 0, NULL },
	{ "/Edit/sep1", NULL, NULL, 0, "<Separator>" },
	{ N_("/Edit/Cu_t"), "<control>X", on_edit_cut, 0, NULL },
	{ N_("/Edit/_Copy"), "<control>C", on_edit_copy, 0, NULL },
	{ N_("/Edit/_Paste"), "<control>V", on_edit_paste, 0, NULL },
	{ N_("/Edit/_Select All"), "<control>A", on_edit_select_all, 0, NULL },
	{ "/Edit/sep2", NULL, NULL, 0, "<Separator>" },
	{ N_("/Edit/_Find..."), "<control>F", on_edit_find, 0, NULL },
	{ N_("/Edit/Find _Again"), "F3", on_edit_find_again, 0, NULL },
	{ N_("/Edit/_Replace..."), "<control>H", on_edit_replace, 0, NULL },
	{ "/Edit/sep3", NULL, NULL, 0, "<Separator>" },
	{ N_("/Edit/_Go to line..."), "<control>G", on_edit_go_to_line, 0, NULL },

	{ N_("/F_ormat"), NULL, NULL, 0, "<Branch>" },
	{ N_("/Format/_Wrap long lines"), "<control>W", on_format_line_wrap, 
		ACTION_WRAP, "<CheckItem>" },
	{ N_("/Format/_Change Font..."), NULL, on_format_change_font, 0, NULL },

	{ N_("/_Help"), NULL, NULL, 0, "<Branch>" },
	{ N_("/Help/_About..."), "F1", on_help_about, 0, NULL },
};

static GtkItemFactoryEntry CONTEXT_MENU [] = {
	{N_("/Select _All"), "<control>A", on_edit_select_all, 0, NULL},
	{"/-Separator1-", NULL, NULL, 0, "<Separator>"},
	{N_("/Cu_t"), "<control>X", on_edit_cut, 0, NULL},
	{N_("/_Copy"), "<control>C", on_edit_copy, 0, NULL},
	{N_("/_Paste"), "<control>V", on_edit_paste, 0, NULL},
};

/* This callback intercepts key presses to allow main window accelerators to 
 * take precedence over the text widget hardcoded key combinations. 
 * This widget behavior is specially anoying because it traps some Alt+key 
 * conbinations that users may expect to activate the menu. */
static gboolean on_text_key_press (GtkWidget * widget, GdkEventKey * event)
{
	/* if there is some accelerator for the key stop processing now */
	if (gtk_accel_groups_activate (GTK_OBJECT (app.window), event->keyval,
	event->state)) {
		gtk_signal_emit_stop_by_name (GTK_OBJECT (widget), 
			"key_press_event");
		return TRUE;
	}
	return FALSE;
}

/* This is called when a mouse button press is detected by the text widget.
 * We use it to capture right button clicks to pop-up the context menu. */
static gboolean on_text_button_press (GtkWidget * w, GdkEventButton * event, gpointer data)
{
	/* only right (=3) button presses */
	if (GDK_BUTTON_PRESS == event->type && 3 == event->button)
	{
		gtk_item_factory_popup (GTK_ITEM_FACTORY (data), event->x_root,
			event->y_root, event->button, event->time);
		/* prevent the default event handler from firing */
		gtk_signal_emit_stop_by_name (GTK_OBJECT (w),
			"button-press-event");
		return TRUE;
	}
	return FALSE;
}

/* this function is called back from the item factory to translate items */
static gchar * translate_menu_cb (const char * path, gpointer data)
{
	return gettext (path);
}

/* this builds the main window menu */
static GtkWidget * build_main_menu (void)
{
	GtkItemFactory * item_factory;
	GtkAccelGroup * accel_group;
	GtkWidget * menubar;
	
	accel_group = gtk_accel_group_new ();
	item_factory = gtk_item_factory_new (GTK_TYPE_MENU_BAR, "<main>", 
		accel_group);
  	gtk_item_factory_set_translate_func (item_factory, translate_menu_cb, 
		NULL, NULL);
  	gtk_item_factory_create_items (item_factory, sizeof (MAIN_MENU) / 
		sizeof (GtkItemFactoryEntry), MAIN_MENU, NULL);
	gtk_window_add_accel_group (GTK_WINDOW (app.window), accel_group);
	menubar = gtk_item_factory_get_widget (item_factory, "<main>");

	/* we will be looking later to see if this item is checked or not, so 
	 * we save a pointer to it. */
	app.line_wrap_menu_item = gtk_item_factory_get_widget_by_action (
		item_factory, ACTION_WRAP);

	return menubar;
}

/* build the text widget context menu */
static void build_context_menu (void)
{
	GtkItemFactory * item_factory;
	
	item_factory = gtk_item_factory_new (GTK_TYPE_MENU, "<popup>", NULL);
  	gtk_item_factory_set_translate_func (item_factory, translate_menu_cb, 
		NULL, NULL);
	gtk_item_factory_create_items (item_factory, sizeof (CONTEXT_MENU) /
		sizeof (CONTEXT_MENU[0]), CONTEXT_MENU, NULL);
	gtk_signal_connect (GTK_OBJECT (app.text_widget), "button-press-event",
		GTK_SIGNAL_FUNC (on_text_button_press), item_factory);
}

/* The Main function. Creates the main window and loads the provided file
 * name if one is specified on the command line. */
int main (int argc, char ** argv)
{
	GtkWidget * mainbox;
	GtkWidget * textbox;
	GtkWidget * menubar;
	GtkTargetEntry target_entries [] = { {"text/uri-list", 0, 0} };

	/* init GTK+ */
	gtk_set_locale ();
	gtk_init (&argc, &argv);

	/* Init gettext. We assume the standard location (/usr/share/locale)
	 * In which case there's no need to call bindtextdomain(). */
	/*bindtextdomain ("gtkedit", NULL);*/
	textdomain ("gtkedit");
	
	/* set up the main window */
	app.window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
	gtk_signal_connect (GTK_OBJECT (app.window), "destroy", 
		GTK_SIGNAL_FUNC (gtk_main_quit), NULL);
	gtk_signal_connect (GTK_OBJECT (app.window), "delete_event", 
		GTK_SIGNAL_FUNC (on_delete_event), NULL);
	gtk_window_set_title (GTK_WINDOW (app.window), "gtkedit");

	/* add widgets to the window: mainbox, menu, text, etc */
	mainbox = gtk_vbox_new (FALSE, 0);
	gtk_container_add (GTK_CONTAINER (app.window), mainbox);
	textbox = gtk_hbox_new (FALSE, 0);
	gtk_box_pack_end (GTK_BOX (mainbox), textbox, TRUE, TRUE, 0);
	/* the text widget */
	app.text_widget = gtk_text_new (NULL, NULL);
	gtk_box_pack_start (GTK_BOX(textbox), app.text_widget, TRUE, TRUE, 0);
	gtk_widget_set_name (app.text_widget, "gtkedit-text");
	gtk_text_set_editable (GTK_TEXT (app.text_widget), TRUE);
	/* to modify the unsaved flag */
	gtk_signal_connect (GTK_OBJECT (app.text_widget), "changed", 
		GTK_SIGNAL_FUNC (on_text_changed), NULL);
	/* capture key presses to fix priorities */
	gtk_signal_connect (GTK_OBJECT (app.text_widget), "key_press_event", 
		GTK_SIGNAL_FUNC (on_text_key_press), NULL);
	/* undo-redo signals */
	gtk_signal_connect (GTK_OBJECT (app.text_widget), "insert-text", 
		GTK_SIGNAL_FUNC (on_insert_text), NULL);
	gtk_signal_connect (GTK_OBJECT (app.text_widget), "delete-text", 
		GTK_SIGNAL_FUNC (on_delete_text), NULL);
	/* drag and drop setup */
	gtk_drag_dest_set (app.text_widget, GTK_DEST_DEFAULT_ALL, 
		target_entries, sizeof (target_entries) / 
		sizeof (GtkTargetEntry), GDK_ACTION_COPY | GDK_ACTION_MOVE);
	gtk_signal_connect (GTK_OBJECT (app.text_widget), "drag_data_received", 
		GTK_SIGNAL_FUNC (on_drag_data), NULL);
		
	/* menus and scroll bar */
	app.vscroll = gtk_vscrollbar_new (GTK_TEXT (app.text_widget)->vadj);
	/* scrollbar widht is constant */
	gtk_box_pack_start (GTK_BOX(textbox), app.vscroll, FALSE, FALSE, 0);
	build_context_menu ();
	menubar = build_main_menu ();
	/* sync text and menu wrap status */
	gtk_text_set_line_wrap (GTK_TEXT (app.text_widget), 
		GTK_CHECK_MENU_ITEM (app.line_wrap_menu_item)->active);
	/* menu bar height is constant */
	gtk_box_pack_start (GTK_BOX (mainbox), menubar, FALSE, FALSE, 0);

	/* create the hidden find dialog and set the initial focus */
	init_find_dialog ();
	gtk_window_set_focus (GTK_WINDOW (app.window), app.text_widget);

	/* load config file */
	load_cfg ();
	
	/* if a file name is provided with the command line, open it now */
	if (argc > 1) {
		if (file_exists (argv [1])) {
			read_file (argv [1]);
		} else {
			/* it's a new file */
			app.file_name = g_strdup (argv [1]);
		}
	}

	/* set initial state */
	reset_undo ();
	app.unsaved_changes = FALSE;
	update_window_title ();
	gtk_widget_show_all (app.window);

	/* enter the main loop */
	gtk_main ();

	/* done, quit cleanly. */
	gtk_exit (0);	
	
	return 0;
}
