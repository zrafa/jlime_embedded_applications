
/*
 * Simple file selector for the GameRunner Project
 *
 *  Copyright (c) 2010 Rafael Ignacio Zurita <rizurita@yahoo.com>
 *
 *  This program can be distributed under the terms of the GNU GPL.
 *  See the file COPYING.
 *
 */

#define _SVID_SOURCE

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include <math.h>

#include <SDL.h>
//#include <SDL_mixer.h>
#include <SDL/SDL_ttf.h>
//#include <SDL_image.h>

#include <sys/types.h>
#include <dirent.h>

#include "global.c"

#define ANCHO 320
#define ALTO 240
#define NROWS 10



char * fnames[1024];
int p=0, nro=0;	pd=1; /* puntero global, pd puntero del display */

char argvtitle[80], *pwd;


int fill_fname_array(char *data_dir) {
           struct dirent **namelist;
           int n, r;

           n = scandir(data_dir, &namelist, 0, alphasort);
           if (n < 0)
               perror("scandir");
           else {
				r=n;
               while (n--) {
    				fnames[n]=strdup(namelist[n]->d_name);
                   free(namelist[n]);
               }
               free(namelist);
           }
		return r;
}




//void dibujar_texto(const char texto[80], int x, int y, int r, int g, int b)
void dibujar_texto(const char texto[80], int x, int y, SDL_Color foregroundColor, SDL_Color bgcolor)
//void dibujar_texto(char *texto, int x, int y, int r, int g, int b)
{

	//SDL_Color foregroundColor = { r, g, b };

	//SDL_Color backgroundColor = { 0, 0, 0 };

	SDL_Surface* textSurface = TTF_RenderText_Shaded(font, texto,
	foregroundColor, bgcolor); 
	SDL_Rect textLocation = { x, y, 0, 0 };
	SDL_BlitSurface(textSurface, NULL, scr, &textLocation);

	/* Liberar ttf */
	SDL_FreeSurface(textSurface);

}


void dibujar_fondo(void) {
	/* pintamos todo de negro */
	//SDL_Color colort = { 255, 255, 255 };
	SDL_Color bgcolor = { 0, 0, 0 };
	SDL_Rect fondo = { 0, 0, ANCHO, ALTO};
	SDL_FillRect(scr, &fondo, SDL_MapRGB(scr->format, 0, 0, 0));

	/* pintamos todo el rect del menu en blanco */
	fondo.x = 0;
	fondo.y = 0;
	fondo.w = ANCHO;
	fondo.h = ALTO;
	SDL_FillRect(scr, &fondo, SDL_MapRGB(scr->format, 255, 255, 255));

	/* dibujamos rectangulos negros por cada entrada en el menu */
	int i;
	SDL_Rect item;
	int ngr = 1;	/* grosor de la linea */
	int nalto = ALTO / NROWS -1;	/* altura del item del menu */
	int nancho = ANCHO;
	for (i=0; i<NROWS; i++) {
		item.x = 0;
		item.y = i * nalto + i;
		item.w = nancho;
		item.h = nalto;

		SDL_FillRect(scr, &item, SDL_MapRGB(scr->format, 0, 0, 0));
	}
	//dibujar_texto(argvtitle, 500, 20, colort, bgcolor);
	/*
	if (pd==1)
	dibujar_texto(pwd, 150, 1, bgcolor, colort);
	else
	dibujar_texto(pwd, 150, 1, colort, bgcolor);
	*/
}



void mostrar_nombres(void) {
	int i, y, x = 20;
	DIR *directory;
	SDL_Color colort = { 255, 255, 255 };
	SDL_Color bgcolor = { 0, 0, 0 };
	SDL_Color bgcolor2 = { 170, 170, 170 };
	SDL_Color cnormal = { 170, 170, 170 };
	SDL_Color cdnormal = { 170, 170, 255 };
	SDL_Color current = { 0, 0, 0 };

	SDL_Rect item;
	int ngr = 1;	/* grosor de la linea */
	int nalto = ALTO / NROWS -1;	/* altura del item del menu */
	int nancho = ANCHO;	/* ancho del item */
	for (i=0; i<NROWS; i++) {
		y = i*(ALTO/NROWS) + ((nalto-8)/2);  /* 8 es el grosor de la linea */
		if (i == (pd-1)) {
			item.x = 0;
			item.y = (ngr*i + nalto*(i));
			item.w = nancho;
			item.h = nalto;
			SDL_FillRect(scr, &item, SDL_MapRGB(scr->format, 170, 170, 170));
		}
		if (p - (pd-1) +i<nro) {
			directory = opendir(fnames[p -(pd-1) +i]);
  			if (directory) {
      				closedir(directory);
				if (i == (pd-1)) {
					dibujar_texto("[DIR] ", x, y, current, bgcolor2);
					dibujar_texto(fnames[p -(pd-1) +i], x+50, y, current, bgcolor2);
				} else {
					dibujar_texto("[DIR] ", x, y, cdnormal, bgcolor);
					dibujar_texto(fnames[p -(pd-1) +i], x+50, y, cdnormal, bgcolor);
				}
			} else {
				if (i == (pd-1))
					dibujar_texto(fnames[p -(pd-1) +i], x, y, current, bgcolor2);
				else
					dibujar_texto(fnames[p -(pd-1) +i], x, y, cnormal, bgcolor);
			}
		}


		
	}
	if (pd==1)
	dibujar_texto(pwd, 150, 1, bgcolor, colort);
	else
	dibujar_texto(pwd, 150, 1, colort, bgcolor);
		
}


