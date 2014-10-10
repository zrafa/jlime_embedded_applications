#ifndef KEYBOARD_H
#define KEYBOARD_H

/** Decodes PS/2 Scancode.  Places output in outBuf, and returns the output
 * length (some keystrokes, like Right Arrow, can result in multiple outputs)
 * outBuf must be at least 3 characters long.   This is based on Atmel's AVR313
 * application note. **/
int KeyboardDecode(unsigned char sc, char *outBuf);

#endif // KEYBOARD_H
