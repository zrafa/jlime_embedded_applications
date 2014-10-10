CWARN 	= -Wall
#CFLAGS 	= -O2 -Iinclude/ -I/usr/local/include -Wall # For production.
CFLAGS	= -g -Iinclude/ -I/usr/local/include -Wall
CC		= cc
SRC		= libdict.c ldsock.c ldutil.c lderrno.c
OBJ		= libdict.o ldsock.o ldutil.o lderrno.o
CPPSRC	= libdict-wrap.cpp
CPPOBJ	= libdict-wrap.o
LIBDIR		= /usr/local/lib
INCDIR		= /usr/local/include

all: libdict.a 

install: all
	(cp -f libdict.a ${LIBDIR})
	(cd include; cp -f *.h ${INCDIR})
libdict-wrap.o:
	${CXX} ${CFLAGS} -c libdict-wrap.cpp
libdict.a: ${OBJ} ${CPPOBJ}
	rm -f libdict.a
	ar rc libdict.a *.o
	ranlib libdict.a
distdir:
	
clean: 
	rm -f *.o *.core core 
superclean: clean
	rm -f libdict.a

