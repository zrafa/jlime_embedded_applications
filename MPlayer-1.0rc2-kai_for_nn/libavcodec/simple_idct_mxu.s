.file	1 "simple_idct.c"
.section .mdebug.abi32
.previous
.gnu_attribute 4, 3
.abicalls
.text
.align	2
.globl	simple_idct_put
.set	nomips16
.ent	simple_idct_put
.type	simple_idct_put, @function
simple_idct_put:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
.mask	0x00000000,0
.fmask	0x00000000,0
li	$2,1518469120			# 0x5a820000
ori	$2,$2,0x5a82
#APP
# 403 "simple_idct.c" 1
.word	0b01110000000000100000000101101111	#S32I2M XR5,$2
# 0 "" 2
#NO_APP
li	$2,1984036864			# 0x76420000
ori	$2,$2,0x30fc
#APP
# 404 "simple_idct.c" 1
.word	0b01110000000000100000000110101111	#S32I2M XR6,$2
# 0 "" 2
#NO_APP
li	$2,2106195968			# 0x7d8a0000
ori	$2,$2,0x6a6e
#APP
# 405 "simple_idct.c" 1
.word	0b01110000000000100000000111101111	#S32I2M XR7,$2
# 0 "" 2
#NO_APP
li	$2,1193082880			# 0x471d0000
ori	$2,$2,0x18f9
#APP
# 406 "simple_idct.c" 1
.word	0b01110000000000100000001000101111	#S32I2M XR8,$2
# 0 "" 2
#NO_APP
addiu	$3,$6,16
#APP
# 410 "simple_idct.c" 1
.word	0b01110000110000000000000001010000	#S32LDD XR1,$6,0
# 0 "" 2
#NO_APP
move	$2,$6
$L2:
#APP
# 413 "simple_idct.c" 1
.word	0b01110000010000000010000010010000	#S32LDD XR2,$2,32
# 0 "" 2
# 414 "simple_idct.c" 1
.word	0b01110000010000000100000011010000	#S32LDD XR3,$2,64
# 0 "" 2
# 415 "simple_idct.c" 1
.word	0b01110000010000000110000100010000	#S32LDD XR4,$2,96
# 0 "" 2
# 418 "simple_idct.c" 1
.word	0b01110000101101000101011011001000	#D16MUL XR11,XR5,XR1,XR13,HW
# 0 "" 2
# 419 "simple_idct.c" 1
.word	0b01110000101101001101011011001010	#D16MAC XR11,XR5,XR3,XR13,AA,HW
# 0 "" 2
# 420 "simple_idct.c" 1
.word	0b01110000101110001001101100001000	#D16MUL XR12,XR6,XR2,XR14,HW
# 0 "" 2
# 421 "simple_idct.c" 1
.word	0b01110000011110010001101100001010	#D16MAC XR12,XR6,XR4,XR14,AA,LW
# 0 "" 2
# 422 "simple_idct.c" 1
.word	0b01110001001100110010111011011000	#D32ADD XR11,XR11,XR12,XR12,AS
# 0 "" 2
# 424 "simple_idct.c" 1
.word	0b01110001001110111011011101011000	#D32ADD XR13,XR13,XR14,XR14,AS
# 0 "" 2
# 426 "simple_idct.c" 1
.word	0b01110000001101000000001011001011	#D16MACF XR11,XR0,XR0,XR13,AA,WW
# 0 "" 2
# 427 "simple_idct.c" 1
.word	0b01110000001110000000001100001011	#D16MACF XR12,XR0,XR0,XR14,AA,WW
# 0 "" 2
# 429 "simple_idct.c" 1
.word	0b01110000101010000101011101001000	#D16MUL XR13,XR5,XR1,XR10,HW
# 0 "" 2
# 430 "simple_idct.c" 1
.word	0b01110011101010001101011101001010	#D16MAC XR13,XR5,XR3,XR10,SS,HW
# 0 "" 2
# 432 "simple_idct.c" 1
.word	0b01110000011001001001101110001000	#D16MUL XR14,XR6,XR2,XR9,LW
# 0 "" 2
# 433 "simple_idct.c" 1
.word	0b01110011101001010001101110001010	#D16MAC XR14,XR6,XR4,XR9,SS,HW
# 0 "" 2
# 434 "simple_idct.c" 1
.word	0b01110001001110111011011101011000	#D32ADD XR13,XR13,XR14,XR14,AS
# 0 "" 2
# 436 "simple_idct.c" 1
.word	0b01110001001001100110101010011000	#D32ADD XR10,XR10,XR9,XR9,AS
# 0 "" 2
# 438 "simple_idct.c" 1
.word	0b01110000001010000000001101001011	#D16MACF XR13,XR0,XR0,XR10,AA,WW
# 0 "" 2
# 439 "simple_idct.c" 1
.word	0b01110000001001000000001110001011	#D16MACF XR14,XR0,XR0,XR9,AA,WW
# 0 "" 2
# 442 "simple_idct.c" 1
.word	0b01110000010000000001000001010000	#S32LDD XR1,$2,16
# 0 "" 2
# 443 "simple_idct.c" 1
.word	0b01110000010000000011000010010000	#S32LDD XR2,$2,48
# 0 "" 2
# 444 "simple_idct.c" 1
.word	0b01110000010000000101000011010000	#S32LDD XR3,$2,80
# 0 "" 2
# 445 "simple_idct.c" 1
.word	0b01110000010000000111000100010000	#S32LDD XR4,$2,112
# 0 "" 2
# 449 "simple_idct.c" 1
.word	0b01110000101010000101111001001000	#D16MUL XR9,XR7,XR1,XR10,HW
# 0 "" 2
# 450 "simple_idct.c" 1
.word	0b01110000011010001001111001001010	#D16MAC XR9,XR7,XR2,XR10,AA,LW
# 0 "" 2
# 451 "simple_idct.c" 1
.word	0b01110000101010001110001001001010	#D16MAC XR9,XR8,XR3,XR10,AA,HW
# 0 "" 2
# 453 "simple_idct.c" 1
.word	0b01110000011010010010001001001010	#D16MAC XR9,XR8,XR4,XR10,AA,LW
# 0 "" 2
# 455 "simple_idct.c" 1
.word	0b01110000001010000000001001001011	#D16MACF XR9,XR0,XR0,XR10,AA,WW
# 0 "" 2
# 457 "simple_idct.c" 1
.word	0b01110000011111000101111010001000	#D16MUL XR10,XR7,XR1,XR15,LW
# 0 "" 2
# 458 "simple_idct.c" 1
.word	0b01110011011111001010001010001010	#D16MAC XR10,XR8,XR2,XR15,SS,LW
# 0 "" 2
# 459 "simple_idct.c" 1
.word	0b01110011101111001101111010001010	#D16MAC XR10,XR7,XR3,XR15,SS,HW
# 0 "" 2
# 461 "simple_idct.c" 1
.word	0b01110011101111010010001010001010	#D16MAC XR10,XR8,XR4,XR15,SS,HW
# 0 "" 2
# 463 "simple_idct.c" 1
.word	0b01110000001111000000001010001011	#D16MACF XR10,XR0,XR0,XR15,AA,WW
# 0 "" 2
# 465 "simple_idct.c" 1
.word	0b01110001001001100110111011001110	#Q16ADD XR11,XR11,XR9,XR9,AS,WW
# 0 "" 2
# 466 "simple_idct.c" 1
.word	0b01110000010000000000001011010001	#S32STD XR11,$2,0
# 0 "" 2
# 467 "simple_idct.c" 1
.word	0b01110000010000000111001001010001	#S32STD XR9,$2,112
# 0 "" 2
# 468 "simple_idct.c" 1
.word	0b01110001001010101011011101001110	#Q16ADD XR13,XR13,XR10,XR10,AS,WW
# 0 "" 2
# 469 "simple_idct.c" 1
.word	0b01110000010000000001001101010001	#S32STD XR13,$2,16
# 0 "" 2
# 470 "simple_idct.c" 1
.word	0b01110000010000000110001010010001	#S32STD XR10,$2,96
# 0 "" 2
# 472 "simple_idct.c" 1
.word	0b01110000101010000110001001001000	#D16MUL XR9,XR8,XR1,XR10,HW
# 0 "" 2
# 473 "simple_idct.c" 1
.word	0b01110011101010001001111001001010	#D16MAC XR9,XR7,XR2,XR10,SS,HW
# 0 "" 2
# 474 "simple_idct.c" 1
.word	0b01110000011010001110001001001010	#D16MAC XR9,XR8,XR3,XR10,AA,LW
# 0 "" 2
# 476 "simple_idct.c" 1
.word	0b01110000011010010001111001001010	#D16MAC XR9,XR7,XR4,XR10,AA,LW
# 0 "" 2
# 478 "simple_idct.c" 1
.word	0b01110000001010000000001001001011	#D16MACF XR9,XR0,XR0,XR10,AA,WW
# 0 "" 2
# 480 "simple_idct.c" 1
.word	0b01110000011111000110001010001000	#D16MUL XR10,XR8,XR1,XR15,LW
# 0 "" 2
# 481 "simple_idct.c" 1
.word	0b01110011101111001010001010001010	#D16MAC XR10,XR8,XR2,XR15,SS,HW
# 0 "" 2
# 482 "simple_idct.c" 1
.word	0b01110000011111001101111010001010	#D16MAC XR10,XR7,XR3,XR15,AA,LW
# 0 "" 2
# 484 "simple_idct.c" 1
.word	0b01110011101111010001111010001010	#D16MAC XR10,XR7,XR4,XR15,SS,HW
# 0 "" 2
# 486 "simple_idct.c" 1
.word	0b01110000001111000000001010001011	#D16MACF XR10,XR0,XR0,XR15,AA,WW
# 0 "" 2
# 488 "simple_idct.c" 1
.word	0b01110001001001100111101110001110	#Q16ADD XR14,XR14,XR9,XR9,AS,WW
# 0 "" 2
# 489 "simple_idct.c" 1
.word	0b01110000010000000010001110010001	#S32STD XR14,$2,32
# 0 "" 2
# 490 "simple_idct.c" 1
.word	0b01110000010000000101001001010001	#S32STD XR9,$2,80
# 0 "" 2
# 491 "simple_idct.c" 1
.word	0b01110001001010101011001100001110	#Q16ADD XR12,XR12,XR10,XR10,AS,WW
# 0 "" 2
# 492 "simple_idct.c" 1
.word	0b01110000010000000000010001010100	#S32LDI XR1,$2,4
# 0 "" 2
# 493 "simple_idct.c" 1
.word	0b01110000010000000010111100010001	#S32STD XR12,$2,44
# 0 "" 2
# 494 "simple_idct.c" 1
.word	0b01110000010000000011111010010001	#S32STD XR10,$2,60
# 0 "" 2
#NO_APP
bne	$2,$3,$L2
addiu	$2,$6,128
#APP
# 500 "simple_idct.c" 1
.word	0b01110000110000000000000001010000	#S32LDD XR1,$6,0
# 0 "" 2
#NO_APP
$L3:
#APP
# 502 "simple_idct.c" 1
.word	0b01110000110000000000010010010000	#S32LDD XR2,$6,4
# 0 "" 2
# 503 "simple_idct.c" 1
.word	0b01110000110000000000100011010000	#S32LDD XR3,$6,8
# 0 "" 2
# 504 "simple_idct.c" 1
.word	0b01110000110000000000110100010000	#S32LDD XR4,$6,12
# 0 "" 2
# 507 "simple_idct.c" 1
.word	0b01110000101100011100011011001000	#D16MUL XR11,XR1,XR7,XR12,HW
# 0 "" 2
# 508 "simple_idct.c" 1
.word	0b01110000101110100000011101001000	#D16MUL XR13,XR1,XR8,XR14,HW
# 0 "" 2
# 509 "simple_idct.c" 1
.word	0b01110010101011011100101101001010	#D16MAC XR13,XR2,XR7,XR11,SA,HW
# 0 "" 2
# 510 "simple_idct.c" 1
.word	0b01110011101100100000101110001010	#D16MAC XR14,XR2,XR8,XR12,SS,HW
# 0 "" 2
# 511 "simple_idct.c" 1
.word	0b01110010101110011100111100001010	#D16MAC XR12,XR3,XR7,XR14,SA,HW
# 0 "" 2
# 513 "simple_idct.c" 1
.word	0b01110000101101100000111011001010	#D16MAC XR11,XR3,XR8,XR13,AA,HW
# 0 "" 2
# 516 "simple_idct.c" 1
.word	0b01110000011010010100011001001000	#D16MUL XR9,XR1,XR5,XR10,LW
# 0 "" 2
# 517 "simple_idct.c" 1
.word	0b01110001011010010100111001001010	#D16MAC XR9,XR3,XR5,XR10,AS,LW
# 0 "" 2
# 518 "simple_idct.c" 1
.word	0b01110000010011011000100001001000	#D16MUL XR1,XR2,XR6,XR3,LW
# 0 "" 2
# 519 "simple_idct.c" 1
.word	0b01110010010001011001000011001010	#D16MAC XR3,XR4,XR6,XR1,SA,LW
# 0 "" 2
# 521 "simple_idct.c" 1
.word	0b01110010101011100001001100001010	#D16MAC XR12,XR4,XR8,XR11,SA,HW
# 0 "" 2
# 523 "simple_idct.c" 1
.word	0b01110010101101011101001110001010	#D16MAC XR14,XR4,XR7,XR13,SA,HW
# 0 "" 2
# 526 "simple_idct.c" 1
.word	0b01110001000100000110010010011000	#D32ADD XR2,XR9,XR1,XR4,AS
# 0 "" 2
# 528 "simple_idct.c" 1
.word	0b01110001000001001110101001011000	#D32ADD XR9,XR10,XR3,XR1,AS
# 0 "" 2
# 531 "simple_idct.c" 1
.word	0b01110001001011101100100010011000	#D32ADD XR2,XR2,XR11,XR11,AS
# 0 "" 2
# 532 "simple_idct.c" 1
.word	0b01110001001110111001000100011000	#D32ADD XR4,XR4,XR14,XR14,AS
# 0 "" 2
# 533 "simple_idct.c" 1
.word	0b01110001001100110010011001011000	#D32ADD XR9,XR9,XR12,XR12,AS
# 0 "" 2
# 534 "simple_idct.c" 1
.word	0b01110001001101110100010001011000	#D32ADD XR1,XR1,XR13,XR13,AS
# 0 "" 2
# 536 "simple_idct.c" 1
.word	0b01110000000010000000001001001011	#D16MACF XR9,XR0,XR0,XR2,AA,WW
# 0 "" 2
# 537 "simple_idct.c" 1
.word	0b01110000000001000000000100001011	#D16MACF XR4,XR0,XR0,XR1,AA,WW
# 0 "" 2
# 538 "simple_idct.c" 1
.word	0b01110000001110000000001101001011	#D16MACF XR13,XR0,XR0,XR14,AA,WW
# 0 "" 2
# 539 "simple_idct.c" 1
.word	0b01110000001100000000001011001011	#D16MACF XR11,XR0,XR0,XR12,AA,WW
# 0 "" 2
# 541 "simple_idct.c" 1
.word	0b01110000000110100101000100000111	#Q16SAT XR4,XR4,XR9
# 0 "" 2
# 542 "simple_idct.c" 1
.word	0b01110000000110110110111011000111	#Q16SAT XR11,XR11,XR13
# 0 "" 2
# 543 "simple_idct.c" 1
.word	0b01110000110000000001000001010100	#S32LDI XR1,$6,16
# 0 "" 2
# 544 "simple_idct.c" 1
.word	0b01110000100000000000000100010001	#S32STD XR4,$4,0
# 0 "" 2
# 545 "simple_idct.c" 1
.word	0b01110000100000000000011011010001	#S32STD XR11,$4,4
# 0 "" 2
#NO_APP
.set	noreorder
.set	nomacro
bne	$6,$2,$L3
addu	$4,$4,$5
.set	macro
.set	reorder

