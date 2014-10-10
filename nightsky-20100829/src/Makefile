
# Currently this compiles on:
#  + Linux
#  + Mac OS X
#  + OpenWRT

PROJECT = nightsky
#DEBUG = -g

ifndef CFLAGS
CFLAGS = -O3 -Wall $(DEBUG)
endif
CFLAGS += $(shell pkg-config --cflags sdl)

LIBS = $(shell pkg-config --libs sdl) -lSDL_image

PARTS = Stopwatch.o core.o Clock.o Font.o Model.o View.o main.o

.c.o:
	$(RM) $@
#	$(CC) -MM $(CFLAGS) $*.c
	$(CC) -c $(CFLAGS) $(CFLAGS_SDL) $*.c

#.SILENT:

# Targets...

all: $(PROJECT)

$(PROJECT): $(PARTS)
	$(CC) $(LDFLAGS) $(LIBS) $(DEBUG) -o $(PROJECT) $(PARTS)

clean:
	rm -f *.o $(PROJECT)

# update with "make clean all 2>/dev/null >> Makefile" when the -MM line is uncommented
Stopwatch.o: Stopwatch.c Stopwatch.h
core.o: core.c core.h
Clock.o: Clock.c Clock.h
Font.o: Font.c Font.h core.h
Model.o: Model.c core.h Model.h
View.o: View.c Font.h core.h View.h Model.h
main.o: main.c Model.h core.h Stopwatch.h Clock.h Font.h View.h
