/* Platform-specific code for the Tvikia hardware */

#include <avr/interrupt.h>
#include <util/delay.h>
#include <avr/io.h>
#include <stdio.h>
#include "uCmorse.h"
#include "Errors.h"
#ifdef USE_KEYBOARD
#  include "Keyboard.h"
#endif
#include "Platform.h"
#include "vt52.h"
#include "ps2.h"

#define FOSC F_CPU // Clock Speed
#define BAUD 57600
#define MYUBRR FOSC/16/BAUD-1

int UsartGetC(FILE *f);
int UsartPutC(char data, FILE *f);

static FILE mystdin = FDEV_SETUP_STREAM(NULL, UsartGetC, _FDEV_SETUP_READ);
static FILE mystdout = FDEV_SETUP_STREAM(UsartPutC, NULL, _FDEV_SETUP_WRITE);

#define BUTTON_DOWN 0x8
#define BUTTON_UP 0x4
#define BUTTON_LEFT 0x2
#define BUTTON_RIGHT 0x1
unsigned char buttonState;

/** Updates global buttonState, and returns transitions.
 *  buttonState is just 4 bits showing the state of PD2,3,4,5.
 *  transitions is a corresponding set of 4 bits with a 1 for buttons which
 *  have just changed (their latest value is always in buttonState **/
unsigned char ButtonCheck() {
  unsigned char state = (~PIND >> 2) & 0xf;
  unsigned char transition = state ^ buttonState;
  buttonState = state;
  return transition;
}

#define inQSize 8
unsigned char inQ[inQSize];
unsigned char inQHead=0;
unsigned char inQTail=0;

void InputPush(char c) {
  if ((inQHead + 1) % inQSize == inQTail) {
    OutP("INPUT BUF FULL\n");
    return; // queue is full
  }
  inQ[inQHead] = c;
  inQHead = (inQHead + 1) % inQSize;
}

int InputPop() {
  if (inQHead == inQTail)
    return -1;
  int r = inQ[inQTail];
  inQTail = (inQTail + 1) % inQSize;
  return r;
}

inline int InputCheck() {
  return InputPop();
}

void InputCollect() {
#ifdef USE_SERIAL_INPUT
  if (UCSR0A & (1 << RXC0)) {
    char r = UDR0;
    InputPush(r);
  }
#endif
  if (g_kbd_buf_len - g_kbd_buf_start != 0) {
    /* Save global interrupt flag */
    unsigned char sreg = SREG;
    /* Disable interrupts */
    cli();
    /* Read from kbd queue */
    unsigned char r = g_kbd_buf[g_kbd_buf_start];
    g_kbd_buf_start = (g_kbd_buf_start + 1) % KBD_BUF_SIZE;
    /* Restore global interrupt flag */
    SREG = sreg;
    //printf("{%x, %i}", r, (KBD_BUF_SIZE + g_kbd_buf_len - g_kbd_buf_start) % KBD_BUF_SIZE);
    char buf[3];
    char buflen = KeyboardDecode(r, buf);
    for (char i=0; i<buflen; ++i)
      InputPush(buf[(int)i]);
  }
  {
    unsigned char transitions = ButtonCheck();
    if (transitions & buttonState 
        & (BUTTON_DOWN | BUTTON_UP | BUTTON_LEFT | BUTTON_RIGHT)) {
      InputPush( 27 );
      InputPush( '[' );
      if (transitions & buttonState & BUTTON_DOWN) {
        InputPush( 'B' );
      } else if (transitions & buttonState & BUTTON_UP) {
        InputPush( 'A' );
      } else if (transitions & buttonState & BUTTON_LEFT) {
        InputPush( 'D' );
      } else if (transitions & buttonState & BUTTON_RIGHT) {
        InputPush( 'C' );
      }
    }
  }
}

/** Write string to stdout **/
void OutC(char c) {
  UsartPutC(c,0x0);
}

void OutS_P(PGM_P s) {
  for (; pgm_read_byte(s) != 0x0; s++)
    OutC(pgm_read_byte(s));
}

/** Blocking Get **/
int UsartGetC(FILE *f) {
  int r=-1;
  /* Wait for data to be received */
  while ( r == -1 ) 
    r = InputCheck();
  /* Get and return received data from buffer */
  return r; 
}

void UsartInit( unsigned int ubrr)
{
  /*Set baud rate */
  UBRR0H = (unsigned char)(ubrr>>8);
  UBRR0L = (unsigned char)ubrr;
  /* Enable receiver and transmitter */
  UCSR0B = (1<<RXEN0)|(1<<TXEN0);
  /* Set frame format: 8data, 2stop bit */
  UCSR0C = (1<<USBS0)|(3<<UCSZ00);
  buttonState = 0x0;
}

int UsartPutC(char data, FILE *f) {
  /* Wait for empty transmit buffer */
  while ( !( UCSR0A & (1<<UDRE0)) )
    ;
  /* Put data into buffer, sends the data */
  UDR0 = data;
  if (data == '\n') // add CR to LF
    UsartPutC('\r', f);
  return 0;
}