j	$31
.end	simple_idct_put
.size	simple_idct_put, .-simple_idct_put
.align	2
.globl	simple_idct_add
.set	nomips16
.ent	simple_idct_add
.type	simple_idct_add, @function
simple_idct_add:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
.mask	0x00000000,0
.fmask	0x00000000,0
li	$2,1518469120			# 0x5a820000
ori	$2,$2,0x5a82
#APP
# 566 "simple_idct.c" 1
.word	0b01110000000000100000000101101111	#S32I2M XR5,$2
# 0 "" 2
#NO_APP
li	$2,1984036864			# 0x76420000
ori	$2,$2,0x30fc
#APP
# 567 "simple_idct.c" 1
.word	0b01110000000000100000000110101111	#S32I2M XR6,$2
# 0 "" 2
#NO_APP
li	$2,2106195968			# 0x7d8a0000
ori	$2,$2,0x6a6e
#APP
# 568 "simple_idct.c" 1
.word	0b01110000000000100000000111101111	#S32I2M XR7,$2
# 0 "" 2
#NO_APP
li	$2,1193082880			# 0x471d0000
ori	$2,$2,0x18f9
#APP
# 569 "simple_idct.c" 1
.word	0b01110000000000100000001000101111	#S32I2M XR8,$2
# 0 "" 2
#NO_APP
addiu	$3,$6,16
#APP
# 573 "simple_idct.c" 1
.word	0b01110000110000000000000001010000	#S32LDD XR1,$6,0
# 0 "" 2
#NO_APP
move	$2,$6
$L9:
#APP
# 576 "simple_idct.c" 1
.word	0b01110000010000000010000010010000	#S32LDD XR2,$2,32
# 0 "" 2
# 577 "simple_idct.c" 1
.word	0b01110000010000000100000011010000	#S32LDD XR3,$2,64
# 0 "" 2
# 578 "simple_idct.c" 1
.word	0b01110000010000000110000100010000	#S32LDD XR4,$2,96
# 0 "" 2
# 581 "simple_idct.c" 1
.word	0b01110000101101000101011011001000	#D16MUL XR11,XR5,XR1,XR13,HW
# 0 "" 2
# 582 "simple_idct.c" 1
.word	0b01110000101101001101011011001010	#D16MAC XR11,XR5,XR3,XR13,AA,HW
# 0 "" 2
# 583 "simple_idct.c" 1
.word	0b01110000101110001001101100001000	#D16MUL XR12,XR6,XR2,XR14,HW
# 0 "" 2
# 584 "simple_idct.c" 1
.word	0b01110000011110010001101100001010	#D16MAC XR12,XR6,XR4,XR14,AA,LW
# 0 "" 2
# 585 "simple_idct.c" 1
.word	0b01110001001100110010111011011000	#D32ADD XR11,XR11,XR12,XR12,AS
# 0 "" 2
# 587 "simple_idct.c" 1
.word	0b01110001001110111011011101011000	#D32ADD XR13,XR13,XR14,XR14,AS
# 0 "" 2
# 589 "simple_idct.c" 1
.word	0b01110000001101000000001011001011	#D16MACF XR11,XR0,XR0,XR13,AA,WW
# 0 "" 2
# 590 "simple_idct.c" 1
.word	0b01110000001110000000001100001011	#D16MACF XR12,XR0,XR0,XR14,AA,WW
# 0 "" 2
# 592 "simple_idct.c" 1
.word	0b01110000101010000101011101001000	#D16MUL XR13,XR5,XR1,XR10,HW
# 0 "" 2
# 593 "simple_idct.c" 1
.word	0b01110011101010001101011101001010	#D16MAC XR13,XR5,XR3,XR10,SS,HW
# 0 "" 2
# 595 "simple_idct.c" 1
.word	0b01110000011001001001101110001000	#D16MUL XR14,XR6,XR2,XR9,LW
# 0 "" 2
# 596 "simple_idct.c" 1
.word	0b01110011101001010001101110001010	#D16MAC XR14,XR6,XR4,XR9,SS,HW
# 0 "" 2
# 597 "simple_idct.c" 1
.word	0b01110001001110111011011101011000	#D32ADD XR13,XR13,XR14,XR14,AS
# 0 "" 2
# 599 "simple_idct.c" 1
.word	0b01110001001001100110101010011000	#D32ADD XR10,XR10,XR9,XR9,AS
# 0 "" 2
# 601 "simple_idct.c" 1
.word	0b01110000001010000000001101001011	#D16MACF XR13,XR0,XR0,XR10,AA,WW
# 0 "" 2
# 602 "simple_idct.c" 1
.word	0b01110000001001000000001110001011	#D16MACF XR14,XR0,XR0,XR9,AA,WW
# 0 "" 2
# 605 "simple_idct.c" 1
.word	0b01110000010000000001000001010000	#S32LDD XR1,$2,16
# 0 "" 2
# 606 "simple_idct.c" 1
.word	0b01110000010000000011000010010000	#S32LDD XR2,$2,48
# 0 "" 2
# 607 "simple_idct.c" 1
.word	0b01110000010000000101000011010000	#S32LDD XR3,$2,80
# 0 "" 2
# 608 "simple_idct.c" 1
.word	0b01110000010000000111000100010000	#S32LDD XR4,$2,112
# 0 "" 2
# 612 "simple_idct.c" 1
.word	0b01110000101010000101111001001000	#D16MUL XR9,XR7,XR1,XR10,HW
# 0 "" 2
# 613 "simple_idct.c" 1
.word	0b01110000011010001001111001001010	#D16MAC XR9,XR7,XR2,XR10,AA,LW
# 0 "" 2
# 614 "simple_idct.c" 1
.word	0b01110000101010001110001001001010	#D16MAC XR9,XR8,XR3,XR10,AA,HW
# 0 "" 2
# 616 "simple_idct.c" 1
.word	0b01110000011010010010001001001010	#D16MAC XR9,XR8,XR4,XR10,AA,LW
# 0 "" 2
# 618 "simple_idct.c" 1
.word	0b01110000001010000000001001001011	#D16MACF XR9,XR0,XR0,XR10,AA,WW
# 0 "" 2
# 620 "simple_idct.c" 1
.word	0b01110000011111000101111010001000	#D16MUL XR10,XR7,XR1,XR15,LW
# 0 "" 2
# 621 "simple_idct.c" 1
.word	0b01110011011111001010001010001010	#D16MAC XR10,XR8,XR2,XR15,SS,LW
# 0 "" 2
# 622 "simple_idct.c" 1
.word	0b01110011101111001101111010001010	#D16MAC XR10,XR7,XR3,XR15,SS,HW
# 0 "" 2
# 624 "simple_idct.c" 1
.word	0b01110011101111010010001010001010	#D16MAC XR10,XR8,XR4,XR15,SS,HW
# 0 "" 2
# 626 "simple_idct.c" 1
.word	0b01110000001111000000001010001011	#D16MACF XR10,XR0,XR0,XR15,AA,WW
# 0 "" 2
# 628 "simple_idct.c" 1
.word	0b01110001001001100110111011001110	#Q16ADD XR11,XR11,XR9,XR9,AS,WW
# 0 "" 2
# 629 "simple_idct.c" 1
.word	0b01110000010000000000001011010001	#S32STD XR11,$2,0
# 0 "" 2
# 630 "simple_idct.c" 1
.word	0b01110000010000000111001001010001	#S32STD XR9,$2,112
# 0 "" 2
# 631 "simple_idct.c" 1
.word	0b01110001001010101011011101001110	#Q16ADD XR13,XR13,XR10,XR10,AS,WW
# 0 "" 2
# 632 "simple_idct.c" 1
.word	0b01110000010000000001001101010001	#S32STD XR13,$2,16
# 0 "" 2
# 633 "simple_idct.c" 1
.word	0b01110000010000000110001010010001	#S32STD XR10,$2,96
# 0 "" 2
# 635 "simple_idct.c" 1
.word	0b01110000101010000110001001001000	#D16MUL XR9,XR8,XR1,XR10,HW
# 0 "" 2
# 636 "simple_idct.c" 1
.word	0b01110011101010001001111001001010	#D16MAC XR9,XR7,XR2,XR10,SS,HW
# 0 "" 2
# 637 "simple_idct.c" 1
.word	0b01110000011010001110001001001010	#D16MAC XR9,XR8,XR3,XR10,AA,LW
# 0 "" 2
# 639 "simple_idct.c" 1
.word	0b01110000011010010001111001001010	#D16MAC XR9,XR7,XR4,XR10,AA,LW
# 0 "" 2
# 641 "simple_idct.c" 1
.word	0b01110000001010000000001001001011	#D16MACF XR9,XR0,XR0,XR10,AA,WW
# 0 "" 2
# 643 "simple_idct.c" 1
.word	0b01110000011111000110001010001000	#D16MUL XR10,XR8,XR1,XR15,LW
# 0 "" 2
# 644 "simple_idct.c" 1
.word	0b01110011101111001010001010001010	#D16MAC XR10,XR8,XR2,XR15,SS,HW
# 0 "" 2
# 645 "simple_idct.c" 1
.word	0b01110000011111001101111010001010	#D16MAC XR10,XR7,XR3,XR15,AA,LW
# 0 "" 2
# 647 "simple_idct.c" 1
.word	0b01110011101111010001111010001010	#D16MAC XR10,XR7,XR4,XR15,SS,HW
# 0 "" 2
# 649 "simple_idct.c" 1
.word	0b01110000001111000000001010001011	#D16MACF XR10,XR0,XR0,XR15,AA,WW
# 0 "" 2
# 651 "simple_idct.c" 1
.word	0b01110001001001100111101110001110	#Q16ADD XR14,XR14,XR9,XR9,AS,WW
# 0 "" 2
# 652 "simple_idct.c" 1
.word	0b01110000010000000010001110010001	#S32STD XR14,$2,32
# 0 "" 2
# 653 "simple_idct.c" 1
.word	0b01110000010000000101001001010001	#S32STD XR9,$2,80
# 0 "" 2
# 654 "simple_idct.c" 1
.word	0b01110001001010101011001100001110	#Q16ADD XR12,XR12,XR10,XR10,AS,WW
# 0 "" 2
# 655 "simple_idct.c" 1
.word	0b01110000010000000000010001010100	#S32LDI XR1,$2,4
# 0 "" 2
# 656 "simple_idct.c" 1
.word	0b01110000010000000010111100010001	#S32STD XR12,$2,44
# 0 "" 2
# 657 "simple_idct.c" 1
.word	0b01110000010000000011111010010001	#S32STD XR10,$2,60
# 0 "" 2
#NO_APP
bne	$2,$3,$L9
addiu	$2,$6,128
#APP
# 662 "simple_idct.c" 1
.word	0b01110000110000000000000001010000	#S32LDD XR1,$6,0
# 0 "" 2
#NO_APP
$L10:
#APP
# 665 "simple_idct.c" 1
.word	0b01110000110000000000010010010000	#S32LDD XR2,$6,4
# 0 "" 2
# 666 "simple_idct.c" 1
.word	0b01110000110000000000100011010000	#S32LDD XR3,$6,8
# 0 "" 2
# 667 "simple_idct.c" 1
.word	0b01110000110000000000110100010000	#S32LDD XR4,$6,12
# 0 "" 2
# 670 "simple_idct.c" 1
.word	0b01110000101100011100011011001000	#D16MUL XR11,XR1,XR7,XR12,HW
# 0 "" 2
# 671 "simple_idct.c" 1
.word	0b01110000101110100000011101001000	#D16MUL XR13,XR1,XR8,XR14,HW
# 0 "" 2
# 672 "simple_idct.c" 1
.word	0b01110010101011011100101101001010	#D16MAC XR13,XR2,XR7,XR11,SA,HW
# 0 "" 2
# 673 "simple_idct.c" 1
.word	0b01110011101100100000101110001010	#D16MAC XR14,XR2,XR8,XR12,SS,HW
# 0 "" 2
# 674 "simple_idct.c" 1
.word	0b01110010101110011100111100001010	#D16MAC XR12,XR3,XR7,XR14,SA,HW
# 0 "" 2
# 676 "simple_idct.c" 1
.word	0b01110000101101100000111011001010	#D16MAC XR11,XR3,XR8,XR13,AA,HW
# 0 "" 2
# 679 "simple_idct.c" 1
.word	0b01110000011010010100011001001000	#D16MUL XR9,XR1,XR5,XR10,LW
# 0 "" 2
# 680 "simple_idct.c" 1
.word	0b01110001011010010100111001001010	#D16MAC XR9,XR3,XR5,XR10,AS,LW
# 0 "" 2
# 681 "simple_idct.c" 1
.word	0b01110000010011011000100001001000	#D16MUL XR1,XR2,XR6,XR3,LW
# 0 "" 2
# 682 "simple_idct.c" 1
.word	0b01110010010001011001000011001010	#D16MAC XR3,XR4,XR6,XR1,SA,LW
# 0 "" 2
# 684 "simple_idct.c" 1
.word	0b01110010101011100001001100001010	#D16MAC XR12,XR4,XR8,XR11,SA,HW
# 0 "" 2
# 686 "simple_idct.c" 1
.word	0b01110010101101011101001110001010	#D16MAC XR14,XR4,XR7,XR13,SA,HW
# 0 "" 2
# 689 "simple_idct.c" 1
.word	0b01110001000100000110010010011000	#D32ADD XR2,XR9,XR1,XR4,AS
# 0 "" 2
# 691 "simple_idct.c" 1
.word	0b01110001000001001110101001011000	#D32ADD XR9,XR10,XR3,XR1,AS
# 0 "" 2
# 694 "simple_idct.c" 1
.word	0b01110001001011101100100010011000	#D32ADD XR2,XR2,XR11,XR11,AS
# 0 "" 2
# 695 "simple_idct.c" 1
.word	0b01110001001110111001000100011000	#D32ADD XR4,XR4,XR14,XR14,AS
# 0 "" 2
# 696 "simple_idct.c" 1
.word	0b01110001001100110010011001011000	#D32ADD XR9,XR9,XR12,XR12,AS
# 0 "" 2
# 697 "simple_idct.c" 1
.word	0b01110001001101110100010001011000	#D32ADD XR1,XR1,XR13,XR13,AS
# 0 "" 2
# 699 "simple_idct.c" 1
.word	0b01110000000010000000001001001011	#D16MACF XR9,XR0,XR0,XR2,AA,WW
# 0 "" 2
# 700 "simple_idct.c" 1
.word	0b01110000000001000000000100001011	#D16MACF XR4,XR0,XR0,XR1,AA,WW
# 0 "" 2
# 701 "simple_idct.c" 1
.word	0b01110000001110000000001101001011	#D16MACF XR13,XR0,XR0,XR14,AA,WW
# 0 "" 2
# 702 "simple_idct.c" 1
.word	0b01110000001100000000001011001011	#D16MACF XR11,XR0,XR0,XR12,AA,WW
# 0 "" 2
# 703 "simple_idct.c" 1
.word	0b01110000100000000000000001010000	#S32LDD XR1,$4,0
# 0 "" 2
# 704 "simple_idct.c" 1
.word	0b01110000100000000000010010010000	#S32LDD XR2,$4,4
# 0 "" 2
# 705 "simple_idct.c" 1
.word	0b01110000001001000000010100011101	#Q8ACCE XR4,XR1,XR0,XR9,AA
# 0 "" 2
# 706 "simple_idct.c" 1
.word	0b01110000001101000000101011011101	#Q8ACCE XR11,XR2,XR0,XR13,AA
# 0 "" 2
# 707 "simple_idct.c" 1
.word	0b01110000110000000001000001010100	#S32LDI XR1,$6,16
# 0 "" 2
# 709 "simple_idct.c" 1
.word	0b01110000000110100101000100000111	#Q16SAT XR4,XR4,XR9
# 0 "" 2
# 710 "simple_idct.c" 1
.word	0b01110000000110110110111011000111	#Q16SAT XR11,XR11,XR13
# 0 "" 2
# 711 "simple_idct.c" 1
.word	0b01110000100000000000000100010001	#S32STD XR4,$4,0
# 0 "" 2
# 712 "simple_idct.c" 1
.word	0b01110000100000000000011011010001	#S32STD XR11,$4,4
# 0 "" 2
#NO_APP
.set	noreorder
.set	nomacro
bne	$6,$2,$L10
addu	$4,$4,$5
.set	macro
.set	reorder

