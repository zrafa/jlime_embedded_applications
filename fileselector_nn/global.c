/*
 * Linball - un pinball 2D multiplataforma escrito en C + SDL (desarrollado en Linux)
 *
 * COSAS FEAS DEL CODIGO QUE QUISIERA CAMBIAR (pero que en el estado actual
 * en que estan funcionan):
 *
 * - la "V" roja donde se posiciona la pelota (en pinball.bmp) antes de empezar
 *   el nivel de juego es un truco para que la pelota caiga y se posicione
 *   sin moverse. dx tiene que ser igual a 0, y pelotax = 743 (pelotay = 600)
 *
 * - la posicion de la tabla inicial es -700 (y0pantalla).
 * 
 * Los valores anteriores estan dentro del codigo de juego como inicializacion.
 * Lo feo de esos valores es que si alguien (yo talvez) cambia un valor de 
 * esos la pelota caerá mal al comenzar el nivel y no se posicionará delante
 * del "resorte" disparador
 *
 * - en colisiones() no se hara un efecto de sonido cuando la pelota "rebote" 
 *   en alguna parte inferior. Esto es porque cuando la pelota es retenida
 *   por los flippers en realidad lo que sucede es que rebota en ambos lados
 *   constantemente. Si hacemos un efecto de sonido en esos rebotes se escucharia
 *   una especie de "ametralladora".
 *
 */

#define MAX_OBJ 20
#define NUM_OBJ 10


/* macros para modificar la resolucion del juego a 320x240 (tabla 320x480) */

/* macros para la bola */
#define ANCHO_BOLA 32	/* para 320x240 el ancho de la bola es 12/
			 * para 800x600 el ancho de la bola es 32
			 */ 
#define MOD_BOLA ANCHO_BOLA / 32

/* macros del ancho y largo de la pantalla y de la tabla*/
//#define ANCHO 800		/* puede ser 320 u 800 */
#define LARGO 600		/* puede ser 240 u 600 */
#define LARGO_TABLA 1200	/* puede ser 480 u 1200 */
#define MODX ANCHO / 800
#define MODY LARGO / 600
#define MODY_REAL LARGO_TABLA / 1200



struct object {
       int posx,posy;
       int visible; /*booleano para saber si dibujarlo o no*/
       SDL_Surface * imagen;
};

enum objects{fondo=0,fondo_dummy,fondo_sup,fondo_sup_dummy, fondo_objetos, 
	     aquibonus, ball,flipper_Ldwn,flipper_Rdwn,flipper_Lup,flipper_Rup,
	     flipper_LdwnR,flipper_RdwnR,flipper_LupR,flipper_RupR, bumperi1,
	     bumperi2, bumperi3, bumpizq, bumpder, tabla_luz1, tabla_luz2, tabla_luz3, last};

enum luces {roja, verde, azul, magenta, ult_luz};

struct luces_colores {
       SDL_Surface * imagen;
};

struct luz {
	int posx;
	int posy;
	int visible;
	enum luces clase;
	int modo;
	int inc;
};

SDL_Surface * image, *scr, *pelota,*temp,*temp2,*dummy;
SDL_Surface *fondoi1, *fondoi2;
SDL_Rect dest;


/* profundidad de colores */
const int prof=16;

/* para habilitar sonido */
int enable_sound=1;


/* sonido de la bola ingresando al tablero cuando inicia el nivel */

int phaserChannel = -1;
	
/* Font a utilizar */
TTF_Font *font, *font_bonus, *font2;


/* Variables del nivel (deberian estar todas dentro de una estructura) */
int potencia_disparador;
int nivel;
int bolas_por_jugar;
int chance_izq;
int chance_der;
int puntaje, puntaje_anterior;
int tecla_space;
char banner[80];	/* texto en la parte superior de la pantalla */
char banner_b[80];	/* texto bonus en la parte superior de la pantalla */

int juego_finalizado;
int puente;		/* esta variable indica si la bola esta abajo o en el 
			 * puente 
			 */

/* parametros del tiempo para calcular el FPS */
int prev_ticks = 0, cur_ticks = 0; /* for keeping track of timing */




int bonus_timer;
enum personajes  { belgrano, moreno, borges, guevara, fangio, favaloro,
		   fontanarrosa, sanmartin, storni, piazzolla, tato,
		   olmedo, sabato, lastpersonaje };

char *bonus_banner;
