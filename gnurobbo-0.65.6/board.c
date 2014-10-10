/*  GNU Robbo
 *  Copyright (C) 2002-2010 The GNU Robbo Team (see AUTHORS).
 *
 *  GNU Robbo is free software - you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2, or (at your option)
 *  any later version.
 *
 *  GNU Robbo is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the impled warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with GNU CC; see the file COPYING. If not, write to the
 *  Free Software Foundation, 59 Temple Place - Suite 330,
 *  Boston, MA 02111-1307, USA.
 *
 */

#include "game.h"

/* Defines */
/*
#define DEBUG_MONITOR_OBJECT_PROCESSING
#define DEBUG_INSPECT_OBJECT_CONTENTS
#define DEBUG_BEAR_LOGIC
*/
#define MAX_TELEPORT_IDS 15	/* max number of teleports of one kind at level */

/* Variables */


/* Function prototypes */
int random_id (void);
int update_coords (struct Coords *coords, int direction);

void set_images (int type, int x, int y);
int can_move (struct Coords coords, int direction);
void move_object (int x, int y, struct Coords coords);
void shoot_object (int x, int y, int direction);
void blow_bomb (int x, int y);
void check_object_if_blowed (int x, int y);
int find_teleport (struct Coords *coords, int teleportnumber,
		   int teleportnumber2);
int is_robbo_killed (void);
void kill_robbo (void);



/***************************************************************************
 * Update Game                                                             *
 ***************************************************************************/
/* Main function for the game - called every game cycle.

   Thunor: Objects that I have 'processed' checked that required it :-
   [x] - BEAR/_B
   [x] - BARRIER
   [x] - BIRD
   [x] - BUTTERFLY
   [x] - BLASTER
   [x] - LASER_L/D
   [x] - PUSH_BOX
   [x] - GUN

*/

