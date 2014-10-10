CFLAGS=`gtk-config --cflags` -Wall
LDFLAGS=`gtk-config --libs` -s

gtkedit: gtkedit.c

pot: gtkedit.pot

gtkedit.pot: gtkedit.c
	xgettext -d gtkedit --keyword=_ --keyword=N_  -o gtkedit.pot gtkedit.c

clean: 
	rm gtkedit gtkedit.pot *.o *~

