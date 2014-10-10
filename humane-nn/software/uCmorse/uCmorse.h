#ifndef UCMORSE_H_
#define UCMORSE_H_ 1

#if 1
// bcg's preferred timings
#define WPM 8
#define DASH 3
#define DIT 1
#define CHARACTER_GAP 1
#define LETTER_GAP 5
#define WORD_GAP 9

#else  //world "standard" settings
// Speed of transmission
#define WPM 10
// Length of DASH, DIT, etc, in units of 1200/WPM ms
#define DASH 3
#define DIT 1
#define CHARACTER_GAP 1
// Note, LETTER_GAP is actually 3, and WORD_GAP 7, when you count the
// prior CHARACTER_GAP after every symbol.
#define LETTER_GAP 2
#define WORD_GAP 6
#endif

#define UNITS2MSEC(u) (1200*u/WPM)
#define MSEC2UNITS(msec) (WPM * msec/1200)

// You must provide a "sounder" function for the following declaration
// which makes a tone/light or silense for the specified period of time
void sounder(int onOrOff, int msec);

void tapString(const char *s);
void tapChar(char ch);
void tapNibbleHex(unsigned char v);
void tapByteHex(unsigned char v);

#endif // UCMORSE_H_
