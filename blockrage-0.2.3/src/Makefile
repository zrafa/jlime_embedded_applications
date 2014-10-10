# Generated automatically from Makefile.in by configure

CC=gcc
MAKE=make
CFLAGS=-s -O2 -Wall -I/usr/local/jlime/mipsel-toolchain/usr/include/SDL -I/usr/local/jlime/mipsel-toolchain/usr/include  -DSYSCONFDIR=\"${sysconfdir}/${progname}\"
LDFLAGS=
LIBS=-L/usr/local/jlime/mipsel-toolchain/usr/lib -lm -lSDL
XSUF=
prefix=/usr/local
exec_prefix=${prefix}
progname=blockrage
sysconfdir=${prefix}/etc
bindir=${exec_prefix}/bin
datadir=${prefix}/share
mandir=${prefix}/man
OBJS    = main.o gfxout.o gfxlib.o menus.o keyboard.o bg.o sound.o global.o timer.o

$(progname)$(XSUF): $(OBJS)
	gcc -s -o $(progname)$(XSUF) $(OBJS) $(LIBS)

bg.o: bg.c bg.h global.h main.h
gfxlib.o: gfxlib.c gfxlib.h global.h gfxout.h
gfxout.o: gfxout.c gfxout.h global.h
global.o: global.c global.h main.h
keyboard.o: keyboard.c keyboard.h global.h main.h
main.o: main.c main.h global.h gfxout.h gfxlib.h menus.h bg.h keyboard.h sound.h timer.h
menus.o: menus.c menus.h global.h gfxout.h gfxlib.h keyboard.h bg.h main.h timer.h
sound.o: sound.c sound.h global.h
timer.o: timer.c timer.h

clean:
	rm -f *.o $(progname)$(XSUF)