j	$31
.end	simple_idct_add
.size	simple_idct_add, .-simple_idct_add
.align	2
.globl	simple_idct48_add
.set	nomips16
.ent	simple_idct48_add
.type	simple_idct48_add, @function
simple_idct48_add:
.frame	$sp,120,$31		# vars= 72, regs= 9/0, args= 0, gp= 8
.mask	0x40ff0000,-4
.fmask	0x00000000,0
.set	noreorder
.set	nomacro

lui	$28,%hi(__gnu_local_gp)
addiu	$sp,$sp,-120
addiu	$28,$28,%lo(__gnu_local_gp)
sw	$fp,116($sp)
sw	$23,112($sp)
sw	$22,108($sp)
sw	$21,104($sp)
sw	$20,100($sp)
sw	$19,96($sp)
sw	$18,92($sp)
sw	$17,88($sp)
sw	$16,84($sp)
.cprestore	0
lh	$2,64($6)
lh	$9,68($6)
lh	$14,16($6)
lh	$12,52($6)
lh	$18,20($6)
lh	$7,48($6)
sw	$2,32($sp)
lh	$3,66($6)
sw	$9,24($sp)
lh	$10,32($6)
subu	$13,$7,$12
lh	$23,36($6)
subu	$16,$14,$18
addu	$7,$12,$7
addu	$18,$18,$14
lw	$12,24($sp)
lw	$14,32($sp)
sw	$3,28($sp)
subu	$fp,$10,$23
addu	$23,$23,$10
addu	$10,$12,$14
lw	$12,28($sp)
li	$8,30274			# 0x7642
mul	$12,$12,$8
li	$3,23170			# 0x5a82
sw	$12,40($sp)
mul	$12,$fp,$3
sw	$13,8($sp)
sw	$12,36($sp)
mul	$12,$7,$3
lw	$7,8($sp)
lh	$24,0($6)
mul	$7,$7,$3
lh	$22,4($6)
sw	$7,8($sp)
mul	$7,$10,$3
lh	$21,2($6)
subu	$20,$24,$22
lh	$fp,70($6)
addu	$22,$22,$24
lh	$24,6($6)
li	$2,12540			# 0x30fc
sw	$7,16($sp)
li	$7,-30274			# 0xffffffffffff89be
mul	$19,$21,$2
lh	$14,22($6)
lh	$10,54($6)
lh	$17,18($6)
lh	$15,34($6)
lh	$11,50($6)
sw	$12,12($sp)
lh	$12,38($6)
sw	$fp,20($sp)
mul	$fp,$24,$7
mul	$25,$17,$2
addu	$19,$fp,$19
mul	$fp,$14,$7
mul	$13,$15,$2
addu	$25,$fp,$25
mul	$fp,$12,$7
mul	$9,$11,$2
mul	$23,$23,$3
addu	$13,$fp,$13
mul	$fp,$10,$7
mul	$17,$17,$8
addu	$9,$fp,$9
mul	$fp,$24,$2
addiu	$24,$23,1024
mul	$23,$14,$2
mul	$15,$15,$8
addu	$17,$23,$17
mul	$23,$12,$2
mul	$11,$11,$8
addu	$15,$23,$15
mul	$23,$10,$2
mul	$21,$21,$8
addu	$11,$23,$11
lw	$23,40($sp)
mul	$22,$22,$3
mul	$20,$20,$3
mul	$18,$18,$3
mul	$16,$16,$3
mtlo	$23
lw	$23,20($sp)
addu	$21,$fp,$21
madd	$23,$2
lw	$fp,36($sp)
mflo	$23
addiu	$14,$fp,1024
lw	$fp,12($sp)
addiu	$20,$20,1024
addiu	$12,$fp,1024
addiu	$16,$16,1024
lw	$fp,8($sp)
sw	$23,12($sp)
subu	$23,$20,$19
addiu	$18,$18,1024
sw	$23,72($sp)
subu	$23,$16,$25
addiu	$10,$fp,1024
sw	$23,36($sp)
lw	$fp,16($sp)
subu	$23,$18,$17
sw	$23,52($sp)
subu	$23,$14,$13
sw	$23,56($sp)
addiu	$fp,$fp,1024
subu	$23,$24,$15
sw	$fp,8($sp)
sw	$23,60($sp)
addu	$15,$24,$15
subu	$23,$10,$9
sw	$23,64($sp)
lw	$24,8($sp)
subu	$23,$12,$11
sra	$15,$15,11
addu	$11,$12,$11
mflo	$12
addiu	$22,$22,1024
addu	$17,$18,$17
addu	$25,$16,$25
addu	$13,$14,$13
lw	$16,52($sp)
lw	$14,72($sp)
sw	$15,44($sp)
lw	$15,36($sp)
subu	$fp,$22,$21
addu	$19,$20,$19
addu	$21,$22,$21
lw	$20,64($sp)
addu	$9,$10,$9
sra	$17,$17,11
addu	$10,$24,$12
sw	$23,68($sp)
sra	$12,$15,11
sra	$23,$14,11
sra	$15,$16,11
sra	$21,$21,11
sw	$17,40($sp)
sra	$10,$10,11
lw	$17,56($sp)
sra	$19,$19,11
sra	$fp,$fp,11
sra	$25,$25,11
sra	$13,$13,11
lw	$18,60($sp)
sw	$21,16($sp)
sw	$10,48($sp)
lw	$21,68($sp)
sra	$10,$20,11
sra	$9,$9,11
sh	$19,2($6)
sh	$23,4($6)
sh	$fp,6($6)
sh	$25,18($6)
sh	$12,20($6)
sh	$15,22($6)
sh	$13,34($6)
lh	$20,100($6)
lh	$15,96($6)
sra	$14,$17,11
lh	$13,116($6)
sh	$9,50($6)
lh	$9,112($6)
sh	$14,36($6)
subu	$14,$15,$20
lw	$fp,32($sp)
sw	$14,32($sp)
subu	$14,$9,$13
lw	$23,40($sp)
addu	$15,$20,$15
mul	$20,$14,$3
lw	$14,32($sp)
sra	$16,$21,11
addu	$13,$13,$9
lh	$21,84($6)
mul	$9,$14,$3
sh	$10,52($6)
mul	$14,$13,$3
lw	$10,24($sp)
lh	$13,118($6)
sh	$16,54($6)
sh	$23,16($6)
lh	$16,80($6)
lh	$23,114($6)
sra	$24,$18,11
lw	$25,48($sp)
subu	$18,$fp,$10
subu	$19,$16,$21
mul	$10,$23,$2
addu	$16,$21,$16
mul	$21,$13,$7
lw	$22,16($sp)
lh	$12,82($6)
lw	$17,28($sp)
sh	$24,38($6)
sh	$25,64($6)
lw	$24,44($sp)
lh	$25,98($6)
mul	$fp,$23,$8
addu	$10,$21,$10
sh	$22,0($6)
lw	$21,20($sp)
mul	$22,$17,$2
sh	$24,32($6)
mul	$17,$25,$2
mul	$24,$12,$2
mul	$12,$12,$8
mul	$8,$25,$8
lh	$25,86($6)
mul	$23,$21,$7
mul	$21,$25,$7
mul	$18,$18,$3
mul	$16,$16,$3
mul	$19,$19,$3
mul	$15,$15,$3
lh	$3,102($6)
addu	$24,$21,$24
mul	$21,$3,$7
sra	$11,$11,11
addu	$7,$21,$17
mul	$17,$25,$2
sh	$11,48($6)
addu	$12,$17,$12
mul	$17,$3,$2
addiu	$3,$14,1024
mul	$14,$13,$2
addu	$8,$17,$8
lw	$17,16($sp)
sll	$11,$11,16
sra	$11,$11,16
sll	$21,$17,16
li	$17,-22725			# 0xffffffffffffa73b
addu	$2,$14,$fp
addiu	$14,$20,1024
mul	$20,$11,$17
addiu	$18,$18,1024
addu	$22,$23,$22
sw	$20,56($sp)
li	$17,19266			# 0x4b42
subu	$20,$18,$22
li	$23,-12873			# 0xffffffffffffcdb7
li	$13,-4520			# 0xffffffffffffee58
sw	$20,52($sp)
mul	$23,$11,$23
lw	$20,12($sp)
mul	$13,$11,$13
mul	$11,$11,$17
lw	$17,8($sp)
addiu	$16,$16,1024
addiu	$19,$19,1024
addiu	$15,$15,1024
addiu	$9,$9,1024
sra	$21,$21,16
subu	$fp,$17,$20
subu	$17,$19,$24
subu	$20,$16,$12
sw	$17,20($sp)
sw	$20,24($sp)
subu	$17,$9,$7
subu	$20,$15,$8
sll	$25,$21,14
sw	$17,28($sp)
sw	$20,32($sp)
subu	$17,$14,$10
subu	$20,$3,$2
subu	$25,$25,$21
addu	$12,$16,$12
addu	$2,$3,$2
li	$21,458752			# 0x70000
lw	$3,52($sp)
sw	$17,16($sp)
addu	$7,$9,$7
sra	$12,$12,11
lw	$9,20($sp)
ori	$21,$21,0xffe0
addu	$21,$25,$21
sw	$20,36($sp)
lw	$25,40($sp)
sra	$20,$3,11
sw	$12,8($sp)
lw	$3,16($sp)
lw	$12,28($sp)
addu	$19,$19,$24
sra	$fp,$fp,11
lw	$24,44($sp)
sw	$fp,12($sp)
addu	$22,$18,$22
lw	$fp,32($sp)
sra	$18,$9,11
lw	$9,36($sp)
addu	$8,$15,$8
addu	$14,$14,$10
sll	$15,$24,16
lw	$10,24($sp)
sll	$17,$25,16
sra	$25,$12,11
sra	$12,$3,11
lw	$3,48($sp)
sra	$15,$15,16
sra	$24,$fp,11
sra	$fp,$9,11
li	$9,-21407			# 0xffffffffffffac61
sra	$16,$10,11
sll	$10,$3,16
mul	$3,$15,$9
sra	$17,$17,16
sra	$22,$22,11
addu	$9,$3,$21
li	$3,4520			# 0x11a8
sh	$22,66($6)
sh	$20,68($6)
mul	$22,$17,$3
lw	$20,8($sp)
lw	$3,12($sp)
sra	$8,$8,11
sra	$7,$7,11
sra	$2,$2,11
sra	$19,$19,11
sh	$3,70($6)
sh	$8,96($6)
sh	$7,98($6)
sh	$25,100($6)
sh	$20,80($6)
sh	$19,82($6)
sh	$18,84($6)
sh	$16,86($6)
sh	$24,102($6)
sh	$2,112($6)
li	$2,22725			# 0x58c5
mul	$3,$17,$2
sra	$14,$14,11
li	$2,19266			# 0x4b42
sh	$14,114($6)
addu	$11,$3,$11
li	$14,21407			# 0x539f
mul	$3,$17,$2
li	$2,12873			# 0x3249
mul	$7,$17,$2
mul	$2,$15,$14
li	$25,8867			# 0x22a3
addu	$14,$2,$21
mul	$2,$15,$25
addu	$13,$3,$13
lw	$3,56($sp)
addu	$25,$2,$21
li	$2,-8867			# 0xffffffffffffdd5d
addu	$17,$7,$3
mul	$3,$15,$2
sra	$10,$10,16
sh	$12,116($6)
addu	$23,$22,$23
sh	$fp,118($6)
addiu	$12,$6,2
addiu	$8,$6,4
addiu	$7,$6,6
beq	$10,$0,$L15
addu	$21,$3,$21

sll	$2,$10,14
subu	$10,$2,$10
subu	$2,$0,$10
addu	$21,$21,$2
addu	$9,$9,$10
addu	$14,$14,$10
addu	$25,$25,$2
$L15:
lh	$2,80($6)
beq	$2,$0,$L16
nop

li	$3,19266			# 0x4b42
mul	$10,$2,$3
li	$3,12873			# 0x3249
addu	$23,$10,$23
mul	$10,$2,$3
li	$3,-22725			# 0xffffffffffffa73b
addu	$11,$10,$11
mul	$10,$2,$3
li	$3,4520			# 0x11a8
addu	$13,$10,$13
mul	$10,$2,$3
addu	$17,$10,$17
$L16:
lh	$2,96($6)
beq	$2,$0,$L17
nop

li	$3,-8867			# 0xffffffffffffdd5d
mul	$10,$2,$3
li	$3,8867			# 0x22a3
addu	$9,$10,$9
mul	$10,$2,$3
li	$3,-21407			# 0xffffffffffffac61
addu	$14,$10,$14
mul	$10,$2,$3
li	$3,21407			# 0x539f
addu	$25,$10,$25
mul	$10,$2,$3
addu	$21,$10,$21
$L17:
lh	$2,112($6)
beq	$2,$0,$L18
nop

