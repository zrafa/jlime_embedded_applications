#ifndef INMORSE_H_
#define INMORSE_H_ 1

extern char codetree[];

/** InMorseNext is used to perform dichotomic lookup of characters for a
 * sequence of morse code.  To use, the caller invokes InMorseNext() once for
 * each dot or dash in a morse code sequence.  When the sequence is complete,
 * the last call to the function returns the resulting character, or -2 if the
 * sequence was too long, or ' ' (space) for any other case.
 *
 * The caller must pass a pointer to a null character p on the first invokation
 * of InMorseNext for use as internal state.  The same pointer must be passed
 * for each successive InMorseNext() call in the dot/dash sequence.  A pointer
 * to an int must also be passed on each call (it does not need to be
 * initialized).
 *
 * The dotOrDash argument should be either the character '-' or '.'.
 **/
char InMorseNext(char dotOrDash, char **p, int *pLen);

/** Roughly equivalant to codetree[idx], except hides detail on AVR to access
 * codetree in flash memory **/ 
char InMorseCodeTree(int idx);
#endif // INMORSE_H_
