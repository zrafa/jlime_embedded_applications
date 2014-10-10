; Enter with:
;  CRC or seed in r15:r14:r13:r12
;  Pointer to data in Y
;  Byte count in R16

; Exit with:
;  CRC in r15:r14:r13:r12

calc_CRC:
   ldi   r17,0x20      ; preload magic number
   ldi   r18,0x83
   ldi   r19,0xB8
   ldi   r20,0xED
next_byte:
   push   r16
   ld   r16,Y+         ; get next byte, inc Y
   eor   r12,r16         ; XOR data into CRC
   ldi   r16,0x08      ; bit counter
next_bit:
   lsr   r15         ; next LS bit to carry
   ror   r14
   ror   r13
   ror   r12
   brcc   no_xor
; If carry is set, XOR the magic number
   eor   r15,r20         ; pity there's no "EORI"
   eor   r14,r19
   eor   r13,r18
   eor   r12,r17
no_xor:
   dec   r16         ; count bit
   brne   next_bit
   pop   r16         ; recover byte count
   dec   r16         ; count byte
   brne   next_byte
   ret            ; all done 