li	$3,-22725			# 0xffffffffffffa73b
mul	$10,$2,$3
li	$3,4520			# 0x11a8
addu	$23,$10,$23
mul	$10,$2,$3
li	$3,-12873			# 0xffffffffffffcdb7
addu	$11,$10,$11
mul	$10,$2,$3
li	$3,19266			# 0x4b42
addu	$13,$10,$13
mul	$10,$2,$3
addu	$17,$10,$17
$L18:
lbu	$2,0($4)
addu	$3,$11,$14
sra	$3,$3,20
addu	$3,$3,$2
lw	$2,%got(ff_cropTbl)($28)
subu	$11,$14,$11
addiu	$2,$2,1024
addu	$3,$2,$3
lbu	$10,0($3)
addu	$3,$4,$5
sb	$10,0($4)
lbu	$15,0($3)
addu	$10,$13,$25
sra	$10,$10,20
addu	$10,$10,$15
addu	$10,$2,$10
lbu	$15,0($10)
addu	$10,$3,$5
sb	$15,0($3)
lbu	$15,0($10)
addu	$3,$17,$21
sra	$3,$3,20
addu	$3,$3,$15
addu	$3,$2,$3
lbu	$15,0($3)
addu	$3,$10,$5
sb	$15,0($10)
lbu	$15,0($3)
addu	$10,$23,$9
sra	$10,$10,20
addu	$10,$10,$15
addu	$10,$2,$10
lbu	$15,0($10)
addu	$10,$3,$5
sb	$15,0($3)
lbu	$15,0($10)
subu	$9,$9,$23
sra	$9,$9,20
addu	$9,$9,$15
addu	$9,$2,$9
lbu	$3,0($9)
addu	$9,$10,$5
sb	$3,0($10)
lbu	$3,0($9)
subu	$17,$21,$17
sra	$17,$17,20
addu	$17,$17,$3
addu	$17,$2,$17
lbu	$10,0($17)
addu	$3,$9,$5
sb	$10,0($9)
lbu	$9,0($3)
subu	$13,$25,$13
sra	$13,$13,20
addu	$13,$13,$9
addu	$13,$2,$13
lbu	$10,0($13)
addu	$9,$3,$5
sb	$10,0($3)
lbu	$3,0($9)
sra	$11,$11,20
addu	$11,$11,$3
addu	$11,$2,$11
lbu	$3,0($11)
li	$25,458752			# 0x70000
sb	$3,0($9)
lh	$15,2($6)
lh	$9,32($12)
sll	$3,$15,14
subu	$15,$3,$15
ori	$25,$25,0xffe0
addu	$3,$15,$25
li	$25,-21407			# 0xffffffffffffac61
mul	$15,$9,$25
lh	$11,48($12)
li	$10,-22725			# 0xffffffffffffa73b
mul	$19,$11,$10
lh	$10,16($12)
addu	$25,$15,$3
li	$24,-12873			# 0xffffffffffffcdb7
li	$15,4520			# 0x11a8
mul	$18,$10,$15
mul	$24,$11,$24
li	$13,19266			# 0x4b42
li	$15,22725			# 0x58c5
li	$14,-4520			# 0xffffffffffffee58
mul	$14,$11,$14
addu	$24,$18,$24
mul	$18,$10,$15
mul	$15,$10,$13
mul	$11,$11,$13
li	$13,12873			# 0x3249
addu	$14,$15,$14
mul	$15,$10,$13
li	$13,21407			# 0x539f
addu	$10,$15,$19
mul	$15,$9,$13
addu	$11,$18,$11
addu	$13,$15,$3
li	$15,8867			# 0x22a3
mul	$18,$9,$15
lh	$16,64($12)
addu	$15,$18,$3
li	$18,-8867			# 0xffffffffffffdd5d
mul	$19,$9,$18
addiu	$17,$4,1
beq	$16,$0,$L19
addu	$3,$19,$3

sll	$9,$16,14
subu	$16,$9,$16
subu	$9,$0,$16
addu	$3,$3,$9
addu	$25,$25,$16
addu	$13,$13,$16
addu	$15,$15,$9
$L19:
lh	$9,80($12)
beq	$9,$0,$L20
nop

li	$16,19266			# 0x4b42
mul	$18,$9,$16
li	$16,12873			# 0x3249
addu	$24,$18,$24
mul	$18,$9,$16
li	$16,-22725			# 0xffffffffffffa73b
addu	$11,$18,$11
mul	$18,$9,$16
li	$16,4520			# 0x11a8
addu	$14,$18,$14
mul	$18,$9,$16
addu	$10,$18,$10
$L20:
lh	$9,96($12)
beq	$9,$0,$L21
li	$16,-8867			# 0xffffffffffffdd5d

mul	$18,$9,$16
li	$16,8867			# 0x22a3
addu	$25,$18,$25
mul	$18,$9,$16
li	$16,-21407			# 0xffffffffffffac61
addu	$13,$18,$13
mul	$18,$9,$16
li	$16,21407			# 0x539f
addu	$15,$18,$15
mul	$18,$9,$16
addu	$3,$18,$3
$L21:
lh	$9,112($12)
beq	$9,$0,$L22
li	$12,-22725			# 0xffffffffffffa73b

mul	$16,$9,$12
li	$12,4520			# 0x11a8
addu	$24,$16,$24
mul	$16,$9,$12
li	$12,-12873			# 0xffffffffffffcdb7
addu	$11,$16,$11
mul	$16,$9,$12
li	$12,19266			# 0x4b42
addu	$14,$16,$14
mul	$16,$9,$12
addu	$10,$16,$10
$L22:
lbu	$12,1($4)
addu	$9,$11,$13
sra	$9,$9,20
addu	$9,$9,$12
addu	$9,$2,$9
lbu	$9,0($9)
addu	$12,$17,$5
sb	$9,1($4)
lbu	$16,0($12)
addu	$9,$14,$15
sra	$9,$9,20
addu	$9,$9,$16
addu	$9,$2,$9
lbu	$16,0($9)
addu	$9,$12,$5
sb	$16,0($12)
lbu	$16,0($9)
addu	$12,$10,$3
sra	$12,$12,20
addu	$12,$12,$16
addu	$12,$2,$12
lbu	$16,0($12)
addu	$12,$9,$5
sb	$16,0($9)
lbu	$16,0($12)
addu	$9,$24,$25
sra	$9,$9,20
addu	$9,$9,$16
addu	$9,$2,$9
lbu	$16,0($9)
addu	$9,$12,$5
sb	$16,0($12)
lbu	$12,0($9)
subu	$24,$25,$24
sra	$24,$24,20
addu	$24,$24,$12
addu	$24,$2,$24
lbu	$24,0($24)
addu	$12,$9,$5
sb	$24,0($9)
lbu	$24,0($12)
subu	$3,$3,$10
sra	$3,$3,20
addu	$3,$3,$24
addu	$3,$2,$3
lbu	$9,0($3)
addu	$3,$12,$5
sb	$9,0($12)
lbu	$9,0($3)
subu	$14,$15,$14
sra	$14,$14,20
addu	$14,$14,$9
addu	$14,$2,$14
lbu	$10,0($14)
addu	$9,$3,$5
sb	$10,0($3)
lbu	$3,0($9)
subu	$11,$13,$11
sra	$11,$11,20
addu	$11,$11,$3
addu	$11,$2,$11
lbu	$3,0($11)
li	$24,458752			# 0x70000
sb	$3,0($9)
lh	$14,4($6)
lh	$9,32($8)
sll	$3,$14,14
subu	$14,$3,$14
ori	$24,$24,0xffe0
addu	$3,$14,$24
li	$24,-21407			# 0xffffffffffffac61
mul	$14,$9,$24
lh	$11,48($8)
li	$10,-22725			# 0xffffffffffffa73b
mul	$18,$11,$10
lh	$10,16($8)
addu	$24,$14,$3
li	$15,-12873			# 0xffffffffffffcdb7
li	$14,4520			# 0x11a8
mul	$17,$10,$14
mul	$15,$11,$15
li	$12,19266			# 0x4b42
li	$14,22725			# 0x58c5
li	$13,-4520			# 0xffffffffffffee58
mul	$13,$11,$13
addu	$15,$17,$15
mul	$17,$10,$14
mul	$14,$10,$12
mul	$11,$11,$12
li	$12,12873			# 0x3249
addu	$13,$14,$13
mul	$14,$10,$12
li	$12,21407			# 0x539f
addu	$10,$14,$18
mul	$14,$9,$12
addu	$11,$17,$11
addu	$12,$14,$3
li	$14,8867			# 0x22a3
mul	$17,$9,$14
lh	$25,64($8)
addu	$14,$17,$3
li	$17,-8867			# 0xffffffffffffdd5d
mul	$18,$9,$17
addiu	$16,$4,2
beq	$25,$0,$L23
addu	$3,$18,$3

sll	$9,$25,14
subu	$25,$9,$25
subu	$9,$0,$25
addu	$3,$3,$9
addu	$24,$24,$25
addu	$12,$12,$25
addu	$14,$14,$9
$L23:
lh	$9,80($8)
beq	$9,$0,$L24
nop

li	$25,19266			# 0x4b42
mul	$17,$9,$25
li	$25,12873			# 0x3249
addu	$15,$17,$15
mul	$17,$9,$25
li	$25,-22725			# 0xffffffffffffa73b
addu	$11,$17,$11
mul	$17,$9,$25
li	$25,4520			# 0x11a8
addu	$13,$17,$13
mul	$17,$9,$25
addu	$10,$17,$10
$L24:
lh	$9,96($8)
beq	$9,$0,$L25
li	$25,-8867			# 0xffffffffffffdd5d

mul	$17,$9,$25
li	$25,8867			# 0x22a3
addu	$24,$17,$24
mul	$17,$9,$25
li	$25,-21407			# 0xffffffffffffac61
addu	$12,$17,$12
mul	$17,$9,$25
li	$25,21407			# 0x539f
addu	$14,$17,$14
mul	$17,$9,$25
addu	$3,$17,$3
$L25:
lh	$9,112($8)
beq	$9,$0,$L26
li	$8,-22725			# 0xffffffffffffa73b

mul	$17,$9,$8
li	$8,4520			# 0x11a8
addu	$15,$17,$15
mul	$17,$9,$8
li	$8,-12873			# 0xffffffffffffcdb7
addu	$11,$17,$11
mul	$17,$9,$8
li	$8,19266			# 0x4b42
addu	$13,$17,$13
mul	$17,$9,$8
addu	$10,$17,$10
$L26:
lbu	$9,2($4)
addu	$8,$11,$12
sra	$8,$8,20
addu	$8,$8,$9
addu	$8,$2,$8
lbu	$9,0($8)
addu	$8,$16,$5
sb	$9,2($4)
lbu	$25,0($8)
addu	$9,$13,$14
sra	$9,$9,20
addu	$9,$9,$25
addu	$9,$2,$9
lbu	$25,0($9)
addu	$9,$8,$5
sb	$25,0($8)
lbu	$25,0($9)
addu	$8,$10,$3
sra	$8,$8,20
addu	$8,$8,$25
addu	$8,$2,$8
lbu	$25,0($8)
addu	$8,$9,$5
sb	$25,0($9)
lbu	$25,0($8)
addu	$9,$15,$24
sra	$9,$9,20
addu	$9,$9,$25
addu	$9,$2,$9
lbu	$25,0($9)
addu	$9,$8,$5
sb	$25,0($8)
lbu	$8,0($9)
subu	$15,$24,$15
sra	$15,$15,20
addu	$15,$15,$8
addu	$15,$2,$15
lbu	$15,0($15)
addu	$8,$9,$5
sb	$15,0($9)
lbu	$15,0($8)
subu	$3,$3,$10
sra	$3,$3,20
addu	$3,$3,$15
addu	$3,$2,$3
lbu	$9,0($3)
addu	$3,$8,$5
sb	$9,0($8)
lbu	$8,0($3)
subu	$13,$14,$13
sra	$13,$13,20
addu	$13,$13,$8
addu	$13,$2,$13
lbu	$9,0($13)
addu	$8,$3,$5
sb	$9,0($3)
lbu	$3,0($8)
subu	$11,$12,$11
sra	$11,$11,20
addu	$11,$11,$3
addu	$11,$2,$11
lbu	$3,0($11)
li	$14,458752			# 0x70000
sb	$3,0($8)
lh	$12,6($6)
ori	$14,$14,0xffe0
sll	$3,$12,14
lh	$6,32($7)
subu	$12,$3,$12
addu	$3,$12,$14
li	$14,-21407			# 0xffffffffffffac61
mul	$12,$6,$14
lh	$9,48($7)
li	$8,-22725			# 0xffffffffffffa73b
mul	$16,$9,$8
lh	$8,16($7)
addu	$14,$12,$3
li	$13,-12873			# 0xffffffffffffcdb7
li	$12,4520			# 0x11a8
mul	$17,$8,$12
mul	$13,$9,$13
li	$10,19266			# 0x4b42
li	$12,22725			# 0x58c5
li	$11,-4520			# 0xffffffffffffee58
mul	$11,$9,$11
addu	$13,$17,$13
mul	$17,$8,$12
mul	$12,$8,$10
mul	$9,$9,$10
li	$10,12873			# 0x3249
addu	$11,$12,$11
mul	$12,$8,$10
li	$10,21407			# 0x539f
addu	$8,$12,$16
mul	$12,$6,$10
li	$25,-8867			# 0xffffffffffffdd5d
addu	$10,$12,$3
li	$12,8867			# 0x22a3
mul	$16,$6,$12
lh	$15,64($7)
addu	$12,$16,$3
mul	$16,$6,$25
addiu	$24,$4,3
addu	$9,$17,$9
beq	$15,$0,$L27
addu	$3,$16,$3

sll	$6,$15,14
subu	$15,$6,$15
subu	$6,$0,$15
addu	$3,$3,$6
addu	$14,$14,$15
addu	$10,$10,$15
addu	$12,$12,$6
$L27:
lh	$6,80($7)
beq	$6,$0,$L28
nop

li	$15,19266			# 0x4b42
mul	$16,$6,$15
li	$15,12873			# 0x3249
addu	$13,$16,$13
mul	$16,$6,$15
li	$15,-22725			# 0xffffffffffffa73b
addu	$9,$16,$9
mul	$16,$6,$15
li	$15,4520			# 0x11a8
addu	$11,$16,$11
mul	$16,$6,$15
addu	$8,$16,$8
$L28:
lh	$6,96($7)
beq	$6,$0,$L29
nop

li	$15,-8867			# 0xffffffffffffdd5d
mul	$16,$6,$15
li	$15,8867			# 0x22a3
addu	$14,$16,$14
mul	$16,$6,$15
li	$15,-21407			# 0xffffffffffffac61
addu	$10,$16,$10
mul	$16,$6,$15
li	$15,21407			# 0x539f
addu	$12,$16,$12
mul	$16,$6,$15
addu	$3,$16,$3
$L29:
lh	$6,112($7)
beq	$6,$0,$L30
li	$7,-22725			# 0xffffffffffffa73b

mul	$15,$6,$7
li	$7,4520			# 0x11a8
addu	$13,$15,$13
mul	$15,$6,$7
li	$7,-12873			# 0xffffffffffffcdb7
addu	$9,$15,$9
mul	$15,$6,$7
li	$7,19266			# 0x4b42
addu	$11,$15,$11
mul	$15,$6,$7
addu	$8,$15,$8
$L30:
lbu	$7,3($4)
addu	$6,$9,$10
sra	$6,$6,20
addu	$6,$6,$7
addu	$6,$2,$6
lbu	$6,0($6)
addu	$7,$24,$5
sb	$6,3($4)
lbu	$6,0($7)
addu	$4,$11,$12
sra	$4,$4,20
addu	$4,$4,$6
addu	$4,$2,$4
lbu	$4,0($4)
addu	$6,$7,$5
sb	$4,0($7)
lbu	$7,0($6)
addu	$4,$8,$3
sra	$4,$4,20
addu	$4,$4,$7
addu	$4,$2,$4
lbu	$7,0($4)
addu	$4,$6,$5
sb	$7,0($6)
lbu	$7,0($4)
addu	$6,$13,$14
sra	$6,$6,20
addu	$6,$6,$7
addu	$6,$2,$6
lbu	$7,0($6)
addu	$6,$4,$5
sb	$7,0($4)
lbu	$4,0($6)
subu	$13,$14,$13
sra	$13,$13,20
addu	$13,$13,$4
addu	$13,$2,$13
lbu	$7,0($13)
addu	$4,$6,$5
sb	$7,0($6)
lbu	$7,0($4)
subu	$3,$3,$8
sra	$3,$3,20
addu	$3,$3,$7
addu	$3,$2,$3
lbu	$6,0($3)
addu	$3,$4,$5
sb	$6,0($4)
lbu	$4,0($3)
subu	$11,$12,$11
sra	$11,$11,20
addu	$11,$11,$4
addu	$11,$2,$11
lbu	$4,0($11)
addu	$5,$3,$5
sb	$4,0($3)
lbu	$3,0($5)
subu	$9,$10,$9
sra	$9,$9,20
addu	$9,$9,$3
addu	$2,$2,$9
lbu	$2,0($2)
sb	$2,0($5)
lw	$fp,116($sp)
lw	$23,112($sp)
lw	$22,108($sp)
lw	$21,104($sp)
lw	$20,100($sp)
lw	$19,96($sp)
lw	$18,92($sp)
lw	$17,88($sp)
lw	$16,84($sp)
j	$31
addiu	$sp,$sp,120