void
update_game (void)
{
  int x_tmp, flag, sflag, temp_state = 0, temp_blowed = 0, temp_direction = 0;
  struct Coords coords, coords_temp, dest, coords_side_behind, coords_behind;
  int x, y, i, forceforward;

  dest.x = 0;			/* to avoid warnings */
  dest.y = 0;
  play_music ();
  /* Firstly, update Robbo */
  if (is_robbo_killed ())
    kill_robbo ();		/* If Robbo has been killed then mark everything to be blown-up */
  if (robbo.shooted > 0)
    robbo.shooted--;		/* Decrement shot delay */
  if (robbo.moved > 0)
    robbo.moved--;		/* Decrement movement delay */
  if (robbo.moved == 0)
    {
      robbo.teleporting = FALSE;
      redraw_field (robbo.x, robbo.y);
      /* Is Robbo currently being pulled by a magnet? */
      if (robbo.blocked == 1)
	{
	 
 	play_sound (SFX_MAGNET, SND_NORM);	/* play magnet sound */
	  set_coords (&coords, robbo.x, robbo.y);
	  if (can_move (coords, robbo.blocked_direction))
	    {
	      switch (robbo.blocked_direction)
		{
		case 0:
		  robbo.x++;
		  break;
		case 2:
		  robbo.x--;
		  break;
		case 1:
		  robbo.y++;
		  break;
		case 3:
		  robbo.y--;
		  break;
		}

	      robbo.moved = DELAY_MAGNET_ATTRACT;
	      redraw_field (robbo.x, robbo.y);
	    }
	  else
	    {
	      kill_robbo ();
	      return;		/* Thunor: this was already here; I didn't add this, but I did add some lower down */
	    }
	}
    }
  else if (robbo.moved == DELAY_ROBBO_ANIMATE)
    {
      robbo.state = !robbo.state;	/* Toggle Robbo's image */
      redraw_field (robbo.x, robbo.y);
    }

  /* Now iterate through every board location updating objects */
  for (y = 0; y < level.h; y++)
    {				/* Thunor: I have swapped these around to process by rows */
      for (x = 0; x < level.w; x++)
	{			/* Thunor: I have swapped these around to process by rows */

	  /* Thunor: I've added this check to filter out already processed objects. Additionally the
	     object logic updates other objects and I have modified the code to mark those as
	     processed too. The reason I am doing this is because objects can get moved ahead of the
	     x/y loop resulting in them having at least their shooted/rotated/moved properties
	     decremented more than once for this cycle and they go out of sync */
	  if (board[x][y].processed != cycle_count)
	    {
	      board[x][y].processed = cycle_count;

	      /* GUN and BIRD objects can rotate and shoot so update their delays here */
	      if (board[x][y].type == GUN || board[x][y].type == BIRD)
		{
		  if (board[x][y].shooted > 0)
		    board[x][y].shooted--;	/* Decrement shot delay */
		  if (board[x][y].rotated > 0)
		    board[x][y].rotated--;	/* Decrement rotation delay */
		}

	      /* Decrement the object's delay and then check if it needs processing */
	      if (board[x][y].moved > 0)
		board[x][y].moved--;
	      if (board[x][y].moved <= 0)
		{
		  check_object_if_blowed (x, y);	/* blow objects marked for blowing */

		  set_coords (&coords, x, y);

		  switch (board[x][y].type)
		    {
						/*********************/
		      /* BEAR/_B logic     */
						/*********************/
		    case BEAR:
		    case BEAR_B:
		      /* Left/right-hand rule maze traversal: this is the exact same way that the original Robbo does it.
		         The bears will attempt to manoeuvre around all obstacles but this takes time and they will
		         get killed by laser fire and push boxes especially if they meet them head-on */
		      set_coords (&coords, x, y);
		      if (game_mode == GAME_ON)
			{
			  if (board[x][y].type == BEAR)
			    {
			      update_coords (&coords, (board[x][y].direction + 3) & 3);	/* Get coords of left board location */
			    }
			  else
			    {
			      update_coords (&coords, (board[x][y].direction + 1) & 3);	/* Get coords of right board location */
			    }
			}
		      forceforward = FALSE;
		      /* Are we implementing sensible_bears? In the Atari Robbo, there are two conditions that place bears into
		         irritating states that become annoying: single bears in empty space going around themselves and two bears
		         of the same type going around one another.

		         |N| | = If this is a BEAR_B taking rights, it will go clockwise forever.
		         | | |   N is north.

		         | |N| = If these are BEARs taking lefts, they will go anti-clockwise forever.
		         |S| |   N is north, S is south.

		         sensible_bears detects the conditions that lead to these problems and fixes them by forcing the bears to
		         go forward until they find another obstacle to navigate around */
		      if (game_mechanics.sensible_bears)
			{
			  set_coords (&coords_side_behind, coords.x,
				      coords.y);
			  update_coords (&coords_side_behind, (board[x][y].direction + 2) & 3);	/* Get coords of side-behind board location */
			  set_coords (&coords_behind, coords_side_behind.x,
				      coords_side_behind.y);
			  if (board[x][y].type == BEAR)
			    {
			      update_coords (&coords_behind, (board[x][y].direction + 1) & 3);	/* Get coords of behind board location */
			    }
			  else
			    {
			      update_coords (&coords_behind, (board[x][y].direction + 3) & 3);	/* Get coords of behind board location */
			    }
			  if (board[coords.x][coords.y].type == EMPTY_FIELD
			      && board[coords_behind.x][coords_behind.y].
			      type == EMPTY_FIELD
			      &&
			      (board[coords_side_behind.x]
			       [coords_side_behind.y].type == EMPTY_FIELD
			       || board[x][y].type ==
			       board[coords_side_behind.x][coords_side_behind.
							   y].type))
			    {
			      forceforward = TRUE;
			    }
			}
#ifdef DEBUG_BEAR_LOGIC
		      if (board[x][y].type == BEAR)
			{
			  printf ("|%02i| @| %06i: BEAR at %03i.%03i\n",
				  board[coords.x][coords.y].type, cycle_count,
				  x, y);
			  printf ("|%02i|%02i|\n",
				  board[coords_side_behind.x]
				  [coords_side_behind.y].type,
				  board[coords_behind.x][coords_behind.y].
				  type);
			}
		      else if (board[x][y].type == BEAR_B)
			{
			  printf ("| *|%02i| %06i: BEAR_B at %03i.%03i\n",
				  board[coords.x][coords.y].type, cycle_count,
				  x, y);
			  printf ("|%02i|%02i|\n",
				  board[coords_behind.x][coords_behind.y].
				  type,
				  board[coords_side_behind.
					x][coords_side_behind.y].type);
			}
#endif
		      /* Check left/right and if it's clear then take it */
		      if (board[coords.x][coords.y].type == EMPTY_FIELD
			  && !forceforward)
			{
			  /* Left/right is clear so change to that direction and move there */
			  if (board[x][y].type == BEAR)
			    {
			      board[x][y].direction = (board[x][y].direction + 3) & 3;	/* Go left */
			    }
			  else
			    {
			      board[x][y].direction = (board[x][y].direction + 1) & 3;	/* Go right */
			    }
			  board[x][y].moved = DELAY_BEAR;
			  negate_state (x, y);
			  move_object (x, y, coords);
			}
		      else
			{
			  /* Left/right is not clear so check forward and if it's clear then take it */
			  set_coords (&coords, x, y);
			  update_coords (&coords, board[x][y].direction);	/* Get coords of forward board location */
			  if (board[coords.x][coords.y].type == EMPTY_FIELD)
			    {
			      /* Forward is clear so move there */
			      board[x][y].moved = DELAY_BEAR;
			      negate_state (x, y);
			      move_object (x, y, coords);
			    }
			  else
			    {
			      /* Forward is not clear so rotate rightward but don't move */
			      if (board[x][y].type == BEAR)
				{
				  board[x][y].direction = (board[x][y].direction + 1) & 3;	/* Go forward */
				}
			      else
				{
				  board[x][y].direction = (board[x][y].direction + 3) & 3;	/* Go forward */
				}
			      board[x][y].moved = DELAY_BEAR;
			      board[x][y].processed = cycle_count;	/* Because we're not moving, we do this manually */
			      negate_state (x, y);
			    }
			}
		      break;

			/*********************/
			/* BARRIER logic     */
			/*********************/
			case BARRIER:
				flag = 0;
				x_tmp = x;

				if (board[x][y].direction == 0)	/* East -> */
				{
					while (x_tmp < level.w && board[x_tmp][y].type != WALL) x_tmp++;
					
					x_tmp--;

					if (board[x_tmp][y].type == BARRIER)
					{
						temp_state = board[x_tmp][y].state;
						temp_blowed = board[x_tmp][y].blowed;
						temp_direction = board[x_tmp][y].direction;
						clear_field (x_tmp, y);
						negate_state (x_tmp, y);
						flag = 1;
					}

					while (x_tmp >= 0 && board[x_tmp][y].type != WALL)
					{
						x_tmp--;

						/* Thunor: I added "x_tmp >= 0 && " below to prevent referencing invalid array elements
						 * as x_tmp can be -1 here if the barrier is up against the left map edge. Following
						 * this block of code, x_tmp is incremented and so this is the most suitable solution */
						if (x_tmp >= 0 && board[x_tmp][y].type == BARRIER)
						{
							check_object_if_blowed (x_tmp, y);
							dest.x = x_tmp + 1;
							dest.y = y;

							if ((dest.x == robbo.x) && (dest.y == robbo.y))
							{
								kill_robbo ();
								return;	/* Thunor: Exiting here stops new barriers from being created */
							}

							move_object (x_tmp, y, dest);
							/* board[dest.x][dest.y].direction = 0; */
							board[dest.x][dest.y].moved = DELAY_BARRIER;
							board[dest.x][dest.y].processed = cycle_count;	/* Thunor: Prevents this object from being processed again this cycle */
							negate_state (dest.x, dest.y);
						}
					}

					x_tmp++;

					if (flag == 1)
					{
						if ((dest.x == robbo.x) && (dest.y == robbo.y))
						{
							kill_robbo ();
							return;	/* Thunor: Exiting here stops new barriers from being created */
						}

						if (robbo.x == x_tmp && robbo.y == y)
						{
							kill_robbo ();
							return;
						}

						create_object (x_tmp, y, BARRIER);
						board[x_tmp][y].state = temp_state;
						board[x_tmp][y].blowed = temp_blowed;
						board[x_tmp][y].direction = temp_direction;
						board[x_tmp][y].moved = DELAY_BARRIER;
						negate_state (x_tmp, y);
					}
				}
				else if (board[x][y].direction == 2)	/* <- West*/
				{
					while (x_tmp >= 0 && board[x_tmp][y].type != WALL) x_tmp--;

					x_tmp++;

					if (board[x_tmp][y].type == BARRIER)
					{
						temp_state = board[x_tmp][y].state;
						temp_blowed = board[x_tmp][y].blowed;
						temp_direction = board[x_tmp][y].direction;
						clear_field (x_tmp, y);
						negate_state (x_tmp, y);
						flag = 1;
					}

					while (x_tmp < level.w && board[x_tmp][y].type != WALL)
					{
						x_tmp++;
						
						/* Thunor: I added "x_tmp < level.w && " below to prevent referencing invalid array elements
						 * as x_tmp can be level.w here if the barrier is up against the right map edge. Following
						 * this block of code, x_tmp is decremented and so this is the most suitable solution */
						if (x_tmp < level.w && board[x_tmp][y].type == BARRIER)
						{
							check_object_if_blowed (x_tmp, y);
							dest.x = x_tmp - 1;
							dest.y = y;

							if ((dest.x == robbo.x) && (dest.y == robbo.y))
							{
								kill_robbo ();
								return;	/* Thunor: Exiting here stops new barriers from being created */
							}

							move_object (x_tmp, y, dest);
							/* board[dest.x][dest.y].direction = 2; */
							board[dest.x][dest.y].moved = DELAY_BARRIER;
							board[dest.x][dest.y].processed = cycle_count;	/* Thunor: Prevents this object from being processed again this cycle */
							negate_state (dest.x, dest.y);
						}
					}

					x_tmp--;

					if (flag == 1 && temp_blowed == 0)
					{
						if ((dest.x == robbo.x) && (dest.y == robbo.y))
						{
							kill_robbo ();
							return;	/* Thunor: Exiting here stops new barriers from being created */
						}

						if (robbo.x == x_tmp && robbo.y == y)
						{
							kill_robbo ();
							return;
						}

						create_object (x_tmp, y, BARRIER);
						board[x_tmp][y].state = temp_state;
						board[x_tmp][y].moved = DELAY_BARRIER;
						board[x_tmp][y].direction = temp_direction;
						negate_state (x_tmp, y);
					}
				}
				break;

						/*********************/
		      /* BIRD logic        */
						/*********************/
		    case BIRD:
		      if (can_move (coords, board[x][y].direction))
			{
			  update_coords (&coords, board[x][y].direction);
			  move_object (x, y, coords);

			}
		      else
			board[x][y].direction =
			  (board[x][y].direction + 2) & 0x03;

		      if (board[coords.x][coords.y].shooting)
			{
			  if (board[coords.x][coords.y].shooted == 0)
			    {
			      if ((my_rand () & 0x07) == 0)
				{	/* bird shoots */
				  shoot_object (coords.x, coords.y,
						board[coords.x][coords.y].
						direction2);
				  if (in_viewport(x,y)) play_sound (SFX_BIRD, SND_NORM);
				}
			      else
				board[coords.x][coords.y].shooted =
				  DELAY_LASER;
			    }
			}
		      board[coords.x][coords.y].moved = DELAY_BIRD;
		      negate_state (coords.x, coords.y);
		      break;
						/*********************/
		      /* BUTTERFLY logic   */
						/*********************/
		    case BUTTERFLY:
		      if (can_move (coords, board[x][y].direction))
			{
			  update_coords (&coords, board[x][y].direction);
			  move_object (x, y, coords);
			}

		      if (!(rand () & 0x07))	/* chances for random move */
			board[coords.x][coords.y].direction = rand () & 0x03;

		      else if ((rand () & 0x01) == 0)
			{	/* if butterfly flies horizontally */
			  if (robbo.x > coords.x)
			    board[coords.x][coords.y].direction = 0;
			  else if (robbo.x < coords.x)
			    board[coords.x][coords.y].direction = 2;
			}
		      else
			{	/* if butterfly flies vertically */
			  if (robbo.y > coords.y)
			    board[coords.x][coords.y].direction = 1;
			  else if (robbo.y < coords.y)
			    board[coords.x][coords.y].direction = 3;
			}

		      board[coords.x][coords.y].moved = DELAY_BUTTERFLY;
		      negate_state (coords.x, coords.y);
		      break;
						/*********************/
		      /* BLASTER logic     */
						/*********************/
		    case BLASTER:
		      set_coords (&coords, x, y);
		      redraw_field (x, y);
		      set_coords (&coords_temp, x, y);	/* * neurocyp now we will check if the gun was removed during blaster shot, if so, we have to react */
		      temp_state = board[coords_temp.x][coords_temp.y].state;
		      while (board[coords_temp.x][coords_temp.y].type ==
			     BLASTER)
			{
			  temp_state =
			    board[coords_temp.x][coords_temp.y].state;
			  update_coords (&coords_temp,
					 (board[coords_temp.x]
					  [coords_temp.y].direction + 2) % 4);
			}
		      if (temp_state < 3
			  && board[coords_temp.x][coords_temp.y].type != GUN)
			{
			  create_object (coords.x, coords.y, LITTLE_BOOM);	/* so the gun was removed during shot? ok, clear it out */
			  board[coords.x][coords.y].moved = DELAY_BLASTER;
			  break;
			}



		      if (!update_coords
			  (&coords, board[coords.x][coords.y].direction)
			  && board[x][y].state == 0)
			{
			  if (robbo.x == coords.x && robbo.y == coords.y)
			    {
			      kill_robbo ();
			      return;	/* Thunor: Exiting here stops new blasters from being created */
			    }
			  switch (board[coords.x][coords.y].type)
			    {
			    case DOOR:
			    case WALL:
			    case MAGNET:
			    case BOX:
			    case TELEPORT:
			    case PUSH_BOX:
			    case BARBED_WIRE:
			    case STOP:
			    case GUN:
			    case LASER_D:
			    case LASER_L:
			    case BLASTER:
			    case SCREW:
			    case KEY:
			    case CAPSULE:
			      break;
			    case BOMB:
			      board[coords.x][coords.y].blowed =
				DELAY_BLASTER;
			      break;
			    default:
			      clear_field (coords.x, coords.y);
			      create_object (coords.x, coords.y, BLASTER);
			      board[coords.x][coords.y].direction =
				board[x][y].direction;
			      board[coords.x][coords.y].direction2 =
				board[x][y].direction2;
			      board[coords.x][coords.y].moved = DELAY_BLASTER;
			    }
			}
		      if (board[x][y].state < 4)
			{
			  board[x][y].state++;
			  board[x][y].moved = DELAY_BLASTER;
			}
		      else
			{
			  clear_field (x, y);
			}
		      break;
						/*********************/
		      /* CAPSULE logic     */
						/*********************/
		    case CAPSULE:
		      if (robbo.exitopened)
			{
			  negate_state (x, y);
			  board[x][y].moved = DELAY_CAPSULE;
			}
		      break;
						/*********************/
		      /* LITTLE_BOOM logic */
						/*********************/
		    case LITTLE_BOOM:
		      redraw_field (x, y);
		      if (board[x][y].state < 3)
			{
			  board[x][y].state++;
			  board[x][y].moved = DELAY_LITTLE_BOOM;
			}
		      else
			clear_field (x, y);
		      break;
						/*********************/
		      /* LASER_L/D logic   */
						/*********************/
		    case LASER_L:
		    case LASER_D:
		      redraw_field (x, y);
		      update_coords (&coords, board[x][y].direction);
		      board[x][y].moved = DELAY_LASER;

		      if ((coords.x == robbo.x) && (coords.y == robbo.y)
			  && !board[x][y].returnlaser)
			{
			  kill_robbo ();
			  return;	/* Thunor: Exiting here stops new lasers from being created */
			}
		      set_coords (&coords, x, y);
		      if (board[x][y].solidlaser == 0)
			{
			  negate_state (x, y);

			  if (can_move (coords, board[x][y].direction))
			    {	/* normal shooting */
			      update_coords (&coords, board[x][y].direction);
			      move_object (x, y, coords);
			      board[coords.x][coords.y].moved = DELAY_LASER;
			    }
			  else
			    {	/* blow object if it's destroyable */
			      if (!update_coords
				  (&coords, board[x][y].direction)
				  && board[coords.x][coords.y].destroyable)
				{
				  if (board[coords.x][coords.y].type != BOMB)
				    if (in_viewport(x,y)) play_sound (SFX_KILL, SND_NORM);
				  clear_field (x, y);
				  board[coords.x][coords.y].blowed = 1;
				  redraw_field (coords.x, coords.y);
				}
			      else
				{
				  clear_field (x, y);	/* clear lasertrack */
				  create_object (x, y, LITTLE_BOOM);
				  board[x][y].moved = DELAY_LITTLE_BOOM;
				  break;
				}
			    }
			}
		      else
			{	/* laser is solid */
			  set_coords (&coords_temp, x, y);	/* first let's check that laser starts from a gun, if not, means gun was moved, or blown */
			  while (board[coords_temp.x][coords_temp.y].type == board[x][y].type)	/* move on laser */
			    update_coords (&coords_temp,
					   (board[x][y].direction + 2) % 4);
			  if (board[coords_temp.x][coords_temp.y].type != GUN)	/* ok, now we are at the beginning of laser beam if it is not a gun, which is there, destroy laser */
			    {
			      create_object (x, y, LITTLE_BOOM);
			      break;
			    }
			  if (can_move (coords, board[x][y].direction)
			      && board[x][y].returnlaser == 0)
			    {	/* if can shoot */
			      update_coords (&coords, board[x][y].direction);
			      shoot_object (x, y, board[x][y].direction);
			      board[coords.x][coords.y].moved = DELAY_LASER;
			    }
			  else
			    {
			      if (board[x][y].returnlaser == 1)
				{
				  set_coords (&coords, x, y);	/* checking if laser is near gun */
				  update_coords (&coords,
						 (board[x][y].direction +
						  2) & 0x03);
				  clear_field (x, y);

				  if (board[coords.x][coords.y].type == GUN)
				    {
				      create_object (x, y, LITTLE_BOOM);
				      break;
				    }

				  if (board[coords.x][coords.y].type ==
				      LASER_D
				      || board[coords.x][coords.y].type ==
				      LASER_L)
				    {
				      board[coords.x][coords.y].returnlaser =
					1;
				      board[coords.x][coords.y].moved =
					DELAY_LASER;
				      board[coords.x][coords.y].processed = cycle_count;	/* Thunor: Prevents this object from being processed again this cycle */
				    }

				}
			      else
				{
				  set_coords (&coords, x, y);
				  if (!update_coords
				      (&coords, board[x][y].direction))
				    {
				      if (board[coords.x][coords.y].type ==
					  LASER_D
					  || board[coords.x][coords.y].type ==
					  LASER_L)
					{
					  if (board[coords.x]
					      [coords.y].direction ==
					      board[x][y].direction)
					    break;
					}
				      if (board[coords.x]
					  [coords.y].destroyable)
					{
					  board[coords.x][coords.y].blowed =
					    1;
					  if (board[coords.x][coords.y].type
					      != BOMB)
					    if (in_viewport(x,y)) play_sound (SFX_KILL, SND_NORM);
					}
				    }
				  board[x][y].returnlaser = 1;
				}
			    }
			}
		      break;
						/*********************/
		      /* BIG_BOOM logic    */
						/*********************/
		    case BIG_BOOM:
		      redraw_field (x, y);
		      if (board[x][y].state < 4)
			{
			  board[x][y].state++;
			  board[x][y].moved = DELAY_BIGBOOM;
			}
		      else
			{

			  i = board[x][y].id_questionmark;	/* This is why create_object() doesn't clear this property */
			  if ((i > 0) && robbo.alive)
			    {
			      clear_field (x, y);
			      if (i == QUESTIONMARK)
				board[x][y].id_questionmark = random_id ();
			      create_object (x, y, i);
			      switch (i)
				{
				case CAPSULE:
				  open_exit ();
				  break;
				case GUN:
				  board[x][y].rotable = 1;
				  board[x][y].randomrotated = 1;
				  board[x][y].direction = rand () & 0x03;
				  break;
				default:
				  break;
				}
			    }
			  else
			    clear_field (x, y);
			}
		      break;
						/*********************
                                                * BARBED WIRE logic *
                                                *********************/
		    case BARBED_WIRE:
		      negate_state (x, y);
		      board[x][y].moved = DELAY_BW;
		      break;

						/*********************/
		      /* TELEPORT logic    */
						/*********************/
		    case TELEPORT:
		      negate_state (x, y);
		      board[x][y].moved = DELAY_TELEPORT;
		      break;
						/*********************/
		      /* TELEPORTING logic */
						/*********************/
		    case TELEPORTING:
		      redraw_field (x, y);
		      if (board[x][y].state < 4)
			{
			  board[x][y].state++;
			  board[x][y].moved = DELAY_TELEPORTING;
			}
		      else
			{
			  clear_field (x, y);
			}
		      break;
						/*********************/
		      /* PUSH_BOX logic    */
						/*********************/
		    case PUSH_BOX:
		      if (board[x][y].state == 1)
			{	/* box is moving */
			  set_coords (&coords, x, y);
			  if (!update_coords (&coords, board[x][y].direction))
			    {
			      if (board[coords.x][coords.y].type ==
				  EMPTY_FIELD)
				{
				  move_object (x, y, coords);
				}
			      else
				{
				  shoot_object (x, y, board[x][y].direction);
				  board[x][y].state = 0;
				}
			    }
			  else
			    board[x][y].state = 0;
			  if (in_viewport(x,y)) 
				play_sound (SFX_BOX, SND_NORM);	/* play the sound */
			  board[coords.x][coords.y].moved = DELAY_PUSHBOX;
			}
		      break;
						/*********************/
		      /* MAGNET logic      */
						/*********************/
		    case MAGNET:
		      i = 0;
		      if (robbo.blocked == 1)
			break;	/* *neurocyp we are already locked on a magnet we ignore other blocks */
		      while (i == 0)
			{
			  if (!update_coords (&coords, board[x][y].direction))
			    {
			      if (robbo.x == coords.x && robbo.y == coords.y)
				{
				  robbo.blocked = 1;
				  robbo.blocked_direction =
				    (board[x][y].direction + 2) & 0x03;
				}
			      else
				switch (board[coords.x][coords.y].type)
				  {
				    /* this things don't protect from magnet */
				  case EMPTY_FIELD:
				    break;
				  default:
				    i = 1;
				    break;
				  }

			    }
			  else
			    i = 1;
			}
		      break;
						/*********************/
		      /* GUN logic         */
						/*********************/
		    case GUN:
		      set_coords (&coords, x, y);
#ifdef DEBUG_MONITOR_OBJECT_PROCESSING
		      printf ("cycle_count=%i: board[%i][%i].processed=%i\n",
			      cycle_count, x, y, board[x][y].processed);
#endif
		      sflag = 0;	/* shooting flag */
		      /* we need to make sure this would not rotate nor move, when it is shooting solid laser */
		      set_coords (&coords_temp, coords.x, coords.y);
		      update_coords (&coords_temp,
				     board[coords.x][coords.y].direction);

		      if (board[coords_temp.x][coords_temp.y].direction ==
			  board[coords.x][coords.y].direction)
			switch (board[coords_temp.x][coords_temp.y].type)
			  {
			  case BLASTER:
			  case SOLID_LASER_L:
			  case SOLID_LASER_D:
			  case LASER_L:
			  case LASER_D:
			    sflag = 1;	/* *neurocyp  we are not supposed to move nor rotate */
			    break;
			  }
		      if (sflag == 0)
			{
			  if (board[coords.x][coords.y].movable)	/*  *neurocyp no move during solid laser or blaster shot */
			    {

			      if (can_move (coords, board[x][y].direction2))	/*  *neurocyp here probably we should implement stopping during solid laser or blaster shot */
				{
				  update_coords (&coords,
						 board[x][y].direction2);
				  move_object (x, y, coords);
				  board[coords.x][coords.y].moved = DELAY_GUN;
				}
			      else
				{
				  board[coords.x][coords.y].direction2 =
				    (board[coords.x][coords.y].direction2 +
				     2) & 0x03;
				  board[coords.x][coords.y].state =
				    board[x][y].direction;
				  board[coords.x][coords.y].moved = DELAY_GUN;
				}
			    }
			  if (board[coords.x][coords.y].rotable)	/*  *neurocyp we will not rotate, when we shoot */
			    {
			      if (board[coords.x][coords.y].rotated == 0)
				{

				  if (board[coords.x][coords.y].randomrotated)
				    {
				      board[coords.x][coords.y].direction =
					rand () & 0x03;
				    }
				  else
				    {
				      board[coords.x][coords.y].direction =
					(board[coords.x][coords.y].direction +
					 1) & 0x03;
				    }
				  board[coords.x][coords.y].rotated =
				    DELAY_ROTATION;
				  redraw_field (coords.x, coords.y);
				}
			    }
			}
		      if (board[coords.x][coords.y].shooted == 0)
			{
			  if (board[coords.x][coords.y].solidlaser == 2)
			    {
			      if (((rand ()) & 0x07) == 0)
				{	/* it's blaster  */
				  if (in_viewport(x,y)) play_sound (SFX_GUN, SND_NORM);
				  set_coords (&coords_temp, coords.x,
					      coords.y);
				  update_coords (&coords_temp,
						 board[coords.x][coords.
								 y].direction);
				  if (robbo.x == coords_temp.x
				      && robbo.y == coords_temp.y)
				    {
				      kill_robbo ();
				      return;	/* Thunor: Exiting here stops new blasters from being created */
				    }
				  switch (board[coords_temp.x]
					  [coords_temp.y].type)
				    {
				    case BLASTER:
				    case TELEPORT:
				    case MAGNET:
				    case WALL:
				    case BOX:
				    case PUSH_BOX:
				    case CAPSULE:
				    case SCREW:
				    case STOP:
				    case BARBED_WIRE:
				    case KEY:
				    case DOOR:
				    case GUN:
				      board[coords.x][coords.y].shooted =
					DELAY_LASER;
				      break;
				    case BOMB:
				      board[coords_temp.x][coords_temp.y].
					blowed = DELAY_LASER;
				      break;
				    default:

				      clear_field (coords_temp.x,
						   coords_temp.y);
				      create_object (coords_temp.x,
						     coords_temp.y, BLASTER);
				      board[coords_temp.x][coords_temp.y].direction = board[coords.x][coords.y].direction;	/* we allow moving blaster guns! */
				      board[coords_temp.x][coords_temp.
							   y].direction2 =
					board[coords.x][coords.y].direction;
				      board[coords_temp.x][coords_temp.
							   y].moved =
					DELAY_BLASTER;
				      board[coords.x][coords.y].shooted =
					DELAY_LASER;
				    }
				}
			      else
				board[coords.x][coords.y].shooted =
				  DELAY_LASER;
			    }
			  else
			    {
			      if ((rand () & 0x07) == 0)
				{
				  /* gun shoots */
				  if (in_viewport(x,y)) play_sound (SFX_GUN, SND_NORM);
				  shoot_object (coords.x, coords.y,
						board[coords.x][coords.y].
						direction);
				}
			      else
				board[coords.x][coords.y].shooted =
				  DELAY_LASER;
#ifdef DEBUG_MONITOR_OBJECT_PROCESSING
			      printf
				("--cycle_count=%i: board[coords.x=%i][coords.y=%i].processed=%i\n",
				 cycle_count, coords.x, coords.y,
				 board[coords.x][coords.y].processed);
			      if (board[coords.x][coords.y].processed !=
				  cycle_count)
				printf
				  ("--OBJECT NOT MARKED AS PROCESSED FOR THIS CYCLE! <<<<<<<<<<\n");
/*	printf("--cycle_count=%i: board[dest.x=%i][dest.y=%i].processed=%i\n", cycle_count, dest.x, dest.y, board[dest.x][dest.y].processed); */
/*	if (board[dest.x][dest.y].processed != cycle_count) printf("--OBJECT NOT MARKED AS PROCESSED FOR THIS CYCLE! <<<<<<<<<<\n"); */
#endif
			    }
			}

		      board[coords.x][coords.y].state =
			board[coords.x][coords.y].direction;
		      break;

		    }
		}
	    }			/* .processed check */
	}
    }
}

