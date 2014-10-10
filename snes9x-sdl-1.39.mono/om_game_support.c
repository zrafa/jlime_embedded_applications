
#ifndef lint
#endif /* lint */

#include <stdlib.h>

#include "SDL/SDL.h"

#include <fcntl.h>
#include <stdio.h>
#include <sys/select.h>
#include <unistd.h>
#include <signal.h>
#include "accelneo.h"
#include "om_game_support.h"

int joyleft;
int joyright;
int joyup;
int joydown;

int usejoystick;


#ifdef HAVE_SDL_JOYSTICKGETAXIS
static SDL_Joystick *joystick;
#endif


int accelerometer_tare = 1;
int accelerometer_zHome = 0;      // Stores new "Home" position
int accelerometer_yHome = 0;      // Stores new "Home" position



int file_event;

void I_InitAccelerometer(void)
{
  file_event = open("/dev/input/event3", O_RDONLY);
} 
void I_CloseAccelerometer(void)
{
  close(file_event);
}

int get_position(event_t *ev)
{

	int accelerometer_zwindow=40; // DeadZone in Pixels
	int accelerometer_ywindow=40; // DeadZone in Pixels
	int accelerometer_yscale=100; // Scaling factor for motion (acceleration)
	int accelerometer_zscale=7; // Scaling factor for motion (acceleration)
      
      if (accelerometer_tare)    // Make current position the "Home" position
	{
	  //accelerometer_xHome = ev->data1; // Not being used.
	  accelerometer_yHome = ev->data2;
	  accelerometer_zHome = ev->data3;
	  // fprintf(stderr,"Tare :[ %d, %d, %d ]", accelerometer_xHome, accelerometer_yHome, accelerometer_zHome);
	  
	  // Currently this operation is triggered when the user leaves 
	  //the main menu and enters the back to the game, and also at the beginning of the first game played.
	  accelerometer_tare = 0;   	      
	}
      //printf("zhome=%i,zwindow=%i,data3=%i,yhome=%i,ywindow=%i,data2=%i\n",accelerometer_zHome,accelerometer_zwindow,ev->data3,accelerometer_yHome,accelerometer_ywindow,ev->data2);
      
      if (ev->data3 >  (accelerometer_zHome + accelerometer_zwindow)) {
//		mousey = abs((accelerometer_zscale / 10.0)* ( ev->data3 - (accelerometer_zHome + accelerometer_zwindow) ));   // Forward
		printf("adelante\n");
	}
      if (ev->data3 <  (accelerometer_zHome - accelerometer_zwindow)) {
//		mousey = -abs((accelerometer_zscale / 10.0) * ( ev->data3 - (accelerometer_zHome - accelerometer_zwindow) ));  // Backward
		printf("atras\n");
	}
      if (ev->data2 >  (accelerometer_yHome + accelerometer_ywindow)) {
//		 mousex = abs((accelerometer_yscale / 10.0) * ( ev->data2 - (accelerometer_yHome + accelerometer_ywindow) )); // Right					       
		printf("derecha\n");
	}
      if (ev->data2 <  (accelerometer_yHome - accelerometer_ywindow)) {
//		mousex = -abs((accelerometer_yscale / 10.0) * ( ev->data2 - (accelerometer_yHome - accelerometer_ywindow) ));  //Left
		printf("izquierda\n");
	}
      
      
	if (ev->data3 >  (accelerometer_zHome + accelerometer_zwindow)) {
      		if (ev->data2 >  (accelerometer_yHome + accelerometer_ywindow))
			return 2;
      		else if (ev->data2 <  (accelerometer_yHome - accelerometer_ywindow))
			return 8;
		else
			return 1;
	} else if (ev->data3 <  (accelerometer_zHome - accelerometer_zwindow)) {
      		if (ev->data2 >  (accelerometer_yHome + accelerometer_ywindow))
			return 4;
      		else if (ev->data2 <  (accelerometer_yHome - accelerometer_ywindow))
			return 6;
		else
			return 5;
	} else if (ev->data2 >  (accelerometer_yHome + accelerometer_ywindow))
			return 3;
	else if (ev->data2 <  (accelerometer_yHome - accelerometer_ywindow))
			return 7;



      return 0;    // eat events
    

}

int get_action_buttons(void)
{
	int mx, my;
	int mb=SDL_GetMouseState(&mx, &my);

	if (mb==1) {
		if (my<80) {
			if (mx<100)	
				return 1;
			else if (mx<200)
				return 2;
			else
				return 3;
		} else if (my<160) {
			if (mx<100)	
				return 4;
			else if (mx<200)
				return 5;
			else
				return 6;
		} else if (my<321) {
			if (mx<100)	
				return 7;
			else if (mx<200)
				return 8;
			else
				return 9;
		}
	}

	return 0;

}


int get_direction_controler(void)
{
  event_t ev;
 const unsigned int report_len = 16;
  unsigned char report[report_len];
  struct accel_3d_t accel;
  accel.val[0] = 0.0;
  accel.val[1] = 0.0;
  accel.val[2] = 0.0;
  
  unsigned short int rel = 1;
  
  while (rel!=0)
    {
      int read_len = read(file_event, report, report_len);
      /* this was a blocking read */
      if (read_len < 0)
	{	
	}
  
      else {
	rel = *(unsigned short int *)(report + 8);
	/*                                                                                                                     
	 * Neo sends three reports on X, Y, and Z with rel = 2                                                                 
	 * and another one (as a separator) with rel = 0                                                                       
	 */
	if (rel == 2)
	  {
	    unsigned short int axis_ind = *(short int *)(report + 10);
	    /* receives signed acceleration in milli-G */
	    int val_mg = *(int *)(report + 12);
	    accel.val[axis_ind] = val_mg;
	  }
     } 
    }  
      ev.type = ev_accelerometer;
      ev.data1 = accel.val[0];
      ev.data2 = accel.val[1];
      ev.data3 = accel.val[2];
      
     return get_position(&ev);
    
}
