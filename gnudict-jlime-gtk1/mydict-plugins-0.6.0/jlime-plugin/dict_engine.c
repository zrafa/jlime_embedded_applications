#include <ctype.h>
#include <stdio.h>

#include "dict_engine.h"

const char archivo[] = "dictionary-gcide.txt";

int bufs = 1024;

void str_to_lower (char * s) 
{
	int i;
  for(i = 0; s[ i ]; i++)
    s[i] = tolower(s[ i ]);
}

void get_pronun (const char *s, char *w, int c)
{
	int i = 1;
	char ct;
	char *st;
	st = strchr(s, c);
	while ((c = st[i]) != '\\') {
		w[(i-1)] = c;
		i++;
	}
	w[i-1] = '\0';
	


}

void search (char* word) 
{
	FILE *f;
	char *res;
	char buf[bufs];
	int not_found, l;
	char pronun[80];

	l = strlen(word);
	word[l] = ' ';
	word[l+1] = '\0';
//	const char* word = "House";

	f = fopen(archivo, "r");
	if ( f == NULL) {
		printf("error open dict.txt");
		exit(1);
	}

	
	not_found = 1;

	res = fgets(buf, bufs, f);
	
	while ((res =! NULL) && (not_found)) {
		if  (! strncmp(buf, word, strlen(word)) ) {	/* found */
			printf("ENCONTRADO\n%s\n",buf);
			get_pronun(buf, pronun, '\\');
			printf("pronun=%s\n",pronun); 
			not_found = 0;
		} else {
			res = fgets(buf, bufs, f);
		}

	}

	if (not_found == 0) {
		
		res = fgets(buf, bufs, f);
		while ((! strncmp(buf, word, strlen(word)) ) || (buf[0] == '\n') || ((res =! NULL) && ((!strncmp(buf, " ", 1)) && (strncmp(buf, word, strlen(word)) )))) {
			printf("%s",buf);
			res = fgets(buf, bufs, f);
//			printf("buf[0]=%d\n",buf[0]);
		}

		if (! (strncmp(buf, " ", 1)))
			printf("%s\n",buf);


	}

	printf("OK s=%s\n", buf);	

	fclose(f);



}

void look (void)
{
	char palabra[80] = "however";
	str_to_lower(palabra);
    	palabra[0] = toupper(palabra[ 0 ]);

	search (palabra);


}
