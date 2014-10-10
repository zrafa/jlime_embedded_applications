bin_PROGRAMS = babylon.so

babylon_so_SOURCES = babylon.cpp babylon.h

# babylon_CPPFLAGS = -DTEST

babylon_so_LDFLAGS = @LDFLAGS_SHAREDLIB@ -lstdc++

EXTRA_DIST = babylon.ini

install-data-local:
	@$(NORMAL_INSTALL)
	if test -f $(srcdir)/babylon.ini; then \
		cp $(srcdir)/babylon.ini $(DESTDIR)$(bindir)/; \
	fi