void StdioInit() {
  UsartInit(MYUBRR);
  // fdevopen uses malloc(), which we avoid
  //fdevopen(0x0, &UsartGetC); // stdin
  //fdevopen(&UsartPutC, 0x0); // stdout and stderr
  stdin = &mystdin;
  stdout = &mystdout;
  stderr = &mystdout;
  printf(VENABLE_LINE_WRAP);
}

int StackSize();
void StackPaint(void) __attribute__ ((naked)) __attribute__ ((section (".init3")));
uint16_t StackCount(void);
void StackCheck();

void sounder(int onOrOff, int msec) {
  DDRB  |= 1 << 5;
  if (onOrOff)
    PORTB |= 1 << 5; // led on
  else 
    PORTB &= ~(1 << 5); // led off
  _delay_ms((float)msec);
  PORTB &= ~(1 << 5); // led off at end
}


/* See http://www.avrfreaks.net/index.php?name=PNphpBB2&file=viewtopic&t=52249&highlight=stack+monitor */
extern uint8_t _end;
extern uint8_t __stack; 
#define STACK_CANARY 0xc5 

int StackSize() {
  return ((uint16_t) &__stack) - SP;
}

int StackFree() {
  return SP - (uint16_t) &_end;
}

void StackPaint(void) {
  uint8_t *p = &_end;

  while(p <= &__stack) {
    *p = STACK_CANARY;
    p++;
  }
} 

uint16_t StackCount(void) {
  const uint8_t *p = &_end;
  uint16_t       c = 0;

  while(*p == STACK_CANARY && p <= &__stack) {
    p++;
    c++;
  }

  return c;
} 

ISR(PCINT2_vect) { /* Note: PCINT2 _GROUP_ includes PCINT23-16 */
  InputCollect();
}

/** Setup button interrupt **/
static inline void ButtonInit() {
  /* Buttons: set pull-ups on button lines */
  DDRD &= ~(0b00111100); // direction input
  PORTD |= 0b00111100; // pull-up
  PCICR |= 0b100; // interrupt PCINT8 on falling edge
  PCMSK2 |= 0b111100; // enable PCINT8 interrupt
}

void PlatformInit() {
  DelayMs(500);
  StdioInit();
  ERRORassert();
  OutP("START UP: PlatformInit()\n");
  StackPrintInfo(stdout);
  TimerInit();
  ERRORassert();
  ButtonInit();
  FileInit();
  StackPrintInfo(stdout);
  if (IsError) {
    fprintf_P(stderr, PSTR("SD Card Not Detected\n"));
    ClearError();
  } else {
    fprintf(stderr, ("SD Card Found\n"));
  }
  kbd_init();
  kbd_resume();
}

void StackCheck() {
  int free = StackFree();
  if (free < 8)
    ERRORreturn("Stack Overflow (bytes free)");
  int count = StackCount();
  if (count == 0)
    ERRORreturn("Stack Overflow (paint)");
}

void StackPrintInfo(FILE *f) {
  fprintf_P(f, PSTR("SP=%08x _end=%08x size=%i\n    free=%i count=%i\n"), (unsigned int) SP, (unsigned int) &_end, StackSize(), (int) StackFree(), StackCount());
  StackCheck();
}

uint64_t timerOverflowCount=0ULL;

void TimerInit() {
  TCCR1B = (1<<WGM12); //CTC mode, use OCR1A for match
  // If you change the clock divisor, change TimerCountPerMillisec() as well!
  //TCCR1B |= (1<<CS10); // F_CPU/1
  TCCR1B |= (1 << CS11) | (1 << CS10); // F_CPU/64
  //TCCR1B |= (1 << CS11) | (0 << CS10); // F_CPU/8
  OCR1A = 0xffff;
  TCNT1 = 311;
  TIMSK1 |= (1<<OCIE1A);                     //generate interrupt on match
  sei();
}

uint32_t TimerCountPerMillisec() {
  const uint64_t divisor=64ULL;
  return F_CPU/divisor/1000ULL;
}

unsigned int TimerReadTCNT1() {
  unsigned char sreg;
  unsigned int i;
  /* Save global interrupt flag */
  sreg = SREG;
  /* Disable interrupts */
  cli();
  /* Read TCNT1 into i */
  i = TCNT1;
  /* Restore global interrupt flag */
  SREG = sreg;
  return i;
}

/** COMPARE A INTERRUPT **/
ISR( TIMER1_COMPA_vect ) {
  timerOverflowCount += 0x1ULL;
  // poll input
  //InputCollect();
#ifdef USE_TIMER_STACK_CHECK
  static unsigned char low=0;
  if (StackFree() < 200) {
    OutP("\nLOW STACK free=");
    OutI(StackFree());
    OutC('\n');
    --low;
  }
#endif
}

uint64_t TimerCount() {
  return (timerOverflowCount << 16ULL) | ((uint64_t) (TimerReadTCNT1() & 0xffff));
}

uint32_t TimerMillisec() {
  return TimerCount()/TimerCountPerMillisec();
}

void DelayMs(unsigned int t) {
  _delay_ms(t);
}

