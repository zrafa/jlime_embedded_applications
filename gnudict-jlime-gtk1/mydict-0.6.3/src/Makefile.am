## Process this file with automake to produce Makefile.in

INCLUDES = \
	@GTK_CFLAGS@

bin_PROGRAMS = mydict

mydict_SOURCES = \
	main.c \
	support.c support.h \
	interface.c interface.h \
	callbacks.c callbacks.h \
	plugin.c plugin.h \
	mydict.c mydict.h \
	mydict_plugin.h

mydict_LDADD = @GTK_LIBS@ 

CC=g++