.set	macro
.set	reorder
.end	simple_idct48_add
.size	simple_idct48_add, .-simple_idct48_add
.align	2
.globl	disable_jz4740_mxu
.set	nomips16
.ent	disable_jz4740_mxu
.type	disable_jz4740_mxu, @function
disable_jz4740_mxu:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
.mask	0x00000000,0
.fmask	0x00000000,0
#APP
# 909 "simple_idct.c" 1
.word	0b01110000000001000000010000101111	#S32I2M XR16,$4
# 0 "" 2
#NO_APP
.set	noreorder
.set	nomacro
j	$31
move	$2,$0
.set	macro
.set	reorder

.end	disable_jz4740_mxu
.size	disable_jz4740_mxu, .-disable_jz4740_mxu
.align	2
.globl	enable_jz4740_mxu
.set	nomips16
.ent	enable_jz4740_mxu
.type	enable_jz4740_mxu, @function
enable_jz4740_mxu:
.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
.mask	0x00000000,0
.fmask	0x00000000,0
#APP
# 916 "simple_idct.c" 1
.word	0b01110000000000100000010000101110	#S32M2I XR16, $2
# 0 "" 2
#NO_APP
ori	$3,$2,0x7
#APP
# 918 "simple_idct.c" 1
.word	0b01110000000000110000010000101111	#S32I2M XR16,$3
# 0 "" 2
#NO_APP
j	$31
.end	enable_jz4740_mxu
.size	enable_jz4740_mxu, .-enable_jz4740_mxu
.align	2
.globl	simple_idct248_put
.set	nomips16
.ent	simple_idct248_put
.type	simple_idct248_put, @function
simple_idct248_put:
.frame	$sp,80,$31		# vars= 32, regs= 9/0, args= 0, gp= 8
.mask	0x40ff0000,-4
.fmask	0x00000000,0
.set	noreorder
.set	nomacro

lui	$28,%hi(__gnu_local_gp)
addiu	$sp,$sp,-80
addiu	$28,$28,%lo(__gnu_local_gp)
sw	$fp,76($sp)
sw	$23,72($sp)
sw	$22,68($sp)
sw	$21,64($sp)
sw	$20,60($sp)
sw	$19,56($sp)
sw	$18,52($sp)
sw	$17,48($sp)
sw	$16,44($sp)
.cprestore	0
lhu	$11,8($6)
lhu	$12,24($6)
lhu	$19,32($6)
lhu	$8,28($6)
lhu	$7,12($6)
sw	$19,20($sp)
subu	$19,$11,$12
lhu	$18,16($6)
lhu	$16,18($6)
lhu	$24,20($6)
lhu	$14,22($6)
lhu	$17,0($6)
lhu	$25,2($6)
lhu	$15,4($6)
lhu	$13,6($6)
lhu	$20,48($6)
sw	$19,24($sp)
lhu	$10,26($6)
lhu	$3,30($6)
subu	$19,$7,$8
lhu	$9,10($6)
lhu	$2,14($6)
addu	$7,$8,$7
lw	$8,24($sp)
subu	$23,$17,$18
subu	$22,$25,$16
subu	$21,$15,$24
sw	$20,16($sp)
addu	$17,$18,$17
subu	$20,$13,$14
addu	$25,$16,$25
addu	$15,$24,$15
addu	$13,$14,$13
addu	$11,$12,$11
subu	$fp,$9,$10
lw	$24,16($sp)
addu	$9,$10,$9
sw	$19,8($sp)
sh	$17,0($6)
subu	$19,$2,$3
sh	$23,16($6)
addu	$2,$3,$2
sh	$25,2($6)
lw	$3,20($sp)
sh	$22,18($6)
sh	$15,4($6)
sh	$21,20($6)
sh	$13,6($6)
sh	$20,22($6)
sh	$11,8($6)
sh	$8,24($6)
lw	$10,8($sp)
lhu	$14,56($6)
lhu	$13,40($6)
sh	$19,30($6)
lhu	$19,66($6)
sh	$9,10($6)
sh	$10,28($6)
lhu	$9,44($6)
lhu	$10,60($6)
addu	$12,$24,$3
lhu	$8,62($6)
lhu	$24,54($6)
lw	$21,20($sp)
lw	$22,16($sp)
lhu	$15,38($6)
sw	$19,12($sp)
lhu	$20,82($6)
subu	$19,$13,$14
sh	$7,12($6)
lhu	$7,46($6)
lhu	$18,50($6)
lhu	$16,52($6)
lhu	$3,80($6)
lhu	$17,34($6)
lhu	$25,36($6)
sh	$2,14($6)
sw	$19,32($sp)
lhu	$2,64($6)
subu	$19,$9,$10
subu	$23,$21,$22
lhu	$11,42($6)
sw	$20,8($sp)
sh	$12,32($6)
subu	$20,$15,$24
lhu	$12,58($6)
addu	$15,$24,$15
sw	$19,16($sp)
subu	$19,$7,$8
subu	$22,$17,$18
subu	$21,$25,$16
addu	$17,$18,$17
lw	$24,8($sp)
sh	$fp,26($6)
sw	$19,20($sp)
subu	$19,$2,$3
addu	$2,$3,$2
lw	$3,12($sp)
sh	$23,48($6)
sh	$15,38($6)
lw	$15,20($sp)
subu	$fp,$11,$12
lhu	$18,86($6)
addu	$11,$12,$11
sh	$17,34($6)
sh	$22,50($6)
lhu	$17,70($6)
lw	$22,8($sp)
sh	$21,52($6)
lw	$21,12($sp)
addu	$13,$14,$13
addu	$9,$10,$9
addu	$7,$8,$7
addu	$10,$24,$3
lw	$8,32($sp)
lhu	$24,90($6)
sh	$11,42($6)
sh	$15,62($6)
lw	$11,16($sp)
lhu	$15,74($6)
lhu	$14,92($6)
addu	$25,$16,$25
subu	$23,$21,$22
sh	$13,40($6)
subu	$21,$17,$18
lhu	$13,76($6)
lhu	$16,88($6)
lhu	$12,94($6)
lhu	$3,100($6)
sh	$25,36($6)
sh	$20,54($6)
lhu	$25,72($6)
lhu	$20,84($6)
sh	$8,56($6)
sh	$fp,58($6)
lhu	$8,114($6)
sh	$9,44($6)
sh	$11,60($6)
lhu	$9,96($6)
lhu	$11,78($6)
sh	$7,46($6)
sh	$2,64($6)
lhu	$7,98($6)
lhu	$2,116($6)
sh	$19,80($6)
sh	$10,66($6)
lhu	$19,68($6)
lhu	$10,112($6)
sw	$21,32($sp)
subu	$21,$15,$24
sw	$21,8($sp)
subu	$21,$13,$14
sw	$21,12($sp)
subu	$21,$11,$12
sw	$21,16($sp)
subu	$21,$9,$10
sw	$21,20($sp)
addu	$15,$24,$15
subu	$21,$7,$8
addu	$9,$10,$9
addu	$7,$8,$7
lw	$24,8($sp)
lw	$8,16($sp)
lw	$10,20($sp)
subu	$fp,$25,$16
addu	$13,$14,$13
addu	$25,$16,$25
addu	$11,$12,$11
addu	$12,$2,$3
subu	$22,$19,$20
lhu	$14,120($6)
sh	$25,72($6)
sh	$15,74($6)
lw	$25,12($sp)
lhu	$15,102($6)
sh	$24,90($6)
sh	$13,76($6)
lhu	$24,118($6)
lhu	$13,104($6)
sh	$11,78($6)
sh	$8,94($6)
lhu	$11,106($6)
lhu	$8,126($6)
sh	$9,96($6)
sh	$10,112($6)
lhu	$9,108($6)
lhu	$10,124($6)
sh	$7,98($6)
sh	$12,100($6)
lhu	$7,110($6)
lhu	$12,122($6)
addu	$17,$18,$17
addu	$19,$20,$19
sh	$22,84($6)
lw	$22,32($sp)
subu	$2,$3,$2
subu	$18,$13,$14
sh	$19,68($6)
sh	$17,70($6)
subu	$19,$15,$24
sh	$25,92($6)
subu	$17,$11,$12
subu	$25,$7,$8
subu	$16,$9,$10
addu	$7,$8,$7
addu	$15,$24,$15
addu	$13,$14,$13
addu	$11,$12,$11
addu	$9,$10,$9
sh	$21,114($6)
sh	$23,82($6)
sh	$22,86($6)
sh	$fp,88($6)
addiu	$3,$6,12
sh	$2,116($6)
addiu	$8,$6,10
sh	$19,118($6)
sh	$18,120($6)
sh	$7,110($6)
sh	$25,126($6)
sw	$5,84($sp)
sh	$15,102($6)
sh	$13,104($6)
sh	$11,106($6)
sh	$17,122($6)
sh	$9,108($6)
sh	$16,124($6)
addiu	$2,$6,8
addiu	$7,$6,14
move	$5,$0
li	$25,19266			# 0x4b42
li	$19,-22725			# 0xffffffffffffa73b
li	$18,4520			# 0x11a8
li	$21,8			# 0x8
sw	$4,12($sp)
b	$L41
sw	$6,16($sp)

$L47:
lw	$4,-4($2)
bne	$4,$0,$L37
nop

bne	$17,$0,$L37
nop

bne	$15,$0,$L37
nop

lh	$4,-8($2)
addiu	$5,$5,1
sll	$4,$4,3
andi	$4,$4,0xffff
sll	$6,$4,16
addu	$4,$6,$4
sw	$4,0($3)
addiu	$8,$8,16
sw	$4,-8($2)
sw	$4,0($2)
sw	$4,-4($2)
addiu	$3,$3,16
addiu	$2,$2,16
beq	$5,$21,$L46
addiu	$7,$7,16

$L41:
lw	$16,0($2)
lw	$17,0($3)
beq	$16,$0,$L47
lh	$15,-6($2)

$L37:
lh	$24,-8($2)
lh	$10,-2($2)
li	$4,-12873			# 0xffffffffffffcdb7
sll	$9,$24,14
mul	$6,$10,$4
subu	$9,$9,$24
li	$4,-4520			# 0xffffffffffffee58
lh	$24,-4($2)
mul	$12,$10,$4
mul	$13,$10,$19
mul	$14,$10,$25
li	$10,-21407			# 0xffffffffffffac61
mul	$11,$24,$10
mul	$10,$15,$18
addiu	$9,$9,1024
addu	$6,$10,$6
li	$10,22725			# 0x58c5
addu	$4,$11,$9
mul	$11,$15,$10
mul	$10,$15,$25
addu	$14,$11,$14
li	$11,12873			# 0x3249
mul	$20,$15,$11
li	$11,21407			# 0x539f
mul	$15,$24,$11
addu	$12,$10,$12
addu	$10,$20,$13
addu	$13,$15,$9
li	$15,8867			# 0x22a3
mul	$20,$24,$15
li	$15,-8867			# 0xffffffffffffdd5d
addu	$11,$20,$9
mul	$20,$24,$15
bne	$17,$0,$L39
addu	$9,$20,$9

beq	$16,$0,$L48
subu	$17,$13,$14

$L39:
lh	$24,0($8)
li	$16,12873			# 0x3249
mul	$23,$24,$16
mul	$16,$24,$18
lh	$15,0($2)
sw	$16,24($sp)
sll	$16,$15,14
subu	$16,$16,$15
subu	$17,$0,$16
lh	$15,0($3)
sw	$17,8($sp)
li	$17,-8867			# 0xffffffffffffdd5d
mul	$22,$15,$17
mul	$fp,$24,$25
mul	$20,$24,$19
lh	$24,0($7)
addu	$17,$22,$16
sw	$17,20($sp)
mul	$17,$24,$19
lw	$22,20($sp)
addu	$fp,$17,$fp
lw	$17,8($sp)
addu	$4,$4,$22
mtlo	$17
li	$17,21407			# 0x539f
madd	$15,$17
addu	$6,$6,$fp
mflo	$17
sw	$17,20($sp)
mul	$17,$24,$18
lw	$22,20($sp)
addu	$23,$17,$23
li	$17,-12873			# 0xffffffffffffcdb7
addu	$9,$9,$22
mul	$22,$24,$17
lw	$17,24($sp)
addu	$20,$22,$20
mul	$22,$24,$25
addu	$12,$12,$20
addu	$24,$22,$17
li	$17,8867			# 0x22a3
mul	$20,$15,$17
li	$17,-21407			# 0xffffffffffffac61
mul	$22,$15,$17
addu	$16,$20,$16
lw	$20,8($sp)
addu	$14,$14,$23
addu	$15,$22,$20
addu	$10,$10,$24
addu	$13,$13,$16
addu	$11,$11,$15
subu	$17,$13,$14
$L48:
subu	$16,$11,$12
subu	$24,$9,$10
subu	$15,$4,$6
addu	$13,$14,$13
addu	$11,$12,$11
addu	$9,$10,$9
addu	$4,$6,$4
sra	$13,$13,11
sra	$17,$17,11
sra	$11,$11,11
sra	$16,$16,11
sra	$9,$9,11
sra	$24,$24,11
sra	$4,$4,11
sra	$15,$15,11
addiu	$5,$5,1
sh	$13,-8($2)
sh	$17,0($7)
sh	$11,-6($2)
addiu	$7,$7,16
sh	$16,0($3)
sh	$9,-4($2)
addiu	$3,$3,16
sh	$24,0($8)
sh	$4,-2($2)
sh	$15,0($2)
addiu	$8,$8,16
bne	$5,$21,$L41
addiu	$2,$2,16

