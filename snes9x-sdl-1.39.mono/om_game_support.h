
#ifndef _OM_GAME_SUPPORT_
#define _OM_GAME_SUPPORT_


#include <stdlib.h>

#include "SDL/SDL.h"

#include <fcntl.h>
#include <stdio.h>
#include <sys/select.h>
#include <unistd.h>
#include <signal.h>
#include "accelneo.h"

// Input event types.
typedef enum
{
  ev_keydown,
  ev_keyup,
  ev_mouse,
  ev_joystick,
  ev_accelerometer,  //Openmoko
} evtype_t;

// Event structure.
typedef struct
{
  evtype_t  type;
  int       data1;    // keys / mouse/joystick buttons
  int       data2;    // mouse/joystick x move
  int       data3;    // mouse/joystick y move
} event_t;


extern int accelerometer_tare;
extern int accelerometer_zHome;      // Stores new "Home" position
extern int accelerometer_yHome;      // Stores new "Home" position



extern int file_event;


void I_InitAccelerometer(void);

void I_CloseAccelerometer(void);

int get_position(event_t *ev);

int get_action_buttons(void);

int get_direction_controler(void);



#endif // _OM_GAME_SUPPORT_