/************************************************************/
/********** Init questionmark objects **********************/
/************************************************************/

void
init_questionmarks (void)
{
  int i, j;

  for (i = 0; i < level.w; i++)
    for (j = 0; j < level.h; j++)
      {
	if (board[i][j].type == QUESTIONMARK)
	  {
	    board[i][j].id_questionmark = random_id ();
	  }
      }
}

/***************************************************************************
 * Returning really random object                                          *
 ***************************************************************************/
/* Function returning random object id */

int
random_id (void)
{
  int ids[11] =
    { EMPTY_FIELD, PUSH_BOX, SCREW, BULLET, KEY, BOMB, GROUND, BUTTERFLY, GUN,
    QUESTIONMARK, CAPSULE
  };

  if (game_mechanics.sensible_questionmarks)
    {
      return ids[my_rand () % 10];
    }
  else
    {
      return ids[my_rand () % 11];
    }
}

/******************************************************/
/* Update Coords **************************************/
/******************************************************/
/* Note that if modifying the coords results in them going off-board
   then the coords returned are the same as passed */

int
update_coords (struct Coords *coords, int direction)
{
  struct Coords coords_temp;
  coords_temp.x = coords->x;
  coords_temp.y = coords->y;

  if (direction == 0)
    coords->x++;
  else if (direction == 1)
    coords->y++;
  else if (direction == 2)
    coords->x--;
  else
    coords->y--;

  if (coords->x < 0 || coords->y < 0 || coords->x >= level.w
      || coords->y >= level.h)
    {
      set_coords (coords, coords_temp.x, coords_temp.y);
      return 1;
    }
  return 0;
}