$L46:
lw	$24,84($sp)
lw	$4,12($sp)
sll	$10,$24,2
sll	$11,$24,1
addu	$8,$10,$24
lw	$2,%got(ff_cropTbl)($28)
addu	$12,$11,$8
addu	$14,$10,$11
addu	$13,$11,$24
lw	$6,16($sp)
addu	$14,$4,$14
addu	$13,$4,$13
addu	$12,$4,$12
addiu	$2,$2,1024
addu	$11,$4,$11
addu	$10,$4,$10
addu	$9,$4,$24
addu	$8,$4,$8
move	$7,$0
li	$5,65536			# 0x10000
li	$3,1108			# 0x454
li	$20,2676			# 0xa74
li	$19,-2676			# 0xfffffffffffff58c
li	$21,8			# 0x8
$L42:
lh	$25,32($6)
lh	$17,96($6)
lh	$18,0($6)
lh	$16,64($6)
mul	$22,$17,$3
mul	$15,$25,$20
addu	$24,$16,$18
mul	$23,$25,$3
subu	$16,$18,$16
sll	$24,$24,11
mul	$18,$17,$19
addu	$24,$24,$5
addu	$15,$22,$15
addu	$22,$24,$15
sra	$17,$22,17
sll	$16,$16,11
addu	$25,$18,$23
addu	$16,$16,$5
addu	$17,$2,$17
lbu	$22,0($17)
addu	$17,$16,$25
addu	$18,$4,$7
sra	$17,$17,17
sb	$22,0($18)
addu	$17,$2,$17
lbu	$17,0($17)
subu	$25,$16,$25
sra	$25,$25,17
sb	$17,0($11)
addu	$25,$2,$25
lbu	$25,0($25)
subu	$15,$24,$15
sra	$15,$15,17
sb	$25,0($10)
addu	$15,$2,$15
lbu	$15,0($15)
addiu	$7,$7,1
sb	$15,0($14)
lh	$25,48($6)
lh	$17,112($6)
lh	$18,16($6)
lh	$16,80($6)
mul	$22,$17,$3
mul	$15,$25,$20
addu	$24,$16,$18
mul	$23,$25,$3
subu	$16,$18,$16
sll	$24,$24,11
mul	$18,$17,$19
addu	$15,$22,$15
addu	$24,$24,$5
addu	$22,$24,$15
sll	$16,$16,11
sra	$17,$22,17
addu	$25,$18,$23
addu	$16,$16,$5
addu	$17,$2,$17
lbu	$18,0($17)
addu	$17,$16,$25
sra	$17,$17,17
sb	$18,0($9)
addu	$17,$2,$17
lbu	$17,0($17)
subu	$25,$16,$25
sra	$25,$25,17
sb	$17,0($13)
addu	$25,$2,$25
lbu	$25,0($25)
subu	$15,$24,$15
sra	$15,$15,17
sb	$25,0($8)
addu	$15,$2,$15
lbu	$15,0($15)
addiu	$6,$6,2
sb	$15,0($12)
addiu	$11,$11,1
addiu	$10,$10,1
addiu	$14,$14,1
addiu	$9,$9,1
addiu	$13,$13,1
addiu	$8,$8,1
bne	$7,$21,$L42
addiu	$12,$12,1

lw	$fp,76($sp)
lw	$23,72($sp)
lw	$22,68($sp)
lw	$21,64($sp)
lw	$20,60($sp)
lw	$19,56($sp)
lw	$18,52($sp)
lw	$17,48($sp)
lw	$16,44($sp)
j	$31
addiu	$sp,$sp,80

.set	macro
.set	reorder
.end	simple_idct248_put
.size	simple_idct248_put, .-simple_idct248_put
.align	2
.globl	simple_idct84_add
.set	nomips16
.ent	simple_idct84_add
.type	simple_idct84_add, @function
simple_idct84_add:
.frame	$sp,72,$31		# vars= 24, regs= 9/0, args= 0, gp= 8
.mask	0x40ff0000,-4
.fmask	0x00000000,0
.set	noreorder
.set	nomacro

lui	$28,%hi(__gnu_local_gp)
addiu	$sp,$sp,-72
addiu	$28,$28,%lo(__gnu_local_gp)
sw	$fp,68($sp)
sw	$23,64($sp)
sw	$22,60($sp)
sw	$21,56($sp)
sw	$20,52($sp)
sw	$19,48($sp)
sw	$18,44($sp)
sw	$17,40($sp)
sw	$16,36($sp)
.cprestore	0
lw	$2,8($6)
lw	$9,12($6)
addiu	$10,$6,2
bne	$2,$0,$L73
lh	$3,2($6)

lw	$7,4($6)
beq	$7,$0,$L79
nop

$L73:
lh	$8,6($6)
lh	$7,0($6)
li	$24,19266			# 0x4b42
li	$12,-22725			# 0xffffffffffffa73b
li	$11,-12873			# 0xffffffffffffcdb7
li	$13,-4520			# 0xffffffffffffee58
mul	$16,$8,$12
mul	$11,$8,$11
mul	$12,$8,$24
mul	$13,$8,$13
sll	$8,$7,14
subu	$7,$8,$7
lh	$8,4($6)
li	$15,-21407			# 0xffffffffffffac61
mul	$14,$8,$15
addiu	$7,$7,1024
addu	$15,$14,$7
li	$14,4520			# 0x11a8
mul	$17,$3,$14
li	$14,22725			# 0x58c5
addu	$11,$17,$11
mul	$17,$3,$14
li	$25,8867			# 0x22a3
addu	$14,$17,$12
mul	$12,$3,$24
li	$24,-8867			# 0xffffffffffffdd5d
addu	$13,$12,$13
li	$12,12873			# 0x3249
mul	$17,$3,$12
addu	$12,$17,$16
li	$16,21407			# 0x539f
mul	$3,$8,$16
addu	$16,$3,$7
mul	$3,$8,$25
addu	$25,$3,$7
mul	$3,$8,$24
beq	$9,$0,$L80
addu	$24,$3,$7

$L52:
lh	$3,10($6)
li	$17,4520			# 0x11a8
mul	$2,$3,$17
lh	$7,8($6)
li	$19,-22725			# 0xffffffffffffa73b
li	$8,19266			# 0x4b42
sw	$2,8($sp)
li	$20,12873			# 0x3249
sll	$2,$7,14
mul	$21,$3,$8
mul	$22,$3,$19
subu	$7,$2,$7
mul	$20,$3,$20
lh	$2,14($6)
lh	$3,12($6)
li	$23,-8867			# 0xffffffffffffdd5d
mul	$9,$3,$23
mul	$fp,$2,$19
addu	$23,$9,$7
addu	$19,$fp,$21
li	$21,21407			# 0x539f
addu	$15,$15,$23
mul	$23,$3,$21
subu	$18,$0,$7
addu	$11,$11,$19
li	$19,-12873			# 0xffffffffffffcdb7
addu	$21,$23,$18
mul	$23,$2,$19
addu	$24,$24,$21
li	$21,8867			# 0x22a3
addu	$19,$23,$22
mul	$22,$3,$21
addu	$13,$13,$19
addu	$7,$22,$7
li	$19,-21407			# 0xffffffffffffac61
addu	$16,$16,$7
mul	$7,$2,$17
mul	$21,$3,$19
addu	$17,$7,$20
mul	$7,$2,$8
addu	$3,$21,$18
addu	$25,$25,$3
lw	$3,8($sp)
addiu	$9,$6,8
addu	$2,$7,$3
addu	$14,$14,$17
addu	$12,$12,$2
addiu	$7,$6,12
addiu	$8,$6,10
addiu	$3,$6,14
$L55:
subu	$19,$16,$14
subu	$18,$25,$13
subu	$17,$24,$12
subu	$2,$15,$11
addu	$14,$14,$16
addu	$13,$13,$25
addu	$12,$12,$24
addu	$11,$11,$15
sra	$14,$14,11
sra	$19,$19,11
sra	$13,$13,11
sra	$18,$18,11
sra	$12,$12,11
sra	$17,$17,11
sra	$11,$11,11
sra	$2,$2,11
sh	$14,0($6)
sh	$19,0($3)
sh	$13,2($6)
sh	$18,0($7)
sh	$12,4($6)
sh	$17,0($8)
sh	$11,6($6)
sh	$2,0($9)
$L54:
lw	$19,24($6)
addiu	$2,$6,16
lw	$20,28($6)
bne	$19,$0,$L74
lh	$25,18($6)

lw	$11,20($6)
bne	$11,$0,$L74
nop

beq	$20,$0,$L81
nop

$L74:
lh	$15,16($6)
lh	$14,6($2)
lh	$18,4($2)
sll	$17,$15,14
li	$12,-22725			# 0xffffffffffffa73b
subu	$17,$17,$15
li	$15,-21407			# 0xffffffffffffac61
mul	$21,$14,$12
mul	$12,$18,$15
addiu	$17,$17,1024
li	$11,-12873			# 0xffffffffffffcdb7
addu	$15,$12,$17
li	$12,4520			# 0x11a8
mul	$22,$25,$12
mul	$11,$14,$11
li	$16,19266			# 0x4b42
li	$12,22725			# 0x58c5
li	$13,-4520			# 0xffffffffffffee58
mul	$13,$14,$13
addu	$11,$22,$11
mul	$22,$25,$12
mul	$12,$25,$16
mul	$14,$14,$16
addu	$13,$12,$13
li	$12,12873			# 0x3249
mul	$16,$25,$12
li	$25,8867			# 0x22a3
addu	$12,$16,$21
li	$16,21407			# 0x539f
mul	$21,$18,$16
li	$24,-8867			# 0xffffffffffffdd5d
addu	$16,$21,$17
mul	$21,$18,$25
addu	$14,$22,$14
addu	$25,$21,$17
mul	$21,$18,$24
bne	$20,$0,$L58
addu	$24,$21,$17

bne	$19,$0,$L58
nop

addiu	$23,$2,12
addiu	$22,$2,10
addiu	$21,$2,14
addiu	$19,$2,8
$L61:
subu	$fp,$16,$14
subu	$20,$25,$13
subu	$18,$24,$12
subu	$17,$15,$11
addu	$14,$14,$16
addu	$13,$13,$25
addu	$12,$12,$24
addu	$11,$11,$15
sra	$14,$14,11
sra	$fp,$fp,11
sra	$13,$13,11
sra	$20,$20,11
sra	$12,$12,11
sra	$18,$18,11
sra	$11,$11,11
sra	$17,$17,11
sh	$14,16($6)
sh	$fp,0($21)
sh	$13,18($6)
sh	$20,0($23)
sh	$12,4($2)
sh	$18,0($22)
sh	$11,6($2)
sh	$17,0($19)
$L60:
lw	$19,40($6)
addiu	$2,$6,32
lw	$20,44($6)
bne	$19,$0,$L75
lh	$25,34($6)

lw	$11,36($6)
bne	$11,$0,$L75
nop

beq	$20,$0,$L82
nop

$L75:
lh	$15,32($6)
lh	$14,6($2)
lh	$18,4($2)
sll	$17,$15,14
li	$12,-22725			# 0xffffffffffffa73b
subu	$17,$17,$15
li	$15,-21407			# 0xffffffffffffac61
mul	$21,$14,$12
mul	$12,$18,$15
addiu	$17,$17,1024
li	$11,-12873			# 0xffffffffffffcdb7
addu	$15,$12,$17
li	$12,4520			# 0x11a8
mul	$22,$25,$12
mul	$11,$14,$11
li	$16,19266			# 0x4b42
li	$12,22725			# 0x58c5
li	$13,-4520			# 0xffffffffffffee58
mul	$13,$14,$13
addu	$11,$22,$11
mul	$22,$25,$12
mul	$12,$25,$16
mul	$14,$14,$16
addu	$13,$12,$13
li	$12,12873			# 0x3249
mul	$16,$25,$12
li	$25,8867			# 0x22a3
addu	$12,$16,$21
li	$16,21407			# 0x539f
mul	$21,$18,$16
li	$24,-8867			# 0xffffffffffffdd5d
addu	$16,$21,$17
mul	$21,$18,$25
addu	$14,$22,$14
addu	$25,$21,$17
mul	$21,$18,$24
bne	$20,$0,$L64
addu	$24,$21,$17

bne	$19,$0,$L64
nop

addiu	$23,$2,12
addiu	$22,$2,10
addiu	$21,$2,14
addiu	$19,$2,8
$L67:
subu	$fp,$16,$14
subu	$20,$25,$13
subu	$18,$24,$12
subu	$17,$15,$11
addu	$14,$14,$16
addu	$13,$13,$25
addu	$12,$12,$24
addu	$11,$11,$15
sra	$14,$14,11
sra	$fp,$fp,11
sra	$13,$13,11
sra	$20,$20,11
sra	$12,$12,11
sra	$18,$18,11
sra	$11,$11,11
sra	$17,$17,11
sh	$14,32($6)
sh	$fp,0($21)
sh	$13,34($6)
sh	$20,0($23)
sh	$12,4($2)
sh	$18,0($22)
sh	$11,6($2)
sh	$17,0($19)
$L66:
lw	$20,56($6)
addiu	$2,$6,48
lw	$21,60($6)
bne	$20,$0,$L68
lh	$17,50($6)

lw	$11,52($6)
bne	$11,$0,$L68
nop

beq	$21,$0,$L83
nop

$L68:
lh	$18,48($6)
lh	$19,4($2)
sll	$13,$18,14
li	$11,-21407			# 0xffffffffffffac61
subu	$18,$13,$18
mul	$13,$19,$11
lh	$16,6($2)
addiu	$18,$18,1024
li	$15,19266			# 0x4b42
li	$14,-22725			# 0xffffffffffffa73b
li	$25,22725			# 0x58c5
li	$12,-12873			# 0xffffffffffffcdb7
li	$24,-4520			# 0xffffffffffffee58
addu	$11,$13,$18
li	$13,4520			# 0x11a8
mul	$22,$16,$14
mul	$12,$16,$12
mul	$14,$17,$13
mul	$24,$16,$24
mul	$13,$17,$25
mul	$16,$16,$15
addu	$12,$14,$12
addu	$16,$13,$16
mul	$13,$17,$15
li	$14,12873			# 0x3249
addu	$24,$13,$24
mul	$13,$17,$14
li	$25,21407			# 0x539f
addu	$14,$13,$22
mul	$13,$19,$25
li	$15,8867			# 0x22a3
addu	$25,$13,$18
mul	$13,$19,$15
addu	$15,$13,$18
li	$13,-8867			# 0xffffffffffffdd5d
mul	$17,$19,$13
bne	$21,$0,$L70
addu	$13,$17,$18

bne	$20,$0,$L70
nop

