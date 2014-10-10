## Process this file with automake to produce Makefile.in

SUBDIRS = po intl src

EXTRA_DIST = config.rpath  \
	autogen.sh \
	TODO	\
	mydict.glade \
	mydict.spec \
	mydict.ini \
	README.zh_CN

install-data-local:
	@$(NORMAL_INSTALL)
	if test -d $(srcdir)/pixmaps; then \
	  $(mkinstalldirs) $(DESTDIR)$(pkgdatadir)/pixmaps; \
	  for pixmap in $(srcdir)/pixmaps/*; do \
	    if test -f $$pixmap; then \
	      $(INSTALL_DATA) $$pixmap $(DESTDIR)$(pkgdatadir)/pixmaps; \
	    fi \
	  done \
	fi; \
	if test -f $(srcdir)mydict.ini; then \
		cp $(srcdir)/mydict.ini $(DESTDIR)$(pkgdatadir)/; \
	fi

dist-hook:
	if test -d pixmaps; then \
	  mkdir $(distdir)/pixmaps; \
	  for pixmap in pixmaps/*; do \
	    if test -f $$pixmap; then \
	      cp -p $$pixmap $(distdir)/pixmaps; \
	    fi \
	  done \
	fi