/******************************************************/
/* Set Coords *****************************************/
/******************************************************/

void
set_coords (struct Coords *coords, int x, int y)
{
  coords->x = x;
  coords->y = y;
}

/******************************************************/
/* Coords Out Of Range ********************************/
/******************************************************/

int
coords_out_of_range (struct Coords coords)
{
  if (coords.x < 0 || coords.x >= level.w || coords.y < 0
      || coords.y >= level.h)
    return 1;
  else
    return 0;
}

/*************************************************************/
/* Negating object state (birds waves their wings etc.. ******/
/*************************************************************/

void
negate_state (int x, int y)
{
  if (x < level.w && y < level.h)
    {
      board[x][y].state = !board[x][y].state;
      board[x][y].redraw = TRUE;
    }
}

/******************************************************/
/* Set Images *****************************************/
/******************************************************/

void
set_images (int type, int x, int y)
{

  if (video.field_size == 16)
    {
      switch (type)
	{
	case EMPTY_FIELD:
	  set_coords (&board[x][y].icon[0], 0, 0);
	  break;
	case WALL:		/* setting coords for icon */
	  set_coords (&board[x][y].icon[0], 35, 1);	/* WALL */
	  set_coords (&board[x][y].icon[1], 52, 1);	/* WALL_RED */
	  set_coords (&board[x][y].icon[2], 86, 35);	/* WALL_GREEN */
	  set_coords (&board[x][y].icon[3], 120, 18);	/* BLACK_WALL */
	  set_coords (&board[x][y].icon[4], 154, 18);	/* FAT_WALL */
	  set_coords (&board[x][y].icon[5], 137, 86);	/* ROUND_WALL */
	  set_coords (&board[x][y].icon[6], 154, 86);	/* BOULDER_WALL */
	  set_coords (&board[x][y].icon[7], 171, 1);	/* SQUARE_WALL */
	  set_coords (&board[x][y].icon[8], 171, 18);	/* LATTICE_WALL */
	  break;
	case SCREW:
	  set_coords (&board[x][y].icon[0], 69, 1);
	  break;
	case BULLET:
	  set_coords (&board[x][y].icon[0], 86, 1);
	  break;
	case BOX:
	  set_coords (&board[x][y].icon[0], 103, 1);
	  break;
	case PUSH_BOX:
	  set_coords (&board[x][y].icon[0], 137, 18);
	  set_coords (&board[x][y].icon[1], 137, 18);	/* pushed box changes state */
	  break;
	case KEY:
	  set_coords (&board[x][y].icon[0], 120, 1);
	  break;
	case BOMB:
	  set_coords (&board[x][y].icon[0], 137, 1);
	  break;
	case DOOR:
	  set_coords (&board[x][y].icon[0], 154, 1);
	  break;
	case QUESTIONMARK:
	  set_coords (&board[x][y].icon[0], 1, 18);
	  break;
	case CAPSULE:
	  set_coords (&board[x][y].icon[0], 86, 18);
	  set_coords (&board[x][y].icon[1], 103, 18);
	  break;
	case BEAR:
	  set_coords (&board[x][y].icon[0], 18, 18);
	  set_coords (&board[x][y].icon[1], 35, 18);
	  break;
	case BIRD:
	  set_coords (&board[x][y].icon[0], 52, 18);
	  set_coords (&board[x][y].icon[1], 69, 18);
	  break;
	case LITTLE_BOOM:
	  set_coords (&board[x][y].icon[0], 35, 35);
	  set_coords (&board[x][y].icon[1], 18, 35);
	  set_coords (&board[x][y].icon[2], 35, 35);
	  set_coords (&board[x][y].icon[3], 52, 35);
	  break;
	case GROUND:
	  set_coords (&board[x][y].icon[0], 69, 35);
	  break;
	case BEAR_B:
	  set_coords (&board[x][y].icon[0], 103, 35);
	  set_coords (&board[x][y].icon[1], 120, 35);
	  break;
	case BUTTERFLY:
	  set_coords (&board[x][y].icon[0], 137, 35);
	  set_coords (&board[x][y].icon[1], 154, 35);
	  break;
	case LASER_L:
	  set_coords (&board[x][y].icon[0], 1, 52);
	  set_coords (&board[x][y].icon[1], 18, 52);
	  set_coords (&board[x][y].icon[2], 1, 35);	/* Thunor: Added for solid lasers */
	  break;
	case LASER_D:
	  set_coords (&board[x][y].icon[0], 35, 52);
	  set_coords (&board[x][y].icon[1], 52, 52);
	  set_coords (&board[x][y].icon[2], 86, 52);	/* Thunor: Added for solid lasers */
	  break;
	case TELEPORT:
	  set_coords (&board[x][y].icon[0], 1, 69);
	  set_coords (&board[x][y].icon[1], 18, 69);
	  break;
	case TELEPORTING:	/* Thunor: Added for dedicated teleport animation */
	  set_coords (&board[x][y].icon[0], 171, 52);
	  set_coords (&board[x][y].icon[1], 171, 69);
	  set_coords (&board[x][y].icon[2], 171, 86);
	  set_coords (&board[x][y].icon[3], 171, 69);
	  set_coords (&board[x][y].icon[4], 171, 52);
	  break;
	case BIG_BOOM:
	  set_coords (&board[x][y].icon[0], 35, 69);
	  set_coords (&board[x][y].icon[1], 52, 69);
	  set_coords (&board[x][y].icon[2], 69, 69);
	  set_coords (&board[x][y].icon[3], 52, 69);
	  set_coords (&board[x][y].icon[4], 35, 69);
	  break;
	case GUN:
	  set_coords (&board[x][y].icon[0], 86, 69);
	  set_coords (&board[x][y].icon[1], 103, 69);
	  set_coords (&board[x][y].icon[2], 120, 69);
	  set_coords (&board[x][y].icon[3], 137, 69);
	  break;
	case MAGNET:
	  set_coords (&board[x][y].icon[0], 1, 1);
	  set_coords (&board[x][y].icon[1], 1, 103);
	  set_coords (&board[x][y].icon[2], 18, 1);
	  set_coords (&board[x][y].icon[3], 18, 103);
	  break;
	case BLASTER:
	  set_coords (&board[x][y].icon[0], 35, 69);
	  set_coords (&board[x][y].icon[1], 52, 69);
	  set_coords (&board[x][y].icon[2], 69, 69);
	  set_coords (&board[x][y].icon[3], 52, 69);
	  set_coords (&board[x][y].icon[4], 35, 69);
	  break;
	case BARRIER:
	  set_coords (&board[x][y].icon[0], 154, 52);
	  set_coords (&board[x][y].icon[1], 154, 69);
	  break;
	case BARBED_WIRE:
	  set_coords (&board[x][y].icon[0], 35, 103);
	  set_coords (&board[x][y].icon[1], 52, 103);

	  break;
	case STOP:
	  set_coords (&board[x][y].icon[0], 69, 103);
	  break;

	}
    }
  else if (video.field_size == 32)
    {
      switch (type)
	{
	case EMPTY_FIELD:
	  set_coords (&board[x][y].icon[0], 2, 240);
	  break;
	case WALL:		/* setting coords for icon */
	  set_coords (&board[x][y].icon[0], 70, 2);	/* WALL */
	  set_coords (&board[x][y].icon[1], 104, 2);	/* WALL_RED */
	  set_coords (&board[x][y].icon[2], 172, 70);	/* WALL_GREEN */
	  set_coords (&board[x][y].icon[3], 240, 36);	/* BLACK_WALL */
	  set_coords (&board[x][y].icon[4], 308, 36);	/* FAT_WALL */
	  set_coords (&board[x][y].icon[5], 274, 172);	/* ROUND_WALL */
	  set_coords (&board[x][y].icon[6], 308, 172);	/* BOULDER_WALL */
	  set_coords (&board[x][y].icon[7], 342, 2);	/* SQUARE_WALL */
	  set_coords (&board[x][y].icon[8], 342, 36);	/* LATTICE_WALL */
	  break;
	case SCREW:
	  set_coords (&board[x][y].icon[0], 138, 2);
	  break;
	case BULLET:
	  set_coords (&board[x][y].icon[0], 172, 2);
	  break;
	case BOX:
	  set_coords (&board[x][y].icon[0], 206, 2);
	  break;
	case PUSH_BOX:
	  set_coords (&board[x][y].icon[0], 274, 36);
	  set_coords (&board[x][y].icon[1], 274, 36);	/* pushed box changes state */
	  break;
	case KEY:
	  set_coords (&board[x][y].icon[0], 240, 2);
	  break;
	case BOMB:
	  set_coords (&board[x][y].icon[0], 274, 2);
	  break;
	case DOOR:
	  set_coords (&board[x][y].icon[0], 308, 2);
	  break;
	case QUESTIONMARK:
	  set_coords (&board[x][y].icon[0], 2, 36);
	  break;
	case CAPSULE:
	  set_coords (&board[x][y].icon[0], 172, 36);
	  set_coords (&board[x][y].icon[1], 206, 36);
	  break;
	case BEAR:
	  set_coords (&board[x][y].icon[0], 36, 36);
	  set_coords (&board[x][y].icon[1], 70, 36);
	  break;
	case BIRD:
	  set_coords (&board[x][y].icon[0], 104, 36);
	  set_coords (&board[x][y].icon[1], 138, 36);
	  break;
	case LITTLE_BOOM:
	  set_coords (&board[x][y].icon[0], 70, 70);
	  set_coords (&board[x][y].icon[1], 36, 70);
	  set_coords (&board[x][y].icon[2], 70, 70);
	  set_coords (&board[x][y].icon[3], 104, 70);
	  break;
	case GROUND:
	  set_coords (&board[x][y].icon[0], 138, 70);
	  break;
	case BEAR_B:
	  set_coords (&board[x][y].icon[0], 206, 70);
	  set_coords (&board[x][y].icon[1], 240, 70);
	  break;
	case BUTTERFLY:
	  set_coords (&board[x][y].icon[0], 274, 70);
	  set_coords (&board[x][y].icon[1], 308, 70);
	  break;
	case LASER_L:
	  set_coords (&board[x][y].icon[0], 2, 104);
	  set_coords (&board[x][y].icon[1], 36, 104);
	  set_coords (&board[x][y].icon[2], 2, 70);	/* Thunor: Added for solid lasers */
	  break;
	case LASER_D:
	  set_coords (&board[x][y].icon[0], 70, 104);
	  set_coords (&board[x][y].icon[1], 104, 104);
	  set_coords (&board[x][y].icon[2], 172, 104);	/* Thunor: Added for solid lasers */
	  break;
	case TELEPORT:
	  set_coords (&board[x][y].icon[0], 2, 138);
	  set_coords (&board[x][y].icon[1], 36, 138);
	  break;
	case TELEPORTING:	/* Thunor: Added for dedicated teleport animation */
	  set_coords (&board[x][y].icon[0], 342, 104);
	  set_coords (&board[x][y].icon[1], 342, 138);
	  set_coords (&board[x][y].icon[2], 342, 172);
	  set_coords (&board[x][y].icon[3], 342, 138);
	  set_coords (&board[x][y].icon[4], 342, 104);
	  break;
	case BIG_BOOM:
	  set_coords (&board[x][y].icon[0], 70, 138);
	  set_coords (&board[x][y].icon[1], 104, 138);
	  set_coords (&board[x][y].icon[2], 138, 138);
	  set_coords (&board[x][y].icon[3], 104, 138);
	  set_coords (&board[x][y].icon[4], 70, 138);
	  break;
	case GUN:
	  set_coords (&board[x][y].icon[0], 172, 138);
	  set_coords (&board[x][y].icon[1], 206, 138);
	  set_coords (&board[x][y].icon[2], 240, 138);
	  set_coords (&board[x][y].icon[3], 274, 138);
	  break;
	case MAGNET:
	  set_coords (&board[x][y].icon[0], 2, 2);
	  set_coords (&board[x][y].icon[1], 2, 206);
	  set_coords (&board[x][y].icon[2], 36, 2);
	  set_coords (&board[x][y].icon[3], 36, 206);
	  break;
	case BLASTER:
	  set_coords (&board[x][y].icon[0], 70, 138);
	  set_coords (&board[x][y].icon[1], 104, 138);
	  set_coords (&board[x][y].icon[2], 138, 138);
	  set_coords (&board[x][y].icon[3], 104, 138);
	  set_coords (&board[x][y].icon[4], 70, 138);
	  break;
	case BARRIER:
	  set_coords (&board[x][y].icon[0], 308, 104);
	  set_coords (&board[x][y].icon[1], 308, 138);
	  break;
	case BARBED_WIRE:
	  set_coords (&board[x][y].icon[0], 70, 206);
	  set_coords (&board[x][y].icon[1], 104, 206);

	  break;
	case STOP:
	  set_coords (&board[x][y].icon[0], 138, 206);
	  break;

	}
    }
}