int eventos(void) {

	int ev=-3;
	SDL_Event evento;
    while(SDL_PollEvent(&evento)) {
		switch (evento.type){
/*
			case SDL_MOUSEBUTTONDOWN:
				
				if ((evento.button.x) < (ANCHO - (ANCHO/4))) { 
				
					ev = evento.button.y * NROWS / ALTO;
				} else if ((evento.button.y) > 300) {
					ev = -1;
				} else if ((evento.button.y) > 150 ) {
					ev = -2;
				} else
					exit(0);
					
						
				break;
*/
			case SDL_KEYDOWN:
			/* case SDL_KEYUP: */
				switch(evento.key.keysym.sym) {
					case SDLK_UP:
						ev = -2;
						break;
					case SDLK_DOWN:
						ev = -1;
						break;
					case SDLK_RETURN:
						ev = 1;
						break;
					case SDLK_ESCAPE:
						TTF_CloseFont(font);
						TTF_Quit();

						SDL_Quit();
            					exit(1);
						
						break;
				}
				
				break;
			case SDL_QUIT:
				TTF_CloseFont(font);
				TTF_Quit();

				SDL_Quit();
            			exit(0);
            			break;
		}
	}

	return ev;
}


void procesar_ev(int ev) 
{
	DIR *directory;

	if (ev == -2) {		/* UP */
		p = p - 1;
		if (p<0) p=0;
		
		pd = pd -1;
		if (pd<1) pd=1;
		
	} else if (ev == -1) {	/* DOWN */
		p = p + 1;
		if (p>nro-1) p=p-1;
		else {
			pd = pd + 1;
			if (pd>NROWS) pd=NROWS;
		};
	} else if (ev == 1) {
		directory = opendir(fnames[p]);
  		if (directory)
    		{
      			closedir(directory);
			chdir(fnames[p]);
			free(pwd);
			pwd=get_current_dir_name();
			p=0; pd=0;
			nro=fill_fname_array(".");
			
    		} else {
			printf ("%s/%s", pwd, fnames[p]);
			TTF_CloseFont(font);
			TTF_Quit();

			SDL_Quit();
			exit(0);
		};

	}
	dibujar_fondo();
	mostrar_nombres();


}


int main(int argc, char * argv[])
{
	sprintf(argvtitle, "%s", argv[2]);
        
	/* Init SDL: */
	if (SDL_Init(SDL_INIT_VIDEO) < 0 ) {
		fprintf(stderr, "Can't init: %s\n", SDL_GetError());
		exit(1);
	}
	/* Open scr: */
		//scr = SDL_SetVideoMode(ANCHO, ALTO, prof, SDL_FULLSCREEN);
	scr = SDL_SetVideoMode(ANCHO, ALTO, 16, SDL_SWSURFACE);
	if (scr == NULL){
		printf("No se pudo iniciar el modo grafico %s\n",SDL_GetError());
		exit(1);
	}

	/* Inicializar ttf */
	TTF_Init();
	font = TTF_OpenFont("FreeSansBold.ttf", 10); // IMPORTANTE!: ver que tamaño para 320
	font2 = TTF_OpenFont("FreeSansBold.ttf", 8); // IMPORTANTE!: ver que tamaño para 320
  
	int main_done = 0, done = 0;

	int i, ev;
	struct dirent *dir;
	DIR *dp;
	nro = fill_fname_array(argv[1]);
	chdir(argv[1]);
	pwd=get_current_dir_name();
	for (i=0; i<nro; i++) {
  		if (!((dp=opendir(fnames[i])) == NULL))
			i=i;
		else
			i=i;
	}


	dibujar_fondo();
	mostrar_nombres();
	SDL_Flip(scr);
	while (1) {
	ev=eventos();
	if (ev != -3)
		procesar_ev(ev);

	SDL_Delay(100);

	SDL_Flip(scr);
}
  //}

sleep(500);


	/* finalizar ttf */
	TTF_CloseFont(font);
	TTF_Quit();

	SDL_Quit();
   
  exit(0);
}



