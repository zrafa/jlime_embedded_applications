;;; uC Morse by Braddock Gaskill, 12 August 2009

#include <avr/io.h>

;;; User Configurable Timing Parameters

#define WPM 5 
#define DASH 3
#define DIT 1
#define CHARACTER_GAP 1
#define LETTER_GAP 5
#define WORD_GAP 9

#define MORSE_PORT PORTB
#define MORSE_PORTN  PORTB5
#define MORSE_DDR  DDRB
#define MORSE_DDRN PORTB5

; Approximated for clock speed of 28,636,360 HZ
#define DEFAULT_SPEED_SCALE 0xffff

;;; End of User Configurable Parameters

#define UNITS2MSEC(u) (1200*u/WPM)
#define MSEC2UNITS(msec) (WPM * msec/1200)
;; Convert WPM UNITs to default sounder scaled time
#define SOUNDER_DEFAULT_SCALE 10
#define UNITS2STIME(u) (1200*u)/(WPM*SOUNDER_DEFAULT_SCALE)
#define STIME2UNITS(msec) (SOUNDER_DEFAULT_SCALE * WPM * msec/(1200))

#define DASH_T          UNITS2STIME(DASH)
#define DIT_T           UNITS2STIME(DIT)
#define CHARACTER_GAP_T UNITS2STIME(CHARACTER_GAP)
#define LETTER_GAP_T    UNITS2STIME(LETTER_GAP)
#define WORD_GAP_T      UNITS2STIME(WORD_GAP)

.global tapCharAsm
.global tapStringAsm
.global sounderAsm
;.global pulseA3
;.global syncPulseA1
;.global syncPulseA2
;.global syncPulseA3
;.global toggleA3
.global morseAsm
.global testmorse
.global morseSpeedScale

#define ch r23

.section .flash

.section .data
;; morse could be stored in PROGMEM if you care about 43 bytes
morseAsm:
.dc.b 0x3f, 0x3e, 0x3c, 0x38, 0x30, 0x20, 0x21, 0x23, 0x27, 0x2f, 0x47, 0x55, 0x2d, 0x31, 0x6d, 0x4c, 0x56, 0x06, 0x11, 0x15, 0x09, 0x02, 0x14, 0x0b, 0x10, 0x04, 0x1e, 0x0d, 0x12, 0x07, 0x05, 0x0f, 0x16, 0x1b, 0x0a, 0x08, 0x03, 0x0c, 0x18, 0x0e, 0x19, 0x1d, 0x13, 0x00

;; Speed scaling of morse signals.
morseSpeedScale:
.dc.w DEFAULT_SPEED_SCALE

txtstr: 
.asciz " HELLO WORLD  "

.section .text

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; sounder r24:r25 = msec delay, r22 = onOrOff
sounderAsm:
  ;; Save regs
  push r23
  push r24
  push r25
  push ZL
  push ZH
  ;; Set pin direction to out
  sbi _SFR_IO_ADDR(MORSE_DDR), MORSE_DDRN
  ldi r23, 1
  cpse r22, r23 // if onOrOff == 0, then skip turn on
  rjmp delay_sounder
  ;; Turn on LED
  sbi _SFR_IO_ADDR(MORSE_PORT), MORSE_PORTN
delay_sounder:
  count0:
    ; ~1ms inner loop if morseSpeedScale = 0x1800
    lds ZL,morseSpeedScale+0
    lds ZH,morseSpeedScale+1
    count1:
    sbiw ZL,1
    brne count1
  sbiw r24,1
  brne count0
  ;;; Turn off LEDs (or keep off)
  cbi _SFR_IO_ADDR(MORSE_PORT), MORSE_PORTN
  ;;; Restore the stack
  pop ZH
  pop ZL
  pop r25
  pop r24 
  pop r23
  ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; tapStringAsm - provide a string pointer in Z
tapStringAsm:
  push ZH
  push ZL
tapLoop0:
  ld ch,Z+
  cpi ch, 0x0 ; string null terminator?
  breq cleanupTS 
  rcall tapCharAsm
  rjmp tapLoop0

cleanupTS:
  pop ZL
  pop ZH

;;; tapCharAsm outputs a single charcter passed in r23
tapCharAsm:
  push ZH
  push ZL
  push YH
  push YL
  push r25
  push r24
  push r23
  push r22
  cpi ch, ' ' ; is it a space?
  brne notspace
  ldi r22,0
  ldi r25,hi8(WORD_GAP_T)
  ldi r24,lo8(WORD_GAP_T)
  rcall sounderAsm
  rjmp cleanup
notspace:
  cpi ch, '0'
  brsh notunk ; branch if same or higher
  cpi ch, 'Z'+1
  brlo notunk ; brank if same of lower
  ldi ch, '?'
notunk:
  subi ch, '0'
  ldi YH, hi8(morseAsm)
  ldi YL, lo8(morseAsm)
  ldi r24,0
  add YL,ch
  adc YH,r24
  ldd ch,Y+0 ; load our morse encoding
nextbit: ; assumes no empty symbols
  sbrc ch, 0 ; skip if lsb == 0 
  ldi r25,hi8(DASH_T)
  sbrc ch, 0 ; skip if lsb == 0 
  ldi r24,lo8(DASH_T)
  sbrs ch, 0 ; skip if lsb == 1 
  ldi r25,hi8(DIT_T)
  sbrs ch, 0 ; skip if lsb == 1 
  ldi r24,lo8(DIT_T)
  ldi r22,1
  lsr ch ; ch >>= 1
  breq breakout
  rcall sounderAsm
  ;;; character gap
  ldi r25,hi8(CHARACTER_GAP_T)
  ldi r24,lo8(CHARACTER_GAP_T)
  ldi r22,0
  rcall sounderAsm
  rjmp nextbit
breakout:
  ldi r25,hi8(LETTER_GAP_T)
  ldi r24,lo8(LETTER_GAP_T)
  ldi r22,0
  rcall sounderAsm

cleanup:
  ;;; Restore the stack
  pop r22
  pop r23
  pop r24 
  pop r25
  pop YL
  pop YH
  pop ZL
  pop ZH
  ret
 
testmorse:
  ldi XL, 0x00
  ldi XH, 0x01
  ;sts morseSpeedScale+0, XL
  ;sts morseSpeedScale+1, XH
testmorseloop:
  ldi ch,'0'
  rcall tapCharAsm
  ldi ZH,hi8(txtstr)
  ldi ZL,lo8(txtstr)
  rcall tapStringAsm
  ldi ch,' '
  rcall tapCharAsm
  ldi ch,'5'
  rcall tapCharAsm
rjmp testmorseloop