/************************************************************/
/* This function checks if object can move on the field *****/
/* described by direction and coordinates, if not returns 0 */
/************************************************************/

int
can_move (struct Coords coords, int direction)
{
  if (update_coords (&coords, direction) ||
      (board[coords.x][coords.y].type != EMPTY_FIELD) ||
      ((robbo.x == coords.x) && (robbo.y == coords.y)) ||
      board[coords.x][coords.y].moved > 0)
    return 0;
  else
    return 1;
}

/**************************************************/
/* Function moves object deleting object data *****/
/* from one field and moves them to another *******/
/**************************************************/

void
move_object (int x, int y, struct Coords coords)
{
  int x1, y1;

  if ((x == coords.x) && (y == coords.y))	/* move to the same place */
    return;

  x1 = coords.x;
  y1 = coords.y;

  board[x1][y1].type = board[x][y].type;
  board[x1][y1].state = board[x][y].state;
  board[x1][y1].direction = board[x][y].direction;
  board[x1][y1].destroyable = board[x][y].destroyable;
  board[x1][y1].blowable = board[x][y].blowable;
  board[x1][y1].killing = board[x][y].killing;
  board[x1][y1].moved = board[x][y].moved;
  board[x1][y1].blowed = board[x][y].blowed;
  board[x1][y1].shooted = board[x][y].shooted;
  board[x1][y1].rotated = board[x][y].rotated;
  board[x1][y1].solidlaser = board[x][y].solidlaser;
  board[x1][y1].rotable = board[x][y].rotable;
  board[x1][y1].randomrotated = board[x][y].randomrotated;
  /* NOTE: teleportnumber is not being moved */
  /* NOTE: teleportnumber2 is not being moved */
  board[x1][y1].id_questionmark = board[x][y].id_questionmark;
  board[x1][y1].direction2 = board[x][y].direction2;
  board[x1][y1].movable = board[x][y].movable;
  /* NOTE: returnlaser is not being moved */
  board[x1][y1].shooting = board[x][y].shooting;
  board[x1][y1].processed = board[x][y].processed;
  board[x1][y1].redraw = TRUE;

  set_images (board[x1][y1].type, x1, y1);
  clear_field (x, y);

}

