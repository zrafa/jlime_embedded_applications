bin_PROGRAMS = rfc2229.so

rfc2229_so_SOURCES = rfc2229.cpp rfc2229.h 

rfc2229_so_LDFLAGS =  @LDFLAGS_SHAREDLIB@ ../libdict-patch/libdict.a

INCLUDES = -I../libdict-patch/include

EXTRA_DIST = rfc2229.ini

install-data-local:
	@$(NORMAL_INSTALL)
	if test -f $(srcdir)/rfc2229.ini; then \
		cp $(srcdir)/rfc2229.ini $(DESTDIR)$(bindir)/; \
	fi
