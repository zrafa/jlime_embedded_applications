#ifdef __ENGINE__

#include <ctype.h>
#include <stdio.h>

const char archivo[] = "dictionary-gcide.txt";

int bufs = 1024;

void str_to_lower (char * s); 

void get_pronun (const char *s, char *w, int c);

void search (char* word);

#endif /* __ENGINE__ */