/*************************************************************/
/******* If objects shoots... ********************************/
/*************************************************************/

void
shoot_object (int x, int y, int direction)
{
  struct Coords coords;

  if (board[x][y].shooted > 0)
    return;

  set_coords (&coords, x, y);

  if (update_coords (&coords, direction))
    {
      board[coords.x][coords.y].shooted = DELAY_LASER;
      return;
    }

  if ((coords.x == robbo.x) && (coords.y == robbo.y))
    {
      kill_robbo ();
      return;			/* This prevents more lasers being created after Robbo dies */
    }

  switch (board[coords.x][coords.y].destroyable)
    {
    case 1:
      if (board[coords.x][coords.y].type != BOMB)
	if (in_viewport(x,y)) play_sound (SFX_KILL, SND_NORM);
      board[coords.x][coords.y].blowed = 1;
      board[coords.x][coords.y].shooted = DELAY_LASER;
      if (board[x][y].solidlaser == 1)
	{
	  board[x][y].moved = DELAY_LASER;
	}
      return;
    default:
      break;
    }
  switch (board[coords.x][coords.y].type)
    {
    case EMPTY_FIELD:
      if (direction == 0 || direction == 2)
	{
	  clear_field (coords.x, coords.y);
	  create_object (coords.x, coords.y, LASER_L);
	}
      else
	{
	  clear_field (coords.x, coords.y);
	  create_object (coords.x, coords.y, LASER_D);
	}

      board[coords.x][coords.y].direction = direction;
      board[coords.x][coords.y].solidlaser = board[x][y].solidlaser;
      board[x][y].shooted = DELAY_LASER;
      board[coords.x][coords.y].moved = DELAY_LASER;

      /* Thunor: I decided to use different animation frame(s) for the solid
         laser fire to make the graphics more interesting */
      if (board[coords.x][coords.y].solidlaser == 1)
	board[coords.x][coords.y].state = 2;

      break;
    case LASER_D:
    case LASER_L:
      break;
    }
}

/****************************************************************/
/* Function marks all objects blowed around the bomb ************/
/****************************************************************/

void
blow_bomb (int x, int y)
{
  struct Coords coords, laserpath;
  int i;
  if (robbo.alive)
    if (in_viewport(x,y)) play_sound (SFX_BOMB, SND_NORM);
  for (i = 0; i < 9; i++)
    {
      switch (i)
	{
	case 0:
	  coords.x = x;
	  coords.y = y;
	  break;
	case 1:
	  coords.x = x + 1;
	  coords.y = y;
	  break;
	case 2:
	  coords.x = x + 1;
	  coords.y = y + 1;
	  break;
	case 3:
	  coords.x = x;
	  coords.y = y + 1;
	  break;
	case 4:
	  coords.x = x - 1;
	  coords.y = y + 1;
	  break;
	case 5:
	  coords.x = x - 1;
	  coords.y = y;
	  break;
	case 6:
	  coords.x = x - 1;
	  coords.y = y - 1;
	  break;
	case 7:
	  coords.x = x;
	  coords.y = y - 1;
	  break;
	case 8:
	  coords.x = x + 1;
	  coords.y = y - 1;
	  break;
	default:
	  coords.x = x;
	  coords.y = y;
	}

      /* Robbo was near blowing up */
      if ((robbo.x == coords.x) && (robbo.y == coords.y))
	{
	  kill_robbo ();
	}

      /* Blow-up the object */
      if (!coords_out_of_range (coords) && !board[coords.x][coords.y].blowed
	  && board[coords.x][coords.y].blowable)
	{
	  if (board[coords.x][coords.y].type == GUN)
	    {
	      board[coords.x][coords.y].blowed = 1;
	      board[coords.x][coords.y].moved = DELAY_BOMB_TARGET;
	      /* Thunor: In Atari Robbo the solid laser fire is left live when the gun is destroyed which is a
	         bit nonsensical so I have introduced an rcfile overrideable game_mechanic.sensible_solid_lasers */
	      if (board[coords.x][coords.y].solidlaser
		  && game_mechanics.sensible_solid_lasers)
		{
		  set_coords (&laserpath, coords.x, coords.y);
		  while (!update_coords
			 (&laserpath, (board[coords.x][coords.y].direction))
			 && (board[laserpath.x][laserpath.y].type == LASER_D
			     || board[laserpath.x][laserpath.y].type ==
			     LASER_L)
			 && board[laserpath.x][laserpath.y].solidlaser
			 && board[laserpath.x][laserpath.y].direction ==
			 board[coords.x][coords.y].direction)
		    {
		      board[laserpath.x][laserpath.y].blowed = 1;
		      board[laserpath.x][laserpath.y].moved =
			DELAY_BOMB_TARGET;
		    }
		}
	      /* Thunor: In Atari Robbo the solid laser is not blowable but in GNU Robbo there
	         is no solid laser type, so I need to check the solidlaser property here */
	    }
	  else
	    if (!
		((board[coords.x][coords.y].type == LASER_D
		  || board[coords.x][coords.y].type == LASER_L)
		 && board[coords.x][coords.y].solidlaser))
	    {
	      board[coords.x][coords.y].blowed = 1;
	      board[coords.x][coords.y].moved = DELAY_BOMB_TARGET;
	      board[coords.x][coords.y].id_questionmark = 0;	/* blowed questionmark doesn't uncover */
	    }
	}
    }
}

/*****************************************************/
/**** Check Object If Blowed *************************/
/*****************************************************/
/* Thunor: NOTE that the object that is being created here is not cleared beforehand.
   The reason for this I have found is because once it has blown-up, its id_questionmark
   property is checked to see if it was a questionmark and if it needs to be recreated */

void
check_object_if_blowed (int x, int y)
{
  if (board[x][y].blowed && board[x][y].type != BIG_BOOM)
    {
      if (board[x][y].type == BOMB)
	blow_bomb (x, y);
      create_object (x, y, BIG_BOOM);
      board[x][y].moved = DELAY_BIGBOOM;
    }
}

/**********************************************************/
/** If Robbo collects the last screw exit opens ***********/
/**********************************************************/

void
open_exit (void)
{
  robbo.exitopened = 1;
  level.now_is_blinking = DELAY_BLINKSCREEN;
  viewport_needs_redrawing ();
}

/*************************************************************/
/**** Function returning coords of finding teleport **********/
/**** Updates coords of found teleport of 0 if not found *****/
/*************************************************************/

int
find_teleport (struct Coords *coords, int teleportnumber, int teleportnumber2)
{
  int i, j;

  for (i = 0; i < level.w; i++)
    for (j = 0; j < level.h; j++)
      {
	if (board[i][j].type == TELEPORT)
	  {
	    if (teleportnumber == board[i][j].teleportnumber)
	      {			/* found the same kind */
		if (teleportnumber2 == board[i][j].teleportnumber2)
		  {		/* next teleport */
		    set_coords (coords, i, j);
		    return 1;	/* found exact_teleport */
		  }
	      }
	  }
      }

  return 0;			/* teleport with this number has not been found...   */
}

/***************************************************************************
 * Robbo initialisation                                                    *
 ***************************************************************************/
/* Clear everything */

void
init_robbo (void)
{
  robbo.x = 0;
  robbo.y = 0;
  robbo.alive = 1;
  robbo.state = 0;
  robbo.direction = 0;
  robbo.screws = 0;
  robbo.keys = 0;
  robbo.bullets = 0;
  robbo.moved = DELAY_ROBBO;
  robbo.shooted = 0;
  robbo.exitopened = 0;
  robbo.blocked = 0;
  robbo.blocked_direction = 0;
  robbo.teleporting = 0;
}

/********************************************************************/
/*** Robbo moving function ******************************************/
/********************************************************************/

