
// Turn this off to turn off morse debug info
//define DOMORSE

.macro tapCharC x
#ifdef DOMORSE
  push r23
  ldi r23,\x
  call tapCharAsm
  pop r23
#endif
.endm

;;; Morse character tap for register integer
.macro tapCharI xx
#ifdef DOMORSE
  push r23
  ldi r23,'0'
  add r23,\xx
  call tapCharAsm
  pop r23
#endif
.endm

.macro repeatTapChar t x1 x2=' '
#ifdef DOMORSE
  push XL
  ldi XL,\t
loop_\@:
  call syncPulseA1
  tapCharC \x1
  tapCharC \x2
  dec XL
  brne loop_\@
  pop XL
#endif
.endm

.macro repeatTapCharCI t x1 x2
#ifdef DOMORSE
  push XL
  ldi XL,\t
loop2_\@:
  call syncPulseA1
  tapCharC \x1
  ;tapCharC \x2
  tapCharI \x2
  dec XL
  brne loop2_\@
  pop XL
#endif
.endm


;;; Morse character tap for immediate integer
.macro tapCharII x
#ifdef DOMORSE
push r23
push r24
ldi r23,\x
ldi r22,'0'
add r23,r22
call tapCharAsm
pop r24
pop r23
#endif
.endm

.macro setMorseSpeedScale s
  push XL
  push XH
  ldi XL, 0x00
  ldi XH, 0x01
  sts morseSpeedScale+0, XL
  sts morseSpeedScale+1, XH
  pop XH
  pop XL
.endm

