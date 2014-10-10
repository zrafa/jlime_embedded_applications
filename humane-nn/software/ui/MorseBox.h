#include "inmorse.h"
#include "vt52.h"
#include <stdio.h>
#include "Platform.h"

#define MORSEBOX_MAX 40

typedef struct {
  char buffer[MORSEBOX_MAX];
  int bufferPos; /**< end position in buf **/
  char *p;
  int pLen;
  char row;
  char escState;
  char prompt[2];
} MorseBox;

/** Initialize a new MorseBox struct **/
void MorseBoxInit(MorseBox *mb, int row);

void MorseBoxReset(MorseBox *mb);

/** Push a keystroke to the MorseBox and process.  
 * Returns 1 if key-press is consumed, 0 if key-press is unused **/
int MorseBoxPushEvent(MorseBox *mb, int in);

/** Get a pointer to the null-terminated input buffer **/
char *MorseBoxGetBuffer(MorseBox *mb);

/** Set the contents of the input buffer with null-terminated string **/
void MorseBoxSetBuffer(MorseBox *mb, char *data);

void MorseBoxSetPrompt(MorseBox *mb, char prompt1, char prompt2);

/** Draw the MorseBox to screen **/
void MorseBoxDraw(MorseBox *mb);