void
move_robbo (int x, int y)
{
  int x_tmp, y_tmp, x2_tmp, y2_tmp;
  int i, j, k;
  int dir_tmp;
  struct Coords coords;

  if (robbo.moved > 0 || robbo.blocked)	/* robbo cannot move yet */
    return;

  x_tmp = robbo.x + x;
  y_tmp = robbo.y + y;

  if ((x == 1) && (y == 0))
    robbo.direction = 0;
  else if ((x == 0) && (y == 1))
    robbo.direction = 2;
  else if ((x == -1) && (y == 0))
    robbo.direction = 4;
  else if ((x == 0) && (y == -1))
    robbo.direction = 6;

  if (x_tmp < 0 || x_tmp >= level.w || y_tmp < 0 || y_tmp >= level.h)
    return;

  redraw_field (robbo.x, robbo.y);	/* Redraw the source field */

  switch (board[x_tmp][y_tmp].type)
    {
    case STOP:
      clear_field (x_tmp, y_tmp);
      break;
    case BARBED_WIRE:
      clear_field (x_tmp, y_tmp);
      kill_robbo ();
      break;

    case EMPTY_FIELD:
    case ROBBO:		/* Robbo can move there */
      redraw_field (x_tmp, y_tmp);	/* Redraw destination field */
      break;
    case SCREW:

      if (robbo.screws > 0)
	{
	  robbo.screws--;
	}

      if (robbo.screws == 0)
	{			/* play sound for open exit */
	 play_sound (SFX_EXIT_OPEN, SND_NORM);
	  open_exit ();
	}
      else
	 play_sound (SFX_SCREW, SND_NORM);	/* play sound for collected screw */

      scoreline.redraw |= SCORELINE_SCREWS;
      clear_field (x_tmp, y_tmp);
      break;
    case BULLET:
       play_sound (SFX_BULLET, SND_NORM);	/* play sound for collected ammo */
      robbo.bullets += 9;
      scoreline.redraw |= SCORELINE_BULLETS;
      clear_field (x_tmp, y_tmp);
      break;
    case KEY:
       play_sound (SFX_KEY, SND_NORM);	/* play sound for collected key */
      robbo.keys++;
      scoreline.redraw |= SCORELINE_KEYS;
      clear_field (x_tmp, y_tmp);
      break;
    case DOOR:			/* Robbo cannot move */
      if (robbo.keys > 0)
	{			/* should open the door first */
	  robbo.keys--;
	  scoreline.redraw |= SCORELINE_KEYS;
	  clear_field (x_tmp, y_tmp);
	  robbo.moved = DELAY_ROBBO;
	   play_sound (SFX_DOOR, SND_NORM);	/* play sound for door open */
	}
      return;
    case TELEPORT:
      if (board[x_tmp][y_tmp].teleportnumber == 0)
	break;
       play_sound (SFX_TELEPORT, SND_NORM);	/* teleport sound */
      i = 0;
      j = board[x_tmp][y_tmp].teleportnumber2;

      while (i == 0)
	{
	  j++;

	  if (((find_teleport
		(&coords, board[x_tmp][y_tmp].teleportnumber, j)) == 0)
	      && j != board[x_tmp][y_tmp].teleportnumber2)
	    {			/* teleport not found */
	      if (j > MAX_TELEPORT_IDS)
		j = -1;
	      continue;
	    }
	    
	    dir_tmp=(robbo.direction/2); /* neurocyp * new teleport logic  now it should be the same as original robbo logic */
	    for(k=0;k<4;k++) {           /* first time, the direction, where robbo tries to go is checked */
		if (can_move (coords, dir_tmp))  
		{
		      create_object (robbo.x, robbo.y, TELEPORTING);	/* Create src teleporting animation */
		      update_coords (&coords, dir_tmp);
		      x_tmp = coords.x;
		      y_tmp = coords.y;
		      robbo.direction = (dir_tmp*2);
		      create_object (x_tmp, y_tmp, TELEPORTING);	/* Create dest teleporting animation */
		      robbo.moved = DELAY_TELEPORTING * 5;	/* 5 frames of teleporting animation */
		      viewport.cycles_to_dest = robbo.moved;
		      robbo.teleporting = TRUE;
		      i = 1;
		      break;
		    }
		dir_tmp=dir_tmp ^ (((k+1)%2)+2);
		}
	  if (j == board[x_tmp][y_tmp].teleportnumber2 && i == 0)
	    {			/* protect from freezing the game */
	      create_object (robbo.x, robbo.y, TELEPORTING);	/* Create src/dest teleporting animation */
	      robbo.moved = DELAY_TELEPORTING * 5;	/* 5 frames of teleporting animation */
	      viewport.cycles_to_dest = robbo.moved;
	      robbo.teleporting = TRUE;
	      i = 1;
	      return;
	    }
	}
      break;
    case CAPSULE:
      if (robbo.exitopened)
	{
	 play_sound (SFX_CAPSULE, SND_NORM);
	  /* Check for pack completion */
	  if (level_packs[selected_pack].level_selected >=
	      level_packs[selected_pack].last_level)
	    {
	      game_mode = END_SCREEN;
	      return;
	    }
	  else
	    {
	      level_packs[selected_pack].level_selected++;
	      if (level_packs[selected_pack].level_selected >
		  level_packs[selected_pack].level_reached)
		{
		  level_packs[selected_pack].level_reached =
		    level_packs[selected_pack].level_selected;
		  /* Save rcfile now if requested -- recommended for battery operated or unstable devices */
		  if (rcfile.save_frequency == RCFILE_SAVE_ON_CHANGE)
		    {
		      save_resource_file (path_resource_file, FALSE);
#if defined(PLATFORM_WIN32) || defined(PLATFORM_PC)
#elif defined(PLATFORM_GP2X)
		      system ("sync");
#elif defined(PLATFORM_ZAURUS)
#elif defined(PLATFORM_PSP)
#endif
		    }
		}
	      if (level_init ())
		{
		  game_mode = INTRO_SCREEN;
		  music_stop ();
		  intro_screen.redraw |= REDRAW_INITIALISE;
		}
	      else
		{
		  game_area.redraw |= REDRAW_EVERYTHING;
		  /* Initialise the fade */
		  show_game_area_fade (FADE_SUB_INITIALISE, 16);
		}
	      return;
	    }
	}
    case BOX:			/* Moveable objects */
    case PUSH_BOX:
    case BOMB:
    case QUESTIONMARK:
    case GUN:
      if ((board[x_tmp][y_tmp].type == GUN)
	  && (board[x_tmp][y_tmp].movable == 0))
	return;
      y2_tmp = robbo.y + (2 * y);
      x2_tmp = robbo.x + (2 * x);
      if (x2_tmp < 0 || x2_tmp >= level.w || y2_tmp < 0 || y2_tmp >= level.h)
	return;

      coords.x = x2_tmp;
      coords.y = y2_tmp;

      if (board[x2_tmp][y2_tmp].type == EMPTY_FIELD)
	{
	 play_sound (SFX_BOX, SND_NORM);
	  if (board[x_tmp][y_tmp].type == PUSH_BOX)
	    {
	      board[x_tmp][y_tmp].state = 1;	/* box is pushed */
	      board[x_tmp][y_tmp].direction = (robbo.direction / 2);
	    }
	  move_object (x_tmp, y_tmp, coords);
	  if (board[coords.x][coords.y].type != GUN)
	    board[coords.x][coords.y].moved = DELAY_PUSHBOX;
	}
      else
	{
	  robbo.moved = DELAY_ROBBO;
	  return;
	}
      break;
    default:			/* every else objects */
      return;
    }

  robbo.x = x_tmp;
  robbo.y = y_tmp;

  if (robbo.moved == 0)
    robbo.moved = DELAY_ROBBO;	/* delay robbo */
   play_sound (SFX_ROBBO, SND_NORM);

}

/*********************************************************/
/** Robbo shoots - x, y means coords of Robbo ************/
/*********************************************************/

void
shoot_robbo (int x, int y)
{
  int x_tmp, y_tmp;

  if (robbo.shooted > 0)
    return;

  /* Is Robbo currently being pulled by a magnet or teleporting? */
  if (robbo.blocked || robbo.teleporting)
    return;			/* Matches original Robbo */

  x_tmp = robbo.x + x;
  y_tmp = robbo.y + y;

  if ((x == 1) && (y == 0))
    robbo.direction = 0;
  else if ((x == 0) && (y == 1))
    robbo.direction = 2;
  else if ((x == -1) && (y == 0))
    robbo.direction = 4;
  else if ((x == 0) && (y == -1))
    robbo.direction = 6;

  redraw_field (robbo.x, robbo.y);

  if (robbo.bullets == 0)
    return;
  if (x_tmp < 0 || x_tmp >= level.w || y_tmp < 0 || y_tmp >= level.h)
    {
      robbo.bullets--;
      robbo.shooted = DELAY_LASER;
      return;
    }

  switch (board[x_tmp][y_tmp].destroyable)
    {
    case 1:			/* objects can be destroyed */
      board[x_tmp][y_tmp].blowed = 1;
      play_sound (SFX_SHOOT, SND_HALF);

      if (board[x_tmp][y_tmp].type != BOMB)
	{
	  //printf("%d\n", board[x_tmp][y_tmp].type);
	 play_sound (SFX_KILL, SND_NORM);
	}
      robbo.shooted = DELAY_LASER;
      robbo.bullets--;
      scoreline.redraw |= SCORELINE_BULLETS;
      return;
    case 0:
      play_sound (SFX_SHOOT, SND_NORM);

      robbo.shooted = DELAY_LASER;
      robbo.bullets--;
      scoreline.redraw |= SCORELINE_BULLETS;
      break;
    }

  switch (board[x_tmp][y_tmp].type)
    {
    case EMPTY_FIELD:
      if (robbo.direction == 0 || robbo.direction == 4)
	create_object (x_tmp, y_tmp, LASER_L);
      else
	create_object (x_tmp, y_tmp, LASER_D);

      board[x_tmp][y_tmp].moved = DELAY_LASER;
      board[x_tmp][y_tmp].direction = robbo.direction / 2;
      break;
    }
}