addiu	$22,$2,12
addiu	$21,$2,10
addiu	$23,$2,14
addiu	$19,$2,8
$L71:
subu	$fp,$25,$16
subu	$20,$15,$24
subu	$18,$13,$14
subu	$17,$11,$12
addu	$25,$16,$25
addu	$15,$24,$15
addu	$13,$14,$13
addu	$11,$12,$11
sra	$15,$15,11
sra	$25,$25,11
sra	$fp,$fp,11
sra	$20,$20,11
sra	$13,$13,11
sra	$18,$18,11
sra	$11,$11,11
sra	$17,$17,11
sh	$25,48($6)
sh	$fp,0($23)
sh	$15,50($6)
sh	$20,0($22)
sh	$13,4($2)
sh	$18,0($21)
sh	$11,6($2)
sh	$17,0($19)
lh	$15,48($6)
$L69:
lh	$24,32($6)
lh	$18,0($6)
sll	$16,$15,8
sll	$2,$15,5
subu	$2,$16,$2
li	$12,2896			# 0xb50
addu	$17,$24,$18
sll	$16,$2,3
subu	$16,$16,$2
mul	$2,$17,$12
lh	$13,16($6)
li	$11,65536			# 0x10000
li	$14,3784			# 0xec8
addu	$17,$2,$11
mul	$2,$13,$14
subu	$16,$16,$15
addu	$16,$2,$16
lbu	$20,0($4)
sll	$2,$13,5
addu	$19,$17,$16
sll	$25,$13,8
subu	$25,$25,$2
sra	$19,$19,17
lw	$2,%got(ff_cropTbl)($28)
addu	$19,$19,$20
sll	$20,$25,3
addiu	$2,$2,1024
subu	$25,$20,$25
addu	$19,$2,$19
subu	$25,$25,$13
li	$13,-3784			# 0xfffffffffffff138
subu	$18,$18,$24
lbu	$24,0($19)
mul	$19,$15,$13
sb	$24,0($4)
addu	$15,$19,$25
mul	$19,$18,$12
addu	$25,$4,$5
addu	$18,$19,$11
addu	$24,$18,$15
lbu	$19,0($25)
sra	$24,$24,17
addu	$24,$24,$19
addu	$24,$2,$24
lbu	$19,0($24)
addu	$24,$25,$5
sb	$19,0($25)
lbu	$25,0($24)
subu	$15,$18,$15
sra	$15,$15,17
addu	$15,$15,$25
addu	$15,$2,$15
lbu	$25,0($15)
addu	$15,$24,$5
sb	$25,0($24)
lbu	$24,0($15)
subu	$16,$17,$16
sra	$16,$16,17
addu	$16,$16,$24
addu	$16,$2,$16
lbu	$24,0($16)
addiu	$25,$4,1
sb	$24,0($15)
lh	$15,48($10)
lh	$18,2($6)
sll	$24,$15,5
sll	$16,$15,8
subu	$16,$16,$24
lh	$24,32($10)
sll	$17,$16,3
subu	$16,$17,$16
addu	$17,$24,$18
mul	$19,$17,$12
lh	$10,16($10)
addu	$17,$19,$11
mul	$19,$10,$14
subu	$16,$16,$15
addu	$16,$19,$16
lbu	$21,1($4)
addu	$20,$17,$16
sra	$20,$20,17
sll	$22,$10,8
sll	$19,$10,5
addu	$20,$20,$21
subu	$19,$22,$19
addu	$20,$2,$20
subu	$24,$18,$24
sll	$21,$19,3
lbu	$18,0($20)
subu	$19,$21,$19
sb	$18,1($4)
subu	$10,$19,$10
mul	$18,$24,$12
mul	$19,$15,$13
addu	$25,$25,$5
addu	$15,$19,$10
addu	$10,$18,$11
addu	$24,$10,$15
lbu	$18,0($25)
sra	$24,$24,17
addu	$24,$24,$18
addu	$24,$2,$24
lbu	$18,0($24)
addu	$24,$25,$5
sb	$18,0($25)
lbu	$25,0($24)
subu	$10,$10,$15
sra	$10,$10,17
addu	$10,$10,$25
addu	$10,$2,$10
lbu	$15,0($10)
addu	$10,$24,$5
sb	$15,0($24)
lbu	$15,0($10)
subu	$16,$17,$16
sra	$16,$16,17
addu	$16,$16,$15
addu	$16,$2,$16
lbu	$24,0($16)
addiu	$15,$6,4
sb	$24,0($10)
lh	$10,48($15)
lh	$25,4($6)
sll	$24,$10,5
sll	$16,$10,8
subu	$16,$16,$24
lh	$24,32($15)
sll	$17,$16,3
lh	$15,16($15)
subu	$16,$17,$16
addu	$17,$24,$25
mul	$19,$15,$14
mul	$18,$17,$12
subu	$16,$16,$10
addu	$17,$18,$11
addu	$16,$19,$16
sll	$18,$15,5
sll	$19,$15,8
subu	$18,$19,$18
lbu	$20,2($4)
addu	$19,$17,$16
sll	$21,$18,3
subu	$18,$21,$18
sra	$19,$19,17
addu	$19,$19,$20
subu	$24,$25,$24
subu	$15,$18,$15
mul	$18,$10,$13
addu	$25,$2,$19
mul	$19,$24,$12
addu	$10,$18,$15
lbu	$18,0($25)
addiu	$25,$4,2
addu	$15,$19,$11
addu	$25,$25,$5
sb	$18,2($4)
addu	$24,$15,$10
lbu	$18,0($25)
sra	$24,$24,17
addu	$24,$24,$18
addu	$24,$2,$24
lbu	$18,0($24)
addu	$24,$25,$5
sb	$18,0($25)
lbu	$25,0($24)
subu	$10,$15,$10
sra	$10,$10,17
addu	$10,$10,$25
addu	$10,$2,$10
lbu	$15,0($10)
addu	$10,$24,$5
sb	$15,0($24)
lbu	$15,0($10)
subu	$16,$17,$16
sra	$16,$16,17
addu	$16,$16,$15
addu	$16,$2,$16
lbu	$24,0($16)
addiu	$15,$6,6
sb	$24,0($10)
lh	$10,48($15)
lh	$25,6($6)
sll	$24,$10,5
sll	$16,$10,8
subu	$16,$16,$24
lh	$24,32($15)
sll	$17,$16,3
subu	$16,$17,$16
addu	$17,$24,$25
mul	$18,$17,$12
lh	$15,16($15)
addu	$17,$18,$11
mul	$18,$15,$14
subu	$16,$16,$10
addu	$16,$18,$16
lbu	$20,3($4)
sll	$21,$15,8
addu	$19,$17,$16
sll	$18,$15,5
subu	$18,$21,$18
sra	$19,$19,17
addu	$19,$19,$20
sll	$20,$18,3
subu	$18,$20,$18
subu	$15,$18,$15
mul	$18,$10,$13
subu	$24,$25,$24
addu	$10,$18,$15
mul	$18,$24,$12
addu	$19,$2,$19
lbu	$19,0($19)
addiu	$25,$4,3
sb	$19,3($4)
addu	$15,$18,$11
addu	$25,$25,$5
lbu	$18,0($25)
addu	$24,$15,$10
sra	$24,$24,17
addu	$24,$24,$18
addu	$24,$2,$24
lbu	$18,0($24)
addu	$24,$25,$5
sb	$18,0($25)
lbu	$25,0($24)
subu	$10,$15,$10
sra	$10,$10,17
addu	$10,$10,$25
addu	$10,$2,$10
lbu	$15,0($10)
addu	$10,$24,$5
sb	$15,0($24)
lbu	$15,0($10)
subu	$16,$17,$16
sra	$16,$16,17
addu	$16,$16,$15
addu	$16,$2,$16
lbu	$15,0($16)
addiu	$24,$4,4
sb	$15,0($10)
lh	$10,48($9)
lh	$17,8($6)
sll	$15,$10,5
sll	$25,$10,8
subu	$25,$25,$15
lh	$15,32($9)
sll	$16,$25,3
subu	$25,$16,$25
addu	$16,$15,$17
mul	$18,$16,$12
lh	$9,16($9)
addu	$16,$18,$11
mul	$18,$9,$14
subu	$25,$25,$10
addu	$25,$18,$25
lbu	$20,4($4)
addu	$19,$16,$25
sra	$19,$19,17
sll	$21,$9,8
sll	$18,$9,5
addu	$19,$19,$20
subu	$18,$21,$18
addu	$19,$2,$19
subu	$15,$17,$15
sll	$20,$18,3
lbu	$17,0($19)
subu	$18,$20,$18
sb	$17,4($4)
subu	$9,$18,$9
mul	$17,$15,$12
mul	$18,$10,$13
addu	$24,$24,$5
addu	$10,$18,$9
addu	$9,$17,$11
addu	$15,$9,$10
lbu	$17,0($24)
sra	$15,$15,17
addu	$15,$15,$17
addu	$15,$2,$15
lbu	$17,0($15)
addu	$15,$24,$5
sb	$17,0($24)
subu	$9,$9,$10
lbu	$24,0($15)
sra	$9,$9,17
addu	$9,$9,$24
addu	$9,$2,$9
lbu	$10,0($9)
addu	$9,$15,$5
sb	$10,0($15)
lbu	$10,0($9)
subu	$25,$16,$25
sra	$25,$25,17
addu	$25,$25,$10
addu	$25,$2,$25
lbu	$10,0($25)
addiu	$15,$4,5
sb	$10,0($9)
lh	$9,48($8)
lh	$16,10($6)
sll	$10,$9,5
sll	$24,$9,8
subu	$24,$24,$10
lh	$10,32($8)
sll	$25,$24,3
subu	$24,$25,$24
addu	$25,$10,$16
mul	$17,$25,$12
lh	$8,16($8)
addu	$25,$17,$11
mul	$17,$8,$14
subu	$24,$24,$9
addu	$24,$17,$24
lbu	$19,5($4)
addu	$18,$25,$24
sra	$18,$18,17
sll	$20,$8,8
sll	$17,$8,5
addu	$18,$18,$19
subu	$17,$20,$17
addu	$18,$2,$18
subu	$10,$16,$10
sll	$19,$17,3
lbu	$16,0($18)
subu	$17,$19,$17
sb	$16,5($4)
subu	$8,$17,$8
mul	$16,$10,$12
mul	$17,$9,$13
addu	$15,$15,$5
addu	$9,$17,$8
addu	$8,$16,$11
addu	$10,$8,$9
lbu	$16,0($15)
sra	$10,$10,17
addu	$10,$10,$16
addu	$10,$2,$10
lbu	$16,0($10)
addu	$10,$15,$5
sb	$16,0($15)
lbu	$15,0($10)
subu	$8,$8,$9
sra	$8,$8,17
addu	$8,$8,$15
addu	$8,$2,$8
lbu	$9,0($8)
addu	$8,$10,$5
sb	$9,0($10)
lbu	$9,0($8)
subu	$24,$25,$24
sra	$24,$24,17
addu	$24,$24,$9
addu	$24,$2,$24
lbu	$9,0($24)
addiu	$10,$4,6
sb	$9,0($8)
lh	$8,48($7)
lh	$25,12($6)
sll	$9,$8,5
sll	$15,$8,8
subu	$15,$15,$9
lh	$9,32($7)
sll	$24,$15,3
subu	$15,$24,$15
addu	$24,$9,$25
mul	$16,$24,$12
lh	$7,16($7)
addu	$24,$16,$11
mul	$16,$7,$14
subu	$15,$15,$8
addu	$15,$16,$15
lbu	$18,6($4)
sll	$19,$7,8
addu	$17,$24,$15
sll	$16,$7,5
subu	$16,$19,$16
sra	$17,$17,17
addu	$17,$17,$18
sll	$18,$16,3
subu	$16,$18,$16
subu	$7,$16,$7
mul	$16,$8,$13
subu	$9,$25,$9
addu	$8,$16,$7
mul	$16,$9,$12
addu	$17,$2,$17
lbu	$25,0($17)
addu	$10,$10,$5
sb	$25,6($4)
addu	$7,$16,$11
lbu	$25,0($10)
addu	$9,$7,$8
sra	$9,$9,17
addu	$9,$9,$25
addu	$9,$2,$9
lbu	$25,0($9)
addu	$9,$10,$5
sb	$25,0($10)
lbu	$10,0($9)
subu	$7,$7,$8
sra	$7,$7,17
addu	$7,$7,$10
addu	$7,$2,$7
lbu	$8,0($7)
addu	$7,$9,$5
sb	$8,0($9)
subu	$15,$24,$15
lbu	$8,0($7)
sra	$15,$15,17
addu	$15,$15,$8
addu	$15,$2,$15
lbu	$8,0($15)
addiu	$24,$4,7
sb	$8,0($7)
lh	$7,48($3)
lh	$9,32($3)
lh	$3,16($3)
lh	$10,14($6)
sll	$8,$7,8
sll	$6,$7,5
mul	$15,$3,$14
subu	$8,$8,$6
sll	$6,$8,3
subu	$8,$6,$8
subu	$6,$8,$7
addu	$8,$9,$10
addu	$14,$15,$6
mul	$6,$8,$12
lbu	$25,7($4)
addu	$8,$6,$11
addu	$6,$8,$14
sra	$6,$6,17
addu	$6,$6,$25
addu	$6,$2,$6
lbu	$6,0($6)
sll	$16,$3,8
sll	$15,$3,5
subu	$9,$10,$9
sb	$6,7($4)
subu	$15,$16,$15
mul	$4,$7,$13
mul	$10,$9,$12
sll	$25,$15,3
subu	$15,$25,$15
subu	$3,$15,$3
addu	$6,$24,$5
addu	$13,$4,$3
addu	$11,$10,$11
lbu	$4,0($6)
addu	$3,$11,$13
sra	$3,$3,17
addu	$3,$3,$4
addu	$3,$2,$3
lbu	$3,0($3)
addu	$4,$6,$5
sb	$3,0($6)
lbu	$6,0($4)
subu	$11,$11,$13
sra	$11,$11,17
addu	$11,$11,$6
addu	$11,$2,$11
lbu	$3,0($11)
addu	$5,$4,$5
sb	$3,0($4)
lbu	$3,0($5)
subu	$14,$8,$14
sra	$14,$14,17
addu	$14,$14,$3
addu	$2,$2,$14
lbu	$2,0($2)
sb	$2,0($5)
lw	$fp,68($sp)
lw	$23,64($sp)
lw	$22,60($sp)
lw	$21,56($sp)
lw	$20,52($sp)
lw	$19,48($sp)
lw	$18,44($sp)
lw	$17,40($sp)
lw	$16,36($sp)
j	$31
addiu	$sp,$sp,72

$L80:
bne	$2,$0,$L52
addiu	$7,$6,12

addiu	$8,$6,10
addiu	$3,$6,14
b	$L55
addiu	$9,$6,8

$L79:
bne	$9,$0,$L73
nop

bne	$3,$0,$L73
addiu	$7,$6,12

lh	$2,0($6)
addiu	$9,$6,8
sll	$2,$2,3
andi	$2,$2,0xffff
sll	$3,$2,16
addu	$2,$3,$2
sw	$2,0($6)
sw	$2,12($6)
sw	$2,8($6)
sw	$2,4($6)
addiu	$8,$6,10
b	$L54
addiu	$3,$6,14

$L58:
lh	$23,10($2)
li	$18,19266			# 0x4b42
mul	$fp,$23,$18
li	$18,4520			# 0x11a8
mul	$18,$23,$18
lh	$17,8($2)
sw	$18,20($sp)
sll	$20,$17,14
subu	$20,$20,$17
li	$18,-22725			# 0xffffffffffffa73b
li	$22,12873			# 0x3249
mul	$22,$23,$22
subu	$19,$0,$20
mul	$23,$23,$18
lh	$18,12($2)
sw	$19,12($sp)
mtlo	$20
li	$19,-8867			# 0xffffffffffffdd5d
lh	$17,14($2)
madd	$18,$19
sw	$20,24($sp)
li	$20,-22725			# 0xffffffffffffa73b
mflo	$19
mul	$21,$17,$20
sw	$19,8($sp)
addu	$20,$21,$fp
sw	$20,16($sp)
lw	$20,12($sp)
li	$21,21407			# 0x539f
mtlo	$20
madd	$18,$21
lw	$21,16($sp)
mflo	$20
lw	$fp,8($sp)
addu	$11,$11,$21
sw	$20,8($sp)
li	$21,-12873			# 0xffffffffffffcdb7
mul	$20,$17,$21
lw	$21,8($sp)
addu	$15,$15,$fp
addu	$24,$24,$21
li	$21,8867			# 0x22a3
mul	$fp,$18,$21
addu	$23,$20,$23
lw	$20,24($sp)
addu	$13,$13,$23
addu	$21,$fp,$20
li	$20,-21407			# 0xffffffffffffac61
mul	$fp,$18,$20
li	$20,4520			# 0x11a8
lw	$23,12($sp)
addu	$16,$16,$21
mul	$21,$17,$20
addu	$18,$fp,$23
addu	$25,$25,$18
li	$18,19266			# 0x4b42
addu	$22,$21,$22
mul	$21,$17,$18
lw	$20,20($sp)
addu	$14,$14,$22
addu	$17,$21,$20
addiu	$19,$2,8
addu	$12,$12,$17
addiu	$23,$2,12
addiu	$22,$2,10
b	$L61
addiu	$21,$2,14

