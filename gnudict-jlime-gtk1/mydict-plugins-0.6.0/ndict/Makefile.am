bin_PROGRAMS = plugndict.so ndict

plugndict_so_SOURCES = plugndict.cpp plugndict.h 

plugndict_so_LDFLAGS = @LDFLAGS_SHAREDLIB@

ndict_SOURCES = plugndict.cpp plugndict.h 

ndict_LDFLAGS =

EXTRA_DIST = plugndict.ini

install-data-local:
	@$(NORMAL_INSTALL)
	if test -f $(srcdir)/plugndict.ini; then \
		cp $(srcdir)/plugndict.ini $(DESTDIR)$(bindir)/; \
	fi