/***************************************************************************
 * Is Robbo Killed                                                         *
 ***************************************************************************/
/* This function checks to see if Robbo is next to an object that can kill
   i.e. killing = 1. It is called every cycle from update_game() */

/*  On exit: returns TRUE if Robbo is next to an object that can kill
			 else returns FALSE */

int
is_robbo_killed (void)
{
  int retval = FALSE;

  if (!robbo.teleporting)
    {
      if ((robbo.x < level.w - 1 && board[robbo.x + 1][robbo.y].killing == 1) ||	/* Robbo's right */
	  (robbo.x > 0 && board[robbo.x - 1][robbo.y].killing == 1) ||	/* Robbo's left */
	  (robbo.y < level.h - 1 && board[robbo.x][robbo.y + 1].killing == 1) ||	/* Robbo's bottom */
	  (robbo.y > 0 && board[robbo.x][robbo.y - 1].killing == 1))
	{			/* Robbo's top */
	  retval = TRUE;
	}
    }

  return retval;
}

/*************************************************/
/*** Robbo doesn't like this function :) *********/
/*************************************************/
/* Everything except EMPTY_FIELDs and WALLs is blown-up here. Once this has
   been executed the once, repeated calls to this function do nothing. */

void
kill_robbo (void)
{
  int x, y;
  if (robbo.alive == 0)
    return;
  robbo.alive = 0;
  robbo.blocked = 0;
 play_sound (SFX_BOMB, SND_NORM);
  create_object (robbo.x, robbo.y, BIG_BOOM);
  board[robbo.x][robbo.y].moved = DELAY_BIGBOOM;

  for (x = 0; x < level.w; x++)
    for (y = 0; y < level.h; y++)
      switch (board[x][y].type)
	{
	case EMPTY_FIELD:
	case WALL:
	  break;
	default:
	  board[x][y].moved = DELAY_BIGBOOM;
	  board[x][y].blowed = 1;
	}

  viewport_needs_redrawing ();

  restart_timeout = DELAY_RESTART;

}

/***************************************************************************
 * Viewport Needs Redrawing                                                *
 ***************************************************************************/
/* This function marks every field for redrawing/refreshing in show_game_area() */

void
viewport_needs_redrawing (void)
{
  int x, y;

  for (y = viewport.y; y < viewport.y + viewport.h; y++)
    {
      for (x = viewport.x; x < viewport.x + viewport.w; x++)
	{
	  redraw_field (x, y);
	}
    }
}

/***************************************************************************
 * Redraw Field                                                            *
 ***************************************************************************/
/* Marks an object for redrawing/refreshing in show_game_area() */

void
redraw_field (int x, int y)
{
  if (x >= 0 && y >= 0 && x < level.w && y < level.h)
    board[x][y].redraw = TRUE;
}

/***************************************************************************
 * Field clearing                                                          *
 ***************************************************************************/
/* This creates a blowable EMPTY_FIELD. This function clears id_questionmark
   whereas create_object() doesn't */

void
clear_field (int x, int y)
{
  create_object (x, y, EMPTY_FIELD);
  board[x][y].id_questionmark = 0;
}

/***************************************************************************
 * Create Object                                                           *
 ***************************************************************************/
/* Thunor: I have found that most of the time clear_field() has been called
   before this function, but there are times when it hasn't such as via
   check_object_if_blowed(). The reason for this is that the id_questionmark
   property needs to be retained so that questionmarks can be recreated, and
   that is why some property clearing is also done below to compensate for this.
   
   What I have decided to do seeing as this is such an important function,
   is to clear everything as in clear_field() EXCEPT id_questionmark. */

void
create_object (int x, int y, int type)
{
  int count;

#ifdef DEBUG_INSPECT_OBJECT_CONTENTS
  if (board[x][y].icon[0].x != 0)
    {
      printf ("*** Start %s ***\n", __func__);
      printf ("type=%i\n", board[x][y].type);
      printf ("state=%i\n", board[x][y].state);
      printf ("direction=%i\n", board[x][y].direction);
      printf ("destroyable=%i\n", board[x][y].destroyable);
      printf ("blowable=%i\n", board[x][y].blowable);
      printf ("killing=%i\n", board[x][y].killing);
      printf ("moved=%i\n", board[x][y].moved);
      printf ("blowed=%i\n", board[x][y].blowed);
      printf ("shooted=%i\n", board[x][y].shooted);
      printf ("rotated=%i\n", board[x][y].rotated);
      printf ("solidlaser=%i\n", board[x][y].solidlaser);
      printf ("rotable=%i\n", board[x][y].rotable);
      printf ("randomrotated=%i\n", board[x][y].randomrotated);
      printf ("teleportnumber=%i\n", board[x][y].teleportnumber);
      printf ("teleportnumber2=%i\n", board[x][y].teleportnumber2);
      printf ("id_questionmark=%i\n", board[x][y].id_questionmark);
      printf ("direction2=%i\n", board[x][y].direction2);
      printf ("movable=%i\n", board[x][y].movable);
      printf ("returnlaser=%i\n", board[x][y].returnlaser);
      printf ("shooting=%i\n", board[x][y].shooting);
      printf ("processed=%i\n", board[x][y].processed);
      printf ("icon[0].x=%i icon[0].y=%i\n", board[x][y].icon[0].x,
	      board[x][y].icon[0].y);
      printf ("icon[1].x=%i icon[1].y=%i\n", board[x][y].icon[1].x,
	      board[x][y].icon[1].y);
      printf ("icon[2].x=%i icon[2].y=%i\n", board[x][y].icon[2].x,
	      board[x][y].icon[2].y);
      printf ("icon[3].x=%i icon[3].y=%i\n", board[x][y].icon[3].x,
	      board[x][y].icon[3].y);
      printf ("icon[4].x=%i icon[4].y=%i\n", board[x][y].icon[4].x,
	      board[x][y].icon[4].y);
      printf ("icon[5].x=%i icon[5].y=%i\n", board[x][y].icon[5].x,
	      board[x][y].icon[5].y);
      printf ("icon[6].x=%i icon[6].y=%i\n", board[x][y].icon[6].x,
	      board[x][y].icon[6].y);
      printf ("icon[7].x=%i icon[7].y=%i\n", board[x][y].icon[7].x,
	      board[x][y].icon[7].y);
      printf ("icon[8].x=%i icon[8].y=%i\n", board[x][y].icon[8].x,
	      board[x][y].icon[8].y);
      printf ("*** Stop %s ***\n", __func__);
    }
#endif

  board[x][y].type = type;
  board[x][y].state = 0;
  board[x][y].direction = 0;
  board[x][y].destroyable = 0;
  board[x][y].blowable = 0;
  board[x][y].killing = 0;
  board[x][y].moved = 0;
  board[x][y].blowed = 0;
  board[x][y].shooted = 0;
  board[x][y].rotated = 0;
  board[x][y].solidlaser = 0;
  board[x][y].rotable = 0;
  board[x][y].randomrotated = 0;
  board[x][y].teleportnumber = 0;
  board[x][y].teleportnumber2 = 0;
  /* NOTE id_questionmark's value is retained */
  board[x][y].direction2 = 0;
  board[x][y].movable = 0;
  board[x][y].returnlaser = 0;
  board[x][y].shooting = 0;
  board[x][y].processed = cycle_count;
  board[x][y].redraw = TRUE;
  for (count = 0; count < MAX_ICONS; count++)
    {
      board[x][y].icon[count].x = 0;
      board[x][y].icon[count].y = 0;
    }

  switch (type)
    {
    case ROBBO:
      robbo.x = x;
      robbo.y = y;
      robbo.state = 0;
      board[x][y].type = EMPTY_FIELD;	/* Robbo isn't a board location, so set it to EMPTY_FIELD */
      board[x][y].id_questionmark = 0;	/* May as well clear this as it's not required to be kept */
      return;			/* QUIT NOW */
    case BEAR:
    case BEAR_B:
    case BIRD:
    case BUTTERFLY:
      board[x][y].killing = 1;	/* Via their closeness */
    case BULLET:		/* The breaks have been ommitted for a reason */
    case BOMB:
    case QUESTIONMARK:
    case GROUND:
    case BARRIER:
      board[x][y].destroyable = 1;	/* Via a shot or push box */
    case SCREW:
    case PUSH_BOX:
    case BOX:
    case KEY:
    case DOOR:
    case LASER_L:
    case LASER_D:
    case TELEPORT:
    case GUN:
    case EMPTY_FIELD:
      board[x][y].blowable = 1;	/* Via a bomb */
      break;
    case STOP:
    case BARBED_WIRE:		//barbed wire - it probably would have its own logic
      board[x][y].blowable = 1;
      board[x][y].destroyable = 0;
      break;

    }

  set_images (board[x][y].type, x, y);

}

/***************************************************************************
 * Clear Entire Board                                                      *
 ***************************************************************************/
/* Clear everything */

void
clear_entire_board (void)
{
  int xpos, ypos;

  /* Fill the game board with EMPTY_FIELD objects */
  for (ypos = 0; ypos < MAX_H; ypos++)
    {
      for (xpos = 0; xpos < MAX_W; xpos++)
	{
	  clear_field (xpos, ypos);
	}
    }
}

/* this will return zero if x/y is in viewport and non zero otherwise */
int in_viewport(int x, int y) {


    if(x-viewport.x<=viewport.w && x-viewport.x>=0 && y-viewport.y<=viewport.h && y-viewport.y>=0)
       {
	 return 1; 
       }
     return 0;
}