$L64:
lh	$23,10($2)
li	$18,19266			# 0x4b42
mul	$fp,$23,$18
li	$18,4520			# 0x11a8
mul	$18,$23,$18
lh	$17,8($2)
sw	$18,20($sp)
sll	$20,$17,14
subu	$20,$20,$17
li	$18,-22725			# 0xffffffffffffa73b
li	$22,12873			# 0x3249
mul	$22,$23,$22
subu	$19,$0,$20
mul	$23,$23,$18
lh	$18,12($2)
sw	$19,12($sp)
mtlo	$20
li	$19,-8867			# 0xffffffffffffdd5d
lh	$17,14($2)
madd	$18,$19
sw	$20,24($sp)
li	$20,-22725			# 0xffffffffffffa73b
mflo	$19
mul	$21,$17,$20
sw	$19,8($sp)
addu	$20,$21,$fp
sw	$20,16($sp)
lw	$20,12($sp)
li	$21,21407			# 0x539f
mtlo	$20
madd	$18,$21
lw	$21,16($sp)
mflo	$20
lw	$fp,8($sp)
addu	$11,$11,$21
sw	$20,8($sp)
li	$21,-12873			# 0xffffffffffffcdb7
mul	$20,$17,$21
lw	$21,8($sp)
addu	$15,$15,$fp
addu	$24,$24,$21
li	$21,8867			# 0x22a3
mul	$fp,$18,$21
addu	$23,$20,$23
lw	$20,24($sp)
addu	$13,$13,$23
addu	$21,$fp,$20
li	$20,-21407			# 0xffffffffffffac61
mul	$fp,$18,$20
li	$20,4520			# 0x11a8
lw	$23,12($sp)
addu	$16,$16,$21
mul	$21,$17,$20
addu	$18,$fp,$23
addu	$25,$25,$18
li	$18,19266			# 0x4b42
addu	$22,$21,$22
mul	$21,$17,$18
lw	$20,20($sp)
addu	$14,$14,$22
addu	$17,$21,$20
addiu	$19,$2,8
addu	$12,$12,$17
addiu	$23,$2,12
addiu	$22,$2,10
b	$L67
addiu	$21,$2,14

$L70:
lh	$23,10($2)
li	$18,19266			# 0x4b42
mul	$fp,$23,$18
li	$18,4520			# 0x11a8
mul	$18,$23,$18
lh	$17,8($2)
sw	$18,20($sp)
sll	$20,$17,14
subu	$20,$20,$17
li	$18,-22725			# 0xffffffffffffa73b
li	$22,12873			# 0x3249
mul	$22,$23,$22
subu	$19,$0,$20
mul	$23,$23,$18
lh	$18,12($2)
sw	$19,12($sp)
mtlo	$20
li	$19,-8867			# 0xffffffffffffdd5d
lh	$17,14($2)
madd	$18,$19
sw	$20,24($sp)
li	$20,-22725			# 0xffffffffffffa73b
mflo	$19
mul	$21,$17,$20
sw	$19,8($sp)
addu	$20,$21,$fp
sw	$20,16($sp)
lw	$20,12($sp)
li	$21,21407			# 0x539f
mtlo	$20
madd	$18,$21
lw	$21,16($sp)
mflo	$20
lw	$fp,8($sp)
addu	$12,$12,$21
sw	$20,8($sp)
li	$21,-12873			# 0xffffffffffffcdb7
mul	$20,$17,$21
lw	$21,8($sp)
addu	$11,$11,$fp
addu	$13,$13,$21
li	$21,8867			# 0x22a3
mul	$fp,$18,$21
addu	$23,$20,$23
lw	$20,24($sp)
addu	$24,$24,$23
addu	$21,$fp,$20
li	$20,-21407			# 0xffffffffffffac61
mul	$fp,$18,$20
li	$20,4520			# 0x11a8
lw	$23,12($sp)
addu	$25,$25,$21
mul	$21,$17,$20
addu	$18,$fp,$23
addu	$15,$15,$18
li	$18,19266			# 0x4b42
addu	$22,$21,$22
mul	$21,$17,$18
lw	$20,20($sp)
addu	$16,$16,$22
addu	$17,$21,$20
addiu	$19,$2,8
addu	$14,$14,$17
addiu	$22,$2,12
addiu	$21,$2,10
b	$L71
addiu	$23,$2,14

$L83:
bne	$17,$0,$L68
nop

lh	$15,48($6)
sll	$2,$15,3
andi	$2,$2,0xffff
sll	$11,$2,16
addu	$2,$11,$2
sw	$2,48($6)
sw	$2,60($6)
sw	$2,56($6)
b	$L69
sw	$2,52($6)

$L82:
bne	$25,$0,$L75
nop

lh	$2,32($6)
sll	$2,$2,3
andi	$2,$2,0xffff
sll	$11,$2,16
addu	$2,$11,$2
sw	$2,32($6)
sw	$2,44($6)
sw	$2,40($6)
b	$L66
sw	$2,36($6)

$L81:
bne	$25,$0,$L74
nop

lh	$2,16($6)
sll	$2,$2,3
andi	$2,$2,0xffff
sll	$11,$2,16
addu	$2,$11,$2
sw	$2,16($6)
sw	$2,28($6)
sw	$2,24($6)
b	$L60
sw	$2,20($6)

.set	macro
.set	reorder
.end	simple_idct84_add
.size	simple_idct84_add, .-simple_idct84_add
.align	2
.globl	simple_idct
.set	nomips16
.ent	simple_idct
.type	simple_idct, @function
simple_idct:
.frame	$sp,72,$31		# vars= 24, regs= 9/0, args= 0, gp= 8
.mask	0x40ff0000,-4
.fmask	0x00000000,0
.set	noreorder
.set	nomacro

addiu	$sp,$sp,-72
sw	$20,52($sp)
sw	$18,44($sp)
sw	$17,40($sp)
sw	$fp,68($sp)
sw	$23,64($sp)
sw	$22,60($sp)
sw	$21,56($sp)
sw	$19,48($sp)
sw	$16,36($sp)
addiu	$2,$4,8
addiu	$3,$4,12
addiu	$7,$4,10
addiu	$6,$4,14
move	$5,$0
li	$24,19266			# 0x4b42
li	$18,-22725			# 0xffffffffffffa73b
li	$17,4520			# 0x11a8
li	$20,8			# 0x8
b	$L89
sw	$4,16($sp)

$L99:
lw	$4,-4($2)
bne	$4,$0,$L85
nop

bne	$19,$0,$L85
nop

bne	$15,$0,$L85
nop

lh	$4,-8($2)
addiu	$5,$5,1
sll	$4,$4,3
andi	$4,$4,0xffff
sll	$8,$4,16
addu	$4,$8,$4
sw	$4,0($3)
addiu	$7,$7,16
sw	$4,-8($2)
sw	$4,0($2)
sw	$4,-4($2)
addiu	$3,$3,16
addiu	$2,$2,16
beq	$5,$20,$L98
addiu	$6,$6,16

$L89:
lw	$16,0($2)
lw	$19,0($3)
beq	$16,$0,$L99
lh	$15,-6($2)

$L85:
lh	$25,-8($2)
lh	$10,-2($2)
li	$4,-12873			# 0xffffffffffffcdb7
sll	$9,$25,14
mul	$8,$10,$4
subu	$9,$9,$25
li	$4,-4520			# 0xffffffffffffee58
lh	$25,-4($2)
mul	$12,$10,$4
mul	$13,$10,$18
mul	$14,$10,$24
li	$10,-21407			# 0xffffffffffffac61
mul	$11,$25,$10
mul	$10,$15,$17
addiu	$9,$9,1024
addu	$8,$10,$8
li	$10,22725			# 0x58c5
addu	$4,$11,$9
mul	$11,$15,$10
mul	$10,$15,$24
addu	$14,$11,$14
li	$11,12873			# 0x3249
mul	$21,$15,$11
li	$11,21407			# 0x539f
mul	$15,$25,$11
addu	$12,$10,$12
addu	$10,$21,$13
addu	$13,$15,$9
li	$15,8867			# 0x22a3
mul	$21,$25,$15
li	$15,-8867			# 0xffffffffffffdd5d
addu	$11,$21,$9
mul	$21,$25,$15
bne	$19,$0,$L87
addu	$9,$21,$9

beq	$16,$0,$L100
subu	$19,$13,$14

$L87:
lh	$25,0($7)
li	$16,12873			# 0x3249
mul	$23,$25,$16
mul	$16,$25,$17
lh	$15,0($2)
sw	$16,28($sp)
sll	$16,$15,14
subu	$16,$16,$15
subu	$19,$0,$16
lh	$15,0($3)
sw	$19,24($sp)
li	$19,-8867			# 0xffffffffffffdd5d
mul	$21,$15,$19
mul	$fp,$25,$24
mul	$22,$25,$18
lh	$25,0($6)
addu	$19,$21,$16
mul	$21,$25,$18
sw	$19,12($sp)
addu	$19,$21,$fp
sw	$19,8($sp)
lw	$19,24($sp)
lw	$fp,12($sp)
mtlo	$19
li	$19,21407			# 0x539f
madd	$15,$19
lw	$21,8($sp)
mflo	$19
addu	$8,$8,$21
sw	$19,12($sp)
mul	$19,$25,$17
lw	$21,12($sp)
addu	$23,$19,$23
li	$19,-12873			# 0xffffffffffffcdb7
addu	$9,$9,$21
mul	$21,$25,$19
lw	$19,28($sp)
addu	$22,$21,$22
mul	$21,$25,$24
addu	$12,$12,$22
addu	$25,$21,$19
li	$19,8867			# 0x22a3
mul	$21,$15,$19
li	$19,-21407			# 0xffffffffffffac61
mul	$22,$15,$19
addu	$16,$21,$16
lw	$21,24($sp)
addu	$4,$4,$fp
addu	$15,$22,$21
addu	$14,$14,$23
addu	$10,$10,$25
addu	$13,$13,$16
addu	$11,$11,$15
subu	$19,$13,$14
$L100:
subu	$16,$11,$12
subu	$25,$9,$10
subu	$15,$4,$8
addu	$13,$14,$13
addu	$11,$12,$11
addu	$9,$10,$9
addu	$4,$8,$4
sra	$13,$13,11
sra	$19,$19,11
sra	$11,$11,11
sra	$16,$16,11
sra	$9,$9,11
sra	$25,$25,11
sra	$4,$4,11
sra	$15,$15,11
addiu	$5,$5,1
sh	$13,-8($2)
sh	$19,0($6)
sh	$11,-6($2)
addiu	$6,$6,16
sh	$16,0($3)
sh	$9,-4($2)
addiu	$3,$3,16
sh	$25,0($7)
sh	$4,-2($2)
sh	$15,0($2)
addiu	$7,$7,16
bne	$5,$20,$L89
addiu	$2,$2,16

$L98:
lw	$4,16($sp)
move	$14,$0
li	$22,21407			# 0x539f
li	$21,8867			# 0x22a3
li	$20,-8867			# 0xffffffffffffdd5d
li	$19,-21407			# 0xffffffffffffac61
li	$fp,22725			# 0x58c5
li	$13,19266			# 0x4b42
li	$18,12873			# 0x3249
li	$25,4520			# 0x11a8
li	$24,-22725			# 0xffffffffffffa73b
li	$17,-12873			# 0xffffffffffffcdb7
$L94:
lh	$11,0($4)
lh	$6,48($4)
sll	$5,$11,14
subu	$11,$5,$11
lh	$5,32($4)
li	$2,-4520			# 0xffffffffffffee58
mul	$8,$6,$2
mul	$23,$6,$24
mul	$3,$6,$17
mul	$10,$6,$13
mul	$6,$5,$19
li	$2,458752			# 0x70000
lh	$7,16($4)
ori	$2,$2,0xffe0
addu	$11,$11,$2
addu	$2,$6,$11
mul	$6,$7,$25
mul	$9,$7,$18
addu	$3,$6,$3
mul	$6,$7,$fp
lh	$12,64($4)
addu	$10,$6,$10
mul	$6,$7,$13
mul	$7,$5,$22
addu	$8,$6,$8
addu	$6,$9,$23
mul	$23,$5,$21
addu	$9,$7,$11
addu	$7,$23,$11
mul	$23,$5,$20
sll	$15,$12,14
subu	$15,$15,$12
addiu	$14,$14,1
subu	$16,$0,$15
beq	$12,$0,$L90
addu	$5,$23,$11

addu	$5,$5,$16
addu	$2,$2,$15
addu	$9,$9,$15
addu	$7,$7,$16
$L90:
lh	$11,80($4)
beq	$11,$0,$L91
mul	$12,$11,$13

addu	$3,$12,$3
mul	$12,$11,$18
addu	$10,$12,$10
mul	$12,$11,$24
addu	$8,$12,$8
mul	$12,$11,$25
addu	$6,$12,$6
$L91:
lh	$11,96($4)
beq	$11,$0,$L92
mul	$12,$11,$20

addu	$2,$12,$2
mul	$12,$11,$21
addu	$9,$12,$9
mul	$12,$11,$19
addu	$7,$12,$7
mul	$12,$11,$22
addu	$5,$12,$5
$L92:
lh	$11,112($4)
beq	$11,$0,$L101
subu	$15,$5,$6

mul	$12,$11,$24
addu	$3,$12,$3
mul	$12,$11,$25
addu	$10,$12,$10
mul	$12,$11,$17
addu	$8,$12,$8
mul	$12,$11,$13
addu	$6,$12,$6
subu	$15,$5,$6
$L101:
subu	$16,$2,$3
subu	$12,$7,$8
subu	$11,$9,$10
sra	$15,$15,20
addu	$9,$10,$9
addu	$7,$8,$7
addu	$5,$6,$5
addu	$2,$3,$2
sh	$15,80($4)
sra	$9,$9,20
sra	$7,$7,20
sra	$5,$5,20
sra	$2,$2,20
sra	$16,$16,20
sra	$12,$12,20
sra	$11,$11,20
li	$15,8			# 0x8
sh	$9,0($4)
sh	$7,16($4)
sh	$5,32($4)
sh	$2,48($4)
sh	$16,64($4)
sh	$12,96($4)
sh	$11,112($4)
bne	$14,$15,$L94
addiu	$4,$4,2

lw	$fp,68($sp)
lw	$23,64($sp)
lw	$22,60($sp)
lw	$21,56($sp)
lw	$20,52($sp)
lw	$19,48($sp)
lw	$18,44($sp)
lw	$17,40($sp)
lw	$16,36($sp)
j	$31
addiu	$sp,$sp,72

.set	macro
.set	reorder
.end	simple_idct
.size	simple_idct, .-simple_idct
.ident	"GCC: (GNU) 4.4.2"
