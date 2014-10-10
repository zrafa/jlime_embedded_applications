# Generated automatically from Makefile.in by configure

CC=gcc
MAKE=make
CFLAGS=-s -O2 -Wall -I/usr/local/jlime/mipsel-toolchain/usr/include/SDL  -DSYSCONFDIR=\"${sysconfdir}/${progname}\"
LDFLAGS=
LIBS=-L/usr/local/jlime/mipsel-toolchain/usr/lib -lm
XSUF=
prefix=/usr/local
exec_prefix=${prefix}
progname=blockrage
sysconfdir=${prefix}/etc
bindir=${exec_prefix}/bin
datadir=${prefix}/share
mandir=${prefix}/man
OBJS    = main.o gfxout.o gfxlib.o menus.o keyboard.o bg.o sound.o global.o
DESTDIR =

$(progname)$(XSUF): src/$(progname)$(XSUF)
	cp src/$(progname)$(XSUF) .

src/$(progname)$(XSUF):
	cd src; $(MAKE) $(progname)$(XSUF)

install: $(progname)$(XSUF)
	./inst -dp 755 -t $(DESTDIR)$(datadir)/$(progname)
	./inst -dp 755 -t $(DESTDIR)$(sysconfdir)/$(progname)
	./inst -dp 755 -fp 644 -t $(DESTDIR)$(datadir)/$(progname) ./data/*
	./inst -dp 755 -fp 755 -t $(DESTDIR)$(bindir)  $(progname)$(XSUF)
	./inst -dp 755 -fp 644 -t $(DESTDIR)$(sysconfdir)/$(progname) $(progname).cfg
	./inst -dp 755 -fp 644 -T $(DESTDIR)$(sysconfdir)/$(progname)/$(progname).rc $(progname)-fhs.rc
	./inst -dp 755 -fp 644 -t $(DESTDIR)$(mandir)/man6 $(progname).6

uninstall:
	rm -r $(DESTDIR)$(datadir)/$(progname)
	rm -r $(DESTDIR)$(sysconfdir)/$(progname)
	rm $(DESTDIR)$(bindir)/$(progname)$(XSUF)
	rm $(DESTDIR)$(mandir)/man6/$(progname).6

clean:
	cd src; $(MAKE) clean
	rm -f $(progname)$(XSUF)
