	.file	1 "h264.c"
	.section .mdebug.abi32
	.previous
	.gnu_attribute 4, 3
	.abicalls
	.text
	.align	2
	.set	nomips16
	.ent	get_bits
	.type	get_bits, @function
get_bits:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$3,8($4)
	lw	$6,0($4)
	sra	$2,$3,3
	addu	$2,$6,$2
	lbu	$6,0($2)
	lbu	$8,3($2)
	lbu	$7,1($2)
	sll	$6,$6,24
	lbu	$2,2($2)
	or	$6,$8,$6
	sll	$7,$7,16
	or	$6,$6,$7
	sll	$2,$2,8
	or	$6,$6,$2
	andi	$2,$3,0x7
	sll	$6,$6,$2
	addu	$3,$5,$3
	subu	$5,$0,$5
	sw	$3,8($4)
	j	$31
	srl	$2,$6,$5

	.set	macro
	.set	reorder
	.end	get_bits
	.size	get_bits, .-get_bits
	.align	2
	.set	nomips16
	.ent	get_cabac_noinline
	.type	get_cabac_noinline, @function
get_cabac_noinline:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$3,4($4)
	lui	$28,%hi(__gnu_local_gp)
	lbu	$6,0($5)
	addiu	$28,$28,%lo(__gnu_local_gp)
	andi	$2,$3,0xc0
	lw	$7,%got(ff_h264_lps_range)($28)
	sll	$2,$2,1
	addu	$2,$2,$6
	addu	$2,$7,$2
	lbu	$7,0($2)
	lw	$8,0($4)
	subu	$3,$3,$7
	sll	$9,$3,17
	subu	$2,$9,$8
	sra	$2,$2,31
	movn	$3,$7,$2
	sw	$3,4($4)
	and	$9,$2,$9
	lw	$3,%got(ff_h264_mlps_state)($28)
	subu	$8,$8,$9
	xor	$2,$2,$6
	sw	$8,0($4)
	addu	$3,$3,$2
	lbu	$3,128($3)
	lw	$7,%got(ff_h264_norm_shift)($28)
	sb	$3,0($5)
	lw	$6,4($4)
	lw	$3,0($4)
	addu	$5,$7,$6
	lbu	$5,0($5)
	sll	$3,$3,$5
	andi	$8,$3,0xffff
	sll	$5,$6,$5
	sw	$5,4($4)
	bne	$8,$0,$L4
	sw	$3,0($4)

	lw	$5,16($4)
	addiu	$6,$3,-1
	xor	$6,$6,$3
	lbu	$10,0($5)
	sra	$6,$6,15
	lbu	$9,1($5)
	addu	$7,$7,$6
	li	$6,-65536			# 0xffffffffffff0000
	lbu	$8,0($7)
	ori	$6,$6,0x1
	sll	$10,$10,9
	addu	$7,$10,$6
	sll	$9,$9,1
	li	$6,7			# 0x7
	addu	$7,$7,$9
	subu	$6,$6,$8
	sll	$6,$7,$6
	addu	$3,$6,$3
	addiu	$5,$5,2
	sw	$5,16($4)
	sw	$3,0($4)
$L4:
	j	$31
	andi	$2,$2,0x1

	.set	macro
	.set	reorder
	.end	get_cabac_noinline
	.size	get_cabac_noinline, .-get_cabac_noinline
	.align	2
	.set	nomips16
	.ent	get_ue_golomb
	.type	get_ue_golomb, @function
get_ue_golomb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$3,8($4)
	lw	$5,0($4)
	sra	$2,$3,3
	addu	$2,$5,$2
	lbu	$7,0($2)
	lbu	$6,1($2)
	lbu	$8,3($2)
	lbu	$5,2($2)
	sll	$7,$7,24
	or	$2,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$2,$2,$6
	or	$2,$2,$5
	andi	$5,$3,0x7
	sll	$2,$2,$5
	li	$5,134217728			# 0x8000000
	lui	$28,%hi(__gnu_local_gp)
	sltu	$5,$2,$5
	beq	$5,$0,$L15
	addiu	$28,$28,%lo(__gnu_local_gp)

	li	$5,-65536			# 0xffffffffffff0000
	and	$5,$2,$5
	bne	$5,$0,$L10
	srl	$5,$2,16

	move	$5,$2
	andi	$7,$5,0xff00
	li	$6,8			# 0x8
	bne	$7,$0,$L12
	move	$8,$0

$L16:
	lw	$7,%got(ff_log2_tab)($28)
	move	$6,$8
	addu	$5,$7,$5
	lbu	$5,0($5)
	addiu	$3,$3,32
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$3,$3,$5
	srl	$2,$2,$5
	sw	$3,8($4)
	j	$31
	addiu	$2,$2,-1

$L10:
	andi	$7,$5,0xff00
	li	$6,24			# 0x18
	beq	$7,$0,$L16
	li	$8,16			# 0x10

$L12:
	lw	$7,%got(ff_log2_tab)($28)
	srl	$5,$5,8
	addu	$5,$7,$5
	lbu	$5,0($5)
	addiu	$3,$3,32
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$3,$3,$5
	srl	$2,$2,$5
	sw	$3,8($4)
	j	$31
	addiu	$2,$2,-1

$L15:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$5,$5,$2
	lbu	$5,0($5)
	addu	$3,$5,$3
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$3,8($4)
	addu	$2,$5,$2
	j	$31
	lbu	$2,0($2)

	.set	macro
	.set	reorder
	.end	get_ue_golomb
	.size	get_ue_golomb, .-get_ue_golomb
	.align	2
	.set	nomips16
	.ent	get_se_golomb
	.type	get_se_golomb, @function
get_se_golomb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$3,8($4)
	lw	$5,0($4)
	sra	$2,$3,3
	addu	$2,$5,$2
	lbu	$7,0($2)
	lbu	$6,1($2)
	lbu	$8,3($2)
	lbu	$5,2($2)
	sll	$7,$7,24
	or	$2,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$2,$2,$6
	or	$2,$2,$5
	andi	$5,$3,0x7
	sll	$2,$2,$5
	li	$5,134217728			# 0x8000000
	lui	$28,%hi(__gnu_local_gp)
	sltu	$5,$2,$5
	beq	$5,$0,$L27
	addiu	$28,$28,%lo(__gnu_local_gp)

	li	$5,-65536			# 0xffffffffffff0000
	and	$5,$2,$5
	bne	$5,$0,$L20
	srl	$5,$2,16

	move	$5,$2
	andi	$7,$5,0xff00
	li	$6,8			# 0x8
	bne	$7,$0,$L22
	move	$8,$0

$L28:
	lw	$7,%got(ff_log2_tab)($28)
	move	$6,$8
	addu	$5,$7,$5
	lbu	$5,0($5)
	addiu	$3,$3,32
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	srl	$2,$2,$5
	andi	$6,$2,0x1
	subu	$5,$3,$5
	beq	$6,$0,$L24
	sw	$5,8($4)

$L29:
	srl	$2,$2,1
	j	$31
	subu	$2,$0,$2

$L20:
	andi	$7,$5,0xff00
	li	$6,24			# 0x18
	beq	$7,$0,$L28
	li	$8,16			# 0x10

$L22:
	lw	$7,%got(ff_log2_tab)($28)
	srl	$5,$5,8
	addu	$5,$7,$5
	lbu	$5,0($5)
	addiu	$3,$3,32
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	srl	$2,$2,$5
	andi	$6,$2,0x1
	subu	$5,$3,$5
	bne	$6,$0,$L29
	sw	$5,8($4)

$L24:
	j	$31
	srl	$2,$2,1

$L27:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$5,$5,$2
	lbu	$5,0($5)
	addu	$3,$5,$3
	lw	$5,%got(ff_se_golomb_vlc_code)($28)
	sw	$3,8($4)
	addu	$2,$5,$2
	j	$31
	lb	$2,0($2)

	.set	macro
	.set	reorder
	.end	get_se_golomb
	.size	get_se_golomb, .-get_se_golomb
	.align	2
	.set	nomips16
	.ent	fill_caches
	.type	fill_caches, @function
fill_caches:
	.frame	$sp,320,$31		# vars= 272, regs= 9/0, args= 0, gp= 8
	.mask	0x40ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$8,6172($4)
	lw	$7,152($4)
	lw	$9,6168($4)
	mul	$2,$7,$8
	addiu	$sp,$sp,-320
	sw	$fp,316($sp)
	sw	$23,312($sp)
	sw	$22,308($sp)
	sw	$21,304($sp)
	sw	$20,300($sp)
	sw	$19,296($sp)
	sw	$18,292($sp)
	sw	$17,288($sp)
	sw	$16,284($sp)
	bne	$6,$0,$L31
	addu	$13,$2,$9

	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$25,-6276($2)
	subu	$2,$13,$7
$L32:
	li	$10,1			# 0x1
	sw	$10,28($sp)
	li	$10,2			# 0x2
	sw	$10,32($sp)
	li	$10,3			# 0x3
	sw	$10,36($sp)
	li	$10,7			# 0x7
	sw	$10,40($sp)
	li	$10,10			# 0xa
	sw	$10,44($sp)
	li	$10,8			# 0x8
	addiu	$3,$13,-1
	sw	$10,48($sp)
	li	$10,11			# 0xb
	sw	$10,52($sp)
	sw	$3,8($sp)
	sw	$3,12($sp)
	sw	$0,24($sp)
	addiu	$12,$2,-1
	bne	$25,$0,$L35
	addiu	$11,$2,1

	li	$7,1			# 0x1
	li	$8,3			# 0x3
	li	$14,2			# 0x2
	sw	$0,160($sp)
	move	$10,$3
	sw	$7,164($sp)
	sw	$8,152($sp)
	sw	$14,156($sp)
	sw	$7,148($sp)
	li	$16,3			# 0x3
	li	$24,1			# 0x1
$L36:
	sw	$2,8764($4)
	sw	$10,8768($4)
	beq	$6,$0,$L52
	sw	$3,8772($4)

	li	$7,65536			# 0x10000
	addu	$7,$4,$7
	lw	$7,-6288($7)
	addu	$8,$7,$2
	lbu	$9,0($8)
	li	$8,255			# 0xff
	beq	$9,$8,$L210
	sll	$8,$2,2

	lw	$9,1568($4)
	addu	$8,$9,$8
	lw	$9,0($8)
	srl	$8,$9,24
	andi	$8,$8,0x1
	sw	$8,124($sp)
$L54:
	addu	$8,$7,$10
	lbu	$14,0($8)
	li	$8,255			# 0xff
	beq	$14,$8,$L56
	move	$8,$0

	lw	$14,1568($4)
	sll	$8,$10,2
	addu	$8,$14,$8
	lw	$8,0($8)
$L56:
	addu	$7,$7,$3
	lbu	$14,0($7)
	li	$7,255			# 0xff
	beq	$14,$7,$L212
	sll	$7,$3,2

	lw	$14,1568($4)
	addu	$7,$14,$7
	lw	$14,0($7)
$L58:
	li	$17,65536			# 0x10000
	addu	$17,$4,$17
	lw	$7,-6276($17)
	sw	$8,16($sp)
	bne	$7,$0,$L59
	sw	$14,20($sp)

	andi	$7,$5,0x7
	sw	$0,72($sp)
	bne	$7,$0,$L77
	sw	$0,80($sp)

	srl	$8,$9,24
$L251:
	andi	$8,$8,0x1
	sw	$8,124($sp)
	lw	$13,20($sp)
	lw	$8,16($sp)
$L78:
	beq	$9,$0,$L107
	sll	$15,$2,4

	lw	$17,9128($4)
	addu	$17,$17,$15
	lbu	$18,4($17)
	lw	$15,11808($4)
	sb	$18,9084($4)
	lbu	$18,5($17)
	sb	$18,9085($4)
	lbu	$18,6($17)
	sb	$18,9086($4)
	lbu	$18,3($17)
	sb	$18,9087($4)
	lbu	$18,9($17)
	sb	$18,9081($4)
	lbu	$18,8($17)
	sb	$18,9082($4)
	lbu	$18,12($17)
	sb	$18,9105($4)
	lbu	$17,11($17)
	sb	$17,9106($4)
$L108:
	beq	$7,$0,$L111
	nop

	beq	$8,$0,$L112
	li	$17,64			# 0x40

	lw	$17,8($sp)
	lw	$18,9128($4)
	sll	$17,$17,4
	addu	$17,$18,$17
	lw	$18,24($sp)
	addu	$18,$17,$18
	lbu	$19,0($18)
	lw	$18,28($sp)
	sb	$19,9091($4)
	addu	$18,$17,$18
	lbu	$19,0($18)
	lw	$18,40($sp)
	sb	$19,9099($4)
	addu	$18,$17,$18
	lbu	$19,0($18)
	lw	$18,44($sp)
	sb	$19,9088($4)
	addu	$17,$17,$18
	lbu	$17,0($17)
	sb	$17,9112($4)
$L113:
	bne	$13,$0,$L241
	lw	$13,12($sp)

	li	$13,64			# 0x40
	sb	$13,9107($4)
	sb	$13,9120($4)
	sb	$13,9096($4)
	sb	$13,9115($4)
$L115:
	beq	$15,$0,$L123
	nop

	beq	$9,$0,$L124
	li	$13,131072			# 0x20000

	addu	$13,$4,$13
	lw	$17,8660($13)
	sll	$15,$2,1
	addu	$15,$17,$15
	lhu	$15,0($15)
	sw	$15,8668($13)
$L125:
	beq	$8,$0,$L127
	nop

$L224:
	li	$7,131072			# 0x20000
	addu	$7,$4,$7
	lw	$15,8660($7)
	sll	$13,$10,1
	addu	$13,$15,$13
	lhu	$13,0($13)
	sra	$24,$13,$24
	andi	$24,$24,0x1
	sll	$24,$24,1
	andi	$13,$13,0x1f0
	or	$13,$24,$13
	sw	$13,8672($7)
$L128:
	beq	$14,$0,$L242
	andi	$7,$5,0x178

	li	$7,131072			# 0x20000
	addu	$7,$4,$7
	lw	$15,8660($7)
	sll	$13,$3,1
	addu	$13,$15,$13
	lhu	$13,0($13)
	lw	$15,8672($7)
	sra	$13,$13,$16
	andi	$13,$13,0x1
	sll	$13,$13,3
	or	$13,$13,$15
	sw	$13,8672($7)
$L123:
	andi	$7,$5,0x178
$L242:
	beq	$7,$0,$L130
	nop

	li	$15,65536			# 0x10000
	addu	$15,$4,$15
	lw	$18,5944($15)
	beq	$18,$0,$L130
	nop

	li	$7,131072			# 0x20000
	ori	$13,$7,0x233c
	ori	$22,$7,0x2226
	ori	$20,$7,0x2216
	addu	$13,$4,$13
	ori	$17,$7,0x220e
	sll	$11,$11,2
	addu	$22,$4,$22
	addu	$20,$4,$20
	ori	$fp,$7,0x2266
	ori	$23,$7,0x2246
	ori	$21,$7,0x221a
	ori	$19,$7,0x2212
	sw	$11,168($sp)
	sll	$3,$3,2
	sw	$22,104($sp)
	sw	$20,100($sp)
	addiu	$22,$13,12
	addu	$17,$4,$17
	addiu	$20,$4,9456
	li	$11,131072			# 0x20000
	ori	$16,$7,0x220a
	sll	$2,$2,2
	sw	$3,216($sp)
	addu	$fp,$4,$fp
	addu	$23,$4,$23
	addu	$21,$4,$21
	addu	$19,$4,$19
	sw	$17,76($sp)
	sw	$20,180($sp)
	sw	$22,228($sp)
	lw	$20,80($sp)
	lw	$22,72($sp)
	li	$3,131072			# 0x20000
	ori	$11,$11,0x2206
	li	$17,131072			# 0x20000
	ori	$24,$7,0x21f8
	sw	$2,132($sp)
	sw	$fp,112($sp)
	addiu	$2,$13,4
	addiu	$fp,$13,28
	sw	$23,108($sp)
	sw	$21,96($sp)
	addiu	$23,$13,20
	sw	$19,84($sp)
	addu	$16,$4,$16
	addu	$11,$4,$11
	ori	$17,$17,0x21ec
	addu	$7,$4,$7
	andi	$19,$5,0x100
	andi	$21,$5,0x900
	addiu	$13,$13,36
	ori	$3,$3,0x2286
	sll	$12,$12,2
	sll	$10,$10,2
	sw	$2,256($sp)
	addu	$3,$4,$3
	sw	$16,92($sp)
	sw	$11,88($sp)
	sw	$7,212($sp)
	sw	$19,136($sp)
	sw	$21,176($sp)
	sw	$13,240($sp)
	andi	$2,$9,0x100
	andi	$7,$9,0x40
	andi	$11,$8,0x100
	andi	$13,$8,0x40
	andi	$19,$14,0x40
	andi	$20,$20,0x80
	andi	$21,$9,0x80
	andi	$22,$22,0x80
	addu	$16,$4,$17
	andi	$17,$14,0x100
	sw	$12,172($sp)
	sw	$10,220($sp)
	sw	$3,116($sp)
	sw	$23,232($sp)
	sw	$fp,236($sp)
	sw	$2,252($sp)
	sw	$7,268($sp)
	sw	$11,248($sp)
	sw	$13,264($sp)
	sw	$17,244($sp)
	sw	$19,260($sp)
	sw	$20,208($sp)
	sw	$21,204($sp)
	andi	$23,$8,0x80
	sw	$22,200($sp)
	lw	$11,72($sp)
	lw	$22,80($sp)
	li	$20,-2			# 0xfffffffffffffffe
	sw	$23,196($sp)
	li	$7,-1			# 0xffffffffffffffff
	li	$21,-1			# 0xffffffffffffffff
	li	$23,-1			# 0xffffffffffffffff
	andi	$fp,$14,0x80
	movz	$7,$20,$11
	movz	$21,$20,$22
	movz	$23,$20,$8
	addu	$24,$4,$24
	addiu	$3,$4,9136
	sw	$fp,192($sp)
	move	$13,$4
	move	$10,$4
	move	$2,$4
	move	$19,$0
	move	$12,$0
	li	$17,-2			# 0xfffffffffffffffe
	sw	$7,184($sp)
	sw	$21,188($sp)
	sw	$23,144($sp)
	sw	$25,224($sp)
	sw	$14,276($sp)
	sw	$5,128($sp)
	sw	$6,140($sp)
$L193:
	sll	$6,$12,1
	li	$25,12288			# 0x3000
	lw	$fp,128($sp)
	sll	$6,$25,$6
	and	$5,$6,$fp
	bne	$5,$0,$L243
	and	$11,$6,$9

	lw	$5,136($sp)
	bne	$5,$0,$L243
	nop

	lw	$5,5340($15)
	beq	$5,$0,$L132
	nop

$L243:
	beq	$11,$0,$L133
	sw	$0,9536($10)

	lw	$14,132($sp)
	lw	$7,9740($4)
	lw	$5,9748($4)
	addu	$7,$7,$14
	lw	$7,0($7)
	sll	$21,$5,1
	addu	$21,$21,$5
	lw	$23,132($sp)
	addu	$21,$21,$7
	lw	$18,1560($10)
	sll	$7,$19,2
	lw	$22,9744($4)
	sll	$5,$21,2
	addu	$7,$7,$19
	addu	$5,$18,$5
	addiu	$20,$7,-1
	addu	$22,$22,$23
	lw	$fp,0($5)
	lw	$22,0($22)
	sll	$14,$20,5
	addiu	$25,$21,1
	addu	$14,$3,$14
	sll	$25,$25,2
	sw	$22,60($sp)
	addu	$25,$18,$25
	lw	$22,9752($4)
	sw	$fp,48($14)
	lw	$25,0($25)
	sw	$20,120($sp)
	sll	$5,$19,5
	sll	$20,$19,3
	addu	$5,$20,$5
	sw	$25,56($sp)
	addiu	$14,$5,5
	lw	$23,56($sp)
	addiu	$25,$21,2
	sll	$fp,$14,2
	addu	$fp,$3,$fp
	sll	$25,$25,2
	sw	$23,0($fp)
	addu	$fp,$18,$25
	addiu	$25,$5,6
	lw	$fp,0($fp)
	addiu	$21,$21,3
	sll	$23,$25,2
	addu	$23,$3,$23
	sll	$21,$21,2
	sw	$fp,0($23)
	addu	$21,$18,$21
	addiu	$18,$5,7
	lw	$21,0($21)
	sll	$fp,$18,2
	sw	$23,56($sp)
	addu	$fp,$3,$fp
	lw	$23,60($sp)
	sw	$21,0($fp)
	lw	$fp,1652($10)
	addu	$22,$23,$22
	addu	$22,$fp,$22
	lb	$21,0($22)
	sb	$21,9460($2)
	sb	$21,9461($2)
	lb	$21,1($22)
	sb	$21,9462($2)
	sb	$21,9463($2)
$L134:
	addiu	$21,$7,1
	and	$7,$6,$8
	bne	$7,$0,$L137
	sll	$21,$21,3

	addiu	$23,$21,11
	addiu	$22,$5,11
	lw	$fp,144($sp)
	sll	$23,$23,2
	sll	$22,$22,2
	addu	$23,$3,$23
	addu	$22,$3,$22
	sw	$0,0($23)
	sw	$0,0($22)
	sb	$fp,9475($2)
	sb	$fp,9467($2)
$L140:
	lw	$22,20($sp)
	and	$23,$6,$22
	beq	$23,$0,$L141
	li	$fp,-2			# 0xfffffffffffffffe

	lw	$fp,12($sp)
	lw	$22,9740($4)
	sll	$fp,$fp,2
	addu	$22,$22,$fp
	lw	$22,0($22)
	lw	$23,32($sp)
	addiu	$22,$22,3
	sw	$22,272($sp)
	mtlo	$22
	lw	$22,9748($4)
	sw	$23,64($sp)
	madd	$23,$22
	addiu	$21,$21,27
	mflo	$22
	sll	$23,$22,2
	lw	$22,1560($10)
	addu	$22,$22,$23
	lw	$22,0($22)
	addiu	$23,$5,27
	sw	$22,68($sp)
	lw	$22,9744($4)
	sll	$23,$23,2
	addu	$fp,$22,$fp
	lw	$fp,0($fp)
	addu	$23,$3,$23
	sw	$fp,60($sp)
	lw	$fp,68($sp)
	sw	$21,68($sp)
	sw	$fp,0($23)
	lw	$22,36($sp)
	lw	$23,9748($4)
	lw	$21,272($sp)
	mul	$fp,$22,$23
	sw	$22,56($sp)
	addu	$23,$fp,$21
	lw	$fp,1560($10)
	lw	$22,68($sp)
	sll	$23,$23,2
	addu	$23,$fp,$23
	lw	$23,0($23)
	sll	$21,$22,2
	addu	$21,$3,$21
	sw	$23,0($21)
	lw	$21,60($sp)
	lw	$23,1652($10)
	addiu	$fp,$21,1
	addu	$fp,$23,$fp
	lw	$23,64($sp)
	lw	$21,9752($4)
	sra	$22,$23,1
	mul	$23,$22,$21
	lw	$21,56($sp)
	addu	$22,$23,$fp
	lbu	$22,0($22)
	sra	$23,$21,1
	lw	$21,9752($4)
	sb	$22,56($sp)
	mul	$22,$23,$21
	lbu	$23,56($sp)
	addu	$fp,$22,$fp
	sb	$23,9483($2)
	lbu	$21,0($fp)
	sb	$21,9491($2)
$L142:
	lw	$21,140($sp)
	bne	$21,$0,$L145
	lw	$22,136($sp)

	bne	$22,$0,$L213
	lw	$23,80($sp)

$L250:
	and	$21,$6,$23
	beq	$21,$0,$L147
	addiu	$21,$5,3

	lw	$fp,172($sp)
	lw	$21,9740($4)
	lw	$22,9748($4)
	addu	$21,$21,$fp
	lw	$23,0($21)
	sll	$21,$22,1
	addu	$21,$21,$22
	addu	$21,$21,$23
	lw	$22,9744($4)
	lw	$23,1560($10)
	addiu	$21,$21,3
	addu	$22,$22,$fp
	sll	$21,$21,2
	addu	$21,$23,$21
	lw	$23,0($22)
	addiu	$22,$5,3
	lw	$21,0($21)
	lw	$fp,9752($4)
	sll	$22,$22,2
	addu	$22,$3,$22
	sw	$21,0($22)
	addiu	$fp,$fp,1
	lw	$21,1652($10)
	addu	$23,$fp,$23
	addu	$23,$21,$23
	lbu	$21,0($23)
	sb	$21,9459($2)
$L148:
	lw	$23,72($sp)
	and	$21,$6,$23
	beq	$21,$0,$L151
	nop

	lw	$fp,168($sp)
	lw	$22,9740($4)
	lw	$21,9748($4)
	addu	$22,$22,$fp
	lw	$23,0($22)
	sll	$22,$21,1
	addu	$21,$22,$21
	lw	$22,9744($4)
	addu	$21,$21,$23
	lw	$23,1560($10)
	addu	$22,$22,$fp
	sll	$19,$19,1
	sll	$21,$21,2
	addu	$19,$19,$20
	addu	$21,$23,$21
	lw	$20,0($22)
	lw	$fp,9752($4)
	lw	$22,0($21)
	sll	$19,$19,4
	lw	$21,1652($10)
	addu	$19,$3,$19
	addu	$fp,$20,$fp
	sw	$22,32($19)
	addu	$fp,$21,$fp
	lbu	$19,0($fp)
	sb	$19,9464($2)
$L152:
	lw	$20,176($sp)
	beq	$20,$0,$L244
	addiu	$23,$5,30

	lw	$19,-6276($15)
	beq	$19,$0,$L209
	nop

$L244:
	addiu	$22,$5,14
	sll	$23,$23,2
	addu	$fp,$3,$23
	addiu	$21,$5,32
	sll	$22,$22,2
	sw	$fp,56($sp)
	addiu	$20,$5,24
	addu	$fp,$3,$22
	sll	$21,$21,2
	sw	$fp,64($sp)
	addiu	$19,$5,16
	addu	$fp,$3,$21
	sll	$20,$20,2
	sw	$fp,60($sp)
	sll	$19,$19,2
	addu	$fp,$3,$20
	sw	$fp,68($sp)
	addu	$fp,$3,$19
	sw	$fp,272($sp)
	sb	$17,9486($2)
	sb	$17,9470($2)
	sb	$17,9488($2)
	sb	$17,9480($2)
	sb	$17,9472($2)
	lw	$fp,56($sp)
	sw	$0,0($fp)
	lw	$fp,64($sp)
	sw	$0,0($fp)
	lw	$fp,60($sp)
	sw	$0,0($fp)
	lw	$fp,68($sp)
	sw	$0,0($fp)
	lw	$fp,272($sp)
	sw	$0,0($fp)
	lw	$fp,11808($4)
	beq	$fp,$0,$L156
	nop

	beq	$11,$0,$L157
	lw	$fp,120($sp)

	lw	$fp,132($sp)
	lw	$11,9740($4)
	sll	$14,$14,2
	addu	$11,$11,$fp
	lw	$11,0($11)
	lw	$fp,9748($4)
	sw	$11,56($sp)
	sll	$11,$fp,1
	addu	$11,$11,$fp
	lw	$fp,56($sp)
	addu	$14,$24,$14
	addu	$11,$11,$fp
	lw	$fp,0($16)
	sw	$11,56($sp)
	sll	$11,$11,2
	addu	$11,$fp,$11
	lw	$11,0($11)
	lw	$fp,120($sp)
	sw	$11,64($sp)
	sll	$11,$fp,5
	lw	$fp,56($sp)
	addu	$11,$24,$11
	addiu	$fp,$fp,1
	sw	$11,120($sp)
	sll	$11,$fp,2
	sw	$11,60($sp)
	lw	$fp,120($sp)
	lw	$11,64($sp)
	sll	$25,$25,2
	sw	$11,48($fp)
	lw	$11,60($sp)
	lw	$fp,0($16)
	addu	$25,$24,$25
	addu	$fp,$fp,$11
	sw	$fp,60($sp)
	lw	$fp,0($fp)
	lw	$11,56($sp)
	sw	$fp,120($sp)
	addiu	$fp,$11,2
	lw	$11,120($sp)
	sll	$fp,$fp,2
	sw	$11,0($14)
	lw	$14,0($16)
	sll	$18,$18,2
	addu	$fp,$14,$fp
	lw	$14,0($fp)
	lw	$fp,56($sp)
	sw	$14,0($25)
	addiu	$11,$fp,3
	lw	$14,0($16)
	sll	$11,$11,2
	addu	$11,$14,$11
	lw	$11,0($11)
	addu	$18,$24,$18
	sw	$11,0($18)
	beq	$7,$0,$L159
	addiu	$5,$5,12

$L228:
	lw	$25,9748($4)
	lw	$11,220($sp)
	lw	$14,224($sp)
	lw	$7,9740($4)
	mul	$18,$14,$25
	addu	$7,$7,$11
	lw	$11,0($7)
	lw	$7,0($16)
	addiu	$11,$11,3
	addu	$25,$18,$11
	sll	$25,$25,2
	addu	$25,$7,$25
	addiu	$14,$5,-1
	lw	$25,0($25)
	sll	$14,$14,2
	addu	$14,$24,$14
	sw	$25,0($14)
	lw	$25,9748($4)
	lw	$18,148($sp)
	addiu	$14,$5,7
	mul	$fp,$18,$25
	sll	$14,$14,2
	addu	$11,$fp,$11
	sll	$11,$11,2
	addu	$11,$7,$11
	lw	$7,0($11)
	addu	$14,$24,$14
	sw	$7,0($14)
	lw	$7,276($sp)
	and	$6,$6,$7
	beq	$6,$0,$L245
	addiu	$6,$5,15

$L229:
	lw	$11,216($sp)
	lw	$6,9740($4)
	lw	$14,9748($4)
	addu	$6,$6,$11
	lw	$11,156($sp)
	lw	$7,0($6)
	mul	$18,$11,$14
	addiu	$7,$7,3
	lw	$6,0($16)
	addu	$14,$18,$7
	sll	$14,$14,2
	addiu	$11,$5,15
	addu	$14,$6,$14
	lw	$14,0($14)
	sll	$11,$11,2
	addu	$11,$24,$11
	sw	$14,0($11)
	lw	$11,9748($4)
	lw	$14,152($sp)
	addiu	$5,$5,23
	mul	$18,$14,$11
	sll	$5,$5,2
	addu	$7,$18,$7
	sll	$7,$7,2
	addu	$7,$6,$7
	lw	$6,0($7)
	addu	$5,$24,$5
	sw	$6,0($5)
$L162:
	addu	$19,$24,$19
	addu	$23,$24,$23
	addu	$22,$24,$22
	addu	$21,$24,$21
	addu	$20,$24,$20
	sw	$0,0($23)
	sw	$0,0($22)
	sw	$0,0($21)
	sw	$0,0($20)
	sw	$0,0($19)
	lw	$5,-6284($15)
	li	$19,3			# 0x3
	bne	$5,$19,$L156
	nop

	lw	$20,228($sp)
	lw	$21,232($sp)
	lw	$22,236($sp)
	lw	$23,240($sp)
	lw	$25,252($sp)
	sw	$0,0($20)
	sw	$0,0($21)
	sw	$0,0($22)
	bne	$25,$0,$L214
	sw	$0,0($23)

	lw	$6,268($sp)
	beq	$6,$0,$L165
	nop

	lw	$7,132($sp)
	lw	$5,9744($4)
	lw	$11,212($sp)
	addu	$5,$5,$7
	lw	$5,0($5)
	lw	$6,9752($4)
	lw	$7,9016($11)
	addu	$5,$5,$6
	addu	$5,$7,$5
	lbu	$6,0($5)
	sb	$6,9024($11)
	lbu	$5,1($5)
	sb	$5,9026($11)
$L164:
	lw	$18,248($sp)
	beq	$18,$0,$L166
	lw	$19,212($sp)

	li	$20,1			# 0x1
	sb	$20,9031($19)
$L167:
	lw	$19,244($sp)
	beq	$19,$0,$L169
	lw	$20,212($sp)

	li	$21,1			# 0x1
	sb	$21,9047($20)
$L156:
	lw	$5,-6276($15)
	beq	$5,$0,$L209
	nop

	lw	$5,-6272($15)
	beq	$5,$0,$L172
	lw	$19,208($sp)

	bne	$19,$0,$L246
	lw	$21,204($sp)

	lb	$5,9459($2)
	bltz	$5,$L246
	sll	$5,$5,1

	lw	$20,88($sp)
	lh	$6,9150($13)
	lh	$7,0($20)
	srl	$11,$6,31
	srl	$14,$7,31
	addu	$6,$11,$6
	addu	$7,$14,$7
	sra	$6,$6,1
	sra	$7,$7,1
	sb	$5,9459($2)
	sh	$6,9150($13)
	sh	$7,0($20)
	lw	$21,204($sp)
$L246:
	bne	$21,$0,$L247
	lw	$5,200($sp)

	lb	$5,9460($2)
	bltz	$5,$L175
	sll	$5,$5,1

	lw	$22,92($sp)
	lh	$6,9154($13)
	lh	$7,0($22)
	srl	$11,$6,31
	srl	$14,$7,31
	addu	$6,$11,$6
	addu	$7,$14,$7
	sra	$6,$6,1
	sra	$7,$7,1
	sb	$5,9460($2)
	sh	$6,9154($13)
	sh	$7,0($22)
$L175:
	lb	$5,9461($2)
	bltz	$5,$L176
	sll	$5,$5,1

	lw	$23,76($sp)
	lh	$6,9158($13)
	lh	$7,0($23)
	srl	$11,$6,31
	srl	$14,$7,31
	addu	$6,$11,$6
	addu	$7,$14,$7
	sra	$6,$6,1
	sra	$7,$7,1
	sb	$5,9461($2)
	sh	$6,9158($13)
	sh	$7,0($23)
$L176:
	lb	$5,9462($2)
	bltz	$5,$L177
	sll	$5,$5,1

	lw	$25,84($sp)
	lh	$6,9162($13)
	lh	$7,0($25)
	srl	$11,$6,31
	srl	$14,$7,31
	addu	$6,$11,$6
	addu	$7,$14,$7
	sra	$6,$6,1
	sra	$7,$7,1
	sb	$5,9462($2)
	sh	$6,9162($13)
	sh	$7,0($25)
$L177:
	lb	$5,9463($2)
	bltz	$5,$L174
	sll	$5,$5,1

	lw	$fp,100($sp)
	lh	$6,9166($13)
	lh	$7,0($fp)
	srl	$11,$6,31
	srl	$14,$7,31
	addu	$6,$11,$6
	addu	$7,$14,$7
	sra	$6,$6,1
	sra	$7,$7,1
	sb	$5,9463($2)
	sh	$6,9166($13)
	sh	$7,0($fp)
$L174:
	lw	$5,200($sp)
$L247:
	bne	$5,$0,$L248
	lw	$18,196($sp)

	lb	$5,9464($2)
	bltz	$5,$L248
	nop

	lw	$11,96($sp)
	lh	$6,9170($13)
	lh	$7,0($11)
	sll	$5,$5,1
	srl	$14,$7,31
	srl	$11,$6,31
	sb	$5,9464($2)
	addu	$7,$14,$7
	addu	$6,$11,$6
	lw	$14,96($sp)
	sra	$6,$6,1
	sra	$7,$7,1
	sh	$6,9170($13)
	sh	$7,0($14)
	lw	$18,196($sp)
$L248:
	bne	$18,$0,$L179
	nop

	lb	$5,9467($2)
	bltz	$5,$L180
	sll	$5,$5,1

	lw	$19,104($sp)
	lh	$6,9182($13)
	lh	$7,0($19)
	srl	$11,$6,31
	srl	$14,$7,31
	addu	$6,$11,$6
	addu	$7,$14,$7
	sra	$6,$6,1
	sra	$7,$7,1
	sb	$5,9467($2)
	sh	$6,9182($13)
	sh	$7,0($19)
$L180:
	lb	$5,9475($2)
	bltz	$5,$L179
	sll	$5,$5,1

	lw	$20,108($sp)
	lh	$6,9214($13)
	lh	$7,0($20)
	srl	$11,$6,31
	srl	$14,$7,31
	addu	$6,$11,$6
	addu	$7,$14,$7
	sra	$6,$6,1
	sra	$7,$7,1
	sb	$5,9475($2)
	sh	$6,9214($13)
	sh	$7,0($20)
$L179:
	lw	$21,192($sp)
	bne	$21,$0,$L209
	nop

	lb	$5,9483($2)
	bltz	$5,$L182
	lw	$22,112($sp)

	lh	$6,9246($13)
	lh	$7,0($22)
	srl	$11,$6,31
	srl	$14,$7,31
	addu	$6,$11,$6
	addu	$7,$14,$7
	sll	$5,$5,1
	sra	$6,$6,1
	sra	$7,$7,1
	sb	$5,9483($2)
	sh	$6,9246($13)
	sh	$7,0($22)
$L182:
	lb	$5,9491($2)
	bltz	$5,$L209
	lw	$23,116($sp)

	lh	$6,9278($13)
	lh	$7,0($23)
	srl	$11,$6,31
	srl	$14,$7,31
	addu	$6,$11,$6
	addu	$7,$14,$7
	sll	$5,$5,1
	sra	$6,$6,1
	sra	$7,$7,1
	lw	$18,5944($15)
	sb	$5,9491($2)
	sh	$6,9278($13)
	sh	$7,0($23)
$L132:
	lw	$19,116($sp)
	lw	$20,112($sp)
	lw	$21,108($sp)
	lw	$22,104($sp)
	lw	$23,96($sp)
	lw	$25,100($sp)
	lw	$fp,84($sp)
	lw	$6,76($sp)
	lw	$7,92($sp)
	lw	$11,88($sp)
	addiu	$12,$12,1
	addiu	$19,$19,160
	addiu	$20,$20,160
	addiu	$21,$21,160
	addiu	$22,$22,160
	addiu	$23,$23,160
	addiu	$25,$25,160
	addiu	$fp,$fp,160
	addiu	$6,$6,160
	addiu	$7,$7,160
	addiu	$11,$11,160
	sltu	$5,$12,$18
	sw	$19,116($sp)
	addiu	$2,$2,40
	addiu	$13,$13,160
	sw	$20,112($sp)
	sw	$21,108($sp)
	sw	$22,104($sp)
	sw	$23,96($sp)
	sw	$25,100($sp)
	sw	$fp,84($sp)
	sw	$6,76($sp)
	sw	$7,92($sp)
	sw	$11,88($sp)
	addiu	$16,$16,4
	addiu	$10,$10,4
	bne	$5,$0,$L193
	move	$19,$12

$L130:
	srl	$8,$8,24
	lw	$13,124($sp)
	andi	$8,$8,0x1
	addu	$8,$8,$13
	sw	$8,9544($4)
	lw	$fp,316($sp)
$L249:
	lw	$23,312($sp)
	lw	$22,308($sp)
	lw	$21,304($sp)
	lw	$20,300($sp)
	lw	$19,296($sp)
	lw	$18,292($sp)
	lw	$17,288($sp)
	lw	$16,284($sp)
	j	$31
	addiu	$sp,$sp,320

$L31:
	li	$3,65536			# 0x10000
	addu	$3,$4,$3
	lw	$10,-6296($3)
	li	$2,1			# 0x1
	beq	$10,$2,$L33
	subu	$2,$13,$7

	lw	$10,-6288($3)
	addu	$12,$10,$2
	addu	$10,$10,$13
	lbu	$11,0($10)
	lbu	$10,0($12)
	beq	$11,$10,$L33
	nop

	b	$L32
	lw	$25,-6276($3)

$L35:
	li	$10,-2			# 0xfffffffffffffffe
	and	$10,$8,$10
	mul	$14,$10,$7
	andi	$8,$8,0x1
	addu	$9,$14,$9
	subu	$10,$9,$7
	lw	$14,1568($4)
	addiu	$16,$10,1
	addiu	$25,$10,-1
	addiu	$9,$9,-1
	sll	$16,$16,2
	sll	$24,$10,2
	sll	$25,$25,2
	sll	$15,$9,2
	srl	$10,$5,7
	addu	$24,$14,$24
	addu	$15,$14,$15
	addu	$25,$14,$25
	xori	$10,$10,0x1
	addu	$14,$14,$16
	lw	$25,0($25)
	lw	$16,0($24)
	andi	$10,$10,0x1
	lw	$24,0($14)
	beq	$8,$0,$L37
	lw	$14,0($15)

	xori	$16,$10,0x1
$L38:
	subu	$15,$2,$7
	beq	$8,$0,$L41
	movn	$2,$15,$16

	xori	$25,$10,0x1
$L42:
	subu	$15,$12,$7
	beq	$8,$0,$L45
	movn	$12,$15,$25

	xori	$24,$10,0x1
$L46:
	subu	$15,$11,$7
	movn	$11,$15,$24
$L48:
	srl	$14,$14,7
	xori	$14,$14,0x1
	andi	$14,$14,0x1
	beq	$14,$10,$L215
	li	$15,1			# 0x1

	move	$3,$9
	sw	$9,8($sp)
	beq	$10,$0,$L50
	sw	$9,12($sp)

	beq	$8,$0,$L51
	li	$9,1			# 0x1

	li	$9,3			# 0x3
	li	$10,2			# 0x2
	li	$8,8			# 0x8
	li	$7,11			# 0xb
	li	$19,1			# 0x1
	li	$20,2			# 0x2
	sw	$10,28($sp)
	sw	$10,24($sp)
	sw	$9,36($sp)
	sw	$8,48($sp)
	sw	$7,52($sp)
	sw	$9,32($sp)
	sw	$8,40($sp)
	sw	$7,44($sp)
	move	$10,$3
	sw	$19,164($sp)
	sw	$19,160($sp)
	sw	$9,152($sp)
	sw	$9,156($sp)
	sw	$20,148($sp)
	li	$25,2			# 0x2
	li	$16,3			# 0x3
	b	$L36
	li	$24,3			# 0x3

$L33:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$25,-6276($2)
	beq	$25,$0,$L249
	lw	$fp,316($sp)

	b	$L32
	subu	$2,$13,$7

$L213:
	lw	$21,5356($15)
	bne	$21,$0,$L250
	nop

$L145:
	lw	$21,-6276($15)
	bne	$21,$0,$L250
	lw	$23,80($sp)

$L209:
	b	$L132
	lw	$18,5944($15)

$L207:
$L241:
	lw	$17,9128($4)
	sll	$13,$13,4
	addu	$13,$17,$13
	lw	$17,32($sp)
	addu	$17,$13,$17
	lbu	$18,0($17)
	lw	$17,36($sp)
	sb	$18,9107($4)
	addu	$17,$13,$17
	lbu	$18,0($17)
	lw	$17,48($sp)
	sb	$18,9115($4)
	addu	$17,$13,$17
	lbu	$18,0($17)
	lw	$17,52($sp)
	sb	$18,9096($4)
	addu	$13,$13,$17
	lbu	$13,0($13)
	b	$L115
	sb	$13,9120($4)

$L111:
	bne	$8,$0,$L116
	lw	$17,8($sp)

	li	$17,64			# 0x40
	movn	$17,$0,$15
	sb	$17,9091($4)
	sb	$17,9112($4)
	sb	$17,9088($4)
	sb	$17,9099($4)
$L119:
	bne	$13,$0,$L207
	lw	$13,12($sp)

	li	$13,64			# 0x40
	movn	$13,$0,$15
	sb	$13,9107($4)
	sb	$13,9120($4)
	sb	$13,9096($4)
	b	$L115
	sb	$13,9115($4)

$L107:
	lw	$15,11808($4)
	beq	$15,$0,$L110
	li	$17,64			# 0x40

	beq	$7,$0,$L110
	move	$17,$0

	li	$17,64			# 0x40
$L110:
	sb	$17,9084($4)
	sb	$17,9106($4)
	sb	$17,9105($4)
	sb	$17,9082($4)
	sb	$17,9081($4)
	sb	$17,9087($4)
	sb	$17,9086($4)
	b	$L108
	sb	$17,9085($4)

$L52:
	li	$7,65536			# 0x10000
	addu	$7,$4,$7
	lw	$8,-6288($7)
	lw	$7,-6296($7)
	addu	$9,$8,$12
	lbu	$9,0($9)
	beq	$9,$7,$L67
	addu	$9,$8,$2

	sw	$0,80($sp)
	lbu	$9,0($9)
	beq	$7,$9,$L69
	addu	$13,$8,$11

$L262:
	lbu	$13,0($13)
	beq	$7,$13,$L71
	move	$9,$0

$L231:
	sw	$0,72($sp)
	addu	$13,$8,$10
	lbu	$13,0($13)
	beq	$7,$13,$L73
	nop

$L232:
	addu	$8,$8,$3
	lbu	$8,0($8)
	beq	$7,$8,$L75
	move	$13,$0

$L233:
	move	$14,$0
	sw	$13,16($sp)
	sw	$14,20($sp)
$L234:
	andi	$7,$5,0x7
	beq	$7,$0,$L251
	srl	$8,$9,24

$L77:
	lw	$15,16($sp)
	lw	$21,80($sp)
	lw	$22,72($sp)
	andi	$19,$21,0x7
	andi	$18,$22,0x7
	move	$8,$15
$L62:
	li	$13,65535			# 0xffff
	li	$20,61162			# 0xeeea
	andi	$17,$9,0x7
	sw	$13,8980($4)
	sw	$20,8988($4)
	sw	$13,8992($4)
	bne	$17,$0,$L79
	sw	$13,8984($4)

	bne	$9,$0,$L218
	li	$13,46079			# 0xb3ff

	sw	$13,8980($4)
$L263:
	li	$13,13311			# 0x33ff
	sw	$13,8984($4)
	li	$13,9962			# 0x26ea
	sw	$13,8988($4)
$L79:
	andi	$13,$8,0x7
	bne	$13,$0,$L238
	lw	$13,20($sp)

	bne	$8,$0,$L82
	nop

$L83:
	lw	$17,8980($4)
	lw	$13,8992($4)
	andi	$17,$17,0xdf5f
	andi	$13,$13,0x5f5f
	sw	$17,8980($4)
	sw	$13,8992($4)
	lw	$13,20($sp)
$L238:
	andi	$17,$13,0x7
$L264:
	bne	$17,$0,$L84
	nop

	bne	$13,$0,$L219
	nop

	lw	$20,8980($4)
$L237:
	lw	$17,8992($4)
	andi	$20,$20,0xdf5f
	andi	$17,$17,0x5f5f
	sw	$20,8980($4)
	sw	$17,8992($4)
$L84:
	bne	$19,$0,$L86
	lw	$23,80($sp)

	bne	$23,$0,$L220
	nop

	lw	$17,8980($4)
$L240:
	andi	$17,$17,0x7fff
	sw	$17,8980($4)
$L86:
	bne	$18,$0,$L252
	andi	$17,$5,0x1

	lw	$fp,72($sp)
	bne	$fp,$0,$L221
	nop

	lw	$17,8988($4)
$L239:
	andi	$17,$17,0xfbff
	sw	$17,8988($4)
$L88:
	andi	$17,$5,0x1
$L252:
	beq	$17,$0,$L253
	srl	$17,$9,24

	andi	$17,$9,0x1
	beq	$17,$0,$L91
	sll	$17,$2,3

	lw	$18,8816($4)
	addu	$17,$18,$17
	lbu	$18,4($17)
	sb	$18,8780($4)
	lbu	$18,5($17)
	sb	$18,8781($4)
	lbu	$18,6($17)
	sb	$18,8782($4)
	lbu	$17,3($17)
	sb	$17,8783($4)
	andi	$17,$8,0x1
	bne	$17,$0,$L96
	nop

$L227:
	beq	$8,$0,$L101
	andi	$8,$8,0x78

	beq	$8,$0,$L254
	li	$8,2			# 0x2

	lw	$8,11860($4)
	beq	$8,$0,$L100
	li	$8,2			# 0x2

$L101:
	li	$8,-1			# 0xffffffffffffffff
	sb	$8,8787($4)
	sb	$8,8795($4)
$L235:
	andi	$8,$13,0x1
	bne	$8,$0,$L255
	lw	$8,12($sp)

$L102:
	beq	$13,$0,$L256
	li	$8,-1			# 0xffffffffffffffff

	andi	$8,$13,0x78
	beq	$8,$0,$L257
	li	$8,2			# 0x2

	lw	$8,11860($4)
	beq	$8,$0,$L105
	nop

	li	$8,-1			# 0xffffffffffffffff
$L256:
	sb	$8,8803($4)
	sb	$8,8811($4)
$L103:
	srl	$17,$9,24
$L253:
	andi	$17,$17,0x1
	move	$8,$15
	b	$L78
	sw	$17,124($sp)

$L141:
	addiu	$21,$21,27
	sll	$21,$21,2
	sw	$21,56($sp)
	li	$21,-1			# 0xffffffffffffffff
	movn	$fp,$21,$22
	move	$22,$fp
	addiu	$23,$5,27
	lw	$fp,56($sp)
	sll	$23,$23,2
	addu	$21,$3,$fp
	addu	$23,$3,$23
	sw	$0,0($21)
	sw	$0,0($23)
	sb	$22,9483($2)
	b	$L142
	sb	$22,9491($2)

$L137:
	lw	$fp,8($sp)
	lw	$22,9740($4)
	sll	$fp,$fp,2
	addu	$22,$22,$fp
	lw	$22,0($22)
	lw	$23,24($sp)
	addiu	$22,$22,3
	sw	$22,56($sp)
	mtlo	$22
	lw	$22,9748($4)
	sw	$23,272($sp)
	madd	$23,$22
	mflo	$22
	sll	$23,$22,2
	lw	$22,1560($10)
	addu	$22,$22,$23
	lw	$22,0($22)
	addiu	$23,$5,11
	sw	$22,68($sp)
	lw	$22,9744($4)
	sll	$23,$23,2
	addu	$fp,$22,$fp
	lw	$fp,0($fp)
	addu	$23,$3,$23
	sw	$fp,64($sp)
	lw	$fp,68($sp)
	sw	$fp,0($23)
	lw	$22,28($sp)
	addiu	$23,$21,11
	sw	$22,68($sp)
	lw	$22,56($sp)
	sw	$23,60($sp)
	mtlo	$22
	lw	$23,9748($4)
	lw	$22,68($sp)
	lw	$fp,60($sp)
	madd	$22,$23
	lw	$22,1560($10)
	mflo	$23
	sll	$fp,$fp,2
	sll	$23,$23,2
	addu	$23,$22,$23
	lw	$23,0($23)
	lw	$22,64($sp)
	addu	$fp,$3,$fp
	sw	$23,0($fp)
	lw	$fp,1652($10)
	addiu	$23,$22,1
	addu	$fp,$fp,$23
	lw	$23,272($sp)
	lw	$22,9752($4)
	sra	$23,$23,1
	mtlo	$fp
	madd	$23,$22
	lw	$23,68($sp)
	mflo	$22
	sra	$23,$23,1
	sw	$fp,56($sp)
	sw	$22,60($sp)
	sw	$23,64($sp)
	lbu	$fp,0($22)
	lw	$22,56($sp)
	mtlo	$22
	lw	$22,9752($4)
	madd	$23,$22
	mflo	$22
	sw	$22,56($sp)
	sb	$fp,9467($2)
	lw	$23,56($sp)
	lbu	$22,0($23)
	b	$L140
	sb	$22,9475($2)

$L133:
	sll	$7,$19,2
	addu	$7,$7,$19
	addiu	$5,$7,-1
	sw	$5,120($sp)
	sll	$20,$19,3
	sll	$5,$19,5
	addu	$5,$20,$5
	lw	$14,120($sp)
	addiu	$18,$5,7
	sll	$22,$14,3
	sll	$21,$18,2
	addiu	$14,$5,5
	sw	$21,56($sp)
	sll	$23,$14,2
	sw	$23,60($sp)
	lw	$23,56($sp)
	addiu	$22,$22,12
	addu	$23,$3,$23
	sw	$23,56($sp)
	lw	$23,60($sp)
	sll	$21,$22,2
	sw	$21,64($sp)
	addu	$23,$3,$23
	sw	$23,60($sp)
	lw	$23,64($sp)
	li	$21,-1			# 0xffffffffffffffff
	addu	$23,$3,$23
	sw	$23,64($sp)
	li	$23,-16908288			# 0xfffffffffefe0000
	ori	$23,$23,0xfefe
	movz	$21,$23,$9
	lw	$23,180($sp)
	addiu	$25,$5,6
	addu	$22,$23,$22
	sll	$fp,$25,2
	lw	$23,56($sp)
	addu	$fp,$3,$fp
	sw	$0,0($23)
	sw	$0,0($fp)
	lw	$23,64($sp)
	lw	$fp,60($sp)
	sw	$0,0($fp)
	sw	$0,0($23)
	b	$L134
	sw	$21,0($22)

$L151:
	sll	$19,$19,1
	addu	$19,$19,$20
	sll	$19,$19,4
	addu	$19,$3,$19
	sw	$0,32($19)
	lw	$19,184($sp)
	b	$L152
	sb	$19,9464($2)

$L147:
	sll	$21,$21,2
	lw	$22,188($sp)
	addu	$21,$3,$21
	sw	$0,0($21)
	b	$L148
	sb	$22,9459($2)

$L116:
	lw	$18,9128($4)
	sll	$17,$17,4
	addu	$17,$18,$17
	lw	$18,24($sp)
	addu	$18,$17,$18
	lbu	$19,0($18)
	lw	$18,28($sp)
	sb	$19,9091($4)
	addu	$18,$17,$18
	lbu	$19,0($18)
	lw	$18,40($sp)
	sb	$19,9099($4)
	addu	$18,$17,$18
	lbu	$19,0($18)
	lw	$18,44($sp)
	sb	$19,9088($4)
	addu	$17,$17,$18
	lbu	$17,0($17)
	b	$L119
	sb	$17,9112($4)

$L112:
	sb	$17,9091($4)
	sb	$17,9112($4)
	sb	$17,9088($4)
	b	$L113
	sb	$17,9099($4)

$L59:
	andi	$7,$5,0x7
	bne	$7,$0,$L223
	move	$18,$0

	lw	$18,9128($4)
	sll	$15,$13,4
	addu	$15,$18,$15
	lhu	$15,14($15)
	sra	$18,$15,8
	sw	$18,56($sp)
	sra	$18,$15,9
	sw	$18,96($sp)
	sra	$18,$15,10
	sw	$18,104($sp)
	sra	$18,$15,11
	sw	$18,108($sp)
	sra	$18,$15,12
	sra	$21,$15,1
	sw	$18,112($sp)
	sra	$18,$15,13
	sw	$21,72($sp)
	sw	$18,116($sp)
	sra	$19,$15,7
	sra	$18,$15,14
	sw	$18,120($sp)
	sra	$20,$15,6
	lw	$18,72($sp)
	andi	$19,$19,0x1
	sra	$fp,$15,2
	sra	$23,$15,3
	andi	$20,$20,0x1
	sw	$19,100($sp)
	lw	$19,56($sp)
	sra	$21,$15,5
	andi	$18,$18,0x1
	andi	$fp,$fp,0x1
	andi	$23,$23,0x1
	sw	$20,84($sp)
	lw	$20,96($sp)
	sw	$18,72($sp)
	sw	$fp,80($sp)
	sw	$23,88($sp)
	andi	$18,$19,0x1
	lw	$23,104($sp)
	lw	$fp,108($sp)
	lw	$19,112($sp)
	sra	$22,$15,4
	andi	$21,$21,0x1
	andi	$22,$22,0x1
	sw	$21,76($sp)
	andi	$21,$20,0x1
	lw	$20,116($sp)
	sw	$22,92($sp)
	andi	$22,$23,0x1
	andi	$23,$fp,0x1
	andi	$fp,$19,0x1
	lw	$19,120($sp)
	andi	$20,$20,0x1
	sw	$20,96($sp)
	andi	$20,$19,0x1
	srl	$19,$15,15
	andi	$15,$15,0x1
	sb	$15,9092($4)
	lw	$15,72($sp)
	sb	$15,9093($4)
	lw	$15,80($sp)
	sb	$15,9100($4)
	lw	$15,88($sp)
	sb	$15,9101($4)
	lw	$15,92($sp)
	sb	$15,9094($4)
	lw	$15,76($sp)
	sb	$18,9108($4)
	sb	$15,9095($4)
	lw	$15,84($sp)
	lw	$18,96($sp)
	sb	$15,9102($4)
	sb	$19,9119($4)
	lw	$15,100($sp)
	lw	$19,5944($17)
	sb	$15,9103($4)
	sb	$21,9109($4)
	sb	$22,9116($4)
	sb	$23,9117($4)
	sb	$fp,9110($4)
	sb	$18,9111($4)
	beq	$19,$0,$L63
	sb	$20,9118($4)

	sll	$13,$13,2
	move	$18,$17
	addiu	$20,$4,9136
	addiu	$21,$4,9456
	sw	$13,92($sp)
	sw	$20,88($sp)
	sw	$21,80($sp)
	move	$17,$4
	move	$13,$0
	move	$15,$0
	li	$19,-1			# 0xffffffffffffffff
	mtlo	$24
	sw	$3,56($sp)
	sw	$2,60($sp)
	move	$fp,$18
$L66:
	sll	$24,$15,1
	li	$22,12288			# 0x3000
	sll	$24,$22,$24
	and	$24,$24,$5
	beq	$24,$0,$L64
	sll	$24,$13,5

	lw	$23,92($sp)
	lw	$24,9740($4)
	sll	$20,$13,5
	addu	$24,$24,$23
	lw	$24,0($24)
	lw	$18,1560($17)
	sll	$23,$13,3
	addu	$23,$23,$20
	sll	$24,$24,2
	addu	$24,$18,$24
	addiu	$22,$23,12
	lw	$2,88($sp)
	lw	$3,92($sp)
	lw	$20,9744($4)
	lw	$18,0($24)
	sll	$13,$22,2
	addu	$13,$2,$13
	addu	$20,$20,$3
	lw	$20,0($20)
	sw	$18,0($13)
	lw	$18,4($24)
	sw	$20,76($sp)
	sw	$18,4($13)
	lw	$18,8($24)
	addiu	$21,$13,32
	sw	$18,8($13)
	lw	$2,12($24)
	addiu	$20,$13,64
	sw	$2,12($13)
	lw	$3,9748($4)
	lw	$2,1652($17)
	sll	$3,$3,2
	addu	$24,$24,$3
	lw	$3,76($sp)
	addiu	$18,$13,96
	addu	$2,$2,$3
	sw	$2,72($sp)
	lw	$2,0($24)
	sw	$2,32($13)
	lw	$3,4($24)
	lw	$2,80($sp)
	sw	$3,4($21)
	lw	$3,8($24)
	addu	$23,$2,$23
	sw	$3,8($21)
	lw	$3,12($24)
	addu	$22,$2,$22
	sw	$3,12($21)
	lw	$21,9748($4)
	sll	$21,$21,2
	addu	$24,$24,$21
	lw	$21,0($24)
	sw	$21,64($13)
	lw	$21,4($24)
	sw	$21,4($20)
	lw	$21,8($24)
	lw	$3,72($sp)
	sw	$21,8($20)
	lw	$21,12($24)
	sw	$21,12($20)
	lw	$21,9748($4)
	sll	$21,$21,2
	addu	$24,$24,$21
	lw	$20,0($24)
	sw	$20,96($13)
	lw	$13,4($24)
	sw	$13,4($18)
	lw	$13,8($24)
	sw	$13,8($18)
	lw	$13,12($24)
	sw	$13,12($18)
	lb	$24,1($3)
	lb	$13,0($3)
	sll	$24,$24,16
	andi	$13,$13,0xffff
	addu	$13,$24,$13
	sll	$24,$13,8
	addu	$13,$24,$13
	sw	$13,20($23)
	sw	$13,0($22)
	lw	$24,9752($4)
	addu	$24,$3,$24
	lb	$13,0($24)
	lb	$24,1($24)
	andi	$13,$13,0xffff
	sll	$24,$24,16
	addu	$13,$24,$13
	sll	$24,$13,8
	addu	$13,$24,$13
	sw	$13,28($23)
	sw	$13,36($23)
$L65:
	lw	$24,5944($fp)
	addiu	$15,$15,1
	sltu	$24,$15,$24
	addiu	$17,$17,4
	bne	$24,$0,$L66
	move	$13,$15

	mflo	$24
	lw	$3,56($sp)
	lw	$2,60($sp)
$L63:
	sw	$0,72($sp)
	sw	$0,80($sp)
	b	$L78
	lw	$13,20($sp)

$L124:
	beq	$7,$0,$L126
	addu	$13,$4,$13

	li	$13,131072			# 0x20000
	addu	$13,$4,$13
	li	$15,448			# 0x1c0
	bne	$8,$0,$L224
	sw	$15,8668($13)

$L127:
	beq	$7,$0,$L129
	li	$7,131072			# 0x20000

	addu	$7,$4,$7
	li	$13,448			# 0x1c0
	b	$L128
	sw	$13,8672($7)

$L37:
	beq	$10,$0,$L225
	nop

$L41:
	beq	$10,$0,$L226
	nop

$L45:
	bne	$10,$0,$L48
	srl	$24,$24,7

	b	$L46
	andi	$24,$24,0x1

$L50:
	addu	$7,$9,$7
	li	$8,10			# 0xa
	li	$9,2			# 0x2
	li	$10,7			# 0x7
	sw	$10,48($sp)
	sw	$9,36($sp)
	move	$10,$3
	sw	$8,52($sp)
	sw	$7,12($sp)
	sw	$9,28($sp)
	sw	$0,32($sp)
	sw	$8,44($sp)
	move	$3,$7
	sw	$0,164($sp)
	sw	$0,160($sp)
	sw	$9,152($sp)
	sw	$0,156($sp)
	sw	$9,148($sp)
	move	$25,$0
	li	$16,1			# 0x1
	b	$L36
	li	$24,1			# 0x1

$L218:
	lw	$13,11860($4)
	beq	$13,$0,$L79
	li	$13,46079			# 0xb3ff

	b	$L263
	sw	$13,8980($4)

$L219:
	lw	$17,11860($4)
	beq	$17,$0,$L84
	nop

	b	$L237
	lw	$20,8980($4)

$L82:
	lw	$13,11860($4)
	bne	$13,$0,$L83
	lw	$13,20($sp)

	b	$L264
	andi	$17,$13,0x7

$L221:
	lw	$17,11860($4)
	beq	$17,$0,$L88
	nop

	b	$L239
	lw	$17,8988($4)

$L220:
	lw	$17,11860($4)
	beq	$17,$0,$L86
	nop

	b	$L240
	lw	$17,8980($4)

$L223:
	move	$19,$0
	sw	$0,72($sp)
	sw	$0,80($sp)
	b	$L62
	move	$15,$8

$L91:
	beq	$9,$0,$L95
	li	$17,-1			# 0xffffffffffffffff

	andi	$17,$9,0x78
	beq	$17,$0,$L95
	li	$17,2			# 0x2

	lw	$17,11860($4)
	beq	$17,$0,$L95
	li	$17,2			# 0x2

	li	$17,-1			# 0xffffffffffffffff
$L95:
	sb	$17,8780($4)
	sb	$17,8783($4)
	sb	$17,8782($4)
	sb	$17,8781($4)
	andi	$17,$8,0x1
	beq	$17,$0,$L227
	nop

$L96:
	lw	$8,8($sp)
	lw	$17,8816($4)
	sll	$8,$8,3
	addu	$8,$17,$8
	lw	$17,24($sp)
	addu	$17,$8,$17
	lbu	$18,0($17)
	lw	$17,28($sp)
	sb	$18,8787($4)
	addu	$8,$8,$17
	lbu	$8,0($8)
	sb	$8,8795($4)
	andi	$8,$13,0x1
	beq	$8,$0,$L102
	lw	$8,12($sp)

$L255:
	lw	$17,8816($4)
	sll	$8,$8,3
	addu	$8,$17,$8
	lw	$17,32($sp)
	addu	$17,$8,$17
	lbu	$18,0($17)
	lw	$17,36($sp)
	sb	$18,8803($4)
	addu	$8,$8,$17
	lbu	$8,0($8)
	srl	$17,$9,24
	andi	$17,$17,0x1
	sb	$8,8811($4)
	sw	$17,124($sp)
	b	$L78
	move	$8,$15

$L225:
	srl	$16,$16,7
	b	$L38
	andi	$16,$16,0x1

$L129:
	addu	$7,$4,$7
	b	$L128
	sw	$0,8672($7)

$L126:
	b	$L125
	sw	$0,8668($13)

$L226:
	srl	$25,$25,7
	b	$L42
	andi	$25,$25,0x1

$L172:
	lw	$25,208($sp)
	beq	$25,$0,$L258
	lw	$5,204($sp)

	lb	$5,9459($2)
	bltz	$5,$L183
	lw	$fp,88($sp)

	lh	$6,9150($13)
	lh	$7,0($fp)
	sra	$5,$5,1
	sll	$6,$6,1
	sll	$7,$7,1
	sb	$5,9459($2)
	sh	$6,9150($13)
	sh	$7,0($fp)
$L183:
	lw	$5,204($sp)
$L258:
	beq	$5,$0,$L259
	lw	$20,200($sp)

	lb	$5,9460($2)
	bltz	$5,$L185
	lw	$11,92($sp)

	lh	$6,9154($13)
	lh	$7,0($11)
	sra	$5,$5,1
	sll	$6,$6,1
	sll	$7,$7,1
	sb	$5,9460($2)
	sh	$6,9154($13)
	sh	$7,0($11)
$L185:
	lb	$5,9461($2)
	bltz	$5,$L186
	lw	$14,76($sp)

	lh	$6,9158($13)
	lh	$7,0($14)
	sra	$5,$5,1
	sll	$6,$6,1
	sll	$7,$7,1
	sb	$5,9461($2)
	sh	$6,9158($13)
	sh	$7,0($14)
$L186:
	lb	$5,9462($2)
	bltz	$5,$L187
	lw	$18,84($sp)

	lh	$6,9162($13)
	lh	$7,0($18)
	sra	$5,$5,1
	sll	$6,$6,1
	sll	$7,$7,1
	sb	$5,9462($2)
	sh	$6,9162($13)
	sh	$7,0($18)
$L187:
	lb	$5,9463($2)
	bltz	$5,$L184
	lw	$19,100($sp)

	lh	$6,9166($13)
	lh	$7,0($19)
	sra	$5,$5,1
	sll	$6,$6,1
	sll	$7,$7,1
	sb	$5,9463($2)
	sh	$6,9166($13)
	sh	$7,0($19)
$L184:
	lw	$20,200($sp)
$L259:
	beq	$20,$0,$L260
	lw	$22,196($sp)

	lb	$5,9464($2)
	bltz	$5,$L260
	lw	$21,96($sp)

	lh	$6,9170($13)
	lh	$7,0($21)
	sra	$5,$5,1
	sll	$6,$6,1
	sll	$7,$7,1
	sb	$5,9464($2)
	sh	$6,9170($13)
	sh	$7,0($21)
	lw	$22,196($sp)
$L260:
	beq	$22,$0,$L261
	lw	$fp,192($sp)

	lb	$5,9467($2)
	bltz	$5,$L190
	lw	$23,104($sp)

	lh	$6,9182($13)
	lh	$7,0($23)
	sra	$5,$5,1
	sll	$6,$6,1
	sll	$7,$7,1
	sb	$5,9467($2)
	sh	$6,9182($13)
	sh	$7,0($23)
$L190:
	lb	$5,9475($2)
	bltz	$5,$L189
	lw	$25,108($sp)

	lh	$6,9214($13)
	lh	$7,0($25)
	sra	$5,$5,1
	sll	$6,$6,1
	sll	$7,$7,1
	sb	$5,9475($2)
	sh	$6,9214($13)
	sh	$7,0($25)
$L189:
	lw	$fp,192($sp)
$L261:
	beq	$fp,$0,$L209
	nop

	lb	$5,9483($2)
	bltz	$5,$L192
	lw	$11,112($sp)

	lh	$6,9246($13)
	lh	$7,0($11)
	sra	$5,$5,1
	sll	$6,$6,1
	sll	$7,$7,1
	sb	$5,9483($2)
	sh	$6,9246($13)
	sh	$7,0($11)
$L192:
	lb	$5,9491($2)
	bltz	$5,$L209
	sra	$5,$5,1

	lw	$14,116($sp)
	lh	$6,9278($13)
	lh	$7,0($14)
	sll	$6,$6,1
	sll	$7,$7,1
	lw	$18,5944($15)
	sb	$5,9491($2)
	sh	$6,9278($13)
	b	$L132
	sh	$7,0($14)

$L157:
	sll	$18,$18,2
	sll	$25,$25,2
	sll	$14,$14,2
	sll	$11,$fp,5
	addu	$18,$24,$18
	addu	$25,$24,$25
	addu	$14,$24,$14
	addu	$11,$24,$11
	sw	$0,0($18)
	addiu	$5,$5,12
	sw	$0,0($25)
	sw	$0,0($14)
	bne	$7,$0,$L228
	sw	$0,48($11)

$L159:
	addiu	$11,$5,7
	addiu	$7,$5,-1
	sll	$11,$11,2
	sll	$7,$7,2
	addu	$7,$24,$7
	addu	$11,$24,$11
	sw	$0,0($11)
	sw	$0,0($7)
	lw	$7,276($sp)
	and	$6,$6,$7
	bne	$6,$0,$L229
	addiu	$6,$5,15

$L245:
	addiu	$5,$5,23
	sll	$5,$5,2
	sll	$6,$6,2
	addu	$5,$24,$5
	addu	$6,$24,$6
	sw	$0,0($5)
	b	$L162
	sw	$0,0($6)

$L212:
	b	$L58
	move	$14,$0

$L215:
	li	$17,3			# 0x3
	li	$18,2			# 0x2
	move	$10,$3
	sw	$15,164($sp)
	sw	$0,160($sp)
	sw	$17,152($sp)
	sw	$18,156($sp)
	sw	$15,148($sp)
	move	$25,$0
	li	$16,3			# 0x3
	b	$L36
	li	$24,1			# 0x1

$L67:
	lw	$13,1568($4)
	sll	$9,$12,2
	addu	$9,$13,$9
	lw	$9,0($9)
	sw	$9,80($sp)
	addu	$9,$8,$2
	lbu	$9,0($9)
	bne	$7,$9,$L262
	addu	$13,$8,$11

$L69:
	lw	$13,1568($4)
	sll	$9,$2,2
	addu	$9,$13,$9
	addu	$13,$8,$11
	lbu	$13,0($13)
	bne	$7,$13,$L231
	lw	$9,0($9)

$L71:
	lw	$14,1568($4)
	sll	$13,$11,2
	addu	$13,$14,$13
	lw	$13,0($13)
	sw	$13,72($sp)
	addu	$13,$8,$10
	lbu	$13,0($13)
	bne	$7,$13,$L232
	nop

$L73:
	lw	$14,1568($4)
	addu	$8,$8,$3
	sll	$13,$10,2
	lbu	$8,0($8)
	addu	$13,$14,$13
	bne	$7,$8,$L233
	lw	$13,0($13)

$L75:
	lw	$8,1568($4)
	sll	$7,$3,2
	addu	$7,$8,$7
	lw	$14,0($7)
	sw	$13,16($sp)
	b	$L234
	sw	$14,20($sp)

$L210:
	sw	$0,124($sp)
	b	$L54
	move	$9,$0

$L64:
	sll	$13,$13,3
	addu	$13,$13,$24
	addiu	$13,$13,12
	lw	$18,88($sp)
	lw	$20,80($sp)
	sll	$24,$13,2
	addu	$24,$18,$24
	addu	$13,$20,$13
	sw	$0,108($24)
	sw	$0,0($24)
	sw	$0,4($24)
	sw	$0,8($24)
	sw	$0,12($24)
	sw	$0,32($24)
	sw	$0,36($24)
	sw	$0,40($24)
	sw	$0,44($24)
	sw	$0,64($24)
	sw	$0,68($24)
	sw	$0,72($24)
	sw	$0,76($24)
	sw	$0,96($24)
	sw	$0,100($24)
	sw	$0,104($24)
	sw	$19,24($13)
	sw	$19,0($13)
	sw	$19,8($13)
	b	$L65
	sw	$19,16($13)

$L51:
	li	$8,7			# 0x7
	li	$7,10			# 0xa
	sw	$9,36($sp)
	sw	$8,48($sp)
	sw	$7,52($sp)
	sw	$0,24($sp)
	sw	$0,28($sp)
	sw	$9,32($sp)
	sw	$8,40($sp)
	sw	$7,44($sp)
	move	$10,$3
	sw	$0,164($sp)
	sw	$0,160($sp)
	sw	$9,152($sp)
	sw	$9,156($sp)
	sw	$0,148($sp)
	move	$25,$0
	li	$16,1			# 0x1
	b	$L36
	li	$24,1			# 0x1

$L214:
	li	$5,16842752			# 0x1010000
	lw	$fp,256($sp)
	ori	$5,$5,0x101
	b	$L164
	sw	$5,0($fp)

$L100:
$L254:
	sb	$8,8787($4)
	b	$L235
	sb	$8,8795($4)

$L105:
	li	$8,2			# 0x2
$L257:
	sb	$8,8803($4)
	b	$L103
	sb	$8,8811($4)

$L169:
	lw	$22,260($sp)
	beq	$22,$0,$L170
	nop

	lw	$6,9752($4)
	lw	$11,164($sp)
	lw	$23,212($sp)
	lw	$25,216($sp)
	lw	$5,9744($4)
	mul	$14,$11,$6
	lw	$7,9016($23)
	addu	$5,$5,$25
	lw	$5,0($5)
	addu	$6,$14,$7
	addu	$5,$6,$5
	lbu	$5,1($5)
	b	$L156
	sb	$5,9047($23)

$L166:
	lw	$21,264($sp)
	beq	$21,$0,$L168
	nop

	lw	$6,9752($4)
	lw	$11,160($sp)
	lw	$22,212($sp)
	lw	$23,220($sp)
	lw	$5,9744($4)
	mul	$14,$11,$6
	lw	$7,9016($22)
	addu	$5,$5,$23
	lw	$5,0($5)
	addu	$6,$14,$7
	addu	$5,$6,$5
	lbu	$5,1($5)
	b	$L167
	sb	$5,9031($22)

$L165:
	lw	$14,256($sp)
	b	$L164
	sw	$0,0($14)

$L170:
	lw	$18,212($sp)
	b	$L156
	sb	$0,9047($18)

$L168:
	lw	$18,212($sp)
	b	$L167
	sb	$0,9031($18)

	.set	macro
	.set	reorder
	.end	fill_caches
	.size	fill_caches, .-fill_caches
	.align	2
	.set	nomips16
	.ent	write_back_motion
	.type	write_back_motion, @function
write_back_motion:
	.frame	$sp,112,$31		# vars= 64, regs= 9/0, args= 0, gp= 8
	.mask	0x40ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$3,6172($4)
	lw	$10,9748($4)
	lw	$6,9752($4)
	mul	$8,$3,$10
	mul	$7,$6,$3
	lw	$2,6168($4)
	addiu	$sp,$sp,-112
	addu	$25,$7,$2
	addu	$10,$8,$2
	andi	$7,$5,0x3000
	sw	$fp,108($sp)
	sw	$23,104($sp)
	sw	$22,100($sp)
	sw	$21,96($sp)
	sw	$20,92($sp)
	sw	$19,88($sp)
	sw	$18,84($sp)
	sw	$17,80($sp)
	sw	$16,76($sp)
	sll	$25,$25,1
	bne	$7,$0,$L266
	sll	$10,$10,2

	lw	$3,1652($4)
	li	$2,-1			# 0xffffffffffffffff
	addu	$3,$3,$25
	addu	$6,$3,$6
	sh	$2,0($3)
	sh	$2,0($6)
$L266:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$3,5944($2)
	beq	$3,$0,$L267
	andi	$16,$5,0x800

	li	$24,131072			# 0x20000
	addiu	$12,$10,2
	ori	$11,$24,0x21ec
	sll	$9,$10,2
	ori	$24,$24,0x21f8
	sll	$13,$12,2
	sw	$2,48($sp)
	sw	$9,40($sp)
	addu	$24,$4,$24
	addu	$11,$4,$11
	addiu	$7,$4,9136
	sw	$13,44($sp)
	sw	$16,52($sp)
	move	$8,$4
	move	$6,$4
	move	$9,$0
	move	$2,$0
	li	$15,12288			# 0x3000
$L271:
	sll	$13,$2,1
	sll	$13,$15,$13
	and	$13,$13,$5
	beq	$13,$0,$L268
	sll	$14,$9,2

	addu	$14,$14,$9
	sll	$23,$14,3
	addiu	$fp,$23,12
	sll	$fp,$fp,2
	lw	$3,1560($8)
	addu	$9,$7,$fp
	lw	$18,40($sp)
	lw	$16,0($9)
	lw	$17,4($9)
	addiu	$23,$23,14
	addu	$9,$3,$18
	addiu	$20,$14,1
	sll	$23,$23,2
	sw	$16,0($9)
	sw	$17,4($9)
	lw	$19,44($sp)
	addu	$9,$7,$23
	sll	$20,$20,3
	lw	$16,0($9)
	lw	$17,4($9)
	lw	$13,9748($4)
	addiu	$22,$20,12
	addu	$9,$3,$19
	sll	$22,$22,2
	sw	$16,0($9)
	sw	$17,4($9)
	addu	$21,$10,$13
	addu	$9,$7,$22
	lw	$18,0($9)
	lw	$19,4($9)
	sll	$21,$21,2
	addiu	$20,$20,14
	addu	$9,$3,$21
	sll	$20,$20,2
	addiu	$16,$14,2
	sw	$18,0($9)
	sw	$19,4($9)
	sll	$16,$16,3
	addu	$9,$7,$20
	addu	$17,$12,$13
	sw	$21,60($sp)
	sw	$20,56($sp)
	lw	$21,4($9)
	lw	$20,0($9)
	sll	$17,$17,2
	addiu	$18,$16,12
	sll	$9,$13,1
	sw	$17,64($sp)
	sll	$18,$18,2
	addu	$17,$3,$17
	sw	$20,0($17)
	sw	$21,4($17)
	addu	$19,$7,$18
	addu	$17,$9,$10
	addiu	$16,$16,14
	lw	$21,4($19)
	sll	$16,$16,2
	sll	$17,$17,2
	sw	$16,32($sp)
	addu	$16,$3,$17
	lw	$20,0($19)
	sw	$21,4($16)
	lw	$21,32($sp)
	sw	$20,0($16)
	addu	$19,$7,$21
	lw	$20,0($19)
	lw	$21,4($19)
	addu	$16,$9,$12
	addiu	$14,$14,3
	sll	$14,$14,3
	sll	$16,$16,2
	sw	$20,8($sp)
	sw	$21,12($sp)
	sw	$16,36($sp)
	addiu	$16,$14,12
	lw	$21,36($sp)
	sll	$16,$16,2
	sw	$16,16($sp)
	addu	$16,$3,$21
	lw	$21,12($sp)
	lw	$20,8($sp)
	sw	$21,4($16)
	lw	$21,16($sp)
	sw	$20,0($16)
	addu	$19,$7,$21
	lw	$20,0($19)
	addu	$9,$9,$13
	lw	$21,4($19)
	addu	$16,$9,$10
	sw	$20,24($sp)
	sll	$16,$16,2
	sw	$21,28($sp)
	lw	$20,24($sp)
	addu	$21,$3,$16
	addiu	$14,$14,14
	move	$19,$21
	sll	$14,$14,2
	lw	$21,28($sp)
	sw	$20,0($19)
	addu	$20,$7,$14
	sw	$21,4($19)
	addu	$9,$9,$12
	move	$21,$20
	lw	$21,4($21)
	sw	$20,8($sp)
	sll	$9,$9,2
	lw	$20,0($20)
	addu	$3,$3,$9
	sw	$20,0($3)
	sw	$21,4($3)
	lw	$3,11808($4)
	beq	$3,$0,$L269
	lw	$19,52($sp)

	beq	$19,$0,$L275
	addu	$18,$24,$18

	sll	$9,$13,2
	lw	$18,40($sp)
	lw	$3,0($11)
	addiu	$16,$9,4
	sll	$13,$13,3
	addiu	$19,$9,2
	addiu	$17,$9,6
	addu	$3,$3,$18
	addu	$14,$13,$9
	sll	$18,$16,1
	sll	$19,$19,1
	sll	$17,$17,1
	addu	$14,$3,$14
	addu	$9,$3,$9
	addu	$19,$3,$19
	addu	$18,$3,$18
	addu	$17,$3,$17
	addu	$16,$3,$16
	addu	$13,$3,$13
	sw	$0,0($3)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$0,12($3)
	sw	$0,0($9)
	sw	$0,0($16)
	sw	$0,12($9)
	sw	$0,8($9)
	sw	$0,0($13)
	sw	$0,0($19)
	sw	$0,0($18)
	sw	$0,0($17)
	sw	$0,12($14)
	sw	$0,0($14)
	sw	$0,4($14)
	sw	$0,8($14)
$L269:
	lw	$3,1652($8)
	lbu	$9,9468($6)
	addu	$3,$3,$25
	sb	$9,0($3)
	lbu	$9,9470($6)
	sb	$9,1($3)
	lw	$9,9752($4)
	lbu	$13,9484($6)
	addu	$9,$3,$9
	sb	$13,0($9)
	lw	$13,9752($4)
	lbu	$9,9486($6)
	addu	$3,$3,$13
	sb	$9,1($3)
	lw	$19,48($sp)
	lw	$3,5944($19)
$L268:
	addiu	$2,$2,1
	sltu	$13,$2,$3
	addiu	$8,$8,4
	addiu	$6,$6,40
	addiu	$11,$11,4
	bne	$13,$0,$L271
	move	$9,$2

$L267:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$6,-6284($2)
	li	$3,3			# 0x3
	beq	$6,$3,$L276
	lw	$fp,108($sp)

$L277:
	lw	$23,104($sp)
$L278:
	lw	$22,100($sp)
	lw	$21,96($sp)
	lw	$20,92($sp)
	lw	$19,88($sp)
	lw	$18,84($sp)
	lw	$17,80($sp)
	lw	$16,76($sp)
	j	$31
	addiu	$sp,$sp,112

$L275:
	addu	$fp,$24,$fp
	lw	$21,4($fp)
	lw	$20,0($fp)
	lw	$3,0($11)
	sw	$21,12($sp)
	lw	$21,40($sp)
	sw	$20,8($sp)
	addu	$13,$3,$21
	lw	$20,8($sp)
	lw	$21,12($sp)
	sw	$20,0($13)
	sw	$21,4($13)
	addu	$23,$24,$23
	lw	$21,4($23)
	lw	$20,0($23)
	sw	$21,12($sp)
	lw	$21,44($sp)
	sw	$20,8($sp)
	addu	$13,$3,$21
	lw	$20,8($sp)
	lw	$21,12($sp)
	sw	$20,0($13)
	sw	$21,4($13)
	addu	$22,$24,$22
	lw	$13,60($sp)
	lw	$23,4($22)
	lw	$19,56($sp)
	lw	$22,0($22)
	addu	$21,$3,$13
	sw	$22,0($21)
	sw	$23,4($21)
	addu	$20,$24,$19
	lw	$13,64($sp)
	lw	$21,4($20)
	lw	$20,0($20)
	addu	$19,$3,$13
	sw	$20,0($19)
	sw	$21,4($19)
	lw	$19,4($18)
	lw	$18,0($18)
	addu	$17,$3,$17
	sw	$18,0($17)
	sw	$19,4($17)
	lw	$17,32($sp)
	lw	$20,36($sp)
	addu	$13,$24,$17
	lw	$18,0($13)
	lw	$19,4($13)
	lw	$21,16($sp)
	addu	$13,$3,$20
	sw	$18,0($13)
	sw	$19,4($13)
	addu	$13,$24,$21
	lw	$19,4($13)
	lw	$18,0($13)
	addu	$16,$3,$16
	sw	$19,4($16)
	sw	$18,0($16)
	addu	$14,$24,$14
	lw	$16,0($14)
	lw	$17,4($14)
	addu	$9,$3,$9
	sw	$16,0($9)
	sw	$17,4($9)
	lw	$3,1652($8)
	lbu	$9,9468($6)
	addu	$3,$3,$25
	sb	$9,0($3)
	lbu	$9,9470($6)
	sb	$9,1($3)
	lw	$9,9752($4)
	lbu	$13,9484($6)
	addu	$9,$3,$9
	sb	$13,0($9)
	lw	$13,9752($4)
	lbu	$9,9486($6)
	addu	$3,$3,$13
	sb	$9,1($3)
	lw	$19,48($sp)
	b	$L268
	lw	$3,5944($19)

$L276:
	lw	$3,11808($4)
	beq	$3,$0,$L277
	nop

	andi	$5,$5,0x40
	beq	$5,$0,$L278
	lw	$23,104($sp)

	li	$5,131072			# 0x20000
	lw	$3,-6260($2)
	addu	$5,$4,$5
	lw	$5,9016($5)
	srl	$3,$3,8
	addu	$25,$5,$25
	andi	$3,$3,0x1
	sb	$3,1($25)
	lw	$5,-6256($2)
	lw	$3,9752($4)
	srl	$5,$5,8
	addu	$3,$25,$3
	andi	$5,$5,0x1
	sb	$5,0($3)
	lw	$2,-6252($2)
	lw	$3,9752($4)
	srl	$2,$2,8
	addu	$25,$25,$3
	andi	$2,$2,0x1
	sb	$2,1($25)
	lw	$fp,108($sp)
	lw	$23,104($sp)
	lw	$22,100($sp)
	lw	$21,96($sp)
	lw	$20,92($sp)
	lw	$19,88($sp)
	lw	$18,84($sp)
	lw	$17,80($sp)
	lw	$16,76($sp)
	j	$31
	addiu	$sp,$sp,112

	.set	macro
	.set	reorder
	.end	write_back_motion
	.size	write_back_motion, .-write_back_motion
	.align	2
	.set	nomips16
	.ent	xchg_mb_border
	.type	xchg_mb_border, @function
xchg_mb_border:
	.frame	$sp,8,$31		# vars= 0, regs= 2/0, args= 0, gp= 0
	.mask	0x00030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$3,5340($2)
	addiu	$sp,$sp,-8
	li	$8,2			# 0x2
	sw	$17,4($sp)
	sw	$16,0($sp)
	lw	$10,24($sp)
	lw	$9,28($sp)
	beq	$3,$8,$L300
	lw	$24,32($sp)

	lw	$15,6168($4)
	lw	$14,6172($4)
	slt	$15,$0,$15
	slt	$14,$0,$14
$L281:
	nor	$2,$0,$10
	beq	$15,$0,$L282
	addu	$5,$5,$2

	bne	$24,$0,$L283
	xori	$2,$14,0x1

	mul	$11,$2,$10
	addu	$3,$4,$2
	addu	$8,$11,$5
	addiu	$3,$3,9004
$L284:
	lbu	$12,0($3)
	addiu	$2,$2,1
	slt	$11,$2,17
	sb	$12,0($8)
	addiu	$3,$3,1
	bne	$11,$0,$L284
	addu	$8,$8,$10

$L282:
	beq	$14,$0,$L303
	lw	$2,36($sp)

	lw	$2,6168($4)
	lw	$3,8996($4)
	sll	$8,$2,5
	addu	$8,$3,$8
	lw	$12,0($8)
	bne	$24,$0,$L287
	lw	$13,4($8)

	addiu	$10,$5,1
$L288:
	sll	$8,$2,5
	addiu	$8,$8,8
	sw	$12,0($10)
	sw	$13,4($10)
	addu	$8,$3,$8
	lw	$10,144($4)
	lw	$12,0($8)
	lw	$13,4($8)
	lw	$16,9($5)
	lw	$17,13($5)
	addiu	$2,$2,1
	slt	$10,$2,$10
	sw	$16,0($8)
	sw	$17,4($8)
	sw	$12,9($5)
	beq	$10,$0,$L286
	sw	$13,13($5)

	sll	$2,$2,5
	addu	$3,$3,$2
	lw	$10,0($3)
	lw	$11,4($3)
	lw	$12,17($5)
	lw	$13,21($5)
	sw	$12,0($3)
	sw	$13,4($3)
	sw	$10,17($5)
	sw	$11,21($5)
$L286:
	lw	$2,36($sp)
$L303:
	bne	$2,$0,$L304
	nor	$2,$0,$9

	lw	$2,56($4)
	andi	$2,$2,0x2000
	bne	$2,$0,$L295
	nor	$2,$0,$9

$L304:
	addu	$7,$7,$2
	beq	$15,$0,$L291
	addu	$6,$6,$2

	bne	$24,$0,$L292
	xori	$2,$14,0x1

	mul	$5,$2,$9
	addu	$3,$4,$2
	addu	$8,$7,$5
	addiu	$3,$3,9021
	addu	$5,$6,$5
$L293:
	lbu	$10,0($3)
	addiu	$2,$2,1
	sb	$10,0($5)
	lbu	$11,9($3)
	slt	$10,$2,9
	sb	$11,0($8)
	addiu	$3,$3,1
	addu	$5,$5,$9
	bne	$10,$0,$L293
	addu	$8,$8,$9

$L291:
	beq	$14,$0,$L302
	lw	$17,4($sp)

$L301:
	lw	$2,6168($4)
	lw	$3,8996($4)
	sll	$4,$2,5
	addiu	$4,$4,16
	addu	$4,$3,$4
	lw	$8,0($4)
	lw	$9,4($4)
	lw	$10,1($6)
	lw	$11,5($6)
	sll	$2,$2,5
	addiu	$2,$2,24
	sw	$10,0($4)
	sw	$11,4($4)
	addu	$2,$3,$2
	sw	$8,1($6)
	sw	$9,5($6)
	lw	$4,0($2)
	lw	$5,4($2)
	lw	$8,1($7)
	lw	$9,5($7)
	sw	$8,0($2)
	sw	$9,4($2)
	sw	$4,1($7)
	sw	$5,5($7)
$L295:
	lw	$17,4($sp)
$L302:
	lw	$16,0($sp)
$L305:
	j	$31
	addiu	$sp,$sp,8

$L287:
	lw	$16,1($5)
	lw	$17,5($5)
	addiu	$10,$5,1
	sw	$16,0($8)
	b	$L288
	sw	$17,4($8)

$L283:
	mul	$11,$2,$10
	addu	$3,$4,$2
	addu	$8,$11,$5
	addiu	$3,$3,9004
$L285:
	lbu	$12,0($3)
	lbu	$13,0($8)
	addiu	$2,$2,1
	slt	$11,$2,17
	sb	$13,0($3)
	sb	$12,0($8)
	addiu	$3,$3,1
	bne	$11,$0,$L285
	addu	$8,$8,$10

	b	$L282
	nop

$L300:
	lw	$3,6172($4)
	lw	$11,152($4)
	lw	$8,6168($4)
	mul	$12,$11,$3
	lw	$2,-6288($2)
	addu	$3,$12,$8
	lw	$8,8764($4)
	addu	$3,$2,$3
	addu	$2,$2,$8
	lbu	$15,-1($3)
	lbu	$14,0($2)
	lbu	$2,0($3)
	xor	$14,$14,$2
	xor	$2,$15,$2
	sltu	$15,$2,1
	b	$L281
	sltu	$14,$14,1

$L292:
	mul	$5,$2,$9
	addu	$3,$4,$2
	addu	$8,$7,$5
	addiu	$3,$3,9021
	addu	$5,$6,$5
$L294:
	lbu	$11,0($5)
	lbu	$10,0($3)
	sb	$11,0($3)
	sb	$10,0($5)
	lbu	$11,9($3)
	lbu	$12,0($8)
	addiu	$2,$2,1
	slt	$10,$2,9
	sb	$12,9($3)
	addu	$5,$5,$9
	sb	$11,0($8)
	addiu	$3,$3,1
	bne	$10,$0,$L294
	addu	$8,$8,$9

	bne	$14,$0,$L301
	lw	$17,4($sp)

	b	$L305
	lw	$16,0($sp)

	.set	macro
	.set	reorder
	.end	xchg_mb_border
	.size	xchg_mb_border, .-xchg_mb_border
	.align	2
	.set	nomips16
	.ent	xchg_pair_border
	.type	xchg_pair_border, @function
xchg_pair_border:
	.frame	$sp,16,$31		# vars= 0, regs= 4/0, args= 0, gp= 0
	.mask	0x000f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-16
	lw	$2,32($sp)
	lw	$3,6168($4)
	lw	$8,6172($4)
	sll	$9,$2,1
	slt	$8,$8,2
	nor	$9,$0,$9
	slt	$3,$0,$3
	sw	$19,12($sp)
	sw	$18,8($sp)
	sw	$17,4($sp)
	sw	$16,0($sp)
	addu	$5,$5,$9
	xori	$8,$8,0x1
	lw	$12,36($sp)
	beq	$3,$0,$L307
	lw	$24,40($sp)

	li	$9,2			# 0x2
	bne	$24,$0,$L310
	movn	$9,$0,$8

	mul	$13,$9,$2
	addu	$10,$4,$9
	addu	$11,$13,$5
	addiu	$10,$10,9004
$L311:
	lbu	$14,0($10)
	addiu	$9,$9,1
	slt	$13,$9,34
	sb	$14,0($11)
	addiu	$10,$10,1
	bne	$13,$0,$L311
	addu	$11,$11,$2

$L307:
	beq	$8,$0,$L313
	nop

	lw	$9,6168($4)
	lw	$11,8996($4)
	sll	$10,$9,5
	addu	$10,$11,$10
	lw	$16,0($10)
	bne	$24,$0,$L314
	lw	$17,4($10)

	addiu	$14,$5,1
$L315:
	sll	$13,$9,5
	addiu	$13,$13,8
	sw	$16,0($14)
	sw	$17,4($14)
	addu	$13,$11,$13
	lw	$16,0($13)
	lw	$17,4($13)
	lw	$18,9($5)
	lw	$19,13($5)
	lw	$10,9000($4)
	sll	$14,$9,5
	sw	$18,0($13)
	sw	$19,4($13)
	sw	$16,9($5)
	sw	$17,13($5)
	addu	$13,$10,$14
	lw	$16,0($13)
	bne	$24,$0,$L316
	lw	$17,4($13)

	addiu	$15,$2,1
	addu	$15,$5,$15
$L317:
	sll	$14,$9,5
	addiu	$14,$14,8
	addiu	$13,$2,9
	sw	$16,0($15)
	sw	$17,4($15)
	addu	$14,$10,$14
	addu	$13,$5,$13
	lw	$15,144($4)
	lw	$16,0($14)
	lw	$17,4($14)
	lw	$18,0($13)
	lw	$19,4($13)
	addiu	$9,$9,1
	slt	$15,$9,$15
	sw	$18,0($14)
	sw	$19,4($14)
	sw	$16,0($13)
	beq	$15,$0,$L313
	sw	$17,4($13)

	sll	$9,$9,5
	addu	$11,$11,$9
	lw	$14,0($11)
	lw	$15,4($11)
	lw	$16,17($5)
	lw	$17,21($5)
	addiu	$2,$2,17
	sw	$16,0($11)
	sw	$17,4($11)
	addu	$10,$10,$9
	sw	$14,17($5)
	sw	$15,21($5)
	addu	$5,$5,$2
	lw	$14,0($10)
	lw	$15,4($10)
	lw	$16,0($5)
	lw	$17,4($5)
	sw	$16,0($10)
	sw	$17,4($10)
	sw	$14,0($5)
	sw	$15,4($5)
$L313:
	lw	$2,56($4)
	andi	$2,$2,0x2000
	bne	$2,$0,$L325
	sll	$2,$12,1

	nor	$2,$0,$2
	addu	$7,$7,$2
	beq	$3,$0,$L319
	addu	$6,$6,$2

	li	$2,2			# 0x2
	bne	$24,$0,$L322
	movn	$2,$0,$8

	mul	$5,$2,$12
	addu	$3,$4,$2
	addu	$9,$7,$5
	addiu	$3,$3,9038
	addu	$5,$6,$5
$L323:
	lbu	$10,0($3)
	addiu	$2,$2,1
	sb	$10,0($5)
	lbu	$11,18($3)
	slt	$10,$2,18
	sb	$11,0($9)
	addiu	$3,$3,1
	addu	$5,$5,$12
	bne	$10,$0,$L323
	addu	$9,$9,$12

$L319:
	beq	$8,$0,$L331
	lw	$19,12($sp)

$L330:
	lw	$2,6168($4)
	lw	$5,8996($4)
	sll	$3,$2,5
	addiu	$3,$3,16
	addu	$8,$5,$3
	lw	$10,0($8)
	lw	$11,4($8)
	lw	$14,1($6)
	lw	$15,5($6)
	sll	$2,$2,5
	addiu	$2,$2,24
	sw	$14,0($8)
	sw	$15,4($8)
	addu	$5,$5,$2
	sw	$10,1($6)
	sw	$11,5($6)
	lw	$8,0($5)
	lw	$9,4($5)
	lw	$10,1($7)
	lw	$11,5($7)
	lw	$4,9000($4)
	addiu	$12,$12,1
	sw	$10,0($5)
	sw	$11,4($5)
	addu	$3,$4,$3
	sw	$8,1($7)
	sw	$9,5($7)
	addu	$6,$6,$12
	lw	$8,0($3)
	lw	$9,4($3)
	lw	$10,0($6)
	lw	$11,4($6)
	addu	$2,$4,$2
	sw	$10,0($3)
	sw	$11,4($3)
	addu	$7,$7,$12
	sw	$8,0($6)
	sw	$9,4($6)
	lw	$5,4($2)
	lw	$8,0($7)
	lw	$9,4($7)
	lw	$4,0($2)
	sw	$9,4($2)
	sw	$8,0($2)
	sw	$4,0($7)
	sw	$5,4($7)
$L325:
	lw	$19,12($sp)
$L331:
	lw	$18,8($sp)
$L332:
	lw	$17,4($sp)
	lw	$16,0($sp)
	j	$31
	addiu	$sp,$sp,16

$L314:
	lw	$18,1($5)
	lw	$19,5($5)
	addiu	$14,$5,1
	sw	$18,0($10)
	b	$L315
	sw	$19,4($10)

$L310:
	mul	$13,$9,$2
	addu	$10,$4,$9
	addu	$11,$13,$5
	addiu	$10,$10,9004
$L312:
	lbu	$14,0($10)
	lbu	$15,0($11)
	addiu	$9,$9,1
	slt	$13,$9,34
	sb	$15,0($10)
	sb	$14,0($11)
	addiu	$10,$10,1
	bne	$13,$0,$L312
	addu	$11,$11,$2

	b	$L307
	nop

$L316:
	addiu	$15,$2,1
	addu	$15,$5,$15
	lw	$18,0($15)
	lw	$19,4($15)
	sw	$18,0($13)
	b	$L317
	sw	$19,4($13)

$L322:
	mul	$5,$2,$12
	addu	$3,$4,$2
	addu	$9,$7,$5
	addiu	$3,$3,9038
	addu	$5,$6,$5
$L324:
	lbu	$11,0($5)
	lbu	$10,0($3)
	sb	$11,0($3)
	sb	$10,0($5)
	lbu	$11,18($3)
	lbu	$13,0($9)
	addiu	$2,$2,1
	slt	$10,$2,18
	sb	$13,18($3)
	addu	$5,$5,$12
	sb	$11,0($9)
	addiu	$3,$3,1
	bne	$10,$0,$L324
	addu	$9,$9,$12

	bne	$8,$0,$L330
	lw	$19,12($sp)

	b	$L332
	lw	$18,8($sp)

	.set	macro
	.set	reorder
	.end	xchg_pair_border
	.size	xchg_pair_border, .-xchg_pair_border
	.align	2
	.set	nomips16
	.ent	flush_dpb
	.type	flush_dpb, @function
flush_dpb:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$9,136($4)
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$2,5952($2)
	beq	$2,$0,$L334
	nop

	sw	$0,80($2)
$L334:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,5956($2)
	beq	$3,$0,$L335
	sw	$0,5952($2)

	sw	$0,80($3)
$L335:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,5960($2)
	beq	$3,$0,$L336
	sw	$0,5956($2)

	sw	$0,80($3)
$L336:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,5964($2)
	beq	$3,$0,$L337
	sw	$0,5960($2)

	sw	$0,80($3)
$L337:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,5968($2)
	beq	$3,$0,$L338
	sw	$0,5964($2)

	sw	$0,80($3)
$L338:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,5972($2)
	beq	$3,$0,$L339
	sw	$0,5968($2)

	sw	$0,80($3)
$L339:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,5976($2)
	beq	$3,$0,$L340
	sw	$0,5972($2)

	sw	$0,80($3)
$L340:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,5980($2)
	beq	$3,$0,$L341
	sw	$0,5976($2)

	sw	$0,80($3)
$L341:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,5984($2)
	beq	$3,$0,$L342
	sw	$0,5980($2)

	sw	$0,80($3)
$L342:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,5988($2)
	beq	$3,$0,$L343
	sw	$0,5984($2)

	sw	$0,80($3)
$L343:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,5992($2)
	beq	$3,$0,$L344
	sw	$0,5988($2)

	sw	$0,80($3)
$L344:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,5996($2)
	beq	$3,$0,$L345
	sw	$0,5992($2)

	sw	$0,80($3)
$L345:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,6000($2)
	beq	$3,$0,$L346
	sw	$0,5996($2)

	sw	$0,80($3)
$L346:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,6004($2)
	beq	$3,$0,$L347
	sw	$0,6000($2)

	sw	$0,80($3)
$L347:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,6008($2)
	beq	$3,$0,$L348
	sw	$0,6004($2)

	sw	$0,80($3)
$L348:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,6012($2)
	beq	$3,$0,$L349
	sw	$0,6008($2)

	sw	$0,80($3)
$L349:
	li	$2,131072			# 0x20000
	addu	$2,$9,$2
	lw	$3,6024($2)
	beq	$3,$0,$L350
	sw	$0,6012($2)

	sw	$0,80($3)
$L350:
	li	$6,131072			# 0x20000
	li	$5,65536			# 0x10000
	ori	$7,$5,0x17fc
	ori	$8,$6,0x1744
	ori	$5,$5,0x17bc
	addu	$6,$9,$6
	sw	$0,6024($6)
	addu	$5,$9,$5
	addu	$7,$9,$7
	addu	$8,$9,$8
	li	$10,4			# 0x4
$L358:
	lw	$4,0($5)
	beq	$4,$0,$L351
	nop

	lw	$2,6024($6)
	beq	$4,$2,$L354
	sw	$0,80($4)

	lw	$2,5952($6)
	beq	$2,$0,$L353
	nop

	beq	$4,$2,$L354
	nop

	b	$L356
	move	$2,$8

$L357:
	beq	$4,$3,$L354
	nop

$L356:
	lw	$3,0($2)
	bne	$3,$0,$L357
	addiu	$2,$2,4

$L353:
	sw	$0,0($5)
$L351:
	addiu	$5,$5,4
	bne	$5,$7,$L358
	nop

	li	$10,131072			# 0x20000
	addu	$7,$9,$10
	lw	$2,6828($7)
	blez	$2,$L359
	sw	$0,6824($7)

	li	$5,65536			# 0x10000
	ori	$10,$10,0x1744
	ori	$5,$5,0x173c
	lw	$8,6024($7)
	addu	$5,$9,$5
	addu	$10,$9,$10
	move	$6,$0
	li	$11,4			# 0x4
$L366:
	lw	$4,0($5)
	beq	$4,$8,$L360
	sw	$0,80($4)

	lw	$2,5952($7)
	beq	$2,$0,$L361
	nop

	beq	$4,$2,$L362
	move	$2,$10

	b	$L377
	lw	$3,0($2)

$L365:
	beq	$4,$3,$L362
	nop

	lw	$3,0($2)
$L377:
	bne	$3,$0,$L365
	addiu	$2,$2,4

$L361:
	lw	$2,6828($7)
	addiu	$6,$6,1
	slt	$2,$6,$2
	sw	$0,0($5)
	bne	$2,$0,$L366
	addiu	$5,$5,4

$L359:
	lw	$2,1880($9)
$L375:
	li	$3,131072			# 0x20000
	addu	$9,$9,$3
	beq	$2,$0,$L376
	sw	$0,6828($9)

	sw	$0,80($2)
$L376:
	j	$31
	nop

$L362:
	sw	$11,80($4)
	lw	$2,6828($7)
	addiu	$6,$6,1
	slt	$2,$6,$2
	sw	$0,0($5)
	bne	$2,$0,$L366
	addiu	$5,$5,4

	b	$L375
	lw	$2,1880($9)

$L354:
	b	$L353
	sw	$10,80($4)

$L360:
	sw	$11,80($8)
	lw	$2,6828($7)
	addiu	$6,$6,1
	slt	$2,$6,$2
	sw	$0,0($5)
	bne	$2,$0,$L366
	addiu	$5,$5,4

	b	$L375
	lw	$2,1880($9)

	.set	macro
	.set	reorder
	.end	flush_dpb
	.size	flush_dpb, .-flush_dpb
	.align	2
	.set	nomips16
	.ent	predict_field_decoding_flag
	.type	predict_field_decoding_flag, @function
predict_field_decoding_flag:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$6,6172($4)
	lw	$5,152($4)
	lw	$2,6168($4)
	mul	$3,$5,$6
	addu	$6,$3,$2
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$3,-6288($2)
	addiu	$7,$6,-1
	addu	$8,$3,$7
	lw	$2,-6296($2)
	lbu	$8,0($8)
	beq	$8,$2,$L383
	subu	$5,$6,$5

	addu	$3,$3,$5
	lbu	$3,0($3)
	beq	$2,$3,$L381
	li	$3,65536			# 0x10000

	move	$2,$0
	addu	$4,$4,$3
	sw	$2,-6268($4)
	j	$31
	sw	$2,-6272($4)

$L381:
	lw	$6,1568($4)
	sll	$5,$5,2
	addu	$5,$6,$5
	lw	$2,0($5)
	srl	$2,$2,7
	andi	$2,$2,0x1
	addu	$4,$4,$3
	sw	$2,-6268($4)
	j	$31
	sw	$2,-6272($4)

$L383:
	lw	$2,1568($4)
	sll	$7,$7,2
	addu	$7,$2,$7
	lw	$2,0($7)
	li	$3,65536			# 0x10000
	srl	$2,$2,7
	andi	$2,$2,0x1
	addu	$4,$4,$3
	sw	$2,-6268($4)
	j	$31
	sw	$2,-6272($4)

	.set	macro
	.set	reorder
	.end	predict_field_decoding_flag
	.size	predict_field_decoding_flag, .-predict_field_decoding_flag
	.align	2
	.set	nomips16
	.ent	decode_cabac_intra_mb_type
	.type	decode_cabac_intra_mb_type, @function
decode_cabac_intra_mb_type:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 16, gp= 8
	.mask	0x800f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-48
	li	$2,131072			# 0x20000
	sw	$17,32($sp)
	ori	$17,$2,0x2000
	addu	$17,$5,$17
	addu	$17,$4,$17
	sw	$18,36($sp)
	sw	$16,28($sp)
	sw	$31,44($sp)
	sw	$19,40($sp)
	move	$16,$4
	move	$18,$6
	beq	$6,$0,$L385
	addiu	$17,$17,4

	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$3,-6288($2)
	lw	$5,8768($4)
	lw	$2,-6296($2)
	addu	$4,$3,$5
	lbu	$6,0($4)
	beq	$6,$2,$L386
	lw	$4,8764($16)

	addu	$3,$3,$4
	lbu	$3,0($3)
	beq	$2,$3,$L397
	move	$5,$0

$L388:
	li	$4,131072			# 0x20000
	ori	$4,$4,0x1fd8
	addu	$4,$16,$4
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	addu	$5,$17,$5

	beq	$2,$0,$L389
	addiu	$17,$17,2

	li	$2,131072			# 0x20000
$L399:
	addu	$2,$16,$2
	lw	$5,8156($2)
	lw	$4,8152($2)
	addiu	$3,$5,-2
	sll	$6,$3,17
	slt	$6,$4,$6
	beq	$6,$0,$L391
	sw	$3,8156($2)

	addiu	$5,$5,-258
	srl	$5,$5,31
	sll	$4,$4,$5
	sll	$3,$3,$5
	andi	$6,$4,0xffff
	sw	$3,8156($2)
	bne	$6,$0,$L392
	sw	$4,8152($2)

	lw	$3,8168($2)
	li	$5,-65536			# 0xffffffffffff0000
	lbu	$7,0($3)
	lbu	$6,1($3)
	sll	$7,$7,9
	ori	$5,$5,0x1
	addu	$5,$7,$5
	sll	$6,$6,1
	addu	$5,$5,$6
	addu	$4,$5,$4
	addiu	$3,$3,2
	sw	$3,8168($2)
	sw	$4,8152($2)
$L392:
	li	$2,131072			# 0x20000
	ori	$2,$2,0x1fd8
	addu	$16,$16,$2
	move	$4,$16
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	addiu	$5,$17,1

	sll	$19,$2,4
	move	$4,$16
	sll	$2,$2,2
	addiu	$5,$17,2
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	subu	$19,$19,$2

	bne	$2,$0,$L398
	addiu	$19,$19,1

$L395:
	addiu	$5,$18,3
	addu	$5,$17,$5
	move	$4,$16
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	sll	$18,$18,1

	addiu	$5,$18,3
	addu	$5,$17,$5
	move	$4,$16
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$16,$2

	lw	$31,44($sp)
	addu	$2,$2,$19
	sll	$16,$16,1
	addu	$2,$2,$16
	lw	$19,40($sp)
	lw	$18,36($sp)
	lw	$17,32($sp)
	lw	$16,28($sp)
	j	$31
	addiu	$sp,$sp,48

$L385:
	ori	$2,$2,0x1fd8
	addu	$4,$4,$2
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$5,$17

	bne	$2,$0,$L399
	li	$2,131072			# 0x20000

$L389:
	lw	$31,44($sp)
	move	$2,$0
	lw	$19,40($sp)
	lw	$18,36($sp)
	lw	$17,32($sp)
	lw	$16,28($sp)
	j	$31
	addiu	$sp,$sp,48

$L391:
	lw	$3,8164($2)
	lw	$2,8168($2)
	beq	$2,$3,$L392
	lw	$31,44($sp)

	li	$2,25			# 0x19
	lw	$19,40($sp)
	lw	$18,36($sp)
	lw	$17,32($sp)
	lw	$16,28($sp)
	j	$31
	addiu	$sp,$sp,48

$L398:
	addiu	$5,$18,2
	addu	$5,$17,$5
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$16

	addiu	$2,$2,1
	sll	$2,$2,2
	b	$L395
	addu	$19,$19,$2

$L386:
	lw	$6,1568($16)
	sll	$5,$5,2
	addu	$5,$6,$5
	lw	$5,0($5)
	addu	$3,$3,$4
	lbu	$3,0($3)
	andi	$5,$5,0x1
	bne	$2,$3,$L388
	xori	$5,$5,0x1

$L397:
	lw	$2,1568($16)
	sll	$4,$4,2
	addu	$4,$2,$4
	lw	$3,0($4)
	addiu	$2,$5,1
	andi	$3,$3,0x1
	b	$L388
	movz	$5,$2,$3

	.set	macro
	.set	reorder
	.end	decode_cabac_intra_mb_type
	.size	decode_cabac_intra_mb_type, .-decode_cabac_intra_mb_type
	.align	2
	.set	nomips16
	.ent	filter_mb_edgev
	.type	filter_mb_edgev, @function
filter_mb_edgev:
	.frame	$sp,80,$31		# vars= 8, regs= 9/0, args= 24, gp= 8
	.mask	0x80ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	li	$2,65536			# 0x10000
	addiu	$sp,$sp,-80
	addu	$2,$4,$2
	lw	$3,96($sp)
	lw	$10,5348($2)
	lw	$8,5344($2)
	addu	$10,$3,$10
	addu	$8,$3,$8
	lh	$9,0($7)
	lui	$2,%hi(beta_table+52)
	lui	$3,%hi(alpha_table+52)
	addiu	$2,$2,%lo(beta_table+52)
	addiu	$3,$3,%lo(alpha_table+52)
	sw	$31,76($sp)
	sw	$23,72($sp)
	sw	$22,68($sp)
	sw	$21,64($sp)
	sw	$20,60($sp)
	sw	$19,56($sp)
	sw	$18,52($sp)
	sw	$17,48($sp)
	sw	$16,44($sp)
	addu	$2,$2,$10
	addu	$3,$3,$8
	slt	$10,$9,4
	lbu	$3,0($3)
	beq	$10,$0,$L401
	lbu	$2,0($2)

	sll	$10,$8,1
	addu	$8,$10,$8
	lui	$10,%hi(tc0_table)
	addiu	$8,$8,156
	addiu	$10,$10,%lo(tc0_table)
	bne	$9,$0,$L402
	addu	$8,$10,$8

	lh	$9,2($7)
	li	$10,-1			# 0xffffffffffffffff
	bne	$9,$0,$L404
	sb	$10,32($sp)

$L425:
	lh	$9,4($7)
	li	$10,-1			# 0xffffffffffffffff
	bne	$9,$0,$L406
	sb	$10,33($sp)

$L426:
	lh	$7,6($7)
	li	$9,-1			# 0xffffffffffffffff
	bne	$7,$0,$L408
	sb	$9,34($sp)

$L427:
	li	$7,-1			# 0xffffffffffffffff
$L409:
	lw	$25,4960($4)
	addiu	$4,$sp,32
	sb	$7,35($sp)
	sw	$4,16($sp)
	move	$7,$2
	move	$4,$5
	move	$5,$6
	jalr	$25
	move	$6,$3

$L422:
	lw	$31,76($sp)
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

$L401:
	sra	$20,$3,2
	addiu	$20,$20,1
	move	$7,$0
	li	$24,16			# 0x10
	lbu	$9,-1($5)
$L428:
	lbu	$10,0($5)
	addiu	$15,$5,-1
	subu	$4,$9,$10
	subu	$8,$0,$4
	slt	$11,$4,0
	movn	$4,$8,$11
	slt	$8,$4,$3
	addiu	$18,$5,-2
	lbu	$11,-2($5)
	addiu	$17,$5,-3
	lbu	$14,-3($5)
	addiu	$16,$5,1
	lbu	$12,1($5)
	addiu	$25,$5,2
	beq	$8,$0,$L412
	lbu	$13,2($5)

	subu	$8,$11,$9
	subu	$19,$0,$8
	slt	$21,$8,0
	movn	$8,$19,$21
	slt	$8,$8,$2
	beq	$8,$0,$L412
	subu	$8,$12,$10

	subu	$19,$0,$8
	slt	$21,$8,0
	movn	$8,$19,$21
	slt	$8,$8,$2
	beq	$8,$0,$L412
	slt	$4,$20,$4

	bne	$4,$0,$L415
	subu	$4,$14,$9

	subu	$8,$0,$4
	slt	$19,$4,0
	movn	$4,$8,$19
	slt	$4,$4,$2
	bne	$4,$0,$L423
	addiu	$23,$10,4

	addu	$4,$9,$12
	sll	$8,$11,1
	addiu	$4,$4,2
	addu	$4,$4,$8
	sra	$4,$4,2
	sb	$4,0($15)
	subu	$4,$13,$10
	subu	$8,$0,$4
	slt	$14,$4,0
	movn	$4,$8,$14
	slt	$4,$4,$2
	beq	$4,$0,$L419
	nop

$L424:
	lbu	$4,3($5)
	addiu	$8,$10,4
	addu	$8,$8,$9
	addu	$9,$9,$12
	addu	$10,$9,$10
	addu	$12,$8,$12
	sll	$9,$13,1
	addu	$8,$11,$13
	sll	$4,$4,1
	addu	$4,$12,$4
	addu	$9,$9,$13
	sll	$12,$10,1
	addiu	$8,$8,4
	addiu	$13,$13,2
	addu	$8,$8,$12
	addu	$10,$13,$10
	addu	$4,$4,$9
	sra	$8,$8,3
	sra	$10,$10,2
	sra	$4,$4,3
	sb	$8,0($5)
	sb	$10,0($16)
	sb	$4,0($25)
$L412:
	addiu	$7,$7,1
	beq	$7,$24,$L422
	addu	$5,$5,$6

	b	$L428
	lbu	$9,-1($5)

$L415:
	addu	$9,$9,$12
	addiu	$10,$10,2
	addu	$10,$10,$11
	addiu	$9,$9,2
	sll	$12,$12,1
	sll	$11,$11,1
	addu	$11,$9,$11
	addu	$12,$10,$12
	sra	$11,$11,2
	sra	$12,$12,2
	sb	$11,0($15)
	b	$L412
	sb	$12,0($5)

$L423:
	lbu	$4,-4($5)
	addu	$23,$23,$9
	addu	$8,$9,$11
	addiu	$19,$10,2
	addu	$22,$14,$12
	sll	$21,$14,1
	addu	$8,$8,$10
	addu	$19,$19,$9
	addu	$23,$23,$11
	sll	$4,$4,1
	addu	$21,$21,$14
	addu	$4,$23,$4
	addiu	$22,$22,4
	sll	$8,$8,1
	addu	$19,$19,$11
	addu	$8,$22,$8
	addu	$4,$4,$21
	addu	$14,$19,$14
	sra	$8,$8,3
	sra	$14,$14,2
	sra	$4,$4,3
	sb	$8,0($15)
	sb	$14,0($18)
	sb	$4,0($17)
	subu	$4,$13,$10
	subu	$8,$0,$4
	slt	$14,$4,0
	movn	$4,$8,$14
	slt	$4,$4,$2
	bne	$4,$0,$L424
	nop

$L419:
	addiu	$10,$10,2
	addu	$11,$10,$11
	sll	$12,$12,1
	addu	$11,$11,$12
	sra	$11,$11,2
	b	$L412
	sb	$11,0($5)

$L402:
	addu	$9,$8,$9
	lb	$10,-1($9)
	lh	$9,2($7)
	beq	$9,$0,$L425
	sb	$10,32($sp)

$L404:
	addu	$9,$8,$9
	lb	$10,-1($9)
	lh	$9,4($7)
	beq	$9,$0,$L426
	sb	$10,33($sp)

$L406:
	addu	$9,$8,$9
	lb	$9,-1($9)
	lh	$7,6($7)
	beq	$7,$0,$L427
	sb	$9,34($sp)

$L408:
	addu	$8,$8,$7
	b	$L409
	lb	$7,-1($8)

	.set	macro
	.set	reorder
	.end	filter_mb_edgev
	.size	filter_mb_edgev, .-filter_mb_edgev
	.align	2
	.set	nomips16
	.ent	filter_mb_edgecv
	.type	filter_mb_edgecv, @function
filter_mb_edgecv:
	.frame	$sp,48,$31		# vars= 8, regs= 1/0, args= 24, gp= 8
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	li	$3,65536			# 0x10000
	addu	$3,$4,$3
	addiu	$sp,$sp,-48
	lw	$10,5348($3)
	lw	$8,5344($3)
	move	$2,$4
	lw	$4,64($sp)
	lh	$9,0($7)
	lui	$3,%hi(beta_table+52)
	lui	$11,%hi(alpha_table+52)
	addu	$10,$4,$10
	addu	$8,$4,$8
	addiu	$3,$3,%lo(beta_table+52)
	addiu	$11,$11,%lo(alpha_table+52)
	sw	$31,44($sp)
	addu	$3,$3,$10
	addu	$11,$11,$8
	slt	$10,$9,4
	move	$4,$5
	lbu	$3,0($3)
	move	$5,$6
	beq	$10,$0,$L430
	lbu	$6,0($11)

	sll	$10,$8,1
	addu	$8,$10,$8
	lui	$10,%hi(tc0_table)
	addiu	$8,$8,156
	addiu	$10,$10,%lo(tc0_table)
	bne	$9,$0,$L431
	addu	$8,$10,$8

	lh	$9,2($7)
	move	$10,$0
	bne	$9,$0,$L433
	sb	$10,32($sp)

$L441:
	move	$10,$0
$L434:
	lh	$9,4($7)
	beq	$9,$0,$L436
	sb	$10,33($sp)

	addu	$9,$8,$9
	lbu	$9,-1($9)
	addiu	$9,$9,1
	sll	$9,$9,24
	sra	$9,$9,24
$L436:
	lh	$7,6($7)
	beq	$7,$0,$L438
	sb	$9,34($sp)

	addu	$8,$8,$7
	lbu	$7,-1($8)
	addiu	$7,$7,1
	sll	$7,$7,24
	sra	$7,$7,24
$L438:
	lw	$25,4968($2)
	addiu	$2,$sp,32
	sb	$7,35($sp)
	sw	$2,16($sp)
	jalr	$25
	move	$7,$3

	lw	$31,44($sp)
	j	$31
	addiu	$sp,$sp,48

$L431:
	addu	$9,$8,$9
	lbu	$10,-1($9)
	lh	$9,2($7)
	addiu	$10,$10,1
	sll	$10,$10,24
	sra	$10,$10,24
	beq	$9,$0,$L441
	sb	$10,32($sp)

$L433:
	addu	$9,$8,$9
	lbu	$10,-1($9)
	addiu	$10,$10,1
	sll	$10,$10,24
	b	$L434
	sra	$10,$10,24

$L430:
	lw	$25,4976($2)
	jalr	$25
	move	$7,$3

	lw	$31,44($sp)
	j	$31
	addiu	$sp,$sp,48

	.set	macro
	.set	reorder
	.end	filter_mb_edgecv
	.size	filter_mb_edgecv, .-filter_mb_edgecv
	.align	2
	.set	nomips16
	.ent	filter_mb_mbaff_edgecv
	.type	filter_mb_mbaff_edgecv, @function
filter_mb_mbaff_edgecv:
	.frame	$sp,32,$31		# vars= 0, regs= 7/0, args= 0, gp= 0
	.mask	0x007f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$17,8($sp)
	sw	$16,4($sp)
	li	$3,65536			# 0x10000
	lui	$16,%hi(alpha_table+52)
	lui	$25,%hi(beta_table+52)
	lui	$17,%hi(tc0_table+156)
	lw	$2,48($sp)
	sw	$18,12($sp)
	addu	$3,$4,$3
	addiu	$10,$5,1
	addiu	$4,$5,-1
	sw	$22,28($sp)
	sw	$21,24($sp)
	sw	$20,20($sp)
	sw	$19,16($sp)
	addiu	$16,$16,%lo(alpha_table+52)
	addiu	$25,$25,%lo(beta_table+52)
	addiu	$17,$17,%lo(tc0_table+156)
	addiu	$5,$5,-2
	move	$8,$0
	li	$18,-256			# 0xffffffffffffff00
	li	$14,8			# 0x8
$L458:
	lh	$9,0($7)
	beq	$9,$0,$L443
	addiu	$11,$4,1

	lw	$12,-6272($3)
	beq	$12,$0,$L445
	andi	$12,$8,0x1

	sra	$12,$8,2
$L445:
	sll	$12,$12,2
	addu	$12,$2,$12
	lw	$12,0($12)
	lw	$15,5348($3)
	lw	$13,5344($3)
	slt	$24,$9,4
	addu	$13,$12,$13
	addu	$12,$12,$15
	addu	$12,$25,$12
	addu	$15,$16,$13
	lbu	$15,0($15)
	beq	$24,$0,$L446
	lbu	$19,0($12)

	lbu	$24,0($4)
	lbu	$20,0($11)
	sll	$21,$13,1
	subu	$12,$24,$20
	addu	$13,$21,$13
	slt	$22,$12,0
	subu	$21,$0,$12
	movn	$12,$21,$22
	addu	$13,$17,$13
	addu	$9,$13,$9
	slt	$12,$12,$15
	lbu	$21,-1($9)
	lbu	$13,0($5)
	beq	$12,$0,$L443
	lbu	$15,0($10)

	subu	$9,$13,$24
	subu	$12,$0,$9
	slt	$22,$9,0
	movn	$9,$12,$22
	slt	$9,$9,$19
	beq	$9,$0,$L443
	subu	$9,$15,$20

	subu	$12,$0,$9
	slt	$22,$9,0
	movn	$9,$12,$22
	slt	$19,$9,$19
	beq	$19,$0,$L443
	addiu	$13,$13,4

	subu	$9,$20,$24
	sll	$9,$9,2
	subu	$15,$13,$15
	addu	$15,$15,$9
	addiu	$21,$21,1
	sra	$15,$15,3
	subu	$9,$0,$21
	slt	$12,$15,$9
	beq	$12,$0,$L461
	nop

	addu	$24,$9,$24
	and	$12,$24,$18
	bne	$12,$0,$L462
	nop

$L451:
	subu	$20,$20,$9
	andi	$24,$24,0x00ff
	and	$9,$20,$18
	beq	$9,$0,$L453
	sb	$24,0($4)

$L464:
	subu	$20,$0,$20
	sra	$20,$20,31
	andi	$20,$20,0x00ff
	sb	$20,0($11)
$L443:
	addiu	$8,$8,1
	addiu	$7,$7,2
	addu	$4,$4,$6
	addu	$5,$5,$6
	bne	$8,$14,$L458
	addu	$10,$10,$6

	lw	$22,28($sp)
$L465:
	lw	$21,24($sp)
	lw	$20,20($sp)
	lw	$19,16($sp)
	lw	$18,12($sp)
	lw	$17,8($sp)
	lw	$16,4($sp)
	j	$31
	addiu	$sp,$sp,32

$L446:
	lbu	$13,0($4)
	lbu	$24,0($11)
	lbu	$21,0($5)
	subu	$9,$13,$24
	subu	$12,$0,$9
	slt	$20,$9,0
	movn	$9,$12,$20
	slt	$9,$9,$15
	beq	$9,$0,$L443
	lbu	$12,0($10)

	subu	$9,$21,$13
	subu	$15,$0,$9
	slt	$20,$9,0
	movn	$9,$15,$20
	slt	$9,$9,$19
	beq	$9,$0,$L443
	subu	$9,$12,$24

	subu	$15,$0,$9
	slt	$20,$9,0
	movn	$9,$15,$20
	slt	$19,$9,$19
	beq	$19,$0,$L443
	addu	$13,$13,$12

	addiu	$9,$21,2
	addu	$24,$9,$24
	addiu	$13,$13,2
	sll	$12,$12,1
	sll	$21,$21,1
	addu	$21,$13,$21
	addu	$12,$24,$12
	sra	$21,$21,2
	sra	$12,$12,2
	addiu	$8,$8,1
	sb	$21,0($4)
	addiu	$7,$7,2
	sb	$12,0($11)
	addu	$4,$4,$6
	addu	$5,$5,$6
	bne	$8,$14,$L458
	addu	$10,$10,$6

	b	$L465
	lw	$22,28($sp)

$L462:
	subu	$24,$0,$24
$L466:
	sra	$24,$24,31
	subu	$20,$20,$9
	andi	$24,$24,0x00ff
	and	$9,$20,$18
	bne	$9,$0,$L464
	sb	$24,0($4)

$L453:
	andi	$20,$20,0x00ff
	b	$L443
	sb	$20,0($11)

$L461:
	slt	$9,$21,$15
	movz	$21,$15,$9
	addu	$24,$21,$24
	and	$12,$24,$18
	beq	$12,$0,$L451
	move	$9,$21

	b	$L466
	subu	$24,$0,$24

	.set	macro
	.set	reorder
	.end	filter_mb_mbaff_edgecv
	.size	filter_mb_mbaff_edgecv, .-filter_mb_mbaff_edgecv
	.align	2
	.set	nomips16
	.ent	filter_mb_edgeh
	.type	filter_mb_edgeh, @function
filter_mb_edgeh:
	.frame	$sp,80,$31		# vars= 8, regs= 10/0, args= 24, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	li	$2,65536			# 0x10000
	addiu	$sp,$sp,-80
	addu	$2,$4,$2
	lw	$3,96($sp)
	lw	$10,5348($2)
	lw	$8,5344($2)
	addu	$10,$3,$10
	addu	$8,$3,$8
	lh	$9,0($7)
	lui	$2,%hi(beta_table+52)
	lui	$3,%hi(alpha_table+52)
	addiu	$2,$2,%lo(beta_table+52)
	addiu	$3,$3,%lo(alpha_table+52)
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$22,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	addu	$2,$2,$10
	addu	$3,$3,$8
	slt	$10,$9,4
	lbu	$3,0($3)
	beq	$10,$0,$L468
	lbu	$2,0($2)

	sll	$10,$8,1
	addu	$8,$10,$8
	lui	$10,%hi(tc0_table)
	addiu	$8,$8,156
	addiu	$10,$10,%lo(tc0_table)
	bne	$9,$0,$L469
	addu	$8,$10,$8

	lh	$9,2($7)
	li	$10,-1			# 0xffffffffffffffff
	bne	$9,$0,$L471
	sb	$10,32($sp)

$L492:
	lh	$9,4($7)
	li	$10,-1			# 0xffffffffffffffff
	bne	$9,$0,$L473
	sb	$10,33($sp)

$L493:
	lh	$7,6($7)
	li	$9,-1			# 0xffffffffffffffff
	bne	$7,$0,$L475
	sb	$9,34($sp)

$L494:
	li	$7,-1			# 0xffffffffffffffff
$L476:
	lw	$25,4956($4)
	addiu	$4,$sp,32
	sb	$7,35($sp)
	sw	$4,16($sp)
	move	$7,$2
	move	$4,$5
	move	$5,$6
	jalr	$25
	move	$6,$3

$L489:
	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	j	$31
	addiu	$sp,$sp,80

$L468:
	sll	$9,$6,1
	addu	$8,$9,$6
	sll	$15,$6,2
	sra	$19,$3,2
	addu	$10,$5,$9
	addu	$14,$5,$8
	subu	$7,$5,$6
	addiu	$19,$19,1
	subu	$15,$5,$15
	subu	$9,$5,$9
	subu	$8,$5,$8
	addu	$6,$5,$6
	addiu	$18,$5,15
$L488:
	lbu	$12,0($7)
	lbu	$13,0($5)
	lbu	$25,0($9)
	subu	$4,$12,$13
	subu	$11,$0,$4
	slt	$24,$4,0
	movn	$4,$11,$24
	slt	$11,$4,$3
	lbu	$17,0($8)
	lbu	$24,0($6)
	beq	$11,$0,$L479
	lbu	$16,0($10)

	subu	$11,$25,$12
	subu	$20,$0,$11
	slt	$21,$11,0
	movn	$11,$20,$21
	slt	$11,$11,$2
	beq	$11,$0,$L479
	subu	$11,$24,$13

	subu	$20,$0,$11
	slt	$21,$11,0
	movn	$11,$20,$21
	slt	$11,$11,$2
	beq	$11,$0,$L479
	slt	$4,$19,$4

	lbu	$20,0($15)
	bne	$4,$0,$L482
	lbu	$11,0($14)

	subu	$4,$17,$12
	subu	$21,$0,$4
	slt	$22,$4,0
	movn	$4,$21,$22
	slt	$4,$4,$2
	bne	$4,$0,$L490
	addu	$4,$25,$12

	addu	$4,$12,$24
	sll	$17,$25,1
	addiu	$4,$4,2
	addu	$4,$4,$17
	sra	$4,$4,2
	sb	$4,0($7)
	subu	$4,$16,$13
	subu	$17,$0,$4
	slt	$20,$4,0
	movn	$4,$17,$20
	slt	$4,$4,$2
	beq	$4,$0,$L486
	nop

$L491:
	addu	$12,$13,$12
	addiu	$4,$12,4
	addu	$4,$4,$24
	addu	$25,$25,$16
	addu	$24,$12,$24
	sll	$11,$11,1
	sll	$12,$16,1
	addu	$4,$4,$11
	addu	$12,$12,$16
	sll	$11,$24,1
	addiu	$25,$25,4
	addiu	$16,$16,2
	addu	$25,$25,$11
	addu	$24,$16,$24
	addu	$4,$4,$12
	sra	$25,$25,3
	sra	$24,$24,2
	sra	$4,$4,3
	sb	$25,0($5)
	sb	$24,0($6)
	sb	$4,0($10)
$L479:
	addiu	$7,$7,1
	addiu	$9,$9,1
	addiu	$8,$8,1
	addiu	$6,$6,1
	addiu	$10,$10,1
	addiu	$15,$15,1
	beq	$5,$18,$L489
	addiu	$14,$14,1

	b	$L488
	addiu	$5,$5,1

$L482:
	addu	$13,$25,$13
	addu	$12,$12,$24
	addiu	$12,$12,2
	addiu	$13,$13,2
	sll	$24,$24,1
	sll	$25,$25,1
	addu	$25,$12,$25
	addu	$24,$13,$24
	sra	$25,$25,2
	sra	$24,$24,2
	sb	$25,0($7)
	b	$L479
	sb	$24,0($5)

$L490:
	addiu	$fp,$4,4
	addu	$23,$17,$24
	addu	$21,$4,$13
	sll	$22,$17,1
	addiu	$4,$4,2
	addu	$fp,$fp,$13
	sll	$20,$20,1
	addu	$20,$fp,$20
	addu	$22,$22,$17
	addiu	$23,$23,4
	addu	$17,$4,$17
	sll	$21,$21,1
	addu	$4,$20,$22
	addu	$21,$23,$21
	addu	$17,$17,$13
	sra	$17,$17,2
	sra	$4,$4,3
	sra	$21,$21,3
	sb	$21,0($7)
	sb	$17,0($9)
	sb	$4,0($8)
	subu	$4,$16,$13
	subu	$17,$0,$4
	slt	$20,$4,0
	movn	$4,$17,$20
	slt	$4,$4,$2
	bne	$4,$0,$L491
	nop

$L486:
	addu	$13,$25,$13
	addiu	$13,$13,2
	sll	$24,$24,1
	addu	$24,$13,$24
	sra	$24,$24,2
	b	$L479
	sb	$24,0($5)

$L469:
	addu	$9,$8,$9
	lb	$10,-1($9)
	lh	$9,2($7)
	beq	$9,$0,$L492
	sb	$10,32($sp)

$L471:
	addu	$9,$8,$9
	lb	$10,-1($9)
	lh	$9,4($7)
	beq	$9,$0,$L493
	sb	$10,33($sp)

$L473:
	addu	$9,$8,$9
	lb	$9,-1($9)
	lh	$7,6($7)
	beq	$7,$0,$L494
	sb	$9,34($sp)

$L475:
	addu	$8,$8,$7
	b	$L476
	lb	$7,-1($8)

	.set	macro
	.set	reorder
	.end	filter_mb_edgeh
	.size	filter_mb_edgeh, .-filter_mb_edgeh
	.align	2
	.set	nomips16
	.ent	filter_mb_edgech
	.type	filter_mb_edgech, @function
filter_mb_edgech:
	.frame	$sp,48,$31		# vars= 8, regs= 1/0, args= 24, gp= 8
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	li	$3,65536			# 0x10000
	addu	$3,$4,$3
	addiu	$sp,$sp,-48
	lw	$10,5348($3)
	lw	$8,5344($3)
	move	$2,$4
	lw	$4,64($sp)
	lh	$9,0($7)
	lui	$3,%hi(beta_table+52)
	lui	$11,%hi(alpha_table+52)
	addu	$10,$4,$10
	addu	$8,$4,$8
	addiu	$3,$3,%lo(beta_table+52)
	addiu	$11,$11,%lo(alpha_table+52)
	sw	$31,44($sp)
	addu	$3,$3,$10
	addu	$11,$11,$8
	slt	$10,$9,4
	move	$4,$5
	lbu	$3,0($3)
	move	$5,$6
	beq	$10,$0,$L496
	lbu	$6,0($11)

	sll	$10,$8,1
	addu	$8,$10,$8
	lui	$10,%hi(tc0_table)
	addiu	$8,$8,156
	addiu	$10,$10,%lo(tc0_table)
	bne	$9,$0,$L497
	addu	$8,$10,$8

	lh	$9,2($7)
	move	$10,$0
	bne	$9,$0,$L499
	sb	$10,32($sp)

$L507:
	move	$10,$0
$L500:
	lh	$9,4($7)
	beq	$9,$0,$L502
	sb	$10,33($sp)

	addu	$9,$8,$9
	lbu	$9,-1($9)
	addiu	$9,$9,1
	sll	$9,$9,24
	sra	$9,$9,24
$L502:
	lh	$7,6($7)
	beq	$7,$0,$L504
	sb	$9,34($sp)

	addu	$8,$8,$7
	lbu	$7,-1($8)
	addiu	$7,$7,1
	sll	$7,$7,24
	sra	$7,$7,24
$L504:
	lw	$25,4964($2)
	addiu	$2,$sp,32
	sb	$7,35($sp)
	sw	$2,16($sp)
	jalr	$25
	move	$7,$3

	lw	$31,44($sp)
	j	$31
	addiu	$sp,$sp,48

$L497:
	addu	$9,$8,$9
	lbu	$10,-1($9)
	lh	$9,2($7)
	addiu	$10,$10,1
	sll	$10,$10,24
	sra	$10,$10,24
	beq	$9,$0,$L507
	sb	$10,32($sp)

$L499:
	addu	$9,$8,$9
	lbu	$10,-1($9)
	addiu	$10,$10,1
	sll	$10,$10,24
	b	$L500
	sra	$10,$10,24

$L496:
	lw	$25,4972($2)
	jalr	$25
	move	$7,$3

	lw	$31,44($sp)
	j	$31
	addiu	$sp,$sp,48

	.set	macro
	.set	reorder
	.end	filter_mb_edgech
	.size	filter_mb_edgech, .-filter_mb_edgech
	.align	2
	.set	nomips16
	.ent	svq3_add_idct_c
	.type	svq3_add_idct_c, @function
svq3_add_idct_c:
	.frame	$sp,160,$31		# vars= 112, regs= 9/0, args= 0, gp= 8
	.mask	0x40ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-160
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$fp,156($sp)
	sw	$23,152($sp)
	sw	$22,148($sp)
	sw	$21,144($sp)
	sw	$20,140($sp)
	sw	$19,136($sp)
	sw	$18,132($sp)
	sw	$17,128($sp)
	sw	$16,124($sp)
	.cprestore	0
	lui	$2,%hi(svq3_dequant_coeff)
	addiu	$2,$2,%lo(svq3_dequant_coeff)
	sll	$7,$7,2
	lw	$3,176($sp)
	addu	$7,$7,$2
	bne	$3,$0,$L509
	lw	$2,0($7)

	li	$3,524288			# 0x80000
$L510:
	lh	$7,24($5)
	lh	$8,28($5)
	lh	$fp,0($5)
	lh	$23,4($5)
	sw	$7,68($sp)
	sw	$8,64($sp)
	lw	$17,64($sp)
	lw	$18,68($sp)
	lh	$14,6($5)
	lh	$13,2($5)
	lh	$20,16($5)
	addu	$16,$fp,$23
	lh	$19,20($5)
	addu	$15,$17,$18
	sll	$17,$16,2
	sll	$18,$16,4
	lh	$10,18($5)
	lh	$9,22($5)
	addu	$25,$19,$20
	sw	$17,8($sp)
	sw	$18,12($sp)
	sll	$17,$14,3
	sll	$18,$13,4
	sw	$17,16($sp)
	sw	$18,20($sp)
	sll	$17,$25,2
	sll	$18,$25,4
	sw	$17,24($sp)
	sw	$18,28($sp)
	sll	$17,$10,4
	sll	$18,$9,3
	sw	$17,32($sp)
	sw	$18,44($sp)
	lw	$17,12($sp)
	lw	$18,8($sp)
	lh	$12,10($5)
	subu	$17,$17,$18
	sw	$17,8($sp)
	lw	$18,24($sp)
	lw	$17,28($sp)
	lh	$11,14($5)
	subu	$17,$17,$18
	lh	$8,26($5)
	lh	$7,30($5)
	lh	$22,8($5)
	lh	$21,12($5)
	sw	$17,48($sp)
	lw	$17,16($sp)
	addu	$24,$21,$22
	subu	$17,$17,$14
	sw	$17,12($sp)
	lw	$17,32($sp)
	lw	$18,20($sp)
	addu	$17,$17,$10
	sw	$17,40($sp)
	sll	$17,$24,2
	sw	$17,20($sp)
	sll	$17,$12,4
	sw	$17,28($sp)
	sll	$17,$15,2
	sw	$17,52($sp)
	sll	$17,$8,4
	sw	$17,60($sp)
	sll	$17,$7,3
	sw	$17,36($sp)
	addu	$18,$18,$13
	lw	$17,8($sp)
	sw	$18,16($sp)
	lw	$18,44($sp)
	addu	$16,$17,$16
	subu	$18,$18,$9
	lw	$17,16($sp)
	sw	$16,8($sp)
	lw	$16,12($sp)
	sw	$18,44($sp)
	sll	$18,$24,4
	sw	$18,24($sp)
	addu	$16,$16,$17
	sw	$16,12($sp)
	lw	$17,20($sp)
	lw	$16,24($sp)
	sll	$18,$11,3
	subu	$16,$16,$17
	sw	$16,16($sp)
	lw	$16,48($sp)
	lw	$17,40($sp)
	addu	$25,$16,$25
	sw	$25,24($sp)
	lw	$25,44($sp)
	lw	$16,52($sp)
	addu	$17,$17,$25
	sw	$17,40($sp)
	lw	$17,28($sp)
	sw	$18,32($sp)
	sll	$18,$15,4
	subu	$25,$18,$16
	addu	$18,$17,$12
	lw	$17,32($sp)
	addu	$15,$25,$15
	subu	$16,$17,$11
	lw	$17,60($sp)
	addu	$16,$18,$16
	addu	$17,$17,$8
	sw	$17,28($sp)
	lw	$17,36($sp)
	andi	$16,$16,0xffff
	subu	$17,$17,$7
	sw	$17,32($sp)
	lw	$17,16($sp)
	lw	$18,28($sp)
	addu	$24,$17,$24
	lw	$17,32($sp)
	andi	$24,$24,0xffff
	addu	$25,$18,$17
	lw	$18,8($sp)
	lw	$17,12($sp)
	andi	$18,$18,0xffff
	sw	$18,48($sp)
	lw	$18,24($sp)
	andi	$17,$17,0xffff
	sw	$17,32($sp)
	andi	$18,$18,0xffff
	sw	$18,20($sp)
	sw	$24,28($sp)
	lw	$18,32($sp)
	lw	$24,48($sp)
	lw	$17,40($sp)
	addu	$18,$18,$24
	andi	$25,$25,0xffff
	sw	$16,24($sp)
	sw	$25,40($sp)
	andi	$15,$15,0xffff
	lw	$25,20($sp)
	sll	$16,$18,16
	sw	$15,44($sp)
	subu	$23,$fp,$23
	lw	$15,64($sp)
	lw	$fp,68($sp)
	andi	$17,$17,0xffff
	sra	$16,$16,16
	addu	$25,$17,$25
	sw	$16,12($sp)
	subu	$21,$22,$21
	subu	$19,$20,$19
	lw	$22,28($sp)
	lw	$20,24($sp)
	sw	$17,16($sp)
	sw	$18,52($sp)
	subu	$17,$fp,$15
	sw	$25,56($sp)
	lw	$fp,12($sp)
	lw	$24,40($sp)
	sll	$18,$25,16
	lw	$25,44($sp)
	sra	$18,$18,16
	addu	$16,$20,$22
	sw	$18,8($sp)
	addu	$24,$24,$25
	sll	$20,$23,4
	addu	$25,$18,$fp
	sll	$22,$13,3
	sll	$18,$23,2
	sll	$fp,$21,2
	sw	$24,60($sp)
	sw	$18,72($sp)
	sw	$20,36($sp)
	sw	$22,112($sp)
	sll	$18,$12,3
	sw	$fp,64($sp)
	sll	$fp,$11,4
	sw	$18,68($sp)
	sw	$fp,76($sp)
	sll	$18,$19,2
	sll	$fp,$19,4
	sw	$18,80($sp)
	sw	$fp,84($sp)
	sll	$18,$10,3
	sll	$fp,$9,4
	sw	$18,88($sp)
	sw	$fp,92($sp)
	sll	$18,$17,2
	sll	$fp,$17,4
	sw	$18,96($sp)
	sw	$fp,100($sp)
	sll	$18,$8,3
	sll	$fp,$7,4
	sw	$18,104($sp)
	sw	$fp,108($sp)
	lw	$18,36($sp)
	lw	$fp,72($sp)
	sll	$20,$14,4
	addu	$20,$20,$14
	lw	$14,112($sp)
	sw	$20,72($sp)
	subu	$18,$18,$fp
	lw	$20,68($sp)
	sw	$18,36($sp)
	subu	$13,$14,$13
	lw	$18,64($sp)
	lw	$14,88($sp)
	subu	$12,$20,$12
	sll	$22,$21,4
	sw	$12,112($sp)
	lw	$fp,84($sp)
	lw	$12,80($sp)
	subu	$22,$22,$18
	subu	$10,$14,$10
	sw	$22,64($sp)
	lw	$22,76($sp)
	sw	$10,76($sp)
	lw	$10,104($sp)
	subu	$20,$fp,$12
	lw	$12,108($sp)
	subu	$8,$10,$8
	lw	$10,36($sp)
	addu	$7,$12,$7
	lw	$12,72($sp)
	lw	$18,92($sp)
	lw	$fp,96($sp)
	addu	$11,$22,$11
	sll	$15,$16,16
	lw	$22,100($sp)
	addu	$23,$10,$23
	sll	$24,$24,16
	lw	$10,64($sp)
	sra	$15,$15,16
	sra	$24,$24,16
	subu	$13,$13,$12
	sw	$7,68($sp)
	andi	$23,$23,0xffff
	sll	$7,$25,4
	addu	$9,$18,$9
	sll	$14,$15,4
	subu	$18,$22,$fp
	addu	$21,$10,$21
	sll	$fp,$25,2
	lw	$10,112($sp)
	sll	$22,$24,3
	andi	$13,$13,0xffff
	subu	$fp,$7,$fp
	subu	$22,$22,$24
	addu	$19,$20,$19
	addu	$14,$14,$15
	subu	$20,$23,$13
	addu	$25,$fp,$25
	addu	$14,$22,$14
	subu	$12,$10,$11
	addu	$17,$18,$17
	lw	$11,76($sp)
	lw	$18,68($sp)
	sw	$20,36($sp)
	lw	$fp,32($sp)
	lw	$22,48($sp)
	lw	$10,28($sp)
	subu	$22,$22,$fp
	sw	$22,32($sp)
	lw	$20,20($sp)
	lw	$22,16($sp)
	subu	$8,$8,$18
	lw	$18,24($sp)
	subu	$fp,$20,$22
	andi	$21,$21,0xffff
	lw	$20,40($sp)
	subu	$9,$11,$9
	andi	$12,$12,0xffff
	subu	$11,$10,$18
	lw	$18,44($sp)
	subu	$7,$21,$12
	andi	$19,$19,0xffff
	andi	$9,$9,0xffff
	sw	$7,48($sp)
	subu	$10,$19,$9
	subu	$7,$18,$20
	addu	$9,$19,$9
	addu	$19,$14,$25
	sh	$7,30($5)
	andi	$17,$17,0xffff
	mul	$7,$19,$2
	andi	$8,$8,0xffff
	subu	$22,$17,$8
	addu	$8,$17,$8
	sh	$9,18($5)
	sh	$8,26($5)
	lw	$9,8($sp)
	lw	$8,12($sp)
	addu	$13,$23,$13
	sh	$13,2($5)
	sh	$fp,22($5)
	sh	$22,28($5)
	lw	$13,36($sp)
	lw	$17,32($sp)
	lw	$18,48($sp)
	lw	$20,52($sp)
	lw	$22,56($sp)
	lw	$fp,60($sp)
	addu	$12,$21,$12
	addu	$19,$7,$3
	subu	$7,$8,$9
	sh	$13,4($5)
	sh	$17,6($5)
	sh	$12,10($5)
	sh	$18,12($5)
	sh	$11,14($5)
	sh	$10,20($5)
	sh	$20,0($5)
	sh	$16,8($5)
	sh	$22,16($5)
	sh	$fp,24($5)
	sll	$12,$7,4
	sll	$9,$7,2
	sll	$11,$24,4
	sll	$10,$15,3
	lbu	$8,0($4)
	subu	$9,$12,$9
	addu	$24,$11,$24
	subu	$15,$10,$15
	subu	$15,$15,$24
	addu	$7,$9,$7
	sra	$19,$19,20
	addu	$9,$7,$15
	addu	$19,$19,$8
	lw	$8,%got(ff_cropTbl)($28)
	mul	$10,$9,$2
	addiu	$8,$8,1024
	addu	$19,$8,$19
	lbu	$11,0($19)
	addu	$9,$10,$3
	addu	$10,$4,$6
	sb	$11,0($4)
	lbu	$11,0($10)
	sra	$9,$9,20
	addu	$9,$9,$11
	addu	$9,$8,$9
	lbu	$11,0($9)
	subu	$7,$7,$15
	sb	$11,0($10)
	mul	$10,$7,$2
	sll	$9,$6,1
	addu	$11,$4,$9
	addu	$7,$10,$3
	lbu	$10,0($11)
	sra	$7,$7,20
	addu	$7,$7,$10
	addu	$7,$8,$7
	lbu	$12,0($7)
	subu	$7,$25,$14
	sb	$12,0($11)
	mul	$11,$7,$2
	addu	$10,$9,$6
	addu	$7,$11,$3
	addu	$11,$4,$10
	lbu	$12,0($11)
	sra	$7,$7,20
	addu	$7,$7,$12
	addu	$7,$8,$7
	lbu	$7,0($7)
	addiu	$24,$6,1
	sb	$7,0($11)
	lh	$14,2($5)
	lh	$12,18($5)
	lh	$7,10($5)
	lh	$11,26($5)
	addu	$13,$12,$14
	sll	$17,$13,4
	sll	$16,$13,2
	sll	$15,$11,3
	sll	$25,$7,4
	subu	$16,$17,$16
	addu	$25,$25,$7
	subu	$15,$15,$11
	addu	$15,$15,$25
	addu	$13,$16,$13
	addu	$16,$15,$13
	mul	$17,$16,$2
	lbu	$25,1($4)
	addu	$16,$17,$3
	subu	$12,$14,$12
	sra	$14,$16,20
	sll	$18,$12,4
	addu	$14,$14,$25
	sll	$17,$11,4
	sll	$25,$12,2
	sll	$16,$7,3
	subu	$25,$18,$25
	addu	$11,$17,$11
	subu	$7,$16,$7
	addu	$14,$8,$14
	lbu	$14,0($14)
	addu	$12,$25,$12
	subu	$7,$7,$11
	addu	$11,$12,$7
	sb	$14,1($4)
	mul	$14,$11,$2
	addu	$24,$4,$24
	addu	$11,$14,$3
	lbu	$14,0($24)
	sra	$11,$11,20
	addu	$11,$11,$14
	addu	$11,$8,$11
	lbu	$11,0($11)
	subu	$7,$12,$7
	sb	$11,0($24)
	mul	$11,$7,$2
	addiu	$14,$9,1
	addu	$14,$4,$14
	lbu	$24,0($14)
	addu	$7,$11,$3
	sra	$7,$7,20
	subu	$13,$13,$15
	addu	$7,$7,$24
	mul	$12,$13,$2
	addu	$7,$8,$7
	lbu	$11,0($7)
	addiu	$7,$10,1
	sb	$11,0($14)
	addu	$7,$4,$7
	addu	$11,$12,$3
	lbu	$12,0($7)
	sra	$11,$11,20
	addu	$11,$11,$12
	addu	$11,$8,$11
	lbu	$11,0($11)
	addiu	$24,$6,2
	sb	$11,0($7)
	lh	$14,4($5)
	lh	$12,20($5)
	lh	$7,12($5)
	lh	$11,28($5)
	addu	$13,$12,$14
	sll	$17,$13,4
	sll	$16,$13,2
	sll	$15,$11,3
	sll	$25,$7,4
	subu	$16,$17,$16
	addu	$25,$25,$7
	subu	$15,$15,$11
	addu	$15,$15,$25
	addu	$13,$16,$13
	addu	$16,$15,$13
	mul	$17,$16,$2
	lbu	$25,2($4)
	addu	$16,$17,$3
	subu	$12,$14,$12
	sra	$14,$16,20
	sll	$18,$12,4
	addu	$14,$14,$25
	sll	$17,$11,4
	sll	$25,$12,2
	sll	$16,$7,3
	subu	$25,$18,$25
	addu	$11,$17,$11
	subu	$7,$16,$7
	addu	$14,$8,$14
	addu	$12,$25,$12
	lbu	$14,0($14)
	subu	$7,$7,$11
	addu	$11,$12,$7
	sb	$14,2($4)
	mul	$14,$11,$2
	addu	$24,$4,$24
	addu	$11,$14,$3
	lbu	$14,0($24)
	sra	$11,$11,20
	addu	$11,$11,$14
	addu	$11,$8,$11
	subu	$7,$12,$7
	lbu	$25,0($11)
	mul	$11,$7,$2
	addiu	$14,$9,2
	addu	$14,$4,$14
	sb	$25,0($24)
	addu	$7,$11,$3
	lbu	$24,0($14)
	sra	$7,$7,20
	subu	$13,$13,$15
	addu	$7,$7,$24
	mul	$12,$13,$2
	addu	$7,$8,$7
	lbu	$11,0($7)
	addiu	$7,$10,2
	sb	$11,0($14)
	addu	$7,$4,$7
	addu	$11,$12,$3
	lbu	$12,0($7)
	sra	$11,$11,20
	addu	$11,$11,$12
	addu	$11,$8,$11
	lbu	$11,0($11)
	addiu	$6,$6,3
	sb	$11,0($7)
	lh	$14,6($5)
	lh	$11,22($5)
	lh	$7,30($5)
	lh	$5,14($5)
	addu	$12,$11,$14
	sll	$25,$12,4
	sll	$24,$12,2
	sll	$13,$7,3
	sll	$15,$5,4
	subu	$24,$25,$24
	addu	$15,$15,$5
	subu	$13,$13,$7
	addu	$13,$13,$15
	addu	$12,$24,$12
	addu	$24,$13,$12
	mul	$15,$24,$2
	subu	$11,$14,$11
	addu	$24,$15,$3
	lbu	$15,3($4)
	sra	$14,$24,20
	sll	$16,$11,4
	addu	$14,$14,$15
	sll	$25,$7,4
	sll	$15,$11,2
	sll	$24,$5,3
	subu	$15,$16,$15
	addu	$7,$25,$7
	subu	$5,$24,$5
	addu	$14,$8,$14
	lbu	$14,0($14)
	addu	$11,$15,$11
	subu	$5,$5,$7
	addu	$7,$11,$5
	sb	$14,3($4)
	mul	$14,$7,$2
	addu	$6,$4,$6
	addu	$7,$14,$3
	lbu	$14,0($6)
	sra	$7,$7,20
	addu	$7,$7,$14
	addu	$7,$8,$7
	lbu	$7,0($7)
	subu	$5,$11,$5
	sb	$7,0($6)
	mul	$6,$5,$2
	addiu	$9,$9,3
	addu	$9,$4,$9
	addu	$5,$6,$3
	lbu	$6,0($9)
	sra	$5,$5,20
	addu	$5,$5,$6
	addu	$5,$8,$5
	lbu	$5,0($5)
	subu	$12,$12,$13
	sb	$5,0($9)
	mul	$5,$12,$2
	addiu	$10,$10,3
	addu	$4,$4,$10
	addu	$2,$5,$3
	lbu	$5,0($4)
	sra	$2,$2,20
	addu	$2,$2,$5
	addu	$8,$8,$2
	lbu	$2,0($8)
	sb	$2,0($4)
	lw	$fp,156($sp)
	lw	$23,152($sp)
	lw	$22,148($sp)
	lw	$21,144($sp)
	lw	$20,140($sp)
	lw	$19,136($sp)
	lw	$18,132($sp)
	lw	$17,128($sp)
	lw	$16,124($sp)
	j	$31
	addiu	$sp,$sp,160

$L509:
	li	$7,1			# 0x1
	beq	$3,$7,$L514
	nop

	lh	$3,0($5)
	sra	$3,$3,3
	mul	$3,$2,$3
	srl	$7,$3,31
	addu	$3,$7,$3
	sra	$7,$3,1
	sll	$8,$7,5
	sll	$3,$7,3
	subu	$3,$8,$3
	sll	$8,$3,3
	subu	$3,$8,$3
	addu	$3,$3,$7
$L512:
	li	$8,524288			# 0x80000
	addu	$3,$3,$8
	b	$L510
	sh	$0,0($5)

$L514:
	lh	$7,0($5)
	li	$3,196608			# 0x30000
	ori	$3,$3,0xf752
	b	$L512
	mul	$3,$7,$3

	.set	macro
	.set	reorder
	.end	svq3_add_idct_c
	.size	svq3_add_idct_c, .-svq3_add_idct_c
	.align	2
	.set	nomips16
	.ent	init_dequant_tables
	.type	init_dequant_tables, @function
init_dequant_tables:
	.frame	$sp,112,$31		# vars= 48, regs= 10/0, args= 16, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-112
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,108($sp)
	sw	$fp,104($sp)
	sw	$23,100($sp)
	sw	$22,96($sp)
	sw	$21,92($sp)
	sw	$20,88($sp)
	sw	$19,84($sp)
	sw	$18,80($sp)
	sw	$17,76($sp)
	sw	$16,72($sp)
	.cprestore	16
	addiu	$2,$4,12612
	addiu	$3,$4,11872
	sw	$2,44($sp)
	li	$2,59204			# 0xe744
	addu	$2,$4,$2
	sw	$3,40($sp)
	sw	$4,112($sp)
	lw	$20,5116($4)
	sw	$2,28($sp)
	lw	$4,44($sp)
	lw	$2,40($sp)
	lui	$3,%hi(ff_div6)
	lui	$fp,%hi(ff_rem6)
	lui	$18,%hi(dequant4_coeff_init)
	lw	$19,%got(ff_h264_idct_add_c)($28)
	lw	$16,112($sp)
	addiu	$3,$3,%lo(ff_div6)
	addiu	$fp,$fp,%lo(ff_rem6)
	addiu	$18,$18,%lo(dequant4_coeff_init)
	sw	$4,32($sp)
	sw	$2,36($sp)
	sw	$0,24($sp)
	li	$23,52			# 0x34
$L523:
	lw	$2,32($sp)
	lw	$4,28($sp)
	sw	$2,0($4)
	lw	$4,24($sp)
	beq	$4,$0,$L516
	move	$17,$2

	sw	$16,48($sp)
	lw	$22,40($sp)
	move	$21,$0
	lw	$16,36($sp)
	sw	$2,52($sp)
	b	$L519
	move	$17,$4

$L517:
	addiu	$21,$21,1
	slt	$2,$21,$17
	beq	$2,$0,$L545
	addiu	$22,$22,16

$L519:
	lw	$25,%call16(memcmp)($28)
	sw	$3,68($sp)
	move	$4,$22
	move	$5,$16
	jalr	$25
	li	$6,16			# 0x10

	lw	$28,16($sp)
	bne	$2,$0,$L517
	lw	$3,68($sp)

	sll	$2,$21,2
	sll	$17,$21,4
	subu	$17,$17,$2
	addu	$17,$17,$21
	lw	$2,44($sp)
	sll	$17,$17,8
	lw	$4,24($sp)
	addu	$17,$2,$17
	lw	$2,28($sp)
	slt	$21,$21,$4
	lw	$16,48($sp)
	beq	$21,$0,$L516
	sw	$17,0($2)

$L518:
	lw	$2,24($sp)
	lw	$4,32($sp)
	addiu	$2,$2,1
	sw	$2,24($sp)
	addiu	$4,$4,3328
	lw	$2,28($sp)
	sw	$4,32($sp)
	lw	$4,36($sp)
	addiu	$2,$2,4
	addiu	$4,$4,16
	sw	$2,28($sp)
	lw	$2,24($sp)
	sw	$4,36($sp)
	li	$4,6			# 0x6
	bne	$2,$4,$L523
	addiu	$16,$16,16

	lw	$3,112($sp)
	lw	$2,11868($3)
	beq	$2,$0,$L551
	lw	$4,112($sp)

	addiu	$3,$3,32580
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	addiu	$4,$3,13312
	sw	$4,-6304($2)
	sw	$3,-6308($2)
	lw	$2,112($sp)
	li	$16,59228			# 0xe75c
	lui	$fp,%hi(ff_div6)
	lui	$23,%hi(ff_rem6)
	lui	$19,%hi(dequant8_coeff_init_scan)
	lui	$18,%hi(dequant8_coeff_init)
	lw	$22,5120($2)
	lw	$21,%got(ff_h264_idct8_add_c)($28)
	addu	$16,$2,$16
	addiu	$fp,$fp,%lo(ff_div6)
	addiu	$23,$23,%lo(ff_rem6)
	addiu	$19,$19,%lo(dequant8_coeff_init_scan)
	addiu	$18,$18,%lo(dequant8_coeff_init)
	addiu	$9,$2,11968
	addiu	$8,$2,12032
	move	$5,$3
	move	$15,$0
	li	$17,64			# 0x40
	li	$20,52			# 0x34
	li	$7,1			# 0x1
$L525:
	lw	$4,112($sp)
	move	$13,$0
	sll	$14,$15,6
	addu	$14,$4,$14
	addu	$2,$23,$13
	addu	$4,$fp,$13
	addiu	$14,$14,11968
	lbu	$11,0($4)
	lbu	$2,0($2)
	beq	$22,$21,$L546
	sll	$10,$13,8

$L528:
	sll	$12,$2,3
	sll	$2,$2,1
	subu	$12,$12,$2
	move	$4,$14
	b	$L531
	move	$2,$0

$L547:
	lw	$5,0($16)
$L531:
	sra	$6,$2,1
	andi	$24,$2,0x3
	andi	$6,$6,0xc
	or	$6,$6,$24
	addu	$6,$19,$6
	lbu	$24,0($6)
	lbu	$6,0($4)
	addu	$24,$12,$24
	addu	$24,$18,$24
	lbu	$25,0($24)
	andi	$24,$2,0x7
	mul	$6,$25,$6
	sll	$24,$24,3
	sra	$25,$2,3
	or	$24,$24,$25
	addu	$5,$5,$10
	sll	$24,$24,2
	addu	$5,$5,$24
	sll	$6,$6,$11
	addiu	$2,$2,1
	sw	$6,0($5)
	bne	$2,$17,$L547
	addiu	$4,$4,1

	addiu	$13,$13,1
	beq	$13,$20,$L548
	nop

$L532:
	addu	$4,$fp,$13
	addu	$2,$23,$13
	lw	$5,0($16)
	lbu	$11,0($4)
	lbu	$2,0($2)
	bne	$22,$21,$L528
	sll	$10,$13,8

$L546:
	sll	$12,$2,3
	sll	$2,$2,1
	subu	$12,$12,$2
	move	$4,$14
	b	$L530
	move	$2,$0

$L549:
	lw	$5,0($16)
$L530:
	sra	$6,$2,1
	andi	$24,$2,0x3
	andi	$6,$6,0xc
	or	$6,$6,$24
	addu	$6,$19,$6
	lbu	$24,0($6)
	lbu	$6,0($4)
	addu	$24,$12,$24
	addu	$24,$18,$24
	lbu	$24,0($24)
	addu	$5,$5,$10
	mul	$6,$24,$6
	sll	$24,$2,2
	addu	$5,$5,$24
	sll	$6,$6,$11
	addiu	$2,$2,1
	sw	$6,0($5)
	bne	$2,$17,$L549
	addiu	$4,$4,1

	addiu	$13,$13,1
	bne	$13,$20,$L532
	nop

$L548:
	beq	$15,$7,$L524
	lw	$25,%call16(memcmp)($28)

	move	$4,$9
	move	$5,$8
	sw	$3,68($sp)
	sw	$7,56($sp)
	sw	$8,64($sp)
	sw	$9,60($sp)
	jalr	$25
	li	$6,64			# 0x40

	lw	$28,16($sp)
	lw	$3,68($sp)
	lw	$7,56($sp)
	lw	$8,64($sp)
	beq	$2,$0,$L526
	lw	$9,60($sp)

	lw	$5,4($16)
	li	$15,1			# 0x1
	b	$L525
	addiu	$16,$16,4

$L545:
	lw	$16,48($sp)
	lw	$17,52($sp)
$L516:
	lw	$4,28($sp)
	move	$6,$0
	lw	$10,0($4)
	move	$5,$0
	move	$13,$10
	move	$12,$10
	move	$11,$10
	b	$L522
	move	$9,$17

$L520:
	lbu	$15,11873($16)
	lbu	$4,1($4)
	addu	$9,$10,$6
	mul	$15,$15,$4
	move	$24,$9
	sll	$15,$15,$2
	sw	$15,16($11)
	lbu	$25,11874($16)
	li	$15,1			# 0x1
	mul	$25,$7,$25
	sll	$15,$15,2
	sll	$25,$25,$2
	sw	$25,32($9)
	lbu	$25,11875($16)
	addu	$8,$14,$8
	mul	$25,$25,$4
	addu	$15,$24,$15
	sll	$25,$25,$2
	sw	$25,48($9)
	lbu	$9,11876($16)
	addu	$8,$18,$8
	mul	$9,$4,$9
	sll	$9,$9,$2
	sw	$9,0($15)
	lbu	$14,11877($16)
	lbu	$9,2($8)
	addu	$8,$10,$6
	mul	$14,$14,$9
	sll	$14,$14,$2
	beq	$20,$19,$L550
	sw	$14,20($8)

$L521:
	lbu	$24,11878($16)
	move	$15,$8
	mul	$24,$4,$24
	li	$14,11			# 0xb
	sll	$24,$24,$2
	sw	$24,36($12)
	lbu	$24,11879($16)
	mul	$24,$24,$9
	sll	$24,$24,$2
	sw	$24,52($8)
	lbu	$24,11880($16)
	mul	$24,$24,$7
	sll	$24,$24,$2
	sw	$24,8($8)
	lbu	$24,11881($16)
	mul	$24,$4,$24
	sll	$24,$24,$2
	sw	$24,24($8)
	lbu	$24,11882($16)
	mul	$7,$24,$7
	sll	$7,$7,$2
	sw	$7,40($8)
	lbu	$7,11883($16)
	mul	$7,$4,$7
	sll	$7,$7,$2
	sw	$7,56($13)
	lbu	$7,11884($16)
	mul	$7,$4,$7
	sll	$7,$7,$2
	sw	$7,12($8)
	lbu	$7,11885($16)
	mul	$7,$9,$7
	sll	$7,$7,$2
	sw	$7,28($8)
$L538:
	lbu	$7,11886($16)
	sll	$14,$14,2
	mul	$4,$4,$7
	addu	$14,$15,$14
	sll	$4,$4,$2
	sw	$4,0($14)
	lbu	$4,11887($16)
	addiu	$5,$5,1
	mul	$9,$4,$9
	addiu	$6,$6,64
	sll	$2,$9,$2
	sw	$2,60($8)
	addiu	$13,$13,64
	addiu	$12,$12,64
	beq	$5,$23,$L518
	addiu	$11,$11,64

	move	$9,$10
$L522:
	addu	$2,$fp,$5
	lbu	$8,0($2)
	lbu	$15,11872($16)
	sll	$14,$8,1
	addu	$4,$14,$8
	addu	$4,$18,$4
	lbu	$7,0($4)
	addu	$2,$3,$5
	mul	$15,$15,$7
	lbu	$2,0($2)
	addu	$9,$9,$6
	addiu	$2,$2,2
	sll	$15,$15,$2
	bne	$20,$19,$L520
	sw	$15,0($9)

	lbu	$15,11873($16)
	lbu	$4,1($4)
	addu	$9,$10,$6
	mul	$15,$15,$4
	move	$24,$9
	sll	$15,$15,$2
	sw	$15,4($11)
	lbu	$25,11874($16)
	li	$15,4			# 0x4
	mul	$25,$25,$7
	sll	$15,$15,2
	sll	$25,$25,$2
	sw	$25,8($9)
	lbu	$25,11875($16)
	addu	$8,$14,$8
	mul	$25,$25,$4
	addu	$15,$24,$15
	sll	$25,$25,$2
	sw	$25,12($9)
	lbu	$9,11876($16)
	addu	$8,$18,$8
	mul	$9,$4,$9
	sll	$9,$9,$2
	sw	$9,0($15)
	lbu	$14,11877($16)
	lbu	$9,2($8)
	addu	$8,$10,$6
	mul	$14,$14,$9
	sll	$14,$14,$2
	bne	$20,$19,$L521
	sw	$14,20($8)

$L550:
	lbu	$24,11878($16)
	move	$15,$8
	mul	$24,$4,$24
	li	$14,14			# 0xe
	sll	$24,$24,$2
	sw	$24,24($12)
	lbu	$24,11879($16)
	mul	$24,$24,$9
	sll	$24,$24,$2
	sw	$24,28($8)
	lbu	$24,11880($16)
	mul	$24,$24,$7
	sll	$24,$24,$2
	sw	$24,32($8)
	lbu	$24,11881($16)
	mul	$24,$4,$24
	sll	$24,$24,$2
	sw	$24,36($8)
	lbu	$24,11882($16)
	mul	$7,$24,$7
	sll	$7,$7,$2
	sw	$7,40($8)
	lbu	$7,11883($16)
	mul	$7,$4,$7
	sll	$7,$7,$2
	sw	$7,44($13)
	lbu	$7,11884($16)
	mul	$7,$4,$7
	sll	$7,$7,$2
	sw	$7,48($8)
	lbu	$7,11885($16)
	mul	$7,$7,$9
	sll	$7,$7,$2
	b	$L538
	sw	$7,52($8)

$L526:
	lw	$4,112($sp)
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	sw	$3,-6304($2)
$L524:
	lw	$3,112($sp)
$L551:
	lw	$2,9924($3)
	beq	$2,$0,$L552
	lw	$31,108($sp)

	li	$5,65536			# 0x10000
	addu	$5,$3,$5
	lw	$4,-6332($5)
	lw	$3,-6328($5)
	li	$2,64			# 0x40
	sw	$2,60($4)
	sw	$2,0($4)
	sw	$2,4($4)
	sw	$2,8($4)
	sw	$2,12($4)
	sw	$2,16($4)
	sw	$2,20($4)
	sw	$2,24($4)
	sw	$2,28($4)
	sw	$2,32($4)
	sw	$2,36($4)
	sw	$2,40($4)
	sw	$2,44($4)
	sw	$2,48($4)
	sw	$2,52($4)
	sw	$2,56($4)
	sw	$2,0($3)
	sw	$2,4($3)
	sw	$2,8($3)
	sw	$2,12($3)
	sw	$2,16($3)
	sw	$2,20($3)
	sw	$2,24($3)
	sw	$2,28($3)
	sw	$2,32($3)
	sw	$2,36($3)
	sw	$2,40($3)
	sw	$2,44($3)
	sw	$2,48($3)
	sw	$2,52($3)
	sw	$2,56($3)
	sw	$2,60($3)
	lw	$4,-6324($5)
	lw	$3,-6320($5)
	sw	$2,60($4)
	sw	$2,0($4)
	sw	$2,4($4)
	sw	$2,8($4)
	sw	$2,12($4)
	sw	$2,16($4)
	sw	$2,20($4)
	sw	$2,24($4)
	sw	$2,28($4)
	sw	$2,32($4)
	sw	$2,36($4)
	sw	$2,40($4)
	sw	$2,44($4)
	sw	$2,48($4)
	sw	$2,52($4)
	sw	$2,56($4)
	sw	$2,0($3)
	sw	$2,4($3)
	sw	$2,8($3)
	sw	$2,12($3)
	sw	$2,16($3)
	sw	$2,20($3)
	sw	$2,24($3)
	sw	$2,28($3)
	sw	$2,32($3)
	sw	$2,36($3)
	sw	$2,40($3)
	sw	$2,44($3)
	sw	$2,48($3)
	sw	$2,52($3)
	sw	$2,56($3)
	sw	$2,60($3)
	lw	$4,-6316($5)
	lw	$3,-6312($5)
	sw	$2,60($4)
	sw	$2,0($4)
	sw	$2,4($4)
	sw	$2,8($4)
	sw	$2,12($4)
	sw	$2,16($4)
	sw	$2,20($4)
	sw	$2,24($4)
	sw	$2,28($4)
	sw	$2,32($4)
	sw	$2,36($4)
	sw	$2,40($4)
	sw	$2,44($4)
	sw	$2,48($4)
	sw	$2,52($4)
	sw	$2,56($4)
	sw	$2,0($3)
	sw	$2,4($3)
	sw	$2,8($3)
	sw	$2,12($3)
	sw	$2,16($3)
	sw	$2,20($3)
	sw	$2,24($3)
	sw	$2,28($3)
	sw	$2,32($3)
	sw	$2,36($3)
	sw	$2,40($3)
	sw	$2,44($3)
	sw	$2,48($3)
	sw	$2,52($3)
	sw	$2,56($3)
	sw	$2,60($3)
	lw	$4,112($sp)
	lw	$2,11868($4)
	beq	$2,$0,$L552
	lw	$31,108($sp)

	li	$8,59228			# 0xe75c
	addu	$8,$4,$8
	move	$7,$0
	li	$5,64			# 0x40
	li	$4,256			# 0x100
	li	$9,2			# 0x2
$L535:
	lw	$6,0($8)
	move	$2,$0
$L536:
	addu	$3,$6,$2
	addiu	$2,$2,4
	bne	$2,$4,$L536
	sw	$5,0($3)

	addiu	$7,$7,1
	bne	$7,$9,$L535
	addiu	$8,$8,4

	lw	$31,108($sp)
$L552:
	lw	$fp,104($sp)
	lw	$23,100($sp)
	lw	$22,96($sp)
	lw	$21,92($sp)
	lw	$20,88($sp)
	lw	$19,84($sp)
	lw	$18,80($sp)
	lw	$17,76($sp)
	lw	$16,72($sp)
	j	$31
	addiu	$sp,$sp,112

	.set	macro
	.set	reorder
	.end	init_dequant_tables
	.size	init_dequant_tables, .-init_dequant_tables
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"out of range intra chroma pred mode at %d %d\012\000"
	.align	2
$LC1:
	.ascii	"top block unavailable for requested intra mode at %d %d\012"
	.ascii	"\000"
	.align	2
$LC2:
	.ascii	"left block unavailable for requested intra mode at %d %d"
	.ascii	"\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	check_intra_pred_mode
	.type	check_intra_pred_mode, @function
check_intra_pred_mode:
	.frame	$sp,40,$31		# vars= 0, regs= 1/0, args= 24, gp= 8
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-40
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,36($sp)
	.cprestore	24
	sltu	$3,$5,7
	beq	$3,$0,$L559
	move	$2,$5

	lw	$3,8984($4)
	andi	$3,$3,0x8000
	bne	$3,$0,$L556
	lui	$3,%hi(top.10339)

	addiu	$3,$3,%lo(top.10339)
	addu	$2,$5,$3
	lb	$2,0($2)
	bltz	$2,$L560
	lui	$6,%hi($LC1)

$L556:
	lw	$3,8992($4)
	andi	$3,$3,0x8000
	bne	$3,$0,$L562
	lw	$31,36($sp)

	lui	$3,%hi(left.10340)
	addiu	$3,$3,%lo(left.10340)
	addu	$2,$2,$3
	lb	$2,0($2)
	bltz	$2,$L561
	lui	$6,%hi($LC2)

$L555:
	lw	$31,36($sp)
$L562:
	j	$31
	addiu	$sp,$sp,40

$L561:
	lw	$3,6172($4)
	lw	$2,0($4)
	lw	$25,%call16(av_log)($28)
	lw	$7,6168($4)
	addiu	$6,$6,%lo($LC2)
	sw	$3,16($sp)
	move	$4,$2
$L558:
	jalr	$25
	move	$5,$0

	b	$L555
	li	$2,-1			# 0xffffffffffffffff

$L560:
	lw	$3,6172($4)
	lw	$2,0($4)
	lw	$7,6168($4)
	lw	$25,%call16(av_log)($28)
	sw	$3,16($sp)
	move	$4,$2
	b	$L558
	addiu	$6,$6,%lo($LC1)

$L559:
	lw	$3,6172($4)
	lw	$2,0($4)
	lui	$6,%hi($LC0)
	lw	$7,6168($4)
	lw	$25,%call16(av_log)($28)
	sw	$3,16($sp)
	move	$4,$2
	b	$L558
	addiu	$6,$6,%lo($LC0)

	.set	macro
	.set	reorder
	.end	check_intra_pred_mode
	.size	check_intra_pred_mode, .-check_intra_pred_mode
	.align	2
	.set	nomips16
	.ent	fill_default_ref_list
	.type	fill_default_ref_list, @function
fill_default_ref_list:
	.frame	$sp,13584,$31		# vars= 13520, regs= 10/0, args= 16, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-13584
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,13580($sp)
	sw	$fp,13576($sp)
	sw	$23,13572($sp)
	sw	$22,13568($sp)
	sw	$21,13564($sp)
	sw	$20,13560($sp)
	sw	$19,13556($sp)
	sw	$18,13552($sp)
	sw	$17,13548($sp)
	sw	$16,13544($sp)
	.cprestore	16
	li	$2,65536			# 0x10000
	addu	$3,$4,$2
	ori	$16,$2,0x1840
	addu	$16,$4,$16
	lw	$5,-6284($3)
	addiu	$14,$16,13056
	li	$3,3			# 0x3
	sw	$16,24($sp)
	beq	$5,$3,$L564
	sw	$14,28($sp)

	li	$15,131072			# 0x20000
	addu	$15,$4,$15
	lw	$8,6828($15)
	blez	$8,$L719
	ori	$2,$2,0x173c

	addu	$2,$4,$2
	move	$3,$0
	move	$7,$0
	b	$L640
	li	$9,3			# 0x3

$L638:
	addiu	$3,$3,1
	slt	$5,$3,$8
	beq	$5,$0,$L566
	addiu	$2,$2,4

$L640:
	lw	$5,0($2)
	lw	$6,80($5)
	bne	$6,$9,$L638
	sll	$6,$7,3

	sll	$8,$7,5
	subu	$6,$8,$6
	sll	$8,$6,4
	addu	$6,$6,$8
	addu	$8,$16,$6
	move	$6,$8
	addiu	$10,$5,400
$L639:
	lw	$14,0($5)
	lw	$13,4($5)
	lw	$12,8($5)
	lw	$11,12($5)
	addiu	$5,$5,16
	sw	$14,0($6)
	sw	$13,4($6)
	sw	$12,8($6)
	sw	$11,12($6)
	bne	$5,$10,$L639
	addiu	$6,$6,16

	lw	$10,4($5)
	lw	$5,0($5)
	sw	$10,4($6)
	sw	$5,0($6)
	lw	$5,0($2)
	addiu	$3,$3,1
	lw	$5,232($5)
	addiu	$7,$7,1
	sw	$5,236($8)
	lw	$8,6828($15)
	slt	$5,$3,$8
	bne	$5,$0,$L640
	addiu	$2,$2,4

$L566:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6076($2)
	beq	$2,$0,$L641
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L720
	sll	$5,$7,5

$L641:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6080($2)
	beq	$2,$0,$L643
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L721
	sll	$5,$7,5

$L643:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6084($2)
	beq	$2,$0,$L645
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L722
	sll	$5,$7,5

$L645:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6088($2)
	beq	$2,$0,$L647
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L723
	sll	$5,$7,5

$L647:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6092($2)
	beq	$2,$0,$L649
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L724
	sll	$5,$7,5

$L649:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6096($2)
	beq	$2,$0,$L651
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L725
	sll	$5,$7,5

$L651:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6100($2)
	beq	$2,$0,$L653
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L726
	sll	$5,$7,5

$L653:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6104($2)
	beq	$2,$0,$L655
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L727
	sll	$5,$7,5

$L655:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6108($2)
	beq	$2,$0,$L657
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L728
	sll	$5,$7,5

$L657:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6112($2)
	beq	$2,$0,$L659
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L729
	sll	$5,$7,5

$L659:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6116($2)
	beq	$2,$0,$L661
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L730
	sll	$5,$7,5

$L661:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6120($2)
	beq	$2,$0,$L663
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L731
	sll	$5,$7,5

$L663:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6124($2)
	beq	$2,$0,$L665
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L732
	sll	$5,$7,5

$L665:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6128($2)
	beq	$2,$0,$L667
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L733
	sll	$5,$7,5

$L667:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6132($2)
	beq	$2,$0,$L669
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L734
	sll	$5,$7,5

$L669:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,6136($2)
	beq	$2,$0,$L671
	li	$3,3			# 0x3

	lw	$5,80($2)
	beq	$5,$3,$L735
	sll	$5,$7,5

$L671:
	li	$2,65536			# 0x10000
	addu	$4,$4,$2
	lw	$2,5936($4)
	sltu	$3,$7,$2
	bne	$3,$0,$L736
	subu	$2,$2,$7

	move	$2,$0
$L673:
	lw	$31,13580($sp)
	lw	$fp,13576($sp)
	lw	$23,13572($sp)
	lw	$22,13568($sp)
	lw	$21,13564($sp)
	lw	$20,13560($sp)
	lw	$19,13556($sp)
	lw	$18,13552($sp)
	lw	$17,13548($sp)
	lw	$16,13544($sp)
	j	$31
	addiu	$sp,$sp,13584

$L736:
	sll	$3,$7,5
	sll	$7,$7,3
	subu	$7,$3,$7
	sll	$3,$2,5
	sll	$2,$2,3
	subu	$2,$3,$2
	sll	$4,$7,4
	addu	$4,$7,$4
	sll	$6,$2,4
	lw	$25,%call16(memset)($28)
	addu	$4,$16,$4
	addu	$6,$2,$6
	jalr	$25
	move	$5,$0

	b	$L673
	move	$2,$0

$L735:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L672:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L672
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,15			# 0xf
	sw	$6,4($3)
	b	$L671
	sw	$2,236($5)

$L734:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L670:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L670
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,14			# 0xe
	sw	$6,4($3)
	b	$L669
	sw	$2,236($5)

$L733:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L668:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L668
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,13			# 0xd
	sw	$6,4($3)
	b	$L667
	sw	$2,236($5)

$L732:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L666:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L666
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,12			# 0xc
	sw	$6,4($3)
	b	$L665
	sw	$2,236($5)

$L731:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L664:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L664
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,11			# 0xb
	sw	$6,4($3)
	b	$L663
	sw	$2,236($5)

$L730:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L662:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L662
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,10			# 0xa
	sw	$6,4($3)
	b	$L661
	sw	$2,236($5)

$L729:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L660:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L660
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,9			# 0x9
	sw	$6,4($3)
	b	$L659
	sw	$2,236($5)

$L728:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L658:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L658
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,8			# 0x8
	sw	$6,4($3)
	b	$L657
	sw	$2,236($5)

$L727:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L656:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L656
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,7			# 0x7
	sw	$6,4($3)
	b	$L655
	sw	$2,236($5)

$L726:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L654:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L654
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,6			# 0x6
	sw	$6,4($3)
	b	$L653
	sw	$2,236($5)

$L725:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L652:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L652
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,5			# 0x5
	sw	$6,4($3)
	b	$L651
	sw	$2,236($5)

$L724:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L650:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L650
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,4			# 0x4
	sw	$6,4($3)
	b	$L649
	sw	$2,236($5)

$L723:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L648:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L648
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,3			# 0x3
	sw	$6,4($3)
	b	$L647
	sw	$2,236($5)

$L722:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L646:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L646
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,2			# 0x2
	sw	$6,4($3)
	b	$L645
	sw	$2,236($5)

$L721:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L644:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L644
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$2,0($3)
	li	$2,1			# 0x1
	sw	$6,4($3)
	b	$L643
	sw	$2,236($5)

$L720:
	sll	$3,$7,3
	subu	$3,$5,$3
	sll	$5,$3,4
	addu	$3,$3,$5
	addu	$5,$16,$3
	move	$3,$5
	addiu	$6,$2,400
$L642:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$6,$L642
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	addiu	$7,$7,1
	sw	$6,4($3)
	sw	$2,0($3)
	b	$L641
	sw	$0,236($5)

$L564:
	li	$3,131072			# 0x20000
	addu	$3,$4,$3
	lw	$13,6828($3)
	blez	$13,$L567
	ori	$2,$2,0x173c

	li	$24,2147418112			# 0x7fff0000
	addu	$25,$4,$2
	ori	$24,$24,0xffff
	addiu	$15,$sp,448
	li	$12,-2147483648			# 0xffffffff80000000
	move	$11,$0
	li	$5,-1			# 0xffffffffffffffff
	li	$17,-1			# 0xffffffffffffffff
$L568:
	move	$6,$25
	move	$7,$24
	li	$10,-2147483648			# 0xffffffff80000000
	move	$2,$0
$L570:
	lw	$3,0($6)
	addiu	$6,$6,4
	lw	$3,228($3)
	slt	$8,$12,$3
	beq	$8,$0,$L569
	slt	$9,$3,$7

	movn	$10,$2,$9
	movn	$7,$3,$9
$L569:
	addiu	$2,$2,1
	bne	$2,$13,$L570
	move	$3,$15

	addiu	$10,$10,17870
	sll	$10,$10,2
	addu	$10,$4,$10
	lw	$6,4($10)
	move	$2,$6
	addiu	$8,$6,400
$L571:
	lw	$18,0($2)
	lw	$12,4($2)
	lw	$10,8($2)
	lw	$9,12($2)
	addiu	$2,$2,16
	sw	$18,0($3)
	sw	$12,4($3)
	sw	$10,8($3)
	sw	$9,12($3)
	bne	$2,$8,$L571
	addiu	$3,$3,16

	lw	$8,4($2)
	lw	$2,0($2)
	sw	$8,4($3)
	bne	$5,$17,$L572
	sw	$2,0($3)

	lw	$2,1880($4)
	lw	$3,228($6)
	lw	$2,228($2)
	slt	$2,$3,$2
	movz	$5,$11,$2
$L572:
	addiu	$11,$11,1
	addiu	$15,$15,408
	bne	$11,$13,$L568
	move	$12,$7

$L573:
	li	$11,65536			# 0x10000
	ori	$17,$11,0x1730
	li	$22,131072			# 0x20000
	addu	$17,$4,$17
	addiu	$2,$sp,32
	addiu	$21,$sp,24
	addu	$22,$4,$22
	addu	$11,$4,$11
	addiu	$3,$sp,40
	addiu	$4,$14,400
	addiu	$6,$14,408
	sw	$2,13516($sp)
	move	$10,$21
	move	$9,$17
	sw	$2,13508($sp)
	li	$fp,1			# 0x1
	move	$19,$0
	li	$15,1			# 0x1
	li	$8,3			# 0x3
	li	$18,1			# 0x1
	li	$7,-99			# 0xffffffffffffff9d
	li	$20,-1			# 0xffffffffffffffff
	sw	$3,13520($sp)
	sw	$4,13512($sp)
	sw	$6,13524($sp)
$L574:
	blez	$13,$L737
	move	$4,$0

	lw	$23,0($9)
	beq	$23,$0,$L588
	move	$6,$0

	sw	$0,13504($sp)
	li	$2,-99			# 0xffffffffffffff9d
$L580:
	beq	$19,$0,$L620
	move	$3,$15

	bltz	$2,$L583
	slt	$12,$2,$13

$L738:
	bne	$12,$0,$L623
	nop

	beq	$3,$20,$L673
	li	$2,-1			# 0xffffffffffffffff

$L581:
	subu	$3,$0,$3
	sra	$2,$3,1
	addu	$2,$2,$5
	bgez	$2,$L738
	slt	$12,$2,$13

$L583:
	beq	$2,$7,$L581
	nop

	bne	$3,$20,$L581
	nop

$L582:
	b	$L673
	li	$2,-1			# 0xffffffffffffffff

$L620:
$L626:
	bltz	$2,$L622
	slt	$12,$2,$13

	beq	$12,$0,$L625
	nop

$L623:
	sll	$24,$2,3
	sll	$25,$2,5
	subu	$12,$25,$24
	sll	$13,$12,4
	addu	$12,$12,$13
	addu	$12,$21,$12
	lw	$13,504($12)
	beq	$13,$8,$L739
	move	$15,$3

$L585:
	lw	$13,6828($22)
	addiu	$6,$6,1
	slt	$12,$6,$13
	beq	$12,$0,$L578
	sltu	$12,$4,$23

	beq	$12,$0,$L588
	sw	$4,13504($sp)

	b	$L580
	addu	$2,$2,$3

$L622:
	beq	$2,$7,$L624
	nop

$L625:
	beq	$3,$18,$L582
	nop

$L624:
	subu	$3,$0,$3
	sra	$2,$3,1
	b	$L626
	addu	$2,$2,$5

$L739:
	lw	$13,13504($sp)
	lw	$23,13504($sp)
	sll	$13,$13,5
	sll	$23,$23,3
	subu	$13,$13,$23
	sll	$23,$13,4
	addu	$13,$13,$23
	lw	$23,0($10)
	mtlo	$2
	addu	$23,$23,$13
	addiu	$13,$12,824
	sw	$13,13504($sp)
	sw	$23,13528($sp)
	addiu	$12,$12,424
	move	$13,$23
$L586:
	lw	$2,0($12)
	sw	$2,13528($sp)
	lw	$2,4($12)
	sw	$2,13532($sp)
	lw	$2,8($12)
	sw	$2,13536($sp)
	lw	$2,12($12)
	addiu	$12,$12,16
	sw	$2,12($13)
	lw	$2,13528($sp)
	sw	$2,0($13)
	lw	$2,13532($sp)
	sw	$2,4($13)
	lw	$2,13536($sp)
	sw	$2,8($13)
	lw	$2,13504($sp)
	bne	$12,$2,$L586
	addiu	$13,$13,16

	sw	$23,13528($sp)
	subu	$24,$25,$24
	lw	$23,0($12)
	lw	$25,4($12)
	sll	$12,$24,4
	addu	$24,$24,$12
	sw	$25,4($13)
	sw	$23,0($13)
	addu	$24,$21,$24
	lw	$12,656($24)
	lw	$13,13528($sp)
	mflo	$2
	sw	$12,236($13)
	addiu	$4,$4,1
	b	$L585
	lw	$23,0($9)

$L737:
	lw	$23,0($9)
$L578:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6076($11)
	beq	$2,$0,$L589
	nop

	lw	$3,80($2)
	beq	$3,$8,$L740
	sll	$6,$4,5

$L589:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6080($11)
	beq	$2,$0,$L591
	nop

	lw	$3,80($2)
	beq	$3,$8,$L741
	sll	$6,$4,5

$L591:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6084($11)
	beq	$2,$0,$L593
	nop

	lw	$3,80($2)
	beq	$3,$8,$L742
	sll	$6,$4,5

$L593:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6088($11)
	beq	$2,$0,$L595
	nop

	lw	$3,80($2)
	beq	$3,$8,$L743
	sll	$6,$4,5

$L595:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6092($11)
	beq	$2,$0,$L597
	nop

	lw	$3,80($2)
	beq	$3,$8,$L744
	sll	$6,$4,5

$L597:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6096($11)
	beq	$2,$0,$L599
	nop

	lw	$3,80($2)
	beq	$3,$8,$L745
	sll	$6,$4,5

$L599:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6100($11)
	beq	$2,$0,$L601
	nop

	lw	$3,80($2)
	beq	$3,$8,$L746
	sll	$6,$4,5

$L601:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6104($11)
	beq	$2,$0,$L603
	nop

	lw	$3,80($2)
	beq	$3,$8,$L747
	sll	$6,$4,5

$L603:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6108($11)
	beq	$2,$0,$L605
	nop

	lw	$3,80($2)
	beq	$3,$8,$L748
	sll	$6,$4,5

$L605:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6112($11)
	beq	$2,$0,$L607
	nop

	lw	$3,80($2)
	beq	$3,$8,$L749
	sll	$6,$4,5

$L607:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6116($11)
	beq	$2,$0,$L609
	nop

	lw	$3,80($2)
	beq	$3,$8,$L750
	sll	$6,$4,5

$L609:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6120($11)
	beq	$2,$0,$L611
	nop

	lw	$3,80($2)
	beq	$3,$8,$L751
	sll	$6,$4,5

$L611:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6124($11)
	beq	$2,$0,$L613
	nop

	lw	$3,80($2)
	beq	$3,$8,$L752
	sll	$6,$4,5

$L613:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6128($11)
	beq	$2,$0,$L615
	nop

	lw	$3,80($2)
	beq	$3,$8,$L753
	sll	$6,$4,5

$L615:
	sltu	$2,$4,$23
	beq	$2,$0,$L588
	nop

	lw	$2,6132($11)
	beq	$2,$0,$L617
	nop

	lw	$3,80($2)
	beq	$3,$8,$L754
	sll	$6,$4,5

$L617:
	sltu	$23,$4,$23
	beq	$23,$0,$L588
	nop

	lw	$2,6136($11)
	beq	$2,$0,$L757
	lw	$23,13508($sp)

	lw	$3,80($2)
	bne	$3,$8,$L757
	nop

	sll	$6,$4,5
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L627:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L627
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	addiu	$4,$4,1
	sw	$2,0($3)
	li	$2,15			# 0xf
	sw	$12,4($3)
	sw	$2,236($6)
$L588:
	lw	$23,13508($sp)
$L757:
	bne	$19,$0,$L755
	sw	$4,0($23)

	lw	$12,13508($sp)
$L759:
	move	$15,$20
	addiu	$12,$12,4
	movz	$15,$18,$fp
	lw	$13,6828($22)
	addiu	$19,$19,1
	sw	$12,13508($sp)
	addiu	$9,$9,4
	addiu	$10,$10,4
	b	$L574
	addiu	$fp,$fp,1

$L719:
	b	$L566
	move	$7,$0

$L755:
	blez	$5,$L629
	nop

	lw	$2,6828($22)
	slt	$2,$5,$2
	bne	$2,$0,$L758
	slt	$2,$fp,2

$L629:
	slt	$4,$4,2
	bne	$4,$0,$L630
	lw	$2,13520($sp)

	move	$3,$14
$L631:
	lw	$4,12($3)
	lw	$13,0($3)
	lw	$12,4($3)
	lw	$6,8($3)
	sw	$13,0($2)
	sw	$12,4($2)
	sw	$6,8($2)
	sw	$4,12($2)
	lw	$4,13512($sp)
	addiu	$3,$3,16
	bne	$3,$4,$L631
	addiu	$2,$2,16

	lw	$6,13512($sp)
	lw	$4,0($4)
	lw	$3,4($6)
	sw	$4,0($2)
	sw	$3,4($2)
	lw	$2,13524($sp)
	move	$3,$14
	addiu	$4,$14,808
$L632:
	lw	$15,0($2)
	lw	$13,4($2)
	lw	$12,8($2)
	lw	$6,12($2)
	addiu	$2,$2,16
	sw	$15,0($3)
	sw	$13,4($3)
	sw	$12,8($3)
	sw	$6,12($3)
	bne	$2,$4,$L632
	addiu	$3,$3,16

	lw	$4,4($2)
	lw	$2,0($2)
	sw	$4,4($3)
	sw	$2,0($3)
	lw	$2,13520($sp)
	lw	$3,13524($sp)
	addiu	$4,$sp,440
$L633:
	lw	$15,0($2)
	lw	$13,4($2)
	lw	$12,8($2)
	lw	$6,12($2)
	addiu	$2,$2,16
	sw	$15,0($3)
	sw	$13,4($3)
	sw	$12,8($3)
	sw	$6,12($3)
	bne	$2,$4,$L633
	addiu	$3,$3,16

	lw	$4,4($2)
	lw	$2,0($2)
	sw	$4,4($3)
	sw	$2,0($3)
$L630:
	slt	$2,$fp,2
$L758:
	bne	$2,$0,$L759
	lw	$12,13508($sp)

	lw	$20,13516($sp)
	move	$18,$0
	li	$19,26112			# 0x6600
$L636:
	lw	$2,0($20)
	lw	$3,0($17)
	sltu	$4,$2,$3
	bne	$4,$0,$L756
	addiu	$20,$20,4

$L635:
	addiu	$18,$18,13056
	bne	$18,$19,$L636
	addiu	$17,$17,4

	b	$L673
	move	$2,$0

$L756:
	sll	$5,$2,5
	sll	$4,$2,3
	subu	$4,$5,$4
	subu	$3,$3,$2
	sll	$2,$3,5
	sll	$5,$4,4
	sll	$3,$3,3
	subu	$2,$2,$3
	addu	$4,$4,$5
	lw	$25,%call16(memset)($28)
	sll	$6,$2,4
	addu	$4,$4,$18
	addu	$6,$2,$6
	addu	$4,$16,$4
	jalr	$25
	move	$5,$0

	b	$L635
	lw	$28,16($sp)

$L743:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L596:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L596
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	sw	$8,236($6)
	lw	$23,0($9)
	b	$L595
	addiu	$4,$4,1

$L742:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L594:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L594
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,2			# 0x2
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L593
	addiu	$4,$4,1

$L741:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L592:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L592
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	sw	$18,236($6)
	lw	$23,0($9)
	b	$L591
	addiu	$4,$4,1

$L740:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L590:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L590
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	sw	$0,236($6)
	lw	$23,0($9)
	b	$L589
	addiu	$4,$4,1

$L567:
	b	$L573
	li	$5,-1			# 0xffffffffffffffff

$L753:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L616:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L616
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,13			# 0xd
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L615
	addiu	$4,$4,1

$L754:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L618:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L618
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,14			# 0xe
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L617
	addiu	$4,$4,1

$L752:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L614:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L614
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,12			# 0xc
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L613
	addiu	$4,$4,1

$L751:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L612:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L612
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,11			# 0xb
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L611
	addiu	$4,$4,1

$L750:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L610:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L610
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,10			# 0xa
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L609
	addiu	$4,$4,1

$L749:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L608:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L608
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,9			# 0x9
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L607
	addiu	$4,$4,1

$L748:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L606:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L606
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,8			# 0x8
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L605
	addiu	$4,$4,1

$L747:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L604:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L604
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,7			# 0x7
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L603
	addiu	$4,$4,1

$L746:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L602:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L602
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,6			# 0x6
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L601
	addiu	$4,$4,1

$L745:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L600:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L600
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,5			# 0x5
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L599
	addiu	$4,$4,1

$L744:
	sll	$3,$4,3
	subu	$3,$6,$3
	sll	$12,$3,4
	lw	$6,0($10)
	addu	$3,$3,$12
	addu	$6,$6,$3
	move	$3,$6
	addiu	$12,$2,400
$L598:
	lw	$25,0($2)
	lw	$24,4($2)
	lw	$15,8($2)
	lw	$13,12($2)
	addiu	$2,$2,16
	sw	$25,0($3)
	sw	$24,4($3)
	sw	$15,8($3)
	sw	$13,12($3)
	bne	$2,$12,$L598
	addiu	$3,$3,16

	lw	$12,4($2)
	lw	$2,0($2)
	sw	$12,4($3)
	sw	$2,0($3)
	li	$2,4			# 0x4
	sw	$2,236($6)
	lw	$23,0($9)
	b	$L597
	addiu	$4,$4,1

	.set	macro
	.set	reorder
	.end	fill_default_ref_list
	.size	fill_default_ref_list, .-fill_default_ref_list
	.align	2
	.set	nomips16
	.ent	free_tables
	.type	free_tables, @function
free_tables:
	.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 16, gp= 8
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-48
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	.cprestore	16
	lw	$25,%call16(av_freep)($28)
	move	$19,$4
	jalr	$25
	addiu	$4,$4,8816

	lw	$28,16($sp)
	li	$16,131072			# 0x20000
	lw	$25,%call16(av_freep)($28)
	ori	$4,$16,0x21e4
	jalr	$25
	addu	$4,$19,$4

	lw	$28,16($sp)
	ori	$4,$16,0x21d4
	lw	$25,%call16(av_freep)($28)
	jalr	$25
	addu	$4,$19,$4

	lw	$28,16($sp)
	ori	$17,$16,0x21ec
	lw	$25,%call16(av_freep)($28)
	addu	$17,$19,$17
	jalr	$25
	move	$4,$17

	lw	$28,16($sp)
	addiu	$4,$17,4
	lw	$25,%call16(av_freep)($28)
	jalr	$25
	addiu	$18,$19,9788

	lw	$28,16($sp)
	ori	$4,$16,0x2338
	lw	$25,%call16(av_freep)($28)
	jalr	$25
	addu	$4,$19,$4

	lw	$28,16($sp)
	addiu	$4,$19,9128
	lw	$25,%call16(av_freep)($28)
	jalr	$25
	move	$16,$0

	lw	$28,16($sp)
	li	$4,59244			# 0xe76c
	lw	$25,%call16(av_freep)($28)
	jalr	$25
	addu	$4,$19,$4

	lw	$28,16($sp)
	li	$2,65536			# 0x10000
	lw	$25,%call16(av_freep)($28)
	addu	$2,$19,$2
	sw	$0,-6288($2)
	jalr	$25
	addiu	$4,$19,9740

	lw	$28,16($sp)
	addiu	$4,$19,9744
	lw	$25,%call16(av_freep)($28)
	jalr	$25
	li	$17,128			# 0x80

	lw	$28,16($sp)
$L761:
	lw	$25,%call16(av_freep)($28)
	addu	$4,$18,$16
	jalr	$25
	addiu	$16,$16,4

	bne	$16,$17,$L761
	lw	$28,16($sp)

	addiu	$18,$19,10780
	move	$16,$0
	li	$17,1024			# 0x400
$L762:
	lw	$25,%call16(av_freep)($28)
	addu	$4,$18,$16
	jalr	$25
	addiu	$16,$16,4

	bne	$16,$17,$L762
	lw	$28,16($sp)

	lw	$2,0($19)
	lw	$2,620($2)
	blez	$2,$L766
	li	$18,131072			# 0x20000

	ori	$18,$18,0x24a0
	addu	$18,$19,$18
	move	$17,$0
$L765:
	lw	$16,0($18)
	lw	$25,%call16(av_freep)($28)
	addiu	$17,$17,1
	addiu	$18,$18,4
	addiu	$4,$16,9000
	beq	$16,$0,$L764
	addiu	$20,$16,8996

	jalr	$25
	nop

	lw	$28,16($sp)
	lw	$25,%call16(av_freep)($28)
	jalr	$25
	move	$4,$20

	lw	$28,16($sp)
	lw	$25,%call16(av_freep)($28)
	jalr	$25
	addiu	$4,$16,2048

	lw	$28,16($sp)
	lw	$25,%call16(av_freep)($28)
	jalr	$25
	addiu	$4,$16,2036

	lw	$2,0($19)
	lw	$28,16($sp)
	lw	$2,620($2)
$L764:
	slt	$3,$17,$2
	bne	$3,$0,$L765
	nop

$L766:
	lw	$31,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,48

	.set	macro
	.set	reorder
	.end	free_tables
	.size	free_tables, .-free_tables
	.section	.rodata.str1.4
	.align	2
$LC3:
	.ascii	"malloc\000"
	.text
	.align	2
	.set	nomips16
	.ent	alloc_tables
	.type	alloc_tables, @function
alloc_tables:
	.frame	$sp,40,$31		# vars= 0, regs= 4/0, args= 16, gp= 8
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-40
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	.cprestore	16
	lw	$17,148($4)
	lw	$2,152($4)
	addiu	$17,$17,1
	mul	$17,$17,$2
	lw	$25,%call16(av_mallocz)($28)
	move	$16,$4
	jalr	$25
	sll	$4,$17,3

	lw	$28,16($sp)
	beq	$2,$0,$L795
	sw	$2,8816($16)

$L771:
	lw	$25,%call16(av_mallocz)($28)
	jalr	$25
	sll	$4,$17,4

	lw	$28,16($sp)
	beq	$2,$0,$L796
	sw	$2,9128($16)

$L773:
	lw	$4,152($16)
	lw	$25,%call16(av_mallocz)($28)
	jalr	$25
	addu	$4,$17,$4

	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$28,16($sp)
	beq	$2,$0,$L797
	sw	$2,-6292($3)

	lw	$25,%call16(av_mallocz)($28)
$L805:
	sll	$18,$17,1
	jalr	$25
	move	$4,$18

	li	$3,131072			# 0x20000
	addu	$3,$16,$3
	lw	$28,16($sp)
	beq	$2,$0,$L798
	sw	$2,8660($3)

$L775:
	lw	$2,11808($16)
	beq	$2,$0,$L776
	lw	$25,%call16(av_mallocz)($28)

	jalr	$25
	move	$4,$17

	li	$3,131072			# 0x20000
	addu	$3,$16,$3
	lw	$28,16($sp)
	beq	$2,$0,$L799
	sw	$2,8676($3)

$L777:
	lw	$25,%call16(av_mallocz)($28)
	sll	$18,$17,6
	jalr	$25
	move	$4,$18

	li	$3,131072			# 0x20000
	addu	$3,$16,$3
	lw	$28,16($sp)
	beq	$2,$0,$L800
	sw	$2,8684($3)

	lw	$25,%call16(av_mallocz)($28)
	jalr	$25
	move	$4,$18

	li	$3,131072			# 0x20000
	addu	$3,$16,$3
	lw	$28,16($sp)
	beq	$2,$0,$L801
	sw	$2,8688($3)

$L779:
	lw	$25,%call16(av_mallocz)($28)
	jalr	$25
	sll	$4,$17,5

	li	$3,131072			# 0x20000
	addu	$3,$16,$3
	lw	$28,16($sp)
	beq	$2,$0,$L802
	sw	$2,9016($3)

$L776:
	li	$18,65536			# 0x10000
$L806:
	addu	$18,$16,$18
	lw	$6,152($16)
	lw	$25,%call16(memset)($28)
	lw	$4,-6292($18)
	addu	$6,$17,$6
	jalr	$25
	li	$5,-1			# 0xffffffffffffffff

	lw	$2,152($16)
	lw	$28,16($sp)
	lw	$3,-6292($18)
	sll	$2,$2,1
	addiu	$2,$2,1
	lw	$25,%call16(av_mallocz)($28)
	addu	$2,$3,$2
	sll	$17,$17,2
	sw	$2,-6288($18)
	jalr	$25
	move	$4,$17

	lw	$28,16($sp)
	beq	$2,$0,$L803
	sw	$2,9740($16)

	lw	$25,%call16(av_mallocz)($28)
	jalr	$25
	move	$4,$17

	lw	$28,16($sp)
	beq	$2,$0,$L781
	sw	$2,9744($16)

$L784:
	lw	$2,148($16)
	blez	$2,$L782
	nop

	lw	$4,144($16)
	move	$3,$0
$L783:
	blez	$4,$L786
	nop

	lw	$9,9740($16)
	lw	$8,9744($16)
	move	$2,$0
$L785:
	lw	$4,152($16)
	lw	$7,9748($16)
	mul	$5,$3,$4
	lw	$6,9752($16)
	addu	$4,$5,$2
	mul	$5,$3,$7
	sll	$4,$4,2
	addu	$7,$5,$2
	mul	$5,$3,$6
	sll	$7,$7,2
	addu	$6,$5,$2
	sll	$6,$6,1
	addu	$5,$8,$4
	addu	$4,$9,$4
	sw	$7,0($4)
	sw	$6,0($5)
	lw	$4,144($16)
	addiu	$2,$2,1
	slt	$5,$2,$4
	bne	$5,$0,$L785
	nop

	lw	$2,148($16)
$L786:
	addiu	$3,$3,1
	slt	$5,$3,$2
	bne	$5,$0,$L783
	nop

$L782:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,-6332($2)
	beq	$2,$0,$L787
	sw	$0,2048($16)

	move	$2,$0
$L788:
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,40

$L797:
	lw	$2,152($16)
	addu	$2,$17,$2
	beq	$2,$0,$L805
	lw	$25,%call16(av_mallocz)($28)

$L791:
$L772 = .
	lw	$25,%call16(perror)($28)
$L804:
	lui	$4,%hi($LC3)
$L807:
	jalr	$25
	addiu	$4,$4,%lo($LC3)

	.option	pic0
	jal	free_tables
	.option	pic2
	move	$4,$16

	b	$L788
	li	$2,-1			# 0xffffffffffffffff

$L796:
	beq	$17,$0,$L773
	lw	$25,%call16(perror)($28)

	b	$L807
	lui	$4,%hi($LC3)

$L795:
	beq	$17,$0,$L771
	lw	$25,%call16(perror)($28)

	b	$L807
	lui	$4,%hi($LC3)

$L803:
	bne	$17,$0,$L791
	lw	$25,%call16(av_mallocz)($28)

	jalr	$25
	move	$4,$17

	lw	$28,16($sp)
	bne	$2,$0,$L784
	sw	$2,9744($16)

$L781:
	beq	$17,$0,$L784
	lw	$25,%call16(perror)($28)

	b	$L807
	lui	$4,%hi($LC3)

$L802:
	beq	$17,$0,$L806
	li	$18,65536			# 0x10000

	b	$L804
	lw	$25,%call16(perror)($28)

$L787:
	.option	pic0
	jal	init_dequant_tables
	.option	pic2
	move	$4,$16

	b	$L788
	move	$2,$0

$L800:
	bne	$18,$0,$L791
	lw	$25,%call16(av_mallocz)($28)

	jalr	$25
	move	$4,$18

	li	$3,131072			# 0x20000
	addu	$3,$16,$3
	lw	$28,16($sp)
	bne	$2,$0,$L779
	sw	$2,8688($3)

$L801:
	beq	$18,$0,$L779
	lw	$25,%call16(perror)($28)

	b	$L807
	lui	$4,%hi($LC3)

$L799:
	beq	$17,$0,$L777
	lw	$25,%call16(perror)($28)

	b	$L807
	lui	$4,%hi($LC3)

$L798:
	beq	$18,$0,$L775
	lw	$25,%call16(perror)($28)

	b	$L807
	lui	$4,%hi($LC3)

	.set	macro
	.set	reorder
	.end	alloc_tables
	.size	alloc_tables, .-alloc_tables
	.align	2
	.set	nomips16
	.ent	frame_start
	.type	frame_start, @function
frame_start:
	.frame	$sp,64,$31		# vars= 0, regs= 10/0, args= 16, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-64
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,60($sp)
	sw	$fp,56($sp)
	sw	$23,52($sp)
	sw	$22,48($sp)
	sw	$21,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	.cprestore	16
	lw	$25,%call16(MPV_frame_start)($28)
	lw	$5,0($4)
	jalr	$25
	move	$16,$4

	bltz	$2,$L817
	lw	$28,16($sp)

	lw	$25,%call16(ff_er_frame_start)($28)
	jalr	$25
	move	$4,$16

	lw	$2,1880($16)
	li	$5,3			# 0x3
	sw	$0,48($2)
	lw	$2,176($16)
	li	$3,4			# 0x4
	sll	$4,$2,3
	mul	$7,$5,$2
	mul	$5,$5,$4
	sll	$8,$2,1
	addiu	$9,$2,1
	sll	$6,$2,4
	addiu	$15,$8,3
	addiu	$23,$2,2
	addiu	$21,$2,3
	addiu	$19,$8,1
	addiu	$17,$7,1
	addiu	$13,$7,2
	sll	$9,$9,2
	addiu	$8,$8,2
	addiu	$11,$7,3
	sw	$9,9560($16)
	sll	$8,$8,2
	addiu	$14,$6,12
	li	$9,12			# 0xc
	li	$10,8			# 0x8
	sll	$2,$2,2
	addiu	$fp,$4,4
	addiu	$22,$4,8
	addiu	$20,$4,12
	addiu	$18,$6,4
	sll	$7,$7,2
	addiu	$25,$5,4
	addiu	$24,$6,8
	addiu	$12,$5,8
	sll	$23,$23,2
	sll	$21,$21,2
	sll	$19,$19,2
	sll	$17,$17,2
	sll	$15,$15,2
	sll	$13,$13,2
	sw	$2,9556($16)
	sw	$7,9588($16)
	sw	$8,9596($16)
	sw	$3,9552($16)
	sw	$3,9648($16)
	sw	$4,9652($16)
	sw	$4,9580($16)
	sw	$6,9676($16)
	lw	$28,16($sp)
	sw	$fp,9656($16)
	sw	$10,9660($16)
	sw	$9,9664($16)
	sw	$23,9572($16)
	sw	$22,9668($16)
	sw	$21,9576($16)
	sw	$20,9672($16)
	sw	$19,9584($16)
	sw	$18,9680($16)
	sw	$17,9592($16)
	sw	$25,9688($16)
	sw	$24,9692($16)
	sw	$15,9600($16)
	sw	$14,9696($16)
	sw	$13,9604($16)
	sw	$12,9700($16)
	sw	$0,9548($16)
	sw	$0,9644($16)
	sw	$10,9564($16)
	sw	$9,9568($16)
	sw	$5,9684($16)
	lw	$4,180($16)
	sll	$11,$11,2
	sll	$2,$4,3
	addiu	$7,$4,1
	sll	$7,$7,2
	addiu	$6,$2,4
	sll	$4,$4,2
	addiu	$5,$5,12
	lw	$8,0($16)
	sw	$11,9608($16)
	sw	$5,9704($16)
	sw	$3,9712($16)
	sw	$4,9620($16)
	sw	$7,9624($16)
	sw	$6,9720($16)
	sw	$0,9628($16)
	sw	$0,9612($16)
	sw	$0,9724($16)
	sw	$0,9708($16)
	sw	$3,9632($16)
	sw	$3,9616($16)
	sw	$3,9728($16)
	sw	$4,9636($16)
	sw	$2,9732($16)
	sw	$2,9716($16)
	sw	$7,9640($16)
	sw	$6,9736($16)
	lw	$3,620($8)
	blez	$3,$L819
	li	$2,65536			# 0x10000

	li	$18,131072			# 0x20000
	ori	$18,$18,0x24a0
	addu	$18,$16,$18
	move	$17,$0
$L813:
	lw	$19,0($18)
	addiu	$17,$17,1
	lw	$2,2048($19)
	beq	$2,$0,$L818
	addiu	$18,$18,4

$L812:
	slt	$2,$17,$3
	bne	$2,$0,$L813
	li	$2,65536			# 0x10000

$L819:
	addu	$2,$16,$2
	lw	$2,-6276($2)
	bne	$2,$0,$L814
	slt	$3,$3,2

	bne	$3,$0,$L820
	lw	$31,60($sp)

$L814:
	lw	$2,148($16)
	lw	$6,152($16)
	lw	$25,%call16(memset)($28)
	mul	$6,$6,$2
	li	$2,65536			# 0x10000
	addu	$16,$16,$2
	lw	$4,-6288($16)
	addiu	$6,$6,-1
	jalr	$25
	li	$5,-1			# 0xffffffffffffffff

	move	$2,$0
	lw	$31,60($sp)
$L820:
	lw	$fp,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,64

$L817:
	lw	$31,60($sp)
	li	$2,-1			# 0xffffffffffffffff
	lw	$fp,56($sp)
	lw	$23,52($sp)
	lw	$22,48($sp)
	lw	$21,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,64

$L818:
	lw	$4,176($16)
	lw	$2,180($16)
	sll	$4,$4,1
	lw	$25,%call16(av_malloc)($28)
	addu	$4,$4,$2
	jalr	$25
	sll	$4,$4,4

	lw	$3,0($16)
	lw	$28,16($sp)
	sw	$2,2048($19)
	b	$L812
	lw	$3,620($3)

	.set	macro
	.set	reorder
	.end	frame_start
	.size	frame_start, .-frame_start
	.align	2
	.set	nomips16
	.ent	init_scan_tables
	.type	init_scan_tables, @function
init_scan_tables:
	.frame	$sp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x00010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$28,$28,%lo(__gnu_local_gp)
	lw	$3,5116($4)
	lw	$2,%got(ff_h264_idct_add_c)($28)
	addiu	$sp,$sp,-8
	beq	$3,$2,$L839
	sw	$16,4($sp)

	li	$2,131072			# 0x20000
	addu	$2,$4,$2
	li	$25,1			# 0x1
	li	$16,4			# 0x4
	li	$13,8			# 0x8
	li	$24,2			# 0x2
	li	$15,5			# 0x5
	li	$12,12			# 0xc
	li	$14,3			# 0x3
	li	$10,9			# 0x9
	li	$11,6			# 0x6
	li	$6,13			# 0xd
	li	$9,7			# 0x7
	li	$8,10			# 0xa
	li	$5,14			# 0xe
	li	$7,11			# 0xb
	li	$3,15			# 0xf
	sb	$3,9219($2)
	sb	$25,9062($2)
	sb	$16,9206($2)
	sb	$24,9207($2)
	sb	$15,9209($2)
	sb	$11,9068($2)
	sb	$13,9212($2)
	sb	$14,9069($2)
	sb	$10,9213($2)
	sb	$9,9070($2)
	sb	$8,9071($2)
	sb	$12,9216($2)
	sb	$6,9217($2)
	sb	$7,9074($2)
	sb	$5,9218($2)
	sb	$0,9060($2)
	sb	$0,9204($2)
	sb	$16,9061($2)
	sb	$25,9205($2)
	sb	$24,9063($2)
	sb	$15,9064($2)
	sb	$14,9208($2)
	sb	$13,9065($2)
	sb	$12,9066($2)
	sb	$11,9210($2)
	sb	$10,9067($2)
	sb	$9,9211($2)
	sb	$8,9214($2)
	sb	$7,9215($2)
	sb	$6,9072($2)
	sb	$5,9073($2)
	sb	$3,9075($2)
$L823:
	lw	$3,5120($4)
	lw	$2,%got(ff_h264_idct8_add_c)($28)
	beq	$3,$2,$L840
	lui	$15,%hi(zigzag_scan8x8)

	li	$3,131072			# 0x20000
	lui	$14,%hi(zigzag_scan8x8_cavlc)
	lui	$13,%hi(field_scan8x8)
	lui	$24,%hi(field_scan8x8_cavlc)
	ori	$3,$3,0x2374
	addu	$3,$4,$3
	addiu	$15,$15,%lo(zigzag_scan8x8)
	addiu	$14,$14,%lo(zigzag_scan8x8_cavlc)
	addiu	$13,$13,%lo(field_scan8x8)
	addiu	$24,$24,%lo(field_scan8x8_cavlc)
	move	$2,$0
	li	$25,64			# 0x40
$L830:
	addu	$8,$15,$2
	addu	$7,$14,$2
	addu	$6,$13,$2
	addu	$5,$24,$2
	lbu	$8,0($8)
	lbu	$7,0($7)
	lbu	$6,0($6)
	lbu	$5,0($5)
	andi	$12,$8,0x7
	andi	$11,$7,0x7
	andi	$10,$6,0x7
	andi	$9,$5,0x7
	sll	$12,$12,3
	srl	$8,$8,3
	sll	$11,$11,3
	srl	$7,$7,3
	sll	$10,$10,3
	srl	$6,$6,3
	sll	$9,$9,3
	srl	$5,$5,3
	or	$8,$12,$8
	or	$7,$11,$7
	or	$6,$10,$6
	or	$5,$9,$5
	addiu	$2,$2,1
	sb	$8,0($3)
	sb	$7,64($3)
	sb	$6,144($3)
	sb	$5,208($3)
	bne	$2,$25,$L830
	addiu	$3,$3,1

	lw	$2,9924($4)
$L842:
	bne	$2,$0,$L841
	li	$2,131072			# 0x20000

	ori	$9,$2,0x2444
	ori	$8,$2,0x2364
	ori	$7,$2,0x2374
	ori	$6,$2,0x23b4
	ori	$5,$2,0x23f4
	ori	$3,$2,0x2404
	addu	$9,$4,$9
	addu	$2,$4,$2
	addu	$8,$4,$8
	addu	$7,$4,$7
	addu	$6,$4,$6
	addu	$5,$4,$5
	addu	$3,$4,$3
	lw	$16,4($sp)
	sw	$9,9368($2)
	sw	$8,9348($2)
	sw	$7,9352($2)
	sw	$6,9356($2)
	sw	$5,9360($2)
	sw	$3,9364($2)
	j	$31
	addiu	$sp,$sp,8

$L841:
	addu	$4,$4,$2
	lui	$2,%hi(zigzag_scan)
	addiu	$2,$2,%lo(zigzag_scan)
	sw	$2,9348($4)
	lui	$2,%hi(field_scan)
	addiu	$2,$2,%lo(field_scan)
	lw	$16,4($sp)
	sw	$24,9368($4)
	sw	$15,9352($4)
	sw	$14,9356($4)
	sw	$2,9360($4)
	sw	$13,9364($4)
	j	$31
	addiu	$sp,$sp,8

$L840:
	li	$3,131072			# 0x20000
	addiu	$15,$15,%lo(zigzag_scan8x8)
	ori	$3,$3,0x2374
	addu	$3,$4,$3
	move	$2,$15
	addiu	$5,$15,64
$L825:
	lw	$9,0($2)
	lw	$8,4($2)
	lw	$7,8($2)
	lw	$6,12($2)
	addiu	$2,$2,16
	sw	$9,0($3)
	sw	$8,4($3)
	sw	$7,8($3)
	sw	$6,12($3)
	bne	$2,$5,$L825
	addiu	$3,$3,16

	lui	$14,%hi(zigzag_scan8x8_cavlc)
	li	$3,131072			# 0x20000
	addiu	$14,$14,%lo(zigzag_scan8x8_cavlc)
	ori	$3,$3,0x23b4
	addu	$3,$4,$3
	move	$2,$14
	addiu	$5,$14,64
$L826:
	lw	$9,0($2)
	lw	$8,4($2)
	lw	$7,8($2)
	lw	$6,12($2)
	addiu	$2,$2,16
	sw	$9,0($3)
	sw	$8,4($3)
	sw	$7,8($3)
	sw	$6,12($3)
	bne	$2,$5,$L826
	addiu	$3,$3,16

	lui	$13,%hi(field_scan8x8)
	li	$3,131072			# 0x20000
	addiu	$13,$13,%lo(field_scan8x8)
	ori	$3,$3,0x2404
	addu	$3,$4,$3
	move	$2,$13
	addiu	$5,$13,64
$L827:
	lw	$9,0($2)
	lw	$8,4($2)
	lw	$7,8($2)
	lw	$6,12($2)
	addiu	$2,$2,16
	sw	$9,0($3)
	sw	$8,4($3)
	sw	$7,8($3)
	sw	$6,12($3)
	bne	$2,$5,$L827
	addiu	$3,$3,16

	lui	$24,%hi(field_scan8x8_cavlc)
	li	$3,131072			# 0x20000
	addiu	$24,$24,%lo(field_scan8x8_cavlc)
	ori	$3,$3,0x2444
	addu	$3,$4,$3
	move	$2,$24
	addiu	$5,$24,64
$L828:
	lw	$9,0($2)
	lw	$8,4($2)
	lw	$7,8($2)
	lw	$6,12($2)
	addiu	$2,$2,16
	sw	$9,0($3)
	sw	$8,4($3)
	sw	$7,8($3)
	sw	$6,12($3)
	bne	$2,$5,$L828
	addiu	$3,$3,16

	b	$L842
	lw	$2,9924($4)

$L839:
	lui	$8,%hi(zigzag_scan)
	lui	$7,%hi(field_scan)
	addiu	$6,$8,%lo(zigzag_scan)
	addiu	$5,$7,%lo(field_scan)
	li	$3,131072			# 0x20000
	lw	$12,12($6)
	ori	$2,$3,0x23f4
	lw	$11,12($5)
	lw	$10,%lo(zigzag_scan)($8)
	lw	$9,4($6)
	lw	$8,8($6)
	ori	$3,$3,0x2364
	lw	$6,4($5)
	lw	$7,%lo(field_scan)($7)
	lw	$5,8($5)
	addu	$3,$4,$3
	addu	$2,$4,$2
	sw	$12,12($3)
	sw	$11,12($2)
	sw	$10,0($3)
	sw	$9,4($3)
	sw	$8,8($3)
	sw	$7,0($2)
	sw	$6,4($2)
	b	$L823
	sw	$5,8($2)

	.set	macro
	.set	reorder
	.end	init_scan_tables
	.size	init_scan_tables, .-init_scan_tables
	.align	2
	.set	nomips16
	.ent	mc_dir_part
	.type	mc_dir_part, @function
mc_dir_part:
	.frame	$sp,136,$31		# vars= 48, regs= 10/0, args= 40, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-136
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,132($sp)
	sw	$fp,128($sp)
	sw	$23,124($sp)
	sw	$22,120($sp)
	sw	$21,116($sp)
	sw	$20,112($sp)
	sw	$19,108($sp)
	sw	$18,104($sp)
	sw	$17,100($sp)
	sw	$16,96($sp)
	.cprestore	40
	lui	$2,%hi(scan8)
	lw	$fp,160($sp)
	addiu	$2,$2,%lo(scan8)
	addu	$2,$2,$6
	lbu	$22,0($2)
	sll	$23,$fp,5
	sll	$fp,$fp,3
	addu	$2,$fp,$23
	addu	$2,$2,$22
	addiu	$3,$2,2284
	move	$20,$5
	sll	$2,$2,2
	sll	$5,$3,2
	move	$16,$4
	addu	$5,$4,$5
	addu	$2,$4,$2
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	lw	$8,-6268($4)
	lw	$4,156($sp)
	sw	$7,72($sp)
	lh	$9,9138($2)
	lw	$7,164($sp)
	lw	$2,152($sp)
	sw	$4,84($sp)
	lw	$12,168($sp)
	lw	$4,188($sp)
	lw	$25,172($sp)
	lw	$3,0($20)
	lh	$10,0($5)
	sw	$2,60($sp)
	sw	$7,56($sp)
	sw	$4,64($sp)
	sw	$12,76($sp)
	sw	$25,80($sp)
	lw	$17,176($sp)
	lw	$18,180($sp)
	lw	$2,184($sp)
	lw	$6,9756($16)
	lw	$4,9764($16)
	lw	$5,9768($16)
	lw	$7,144($16)
	beq	$3,$0,$L856
	lw	$11,148($16)

	sll	$18,$18,3
	addu	$18,$18,$9
	sll	$17,$17,3
	addu	$17,$17,$10
	sra	$10,$18,2
	mul	$12,$10,$6
	addiu	$9,$4,-3
	andi	$21,$17,0x7
	movn	$4,$9,$21
	sra	$9,$17,2
	addu	$13,$12,$9
	sll	$11,$11,4
	subu	$12,$0,$4
	sltu	$8,$0,$8
	andi	$19,$18,0x7
	addiu	$14,$5,-3
	sra	$8,$11,$8
	sll	$7,$7,4
	slt	$12,$9,$12
	movn	$5,$14,$19
	addu	$3,$3,$13
	sw	$8,48($sp)
	bne	$12,$0,$L847
	sw	$7,52($sp)

	subu	$7,$0,$5
	slt	$7,$10,$7
	beq	$7,$0,$L857
	lw	$25,52($sp)

$L847:
	nor	$5,$0,$6
$L862:
	sll	$5,$5,1
	addu	$5,$3,$5
	li	$3,21			# 0x15
	lw	$4,2040($16)
	lw	$7,48($sp)
	sw	$3,16($sp)
	lw	$3,52($sp)
	addiu	$9,$9,-2
	addiu	$10,$10,-2
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	sw	$3,28($sp)
	sw	$7,32($sp)
	sw	$2,92($sp)
	sw	$9,20($sp)
	sw	$10,24($sp)
	jalr	$25
	li	$7,21			# 0x15

	lw	$6,9756($16)
	lw	$4,2040($16)
	addiu	$3,$6,1
	sll	$3,$3,1
	li	$12,1			# 0x1
	lw	$2,92($sp)
	addu	$3,$4,$3
	sw	$12,68($sp)
$L848:
	andi	$4,$18,0x3
	andi	$5,$17,0x3
	sll	$4,$4,2
	addu	$4,$4,$5
	sll	$4,$4,2
	addu	$2,$2,$4
	lw	$25,0($2)
	lw	$4,56($sp)
	move	$5,$3
	sw	$2,92($sp)
	jalr	$25
	sw	$3,88($sp)

	lw	$25,72($sp)
	lw	$28,40($sp)
	lw	$2,92($sp)
	beq	$25,$0,$L858
	lw	$3,88($sp)

$L849:
	lw	$2,56($16)
	andi	$2,$2,0x2000
	bne	$2,$0,$L856
	li	$2,65536			# 0x10000

	addu	$2,$16,$2
	lw	$2,-6268($2)
	bne	$2,$0,$L850
	addu	$23,$fp,$23

	lw	$6,9760($16)
	sra	$22,$18,3
	mul	$3,$22,$6
	sra	$17,$17,3
	lw	$18,8($20)
	lw	$5,4($20)
	lw	$4,68($sp)
	addu	$2,$3,$17
	addu	$18,$18,$2
	bne	$4,$0,$L859
	addu	$5,$5,$2

$L854:
	lw	$4,76($sp)
	lw	$7,60($sp)
	lw	$25,64($sp)
	sw	$21,16($sp)
	jalr	$25
	sw	$19,20($sp)

	lw	$28,40($sp)
$L855:
	lw	$6,9760($16)
	lw	$4,80($sp)
	lw	$7,60($sp)
	lw	$25,64($sp)
	sw	$21,152($sp)
	sw	$19,156($sp)
	move	$5,$18
	lw	$31,132($sp)
	lw	$fp,128($sp)
	lw	$23,124($sp)
	lw	$22,120($sp)
	lw	$21,116($sp)
	lw	$20,112($sp)
	lw	$19,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	jr	$25
	addiu	$sp,$sp,136

$L857:
	addiu	$7,$9,15
	addu	$4,$4,$25
	slt	$4,$7,$4
	beq	$4,$0,$L847
	addu	$5,$5,$8

	addiu	$4,$10,15
	slt	$5,$4,$5
	beq	$5,$0,$L862
	nor	$5,$0,$6

	b	$L848
	sw	$0,68($sp)

$L850:
	addu	$23,$16,$23
	addu	$22,$23,$22
	lbu	$2,9456($22)
	lw	$19,6172($16)
	andi	$2,$2,0x1
	andi	$19,$19,0x1
	subu	$19,$19,$2
	sll	$19,$19,1
	addu	$18,$18,$19
	sra	$22,$18,3
	bltz	$22,$L860
	lw	$7,48($sp)

	addiu	$3,$22,8
	sra	$2,$7,1
	lw	$12,68($sp)
	slt	$2,$3,$2
	xori	$2,$2,0x1
	or	$12,$12,$2
	sw	$12,68($sp)
	andi	$19,$18,0x7
$L861:
	lw	$6,9760($16)
	sra	$17,$17,3
	mul	$3,$22,$6
	lw	$18,8($20)
	lw	$5,4($20)
	lw	$4,68($sp)
	addu	$2,$3,$17
	addu	$18,$18,$2
	beq	$4,$0,$L854
	addu	$5,$5,$2

$L859:
	lw	$12,48($sp)
	lw	$7,52($sp)
	lw	$4,2040($16)
	sra	$20,$12,1
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	sra	$23,$7,1
	li	$fp,9			# 0x9
	li	$7,9			# 0x9
	sw	$fp,16($sp)
	sw	$17,20($sp)
	sw	$22,24($sp)
	sw	$23,28($sp)
	jalr	$25
	sw	$20,32($sp)

	lw	$5,2040($16)
	lw	$6,9760($16)
	lw	$4,76($sp)
	lw	$7,60($sp)
	lw	$25,64($sp)
	sw	$21,16($sp)
	jalr	$25
	sw	$19,20($sp)

	lw	$28,40($sp)
	lw	$4,2040($16)
	lw	$6,9760($16)
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	move	$5,$18
	sw	$fp,16($sp)
	sw	$17,20($sp)
	sw	$22,24($sp)
	sw	$23,28($sp)
	sw	$20,32($sp)
	jalr	$25
	li	$7,9			# 0x9

	lw	$28,40($sp)
	b	$L855
	lw	$18,2040($16)

$L856:
	lw	$31,132($sp)
	lw	$fp,128($sp)
	lw	$23,124($sp)
	lw	$22,120($sp)
	lw	$21,116($sp)
	lw	$20,112($sp)
	lw	$19,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	j	$31
	addiu	$sp,$sp,136

$L858:
	lw	$25,0($2)
	lw	$2,84($sp)
	lw	$6,9756($16)
	addu	$5,$3,$2
	lw	$3,56($sp)
	jalr	$25
	addu	$4,$3,$2

	b	$L849
	lw	$28,40($sp)

$L860:
	li	$4,1			# 0x1
	sw	$4,68($sp)
	b	$L861
	andi	$19,$18,0x7

	.set	macro
	.set	reorder
	.end	mc_dir_part
	.size	mc_dir_part, .-mc_dir_part
	.align	2
	.set	nomips16
	.ent	decode_end
	.type	decode_end, @function
decode_end:
	.frame	$sp,32,$31		# vars= 0, regs= 2/0, args= 16, gp= 8
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-32
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,28($sp)
	sw	$16,24($sp)
	.cprestore	16
	lw	$16,136($4)
	lw	$25,%call16(av_freep)($28)
	jalr	$25
	addiu	$4,$16,8712

	lw	$28,16($sp)
	lw	$25,%call16(av_freep)($28)
	jalr	$25
	addiu	$4,$16,8716

	.option	pic0
	jal	free_tables
	.option	pic2
	move	$4,$16

	lw	$28,16($sp)
	lw	$25,%call16(MPV_common_end)($28)
	jalr	$25
	move	$4,$16

	lw	$31,28($sp)
	move	$2,$0
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	decode_end
	.size	decode_end, .-decode_end
	.align	2
	.set	nomips16
	.ent	decode_init
	.type	decode_init, @function
decode_init:
	.frame	$sp,80,$31		# vars= 0, regs= 4/0, args= 56, gp= 8
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-80
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,76($sp)
	sw	$18,72($sp)
	sw	$17,68($sp)
	sw	$16,64($sp)
	.cprestore	56
	lw	$17,136($4)
	lw	$25,%call16(MPV_decode_defaults)($28)
	move	$18,$4
	jalr	$25
	move	$4,$17

	lw	$3,40($18)
	lw	$2,132($18)
	lw	$28,56($sp)
	sw	$3,4($17)
	lw	$2,8($2)
	lw	$3,44($18)
	lw	$25,%call16(ff_h264_pred_init)($28)
	move	$5,$2
	sw	$3,8($17)
	sw	$2,44($17)
	addiu	$4,$17,8820
	jalr	$25
	sw	$18,0($17)

	lw	$28,56($sp)
	li	$2,65536			# 0x10000
	li	$16,1			# 0x1
	lw	$25,%call16(memset)($28)
	li	$3,-1			# 0xffffffffffffffff
	addu	$2,$17,$2
	sw	$3,-6300($2)
	addiu	$4,$17,11872
	li	$5,16			# 0x10
	li	$6,96			# 0x60
	sw	$16,2128($17)
	jalr	$25
	sw	$16,2136($17)

	lw	$28,56($sp)
	addiu	$4,$17,11968
	lw	$25,%call16(memset)($28)
	li	$5,16			# 0x10
	jalr	$25
	li	$6,128			# 0x80

	lui	$2,%hi(done.12554)
	lw	$4,236($18)
	lw	$3,%lo(done.12554)($2)
	li	$5,4			# 0x4
	lw	$28,56($sp)
	sw	$5,24($17)
	sw	$4,80($17)
	sw	$16,8188($17)
	sw	$16,8240($17)
	bne	$3,$0,$L866
	sw	$0,52($18)

	sw	$16,%lo(done.12554)($2)
	lui	$2,%hi(chroma_dc_coeff_token_bits)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(chroma_dc_coeff_token_bits)
	lui	$4,%hi(chroma_dc_coeff_token_vlc)
	lui	$7,%hi(chroma_dc_coeff_token_len)
	addiu	$4,$4,%lo(chroma_dc_coeff_token_vlc)
	addiu	$7,$7,%lo(chroma_dc_coeff_token_len)
	li	$5,8			# 0x8
	li	$6,20			# 0x14
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(coeff_token_bits)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(coeff_token_bits)
	lui	$4,%hi(coeff_token_vlc)
	lui	$7,%hi(coeff_token_len)
	addiu	$4,$4,%lo(coeff_token_vlc)
	addiu	$7,$7,%lo(coeff_token_len)
	li	$5,8			# 0x8
	li	$6,68			# 0x44
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(coeff_token_bits+68)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(coeff_token_bits+68)
	lui	$4,%hi(coeff_token_vlc+16)
	lui	$7,%hi(coeff_token_len+68)
	addiu	$4,$4,%lo(coeff_token_vlc+16)
	addiu	$7,$7,%lo(coeff_token_len+68)
	li	$5,8			# 0x8
	li	$6,68			# 0x44
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(coeff_token_bits+136)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(coeff_token_bits+136)
	lui	$4,%hi(coeff_token_vlc+32)
	lui	$7,%hi(coeff_token_len+136)
	addiu	$4,$4,%lo(coeff_token_vlc+32)
	addiu	$7,$7,%lo(coeff_token_len+136)
	li	$5,8			# 0x8
	li	$6,68			# 0x44
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(coeff_token_bits+204)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(coeff_token_bits+204)
	lui	$4,%hi(coeff_token_vlc+48)
	lui	$7,%hi(coeff_token_len+204)
	addiu	$4,$4,%lo(coeff_token_vlc+48)
	addiu	$7,$7,%lo(coeff_token_len+204)
	li	$5,8			# 0x8
	li	$6,68			# 0x44
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(chroma_dc_total_zeros_bits)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(chroma_dc_total_zeros_bits)
	lui	$4,%hi(chroma_dc_total_zeros_vlc)
	lui	$7,%hi(chroma_dc_total_zeros_len)
	addiu	$4,$4,%lo(chroma_dc_total_zeros_vlc)
	addiu	$7,$7,%lo(chroma_dc_total_zeros_len)
	li	$5,3			# 0x3
	li	$6,4			# 0x4
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(chroma_dc_total_zeros_bits+4)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(chroma_dc_total_zeros_bits+4)
	lui	$4,%hi(chroma_dc_total_zeros_vlc+16)
	lui	$7,%hi(chroma_dc_total_zeros_len+4)
	addiu	$4,$4,%lo(chroma_dc_total_zeros_vlc+16)
	addiu	$7,$7,%lo(chroma_dc_total_zeros_len+4)
	li	$5,3			# 0x3
	li	$6,4			# 0x4
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(chroma_dc_total_zeros_bits+8)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(chroma_dc_total_zeros_bits+8)
	lui	$4,%hi(chroma_dc_total_zeros_vlc+32)
	lui	$7,%hi(chroma_dc_total_zeros_len+8)
	addiu	$4,$4,%lo(chroma_dc_total_zeros_vlc+32)
	addiu	$7,$7,%lo(chroma_dc_total_zeros_len+8)
	li	$5,3			# 0x3
	li	$6,4			# 0x4
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits)
	lui	$4,%hi(total_zeros_vlc)
	lui	$7,%hi(total_zeros_len)
	addiu	$4,$4,%lo(total_zeros_vlc)
	addiu	$7,$7,%lo(total_zeros_len)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+16)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+16)
	lui	$4,%hi(total_zeros_vlc+16)
	lui	$7,%hi(total_zeros_len+16)
	addiu	$4,$4,%lo(total_zeros_vlc+16)
	addiu	$7,$7,%lo(total_zeros_len+16)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+32)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+32)
	lui	$4,%hi(total_zeros_vlc+32)
	lui	$7,%hi(total_zeros_len+32)
	addiu	$4,$4,%lo(total_zeros_vlc+32)
	addiu	$7,$7,%lo(total_zeros_len+32)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+48)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+48)
	lui	$4,%hi(total_zeros_vlc+48)
	lui	$7,%hi(total_zeros_len+48)
	addiu	$4,$4,%lo(total_zeros_vlc+48)
	addiu	$7,$7,%lo(total_zeros_len+48)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+64)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+64)
	lui	$4,%hi(total_zeros_vlc+64)
	lui	$7,%hi(total_zeros_len+64)
	addiu	$4,$4,%lo(total_zeros_vlc+64)
	addiu	$7,$7,%lo(total_zeros_len+64)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+80)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+80)
	lui	$4,%hi(total_zeros_vlc+80)
	lui	$7,%hi(total_zeros_len+80)
	addiu	$4,$4,%lo(total_zeros_vlc+80)
	addiu	$7,$7,%lo(total_zeros_len+80)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+96)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+96)
	lui	$4,%hi(total_zeros_vlc+96)
	lui	$7,%hi(total_zeros_len+96)
	addiu	$4,$4,%lo(total_zeros_vlc+96)
	addiu	$7,$7,%lo(total_zeros_len+96)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+112)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+112)
	lui	$4,%hi(total_zeros_vlc+112)
	lui	$7,%hi(total_zeros_len+112)
	addiu	$4,$4,%lo(total_zeros_vlc+112)
	addiu	$7,$7,%lo(total_zeros_len+112)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+128)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+128)
	lui	$4,%hi(total_zeros_vlc+128)
	lui	$7,%hi(total_zeros_len+128)
	addiu	$4,$4,%lo(total_zeros_vlc+128)
	addiu	$7,$7,%lo(total_zeros_len+128)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+144)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+144)
	lui	$4,%hi(total_zeros_vlc+144)
	lui	$7,%hi(total_zeros_len+144)
	addiu	$4,$4,%lo(total_zeros_vlc+144)
	addiu	$7,$7,%lo(total_zeros_len+144)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+160)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+160)
	lui	$4,%hi(total_zeros_vlc+160)
	lui	$7,%hi(total_zeros_len+160)
	addiu	$4,$4,%lo(total_zeros_vlc+160)
	addiu	$7,$7,%lo(total_zeros_len+160)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+176)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+176)
	lui	$4,%hi(total_zeros_vlc+176)
	lui	$7,%hi(total_zeros_len+176)
	addiu	$4,$4,%lo(total_zeros_vlc+176)
	addiu	$7,$7,%lo(total_zeros_len+176)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+192)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+192)
	lui	$4,%hi(total_zeros_vlc+192)
	lui	$7,%hi(total_zeros_len+192)
	addiu	$4,$4,%lo(total_zeros_vlc+192)
	addiu	$7,$7,%lo(total_zeros_len+192)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+208)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+208)
	lui	$4,%hi(total_zeros_vlc+208)
	lui	$7,%hi(total_zeros_len+208)
	addiu	$4,$4,%lo(total_zeros_vlc+208)
	addiu	$7,$7,%lo(total_zeros_len+208)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(total_zeros_bits+224)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(total_zeros_bits+224)
	lui	$4,%hi(total_zeros_vlc+224)
	lui	$7,%hi(total_zeros_len+224)
	addiu	$4,$4,%lo(total_zeros_vlc+224)
	addiu	$7,$7,%lo(total_zeros_len+224)
	li	$5,9			# 0x9
	li	$6,16			# 0x10
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(run_bits)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(run_bits)
	lui	$4,%hi(run_vlc)
	lui	$7,%hi(run_len)
	addiu	$4,$4,%lo(run_vlc)
	addiu	$7,$7,%lo(run_len)
	li	$5,3			# 0x3
	li	$6,7			# 0x7
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(run_bits+16)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(run_bits+16)
	lui	$4,%hi(run_vlc+16)
	lui	$7,%hi(run_len+16)
	addiu	$4,$4,%lo(run_vlc+16)
	addiu	$7,$7,%lo(run_len+16)
	li	$5,3			# 0x3
	li	$6,7			# 0x7
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(run_bits+32)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(run_bits+32)
	lui	$4,%hi(run_vlc+32)
	lui	$7,%hi(run_len+32)
	addiu	$4,$4,%lo(run_vlc+32)
	addiu	$7,$7,%lo(run_len+32)
	li	$5,3			# 0x3
	li	$6,7			# 0x7
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(run_bits+48)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(run_bits+48)
	lui	$4,%hi(run_vlc+48)
	lui	$7,%hi(run_len+48)
	addiu	$4,$4,%lo(run_vlc+48)
	addiu	$7,$7,%lo(run_len+48)
	li	$5,3			# 0x3
	li	$6,7			# 0x7
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(run_bits+64)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(run_bits+64)
	lui	$4,%hi(run_vlc+64)
	lui	$7,%hi(run_len+64)
	addiu	$4,$4,%lo(run_vlc+64)
	addiu	$7,$7,%lo(run_len+64)
	li	$5,3			# 0x3
	li	$6,7			# 0x7
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(run_bits+80)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(run_bits+80)
	lui	$4,%hi(run_vlc+80)
	lui	$7,%hi(run_len+80)
	addiu	$4,$4,%lo(run_vlc+80)
	addiu	$7,$7,%lo(run_len+80)
	li	$5,3			# 0x3
	li	$6,7			# 0x7
	sw	$2,24($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	jalr	$25
	sw	$16,48($sp)

	lw	$28,56($sp)
	lui	$2,%hi(run_bits+96)
	lw	$25,%call16(init_vlc_sparse)($28)
	addiu	$2,$2,%lo(run_bits+96)
	lui	$4,%hi(run7_vlc)
	lui	$7,%hi(run_len+96)
	sw	$2,24($sp)
	sw	$16,48($sp)
	sw	$16,16($sp)
	sw	$16,20($sp)
	sw	$16,28($sp)
	sw	$16,32($sp)
	sw	$0,36($sp)
	sw	$0,40($sp)
	sw	$0,44($sp)
	addiu	$4,$4,%lo(run7_vlc)
	addiu	$7,$7,%lo(run_len+96)
	li	$5,6			# 0x6
	jalr	$25
	li	$6,16			# 0x10

$L866:
	lw	$2,28($18)
	blez	$2,$L871
	lw	$31,76($sp)

	lw	$2,24($18)
	beq	$2,$0,$L871
	nop

	lb	$2,0($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L870
	nop

$L871:
	li	$2,131072			# 0x20000
	addu	$2,$17,$2
	sw	$17,9376($2)
	sw	$0,8728($17)
	move	$2,$0
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	j	$31
	addiu	$sp,$sp,80

$L870:
	sw	$2,8728($17)
	lw	$31,76($sp)
	li	$2,131072			# 0x20000
	addu	$2,$17,$2
	sw	$17,9376($2)
	sw	$0,8732($17)
	move	$2,$0
	lw	$18,72($sp)
	lw	$17,68($sp)
	lw	$16,64($sp)
	j	$31
	addiu	$sp,$sp,80

	.set	macro
	.set	reorder
	.end	decode_init
	.size	decode_init, .-decode_init
	.section	.rodata.str1.4
	.align	2
$LC4:
	.ascii	"x264 - core %d\000"
	.align	2
$LC5:
	.ascii	"user data:\"%s\"\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_unregistered_user_data
	.type	decode_unregistered_user_data, @function
decode_unregistered_user_data:
	.frame	$sp,328,$31		# vars= 280, regs= 6/0, args= 16, gp= 8
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-328
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,324($sp)
	sw	$20,320($sp)
	sw	$19,316($sp)
	sw	$18,312($sp)
	sw	$17,308($sp)
	sw	$16,304($sp)
	.cprestore	16
	slt	$2,$5,16
	move	$19,$5
	bne	$2,$0,$L885
	move	$18,$4

	lw	$2,8456($4)
	lw	$9,8448($4)
	move	$16,$0
	addiu	$8,$sp,28
	li	$7,271			# 0x10f
	sra	$3,$2,3
$L889:
	addu	$3,$9,$3
	lbu	$4,0($3)
	lbu	$6,3($3)
	lbu	$5,1($3)
	sll	$4,$4,24
	lbu	$3,2($3)
	or	$4,$6,$4
	sll	$5,$5,16
	sll	$3,$3,8
	or	$4,$4,$5
	or	$4,$4,$3
	andi	$3,$2,0x7
	sll	$4,$4,$3
	srl	$4,$4,24
	addu	$3,$8,$16
	addiu	$2,$2,8
	addiu	$16,$16,1
	sb	$4,0($3)
	slt	$17,$16,$19
	beq	$16,$7,$L875
	sw	$2,8456($18)

	bne	$17,$0,$L889
	sra	$3,$2,3

$L875:
	addiu	$6,$sp,24
	lw	$25,%call16(__isoc99_sscanf)($28)
	addu	$2,$6,$16
	addiu	$20,$sp,44
	lui	$5,%hi($LC4)
	sb	$0,4($2)
	addiu	$5,$5,%lo($LC4)
	jalr	$25
	move	$4,$20

	li	$3,1			# 0x1
	beq	$2,$3,$L886
	lw	$28,16($sp)

$L877:
	lw	$4,0($18)
	lw	$2,412($4)
	andi	$2,$2,0x1000
	bne	$2,$0,$L887
	lw	$25,%call16(av_log)($28)

$L878:
	beq	$17,$0,$L884
	nor	$16,$0,$16

	lw	$2,8456($18)
	addu	$19,$16,$19
	addiu	$2,$2,8
	sll	$19,$19,3
	addu	$19,$2,$19
	sw	$19,8456($18)
$L884:
	lw	$31,324($sp)
	move	$2,$0
	lw	$20,320($sp)
	lw	$19,316($sp)
	lw	$18,312($sp)
	lw	$17,308($sp)
	lw	$16,304($sp)
	j	$31
	addiu	$sp,$sp,328

$L885:
	lw	$31,324($sp)
	li	$2,-1			# 0xffffffffffffffff
	lw	$20,320($sp)
	lw	$19,316($sp)
	lw	$18,312($sp)
	lw	$17,308($sp)
	lw	$16,304($sp)
	j	$31
	addiu	$sp,$sp,328

$L887:
	lui	$6,%hi($LC5)
$L890:
	addiu	$6,$6,%lo($LC5)
	move	$7,$20
	jalr	$25
	li	$5,2			# 0x2

	b	$L878
	nop

$L886:
	lw	$2,24($sp)
	bltz	$2,$L877
	li	$3,131072			# 0x20000

	addu	$3,$18,$3
	lw	$4,0($18)
	sw	$2,9372($3)
	lw	$2,412($4)
	andi	$2,$2,0x1000
	beq	$2,$0,$L878
	lw	$25,%call16(av_log)($28)

	b	$L890
	lui	$6,%hi($LC5)

	.set	macro
	.set	reorder
	.end	decode_unregistered_user_data
	.size	decode_unregistered_user_data, .-decode_unregistered_user_data
	.section	.rodata.str1.4
	.align	2
$LC6:
	.ascii	"corrupted macroblock %d %d (total_coeff=%d)\012\000"
	.align	2
$LC7:
	.ascii	"prefix too large at %d %d\012\000"
	.align	2
$LC8:
	.ascii	"negative number of zero coeffs at %d %d\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_residual
	.type	decode_residual, @function
decode_residual:
	.frame	$sp,152,$31		# vars= 80, regs= 10/0, args= 24, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-152
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,148($sp)
	sw	$fp,144($sp)
	sw	$23,140($sp)
	sw	$22,136($sp)
	sw	$21,132($sp)
	sw	$20,128($sp)
	sw	$19,124($sp)
	sw	$18,120($sp)
	sw	$17,116($sp)
	sw	$16,112($sp)
	.cprestore	24
	li	$2,26			# 0x1a
	move	$17,$4
	move	$16,$5
	lw	$19,168($sp)
	lw	$20,172($sp)
	beq	$7,$2,$L952
	lw	$23,176($sp)

	li	$2,25			# 0x19
	beq	$7,$2,$L953
	lui	$5,%hi(scan8)

	addiu	$5,$5,%lo(scan8)
	addu	$2,$5,$7
	lbu	$2,0($2)
	addu	$2,$4,$2
	lbu	$3,9079($2)
	lbu	$4,9072($2)
	addu	$4,$4,$3
	slt	$2,$4,64
	beq	$2,$0,$L897
	nop

	addiu	$4,$4,1
	sra	$4,$4,1
$L897:
	lw	$2,8($16)
	lw	$9,0($16)
	sra	$3,$2,3
	addu	$3,$9,$3
	andi	$12,$4,0x1f
	lbu	$4,0($3)
	lbu	$11,3($3)
	lbu	$8,1($3)
	lui	$10,%hi(coeff_token_table_index.15747)
	sll	$12,$12,2
	addiu	$10,$10,%lo(coeff_token_table_index.15747)
	sll	$4,$4,24
	lbu	$3,2($3)
	sll	$8,$8,16
	addu	$10,$12,$10
	or	$4,$11,$4
	or	$4,$4,$8
	sll	$3,$3,8
	lw	$10,0($10)
	or	$4,$4,$3
	lui	$3,%hi(coeff_token_vlc)
	andi	$8,$2,0x7
	sll	$10,$10,4
	addiu	$3,$3,%lo(coeff_token_vlc)
	addu	$3,$3,$10
	sll	$4,$4,$8
	srl	$4,$4,24
	lw	$8,4($3)
	sll	$4,$4,2
	addu	$4,$8,$4
	lh	$3,2($4)
	bltz	$3,$L954
	lh	$22,0($4)

	addu	$5,$5,$7
	lbu	$4,0($5)
	addu	$2,$3,$2
	addu	$4,$17,$4
	sra	$18,$22,2
	sw	$2,8($16)
	sb	$18,9080($4)
$L893:
	beq	$18,$0,$L899
	sltu	$2,$23,$18

	bne	$2,$0,$L955
	andi	$22,$22,0x3

	beq	$22,$0,$L903
	move	$fp,$0

	lw	$2,8($16)
	lw	$10,0($16)
	addiu	$3,$sp,32
	addu	$9,$22,$2
	li	$8,1			# 0x1
$L904:
	sra	$4,$2,3
	addu	$4,$10,$4
	lbu	$5,0($4)
	andi	$4,$2,0x7
	sll	$4,$5,$4
	srl	$4,$4,6
	andi	$4,$4,0x2
	addiu	$2,$2,1
	subu	$4,$8,$4
	sw	$4,0($3)
	sw	$2,8($16)
	bne	$2,$9,$L904
	addiu	$3,$3,4

	move	$fp,$22
$L903:
	slt	$2,$fp,$18
	bne	$2,$0,$L957
	slt	$2,$18,11

$L905:
	beq	$18,$23,$L958
	addiu	$3,$18,-1

	li	$2,26			# 0x1a
	beq	$7,$2,$L959
	nop

	lw	$4,8($16)
	lw	$3,0($16)
	sra	$2,$4,3
	addu	$2,$3,$2
	lbu	$9,0($2)
	lbu	$8,3($2)
	lbu	$3,1($2)
	lbu	$5,2($2)
	sll	$2,$9,24
	or	$2,$8,$2
	sll	$3,$3,16
	or	$2,$2,$3
	sll	$5,$5,8
	or	$2,$2,$5
	addiu	$3,$18,-1
	lui	$5,%hi(total_zeros_vlc)
	andi	$8,$4,0x7
	sll	$9,$3,4
	addiu	$5,$5,%lo(total_zeros_vlc)
	addu	$5,$5,$9
	sll	$2,$2,$8
	lw	$5,4($5)
	srl	$2,$2,23
	sll	$2,$2,2
	addu	$2,$5,$2
	lh	$5,2($2)
	lh	$2,0($2)
	addu	$4,$5,$4
	sw	$4,8($16)
$L931:
	addu	$3,$3,$2
	addu	$4,$19,$3
	slt	$7,$7,25
	beq	$7,$0,$L933
	lbu	$4,0($4)

	sll	$5,$4,2
	addu	$5,$20,$5
	lw	$7,0($5)
	lw	$5,32($sp)
	sll	$4,$4,1
	mul	$7,$7,$5
	addu	$4,$6,$4
	addiu	$7,$7,32
	srl	$7,$7,6
	slt	$5,$18,2
	bne	$5,$0,$L935
	sh	$7,0($4)

	lui	$4,%hi(run7_vlc+4)
	sll	$18,$18,2
	lw	$11,%lo(run7_vlc+4)($4)
	lui	$10,%hi(run_vlc)
	addiu	$4,$sp,32
	addu	$18,$4,$18
	addiu	$10,$10,%lo(run_vlc)
	b	$L945
	addiu	$4,$sp,36

$L961:
	lw	$8,8($16)
	lw	$9,0($16)
	sra	$5,$8,3
	addu	$5,$9,$5
	lbu	$14,0($5)
	lbu	$13,3($5)
	lbu	$12,1($5)
	lbu	$9,2($5)
	sll	$5,$14,24
	or	$5,$13,$5
	sll	$12,$12,16
	sll	$9,$9,8
	or	$5,$5,$12
	or	$5,$5,$9
	andi	$9,$8,0x7
	sll	$5,$5,$9
	lw	$7,4($7)
	srl	$5,$5,29
	sll	$5,$5,2
	addu	$5,$7,$5
	lh	$9,2($5)
	lh	$7,0($5)
	addu	$8,$9,$8
	sw	$8,8($16)
	nor	$5,$0,$7
$L942:
	addu	$3,$3,$5
	addu	$5,$19,$3
	lbu	$5,0($5)
	lw	$8,0($4)
	sll	$9,$5,2
	addu	$9,$20,$9
	lw	$9,0($9)
	sll	$5,$5,1
	mul	$8,$9,$8
	addu	$5,$6,$5
	addiu	$8,$8,32
	srl	$8,$8,6
	addiu	$4,$4,4
	sh	$8,0($5)
	beq	$4,$18,$L935
	subu	$2,$2,$7

$L945:
	blez	$2,$L960
	slt	$5,$2,7

	addiu	$7,$2,-1
	sll	$7,$7,4
	bne	$5,$0,$L961
	addu	$7,$10,$7

	lw	$5,8($16)
	lw	$9,0($16)
	sra	$7,$5,3
	addu	$7,$9,$7
	lbu	$14,0($7)
	lbu	$13,3($7)
	lbu	$12,1($7)
	lbu	$8,2($7)
	sll	$7,$14,24
	or	$7,$13,$7
	sll	$12,$12,16
	sll	$8,$8,8
	or	$7,$7,$12
	or	$7,$7,$8
	andi	$8,$5,0x7
	sll	$7,$7,$8
	srl	$7,$7,26
	sll	$7,$7,2
	addu	$7,$11,$7
	lh	$8,2($7)
	bltz	$8,$L962
	lh	$7,0($7)

$L944:
	addu	$5,$8,$5
	sw	$5,8($16)
	b	$L942
	nor	$5,$0,$7

$L935:
	bltz	$2,$L963
	lui	$6,%hi($LC8)

$L899:
	lw	$31,148($sp)
	move	$2,$0
	lw	$fp,144($sp)
	lw	$23,140($sp)
	lw	$22,136($sp)
	lw	$21,132($sp)
	lw	$20,128($sp)
	lw	$19,124($sp)
	lw	$18,120($sp)
	lw	$17,116($sp)
	lw	$16,112($sp)
	j	$31
	addiu	$sp,$sp,152

$L957:
	beq	$2,$0,$L906
	xori	$8,$22,0x3

	move	$8,$0
$L907:
	lw	$4,8($16)
	lw	$3,0($16)
	sra	$2,$4,3
	addu	$2,$3,$2
	lbu	$9,0($2)
	lbu	$5,1($2)
	lbu	$10,3($2)
	lbu	$3,2($2)
	sll	$9,$9,24
	or	$2,$10,$9
	sll	$5,$5,16
	sll	$3,$3,8
	or	$2,$2,$5
	or	$2,$2,$3
	andi	$3,$4,0x7
	sll	$2,$2,$3
	li	$3,-65536			# 0xffffffffffff0000
	and	$3,$2,$3
	bne	$3,$0,$L908
	li	$9,16			# 0x10

	andi	$5,$2,0xff00
	li	$9,32			# 0x20
	beq	$5,$0,$L964
	li	$3,24			# 0x18

$L910:
	lw	$21,%got(ff_log2_tab)($28)
	srl	$2,$2,8
	addu	$2,$21,$2
	lbu	$2,0($2)
	subu	$2,$3,$2
	addiu	$3,$2,-1
	addu	$4,$2,$4
	slt	$5,$3,14
	beq	$5,$0,$L912
	sw	$4,8($16)

$L973:
	bne	$8,$0,$L965
	move	$4,$16

$L914:
	addiu	$2,$3,2
	xori	$22,$22,0x3
	movn	$3,$2,$22
	addiu	$5,$3,2
	andi	$2,$3,0x1
	subu	$2,$0,$2
	sra	$5,$5,1
	xor	$5,$5,$2
	addiu	$8,$fp,1
	addiu	$4,$sp,32
	sll	$fp,$fp,2
	subu	$2,$5,$2
	addu	$fp,$4,$fp
	slt	$3,$3,6
	li	$5,2			# 0x2
	li	$10,1			# 0x1
	slt	$9,$8,$18
	movn	$5,$10,$3
	beq	$9,$0,$L905
	sw	$2,0($fp)

	sll	$9,$8,2
	lui	$13,%hi(suffix_limit.15764)
	lw	$3,8($16)
	lw	$10,0($16)
	addu	$9,$4,$9
	addiu	$13,$13,%lo(suffix_limit.15764)
	li	$12,-65536			# 0xffffffffffff0000
	li	$14,32			# 0x20
	b	$L929
	li	$11,15			# 0xf

$L968:
	li	$24,32			# 0x20
	beq	$15,$0,$L966
	li	$4,24			# 0x18

$L923:
	srl	$2,$2,8
	addu	$2,$21,$2
	lbu	$2,0($2)
	subu	$2,$4,$2
	addiu	$4,$2,-1
	addu	$3,$2,$3
	slt	$2,$4,15
	bne	$2,$0,$L967
	sw	$3,8($16)

$L925:
	bne	$4,$11,$L927
	sra	$2,$3,3

	addu	$2,$10,$2
	lbu	$25,0($2)
	lbu	$24,3($2)
	lbu	$15,1($2)
	lbu	$4,2($2)
	sll	$2,$25,24
	or	$2,$24,$2
	sll	$15,$15,16
	sll	$4,$4,8
	or	$2,$2,$15
	or	$2,$2,$4
	andi	$4,$3,0x7
	sll	$2,$2,$4
	srl	$2,$2,20
	addiu	$3,$3,12
	sll	$4,$11,$5
	addu	$2,$2,$4
	sw	$3,8($16)
$L926:
	sll	$15,$5,2
	andi	$4,$2,0x1
	addiu	$24,$2,2
	addu	$15,$15,$13
	subu	$4,$0,$4
	lw	$15,0($15)
	sra	$24,$24,1
	xor	$24,$24,$4
	addiu	$8,$8,1
	slt	$2,$15,$2
	subu	$4,$24,$4
	slt	$15,$8,$18
	sw	$4,0($9)
	addu	$5,$2,$5
	beq	$15,$0,$L905
	addiu	$9,$9,4

$L929:
	sra	$4,$3,3
	addu	$4,$10,$4
	lbu	$2,0($4)
	lbu	$24,3($4)
	lbu	$15,1($4)
	sll	$2,$2,24
	lbu	$4,2($4)
	or	$2,$24,$2
	sll	$15,$15,16
	sll	$4,$4,8
	or	$2,$2,$15
	or	$2,$2,$4
	andi	$4,$3,0x7
	sll	$2,$2,$4
	and	$4,$2,$12
	beq	$4,$0,$L968
	andi	$15,$2,0xff00

	srl	$2,$2,16
	andi	$15,$2,0xff00
	li	$24,16			# 0x10
	bne	$15,$0,$L923
	li	$4,8			# 0x8

$L966:
	addu	$2,$21,$2
	lbu	$2,0($2)
	move	$4,$24
	subu	$2,$4,$2
	addiu	$4,$2,-1
	addu	$3,$2,$3
	slt	$2,$4,15
	beq	$2,$0,$L925
	sw	$3,8($16)

$L967:
	sra	$2,$3,3
	addu	$2,$10,$2
	lbu	$22,0($2)
	lbu	$25,3($2)
	lbu	$24,1($2)
	lbu	$15,2($2)
	sll	$2,$22,24
	or	$2,$25,$2
	sll	$24,$24,16
	sll	$15,$15,8
	or	$2,$2,$24
	or	$2,$2,$15
	andi	$15,$3,0x7
	sll	$2,$2,$15
	subu	$15,$14,$5
	srl	$2,$2,$15
	addu	$3,$3,$5
	sll	$4,$4,$5
	addu	$2,$2,$4
	b	$L926
	sw	$3,8($16)

$L960:
	li	$5,-1			# 0xffffffffffffffff
	b	$L942
	move	$7,$0

$L962:
	addiu	$5,$5,6
	sra	$12,$5,3
	addu	$9,$9,$12
	lbu	$15,0($9)
	lbu	$14,3($9)
	lbu	$13,1($9)
	lbu	$12,2($9)
	sll	$9,$15,24
	or	$9,$14,$9
	sll	$13,$13,16
	sll	$12,$12,8
	or	$9,$9,$13
	or	$9,$9,$12
	andi	$12,$5,0x7
	sll	$9,$9,$12
	srl	$8,$9,$8
	addu	$7,$8,$7
	sll	$7,$7,2
	addu	$7,$11,$7
	lh	$8,2($7)
	b	$L944
	lh	$7,0($7)

$L952:
	lw	$3,8($5)
	lw	$4,0($5)
	sra	$2,$3,3
	addu	$2,$4,$2
	lbu	$9,0($2)
	lbu	$8,3($2)
	lbu	$5,1($2)
	lbu	$4,2($2)
	sll	$2,$9,24
	or	$2,$8,$2
	sll	$5,$5,16
	sll	$4,$4,8
	or	$2,$2,$5
	or	$2,$2,$4
	andi	$4,$3,0x7
	sll	$2,$2,$4
	lui	$4,%hi(chroma_dc_coeff_token_vlc+4)
	lw	$4,%lo(chroma_dc_coeff_token_vlc+4)($4)
	srl	$2,$2,24
	sll	$2,$2,2
	addu	$2,$4,$2
	lh	$4,2($2)
	lh	$22,0($2)
	addu	$3,$4,$3
	sw	$3,8($16)
	b	$L893
	sra	$18,$22,2

$L959:
	lw	$4,8($16)
	lw	$3,0($16)
	sra	$2,$4,3
	addu	$2,$3,$2
	lbu	$5,0($2)
	lbu	$7,3($2)
	lbu	$3,1($2)
	sll	$5,$5,24
	lbu	$2,2($2)
	or	$5,$7,$5
	sll	$3,$3,16
	or	$5,$5,$3
	sll	$2,$2,8
	addiu	$7,$18,-1
	lui	$3,%hi(chroma_dc_total_zeros_vlc)
	or	$5,$5,$2
	sll	$7,$7,4
	andi	$2,$4,0x7
	addiu	$3,$3,%lo(chroma_dc_total_zeros_vlc)
	sll	$2,$5,$2
	addu	$3,$3,$7
	srl	$2,$2,29
	lw	$3,4($3)
	sll	$2,$2,2
	addu	$3,$3,$2
	lh	$2,0($3)
	lh	$5,2($3)
	addiu	$3,$2,-1
	addu	$4,$5,$4
	addu	$3,$3,$18
	sw	$4,8($16)
	addu	$4,$19,$3
	lbu	$4,0($4)
$L933:
	sll	$4,$4,1
	lw	$7,32($sp)
	addu	$4,$6,$4
	slt	$5,$18,2
	bne	$5,$0,$L935
	sh	$7,0($4)

	lui	$4,%hi(run7_vlc+4)
	sll	$18,$18,2
	lw	$10,%lo(run7_vlc+4)($4)
	lui	$9,%hi(run_vlc)
	addiu	$4,$sp,32
	addu	$18,$4,$18
	addiu	$9,$9,%lo(run_vlc)
	b	$L940
	addiu	$4,$sp,36

$L970:
	lw	$8,8($16)
	lw	$11,0($16)
	sra	$5,$8,3
	addu	$5,$11,$5
	lbu	$14,0($5)
	lbu	$13,3($5)
	lbu	$12,1($5)
	lbu	$11,2($5)
	sll	$5,$14,24
	or	$5,$13,$5
	sll	$12,$12,16
	sll	$11,$11,8
	or	$5,$5,$12
	or	$5,$5,$11
	andi	$11,$8,0x7
	sll	$5,$5,$11
	lw	$7,4($7)
	srl	$5,$5,29
	sll	$5,$5,2
	addu	$5,$7,$5
	lh	$7,2($5)
	lh	$5,0($5)
	addu	$8,$7,$8
	sw	$8,8($16)
	nor	$7,$0,$5
$L937:
	addu	$3,$3,$7
	addu	$7,$19,$3
	lbu	$7,0($7)
	lw	$8,0($4)
	sll	$7,$7,1
	addu	$7,$6,$7
	addiu	$4,$4,4
	sh	$8,0($7)
	beq	$4,$18,$L935
	subu	$2,$2,$5

$L940:
	blez	$2,$L969
	slt	$5,$2,7

	addiu	$7,$2,-1
	sll	$7,$7,4
	bne	$5,$0,$L970
	addu	$7,$9,$7

	lw	$7,8($16)
	lw	$11,0($16)
	sra	$5,$7,3
	addu	$5,$11,$5
	lbu	$14,0($5)
	lbu	$13,3($5)
	lbu	$12,1($5)
	lbu	$8,2($5)
	sll	$5,$14,24
	or	$5,$13,$5
	sll	$12,$12,16
	sll	$8,$8,8
	or	$5,$5,$12
	or	$5,$5,$8
	andi	$8,$7,0x7
	sll	$5,$5,$8
	srl	$5,$5,26
	sll	$5,$5,2
	addu	$5,$10,$5
	lh	$8,2($5)
	bltz	$8,$L971
	lh	$5,0($5)

$L939:
	addu	$7,$8,$7
	sw	$7,8($16)
	b	$L937
	nor	$7,$0,$5

$L969:
	li	$7,-1			# 0xffffffffffffffff
	b	$L937
	move	$5,$0

$L971:
	addiu	$7,$7,6
	sra	$12,$7,3
	addu	$11,$11,$12
	lbu	$15,0($11)
	lbu	$14,3($11)
	lbu	$13,1($11)
	lbu	$12,2($11)
	sll	$11,$15,24
	or	$11,$14,$11
	sll	$13,$13,16
	sll	$12,$12,8
	or	$11,$11,$13
	or	$11,$11,$12
	andi	$12,$7,0x7
	sll	$11,$11,$12
	srl	$8,$11,$8
	addu	$5,$8,$5
	sll	$5,$5,2
	addu	$5,$10,$5
	lh	$8,2($5)
	b	$L939
	lh	$5,0($5)

$L953:
	lbu	$2,9091($17)
	lbu	$4,9084($4)
	addu	$4,$4,$2
	slt	$2,$4,64
	beq	$2,$0,$L895
	nop

	addiu	$4,$4,1
	sra	$4,$4,1
$L895:
	lw	$2,8($16)
	lw	$8,0($16)
	sra	$3,$2,3
	addu	$3,$8,$3
	andi	$4,$4,0x1f
	lbu	$5,0($3)
	sll	$11,$4,2
	lbu	$10,3($3)
	lbu	$4,1($3)
	lui	$9,%hi(coeff_token_table_index.15747)
	addiu	$9,$9,%lo(coeff_token_table_index.15747)
	sll	$5,$5,24
	lbu	$3,2($3)
	sll	$4,$4,16
	addu	$9,$11,$9
	or	$5,$10,$5
	or	$5,$5,$4
	sll	$3,$3,8
	lw	$9,0($9)
	or	$5,$5,$3
	lui	$3,%hi(coeff_token_vlc)
	sll	$9,$9,4
	andi	$4,$2,0x7
	addiu	$3,$3,%lo(coeff_token_vlc)
	addu	$3,$3,$9
	sll	$4,$5,$4
	srl	$4,$4,24
	lw	$5,4($3)
	sll	$4,$4,2
	addu	$4,$5,$4
	lh	$3,2($4)
	bltz	$3,$L972
	lh	$22,0($4)

$L896:
	addu	$2,$3,$2
	sw	$2,8($16)
	b	$L893
	sra	$18,$22,2

$L906:
	b	$L907
	sltu	$8,$0,$8

$L954:
	addiu	$2,$2,8
	sra	$4,$2,3
	addu	$9,$9,$4
	lbu	$10,0($9)
	lbu	$12,3($9)
	lbu	$11,1($9)
	lbu	$4,2($9)
	sll	$10,$10,24
	or	$10,$12,$10
	sll	$9,$11,16
	sll	$4,$4,8
	or	$9,$10,$9
	or	$9,$9,$4
	andi	$4,$2,0x7
	sll	$4,$9,$4
	srl	$3,$4,$3
	addu	$22,$3,$22
	sll	$22,$22,2
	addu	$8,$8,$22
	addu	$5,$5,$7
	lh	$3,2($8)
	lh	$22,0($8)
	lbu	$4,0($5)
	addu	$2,$3,$2
	addu	$4,$17,$4
	sra	$18,$22,2
	sw	$2,8($16)
	b	$L893
	sb	$18,9080($4)

$L972:
	addiu	$2,$2,8
	sra	$4,$2,3
	addu	$8,$8,$4
	lbu	$9,0($8)
	lbu	$11,3($8)
	lbu	$10,1($8)
	lbu	$4,2($8)
	sll	$9,$9,24
	or	$9,$11,$9
	sll	$8,$10,16
	sll	$4,$4,8
	or	$8,$9,$8
	or	$8,$8,$4
	andi	$4,$2,0x7
	sll	$4,$8,$4
	srl	$3,$4,$3
	addu	$22,$3,$22
	sll	$22,$22,2
	addu	$5,$5,$22
	lh	$3,2($5)
	b	$L896
	lh	$22,0($5)

$L908:
	srl	$2,$2,16
	andi	$5,$2,0xff00
	bne	$5,$0,$L910
	li	$3,8			# 0x8

$L964:
	lw	$21,%got(ff_log2_tab)($28)
	move	$3,$9
	addu	$2,$21,$2
	lbu	$2,0($2)
	subu	$2,$3,$2
	addiu	$3,$2,-1
	addu	$4,$2,$4
	slt	$5,$3,14
	bne	$5,$0,$L973
	sw	$4,8($16)

$L912:
	li	$2,14			# 0xe
	beq	$3,$2,$L974
	li	$2,15			# 0xf

	bne	$3,$2,$L927
	move	$4,$16

	li	$5,12			# 0xc
	sw	$3,100($sp)
	sw	$6,104($sp)
	sw	$7,108($sp)
	.option	pic0
	jal	get_bits
	.option	pic2
	sw	$8,96($sp)

	lw	$8,96($sp)
	lw	$3,100($sp)
	lw	$28,24($sp)
	sll	$3,$3,$8
	addu	$3,$2,$3
	addiu	$2,$3,15
	movz	$3,$2,$8
	lw	$6,104($sp)
	b	$L914
	lw	$7,108($sp)

$L958:
	b	$L931
	move	$2,$0

$L927:
	lw	$2,6172($17)
	lui	$6,%hi($LC7)
	lw	$25,%call16(av_log)($28)
	lw	$4,0($17)
	lw	$7,6168($17)
	addiu	$6,$6,%lo($LC7)
	sw	$2,16($sp)
$L951:
	jalr	$25
	move	$5,$0

	lw	$31,148($sp)
	li	$2,-1			# 0xffffffffffffffff
	lw	$fp,144($sp)
	lw	$23,140($sp)
	lw	$22,136($sp)
	lw	$21,132($sp)
	lw	$20,128($sp)
	lw	$19,124($sp)
	lw	$18,120($sp)
	lw	$17,116($sp)
	lw	$16,112($sp)
	j	$31
	addiu	$sp,$sp,152

$L963:
	lw	$2,6172($17)
	lw	$4,0($17)
	lw	$7,6168($17)
	lw	$25,%call16(av_log)($28)
	sw	$2,16($sp)
	b	$L951
	addiu	$6,$6,%lo($LC8)

$L965:
	li	$5,1			# 0x1
	sw	$3,100($sp)
	sw	$6,104($sp)
	.option	pic0
	jal	get_bits
	.option	pic2
	sw	$7,108($sp)

	lw	$3,100($sp)
	lw	$28,24($sp)
	sll	$3,$3,1
	addu	$3,$2,$3
	lw	$6,104($sp)
	b	$L914
	lw	$7,108($sp)

$L974:
	beq	$8,$0,$L916
	move	$4,$16

	li	$5,1			# 0x1
	sw	$6,104($sp)
	.option	pic0
	jal	get_bits
	.option	pic2
	sw	$7,108($sp)

	lw	$28,24($sp)
	addiu	$3,$2,28
	lw	$6,104($sp)
	b	$L914
	lw	$7,108($sp)

$L916:
	li	$5,4			# 0x4
	sw	$6,104($sp)
	.option	pic0
	jal	get_bits
	.option	pic2
	sw	$7,108($sp)

	lw	$28,24($sp)
	addiu	$3,$2,14
	lw	$6,104($sp)
	b	$L914
	lw	$7,108($sp)

$L955:
	lw	$2,6172($17)
	lui	$6,%hi($LC6)
	lw	$4,0($17)
	lw	$7,6168($17)
	lw	$25,%call16(av_log)($28)
	sw	$2,16($sp)
	sw	$18,20($sp)
	b	$L951
	addiu	$6,$6,%lo($LC6)

	.set	macro
	.set	reorder
	.end	decode_residual
	.size	decode_residual, .-decode_residual
	.section	.rodata.str1.4
	.align	2
$LC9:
	.ascii	"unsupported slice header (%02X)\012\000"
	.align	2
$LC10:
	.ascii	"slice after bitstream end\012\000"
	.align	2
$LC11:
	.ascii	"illegal slice type %d \012\000"
	.text
	.align	2
	.set	nomips16
	.ent	svq3_decode_slice_header
	.type	svq3_decode_slice_header, @function
svq3_decode_slice_header:
	.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 16, gp= 8
	.mask	0x801f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-48
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,44($sp)
	sw	$20,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	.cprestore	16
	lw	$3,8456($4)
	lw	$2,8448($4)
	move	$16,$4
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$7,0($4)
	lbu	$6,3($4)
	lbu	$5,1($4)
	sll	$7,$7,24
	lbu	$4,2($4)
	sll	$5,$5,16
	or	$7,$6,$7
	or	$7,$7,$5
	sll	$4,$4,8
	or	$7,$7,$4
	andi	$4,$3,0x7
	sll	$7,$7,$4
	srl	$7,$7,24
	andi	$17,$7,0x9f
	addiu	$5,$17,-1
	addiu	$4,$3,8
	sltu	$5,$5,2
	sw	$4,8456($16)
	lw	$18,6168($16)
	lw	$19,6172($16)
	beq	$5,$0,$L976
	lw	$20,152($16)

	andi	$5,$7,0x60
	beq	$5,$0,$L976
	sra	$5,$4,3

	addu	$5,$2,$5
	lbu	$9,0($5)
	lbu	$6,3($5)
	lbu	$8,1($5)
	sll	$9,$9,24
	lbu	$5,2($5)
	or	$9,$6,$9
	sll	$8,$8,16
	sra	$6,$7,5
	andi	$6,$6,0x3
	or	$7,$9,$8
	sll	$5,$5,8
	or	$7,$7,$5
	andi	$8,$4,0x7
	sll	$5,$6,3
	subu	$5,$0,$5
	sll	$7,$7,$8
	srl	$7,$7,$5
	addu	$7,$7,$6
	sll	$7,$7,3
	lw	$5,8460($16)
	addu	$4,$7,$4
	slt	$5,$5,$4
	bne	$5,$0,$L1012
	sw	$4,9784($16)

	li	$5,1			# 0x1
	subu	$5,$5,$6
	sll	$5,$5,3
	addu	$4,$4,$5
	addiu	$3,$3,16
	sw	$4,8460($16)
	beq	$6,$0,$L980
	sw	$3,8456($16)

	sra	$3,$3,3
	lw	$25,%call16(memcpy)($28)
	sra	$4,$4,3
	addu	$5,$2,$4
	addiu	$6,$6,-1
	jalr	$25
	addu	$4,$2,$3

	lw	$28,16($sp)
	lw	$3,8456($16)
	lw	$2,8448($16)
$L980:
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$5,0($4)
	lbu	$7,3($4)
	lbu	$6,1($4)
	sll	$5,$5,24
	lbu	$4,2($4)
	or	$5,$7,$5
	sll	$6,$6,16
	sll	$4,$4,8
	or	$5,$5,$6
	or	$5,$5,$4
	andi	$4,$3,0x7
	sll	$5,$5,$4
	li	$4,-1434451968			# 0xffffffffaa800000
	and	$4,$5,$4
	bne	$4,$0,$L981
	lw	$4,%got(ff_interleaved_golomb_vlc_len)($28)

	lw	$10,%got(ff_interleaved_golomb_vlc_len)($28)
	srl	$5,$5,24
	addu	$4,$10,$5
	lbu	$4,0($4)
	sltu	$6,$4,9
	bne	$6,$0,$L982
	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

	li	$6,9			# 0x9
	bne	$4,$6,$L1013
	addiu	$3,$3,8

	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	li	$6,1			# 0x1
	li	$11,9			# 0x9
$L987:
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$12,0($4)
	lbu	$8,1($4)
	lbu	$13,3($4)
	lbu	$7,2($4)
	sll	$12,$12,24
	sll	$8,$8,16
	or	$4,$13,$12
	or	$4,$4,$8
	sll	$7,$7,8
	or	$4,$4,$7
	andi	$7,$3,0x7
	sll	$4,$4,$7
	addu	$7,$9,$5
	srl	$5,$4,24
	addu	$4,$10,$5
	lbu	$4,0($4)
	lbu	$7,0($7)
	sll	$6,$6,4
	sltu	$8,$4,9
	beq	$8,$0,$L1014
	or	$6,$7,$6

$L989:
	addu	$3,$3,$4
$L986:
	addu	$5,$9,$5
$L1017:
	addiu	$4,$4,-1
	sra	$4,$4,1
	lbu	$7,0($5)
	sll	$6,$6,$4
	or	$7,$7,$6
	sw	$3,8456($16)
	addiu	$7,$7,-1
	li	$3,-2147483648			# 0xffffffff80000000
	beq	$7,$3,$L1018
	lui	$6,%hi($LC11)

$L984:
	slt	$3,$7,3
	beq	$3,$0,$L988
	lui	$3,%hi(golomb_to_pict_type)

	addiu	$3,$3,%lo(golomb_to_pict_type)
	addu	$7,$7,$3
	lbu	$4,0($7)
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	sw	$4,-6284($3)
	li	$3,2			# 0x2
	beq	$17,$3,$L1015
	nop

	lw	$4,8456($16)
	lw	$6,6168($16)
	addiu	$4,$4,1
	sw	$4,8456($16)
	sw	$0,6176($16)
$L999:
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$8,0($3)
	lbu	$7,3($3)
	lbu	$5,1($3)
	sll	$8,$8,24
	lbu	$3,2($3)
	or	$8,$7,$8
	sll	$5,$5,16
	or	$8,$8,$5
	sll	$3,$3,8
	or	$8,$8,$3
	andi	$3,$4,0x7
	addiu	$5,$4,8
	sll	$8,$8,$3
	li	$7,65536			# 0x10000
	srl	$8,$8,24
	addu	$7,$16,$7
	sra	$3,$5,3
	sw	$5,8456($16)
	sw	$8,-6296($7)
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$9,3($3)
	lbu	$8,1($3)
	sll	$7,$7,24
	lbu	$3,2($3)
	or	$7,$9,$7
	sll	$8,$8,16
	sll	$3,$3,8
	or	$7,$7,$8
	or	$7,$7,$3
	andi	$5,$5,0x7
	addiu	$3,$4,13
	sll	$7,$7,$5
	srl	$7,$7,27
	sra	$5,$3,3
	sw	$3,8456($16)
	addu	$5,$2,$5
	sw	$7,2056($16)
	lbu	$7,0($5)
	andi	$3,$3,0x7
	sll	$7,$7,$3
	andi	$7,$7,0x00ff
	lw	$5,9780($16)
	srl	$7,$7,7
	addiu	$3,$4,15
	sw	$7,2076($16)
	beq	$5,$0,$L1000
	sw	$3,8456($16)

	addiu	$3,$4,16
	sw	$3,8456($16)
$L1000:
	addiu	$4,$3,3
	sra	$5,$4,3
	sw	$4,8456($16)
	addu	$5,$2,$5
	lbu	$5,0($5)
	andi	$4,$4,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,4
	srl	$4,$4,7
	beq	$4,$0,$L1001
	sw	$3,8456($16)

$L1006:
	addiu	$4,$3,8
	sra	$5,$4,3
	sw	$4,8456($16)
	addu	$5,$2,$5
	lbu	$5,0($5)
	andi	$4,$4,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,9
	srl	$4,$4,7
	bne	$4,$0,$L1006
	sw	$3,8456($16)

$L1001:
	mul	$2,$20,$19
	blez	$6,$L1003
	addu	$17,$2,$18

	lw	$4,8816($16)
	addiu	$2,$17,-1
	lw	$25,%call16(memset)($28)
	sll	$2,$2,3
	addu	$4,$4,$2
	li	$5,-1			# 0xffffffffffffffff
	jalr	$25
	li	$6,4			# 0x4

	lw	$6,6168($16)
	lw	$28,16($sp)
	lw	$4,8816($16)
	subu	$2,$17,$6
	lw	$25,%call16(memset)($28)
	sll	$2,$2,3
	addu	$4,$4,$2
	sll	$6,$6,3
	jalr	$25
	li	$5,-1			# 0xffffffffffffffff

	lw	$28,16($sp)
$L1003:
	lw	$2,6172($16)
	blez	$2,$L1004
	lw	$25,%call16(memset)($28)

	lw	$2,152($16)
	lw	$6,144($16)
	lw	$3,6168($16)
	lw	$4,8816($16)
	subu	$2,$17,$2
	subu	$6,$6,$3
	sll	$2,$2,3
	addu	$4,$4,$2
	sll	$6,$6,3
	jalr	$25
	li	$5,-1			# 0xffffffffffffffff

	lw	$2,6168($16)
	blez	$2,$L1019
	lw	$31,44($sp)

	lw	$2,152($16)
	lw	$3,8816($16)
	subu	$2,$17,$2
	addiu	$2,$2,-1
	sll	$2,$2,3
	addu	$2,$3,$2
	li	$3,-1			# 0xffffffffffffffff
	sb	$3,3($2)
	move	$2,$0
$L978:
	lw	$31,44($sp)
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,48

$L1014:
	beq	$4,$11,$L987
	addiu	$3,$3,8

	b	$L1017
	addu	$5,$9,$5

$L982:
	b	$L989
	li	$6,1			# 0x1

$L1004:
	lw	$31,44($sp)
$L1019:
	move	$2,$0
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,48

$L981:
	srl	$5,$5,24
	addu	$4,$4,$5
	lbu	$4,0($4)
	addu	$3,$4,$3
	lw	$4,%got(ff_interleaved_ue_golomb_vlc_code)($28)
	sw	$3,8456($16)
	addu	$5,$4,$5
	b	$L984
	lbu	$7,0($5)

$L1015:
	lw	$3,172($16)
	slt	$4,$3,64
	bne	$4,$0,$L1016
	li	$11,26			# 0x1a

	addiu	$3,$3,-1
	li	$4,-65536			# 0xffffffffffff0000
	and	$4,$3,$4
	bne	$4,$0,$L995
	li	$6,17			# 0x11

	li	$6,1			# 0x1
	li	$4,9			# 0x9
$L996:
	andi	$5,$3,0xff00
	bne	$5,$0,$L997
	nop

	move	$4,$6
$L998:
	lw	$5,%got(ff_log2_tab)($28)
	li	$11,32			# 0x20
	addu	$3,$5,$3
	lbu	$5,0($3)
	addu	$5,$5,$4
	b	$L994
	subu	$11,$11,$5

$L1016:
	li	$5,6			# 0x6
$L994:
	lw	$4,8456($16)
	lw	$9,144($16)
	sra	$6,$4,3
	addu	$3,$2,$6
	lbu	$8,0($3)
	lbu	$7,3($3)
	sll	$8,$8,24
	lbu	$6,1($3)
	or	$8,$7,$8
	lw	$7,6172($16)
	lbu	$10,2($3)
	sll	$6,$6,16
	mul	$3,$9,$7
	or	$8,$8,$6
	sll	$10,$10,8
	or	$8,$8,$10
	lw	$6,6168($16)
	andi	$10,$4,0x7
	sll	$8,$8,$10
	addu	$7,$3,$6
	srl	$3,$8,$11
	addu	$4,$5,$4
	subu	$3,$3,$7
	sw	$3,6176($16)
	b	$L999
	sw	$4,8456($16)

$L976:
	lui	$6,%hi($LC9)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	addiu	$6,$6,%lo($LC9)
$L1011:
	jalr	$25
	move	$5,$0

	lw	$31,44($sp)
	li	$2,-1			# 0xffffffffffffffff
	lw	$20,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,48

$L997:
	b	$L998
	srl	$3,$3,8

$L995:
	srl	$3,$3,16
	b	$L996
	li	$4,25			# 0x19

$L988:
	lui	$6,%hi($LC11)
$L1018:
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L1011
	addiu	$6,$6,%lo($LC11)

$L1012:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC10)
	addiu	$6,$6,%lo($LC10)
	jalr	$25
	move	$5,$0

	b	$L978
	li	$2,-1			# 0xffffffffffffffff

$L1013:
	li	$6,1			# 0x1
	b	$L986
	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

	.set	macro
	.set	reorder
	.end	svq3_decode_slice_header
	.size	svq3_decode_slice_header, .-svq3_decode_slice_header
	.align	2
	.set	nomips16
	.ent	pred_motion
	.type	pred_motion, @function
pred_motion:
	.frame	$sp,32,$31		# vars= 0, regs= 8/0, args= 0, gp= 0
	.mask	0x00ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$2,%hi(scan8)
	addiu	$2,$2,%lo(scan8)
	addu	$2,$2,$5
	sll	$3,$7,2
	lbu	$2,0($2)
	sll	$8,$7,3
	sll	$5,$7,5
	addu	$9,$3,$7
	addu	$10,$8,$5
	addiu	$9,$9,-1
	li	$24,65536			# 0x10000
	addiu	$sp,$sp,-32
	addiu	$13,$2,-8
	sll	$9,$9,3
	addu	$24,$4,$24
	addu	$25,$10,$2
	sw	$20,16($sp)
	addu	$12,$4,$10
	addu	$15,$13,$6
	addu	$9,$9,$2
	addiu	$14,$25,-1
	lw	$20,-6276($24)
	sw	$19,12($sp)
	sw	$18,8($sp)
	sw	$23,28($sp)
	sw	$22,24($sp)
	sw	$21,20($sp)
	sw	$17,4($sp)
	sw	$16,0($sp)
	addu	$18,$12,$15
	addu	$13,$12,$13
	addiu	$11,$4,9136
	addu	$12,$12,$2
	sll	$14,$14,2
	sll	$9,$9,2
	lb	$16,9456($13)
	lb	$17,9455($12)
	lb	$13,9456($18)
	addu	$14,$11,$14
	addu	$9,$11,$9
	lw	$12,48($sp)
	lw	$19,52($sp)
	beq	$20,$0,$L1021
	lw	$18,56($sp)

	sll	$20,$7,4
	addu	$3,$3,$20
	sll	$3,$3,3
	addiu	$3,$3,40
	addu	$3,$11,$3
	sw	$0,0($3)
	lw	$20,-6272($24)
	lw	$24,1880($4)
	bne	$20,$0,$L1022
	lw	$22,104($24)

	lw	$21,6172($4)
	andi	$23,$21,0x1
	beq	$23,$0,$L1022
	slt	$23,$2,20

	beq	$23,$0,$L1022
	li	$23,-2			# 0xfffffffffffffffe

	beq	$13,$23,$L1023
	addiu	$23,$21,-1

	lw	$8,152($4)
	mul	$20,$23,$8
	lw	$25,6168($4)
	addu	$23,$20,$25
	xori	$20,$2,0xf
	sltu	$20,$20,1
	addu	$20,$23,$20
	sll	$20,$20,2
	addu	$20,$22,$20
	lw	$20,0($20)
	andi	$20,$20,0x80
	beq	$20,$0,$L1024
	sll	$21,$21,2

	addiu	$21,$21,-1
	sra	$10,$21,2
	sll	$25,$25,2
	mul	$11,$10,$8
	addiu	$25,$25,-4
	addu	$6,$25,$6
	andi	$2,$2,0x7
	addu	$2,$6,$2
	sra	$6,$2,2
	addu	$8,$11,$6
	sll	$8,$8,2
	addu	$22,$22,$8
	sll	$10,$7,1
	lw	$6,0($22)
	li	$8,12288			# 0x3000
	sll	$8,$8,$10
	and	$8,$6,$8
	beq	$8,$0,$L1063
	andi	$6,$6,0x40

$L1025:
	lw	$6,9748($4)
	addiu	$8,$7,24
	mul	$10,$21,$6
	sll	$8,$8,2
	addu	$8,$24,$8
	addu	$6,$10,$2
	lw	$8,0($8)
	sll	$6,$6,2
	addu	$6,$8,$6
	addiu	$8,$7,46
	sll	$7,$7,7
	addu	$5,$5,$7
	sll	$7,$8,2
	addu	$24,$24,$7
	addu	$5,$4,$5
	lw	$7,4($24)
	lw	$4,9752($4)
	lhu	$8,0($6)
	sra	$21,$21,1
	sra	$2,$2,1
	addu	$2,$7,$2
	mul	$7,$21,$4
	sh	$8,9176($5)
	lhu	$6,2($6)
	addu	$21,$7,$2
	sll	$2,$6,1
	sh	$2,9178($5)
	lb	$13,0($21)
	b	$L1027
	sra	$13,$13,1

$L1021:
	li	$3,-2			# 0xfffffffffffffffe
	beq	$13,$3,$L1072
	addu	$5,$8,$5

$L1024:
	addu	$3,$15,$10
	sll	$3,$3,2
	addu	$3,$11,$3
$L1027:
	xor	$5,$17,$12
	xor	$2,$16,$12
	sltu	$5,$5,1
	sltu	$2,$2,1
	xor	$4,$12,$13
	sltu	$4,$4,1
	addu	$2,$5,$2
	addu	$2,$2,$4
	slt	$4,$2,2
	bne	$4,$0,$L1073
	li	$4,1			# 0x1

$L1042:
	lh	$2,0($14)
	lh	$4,0($9)
	slt	$6,$4,$2
	bne	$6,$0,$L1064
	lh	$5,0($3)

	slt	$6,$5,$4
	beq	$6,$0,$L1044
	nop

	slt	$4,$5,$2
	movz	$2,$5,$4
	move	$4,$2
$L1044:
	lh	$5,2($14)
	lh	$2,2($9)
	sw	$4,0($19)
	slt	$4,$2,$5
	beq	$4,$0,$L1045
	lh	$3,2($3)

$L1065:
	slt	$4,$2,$3
	beq	$4,$0,$L1046
	nop

	slt	$2,$5,$3
	movz	$5,$3,$2
	move	$2,$5
$L1046:
	sw	$2,0($18)
$L1047:
	lw	$23,28($sp)
	lw	$22,24($sp)
	lw	$21,20($sp)
	lw	$20,16($sp)
	lw	$19,12($sp)
	lw	$18,8($sp)
	lw	$17,4($sp)
	lw	$16,0($sp)
	j	$31
	addiu	$sp,$sp,32

$L1064:
	slt	$6,$4,$5
	beq	$6,$0,$L1044
	nop

	slt	$4,$2,$5
	movz	$2,$5,$4
	move	$4,$2
	lh	$5,2($14)
	lh	$2,2($9)
	sw	$4,0($19)
	slt	$4,$2,$5
	bne	$4,$0,$L1065
	lh	$3,2($3)

$L1045:
	slt	$4,$3,$2
	beq	$4,$0,$L1046
	nop

	slt	$2,$3,$5
	movz	$5,$3,$2
	b	$L1046
	move	$2,$5

$L1022:
	li	$6,-2			# 0xfffffffffffffffe
	bne	$13,$6,$L1024
	nop

	lw	$21,6172($4)
	andi	$6,$21,0x1
	bne	$6,$0,$L1023
	slt	$10,$2,20

	bne	$10,$0,$L1029
	nop

$L1028:
	andi	$13,$2,0x7
	li	$10,4			# 0x4
	beq	$13,$10,$L1066
	addu	$10,$8,$5

$L1029:
	addu	$5,$8,$5
$L1072:
	addu	$4,$4,$5
	addu	$2,$4,$2
	lb	$13,9447($2)
	xor	$5,$17,$12
	xor	$2,$16,$12
	sltu	$5,$5,1
	sltu	$2,$2,1
	xor	$4,$12,$13
	sltu	$4,$4,1
	addu	$2,$5,$2
	addiu	$3,$25,-9
	addu	$2,$2,$4
	sll	$3,$3,2
	slt	$4,$2,2
	beq	$4,$0,$L1042
	addu	$3,$11,$3

	li	$4,1			# 0x1
$L1073:
	beq	$2,$4,$L1067
	li	$2,-2			# 0xfffffffffffffffe

	bne	$16,$2,$L1042
	nop

	bne	$13,$16,$L1042
	nop

	beq	$17,$13,$L1042
	nop

$L1048:
	lh	$2,2($14)
	lh	$3,0($14)
	sw	$3,0($19)
	b	$L1047
	sw	$2,0($18)

$L1067:
	beq	$17,$12,$L1048
	nop

	beq	$16,$12,$L1068
	nop

	lh	$2,2($3)
	lh	$3,0($3)
	sw	$3,0($19)
	b	$L1047
	sw	$2,0($18)

$L1023:
	b	$L1028
	li	$6,1			# 0x1

$L1066:
	addu	$10,$4,$10
	lb	$13,9467($10)
	li	$10,-2			# 0xfffffffffffffffe
	beq	$13,$10,$L1029
	nop

	beq	$20,$0,$L1069
	nop

	lw	$6,8768($4)
	sll	$6,$6,2
	addu	$6,$22,$6
	lw	$6,0($6)
	andi	$6,$6,0x80
	bne	$6,$0,$L1029
	nop

	slt	$6,$2,20
	bne	$6,$0,$L1029
	and	$10,$21,$10

	addiu	$2,$2,-12
	sll	$10,$10,1
	sra	$6,$2,3
	addu	$6,$10,$6
	sll	$6,$6,1
	lw	$8,152($4)
	addiu	$6,$6,-1
	sra	$11,$6,2
	lw	$2,6168($4)
	mul	$13,$11,$8
	sll	$2,$2,2
	addiu	$2,$2,-1
	sra	$10,$2,2
	addu	$8,$13,$10
	sll	$8,$8,2
	addu	$22,$22,$8
	sll	$10,$7,1
	lw	$8,0($22)
	li	$11,12288			# 0x3000
	sll	$10,$11,$10
	and	$10,$8,$10
	beq	$10,$0,$L1070
	nop

$L1032:
	lw	$8,9748($4)
	addiu	$10,$7,24
	mul	$11,$6,$8
	sll	$10,$10,2
	addu	$10,$24,$10
	addu	$8,$11,$2
	lw	$10,0($10)
	sll	$8,$8,2
	addu	$8,$10,$8
	addiu	$10,$7,46
	sll	$7,$7,7
	addu	$5,$5,$7
	sll	$7,$10,2
	lhu	$10,0($8)
	addu	$5,$4,$5
	sh	$10,9176($5)
	lw	$10,9752($4)
	sra	$6,$6,1
	lh	$4,2($8)
	mul	$8,$6,$10
	addu	$24,$24,$7
	lw	$7,4($24)
	sra	$4,$4,1
	addu	$6,$8,$7
	sra	$2,$2,1
	sh	$4,9178($5)
	addu	$2,$6,$2
	lb	$13,0($2)
	b	$L1027
	sll	$13,$13,1

$L1068:
	lh	$2,2($9)
	lh	$3,0($9)
	sw	$3,0($19)
	b	$L1047
	sw	$2,0($18)

$L1069:
	lw	$10,8768($4)
	sll	$10,$10,2
	addu	$10,$22,$10
	lw	$10,0($10)
	andi	$10,$10,0x80
	beq	$10,$0,$L1029
	nop

	ori	$21,$21,0x1
	sll	$21,$21,1
	lw	$8,6168($4)
	addu	$6,$21,$6
	sra	$2,$2,4
	sll	$8,$8,2
	addiu	$2,$2,-1
	sll	$6,$6,1
	addu	$6,$2,$6
	addiu	$2,$8,-1
	lw	$8,152($4)
	sra	$11,$6,2
	mul	$13,$11,$8
	sra	$10,$2,2
	addu	$8,$13,$10
	sll	$8,$8,2
	addu	$22,$22,$8
	sll	$10,$7,1
	lw	$8,0($22)
	li	$11,12288			# 0x3000
	sll	$10,$11,$10
	and	$10,$8,$10
	beq	$10,$0,$L1071
	nop

$L1031:
	lw	$8,9748($4)
	addiu	$10,$7,24
	mul	$11,$6,$8
	sll	$10,$10,2
	addu	$10,$24,$10
	addu	$8,$11,$2
	lw	$10,0($10)
	sll	$8,$8,2
	addu	$8,$10,$8
	addiu	$10,$7,46
	sll	$7,$7,7
	addu	$5,$5,$7
	sll	$7,$10,2
	lhu	$10,0($8)
	addu	$5,$4,$5
	sh	$10,9176($5)
	lw	$10,9752($4)
	sra	$6,$6,1
	lhu	$4,2($8)
	mul	$8,$6,$10
	addu	$24,$24,$7
	lw	$7,4($24)
	sll	$4,$4,1
	addu	$6,$8,$7
	sra	$2,$2,1
	sh	$4,9178($5)
	addu	$2,$6,$2
	lb	$13,0($2)
	b	$L1027
	sra	$13,$13,1

$L1063:
	bne	$6,$0,$L1025
	nop

	b	$L1027
	li	$13,-1			# 0xffffffffffffffff

$L1071:
	andi	$8,$8,0x40
	bne	$8,$0,$L1031
	nop

	b	$L1027
	li	$13,-1			# 0xffffffffffffffff

$L1070:
	andi	$8,$8,0x40
	bne	$8,$0,$L1032
	nop

	b	$L1027
	li	$13,-1			# 0xffffffffffffffff

	.set	macro
	.set	reorder
	.end	pred_motion
	.size	pred_motion, .-pred_motion
	.section	.rodata.str1.4
	.align	2
$LC12:
	.ascii	"overflow in decode_cabac_mb_ref\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_cabac_mb_ref
	.type	decode_cabac_mb_ref, @function
decode_cabac_mb_ref:
	.frame	$sp,56,$31		# vars= 0, regs= 7/0, args= 16, gp= 8
	.mask	0x803f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-56
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,52($sp)
	sw	$21,48($sp)
	sw	$20,44($sp)
	sw	$19,40($sp)
	sw	$18,36($sp)
	sw	$17,32($sp)
	sw	$16,28($sp)
	.cprestore	16
	lui	$2,%hi(scan8)
	addiu	$2,$2,%lo(scan8)
	addu	$2,$2,$6
	sll	$3,$5,5
	lbu	$2,0($2)
	sll	$5,$5,3
	addu	$5,$5,$3
	li	$6,65536			# 0x10000
	addu	$6,$4,$6
	addu	$5,$4,$5
	addiu	$3,$2,-8
	addiu	$2,$2,-1
	lw	$7,-6284($6)
	addu	$6,$5,$3
	addu	$5,$5,$2
	lb	$8,9456($5)
	lb	$5,9456($6)
	li	$6,3			# 0x3
	beq	$7,$6,$L1087
	nop

	slt	$8,$0,$8
	slt	$5,$0,$5
	addiu	$2,$8,2
	movn	$8,$2,$5
$L1078:
	lw	$13,%got(ff_h264_norm_shift)($28)
	lw	$24,%got(ff_h264_mlps_state)($28)
	li	$14,131072			# 0x20000
	li	$20,-65536			# 0xffffffffffff0000
	lw	$25,%got(ff_h264_lps_range)($28)
	addiu	$24,$24,128
	ori	$20,$20,0x1
	move	$2,$0
	addu	$3,$4,$14
	move	$15,$13
	li	$19,7			# 0x7
	li	$18,4			# 0x4
	li	$17,5			# 0x5
	li	$16,32			# 0x20
$L1081:
	addiu	$9,$8,54
	lw	$6,8156($3)
	addu	$9,$4,$9
	addu	$9,$14,$9
	lbu	$10,8196($9)
	andi	$5,$6,0xc0
	sll	$5,$5,1
	addu	$5,$5,$10
	addu	$5,$25,$5
	lbu	$12,0($5)
	lw	$11,8152($3)
	subu	$6,$6,$12
	sll	$5,$6,17
	subu	$7,$5,$11
	sra	$7,$7,31
	movn	$6,$12,$7
	addu	$12,$13,$6
	and	$5,$7,$5
	xor	$7,$7,$10
	lbu	$10,0($12)
	subu	$5,$11,$5
	sw	$5,8152($3)
	sll	$5,$5,$10
	addiu	$12,$5,-1
	xor	$12,$12,$5
	sw	$6,8156($3)
	addu	$11,$24,$7
	sra	$12,$12,15
	addu	$21,$15,$12
	lbu	$12,0($11)
	sll	$6,$6,$10
	andi	$11,$5,0xffff
	andi	$7,$7,0x1
	slt	$8,$8,4
	sb	$12,8196($9)
	sw	$6,8156($3)
	bne	$11,$0,$L1083
	sw	$5,8152($3)

	lw	$6,8168($3)
	lbu	$10,0($21)
	lbu	$11,0($6)
	lbu	$9,1($6)
	sll	$11,$11,9
	addu	$11,$11,$20
	sll	$9,$9,1
	addu	$9,$11,$9
	subu	$10,$19,$10
	sll	$9,$9,$10
	addu	$5,$9,$5
	addiu	$6,$6,2
	sw	$5,8152($3)
	sw	$6,8168($3)
$L1083:
	beq	$7,$0,$L1089
	lw	$31,52($sp)

	move	$5,$17
	movn	$5,$18,$8
	addiu	$2,$2,1
	bne	$2,$16,$L1081
	move	$8,$5

	lw	$25,%call16(av_log)($28)
	lw	$4,0($4)
	lui	$6,%hi($LC12)
	addiu	$6,$6,%lo($LC12)
	jalr	$25
	move	$5,$0

	move	$2,$0
	lw	$31,52($sp)
$L1089:
	lw	$21,48($sp)
	lw	$20,44($sp)
	lw	$19,40($sp)
	lw	$18,36($sp)
	lw	$17,32($sp)
	lw	$16,28($sp)
	j	$31
	addiu	$sp,$sp,56

$L1087:
	blez	$8,$L1088
	addu	$2,$4,$2

	li	$6,131072			# 0x20000
	addu	$2,$6,$2
	lbu	$8,9020($2)
	sltu	$8,$8,1
$L1077:
	blez	$5,$L1078
	li	$2,131072			# 0x20000

	addu	$3,$4,$3
	addu	$3,$2,$3
	lbu	$3,9020($3)
	addiu	$2,$8,2
	b	$L1078
	movz	$8,$2,$3

$L1088:
	b	$L1077
	move	$8,$0

	.set	macro
	.set	reorder
	.end	decode_cabac_mb_ref
	.size	decode_cabac_mb_ref, .-decode_cabac_mb_ref
	.section	.rodata.str1.4
	.align	2
$LC13:
	.ascii	"overflow in decode_cabac_mb_mvd\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_cabac_mb_mvd
	.type	decode_cabac_mb_mvd, @function
decode_cabac_mb_mvd:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 16, gp= 8
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-32
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,28($sp)
	.cprestore	16
	lui	$2,%hi(scan8)
	addiu	$2,$2,%lo(scan8)
	addu	$2,$2,$6
	sll	$3,$5,5
	lbu	$2,0($2)
	sll	$5,$5,3
	addu	$5,$5,$3
	addu	$5,$5,$2
	addiu	$2,$5,-1
	addiu	$5,$5,-8
	sll	$5,$5,1
	sll	$2,$2,1
	li	$3,65536			# 0x10000
	ori	$3,$3,0x10fc
	addu	$5,$5,$7
	addu	$2,$2,$7
	addu	$2,$2,$3
	addu	$3,$5,$3
	sll	$3,$3,1
	sll	$2,$2,1
	addu	$3,$4,$3
	addu	$2,$4,$2
	lh	$3,0($3)
	lh	$2,0($2)
	subu	$8,$0,$3
	slt	$9,$3,0
	subu	$5,$0,$2
	slt	$6,$2,0
	movn	$3,$8,$9
	movn	$2,$5,$6
	li	$9,40			# 0x28
	li	$8,47			# 0x2f
	addu	$2,$3,$2
	li	$6,48			# 0x30
	movz	$8,$9,$7
	li	$9,41			# 0x29
	li	$5,49			# 0x31
	movz	$6,$9,$7
	slt	$3,$2,3
	li	$9,42			# 0x2a
	beq	$3,$0,$L1095
	movz	$5,$9,$7

	move	$5,$8
$L1096:
	li	$3,131072			# 0x20000
	addu	$2,$4,$3
	lw	$9,8156($2)
	addu	$5,$4,$5
	addu	$11,$3,$5
	lbu	$10,8196($11)
	andi	$3,$9,0xc0
	sll	$3,$3,1
	lw	$7,%got(ff_h264_lps_range)($28)
	addu	$3,$3,$10
	addu	$3,$7,$3
	lbu	$13,0($3)
	lw	$12,8152($2)
	subu	$9,$9,$13
	sll	$3,$9,17
	subu	$6,$3,$12
	sra	$6,$6,31
	lw	$5,%got(ff_h264_norm_shift)($28)
	movn	$9,$13,$6
	and	$3,$6,$3
	xor	$10,$6,$10
	lw	$6,%got(ff_h264_mlps_state)($28)
	addu	$13,$5,$9
	subu	$3,$12,$3
	addiu	$6,$6,128
	lbu	$12,0($13)
	sw	$3,8152($2)
	sw	$9,8156($2)
	addu	$13,$6,$10
	lbu	$13,0($13)
	sll	$3,$3,$12
	sll	$9,$9,$12
	andi	$12,$3,0xffff
	sb	$13,8196($11)
	sw	$9,8156($2)
	bne	$12,$0,$L1097
	sw	$3,8152($2)

	lw	$11,8168($2)
	addiu	$14,$3,-1
	xor	$14,$14,$3
	lbu	$13,0($11)
	sra	$14,$14,15
	lbu	$15,1($11)
	addu	$14,$5,$14
	li	$12,-65536			# 0xffffffffffff0000
	ori	$12,$12,0x1
	sll	$13,$13,9
	lbu	$14,0($14)
	addu	$13,$13,$12
	sll	$15,$15,1
	li	$12,7			# 0x7
	addu	$13,$13,$15
	subu	$12,$12,$14
	sll	$12,$13,$12
	addu	$3,$12,$3
	addiu	$11,$11,2
	sw	$11,8168($2)
	sw	$3,8152($2)
$L1097:
	andi	$10,$10,0x1
	beq	$10,$0,$L1129
	addiu	$11,$8,3

	li	$2,131072			# 0x20000
	addu	$11,$4,$11
	addu	$11,$2,$11
	lbu	$12,8196($11)
	andi	$3,$9,0xc0
	sll	$3,$3,1
	addu	$3,$3,$12
	addu	$3,$7,$3
	lbu	$14,0($3)
	addu	$2,$4,$2
	lw	$13,8152($2)
	subu	$9,$9,$14
	sll	$3,$9,17
	subu	$10,$3,$13
	sra	$10,$10,31
	movn	$9,$14,$10
	addu	$14,$5,$9
	and	$3,$10,$3
	subu	$3,$13,$3
	xor	$10,$10,$12
	lbu	$12,0($14)
	sw	$3,8152($2)
	sw	$9,8156($2)
	addu	$13,$6,$10
	lbu	$14,0($13)
	sll	$3,$3,$12
	sll	$9,$9,$12
	andi	$13,$3,0xffff
	sb	$14,8196($11)
	sw	$9,8156($2)
	bne	$13,$0,$L1100
	sw	$3,8152($2)

	lw	$9,8168($2)
	addiu	$13,$3,-1
	xor	$13,$13,$3
	lw	$11,%got(ff_h264_norm_shift)($28)
	lbu	$12,0($9)
	sra	$13,$13,15
	lbu	$14,1($9)
	addu	$13,$11,$13
	li	$11,-65536			# 0xffffffffffff0000
	ori	$11,$11,0x1
	sll	$12,$12,9
	lbu	$13,0($13)
	addu	$12,$12,$11
	sll	$14,$14,1
	li	$11,7			# 0x7
	addu	$12,$12,$14
	subu	$11,$11,$13
	sll	$11,$12,$11
	addu	$3,$3,$11
	addiu	$9,$9,2
	sw	$9,8168($2)
	sw	$3,8152($2)
$L1100:
	andi	$10,$10,0x1
	beq	$10,$0,$L1102
	li	$2,1			# 0x1

	li	$3,131072			# 0x20000
	addu	$2,$4,$3
	addiu	$11,$8,4
	lw	$9,8156($2)
	addu	$11,$4,$11
	addu	$11,$3,$11
	lbu	$12,8196($11)
	andi	$3,$9,0xc0
	sll	$3,$3,1
	addu	$3,$3,$12
	addu	$3,$7,$3
	lbu	$14,0($3)
	lw	$13,8152($2)
	subu	$9,$9,$14
	sll	$3,$9,17
	subu	$10,$3,$13
	sra	$10,$10,31
	movn	$9,$14,$10
	addu	$14,$5,$9
	and	$3,$10,$3
	subu	$3,$13,$3
	xor	$10,$10,$12
	lbu	$12,0($14)
	sw	$3,8152($2)
	sw	$9,8156($2)
	addu	$13,$6,$10
	lbu	$14,0($13)
	sll	$3,$3,$12
	sll	$9,$9,$12
	andi	$13,$3,0xffff
	sb	$14,8196($11)
	sw	$9,8156($2)
	bne	$13,$0,$L1103
	sw	$3,8152($2)

	lw	$9,8168($2)
	addiu	$13,$3,-1
	xor	$13,$13,$3
	lw	$11,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($9)
	sra	$13,$13,15
	addu	$13,$11,$13
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$11,1($9)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$11,$11,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$11
	li	$11,7			# 0x7
	subu	$11,$11,$13
	sll	$11,$12,$11
	addu	$3,$3,$11
	addiu	$9,$9,2
	sw	$9,8168($2)
	sw	$3,8152($2)
$L1103:
	andi	$10,$10,0x1
	beq	$10,$0,$L1102
	li	$2,2			# 0x2

	li	$3,131072			# 0x20000
	addu	$2,$4,$3
	addiu	$11,$8,5
	lw	$9,8156($2)
	addu	$11,$4,$11
	addu	$11,$3,$11
	lbu	$12,8196($11)
	andi	$3,$9,0xc0
	sll	$3,$3,1
	addu	$3,$3,$12
	addu	$3,$7,$3
	lbu	$14,0($3)
	lw	$13,8152($2)
	subu	$9,$9,$14
	sll	$3,$9,17
	subu	$10,$3,$13
	sra	$10,$10,31
	movn	$9,$14,$10
	addu	$14,$5,$9
	and	$3,$10,$3
	subu	$3,$13,$3
	xor	$10,$10,$12
	lbu	$12,0($14)
	sw	$3,8152($2)
	sw	$9,8156($2)
	addu	$13,$6,$10
	lbu	$14,0($13)
	sll	$3,$3,$12
	sll	$9,$9,$12
	andi	$13,$3,0xffff
	sb	$14,8196($11)
	sw	$9,8156($2)
	bne	$13,$0,$L1105
	sw	$3,8152($2)

	lw	$9,8168($2)
	addiu	$13,$3,-1
	xor	$13,$13,$3
	lw	$11,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($9)
	sra	$13,$13,15
	addu	$13,$11,$13
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$11,1($9)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$11,$11,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$11
	li	$11,7			# 0x7
	subu	$11,$11,$13
	sll	$11,$12,$11
	addu	$3,$3,$11
	addiu	$9,$9,2
	sw	$9,8168($2)
	sw	$3,8152($2)
$L1105:
	andi	$10,$10,0x1
	beq	$10,$0,$L1102
	li	$2,3			# 0x3

	li	$11,131072			# 0x20000
	addu	$2,$4,$11
	addiu	$8,$8,6
	lw	$9,8156($2)
	addu	$8,$4,$8
	addu	$11,$11,$8
	lbu	$12,8196($11)
	andi	$3,$9,0xc0
	sll	$3,$3,1
	addu	$3,$3,$12
	addu	$3,$7,$3
	lbu	$14,0($3)
	lw	$13,8152($2)
	subu	$9,$9,$14
	sll	$3,$9,17
	subu	$10,$3,$13
	sra	$10,$10,31
	movn	$9,$14,$10
	addu	$14,$5,$9
	and	$3,$10,$3
	subu	$3,$13,$3
	xor	$10,$10,$12
	lbu	$12,0($14)
	sw	$3,8152($2)
	sw	$9,8156($2)
	addu	$13,$6,$10
	lbu	$14,0($13)
	sll	$3,$3,$12
	sll	$9,$9,$12
	andi	$13,$3,0xffff
	sb	$14,8196($11)
	sw	$9,8156($2)
	bne	$13,$0,$L1107
	sw	$3,8152($2)

	lw	$9,8168($2)
	addiu	$13,$3,-1
	xor	$13,$13,$3
	lw	$11,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($9)
	sra	$13,$13,15
	addu	$13,$11,$13
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$11,1($9)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$11,$11,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$11
	li	$11,7			# 0x7
	subu	$11,$11,$13
	sll	$11,$12,$11
	addu	$3,$3,$11
	addiu	$9,$9,2
	sw	$9,8168($2)
	sw	$3,8152($2)
$L1107:
	andi	$10,$10,0x1
	beq	$10,$0,$L1102
	li	$2,4			# 0x4

	li	$11,131072			# 0x20000
	addu	$2,$4,$11
	lw	$9,8156($2)
	addu	$11,$11,$8
	lbu	$12,8196($11)
	andi	$3,$9,0xc0
	sll	$3,$3,1
	addu	$3,$3,$12
	addu	$3,$7,$3
	lbu	$14,0($3)
	lw	$13,8152($2)
	subu	$9,$9,$14
	sll	$3,$9,17
	subu	$10,$3,$13
	sra	$10,$10,31
	movn	$9,$14,$10
	addu	$14,$5,$9
	and	$3,$10,$3
	subu	$3,$13,$3
	xor	$10,$10,$12
	lbu	$12,0($14)
	sw	$3,8152($2)
	sw	$9,8156($2)
	addu	$13,$6,$10
	lbu	$14,0($13)
	sll	$3,$3,$12
	sll	$9,$9,$12
	andi	$13,$3,0xffff
	sb	$14,8196($11)
	sw	$9,8156($2)
	bne	$13,$0,$L1109
	sw	$3,8152($2)

	lw	$9,8168($2)
	addiu	$13,$3,-1
	xor	$13,$13,$3
	lw	$11,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($9)
	sra	$13,$13,15
	addu	$13,$11,$13
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$11,1($9)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$11,$11,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$11
	li	$11,7			# 0x7
	subu	$11,$11,$13
	sll	$11,$12,$11
	addu	$3,$3,$11
	addiu	$9,$9,2
	sw	$9,8168($2)
	sw	$3,8152($2)
$L1109:
	andi	$10,$10,0x1
	beq	$10,$0,$L1102
	li	$2,5			# 0x5

	li	$11,131072			# 0x20000
	addu	$2,$4,$11
	lw	$9,8156($2)
	addu	$11,$11,$8
	lbu	$12,8196($11)
	andi	$3,$9,0xc0
	sll	$3,$3,1
	addu	$3,$3,$12
	addu	$3,$7,$3
	lbu	$14,0($3)
	lw	$13,8152($2)
	subu	$9,$9,$14
	sll	$3,$9,17
	subu	$10,$3,$13
	sra	$10,$10,31
	movn	$9,$14,$10
	addu	$14,$5,$9
	and	$3,$10,$3
	subu	$3,$13,$3
	xor	$10,$10,$12
	lbu	$12,0($14)
	sw	$3,8152($2)
	sw	$9,8156($2)
	addu	$13,$6,$10
	lbu	$14,0($13)
	sll	$3,$3,$12
	sll	$9,$9,$12
	andi	$13,$3,0xffff
	sb	$14,8196($11)
	sw	$9,8156($2)
	bne	$13,$0,$L1111
	sw	$3,8152($2)

	lw	$9,8168($2)
	addiu	$13,$3,-1
	xor	$13,$13,$3
	lw	$11,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($9)
	sra	$13,$13,15
	addu	$13,$11,$13
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$11,1($9)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$11,$11,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$11
	li	$11,7			# 0x7
	subu	$11,$11,$13
	sll	$11,$12,$11
	addu	$3,$3,$11
	addiu	$9,$9,2
	sw	$9,8168($2)
	sw	$3,8152($2)
$L1111:
	andi	$10,$10,0x1
	beq	$10,$0,$L1102
	li	$2,6			# 0x6

	li	$11,131072			# 0x20000
	addu	$2,$4,$11
	lw	$9,8156($2)
	addu	$11,$11,$8
	lbu	$12,8196($11)
	andi	$3,$9,0xc0
	sll	$3,$3,1
	addu	$3,$3,$12
	addu	$3,$7,$3
	lbu	$14,0($3)
	lw	$13,8152($2)
	subu	$9,$9,$14
	sll	$3,$9,17
	subu	$10,$3,$13
	sra	$10,$10,31
	movn	$9,$14,$10
	addu	$14,$5,$9
	and	$3,$10,$3
	subu	$3,$13,$3
	xor	$10,$10,$12
	lbu	$12,0($14)
	sw	$3,8152($2)
	sw	$9,8156($2)
	addu	$13,$6,$10
	lbu	$14,0($13)
	sll	$3,$3,$12
	sll	$9,$9,$12
	andi	$13,$3,0xffff
	sb	$14,8196($11)
	sw	$9,8156($2)
	bne	$13,$0,$L1113
	sw	$3,8152($2)

	lw	$9,8168($2)
	addiu	$13,$3,-1
	xor	$13,$13,$3
	lw	$11,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($9)
	sra	$13,$13,15
	addu	$13,$11,$13
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$11,1($9)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$11,$11,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$11
	li	$11,7			# 0x7
	subu	$11,$11,$13
	sll	$11,$12,$11
	addu	$3,$3,$11
	addiu	$9,$9,2
	sw	$9,8168($2)
	sw	$3,8152($2)
$L1113:
	andi	$10,$10,0x1
	beq	$10,$0,$L1102
	li	$2,7			# 0x7

	li	$9,131072			# 0x20000
	addu	$2,$4,$9
	lw	$3,8156($2)
	addu	$8,$9,$8
	lbu	$10,8196($8)
	andi	$9,$3,0xc0
	sll	$9,$9,1
	addu	$9,$9,$10
	addu	$7,$7,$9
	lbu	$12,0($7)
	lw	$11,8152($2)
	subu	$7,$3,$12
	sll	$3,$7,17
	subu	$9,$3,$11
	sra	$9,$9,31
	movn	$7,$12,$9
	and	$3,$9,$3
	addu	$5,$5,$7
	subu	$3,$11,$3
	xor	$9,$9,$10
	lbu	$5,0($5)
	sw	$3,8152($2)
	sw	$7,8156($2)
	addu	$6,$6,$9
	lbu	$10,0($6)
	sll	$3,$3,$5
	sll	$7,$7,$5
	andi	$6,$3,0xffff
	sb	$10,8196($8)
	sw	$7,8156($2)
	bne	$6,$0,$L1116
	sw	$3,8152($2)

	lw	$5,8168($2)
	addiu	$8,$3,-1
	xor	$8,$8,$3
	lw	$6,%got(ff_h264_norm_shift)($28)
	lbu	$10,0($5)
	sra	$8,$8,15
	addu	$8,$6,$8
	li	$7,-65536			# 0xffffffffffff0000
	lbu	$6,1($5)
	sll	$10,$10,9
	ori	$7,$7,0x1
	sll	$6,$6,1
	lbu	$8,0($8)
	addu	$7,$10,$7
	addu	$7,$7,$6
	li	$6,7			# 0x7
	subu	$6,$6,$8
	sll	$6,$7,$6
	addu	$3,$3,$6
	addiu	$5,$5,2
	sw	$5,8168($2)
	sw	$3,8152($2)
$L1116:
	andi	$9,$9,0x1
	beq	$9,$0,$L1137
	li	$6,131072			# 0x20000

	addu	$6,$4,$6
	sll	$3,$3,1
	lw	$9,8156($6)
	li	$5,3			# 0x3
	li	$15,-65536			# 0xffffffffffff0000
	li	$11,1			# 0x1
	andi	$8,$3,0xffff
	sll	$9,$9,17
	ori	$15,$15,0x1
	li	$2,9			# 0x9
	li	$14,25			# 0x19
	sll	$10,$11,$5
	addiu	$7,$5,1
	bne	$8,$0,$L1119
	sw	$3,8152($6)

$L1138:
	lw	$8,8168($6)
	lbu	$13,0($8)
	lbu	$12,1($8)
	sll	$13,$13,9
	addu	$13,$13,$15
	sll	$12,$12,1
	addu	$12,$13,$12
	addu	$3,$3,$12
	addiu	$8,$8,2
	sw	$8,8168($6)
	sw	$3,8152($6)
$L1119:
	slt	$8,$3,$9
	bne	$8,$0,$L1120
	nop

$L1139:
	subu	$3,$3,$9
	addu	$2,$2,$10
	beq	$7,$14,$L1121
	sw	$3,8152($6)

	sll	$3,$3,1
	move	$5,$7
	andi	$8,$3,0xffff
	sll	$10,$11,$5
	addiu	$7,$5,1
	beq	$8,$0,$L1138
	sw	$3,8152($6)

	slt	$8,$3,$9
	beq	$8,$0,$L1139
	nop

$L1120:
	li	$6,131072			# 0x20000
	li	$11,-65536			# 0xffffffffffff0000
	addu	$6,$4,$6
	ori	$11,$11,0x1
	li	$9,1			# 0x1
$L1126:
	sll	$3,$3,1
	andi	$7,$3,0xffff
	bne	$7,$0,$L1122
	sw	$3,8152($6)

	lw	$7,8168($6)
	lbu	$10,0($7)
	lbu	$8,1($7)
	sll	$10,$10,9
	addu	$10,$10,$11
	sll	$8,$8,1
	addu	$8,$10,$8
	addu	$3,$3,$8
	addiu	$7,$7,2
	sw	$7,8168($6)
	sw	$3,8152($6)
$L1122:
	lw	$7,8156($6)
	addiu	$5,$5,-1
	sll	$7,$7,17
	subu	$8,$3,$7
	slt	$3,$3,$7
	bne	$3,$0,$L1123
	sll	$7,$9,$5

	sw	$8,8152($6)
	addu	$2,$2,$7
$L1123:
	bne	$5,$0,$L1126
	lw	$3,8152($6)

$L1102:
	sll	$3,$3,1
	li	$5,131072			# 0x20000
	addu	$5,$4,$5
	andi	$6,$3,0xffff
	bne	$6,$0,$L1124
	sw	$3,8152($5)

	lw	$6,8168($5)
	li	$7,-65536			# 0xffffffffffff0000
	lbu	$9,0($6)
	lbu	$8,1($6)
	sll	$9,$9,9
	ori	$7,$7,0x1
	addu	$7,$9,$7
	sll	$8,$8,1
	addu	$7,$7,$8
	addu	$3,$3,$7
	addiu	$6,$6,2
	sw	$6,8168($5)
	sw	$3,8152($5)
$L1124:
	li	$5,131072			# 0x20000
	addu	$4,$4,$5
	lw	$6,8156($4)
	lw	$31,28($sp)
	sll	$6,$6,17
	subu	$3,$3,$6
	sra	$5,$3,31
	and	$6,$5,$6
	subu	$2,$0,$2
	addu	$3,$6,$3
	xor	$2,$5,$2
	subu	$2,$2,$5
	sw	$3,8152($4)
	j	$31
	addiu	$sp,$sp,32

$L1095:
	slt	$2,$2,33
	b	$L1096
	movn	$5,$6,$2

$L1129:
	lw	$31,28($sp)
	move	$2,$0
	j	$31
	addiu	$sp,$sp,32

$L1121:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($4)
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	jalr	$25
	move	$5,$0

	lw	$31,28($sp)
	li	$2,-2147483648			# 0xffffffff80000000
	j	$31
	addiu	$sp,$sp,32

$L1137:
	b	$L1102
	li	$2,8			# 0x8

	.set	macro
	.set	reorder
	.end	decode_cabac_mb_mvd
	.size	decode_cabac_mb_mvd, .-decode_cabac_mb_mvd
	.align	2
	.set	nomips16
	.ent	decode_cabac_residual
	.type	decode_cabac_residual, @function
decode_cabac_residual:
	.frame	$sp,328,$31		# vars= 280, regs= 9/0, args= 0, gp= 8
	.mask	0x40ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-328
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$fp,324($sp)
	sw	$23,320($sp)
	sw	$22,316($sp)
	sw	$21,312($sp)
	sw	$20,308($sp)
	sw	$19,304($sp)
	sw	$18,300($sp)
	sw	$17,296($sp)
	sw	$16,292($sp)
	.cprestore	0
	lw	$8,152($4)
	lw	$3,6172($4)
	lw	$2,6168($4)
	mul	$12,$8,$3
	li	$9,131072			# 0x20000
	addu	$11,$12,$2
	addu	$10,$4,$9
	sw	$11,268($sp)
	li	$11,5			# 0x5
	lw	$14,344($sp)
	lw	$12,348($sp)
	lw	$3,8156($10)
	lw	$8,8152($10)
	beq	$6,$11,$L1141
	lw	$2,8168($10)

	bne	$6,$0,$L1142
	addiu	$9,$6,-1

	lw	$9,8672($10)
	lw	$11,8668($10)
	andi	$9,$9,0x100
	andi	$10,$11,0x100
$L1143:
	sltu	$9,$0,$9
	addiu	$11,$9,2
	movn	$9,$11,$10
	sll	$17,$6,2
	addu	$9,$9,$17
	addiu	$9,$9,85
	addu	$9,$4,$9
	li	$25,131072			# 0x20000
	addu	$25,$25,$9
	lbu	$15,8196($25)
	andi	$9,$3,0xc0
	sll	$9,$9,1
	lw	$10,%got(ff_h264_lps_range)($28)
	addu	$9,$9,$15
	addu	$9,$10,$9
	lbu	$11,0($9)
	lw	$9,%got(ff_h264_norm_shift)($28)
	subu	$3,$3,$11
	sll	$16,$3,17
	subu	$13,$16,$8
	sra	$13,$13,31
	movn	$3,$11,$13
	lw	$11,%got(ff_h264_mlps_state)($28)
	addu	$24,$9,$3
	xor	$15,$13,$15
	lbu	$24,0($24)
	and	$13,$13,$16
	addiu	$11,$11,128
	subu	$8,$8,$13
	addu	$18,$11,$15
	sll	$8,$8,$24
	lbu	$16,0($18)
	andi	$13,$8,0xffff
	sb	$16,8196($25)
	bne	$13,$0,$L1147
	sll	$3,$3,$24

	addiu	$25,$8,-1
	xor	$25,$25,$8
	lbu	$16,0($2)
	lbu	$13,1($2)
	sra	$25,$25,15
	li	$24,-65536			# 0xffffffffffff0000
	addu	$25,$9,$25
	sll	$16,$16,9
	ori	$24,$24,0x1
	sll	$13,$13,1
	lbu	$25,0($25)
	addu	$24,$16,$24
	addu	$24,$24,$13
	li	$13,7			# 0x7
	subu	$13,$13,$25
	sll	$13,$24,$13
	addu	$8,$8,$13
	addiu	$2,$2,2
$L1147:
	andi	$15,$15,0x1
	bne	$15,$0,$L1148
	li	$13,65536			# 0x10000

	addiu	$5,$6,-1
	sltu	$5,$5,2
	bne	$5,$0,$L1230
	li	$5,4			# 0x4

	beq	$6,$5,$L1231
	lui	$5,%hi(scan8)

$L1169:
	li	$5,131072			# 0x20000
	addu	$4,$4,$5
	lw	$fp,324($sp)
	lw	$23,320($sp)
	lw	$22,316($sp)
	lw	$21,312($sp)
	lw	$20,308($sp)
	lw	$19,304($sp)
	lw	$18,300($sp)
	lw	$17,296($sp)
	lw	$16,292($sp)
	sw	$2,8168($4)
	sw	$3,8156($4)
	sw	$8,8152($4)
	j	$31
	addiu	$sp,$sp,328

$L1142:
	sltu	$9,$9,2
	bne	$9,$0,$L1232
	lui	$9,%hi(scan8)

	li	$9,3			# 0x3
	beq	$6,$9,$L1233
	nop

	lui	$9,%hi(scan8)
	addiu	$9,$9,%lo(scan8)
	addu	$9,$7,$9
	lbu	$9,16($9)
	addu	$9,$4,$9
	lbu	$10,9072($9)
	b	$L1143
	lbu	$9,9079($9)

$L1148:
	addu	$13,$4,$13
	lw	$13,-6272($13)
	lui	$24,%hi(coeff_abs_level_m1_offset.17570)
	sll	$15,$13,3
	sll	$13,$13,1
	subu	$13,$15,$13
	addiu	$24,$24,%lo(coeff_abs_level_m1_offset.17570)
	addu	$17,$24,$17
	addu	$13,$13,$6
	lui	$15,%hi(last_coeff_flag_offset.17569)
	lui	$24,%hi(significant_coeff_flag_offset.17568)
	sll	$13,$13,2
	addiu	$24,$24,%lo(significant_coeff_flag_offset.17568)
	addiu	$15,$15,%lo(last_coeff_flag_offset.17569)
	addu	$15,$13,$15
	addu	$13,$13,$24
	lw	$25,0($15)
	lw	$24,0($13)
	li	$15,131072			# 0x20000
	lw	$13,0($17)
	ori	$15,$15,0x2000
	addu	$13,$13,$15
	addu	$24,$24,$15
	addu	$15,$25,$15
	lw	$25,352($sp)
	addu	$24,$4,$24
	addu	$15,$4,$15
	addu	$13,$4,$13
	addiu	$21,$25,-1
	addiu	$24,$24,4
	addiu	$15,$15,4
	blez	$21,$L1234
	addiu	$13,$13,4

	move	$17,$15
	li	$23,-65536			# 0xffffffffffff0000
	addiu	$15,$sp,8
	lw	$20,%got(ff_h264_norm_shift)($28)
	ori	$23,$23,0x1
	move	$19,$0
	move	$25,$0
	li	$22,7			# 0x7
	mtlo	$13
	sw	$4,272($sp)
	move	$fp,$15
$L1162:
	lbu	$16,0($24)
	andi	$13,$3,0xc0
	sll	$13,$13,1
	addu	$13,$13,$16
	addu	$13,$10,$13
	lbu	$13,0($13)
	subu	$15,$3,$13
	sll	$18,$15,17
	subu	$3,$18,$8
	sra	$3,$3,31
	movn	$15,$13,$3
	addu	$13,$9,$15
	xor	$16,$3,$16
	lbu	$13,0($13)
	and	$3,$3,$18
	subu	$8,$8,$3
	sll	$8,$8,$13
	addiu	$18,$8,-1
	xor	$18,$18,$8
	sra	$18,$18,15
	addu	$18,$20,$18
	sw	$18,264($sp)
	addu	$3,$11,$16
	lbu	$3,0($3)
	andi	$18,$8,0xffff
	sb	$3,0($24)
	andi	$16,$16,0x1
	bne	$18,$0,$L1158
	sll	$3,$15,$13

	lbu	$15,0($2)
	lw	$4,264($sp)
	lbu	$13,1($2)
	sll	$15,$15,9
	lbu	$18,0($4)
	addu	$15,$15,$23
	sll	$13,$13,1
	addu	$15,$15,$13
	subu	$18,$22,$18
	sll	$15,$15,$18
	addu	$8,$8,$15
	addiu	$2,$2,2
$L1158:
	bne	$16,$0,$L1235
	sll	$13,$19,2

	addiu	$25,$25,1
$L1265:
	slt	$13,$25,$21
	addiu	$24,$24,1
	bne	$13,$0,$L1162
	addiu	$17,$17,1

	mflo	$13
	beq	$25,$21,$L1236
	lw	$4,272($sp)

$L1163:
	bne	$6,$0,$L1164
	lw	$15,268($sp)

	li	$6,131072			# 0x20000
	addu	$6,$4,$6
	lw	$7,8660($6)
	sll	$6,$15,1
	addu	$6,$7,$6
	lhu	$7,0($6)
	ori	$7,$7,0x100
	sh	$7,0($6)
$L1165:
	blez	$19,$L1169
	sll	$19,$19,2

	addiu	$22,$sp,8
	li	$7,-65536			# 0xffffffffffff0000
	lw	$17,%got(ff_h264_norm_shift)($28)
	addu	$19,$22,$19
	ori	$7,$7,0x1
	move	$18,$0
	li	$21,1			# 0x1
	li	$23,4			# 0x4
	li	$16,7			# 0x7
	move	$6,$8
	sw	$4,268($sp)
$L1222:
	beq	$18,$0,$L1170
	slt	$fp,$21,5

	move	$fp,$0
$L1171:
	addu	$fp,$13,$fp
	lbu	$24,0($fp)
	andi	$8,$3,0xc0
	sll	$8,$8,1
	addu	$8,$8,$24
	addu	$8,$10,$8
	lbu	$25,0($8)
	lw	$20,-4($19)
	subu	$3,$3,$25
	sll	$15,$3,17
	subu	$8,$15,$6
	sra	$8,$8,31
	movn	$3,$25,$8
	addu	$25,$9,$3
	lbu	$25,0($25)
	and	$15,$8,$15
	xor	$24,$8,$24
	subu	$15,$6,$15
	addu	$8,$11,$24
	sll	$15,$15,$25
	lbu	$8,0($8)
	addu	$20,$14,$20
	andi	$6,$15,0xffff
	lbu	$20,0($20)
	sll	$3,$3,$25
	bne	$6,$0,$L1172
	sb	$8,0($fp)

	addiu	$8,$15,-1
	xor	$8,$8,$15
	lbu	$25,0($2)
	sra	$8,$8,15
	lbu	$6,1($2)
	addu	$8,$17,$8
	sll	$25,$25,9
	lbu	$8,0($8)
	addu	$25,$25,$7
	sll	$6,$6,1
	addu	$6,$25,$6
	subu	$8,$16,$8
	sll	$6,$6,$8
	addu	$15,$15,$6
	addiu	$2,$2,2
$L1172:
	andi	$24,$24,0x1
	bne	$24,$0,$L1173
	slt	$8,$18,5

	beq	$12,$0,$L1237
	sll	$8,$20,2

	sll	$15,$15,1
	addu	$8,$12,$8
	andi	$6,$15,0xffff
	bne	$6,$0,$L1177
	lw	$24,0($8)

	lbu	$8,0($2)
	lbu	$6,1($2)
	addu	$15,$15,$7
	sll	$8,$8,9
	addu	$15,$15,$8
	sll	$6,$6,1
	addu	$15,$15,$6
	addiu	$2,$2,2
$L1177:
	sll	$6,$3,17
	subu	$15,$15,$6
	sra	$8,$15,31
	subu	$24,$0,$24
	xor	$24,$8,$24
	subu	$24,$24,$8
	sll	$20,$20,1
	addiu	$24,$24,32
	and	$6,$8,$6
	addu	$20,$5,$20
	sra	$8,$24,6
	sh	$8,0($20)
	addu	$6,$6,$15
$L1176:
	addiu	$21,$21,1
$L1178:
	addiu	$19,$19,-4
	bne	$22,$19,$L1222
	move	$8,$6

	b	$L1169
	lw	$4,268($sp)

$L1173:
	move	$4,$23
	movn	$4,$18,$8
	addiu	$8,$4,5
	addu	$8,$13,$8
	lbu	$24,0($8)
	andi	$6,$3,0xc0
	sll	$6,$6,1
	addu	$6,$6,$24
	addu	$6,$10,$6
	lbu	$25,0($6)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$6,$fp,$15
	sra	$6,$6,31
	movn	$3,$25,$6
	addu	$25,$9,$3
	xor	$24,$6,$24
	lbu	$25,0($25)
	and	$6,$6,$fp
	subu	$6,$15,$6
	addu	$fp,$11,$24
	lbu	$15,0($fp)
	sll	$6,$6,$25
	andi	$fp,$6,0xffff
	sb	$15,0($8)
	bne	$fp,$0,$L1179
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1179:
	andi	$24,$24,0x1
	beq	$24,$0,$L1238
	li	$25,2			# 0x2

	andi	$24,$3,0xc0
	sll	$24,$24,1
	addu	$24,$24,$15
	addu	$24,$10,$24
	lbu	$25,0($24)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$24,$fp,$6
	sra	$24,$24,31
	movn	$3,$25,$24
	addu	$25,$9,$3
	xor	$15,$24,$15
	lbu	$25,0($25)
	and	$24,$24,$fp
	subu	$6,$6,$24
	addu	$24,$11,$15
	sll	$6,$6,$25
	lbu	$24,0($24)
	andi	$fp,$6,0xffff
	sb	$24,0($8)
	bne	$fp,$0,$L1182
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1182:
	andi	$15,$15,0x1
	beq	$15,$0,$L1239
	li	$25,3			# 0x3

	andi	$15,$3,0xc0
	sll	$15,$15,1
	addu	$15,$15,$24
	addu	$15,$10,$15
	lbu	$25,0($15)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$15,$fp,$6
	sra	$15,$15,31
	movn	$3,$25,$15
	addu	$25,$9,$3
	xor	$24,$15,$24
	lbu	$25,0($25)
	and	$15,$15,$fp
	subu	$6,$6,$15
	addu	$15,$11,$24
	sll	$6,$6,$25
	lbu	$15,0($15)
	andi	$fp,$6,0xffff
	sb	$15,0($8)
	bne	$fp,$0,$L1184
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1184:
	andi	$24,$24,0x1
	beq	$24,$0,$L1240
	li	$25,4			# 0x4

	andi	$24,$3,0xc0
	sll	$24,$24,1
	addu	$24,$24,$15
	addu	$24,$10,$24
	lbu	$25,0($24)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$24,$fp,$6
	sra	$24,$24,31
	movn	$3,$25,$24
	addu	$25,$9,$3
	xor	$15,$24,$15
	lbu	$25,0($25)
	and	$24,$24,$fp
	subu	$6,$6,$24
	addu	$24,$11,$15
	sll	$6,$6,$25
	lbu	$24,0($24)
	andi	$fp,$6,0xffff
	sb	$24,0($8)
	bne	$fp,$0,$L1186
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1186:
	andi	$15,$15,0x1
	beq	$15,$0,$L1241
	li	$25,5			# 0x5

	andi	$15,$3,0xc0
	sll	$15,$15,1
	addu	$15,$15,$24
	addu	$15,$10,$15
	lbu	$25,0($15)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$15,$fp,$6
	sra	$15,$15,31
	movn	$3,$25,$15
	addu	$25,$9,$3
	xor	$24,$15,$24
	lbu	$25,0($25)
	and	$15,$15,$fp
	subu	$6,$6,$15
	addu	$15,$11,$24
	sll	$6,$6,$25
	lbu	$15,0($15)
	andi	$fp,$6,0xffff
	sb	$15,0($8)
	bne	$fp,$0,$L1188
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1188:
	andi	$24,$24,0x1
	beq	$24,$0,$L1242
	li	$25,6			# 0x6

	andi	$24,$3,0xc0
	sll	$24,$24,1
	addu	$24,$24,$15
	addu	$24,$10,$24
	lbu	$25,0($24)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$24,$fp,$6
	sra	$24,$24,31
	movn	$3,$25,$24
	addu	$25,$9,$3
	xor	$15,$24,$15
	lbu	$25,0($25)
	and	$24,$24,$fp
	subu	$6,$6,$24
	addu	$24,$11,$15
	sll	$6,$6,$25
	lbu	$24,0($24)
	andi	$fp,$6,0xffff
	sb	$24,0($8)
	bne	$fp,$0,$L1190
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1190:
	andi	$15,$15,0x1
	beq	$15,$0,$L1243
	li	$25,7			# 0x7

	andi	$15,$3,0xc0
	sll	$15,$15,1
	addu	$15,$15,$24
	addu	$15,$10,$15
	lbu	$25,0($15)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$15,$fp,$6
	sra	$15,$15,31
	movn	$3,$25,$15
	addu	$25,$9,$3
	xor	$24,$15,$24
	lbu	$25,0($25)
	and	$15,$15,$fp
	subu	$6,$6,$15
	addu	$15,$11,$24
	sll	$6,$6,$25
	lbu	$15,0($15)
	andi	$fp,$6,0xffff
	sb	$15,0($8)
	bne	$fp,$0,$L1192
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1192:
	andi	$24,$24,0x1
	beq	$24,$0,$L1244
	li	$25,8			# 0x8

	andi	$24,$3,0xc0
	sll	$24,$24,1
	addu	$24,$24,$15
	addu	$24,$10,$24
	lbu	$25,0($24)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$24,$fp,$6
	sra	$24,$24,31
	movn	$3,$25,$24
	addu	$25,$9,$3
	xor	$15,$24,$15
	lbu	$25,0($25)
	and	$24,$24,$fp
	subu	$6,$6,$24
	addu	$fp,$11,$15
	lbu	$24,0($fp)
	sll	$6,$6,$25
	andi	$fp,$6,0xffff
	sb	$24,0($8)
	bne	$fp,$0,$L1194
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1194:
	andi	$15,$15,0x1
	beq	$15,$0,$L1245
	li	$25,9			# 0x9

	andi	$15,$3,0xc0
	sll	$15,$15,1
	addu	$15,$15,$24
	addu	$15,$10,$15
	lbu	$25,0($15)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$15,$fp,$6
	sra	$15,$15,31
	movn	$3,$25,$15
	addu	$25,$9,$3
	xor	$24,$15,$24
	lbu	$25,0($25)
	and	$15,$15,$fp
	subu	$6,$6,$15
	addu	$15,$11,$24
	sll	$6,$6,$25
	lbu	$15,0($15)
	andi	$fp,$6,0xffff
	sb	$15,0($8)
	bne	$fp,$0,$L1196
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1196:
	andi	$24,$24,0x1
	beq	$24,$0,$L1246
	li	$25,10			# 0xa

	andi	$24,$3,0xc0
	sll	$24,$24,1
	addu	$24,$24,$15
	addu	$24,$10,$24
	lbu	$25,0($24)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$24,$fp,$6
	sra	$24,$24,31
	movn	$3,$25,$24
	addu	$25,$9,$3
	xor	$15,$24,$15
	lbu	$25,0($25)
	and	$24,$24,$fp
	subu	$6,$6,$24
	addu	$24,$11,$15
	sll	$6,$6,$25
	lbu	$24,0($24)
	andi	$fp,$6,0xffff
	sb	$24,0($8)
	bne	$fp,$0,$L1198
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1198:
	andi	$15,$15,0x1
	beq	$15,$0,$L1247
	li	$25,11			# 0xb

	andi	$15,$3,0xc0
	sll	$15,$15,1
	addu	$15,$15,$24
	addu	$15,$10,$15
	lbu	$25,0($15)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$15,$fp,$6
	sra	$15,$15,31
	movn	$3,$25,$15
	addu	$25,$9,$3
	xor	$24,$15,$24
	lbu	$25,0($25)
	and	$15,$15,$fp
	subu	$6,$6,$15
	addu	$15,$11,$24
	sll	$6,$6,$25
	lbu	$15,0($15)
	andi	$fp,$6,0xffff
	sb	$15,0($8)
	bne	$fp,$0,$L1200
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1200:
	andi	$24,$24,0x1
	beq	$24,$0,$L1248
	li	$25,12			# 0xc

	andi	$24,$3,0xc0
	sll	$24,$24,1
	addu	$24,$24,$15
	addu	$24,$10,$24
	lbu	$25,0($24)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$24,$fp,$6
	sra	$24,$24,31
	movn	$3,$25,$24
	addu	$25,$9,$3
	xor	$15,$24,$15
	lbu	$25,0($25)
	and	$24,$24,$fp
	subu	$6,$6,$24
	addu	$24,$11,$15
	sll	$6,$6,$25
	lbu	$24,0($24)
	andi	$fp,$6,0xffff
	sb	$24,0($8)
	bne	$fp,$0,$L1202
	sll	$3,$3,$25

	lbu	$25,0($2)
	addiu	$fp,$6,-1
	sw	$25,264($sp)
	xor	$fp,$fp,$6
	lw	$4,264($sp)
	sra	$fp,$fp,15
	lbu	$25,1($2)
	addu	$fp,$17,$fp
	sll	$4,$4,9
	lbu	$fp,0($fp)
	addu	$4,$4,$7
	sll	$25,$25,1
	addu	$25,$4,$25
	subu	$fp,$16,$fp
	sll	$25,$25,$fp
	sw	$4,264($sp)
	addu	$6,$6,$25
	addiu	$2,$2,2
$L1202:
	andi	$15,$15,0x1
	beq	$15,$0,$L1249
	li	$25,13			# 0xd

	andi	$15,$3,0xc0
	sll	$15,$15,1
	addu	$15,$15,$24
	addu	$15,$10,$15
	lbu	$25,0($15)
	subu	$3,$3,$25
	sll	$fp,$3,17
	subu	$15,$fp,$6
	sra	$15,$15,31
	movn	$3,$25,$15
	addu	$25,$9,$3
	xor	$24,$15,$24
	lbu	$25,0($25)
	and	$15,$15,$fp
	subu	$6,$6,$15
	addu	$15,$11,$24
	lbu	$fp,0($15)
	sll	$6,$6,$25
	andi	$15,$6,0xffff
	sb	$fp,0($8)
	bne	$15,$0,$L1205
	sll	$3,$3,$25

	addiu	$15,$6,-1
	xor	$15,$15,$6
	lbu	$25,0($2)
	sra	$15,$15,15
	lbu	$8,1($2)
	addu	$15,$17,$15
	sll	$25,$25,9
	lbu	$15,0($15)
	addu	$25,$25,$7
	sll	$8,$8,1
	addu	$8,$25,$8
	subu	$15,$16,$15
	sll	$8,$8,$15
	addu	$6,$6,$8
	addiu	$2,$2,2
$L1205:
	andi	$24,$24,0x1
	beq	$24,$0,$L1262
	li	$25,14			# 0xe

	sll	$6,$6,1
	andi	$8,$6,0xffff
	sll	$15,$3,17
	move	$24,$0
	bne	$8,$0,$L1209
	addu	$25,$6,$7

$L1251:
	lbu	$6,0($2)
	lbu	$8,1($2)
	sll	$6,$6,9
	addu	$25,$25,$6
	sll	$8,$8,1
	addu	$6,$25,$8
	addiu	$2,$2,2
$L1209:
	slt	$8,$6,$15
	bne	$8,$0,$L1210
	nop

$L1252:
	subu	$6,$6,$15
	sll	$6,$6,1
	andi	$8,$6,0xffff
	addiu	$24,$24,1
	beq	$8,$0,$L1251
	addu	$25,$6,$7

	slt	$8,$6,$15
	beq	$8,$0,$L1252
	nop

$L1210:
	beq	$24,$0,$L1253
	move	$8,$0

	b	$L1215
	li	$25,1			# 0x1

$L1213:
	sll	$25,$25,1
	addiu	$8,$8,1
	subu	$6,$6,$15
	beq	$8,$24,$L1254
	addu	$25,$25,$fp

$L1215:
	sll	$6,$6,1
	addu	$4,$6,$7
	andi	$fp,$6,0xffff
	bne	$fp,$0,$L1212
	sw	$4,264($sp)

	lbu	$6,0($2)
	lbu	$fp,1($2)
	sll	$6,$6,9
	addu	$6,$4,$6
	sll	$fp,$fp,1
	addu	$6,$6,$fp
	addiu	$2,$2,2
$L1212:
	slt	$fp,$6,$15
	beq	$fp,$0,$L1213
	li	$fp,1			# 0x1

	move	$fp,$0
	sll	$25,$25,1
	addiu	$8,$8,1
	bne	$8,$24,$L1215
	addu	$25,$25,$fp

$L1254:
	addiu	$25,$25,14
$L1208:
	beq	$12,$0,$L1255
	nop

$L1216:
	sll	$6,$6,1
	andi	$8,$6,0xffff
	bne	$8,$0,$L1263
	slt	$8,$6,$15

	lbu	$24,0($2)
	lbu	$8,1($2)
	addu	$6,$6,$7
	sll	$24,$24,9
	addu	$6,$6,$24
	sll	$8,$8,1
	addu	$6,$6,$8
	addiu	$2,$2,2
	slt	$8,$6,$15
$L1263:
	bne	$8,$0,$L1221
	sll	$8,$20,2

	addu	$8,$12,$8
	lw	$8,0($8)
	subu	$25,$0,$25
	mul	$8,$25,$8
	sll	$20,$20,1
	addiu	$8,$8,32
	addu	$20,$5,$20
	srl	$8,$8,6
	sh	$8,0($20)
	subu	$6,$6,$15
	b	$L1178
	addiu	$18,$18,1

$L1170:
	move	$25,$23
	movn	$25,$21,$fp
	b	$L1171
	move	$fp,$25

$L1221:
	addu	$8,$12,$8
	lw	$8,0($8)
	sll	$20,$20,1
	mul	$25,$25,$8
	addu	$20,$5,$20
	addiu	$25,$25,32
	srl	$25,$25,6
	sh	$25,0($20)
	b	$L1178
	addiu	$18,$18,1

$L1253:
	bne	$12,$0,$L1216
	li	$25,15			# 0xf

$L1255:
	sll	$6,$6,1
	andi	$8,$6,0xffff
	bne	$8,$0,$L1264
	slt	$8,$6,$15

	lbu	$24,0($2)
	lbu	$8,1($2)
	addu	$6,$6,$7
	sll	$24,$24,9
	addu	$6,$6,$24
	sll	$8,$8,1
	addu	$6,$6,$8
	addiu	$2,$2,2
	slt	$8,$6,$15
$L1264:
	bne	$8,$0,$L1218
	nop

	sll	$20,$20,1
	addu	$20,$5,$20
	subu	$25,$0,$25
	sh	$25,0($20)
	subu	$6,$6,$15
	b	$L1178
	addiu	$18,$18,1

$L1237:
	sll	$15,$15,1
	andi	$6,$15,0xffff
	bne	$6,$0,$L1175
	nop

	lbu	$8,0($2)
	lbu	$6,1($2)
	addu	$15,$15,$7
	sll	$8,$8,9
	addu	$15,$15,$8
	sll	$6,$6,1
	addu	$15,$15,$6
	addiu	$2,$2,2
$L1175:
	sll	$6,$3,17
	subu	$15,$15,$6
	sra	$8,$15,31
	sll	$20,$20,1
	nor	$24,$0,$8
	subu	$24,$24,$8
	and	$6,$8,$6
	addu	$20,$5,$20
	sh	$24,0($20)
	b	$L1176
	addu	$6,$6,$15

$L1235:
	addu	$13,$fp,$13
	sw	$25,0($13)
	lbu	$16,0($17)
	andi	$13,$3,0xc0
	sll	$13,$13,1
	addu	$13,$13,$16
	addu	$13,$10,$13
	lbu	$15,0($13)
	addiu	$19,$19,1
	subu	$3,$3,$15
	sll	$18,$3,17
	subu	$13,$18,$8
	sra	$13,$13,31
	movn	$3,$15,$13
	addu	$15,$9,$3
	xor	$16,$13,$16
	lbu	$15,0($15)
	and	$13,$13,$18
	subu	$8,$8,$13
	sll	$8,$8,$15
	addu	$13,$11,$16
	lbu	$13,0($13)
	addiu	$18,$8,-1
	xor	$18,$18,$8
	sra	$18,$18,15
	sb	$13,0($17)
	andi	$13,$16,0x1
	andi	$16,$8,0xffff
	addu	$18,$20,$18
	bne	$16,$0,$L1160
	sll	$3,$3,$15

	lbu	$16,0($2)
	lbu	$15,1($2)
	sll	$16,$16,9
	lbu	$18,0($18)
	addu	$16,$16,$23
	sll	$15,$15,1
	addu	$15,$16,$15
	subu	$18,$22,$18
	sll	$15,$15,$18
	addu	$8,$8,$15
	addiu	$2,$2,2
$L1160:
	beq	$13,$0,$L1265
	addiu	$25,$25,1

	lw	$25,352($sp)
	mflo	$13
	bne	$25,$21,$L1163
	lw	$4,272($sp)

	b	$L1261
	sll	$15,$19,2

$L1218:
	sll	$20,$20,1
	addu	$20,$5,$20
	sh	$25,0($20)
	b	$L1178
	addiu	$18,$18,1

$L1238:
$L1181:
$L1262:
	b	$L1208
	sll	$15,$3,17

$L1239:
	b	$L1208
	sll	$15,$3,17

$L1240:
	b	$L1208
	sll	$15,$3,17

$L1241:
	b	$L1208
	sll	$15,$3,17

$L1242:
	b	$L1208
	sll	$15,$3,17

$L1243:
	b	$L1208
	sll	$15,$3,17

$L1244:
	b	$L1208
	sll	$15,$3,17

$L1245:
	b	$L1208
	sll	$15,$3,17

$L1246:
	b	$L1208
	sll	$15,$3,17

$L1247:
	b	$L1208
	sll	$15,$3,17

$L1248:
	b	$L1208
	sll	$15,$3,17

$L1249:
	b	$L1208
	sll	$15,$3,17

$L1141:
	li	$10,65536			# 0x10000
	addu	$10,$4,$10
	lw	$10,-6272($10)
	lui	$15,%hi(significant_coeff_flag_offset.17568)
	sll	$13,$10,5
	sll	$11,$10,3
	subu	$11,$13,$11
	lui	$13,%hi(last_coeff_flag_offset.17569)
	addiu	$15,$15,%lo(significant_coeff_flag_offset.17568)
	addiu	$13,$13,%lo(last_coeff_flag_offset.17569)
	addu	$13,$11,$13
	addu	$11,$11,$15
	lw	$18,20($11)
	lw	$13,20($13)
	ori	$9,$9,0x2000
	sll	$15,$10,6
	lui	$20,%hi(significant_coeff_flag_offset_8x8.17571)
	subu	$15,$15,$10
	addu	$13,$13,$9
	addu	$18,$18,$9
	lw	$11,%got(ff_h264_mlps_state)($28)
	lw	$9,%got(ff_h264_norm_shift)($28)
	addiu	$20,$20,%lo(significant_coeff_flag_offset_8x8.17571)
	addu	$13,$4,$13
	addu	$18,$4,$18
	addu	$20,$20,$15
	li	$23,-65536			# 0xffffffffffff0000
	addiu	$15,$sp,8
	lw	$10,%got(ff_h264_lps_range)($28)
	addiu	$16,$13,4
	addiu	$18,$18,4
	addiu	$11,$11,128
	ori	$23,$23,0x1
	move	$19,$0
	move	$13,$0
	move	$17,$9
	li	$22,7			# 0x7
	li	$21,63			# 0x3f
	mtlo	$4
	sw	$5,272($sp)
	sw	$6,280($sp)
	move	$fp,$15
	addu	$4,$20,$13
$L1266:
	lbu	$15,0($4)
	andi	$4,$3,0xc0
	addu	$15,$18,$15
	lbu	$24,0($15)
	sll	$4,$4,1
	addu	$4,$4,$24
	addu	$4,$10,$4
	lbu	$4,0($4)
	subu	$5,$3,$4
	sll	$25,$5,17
	subu	$3,$25,$8
	sra	$3,$3,31
	movn	$5,$4,$3
	addu	$4,$9,$5
	xor	$24,$3,$24
	lbu	$4,0($4)
	and	$3,$3,$25
	subu	$8,$8,$3
	sll	$8,$8,$4
	addiu	$25,$8,-1
	addu	$3,$11,$24
	xor	$25,$25,$8
	sra	$25,$25,15
	lbu	$3,0($3)
	addu	$6,$17,$25
	andi	$25,$8,0xffff
	sb	$3,0($15)
	andi	$24,$24,0x1
	bne	$25,$0,$L1152
	sll	$3,$5,$4

	lbu	$5,0($2)
	lbu	$4,1($2)
	sll	$5,$5,9
	lbu	$15,0($6)
	addu	$5,$5,$23
	sll	$4,$4,1
	addu	$4,$5,$4
	subu	$15,$22,$15
	sll	$4,$4,$15
	addu	$8,$8,$4
	addiu	$2,$2,2
$L1152:
	bne	$24,$0,$L1256
	lui	$15,%hi(last_coeff_flag_offset_8x8)

	addiu	$13,$13,1
$L1267:
	bne	$13,$21,$L1266
	addu	$4,$20,$13

	mflo	$4
	lw	$5,272($sp)
	lw	$6,280($sp)
	lw	$24,352($sp)
$L1155:
	addiu	$15,$24,-1
	beq	$15,$13,$L1257
	sll	$15,$19,2

$L1157:
	li	$13,131072			# 0x20000
	ori	$13,$13,0x21ae
	addu	$13,$4,$13
$L1164:
	addiu	$15,$6,-1
	sltu	$15,$15,2
	bne	$15,$0,$L1258
	li	$15,3			# 0x3

	beq	$6,$15,$L1259
	li	$15,4			# 0x4

	beq	$6,$15,$L1260
	lui	$6,%hi(scan8)

	addiu	$6,$6,%lo(scan8)
	addu	$7,$7,$6
	lbu	$6,0($7)
	sll	$7,$19,8
	addu	$7,$7,$19
	addiu	$15,$4,9080
	addu	$6,$15,$6
	andi	$7,$7,0xffff
	sh	$7,8($6)
	b	$L1165
	sh	$7,0($6)

$L1256:
	addiu	$15,$15,%lo(last_coeff_flag_offset_8x8)
	addu	$4,$15,$13
	lbu	$15,0($4)
	sll	$4,$19,2
	addu	$4,$fp,$4
	sw	$13,0($4)
	addu	$15,$16,$15
	lbu	$24,0($15)
	andi	$4,$3,0xc0
	sll	$4,$4,1
	addu	$4,$4,$24
	addu	$4,$10,$4
	lbu	$5,0($4)
	addiu	$19,$19,1
	subu	$3,$3,$5
	sll	$25,$3,17
	subu	$4,$25,$8
	sra	$4,$4,31
	movn	$3,$5,$4
	addu	$5,$9,$3
	xor	$24,$4,$24
	lbu	$5,0($5)
	and	$4,$4,$25
	subu	$8,$8,$4
	sll	$8,$8,$5
	addu	$4,$11,$24
	lbu	$4,0($4)
	addiu	$25,$8,-1
	xor	$25,$25,$8
	sra	$25,$25,15
	sb	$4,0($15)
	andi	$4,$24,0x1
	andi	$24,$8,0xffff
	addu	$25,$17,$25
	bne	$24,$0,$L1154
	sll	$3,$3,$5

	lbu	$15,0($2)
	lbu	$5,1($2)
	sll	$15,$15,9
	lbu	$24,0($25)
	addu	$15,$15,$23
	sll	$5,$5,1
	addu	$5,$15,$5
	subu	$24,$22,$24
	sll	$5,$5,$24
	addu	$8,$8,$5
	addiu	$2,$2,2
$L1154:
	beq	$4,$0,$L1267
	addiu	$13,$13,1

	addiu	$13,$13,-1
	lw	$13,352($sp)
	mflo	$4
	lw	$5,272($sp)
	lw	$6,280($sp)
	b	$L1155
	move	$24,$13

$L1236:
	sll	$15,$19,2
$L1261:
	addu	$15,$sp,$15
	sw	$25,8($15)
	b	$L1163
	addiu	$19,$19,1

$L1231:
	addiu	$5,$5,%lo(scan8)
	addu	$7,$7,$5
	lbu	$5,16($7)
	addu	$5,$4,$5
	b	$L1169
	sb	$0,9080($5)

$L1259:
	li	$6,131072			# 0x20000
	addu	$6,$4,$6
	lw	$24,268($sp)
	lw	$15,8660($6)
	sll	$6,$24,1
	addu	$6,$15,$6
	lhu	$15,0($6)
	li	$24,64			# 0x40
	sll	$7,$24,$7
	or	$7,$7,$15
	b	$L1165
	sh	$7,0($6)

$L1258:
	lui	$6,%hi(scan8)
	addiu	$6,$6,%lo(scan8)
	addu	$7,$7,$6
	lbu	$6,0($7)
	addu	$6,$4,$6
	b	$L1165
	sb	$19,9080($6)

$L1232:
	addiu	$9,$9,%lo(scan8)
	addu	$9,$7,$9
	lbu	$9,0($9)
	addu	$9,$4,$9
	lbu	$10,9072($9)
	b	$L1143
	lbu	$9,9079($9)

$L1230:
	lui	$5,%hi(scan8)
	addiu	$5,$5,%lo(scan8)
	addu	$7,$7,$5
	lbu	$5,0($7)
	addu	$5,$4,$5
	b	$L1169
	sb	$0,9080($5)

$L1233:
	lw	$11,8672($10)
	lw	$13,8668($10)
	addiu	$9,$7,6
	sra	$10,$13,$9
	sra	$9,$11,$9
	andi	$9,$9,0x1
	b	$L1143
	andi	$10,$10,0x1

$L1257:
	addu	$15,$sp,$15
	sw	$13,8($15)
	b	$L1157
	addiu	$19,$19,1

$L1260:
	addiu	$6,$6,%lo(scan8)
	addu	$7,$7,$6
	lbu	$6,16($7)
	addu	$6,$4,$6
	b	$L1165
	sb	$19,9080($6)

$L1234:
	move	$25,$0
	bne	$25,$21,$L1163
	move	$19,$0

	b	$L1261
	sll	$15,$19,2

	.set	macro
	.set	reorder
	.end	decode_cabac_residual
	.size	decode_cabac_residual, .-decode_cabac_residual
	.align	2
	.set	nomips16
	.ent	decode_scaling_list
	.type	decode_scaling_list, @function
decode_scaling_list:
	.frame	$sp,8,$31		# vars= 0, regs= 2/0, args= 0, gp= 0
	.mask	0x00030000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-8
	lui	$28,%hi(__gnu_local_gp)
	li	$3,16			# 0x10
	sw	$17,4($sp)
	sw	$16,0($sp)
	addiu	$28,$28,%lo(__gnu_local_gp)
	beq	$6,$3,$L1269
	lw	$2,24($sp)

	lw	$3,8456($4)
	lw	$9,8448($4)
	sra	$8,$3,3
	addu	$8,$9,$8
	lbu	$9,0($8)
	andi	$8,$3,0x7
	sll	$8,$9,$8
	andi	$8,$8,0x00ff
	lui	$11,%hi(zigzag_scan8x8)
	addiu	$3,$3,1
	srl	$8,$8,7
	addiu	$11,$11,%lo(zigzag_scan8x8)
	beq	$8,$0,$L1271
	sw	$3,8456($4)

$L1297:
	blez	$6,$L1298
	lw	$17,4($sp)

	lw	$14,%got(ff_log2_tab)($28)
	lw	$24,%got(ff_golomb_vlc_len)($28)
	lw	$15,%got(ff_se_golomb_vlc_code)($28)
	li	$8,8			# 0x8
	li	$3,8			# 0x8
	move	$2,$0
	li	$12,134217728			# 0x8000000
	li	$13,-65536			# 0xffffffffffff0000
$L1287:
	bne	$8,$0,$L1290
	nop

	bne	$2,$0,$L1299
	addu	$9,$11,$2

$L1293:
	beq	$8,$0,$L1291
	lw	$25,%call16(memcpy)($28)

	lbu	$9,0($11)
	addu	$9,$5,$9
$L1288:
	andi	$3,$8,0x00ff
$L1286:
	addiu	$2,$2,1
	slt	$10,$2,$6
	bne	$10,$0,$L1287
	sb	$3,0($9)

	lw	$17,4($sp)
$L1298:
	lw	$16,0($sp)
	j	$31
	addiu	$sp,$sp,8

$L1290:
	lw	$9,8456($4)
	lw	$10,8448($4)
	sra	$8,$9,3
	addu	$8,$10,$8
	lbu	$16,0($8)
	lbu	$25,1($8)
	lbu	$17,3($8)
	lbu	$10,2($8)
	sll	$16,$16,24
	or	$8,$17,$16
	sll	$25,$25,16
	sll	$10,$10,8
	or	$8,$8,$25
	or	$8,$8,$10
	andi	$10,$9,0x7
	sll	$8,$8,$10
	sltu	$10,$8,$12
	beq	$10,$0,$L1292
	nop

	and	$10,$8,$13
	bne	$10,$0,$L1277
	srl	$10,$8,16

	move	$10,$8
	andi	$16,$10,0xff00
	li	$25,8			# 0x8
	bne	$16,$0,$L1279
	move	$17,$0

$L1295:
	addu	$10,$14,$10
	lbu	$10,0($10)
	move	$25,$17
	addu	$10,$10,$25
	sll	$10,$10,1
	addiu	$10,$10,-31
	srl	$8,$8,$10
	addiu	$9,$9,32
	subu	$10,$9,$10
	andi	$25,$8,0x1
	beq	$25,$0,$L1281
	sw	$10,8456($4)

$L1296:
	srl	$8,$8,1
	subu	$8,$0,$8
	addu	$8,$8,$3
	andi	$8,$8,0xff
$L1294:
	beq	$2,$0,$L1293
	addu	$9,$11,$2

$L1299:
	lbu	$9,0($9)
	bne	$8,$0,$L1288
	addu	$9,$5,$9

	b	$L1286
	andi	$3,$3,0x00ff

$L1292:
	srl	$8,$8,23
	addu	$10,$24,$8
	addu	$8,$15,$8
	lbu	$10,0($10)
	lb	$8,0($8)
	addu	$9,$10,$9
	addu	$8,$8,$3
	sw	$9,8456($4)
	b	$L1294
	andi	$8,$8,0xff

$L1277:
	andi	$16,$10,0xff00
	li	$25,24			# 0x18
	beq	$16,$0,$L1295
	li	$17,16			# 0x10

$L1279:
	srl	$10,$10,8
	addu	$10,$14,$10
	lbu	$10,0($10)
	addiu	$9,$9,32
	addu	$10,$10,$25
	sll	$10,$10,1
	addiu	$10,$10,-31
	srl	$8,$8,$10
	andi	$25,$8,0x1
	subu	$10,$9,$10
	bne	$25,$0,$L1296
	sw	$10,8456($4)

$L1281:
	srl	$8,$8,1
	addu	$8,$8,$3
	b	$L1294
	andi	$8,$8,0xff

$L1269:
	lw	$3,8456($4)
	lw	$9,8448($4)
	sra	$8,$3,3
	addu	$8,$9,$8
	lbu	$9,0($8)
	andi	$8,$3,0x7
	sll	$8,$9,$8
	andi	$8,$8,0x00ff
	lui	$11,%hi(zigzag_scan)
	addiu	$3,$3,1
	srl	$8,$8,7
	addiu	$11,$11,%lo(zigzag_scan)
	bne	$8,$0,$L1297
	sw	$3,8456($4)

$L1271:
	lw	$25,%call16(memcpy)($28)
	move	$4,$5
	lw	$17,4($sp)
	lw	$16,0($sp)
	move	$5,$2
	jr	$25
	addiu	$sp,$sp,8

$L1291:
	move	$4,$5
	lw	$17,4($sp)
	lw	$16,0($sp)
	move	$5,$7
	jr	$25
	addiu	$sp,$sp,8

	.set	macro
	.set	reorder
	.end	decode_scaling_list
	.size	decode_scaling_list, .-decode_scaling_list
	.align	2
	.set	nomips16
	.ent	decode_scaling_matrices
	.type	decode_scaling_matrices, @function
decode_scaling_matrices:
	.frame	$sp,80,$31		# vars= 8, regs= 10/0, args= 24, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-80
	sw	$21,60($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	sw	$31,76($sp)
	sw	$fp,72($sp)
	sw	$23,68($sp)
	sw	$22,64($sp)
	sw	$20,56($sp)
	move	$18,$7
	move	$16,$4
	move	$21,$6
	lw	$17,96($sp)
	bne	$7,$0,$L1301
	lw	$19,100($sp)

	lw	$2,636($5)
	bne	$2,$0,$L1311
	addiu	$2,$5,640

$L1301:
	lw	$3,8456($16)
	lw	$6,8448($16)
	sra	$4,$3,3
	addu	$4,$6,$4
	lbu	$6,0($4)
	andi	$4,$3,0x7
	sll	$4,$6,$4
	andi	$4,$4,0x00ff
	lui	$2,%hi(default_scaling4)
	lui	$20,%hi(default_scaling4+16)
	lui	$23,%hi(default_scaling8)
	lui	$22,%hi(default_scaling8+64)
	addiu	$3,$3,1
	srl	$4,$4,7
	addiu	$2,$2,%lo(default_scaling4)
	addiu	$20,$20,%lo(default_scaling4+16)
	addiu	$23,$23,%lo(default_scaling8)
	addiu	$22,$22,%lo(default_scaling8+64)
	move	$7,$0
	bne	$4,$0,$L1312
	sw	$3,8456($16)

$L1302:
	bne	$7,$0,$L1313
	addiu	$8,$5,736

	lw	$31,76($sp)
$L1314:
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	j	$31
	addiu	$sp,$sp,80

$L1313:
	addiu	$2,$5,640
$L1305:
	lw	$7,0($2)
	lw	$6,4($2)
	lw	$4,8($2)
	lw	$3,12($2)
	swl	$7,3($17)
	swr	$7,0($17)
	swl	$6,7($17)
	swr	$6,4($17)
	swl	$4,11($17)
	swr	$4,8($17)
	swl	$3,15($17)
	addiu	$2,$2,16
	swr	$3,12($17)
	bne	$2,$8,$L1305
	addiu	$17,$17,16

	addiu	$5,$5,864
$L1306:
	lw	$7,0($2)
	lw	$6,4($2)
	lw	$4,8($2)
	lw	$3,12($2)
	swl	$7,3($19)
	swr	$7,0($19)
	swl	$6,7($19)
	swr	$6,4($19)
	swl	$4,11($19)
	swr	$4,8($19)
	swl	$3,15($19)
	addiu	$2,$2,16
	swr	$3,12($19)
	bne	$2,$5,$L1306
	addiu	$19,$19,16

	b	$L1314
	lw	$31,76($sp)

$L1311:
	lw	$3,8456($16)
	lw	$6,8448($16)
	sra	$4,$3,3
	addu	$4,$6,$4
	lbu	$6,0($4)
	andi	$4,$3,0x7
	sll	$4,$6,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,1
	srl	$4,$4,7
	addiu	$20,$5,688
	addiu	$23,$5,736
	addiu	$22,$5,800
	li	$7,1			# 0x1
	beq	$4,$0,$L1302
	sw	$3,8456($16)

$L1312:
	lw	$3,636($5)
	lui	$fp,%hi(default_scaling4)
	addiu	$fp,$fp,%lo(default_scaling4)
	or	$3,$3,$18
	sw	$3,636($5)
	move	$7,$fp
	addiu	$3,$17,16
	move	$4,$16
	move	$5,$17
	li	$6,16			# 0x10
	sw	$3,32($sp)
	.option	pic0
	jal	decode_scaling_list
	.option	pic2
	sw	$2,16($sp)

	lw	$5,32($sp)
	move	$7,$fp
	move	$4,$16
	li	$6,16			# 0x10
	.option	pic0
	jal	decode_scaling_list
	.option	pic2
	sw	$17,16($sp)

	lw	$2,32($sp)
	move	$7,$fp
	move	$4,$16
	addiu	$5,$17,32
	li	$6,16			# 0x10
	lui	$fp,%hi(default_scaling4+16)
	addiu	$fp,$fp,%lo(default_scaling4+16)
	.option	pic0
	jal	decode_scaling_list
	.option	pic2
	sw	$2,16($sp)

	addiu	$2,$17,48
	addiu	$3,$17,64
	move	$5,$2
	move	$4,$16
	li	$6,16			# 0x10
	move	$7,$fp
	sw	$3,32($sp)
	sw	$2,36($sp)
	.option	pic0
	jal	decode_scaling_list
	.option	pic2
	sw	$20,16($sp)

	lw	$2,36($sp)
	lw	$5,32($sp)
	move	$4,$16
	li	$6,16			# 0x10
	move	$7,$fp
	.option	pic0
	jal	decode_scaling_list
	.option	pic2
	sw	$2,16($sp)

	lw	$2,32($sp)
	addiu	$5,$17,80
	move	$7,$fp
	move	$4,$16
	li	$6,16			# 0x10
	.option	pic0
	jal	decode_scaling_list
	.option	pic2
	sw	$2,16($sp)

	bne	$18,$0,$L1315
	lui	$7,%hi(default_scaling8)

	lw	$2,64($21)
	beq	$2,$0,$L1314
	lw	$31,76($sp)

	lui	$7,%hi(default_scaling8)
$L1315:
	move	$4,$16
	move	$5,$19
	addiu	$7,$7,%lo(default_scaling8)
	li	$6,64			# 0x40
	.option	pic0
	jal	decode_scaling_list
	.option	pic2
	sw	$23,16($sp)

	lui	$7,%hi(default_scaling8+64)
	sw	$22,96($sp)
	move	$4,$16
	addiu	$5,$19,64
	lw	$31,76($sp)
	lw	$fp,72($sp)
	lw	$23,68($sp)
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	addiu	$7,$7,%lo(default_scaling8+64)
	li	$6,64			# 0x40
	.option	pic0
	j	decode_scaling_list
	.option	pic2
	addiu	$sp,$sp,80

	.set	macro
	.set	reorder
	.end	decode_scaling_matrices
	.size	decode_scaling_matrices, .-decode_scaling_matrices
	.section	.rodata.str1.4
	.align	2
$LC14:
	.ascii	"invalid MV vlc\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	svq3_mc_dir
	.type	svq3_mc_dir, @function
svq3_mc_dir:
	.frame	$sp,272,$31		# vars= 184, regs= 10/0, args= 40, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-272
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,268($sp)
	sw	$fp,264($sp)
	sw	$23,260($sp)
	sw	$22,256($sp)
	sw	$21,252($sp)
	sw	$20,248($sp)
	sw	$19,244($sp)
	sw	$18,240($sp)
	sw	$17,236($sp)
	sw	$16,232($sp)
	.cprestore	40
	andi	$2,$5,0x5
	li	$3,4			# 0x4
	move	$16,$4
	move	$22,$6
	beq	$2,$3,$L1473
	sw	$7,284($sp)

	andi	$2,$5,0x1
	li	$20,16			# 0x10
	sra	$20,$20,$2
$L1318:
	li	$2,-1431699456			# 0xffffffffaaaa0000
	addiu	$5,$5,1
	ori	$2,$2,0xaaab
	multu	$5,$2
	lw	$4,168($16)
	mfhi	$5
	li	$21,16			# 0x10
	srl	$5,$5,1
	sra	$21,$21,$5
	lw	$2,284($sp)
	lw	$12,164($16)
	lw	$3,284($sp)
	subu	$4,$4,$21
	sll	$10,$2,2
	sll	$15,$4,3
	sll	$9,$2,4
	subu	$5,$12,$20
	sll	$11,$4,1
	sll	$8,$3,5
	sra	$2,$20,3
	addu	$9,$10,$9
	sll	$12,$5,3
	addu	$10,$10,$3
	sll	$5,$5,1
	addiu	$3,$16,2660
	subu	$11,$15,$11
	li	$6,2			# 0x2
	lw	$15,288($sp)
	lw	$4,284($sp)
	subu	$6,$6,$2
	subu	$12,$12,$5
	addiu	$2,$16,2596
	move	$5,$3
	movz	$5,$2,$15
	lw	$15,284($sp)
	sll	$14,$4,3
	sll	$7,$4,7
	addu	$7,$8,$7
	xori	$25,$22,0x4
	addu	$8,$14,$8
	li	$24,-96			# 0xffffffffffffffa0
	sll	$14,$15,1
	sra	$15,$20,1
	movn	$24,$0,$25
	sw	$15,180($sp)
	lw	$15,288($sp)
	sw	$24,76($sp)
	addiu	$13,$6,1
	movn	$2,$3,$15
	sll	$13,$13,4
	lw	$3,76($sp)
	sra	$24,$20,2
	sw	$13,136($sp)
	sw	$2,140($sp)
	sw	$8,100($sp)
	sw	$24,132($sp)
	addiu	$8,$10,1
	addiu	$13,$16,9136
	addiu	$24,$16,648
	addiu	$10,$10,-1
	li	$2,12288			# 0x3000
	sw	$24,68($sp)
	sw	$13,72($sp)
	subu	$12,$12,$3
	subu	$11,$11,$3
	sra	$24,$21,1
	sll	$2,$2,$14
	sll	$10,$10,3
	sw	$24,104($sp)
	sw	$2,204($sp)
	lw	$24,68($sp)
	lw	$2,284($sp)
	sw	$12,156($sp)
	sw	$11,152($sp)
	sw	$10,144($sp)
	lw	$11,140($sp)
	lw	$10,72($sp)
	lw	$12,136($sp)
	sll	$9,$9,3
	addiu	$4,$4,390
	addiu	$13,$16,240
	addiu	$9,$9,40
	sll	$4,$4,2
	sll	$6,$6,4
	movz	$24,$13,$2
	addu	$7,$16,$7
	addu	$6,$11,$6
	addu	$5,$5,$12
	addu	$4,$16,$4
	addu	$9,$10,$9
	sll	$8,$8,3
	sw	$24,68($sp)
	sw	$7,200($sp)
	sw	$6,124($sp)
	sw	$5,148($sp)
	sw	$9,176($sp)
	sw	$8,188($sp)
	sw	$4,120($sp)
	lw	$24,180($sp)
	lw	$2,104($sp)
	lw	$3,100($sp)
	lw	$4,100($sp)
	lw	$6,132($sp)
	lw	$7,100($sp)
	addiu	$13,$16,2904
	addiu	$15,$16,2860
	addiu	$24,$24,1
	addiu	$2,$2,1
	addiu	$3,$3,9
	addiu	$4,$4,1
	sra	$5,$21,2
	sll	$6,$6,2
	addu	$7,$16,$7
	sw	$13,172($sp)
	sw	$15,168($sp)
	sw	$24,164($sp)
	sw	$2,160($sp)
	sw	$3,208($sp)
	sw	$4,184($sp)
	sw	$5,128($sp)
	sw	$6,84($sp)
	sw	$0,96($sp)
	sw	$7,92($sp)
$L1321:
	lw	$10,96($sp)
	lw	$11,284($sp)
	sra	$5,$10,1
	andi	$4,$10,0x8
	andi	$5,$5,0x2
	addu	$5,$5,$4
	addiu	$3,$11,24
	addiu	$2,$11,46
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	sll	$3,$3,2
	sll	$2,$2,2
	sra	$12,$10,2
	sw	$5,112($sp)
	sw	$4,88($sp)
	sw	$3,192($sp)
	sw	$2,196($sp)
	sw	$12,116($sp)
	move	$17,$0
$L1447:
	lw	$18,6172($16)
	lw	$8,116($sp)
	sll	$4,$18,2
	lw	$6,9748($16)
	addu	$4,$8,$4
	mul	$7,$4,$6
	lw	$19,6168($16)
	sra	$2,$17,2
	sll	$3,$19,2
	sra	$5,$17,1
	addu	$4,$7,$3
	andi	$6,$2,0x1
	andi	$3,$5,0x4
	lw	$9,112($sp)
	addu	$3,$6,$3
	lw	$8,96($sp)
	addu	$4,$4,$2
	sll	$19,$19,4
	sll	$18,$18,4
	addu	$3,$3,$9
	li	$2,4			# 0x4
	sw	$4,64($sp)
	addu	$19,$17,$19
	addu	$18,$8,$18
	beq	$22,$2,$L1322
	sw	$3,80($sp)

	lui	$10,%hi(scan8)
	addiu	$10,$10,%lo(scan8)
	addu	$2,$3,$10
	lbu	$2,0($2)
	lw	$12,100($sp)
	lw	$11,88($sp)
	lw	$13,132($sp)
	lw	$15,144($sp)
	lw	$24,92($sp)
	addiu	$8,$2,-8
	addu	$7,$2,$12
	addu	$6,$8,$13
	lw	$10,-6276($11)
	addiu	$4,$7,-1
	lw	$11,72($sp)
	addu	$5,$2,$15
	sll	$4,$4,2
	sll	$5,$5,2
	addu	$8,$24,$8
	addu	$9,$24,$2
	addu	$3,$24,$6
	lb	$8,9456($8)
	lb	$9,9455($9)
	addu	$4,$11,$4
	addu	$5,$11,$5
	beq	$10,$0,$L1323
	lb	$3,9456($3)

	lw	$12,176($sp)
	lw	$13,88($sp)
	sw	$0,0($12)
	lw	$10,1880($16)
	lw	$11,-6272($13)
	bne	$11,$0,$L1324
	lw	$14,104($10)

	lw	$12,6172($16)
	andi	$13,$12,0x1
	beq	$13,$0,$L1324
	slt	$13,$2,20

	beq	$13,$0,$L1324
	li	$13,-2			# 0xfffffffffffffffe

	beq	$3,$13,$L1325
	nop

	lw	$13,152($16)
	addiu	$7,$12,-1
	mul	$24,$7,$13
	lw	$11,6168($16)
	xori	$7,$2,0xf
	addu	$15,$24,$11
	sltu	$7,$7,1
	addu	$7,$15,$7
	sll	$7,$7,2
	addu	$7,$14,$7
	lw	$7,0($7)
	andi	$7,$7,0x80
	bne	$7,$0,$L1474
	andi	$2,$2,0x7

$L1326:
	lw	$7,100($sp)
	lw	$10,72($sp)
	addu	$6,$6,$7
	sll	$6,$6,2
	xori	$2,$3,0x1
	addu	$6,$10,$6
	sltu	$2,$2,1
$L1329:
	xori	$10,$9,0x1
	xori	$7,$8,0x1
	sltu	$10,$10,1
	sltu	$7,$7,1
	addu	$7,$10,$7
	addu	$2,$7,$2
	slt	$7,$2,2
	bne	$7,$0,$L1499
	li	$7,1			# 0x1

$L1343:
	lh	$3,0($4)
	lh	$2,0($5)
	slt	$8,$2,$3
	beq	$8,$0,$L1344
	lh	$7,0($6)

	slt	$8,$2,$7
	beq	$8,$0,$L1345
	nop

	slt	$2,$3,$7
	movz	$3,$7,$2
	move	$2,$3
$L1345:
	lh	$3,2($5)
	lh	$4,2($4)
	lh	$5,2($6)
	slt	$6,$3,$4
	beq	$6,$0,$L1346
	slt	$6,$5,$3

	slt	$6,$3,$5
	beq	$6,$0,$L1339
	nop

	slt	$3,$4,$5
	movz	$4,$5,$3
	move	$3,$4
$L1339:
	sll	$5,$19,1
	lw	$6,76($sp)
	sll	$4,$19,3
	subu	$4,$5,$4
	addu	$5,$4,$6
	slt	$6,$2,$5
	bne	$6,$0,$L1348
	lw	$7,156($sp)

	addu	$4,$4,$7
	slt	$5,$4,$2
	movz	$4,$2,$5
	move	$5,$4
$L1348:
	sll	$2,$18,3
	sll	$4,$18,1
	lw	$8,76($sp)
	subu	$4,$4,$2
	addu	$2,$4,$8
	slt	$6,$3,$2
	bne	$6,$0,$L1349
	lw	$9,152($sp)

	addu	$4,$4,$9
	slt	$2,$4,$3
	movz	$4,$3,$2
	move	$2,$4
$L1349:
	li	$3,4			# 0x4
	beq	$22,$3,$L1350
	move	$3,$0

	lw	$4,8456($16)
	lw	$6,8448($16)
	sra	$7,$4,3
	addu	$7,$6,$7
	lbu	$10,0($7)
	lbu	$11,3($7)
	lbu	$9,1($7)
	sll	$10,$10,24
	lbu	$7,2($7)
	or	$10,$11,$10
	sll	$9,$9,16
	sll	$8,$7,8
	or	$10,$10,$9
	or	$8,$10,$8
	andi	$13,$4,0x7
	sll	$8,$8,$13
	li	$7,-1434451968			# 0xffffffffaa800000
	and	$3,$8,$7
	beq	$3,$0,$L1351
	lw	$3,%got(ff_interleaved_golomb_vlc_len)($28)

	srl	$8,$8,24
	addu	$3,$3,$8
	lbu	$3,0($3)
	addu	$4,$4,$3
	sra	$3,$4,3
	sw	$4,8456($16)
	addu	$3,$6,$3
	lbu	$11,0($3)
	lbu	$9,1($3)
	lbu	$10,3($3)
	sll	$11,$11,24
	lbu	$3,2($3)
	sll	$9,$9,16
	or	$11,$10,$11
	or	$11,$11,$9
	sll	$3,$3,8
	lw	$9,%got(ff_interleaved_se_golomb_vlc_code)($28)
	or	$3,$11,$3
	andi	$12,$4,0x7
	addu	$9,$9,$8
	sll	$8,$3,$12
	and	$7,$8,$7
	beq	$7,$0,$L1475
	lb	$3,0($9)

$L1454:
	lw	$6,%got(ff_interleaved_golomb_vlc_len)($28)
	srl	$8,$8,24
	addu	$6,$6,$8
	lbu	$6,0($6)
	lw	$12,%got(ff_interleaved_se_golomb_vlc_code)($28)
	addu	$4,$6,$4
	addu	$8,$12,$8
	sw	$4,8456($16)
	lb	$4,0($8)
$L1358:
	li	$6,-2147483648			# 0xffffffff80000000
	beq	$3,$6,$L1359
	li	$6,3			# 0x3

	beq	$22,$6,$L1476
	li	$6,2			# 0x2

	beq	$22,$6,$L1391
	li	$6,-1431699456			# 0xffffffffaaaa0000

	ori	$6,$6,0xaaab
	addiu	$5,$5,24579
	multu	$5,$6
	addiu	$2,$2,24579
	mfhi	$5
	multu	$2,$6
	srl	$5,$5,2
	mfhi	$6
	addiu	$5,$5,-4096
	srl	$6,$6,2
	addu	$5,$5,$4
	addiu	$6,$6,-4096
	addu	$6,$6,$3
	addu	$fp,$5,$19
	sw	$5,52($sp)
	sw	$6,48($sp)
	bltz	$fp,$L1477
	addu	$23,$6,$18

	lw	$6,164($16)
	addiu	$2,$6,-1
	subu	$2,$2,$20
	slt	$2,$fp,$2
	beq	$2,$0,$L1462
	nop

	bltz	$23,$L1462
	nop

	lw	$7,168($16)
	addiu	$2,$7,-1
	subu	$2,$2,$21
	slt	$2,$23,$2
	beq	$2,$0,$L1422
	lw	$10,68($sp)

	lw	$2,176($16)
	mul	$3,$23,$2
	lw	$4,0($10)
	addu	$5,$3,$fp
	lw	$3,1464($16)
	addu	$5,$4,$5
	move	$6,$2
	sw	$0,56($sp)
$L1424:
	mul	$4,$18,$2
	lw	$7,124($sp)
	addu	$2,$4,$19
	lw	$25,0($7)
	addu	$4,$3,$2
	jalr	$25
	move	$7,$21

	lw	$2,56($16)
	andi	$2,$2,0x2000
	bne	$2,$0,$L1430
	lw	$28,40($sp)

	slt	$2,$23,$18
	addu	$2,$2,$23
	lw	$23,180($16)
	sra	$2,$2,1
	mul	$4,$2,$23
	slt	$3,$fp,$19
	lw	$6,68($sp)
	addu	$fp,$3,$fp
	sra	$fp,$fp,1
	lw	$5,4($6)
	lw	$7,56($sp)
	sra	$19,$19,1
	addu	$3,$4,$fp
	sw	$19,60($sp)
	addu	$5,$5,$3
	sra	$19,$18,1
	bne	$7,$0,$L1431
	lw	$18,1468($16)

	move	$6,$23
$L1432:
	mul	$7,$19,$23
	lw	$3,60($sp)
	lw	$8,140($sp)
	lw	$9,136($sp)
	addu	$4,$7,$3
	addu	$3,$8,$9
	lw	$25,0($3)
	lw	$7,104($sp)
	addu	$4,$18,$4
	jalr	$25
	sw	$2,224($sp)

	lw	$18,180($16)
	lw	$2,224($sp)
	lw	$10,68($sp)
	mul	$4,$2,$18
	lw	$5,8($10)
	lw	$6,56($sp)
	addu	$3,$4,$fp
	lw	$28,40($sp)
	lw	$23,1472($16)
	bne	$6,$0,$L1435
	addu	$5,$5,$3

	move	$6,$18
$L1436:
	mul	$3,$19,$18
	lw	$4,148($sp)
	lw	$2,60($sp)
	lw	$25,0($4)
	addu	$18,$3,$2
	lw	$7,104($sp)
	jalr	$25
	addu	$4,$23,$18

	lw	$28,40($sp)
$L1430:
	lw	$5,52($sp)
	lw	$6,48($sp)
	sll	$3,$5,3
	sll	$2,$6,3
	sll	$5,$5,1
	sll	$4,$6,1
	subu	$3,$3,$5
	subu	$2,$2,$4
$L1389:
	andi	$3,$3,0xffff
	sll	$2,$2,16
	addu	$2,$2,$3
	li	$3,8			# 0x8
	beq	$21,$3,$L1478
	nop

$L1501:
	beq	$20,$3,$L1441
	slt	$3,$17,8

$L1440:
	li	$3,4			# 0x4
	beq	$20,$3,$L1443
	nop

$L1442:
	li	$3,4			# 0x4
$L1502:
	beq	$21,$3,$L1443
	nop

$L1417:
	lw	$9,120($sp)
	lw	$10,64($sp)
	lw	$3,0($9)
	lw	$4,9748($16)
	lw	$11,84($sp)
	sll	$5,$10,2
	li	$6,4			# 0x4
	addu	$3,$3,$5
	beq	$11,$6,$L1480
	sll	$5,$4,2

$L1444:
	li	$6,8			# 0x8
	beq	$11,$6,$L1481
	li	$6,16			# 0x10

	beq	$11,$6,$L1482
	nop

$L1445:
	addu	$17,$17,$20
	slt	$2,$17,16
	bne	$2,$0,$L1447
	lw	$9,96($sp)

	addu	$9,$9,$21
	slt	$2,$9,16
	bne	$2,$0,$L1321
	sw	$9,96($sp)

	b	$L1364
	move	$2,$0

$L1350:
	move	$4,$0
$L1391:
	li	$6,-1431699456			# 0xffffffffaaaa0000
	ori	$6,$6,0xaaab
	addiu	$2,$2,12289
	multu	$2,$6
	addiu	$5,$5,12289
	mfhi	$2
	multu	$5,$6
	srl	$2,$2,1
	mfhi	$5
	addiu	$2,$2,-4096
	addu	$2,$2,$3
	srl	$5,$5,1
	sw	$2,48($sp)
	addiu	$5,$5,-4096
	addu	$5,$5,$4
	lw	$4,48($sp)
	andi	$3,$2,0x1
	sra	$fp,$5,1
	sll	$3,$3,1
	andi	$2,$5,0x1
	sra	$23,$4,1
	addu	$fp,$fp,$19
	sw	$5,52($sp)
	addu	$3,$3,$2
	bltz	$fp,$L1483
	addu	$23,$23,$18

	lw	$4,164($16)
	addiu	$2,$4,-1
	subu	$2,$2,$20
	slt	$2,$fp,$2
	beq	$2,$0,$L1461
	nop

	bltz	$23,$L1461
	nop

	lw	$6,168($16)
	addiu	$2,$6,-1
	subu	$2,$2,$21
	slt	$2,$23,$2
	beq	$2,$0,$L1400
	lw	$5,68($sp)

	lw	$2,176($16)
	mul	$6,$23,$2
	lw	$4,0($5)
	lw	$8,1464($16)
	addu	$5,$6,$fp
	addu	$5,$4,$5
	move	$6,$2
	sw	$0,60($sp)
$L1402:
	sll	$3,$3,2
	sw	$3,56($sp)
	mul	$3,$18,$2
	lw	$4,124($sp)
	lw	$7,56($sp)
	addu	$2,$3,$19
	addu	$3,$4,$7
	lw	$25,0($3)
	addu	$4,$8,$2
	jalr	$25
	move	$7,$21

	lw	$2,56($16)
	andi	$2,$2,0x2000
	bne	$2,$0,$L1408
	lw	$28,40($sp)

	slt	$2,$23,$18
	addu	$2,$2,$23
	lw	$23,180($16)
	sra	$2,$2,1
	mul	$4,$2,$23
	slt	$3,$fp,$19
	lw	$6,68($sp)
	addu	$fp,$3,$fp
	sra	$fp,$fp,1
	lw	$5,4($6)
	lw	$7,60($sp)
	sra	$19,$19,1
	addu	$3,$4,$fp
	sw	$19,108($sp)
	addu	$5,$5,$3
	sra	$19,$18,1
	bne	$7,$0,$L1409
	lw	$18,1468($16)

	move	$6,$23
$L1410:
	lw	$9,140($sp)
	mul	$8,$19,$23
	lw	$10,136($sp)
	lw	$11,56($sp)
	addu	$3,$9,$10
	lw	$7,108($sp)
	addu	$3,$3,$11
	addu	$4,$8,$7
	lw	$25,0($3)
	lw	$7,104($sp)
	addu	$4,$18,$4
	jalr	$25
	sw	$2,224($sp)

	lw	$18,180($16)
	lw	$2,224($sp)
	lw	$9,68($sp)
	mul	$4,$2,$18
	lw	$5,8($9)
	lw	$6,60($sp)
	addu	$3,$4,$fp
	lw	$28,40($sp)
	lw	$23,1472($16)
	bne	$6,$0,$L1413
	addu	$5,$5,$3

	move	$6,$18
$L1414:
	mul	$3,$19,$18
	lw	$2,108($sp)
	lw	$4,148($sp)
	lw	$7,56($sp)
	addu	$18,$3,$2
	addu	$2,$4,$7
	lw	$25,0($2)
	lw	$7,104($sp)
	jalr	$25
	addu	$4,$23,$18

	lw	$28,40($sp)
$L1408:
	lw	$8,52($sp)
	lw	$9,48($sp)
	sll	$4,$8,1
	sll	$5,$9,1
	addu	$4,$4,$8
	addu	$5,$5,$9
	li	$6,4			# 0x4
	move	$3,$4
	bne	$22,$6,$L1389
	move	$2,$5

	lw	$9,120($sp)
	lw	$10,64($sp)
	sll	$5,$5,16
	andi	$2,$4,0xffff
	lw	$3,0($9)
	lw	$4,9748($16)
	lw	$11,84($sp)
	addu	$2,$5,$2
	li	$6,4			# 0x4
	sll	$5,$10,2
	addu	$3,$3,$5
	bne	$11,$6,$L1444
	sll	$5,$4,2

$L1480:
	lw	$12,128($sp)
	li	$6,1			# 0x1
	beq	$12,$6,$L1445
	sw	$2,0($3)

	addu	$6,$3,$5
	sw	$2,0($6)
	li	$6,2			# 0x2
	beq	$12,$6,$L1445
	nop

	sll	$4,$4,3
	addu	$5,$4,$5
	addu	$5,$3,$5
	addu	$4,$3,$4
	sw	$2,0($4)
	b	$L1445
	sw	$2,0($5)

$L1322:
	lw	$3,744($16)
	sll	$2,$4,2
	addu	$2,$3,$2
	lh	$3,2($2)
	lh	$6,0($2)
	lw	$15,284($sp)
	sll	$3,$3,1
	bne	$15,$0,$L1347
	sll	$6,$6,1

	lw	$24,88($sp)
	lw	$2,-6216($24)
	lw	$5,-6212($24)
	mul	$3,$3,$2
	mul	$2,$6,$2
	div	$0,$3,$5
	teq	$5,$0,7
	mflo	$3
	div	$0,$2,$5
	teq	$5,$0,7
	mflo	$2
$L1496:
	addiu	$3,$3,1
	addiu	$2,$2,1
	sra	$3,$3,1
	b	$L1339
	sra	$2,$2,1

$L1443:
	lw	$5,80($sp)
	lui	$6,%hi(scan8)
	addiu	$6,$6,%lo(scan8)
	addu	$3,$5,$6
	lbu	$3,0($3)
	lw	$7,100($sp)
	lw	$8,72($sp)
	addu	$3,$3,$7
	sll	$3,$3,2
	addu	$3,$8,$3
	b	$L1417
	sw	$2,0($3)

$L1461:
	lw	$6,168($16)
$L1400:
	lw	$2,56($16)
	srl	$2,$2,14
	andi	$2,$2,0x1
	sw	$2,60($sp)
$L1397:
	subu	$2,$4,$20
	addiu	$2,$2,15
	slt	$5,$2,$fp
	movn	$fp,$2,$5
	move	$5,$fp
$L1398:
	slt	$2,$23,-16
	beq	$2,$0,$L1403
	subu	$2,$6,$21

	lw	$8,68($sp)
	lw	$2,176($16)
	li	$23,-16			# 0xfffffffffffffff0
	lw	$7,0($8)
	mul	$8,$23,$2
	lw	$9,60($sp)
	addu	$5,$8,$5
	addu	$5,$7,$5
	bne	$9,$0,$L1405
	lw	$8,1464($16)

$L1486:
	b	$L1402
	move	$6,$2

$L1323:
	li	$10,-2			# 0xfffffffffffffffe
	bne	$3,$10,$L1326
	nop

$L1331:
	lw	$11,92($sp)
$L1500:
	addiu	$6,$7,-9
$L1505:
	addu	$2,$11,$2
	lb	$3,9447($2)
	xori	$10,$9,0x1
	xori	$7,$8,0x1
	xori	$2,$3,0x1
	sltu	$10,$10,1
	sltu	$7,$7,1
	addu	$7,$10,$7
	sltu	$2,$2,1
	lw	$12,72($sp)
	addu	$2,$7,$2
	sll	$6,$6,2
	slt	$7,$2,2
	beq	$7,$0,$L1343
	addu	$6,$12,$6

	li	$7,1			# 0x1
$L1499:
	beq	$2,$7,$L1484
	nop

	li	$2,-2			# 0xfffffffffffffffe
	bne	$8,$2,$L1343
	nop

	bne	$3,$8,$L1343
	nop

	beq	$9,$3,$L1343
	nop

$L1459:
	lh	$3,2($4)
	b	$L1339
	lh	$2,0($4)

$L1347:
	lw	$2,88($sp)
	lw	$4,-6212($2)
	lw	$2,-6216($2)
	subu	$2,$2,$4
	mul	$3,$3,$2
	mul	$2,$6,$2
	div	$0,$3,$4
	teq	$4,$0,7
	mflo	$3
	div	$0,$2,$4
	teq	$4,$0,7
	b	$L1496
	mflo	$2

$L1346:
	beq	$6,$0,$L1339
	nop

	slt	$3,$5,$4
	movz	$4,$5,$3
	b	$L1339
	move	$3,$4

$L1344:
	slt	$8,$7,$2
	beq	$8,$0,$L1345
	nop

	slt	$2,$7,$3
	movz	$3,$7,$2
	b	$L1345
	move	$2,$3

$L1324:
	li	$12,-2			# 0xfffffffffffffffe
	bne	$3,$12,$L1326
	nop

	lw	$12,6172($16)
	andi	$6,$12,0x1
	bne	$6,$0,$L1325
	slt	$3,$2,20

	bne	$3,$0,$L1331
	nop

$L1330:
	andi	$13,$2,0x7
	li	$3,4			# 0x4
	bne	$13,$3,$L1331
	lw	$13,92($sp)

	lb	$3,9467($13)
	li	$13,-2			# 0xfffffffffffffffe
	beq	$3,$13,$L1331
	nop

	bne	$11,$0,$L1332
	nop

	lw	$3,8768($16)
	sll	$3,$3,2
	addu	$3,$14,$3
	lw	$3,0($3)
	andi	$3,$3,0x80
	beq	$3,$0,$L1500
	lw	$11,92($sp)

	ori	$12,$12,0x1
	sll	$12,$12,1
	addu	$6,$12,$6
	sra	$2,$2,4
	addiu	$2,$2,-1
	sll	$6,$6,1
	addu	$6,$2,$6
	lw	$11,152($16)
	sra	$7,$6,2
	lw	$3,6168($16)
	mul	$12,$7,$11
	sll	$3,$3,2
	addiu	$3,$3,-1
	sra	$2,$3,2
	addu	$2,$12,$2
	sll	$2,$2,2
	addu	$2,$14,$2
	lw	$7,0($2)
	lw	$13,204($sp)
	and	$2,$13,$7
	beq	$2,$0,$L1485
	nop

	lw	$7,9748($16)
$L1497:
	lw	$15,192($sp)
	mul	$11,$6,$7
	addu	$2,$10,$15
	addu	$7,$11,$3
	lw	$11,0($2)
	sll	$2,$7,2
	addu	$2,$11,$2
	lhu	$7,0($2)
	lw	$13,200($sp)
	lw	$12,196($sp)
	sh	$7,9176($13)
	addu	$10,$10,$12
	lw	$11,9752($16)
	lw	$7,4($10)
	lhu	$10,2($2)
	sra	$2,$6,1
	mul	$6,$2,$11
	sll	$10,$10,1
	addu	$7,$6,$7
	sra	$2,$3,1
	addu	$2,$7,$2
	sh	$10,9178($13)
	lb	$3,0($2)
	lw	$6,176($sp)
	sra	$3,$3,1
	xori	$2,$3,0x1
	b	$L1329
	sltu	$2,$2,1

$L1462:
	lw	$7,168($16)
$L1422:
	lw	$2,56($16)
	srl	$2,$2,14
	andi	$2,$2,0x1
	sw	$2,56($sp)
$L1419:
	subu	$2,$6,$20
	addiu	$2,$2,15
	slt	$3,$2,$fp
	movn	$fp,$2,$3
	move	$5,$fp
$L1420:
	slt	$2,$23,-16
	beq	$2,$0,$L1425
	subu	$2,$7,$21

	lw	$2,176($16)
	li	$23,-16			# 0xfffffffffffffff0
	mul	$3,$23,$2
	lw	$8,68($sp)
	addu	$5,$3,$5
	lw	$4,0($8)
	addu	$5,$4,$5
	lw	$4,56($sp)
	bne	$4,$0,$L1427
	lw	$3,1464($16)

$L1488:
	b	$L1424
	move	$6,$2

$L1403:
	addiu	$2,$2,15
	slt	$7,$2,$23
	movn	$23,$2,$7
	lw	$8,68($sp)
	lw	$2,176($16)
	lw	$7,0($8)
	mul	$8,$23,$2
	lw	$9,60($sp)
	addu	$5,$8,$5
	addu	$5,$7,$5
	beq	$9,$0,$L1486
	lw	$8,1464($16)

$L1405:
	lw	$9,2040($16)
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	addiu	$7,$21,1
	sw	$7,16($sp)
	sw	$4,28($sp)
	sw	$6,32($sp)
	sw	$2,224($sp)
	move	$6,$2
	sw	$3,220($sp)
	sw	$8,216($sp)
	sw	$fp,20($sp)
	sw	$23,24($sp)
	move	$4,$9
	jalr	$25
	addiu	$7,$20,1

	lw	$5,2040($16)
	lw	$6,176($16)
	lw	$8,216($sp)
	lw	$3,220($sp)
	b	$L1402
	lw	$2,224($sp)

$L1478:
	lw	$7,96($sp)
	slt	$3,$7,8
	beq	$3,$0,$L1501
	li	$3,8			# 0x8

	lw	$8,80($sp)
	lui	$9,%hi(scan8)
	addiu	$9,$9,%lo(scan8)
	addu	$3,$8,$9
	lbu	$4,0($3)
	lw	$10,188($sp)
	lw	$11,72($sp)
	addu	$3,$4,$10
	sll	$3,$3,2
	addu	$3,$11,$3
	bne	$20,$21,$L1440
	sw	$2,0($3)

	slt	$3,$17,8
	bne	$3,$0,$L1487
	lw	$12,208($sp)

$L1441:
	beq	$3,$0,$L1502
	li	$3,4			# 0x4

	lw	$13,80($sp)
	lui	$15,%hi(scan8)
	addiu	$15,$15,%lo(scan8)
	addu	$3,$13,$15
	lbu	$3,0($3)
	lw	$24,184($sp)
	lw	$4,72($sp)
	addu	$3,$3,$24
	sll	$3,$3,2
	addu	$3,$4,$3
	b	$L1442
	sw	$2,0($3)

$L1425:
	addiu	$2,$2,15
	slt	$3,$2,$23
	movn	$23,$2,$3
	lw	$2,176($16)
	lw	$8,68($sp)
	mul	$3,$23,$2
	lw	$4,0($8)
	addu	$5,$3,$5
	addu	$5,$4,$5
	lw	$4,56($sp)
	beq	$4,$0,$L1488
	lw	$3,1464($16)

$L1427:
	lw	$4,2040($16)
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	addiu	$8,$21,1
	sw	$6,28($sp)
	sw	$7,32($sp)
	move	$6,$2
	sw	$2,224($sp)
	sw	$3,220($sp)
	sw	$8,16($sp)
	sw	$fp,20($sp)
	sw	$23,24($sp)
	jalr	$25
	addiu	$7,$20,1

	lw	$5,2040($16)
	lw	$6,176($16)
	lw	$3,220($sp)
	b	$L1424
	lw	$2,224($sp)

$L1481:
	lw	$15,128($sp)
	li	$6,1			# 0x1
	sw	$2,0($3)
	beq	$15,$6,$L1445
	sw	$2,4($3)

	addu	$6,$3,$5
	sw	$2,4($6)
	sw	$2,0($6)
	li	$6,2			# 0x2
	beq	$15,$6,$L1445
	nop

	sll	$4,$4,3
	addiu	$6,$5,2
	sll	$6,$6,1
	addu	$5,$4,$5
	addu	$5,$3,$5
	addu	$6,$3,$6
	addu	$4,$3,$4
	sw	$2,0($4)
	sw	$2,0($6)
	sw	$2,4($5)
	b	$L1445
	sw	$2,0($5)

$L1476:
	addiu	$2,$2,1
	addiu	$5,$5,1
	sra	$2,$2,1
	addu	$2,$3,$2
	sra	$5,$5,1
	addu	$5,$4,$5
	sw	$2,48($sp)
	li	$3,-1431699456			# 0xffffffffaaaa0000
	ori	$3,$3,0xaaab
	addiu	$2,$5,12288
	sw	$5,52($sp)
	lw	$5,48($sp)
	multu	$2,$3
	addiu	$4,$5,12288
	mfhi	$2
	multu	$4,$3
	srl	$2,$2,1
	mfhi	$3
	addiu	$2,$2,-4096
	srl	$3,$3,1
	addiu	$3,$3,-4096
	addu	$fp,$2,$19
	bltz	$fp,$L1489
	addu	$23,$3,$18

	lw	$4,164($16)
	addiu	$5,$4,-1
	subu	$5,$5,$20
	slt	$5,$fp,$5
	beq	$5,$0,$L1460
	nop

	bltz	$23,$L1460
	nop

	lw	$6,168($16)
	addiu	$5,$6,-1
	subu	$5,$5,$21
	slt	$5,$23,$5
	beq	$5,$0,$L1372
	lw	$5,68($sp)

	lw	$8,176($16)
	mul	$6,$23,$8
	lw	$4,0($5)
	lw	$10,1464($16)
	addu	$5,$6,$fp
	addu	$5,$4,$5
	move	$6,$8
	sw	$0,60($sp)
$L1374:
	sll	$4,$3,1
	lw	$12,48($sp)
	addu	$3,$4,$3
	subu	$3,$12,$3
	lw	$13,52($sp)
	sll	$4,$2,1
	sll	$3,$3,2
	addu	$3,$13,$3
	addu	$2,$4,$2
	subu	$2,$3,$2
	sll	$2,$2,2
	sw	$2,56($sp)
	lw	$15,288($sp)
	lw	$2,168($sp)
	lw	$24,172($sp)
	lw	$3,56($sp)
	movn	$2,$24,$15
	addu	$2,$2,$3
	mul	$3,$18,$8
	sw	$21,16($sp)
	addu	$4,$3,$19
	lw	$25,0($2)
	addu	$4,$10,$4
	jalr	$25
	move	$7,$20

	lw	$2,56($16)
	andi	$2,$2,0x2000
	bne	$2,$0,$L1380
	lw	$28,40($sp)

	slt	$2,$23,$18
	addu	$2,$2,$23
	lw	$23,180($16)
	slt	$3,$fp,$19
	sra	$2,$2,1
	addu	$fp,$3,$fp
	mul	$3,$2,$23
	lw	$4,68($sp)
	sra	$fp,$fp,1
	addu	$5,$3,$fp
	lw	$6,60($sp)
	lw	$3,4($4)
	sra	$19,$19,1
	sw	$19,108($sp)
	addu	$5,$3,$5
	sra	$19,$18,1
	bne	$6,$0,$L1381
	lw	$18,1468($16)

	move	$6,$23
$L1382:
	lw	$8,288($sp)
	lw	$9,172($sp)
	lw	$3,168($sp)
	lw	$10,56($sp)
	movn	$3,$9,$8
	mul	$8,$19,$23
	lw	$11,104($sp)
	lw	$7,108($sp)
	addu	$3,$3,$10
	sw	$11,16($sp)
	addu	$4,$8,$7
	lw	$25,0($3)
	lw	$7,180($sp)
	addu	$4,$18,$4
	jalr	$25
	sw	$2,224($sp)

	lw	$18,180($16)
	lw	$2,224($sp)
	lw	$9,68($sp)
	mul	$4,$2,$18
	lw	$3,8($9)
	lw	$6,60($sp)
	addu	$5,$4,$fp
	lw	$28,40($sp)
	lw	$23,1472($16)
	bne	$6,$0,$L1385
	addu	$5,$3,$5

	move	$6,$18
$L1386:
	lw	$8,288($sp)
	lw	$2,172($sp)
	lw	$9,168($sp)
	mul	$4,$19,$18
	movz	$2,$9,$8
	lw	$7,56($sp)
	lw	$8,104($sp)
	lw	$3,108($sp)
	addu	$2,$2,$7
	sw	$8,16($sp)
	addu	$18,$4,$3
	lw	$25,0($2)
	lw	$7,180($sp)
	jalr	$25
	addu	$4,$23,$18

	lw	$28,40($sp)
$L1380:
	lw	$9,52($sp)
	lw	$10,48($sp)
	sll	$3,$9,1
	b	$L1389
	sll	$2,$10,1

$L1483:
	lw	$4,56($16)
	slt	$2,$fp,-16
	srl	$4,$4,14
	andi	$4,$4,0x1
	sw	$4,60($sp)
	lw	$6,168($16)
	beq	$2,$0,$L1397
	lw	$4,164($16)

	li	$5,-16			# 0xfffffffffffffff0
	b	$L1398
	li	$fp,-16			# 0xfffffffffffffff0

$L1482:
	addiu	$7,$5,4
	addu	$6,$3,$5
	addu	$8,$3,$7
	sw	$2,0($3)
	sw	$2,4($3)
	sw	$2,8($3)
	sw	$2,12($3)
	sw	$2,0($6)
	sw	$2,0($8)
	lw	$8,128($sp)
	sw	$2,12($6)
	sw	$2,8($6)
	li	$6,2			# 0x2
	beq	$8,$6,$L1445
	nop

	sll	$4,$4,3
	addiu	$8,$5,2
	addiu	$6,$5,6
	sll	$8,$8,1
	addu	$5,$4,$5
	sll	$7,$7,1
	sll	$6,$6,1
	addu	$5,$3,$5
	addu	$8,$3,$8
	addu	$7,$3,$7
	addu	$6,$3,$6
	addu	$4,$3,$4
	sw	$2,0($4)
	sw	$2,0($8)
	sw	$2,0($7)
	sw	$2,0($6)
	sw	$2,12($5)
	sw	$2,0($5)
	sw	$2,4($5)
	b	$L1445
	sw	$2,8($5)

$L1477:
	lw	$3,56($16)
	slt	$2,$fp,-16
	srl	$3,$3,14
	andi	$3,$3,0x1
	sw	$3,56($sp)
	lw	$6,164($16)
	beq	$2,$0,$L1419
	lw	$7,168($16)

	li	$5,-16			# 0xfffffffffffffff0
	b	$L1420
	li	$fp,-16			# 0xfffffffffffffff0

$L1413:
	lw	$3,164($16)
	lw	$6,168($16)
	lw	$7,160($sp)
	lw	$4,2040($16)
	sra	$3,$3,1
	sra	$6,$6,1
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	sw	$7,16($sp)
	lw	$7,164($sp)
	sw	$6,32($sp)
	sw	$fp,20($sp)
	move	$6,$18
	sw	$2,24($sp)
	jalr	$25
	sw	$3,28($sp)

	lw	$5,2040($16)
	b	$L1414
	lw	$6,180($16)

$L1409:
	lw	$3,164($16)
	lw	$6,168($16)
	lw	$8,160($sp)
	lw	$4,2040($16)
	sra	$3,$3,1
	sra	$6,$6,1
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	lw	$7,164($sp)
	sw	$6,32($sp)
	sw	$2,24($sp)
	move	$6,$23
	sw	$2,224($sp)
	sw	$3,28($sp)
	sw	$8,16($sp)
	jalr	$25
	sw	$fp,20($sp)

	lw	$5,2040($16)
	lw	$6,180($16)
	b	$L1410
	lw	$2,224($sp)

$L1460:
	lw	$6,168($16)
$L1372:
	lw	$5,56($16)
	srl	$5,$5,14
	andi	$5,$5,0x1
	sw	$5,60($sp)
$L1369:
	subu	$7,$4,$20
	addiu	$7,$7,15
	slt	$5,$7,$fp
	movn	$fp,$7,$5
	move	$5,$fp
$L1370:
	slt	$7,$23,-16
	beq	$7,$0,$L1375
	subu	$7,$6,$21

	lw	$9,68($sp)
	lw	$8,176($16)
	li	$23,-16			# 0xfffffffffffffff0
	lw	$7,0($9)
	mul	$9,$23,$8
	lw	$11,60($sp)
	addu	$5,$9,$5
	lw	$10,1464($16)
	bne	$11,$0,$L1377
	addu	$5,$7,$5

$L1490:
	b	$L1374
	move	$6,$8

$L1435:
	lw	$3,164($16)
	lw	$6,168($16)
	lw	$7,160($sp)
	lw	$4,2040($16)
	sra	$3,$3,1
	sra	$6,$6,1
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	sw	$7,16($sp)
	lw	$7,164($sp)
	sw	$6,32($sp)
	sw	$fp,20($sp)
	move	$6,$18
	sw	$2,24($sp)
	jalr	$25
	sw	$3,28($sp)

	lw	$5,2040($16)
	b	$L1436
	lw	$6,180($16)

$L1431:
	lw	$3,164($16)
	lw	$6,168($16)
	lw	$8,160($sp)
	lw	$4,2040($16)
	sra	$3,$3,1
	sra	$6,$6,1
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	lw	$7,164($sp)
	sw	$6,32($sp)
	sw	$2,24($sp)
	move	$6,$23
	sw	$2,224($sp)
	sw	$3,28($sp)
	sw	$8,16($sp)
	jalr	$25
	sw	$fp,20($sp)

	lw	$5,2040($16)
	lw	$6,180($16)
	b	$L1432
	lw	$2,224($sp)

$L1375:
	addiu	$8,$7,15
	slt	$7,$8,$23
	movn	$23,$8,$7
	lw	$9,68($sp)
	lw	$8,176($16)
	lw	$7,0($9)
	mul	$9,$23,$8
	lw	$11,60($sp)
	addu	$5,$9,$5
	lw	$10,1464($16)
	beq	$11,$0,$L1490
	addu	$5,$7,$5

$L1377:
	lw	$9,2040($16)
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	addiu	$7,$21,1
	sw	$7,16($sp)
	sw	$4,28($sp)
	sw	$6,32($sp)
	sw	$2,224($sp)
	move	$6,$8
	sw	$3,220($sp)
	sw	$8,216($sp)
	sw	$10,212($sp)
	sw	$fp,20($sp)
	sw	$23,24($sp)
	move	$4,$9
	jalr	$25
	addiu	$7,$20,1

	lw	$5,2040($16)
	lw	$6,176($16)
	lw	$10,212($sp)
	lw	$8,216($sp)
	lw	$3,220($sp)
	b	$L1374
	lw	$2,224($sp)

$L1484:
	beq	$9,$2,$L1459
	nop

	beq	$8,$2,$L1491
	nop

	lh	$3,2($6)
	b	$L1339
	lh	$2,0($6)

$L1489:
	lw	$4,56($16)
	slt	$5,$fp,-16
	srl	$4,$4,14
	andi	$4,$4,0x1
	sw	$4,60($sp)
	lw	$6,168($16)
	beq	$5,$0,$L1369
	lw	$4,164($16)

	li	$5,-16			# 0xfffffffffffffff0
	b	$L1370
	li	$fp,-16			# 0xfffffffffffffff0

$L1325:
	b	$L1330
	li	$6,1			# 0x1

$L1359:
	lw	$25,%call16(av_log)($28)
$L1504:
	lw	$4,0($16)
	lui	$6,%hi($LC14)
	addiu	$6,$6,%lo($LC14)
	jalr	$25
	move	$5,$0

	li	$2,-1			# 0xffffffffffffffff
$L1364:
	lw	$31,268($sp)
	lw	$fp,264($sp)
	lw	$23,260($sp)
	lw	$22,256($sp)
	lw	$21,252($sp)
	lw	$20,248($sp)
	lw	$19,244($sp)
	lw	$18,240($sp)
	lw	$17,236($sp)
	lw	$16,232($sp)
	j	$31
	addiu	$sp,$sp,272

$L1385:
	lw	$3,164($16)
	lw	$6,168($16)
	lw	$7,160($sp)
	lw	$4,2040($16)
	sra	$3,$3,1
	sra	$6,$6,1
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	sw	$7,16($sp)
	lw	$7,164($sp)
	sw	$6,32($sp)
	sw	$fp,20($sp)
	move	$6,$18
	sw	$2,24($sp)
	jalr	$25
	sw	$3,28($sp)

	lw	$5,2040($16)
	b	$L1386
	lw	$6,180($16)

$L1381:
	lw	$3,164($16)
	lw	$6,168($16)
	lw	$7,160($sp)
	lw	$4,2040($16)
	sra	$3,$3,1
	sra	$6,$6,1
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	sw	$7,16($sp)
	lw	$7,164($sp)
	sw	$6,32($sp)
	sw	$2,24($sp)
	move	$6,$23
	sw	$2,224($sp)
	sw	$3,28($sp)
	jalr	$25
	sw	$fp,20($sp)

	lw	$5,2040($16)
	lw	$6,180($16)
	b	$L1382
	lw	$2,224($sp)

$L1351:
	addiu	$4,$4,8
	sra	$3,$4,3
	addu	$3,$6,$3
	lbu	$7,0($3)
	lbu	$9,3($3)
	lbu	$10,1($3)
	sll	$7,$7,24
	lbu	$3,2($3)
	or	$9,$9,$7
	sll	$7,$10,16
	or	$9,$9,$7
	sll	$7,$3,8
	or	$7,$9,$7
	andi	$3,$4,0x7
	sll	$3,$7,$3
	ori	$8,$8,0x1
	srl	$3,$3,8
	li	$7,-1431699456			# 0xffffffffaaaa0000
	or	$3,$8,$3
	ori	$7,$7,0xaaaa
	and	$7,$3,$7
	beq	$7,$0,$L1353
	nop

	bltz	$3,$L1492
	li	$8,-62			# 0xffffffffffffffc2

	li	$7,31			# 0x1f
	sll	$8,$3,$7
$L1503:
	sll	$9,$3,2
	addiu	$7,$7,-1
	srl	$3,$3,30
	addu	$3,$3,$9
	srl	$8,$8,$7
	subu	$3,$3,$8
	bgez	$3,$L1503
	sll	$8,$3,$7

	sll	$8,$7,1
	subu	$8,$0,$8
$L1355:
	addiu	$4,$4,55
	addu	$4,$4,$8
	sra	$8,$4,3
	addu	$8,$6,$8
	sw	$4,8456($16)
	lbu	$9,0($8)
	lbu	$11,1($8)
	lbu	$10,3($8)
	lbu	$12,2($8)
	sll	$9,$9,24
	sll	$8,$3,$7
	srl	$7,$8,$7
	or	$9,$10,$9
	andi	$8,$3,0x1
	sll	$3,$11,16
	or	$9,$9,$3
	addiu	$3,$7,-1
	subu	$7,$0,$8
	sll	$8,$12,8
	xor	$7,$3,$7
	or	$3,$9,$8
	andi	$8,$4,0x7
	sll	$8,$3,$8
	addiu	$3,$7,1
	li	$7,-1434451968			# 0xffffffffaa800000
	and	$7,$8,$7
	bne	$7,$0,$L1454
	sra	$3,$3,1

$L1475:
	addiu	$4,$4,8
	b	$L1357
	ori	$8,$8,0x1

$L1487:
	addu	$4,$4,$12
	sll	$4,$4,2
	addu	$4,$11,$4
	b	$L1441
	sw	$2,0($4)

$L1474:
	sll	$3,$11,2
	lw	$6,132($sp)
	addiu	$3,$3,-4
	sll	$12,$12,2
	addu	$3,$3,$6
	addiu	$12,$12,-1
	addu	$3,$3,$2
	sra	$2,$12,2
	mul	$7,$2,$13
	sra	$6,$3,2
	addu	$2,$7,$6
	sll	$2,$2,2
	addu	$2,$14,$2
	lw	$6,0($2)
	lw	$11,204($sp)
	and	$2,$6,$11
	beq	$2,$0,$L1493
	nop

$L1327:
	lw	$6,9748($16)
	lw	$13,192($sp)
	mul	$7,$12,$6
	addu	$2,$10,$13
	addu	$6,$7,$3
	lw	$7,0($2)
	sll	$2,$6,2
	addu	$2,$7,$2
	lw	$11,196($sp)
	lhu	$6,0($2)
	lw	$13,200($sp)
	addu	$10,$10,$11
	sh	$6,9176($13)
	lw	$7,9752($16)
	lw	$6,4($10)
	sra	$3,$3,1
	sra	$12,$12,1
	addu	$3,$6,$3
	mul	$6,$12,$7
	lhu	$2,2($2)
	addu	$3,$6,$3
	sll	$2,$2,1
	sh	$2,9178($13)
	lb	$3,0($3)
	lw	$6,176($sp)
	sra	$3,$3,1
	xori	$2,$3,0x1
	b	$L1329
	sltu	$2,$2,1

$L1353:
	li	$3,-2147483648			# 0xffffffff80000000
$L1357:
	sra	$7,$4,3
	addu	$6,$6,$7
	lbu	$7,0($6)
	lbu	$9,3($6)
	lbu	$10,1($6)
	sll	$7,$7,24
	lbu	$6,2($6)
	or	$9,$9,$7
	sll	$7,$10,16
	or	$9,$9,$7
	sll	$7,$6,8
	or	$7,$9,$7
	andi	$6,$4,0x7
	sll	$6,$7,$6
	srl	$6,$6,8
	or	$8,$8,$6
	li	$6,-1431699456			# 0xffffffffaaaa0000
	ori	$6,$6,0xaaaa
	and	$6,$8,$6
	beq	$6,$0,$L1504
	lw	$25,%call16(av_log)($28)

	bltz	$8,$L1494
	li	$9,-62			# 0xffffffffffffffc2

	li	$6,31			# 0x1f
$L1362:
	sll	$7,$8,$6
	sll	$9,$8,2
	addiu	$6,$6,-1
	srl	$8,$8,30
	addu	$8,$8,$9
	srl	$7,$7,$6
	subu	$8,$8,$7
	bgez	$8,$L1362
	sll	$7,$6,1

	subu	$9,$0,$7
$L1361:
	sll	$7,$8,$6
	srl	$6,$7,$6
	andi	$8,$8,0x1
	addiu	$6,$6,-1
	subu	$8,$0,$8
	addiu	$4,$4,55
	xor	$6,$6,$8
	addu	$7,$4,$9
	addiu	$4,$6,1
	sw	$7,8456($16)
	b	$L1358
	sra	$4,$4,1

$L1473:
	b	$L1318
	li	$20,4			# 0x4

$L1491:
	lh	$3,2($5)
	b	$L1339
	lh	$2,0($5)

$L1332:
	lw	$3,8768($16)
	sll	$3,$3,2
	addu	$3,$14,$3
	lw	$3,0($3)
	andi	$3,$3,0x80
	bne	$3,$0,$L1500
	lw	$11,92($sp)

	slt	$3,$2,20
	bne	$3,$0,$L1505
	addiu	$6,$7,-9

	and	$12,$12,$13
	addiu	$2,$2,-12
	sll	$12,$12,1
	sra	$2,$2,3
	addu	$2,$12,$2
	sll	$2,$2,1
	addiu	$3,$2,-1
	lw	$11,152($16)
	sra	$7,$3,2
	lw	$6,6168($16)
	mul	$12,$7,$11
	sll	$6,$6,2
	addiu	$6,$6,-1
	sra	$2,$6,2
	addu	$2,$12,$2
	sll	$2,$2,2
	addu	$2,$14,$2
	lw	$7,0($2)
	lw	$13,204($sp)
	and	$2,$13,$7
	beq	$2,$0,$L1495
	nop

	lw	$7,9748($16)
$L1498:
	lw	$15,192($sp)
	mul	$11,$3,$7
	addu	$2,$10,$15
	addu	$7,$11,$6
	lw	$11,0($2)
	sll	$2,$7,2
	addu	$2,$11,$2
	lhu	$7,0($2)
	lw	$13,200($sp)
	lw	$12,196($sp)
	sh	$7,9176($13)
	addu	$10,$10,$12
	lw	$11,9752($16)
	lw	$7,4($10)
	lh	$10,2($2)
	sra	$2,$3,1
	mul	$3,$2,$11
	sra	$10,$10,1
	addu	$7,$3,$7
	sra	$2,$6,1
	addu	$2,$7,$2
	sh	$10,9178($13)
	lb	$3,0($2)
	lw	$6,176($sp)
	move	$2,$0
	b	$L1329
	sll	$3,$3,1

$L1494:
	b	$L1361
	li	$6,31			# 0x1f

$L1492:
	b	$L1355
	li	$7,31			# 0x1f

$L1493:
	andi	$2,$6,0x40
	bne	$2,$0,$L1327
	nop

$L1328:
	lw	$6,176($sp)
	move	$2,$0
	b	$L1329
	li	$3,-1			# 0xffffffffffffffff

$L1485:
	andi	$2,$7,0x40
	beq	$2,$0,$L1328
	nop

	b	$L1497
	lw	$7,9748($16)

$L1495:
	andi	$2,$7,0x40
	beq	$2,$0,$L1328
	nop

	b	$L1498
	lw	$7,9748($16)

	.set	macro
	.set	reorder
	.end	svq3_mc_dir
	.size	svq3_mc_dir, .-svq3_mc_dir
	.align	2
	.set	nomips16
	.ent	pred_16x8_motion
	.type	pred_16x8_motion, @function
pred_16x8_motion:
	.frame	$sp,32,$31		# vars= 0, regs= 7/0, args= 0, gp= 0
	.mask	0x007f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$16,4($sp)
	sw	$22,28($sp)
	sw	$21,24($sp)
	sw	$20,20($sp)
	sw	$19,16($sp)
	sw	$18,12($sp)
	sw	$17,8($sp)
	lw	$16,48($sp)
	bne	$5,$0,$L1507
	lw	$25,52($sp)

	sll	$9,$6,3
	sll	$8,$6,5
	addu	$10,$9,$8
	sll	$14,$6,2
	addu	$2,$4,$10
	addu	$13,$14,$6
	lb	$2,9460($2)
	addiu	$13,$13,-1
	beq	$2,$7,$L1553
	sll	$13,$13,3

$L1511:
	lui	$2,%hi(scan8)
	addiu	$2,$2,%lo(scan8)
	addu	$5,$5,$2
	lbu	$2,0($5)
	li	$24,65536			# 0x10000
	addu	$5,$9,$8
	addu	$5,$4,$5
	addu	$24,$4,$24
	addu	$17,$10,$2
	addu	$18,$2,$5
	addu	$13,$13,$2
	addiu	$12,$17,-1
	addiu	$15,$2,-4
	lw	$11,-6276($24)
	addu	$20,$5,$15
	addiu	$3,$4,9136
	move	$5,$18
	sll	$12,$12,2
	sll	$13,$13,2
	lb	$19,9455($5)
	lb	$18,9448($18)
	addu	$12,$3,$12
	addu	$13,$3,$13
	bne	$11,$0,$L1554
	lb	$5,9456($20)

	li	$6,-2			# 0xfffffffffffffffe
	beq	$5,$6,$L1520
	nop

$L1515:
	addu	$11,$10,$15
	sll	$11,$11,2
	addu	$11,$3,$11
$L1518:
	xor	$4,$7,$19
	xor	$2,$7,$18
	sltu	$4,$4,1
	sltu	$2,$2,1
	xor	$3,$7,$5
	sltu	$3,$3,1
	addu	$2,$4,$2
	addu	$2,$2,$3
	slt	$3,$2,2
	bne	$3,$0,$L1563
	li	$3,1			# 0x1

$L1532:
	lh	$2,0($12)
	lh	$3,0($13)
	slt	$5,$3,$2
	beq	$5,$0,$L1533
	lh	$4,0($11)

	slt	$5,$3,$4
	bne	$5,$0,$L1555
	nop

$L1534:
	lh	$4,2($12)
	lh	$2,2($13)
	sw	$3,0($16)
	slt	$5,$2,$4
	beq	$5,$0,$L1535
	lh	$3,2($11)

	slt	$5,$2,$3
	beq	$5,$0,$L1536
	nop

	slt	$2,$4,$3
	movz	$4,$3,$2
	move	$2,$4
$L1536:
	sw	$2,0($25)
$L1537:
	lw	$22,28($sp)
	lw	$21,24($sp)
	lw	$20,20($sp)
	lw	$19,16($sp)
	lw	$18,12($sp)
	lw	$17,8($sp)
	lw	$16,4($sp)
	j	$31
	addiu	$sp,$sp,32

$L1507:
	sll	$9,$6,3
	sll	$8,$6,5
	addu	$10,$9,$8
	addu	$2,$4,$10
	lb	$2,9483($2)
	beq	$2,$7,$L1510
	nop

	sll	$14,$6,2
	addu	$13,$14,$6
	addiu	$13,$13,-1
	b	$L1511
	sll	$13,$13,3

$L1554:
	sll	$11,$6,4
	addu	$11,$14,$11
	sll	$11,$11,3
	addiu	$11,$11,40
	addu	$11,$3,$11
	sw	$0,0($11)
	lw	$14,1880($4)
	lw	$24,-6272($24)
	bne	$24,$0,$L1513
	lw	$21,104($14)

	lw	$20,6172($4)
	andi	$22,$20,0x1
	beq	$22,$0,$L1513
	slt	$22,$2,20

	beq	$22,$0,$L1513
	li	$22,-2			# 0xfffffffffffffffe

	beq	$5,$22,$L1514
	addiu	$22,$20,-1

	lw	$9,152($4)
	mul	$17,$22,$9
	lw	$24,6168($4)
	addu	$22,$17,$24
	xori	$17,$2,0xf
	sltu	$17,$17,1
	addu	$17,$22,$17
	sll	$17,$17,2
	addu	$17,$21,$17
	lw	$17,0($17)
	andi	$17,$17,0x80
	beq	$17,$0,$L1515
	andi	$2,$2,0x7

	sll	$20,$20,2
	addiu	$20,$20,-1
	sra	$5,$20,2
	mul	$10,$5,$9
	sll	$24,$24,2
	addu	$2,$2,$24
	sra	$3,$2,2
	addu	$9,$10,$3
	sll	$9,$9,2
	addu	$21,$21,$9
	sll	$5,$6,1
	lw	$3,0($21)
	li	$9,12288			# 0x3000
	sll	$5,$9,$5
	and	$5,$3,$5
	beq	$5,$0,$L1556
	andi	$3,$3,0x40

$L1516:
	lw	$3,9748($4)
	addiu	$5,$6,24
	mul	$9,$20,$3
	sll	$5,$5,2
	addu	$5,$14,$5
	addu	$3,$9,$2
	lw	$5,0($5)
	sll	$3,$3,2
	addu	$3,$5,$3
	addiu	$5,$6,46
	sll	$6,$6,7
	addu	$8,$8,$6
	sll	$6,$5,2
	lhu	$5,0($3)
	addu	$8,$4,$8
	addu	$14,$14,$6
	sh	$5,9176($8)
	lw	$4,9752($4)
	lw	$5,4($14)
	sra	$20,$20,1
	sra	$2,$2,1
	addu	$2,$5,$2
	mul	$5,$20,$4
	lhu	$3,2($3)
	addu	$20,$5,$2
	sll	$2,$3,1
	sh	$2,9178($8)
	lb	$5,0($20)
	b	$L1518
	sra	$5,$5,1

$L1513:
	li	$20,-2			# 0xfffffffffffffffe
	bne	$5,$20,$L1515
	nop

	lw	$20,6172($4)
	andi	$5,$20,0x1
	bne	$5,$0,$L1514
	slt	$10,$2,20

	bne	$10,$0,$L1520
	nop

$L1519:
	andi	$15,$2,0x7
	li	$10,4			# 0x4
	beq	$15,$10,$L1557
	addu	$10,$9,$8

$L1520:
	addu	$8,$9,$8
	addu	$4,$4,$8
	addu	$2,$4,$2
	lb	$5,9447($2)
	addiu	$11,$17,-9
	sll	$11,$11,2
	xor	$4,$7,$19
	xor	$2,$7,$18
	addu	$11,$3,$11
	sltu	$4,$4,1
	sltu	$2,$2,1
	xor	$3,$7,$5
	sltu	$3,$3,1
	addu	$2,$4,$2
	addu	$2,$2,$3
	slt	$3,$2,2
	beq	$3,$0,$L1532
	li	$3,1			# 0x1

$L1563:
	beq	$2,$3,$L1558
	li	$2,-2			# 0xfffffffffffffffe

	bne	$18,$2,$L1532
	nop

	bne	$5,$18,$L1532
	nop

	beq	$19,$5,$L1532
	nop

$L1538:
	lh	$2,2($12)
	lh	$3,0($12)
	sw	$3,0($16)
	b	$L1537
	sw	$2,0($25)

$L1535:
	slt	$5,$3,$2
	beq	$5,$0,$L1536
	nop

	slt	$2,$3,$4
	movz	$4,$3,$2
	b	$L1536
	move	$2,$4

$L1533:
	slt	$5,$4,$3
	beq	$5,$0,$L1534
	nop

	slt	$3,$4,$2
	movz	$2,$4,$3
	b	$L1534
	move	$3,$2

$L1555:
	slt	$3,$2,$4
	movz	$2,$4,$3
	b	$L1534
	move	$3,$2

$L1553:
	addiu	$13,$13,12
	addiu	$4,$4,9136
	sll	$13,$13,2
	addu	$4,$4,$13
	lh	$2,2($4)
	lh	$3,0($4)
	sw	$3,0($16)
	b	$L1537
	sw	$2,0($25)

$L1510:
	addiu	$10,$10,27
	addiu	$4,$4,9136
	sll	$10,$10,2
	addu	$4,$4,$10
	lh	$2,2($4)
	lh	$3,0($4)
	sw	$3,0($16)
	b	$L1537
	sw	$2,0($25)

$L1558:
	beq	$7,$19,$L1538
	nop

	beq	$7,$18,$L1559
	nop

	lh	$2,2($11)
	lh	$3,0($11)
	sw	$3,0($16)
	b	$L1537
	sw	$2,0($25)

$L1514:
	b	$L1519
	li	$5,1			# 0x1

$L1557:
	addu	$10,$4,$10
	lb	$15,9467($10)
	li	$10,-2			# 0xfffffffffffffffe
	beq	$15,$10,$L1520
	nop

	beq	$24,$0,$L1560
	nop

	lw	$5,8768($4)
	sll	$5,$5,2
	addu	$5,$21,$5
	lw	$5,0($5)
	andi	$5,$5,0x80
	bne	$5,$0,$L1520
	slt	$5,$2,20

	bne	$5,$0,$L1520
	and	$10,$20,$10

	addiu	$2,$2,-12
	sll	$10,$10,1
	sra	$3,$2,3
	addu	$3,$10,$3
	sll	$3,$3,1
	lw	$5,152($4)
	addiu	$3,$3,-1
	sra	$10,$3,2
	lw	$2,6168($4)
	mul	$15,$10,$5
	sll	$2,$2,2
	addiu	$2,$2,-1
	sra	$9,$2,2
	addu	$5,$15,$9
	sll	$5,$5,2
	addu	$21,$21,$5
	sll	$9,$6,1
	lw	$5,0($21)
	li	$10,12288			# 0x3000
	sll	$9,$10,$9
	and	$9,$5,$9
	beq	$9,$0,$L1561
	nop

$L1523:
	lw	$5,9748($4)
	addiu	$9,$6,24
	mul	$10,$3,$5
	sll	$9,$9,2
	addu	$9,$14,$9
	addu	$5,$10,$2
	lw	$9,0($9)
	sll	$5,$5,2
	addu	$5,$9,$5
	addiu	$9,$6,46
	sll	$6,$6,7
	addu	$8,$8,$6
	sll	$6,$9,2
	lhu	$9,0($5)
	addu	$8,$4,$8
	sh	$9,9176($8)
	lw	$9,9752($4)
	sra	$3,$3,1
	lh	$4,2($5)
	mul	$5,$3,$9
	addu	$14,$14,$6
	lw	$6,4($14)
	sra	$4,$4,1
	addu	$3,$5,$6
	sra	$2,$2,1
	sh	$4,9178($8)
	addu	$2,$3,$2
	lb	$5,0($2)
	b	$L1518
	sll	$5,$5,1

$L1559:
	lh	$2,2($13)
	lh	$3,0($13)
	sw	$3,0($16)
	b	$L1537
	sw	$2,0($25)

$L1560:
	lw	$10,8768($4)
	sll	$10,$10,2
	addu	$10,$21,$10
	lw	$10,0($10)
	andi	$10,$10,0x80
	beq	$10,$0,$L1520
	nop

	ori	$20,$20,0x1
	sll	$20,$20,1
	sra	$3,$2,4
	addu	$5,$20,$5
	sll	$5,$5,1
	addiu	$3,$3,-1
	addu	$3,$3,$5
	lw	$5,152($4)
	sra	$10,$3,2
	lw	$9,6168($4)
	mul	$15,$10,$5
	sll	$9,$9,2
	addiu	$2,$9,-1
	sra	$9,$2,2
	addu	$5,$15,$9
	sll	$5,$5,2
	addu	$21,$21,$5
	sll	$9,$6,1
	lw	$5,0($21)
	li	$10,12288			# 0x3000
	sll	$9,$10,$9
	and	$9,$5,$9
	beq	$9,$0,$L1562
	nop

$L1522:
	lw	$5,9748($4)
	addiu	$9,$6,24
	mul	$10,$3,$5
	sll	$9,$9,2
	addu	$9,$14,$9
	addu	$5,$10,$2
	lw	$9,0($9)
	sll	$5,$5,2
	addu	$5,$9,$5
	addiu	$9,$6,46
	sll	$6,$6,7
	addu	$8,$8,$6
	sll	$6,$9,2
	lhu	$9,0($5)
	addu	$8,$4,$8
	sh	$9,9176($8)
	lw	$9,9752($4)
	sra	$3,$3,1
	lhu	$4,2($5)
	mul	$5,$3,$9
	addu	$14,$14,$6
	lw	$6,4($14)
	sll	$4,$4,1
	addu	$3,$5,$6
	sra	$2,$2,1
	sh	$4,9178($8)
	addu	$2,$3,$2
	lb	$5,0($2)
	b	$L1518
	sra	$5,$5,1

$L1556:
	bne	$3,$0,$L1516
	nop

	b	$L1518
	li	$5,-1			# 0xffffffffffffffff

$L1562:
	andi	$5,$5,0x40
	bne	$5,$0,$L1522
	nop

	b	$L1518
	li	$5,-1			# 0xffffffffffffffff

$L1561:
	andi	$5,$5,0x40
	bne	$5,$0,$L1523
	nop

	b	$L1518
	li	$5,-1			# 0xffffffffffffffff

	.set	macro
	.set	reorder
	.end	pred_16x8_motion
	.size	pred_16x8_motion, .-pred_16x8_motion
	.align	2
	.set	nomips16
	.ent	pred_8x16_motion
	.type	pred_8x16_motion, @function
pred_8x16_motion:
	.frame	$sp,32,$31		# vars= 0, regs= 7/0, args= 0, gp= 0
	.mask	0x007f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$16,4($sp)
	sw	$22,28($sp)
	sw	$21,24($sp)
	sw	$20,20($sp)
	sw	$19,16($sp)
	sw	$18,12($sp)
	sw	$17,8($sp)
	lw	$16,48($sp)
	bne	$5,$0,$L1565
	lw	$25,52($sp)

	sll	$9,$6,3
	sll	$8,$6,5
	addu	$10,$9,$8
	addu	$2,$4,$10
	lb	$2,9467($2)
	beq	$2,$7,$L1603
	addiu	$3,$4,9136

$L1566:
	lui	$2,%hi(scan8)
	addiu	$2,$2,%lo(scan8)
	addu	$5,$5,$2
	sll	$24,$6,2
	lbu	$2,0($5)
	addu	$13,$24,$6
	addiu	$13,$13,-1
	li	$15,65536			# 0x10000
	addu	$5,$9,$8
	addu	$5,$4,$5
	sll	$13,$13,3
	addu	$15,$4,$15
	addu	$17,$10,$2
	addu	$18,$2,$5
	addu	$13,$13,$2
	addiu	$12,$17,-1
	addiu	$14,$2,-6
	lw	$11,-6276($15)
	addu	$20,$5,$14
	sll	$12,$12,2
	move	$5,$18
	sll	$13,$13,2
	lb	$19,9455($5)
	lb	$18,9448($18)
	addu	$12,$3,$12
	addu	$13,$3,$13
	bne	$11,$0,$L1620
	lb	$5,9456($20)

	li	$6,-2			# 0xfffffffffffffffe
	beq	$5,$6,$L1583
	nop

$L1578:
	addu	$11,$10,$14
	sll	$11,$11,2
	addu	$11,$3,$11
$L1581:
	xor	$4,$7,$19
	xor	$2,$7,$18
	sltu	$4,$4,1
	sltu	$2,$2,1
	xor	$3,$7,$5
	sltu	$3,$3,1
	addu	$2,$4,$2
	addu	$2,$2,$3
	slt	$3,$2,2
	bne	$3,$0,$L1630
	li	$3,1			# 0x1

$L1595:
	lh	$2,0($12)
	lh	$3,0($13)
	slt	$5,$3,$2
	beq	$5,$0,$L1596
	lh	$4,0($11)

	slt	$5,$3,$4
	bne	$5,$0,$L1621
	nop

$L1597:
	lh	$4,2($12)
	lh	$2,2($13)
	sw	$3,0($16)
	slt	$5,$2,$4
	beq	$5,$0,$L1598
	lh	$3,2($11)

	slt	$5,$2,$3
	beq	$5,$0,$L1599
	nop

	slt	$2,$4,$3
	movz	$4,$3,$2
	move	$2,$4
$L1599:
	sw	$2,0($25)
$L1600:
	lw	$22,28($sp)
	lw	$21,24($sp)
	lw	$20,20($sp)
	lw	$19,16($sp)
	lw	$18,12($sp)
	lw	$17,8($sp)
	lw	$16,4($sp)
	j	$31
	addiu	$sp,$sp,32

$L1620:
	sll	$11,$6,4
	addu	$11,$24,$11
	sll	$11,$11,3
	addiu	$11,$11,40
	addu	$11,$3,$11
	sw	$0,0($11)
	lw	$24,-6272($15)
	lw	$15,1880($4)
	bne	$24,$0,$L1576
	lw	$21,104($15)

	lw	$20,6172($4)
	andi	$22,$20,0x1
	beq	$22,$0,$L1576
	slt	$22,$2,20

	beq	$22,$0,$L1576
	li	$22,-2			# 0xfffffffffffffffe

	beq	$5,$22,$L1577
	addiu	$22,$20,-1

	lw	$9,152($4)
	mul	$17,$22,$9
	lw	$24,6168($4)
	addu	$22,$17,$24
	xori	$17,$2,0xf
	sltu	$17,$17,1
	addu	$17,$22,$17
	sll	$17,$17,2
	addu	$17,$21,$17
	lw	$17,0($17)
	andi	$17,$17,0x80
	beq	$17,$0,$L1578
	andi	$2,$2,0x7

	sll	$20,$20,2
	addiu	$20,$20,-1
	sra	$5,$20,2
	mul	$10,$5,$9
	sll	$24,$24,2
	addiu	$24,$24,-2
	addu	$2,$24,$2
	sra	$3,$2,2
	addu	$9,$10,$3
	sll	$9,$9,2
	addu	$21,$21,$9
	sll	$5,$6,1
	lw	$3,0($21)
	li	$9,12288			# 0x3000
	sll	$5,$9,$5
	and	$5,$3,$5
	beq	$5,$0,$L1622
	andi	$3,$3,0x40

$L1579:
	lw	$3,9748($4)
	addiu	$5,$6,24
	mul	$9,$20,$3
	sll	$5,$5,2
	addu	$5,$15,$5
	addu	$3,$9,$2
	lw	$5,0($5)
	sll	$3,$3,2
	addu	$3,$5,$3
	addiu	$5,$6,46
	sll	$6,$6,7
	addu	$8,$8,$6
	sll	$6,$5,2
	lhu	$5,0($3)
	addu	$8,$4,$8
	addu	$15,$15,$6
	sh	$5,9176($8)
	lw	$4,9752($4)
	lw	$5,4($15)
	sra	$20,$20,1
	sra	$2,$2,1
	addu	$2,$5,$2
	mul	$5,$20,$4
	lhu	$3,2($3)
	addu	$20,$5,$2
	sll	$2,$3,1
	sh	$2,9178($8)
	lb	$5,0($20)
	b	$L1581
	sra	$5,$5,1

$L1576:
	li	$20,-2			# 0xfffffffffffffffe
	bne	$5,$20,$L1578
	nop

	lw	$20,6172($4)
	andi	$5,$20,0x1
	bne	$5,$0,$L1577
	slt	$10,$2,20

	bne	$10,$0,$L1583
	nop

$L1582:
	andi	$14,$2,0x7
	li	$10,4			# 0x4
	beq	$14,$10,$L1623
	addu	$10,$9,$8

$L1583:
	addu	$8,$9,$8
	addu	$4,$4,$8
	addu	$2,$4,$2
	lb	$5,9447($2)
	addiu	$11,$17,-9
	sll	$11,$11,2
	xor	$4,$7,$19
	xor	$2,$7,$18
	addu	$11,$3,$11
	sltu	$4,$4,1
	sltu	$2,$2,1
	xor	$3,$7,$5
	sltu	$3,$3,1
	addu	$2,$4,$2
	addu	$2,$2,$3
	slt	$3,$2,2
	beq	$3,$0,$L1595
	li	$3,1			# 0x1

$L1630:
	beq	$2,$3,$L1624
	li	$2,-2			# 0xfffffffffffffffe

	bne	$18,$2,$L1595
	nop

	bne	$5,$18,$L1595
	nop

	beq	$19,$5,$L1595
	nop

$L1605:
	lh	$2,2($12)
	lh	$3,0($12)
	sw	$3,0($16)
	b	$L1600
	sw	$2,0($25)

$L1598:
	slt	$5,$3,$2
	beq	$5,$0,$L1599
	nop

	slt	$2,$3,$4
	movz	$4,$3,$2
	b	$L1599
	move	$2,$4

$L1596:
	slt	$5,$4,$3
	beq	$5,$0,$L1597
	nop

	slt	$3,$4,$2
	movz	$2,$4,$3
	b	$L1597
	move	$3,$2

$L1565:
	li	$10,65536			# 0x10000
	addu	$10,$4,$10
	sll	$9,$6,3
	sll	$8,$6,5
	addu	$2,$9,$8
	lw	$3,-6276($10)
	addu	$2,$4,$2
	bne	$3,$0,$L1604
	lb	$2,9464($2)

	addiu	$3,$4,9136
$L1568:
	li	$10,-2			# 0xfffffffffffffffe
	beq	$2,$10,$L1569
	nop

$L1570:
	addu	$10,$9,$8
	addiu	$10,$10,8
	sll	$10,$10,2
	addu	$10,$3,$10
$L1572:
	beq	$7,$2,$L1574
	nop

	b	$L1566
	addu	$10,$9,$8

$L1621:
	slt	$3,$2,$4
	movz	$2,$4,$3
	b	$L1597
	move	$3,$2

$L1604:
	sll	$3,$6,4
	sll	$11,$6,2
	addu	$11,$11,$3
	sll	$11,$11,3
	addiu	$11,$11,40
	addiu	$3,$4,9136
	addu	$11,$3,$11
	sw	$0,0($11)
	lw	$12,-6272($10)
	lw	$15,1880($4)
	move	$10,$11
	bne	$12,$0,$L1568
	lw	$11,104($15)

	lw	$12,6172($4)
	andi	$13,$12,0x1
	beq	$13,$0,$L1568
	li	$13,-2			# 0xfffffffffffffffe

	beq	$2,$13,$L1569
	addiu	$24,$12,-1

	lw	$13,152($4)
	mul	$17,$24,$13
	lw	$14,6168($4)
	addu	$24,$17,$14
	sll	$24,$24,2
	addu	$24,$11,$24
	lw	$24,0($24)
	andi	$24,$24,0x80
	beq	$24,$0,$L1570
	sll	$12,$12,2

	addiu	$12,$12,-1
	sra	$24,$12,2
	mul	$17,$24,$13
	sll	$14,$14,2
	addiu	$14,$14,4
	sra	$2,$14,2
	addu	$13,$17,$2
	sll	$13,$13,2
	addu	$11,$11,$13
	lw	$2,0($11)
	sll	$24,$6,1
	li	$11,12288			# 0x3000
	sll	$11,$11,$24
	and	$11,$2,$11
	beq	$11,$0,$L1625
	nop

$L1571:
	lw	$2,9748($4)
	addiu	$11,$6,24
	mul	$13,$12,$2
	sll	$11,$11,2
	addu	$11,$15,$11
	addu	$2,$13,$14
	lw	$11,0($11)
	sll	$2,$2,2
	addu	$11,$11,$2
	addiu	$24,$6,46
	sll	$2,$6,7
	lhu	$13,0($11)
	addu	$2,$8,$2
	sll	$24,$24,2
	addu	$2,$4,$2
	addu	$15,$15,$24
	sh	$13,9176($2)
	lw	$13,4($15)
	lw	$15,9752($4)
	sra	$12,$12,1
	mul	$17,$12,$15
	lhu	$11,2($11)
	addu	$12,$17,$13
	sll	$11,$11,1
	sra	$14,$14,1
	sh	$11,9178($2)
	addu	$14,$12,$14
	lb	$2,0($14)
	b	$L1572
	sra	$2,$2,1

$L1624:
	beq	$7,$19,$L1605
	nop

	beq	$7,$18,$L1626
	nop

	lh	$2,2($11)
	lh	$3,0($11)
	sw	$3,0($16)
	b	$L1600
	sw	$2,0($25)

$L1577:
	b	$L1582
	li	$5,1			# 0x1

$L1603:
	addiu	$10,$10,11
	sll	$10,$10,2
	addiu	$4,$4,9136
	addu	$4,$4,$10
	lh	$2,2($4)
	lh	$3,0($4)
	lw	$22,28($sp)
	sw	$3,0($16)
	lw	$21,24($sp)
	lw	$20,20($sp)
	lw	$19,16($sp)
	lw	$18,12($sp)
	lw	$17,8($sp)
	lw	$16,4($sp)
	sw	$2,0($25)
	j	$31
	addiu	$sp,$sp,32

$L1569:
	addu	$8,$9,$8
	addu	$2,$4,$8
	addiu	$8,$8,5
	sll	$10,$8,2
	lb	$2,9461($2)
	addu	$10,$3,$10
	sll	$9,$6,3
	b	$L1572
	sll	$8,$6,5

$L1574:
	lh	$2,2($10)
	lh	$3,0($10)
	sw	$3,0($16)
	b	$L1600
	sw	$2,0($25)

$L1623:
	addu	$10,$4,$10
	lb	$14,9467($10)
	li	$10,-2			# 0xfffffffffffffffe
	beq	$14,$10,$L1583
	nop

	beq	$24,$0,$L1627
	nop

	lw	$5,8768($4)
	sll	$5,$5,2
	addu	$5,$21,$5
	lw	$5,0($5)
	andi	$5,$5,0x80
	bne	$5,$0,$L1583
	slt	$5,$2,20

	bne	$5,$0,$L1583
	and	$10,$20,$10

	addiu	$2,$2,-12
	sll	$10,$10,1
	sra	$3,$2,3
	addu	$3,$10,$3
	sll	$3,$3,1
	lw	$5,152($4)
	addiu	$3,$3,-1
	sra	$10,$3,2
	lw	$2,6168($4)
	mul	$14,$10,$5
	sll	$2,$2,2
	addiu	$2,$2,-1
	sra	$9,$2,2
	addu	$5,$14,$9
	sll	$5,$5,2
	addu	$21,$21,$5
	sll	$9,$6,1
	lw	$5,0($21)
	li	$10,12288			# 0x3000
	sll	$9,$10,$9
	and	$9,$5,$9
	beq	$9,$0,$L1628
	nop

$L1586:
	lw	$5,9748($4)
	addiu	$9,$6,24
	mul	$10,$3,$5
	sll	$9,$9,2
	addu	$9,$15,$9
	addu	$5,$10,$2
	lw	$9,0($9)
	sll	$5,$5,2
	addu	$5,$9,$5
	addiu	$9,$6,46
	sll	$6,$6,7
	addu	$8,$8,$6
	sll	$6,$9,2
	lhu	$9,0($5)
	addu	$8,$4,$8
	sh	$9,9176($8)
	lw	$9,9752($4)
	sra	$3,$3,1
	lh	$4,2($5)
	mul	$5,$3,$9
	addu	$15,$15,$6
	lw	$6,4($15)
	sra	$4,$4,1
	addu	$3,$5,$6
	sra	$2,$2,1
	sh	$4,9178($8)
	addu	$2,$3,$2
	lb	$5,0($2)
	b	$L1581
	sll	$5,$5,1

$L1626:
	lh	$2,2($13)
	lh	$3,0($13)
	sw	$3,0($16)
	b	$L1600
	sw	$2,0($25)

$L1627:
	lw	$10,8768($4)
	sll	$10,$10,2
	addu	$10,$21,$10
	lw	$10,0($10)
	andi	$10,$10,0x80
	beq	$10,$0,$L1583
	nop

	ori	$20,$20,0x1
	sll	$20,$20,1
	sra	$3,$2,4
	addu	$5,$20,$5
	sll	$5,$5,1
	addiu	$3,$3,-1
	addu	$3,$3,$5
	lw	$5,152($4)
	sra	$10,$3,2
	lw	$9,6168($4)
	mul	$14,$10,$5
	sll	$9,$9,2
	addiu	$2,$9,-1
	sra	$9,$2,2
	addu	$5,$14,$9
	sll	$5,$5,2
	addu	$21,$21,$5
	sll	$9,$6,1
	lw	$5,0($21)
	li	$10,12288			# 0x3000
	sll	$9,$10,$9
	and	$9,$5,$9
	beq	$9,$0,$L1629
	nop

$L1585:
	lw	$5,9748($4)
	addiu	$9,$6,24
	mul	$10,$3,$5
	sll	$9,$9,2
	addu	$9,$15,$9
	addu	$5,$10,$2
	lw	$9,0($9)
	sll	$5,$5,2
	addu	$5,$9,$5
	addiu	$9,$6,46
	sll	$6,$6,7
	addu	$8,$8,$6
	sll	$6,$9,2
	lhu	$9,0($5)
	addu	$8,$4,$8
	sh	$9,9176($8)
	lw	$9,9752($4)
	sra	$3,$3,1
	lhu	$4,2($5)
	mul	$5,$3,$9
	addu	$15,$15,$6
	lw	$6,4($15)
	sll	$4,$4,1
	addu	$3,$5,$6
	sra	$2,$2,1
	sh	$4,9178($8)
	addu	$2,$3,$2
	lb	$5,0($2)
	b	$L1581
	sra	$5,$5,1

$L1622:
	bne	$3,$0,$L1579
	nop

	b	$L1581
	li	$5,-1			# 0xffffffffffffffff

$L1625:
	andi	$2,$2,0x40
	bne	$2,$0,$L1571
	nop

	b	$L1572
	li	$2,-1			# 0xffffffffffffffff

$L1629:
	andi	$5,$5,0x40
	bne	$5,$0,$L1585
	nop

	b	$L1581
	li	$5,-1			# 0xffffffffffffffff

$L1628:
	andi	$5,$5,0x40
	bne	$5,$0,$L1586
	nop

	b	$L1581
	li	$5,-1			# 0xffffffffffffffff

	.set	macro
	.set	reorder
	.end	pred_8x16_motion
	.size	pred_8x16_motion, .-pred_8x16_motion
	.align	2
	.set	nomips16
	.ent	pred_direct_motion
	.type	pred_direct_motion, @function
pred_direct_motion:
	.frame	$sp,120,$31		# vars= 72, regs= 9/0, args= 0, gp= 8
	.mask	0x40ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$7,6172($4)
	lw	$3,152($4)
	lw	$6,6168($4)
	mul	$2,$7,$3
	lw	$9,9752($4)
	addu	$3,$2,$6
	li	$2,131072			# 0x20000
	addu	$2,$4,$2
	lw	$8,-13528($2)
	sll	$3,$3,2
	addu	$3,$8,$3
	mul	$8,$7,$9
	lw	$12,9748($4)
	addu	$9,$8,$6
	mul	$8,$7,$12
	addiu	$sp,$sp,-120
	lw	$3,0($3)
	addu	$12,$8,$6
	lw	$10,-13536($2)
	lw	$8,-13444($2)
	sw	$fp,116($sp)
	sw	$23,112($sp)
	lw	$fp,-13532($2)
	lw	$23,-13440($2)
	lw	$2,0($5)
	sll	$12,$12,4
	sll	$9,$9,1
	andi	$6,$3,0x40
	addu	$fp,$fp,$12
	addu	$23,$23,$9
	sw	$22,108($sp)
	sw	$21,104($sp)
	sw	$20,100($sp)
	sw	$19,96($sp)
	sw	$18,92($sp)
	sw	$17,88($sp)
	sw	$16,84($sp)
	addu	$12,$10,$12
	addu	$9,$8,$9
	beq	$6,$0,$L1632
	andi	$2,$2,0x40

	lw	$6,9980($4)
	bne	$6,$0,$L1632
	li	$6,61504			# 0xf040

	sw	$6,0($5)
	move	$16,$0
	move	$25,$0
	move	$24,$0
	li	$11,16704			# 0x4140
	li	$17,4416			# 0x1140
	beq	$2,$0,$L1636
	li	$14,20800			# 0x5140

$L1843:
	li	$6,61504			# 0xf040
$L1637:
	li	$7,65536			# 0x10000
	addu	$7,$4,$7
	lw	$7,-6272($7)
	beq	$7,$0,$L1870
	li	$7,65536			# 0x10000

	ori	$6,$6,0x80
	sw	$6,0($5)
$L1870:
	addu	$8,$4,$7
	lw	$10,5356($8)
	beq	$10,$0,$L1639
	ori	$15,$7,0x14f0

	lb	$7,9464($4)
	li	$8,-2			# 0xfffffffffffffffe
	lb	$6,9467($4)
	beq	$7,$8,$L1640
	lb	$10,9460($4)

	move	$8,$7
	bltz	$6,$L1837
	sw	$6,8($sp)

$L1808:
	slt	$13,$10,$6
	beq	$13,$0,$L1871
	move	$13,$6

	bltz	$10,$L1872
	slt	$13,$8,$13

	sw	$10,8($sp)
$L1818:
	move	$13,$10
	slt	$13,$8,$13
	bne	$13,$0,$L1838
	nop

$L1644:
	lb	$20,9500($4)
	lb	$21,9504($4)
	li	$15,-2			# 0xfffffffffffffffe
	lb	$19,9507($4)
	move	$13,$20
	beq	$21,$15,$L1839
	move	$8,$21

$L1651:
	bltz	$19,$L1652
	sw	$19,12($sp)

$L1845:
	slt	$15,$20,$19
	beq	$15,$0,$L1653
	nop

	bltz	$20,$L1653
	slt	$13,$8,$13

	bne	$13,$0,$L1840
	sw	$20,12($sp)

$L1657:
	lw	$8,8($sp)
	bltz	$8,$L1873
	lw	$13,12($sp)

$L1659:
	li	$19,65536			# 0x10000
	addu	$19,$4,$19
	addiu	$20,$sp,16
	addiu	$21,$sp,20
	lw	$18,12($sp)
	lw	$22,-6276($19)
	sw	$20,40($sp)
	sw	$21,32($sp)
	addiu	$20,$4,9180
	addiu	$21,$4,9152
	move	$13,$18
	addiu	$15,$4,9136
	sw	$20,68($sp)
	beq	$22,$0,$L1842
	sw	$21,64($sp)

	sw	$0,40($15)
	lw	$20,-6272($19)
	lw	$19,1880($4)
	sw	$19,36($sp)
	lw	$21,36($sp)
	addiu	$19,$4,9176
	lw	$21,104($21)
	bne	$20,$0,$L1687
	sw	$21,52($sp)

	lw	$21,6172($4)
	andi	$22,$21,0x1
	beq	$22,$0,$L1687
	sw	$21,48($sp)

	li	$22,-2			# 0xfffffffffffffffe
	beq	$7,$22,$L1691
	addiu	$21,$21,-1

	lw	$22,6168($4)
	lw	$20,152($4)
	mtlo	$22
	madd	$21,$20
	sw	$20,44($sp)
	mflo	$21
	lw	$20,52($sp)
	sw	$22,56($sp)
	sll	$22,$21,2
	addu	$22,$20,$22
	lw	$22,0($22)
	andi	$22,$22,0x80
	beq	$22,$0,$L1684
	sw	$21,72($sp)

	lw	$20,48($sp)
	lw	$21,56($sp)
	sll	$7,$20,2
	sll	$22,$21,2
	addiu	$7,$7,-1
	addiu	$22,$22,4
	sra	$21,$7,2
	sw	$7,48($sp)
	sra	$7,$22,2
	mtlo	$7
	lw	$7,44($sp)
	lw	$20,52($sp)
	madd	$21,$7
	mflo	$7
	sw	$7,44($sp)
	sll	$7,$7,2
	addu	$7,$20,$7
	lw	$21,0($7)
	andi	$7,$21,0x3000
	beq	$7,$0,$L1692
	nop

	lw	$21,36($sp)
$L1884:
	lw	$7,9748($4)
	lw	$21,96($21)
	lw	$20,48($sp)
	sw	$21,44($sp)
	mul	$21,$20,$7
	lw	$20,36($sp)
	addu	$7,$21,$22
	lw	$21,44($sp)
	sll	$7,$7,2
	addu	$7,$21,$7
	lhu	$21,0($7)
	lw	$20,188($20)
	sh	$21,9176($4)
	lhu	$7,2($7)
	mtlo	$20
	sh	$7,36($sp)
	lw	$7,48($sp)
	lw	$20,9752($4)
	sra	$7,$7,1
	madd	$7,$20
	lhu	$21,36($sp)
	mflo	$20
	sll	$7,$21,1
	sra	$22,$22,1
	sw	$20,44($sp)
	sh	$7,9178($4)
	addu	$22,$20,$22
	lb	$7,0($22)
	b	$L1683
	sra	$7,$7,1

$L1632:
	bne	$2,$0,$L1874
	li	$6,61504			# 0xf040

	andi	$6,$3,0xf
	beq	$6,$0,$L1634
	li	$6,20744			# 0x5108

	sw	$6,0($5)
	li	$16,8			# 0x8
	li	$25,8			# 0x8
	li	$24,8			# 0x8
	li	$11,16648			# 0x4108
	li	$17,4360			# 0x1108
	b	$L1637
	li	$14,20744			# 0x5108

$L1634:
	li	$6,61504			# 0xf040
$L1874:
	sw	$6,0($5)
	li	$16,8			# 0x8
	li	$25,8			# 0x8
	li	$24,8			# 0x8
	li	$11,16648			# 0x4108
	li	$17,4360			# 0x1108
	bne	$2,$0,$L1843
	li	$14,20744			# 0x5108

$L1636:
	lw	$6,0($5)
	ori	$6,$6,0x100
	b	$L1637
	sw	$6,0($5)

$L1639:
	ori	$11,$7,0x15b0
	lw	$8,-6276($8)
	addu	$11,$4,$11
	addu	$15,$4,$15
	beq	$8,$0,$L1752
	addiu	$17,$11,64

	andi	$8,$6,0x80
	beq	$8,$0,$L1753
	nop

	ori	$11,$7,0x1630
	addu	$11,$4,$11
	ori	$15,$7,0x1530
	addu	$15,$4,$15
	addiu	$17,$11,128
$L1753:
	xor	$7,$6,$3
	andi	$7,$7,0x80
	beq	$7,$0,$L1875
	andi	$6,$6,0x8

	li	$6,61504			# 0xf040
	li	$3,61760			# 0xf140
	movn	$3,$6,$2
	lw	$6,6172($4)
	or	$8,$3,$8
	lw	$10,152($4)
	li	$3,-2			# 0xfffffffffffffffe
	and	$3,$6,$3
	mul	$13,$3,$10
	lw	$7,6168($4)
	andi	$6,$8,0x80
	addu	$3,$13,$7
	beq	$6,$0,$L1756
	sw	$8,0($5)

	li	$6,131072			# 0x20000
	addu	$6,$4,$6
	lw	$7,-13528($6)
	sll	$6,$3,2
	lw	$10,152($4)
	addu	$6,$7,$6
	lw	$6,0($6)
	addu	$3,$3,$10
	sll	$3,$3,2
	sw	$6,8($sp)
	addu	$7,$7,$3
	lw	$10,6172($4)
	lw	$3,0($7)
	andi	$7,$10,0x1
	beq	$7,$0,$L1757
	sw	$3,12($sp)

	lw	$10,9752($4)
	lw	$7,9748($4)
	sll	$10,$10,1
	sll	$7,$7,4
	subu	$10,$0,$10
	subu	$7,$0,$7
	addu	$23,$23,$10
	addu	$fp,$fp,$7
	addu	$9,$9,$10
	addu	$12,$12,$7
$L1757:
	andi	$6,$6,0xf
	beq	$6,$0,$L1758
	andi	$3,$3,0xf

	beq	$3,$0,$L1758
	nop

	bne	$2,$0,$L1758
	move	$7,$0

	ori	$8,$8,0x10
	b	$L1759
	sw	$8,0($5)

$L1752:
	andi	$6,$6,0x8
$L1875:
	beq	$6,$0,$L1791
	li	$7,59272			# 0xe788

	addiu	$2,$4,9508
	andi	$3,$3,0x7
	sw	$0,9508($4)
	addiu	$10,$4,9456
	sw	$0,24($2)
	sw	$0,8($2)
	bne	$3,$0,$L1844
	sw	$0,16($2)

	lb	$2,0($9)
	bltz	$2,$L1794
	sll	$2,$2,2

	addu	$11,$11,$2
	lw	$5,0($11)
	lh	$8,0($12)
	sll	$2,$5,2
	addu	$15,$15,$2
	lw	$3,0($15)
$L1795:
	lh	$2,2($12)
	mul	$6,$8,$3
	mul	$3,$2,$3
	addiu	$6,$6,128
	addiu	$3,$3,128
	sra	$6,$6,8
	sra	$3,$3,8
	sll	$7,$5,8
	addu	$5,$7,$5
	subu	$2,$3,$2
	subu	$8,$6,$8
	sll	$2,$2,16
	andi	$8,$8,0xffff
	sll	$3,$3,16
	andi	$6,$6,0xffff
	sll	$7,$5,16
	addu	$3,$3,$6
	addu	$2,$2,$8
	addu	$7,$5,$7
$L1793:
	addiu	$6,$4,9184
	addiu	$5,$4,9344
	addiu	$8,$10,12
	sw	$7,12($10)
	sw	$7,24($8)
	sw	$7,8($8)
	sw	$7,16($8)
	sw	$3,9184($4)
	sw	$3,108($6)
	sw	$3,4($6)
	sw	$3,8($6)
	sw	$3,12($6)
	sw	$3,32($6)
	sw	$3,36($6)
	sw	$3,40($6)
	sw	$3,44($6)
	sw	$3,64($6)
	sw	$3,68($6)
	sw	$3,72($6)
	sw	$3,76($6)
	sw	$3,96($6)
	sw	$3,100($6)
	sw	$3,104($6)
	sw	$2,9344($4)
	sw	$2,4($5)
	sw	$2,8($5)
	sw	$2,12($5)
	sw	$2,32($5)
	sw	$2,36($5)
	sw	$2,40($5)
	sw	$2,44($5)
	sw	$2,64($5)
	sw	$2,68($5)
	sw	$2,72($5)
	sw	$2,76($5)
	sw	$2,96($5)
	sw	$2,100($5)
	sw	$2,108($5)
	sw	$2,104($5)
$L1805:
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

$L1871:
	slt	$13,$8,$13
$L1872:
	beq	$13,$0,$L1644
	nop

$L1838:
	bltz	$8,$L1644
	li	$15,-2			# 0xfffffffffffffffe

	sw	$8,8($sp)
	lb	$20,9500($4)
	lb	$21,9504($4)
	lb	$19,9507($4)
	move	$13,$20
	bne	$21,$15,$L1651
	move	$8,$21

$L1839:
	lb	$8,9499($4)
	bgez	$19,$L1845
	sw	$19,12($sp)

$L1652:
	bgez	$20,$L1656
	sw	$20,12($sp)

	bgez	$8,$L1657
	sw	$8,12($sp)

	li	$8,-1			# 0xffffffffffffffff
	sw	$8,12($sp)
$L1847:
	lw	$8,8($sp)
	bgez	$8,$L1659
	lw	$13,12($sp)

$L1873:
	bltz	$13,$L1846
	nop

	sw	$0,20($sp)
	sw	$0,16($sp)
	addiu	$15,$4,9136
	b	$L1803
	move	$18,$13

$L1653:
	move	$13,$19
$L1656:
	slt	$13,$8,$13
	beq	$13,$0,$L1657
	nop

$L1840:
	bltz	$8,$L1657
	nop

	b	$L1847
	sw	$8,12($sp)

$L1791:
	lui	$6,%hi(scan8)
	andi	$3,$3,0x7
	addu	$7,$4,$7
	addiu	$6,$6,%lo(scan8)
	addiu	$13,$4,9456
	addiu	$8,$4,9136
	move	$5,$0
	li	$16,4			# 0x4
	sw	$17,36($sp)
	sw	$23,44($sp)
$L1802:
	beq	$2,$0,$L1796
	nop

	lw	$10,0($7)
	andi	$10,$10,0x100
	beq	$10,$0,$L1797
	nop

$L1796:
	lbu	$22,0($6)
	sw	$14,0($7)
	addiu	$25,$22,40
	addu	$10,$13,$25
	sh	$0,8($10)
	beq	$3,$0,$L1798
	sh	$0,0($10)

	sll	$10,$22,2
	sll	$25,$25,2
	addu	$10,$8,$10
	addu	$25,$8,$25
	addu	$22,$13,$22
	sw	$0,36($10)
	sw	$0,0($10)
	sw	$0,4($10)
	sw	$0,32($10)
	sh	$0,8($22)
	sw	$0,36($25)
	sh	$0,0($22)
	sw	$0,0($25)
	sw	$0,4($25)
	sw	$0,32($25)
$L1797:
	addiu	$5,$5,1
	addiu	$7,$7,4
	bne	$5,$16,$L1802
	addiu	$6,$6,4

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

$L1842:
	li	$19,-2			# 0xfffffffffffffffe
	bne	$7,$19,$L1683
	addiu	$19,$15,32

$L1685:
	lb	$7,9459($4)
	addiu	$19,$15,12
$L1683:
	xor	$21,$8,$6
	sltu	$21,$21,1
	sw	$21,36($sp)
	xor	$20,$8,$10
	lw	$22,36($sp)
	sltu	$20,$20,1
	xor	$21,$8,$7
	sltu	$21,$21,1
	addu	$20,$22,$20
	addu	$20,$20,$21
	slt	$21,$20,2
	bne	$21,$0,$L1848
	li	$21,1			# 0x1

$L1664:
	lh	$7,9180($4)
	lh	$6,9152($4)
	slt	$22,$6,$7
	beq	$22,$0,$L1849
	lh	$10,0($19)

	slt	$22,$6,$10
	beq	$22,$0,$L1682
	nop

	slt	$6,$7,$10
	movz	$7,$10,$6
	move	$6,$7
$L1682:
	lw	$7,68($sp)
	lw	$20,64($sp)
	lh	$10,2($7)
	lh	$7,2($20)
	lw	$21,40($sp)
	slt	$20,$7,$10
	sw	$6,0($21)
	beq	$20,$0,$L1850
	lh	$6,2($19)

	slt	$19,$7,$6
	beq	$19,$0,$L1876
	lw	$22,32($sp)

	slt	$7,$10,$6
	movz	$10,$6,$7
	move	$7,$10
$L1681:
	lw	$22,32($sp)
$L1876:
	sw	$7,0($22)
$L1671:
	bgez	$18,$L1851
	nop

	sw	$0,28($sp)
	sw	$0,24($sp)
$L1709:
	bltz	$13,$L1852
	nop

$L1718:
	bltz	$8,$L1720
	li	$6,-4097			# 0xffffffffffffefff

$L1661:
	lw	$6,0($5)
	move	$16,$24
	move	$11,$14
$L1719:
	andi	$6,$6,0x8
	beq	$6,$0,$L1721
	andi	$6,$8,0x00ff

	andi	$5,$8,0x00ff
	andi	$2,$13,0x00ff
	sll	$7,$5,8
	sll	$6,$2,8
	addu	$5,$7,$5
	addu	$2,$6,$2
	sll	$7,$5,16
	sll	$6,$2,16
	addu	$5,$5,$7
	addu	$2,$2,$6
	addiu	$7,$4,9468
	addiu	$6,$4,9508
	andi	$3,$3,0x7
	sw	$5,9468($4)
	sw	$5,24($7)
	sw	$5,8($7)
	sw	$5,16($7)
	sw	$2,9508($4)
	sw	$2,24($6)
	sw	$2,8($6)
	bne	$3,$0,$L1722
	sw	$2,16($6)

	lb	$2,0($9)
	bne	$2,$0,$L1723
	nop

	lhu	$2,0($12)
	addiu	$2,$2,1
	andi	$2,$2,0xffff
	sltu	$2,$2,3
	bne	$2,$0,$L1853
	nop

$L1722:
	lw	$3,28($sp)
$L1869:
	lw	$2,20($sp)
$L1882:
	lhu	$6,24($sp)
	lhu	$5,16($sp)
	sll	$3,$3,16
	sll	$2,$2,16
	addu	$3,$3,$6
	addu	$2,$2,$5
$L1728:
	addiu	$6,$4,9184
	addiu	$5,$4,9344
	sw	$2,9184($4)
	lw	$fp,116($sp)
	sw	$2,108($6)
	sw	$2,4($6)
	sw	$2,8($6)
	sw	$2,12($6)
	sw	$2,32($6)
	sw	$2,36($6)
	sw	$2,40($6)
	sw	$2,44($6)
	sw	$2,64($6)
	sw	$2,68($6)
	sw	$2,72($6)
	sw	$2,76($6)
	sw	$2,96($6)
	sw	$2,100($6)
	sw	$2,104($6)
	lw	$23,112($sp)
	sw	$3,9344($4)
	lw	$22,108($sp)
	lw	$21,104($sp)
	lw	$20,100($sp)
	lw	$19,96($sp)
	lw	$18,92($sp)
	lw	$17,88($sp)
	lw	$16,84($sp)
	sw	$3,108($5)
	sw	$3,4($5)
	sw	$3,8($5)
	sw	$3,12($5)
	sw	$3,32($5)
	sw	$3,36($5)
	sw	$3,40($5)
	sw	$3,44($5)
	sw	$3,64($5)
	sw	$3,68($5)
	sw	$3,72($5)
	sw	$3,76($5)
	sw	$3,96($5)
	sw	$3,100($5)
	sw	$3,104($5)
	j	$31
	addiu	$sp,$sp,120

$L1640:
	lb	$8,9459($4)
	bgez	$6,$L1808
	sw	$6,8($sp)

$L1837:
	bgez	$10,$L1818
	sw	$10,8($sp)

	bgez	$8,$L1644
	sw	$8,8($sp)

	li	$8,-1			# 0xffffffffffffffff
	b	$L1644
	sw	$8,8($sp)

$L1687:
	li	$22,-2			# 0xfffffffffffffffe
	beq	$7,$22,$L1854
	nop

$L1684:
	b	$L1683
	addiu	$19,$15,32

$L1758:
	ori	$8,$8,0x40
	sw	$8,0($5)
	move	$7,$0
$L1760:
	addiu	$3,$4,9456
	beq	$2,$0,$L1771
	addiu	$5,$4,9136

	li	$6,65536			# 0x10000
	addu	$6,$4,$6
	lw	$6,-6264($6)
	andi	$6,$6,0x100
	bne	$6,$0,$L1804
	move	$6,$5

$L1772:
	li	$8,65536			# 0x10000
	addu	$8,$4,$8
	lw	$8,-6260($8)
	andi	$8,$8,0x100
	bne	$8,$0,$L1877
	lw	$8,8($sp)

$L1778:
	li	$8,65536			# 0x10000
	addu	$8,$4,$8
	lw	$8,-6256($8)
	andi	$8,$8,0x100
	bne	$8,$0,$L1878
	lw	$8,12($sp)

$L1785:
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$2,-6252($2)
	andi	$2,$2,0x100
	beq	$2,$0,$L1805
	lw	$2,12($sp)

	b	$L1886
	li	$8,65536			# 0x10000

$L1771:
	move	$6,$5
$L1804:
	lw	$8,8($sp)
	li	$10,65536			# 0x10000
	addu	$10,$4,$10
	li	$13,20744			# 0x5108
	andi	$8,$8,0x7
	sw	$13,-6264($10)
	sh	$0,52($3)
	bne	$8,$0,$L1765
	sh	$0,60($3)

	lb	$8,0($9)
	bltz	$8,$L1855
	move	$14,$fp

	sll	$8,$8,1
	sra	$8,$8,$7
	sll	$8,$8,2
	addu	$8,$11,$8
	lw	$8,0($8)
	move	$14,$12
$L1769:
	sll	$10,$8,8
	addu	$10,$10,$8
	andi	$10,$10,0xffff
	sh	$10,20($3)
	sh	$10,12($3)
	lh	$10,2($14)
	sll	$8,$8,2
	sll	$10,$10,$7
	addu	$8,$15,$8
	srl	$13,$10,31
	addu	$10,$13,$10
	lh	$14,0($14)
	lw	$13,0($8)
	sra	$8,$10,1
	mul	$10,$13,$8
	mul	$13,$13,$14
	addiu	$10,$10,128
	addiu	$13,$13,128
	sra	$13,$13,8
	sra	$10,$10,8
	subu	$8,$10,$8
	subu	$14,$13,$14
	andi	$14,$14,0xffff
	andi	$13,$13,0xffff
	sll	$8,$8,16
	sll	$10,$10,16
	addu	$10,$10,$13
	addu	$8,$8,$14
	addiu	$13,$5,208
	addiu	$14,$5,48
	sw	$10,48($5)
	sw	$10,36($14)
	sw	$10,4($14)
	sw	$10,32($14)
	sw	$8,208($5)
	sw	$8,36($13)
	sw	$8,4($13)
	sw	$8,32($13)
$L1768:
	bne	$2,$0,$L1772
	lw	$8,8($sp)

$L1877:
	li	$10,65536			# 0x10000
	addu	$10,$4,$10
	li	$13,20744			# 0x5108
	andi	$8,$8,0x7
	sw	$13,-6260($10)
	sh	$0,54($3)
	bne	$8,$0,$L1773
	sh	$0,62($3)

	lb	$8,1($9)
	bltz	$8,$L1856
	move	$14,$fp

	sll	$8,$8,1
	sra	$8,$8,$7
	sll	$8,$8,2
	addu	$8,$11,$8
	lw	$8,0($8)
	move	$14,$12
$L1777:
	sll	$10,$8,8
	addu	$10,$10,$8
	andi	$10,$10,0xffff
	sh	$10,22($3)
	sh	$10,14($3)
	lh	$10,14($14)
	sll	$8,$8,2
	sll	$10,$10,$7
	addu	$8,$15,$8
	srl	$13,$10,31
	addu	$10,$13,$10
	lh	$14,12($14)
	lw	$13,0($8)
	sra	$8,$10,1
	mul	$10,$13,$8
	mul	$13,$13,$14
	addiu	$10,$10,128
	addiu	$13,$13,128
	sra	$13,$13,8
	sra	$10,$10,8
	subu	$8,$10,$8
	subu	$14,$13,$14
	andi	$14,$14,0xffff
	andi	$13,$13,0xffff
	sll	$8,$8,16
	sll	$10,$10,16
	addu	$10,$10,$13
	addu	$8,$8,$14
	addiu	$13,$5,216
	addiu	$14,$5,56
	sw	$10,56($5)
	sw	$10,36($14)
	sw	$10,4($14)
	sw	$10,32($14)
	sw	$8,216($5)
	sw	$8,36($13)
	sw	$8,4($13)
	sw	$8,32($13)
$L1776:
	bne	$2,$0,$L1778
	lw	$8,12($sp)

$L1878:
	li	$10,65536			# 0x10000
	addu	$10,$4,$10
	li	$13,20744			# 0x5108
	andi	$8,$8,0x7
	sw	$13,-6256($10)
	sh	$0,68($3)
	bne	$8,$0,$L1780
	sh	$0,76($3)

	lw	$8,9752($4)
	li	$10,2			# 0x2
	sra	$10,$10,$7
	mul	$10,$10,$8
	addu	$8,$9,$10
	lb	$8,0($8)
	bltz	$8,$L1857
	addu	$10,$23,$10

	sll	$8,$8,1
	sra	$8,$8,$7
	sll	$8,$8,2
	addu	$8,$11,$8
	lw	$8,0($8)
	move	$14,$12
$L1784:
	lw	$13,9748($4)
	li	$10,6			# 0x6
	sra	$10,$10,$7
	mul	$10,$10,$13
	sll	$13,$8,8
	addu	$13,$13,$8
	andi	$13,$13,0xffff
	sll	$10,$10,2
	addu	$10,$14,$10
	sh	$13,36($3)
	sh	$13,28($3)
	lh	$13,2($10)
	sll	$8,$8,2
	sll	$13,$13,$7
	addu	$14,$15,$8
	srl	$8,$13,31
	addu	$8,$8,$13
	lw	$13,0($14)
	lh	$14,0($10)
	sra	$8,$8,1
	mul	$10,$13,$8
	mul	$13,$13,$14
	addiu	$10,$10,128
	addiu	$13,$13,128
	sra	$13,$13,8
	sra	$10,$10,8
	subu	$8,$10,$8
	subu	$14,$13,$14
	andi	$14,$14,0xffff
	andi	$13,$13,0xffff
	sll	$8,$8,16
	sll	$10,$10,16
	addu	$10,$10,$13
	addu	$8,$8,$14
	addiu	$13,$5,272
	addiu	$14,$5,112
	sw	$10,112($5)
	sw	$10,36($14)
	sw	$10,4($14)
	sw	$10,32($14)
	sw	$8,272($5)
	sw	$8,36($13)
	sw	$8,4($13)
	sw	$8,32($13)
$L1783:
	bne	$2,$0,$L1785
	lw	$2,12($sp)

	li	$8,65536			# 0x10000
$L1886:
	addu	$8,$4,$8
	li	$10,20744			# 0x5108
	andi	$2,$2,0x7
	sw	$10,-6252($8)
	sh	$0,70($3)
	beq	$2,$0,$L1788
	sh	$0,78($3)

	addiu	$4,$6,120
	addiu	$2,$6,280
	sw	$0,120($6)
	sh	$0,38($3)
	sw	$0,36($4)
	sw	$0,4($4)
	sw	$0,32($4)
	sh	$0,30($3)
	sw	$0,280($6)
	sw	$0,36($2)
	sw	$0,4($2)
	b	$L1805
	sw	$0,32($2)

$L1798:
	lw	$25,9752($4)
	sra	$19,$5,1
	mul	$10,$19,$25
	andi	$18,$5,0x1
	addu	$25,$10,$18
	addu	$10,$9,$25
	lb	$10,0($10)
	bltz	$10,$L1799
	lw	$17,44($sp)

	sll	$10,$10,2
	addu	$10,$11,$10
	lw	$10,0($10)
	move	$25,$12
$L1800:
	sll	$20,$10,8
	addu	$20,$20,$10
	sll	$10,$10,2
	andi	$20,$20,0xffff
	addu	$17,$13,$22
	addu	$10,$15,$10
	sh	$20,8($17)
	lw	$10,0($10)
	bne	$24,$0,$L1801
	sh	$20,0($17)

	lw	$17,9748($4)
	sll	$19,$19,1
	mul	$20,$19,$17
	sll	$18,$18,1
	addu	$17,$20,$18
	sll	$17,$17,2
	addu	$17,$25,$17
	lh	$21,0($17)
	sll	$20,$22,2
	mul	$21,$10,$21
	addu	$20,$8,$20
	addiu	$21,$21,128
	sra	$21,$21,8
	sh	$21,0($20)
	lh	$21,2($17)
	lh	$23,0($20)
	mul	$21,$10,$21
	addiu	$22,$22,40
	addiu	$21,$21,128
	sra	$21,$21,8
	sll	$21,$21,16
	sra	$21,$21,16
	sh	$21,2($20)
	lh	$20,0($17)
	lh	$17,2($17)
	subu	$20,$23,$20
	subu	$17,$21,$17
	andi	$20,$20,0xffff
	sll	$22,$22,2
	sll	$17,$17,16
	addu	$17,$17,$20
	addu	$22,$8,$22
	sw	$17,0($22)
	lw	$17,9748($4)
	addiu	$21,$18,1
	mul	$20,$19,$17
	lbu	$22,1($6)
	addu	$17,$20,$21
	sll	$17,$17,2
	addu	$17,$25,$17
	sw	$22,32($sp)
	lh	$22,0($17)
	lw	$23,32($sp)
	mul	$22,$10,$22
	sll	$20,$23,2
	addiu	$22,$22,128
	addu	$20,$8,$20
	sra	$22,$22,8
	sh	$22,0($20)
	lh	$22,2($17)
	lh	$23,0($20)
	mul	$22,$10,$22
	sw	$23,40($sp)
	addiu	$22,$22,128
	sra	$22,$22,8
	lw	$23,32($sp)
	sll	$22,$22,16
	sra	$22,$22,16
	sh	$22,2($20)
	addiu	$23,$23,40
	lh	$20,0($17)
	sw	$23,32($sp)
	lw	$23,40($sp)
	lh	$17,2($17)
	subu	$20,$23,$20
	lw	$23,32($sp)
	subu	$22,$22,$17
	sll	$22,$22,16
	sll	$17,$23,2
	andi	$20,$20,0xffff
	addu	$20,$22,$20
	addu	$17,$8,$17
	sw	$20,0($17)
	lw	$17,9748($4)
	addiu	$19,$19,1
	mul	$20,$19,$17
	lbu	$22,2($6)
	addu	$18,$20,$18
	sll	$18,$18,2
	addu	$18,$25,$18
	lh	$20,0($18)
	sll	$17,$22,2
	mul	$20,$10,$20
	addu	$17,$8,$17
	addiu	$20,$20,128
	sra	$20,$20,8
	sh	$20,0($17)
	lh	$20,2($18)
	lh	$23,0($17)
	mul	$20,$10,$20
	addiu	$22,$22,40
	addiu	$20,$20,128
	sra	$20,$20,8
	sll	$20,$20,16
	sra	$20,$20,16
	sh	$20,2($17)
	lh	$17,0($18)
	lh	$18,2($18)
	subu	$17,$23,$17
	subu	$18,$20,$18
	sll	$18,$18,16
	sll	$22,$22,2
	andi	$17,$17,0xffff
	addu	$17,$18,$17
	addu	$22,$8,$22
	sw	$17,0($22)
	lw	$17,9748($4)
	lbu	$18,3($6)
	mul	$20,$19,$17
	sll	$17,$18,2
	addu	$19,$20,$21
	sll	$19,$19,2
	addu	$25,$25,$19
	lh	$19,0($25)
	addu	$17,$8,$17
	mul	$19,$10,$19
	addiu	$18,$18,40
	addiu	$19,$19,128
	sra	$19,$19,8
	sh	$19,0($17)
	lh	$19,2($25)
	lh	$20,0($17)
	mul	$10,$10,$19
	sll	$18,$18,2
	addiu	$10,$10,128
	sra	$10,$10,8
	sll	$10,$10,16
	sra	$10,$10,16
	sh	$10,2($17)
	lh	$17,2($25)
	lh	$19,0($25)
	subu	$10,$10,$17
	subu	$25,$20,$19
	sll	$10,$10,16
	andi	$25,$25,0xffff
	addu	$18,$8,$18
	addu	$10,$10,$25
	b	$L1797
	sw	$10,0($18)

$L1721:
	andi	$5,$13,0x00ff
	andi	$3,$3,0x7
	sll	$25,$6,8
	sll	$24,$5,8
	sw	$3,32($sp)
	li	$3,131072			# 0x20000
	addu	$25,$25,$6
	addu	$24,$24,$5
	addu	$3,$4,$3
	li	$5,59272			# 0xe788
	lui	$6,%hi(scan8)
	sw	$3,40($sp)
	andi	$25,$25,0xffff
	andi	$24,$24,0xffff
	addu	$5,$4,$5
	addiu	$6,$6,%lo(scan8)
	addiu	$14,$4,9136
	addiu	$15,$4,9456
	move	$3,$0
$L1751:
	beq	$2,$0,$L1879
	lw	$22,20($sp)

	lw	$7,0($5)
	andi	$7,$7,0x100
	beq	$7,$0,$L1731
	nop

$L1879:
	lbu	$7,0($6)
	lhu	$21,16($sp)
	lw	$20,28($sp)
	lhu	$19,24($sp)
	addiu	$10,$7,40
	sll	$22,$22,16
	addu	$21,$22,$21
	sll	$20,$20,16
	sll	$17,$10,2
	sll	$18,$7,2
	lw	$22,32($sp)
	addu	$19,$20,$19
	addu	$18,$14,$18
	addu	$17,$14,$17
	addu	$10,$15,$10
	addu	$20,$15,$7
	sw	$11,0($5)
	sh	$25,8($20)
	sw	$21,36($18)
	sw	$21,0($18)
	sw	$21,4($18)
	sw	$21,32($18)
	sh	$25,0($20)
	sw	$19,36($17)
	sh	$24,8($10)
	sw	$19,0($17)
	sw	$19,4($17)
	sw	$19,32($17)
	bne	$22,$0,$L1731
	sh	$24,0($10)

	lw	$18,9752($4)
	sra	$19,$3,1
	mul	$10,$19,$18
	andi	$17,$3,0x1
	addu	$18,$10,$17
	addu	$10,$9,$18
	lb	$10,0($10)
	bne	$10,$0,$L1732
	nop

	bne	$16,$0,$L1735
	move	$10,$12

$L1858:
	lw	$18,9748($4)
	sll	$19,$19,1
	mul	$20,$19,$18
	sll	$17,$17,1
	addu	$21,$20,$17
	sll	$21,$21,2
	addu	$21,$10,$21
	lhu	$22,0($21)
	addiu	$22,$22,1
	andi	$22,$22,0xffff
	sltu	$22,$22,3
	beq	$22,$0,$L1736
	nop

	lhu	$21,2($21)
	addiu	$21,$21,1
	andi	$21,$21,0xffff
	sltu	$21,$21,3
	beq	$21,$0,$L1736
	nop

	bne	$8,$0,$L1739
	sll	$18,$7,2

	addu	$18,$14,$18
	sw	$0,0($18)
$L1739:
	bne	$13,$0,$L1820
	addiu	$7,$7,40

	sll	$7,$7,2
	addu	$7,$14,$7
	sw	$0,0($7)
$L1820:
	lw	$18,9748($4)
	mul	$20,$19,$18
$L1736:
	addiu	$7,$17,1
	addu	$20,$20,$7
	sll	$20,$20,2
	addu	$20,$10,$20
	lhu	$21,0($20)
	addiu	$21,$21,1
	andi	$21,$21,0xffff
	sltu	$21,$21,3
	beq	$21,$0,$L1740
	nop

	lhu	$20,2($20)
	addiu	$20,$20,1
	andi	$20,$20,0xffff
	sltu	$20,$20,3
	beq	$20,$0,$L1740
	nop

	bne	$8,$0,$L1743
	nop

	lbu	$18,1($6)
	sll	$18,$18,2
	addu	$18,$14,$18
	sw	$0,0($18)
$L1743:
	bne	$13,$0,$L1821
	nop

	lbu	$18,1($6)
	addiu	$18,$18,40
	sll	$18,$18,2
	addu	$18,$14,$18
	sw	$0,0($18)
$L1821:
	lw	$18,9748($4)
$L1740:
	addiu	$19,$19,1
	mul	$18,$18,$19
	addu	$17,$18,$17
	sll	$17,$17,2
	addu	$17,$10,$17
	lhu	$20,0($17)
	addiu	$20,$20,1
	andi	$20,$20,0xffff
	sltu	$20,$20,3
	beq	$20,$0,$L1744
	nop

	lhu	$17,2($17)
	addiu	$17,$17,1
	andi	$17,$17,0xffff
	sltu	$17,$17,3
	beq	$17,$0,$L1744
	nop

	bne	$8,$0,$L1747
	nop

	lbu	$17,2($6)
	sll	$17,$17,2
	addu	$17,$14,$17
	sw	$0,0($17)
$L1747:
	bne	$13,$0,$L1822
	nop

	lbu	$17,2($6)
	addiu	$17,$17,40
	sll	$17,$17,2
	addu	$17,$14,$17
	sw	$0,0($17)
$L1822:
	lw	$18,9748($4)
	mul	$18,$19,$18
$L1744:
	addu	$18,$18,$7
	sll	$18,$18,2
	addu	$10,$10,$18
	lhu	$7,0($10)
	addiu	$7,$7,1
	andi	$7,$7,0xffff
	sltu	$7,$7,3
	beq	$7,$0,$L1731
	nop

	lhu	$7,2($10)
	addiu	$7,$7,1
	andi	$7,$7,0xffff
	sltu	$7,$7,3
	beq	$7,$0,$L1731
	nop

	bne	$8,$0,$L1749
	nop

	lbu	$7,3($6)
	sll	$7,$7,2
	addu	$7,$14,$7
	sw	$0,0($7)
$L1749:
	bne	$13,$0,$L1731
	nop

	lbu	$7,3($6)
	addiu	$7,$7,40
	sll	$7,$7,2
	addu	$7,$14,$7
	sw	$0,0($7)
$L1731:
	addiu	$3,$3,1
	li	$21,4			# 0x4
	addiu	$5,$5,4
	bne	$3,$21,$L1751
	addiu	$6,$6,4

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

$L1732:
	bgez	$10,$L1731
	addu	$18,$23,$18

	lb	$10,0($18)
	bne	$10,$0,$L1731
	lw	$18,40($sp)

	lw	$10,9372($18)
	slt	$18,$10,34
	beq	$18,$0,$L1734
	nop

	bne	$10,$0,$L1731
	nop

$L1734:
	beq	$16,$0,$L1858
	move	$10,$fp

$L1735:
	lw	$18,9748($4)
	mul	$20,$19,$18
	addu	$17,$20,$17
	sll	$19,$17,1
	addu	$17,$19,$17
	sll	$17,$17,2
	addu	$10,$10,$17
	lhu	$17,0($10)
	addiu	$17,$17,1
	andi	$17,$17,0xffff
	sltu	$17,$17,3
	beq	$17,$0,$L1731
	nop

	lhu	$10,2($10)
	addiu	$10,$10,1
	andi	$10,$10,0xffff
	sltu	$10,$10,3
	beq	$10,$0,$L1731
	nop

	bne	$8,$0,$L1750
	sll	$10,$7,2

	addu	$10,$14,$10
	sw	$0,36($10)
	sw	$0,0($10)
	sw	$0,4($10)
	sw	$0,32($10)
$L1750:
	bne	$13,$0,$L1731
	addiu	$7,$7,40

	sll	$7,$7,2
	addu	$7,$14,$7
	sw	$0,36($7)
	sw	$0,0($7)
	sw	$0,4($7)
	b	$L1731
	sw	$0,32($7)

$L1851:
	lb	$19,9507($4)
	lb	$20,9500($4)
	lb	$21,9504($4)
$L1803:
	li	$6,65536			# 0x10000
	addu	$6,$4,$6
	addiu	$22,$sp,24
	addiu	$7,$sp,28
	lw	$10,-6276($6)
	sw	$22,44($sp)
	sw	$7,40($sp)
	addiu	$22,$15,204
	addiu	$7,$15,176
	sw	$7,64($sp)
	sw	$22,68($sp)
	beq	$10,$0,$L1695
	move	$7,$21

	sw	$0,200($15)
	lw	$6,-6272($6)
	lw	$10,1880($4)
	sw	$6,32($sp)
	lw	$22,104($10)
	sw	$10,36($sp)
	lw	$10,32($sp)
	addiu	$6,$15,200
	bne	$10,$0,$L1696
	sw	$22,52($sp)

	lw	$22,6172($4)
	andi	$10,$22,0x1
	beq	$10,$0,$L1696
	sw	$22,48($sp)

	li	$10,-2			# 0xfffffffffffffffe
	beq	$21,$10,$L1697
	addiu	$22,$22,-1

	lw	$10,6168($4)
	lw	$21,152($4)
	mtlo	$10
	madd	$22,$21
	sw	$10,32($sp)
	mflo	$10
	sw	$22,72($sp)
	lw	$22,52($sp)
	sw	$21,56($sp)
	sll	$21,$10,2
	addu	$21,$22,$21
	lw	$21,0($21)
	andi	$21,$21,0x80
	beq	$21,$0,$L1698
	lw	$10,48($sp)

	lw	$7,32($sp)
	sll	$21,$7,2
	addiu	$21,$21,4
	sll	$15,$10,2
	sra	$7,$21,2
	mtlo	$7
	addiu	$15,$15,-1
	lw	$7,56($sp)
	sra	$22,$15,2
	madd	$22,$7
	lw	$10,52($sp)
	mflo	$7
	sw	$7,32($sp)
	sll	$7,$7,2
	addu	$7,$10,$7
	lw	$22,0($7)
	andi	$7,$22,0xc000
	beq	$7,$0,$L1828
	nop

$L1703:
	lw	$7,9748($4)
	lw	$10,36($sp)
	lw	$22,100($10)
	mul	$10,$15,$7
	sra	$15,$15,1
	addu	$7,$10,$21
	sll	$7,$7,2
	addu	$7,$22,$7
	lhu	$22,0($7)
	lw	$10,36($sp)
	sh	$22,9336($4)
	lhu	$7,2($7)
	lw	$10,192($10)
	sh	$7,32($sp)
	lw	$7,9752($4)
	sra	$21,$21,1
	mul	$22,$15,$7
	addu	$15,$22,$10
	lhu	$10,32($sp)
	addu	$15,$15,$21
	sll	$7,$10,1
	sh	$7,9338($4)
	lb	$7,0($15)
	b	$L1701
	sra	$7,$7,1

$L1696:
	li	$22,-2			# 0xfffffffffffffffe
	beq	$21,$22,$L1859
	nop

$L1698:
	addiu	$6,$15,192
$L1701:
	xor	$15,$19,$18
	xor	$21,$20,$18
	sltu	$22,$15,1
	sltu	$21,$21,1
	xor	$15,$7,$18
	sltu	$15,$15,1
	addu	$21,$22,$21
	addu	$21,$21,$15
	slt	$15,$21,2
	bne	$15,$0,$L1704
	li	$15,1			# 0x1

	lw	$18,68($sp)
	lw	$19,64($sp)
	lh	$7,0($18)
	lh	$15,0($19)
	slt	$19,$15,$7
	beq	$19,$0,$L1705
	lh	$18,0($6)

	slt	$19,$15,$18
	bne	$19,$0,$L1860
	nop

$L1706:
	lw	$20,68($sp)
$L1880:
	lw	$21,64($sp)
	lh	$10,2($20)
	lh	$7,2($21)
	lw	$22,44($sp)
	lh	$6,2($6)
	sw	$15,0($22)
	slt	$15,$7,$10
	beq	$15,$0,$L1707
	slt	$15,$6,$7

	slt	$15,$7,$6
	beq	$15,$0,$L1708
	nop

	slt	$7,$10,$6
	movz	$10,$6,$7
	move	$7,$10
$L1708:
	lw	$6,40($sp)
	sw	$7,0($6)
$L1861:
	bgez	$13,$L1718
	nop

$L1852:
	lw	$7,0($5)
	li	$6,-16385			# 0xffffffffffffbfff
	and	$6,$7,$6
	sw	$6,0($5)
	move	$16,$25
	b	$L1719
	move	$11,$17

$L1801:
	lw	$17,9748($4)
	addiu	$20,$22,40
	mul	$21,$19,$17
	sll	$20,$20,2
	addu	$19,$21,$18
	sll	$18,$19,1
	addu	$19,$18,$19
	sll	$19,$19,2
	addu	$25,$25,$19
	lh	$19,0($25)
	lh	$21,2($25)
	mul	$18,$10,$19
	mul	$17,$10,$21
	addiu	$18,$18,128
	addiu	$17,$17,128
	sra	$18,$18,8
	sra	$17,$17,8
	subu	$25,$17,$21
	subu	$19,$18,$19
	sll	$25,$25,16
	andi	$19,$19,0xffff
	sll	$17,$17,16
	andi	$18,$18,0xffff
	sll	$22,$22,2
	addu	$17,$17,$18
	addu	$25,$25,$19
	addu	$22,$8,$22
	addu	$10,$8,$20
	sw	$17,36($22)
	sw	$17,0($22)
	sw	$17,4($22)
	sw	$17,32($22)
	sw	$25,36($10)
	sw	$25,0($10)
	sw	$25,4($10)
	b	$L1797
	sw	$25,32($10)

$L1695:
	li	$6,-2			# 0xfffffffffffffffe
	bne	$21,$6,$L1698
	nop

$L1702:
	addiu	$6,$15,172
	b	$L1701
	lb	$7,9499($4)

$L1850:
	slt	$19,$6,$7
	beq	$19,$0,$L1681
	lw	$22,32($sp)

	slt	$7,$6,$10
	movz	$10,$6,$7
	move	$7,$10
	b	$L1671
	sw	$7,0($22)

$L1849:
	slt	$22,$10,$6
	beq	$22,$0,$L1682
	nop

	slt	$6,$10,$7
	movz	$7,$10,$6
	b	$L1682
	move	$6,$7

$L1720:
	lw	$7,0($5)
	and	$6,$7,$6
	b	$L1719
	sw	$6,0($5)

$L1705:
	slt	$19,$18,$15
	beq	$19,$0,$L1880
	lw	$20,68($sp)

	slt	$15,$18,$7
	movz	$7,$18,$15
	b	$L1880
	move	$15,$7

$L1707:
	beq	$15,$0,$L1708
	nop

	slt	$7,$6,$10
	movz	$10,$6,$7
	lw	$6,40($sp)
	move	$7,$10
	b	$L1861
	sw	$7,0($6)

$L1799:
	lw	$20,36($sp)
	addu	$25,$17,$25
	lb	$10,0($25)
	move	$25,$fp
	sll	$10,$10,2
	addu	$10,$20,$10
	b	$L1800
	lw	$10,0($10)

$L1844:
	move	$7,$0
	move	$2,$0
	b	$L1793
	move	$3,$0

$L1704:
	beq	$21,$15,$L1862
	li	$15,-2			# 0xfffffffffffffffe

	beq	$20,$15,$L1863
	lw	$22,68($sp)

$L1883:
	lw	$10,64($sp)
	lh	$7,0($22)
	lh	$15,0($10)
	slt	$19,$15,$7
	beq	$19,$0,$L1714
	lh	$18,0($6)

	slt	$19,$15,$18
	beq	$19,$0,$L1715
	nop

	slt	$15,$7,$18
	movz	$7,$18,$15
	move	$15,$7
$L1715:
	lw	$18,68($sp)
	lw	$19,64($sp)
	lh	$10,2($18)
	lh	$7,2($19)
	lw	$20,44($sp)
	lh	$6,2($6)
	sw	$15,0($20)
	slt	$15,$7,$10
	beq	$15,$0,$L1716
	slt	$15,$6,$7

	slt	$15,$7,$6
	beq	$15,$0,$L1881
	lw	$21,40($sp)

	slt	$7,$10,$6
	movz	$10,$6,$7
	move	$7,$10
$L1881:
	b	$L1709
	sw	$7,0($21)

$L1848:
	beq	$20,$21,$L1665
	li	$22,-2			# 0xfffffffffffffffe

	bne	$10,$22,$L1664
	nop

	bne	$7,$10,$L1664
	nop

	beq	$6,$7,$L1664
	lw	$6,68($sp)

	lw	$10,32($sp)
	lh	$7,2($6)
	lw	$19,40($sp)
	lh	$6,9180($4)
	sw	$7,0($10)
	b	$L1671
	sw	$6,0($19)

$L1756:
	lw	$24,6172($4)
	lw	$13,152($4)
	lw	$7,9748($4)
	li	$10,131072			# 0x20000
	addu	$10,$4,$10
	andi	$24,$24,0x1
	li	$6,2			# 0x2
	li	$14,1			# 0x1
	movn	$6,$14,$24
	addu	$3,$3,$13
	sll	$7,$7,1
	lw	$13,-13528($10)
	lw	$10,9752($4)
	mul	$7,$7,$6
	sll	$3,$3,2
	mul	$6,$6,$10
	addu	$3,$13,$3
	lw	$3,0($3)
	sll	$7,$7,2
	andi	$10,$3,0x1f
	addu	$23,$23,$6
	addu	$fp,$fp,$7
	sw	$3,12($sp)
	sw	$3,8($sp)
	addu	$9,$9,$6
	beq	$10,$0,$L1763
	addu	$12,$12,$7

	bne	$2,$0,$L1763
	nop

	ori	$8,$8,0x8
	sw	$8,0($5)
	li	$7,2			# 0x2
$L1759:
	addiu	$6,$4,9136
	addiu	$3,$4,9456
	b	$L1804
	move	$5,$6

$L1723:
	bgez	$2,$L1869
	lw	$3,28($sp)

	lb	$2,0($23)
	bne	$2,$0,$L1882
	lw	$2,20($sp)

	lhu	$2,0($fp)
	addiu	$2,$2,1
	andi	$2,$2,0xffff
	sltu	$2,$2,3
	beq	$2,$0,$L1882
	lw	$2,20($sp)

	lhu	$2,2($fp)
	addiu	$2,$2,1
	andi	$2,$2,0xffff
	sltu	$2,$2,3
	beq	$2,$0,$L1882
	lw	$2,20($sp)

	li	$2,131072			# 0x20000
	addu	$2,$4,$2
	lw	$2,9372($2)
	slt	$3,$2,34
	beq	$3,$0,$L1724
	nop

	bne	$2,$0,$L1869
	lw	$3,28($sp)

$L1724:
	blez	$8,$L1864
	lhu	$3,16($sp)

	lw	$2,20($sp)
	sll	$2,$2,16
	addu	$2,$2,$3
$L1726:
	blez	$13,$L1865
	lhu	$5,24($sp)

	lw	$3,28($sp)
	sll	$3,$3,16
	b	$L1728
	addu	$3,$3,$5

$L1765:
	addiu	$10,$6,48
	addiu	$8,$6,208
	sw	$0,48($6)
	sh	$0,12($3)
	sw	$0,36($10)
	sw	$0,4($10)
	sw	$0,32($10)
	sh	$0,20($3)
	sw	$0,208($6)
	sw	$0,36($8)
	sw	$0,4($8)
	b	$L1768
	sw	$0,32($8)

$L1860:
	slt	$15,$7,$18
	movz	$7,$18,$15
	b	$L1706
	move	$15,$7

$L1763:
	ori	$8,$8,0x40
	sw	$8,0($5)
	b	$L1760
	li	$7,2			# 0x2

$L1853:
	lhu	$2,2($12)
	addiu	$2,$2,1
	andi	$2,$2,0xffff
	sltu	$2,$2,3
	bne	$2,$0,$L1724
	lw	$3,28($sp)

	b	$L1882
	lw	$2,20($sp)

$L1859:
	lw	$21,6172($4)
	andi	$7,$21,0x1
	beq	$7,$0,$L1702
	sw	$21,48($sp)

$L1697:
	lb	$21,9507($4)
	li	$7,-2			# 0xfffffffffffffffe
	beq	$21,$7,$L1702
	lw	$22,32($sp)

	bne	$22,$0,$L1702
	lw	$10,52($sp)

	lw	$7,8768($4)
	sll	$7,$7,2
	addu	$7,$10,$7
	lw	$7,0($7)
	andi	$7,$7,0x80
	beq	$7,$0,$L1702
	lw	$22,48($sp)

	lw	$21,6168($4)
	sll	$21,$21,2
	ori	$15,$22,0x1
	addiu	$21,$21,-1
	sra	$10,$21,2
	sll	$15,$15,2
	mtlo	$10
	addiu	$15,$15,1
	lw	$10,152($4)
	sra	$7,$15,2
	madd	$7,$10
	lw	$22,52($sp)
	mflo	$10
	sll	$7,$10,2
	addu	$7,$22,$7
	lw	$22,0($7)
	andi	$7,$22,0xc000
	bne	$7,$0,$L1703
	sw	$10,32($sp)

$L1828:
	andi	$7,$22,0x40
	bne	$7,$0,$L1703
	nop

	b	$L1701
	li	$7,-1			# 0xffffffffffffffff

$L1854:
	lw	$22,6172($4)
	andi	$7,$22,0x1
	beq	$7,$0,$L1685
	sw	$22,48($sp)

$L1691:
	lb	$22,9467($4)
	li	$7,-2			# 0xfffffffffffffffe
	beq	$22,$7,$L1685
	nop

	bne	$20,$0,$L1685
	lw	$22,52($sp)

	lw	$7,8768($4)
	sll	$7,$7,2
	addu	$7,$22,$7
	lw	$7,0($7)
	andi	$7,$7,0x80
	beq	$7,$0,$L1685
	lw	$21,48($sp)

	lw	$20,6168($4)
	ori	$7,$21,0x1
	sll	$22,$20,2
	sll	$7,$7,2
	addiu	$7,$7,1
	addiu	$20,$22,-1
	sw	$7,44($sp)
	sra	$22,$7,2
	sra	$7,$20,2
	mtlo	$7
	lw	$7,152($4)
	lw	$21,52($sp)
	madd	$22,$7
	mflo	$7
	sw	$7,48($sp)
	sll	$7,$7,2
	addu	$7,$21,$7
	lw	$22,0($7)
	andi	$7,$22,0x3000
	beq	$7,$0,$L1688
	nop

	lw	$22,36($sp)
$L1885:
	lw	$21,44($sp)
	lw	$7,9748($4)
	lw	$22,96($22)
	sw	$22,48($sp)
	mul	$22,$21,$7
	lw	$21,36($sp)
	addu	$7,$22,$20
	lw	$22,48($sp)
	sll	$7,$7,2
	addu	$7,$22,$7
	lw	$21,188($21)
	lhu	$22,0($7)
	sw	$21,52($sp)
	lw	$21,44($sp)
	sh	$22,9176($4)
	lhu	$22,2($7)
	sra	$7,$21,1
	lw	$21,52($sp)
	mtlo	$21
	lw	$21,9752($4)
	madd	$7,$21
	sll	$7,$22,1
	mflo	$21
	sra	$22,$20,1
	sw	$21,44($sp)
	sh	$7,9178($4)
	addu	$22,$21,$22
	lb	$7,0($22)
	b	$L1683
	sra	$7,$7,1

$L1665:
	beq	$8,$6,$L1675
	lw	$20,68($sp)

	beq	$8,$10,$L1676
	lw	$20,32($sp)

	lh	$7,2($19)
	lh	$6,0($19)
	lw	$21,40($sp)
	sw	$7,0($20)
	b	$L1671
	sw	$6,0($21)

$L1862:
	beq	$19,$18,$L1866
	lw	$10,68($sp)

	beq	$20,$18,$L1867
	lw	$10,40($sp)

	lh	$7,2($6)
	lh	$6,0($6)
	lw	$18,44($sp)
	sw	$7,0($10)
	b	$L1709
	sw	$6,0($18)

$L1788:
	lw	$2,9752($4)
	li	$6,2			# 0x2
	sra	$6,$6,$7
	mul	$6,$6,$2
	addiu	$6,$6,1
	addu	$9,$9,$6
	lb	$2,0($9)
	bltz	$2,$L1789
	addu	$6,$23,$6

	sll	$2,$2,1
	sra	$2,$2,$7
	sll	$2,$2,2
	addu	$11,$11,$2
	lw	$2,0($11)
$L1790:
	lw	$4,9748($4)
	li	$6,6			# 0x6
	sra	$6,$6,$7
	mul	$6,$6,$4
	sll	$4,$2,8
	addu	$4,$4,$2
	addiu	$6,$6,3
	andi	$4,$4,0xffff
	sll	$6,$6,2
	sh	$4,38($3)
	sh	$4,30($3)
	addu	$12,$12,$6
	lh	$3,2($12)
	sll	$2,$2,2
	sll	$7,$3,$7
	addu	$15,$15,$2
	srl	$2,$7,31
	lw	$4,0($15)
	lh	$6,0($12)
	addu	$7,$2,$7
	sra	$2,$7,1
	mul	$3,$4,$2
	mul	$4,$4,$6
	addiu	$3,$3,128
	addiu	$4,$4,128
	sra	$4,$4,8
	sra	$3,$3,8
	subu	$2,$3,$2
	subu	$6,$4,$6
	andi	$6,$6,0xffff
	andi	$4,$4,0xffff
	sll	$2,$2,16
	sll	$3,$3,16
	addu	$3,$3,$4
	addu	$2,$2,$6
	addiu	$4,$5,280
	addiu	$6,$5,120
	sw	$3,120($5)
	sw	$3,36($6)
	sw	$3,4($6)
	sw	$3,32($6)
	sw	$2,280($5)
	sw	$2,36($4)
	sw	$2,4($4)
	b	$L1805
	sw	$2,32($4)

$L1773:
	addiu	$10,$6,56
	addiu	$8,$6,216
	sw	$0,56($6)
	sh	$0,14($3)
	sw	$0,36($10)
	sw	$0,4($10)
	sw	$0,32($10)
	sh	$0,22($3)
	sw	$0,216($6)
	sw	$0,36($8)
	sw	$0,4($8)
	b	$L1776
	sw	$0,32($8)

$L1780:
	addiu	$10,$6,112
	addiu	$8,$6,272
	sw	$0,112($6)
	sh	$0,28($3)
	sw	$0,36($10)
	sw	$0,4($10)
	sw	$0,32($10)
	sh	$0,36($3)
	sw	$0,272($6)
	sw	$0,36($8)
	sw	$0,4($8)
	b	$L1783
	sw	$0,32($8)

$L1846:
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	sw	$0,16($sp)
	move	$8,$0
	b	$L1661
	move	$13,$0

$L1794:
	lb	$2,0($23)
	move	$12,$fp
	sll	$2,$2,2
	addu	$17,$17,$2
	lw	$5,0($17)
	lh	$8,0($fp)
	sll	$2,$5,2
	addu	$15,$15,$2
	b	$L1795
	lw	$3,0($15)

$L1716:
	beq	$15,$0,$L1881
	lw	$21,40($sp)

	slt	$7,$6,$10
	movz	$10,$6,$7
	move	$7,$10
	b	$L1709
	sw	$7,0($21)

$L1714:
	slt	$19,$18,$15
	beq	$19,$0,$L1715
	nop

	slt	$15,$18,$7
	movz	$7,$18,$15
	b	$L1715
	move	$15,$7

$L1863:
	bne	$7,$20,$L1883
	nop

	beq	$19,$7,$L1883
	lw	$19,68($sp)

	lw	$20,40($sp)
	lh	$7,2($19)
	lh	$6,0($19)
	lw	$21,44($sp)
	sw	$7,0($20)
	b	$L1709
	sw	$6,0($21)

$L1857:
	lb	$8,0($10)
	move	$14,$fp
	sll	$8,$8,1
	sra	$8,$8,$7
	sll	$8,$8,2
	addu	$8,$17,$8
	b	$L1784
	lw	$8,0($8)

$L1855:
	lb	$8,0($23)
	sll	$8,$8,1
	sra	$8,$8,$7
	sll	$8,$8,2
	addu	$8,$17,$8
	b	$L1769
	lw	$8,0($8)

$L1856:
	lb	$8,1($23)
	sll	$8,$8,1
	sra	$8,$8,$7
	sll	$8,$8,2
	addu	$8,$17,$8
	b	$L1777
	lw	$8,0($8)

$L1789:
	lb	$2,0($6)
	move	$12,$fp
	sll	$2,$2,1
	sra	$2,$2,$7
	sll	$2,$2,2
	addu	$17,$17,$2
	b	$L1790
	lw	$2,0($17)

$L1864:
	b	$L1726
	move	$2,$0

$L1676:
	lw	$22,64($sp)
	lh	$6,9152($4)
	lh	$7,2($22)
	lw	$10,32($sp)
	lw	$19,40($sp)
	sw	$7,0($10)
	b	$L1671
	sw	$6,0($19)

$L1867:
	lw	$20,64($sp)
	lw	$21,40($sp)
	lh	$7,2($20)
	lh	$6,0($20)
	lw	$22,44($sp)
	sw	$7,0($21)
	b	$L1709
	sw	$6,0($22)

$L1866:
	lw	$18,40($sp)
	lh	$7,2($10)
	lh	$6,0($10)
	lw	$19,44($sp)
	sw	$7,0($18)
	b	$L1709
	sw	$6,0($19)

$L1675:
	lh	$6,9180($4)
	lh	$7,2($20)
	lw	$21,32($sp)
	lw	$22,40($sp)
	sw	$7,0($21)
	b	$L1671
	sw	$6,0($22)

$L1865:
	b	$L1728
	move	$3,$0

$L1692:
	andi	$7,$21,0x40
	bne	$7,$0,$L1884
	lw	$21,36($sp)

	b	$L1683
	li	$7,-1			# 0xffffffffffffffff

$L1688:
	andi	$7,$22,0x40
	bne	$7,$0,$L1885
	lw	$22,36($sp)

	b	$L1683
	li	$7,-1			# 0xffffffffffffffff

	.set	macro
	.set	reorder
	.end	pred_direct_motion
	.size	pred_direct_motion, .-pred_direct_motion
	.section	.rodata.str1.4
	.align	2
$LC15:
	.ascii	"short term list:\012\000"
	.align	2
$LC16:
	.ascii	"%d fn:%d poc:%d %p\012\000"
	.align	2
$LC17:
	.ascii	"long term list:\012\000"
	.align	2
$LC18:
	.ascii	"reference count overflow\012\000"
	.align	2
$LC19:
	.ascii	"abs_diff_pic_num overflow\012\000"
	.align	2
$LC20:
	.ascii	"long_term_pic_idx overflow\012\000"
	.align	2
$LC21:
	.ascii	"illegal reordering_of_pic_nums_idc\012\000"
	.align	2
$LC22:
	.ascii	"reference picture missing during reorder\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_ref_pic_list_reordering
	.type	decode_ref_pic_list_reordering, @function
decode_ref_pic_list_reordering:
	.frame	$sp,112,$31		# vars= 32, regs= 10/0, args= 32, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-112
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,108($sp)
	sw	$fp,104($sp)
	sw	$23,100($sp)
	sw	$22,96($sp)
	sw	$21,92($sp)
	sw	$20,88($sp)
	sw	$19,84($sp)
	sw	$18,80($sp)
	sw	$17,76($sp)
	sw	$16,72($sp)
	.cprestore	32
	move	$16,$4
	lw	$4,0($4)
	lw	$2,412($4)
	andi	$2,$2,0x800
	bne	$2,$0,$L2007
	lw	$25,%call16(av_log)($28)

$L1888:
	li	$2,65536			# 0x10000
	addu	$3,$16,$2
	lw	$4,-6284($3)
	li	$5,1			# 0x1
	beq	$4,$5,$L1906
	nop

	li	$5,5			# 0x5
	beq	$4,$5,$L1906
	nop

	lw	$4,5944($3)
	beq	$4,$0,$L2024
	ori	$5,$2,0x1840

	ori	$4,$2,0x7e40
	ori	$22,$2,0x1730
	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	addu	$5,$16,$5
	addu	$4,$16,$4
	lw	$fp,%got(ff_log2_tab)($28)
	sw	$2,48($sp)
	sw	$5,52($sp)
	addu	$22,$16,$22
	sw	$3,44($sp)
	sw	$4,56($sp)
	move	$2,$0
	sw	$0,40($sp)
	li	$21,134217728			# 0x8000000
$L1952:
	lw	$6,0($22)
	sll	$3,$2,10
	sll	$4,$2,7
	sll	$2,$2,8
	addu	$4,$4,$3
	subu	$2,$3,$2
	sll	$3,$6,5
	sll	$6,$6,3
	subu	$3,$3,$6
	sll	$5,$2,4
	sll	$20,$4,4
	addu	$5,$2,$5
	sll	$6,$3,4
	lw	$2,56($sp)
	addu	$6,$3,$6
	addu	$20,$4,$20
	lw	$3,52($sp)
	lw	$25,%call16(memcpy)($28)
	addu	$20,$2,$20
	addu	$5,$3,$5
	jalr	$25
	move	$4,$20

	lw	$4,8456($16)
	lw	$6,8448($16)
	sra	$2,$4,3
	addu	$2,$6,$2
	lbu	$3,0($2)
	andi	$2,$4,0x7
	sll	$2,$3,$2
	andi	$2,$2,0x00ff
	addiu	$4,$4,1
	srl	$2,$2,7
	lw	$28,32($sp)
	beq	$2,$0,$L1909
	sw	$4,8456($16)

	lw	$5,40($sp)
	li	$8,65536			# 0x10000
	sll	$7,$5,7
	sll	$2,$5,10
	addu	$2,$7,$2
	sll	$7,$2,4
	addu	$7,$2,$7
	lw	$2,44($sp)
	ori	$8,$8,0x7e40
	addu	$19,$7,$8
	lw	$18,-6204($2)
	addu	$19,$16,$19
	move	$17,$0
	li	$23,-65536			# 0xffffffffffff0000
	li	$3,3			# 0x3
$L1951:
	sra	$2,$4,3
	addu	$2,$6,$2
	lbu	$5,0($2)
	lbu	$9,3($2)
	lbu	$8,1($2)
	sll	$5,$5,24
	lbu	$2,2($2)
	or	$5,$9,$5
	sll	$8,$8,16
	sll	$2,$2,8
	or	$5,$5,$8
	or	$5,$5,$2
	andi	$2,$4,0x7
	sll	$5,$5,$2
	sltu	$2,$5,$21
	beq	$2,$0,$L2008
	and	$2,$5,$23

	bne	$2,$0,$L1912
	srl	$2,$5,16

	move	$2,$5
	li	$8,8			# 0x8
	move	$10,$0
$L1913:
	andi	$9,$2,0xff00
	bne	$9,$0,$L1914
	nop

	move	$8,$10
$L1915:
	addu	$2,$fp,$2
	lbu	$9,0($2)
	addiu	$2,$4,32
	addu	$8,$9,$8
	sll	$8,$8,1
	addiu	$8,$8,-31
	srl	$4,$5,$8
	subu	$2,$2,$8
	addiu	$4,$4,-1
	beq	$4,$3,$L1909
	sw	$2,8456($16)

$L2017:
	lw	$5,0($22)
	sltu	$5,$17,$5
	beq	$5,$0,$L2009
	lw	$25,%call16(av_log)($28)

	sltu	$5,$4,3
	beq	$5,$0,$L1918
	nop

	li	$5,2			# 0x2
	bne	$4,$5,$L2010
	sra	$5,$2,3

	sra	$4,$2,3
	addu	$4,$6,$4
	lbu	$6,0($4)
	lbu	$8,3($4)
	lbu	$5,1($4)
	sll	$6,$6,24
	lbu	$4,2($4)
	or	$6,$8,$6
	sll	$5,$5,16
	sll	$4,$4,8
	or	$5,$6,$5
	or	$5,$5,$4
	andi	$4,$2,0x7
	sll	$4,$5,$4
	sltu	$5,$4,$21
	beq	$5,$0,$L2011
	and	$5,$4,$23

	bne	$5,$0,$L1936
	srl	$5,$4,16

	move	$5,$4
	li	$6,8			# 0x8
	move	$9,$0
$L1937:
	andi	$8,$5,0xff00
	bne	$8,$0,$L1938
	nop

	move	$6,$9
$L1939:
	addu	$5,$fp,$5
	lbu	$10,0($5)
	addiu	$2,$2,32
	addu	$10,$10,$6
	sll	$10,$10,1
	addiu	$10,$10,-31
	subu	$2,$2,$10
	srl	$10,$4,$10
	addiu	$10,$10,-1
	sw	$2,8456($16)
	slt	$2,$10,32
	beq	$2,$0,$L2012
	lw	$4,8500($16)

$L1940:
	addiu	$2,$10,17902
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$13,4($2)
	beq	$13,$0,$L1929
	nop

	lw	$2,80($13)
	and	$4,$4,$2
	beq	$4,$0,$L1929
	nop

	sw	$10,236($13)
$L1933:
	sll	$4,$17,5
	sll	$2,$17,3
	subu	$2,$4,$2
	sll	$4,$2,4
	addu	$2,$2,$4
	li	$4,65536			# 0x10000
	ori	$4,$4,0x7f28
	addu	$2,$2,$7
	lw	$9,0($22)
	move	$6,$17
	addu	$2,$2,$4
	addiu	$4,$6,1
	addu	$2,$16,$2
	sltu	$5,$4,$9
	beq	$5,$0,$L1946
	addiu	$2,$2,4

$L1945:
	lw	$5,4($2)
	lw	$8,240($13)
	beq	$8,$5,$L2013
	nop

	addiu	$2,$2,408
	move	$6,$4
$L2014:
	addiu	$4,$6,1
	sltu	$5,$4,$9
	bne	$5,$0,$L1945
	nop

$L1946:
	slt	$2,$17,$6
	beq	$2,$0,$L1944
	addiu	$4,$6,-1

	sll	$2,$4,5
	sll	$4,$4,3
	subu	$2,$2,$4
	sll	$5,$2,4
	addu	$5,$2,$5
	li	$8,65536			# 0x10000
	addu	$5,$5,$7
	ori	$8,$8,0x7e40
	addu	$5,$5,$8
	addu	$5,$16,$5
$L1948:
	addiu	$6,$6,-1
	move	$2,$5
	addiu	$4,$5,408
	addiu	$8,$5,400
$L1947:
	lw	$12,0($2)
	lw	$11,4($2)
	lw	$10,8($2)
	lw	$9,12($2)
	addiu	$2,$2,16
	sw	$12,0($4)
	sw	$11,4($4)
	sw	$10,8($4)
	sw	$9,12($4)
	bne	$2,$8,$L1947
	addiu	$4,$4,16

	lw	$9,4($2)
	lw	$8,0($2)
	slt	$2,$17,$6
	sw	$9,4($4)
	sw	$8,0($4)
	bne	$2,$0,$L1948
	addiu	$5,$5,-408

$L1944:
	move	$2,$19
	addiu	$4,$13,400
$L1949:
	lw	$9,0($13)
	lw	$8,4($13)
	lw	$6,8($13)
	lw	$5,12($13)
	addiu	$13,$13,16
	sw	$9,0($2)
	sw	$8,4($2)
	sw	$6,8($2)
	sw	$5,12($2)
	bne	$13,$4,$L1949
	addiu	$2,$2,16

	lw	$5,4($13)
	lw	$4,0($13)
	sw	$5,4($2)
	sw	$4,0($2)
$L1950:
	addiu	$17,$17,1
	addiu	$19,$19,408
	addiu	$20,$20,408
	lw	$4,8456($16)
	b	$L1951
	lw	$6,8448($16)

$L2013:
	lw	$5,0($2)
	beq	$5,$10,$L1946
	addiu	$2,$2,408

	b	$L2014
	move	$6,$4

$L2010:
	addu	$6,$6,$5
	lbu	$8,0($6)
	lbu	$10,3($6)
	lbu	$9,1($6)
	lbu	$5,2($6)
	sll	$8,$8,24
	or	$8,$10,$8
	sll	$6,$9,16
	sll	$5,$5,8
	or	$6,$8,$6
	or	$6,$6,$5
	andi	$5,$2,0x7
	sll	$5,$6,$5
	sltu	$6,$5,$21
	beq	$6,$0,$L2015
	and	$6,$5,$23

	bne	$6,$0,$L1922
	srl	$6,$5,16

	move	$6,$5
	li	$8,8			# 0x8
	move	$9,$0
$L1923:
	andi	$10,$6,0xff00
	bne	$10,$0,$L1924
	nop

	move	$8,$9
$L1925:
	addu	$6,$fp,$6
	lbu	$6,0($6)
	addiu	$2,$2,32
	addu	$6,$6,$8
	sll	$6,$6,1
	addiu	$6,$6,-31
	subu	$2,$2,$6
	srl	$5,$5,$6
	sw	$2,8456($16)
	addiu	$5,$5,-1
$L1921:
	lw	$6,44($sp)
	addiu	$5,$5,1
	lw	$2,-6200($6)
	sltu	$6,$5,$2
	beq	$6,$0,$L2016
	lw	$25,%call16(av_log)($28)

	bne	$4,$0,$L1927
	nop

	subu	$18,$18,$5
$L1928:
	lw	$8,48($sp)
	addiu	$6,$2,-1
	lw	$4,6828($8)
	and	$18,$18,$6
	addiu	$2,$4,-1
	bltz	$2,$L1929
	lw	$6,8500($16)

	addiu	$4,$4,17869
	sll	$4,$4,2
	addu	$4,$16,$4
	addiu	$4,$4,4
$L1932:
	lw	$13,0($4)
	addiu	$2,$2,-1
	lw	$5,0($13)
	beq	$5,$0,$L1930
	addiu	$4,$4,-4

	lw	$5,232($13)
	bne	$18,$5,$L1930
	nop

	lw	$5,80($13)
	and	$5,$6,$5
	beq	$5,$0,$L1930
	nop

	lw	$5,240($13)
	beq	$5,$0,$L1931
	nop

$L1930:
	bgez	$2,$L1932
	nop

$L1929:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC22)
	sw	$3,60($sp)
	sw	$7,64($sp)
	move	$5,$0
	jalr	$25
	addiu	$6,$6,%lo($LC22)

	lw	$28,32($sp)
	move	$4,$20
	lw	$25,%call16(memset)($28)
	move	$5,$0
	jalr	$25
	li	$6,408			# 0x198

	lw	$28,32($sp)
	lw	$3,60($sp)
	b	$L1950
	lw	$7,64($sp)

$L2008:
	lw	$8,%got(ff_golomb_vlc_len)($28)
	srl	$5,$5,23
	addu	$2,$8,$5
	lw	$8,%got(ff_ue_golomb_vlc_code)($28)
	lbu	$2,0($2)
	addu	$5,$8,$5
	addu	$2,$2,$4
	lbu	$4,0($5)
	bne	$4,$3,$L2017
	sw	$2,8456($16)

$L1909:
	lw	$2,44($sp)
	lw	$3,40($sp)
	lw	$4,5944($2)
	addiu	$3,$3,1
	sw	$3,40($sp)
	sltu	$3,$3,$4
	addiu	$22,$22,4
	bne	$3,$0,$L1952
	lw	$2,40($sp)

	li	$2,65536			# 0x10000
$L2024:
	ori	$3,$2,0x1730
	addu	$3,$16,$3
	addu	$12,$16,$2
	move	$8,$3
	move	$7,$0
	ori	$11,$2,0x7e40
	addiu	$10,$16,1464
	addiu	$9,$16,1864
$L1953:
	sltu	$4,$7,$4
	beq	$4,$0,$L1957
	li	$2,3			# 0x3

	lw	$6,0($8)
	beq	$6,$0,$L1958
	sll	$2,$7,10

	sll	$4,$7,7
	addu	$2,$4,$2
	sll	$4,$2,4
	addu	$2,$2,$4
	addu	$2,$2,$11
	addu	$2,$16,$2
	b	$L1956
	move	$4,$0

$L1954:
	addiu	$4,$4,1
	sltu	$5,$4,$6
	beq	$5,$0,$L1958
	addiu	$2,$2,408

$L1956:
	lw	$5,0($2)
	bne	$5,$0,$L1954
	move	$5,$2

	move	$6,$10
$L1955:
	lw	$24,0($6)
	lw	$15,4($6)
	lw	$14,8($6)
	lw	$13,12($6)
	addiu	$6,$6,16
	sw	$24,0($5)
	sw	$15,4($5)
	sw	$14,8($5)
	sw	$13,12($5)
	bne	$6,$9,$L1955
	addiu	$5,$5,16

	lw	$6,4($9)
	lw	$13,0($9)
	sw	$6,4($5)
	sw	$13,0($5)
	b	$L1954
	lw	$6,0($8)

$L1914:
	b	$L1915
	srl	$2,$2,8

$L1912:
	li	$8,24			# 0x18
	b	$L1913
	li	$10,16			# 0x10

$L2011:
	lw	$6,%got(ff_golomb_vlc_len)($28)
	srl	$4,$4,23
	lw	$8,%got(ff_ue_golomb_vlc_code)($28)
	addu	$5,$6,$4
	lbu	$5,0($5)
	addu	$4,$8,$4
	lbu	$10,0($4)
	addu	$2,$5,$2
	sw	$2,8456($16)
	slt	$2,$10,32
	bne	$2,$0,$L1940
	lw	$4,8500($16)

$L2012:
	lui	$6,%hi($LC20)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L2005
	addiu	$6,$6,%lo($LC20)

$L1938:
	b	$L1939
	srl	$5,$5,8

$L1936:
	li	$6,24			# 0x18
	b	$L1937
	li	$9,16			# 0x10

$L1927:
	b	$L1928
	addu	$18,$5,$18

$L2015:
	lw	$8,%got(ff_golomb_vlc_len)($28)
	srl	$5,$5,23
	addu	$6,$8,$5
	lbu	$6,0($6)
	lw	$8,%got(ff_ue_golomb_vlc_code)($28)
	addu	$2,$6,$2
	addu	$5,$8,$5
	sw	$2,8456($16)
	b	$L1921
	lbu	$5,0($5)

$L1924:
	b	$L1925
	srl	$6,$6,8

$L1922:
	li	$8,24			# 0x18
	b	$L1923
	li	$9,16			# 0x10

$L1931:
	sw	$18,236($13)
	b	$L1933
	move	$10,$18

$L2019:
	addiu	$7,$7,1
	addiu	$11,$11,4
	addiu	$3,$3,4
	bne	$7,$24,$L1975
	addiu	$13,$13,19584

	li	$3,65536			# 0x10000
	addu	$2,$16,$3
	lw	$2,-6276($2)
	beq	$2,$0,$L1906
	move	$2,$0

	ori	$9,$3,0x1630
	ori	$8,$3,0x15b0
	li	$7,2			# 0x2
$L1984:
	sll	$5,$2,6
	sll	$3,$2,7
	addu	$5,$5,$8
	addu	$3,$3,$9
	addu	$5,$16,$5
	addu	$3,$16,$3
	b	$L1986
	move	$4,$0

$L1985:
	lw	$6,0($5)
	addiu	$4,$4,1
	sll	$6,$6,1
	addiu	$11,$6,1
	sw	$11,4($3)
	sw	$6,0($3)
	addiu	$5,$5,4
	addiu	$3,$3,8
$L1986:
	lw	$6,372($10)
	slt	$6,$4,$6
	bne	$6,$0,$L1985
	nop

	addiu	$2,$2,1
	bne	$2,$7,$L1984
	addiu	$10,$10,4

$L1906:
	move	$2,$0
$L1917:
	lw	$31,108($sp)
	lw	$fp,104($sp)
	lw	$23,100($sp)
	lw	$22,96($sp)
	lw	$21,92($sp)
	lw	$20,88($sp)
	lw	$19,84($sp)
	lw	$18,80($sp)
	lw	$17,76($sp)
	lw	$16,72($sp)
	j	$31
	addiu	$sp,$sp,112

$L2007:
	lui	$6,%hi($LC15)
	li	$19,131072			# 0x20000
	addiu	$6,$6,%lo($LC15)
	li	$5,2			# 0x2
	jalr	$25
	addu	$19,$16,$19

	lw	$2,6828($19)
	beq	$2,$0,$L1889
	lw	$28,32($sp)

	li	$18,65536			# 0x10000
	ori	$18,$18,0x173c
	lui	$20,%hi($LC16)
	addu	$18,$16,$18
	addiu	$20,$20,%lo($LC16)
	move	$17,$0
$L1890:
	lw	$2,0($18)
	lw	$4,0($16)
	lw	$3,232($2)
	lw	$25,%call16(av_log)($28)
	sw	$3,16($sp)
	lw	$3,228($2)
	move	$7,$17
	sw	$3,20($sp)
	lw	$2,0($2)
	li	$5,2			# 0x2
	sw	$2,24($sp)
	jalr	$25
	move	$6,$20

	lw	$2,6828($19)
	addiu	$17,$17,1
	sltu	$2,$17,$2
	lw	$28,32($sp)
	bne	$2,$0,$L1890
	addiu	$18,$18,4

$L1889:
	lw	$4,0($16)
	lw	$2,412($4)
	andi	$2,$2,0x800
	beq	$2,$0,$L1888
	lw	$25,%call16(av_log)($28)

	lui	$6,%hi($LC17)
	addiu	$6,$6,%lo($LC17)
	jalr	$25
	li	$5,2			# 0x2

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6076($2)
	beq	$2,$0,$L1891
	lw	$28,32($sp)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	lw	$25,%call16(av_log)($28)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	move	$7,$0

	lw	$28,32($sp)
$L1891:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6080($2)
	beq	$2,$0,$L1892
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,1			# 0x1

	lw	$28,32($sp)
$L1892:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6084($2)
	beq	$2,$0,$L1893
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,2			# 0x2

	lw	$28,32($sp)
$L1893:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6088($2)
	beq	$2,$0,$L1894
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,3			# 0x3

	lw	$28,32($sp)
$L1894:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6092($2)
	beq	$2,$0,$L1895
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,4			# 0x4

	lw	$28,32($sp)
$L1895:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6096($2)
	beq	$2,$0,$L1896
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,5			# 0x5

	lw	$28,32($sp)
$L1896:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6100($2)
	beq	$2,$0,$L1897
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,6			# 0x6

	lw	$28,32($sp)
$L1897:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6104($2)
	beq	$2,$0,$L1898
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,7			# 0x7

	lw	$28,32($sp)
$L1898:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6108($2)
	beq	$2,$0,$L1899
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,8			# 0x8

	lw	$28,32($sp)
$L1899:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6112($2)
	beq	$2,$0,$L1900
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,9			# 0x9

	lw	$28,32($sp)
$L1900:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6116($2)
	beq	$2,$0,$L1901
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,10			# 0xa

	lw	$28,32($sp)
$L1901:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6120($2)
	beq	$2,$0,$L1902
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,11			# 0xb

	lw	$28,32($sp)
$L1902:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6124($2)
	beq	$2,$0,$L1903
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,12			# 0xc

	lw	$28,32($sp)
$L1903:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6128($2)
	beq	$2,$0,$L1904
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,13			# 0xd

	lw	$28,32($sp)
$L1904:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6132($2)
	beq	$2,$0,$L1905
	li	$5,2			# 0x2

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	lw	$25,%call16(av_log)($28)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	jalr	$25
	li	$7,14			# 0xe

	lw	$28,32($sp)
$L1905:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,6136($2)
	beq	$2,$0,$L1888
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($16)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,15			# 0xf

	b	$L1888
	lw	$28,32($sp)

$L1918:
	lui	$6,%hi($LC21)
	lw	$4,0($16)
	addiu	$6,$6,%lo($LC21)
$L2005:
	jalr	$25
	move	$5,$0

	b	$L1917
	li	$2,-1			# 0xffffffffffffffff

$L2009:
	lw	$4,0($16)
	lui	$6,%hi($LC18)
	jalr	$25
	addiu	$6,$6,%lo($LC18)

	b	$L1917
	li	$2,-1			# 0xffffffffffffffff

$L2016:
	lui	$6,%hi($LC19)
	lw	$4,0($16)
	b	$L2005
	addiu	$6,$6,%lo($LC19)

$L1958:
	lw	$4,5944($12)
	addiu	$7,$7,1
	b	$L1953
	addiu	$8,$8,4

$L1957:
	li	$8,65536			# 0x10000
	addu	$5,$16,$8
	lw	$4,-6284($5)
	beq	$4,$2,$L2001
	nop

$L2004:
	lw	$2,1880($16)
	li	$12,65536			# 0x10000
$L2022:
	ori	$12,$12,0x7e40
$L2025:
	lw	$9,52($2)
	addu	$12,$16,$12
	li	$4,1			# 0x1
	beq	$9,$4,$L2018
	addiu	$12,$12,19584

$L1970:
	li	$4,3			# 0x3
	beq	$9,$4,$L2023
	li	$14,65536			# 0x10000

	sw	$0,376($2)
$L2023:
	ori	$14,$14,0x7f20
	move	$10,$2
	move	$5,$3
	move	$4,$0
	li	$13,2			# 0x2
$L1974:
	lw	$6,0($5)
	sw	$6,372($10)
	lw	$6,0($5)
	beq	$6,$0,$L1972
	nop

	sll	$7,$4,7
	sll	$6,$4,10
	addu	$6,$7,$6
	sll	$8,$6,4
	addu	$8,$6,$8
	addu	$8,$8,$14
	sll	$7,$4,6
	addu	$8,$16,$8
	addu	$7,$2,$7
	addiu	$8,$8,4
	addiu	$7,$7,244
	move	$6,$0
$L1973:
	lw	$11,0($8)
	addiu	$6,$6,1
	sw	$11,0($7)
	lw	$11,0($5)
	addiu	$8,$8,408
	sltu	$11,$6,$11
	bne	$11,$0,$L1973
	addiu	$7,$7,4

$L1972:
	addiu	$4,$4,1
	addiu	$5,$5,4
	bne	$4,$13,$L1974
	addiu	$10,$10,4

	li	$2,3			# 0x3
	bne	$9,$2,$L1917
	move	$2,$0

	li	$2,65536			# 0x10000
	addu	$4,$16,$2
	lw	$4,5356($4)
	bne	$4,$0,$L1906
	ori	$13,$2,0x7f24

	addu	$13,$16,$13
	ori	$17,$2,0x80b8
	move	$10,$12
	move	$11,$12
	move	$7,$0
	ori	$25,$2,0x15b0
	li	$24,2			# 0x2
$L1975:
	sll	$4,$7,7
	sll	$2,$7,10
	addu	$2,$4,$2
	sll	$18,$2,4
	addu	$18,$2,$18
	sll	$9,$7,6
	addu	$18,$18,$17
	addu	$15,$12,$9
	addu	$18,$16,$18
	addu	$9,$9,$25
	addu	$9,$16,$9
	addiu	$15,$15,244
	addiu	$18,$18,4
	move	$14,$0
$L1983:
	lw	$2,372($11)
	slt	$2,$14,$2
	beq	$2,$0,$L2019
	nop

	lw	$6,0($3)
	lw	$8,0($15)
	beq	$6,$0,$L1976
	sw	$0,0($9)

	lw	$2,0($13)
	beq	$8,$2,$L2020
	move	$2,$0

	b	$L1979
	move	$4,$18

$L1980:
	lw	$5,0($4)
	beq	$8,$5,$L1978
	addiu	$4,$4,408

$L1979:
	addiu	$2,$2,1
	sltu	$5,$2,$6
	bne	$5,$0,$L1980
	nop

$L1976:
	addiu	$14,$14,1
	addiu	$9,$9,4
	b	$L1983
	addiu	$15,$15,4

$L2020:
$L1978:
	b	$L1976
	sw	$2,0($9)

$L2018:
	b	$L1970
	sw	$0,372($2)

$L2001:
	lw	$2,5356($5)
	bne	$2,$0,$L2004
	ori	$4,$8,0x14f0

	lw	$2,1880($16)
	li	$6,131072			# 0x20000
	addu	$6,$16,$6
	addu	$4,$16,$4
	ori	$8,$8,0x7f24
	lw	$15,228($2)
	lw	$24,-13404($6)
	addu	$8,$16,$8
	lw	$6,5936($5)
	move	$7,$0
	move	$5,$4
	li	$14,127			# 0x7f
	li	$13,-128			# 0xffffffffffffff80
	li	$12,1023			# 0x3ff
	li	$11,-1024			# 0xfffffffffffffc00
	li	$10,256			# 0x100
$L1960:
	beq	$7,$6,$L2021
	li	$25,16448			# 0x4040

	lw	$9,0($8)
	subu	$17,$24,$9
	slt	$19,$17,-128
	beq	$19,$0,$L1961
	slt	$18,$17,128

	li	$17,-128			# 0xffffffffffffff80
$L1962:
	div	$0,$25,$17
	teq	$17,$0,7
	subu	$9,$15,$9
	slt	$25,$9,128
	movz	$9,$14,$25
	slt	$25,$9,-128
	movn	$9,$13,$25
	mflo	$17
	mul	$9,$17,$9
	addiu	$9,$9,32
	sra	$9,$9,6
	slt	$25,$9,1024
	movz	$9,$12,$25
	slt	$25,$9,-1024
	movn	$9,$11,$25
	sw	$9,0($5)
$L1965:
	addiu	$7,$7,1
	addiu	$5,$5,4
	b	$L1960
	addiu	$8,$8,408

$L1961:
	beq	$18,$0,$L1963
	li	$25,16447			# 0x403f

	bne	$17,$0,$L1964
	subu	$25,$0,$17

	b	$L1965
	sw	$10,0($5)

$L1963:
	b	$L1962
	li	$17,127			# 0x7f

$L2021:
	li	$5,65536			# 0x10000
	addu	$7,$16,$5
	lw	$8,-6276($7)
	beq	$8,$0,$L2022
	li	$12,65536			# 0x10000

	ori	$5,$5,0x1534
	move	$9,$7
	addu	$5,$16,$5
	b	$L1968
	move	$7,$0

$L1969:
	lw	$8,0($4)
	lw	$6,5936($9)
	sw	$8,-4($5)
	sw	$8,0($5)
	addiu	$7,$7,1
	addiu	$4,$4,4
	addiu	$5,$5,8
$L1968:
	sltu	$6,$7,$6
	bne	$6,$0,$L1969
	li	$12,65536			# 0x10000

	b	$L2025
	ori	$12,$12,0x7e40

$L1964:
	slt	$18,$17,0
	movz	$25,$17,$18
	sra	$25,$25,1
	b	$L1962
	addiu	$25,$25,16384

	.set	macro
	.set	reorder
	.end	decode_ref_pic_list_reordering
	.size	decode_ref_pic_list_reordering, .-decode_ref_pic_list_reordering
	.align	2
	.set	nomips16
	.ent	filter_mb
	.type	filter_mb, @function
filter_mb:
	.frame	$sp,216,$31		# vars= 144, regs= 10/0, args= 24, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$3,152($4)
	addiu	$sp,$sp,-216
	sw	$17,180($sp)
	move	$17,$4
	mul	$4,$6,$3
	li	$10,4			# 0x4
	addu	$2,$4,$5
	lw	$4,1568($17)
	sll	$8,$2,2
	sw	$2,84($sp)
	addu	$2,$4,$8
	lw	$2,0($2)
	sw	$8,100($sp)
	sw	$2,92($sp)
	lw	$9,92($sp)
	li	$8,65536			# 0x10000
	andi	$9,$9,0x80
	sw	$9,124($sp)
	addu	$8,$17,$8
	lw	$11,124($sp)
	li	$9,2			# 0x2
	lw	$2,-6276($8)
	movn	$10,$9,$11
	sw	$31,212($sp)
	sw	$fp,208($sp)
	sw	$23,204($sp)
	sw	$22,200($sp)
	sw	$21,196($sp)
	sw	$20,192($sp)
	sw	$19,188($sp)
	sw	$18,184($sp)
	sw	$16,176($sp)
	sw	$7,228($sp)
	beq	$2,$0,$L2255
	sw	$10,144($sp)

	lw	$22,84($sp)
	lw	$7,-6288($8)
	addiu	$11,$22,-1
	addu	$10,$7,$11
	lbu	$10,0($10)
	li	$12,255			# 0xff
	beq	$10,$12,$L2256
	sll	$11,$11,2

	addu	$11,$4,$11
	lw	$11,0($11)
	lw	$12,92($sp)
	xor	$11,$12,$11
	andi	$11,$11,0x80
	beq	$11,$0,$L2257
	andi	$13,$12,0x7

	lw	$8,5340($8)
	beq	$8,$9,$L2258
	lw	$15,84($sp)

$L2036:
	li	$2,-2			# 0xfffffffffffffffe
	and	$2,$6,$2
	mul	$7,$2,$3
	addiu	$5,$5,-1
	lw	$8,92($sp)
	addu	$5,$7,$5
	andi	$8,$8,0x7
	addu	$3,$5,$3
	sw	$8,152($sp)
	sw	$5,32($sp)
	beq	$8,$0,$L2037
	sw	$3,36($sp)

	li	$2,4			# 0x4
	andi	$6,$6,0x1
	sh	$2,64($sp)
	sh	$2,78($sp)
	sh	$2,76($sp)
	sh	$2,74($sp)
	sh	$2,72($sp)
	sh	$2,70($sp)
	sh	$2,68($sp)
	sh	$2,66($sp)
	sw	$6,148($sp)
	addiu	$16,$sp,64
$L2038:
	lw	$2,1548($17)
	lw	$9,84($sp)
	addu	$4,$2,$3
	addu	$6,$2,$9
	lb	$3,0($6)
	addu	$2,$2,$5
	lb	$2,0($2)
	lb	$4,0($4)
	andi	$6,$3,0xff
	addu	$6,$17,$6
	andi	$8,$2,0xff
	andi	$7,$4,0xff
	lbu	$5,12352($6)
	addu	$8,$17,$8
	lbu	$6,12096($6)
	addu	$7,$17,$7
	lbu	$9,12352($8)
	lbu	$10,12096($8)
	lbu	$11,12352($7)
	lbu	$8,12096($7)
	addiu	$3,$3,1
	addiu	$6,$6,1
	addiu	$5,$5,1
	addu	$8,$6,$8
	addu	$7,$5,$11
	addu	$6,$6,$10
	addu	$5,$5,$9
	lw	$10,228($sp)
	addu	$4,$4,$3
	addu	$2,$3,$2
	sra	$6,$6,1
	sra	$5,$5,1
	sra	$4,$4,1
	sra	$8,$8,1
	sra	$7,$7,1
	sra	$2,$2,1
	sw	$6,48($sp)
	sw	$5,56($sp)
	sw	$4,44($sp)
	sw	$8,52($sp)
	sw	$7,60($sp)
	li	$9,65536			# 0x10000
	lui	$23,%hi(beta_table+52)
	addiu	$4,$10,-1
	addiu	$6,$10,-2
	addiu	$8,$10,-3
	addiu	$5,$10,1
	addiu	$7,$10,2
	move	$3,$10
	lw	$10,240($sp)
	sw	$2,40($sp)
	addu	$9,$17,$9
	addiu	$23,$23,%lo(beta_table+52)
	move	$2,$0
	li	$fp,-2			# 0xfffffffffffffffe
	addiu	$31,$sp,40
	li	$25,16			# 0x10
	mtlo	$17
$L2080:
	lw	$12,-6272($9)
	bne	$12,$0,$L2050
	sra	$13,$2,1

	and	$13,$13,$fp
	andi	$11,$2,0x1
	or	$13,$13,$11
$L2050:
	sll	$13,$13,1
	addu	$13,$16,$13
	lh	$11,0($13)
	beq	$11,$0,$L2051
	nop

	beq	$12,$0,$L2053
	andi	$12,$2,0x1

	sra	$12,$2,3
$L2053:
	sll	$12,$12,2
	addu	$12,$12,$31
	lw	$12,0($12)
	lw	$24,5344($9)
	lw	$13,5348($9)
	addu	$24,$12,$24
	addu	$13,$12,$13
	lui	$12,%hi(alpha_table+52)
	addiu	$12,$12,%lo(alpha_table+52)
	addu	$14,$12,$24
	addu	$13,$23,$13
	slt	$12,$11,4
	lbu	$20,0($14)
	beq	$12,$0,$L2054
	lbu	$13,0($13)

	lbu	$14,0($4)
	lbu	$12,0($3)
	sll	$18,$24,1
	subu	$15,$14,$12
	lui	$17,%hi(tc0_table+156)
	addu	$24,$18,$24
	slt	$19,$15,0
	subu	$18,$0,$15
	addiu	$17,$17,%lo(tc0_table+156)
	movn	$15,$18,$19
	addu	$24,$17,$24
	addu	$11,$24,$11
	slt	$15,$15,$20
	lbu	$11,-1($11)
	lbu	$19,0($6)
	lbu	$24,0($8)
	lbu	$18,0($5)
	beq	$15,$0,$L2051
	lbu	$21,0($7)

	subu	$15,$19,$14
	subu	$20,$0,$15
	slt	$22,$15,0
	movn	$15,$20,$22
	slt	$15,$15,$13
	beq	$15,$0,$L2051
	subu	$15,$18,$12

	subu	$20,$0,$15
	slt	$22,$15,0
	movn	$15,$20,$22
	slt	$15,$15,$13
	beq	$15,$0,$L2051
	subu	$15,$24,$14

	subu	$20,$0,$15
	slt	$22,$15,0
	movn	$15,$20,$22
	slt	$15,$15,$13
	bne	$15,$0,$L2058
	addiu	$20,$12,1

	move	$15,$11
$L2060:
	subu	$24,$21,$12
	subu	$20,$0,$24
	slt	$22,$24,0
	movn	$24,$20,$22
	slt	$13,$24,$13
	beq	$13,$0,$L2062
	addiu	$24,$12,1

	addu	$24,$24,$14
	sra	$24,$24,1
	sll	$13,$18,1
	subu	$13,$24,$13
	addu	$21,$13,$21
	sra	$21,$21,1
	subu	$13,$0,$11
	slt	$24,$21,$13
	bne	$24,$0,$L2282
	addu	$13,$18,$13

	slt	$13,$21,$11
	movz	$21,$11,$13
	move	$13,$21
	addu	$13,$18,$13
$L2282:
	sb	$13,0($5)
	addiu	$15,$15,1
$L2062:
	addiu	$19,$19,4
	subu	$11,$12,$14
	subu	$19,$19,$18
	sll	$11,$11,2
	addu	$11,$19,$11
	sra	$13,$11,3
	subu	$11,$0,$15
	slt	$24,$13,$11
	bne	$24,$0,$L2065
	nop

	slt	$11,$13,$15
	movz	$13,$15,$11
	move	$11,$13
$L2065:
	addu	$14,$11,$14
	li	$18,-256			# 0xffffffffffffff00
	and	$13,$14,$18
	beq	$13,$0,$L2066
	nop

	subu	$14,$0,$14
	sra	$14,$14,31
	andi	$14,$14,0x00ff
$L2067:
	subu	$11,$12,$11
	li	$22,-256			# 0xffffffffffffff00
	and	$12,$11,$22
	beq	$12,$0,$L2068
	sb	$14,0($4)

	subu	$11,$0,$11
	sra	$11,$11,31
	andi	$11,$11,0x00ff
$L2253:
	sb	$11,0($3)
$L2051:
	addiu	$2,$2,1
	addu	$4,$4,$10
	addu	$6,$6,$10
	addu	$8,$8,$10
	addu	$5,$5,$10
	beq	$2,$25,$L2079
	addu	$7,$7,$10

	b	$L2080
	addu	$3,$3,$10

$L2255:
	lw	$7,11848($17)
	lw	$3,11852($17)
	lw	$12,84($sp)
	slt	$10,$3,$7
	lw	$9,1548($17)
	movn	$3,$7,$10
	lw	$11,5344($8)
	slt	$7,$3,0
	addu	$10,$9,$12
	li	$12,15			# 0xf
	subu	$11,$12,$11
	movn	$3,$0,$7
	lb	$7,0($10)
	subu	$3,$11,$3
	slt	$11,$3,$7
	beq	$11,$0,$L2030
	lw	$13,92($sp)

	andi	$6,$6,0x1
	andi	$13,$13,0x7
	lw	$5,5340($8)
	lw	$7,-6288($8)
	sw	$6,148($sp)
	sw	$13,152($sp)
	move	$6,$0
$L2031:
	lw	$18,92($sp)
	li	$8,1			# 0x1
	andi	$3,$18,0x808
	xori	$3,$3,0x808
	li	$22,4			# 0x4
	lw	$11,240($sp)
	lw	$12,240($sp)
	movz	$22,$8,$3
	lw	$9,244($sp)
	li	$3,16777216			# 0x1000000
	sw	$22,88($sp)
	and	$3,$18,$3
	li	$10,65536			# 0x10000
	sll	$11,$11,1
	sll	$12,$12,2
	addiu	$13,$sp,64
	move	$22,$0
	sw	$3,112($sp)
	addu	$10,$17,$10
	sll	$8,$9,1
	sw	$11,156($sp)
	sw	$12,96($sp)
	bne	$22,$0,$L2081
	sw	$13,104($sp)

$L2267:
	lw	$15,84($sp)
	li	$3,16			# 0x10
	addiu	$15,$15,-1
	lw	$11,92($sp)
	move	$9,$15
	sll	$3,$3,$22
	sll	$9,$9,2
	move	$12,$15
	ori	$3,$3,0x8
	sw	$9,116($sp)
	sw	$15,108($sp)
	and	$3,$3,$11
	addu	$11,$4,$9
	addu	$9,$7,$12
	lw	$18,0($11)
	beq	$3,$0,$L2085
	lbu	$9,0($9)

$L2268:
	li	$3,32			# 0x20
	sra	$3,$3,$22
	lw	$11,92($sp)
	ori	$3,$3,0x8
	li	$13,3			# 0x3
	sw	$3,136($sp)
	and	$3,$3,$11
	sw	$13,128($sp)
	beq	$6,$0,$L2087
	sw	$3,140($sp)

$L2269:
	li	$3,2			# 0x2
	beq	$5,$3,$L2259
	li	$16,1			# 0x1

$L2089:
	beq	$2,$0,$L2283
	lw	$3,88($sp)

	li	$15,1			# 0x1
	beq	$22,$15,$L2091
	lw	$5,148($sp)

$L2092:
	lw	$3,88($sp)
$L2283:
	slt	$2,$16,$3
	beq	$2,$0,$L2094
	nop

	andi	$18,$18,0x80
	lw	$4,1568($17)
	sw	$18,132($sp)
$L2093:
	lw	$2,96($sp)
	mul	$23,$8,$16
	mul	$5,$16,$2
	lw	$3,228($sp)
	lw	$6,232($sp)
	lw	$7,236($sp)
	sll	$fp,$16,1
	sll	$20,$16,2
	addu	$2,$6,$fp
	sll	$19,$16,3
	addu	$fp,$7,$fp
	addu	$21,$5,$3
	addu	$20,$3,$20
	addiu	$9,$sp,32
	addu	$3,$6,$23
	addu	$23,$7,$23
	move	$24,$fp
	sw	$22,80($sp)
	addiu	$19,$19,12
	move	$22,$23
	sw	$9,120($sp)
	move	$fp,$3
	beq	$16,$0,$L2125
	move	$23,$2

$L2264:
	lw	$11,100($sp)
	andi	$18,$16,0x1
	addu	$4,$4,$11
	beq	$18,$0,$L2260
	lw	$4,0($4)

	lw	$12,112($sp)
	bne	$12,$0,$L2284
	lw	$18,88($sp)

	lw	$3,84($sp)
	li	$18,1			# 0x1
$L2127:
	lw	$13,92($sp)
	or	$5,$4,$13
	andi	$5,$5,0x7
	bne	$5,$0,$L2261
	nop

$L2129:
	lw	$7,128($sp)
	and	$5,$16,$7
	beq	$5,$0,$L2136
	li	$6,1			# 0x1

	sh	$0,70($sp)
	sh	$0,68($sp)
	sh	$0,66($sp)
	sh	$0,64($sp)
$L2137:
	lw	$12,80($sp)
$L2301:
	beq	$12,$0,$L2151
	addiu	$4,$16,12

	move	$4,$19
	li	$7,8			# 0x8
$L2152:
	addu	$5,$17,$4
	lbu	$9,9080($5)
	bne	$9,$0,$L2285
	li	$13,2			# 0x2

	subu	$7,$4,$7
	addu	$9,$17,$7
	lbu	$11,9080($9)
	bne	$11,$0,$L2155
	nop

	bne	$6,$0,$L2154
	li	$15,3			# 0x3

	lw	$11,-6284($10)
	beq	$11,$15,$L2156
	sh	$0,64($sp)

	lb	$5,9456($5)
	lb	$9,9456($9)
	addiu	$5,$5,2
	addiu	$9,$9,2
	lui	$2,%hi(ref2frm.19690)
	addiu	$2,$2,%lo(ref2frm.19690)
	sll	$5,$5,2
	sll	$9,$9,2
	addu	$5,$5,$2
	addu	$9,$9,$2
	lw	$11,0($5)
	lw	$5,0($9)
	bne	$11,$5,$L2157
	addiu	$5,$4,2284

	addiu	$9,$7,2284
	sll	$5,$5,2
	sll	$9,$9,2
	addu	$5,$17,$5
	addu	$9,$17,$9
	lh	$11,0($5)
	lh	$5,0($9)
	subu	$5,$11,$5
	subu	$11,$0,$5
	slt	$9,$5,0
	movn	$5,$11,$9
	slt	$5,$5,4
	beq	$5,$0,$L2286
	lw	$5,80($sp)

	sll	$4,$4,2
	sll	$7,$7,2
	addu	$7,$17,$7
	addu	$4,$17,$4
	lh	$5,9138($7)
	lh	$4,9138($4)
	subu	$4,$4,$5
	subu	$5,$0,$4
	slt	$7,$4,0
	movn	$4,$5,$7
	lw	$5,144($sp)
	slt	$4,$4,$5
	beq	$4,$0,$L2286
	lw	$5,80($sp)

$L2154:
	lw	$5,80($sp)
$L2293:
	beq	$5,$0,$L2287
	addiu	$4,$16,20

$L2270:
	addiu	$4,$19,1
	addu	$5,$17,$4
	lbu	$9,9080($5)
	bne	$9,$0,$L2168
	li	$7,8			# 0x8

$L2166:
	subu	$7,$4,$7
	addu	$9,$17,$7
	lbu	$11,9080($9)
	bne	$11,$0,$L2168
	nop

	bne	$6,$0,$L2167
	li	$12,3			# 0x3

	lw	$11,-6284($10)
	beq	$11,$12,$L2169
	sh	$0,66($sp)

	lb	$5,9456($5)
	lb	$9,9456($9)
	addiu	$5,$5,2
	addiu	$9,$9,2
	lui	$13,%hi(ref2frm.19690)
	addiu	$13,$13,%lo(ref2frm.19690)
	sll	$5,$5,2
	sll	$9,$9,2
	addu	$5,$5,$13
	addu	$9,$9,$13
	lw	$11,0($5)
	lw	$5,0($9)
	bne	$11,$5,$L2170
	addiu	$5,$4,2284

	addiu	$9,$7,2284
	sll	$5,$5,2
	sll	$9,$9,2
	addu	$5,$17,$5
	addu	$9,$17,$9
	lh	$11,0($5)
	lh	$5,0($9)
	subu	$5,$11,$5
	subu	$11,$0,$5
	slt	$9,$5,0
	movn	$5,$11,$9
	slt	$5,$5,4
	beq	$5,$0,$L2288
	li	$2,1			# 0x1

	sll	$4,$4,2
	sll	$7,$7,2
	addu	$7,$17,$7
	addu	$4,$17,$4
	lh	$5,9138($7)
	lh	$4,9138($4)
	lw	$15,144($sp)
	subu	$4,$4,$5
	subu	$5,$0,$4
	slt	$7,$4,0
	movn	$4,$5,$7
	slt	$4,$4,$15
	beq	$4,$0,$L2288
	nop

$L2167:
	lw	$4,80($sp)
$L2296:
	beq	$4,$0,$L2289
	addiu	$4,$16,28

$L2271:
	addiu	$4,$19,2
	addu	$5,$17,$4
	lbu	$9,9080($5)
	bne	$9,$0,$L2181
	li	$7,8			# 0x8

$L2179:
	subu	$7,$4,$7
	addu	$9,$17,$7
	lbu	$11,9080($9)
	bne	$11,$0,$L2181
	nop

	bne	$6,$0,$L2180
	li	$12,3			# 0x3

	lw	$11,-6284($10)
	beq	$11,$12,$L2182
	sh	$0,68($sp)

	lb	$5,9456($5)
	lb	$9,9456($9)
	addiu	$5,$5,2
	addiu	$9,$9,2
	lui	$13,%hi(ref2frm.19690)
	addiu	$13,$13,%lo(ref2frm.19690)
	sll	$5,$5,2
	sll	$9,$9,2
	addu	$5,$5,$13
	addu	$9,$9,$13
	lw	$11,0($5)
	lw	$5,0($9)
	bne	$11,$5,$L2183
	addiu	$5,$4,2284

	addiu	$9,$7,2284
	sll	$5,$5,2
	sll	$9,$9,2
	addu	$5,$17,$5
	addu	$9,$17,$9
	lh	$11,0($5)
	lh	$5,0($9)
	subu	$5,$11,$5
	subu	$11,$0,$5
	slt	$9,$5,0
	movn	$5,$11,$9
	slt	$5,$5,4
	beq	$5,$0,$L2183
	sll	$4,$4,2

	sll	$7,$7,2
	addu	$7,$17,$7
	addu	$4,$17,$4
	lh	$5,9138($7)
	lh	$4,9138($4)
	lw	$15,144($sp)
	subu	$4,$4,$5
	subu	$5,$0,$4
	slt	$7,$4,0
	movn	$4,$5,$7
	slt	$4,$4,$15
	beq	$4,$0,$L2183
	nop

$L2180:
	lw	$4,80($sp)
$L2295:
	bne	$4,$0,$L2290
	addiu	$4,$19,3

$L2272:
	addiu	$4,$16,36
	addu	$5,$17,$4
	lbu	$9,9080($5)
	bne	$9,$0,$L2191
	li	$7,1			# 0x1

$L2273:
	subu	$7,$4,$7
	addu	$9,$17,$7
	lbu	$11,9080($9)
	bne	$11,$0,$L2191
	nop

	bne	$6,$0,$L2193
	nop

	lw	$6,-6284($10)
	li	$11,3			# 0x3
	beq	$6,$11,$L2262
	sh	$0,70($sp)

	lb	$6,9456($9)
	lb	$5,9456($5)
	addiu	$6,$6,2
	addiu	$5,$5,2
	lui	$9,%hi(ref2frm.19690)
	addiu	$9,$9,%lo(ref2frm.19690)
	sll	$5,$5,2
	sll	$6,$6,2
	addu	$5,$5,$9
	addu	$6,$6,$9
	lw	$5,0($5)
	lw	$6,0($6)
	bne	$5,$6,$L2195
	addiu	$6,$4,2284

	addiu	$5,$7,2284
	sll	$6,$6,2
	sll	$5,$5,2
	addu	$6,$17,$6
	addu	$5,$17,$5
	lh	$6,0($6)
	lh	$5,0($5)
	subu	$5,$6,$5
	subu	$9,$0,$5
	slt	$6,$5,0
	movn	$5,$9,$6
	slt	$5,$5,4
	beq	$5,$0,$L2195
	sll	$4,$4,2

	sll	$7,$7,2
	addu	$4,$17,$4
	addu	$7,$17,$7
	lh	$5,9138($7)
	lh	$4,9138($4)
	lw	$11,144($sp)
	subu	$4,$4,$5
	subu	$5,$0,$4
	slt	$6,$4,0
	movn	$4,$5,$6
	slt	$4,$4,$11
	beq	$4,$0,$L2195
	nop

$L2193:
	lh	$4,64($sp)
$L2292:
	lh	$6,66($sp)
	lh	$5,68($sp)
	addu	$6,$6,$4
	lh	$4,70($sp)
	addu	$5,$6,$5
	addu	$5,$5,$4
	beq	$5,$0,$L2128
	nop

	lw	$4,1548($17)
	lw	$13,84($sp)
	lw	$15,80($sp)
	addu	$5,$4,$13
	lb	$5,0($5)
	addu	$4,$4,$3
	lb	$4,0($4)
	addiu	$5,$5,1
	addu	$5,$5,$4
	bne	$15,$0,$L2202
	sra	$9,$5,1

$L2265:
	lw	$6,240($sp)
	lw	$7,104($sp)
	move	$4,$17
	move	$5,$20
	sw	$3,160($sp)
	sw	$8,168($sp)
	sw	$10,172($sp)
	sw	$24,164($sp)
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$9,16($sp)

	lw	$3,160($sp)
	lw	$8,168($sp)
	lw	$10,172($sp)
	beq	$18,$0,$L2263
	lw	$24,164($sp)

$L2128:
	lw	$18,88($sp)
$L2284:
	addiu	$16,$16,1
	lw	$2,96($sp)
	slt	$3,$16,$18
	addiu	$24,$24,2
	addu	$21,$21,$2
	addu	$22,$22,$8
	addiu	$20,$20,4
	addu	$fp,$fp,$8
	addiu	$23,$23,2
	beq	$3,$0,$L2252
	addiu	$19,$19,8

$L2266:
	bne	$16,$0,$L2264
	lw	$4,1568($17)

$L2125:
	lw	$3,116($sp)
	lw	$13,92($sp)
	addu	$4,$4,$3
	lw	$4,0($4)
	lw	$3,108($sp)
	or	$5,$4,$13
	andi	$5,$5,0x7
	beq	$5,$0,$L2129
	move	$18,$0

$L2261:
	bne	$16,$0,$L2130
	lw	$15,124($sp)

	bne	$15,$0,$L2131
	nop

	lw	$2,132($sp)
	beq	$2,$0,$L2134
	li	$4,4			# 0x4

$L2131:
	lw	$4,-6276($10)
	bne	$4,$0,$L2133
	li	$5,3			# 0x3

	lw	$4,8500($17)
	beq	$4,$5,$L2134
	li	$4,3			# 0x3

$L2133:
	lw	$6,80($sp)
	beq	$6,$0,$L2134
	li	$4,4			# 0x4

$L2130:
	li	$4,3			# 0x3
$L2134:
	sh	$4,64($sp)
	sh	$4,70($sp)
	sh	$4,68($sp)
	sh	$4,66($sp)
	lw	$13,84($sp)
	lw	$4,1548($17)
	lw	$15,80($sp)
	addu	$5,$4,$13
	lb	$5,0($5)
	addu	$4,$4,$3
	lb	$4,0($4)
	addiu	$5,$5,1
	addu	$5,$5,$4
	beq	$15,$0,$L2265
	sra	$9,$5,1

$L2202:
	lw	$6,240($sp)
	lw	$7,104($sp)
	move	$4,$17
	move	$5,$21
	sw	$3,160($sp)
	sw	$8,168($sp)
	sw	$10,172($sp)
	sw	$24,164($sp)
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$9,16($sp)

	lw	$3,160($sp)
	lw	$8,168($sp)
	lw	$10,172($sp)
	bne	$18,$0,$L2128
	lw	$24,164($sp)

	lw	$5,1548($17)
	lw	$4,8740($17)
	addu	$5,$5,$3
	lbu	$5,0($5)
	addiu	$4,$4,1
	addu	$5,$17,$5
	lbu	$5,12096($5)
	lw	$6,5344($10)
	addu	$4,$4,$5
	lw	$7,5348($10)
	sra	$4,$4,1
	lh	$5,64($sp)
	lui	$18,%hi(beta_table+52)
	lui	$2,%hi(alpha_table+52)
	addu	$7,$4,$7
	addiu	$18,$18,%lo(beta_table+52)
	addu	$4,$4,$6
	addiu	$2,$2,%lo(alpha_table+52)
	addu	$7,$18,$7
	addu	$6,$2,$4
	slt	$9,$5,4
	lbu	$6,0($6)
	beq	$9,$0,$L2222
	lbu	$7,0($7)

	bne	$5,$0,$L2223
	sll	$9,$4,1

	move	$9,$0
$L2224:
	lh	$5,66($sp)
	bne	$5,$0,$L2225
	sb	$9,32($sp)

	move	$9,$0
$L2226:
	lh	$5,68($sp)
	bne	$5,$0,$L2227
	sb	$9,33($sp)

	move	$9,$0
$L2228:
	lh	$5,70($sp)
	bne	$5,$0,$L2229
	sb	$9,34($sp)

	move	$4,$0
$L2230:
	lw	$18,120($sp)
	lw	$25,4964($17)
	lw	$5,244($sp)
	sb	$4,35($sp)
	sw	$3,160($sp)
	sw	$8,168($sp)
	sw	$10,172($sp)
	sw	$24,164($sp)
	sw	$18,16($sp)
	jalr	$25
	move	$4,$fp

	lw	$3,160($sp)
	lw	$8,168($sp)
	lw	$10,172($sp)
	lw	$24,164($sp)
$L2231:
	lw	$4,1548($17)
	lw	$5,8744($17)
	addu	$3,$4,$3
	lbu	$4,0($3)
	addiu	$3,$5,1
	addu	$4,$17,$4
	lbu	$4,12352($4)
	lw	$5,5344($10)
	addu	$3,$3,$4
	lw	$7,5348($10)
	sra	$3,$3,1
	addu	$7,$3,$7
	lh	$4,64($sp)
	addu	$3,$3,$5
	lui	$2,%hi(beta_table+52)
	lui	$5,%hi(alpha_table+52)
	addiu	$5,$5,%lo(alpha_table+52)
	addiu	$2,$2,%lo(beta_table+52)
	addu	$6,$5,$3
	addu	$7,$2,$7
	slt	$5,$4,4
	lbu	$6,0($6)
	beq	$5,$0,$L2232
	lbu	$7,0($7)

	bne	$4,$0,$L2233
	sll	$5,$3,1

	move	$5,$0
$L2234:
	lh	$4,66($sp)
	bne	$4,$0,$L2235
	sb	$5,32($sp)

	lh	$4,68($sp)
	move	$5,$0
	bne	$4,$0,$L2237
	sb	$5,33($sp)

$L2276:
	lh	$4,70($sp)
	move	$5,$0
	bne	$4,$0,$L2239
	sb	$5,34($sp)

$L2277:
	move	$3,$0
$L2240:
	lw	$15,120($sp)
	lw	$25,4964($17)
	move	$4,$22
	sb	$3,35($sp)
	sw	$15,16($sp)
$L2254:
	lw	$5,244($sp)
	sw	$8,168($sp)
	sw	$10,172($sp)
	jalr	$25
	sw	$24,164($sp)

	lw	$18,88($sp)
	lw	$8,168($sp)
	lw	$24,164($sp)
	addiu	$16,$16,1
	lw	$2,96($sp)
	slt	$3,$16,$18
	lw	$10,172($sp)
	addiu	$24,$24,2
	addu	$21,$21,$2
	addu	$22,$22,$8
	addiu	$20,$20,4
	addu	$fp,$fp,$8
	addiu	$23,$23,2
	bne	$3,$0,$L2266
	addiu	$19,$19,8

$L2252:
	lw	$22,80($sp)
$L2094:
	addiu	$22,$22,1
	li	$2,2			# 0x2
	beq	$22,$2,$L2245
	nop

	lw	$4,1568($17)
	lw	$7,-6288($10)
	lw	$5,5340($10)
	lw	$2,-6276($10)
	beq	$22,$0,$L2267
	move	$6,$0

$L2081:
	lw	$18,8764($17)
	li	$3,16			# 0x10
	move	$9,$18
	lw	$11,92($sp)
	sll	$3,$3,$22
	sll	$9,$9,2
	move	$12,$18
	ori	$3,$3,0x8
	sw	$18,108($sp)
	sw	$9,116($sp)
	and	$3,$3,$11
	addu	$11,$4,$9
	addu	$9,$7,$12
	lw	$18,0($11)
	bne	$3,$0,$L2268
	lbu	$9,0($9)

$L2085:
	lw	$15,92($sp)
	li	$3,32			# 0x20
	sra	$3,$3,$22
	and	$11,$3,$15
	sltu	$11,$0,$11
	ori	$3,$3,0x8
	sw	$11,128($sp)
	move	$11,$15
	sw	$3,136($sp)
	and	$3,$3,$11
	bne	$6,$0,$L2269
	sw	$3,140($sp)

$L2087:
	xori	$16,$9,0xff
	li	$3,2			# 0x2
	bne	$5,$3,$L2089
	sltu	$16,$16,1

$L2259:
	lw	$12,84($sp)
	li	$13,1			# 0x1
	addu	$7,$7,$12
	lbu	$3,0($7)
	xor	$3,$3,$9
	b	$L2089
	movn	$16,$13,$3

$L2262:
	lb	$6,9456($5)
	lb	$11,9456($9)
	addiu	$6,$6,2
	addiu	$11,$11,2
	lui	$12,%hi(ref2frm.19690)
	addiu	$12,$12,%lo(ref2frm.19690)
	sll	$6,$6,2
	sll	$11,$11,2
	addu	$6,$12,$6
	addu	$11,$12,$11
	lw	$12,0($6)
	lw	$6,0($11)
	bne	$12,$6,$L2195
	addiu	$6,$4,2284

	addiu	$11,$7,2284
	sll	$6,$6,2
	sll	$11,$11,2
	addu	$6,$17,$6
	addu	$11,$17,$11
	lh	$12,0($6)
	lh	$6,0($11)
	subu	$11,$12,$6
	slt	$6,$11,0
	subu	$12,$0,$11
	movn	$11,$12,$6
	slt	$6,$11,4
	beq	$6,$0,$L2291
	li	$12,1			# 0x1

	sll	$12,$4,2
	sll	$13,$7,2
	addu	$12,$17,$12
	addu	$13,$17,$13
	lh	$6,9138($13)
	lh	$11,9138($12)
	lw	$15,144($sp)
	subu	$11,$11,$6
	slt	$6,$11,0
	subu	$14,$0,$11
	movn	$11,$14,$6
	slt	$6,$11,$15
	beq	$6,$0,$L2195
	nop

	lb	$6,9496($9)
	lb	$5,9496($5)
	addiu	$6,$6,2
	addiu	$5,$5,2
	lui	$2,%hi(ref2frm.19690)
	addiu	$2,$2,%lo(ref2frm.19690)
	sll	$5,$5,2
	sll	$6,$6,2
	addu	$5,$2,$5
	addu	$6,$2,$6
	lw	$9,0($5)
	lw	$5,0($6)
	bne	$9,$5,$L2195
	addiu	$4,$4,2324

	addiu	$7,$7,2324
	sll	$4,$4,2
	sll	$7,$7,2
	addu	$4,$17,$4
	addu	$7,$17,$7
	lh	$4,0($4)
	lh	$5,0($7)
	subu	$5,$4,$5
	subu	$6,$0,$5
	slt	$4,$5,0
	movn	$5,$6,$4
	slt	$5,$5,4
	beq	$5,$0,$L2195
	nop

	lh	$4,9298($12)
	lh	$5,9298($13)
	subu	$5,$4,$5
	subu	$6,$0,$5
	slt	$4,$5,0
	movn	$5,$6,$4
	slt	$5,$5,$15
	bne	$5,$0,$L2292
	lh	$4,64($sp)

$L2195:
	li	$12,1			# 0x1
$L2291:
	b	$L2193
	sh	$12,70($sp)

$L2156:
	lb	$11,9456($5)
	lb	$12,9456($9)
	addiu	$11,$11,2
	addiu	$12,$12,2
	lui	$13,%hi(ref2frm.19690)
	addiu	$13,$13,%lo(ref2frm.19690)
	sll	$11,$11,2
	sll	$12,$12,2
	addu	$11,$13,$11
	addu	$12,$13,$12
	lw	$13,0($11)
	lw	$11,0($12)
	bne	$13,$11,$L2157
	addiu	$11,$4,2284

	addiu	$12,$7,2284
	sll	$11,$11,2
	sll	$12,$12,2
	addu	$11,$17,$11
	addu	$12,$17,$12
	lh	$13,0($11)
	lh	$11,0($12)
	subu	$12,$13,$11
	slt	$11,$12,0
	subu	$13,$0,$12
	movn	$12,$13,$11
	slt	$11,$12,4
	beq	$11,$0,$L2157
	sll	$13,$4,2

	sll	$14,$7,2
	addu	$13,$17,$13
	addu	$14,$17,$14
	lh	$11,9138($14)
	lh	$12,9138($13)
	subu	$12,$12,$11
	subu	$15,$0,$12
	slt	$11,$12,0
	movn	$12,$15,$11
	lw	$15,144($sp)
	slt	$11,$12,$15
	beq	$11,$0,$L2157
	lui	$2,%hi(ref2frm.19690)

	lb	$5,9496($5)
	lb	$9,9496($9)
	addiu	$5,$5,2
	addiu	$9,$9,2
	addiu	$2,$2,%lo(ref2frm.19690)
	sll	$5,$5,2
	sll	$9,$9,2
	addu	$5,$2,$5
	addu	$9,$2,$9
	lw	$11,0($5)
	lw	$5,0($9)
	bne	$11,$5,$L2157
	addiu	$4,$4,2324

	addiu	$7,$7,2324
	sll	$4,$4,2
	sll	$7,$7,2
	addu	$4,$17,$4
	addu	$7,$17,$7
	lh	$5,0($4)
	lh	$4,0($7)
	subu	$5,$5,$4
	slt	$4,$5,0
	subu	$7,$0,$5
	movn	$5,$7,$4
	slt	$4,$5,4
	beq	$4,$0,$L2286
	lw	$5,80($sp)

	lh	$4,9298($14)
	lh	$5,9298($13)
	subu	$5,$5,$4
	slt	$4,$5,0
	subu	$7,$0,$5
	movn	$5,$7,$4
	slt	$4,$5,$15
	bne	$4,$0,$L2293
	lw	$5,80($sp)

$L2157:
	lw	$5,80($sp)
$L2286:
	li	$4,1			# 0x1
	bne	$5,$0,$L2270
	sh	$4,64($sp)

	addiu	$4,$16,20
$L2287:
	addu	$5,$17,$4
	lbu	$9,9080($5)
	beq	$9,$0,$L2166
	li	$7,1			# 0x1

$L2168:
	lw	$4,80($sp)
	li	$7,2			# 0x2
	bne	$4,$0,$L2271
	sh	$7,66($sp)

	addiu	$4,$16,28
$L2289:
	addu	$5,$17,$4
	lbu	$9,9080($5)
	beq	$9,$0,$L2179
	li	$7,1			# 0x1

$L2181:
	lw	$4,80($sp)
	li	$5,2			# 0x2
	beq	$4,$0,$L2272
	sh	$5,68($sp)

	addiu	$4,$19,3
$L2290:
	addu	$5,$17,$4
	lbu	$9,9080($5)
	beq	$9,$0,$L2273
	li	$7,8			# 0x8

$L2191:
	li	$5,2			# 0x2
	b	$L2193
	sh	$5,70($sp)

$L2182:
	lb	$11,9456($5)
	lb	$12,9456($9)
	addiu	$11,$11,2
	addiu	$12,$12,2
	lui	$2,%hi(ref2frm.19690)
	addiu	$2,$2,%lo(ref2frm.19690)
	sll	$11,$11,2
	sll	$12,$12,2
	addu	$11,$2,$11
	addu	$12,$2,$12
	lw	$13,0($11)
	lw	$11,0($12)
	bne	$13,$11,$L2183
	addiu	$11,$4,2284

	addiu	$12,$7,2284
	sll	$11,$11,2
	sll	$12,$12,2
	addu	$11,$17,$11
	addu	$12,$17,$12
	lh	$13,0($11)
	lh	$11,0($12)
	subu	$12,$13,$11
	slt	$11,$12,0
	subu	$13,$0,$12
	movn	$12,$13,$11
	slt	$11,$12,4
	beq	$11,$0,$L2183
	sll	$13,$4,2

	sll	$14,$7,2
	addu	$13,$17,$13
	addu	$14,$17,$14
	lh	$11,9138($14)
	lh	$12,9138($13)
	subu	$12,$12,$11
	subu	$15,$0,$12
	slt	$11,$12,0
	movn	$12,$15,$11
	lw	$15,144($sp)
	slt	$11,$12,$15
	beq	$11,$0,$L2183
	nop

	lb	$5,9496($5)
	lb	$9,9496($9)
	addiu	$5,$5,2
	addiu	$9,$9,2
	sll	$5,$5,2
	sll	$9,$9,2
	addu	$5,$2,$5
	addu	$9,$2,$9
	lw	$11,0($5)
	lw	$5,0($9)
	bne	$11,$5,$L2183
	addiu	$4,$4,2324

	addiu	$7,$7,2324
	sll	$4,$4,2
	sll	$7,$7,2
	addu	$4,$17,$4
	addu	$7,$17,$7
	lh	$5,0($4)
	lh	$4,0($7)
	subu	$5,$5,$4
	slt	$4,$5,0
	subu	$7,$0,$5
	movn	$5,$7,$4
	slt	$4,$5,4
	beq	$4,$0,$L2294
	li	$2,1			# 0x1

	lh	$4,9298($14)
	lh	$5,9298($13)
	subu	$5,$5,$4
	slt	$4,$5,0
	subu	$7,$0,$5
	movn	$5,$7,$4
	slt	$4,$5,$15
	bne	$4,$0,$L2295
	lw	$4,80($sp)

$L2183:
	li	$2,1			# 0x1
$L2294:
	b	$L2180
	sh	$2,68($sp)

$L2169:
	lb	$11,9456($5)
	lb	$12,9456($9)
	addiu	$11,$11,2
	addiu	$12,$12,2
	lui	$2,%hi(ref2frm.19690)
	addiu	$2,$2,%lo(ref2frm.19690)
	sll	$11,$11,2
	sll	$12,$12,2
	addu	$11,$2,$11
	addu	$12,$2,$12
	lw	$13,0($11)
	lw	$11,0($12)
	bne	$13,$11,$L2170
	addiu	$11,$4,2284

	addiu	$12,$7,2284
	sll	$11,$11,2
	sll	$12,$12,2
	addu	$11,$17,$11
	addu	$12,$17,$12
	lh	$13,0($11)
	lh	$11,0($12)
	subu	$12,$13,$11
	slt	$11,$12,0
	subu	$13,$0,$12
	movn	$12,$13,$11
	slt	$11,$12,4
	beq	$11,$0,$L2170
	sll	$13,$4,2

	sll	$14,$7,2
	addu	$13,$17,$13
	addu	$14,$17,$14
	lh	$11,9138($14)
	lh	$12,9138($13)
	subu	$12,$12,$11
	subu	$15,$0,$12
	slt	$11,$12,0
	movn	$12,$15,$11
	lw	$15,144($sp)
	slt	$11,$12,$15
	beq	$11,$0,$L2170
	nop

	lb	$5,9496($5)
	lb	$9,9496($9)
	addiu	$5,$5,2
	addiu	$9,$9,2
	sll	$5,$5,2
	sll	$9,$9,2
	addu	$5,$2,$5
	addu	$9,$2,$9
	lw	$11,0($5)
	lw	$5,0($9)
	bne	$11,$5,$L2170
	addiu	$4,$4,2324

	addiu	$7,$7,2324
	sll	$4,$4,2
	sll	$7,$7,2
	addu	$4,$17,$4
	addu	$7,$17,$7
	lh	$5,0($4)
	lh	$4,0($7)
	subu	$5,$5,$4
	slt	$4,$5,0
	subu	$7,$0,$5
	movn	$5,$7,$4
	slt	$4,$5,4
	beq	$4,$0,$L2288
	li	$2,1			# 0x1

	lh	$4,9298($14)
	lh	$5,9298($13)
	subu	$5,$5,$4
	slt	$4,$5,0
	subu	$7,$0,$5
	movn	$5,$7,$4
	slt	$4,$5,$15
	bne	$4,$0,$L2296
	lw	$4,80($sp)

$L2170:
	li	$2,1			# 0x1
$L2288:
	b	$L2167
	sh	$2,66($sp)

$L2030:
	beq	$5,$0,$L2032
	nop

	lb	$5,-1($10)
	addiu	$10,$7,1
	addu	$5,$10,$5
	sra	$5,$5,1
	slt	$5,$3,$5
	beq	$5,$0,$L2032
	lw	$15,92($sp)

	andi	$6,$6,0x1
	andi	$15,$15,0x7
	sw	$6,148($sp)
	lw	$5,5340($8)
	lw	$7,-6288($8)
	move	$6,$0
	b	$L2031
	sw	$15,152($sp)

$L2032:
	beq	$6,$0,$L2297
	lw	$31,212($sp)

	lw	$5,8764($17)
	addu	$9,$9,$5
	lb	$5,0($9)
	addiu	$5,$5,1
	addu	$7,$5,$7
	sra	$7,$7,1
	slt	$3,$3,$7
	beq	$3,$0,$L2297
	lw	$18,92($sp)

	li	$3,65536			# 0x10000
	addu	$3,$17,$3
	andi	$6,$6,0x1
	andi	$18,$18,0x7
	sw	$6,148($sp)
	lw	$5,5340($3)
	lw	$7,-6288($3)
	move	$6,$0
	b	$L2031
	sw	$18,152($sp)

$L2245:
	lw	$31,212($sp)
$L2297:
	lw	$fp,208($sp)
	lw	$23,204($sp)
	lw	$22,200($sp)
	lw	$21,196($sp)
	lw	$20,192($sp)
	lw	$19,188($sp)
	lw	$18,184($sp)
	lw	$17,180($sp)
	lw	$16,176($sp)
	j	$31
	addiu	$sp,$sp,216

$L2260:
	b	$L2127
	lw	$3,84($sp)

$L2155:
$L2285:
	b	$L2154
	sh	$13,64($sp)

$L2263:
	lw	$5,1548($17)
	lw	$4,8740($17)
	addu	$5,$5,$3
	lbu	$5,0($5)
	addiu	$4,$4,1
	addu	$5,$17,$5
	lbu	$5,12096($5)
	lw	$6,5344($10)
	addu	$4,$4,$5
	lw	$7,5348($10)
	sra	$4,$4,1
	lh	$5,64($sp)
	lui	$18,%hi(beta_table+52)
	lui	$2,%hi(alpha_table+52)
	addu	$7,$4,$7
	addiu	$18,$18,%lo(beta_table+52)
	addu	$4,$4,$6
	addiu	$2,$2,%lo(alpha_table+52)
	addu	$7,$18,$7
	addu	$6,$2,$4
	slt	$9,$5,4
	lbu	$6,0($6)
	beq	$9,$0,$L2203
	lbu	$7,0($7)

	bne	$5,$0,$L2204
	sll	$9,$4,1

	move	$9,$0
$L2205:
	lh	$5,66($sp)
	bne	$5,$0,$L2206
	sb	$9,32($sp)

	move	$9,$0
$L2207:
	lh	$5,68($sp)
	bne	$5,$0,$L2208
	sb	$9,33($sp)

	move	$9,$0
$L2209:
	lh	$5,70($sp)
	bne	$5,$0,$L2210
	sb	$9,34($sp)

	move	$4,$0
$L2211:
	lw	$18,120($sp)
	lw	$25,4968($17)
	lw	$5,244($sp)
	sb	$4,35($sp)
	sw	$3,160($sp)
	sw	$8,168($sp)
	sw	$10,172($sp)
	sw	$24,164($sp)
	sw	$18,16($sp)
	jalr	$25
	move	$4,$23

	lw	$3,160($sp)
	lw	$8,168($sp)
	lw	$10,172($sp)
	lw	$24,164($sp)
$L2212:
	lw	$4,1548($17)
	lw	$5,8744($17)
	addu	$3,$4,$3
	lbu	$4,0($3)
	addiu	$3,$5,1
	addu	$4,$17,$4
	lbu	$4,12352($4)
	lw	$5,5344($10)
	addu	$3,$3,$4
	lw	$7,5348($10)
	sra	$3,$3,1
	addu	$7,$3,$7
	lh	$4,64($sp)
	addu	$3,$3,$5
	lui	$2,%hi(beta_table+52)
	lui	$5,%hi(alpha_table+52)
	addiu	$5,$5,%lo(alpha_table+52)
	addiu	$2,$2,%lo(beta_table+52)
	addu	$6,$5,$3
	addu	$7,$2,$7
	slt	$5,$4,4
	lbu	$6,0($6)
	beq	$5,$0,$L2213
	lbu	$7,0($7)

	bne	$4,$0,$L2214
	sll	$5,$3,1

	move	$5,$0
$L2215:
	lh	$4,66($sp)
	bne	$4,$0,$L2216
	sb	$5,32($sp)

	move	$5,$0
$L2217:
	lh	$4,68($sp)
	bne	$4,$0,$L2218
	sb	$5,33($sp)

	move	$5,$0
$L2219:
	lh	$4,70($sp)
	bne	$4,$0,$L2220
	sb	$5,34($sp)

	move	$3,$0
$L2221:
	lw	$15,120($sp)
	lw	$25,4968($17)
	move	$4,$24
	sb	$3,35($sp)
	b	$L2254
	sw	$15,16($sp)

$L2151:
	b	$L2152
	li	$7,1			# 0x1

$L2136:
	lw	$5,-6276($10)
	beq	$5,$0,$L2298
	lw	$12,140($sp)

	lw	$9,92($sp)
	xor	$5,$4,$9
	andi	$5,$5,0x80
	beq	$5,$0,$L2138
	li	$11,1			# 0x1

	sh	$11,70($sp)
	sh	$11,68($sp)
	sh	$11,66($sp)
	sh	$11,64($sp)
	b	$L2137
	li	$6,1			# 0x1

$L2138:
$L2298:
	beq	$12,$0,$L2137
	move	$6,$0

	bne	$16,$0,$L2299
	lw	$15,80($sp)

	lw	$13,136($sp)
	and	$4,$4,$13
	beq	$4,$0,$L2301
	lw	$12,80($sp)

$L2299:
	beq	$15,$0,$L2141
	addiu	$4,$16,12

	lw	$6,-6284($10)
	move	$4,$19
	li	$5,8			# 0x8
	li	$2,3			# 0x3
	beq	$6,$2,$L2274
	subu	$5,$4,$5

$L2142:
	addu	$7,$17,$4
	addu	$6,$17,$5
	lb	$7,9456($7)
	lb	$6,9456($6)
	addiu	$7,$7,2
	addiu	$6,$6,2
	lui	$9,%hi(ref2frm.19690)
	addiu	$9,$9,%lo(ref2frm.19690)
	sll	$7,$7,2
	sll	$6,$6,2
	addu	$7,$7,$9
	addu	$6,$6,$9
	lw	$7,0($7)
	lw	$6,0($6)
	beq	$7,$6,$L2275
	addiu	$7,$5,2284

$L2143:
	li	$5,1			# 0x1
$L2148:
	sh	$5,64($sp)
	sh	$5,70($sp)
	sh	$5,68($sp)
	sh	$5,66($sp)
	b	$L2137
	li	$6,1			# 0x1

$L2275:
	addiu	$6,$4,2284
	sll	$6,$6,2
	sll	$7,$7,2
	addu	$6,$17,$6
	addu	$7,$17,$7
	lh	$9,0($6)
	lh	$6,0($7)
	subu	$7,$9,$6
	slt	$6,$7,0
	subu	$9,$0,$7
	movn	$7,$9,$6
	slt	$6,$7,4
	beq	$6,$0,$L2143
	sll	$4,$4,2

	sll	$5,$5,2
	addu	$4,$17,$4
	addu	$5,$17,$5
	lh	$4,9138($4)
	lh	$5,9138($5)
	lw	$11,144($sp)
	subu	$5,$4,$5
	subu	$6,$0,$5
	slt	$4,$5,0
	movn	$5,$6,$4
	slt	$5,$5,$11
	b	$L2148
	xori	$5,$5,0x1

$L2235:
	sll	$5,$3,1
	lui	$11,%hi(tc0_table+156)
	addu	$5,$5,$3
	addiu	$11,$11,%lo(tc0_table+156)
	addu	$5,$11,$5
	addu	$4,$5,$4
	lbu	$5,-1($4)
	lh	$4,68($sp)
	addiu	$5,$5,1
	sll	$5,$5,24
	sra	$5,$5,24
	beq	$4,$0,$L2276
	sb	$5,33($sp)

$L2237:
	sll	$5,$3,1
	lui	$12,%hi(tc0_table+156)
	addu	$5,$5,$3
	addiu	$12,$12,%lo(tc0_table+156)
	addu	$5,$12,$5
	addu	$4,$5,$4
	lbu	$5,-1($4)
	lh	$4,70($sp)
	addiu	$5,$5,1
	sll	$5,$5,24
	sra	$5,$5,24
	beq	$4,$0,$L2277
	sb	$5,34($sp)

$L2239:
	sll	$5,$3,1
	lui	$13,%hi(tc0_table+156)
	addu	$3,$5,$3
	addiu	$13,$13,%lo(tc0_table+156)
	addu	$3,$13,$3
	addu	$3,$3,$4
	lbu	$3,-1($3)
	addiu	$3,$3,1
	sll	$3,$3,24
	b	$L2240
	sra	$3,$3,24

$L2233:
	lui	$9,%hi(tc0_table+156)
	addu	$5,$5,$3
	addiu	$9,$9,%lo(tc0_table+156)
	addu	$5,$9,$5
	addu	$4,$5,$4
	lbu	$5,-1($4)
	addiu	$5,$5,1
	sll	$5,$5,24
	b	$L2234
	sra	$5,$5,24

$L2229:
	sll	$9,$4,1
	lui	$15,%hi(tc0_table+156)
	addu	$4,$9,$4
	addiu	$15,$15,%lo(tc0_table+156)
	addu	$4,$15,$4
	addu	$4,$4,$5
	lbu	$4,-1($4)
	addiu	$4,$4,1
	sll	$4,$4,24
	b	$L2230
	sra	$4,$4,24

$L2227:
	sll	$9,$4,1
	lui	$13,%hi(tc0_table+156)
	addu	$9,$9,$4
	addiu	$13,$13,%lo(tc0_table+156)
	addu	$9,$13,$9
	addu	$5,$9,$5
	lbu	$9,-1($5)
	addiu	$9,$9,1
	sll	$9,$9,24
	b	$L2228
	sra	$9,$9,24

$L2225:
	sll	$9,$4,1
	lui	$12,%hi(tc0_table+156)
	addu	$9,$9,$4
	addiu	$12,$12,%lo(tc0_table+156)
	addu	$9,$12,$9
	addu	$5,$9,$5
	lbu	$9,-1($5)
	addiu	$9,$9,1
	sll	$9,$9,24
	b	$L2226
	sra	$9,$9,24

$L2223:
	lui	$11,%hi(tc0_table+156)
	addu	$9,$9,$4
	addiu	$11,$11,%lo(tc0_table+156)
	addu	$9,$11,$9
	addu	$5,$9,$5
	lbu	$9,-1($5)
	addiu	$9,$9,1
	sll	$9,$9,24
	b	$L2224
	sra	$9,$9,24

$L2220:
	sll	$5,$3,1
	lui	$13,%hi(tc0_table+156)
	addu	$3,$5,$3
	addiu	$13,$13,%lo(tc0_table+156)
	addu	$3,$13,$3
	addu	$3,$3,$4
	lbu	$3,-1($3)
	addiu	$3,$3,1
	sll	$3,$3,24
	b	$L2221
	sra	$3,$3,24

$L2218:
	sll	$5,$3,1
	lui	$12,%hi(tc0_table+156)
	addu	$5,$5,$3
	addiu	$12,$12,%lo(tc0_table+156)
	addu	$5,$12,$5
	addu	$4,$5,$4
	lbu	$5,-1($4)
	addiu	$5,$5,1
	sll	$5,$5,24
	b	$L2219
	sra	$5,$5,24

$L2216:
	sll	$5,$3,1
	lui	$11,%hi(tc0_table+156)
	addu	$5,$5,$3
	addiu	$11,$11,%lo(tc0_table+156)
	addu	$5,$11,$5
	addu	$4,$5,$4
	lbu	$5,-1($4)
	addiu	$5,$5,1
	sll	$5,$5,24
	b	$L2217
	sra	$5,$5,24

$L2214:
	lui	$9,%hi(tc0_table+156)
	addu	$5,$5,$3
	addiu	$9,$9,%lo(tc0_table+156)
	addu	$5,$9,$5
	addu	$4,$5,$4
	lbu	$5,-1($4)
	addiu	$5,$5,1
	sll	$5,$5,24
	b	$L2215
	sra	$5,$5,24

$L2210:
	sll	$9,$4,1
	lui	$15,%hi(tc0_table+156)
	addu	$4,$9,$4
	addiu	$15,$15,%lo(tc0_table+156)
	addu	$4,$15,$4
	addu	$4,$4,$5
	lbu	$4,-1($4)
	addiu	$4,$4,1
	sll	$4,$4,24
	b	$L2211
	sra	$4,$4,24

$L2208:
	sll	$9,$4,1
	lui	$13,%hi(tc0_table+156)
	addu	$9,$9,$4
	addiu	$13,$13,%lo(tc0_table+156)
	addu	$9,$13,$9
	addu	$5,$9,$5
	lbu	$9,-1($5)
	addiu	$9,$9,1
	sll	$9,$9,24
	b	$L2209
	sra	$9,$9,24

$L2206:
	sll	$9,$4,1
	lui	$12,%hi(tc0_table+156)
	addu	$9,$9,$4
	addiu	$12,$12,%lo(tc0_table+156)
	addu	$9,$12,$9
	addu	$5,$9,$5
	lbu	$9,-1($5)
	addiu	$9,$9,1
	sll	$9,$9,24
	b	$L2207
	sra	$9,$9,24

$L2204:
	lui	$11,%hi(tc0_table+156)
	addu	$9,$9,$4
	addiu	$11,$11,%lo(tc0_table+156)
	addu	$9,$11,$9
	addu	$5,$9,$5
	lbu	$9,-1($5)
	addiu	$9,$9,1
	sll	$9,$9,24
	b	$L2205
	sra	$9,$9,24

$L2213:
	lw	$25,4976($17)
	lw	$5,244($sp)
	move	$4,$24
	sw	$8,168($sp)
	sw	$10,172($sp)
	jalr	$25
	sw	$24,164($sp)

	lw	$8,168($sp)
	lw	$10,172($sp)
	b	$L2128
	lw	$24,164($sp)

$L2203:
	lw	$25,4976($17)
	lw	$5,244($sp)
	sw	$3,160($sp)
	sw	$8,168($sp)
	sw	$10,172($sp)
	sw	$24,164($sp)
	jalr	$25
	move	$4,$23

	lw	$24,164($sp)
	lw	$10,172($sp)
	lw	$8,168($sp)
	b	$L2212
	lw	$3,160($sp)

$L2232:
	lw	$25,4972($17)
	lw	$5,244($sp)
	sw	$8,168($sp)
	sw	$10,172($sp)
	sw	$24,164($sp)
	jalr	$25
	move	$4,$22

	lw	$24,164($sp)
	lw	$10,172($sp)
	b	$L2128
	lw	$8,168($sp)

$L2222:
	lw	$25,4972($17)
	lw	$5,244($sp)
	sw	$3,160($sp)
	sw	$8,168($sp)
	sw	$10,172($sp)
	sw	$24,164($sp)
	jalr	$25
	move	$4,$fp

	lw	$24,164($sp)
	lw	$10,172($sp)
	lw	$8,168($sp)
	b	$L2231
	lw	$3,160($sp)

$L2091:
	bne	$5,$0,$L2283
	lw	$3,88($sp)

	bne	$16,$0,$L2095
	lw	$6,124($sp)

	bne	$6,$0,$L2278
	andi	$7,$18,0x80

	beq	$7,$0,$L2096
	sw	$7,132($sp)

	lw	$16,152($17)
	lw	$9,84($sp)
	sll	$16,$16,1
	addiu	$11,$sp,72
	lw	$21,228($sp)
	subu	$16,$9,$16
	move	$19,$0
	move	$23,$0
	li	$20,3			# 0x3
	sw	$11,120($sp)
	addiu	$fp,$sp,32
	sw	$8,80($sp)
$L2124:
	lw	$12,152($sp)
	bne	$12,$0,$L2097
	sll	$2,$16,2

	lw	$3,1568($17)
	addu	$2,$3,$2
	lw	$2,0($2)
	andi	$2,$2,0x7
	bne	$2,$0,$L2097
	sll	$2,$16,4

	lw	$5,9128($17)
	addu	$5,$5,$2
	lui	$3,%hi(nnz_idx.19718)
	lw	$2,104($sp)
	move	$4,$17
	addiu	$3,$3,%lo(nnz_idx.19718)
$L2103:
	lbu	$6,9092($4)
	bne	$6,$0,$L2300
	li	$13,2			# 0x2

	lw	$6,0($3)
	addu	$6,$5,$6
	lbu	$6,0($6)
	bne	$6,$0,$L2100
	li	$15,1			# 0x1

	sh	$15,0($2)
$L2102:
	lw	$6,120($sp)
	addiu	$2,$2,2
	addiu	$4,$4,1
	bne	$2,$6,$L2103
	addiu	$3,$3,4

$L2099:
	lw	$2,1548($17)
	lw	$7,84($sp)
	lw	$6,156($sp)
	addu	$3,$2,$7
	lb	$3,0($3)
	addu	$2,$2,$16
	lb	$2,0($2)
	addiu	$3,$3,1
	addu	$2,$3,$2
	lw	$7,104($sp)
	sra	$2,$2,1
	move	$4,$17
	move	$5,$21
	sw	$2,16($sp)
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$10,172($sp)

	lw	$2,1548($17)
	lw	$3,8740($17)
	addu	$2,$2,$16
	lbu	$2,0($2)
	lw	$10,172($sp)
	addu	$2,$17,$2
	lbu	$2,12096($2)
	addiu	$3,$3,1
	lw	$5,5344($10)
	addu	$2,$3,$2
	lw	$4,5348($10)
	sra	$2,$2,1
	lh	$3,64($sp)
	lui	$8,%hi(beta_table+52)
	lui	$9,%hi(alpha_table+52)
	addu	$4,$2,$4
	addiu	$8,$8,%lo(beta_table+52)
	addu	$2,$2,$5
	addiu	$9,$9,%lo(alpha_table+52)
	lw	$11,232($sp)
	addu	$4,$8,$4
	addu	$6,$9,$2
	slt	$5,$3,4
	lbu	$7,0($4)
	lbu	$6,0($6)
	beq	$5,$0,$L2104
	addu	$4,$11,$19

	bne	$3,$0,$L2105
	sll	$5,$2,1

	move	$5,$0
$L2106:
	lh	$3,66($sp)
	bne	$3,$0,$L2107
	sb	$5,32($sp)

	move	$5,$0
$L2108:
	lh	$3,68($sp)
	bne	$3,$0,$L2109
	sb	$5,33($sp)

	move	$5,$0
$L2110:
	lh	$3,70($sp)
	bne	$3,$0,$L2111
	sb	$5,34($sp)

	move	$2,$0
$L2112:
	lw	$25,4964($17)
	lw	$5,80($sp)
	sw	$10,172($sp)
	sb	$2,35($sp)
	jalr	$25
	sw	$fp,16($sp)

	lw	$10,172($sp)
$L2113:
	lw	$2,1548($17)
	lw	$3,8744($17)
	addu	$2,$2,$16
	lbu	$2,0($2)
	addiu	$3,$3,1
	addu	$2,$17,$2
	lbu	$2,12352($2)
	lw	$5,5344($10)
	addu	$2,$3,$2
	lw	$4,5348($10)
	sra	$2,$2,1
	lh	$3,64($sp)
	lui	$6,%hi(beta_table+52)
	lui	$7,%hi(alpha_table+52)
	addu	$4,$2,$4
	addiu	$6,$6,%lo(beta_table+52)
	addu	$2,$2,$5
	addiu	$7,$7,%lo(alpha_table+52)
	lw	$8,236($sp)
	addu	$4,$6,$4
	slt	$5,$3,4
	addu	$6,$7,$2
	lbu	$6,0($6)
	lbu	$7,0($4)
	beq	$5,$0,$L2114
	addu	$4,$8,$19

	bne	$3,$0,$L2115
	sll	$5,$2,1

	move	$5,$0
$L2116:
	lh	$3,66($sp)
	bne	$3,$0,$L2117
	sb	$5,32($sp)

	move	$5,$0
$L2118:
	lh	$3,68($sp)
	bne	$3,$0,$L2119
	sb	$5,33($sp)

	move	$5,$0
$L2120:
	lh	$3,70($sp)
	bne	$3,$0,$L2121
	sb	$5,34($sp)

	move	$2,$0
$L2122:
	lw	$25,4964($17)
	lw	$5,80($sp)
	sw	$10,172($sp)
	sb	$2,35($sp)
	jalr	$25
	sw	$fp,16($sp)

	lw	$10,172($sp)
$L2123:
	lw	$2,240($sp)
	lw	$15,244($sp)
	addiu	$23,$23,1
	li	$3,2			# 0x2
	addu	$21,$21,$2
	addu	$19,$19,$15
	bne	$23,$3,$L2279
	lw	$2,152($17)

	lw	$8,80($sp)
$L2095:
	b	$L2092
	li	$16,1			# 0x1

$L2278:
	andi	$18,$18,0x80
	sw	$18,132($sp)
$L2096:
	b	$L2093
	move	$16,$0

$L2141:
	lw	$6,-6284($10)
	li	$5,1			# 0x1
	li	$2,3			# 0x3
	bne	$6,$2,$L2142
	subu	$5,$4,$5

$L2274:
	addu	$9,$17,$4
	addu	$11,$17,$5
	lb	$6,9456($9)
	lb	$7,9456($11)
	addiu	$6,$6,2
	addiu	$7,$7,2
	lui	$12,%hi(ref2frm.19690)
	addiu	$12,$12,%lo(ref2frm.19690)
	sll	$6,$6,2
	sll	$7,$7,2
	addu	$6,$12,$6
	addu	$7,$12,$7
	lw	$12,0($6)
	lw	$6,0($7)
	bne	$12,$6,$L2143
	addiu	$7,$5,2284

	addiu	$6,$4,2284
	sll	$6,$6,2
	sll	$7,$7,2
	addu	$6,$17,$6
	addu	$7,$17,$7
	lh	$12,0($6)
	lh	$6,0($7)
	subu	$7,$12,$6
	slt	$6,$7,0
	subu	$12,$0,$7
	movn	$7,$12,$6
	slt	$6,$7,4
	beq	$6,$0,$L2143
	sll	$12,$4,2

	sll	$13,$5,2
	addu	$12,$17,$12
	addu	$13,$17,$13
	lh	$6,9138($13)
	lh	$7,9138($12)
	lw	$15,144($sp)
	subu	$7,$7,$6
	slt	$6,$7,0
	subu	$14,$0,$7
	movn	$7,$14,$6
	slt	$6,$7,$15
	beq	$6,$0,$L2143
	nop

	lb	$6,9496($9)
	lb	$7,9496($11)
	addiu	$6,$6,2
	addiu	$7,$7,2
	lui	$2,%hi(ref2frm.19690)
	addiu	$2,$2,%lo(ref2frm.19690)
	sll	$6,$6,2
	sll	$7,$7,2
	addu	$6,$2,$6
	addu	$7,$2,$7
	lw	$9,0($6)
	lw	$6,0($7)
	bne	$9,$6,$L2143
	addiu	$4,$4,2324

	addiu	$5,$5,2324
	sll	$4,$4,2
	sll	$5,$5,2
	addu	$4,$17,$4
	addu	$5,$17,$5
	lh	$4,0($4)
	lh	$5,0($5)
	subu	$5,$4,$5
	subu	$6,$0,$5
	slt	$4,$5,0
	movn	$5,$6,$4
	slt	$5,$5,4
	beq	$5,$0,$L2143
	nop

	lh	$4,9298($12)
	lh	$5,9298($13)
	subu	$5,$4,$5
	subu	$6,$0,$5
	slt	$4,$5,0
	movn	$5,$6,$4
	slt	$5,$5,$15
	b	$L2148
	xori	$5,$5,0x1

$L2257:
	andi	$6,$6,0x1
	sw	$6,148($sp)
	lw	$5,5340($8)
	move	$6,$0
	b	$L2031
	sw	$13,152($sp)

$L2256:
	lw	$3,92($sp)
	andi	$6,$6,0x1
	andi	$3,$3,0x7
	sw	$6,148($sp)
	lw	$5,5340($8)
	move	$6,$0
	b	$L2031
	sw	$3,152($sp)

$L2258:
	addu	$8,$7,$15
	lbu	$8,0($8)
	beq	$8,$10,$L2036
	lw	$18,92($sp)

	andi	$6,$6,0x1
	andi	$18,$18,0x7
	sw	$6,148($sp)
	li	$5,2			# 0x2
	move	$6,$0
	b	$L2031
	sw	$18,152($sp)

$L2054:
	lbu	$12,0($4)
	lbu	$11,0($3)
	lbu	$14,0($6)
	subu	$19,$12,$11
	subu	$15,$0,$19
	slt	$24,$19,0
	movn	$19,$15,$24
	slt	$21,$19,$20
	lbu	$18,0($8)
	lbu	$15,0($5)
	beq	$21,$0,$L2051
	lbu	$24,0($7)

	subu	$21,$14,$12
	subu	$17,$0,$21
	slt	$22,$21,0
	movn	$21,$17,$22
	slt	$21,$21,$13
	beq	$21,$0,$L2051
	subu	$21,$15,$11

	subu	$17,$0,$21
	slt	$22,$21,0
	movn	$21,$17,$22
	slt	$21,$21,$13
	beq	$21,$0,$L2051
	sra	$20,$20,2

	addiu	$20,$20,1
	slt	$19,$20,$19
	bne	$19,$0,$L2073
	subu	$19,$18,$12

	subu	$20,$0,$19
	slt	$21,$19,0
	movn	$19,$20,$21
	slt	$19,$19,$13
	beq	$19,$0,$L2074
	addu	$19,$12,$15

	addiu	$21,$11,4
	addu	$21,$21,$12
	lbu	$17,-4($3)
	addu	$21,$21,$14
	sw	$21,88($sp)
	sw	$17,80($sp)
	sll	$22,$18,1
	lw	$17,88($sp)
	addu	$22,$22,$18
	addu	$22,$17,$22
	sw	$22,88($sp)
	addu	$20,$12,$14
	lw	$22,80($sp)
	addiu	$19,$11,2
	lw	$17,88($sp)
	addu	$20,$20,$11
	addu	$19,$19,$12
	addu	$21,$18,$15
	addiu	$21,$21,4
	sll	$22,$22,1
	sll	$20,$20,1
	addu	$19,$19,$14
	addu	$20,$21,$20
	addu	$19,$19,$18
	addu	$21,$17,$22
	sra	$20,$20,3
	sra	$19,$19,2
	sra	$21,$21,3
	sw	$22,80($sp)
	sb	$20,0($4)
	sb	$19,0($6)
	sb	$21,0($8)
$L2076:
	subu	$18,$24,$11
	subu	$19,$0,$18
	slt	$20,$18,0
	movn	$18,$19,$20
	slt	$13,$18,$13
	beq	$13,$0,$L2077
	addiu	$18,$11,4

	lbu	$13,3($3)
	addu	$18,$18,$12
	sll	$19,$24,1
	addu	$12,$12,$15
	addu	$19,$19,$24
	addu	$12,$12,$11
	addu	$14,$14,$24
	addu	$15,$18,$15
	sll	$11,$12,1
	addu	$15,$15,$19
	addiu	$14,$14,4
	sll	$13,$13,1
	addiu	$24,$24,2
	addu	$14,$14,$11
	addu	$12,$24,$12
	addu	$13,$15,$13
	sra	$14,$14,3
	sra	$12,$12,2
	sra	$13,$13,3
	sb	$14,0($3)
	sb	$12,0($5)
	b	$L2051
	sb	$13,0($7)

$L2100:
$L2300:
	b	$L2102
	sh	$13,0($2)

$L2079:
	mflo	$4
	lw	$5,232($sp)
	lw	$6,244($sp)
	mflo	$17
	addiu	$2,$sp,48
	move	$7,$16
	.option	pic0
	jal	filter_mb_mbaff_edgecv
	.option	pic2
	sw	$2,16($sp)

	lw	$5,236($sp)
	lw	$6,244($sp)
	addiu	$2,$sp,56
	move	$7,$16
	move	$4,$17
	.option	pic0
	jal	filter_mb_mbaff_edgecv
	.option	pic2
	sw	$2,16($sp)

	li	$3,65536			# 0x10000
	addu	$3,$17,$3
	lw	$2,-6276($3)
	lw	$4,1568($17)
	lw	$7,-6288($3)
	lw	$5,5340($3)
	b	$L2031
	li	$6,1			# 0x1

$L2097:
	sh	$20,70($sp)
	sh	$20,68($sp)
	sh	$20,66($sp)
	b	$L2099
	sh	$20,64($sp)

$L2279:
	b	$L2124
	addu	$16,$16,$2

$L2121:
	sll	$5,$2,1
	lui	$13,%hi(tc0_table+156)
	addu	$2,$5,$2
	addiu	$13,$13,%lo(tc0_table+156)
	addu	$2,$13,$2
	addu	$2,$2,$3
	lbu	$2,-1($2)
	addiu	$2,$2,1
	sll	$2,$2,24
	b	$L2122
	sra	$2,$2,24

$L2119:
	sll	$5,$2,1
	lui	$12,%hi(tc0_table+156)
	addu	$5,$5,$2
	addiu	$12,$12,%lo(tc0_table+156)
	addu	$5,$12,$5
	addu	$3,$5,$3
	lbu	$5,-1($3)
	addiu	$5,$5,1
	sll	$5,$5,24
	b	$L2120
	sra	$5,$5,24

$L2037:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,-6272($2)
	andi	$6,$6,0x1
	sw	$6,148($sp)
	bne	$2,$0,$L2039
	sll	$13,$6,1

	addiu	$16,$sp,64
	move	$6,$16
	addiu	$7,$sp,32
	li	$12,4			# 0x4
	li	$11,1			# 0x1
	li	$10,2			# 0x2
	b	$L2044
	li	$9,8			# 0x8

$L2280:
	lbu	$15,9092($15)
	sll	$8,$8,4
	bne	$15,$0,$L2043
	sra	$14,$2,2

	lw	$15,9128($17)
	addu	$8,$15,$8
	addu	$8,$8,$13
	addu	$8,$8,$14
	lbu	$8,0($8)
	bne	$8,$0,$L2043
	nop

	sh	$11,0($6)
$L2042:
	addiu	$2,$2,1
	beq	$2,$9,$L2038
	addiu	$6,$6,2

$L2044:
	andi	$8,$2,0x1
	sll	$8,$8,2
	addu	$8,$7,$8
	lw	$8,0($8)
	sra	$15,$2,1
	sll	$14,$8,2
	addu	$14,$4,$14
	lw	$14,0($14)
	sll	$15,$15,3
	andi	$14,$14,0x7
	beq	$14,$0,$L2280
	addu	$15,$17,$15

	b	$L2042
	sh	$12,0($6)

$L2043:
	b	$L2042
	sh	$10,0($6)

$L2117:
	sll	$5,$2,1
	lui	$11,%hi(tc0_table+156)
	addu	$5,$5,$2
	addiu	$11,$11,%lo(tc0_table+156)
	addu	$5,$11,$5
	addu	$3,$5,$3
	lbu	$5,-1($3)
	addiu	$5,$5,1
	sll	$5,$5,24
	b	$L2118
	sra	$5,$5,24

$L2115:
	lui	$9,%hi(tc0_table+156)
	addu	$5,$5,$2
	addiu	$9,$9,%lo(tc0_table+156)
	addu	$5,$9,$5
	addu	$3,$5,$3
	lbu	$5,-1($3)
	addiu	$5,$5,1
	sll	$5,$5,24
	b	$L2116
	sra	$5,$5,24

$L2114:
	lw	$25,4972($17)
	lw	$5,80($sp)
	jalr	$25
	sw	$10,172($sp)

	b	$L2123
	lw	$10,172($sp)

$L2111:
	sll	$5,$2,1
	addu	$2,$5,$2
	lui	$5,%hi(tc0_table+156)
	addiu	$5,$5,%lo(tc0_table+156)
	addu	$2,$5,$2
	addu	$2,$2,$3
	lbu	$2,-1($2)
	addiu	$2,$2,1
	sll	$2,$2,24
	b	$L2112
	sra	$2,$2,24

$L2109:
	sll	$5,$2,1
	lui	$15,%hi(tc0_table+156)
	addu	$5,$5,$2
	addiu	$15,$15,%lo(tc0_table+156)
	addu	$5,$15,$5
	addu	$3,$5,$3
	lbu	$5,-1($3)
	addiu	$5,$5,1
	sll	$5,$5,24
	b	$L2110
	sra	$5,$5,24

$L2107:
	sll	$5,$2,1
	lui	$13,%hi(tc0_table+156)
	addu	$5,$5,$2
	addiu	$13,$13,%lo(tc0_table+156)
	addu	$5,$13,$5
	addu	$3,$5,$3
	lbu	$5,-1($3)
	addiu	$5,$5,1
	sll	$5,$5,24
	b	$L2108
	sra	$5,$5,24

$L2105:
	lui	$12,%hi(tc0_table+156)
	addu	$5,$5,$2
	addiu	$12,$12,%lo(tc0_table+156)
	addu	$5,$12,$5
	addu	$3,$5,$3
	lbu	$5,-1($3)
	addiu	$5,$5,1
	sll	$5,$5,24
	b	$L2106
	sra	$5,$5,24

$L2104:
	lw	$25,4972($17)
	lw	$5,80($sp)
	jalr	$25
	sw	$10,172($sp)

	b	$L2113
	lw	$10,172($sp)

$L2039:
	addiu	$16,$sp,64
	move	$6,$16
	move	$2,$0
	addiu	$7,$sp,32
	li	$12,2			# 0x2
	li	$11,1			# 0x1
	li	$10,4			# 0x4
	b	$L2049
	li	$9,8			# 0x8

$L2281:
	sh	$10,0($6)
$L2046:
	addiu	$2,$2,1
	beq	$2,$9,$L2038
	addiu	$6,$6,2

$L2049:
	sra	$8,$2,2
	sll	$8,$8,2
	addu	$8,$7,$8
	lw	$8,0($8)
	sra	$14,$2,1
	sll	$13,$8,2
	addu	$13,$4,$13
	lw	$13,0($13)
	sll	$14,$14,3
	andi	$13,$13,0x7
	bne	$13,$0,$L2281
	addu	$14,$17,$14

	lbu	$14,9092($14)
	sll	$8,$8,4
	bne	$14,$0,$L2047
	andi	$13,$2,0x3

	lw	$14,9128($17)
	addu	$8,$14,$8
	addu	$8,$8,$13
	lbu	$8,0($8)
	bne	$8,$0,$L2047
	nop

	b	$L2046
	sh	$11,0($6)

$L2047:
	b	$L2046
	sh	$12,0($6)

$L2068:
	b	$L2253
	andi	$11,$11,0x00ff

$L2066:
	b	$L2067
	andi	$14,$14,0x00ff

$L2058:
	addu	$20,$20,$14
	sra	$20,$20,1
	sll	$15,$19,1
	subu	$15,$20,$15
	addu	$24,$15,$24
	sra	$24,$24,1
	subu	$15,$0,$11
	slt	$20,$24,$15
	bne	$20,$0,$L2061
	nop

	slt	$15,$24,$11
	movz	$24,$11,$15
	move	$15,$24
$L2061:
	addu	$15,$19,$15
	sb	$15,0($6)
	b	$L2060
	addiu	$15,$11,1

$L2077:
	addiu	$11,$11,2
	addu	$11,$11,$14
	sll	$15,$15,1
	addu	$11,$11,$15
	b	$L2253
	sra	$11,$11,2

$L2074:
	addiu	$19,$19,2
	sll	$18,$14,1
	addu	$18,$19,$18
	sra	$18,$18,2
	b	$L2076
	sb	$18,0($4)

$L2073:
	addu	$12,$12,$15
	addiu	$11,$11,2
	addu	$11,$11,$14
	addiu	$12,$12,2
	sll	$15,$15,1
	sll	$14,$14,1
	addu	$12,$12,$14
	addu	$15,$11,$15
	sra	$12,$12,2
	sra	$15,$15,2
	sb	$12,0($4)
	b	$L2051
	sb	$15,0($3)

	.set	macro
	.set	reorder
	.end	filter_mb
	.size	filter_mb, .-filter_mb
	.align	2
	.set	nomips16
	.ent	filter_mb_fast
	.type	filter_mb_fast, @function
filter_mb_fast:
	.frame	$sp,200,$31		# vars= 112, regs= 10/0, args= 40, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-200
	sw	$21,180($sp)
	sw	$20,176($sp)
	sw	$19,172($sp)
	sw	$18,168($sp)
	sw	$17,164($sp)
	sw	$16,160($sp)
	sw	$31,196($sp)
	sw	$fp,192($sp)
	sw	$23,188($sp)
	sw	$22,184($sp)
	move	$16,$4
	move	$19,$7
	lw	$20,216($sp)
	lw	$21,220($sp)
	lw	$18,224($sp)
	lw	$17,228($sp)
	beq	$5,$0,$L2303
	lw	$2,152($4)

	beq	$6,$0,$L2303
	nop

	lw	$25,4980($4)
	beq	$25,$0,$L2303
	nop

	lw	$3,12608($4)
	bne	$3,$0,$L2303
	li	$3,65536			# 0x10000

	addu	$3,$4,$3
	mul	$4,$6,$2
	lw	$7,5340($3)
	addu	$2,$4,$5
	li	$4,2			# 0x2
	beq	$7,$4,$L2339
	addiu	$10,$2,-1

	lw	$7,8764($16)
	lw	$3,1548($16)
$L2355:
	addu	$5,$3,$2
	addu	$4,$3,$7
	addu	$3,$3,$10
	lb	$23,0($5)
	lb	$3,0($3)
	lb	$5,0($4)
	andi	$8,$3,0xff
	andi	$6,$5,0xff
	andi	$9,$23,0xff
	addu	$9,$16,$9
	addu	$8,$16,$8
	addu	$6,$16,$6
	li	$4,65536			# 0x10000
	lbu	$fp,12096($9)
	lbu	$11,12096($8)
	lbu	$9,12096($6)
	addu	$4,$16,$4
	lw	$6,5344($4)
	li	$8,15			# 0xf
	lw	$4,1568($16)
	addu	$11,$fp,$11
	addu	$9,$fp,$9
	addu	$5,$23,$5
	subu	$6,$8,$6
	sll	$2,$2,2
	addu	$3,$23,$3
	addiu	$5,$5,1
	addiu	$11,$11,1
	addiu	$9,$9,1
	addu	$2,$4,$2
	addiu	$3,$3,1
	sra	$5,$5,1
	sra	$11,$11,1
	sra	$9,$9,1
	slt	$8,$6,$23
	lw	$2,0($2)
	sra	$3,$3,1
	sw	$5,132($sp)
	sw	$11,124($sp)
	bne	$8,$0,$L2307
	sw	$9,128($sp)

	slt	$5,$6,$3
	bne	$5,$0,$L2357
	andi	$5,$2,0x7

	lw	$8,132($sp)
	slt	$5,$6,$8
	bne	$5,$0,$L2357
	andi	$5,$2,0x7

	slt	$5,$6,$fp
	bne	$5,$0,$L2357
	andi	$5,$2,0x7

	slt	$5,$6,$11
	bne	$5,$0,$L2357
	andi	$5,$2,0x7

	slt	$6,$6,$9
	beq	$6,$0,$L2356
	lw	$31,196($sp)

$L2307:
	andi	$5,$2,0x7
$L2357:
	beq	$5,$0,$L2308
	li	$8,16777216			# 0x1000000

	lui	$5,%hi(C.679.19516)
	lui	$4,%hi(C.680.19517)
	addiu	$7,$5,%lo(C.679.19516)
	addiu	$6,$4,%lo(C.680.19517)
	lw	$7,4($7)
	lw	$6,4($6)
	lw	$5,%lo(C.679.19516)($5)
	lw	$4,%lo(C.680.19517)($4)
	and	$2,$2,$8
	sw	$5,48($sp)
	sw	$7,52($sp)
	sw	$4,56($sp)
	bne	$2,$0,$L2340
	sw	$6,60($sp)

	addiu	$4,$sp,48
	sw	$4,120($sp)
	lw	$7,120($sp)
	addiu	$22,$sp,56
	move	$4,$16
	move	$5,$19
	move	$6,$18
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$3,16($sp)

	move	$4,$16
	addiu	$5,$19,4
	move	$6,$18
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$23,16($sp)

	move	$4,$16
	addiu	$5,$19,8
	move	$6,$18
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$23,16($sp)

	move	$4,$16
	addiu	$5,$19,12
	move	$6,$18
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$23,16($sp)

	lw	$2,132($sp)
	lw	$7,120($sp)
	sll	$8,$18,2
	move	$4,$16
	move	$5,$19
	move	$6,$18
	sw	$8,136($sp)
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$2,16($sp)

	lw	$3,136($sp)
	move	$4,$16
	addu	$5,$19,$3
	move	$6,$18
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$23,16($sp)

	sll	$5,$18,3
	addu	$5,$19,$5
	move	$4,$16
	move	$6,$18
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$23,16($sp)

	lw	$4,136($sp)
	sll	$5,$18,4
	subu	$5,$5,$4
$L2337:
	move	$6,$18
	addu	$5,$19,$5
	move	$4,$16
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$23,16($sp)

	lw	$8,124($sp)
	lw	$7,120($sp)
	move	$4,$16
	move	$5,$20
	move	$6,$17
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$8,16($sp)

	move	$4,$16
	addiu	$5,$20,4
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$fp,16($sp)

	lw	$2,124($sp)
	lw	$7,120($sp)
	move	$4,$16
	move	$5,$21
	move	$6,$17
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$2,16($sp)

	move	$4,$16
	addiu	$5,$21,4
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$fp,16($sp)

	lw	$3,128($sp)
	lw	$7,120($sp)
	move	$4,$16
	move	$5,$20
	move	$6,$17
	sll	$18,$17,2
	.option	pic0
	jal	filter_mb_edgech
	.option	pic2
	sw	$3,16($sp)

	addu	$5,$20,$18
	move	$4,$16
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgech
	.option	pic2
	sw	$fp,16($sp)

	lw	$8,128($sp)
	lw	$7,120($sp)
	move	$4,$16
	move	$5,$21
	move	$6,$17
	b	$L2338
	sw	$8,16($sp)

$L2339:
	lw	$3,-6288($3)
	lw	$7,8764($16)
	addu	$8,$3,$2
	addu	$4,$3,$7
	lbu	$8,0($8)
	lbu	$4,0($4)
	beq	$4,$8,$L2341
	addu	$3,$3,$10

$L2303:
	move	$4,$16
$L2360:
	move	$7,$19
	sw	$20,16($sp)
	sw	$21,20($sp)
	sw	$18,24($sp)
	.option	pic0
	jal	filter_mb
	.option	pic2
	sw	$17,28($sp)

$L2336:
	lw	$31,196($sp)
$L2356:
	lw	$fp,192($sp)
	lw	$23,188($sp)
	lw	$22,184($sp)
	lw	$21,180($sp)
	lw	$20,176($sp)
	lw	$19,172($sp)
	lw	$18,168($sp)
	lw	$17,164($sp)
	lw	$16,160($sp)
	j	$31
	addiu	$sp,$sp,200

$L2308:
	and	$8,$2,$8
	beq	$8,$0,$L2311
	addiu	$22,$sp,56

	li	$5,131072			# 0x20000
	addu	$5,$16,$5
	lw	$6,8664($5)
	li	$5,7			# 0x7
	andi	$6,$6,0x7
	bne	$6,$5,$L2358
	andi	$5,$2,0x28

	li	$12,131072			# 0x20000
	li	$13,131072			# 0x20000
	ori	$12,$12,0x2
	ori	$13,$13,0x2
	addiu	$2,$sp,88
	sw	$12,16($2)
	sw	$13,20($2)
	sll	$10,$10,2
	sw	$12,88($sp)
	sw	$13,92($sp)
	li	$9,4			# 0x4
	sw	$12,0($22)
	sw	$13,4($22)
	sw	$12,16($22)
	sw	$13,20($22)
$L2312:
	addu	$10,$4,$10
	lw	$5,0($10)
	andi	$5,$5,0x7
	beq	$5,$0,$L2318
	li	$10,262144			# 0x40000

	li	$11,262144			# 0x40000
	ori	$10,$10,0x4
	ori	$11,$11,0x4
	sw	$10,0($22)
	sw	$11,4($22)
$L2318:
	sll	$7,$7,2
	addu	$4,$4,$7
	lw	$4,0($4)
	andi	$4,$4,0x7
	beq	$4,$0,$L2359
	li	$4,1			# 0x1

	li	$4,262144			# 0x40000
	li	$5,262144			# 0x40000
	ori	$4,$4,0x4
	ori	$5,$5,0x4
	sw	$4,0($2)
	sw	$5,4($2)
	li	$4,1			# 0x1
$L2359:
	beq	$9,$4,$L2342
	nop

	beq	$8,$0,$L2322
	nop

	lw	$4,0($22)
	lw	$5,4($22)
	or	$4,$4,$5
	bne	$4,$0,$L2343
	move	$4,$16

$L2323:
	lw	$4,20($22)
	lw	$3,16($22)
	or	$3,$3,$4
	bne	$3,$0,$L2344
	addiu	$22,$sp,72

$L2324:
	lw	$3,0($2)
	lw	$4,4($2)
	or	$3,$3,$4
	bne	$3,$0,$L2345
	lw	$3,132($sp)

$L2325:
	lw	$3,20($2)
	lw	$2,16($2)
	or	$2,$2,$3
	beq	$2,$0,$L2356
	lw	$31,196($sp)

	addiu	$22,$sp,104
	sll	$5,$18,3
	move	$6,$18
	addu	$5,$19,$5
	move	$4,$16
	move	$7,$22
	sll	$18,$17,2
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$23,16($sp)

	addu	$5,$20,$18
	move	$4,$16
	move	$6,$17
	move	$7,$22
	sw	$fp,16($sp)
$L2338:
	.option	pic0
	jal	filter_mb_edgech
	nop

	.option	pic2
	addu	$5,$21,$18
	move	$4,$16
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgech
	.option	pic2
	sw	$fp,16($sp)

	lw	$31,196($sp)
	lw	$fp,192($sp)
	lw	$23,188($sp)
	lw	$22,184($sp)
	lw	$21,180($sp)
	lw	$20,176($sp)
	lw	$19,172($sp)
	lw	$18,168($sp)
	lw	$17,164($sp)
	lw	$16,160($sp)
	j	$31
	addiu	$sp,$sp,200

$L2311:
	andi	$5,$2,0x28
$L2358:
	beq	$5,$0,$L2346
	srl	$6,$2,4

	sll	$10,$10,2
	addu	$4,$4,$10
	lw	$4,0($4)
	andi	$4,$4,0x28
	beq	$4,$0,$L2333
	li	$6,3			# 0x3

	li	$5,3			# 0x3
$L2334:
	li	$4,1			# 0x1
	li	$7,2			# 0x2
	andi	$2,$2,0x8
	beq	$2,$0,$L2316
	movn	$4,$7,$8

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lw	$2,8664($2)
	andi	$2,$2,0xf
	bne	$2,$0,$L2316
	nop

	li	$9,1			# 0x1
$L2317:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,-6284($2)
	addiu	$7,$16,9136
	xori	$2,$2,0x3
	sltu	$2,$2,1
	sw	$4,24($sp)
	sw	$2,16($sp)
	sw	$5,28($sp)
	sw	$6,32($sp)
	sw	$9,20($sp)
	move	$4,$22
	sw	$3,152($sp)
	sw	$8,140($sp)
	sw	$9,144($sp)
	sw	$10,148($sp)
	addiu	$5,$16,9080
	jalr	$25
	addiu	$6,$16,9456

	lw	$7,8764($16)
	lw	$4,1568($16)
	addiu	$2,$sp,88
	lw	$10,148($sp)
	lw	$9,144($sp)
	lw	$8,140($sp)
	b	$L2312
	lw	$3,152($sp)

$L2340:
	addiu	$2,$sp,48
	move	$7,$2
	move	$4,$16
	move	$5,$19
	move	$6,$18
	addiu	$22,$sp,56
	sw	$2,120($sp)
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$3,16($sp)

	move	$4,$16
	addiu	$5,$19,8
	move	$6,$18
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$23,16($sp)

	lw	$3,132($sp)
	lw	$7,120($sp)
	move	$5,$19
	move	$4,$16
	move	$6,$18
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$3,16($sp)

	b	$L2337
	sll	$5,$18,3

$L2346:
	andi	$6,$6,0x1
	sll	$10,$10,2
	b	$L2334
	move	$5,$0

$L2341:
	lbu	$3,0($3)
	bne	$3,$4,$L2360
	move	$4,$16

	b	$L2355
	lw	$3,1548($16)

$L2316:
	b	$L2317
	li	$9,4			# 0x4

$L2322:
	lw	$4,0($22)
	lw	$5,4($22)
	or	$4,$4,$5
	bne	$4,$0,$L2347
	move	$4,$16

$L2326:
	lw	$3,8($22)
	lw	$4,12($22)
	or	$3,$3,$4
	bne	$3,$0,$L2348
	move	$4,$16

$L2327:
	lw	$3,16($22)
	lw	$4,20($22)
	or	$3,$3,$4
	bne	$3,$0,$L2349
	addiu	$3,$sp,72

$L2328:
	lw	$4,28($22)
	lw	$3,24($22)
	or	$3,$3,$4
	bne	$3,$0,$L2350
	move	$4,$16

$L2329:
	lw	$3,0($2)
	lw	$4,4($2)
	or	$3,$3,$4
	bne	$3,$0,$L2351
	lw	$8,132($sp)

$L2330:
	lw	$3,8($2)
	lw	$4,12($2)
	or	$3,$3,$4
	bne	$3,$0,$L2352
	sll	$5,$18,2

$L2331:
	lw	$3,16($2)
	lw	$4,20($2)
	or	$3,$3,$4
	bne	$3,$0,$L2353
	addiu	$22,$sp,104

$L2332:
	lw	$3,28($2)
	lw	$2,24($2)
	or	$2,$2,$3
	beq	$2,$0,$L2336
	sll	$2,$18,2

	sll	$5,$18,4
	subu	$5,$5,$2
	addu	$5,$19,$5
	move	$4,$16
	move	$6,$18
	addiu	$7,$sp,112
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$23,16($sp)

	b	$L2356
	lw	$31,196($sp)

$L2342:
	lw	$4,0($22)
	lw	$5,4($22)
	or	$4,$4,$5
	bne	$4,$0,$L2354
	move	$4,$16

$L2321:
	lw	$3,4($2)
	lw	$2,0($2)
	or	$2,$2,$3
	beq	$2,$0,$L2336
	lw	$2,132($sp)

	addiu	$22,$sp,88
	move	$5,$19
	move	$6,$18
	move	$4,$16
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$2,16($sp)

	lw	$3,128($sp)
	move	$5,$20
	move	$4,$16
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgech
	.option	pic2
	sw	$3,16($sp)

	lw	$8,128($sp)
	move	$4,$16
	move	$5,$21
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgech
	.option	pic2
	sw	$8,16($sp)

	b	$L2356
	lw	$31,196($sp)

$L2333:
	b	$L2334
	move	$5,$0

$L2353:
	sll	$5,$18,3
	sll	$3,$17,2
	addu	$5,$19,$5
	move	$4,$16
	move	$6,$18
	move	$7,$22
	sw	$2,140($sp)
	sw	$3,120($sp)
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$23,16($sp)

	lw	$4,120($sp)
	move	$6,$17
	addu	$5,$20,$4
	move	$7,$22
	move	$4,$16
	.option	pic0
	jal	filter_mb_edgech
	.option	pic2
	sw	$fp,16($sp)

	lw	$8,120($sp)
	move	$6,$17
	addu	$5,$21,$8
	move	$7,$22
	move	$4,$16
	.option	pic0
	jal	filter_mb_edgech
	.option	pic2
	sw	$fp,16($sp)

	b	$L2332
	lw	$2,140($sp)

$L2352:
	addu	$5,$19,$5
	move	$4,$16
	move	$6,$18
	addiu	$7,$sp,96
	sw	$2,140($sp)
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$23,16($sp)

	b	$L2331
	lw	$2,140($sp)

$L2351:
	addiu	$22,$sp,88
	move	$4,$16
	move	$5,$19
	move	$6,$18
	move	$7,$22
	sw	$2,140($sp)
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$8,16($sp)

	lw	$3,128($sp)
	move	$4,$16
	move	$5,$20
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgech
	.option	pic2
	sw	$3,16($sp)

	lw	$8,128($sp)
	move	$7,$22
	move	$4,$16
	move	$5,$21
	move	$6,$17
	.option	pic0
	jal	filter_mb_edgech
	.option	pic2
	sw	$8,16($sp)

	b	$L2330
	lw	$2,140($sp)

$L2350:
	addiu	$5,$19,12
	move	$6,$18
	addiu	$7,$sp,80
	sw	$2,140($sp)
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$23,16($sp)

	b	$L2329
	lw	$2,140($sp)

$L2349:
	move	$7,$3
	move	$4,$16
	addiu	$5,$19,8
	move	$6,$18
	sw	$2,140($sp)
	sw	$3,152($sp)
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$23,16($sp)

	lw	$3,152($sp)
	move	$4,$16
	move	$7,$3
	addiu	$5,$20,4
	move	$6,$17
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$fp,16($sp)

	lw	$3,152($sp)
	move	$4,$16
	move	$7,$3
	addiu	$5,$21,4
	move	$6,$17
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$fp,16($sp)

	b	$L2328
	lw	$2,140($sp)

$L2348:
	addiu	$5,$19,4
	move	$6,$18
	addiu	$7,$sp,64
	sw	$2,140($sp)
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$23,16($sp)

	b	$L2327
	lw	$2,140($sp)

$L2347:
	move	$5,$19
	move	$6,$18
	move	$7,$22
	sw	$2,140($sp)
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$3,16($sp)

	lw	$8,124($sp)
	move	$4,$16
	move	$5,$20
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$8,16($sp)

	lw	$3,124($sp)
	move	$4,$16
	move	$5,$21
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$3,16($sp)

	b	$L2326
	lw	$2,140($sp)

$L2344:
	move	$4,$16
	addiu	$5,$19,8
	move	$6,$18
	move	$7,$22
	sw	$2,140($sp)
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$23,16($sp)

	move	$4,$16
	addiu	$5,$20,4
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$fp,16($sp)

	move	$7,$22
	move	$4,$16
	addiu	$5,$21,4
	move	$6,$17
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$fp,16($sp)

	b	$L2324
	lw	$2,140($sp)

$L2343:
	move	$5,$19
	move	$6,$18
	move	$7,$22
	sw	$2,140($sp)
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$3,16($sp)

	lw	$3,124($sp)
	move	$4,$16
	move	$5,$20
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$3,16($sp)

	lw	$8,124($sp)
	move	$4,$16
	move	$5,$21
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$8,16($sp)

	b	$L2323
	lw	$2,140($sp)

$L2345:
	addiu	$22,$sp,88
	move	$4,$16
	move	$5,$19
	move	$6,$18
	move	$7,$22
	sw	$2,140($sp)
	.option	pic0
	jal	filter_mb_edgeh
	.option	pic2
	sw	$3,16($sp)

	lw	$8,128($sp)
	move	$4,$16
	move	$5,$20
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgech
	.option	pic2
	sw	$8,16($sp)

	lw	$3,128($sp)
	move	$7,$22
	move	$4,$16
	move	$5,$21
	move	$6,$17
	.option	pic0
	jal	filter_mb_edgech
	.option	pic2
	sw	$3,16($sp)

	b	$L2325
	lw	$2,140($sp)

$L2354:
	move	$5,$19
	move	$6,$18
	move	$7,$22
	sw	$2,140($sp)
	.option	pic0
	jal	filter_mb_edgev
	.option	pic2
	sw	$3,16($sp)

	lw	$3,124($sp)
	move	$4,$16
	move	$5,$20
	move	$6,$17
	move	$7,$22
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$3,16($sp)

	lw	$8,124($sp)
	move	$7,$22
	move	$4,$16
	move	$5,$21
	move	$6,$17
	.option	pic0
	jal	filter_mb_edgecv
	.option	pic2
	sw	$8,16($sp)

	b	$L2321
	lw	$2,140($sp)

	.set	macro
	.set	reorder
	.end	filter_mb_fast
	.size	filter_mb_fast, .-filter_mb_fast
	.section	.rodata.str1.4
	.align	2
$LC23:
	.ascii	"luma prediction:%d\012\000"
	.align	2
$LC24:
	.ascii	"weird prediction\012\000"
	.align	2
$LC25:
	.ascii	"top block unavailable for requested intra4x4 mode %d at "
	.ascii	"%d %d\012\000"
	.align	2
$LC26:
	.ascii	"left block unavailable for requested intra4x4 mode %d at"
	.ascii	" %d %d\012\000"
	.align	2
$LC27:
	.ascii	"check_intra_pred_mode = -1\012\000"
	.align	2
$LC28:
	.ascii	"cbp_vlc=%d\012\000"
	.align	2
$LC29:
	.ascii	"qscale:%d\012\000"
	.align	2
$LC30:
	.ascii	"error while decoding intra luma dc\012\000"
	.align	2
$LC31:
	.ascii	"error while decoding block\012\000"
	.align	2
$LC32:
	.ascii	"error while decoding chroma dc block\012\000"
	.align	2
$LC33:
	.ascii	"error while decoding chroma ac block\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	svq3_decode_mb
	.type	svq3_decode_mb, @function
svq3_decode_mb:
	.frame	$sp,144,$31		# vars= 56, regs= 10/0, args= 40, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-144
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,140($sp)
	sw	$fp,136($sp)
	sw	$23,132($sp)
	sw	$22,128($sp)
	sw	$21,124($sp)
	sw	$20,120($sp)
	sw	$19,116($sp)
	sw	$18,112($sp)
	sw	$17,108($sp)
	sw	$16,104($sp)
	.cprestore	40
	lw	$19,6172($4)
	lw	$18,9748($4)
	lw	$7,6168($4)
	mul	$3,$19,$18
	li	$2,65535			# 0xffff
	addu	$18,$3,$7
	li	$6,13311			# 0x33ff
	lw	$3,152($4)
	movn	$6,$2,$19
	sw	$6,8984($4)
	mul	$6,$19,$3
	move	$8,$2
	li	$20,24415			# 0x5f5f
	move	$17,$5
	sw	$2,8988($4)
	li	$5,32768			# 0x8000
	addu	$2,$6,$7
	movz	$8,$20,$7
	sw	$2,56($sp)
	move	$2,$5
	move	$16,$4
	sw	$8,8992($4)
	sll	$18,$18,2
	movz	$2,$0,$7
	bne	$17,$0,$L2366
	movz	$5,$0,$19

	lw	$3,2084($4)
	li	$2,2			# 0x2
	beq	$3,$2,$L2367
	lw	$8,56($sp)

	lw	$3,752($4)
	sll	$2,$8,2
	addu	$2,$3,$2
	lw	$2,0($2)
	li	$3,-1			# 0xffffffffffffffff
	bne	$2,$3,$L2368
	sltu	$3,$2,7

$L2367:
	sll	$17,$7,4
	sll	$19,$19,4
	bltz	$17,$L2642
	addiu	$fp,$16,240

	lw	$6,164($16)
	addiu	$2,$6,-17
	slt	$2,$17,$2
	beq	$2,$0,$L2640
	nop

	bltz	$19,$L2640
	nop

	lw	$3,168($16)
	addiu	$2,$3,-17
	slt	$2,$19,$2
	beq	$2,$0,$L2373
	move	$22,$17

	lw	$21,176($16)
	lw	$5,240($16)
	mul	$2,$19,$21
	addu	$3,$2,$17
	addu	$5,$5,$3
	lw	$2,1464($16)
	move	$20,$19
	move	$3,$21
	b	$L2375
	move	$23,$0

$L2366:
	sltu	$3,$17,8
	bne	$3,$0,$L2643
	li	$3,8			# 0x8

	beq	$17,$3,$L2441
	li	$3,33			# 0x21

	beq	$17,$3,$L2644
	lw	$25,%call16(memset)($28)

	addiu	$17,$17,-8
	lui	$4,%hi(i_mb_type_info)
	sll	$17,$17,2
	addiu	$4,$4,%lo(i_mb_type_info)
	addu	$3,$4,$17
	lbu	$3,2($3)
	andi	$6,$3,0x1
	sll	$8,$6,1
	sra	$3,$3,1
	addu	$6,$8,$6
	xori	$3,$3,0x1
	xor	$3,$3,$6
	sltu	$6,$3,7
	beq	$6,$0,$L2645
	lw	$25,%call16(av_log)($28)

	bne	$5,$0,$L2475
	lui	$5,%hi(top.10339)

	addiu	$5,$5,%lo(top.10339)
	addu	$3,$3,$5
	lb	$3,0($3)
	bltz	$3,$L2646
	lui	$6,%hi($LC1)

$L2475:
	bne	$2,$0,$L2476
	nop

	lui	$2,%hi(left.10340)
	addiu	$2,$2,%lo(left.10340)
	addu	$3,$3,$2
	lb	$3,0($3)
	bltz	$3,$L2647
	lui	$6,%hi($LC2)

$L2476:
	addu	$4,$4,$17
	li	$19,2			# 0x2
	lbu	$17,3($4)
	lw	$2,2084($16)
	sw	$3,8760($16)
	move	$20,$0
	move	$21,$0
	b	$L2384
	sw	$19,60($sp)

$L2643:
	lw	$4,9776($4)
	beq	$4,$0,$L2648
	nop

	lw	$3,8456($16)
	lw	$5,8448($16)
	sra	$2,$3,3
	addu	$2,$5,$2
	lbu	$5,0($2)
	andi	$2,$3,0x7
	sll	$5,$5,$2
	andi	$5,$5,0x00ff
	srl	$5,$5,7
	lw	$2,9772($16)
	addiu	$3,$3,1
	sltu	$5,$5,1
	bne	$2,$5,$L2403
	sw	$3,8456($16)

	li	$19,3			# 0x3
$L2404:
	lw	$2,56($sp)
$L2711:
	addiu	$21,$18,-1
	addiu	$fp,$2,-1
	sll	$fp,$fp,3
	addiu	$20,$16,9136
	sll	$23,$21,2
	blez	$7,$L2408
	addiu	$22,$16,9456

	lw	$2,8816($16)
	addu	$2,$2,$fp
	lb	$3,0($2)
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L2408
	nop

	lw	$2,1560($16)
	addu	$3,$2,$23
	lw	$3,0($3)
	sw	$3,44($20)
	lw	$3,9748($16)
	addu	$3,$21,$3
	sll	$3,$3,2
	addu	$3,$2,$3
	lw	$3,0($3)
	sw	$3,76($20)
	lw	$3,9748($16)
	sll	$3,$3,1
	addu	$3,$3,$21
	sll	$3,$3,2
	addu	$3,$2,$3
	lw	$3,0($3)
	sw	$3,108($20)
	lw	$3,9748($16)
	sll	$4,$3,1
	addu	$3,$4,$3
	addu	$3,$3,$21
	sll	$3,$3,2
	addu	$2,$2,$3
	lw	$2,0($2)
	sw	$2,140($20)
$L2407:
	lw	$2,6172($16)
	blez	$2,$L2649
	lw	$25,%call16(memset)($28)

	lw	$2,9748($16)
	lw	$3,1560($16)
	subu	$2,$18,$2
	sll	$2,$2,2
	addu	$3,$3,$2
	lwl	$7,3($3)
	lwl	$6,7($3)
	lwr	$7,0($3)
	lwl	$5,11($3)
	lwl	$4,15($3)
	addiu	$2,$20,16
	lwr	$4,12($3)
	lwr	$6,4($3)
	lwr	$5,8($3)
	swl	$7,3($2)
	swr	$7,0($2)
	swl	$6,7($2)
	swr	$6,4($2)
	swl	$5,11($2)
	swr	$5,8($2)
	swl	$4,15($2)
	swr	$4,12($2)
	lw	$4,56($sp)
	lw	$2,152($16)
	lw	$3,8816($16)
	subu	$2,$4,$2
	sll	$2,$2,3
	addu	$2,$3,$2
	lb	$3,4($2)
	li	$4,-2			# 0xfffffffffffffffe
	nor	$3,$0,$3
	li	$2,1			# 0x1
	movz	$2,$4,$3
	addiu	$3,$22,4
	sb	$2,4($22)
	sb	$2,3($3)
	sb	$2,1($3)
	sb	$2,2($3)
	lw	$2,144($16)
	lw	$7,6168($16)
	addiu	$2,$2,-1
	slt	$2,$7,$2
	beq	$2,$0,$L2650
	lw	$6,56($sp)

	lw	$2,9748($16)
	lw	$3,1560($16)
	subu	$2,$18,$2
	addiu	$2,$2,4
	sll	$2,$2,2
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,32($20)
	lw	$4,152($16)
	lw	$3,8816($16)
	subu	$4,$6,$4
	addiu	$5,$4,1
	sll	$5,$5,3
	addu	$5,$3,$5
	lb	$5,0($5)
	li	$2,-1			# 0xffffffffffffffff
	beq	$5,$2,$L2419
	sll	$4,$4,3

	addu	$3,$3,$4
	lb	$3,4($3)
	beq	$3,$2,$L2419
	li	$2,1			# 0x1

	lw	$7,6168($16)
	sb	$2,9464($16)
$L2417:
	blez	$7,$L2651
	lw	$5,56($sp)

	lw	$2,9748($16)
	lw	$3,1560($16)
	subu	$2,$18,$2
	addiu	$2,$2,-1
	sll	$2,$2,2
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,12($20)
	lw	$2,152($16)
	lw	$3,8816($16)
	subu	$2,$5,$2
	addiu	$2,$2,-1
	sll	$2,$2,3
	addu	$2,$3,$2
	lb	$4,3($2)
	li	$3,-2			# 0xfffffffffffffffe
	li	$2,1			# 0x1
	nor	$4,$0,$4
	movz	$2,$3,$4
	sb	$2,9459($16)
$L2410:
	lw	$2,2084($16)
	li	$3,3			# 0x3
	bne	$2,$3,$L2701
	li	$3,2			# 0x2

	lw	$2,6168($16)
	blez	$2,$L2423
	nop

	lw	$2,8816($16)
	addu	$fp,$2,$fp
	lb	$3,0($fp)
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L2423
	nop

	lw	$2,1564($16)
	addu	$23,$2,$23
	lw	$3,0($23)
	sw	$3,204($20)
	lw	$3,9748($16)
	addu	$3,$21,$3
	sll	$3,$3,2
	addu	$3,$2,$3
	lw	$3,0($3)
	sw	$3,236($20)
	lw	$3,9748($16)
	sll	$3,$3,1
	addu	$3,$3,$21
	sll	$3,$3,2
	addu	$3,$2,$3
	lw	$3,0($3)
	sw	$3,268($20)
	lw	$3,9748($16)
	sll	$4,$3,1
	addu	$3,$4,$3
	addu	$21,$3,$21
	sll	$21,$21,2
	addu	$2,$2,$21
	lw	$2,0($2)
	sw	$2,300($20)
$L2424:
	lw	$2,6172($16)
	blez	$2,$L2425
	lw	$25,%call16(memset)($28)

	lw	$2,9748($16)
	lw	$3,1564($16)
	subu	$2,$18,$2
	sll	$2,$2,2
	addu	$3,$3,$2
	lwl	$7,3($3)
	lwl	$6,7($3)
	lwr	$7,0($3)
	lwl	$5,11($3)
	lwl	$4,15($3)
	addiu	$2,$20,176
	lwr	$4,12($3)
	lwr	$6,4($3)
	lwr	$5,8($3)
	swl	$7,3($2)
	swr	$7,0($2)
	swl	$6,7($2)
	swr	$6,4($2)
	swl	$5,11($2)
	swr	$5,8($2)
	swl	$4,15($2)
	swr	$4,12($2)
	lw	$7,56($sp)
	lw	$2,152($16)
	lw	$3,8816($16)
	subu	$2,$7,$2
	sll	$2,$2,3
	addu	$2,$3,$2
	lb	$3,4($2)
	li	$4,-2			# 0xfffffffffffffffe
	nor	$3,$0,$3
	li	$2,1			# 0x1
	movz	$2,$4,$3
	addiu	$3,$22,44
	sb	$2,44($22)
	sb	$2,3($3)
	sb	$2,1($3)
	sb	$2,2($3)
	lw	$2,144($16)
	lw	$7,6168($16)
	addiu	$2,$2,-1
	slt	$2,$7,$2
	beq	$2,$0,$L2428
	lw	$8,56($sp)

	lw	$2,9748($16)
	lw	$3,1564($16)
	subu	$2,$18,$2
	addiu	$2,$2,4
	sll	$2,$2,2
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,192($20)
	lw	$4,152($16)
	lw	$3,8816($16)
	subu	$4,$8,$4
	addiu	$5,$4,1
	sll	$5,$5,3
	addu	$5,$3,$5
	lb	$5,0($5)
	li	$2,-1			# 0xffffffffffffffff
	beq	$5,$2,$L2429
	sll	$4,$4,3

	addu	$3,$3,$4
	lb	$3,4($3)
	beq	$3,$2,$L2429
	li	$2,1			# 0x1

	lw	$7,6168($16)
	sb	$2,9504($16)
$L2431:
	blez	$7,$L2432
	lw	$4,56($sp)

	lw	$2,9748($16)
	lw	$3,1564($16)
	subu	$2,$18,$2
	addiu	$2,$2,-1
	sll	$2,$2,2
	addu	$2,$3,$2
	lw	$2,0($2)
	sw	$2,172($20)
	lw	$2,152($16)
	lw	$3,8816($16)
	subu	$2,$4,$2
	addiu	$2,$2,-1
	sll	$2,$2,3
	addu	$2,$3,$2
	lb	$4,3($2)
	li	$3,-2			# 0xfffffffffffffffe
	li	$2,1			# 0x1
	nor	$4,$0,$4
	movz	$2,$3,$4
	sb	$2,9499($16)
$L2435:
	lw	$2,2084($16)
	li	$3,3			# 0x3
	bne	$2,$3,$L2422
	li	$3,2			# 0x2

	li	$2,2			# 0x2
$L2709:
	bne	$17,$2,$L2652
	lw	$25,%call16(memset)($28)

	lw	$4,1560($16)
	sll	$2,$18,2
	addu	$4,$4,$2
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	lw	$4,1560($16)
	addu	$2,$18,$2
	lw	$25,%call16(memset)($28)
	sll	$2,$2,2
	addu	$4,$4,$2
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	sll	$2,$2,1
	lw	$4,1560($16)
	addu	$2,$18,$2
	lw	$25,%call16(memset)($28)
	sll	$2,$2,2
	addu	$4,$4,$2
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	sll	$3,$2,1
	addu	$2,$3,$2
	lw	$4,1560($16)
	addu	$18,$2,$18
	lw	$25,%call16(memset)($28)
	sll	$18,$18,2
	addu	$4,$4,$18
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

$L2439:
	xori	$17,$17,0x3
	sltu	$17,$17,1
	move	$6,$19
	move	$4,$16
	move	$5,$0
	li	$7,1			# 0x1
	.option	pic0
	jal	svq3_mc_dir
	.option	pic2
	sw	$17,16($sp)

	bgez	$2,$L2401
	lw	$28,40($sp)

	b	$L2456
	li	$2,-1			# 0xffffffffffffffff

$L2640:
	lw	$3,168($16)
$L2373:
	lw	$23,56($16)
	srl	$23,$23,14
	andi	$23,$23,0x1
$L2370:
	addiu	$2,$6,-1
	slt	$22,$17,$2
	movn	$2,$17,$22
	move	$22,$2
$L2371:
	slt	$4,$19,-16
	beq	$4,$0,$L2376
	addiu	$20,$3,-1

	li	$20,-16			# 0xfffffffffffffff0
$L2377:
	lw	$21,176($16)
	lw	$5,240($16)
	mul	$7,$20,$21
	addu	$4,$7,$2
	addu	$5,$5,$4
	bne	$23,$0,$L2379
	lw	$2,1464($16)

	move	$3,$21
$L2375:
	mul	$4,$19,$3
	lw	$25,2596($16)
	addu	$3,$4,$17
	addu	$4,$2,$3
	move	$6,$21
	jalr	$25
	li	$7,16			# 0x10

	lw	$2,56($16)
	andi	$2,$2,0x2000
	bne	$2,$0,$L2380
	lw	$28,40($sp)

	slt	$3,$22,$17
	slt	$2,$20,$19
	addu	$22,$3,$22
	addu	$20,$2,$20
	addiu	$5,$16,2612
	sra	$22,$22,1
	sra	$20,$20,1
	sra	$17,$17,1
	sra	$19,$19,1
	bne	$23,$0,$L2381
	sw	$5,48($sp)

	lw	$6,180($16)
	lw	$4,1468($16)
	mul	$7,$20,$6
	mul	$2,$19,$6
	lw	$5,244($16)
	addu	$3,$2,$17
	lw	$25,2612($16)
	addu	$2,$7,$22
	addu	$4,$4,$3
	addu	$5,$5,$2
	jalr	$25
	li	$7,8			# 0x8

	lw	$6,180($16)
	lw	$4,1472($16)
	mul	$2,$19,$6
	lw	$5,248($16)
	addu	$17,$2,$17
	mul	$2,$20,$6
	lw	$25,2612($16)
	addu	$20,$2,$22
	addu	$4,$4,$17
	addu	$5,$5,$20
	jalr	$25
	li	$7,8			# 0x8

	lw	$28,40($sp)
$L2380:
	lw	$2,2084($16)
	li	$3,3			# 0x3
	beq	$2,$3,$L2383
	nop

$L2639:
	li	$20,2048			# 0x800
	move	$19,$0
	move	$21,$0
	move	$17,$0
	sw	$20,60($sp)
$L2384:
	li	$3,1			# 0x1
	beq	$2,$3,$L2589
	lw	$25,%call16(memset)($28)

	lw	$4,1560($16)
	sll	$22,$18,2
	addu	$4,$4,$22
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	lw	$4,1560($16)
	addu	$2,$18,$2
	lw	$25,%call16(memset)($28)
	sll	$2,$2,2
	addu	$4,$4,$2
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	sll	$2,$2,1
	lw	$4,1560($16)
	addu	$2,$18,$2
	lw	$25,%call16(memset)($28)
	sll	$2,$2,2
	addu	$4,$4,$2
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	sll	$3,$2,1
	addu	$2,$3,$2
	lw	$4,1560($16)
	addu	$2,$2,$18
	lw	$25,%call16(memset)($28)
	sll	$2,$2,2
	addu	$4,$4,$2
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$3,2084($16)
	li	$2,3			# 0x3
	beq	$3,$2,$L2653
	lw	$28,40($sp)

$L2589:
	beq	$21,$0,$L2702
	lw	$8,56($sp)

	li	$18,1			# 0x1
$L2479:
	beq	$20,$0,$L2480
	li	$2,3			# 0x3

	lw	$3,2084($16)
	beq	$3,$2,$L2703
	li	$4,131072			# 0x20000

	beq	$19,$0,$L2654
	nop

$L2482:
	lw	$3,8456($16)
	lw	$8,8448($16)
	sra	$2,$3,3
	addu	$2,$8,$2
	lbu	$5,0($2)
	lbu	$6,3($2)
	lbu	$4,1($2)
	sll	$5,$5,24
	lbu	$2,2($2)
	or	$5,$6,$5
	sll	$4,$4,16
	sll	$2,$2,8
	or	$4,$5,$4
	or	$4,$4,$2
	andi	$2,$3,0x7
	sll	$2,$4,$2
	li	$4,-1434451968			# 0xffffffffaa800000
	and	$4,$2,$4
	beq	$4,$0,$L2498
	lw	$7,2056($16)

	lw	$5,%got(ff_interleaved_golomb_vlc_len)($28)
	srl	$2,$2,24
	addu	$5,$5,$2
	lbu	$4,0($5)
	addu	$3,$4,$3
	lw	$4,%got(ff_interleaved_se_golomb_vlc_code)($28)
	sw	$3,8456($16)
	addu	$2,$4,$2
	lb	$2,0($2)
$L2499:
	addu	$7,$2,$7
	slt	$2,$7,32
	beq	$2,$0,$L2655
	sw	$7,2056($16)

	beq	$19,$0,$L2496
	nop

	li	$25,131072			# 0x20000
	ori	$25,$25,0x1ad8
	lui	$20,%hi(svq3_dct_tables)
	lui	$24,%hi(luma_dc_zigzag_scan)
	lw	$5,%got(ff_interleaved_golomb_vlc_len)($28)
	lw	$21,%got(ff_interleaved_ue_golomb_vlc_code)($28)
	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	addu	$25,$16,$25
	addiu	$20,$20,%lo(svq3_dct_tables)
	addiu	$24,$24,%lo(luma_dc_zigzag_scan)
	addiu	$11,$16,8448
	move	$12,$0
	li	$15,-1434451968			# 0xffffffffaa800000
	li	$10,9			# 0x9
	li	$14,-2147483648			# 0xffffffff80000000
$L2504:
	lw	$3,8($11)
	sra	$2,$3,3
	addu	$2,$8,$2
	lbu	$6,0($2)
	lbu	$7,3($2)
	lbu	$4,1($2)
	sll	$6,$6,24
	lbu	$2,2($2)
	or	$6,$7,$6
	sll	$4,$4,16
	sll	$2,$2,8
	or	$4,$6,$4
	or	$4,$4,$2
	andi	$2,$3,0x7
	sll	$4,$4,$2
	and	$2,$4,$15
	bne	$2,$0,$L2511
	nop

	srl	$4,$4,24
	addu	$2,$5,$4
	lbu	$2,0($2)
	sltu	$6,$2,9
	beq	$6,$0,$L2656
	lw	$13,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

	li	$6,1			# 0x1
$L2518:
	addu	$3,$3,$2
$L2516:
	addiu	$2,$2,-1
$L2692:
	addu	$4,$13,$4
	sra	$7,$2,1
	lbu	$2,0($4)
	sll	$6,$6,$7
	or	$2,$2,$6
	addiu	$2,$2,-1
	beq	$2,$0,$L2496
	sw	$3,8($11)

$L2520:
	beq	$2,$14,$L2505
	addiu	$3,$2,1

	sra	$3,$3,1
	slt	$4,$3,16
	bne	$4,$0,$L2657
	andi	$4,$3,0xf

	bne	$4,$0,$L2508
	slt	$6,$4,3

	li	$6,4			# 0x4
$L2509:
	sra	$3,$3,4
	addu	$12,$4,$12
	addu	$6,$6,$3
	slt	$3,$12,16
	beq	$3,$0,$L2505
	addu	$3,$24,$12

$L2704:
	lbu	$3,0($3)
	andi	$2,$2,0x1
	addiu	$2,$2,-1
	sll	$3,$3,1
	xor	$4,$6,$2
	subu	$2,$4,$2
	addu	$3,$25,$3
	sh	$2,0($3)
	b	$L2504
	addiu	$12,$12,1

$L2480:
	li	$4,131072			# 0x20000
$L2703:
	addiu	$2,$16,9088
	lw	$25,2180($16)
	ori	$4,$4,0x1ad8
	sw	$0,9088($16)
	addu	$4,$16,$4
	sw	$0,32($2)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,12($2)
	sw	$0,16($2)
	sw	$0,20($2)
	sw	$0,24($2)
	jalr	$25
	sw	$0,28($2)

	bne	$19,$0,$L2482
	lw	$28,40($sp)

$L2654:
	beq	$20,$0,$L2483
	li	$3,3			# 0x3

	lw	$2,2084($16)
	beq	$2,$3,$L2483
	nop

$L2484:
	li	$3,1			# 0x1
	beq	$2,$3,$L2496
	nop

	lw	$2,2076($16)
	beq	$2,$0,$L2496
	nop

	bne	$17,$0,$L2482
	lw	$4,56($sp)

$L2696:
	lw	$5,60($sp)
	lw	$3,1568($16)
	sll	$2,$4,2
	addu	$3,$3,$2
	andi	$2,$5,0x7
	beq	$2,$0,$L2456
	sw	$5,0($3)

	lw	$4,8984($16)
	lw	$3,8992($16)
	andi	$4,$4,0x8000
	li	$2,4			# 0x4
	andi	$3,$3,0x8000
	bne	$3,$0,$L2587
	movn	$2,$0,$4

	lui	$3,%hi(left.10340)
	addiu	$3,$3,%lo(left.10340)
	addu	$2,$2,$3
	lb	$2,0($2)
	bltz	$2,$L2658
	lw	$25,%call16(av_log)($28)

$L2587:
	sw	$2,8756($16)
	move	$2,$0
$L2691:
	lw	$31,140($sp)
	lw	$fp,136($sp)
	lw	$23,132($sp)
	lw	$22,128($sp)
	lw	$21,124($sp)
	lw	$20,120($sp)
	lw	$19,116($sp)
	lw	$18,112($sp)
	lw	$17,108($sp)
	lw	$16,104($sp)
	j	$31
	addiu	$sp,$sp,144

$L2657:
	sll	$3,$3,1
	addu	$3,$3,$20
	lbu	$4,0($3)
	lbu	$6,1($3)
	addu	$12,$4,$12
	slt	$3,$12,16
	bne	$3,$0,$L2704
	addu	$3,$24,$12

$L2505:
	lui	$6,%hi($LC30)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L2636
	addiu	$6,$6,%lo($LC30)

$L2511:
	srl	$4,$4,24
	addu	$2,$5,$4
	lbu	$2,0($2)
	addu	$4,$21,$4
	addu	$3,$2,$3
	lbu	$2,0($4)
	bne	$2,$0,$L2520
	sw	$3,8($11)

$L2496:
	beq	$17,$0,$L2696
	lw	$4,56($sp)

	lw	$2,2056($16)
	sltu	$19,$0,$19
	slt	$2,$2,24
	beq	$2,$0,$L2521
	sw	$19,48($sp)

	bne	$18,$0,$L2660
	li	$4,8			# 0x8

$L2521:
	li	$7,1			# 0x1
	li	$6,16			# 0x10
	sw	$6,68($sp)
	move	$22,$0
	sw	$7,72($sp)
	move	$8,$7
$L2522:
	lui	$2,%hi(scan_patterns.21716)
	sll	$3,$8,2
	addiu	$2,$2,%lo(scan_patterns.21716)
	addu	$2,$3,$2
	sw	$2,88($sp)
	li	$2,131072			# 0x20000
	ori	$2,$2,0x1ad8
	addu	$2,$16,$2
	lui	$fp,%hi(svq3_dct_tables)
	lw	$10,%got(ff_interleaved_golomb_vlc_len)($28)
	lw	$11,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	lw	$21,%got(ff_interleaved_ue_golomb_vlc_code)($28)
	sw	$2,64($sp)
	addiu	$fp,$fp,%lo(svq3_dct_tables)
	addiu	$13,$16,8448
	move	$23,$0
	li	$12,9			# 0x9
	sw	$17,76($sp)
	lw	$3,76($sp)
$L2707:
	sra	$2,$3,$23
	andi	$2,$2,0x1
	beq	$2,$0,$L2523
	andi	$3,$23,0x2

	lw	$4,88($sp)
	sll	$3,$3,1
	andi	$2,$23,0x1
	addu	$2,$3,$2
	sll	$5,$23,2
	lw	$19,0($4)
	sw	$2,80($sp)
	sw	$0,52($sp)
	sw	$5,84($sp)
	li	$25,-1434451968			# 0xffffffffaa800000
	li	$17,-2147483648			# 0xffffffff80000000
	sll	$20,$22,4
	mtlo	$23
$L2592:
	lw	$6,48($sp)
	beq	$6,$0,$L2524
	lw	$2,84($sp)

	lw	$7,52($sp)
	lw	$8,80($sp)
	andi	$18,$7,0x2
	addu	$18,$18,$8
	sll	$18,$18,1
	andi	$2,$7,0x1
	addu	$18,$18,$2
$L2525:
	lui	$4,%hi(scan8)
	addiu	$4,$4,%lo(scan8)
	addu	$2,$4,$18
	lbu	$2,0($2)
	li	$3,1			# 0x1
	addu	$2,$16,$2
	sb	$3,9080($2)
	lw	$5,64($sp)
	sll	$18,$18,5
	lw	$9,0($13)
	lw	$24,68($sp)
	lw	$14,48($sp)
	addu	$18,$5,$18
	li	$23,-1			# 0xffffffffffffffff
$L2623:
	lw	$3,8($13)
	sra	$2,$3,3
	addu	$2,$9,$2
	lbu	$6,0($2)
	lbu	$7,3($2)
	lbu	$5,1($2)
	sll	$6,$6,24
	lbu	$2,2($2)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$4,$2,8
	or	$6,$6,$5
	or	$4,$6,$4
	andi	$8,$3,0x7
	sll	$4,$4,$8
	and	$2,$4,$25
	bne	$2,$0,$L2538
	nop

	srl	$4,$4,24
	addu	$2,$10,$4
	lbu	$2,0($2)
	sltu	$5,$2,9
	beq	$5,$0,$L2661
	lw	$15,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

	li	$5,1			# 0x1
$L2545:
	addu	$3,$3,$2
$L2543:
	addu	$4,$15,$4
$L2693:
	addiu	$2,$2,-1
	sra	$2,$2,1
	lbu	$4,0($4)
	sll	$5,$5,$2
	or	$5,$4,$5
	addiu	$5,$5,-1
	beq	$5,$0,$L2662
	sw	$3,8($13)

$L2547:
	beq	$5,$17,$L2527
	addiu	$2,$5,1

	sra	$2,$2,1
	slt	$3,$2,16
	beq	$3,$0,$L2528
	addu	$3,$20,$2

	sll	$3,$3,1
	addu	$3,$3,$fp
	lbu	$2,1($3)
	lbu	$3,0($3)
$L2529:
	addu	$14,$3,$14
	slt	$3,$14,$24
	beq	$3,$0,$L2705
	lui	$6,%hi($LC31)

	addu	$3,$19,$14
$L2706:
	lbu	$3,0($3)
	andi	$5,$5,0x1
	addiu	$5,$5,-1
	sll	$3,$3,1
	xor	$2,$2,$5
	subu	$2,$2,$5
	addu	$3,$18,$3
	sh	$2,0($3)
	b	$L2623
	addiu	$14,$14,1

$L2656:
	bne	$2,$10,$L2663
	addiu	$3,$3,8

	lw	$13,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	li	$6,1			# 0x1
$L2517:
	sra	$2,$3,3
	addu	$2,$8,$2
	lbu	$23,0($2)
	lbu	$22,1($2)
	lbu	$fp,3($2)
	lbu	$7,2($2)
	sll	$23,$23,24
	sll	$22,$22,16
	or	$2,$fp,$23
	or	$2,$2,$22
	sll	$7,$7,8
	or	$2,$2,$7
	andi	$7,$3,0x7
	sll	$2,$2,$7
	addu	$7,$9,$4
	srl	$4,$2,24
	addu	$2,$5,$4
	lbu	$2,0($2)
	lbu	$22,0($7)
	sll	$6,$6,4
	sltu	$7,$2,9
	bne	$7,$0,$L2518
	or	$6,$22,$6

	beq	$2,$10,$L2517
	addiu	$3,$3,8

	b	$L2692
	addiu	$2,$2,-1

$L2538:
	srl	$4,$4,24
	addu	$2,$10,$4
	lbu	$2,0($2)
	addu	$4,$21,$4
	lbu	$5,0($4)
	addu	$3,$2,$3
	bne	$5,$0,$L2547
	sw	$3,8($13)

$L2662:
	lw	$8,72($sp)
	li	$2,2			# 0x2
	bne	$8,$2,$L2548
	slt	$2,$24,16

	beq	$2,$0,$L2548
	move	$14,$24

	b	$L2623
	addiu	$24,$24,8

$L2528:
	beq	$22,$0,$L2530
	andi	$3,$2,0xf

	andi	$3,$2,0x7
	bne	$3,$0,$L2531
	li	$6,1			# 0x1

	li	$4,8			# 0x8
	sra	$2,$2,3
	addu	$2,$4,$2
$L2667:
	addu	$14,$3,$14
	slt	$3,$14,$24
	bne	$3,$0,$L2706
	addu	$3,$19,$14

$L2527:
	lui	$6,%hi($LC31)
$L2705:
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	addiu	$6,$6,%lo($LC31)
$L2636:
	jalr	$25
	move	$5,$0

	li	$2,-1			# 0xffffffffffffffff
$L2456:
	lw	$31,140($sp)
	lw	$fp,136($sp)
	lw	$23,132($sp)
	lw	$22,128($sp)
	lw	$21,124($sp)
	lw	$20,120($sp)
	lw	$19,116($sp)
	lw	$18,112($sp)
	lw	$17,108($sp)
	lw	$16,104($sp)
	j	$31
	addiu	$sp,$sp,144

$L2661:
	bne	$2,$12,$L2665
	addiu	$3,$3,8

	lw	$15,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	li	$5,1			# 0x1
$L2544:
	sra	$2,$3,3
	addu	$2,$9,$2
	lbu	$7,0($2)
	lbu	$8,3($2)
	lbu	$6,1($2)
	sll	$7,$7,24
	lbu	$2,2($2)
	or	$7,$8,$7
	sll	$6,$6,16
	or	$7,$7,$6
	sll	$6,$2,8
	or	$6,$7,$6
	andi	$8,$3,0x7
	sll	$6,$6,$8
	addu	$8,$11,$4
	srl	$4,$6,24
	addu	$2,$10,$4
	lbu	$2,0($2)
	lbu	$7,0($8)
	sll	$5,$5,4
	sltu	$6,$2,9
	bne	$6,$0,$L2545
	or	$5,$7,$5

	beq	$2,$12,$L2544
	addiu	$3,$3,8

	b	$L2693
	addu	$4,$15,$4

$L2530:
	bne	$3,$0,$L2535
	slt	$4,$3,3

	li	$4,4			# 0x4
	sra	$2,$2,4
	b	$L2529
	addu	$2,$4,$2

$L2535:
	beq	$4,$0,$L2537
	slt	$4,$3,10

	li	$4,2			# 0x2
	sra	$2,$2,4
	b	$L2529
	addu	$2,$4,$2

$L2531:
	beq	$3,$6,$L2666
	slt	$4,$3,5

	move	$7,$23
	movn	$7,$0,$4
	move	$4,$7
	sra	$2,$2,3
	b	$L2667
	addu	$2,$4,$2

$L2537:
	sra	$2,$2,4
	b	$L2529
	addu	$2,$4,$2

$L2548:
	lw	$6,52($sp)
	li	$7,4			# 0x4
	addiu	$6,$6,1
	bne	$6,$7,$L2592
	sw	$6,52($sp)

	mflo	$23
$L2523:
	addiu	$23,$23,1
	li	$2,4			# 0x4
	bne	$23,$2,$L2707
	lw	$3,76($sp)

	lw	$17,76($sp)
	andi	$2,$17,0x30
	beq	$2,$0,$L2696
	lw	$4,56($sp)

	lw	$3,64($sp)
	lui	$18,%hi(chroma_dc_scan)
	addiu	$14,$3,512
	lw	$8,8448($16)
	lw	$5,%got(ff_interleaved_golomb_vlc_len)($28)
	lw	$20,%got(ff_interleaved_ue_golomb_vlc_code)($28)
	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	addiu	$21,$3,768
	addiu	$18,$18,%lo(chroma_dc_scan)
	move	$15,$14
	li	$25,-1434451968			# 0xffffffffaa800000
	li	$10,9			# 0x9
	li	$24,-2147483648			# 0xffffffff80000000
	li	$19,3			# 0x3
$L2593:
	move	$11,$0
$L2550:
	lw	$3,8($13)
	sra	$2,$3,3
	addu	$2,$8,$2
	lbu	$6,0($2)
	lbu	$7,3($2)
	lbu	$4,1($2)
	sll	$6,$6,24
	lbu	$2,2($2)
	or	$6,$7,$6
	sll	$4,$4,16
	sll	$2,$2,8
	or	$4,$6,$4
	or	$4,$4,$2
	andi	$2,$3,0x7
	sll	$4,$4,$2
	and	$2,$4,$25
	bne	$2,$0,$L2555
	nop

	srl	$4,$4,24
	addu	$2,$5,$4
	lbu	$2,0($2)
	sltu	$6,$2,9
	beq	$6,$0,$L2668
	lw	$12,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

	li	$6,1			# 0x1
$L2562:
	addu	$3,$3,$2
$L2560:
	addiu	$2,$2,-1
$L2694:
	addu	$4,$12,$4
	sra	$7,$2,1
	lbu	$2,0($4)
	sll	$6,$6,$7
	or	$2,$2,$6
	addiu	$2,$2,-1
	beq	$2,$0,$L2669
	sw	$3,8($13)

$L2564:
	beq	$2,$24,$L2551
	addiu	$3,$2,1

	sra	$3,$3,1
	slt	$4,$3,3
	beq	$4,$0,$L2552
	move	$4,$0

$L2553:
	addu	$11,$4,$11
	slt	$4,$11,4
	beq	$4,$0,$L2708
	lui	$6,%hi($LC32)

$L2670:
	addu	$4,$18,$11
	lbu	$4,0($4)
	andi	$2,$2,0x1
	addiu	$2,$2,-1
	sll	$4,$4,1
	xor	$3,$3,$2
	subu	$2,$3,$2
	addu	$4,$15,$4
	sh	$2,0($4)
	b	$L2550
	addiu	$11,$11,1

$L2552:
	bne	$3,$19,$L2554
	addiu	$6,$3,9

	li	$4,1			# 0x1
	addu	$11,$4,$11
	slt	$4,$11,4
	bne	$4,$0,$L2670
	li	$3,1			# 0x1

$L2551:
	lui	$6,%hi($LC32)
$L2708:
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L2636
	addiu	$6,$6,%lo($LC32)

$L2555:
	srl	$4,$4,24
	addu	$2,$5,$4
	lbu	$2,0($2)
	addu	$4,$20,$4
	addu	$3,$2,$3
	lbu	$2,0($4)
	bne	$2,$0,$L2564
	sw	$3,8($13)

$L2669:
	addiu	$15,$15,128
	bne	$15,$21,$L2593
	nop

	andi	$17,$17,0x20
	beq	$17,$0,$L2696
	lw	$4,56($sp)

	lui	$19,%hi(scan8+16)
	lui	$21,%hi(scan8+24)
	lui	$17,%hi(svq3_dct_tables)
	lui	$25,%hi(zigzag_scan)
	lw	$18,%got(ff_interleaved_ue_golomb_vlc_code)($28)
	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	addiu	$19,$19,%lo(scan8+16)
	addiu	$21,$21,%lo(scan8+24)
	addiu	$17,$17,%lo(svq3_dct_tables)
	addiu	$25,$25,%lo(zigzag_scan)
	li	$20,1			# 0x1
	li	$15,-1434451968			# 0xffffffffaa800000
	li	$10,9			# 0x9
	li	$24,-2147483648			# 0xffffffff80000000
$L2595:
	lbu	$2,0($19)
	li	$11,1			# 0x1
	addu	$2,$16,$2
	sb	$20,9080($2)
	lw	$8,0($13)
$L2566:
	lw	$3,8($13)
	sra	$2,$3,3
	addu	$2,$8,$2
	lbu	$6,0($2)
	lbu	$7,3($2)
	lbu	$4,1($2)
	sll	$6,$6,24
	lbu	$2,2($2)
	or	$6,$7,$6
	sll	$4,$4,16
	sll	$2,$2,8
	or	$4,$6,$4
	or	$4,$4,$2
	andi	$2,$3,0x7
	sll	$4,$4,$2
	and	$2,$4,$15
	bne	$2,$0,$L2573
	nop

	srl	$4,$4,24
	addu	$2,$5,$4
	lbu	$2,0($2)
	sltu	$6,$2,9
	beq	$6,$0,$L2671
	lw	$12,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

	li	$6,1			# 0x1
$L2580:
	addu	$3,$3,$2
$L2578:
	addiu	$2,$2,-1
$L2697:
	addu	$4,$12,$4
	sra	$7,$2,1
	lbu	$2,0($4)
	sll	$6,$6,$7
	or	$2,$2,$6
	addiu	$2,$2,-1
	beq	$2,$0,$L2672
	sw	$3,8($13)

$L2582:
	beq	$2,$24,$L2567
	addiu	$3,$2,1

	sra	$3,$3,1
	slt	$4,$3,16
	bne	$4,$0,$L2673
	andi	$4,$3,0xf

	bne	$4,$0,$L2570
	li	$6,4			# 0x4

$L2571:
	addu	$11,$4,$11
	sra	$3,$3,4
	slt	$4,$11,16
	beq	$4,$0,$L2567
	addu	$6,$6,$3

$L2680:
	addu	$3,$25,$11
	lbu	$3,0($3)
	andi	$2,$2,0x1
	addiu	$2,$2,-1
	sll	$3,$3,1
	xor	$4,$6,$2
	subu	$2,$4,$2
	addu	$3,$14,$3
	sh	$2,0($3)
	b	$L2566
	addiu	$11,$11,1

$L2524:
	lw	$3,52($sp)
	b	$L2525
	addu	$18,$2,$3

$L2668:
	bne	$2,$10,$L2674
	addiu	$3,$3,8

	lw	$12,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	li	$6,1			# 0x1
$L2561:
	sra	$2,$3,3
	addu	$2,$8,$2
	lbu	$23,0($2)
	lbu	$22,1($2)
	lbu	$fp,3($2)
	lbu	$7,2($2)
	sll	$23,$23,24
	sll	$22,$22,16
	or	$2,$fp,$23
	or	$2,$2,$22
	sll	$7,$7,8
	or	$2,$2,$7
	andi	$7,$3,0x7
	sll	$2,$2,$7
	addu	$7,$9,$4
	srl	$4,$2,24
	addu	$2,$5,$4
	lbu	$2,0($2)
	lbu	$22,0($7)
	sll	$6,$6,4
	sltu	$7,$2,9
	bne	$7,$0,$L2562
	or	$6,$22,$6

	beq	$2,$10,$L2561
	addiu	$3,$3,8

	b	$L2694
	addiu	$2,$2,-1

$L2666:
	li	$4,2			# 0x2
	sra	$2,$2,3
	b	$L2667
	addu	$2,$4,$2

$L2554:
	sra	$6,$6,2
	andi	$4,$3,0x3
	b	$L2553
	subu	$3,$6,$4

$L2508:
	beq	$6,$0,$L2510
	nop

	b	$L2509
	li	$6,2			# 0x2

$L2652:
	move	$4,$16
	move	$5,$0
	move	$6,$19
	move	$7,$0
	.option	pic0
	jal	svq3_mc_dir
	.option	pic2
	sw	$0,16($sp)

	bltz	$2,$L2400
	lw	$28,40($sp)

	li	$2,1			# 0x1
	bne	$17,$2,$L2439
	lw	$25,%call16(memset)($28)

	lw	$4,1564($16)
	sll	$2,$18,2
	addu	$4,$4,$2
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	lw	$4,1564($16)
	addu	$2,$18,$2
	lw	$25,%call16(memset)($28)
	sll	$2,$2,2
	addu	$4,$4,$2
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	sll	$2,$2,1
	lw	$4,1564($16)
	addu	$2,$18,$2
	lw	$25,%call16(memset)($28)
	sll	$2,$2,2
	addu	$4,$4,$2
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	sll	$3,$2,1
	addu	$2,$3,$2
	lw	$4,1564($16)
	addu	$18,$2,$18
	lw	$25,%call16(memset)($28)
	sll	$18,$18,2
	addu	$4,$4,$18
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$28,40($sp)
$L2401:
	li	$7,8			# 0x8
	sw	$7,60($sp)
	move	$17,$0
	lw	$8,56($sp)
$L2702:
	lw	$3,8816($16)
	sll	$2,$8,3
	addu	$2,$3,$2
	li	$3,2			# 0x2
	sb	$3,7($2)
	sb	$3,0($2)
	sb	$3,1($2)
	sb	$3,2($2)
	sb	$3,3($2)
	sb	$3,4($2)
	sb	$3,5($2)
	sb	$3,6($2)
	lw	$2,60($sp)
	move	$18,$0
	andi	$20,$2,0x800
	b	$L2479
	andi	$19,$2,0x2

$L2483:
	lw	$2,8456($16)
	lw	$10,8448($16)
	sra	$3,$2,3
	addu	$3,$10,$3
	lbu	$5,0($3)
	lbu	$6,3($3)
	lbu	$4,1($3)
	sll	$5,$5,24
	lbu	$3,2($3)
	or	$5,$6,$5
	sll	$4,$4,16
	sll	$3,$3,8
	or	$4,$5,$4
	or	$4,$4,$3
	andi	$3,$2,0x7
	sll	$4,$4,$3
	li	$3,-1434451968			# 0xffffffffaa800000
	and	$3,$4,$3
	bne	$3,$0,$L2485
	lw	$5,%got(ff_interleaved_golomb_vlc_len)($28)

	srl	$4,$4,24
	addu	$3,$5,$4
	lbu	$3,0($3)
	sltu	$6,$3,9
	bne	$6,$0,$L2486
	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

	li	$6,9			# 0x9
	bne	$3,$6,$L2675
	addiu	$2,$2,8

	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	li	$6,1			# 0x1
	li	$11,9			# 0x9
$L2491:
	sra	$3,$2,3
	addu	$3,$10,$3
	lbu	$8,0($3)
	lbu	$12,3($3)
	lbu	$7,1($3)
	sll	$8,$8,24
	lbu	$3,2($3)
	or	$8,$12,$8
	sll	$7,$7,16
	or	$7,$8,$7
	sll	$3,$3,8
	or	$7,$7,$3
	andi	$3,$2,0x7
	sll	$3,$7,$3
	addu	$7,$9,$4
	srl	$4,$3,24
	addu	$3,$5,$4
	lbu	$3,0($3)
	lbu	$8,0($7)
	sll	$6,$6,4
	sltu	$7,$3,9
	bne	$7,$0,$L2492
	or	$6,$8,$6

	beq	$3,$11,$L2491
	addiu	$2,$2,8

	b	$L2695
	addu	$4,$9,$4

$L2376:
	slt	$4,$20,$19
	b	$L2377
	movz	$20,$19,$4

$L2510:
	b	$L2509
	slt	$6,$4,10

$L2660:
	li	$5,2			# 0x2
	sw	$4,68($sp)
	li	$22,1			# 0x1
	sw	$5,72($sp)
	b	$L2522
	move	$8,$5

$L2642:
	lw	$23,56($16)
	slt	$2,$17,-16
	srl	$23,$23,14
	andi	$23,$23,0x1
	lw	$6,164($16)
	beq	$2,$0,$L2370
	lw	$3,168($16)

	li	$2,-16			# 0xfffffffffffffff0
	b	$L2371
	li	$22,-16			# 0xfffffffffffffff0

$L2648:
	lw	$2,9772($16)
$L2403:
	beq	$2,$0,$L2404
	li	$19,1			# 0x1

	lw	$2,8456($16)
	lw	$5,8448($16)
	sra	$3,$2,3
	addu	$3,$5,$3
	lbu	$5,0($3)
	andi	$3,$2,0x7
	sll	$3,$5,$3
	andi	$3,$3,0x00ff
	srl	$3,$3,7
	addiu	$2,$2,1
	sltu	$3,$3,1
	beq	$4,$3,$L2676
	sw	$2,8456($16)

	b	$L2711
	lw	$2,56($sp)

$L2653:
	lw	$4,1564($16)
	lw	$25,%call16(memset)($28)
	addu	$4,$4,$22
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	lw	$4,1564($16)
	addu	$2,$18,$2
	lw	$25,%call16(memset)($28)
	sll	$2,$2,2
	addu	$4,$4,$2
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	sll	$2,$2,1
	lw	$4,1564($16)
	addu	$2,$18,$2
	lw	$25,%call16(memset)($28)
	sll	$2,$2,2
	addu	$4,$4,$2
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,9748($16)
	lw	$28,40($sp)
	sll	$3,$2,1
	addu	$2,$3,$2
	lw	$4,1564($16)
	addu	$18,$2,$18
	lw	$25,%call16(memset)($28)
	sll	$18,$18,2
	addu	$4,$4,$18
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	b	$L2589
	lw	$28,40($sp)

$L2644:
	addiu	$19,$4,8776
	move	$4,$19
	li	$5,-1			# 0xffffffffffffffff
	jalr	$25
	li	$6,40			# 0x28

	li	$2,2			# 0x2
	addiu	$6,$16,8788
	addiu	$5,$16,8796
	addiu	$4,$16,8804
	addiu	$3,$16,8812
	lw	$28,40($sp)
	sb	$2,8788($16)
	sb	$2,3($6)
	sb	$2,1($6)
	sb	$2,2($6)
	sb	$2,8796($16)
	sb	$2,3($5)
	sb	$2,1($5)
	sb	$2,2($5)
	sb	$2,8804($16)
	sb	$2,3($4)
	sb	$2,1($4)
	sb	$2,2($4)
	sb	$2,8812($16)
	sb	$2,3($3)
	sb	$2,1($3)
	sb	$2,2($3)
	lw	$2,6172($16)
$L2699:
	lw	$5,152($16)
	lw	$4,6168($16)
	mul	$6,$5,$2
	lw	$3,8816($16)
	addu	$2,$6,$4
	sll	$2,$2,3
	lbu	$4,8791($16)
	addu	$3,$3,$2
	sb	$4,0($3)
	lw	$3,8816($16)
	lbu	$4,8799($16)
	addu	$3,$3,$2
	sb	$4,1($3)
	lw	$3,8816($16)
	lbu	$4,8807($16)
	addu	$3,$3,$2
	sb	$4,2($3)
	lw	$3,8816($16)
	lbu	$4,8815($16)
	addu	$3,$3,$2
	sb	$4,3($3)
	lw	$3,8816($16)
	lbu	$4,8812($16)
	addu	$3,$3,$2
	sb	$4,4($3)
	lw	$3,8816($16)
	lbu	$4,8813($16)
	addu	$3,$3,$2
	sb	$4,5($3)
	lw	$4,8816($16)
	lbu	$3,8814($16)
	addu	$2,$4,$2
	sb	$3,6($2)
	li	$2,8			# 0x8
	beq	$17,$2,$L2677
	li	$2,11			# 0xb

	addiu	$6,$19,12
	addiu	$5,$19,20
	addiu	$4,$19,28
	addiu	$3,$19,36
	sb	$2,12($19)
	sb	$2,3($6)
	sb	$2,1($6)
	sb	$2,2($6)
	sb	$2,20($19)
	sb	$2,3($5)
	sb	$2,1($5)
	sb	$2,2($5)
	sb	$2,28($19)
	sb	$2,3($4)
	sb	$2,1($4)
	sb	$2,2($4)
	sb	$2,36($19)
	sb	$2,3($3)
	sb	$2,1($3)
	sb	$2,2($3)
	li	$2,13311			# 0x33ff
	sw	$2,8984($16)
	li	$2,24415			# 0x5f5f
	sw	$2,8992($16)
$L2638:
	li	$21,1			# 0x1
	lw	$2,2084($16)
	move	$19,$0
	move	$20,$0
	move	$17,$0
	b	$L2384
	sw	$21,60($sp)

$L2485:
	srl	$4,$4,24
	addu	$5,$5,$4
	lbu	$3,0($5)
	addu	$2,$3,$2
	lw	$3,%got(ff_interleaved_ue_golomb_vlc_code)($28)
	sw	$2,8456($16)
	addu	$4,$3,$4
	lbu	$7,0($4)
$L2488:
	sltu	$2,$7,48
	beq	$2,$0,$L2678
	lw	$3,60($sp)

	andi	$2,$3,0x7
	beq	$2,$0,$L2495
	nop

	lui	$2,%hi(golomb_to_intra4x4_cbp)
	addiu	$2,$2,%lo(golomb_to_intra4x4_cbp)
	addu	$7,$7,$2
	lbu	$17,0($7)
	b	$L2484
	lw	$2,2084($16)

$L2368:
	li	$17,6			# 0x6
	movn	$17,$2,$3
	move	$5,$17
	li	$6,4			# 0x4
	move	$7,$0
	.option	pic0
	jal	svq3_mc_dir
	.option	pic2
	sw	$0,16($sp)

	bgez	$2,$L2679
	move	$4,$16

$L2400:
	b	$L2456
	li	$2,-1			# 0xffffffffffffffff

$L2676:
	b	$L2404
	li	$19,2			# 0x2

$L2486:
	li	$6,1			# 0x1
$L2492:
	addu	$2,$2,$3
$L2490:
	addu	$4,$9,$4
$L2695:
	addiu	$3,$3,-1
	sra	$3,$3,1
	lbu	$7,0($4)
	sll	$6,$6,$3
	or	$7,$7,$6
	sw	$2,8456($16)
	b	$L2488
	addiu	$7,$7,-1

$L2379:
	lw	$4,2040($16)
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	li	$7,17			# 0x11
	sw	$6,28($sp)
	sw	$3,32($sp)
	move	$6,$21
	sw	$2,96($sp)
	sw	$7,16($sp)
	sw	$22,20($sp)
	jalr	$25
	sw	$20,24($sp)

	move	$3,$21
	lw	$5,2040($16)
	lw	$21,176($16)
	b	$L2375
	lw	$2,96($sp)

$L2495:
	lui	$2,%hi(golomb_to_inter_cbp)
	addiu	$2,$2,%lo(golomb_to_inter_cbp)
	addu	$7,$7,$2
	lbu	$17,0($7)
	b	$L2484
	lw	$2,2084($16)

$L2673:
	sll	$3,$3,1
	addu	$3,$3,$17
	lbu	$4,0($3)
	addu	$11,$4,$11
	slt	$4,$11,16
	bne	$4,$0,$L2680
	lbu	$6,1($3)

$L2567:
	lui	$6,%hi($LC33)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L2636
	addiu	$6,$6,%lo($LC33)

$L2573:
	srl	$4,$4,24
	addu	$2,$5,$4
	lbu	$2,0($2)
	addu	$4,$18,$4
	addu	$3,$2,$3
	lbu	$2,0($4)
	bne	$2,$0,$L2582
	sw	$3,8($13)

$L2672:
	addiu	$19,$19,1
	bne	$19,$21,$L2595
	addiu	$14,$14,32

	b	$L2696
	lw	$4,56($sp)

$L2671:
	bne	$2,$10,$L2681
	addiu	$3,$3,8

	lw	$12,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	li	$6,1			# 0x1
$L2579:
	sra	$2,$3,3
	addu	$2,$8,$2
	lbu	$23,0($2)
	lbu	$22,1($2)
	lbu	$fp,3($2)
	lbu	$7,2($2)
	sll	$23,$23,24
	sll	$22,$22,16
	or	$2,$fp,$23
	or	$2,$2,$22
	sll	$7,$7,8
	or	$2,$2,$7
	andi	$7,$3,0x7
	sll	$2,$2,$7
	addu	$7,$9,$4
	srl	$4,$2,24
	addu	$2,$5,$4
	lbu	$2,0($2)
	lbu	$22,0($7)
	sll	$6,$6,4
	sltu	$7,$2,9
	bne	$7,$0,$L2580
	or	$6,$22,$6

	beq	$2,$10,$L2579
	addiu	$3,$3,8

	b	$L2697
	addiu	$2,$2,-1

$L2570:
	slt	$6,$4,3
	beq	$6,$0,$L2572
	nop

	b	$L2571
	li	$6,2			# 0x2

$L2572:
	b	$L2571
	slt	$6,$4,10

$L2423:
	sw	$0,204($20)
	sw	$0,236($20)
	sw	$0,268($20)
	b	$L2424
	sw	$0,300($20)

$L2408:
	sw	$0,44($20)
	sw	$0,76($20)
	sw	$0,108($20)
	b	$L2407
	sw	$0,140($20)

$L2428:
	b	$L2431
	sb	$4,9504($16)

$L2649:
	addiu	$4,$22,3
	li	$5,-2			# 0xfffffffffffffffe
	jalr	$25
	li	$6,8			# 0x8

	b	$L2410
	lw	$28,40($sp)

$L2650:
	b	$L2417
	sb	$4,9464($16)

$L2381:
	move	$21,$0
	li	$2,9			# 0x9
	lw	$23,180($16)
$L2698:
	addu	$3,$fp,$21
	lw	$8,4($3)
	mul	$3,$20,$23
	lw	$7,164($16)
	lw	$6,168($16)
	addu	$5,$3,$22
	addu	$3,$16,$21
	lw	$3,1468($3)
	lw	$4,2040($16)
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	sra	$7,$7,1
	sra	$6,$6,1
	addu	$5,$8,$5
	sw	$2,16($sp)
	sw	$2,96($sp)
	sw	$7,28($sp)
	sw	$6,32($sp)
	li	$7,9			# 0x9
	move	$6,$23
	sw	$3,92($sp)
	sw	$22,20($sp)
	jalr	$25
	sw	$20,24($sp)

	mul	$5,$19,$23
	lw	$6,48($sp)
	lw	$3,92($sp)
	addu	$4,$5,$17
	lw	$25,0($6)
	lw	$5,2040($16)
	lw	$6,180($16)
	addu	$4,$3,$4
	jalr	$25
	li	$7,8			# 0x8

	addiu	$21,$21,4
	li	$3,8			# 0x8
	lw	$28,40($sp)
	beq	$21,$3,$L2380
	lw	$2,96($sp)

	b	$L2698
	lw	$23,180($16)

$L2383:
	lw	$17,6168($16)
	lw	$19,6172($16)
	addiu	$7,$16,648
	sll	$17,$17,4
	sll	$19,$19,4
	bltz	$17,$L2682
	sw	$7,60($sp)

	lw	$3,164($16)
	addiu	$2,$3,-17
	slt	$2,$17,$2
	beq	$2,$0,$L2641
	nop

	bltz	$19,$L2641
	nop

	lw	$2,168($16)
	addiu	$4,$2,-17
	slt	$4,$19,$4
	beq	$4,$0,$L2389
	move	$22,$17

	lw	$21,176($16)
	lw	$5,648($16)
	mul	$3,$19,$21
	lw	$fp,1464($16)
	addu	$2,$3,$17
	addu	$5,$5,$2
	move	$20,$19
	move	$2,$21
	move	$23,$0
$L2391:
	mul	$3,$19,$2
	lw	$25,2660($16)
	addu	$2,$3,$17
	addu	$4,$fp,$2
	move	$6,$21
	jalr	$25
	li	$7,16			# 0x10

	lw	$2,56($16)
	andi	$2,$2,0x2000
	bne	$2,$0,$L2637
	lw	$28,40($sp)

	slt	$3,$22,$17
	slt	$2,$20,$19
	sra	$17,$17,1
	sra	$19,$19,1
	addu	$22,$3,$22
	addu	$20,$2,$20
	sw	$17,52($sp)
	sw	$19,48($sp)
	sra	$22,$22,1
	sra	$20,$20,1
	addiu	$19,$16,2676
	move	$21,$0
	li	$17,9			# 0x9
$L2399:
	lw	$4,60($sp)
	lw	$fp,180($16)
	addu	$2,$4,$21
	lw	$5,4($2)
	mul	$2,$20,$fp
	addu	$3,$2,$22
	addu	$2,$16,$21
	addu	$5,$5,$3
	bne	$23,$0,$L2397
	lw	$2,1468($2)

	move	$6,$fp
$L2398:
	lw	$3,48($sp)
	lw	$7,52($sp)
	mul	$8,$3,$fp
	lw	$25,0($19)
	addu	$4,$8,$7
	addu	$4,$2,$4
	jalr	$25
	li	$7,8			# 0x8

	addiu	$21,$21,4
	li	$2,8			# 0x8
	bne	$21,$2,$L2399
	lw	$28,40($sp)

$L2637:
	b	$L2639
	lw	$2,2084($16)

$L2641:
	lw	$2,168($16)
$L2389:
	lw	$23,56($16)
	srl	$23,$23,14
	andi	$23,$23,0x1
$L2386:
	addiu	$4,$3,-1
	slt	$22,$17,$4
	movn	$4,$17,$22
	move	$22,$4
$L2387:
	slt	$5,$19,-16
	beq	$5,$0,$L2392
	addiu	$20,$2,-1

	li	$20,-16			# 0xfffffffffffffff0
$L2393:
	lw	$21,176($16)
	lw	$5,648($16)
	mul	$6,$20,$21
	lw	$fp,1464($16)
	addu	$4,$6,$4
	beq	$23,$0,$L2683
	addu	$5,$5,$4

	lw	$4,2040($16)
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	li	$6,17			# 0x11
	sw	$6,16($sp)
	sw	$2,32($sp)
	move	$6,$21
	sw	$3,28($sp)
	sw	$22,20($sp)
	sw	$20,24($sp)
	jalr	$25
	li	$7,17			# 0x11

	move	$2,$21
	lw	$5,2040($16)
	b	$L2391
	lw	$21,176($16)

$L2419:
	li	$2,-2			# 0xfffffffffffffffe
	sb	$2,9464($16)
	b	$L2417
	lw	$7,6168($16)

$L2429:
	li	$2,-2			# 0xfffffffffffffffe
	sb	$2,9504($16)
	b	$L2431
	lw	$7,6168($16)

$L2425:
	addiu	$4,$22,43
	li	$5,-2			# 0xfffffffffffffffe
	jalr	$25
	li	$6,8			# 0x8

	b	$L2435
	lw	$28,40($sp)

$L2651:
	li	$2,-2			# 0xfffffffffffffffe
	b	$L2410
	sb	$2,9459($16)

$L2422:
$L2701:
	bne	$2,$3,$L2709
	li	$2,2			# 0x2

	addiu	$5,$17,-1
	move	$6,$19
	move	$4,$16
	move	$7,$0
	.option	pic0
	jal	svq3_mc_dir
	.option	pic2
	sw	$0,16($sp)

	bgez	$2,$L2401
	lw	$28,40($sp)

	b	$L2456
	li	$2,-1			# 0xffffffffffffffff

$L2498:
	addiu	$4,$3,8
	sra	$3,$4,3
	addu	$3,$8,$3
	lbu	$6,0($3)
	lbu	$9,3($3)
	lbu	$5,1($3)
	sll	$6,$6,24
	lbu	$3,2($3)
	or	$6,$9,$6
	sll	$5,$5,16
	sll	$3,$3,8
	or	$5,$6,$5
	or	$5,$5,$3
	andi	$3,$4,0x7
	sll	$3,$5,$3
	srl	$3,$3,8
	ori	$2,$2,0x1
	or	$2,$2,$3
	li	$3,-1431699456			# 0xffffffffaaaa0000
	ori	$3,$3,0xaaaa
	and	$3,$2,$3
	beq	$3,$0,$L2684
	li	$3,31			# 0x1f

	b	$L2710
	sll	$5,$2,2

$L2502:
	addiu	$3,$3,-1
	srl	$2,$9,$3
	subu	$2,$5,$2
	sll	$5,$2,2
$L2710:
	srl	$6,$2,30
	sll	$9,$2,$3
	bgez	$2,$L2502
	addu	$5,$6,$5

	srl	$5,$9,$3
	andi	$2,$2,0x1
	addiu	$5,$5,-1
	subu	$2,$0,$2
	xor	$2,$5,$2
	addiu	$4,$4,55
	sll	$3,$3,1
	subu	$3,$4,$3
	addiu	$2,$2,1
	sw	$3,8456($16)
	b	$L2499
	sra	$2,$2,1

$L2677:
	lw	$2,8984($16)
	andi	$2,$2,0x8000
	bne	$2,$0,$L2461
	lui	$5,%hi(top.10290)

	addiu	$5,$5,%lo(top.10290)
	move	$2,$16
	move	$3,$0
	li	$4,4			# 0x4
$L2465:
	lb	$6,8788($2)
	addu	$6,$5,$6
	lb	$7,0($6)
	bltz	$7,$L2685
	addiu	$3,$3,1

	beq	$7,$0,$L2464
	nop

	sb	$7,8788($2)
$L2464:
	bne	$3,$4,$L2465
	addiu	$2,$2,1

$L2461:
	lw	$2,8992($16)
	andi	$2,$2,0x8000
	bne	$2,$0,$L2463
	lui	$5,%hi(left.10291)

	addiu	$5,$5,%lo(left.10291)
	move	$2,$16
	move	$3,$0
	b	$L2468
	li	$4,4			# 0x4

$L2466:
	beq	$7,$0,$L2467
	nop

	sb	$7,8788($2)
$L2467:
	beq	$3,$4,$L2463
	addiu	$2,$2,8

$L2468:
	lb	$6,8788($2)
	addu	$6,$5,$6
	lb	$7,0($6)
	bgez	$7,$L2466
	addiu	$3,$3,1

	lw	$3,6168($16)
	lw	$2,6172($16)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC26)
	sw	$3,16($sp)
	sw	$2,20($sp)
	addiu	$6,$6,%lo($LC26)
	jalr	$25
	move	$5,$0

	lw	$28,40($sp)
$L2463:
	lw	$4,6168($16)
	li	$2,65535			# 0xffff
	lw	$5,6172($16)
	li	$3,24415			# 0x5f5f
	movn	$3,$2,$4
	li	$4,13311			# 0x33ff
	movz	$2,$4,$5
	sw	$2,8984($16)
	b	$L2638
	sw	$3,8992($16)

$L2441:
	lw	$25,%call16(memset)($28)
	addiu	$19,$4,8776
	move	$4,$19
	li	$5,-1			# 0xffffffffffffffff
	jalr	$25
	li	$6,40			# 0x28

	lw	$2,6168($16)
	blez	$2,$L2444
	lw	$28,40($sp)

	lw	$5,56($sp)
	lw	$3,8816($16)
	addiu	$2,$5,-1
	sll	$2,$2,3
	addu	$2,$3,$2
	lbu	$3,0($2)
	sb	$3,8787($16)
	lbu	$4,1($2)
	sll	$3,$3,24
	sb	$4,8795($16)
	lbu	$4,2($2)
	sra	$3,$3,24
	sb	$4,8803($16)
	lbu	$2,3($2)
	sb	$2,8811($16)
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L2686
	nop

$L2444:
	lw	$2,6172($16)
	blez	$2,$L2445
	lw	$6,56($sp)

	lw	$2,152($16)
	lw	$3,8816($16)
	subu	$2,$6,$2
	sll	$2,$2,3
	addu	$2,$3,$2
	lb	$3,4($2)
	sb	$3,8780($16)
	lbu	$4,5($2)
	sb	$4,8781($16)
	lbu	$4,6($2)
	sb	$4,8782($16)
	lbu	$2,3($2)
	sb	$2,8783($16)
	li	$2,-1			# 0xffffffffffffffff
	beq	$3,$2,$L2687
	li	$2,13311			# 0x33ff

$L2445:
	lui	$12,%hi(scan8)
	lui	$20,%hi(scan8+16)
	lui	$25,%hi(svq3_pred_0)
	lui	$14,%hi(svq3_pred_1)
	lw	$5,%got(ff_interleaved_golomb_vlc_len)($28)
	lw	$21,%got(ff_interleaved_ue_golomb_vlc_code)($28)
	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	addiu	$12,$12,%lo(scan8)
	addiu	$20,$20,%lo(scan8+16)
	addiu	$25,$25,%lo(svq3_pred_0)
	addiu	$14,$14,%lo(svq3_pred_1)
	addiu	$24,$16,8448
	li	$15,-1434451968			# 0xffffffffaa800000
	li	$11,9			# 0x9
	li	$13,-1			# 0xffffffffffffffff
$L2459:
	lw	$2,8456($16)
	lw	$4,8448($16)
	sra	$3,$2,3
	addu	$3,$4,$3
	lbu	$6,0($3)
	lbu	$7,3($3)
	lbu	$4,1($3)
	sll	$6,$6,24
	lbu	$3,2($3)
	or	$6,$7,$6
	sll	$4,$4,16
	sll	$3,$3,8
	or	$4,$6,$4
	or	$4,$4,$3
	andi	$3,$2,0x7
	sll	$4,$4,$3
	and	$3,$4,$15
	bne	$3,$0,$L2446
	nop

	srl	$4,$4,24
	addu	$3,$5,$4
	lbu	$3,0($3)
	sltu	$6,$3,9
	beq	$6,$0,$L2688
	lw	$22,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

	li	$6,1			# 0x1
$L2453:
	addu	$2,$2,$3
$L2451:
	addu	$4,$22,$4
$L2700:
	addiu	$3,$3,-1
	sra	$3,$3,1
	lbu	$7,0($4)
	sll	$6,$6,$3
	or	$7,$7,$6
	sw	$2,8456($16)
	addiu	$7,$7,-1
$L2449:
	sltu	$2,$7,25
	beq	$2,$0,$L2689
	lui	$6,%hi($LC23)

	lbu	$2,0($12)
	sll	$7,$7,1
	addu	$4,$16,$2
	move	$3,$4
	lb	$3,8775($3)
	lb	$4,8768($4)
	addiu	$3,$3,1
	addiu	$4,$4,1
	sll	$8,$4,5
	sll	$6,$3,2
	sll	$4,$4,1
	subu	$4,$8,$4
	addu	$3,$6,$3
	addu	$7,$7,$25
	addu	$3,$4,$3
	lbu	$4,0($7)
	addu	$3,$3,$14
	addu	$3,$3,$4
	lb	$3,0($3)
	addiu	$4,$2,8775
	addu	$4,$16,$4
	addu	$2,$16,$2
	sb	$3,1($4)
	lb	$6,8769($2)
	addiu	$2,$3,1
	addiu	$6,$6,1
	sll	$10,$6,5
	sll	$8,$2,2
	sll	$6,$6,1
	subu	$6,$10,$6
	addu	$2,$8,$2
	addu	$2,$6,$2
	lbu	$6,1($7)
	addu	$2,$2,$14
	addu	$2,$2,$6
	lb	$2,0($2)
	beq	$3,$13,$L2457
	sb	$2,2($4)

	beq	$2,$13,$L2457
	addiu	$12,$12,2

	bne	$12,$20,$L2459
	nop

	b	$L2699
	lw	$2,6172($16)

$L2446:
	srl	$4,$4,24
	addu	$3,$5,$4
	lbu	$3,0($3)
	addu	$4,$21,$4
	addu	$2,$3,$2
	sw	$2,8456($16)
	b	$L2449
	lbu	$7,0($4)

$L2688:
	bne	$3,$11,$L2690
	addiu	$2,$2,8

	lw	$10,0($24)
	lw	$22,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	li	$6,1			# 0x1
$L2452:
	sra	$3,$2,3
	addu	$3,$10,$3
	lbu	$8,0($3)
	lbu	$23,3($3)
	lbu	$7,1($3)
	sll	$8,$8,24
	lbu	$3,2($3)
	or	$8,$23,$8
	sll	$7,$7,16
	or	$7,$8,$7
	sll	$3,$3,8
	or	$7,$7,$3
	andi	$3,$2,0x7
	sll	$3,$7,$3
	addu	$7,$9,$4
	srl	$4,$3,24
	addu	$3,$5,$4
	lbu	$3,0($3)
	lbu	$8,0($7)
	sll	$6,$6,4
	sltu	$7,$3,9
	bne	$7,$0,$L2453
	or	$6,$8,$6

	beq	$3,$11,$L2452
	addiu	$2,$2,8

	b	$L2700
	addu	$4,$22,$4

$L2432:
	li	$2,-2			# 0xfffffffffffffffe
	b	$L2435
	sb	$2,9499($16)

$L2457:
	lui	$6,%hi($LC24)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L2636
	addiu	$6,$6,%lo($LC24)

$L2682:
	lw	$23,56($16)
	slt	$4,$17,-16
	srl	$23,$23,14
	andi	$23,$23,0x1
	lw	$3,164($16)
	beq	$4,$0,$L2386
	lw	$2,168($16)

	li	$4,-16			# 0xfffffffffffffff0
	b	$L2387
	li	$22,-16			# 0xfffffffffffffff0

$L2397:
	lw	$6,164($16)
	lw	$3,168($16)
	lw	$4,2040($16)
	sra	$6,$6,1
	sra	$3,$3,1
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	sw	$6,28($sp)
	sw	$2,96($sp)
	move	$6,$fp
	sw	$3,32($sp)
	sw	$17,16($sp)
	sw	$22,20($sp)
	sw	$20,24($sp)
	jalr	$25
	li	$7,9			# 0x9

	lw	$5,2040($16)
	lw	$6,180($16)
	b	$L2398
	lw	$2,96($sp)

$L2392:
	slt	$5,$20,$19
	b	$L2393
	movz	$20,$19,$5

$L2674:
	li	$6,1			# 0x1
	b	$L2560
	lw	$12,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

$L2663:
	li	$6,1			# 0x1
	b	$L2516
	lw	$13,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

$L2665:
	li	$5,1			# 0x1
	b	$L2543
	lw	$15,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

$L2655:
	lui	$6,%hi($LC29)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	addiu	$6,$6,%lo($LC29)
$L2635:
	jalr	$25
	move	$5,$0

	b	$L2456
	li	$2,-1			# 0xffffffffffffffff

$L2690:
	li	$6,1			# 0x1
	b	$L2451
	lw	$22,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

$L2689:
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L2635
	addiu	$6,$6,%lo($LC23)

$L2687:
	b	$L2445
	sw	$2,8984($16)

$L2686:
	b	$L2444
	sw	$20,8992($16)

$L2685:
	lw	$3,6168($16)
	lw	$2,6172($16)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC25)
	sw	$3,16($sp)
	sw	$2,20($sp)
	addiu	$6,$6,%lo($LC25)
	jalr	$25
	move	$5,$0

	b	$L2463
	lw	$28,40($sp)

$L2684:
	b	$L2499
	li	$2,-2147483648			# 0xffffffff80000000

$L2683:
	b	$L2391
	move	$2,$21

$L2681:
	li	$6,1			# 0x1
	b	$L2578
	lw	$12,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

$L2647:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	sw	$19,16($sp)
	addiu	$6,$6,%lo($LC2)
	jalr	$25
	move	$5,$0

	lw	$28,40($sp)
$L2474:
	li	$2,-1			# 0xffffffffffffffff
	lui	$6,%hi($LC27)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	sw	$2,8760($16)
	b	$L2636
	addiu	$6,$6,%lo($LC27)

$L2678:
	lui	$6,%hi($LC28)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L2635
	addiu	$6,$6,%lo($LC28)

$L2646:
	lw	$4,0($16)
	sw	$19,16($sp)
	addiu	$6,$6,%lo($LC1)
	jalr	$25
	move	$5,$0

	b	$L2474
	lw	$28,40($sp)

$L2645:
	lw	$4,0($16)
	lui	$6,%hi($LC0)
	sw	$19,16($sp)
	addiu	$6,$6,%lo($LC0)
	jalr	$25
	move	$5,$0

	b	$L2474
	lw	$28,40($sp)

$L2675:
	li	$6,1			# 0x1
	b	$L2490
	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

$L2679:
	li	$2,1			# 0x1
	move	$5,$17
	li	$6,4			# 0x4
	li	$7,1			# 0x1
	.option	pic0
	jal	svq3_mc_dir
	.option	pic2
	sw	$2,16($sp)

	bgez	$2,$L2401
	lw	$28,40($sp)

	b	$L2456
	li	$2,-1			# 0xffffffffffffffff

$L2658:
	lw	$2,6172($16)
	lw	$4,0($16)
	lw	$7,6168($16)
	lui	$6,%hi($LC2)
	sw	$2,16($sp)
	addiu	$6,$6,%lo($LC2)
	jalr	$25
	move	$5,$0

	li	$2,-1			# 0xffffffffffffffff
	sw	$2,8756($16)
	b	$L2691
	move	$2,$0

	.set	macro
	.set	reorder
	.end	svq3_decode_mb
	.size	svq3_decode_mb, .-svq3_decode_mb
	.align	2
	.set	nomips16
	.ent	decode_mb_skip
	.type	decode_mb_skip, @function
decode_mb_skip:
	.frame	$sp,136,$31		# vars= 72, regs= 10/0, args= 16, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-136
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,132($sp)
	sw	$fp,128($sp)
	sw	$23,124($sp)
	sw	$22,120($sp)
	sw	$21,116($sp)
	sw	$20,112($sp)
	sw	$19,108($sp)
	sw	$18,104($sp)
	sw	$17,100($sp)
	sw	$16,96($sp)
	.cprestore	16
	lw	$17,152($4)
	lw	$3,6172($4)
	lw	$2,6168($4)
	mul	$5,$17,$3
	move	$16,$4
	addu	$17,$5,$2
	lw	$4,9128($4)
	lw	$25,%call16(memset)($28)
	sll	$2,$17,4
	addu	$4,$4,$2
	sw	$0,24($sp)
	move	$5,$0
	jalr	$25
	li	$6,16			# 0x10

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,-6272($2)
	addiu	$2,$16,9088
	sw	$0,9088($16)
	sw	$0,36($2)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,12($2)
	sw	$0,16($2)
	sw	$0,20($2)
	sw	$0,24($2)
	sw	$0,28($2)
	bne	$3,$0,$L2713
	sw	$0,32($2)

	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$4,-6284($3)
	li	$3,3			# 0x3
	beq	$4,$3,$L2764
	lw	$2,24($sp)

$L2715:
	ori	$2,$2,0x3808
	move	$5,$2
	move	$4,$16
	move	$6,$0
	.option	pic0
	jal	fill_caches
	.option	pic2
	sw	$2,24($sp)

	lb	$2,9460($16)
	li	$3,-2			# 0xfffffffffffffffe
	beq	$2,$3,$L2717
	lb	$4,9467($16)

	beq	$4,$3,$L2717
	nop

	bne	$2,$0,$L2718
	nop

	lw	$3,9152($16)
	bne	$3,$0,$L2718
	nop

$L2717:
	move	$2,$0
$L2734:
	addiu	$3,$16,9184
	addiu	$4,$16,9468
	lw	$10,24($sp)
	sw	$0,9468($16)
	sw	$0,24($4)
	sw	$0,8($4)
	sw	$0,16($4)
	sw	$2,9184($16)
	sw	$2,108($3)
	sw	$2,4($3)
	sw	$2,8($3)
	sw	$2,12($3)
	sw	$2,32($3)
	sw	$2,36($3)
	sw	$2,40($3)
	sw	$2,44($3)
	sw	$2,64($3)
	sw	$2,68($3)
	sw	$2,72($3)
	sw	$2,76($3)
	sw	$2,96($3)
	sw	$2,100($3)
	sw	$2,104($3)
$L2716:
	lw	$24,6172($16)
	lw	$8,9748($16)
	lw	$3,9752($16)
	mul	$4,$24,$8
	mul	$5,$3,$24
	lw	$2,6168($16)
	addu	$8,$4,$2
	addu	$24,$5,$2
	andi	$4,$10,0x3000
	sll	$8,$8,2
	bne	$4,$0,$L2742
	sll	$24,$24,1

	lw	$4,1652($16)
	li	$2,-1			# 0xffffffffffffffff
	addu	$4,$4,$24
	addu	$3,$4,$3
	sh	$2,0($4)
	sh	$2,0($3)
$L2742:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,5944($2)
	beq	$3,$0,$L2743
	move	$4,$16

	li	$15,131072			# 0x20000
	addiu	$11,$8,2
	ori	$9,$15,0x21ec
	sll	$7,$8,2
	andi	$14,$10,0x800
	ori	$15,$15,0x21f8
	sll	$12,$11,2
	sw	$2,76($sp)
	sw	$7,68($sp)
	sw	$14,80($sp)
	addu	$15,$16,$15
	addu	$9,$16,$9
	addiu	$5,$16,9136
	sw	$12,72($sp)
	move	$6,$16
	move	$7,$0
	move	$2,$0
	li	$14,12288			# 0x3000
	mtlo	$17
$L2747:
	sll	$12,$2,1
	sll	$12,$14,$12
	and	$12,$12,$10
	beq	$12,$0,$L2744
	sll	$13,$7,2

	addu	$13,$13,$7
	sll	$23,$13,3
	addiu	$fp,$23,12
	sll	$fp,$fp,2
	lw	$3,1560($6)
	addu	$7,$5,$fp
	lw	$17,68($sp)
	lw	$18,0($7)
	lw	$19,4($7)
	addiu	$23,$23,14
	addu	$7,$3,$17
	addiu	$20,$13,1
	sll	$23,$23,2
	sw	$18,0($7)
	sw	$19,4($7)
	lw	$25,72($sp)
	addu	$7,$5,$23
	sll	$20,$20,3
	lw	$18,0($7)
	lw	$19,4($7)
	lw	$12,9748($16)
	addiu	$22,$20,12
	addu	$7,$3,$25
	sll	$22,$22,2
	sw	$18,0($7)
	sw	$19,4($7)
	addu	$21,$8,$12
	addu	$7,$5,$22
	lw	$18,0($7)
	lw	$19,4($7)
	sll	$21,$21,2
	addiu	$20,$20,14
	addu	$7,$3,$21
	addiu	$25,$13,2
	sll	$20,$20,2
	sw	$18,0($7)
	sw	$19,4($7)
	sll	$25,$25,3
	addu	$7,$5,$20
	lw	$18,0($7)
	lw	$19,4($7)
	addu	$17,$11,$12
	addiu	$7,$25,12
	sll	$17,$17,2
	sll	$7,$7,2
	sw	$7,60($sp)
	sw	$17,88($sp)
	addu	$17,$3,$17
	sw	$19,4($17)
	lw	$19,60($sp)
	sll	$7,$12,1
	sw	$18,0($17)
	addu	$19,$5,$19
	addu	$17,$7,$8
	addiu	$25,$25,14
	lw	$18,0($19)
	sll	$17,$17,2
	sll	$25,$25,2
	sw	$25,56($sp)
	addu	$25,$3,$17
	lw	$19,4($19)
	sw	$18,0($25)
	lw	$18,56($sp)
	sw	$19,4($25)
	sw	$17,92($sp)
	addu	$17,$5,$18
	lw	$18,0($17)
	lw	$19,4($17)
	addu	$25,$7,$11
	sll	$25,$25,2
	addiu	$13,$13,3
	sll	$13,$13,3
	sw	$18,32($sp)
	sw	$19,36($sp)
	sw	$25,64($sp)
	lw	$19,64($sp)
	addiu	$25,$13,12
	sll	$25,$25,2
	sw	$25,40($sp)
	addu	$25,$3,$19
	lw	$19,36($sp)
	lw	$18,32($sp)
	sw	$19,4($25)
	lw	$19,40($sp)
	sw	$18,0($25)
	addu	$17,$5,$19
	lw	$18,0($17)
	addu	$7,$7,$12
	lw	$19,4($17)
	addu	$25,$7,$8
	sw	$18,48($sp)
	sll	$25,$25,2
	sw	$19,52($sp)
	lw	$18,48($sp)
	addu	$19,$3,$25
	addiu	$13,$13,14
	move	$17,$19
	sll	$13,$13,2
	lw	$19,52($sp)
	sw	$18,0($17)
	addu	$18,$5,$13
	sw	$19,4($17)
	addu	$7,$7,$11
	move	$19,$18
	lw	$19,4($19)
	sw	$18,32($sp)
	sll	$7,$7,2
	lw	$18,0($18)
	addu	$3,$3,$7
	sw	$18,0($3)
	sw	$19,4($3)
	lw	$3,11808($16)
	beq	$3,$0,$L2745
	lw	$17,80($sp)

	beq	$17,$0,$L2765
	addu	$20,$15,$20

	sll	$7,$12,2
	lw	$19,68($sp)
	lw	$3,0($9)
	addiu	$25,$7,4
	sll	$12,$12,3
	addiu	$20,$7,2
	addiu	$18,$7,6
	addu	$3,$3,$19
	addu	$13,$12,$7
	sll	$19,$25,1
	sll	$20,$20,1
	sll	$18,$18,1
	addu	$13,$3,$13
	addu	$7,$3,$7
	addu	$20,$3,$20
	addu	$19,$3,$19
	addu	$18,$3,$18
	addu	$25,$3,$25
	addu	$12,$3,$12
	sw	$0,0($3)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$0,12($3)
	sw	$0,0($7)
	sw	$0,0($25)
	sw	$0,12($7)
	sw	$0,8($7)
	sw	$0,0($12)
	sw	$0,0($20)
	sw	$0,0($19)
	sw	$0,0($18)
	sw	$0,12($13)
	sw	$0,0($13)
	sw	$0,4($13)
	sw	$0,8($13)
$L2745:
	lw	$3,1652($6)
	lbu	$7,9468($4)
	addu	$3,$3,$24
	sb	$7,0($3)
	lbu	$7,9470($4)
	sb	$7,1($3)
	lw	$7,9752($16)
	lbu	$12,9484($4)
	addu	$7,$3,$7
	sb	$12,0($7)
	lw	$12,9752($16)
	lbu	$7,9486($4)
	addu	$3,$3,$12
	sb	$7,1($3)
	lw	$25,76($sp)
	lw	$3,5944($25)
$L2744:
	addiu	$2,$2,1
	sltu	$12,$2,$3
	addiu	$6,$6,4
	addiu	$4,$4,40
	addiu	$9,$9,4
	bne	$12,$0,$L2747
	move	$7,$2

	mflo	$17
$L2743:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$4,-6284($2)
	li	$3,3			# 0x3
	beq	$4,$3,$L2766
	nop

$L2748:
	lw	$3,1568($16)
	sll	$2,$17,2
	addu	$2,$3,$2
	lw	$3,24($sp)
	sw	$3,0($2)
	lw	$2,1548($16)
	lw	$3,2056($16)
	addu	$2,$2,$17
	sb	$3,0($2)
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,-6288($2)
	lw	$2,-6296($2)
	addu	$17,$3,$17
	sb	$2,0($17)
	lw	$31,132($sp)
	li	$2,1			# 0x1
	sw	$2,8748($16)
	lw	$fp,128($sp)
	lw	$23,124($sp)
	lw	$22,120($sp)
	lw	$21,116($sp)
	lw	$20,112($sp)
	lw	$19,108($sp)
	lw	$18,104($sp)
	lw	$17,100($sp)
	lw	$16,96($sp)
	j	$31
	addiu	$sp,$sp,136

$L2713:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$2,24($sp)
	lw	$4,-6284($3)
	li	$3,3			# 0x3
	bne	$4,$3,$L2715
	ori	$2,$2,0x80

$L2764:
	ori	$2,$2,0x5908
	move	$5,$2
	move	$4,$16
	move	$6,$0
	.option	pic0
	jal	fill_caches
	.option	pic2
	sw	$2,24($sp)

	move	$4,$16
	.option	pic0
	jal	pred_direct_motion
	.option	pic2
	addiu	$5,$sp,24

	lw	$10,24($sp)
	ori	$10,$10,0x800
	b	$L2716
	sw	$10,24($sp)

$L2765:
	addu	$fp,$15,$fp
	lw	$19,4($fp)
	lw	$18,0($fp)
	lw	$3,0($9)
	sw	$19,36($sp)
	lw	$19,68($sp)
	sw	$18,32($sp)
	addu	$12,$3,$19
	lw	$18,32($sp)
	lw	$19,36($sp)
	sw	$18,0($12)
	sw	$19,4($12)
	addu	$23,$15,$23
	lw	$19,4($23)
	lw	$18,0($23)
	sw	$19,36($sp)
	lw	$19,72($sp)
	sw	$18,32($sp)
	addu	$12,$3,$19
	lw	$18,32($sp)
	lw	$19,36($sp)
	sw	$18,0($12)
	sw	$19,4($12)
	addu	$22,$15,$22
	lw	$23,4($22)
	lw	$22,0($22)
	addu	$21,$3,$21
	sw	$22,0($21)
	sw	$23,4($21)
	lw	$12,88($sp)
	lw	$21,4($20)
	lw	$17,60($sp)
	lw	$20,0($20)
	addu	$19,$3,$12
	sw	$20,0($19)
	sw	$21,4($19)
	addu	$12,$15,$17
	lw	$19,92($sp)
	lw	$20,0($12)
	lw	$21,4($12)
	addu	$18,$3,$19
	sw	$20,0($18)
	sw	$21,4($18)
	lw	$17,56($sp)
	addu	$25,$3,$25
	addu	$12,$15,$17
	lw	$17,64($sp)
	lw	$18,0($12)
	lw	$19,4($12)
	addu	$12,$3,$17
	sw	$18,0($12)
	lw	$18,40($sp)
	sw	$19,4($12)
	addu	$12,$15,$18
	lw	$18,0($12)
	lw	$19,4($12)
	addu	$13,$15,$13
	sw	$18,0($25)
	sw	$19,4($25)
	lw	$12,0($13)
	lw	$13,4($13)
	addu	$7,$3,$7
	sw	$12,0($7)
	sw	$13,4($7)
	lw	$3,1652($6)
	lbu	$7,9468($4)
	addu	$3,$3,$24
	sb	$7,0($3)
	lbu	$7,9470($4)
	sb	$7,1($3)
	lw	$7,9752($16)
	lbu	$12,9484($4)
	addu	$7,$3,$7
	sb	$12,0($7)
	lw	$12,9752($16)
	lbu	$7,9486($4)
	addu	$3,$3,$12
	sb	$7,1($3)
	lw	$25,76($sp)
	b	$L2744
	lw	$3,5944($25)

$L2718:
	bne	$4,$0,$L2774
	li	$3,65536			# 0x10000

	lw	$3,9180($16)
	beq	$3,$0,$L2717
	li	$3,65536			# 0x10000

$L2774:
	addu	$3,$16,$3
	lw	$7,-6276($3)
	addiu	$6,$16,9136
	addiu	$9,$16,9180
	addiu	$8,$16,9152
	bne	$7,$0,$L2767
	lb	$5,9464($16)

	li	$3,-2			# 0xfffffffffffffffe
	bne	$5,$3,$L2775
	addiu	$3,$6,32

$L2727:
	lb	$5,9459($16)
	addiu	$3,$6,12
	sltu	$5,$5,1
$L2726:
	sltu	$7,$4,1
	sltu	$6,$2,1
	addu	$6,$7,$6
	addu	$5,$6,$5
	slt	$6,$5,2
	bne	$6,$0,$L2729
	li	$6,1			# 0x1

$L2735:
	lh	$4,9180($16)
	lh	$2,9152($16)
	slt	$6,$2,$4
	beq	$6,$0,$L2738
	lh	$5,0($3)

	slt	$6,$2,$5
	bne	$6,$0,$L2768
	nop

$L2739:
	lh	$5,2($9)
	lh	$4,2($8)
	slt	$6,$4,$5
	beq	$6,$0,$L2740
	lh	$3,2($3)

	slt	$6,$4,$3
	beq	$6,$0,$L2741
	nop

	slt	$4,$5,$3
	movz	$5,$3,$4
	move	$4,$5
$L2741:
	andi	$2,$2,0xffff
	sll	$4,$4,16
	b	$L2734
	addu	$2,$4,$2

$L2766:
	lw	$3,11808($16)
	beq	$3,$0,$L2748
	nop

	andi	$10,$10,0x40
	beq	$10,$0,$L2748
	li	$4,131072			# 0x20000

	lw	$3,-6260($2)
	addu	$4,$16,$4
	lw	$4,9016($4)
	srl	$3,$3,8
	addu	$24,$4,$24
	andi	$3,$3,0x1
	sb	$3,1($24)
	lw	$4,-6256($2)
	lw	$3,9752($16)
	srl	$4,$4,8
	addu	$3,$24,$3
	andi	$4,$4,0x1
	sb	$4,0($3)
	lw	$2,-6252($2)
	lw	$3,9752($16)
	srl	$2,$2,8
	addu	$24,$24,$3
	andi	$2,$2,0x1
	b	$L2748
	sb	$2,1($24)

$L2767:
	sw	$0,40($6)
	lw	$10,-6272($3)
	lw	$7,1880($16)
	addiu	$3,$16,9176
	bne	$10,$0,$L2721
	lw	$12,104($7)

	lw	$11,6172($16)
	andi	$13,$11,0x1
	beq	$13,$0,$L2721
	li	$13,-2			# 0xfffffffffffffffe

	beq	$5,$13,$L2722
	addiu	$14,$11,-1

	lw	$10,152($16)
	mul	$15,$14,$10
	lw	$13,6168($16)
	addu	$14,$15,$13
	sll	$14,$14,2
	addu	$14,$12,$14
	lw	$14,0($14)
	andi	$14,$14,0x80
	beq	$14,$0,$L2723
	sll	$11,$11,2

	addiu	$11,$11,-1
	sll	$5,$13,2
	sra	$13,$11,2
	mul	$14,$13,$10
	addiu	$5,$5,4
	sra	$6,$5,2
	addu	$10,$14,$6
	sll	$10,$10,2
	addu	$12,$12,$10
	lw	$6,0($12)
	andi	$10,$6,0x3000
	beq	$10,$0,$L2769
	andi	$6,$6,0x40

$L2724:
	lw	$6,9748($16)
	lw	$10,96($7)
	mul	$12,$11,$6
	sra	$11,$11,1
	addu	$6,$12,$5
	sll	$6,$6,2
	addu	$6,$10,$6
	lhu	$12,0($6)
	lw	$10,9752($16)
	sh	$12,9176($16)
	mul	$12,$11,$10
	lhu	$6,2($6)
	lw	$7,188($7)
	sll	$6,$6,1
	addu	$11,$12,$7
	sra	$5,$5,1
	sh	$6,9178($16)
	addu	$5,$11,$5
	lb	$5,0($5)
	sra	$5,$5,1
	b	$L2726
	sltu	$5,$5,1

$L2721:
	li	$11,-2			# 0xfffffffffffffffe
	beq	$5,$11,$L2770
	nop

$L2723:
	addiu	$3,$6,32
$L2775:
	b	$L2726
	sltu	$5,$5,1

$L2740:
	slt	$6,$3,$4
	beq	$6,$0,$L2741
	nop

	slt	$4,$3,$5
	movz	$5,$3,$4
	b	$L2741
	move	$4,$5

$L2738:
	slt	$6,$5,$2
	beq	$6,$0,$L2739
	nop

	slt	$2,$5,$4
	movz	$4,$5,$2
	b	$L2739
	move	$2,$4

$L2729:
	bne	$5,$6,$L2735
	nop

	beq	$4,$0,$L2771
	nop

	beq	$2,$0,$L2772
	nop

	lh	$2,2($3)
	lhu	$3,0($3)
	sll	$2,$2,16
	b	$L2734
	addu	$2,$2,$3

$L2768:
	slt	$2,$4,$5
	movz	$4,$5,$2
	b	$L2739
	move	$2,$4

$L2770:
	lw	$11,6172($16)
	andi	$5,$11,0x1
	beq	$5,$0,$L2727
	nop

$L2722:
	lb	$13,9467($16)
	li	$5,-2			# 0xfffffffffffffffe
	beq	$13,$5,$L2727
	nop

	bne	$10,$0,$L2727
	nop

	lw	$5,8768($16)
	sll	$5,$5,2
	addu	$5,$12,$5
	lw	$5,0($5)
	andi	$5,$5,0x80
	beq	$5,$0,$L2727
	nop

	ori	$6,$11,0x1
	sll	$6,$6,2
	lw	$10,152($16)
	addiu	$6,$6,1
	lw	$5,6168($16)
	sra	$13,$6,2
	mul	$14,$13,$10
	sll	$5,$5,2
	addiu	$5,$5,-1
	sra	$11,$5,2
	addu	$10,$14,$11
	sll	$10,$10,2
	addu	$12,$12,$10
	lw	$10,0($12)
	andi	$11,$10,0x3000
	beq	$11,$0,$L2773
	andi	$10,$10,0x40

$L2728:
	lw	$12,9748($16)
	lw	$11,96($7)
	mul	$10,$6,$12
	sra	$6,$6,1
	addu	$12,$10,$5
	lw	$10,188($7)
	sll	$7,$12,2
	addu	$7,$11,$7
	lhu	$12,0($7)
	lw	$11,9752($16)
	sh	$12,9176($16)
	mul	$12,$6,$11
	lhu	$7,2($7)
	addu	$6,$12,$10
	sll	$7,$7,1
	sra	$5,$5,1
	sh	$7,9178($16)
	addu	$5,$6,$5
	lb	$5,0($5)
	sra	$5,$5,1
	b	$L2726
	sltu	$5,$5,1

$L2772:
	lh	$2,2($8)
	lhu	$3,9152($16)
	sll	$2,$2,16
	b	$L2734
	addu	$2,$2,$3

$L2771:
	lh	$2,2($9)
	lhu	$3,9180($16)
	sll	$2,$2,16
	b	$L2734
	addu	$2,$2,$3

$L2769:
	bne	$6,$0,$L2724
	nop

	b	$L2726
	move	$5,$0

$L2773:
	bne	$10,$0,$L2728
	nop

	b	$L2726
	move	$5,$0

	.set	macro
	.set	reorder
	.end	decode_mb_skip
	.size	decode_mb_skip, .-decode_mb_skip
	.section	.rodata.str1.4
	.align	2
$LC34:
	.ascii	"decode_cabac_mb_type failed\012\000"
	.align	2
$LC35:
	.ascii	"cabac decode of qscale diff failed at %d %d\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_mb_cabac
	.type	decode_mb_cabac, @function
decode_mb_cabac:
	.frame	$sp,224,$31		# vars= 144, regs= 10/0, args= 32, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-224
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,220($sp)
	sw	$fp,216($sp)
	sw	$23,212($sp)
	sw	$22,208($sp)
	sw	$21,204($sp)
	sw	$20,200($sp)
	sw	$19,196($sp)
	sw	$18,192($sp)
	sw	$17,188($sp)
	sw	$16,184($sp)
	.cprestore	32
	lw	$18,152($4)
	lw	$3,6172($4)
	move	$16,$4
	mul	$5,$18,$3
	li	$17,131072			# 0x20000
	lw	$6,11868($16)
	ori	$17,$17,0x1ad8
	lw	$2,6168($4)
	lw	$25,2180($4)
	addu	$17,$4,$17
	li	$19,65536			# 0x10000
	move	$4,$17
	sw	$6,76($sp)
	addu	$19,$16,$19
	jalr	$25
	addu	$18,$5,$2

	lw	$4,-6284($19)
	li	$2,1			# 0x1
	beq	$4,$2,$L2777
	lw	$28,32($sp)

	li	$2,5			# 0x5
	beq	$4,$2,$L2777
	nop

	lw	$3,-6276($19)
	beq	$3,$0,$L2780
	nop

	lw	$2,6168($16)
	bne	$2,$0,$L2785
	nop

	lw	$2,6172($16)
	andi	$4,$2,0x1
	beq	$4,$0,$L2783
	li	$7,1			# 0x1

$L2784:
	lw	$4,8748($16)
	beq	$4,$0,$L2787
	li	$10,-2			# 0xfffffffffffffffe

	lw	$2,8752($16)
$L2788:
	beq	$2,$0,$L2779
	nop

	beq	$3,$0,$L2801
	nop

	lw	$2,6172($16)
	andi	$2,$2,0x1
	beq	$2,$0,$L3174
	sll	$2,$18,2

$L2801:
	.option	pic0
	jal	decode_mb_skip
	.option	pic2
	move	$4,$16

	li	$2,131072			# 0x20000
	addu	$16,$16,$2
	lw	$4,8660($16)
	lw	$3,8676($16)
	sll	$2,$18,1
	addu	$2,$4,$2
	addu	$18,$3,$18
	sh	$0,0($2)
	sb	$0,0($18)
	lw	$31,220($sp)
	sw	$0,8680($16)
	move	$2,$0
	lw	$fp,216($sp)
	lw	$23,212($sp)
	lw	$22,208($sp)
	lw	$21,204($sp)
	lw	$20,200($sp)
	lw	$19,196($sp)
	lw	$18,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	j	$31
	addiu	$sp,$sp,224

$L2777:
	lw	$3,-6276($19)
$L2779:
	beq	$3,$0,$L2821
	li	$3,65536			# 0x10000

	lw	$2,6172($16)
	andi	$3,$2,0x1
	beq	$3,$0,$L3175
	li	$3,-2			# 0xfffffffffffffffe

$L2822:
	lw	$3,152($16)
	lw	$6,6168($16)
	mul	$7,$3,$2
	li	$5,65536			# 0x10000
	addu	$5,$16,$5
	addu	$4,$7,$6
	lw	$7,-6276($5)
	addiu	$8,$4,-1
	subu	$4,$4,$3
	sw	$8,8768($16)
	sw	$0,8748($16)
	beq	$7,$0,$L2826
	sw	$4,8764($16)

	li	$7,-2			# 0xfffffffffffffffe
	and	$7,$2,$7
	mul	$8,$7,$3
	lw	$7,1568($16)
	addu	$6,$8,$6
	addiu	$8,$6,-1
	subu	$6,$6,$3
	sll	$6,$6,2
	lw	$5,-6272($5)
	sll	$9,$8,2
	addu	$9,$7,$9
	addu	$7,$7,$6
	andi	$6,$2,0x1
	lw	$7,0($7)
	lw	$2,0($9)
	beq	$6,$0,$L2827
	sltu	$5,$5,1

	xori	$6,$5,0x1
$L2828:
	beq	$6,$0,$L2830
	subu	$4,$4,$3

	sw	$4,8764($16)
$L2830:
	srl	$2,$2,7
	xori	$2,$2,0x1
	andi	$2,$2,0x1
	beq	$2,$5,$L3235
	li	$2,65536			# 0x10000

	sw	$8,8768($16)
$L2826:
	li	$2,65536			# 0x10000
$L3235:
	addu	$2,$16,$2
	lw	$19,-6284($2)
	li	$3,1			# 0x1
	beq	$19,$3,$L3176
	li	$3,2			# 0x2

	bne	$19,$3,$L2833
	li	$20,131072			# 0x20000

	ori	$21,$20,0x1fd8
	addu	$21,$16,$21
	ori	$5,$20,0x2012
	addu	$5,$16,$5
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$21

	bne	$2,$0,$L2834
	ori	$5,$20,0x2013

	addu	$5,$16,$5
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$21

	bne	$2,$0,$L2835
	move	$4,$21

	ori	$5,$20,0x2014
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	addu	$5,$16,$5

	sll	$19,$2,1
	lw	$28,32($sp)
	b	$L2832
	addu	$2,$19,$2

$L2821:
	lw	$4,8500($16)
	xori	$4,$4,0x3
	addu	$3,$16,$3
	sltu	$4,$0,$4
	lw	$2,6172($16)
	b	$L2822
	sw	$4,-6272($3)

$L2827:
	bne	$5,$0,$L2830
	srl	$6,$7,7

	b	$L2828
	andi	$6,$6,0x1

$L2834:
	move	$4,$16
	li	$5,17			# 0x11
	.option	pic0
	jal	decode_cabac_intra_mb_type
	.option	pic2
	move	$6,$0

	lw	$28,32($sp)
	addiu	$2,$2,5
$L2832:
	bltz	$2,$L3147
	sw	$2,40($sp)

$L2847:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$3,-6284($3)
	li	$4,3			# 0x3
	beq	$3,$4,$L3177
	li	$4,2			# 0x2

	beq	$3,$4,$L2852
	lw	$8,40($sp)

	move	$2,$8
$L2851:
	lui	$3,%hi(i_mb_type_info)
	addiu	$3,$3,%lo(i_mb_type_info)
	sll	$2,$2,2
	sll	$8,$8,2
	addu	$2,$2,$3
	addu	$8,$8,$3
	lbu	$4,2($2)
	lhu	$3,0($8)
	lbu	$2,3($2)
	sw	$4,8760($16)
	sw	$2,72($sp)
	sw	$3,40($sp)
	move	$19,$0
$L2850:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,-6272($2)
	beq	$2,$0,$L3236
	li	$9,65536			# 0x10000

	ori	$3,$3,0x80
	sw	$3,40($sp)
$L3236:
	addu	$2,$16,$9
	lw	$3,-6288($2)
	lw	$4,-6296($2)
	addu	$3,$3,$18
	sb	$4,0($3)
	lw	$5,40($sp)
	andi	$3,$5,0x4
	beq	$3,$0,$L2855
	ori	$12,$9,0xdbc

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lw	$3,8152($2)
	lw	$2,8168($2)
	andi	$5,$3,0x1
	addiu	$4,$2,-1
	movn	$2,$4,$5
	andi	$3,$3,0x1ff
	addiu	$4,$2,-1
	movn	$2,$4,$3
	ori	$11,$9,0xd6c
	ori	$10,$9,0xd7c
	move	$3,$2
	move	$5,$0
	ori	$9,$9,0xdac
	li	$14,16			# 0x10
$L2858:
	srl	$6,$5,2
	srl	$4,$5,3
	andi	$6,$6,0x1
	sll	$4,$4,2
	addu	$4,$6,$4
	sll	$4,$4,3
	andi	$6,$5,0x3
	addu	$4,$4,$6
	sll	$4,$4,2
	addu	$6,$4,$11
	lbu	$7,0($3)
	sll	$6,$6,1
	addiu	$8,$4,1
	addu	$6,$16,$6
	sh	$7,0($6)
	addu	$6,$8,$11
	lbu	$13,1($3)
	sll	$6,$6,1
	addiu	$7,$4,2
	addu	$6,$16,$6
	sh	$13,0($6)
	addu	$13,$7,$11
	lbu	$15,2($3)
	sll	$13,$13,1
	addiu	$6,$4,3
	addu	$13,$16,$13
	sh	$15,0($13)
	addu	$13,$6,$11
	lbu	$15,3($3)
	sll	$13,$13,1
	addu	$13,$16,$13
	sh	$15,0($13)
	addu	$13,$4,$10
	lbu	$15,4($3)
	sll	$13,$13,1
	addu	$13,$16,$13
	sh	$15,0($13)
	addu	$13,$8,$10
	lbu	$15,5($3)
	sll	$13,$13,1
	addu	$13,$16,$13
	sh	$15,0($13)
	addu	$13,$7,$10
	lbu	$15,6($3)
	sll	$13,$13,1
	addu	$13,$16,$13
	sh	$15,0($13)
	addu	$13,$6,$10
	lbu	$15,7($3)
	sll	$13,$13,1
	addu	$13,$16,$13
	sh	$15,0($13)
	addu	$13,$4,$9
	lbu	$15,8($3)
	sll	$13,$13,1
	addu	$13,$16,$13
	sh	$15,0($13)
	addu	$13,$8,$9
	lbu	$15,9($3)
	sll	$13,$13,1
	addu	$13,$16,$13
	sh	$15,0($13)
	addu	$13,$7,$9
	lbu	$15,10($3)
	sll	$13,$13,1
	addu	$13,$16,$13
	sh	$15,0($13)
	addu	$13,$6,$9
	lbu	$15,11($3)
	sll	$13,$13,1
	addu	$13,$16,$13
	sh	$15,0($13)
	addu	$4,$4,$12
	lbu	$13,12($3)
	sll	$4,$4,1
	addu	$4,$16,$4
	sh	$13,0($4)
	addu	$8,$8,$12
	lbu	$4,13($3)
	sll	$8,$8,1
	addu	$8,$16,$8
	sh	$4,0($8)
	addu	$7,$7,$12
	lbu	$4,14($3)
	sll	$7,$7,1
	addu	$7,$16,$7
	sh	$4,0($7)
	addu	$6,$6,$12
	lbu	$4,15($3)
	sll	$6,$6,1
	addu	$6,$16,$6
	addiu	$5,$5,1
	sh	$4,0($6)
	bne	$5,$14,$L2858
	addiu	$3,$3,16

	lbu	$4,256($2)
	li	$3,131072			# 0x20000
	addu	$17,$16,$3
	sh	$4,7384($17)
	lbu	$4,257($2)
	addiu	$5,$2,384
	sh	$4,7386($17)
	lbu	$4,258($2)
	lw	$25,%call16(ff_init_cabac_decoder)($28)
	sh	$4,7388($17)
	lbu	$6,259($2)
	ori	$4,$3,0x1fd8
	sh	$6,7390($17)
	lbu	$3,260($2)
	addu	$4,$16,$4
	sh	$3,7416($17)
	lbu	$3,261($2)
	sh	$3,7418($17)
	lbu	$3,262($2)
	sh	$3,7420($17)
	lbu	$3,263($2)
	sh	$3,7422($17)
	lbu	$3,264($2)
	sh	$3,7392($17)
	lbu	$3,265($2)
	sh	$3,7394($17)
	lbu	$3,266($2)
	sh	$3,7396($17)
	lbu	$3,267($2)
	sh	$3,7398($17)
	lbu	$3,268($2)
	sh	$3,7424($17)
	lbu	$3,269($2)
	sh	$3,7426($17)
	lbu	$3,270($2)
	sh	$3,7428($17)
	lbu	$3,271($2)
	sh	$3,7430($17)
	lbu	$3,272($2)
	sh	$3,7400($17)
	lbu	$3,273($2)
	sh	$3,7402($17)
	lbu	$3,274($2)
	sh	$3,7404($17)
	lbu	$3,275($2)
	sh	$3,7406($17)
	lbu	$3,276($2)
	sh	$3,7432($17)
	lbu	$3,277($2)
	sh	$3,7434($17)
	lbu	$3,278($2)
	sh	$3,7436($17)
	lbu	$3,279($2)
	sh	$3,7438($17)
	lbu	$3,280($2)
	sh	$3,7408($17)
	lbu	$3,281($2)
	sh	$3,7410($17)
	lbu	$3,282($2)
	sh	$3,7412($17)
	lbu	$3,283($2)
	sh	$3,7414($17)
	lbu	$3,284($2)
	sh	$3,7440($17)
	lbu	$3,285($2)
	sh	$3,7442($17)
	lbu	$3,286($2)
	sh	$3,7444($17)
	lbu	$3,287($2)
	sh	$3,7446($17)
	lbu	$3,288($2)
	sh	$3,7448($17)
	lbu	$3,289($2)
	sh	$3,7450($17)
	lbu	$3,290($2)
	sh	$3,7452($17)
	lbu	$3,291($2)
	sh	$3,7454($17)
	lbu	$3,292($2)
	sh	$3,7480($17)
	lbu	$3,293($2)
	sh	$3,7482($17)
	lbu	$3,294($2)
	sh	$3,7484($17)
	lbu	$3,295($2)
	sh	$3,7486($17)
	lbu	$3,296($2)
	sh	$3,7456($17)
	lbu	$3,297($2)
	sh	$3,7458($17)
	lbu	$3,298($2)
	sh	$3,7460($17)
	lbu	$3,299($2)
	sh	$3,7462($17)
	lbu	$3,300($2)
	sh	$3,7488($17)
	lbu	$3,301($2)
	sh	$3,7490($17)
	lbu	$3,302($2)
	sh	$3,7492($17)
	lbu	$3,303($2)
	sh	$3,7494($17)
	lbu	$3,304($2)
	sh	$3,7464($17)
	lbu	$3,305($2)
	sh	$3,7466($17)
	lbu	$3,306($2)
	sh	$3,7468($17)
	lbu	$3,307($2)
	sh	$3,7470($17)
	lbu	$3,308($2)
	sh	$3,7496($17)
	lbu	$3,309($2)
	sh	$3,7498($17)
	lbu	$3,310($2)
	sh	$3,7500($17)
	lbu	$3,311($2)
	sh	$3,7502($17)
	lbu	$3,312($2)
	sh	$3,7472($17)
	lbu	$3,313($2)
	sh	$3,7474($17)
	lbu	$3,314($2)
	sh	$3,7476($17)
	lbu	$3,315($2)
	sh	$3,7478($17)
	lbu	$3,316($2)
	sh	$3,7504($17)
	lbu	$3,317($2)
	sh	$3,7506($17)
	lbu	$3,318($2)
	sh	$3,7508($17)
	lbu	$3,319($2)
	sh	$3,7510($17)
	lbu	$3,320($2)
	sh	$3,7512($17)
	lbu	$3,321($2)
	sh	$3,7514($17)
	lbu	$3,322($2)
	sh	$3,7516($17)
	lbu	$3,323($2)
	sh	$3,7518($17)
	lbu	$3,324($2)
	sh	$3,7544($17)
	lbu	$3,325($2)
	sh	$3,7546($17)
	lbu	$3,326($2)
	sh	$3,7548($17)
	lbu	$3,327($2)
	sh	$3,7550($17)
	lbu	$3,328($2)
	sh	$3,7520($17)
	lbu	$3,329($2)
	sh	$3,7522($17)
	lbu	$3,330($2)
	sh	$3,7524($17)
	lbu	$3,331($2)
	sh	$3,7526($17)
	lbu	$3,332($2)
	sh	$3,7552($17)
	lbu	$3,333($2)
	sh	$3,7554($17)
	lbu	$3,334($2)
	sh	$3,7556($17)
	lbu	$3,335($2)
	sh	$3,7558($17)
	lbu	$3,336($2)
	sh	$3,7528($17)
	lbu	$3,337($2)
	sh	$3,7530($17)
	lbu	$3,338($2)
	sh	$3,7532($17)
	lbu	$3,339($2)
	sh	$3,7534($17)
	lbu	$3,340($2)
	sh	$3,7560($17)
	lbu	$3,341($2)
	sh	$3,7562($17)
	lbu	$3,342($2)
	sh	$3,7564($17)
	lbu	$3,343($2)
	sh	$3,7566($17)
	lbu	$3,344($2)
	sh	$3,7536($17)
	lbu	$3,345($2)
	sh	$3,7538($17)
	lbu	$3,346($2)
	sh	$3,7540($17)
	lbu	$3,347($2)
	sh	$3,7542($17)
	lbu	$3,348($2)
	sh	$3,7568($17)
	lbu	$3,349($2)
	sh	$3,7570($17)
	lbu	$3,350($2)
	sh	$3,7572($17)
	lbu	$3,351($2)
	sh	$3,7574($17)
	lbu	$3,352($2)
	sh	$3,7576($17)
	lbu	$3,353($2)
	sh	$3,7578($17)
	lbu	$3,354($2)
	sh	$3,7580($17)
	lbu	$3,355($2)
	sh	$3,7582($17)
	lbu	$3,356($2)
	sh	$3,7608($17)
	lbu	$3,357($2)
	sh	$3,7610($17)
	lbu	$3,358($2)
	sh	$3,7612($17)
	lbu	$3,359($2)
	sh	$3,7614($17)
	lbu	$3,360($2)
	sh	$3,7584($17)
	lbu	$3,361($2)
	sh	$3,7586($17)
	lbu	$3,362($2)
	sh	$3,7588($17)
	lbu	$3,363($2)
	sh	$3,7590($17)
	lbu	$3,364($2)
	sh	$3,7616($17)
	lbu	$3,365($2)
	sh	$3,7618($17)
	lbu	$3,366($2)
	sh	$3,7620($17)
	lbu	$3,367($2)
	sh	$3,7622($17)
	lbu	$3,368($2)
	sh	$3,7592($17)
	lbu	$3,369($2)
	sh	$3,7594($17)
	lbu	$3,370($2)
	sh	$3,7596($17)
	lbu	$3,371($2)
	sh	$3,7598($17)
	lbu	$3,372($2)
	sh	$3,7624($17)
	lbu	$3,373($2)
	sh	$3,7626($17)
	lbu	$3,374($2)
	sh	$3,7628($17)
	lbu	$3,375($2)
	lw	$6,8172($17)
	sh	$3,7630($17)
	lbu	$3,376($2)
	subu	$6,$6,$5
	sh	$3,7600($17)
	lbu	$3,377($2)
	sh	$3,7602($17)
	lbu	$3,378($2)
	sh	$3,7604($17)
	lbu	$3,379($2)
	sh	$3,7606($17)
	lbu	$3,380($2)
	sh	$3,7632($17)
	lbu	$3,381($2)
	sh	$3,7634($17)
	lbu	$3,382($2)
	sh	$3,7636($17)
	lbu	$2,383($2)
	jalr	$25
	sh	$2,7638($17)

	lw	$4,8660($17)
	lw	$2,8676($17)
	sll	$3,$18,1
	addu	$3,$4,$3
	addu	$2,$2,$18
	li	$4,495			# 0x1ef
	sh	$4,0($3)
	lw	$28,32($sp)
	sb	$0,0($2)
	lw	$2,1548($16)
	lw	$25,%call16(memset)($28)
	addu	$2,$2,$18
	sb	$0,0($2)
	lbu	$5,12096($16)
	lbu	$3,12352($16)
	lw	$4,9128($16)
	sll	$2,$18,4
	sw	$5,8740($16)
	sw	$3,8744($16)
	addu	$4,$4,$2
	li	$5,16			# 0x10
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,1568($16)
	sll	$18,$18,2
	addu	$18,$2,$18
	lw	$2,40($sp)
	sw	$2,0($18)
	move	$2,$0
$L2820:
	lw	$31,220($sp)
	lw	$fp,216($sp)
	lw	$23,212($sp)
	lw	$22,208($sp)
	lw	$21,204($sp)
	lw	$20,200($sp)
	lw	$19,196($sp)
	lw	$18,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	j	$31
	addiu	$sp,$sp,224

$L2855:
	lw	$3,-6268($2)
	beq	$3,$0,$L3237
	move	$4,$16

	lw	$3,5936($2)
	lw	$4,5940($2)
	sll	$3,$3,1
	sll	$4,$4,1
	sw	$4,5940($2)
	sw	$3,5936($2)
	move	$4,$16
$L3237:
	.option	pic0
	jal	fill_caches
	.option	pic2
	move	$6,$0

	lw	$8,40($sp)
	andi	$2,$8,0x7
	beq	$2,$0,$L2860
	lw	$28,32($sp)

	andi	$8,$8,0x1
	beq	$8,$0,$L2861
	lw	$9,76($sp)

	bne	$9,$0,$L2862
	nop

$L2864:
	lw	$3,%got(ff_h264_mlps_state)($28)
	lw	$2,%got(ff_h264_norm_shift)($28)
	lui	$8,%hi(scan8)
	lui	$31,%hi(scan8+16)
	li	$5,131072			# 0x20000
	li	$25,-65536			# 0xffffffffffff0000
	addiu	$8,$8,%lo(scan8)
	addiu	$31,$31,%lo(scan8+16)
	addiu	$3,$3,128
	addu	$5,$16,$5
	ori	$25,$25,0x1
	lw	$4,%got(ff_h264_lps_range)($28)
	li	$19,2			# 0x2
	move	$24,$2
	b	$L2863
	li	$15,7			# 0x7

$L3178:
	addiu	$8,$8,1
	beq	$8,$31,$L2873
	sb	$7,8776($9)

$L2863:
	lw	$10,8156($5)
	lbu	$12,8264($5)
	andi	$6,$10,0xc0
	sll	$6,$6,1
	addu	$6,$6,$12
	addu	$6,$4,$6
	lbu	$6,0($6)
	lw	$14,8152($5)
	subu	$10,$10,$6
	sll	$7,$10,17
	subu	$11,$7,$14
	lbu	$9,0($8)
	sra	$11,$11,31
	movn	$10,$6,$11
	addu	$9,$16,$9
	lb	$13,8775($9)
	addu	$20,$2,$10
	and	$7,$11,$7
	lb	$6,8768($9)
	subu	$7,$14,$7
	xor	$11,$11,$12
	lbu	$12,0($20)
	sw	$7,8152($5)
	sw	$10,8156($5)
	slt	$20,$13,$6
	addu	$14,$3,$11
	movn	$6,$13,$20
	sll	$7,$7,$12
	lbu	$13,0($14)
	sll	$10,$10,$12
	slt	$14,$6,0
	andi	$12,$7,0xffff
	movn	$6,$19,$14
	sb	$13,8264($5)
	sw	$10,8156($5)
	bne	$12,$0,$L2875
	sw	$7,8152($5)

	lw	$12,8168($5)
	addiu	$14,$7,-1
	xor	$14,$14,$7
	lbu	$20,0($12)
	sra	$14,$14,15
	lbu	$13,1($12)
	addu	$14,$24,$14
	sll	$20,$20,9
	lbu	$14,0($14)
	addu	$20,$20,$25
	sll	$13,$13,1
	addu	$13,$20,$13
	subu	$14,$15,$14
	sll	$13,$13,$14
	addu	$7,$13,$7
	addiu	$12,$12,2
	sw	$7,8152($5)
	sw	$12,8168($5)
$L2875:
	andi	$11,$11,0x1
	bne	$11,$0,$L3178
	move	$7,$6

	lbu	$14,8265($5)
	andi	$7,$10,0xc0
	sll	$7,$7,1
	addu	$7,$7,$14
	addu	$7,$4,$7
	lbu	$13,0($7)
	lw	$20,8152($5)
	subu	$10,$10,$13
	sll	$7,$10,17
	subu	$11,$7,$20
	sra	$11,$11,31
	movn	$10,$13,$11
	and	$7,$11,$7
	addu	$12,$2,$10
	subu	$7,$20,$7
	lbu	$13,0($12)
	xor	$14,$11,$14
	sw	$7,8152($5)
	sw	$10,8156($5)
	addu	$11,$3,$14
	sll	$7,$7,$13
	lbu	$11,0($11)
	sll	$13,$10,$13
	andi	$10,$7,0xffff
	sb	$11,8265($5)
	sw	$13,8156($5)
	bne	$10,$0,$L2878
	sw	$7,8152($5)

	lw	$10,8168($5)
	addiu	$12,$7,-1
	xor	$12,$12,$7
	lbu	$21,0($10)
	sra	$12,$12,15
	lbu	$20,1($10)
	addu	$12,$24,$12
	sll	$21,$21,9
	lbu	$12,0($12)
	addu	$21,$21,$25
	sll	$20,$20,1
	addu	$20,$21,$20
	subu	$12,$15,$12
	sll	$12,$20,$12
	addu	$7,$12,$7
	addiu	$10,$10,2
	sw	$7,8152($5)
	sw	$10,8168($5)
$L2878:
	andi	$7,$13,0xc0
	sll	$7,$7,1
	addu	$7,$7,$11
	addu	$7,$4,$7
	lbu	$12,0($7)
	lw	$20,8152($5)
	subu	$10,$13,$12
	sll	$7,$10,17
	subu	$13,$7,$20
	sra	$13,$13,31
	movn	$10,$12,$13
	and	$7,$13,$7
	addu	$12,$2,$10
	subu	$7,$20,$7
	lbu	$12,0($12)
	xor	$13,$13,$11
	sw	$7,8152($5)
	sw	$10,8156($5)
	addu	$11,$3,$13
	sll	$7,$7,$12
	lbu	$11,0($11)
	sll	$12,$10,$12
	andi	$10,$7,0xffff
	sb	$11,8265($5)
	sw	$12,8156($5)
	bne	$10,$0,$L2879
	sw	$7,8152($5)

	lw	$10,8168($5)
	addiu	$20,$7,-1
	xor	$20,$20,$7
	lbu	$22,0($10)
	sra	$20,$20,15
	lbu	$21,1($10)
	addu	$20,$24,$20
	sll	$22,$22,9
	lbu	$20,0($20)
	addu	$22,$22,$25
	sll	$21,$21,1
	addu	$21,$22,$21
	subu	$20,$15,$20
	sll	$20,$21,$20
	addu	$7,$20,$7
	addiu	$10,$10,2
	sw	$7,8152($5)
	sw	$10,8168($5)
$L2879:
	andi	$7,$12,0xc0
	sll	$7,$7,1
	addu	$7,$7,$11
	addu	$7,$4,$7
	lbu	$21,0($7)
	lw	$20,8152($5)
	subu	$10,$12,$21
	sll	$7,$10,17
	subu	$12,$7,$20
	sra	$12,$12,31
	movn	$10,$21,$12
	addu	$21,$2,$10
	and	$7,$12,$7
	subu	$7,$20,$7
	xor	$12,$12,$11
	lbu	$11,0($21)
	sw	$7,8152($5)
	sw	$10,8156($5)
	addu	$20,$3,$12
	lbu	$21,0($20)
	sll	$7,$7,$11
	sll	$10,$10,$11
	andi	$20,$7,0xffff
	sb	$21,8265($5)
	sw	$10,8156($5)
	bne	$20,$0,$L2880
	sw	$7,8152($5)

	lw	$10,8168($5)
	addiu	$11,$7,-1
	xor	$11,$11,$7
	lbu	$21,0($10)
	sra	$11,$11,15
	lbu	$20,1($10)
	addu	$11,$24,$11
	sll	$21,$21,9
	lbu	$11,0($11)
	addu	$21,$21,$25
	sll	$20,$20,1
	addu	$20,$21,$20
	subu	$11,$15,$11
	sll	$11,$20,$11
	addu	$7,$11,$7
	addiu	$10,$10,2
	sw	$7,8152($5)
	sw	$10,8168($5)
$L2880:
	andi	$7,$13,0x1
	sll	$7,$7,1
	andi	$14,$14,0x1
	andi	$12,$12,0x1
	addu	$7,$7,$14
	sll	$12,$12,2
	addu	$7,$7,$12
	slt	$6,$7,$6
	addiu	$10,$7,1
	movz	$7,$10,$6
	addiu	$8,$8,1
	bne	$8,$31,$L2863
	sb	$7,8776($9)

$L2873:
	lw	$2,6172($16)
$L3227:
	lw	$5,152($16)
	lw	$4,6168($16)
	mul	$6,$5,$2
	lw	$3,8816($16)
	addu	$2,$6,$4
	sll	$2,$2,3
	lbu	$4,8791($16)
	addu	$3,$3,$2
	sb	$4,0($3)
	lw	$3,8816($16)
	lbu	$4,8799($16)
	addu	$3,$3,$2
	sb	$4,1($3)
	lw	$3,8816($16)
	lbu	$4,8807($16)
	addu	$3,$3,$2
	sb	$4,2($3)
	lw	$3,8816($16)
	lbu	$4,8815($16)
	addu	$3,$3,$2
	sb	$4,3($3)
	lw	$3,8816($16)
	lbu	$4,8812($16)
	addu	$3,$3,$2
	sb	$4,4($3)
	lw	$3,8816($16)
	lbu	$4,8813($16)
	addu	$3,$3,$2
	sb	$4,5($3)
	lw	$4,8816($16)
	lbu	$3,8814($16)
	addu	$2,$4,$2
	sb	$3,6($2)
	lw	$2,8984($16)
	andi	$2,$2,0x8000
	bne	$2,$0,$L2881
	lui	$2,%hi(top.10290)

	lb	$3,8788($16)
	addiu	$2,$2,%lo(top.10290)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L2882
	move	$7,$3

	bne	$3,$0,$L3179
	nop

$L2883:
	lb	$3,8789($16)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L2882
	move	$7,$3

	bne	$3,$0,$L3180
	nop

$L2884:
	lb	$3,8790($16)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L2882
	move	$7,$3

	bne	$3,$0,$L3181
	nop

$L2885:
	lb	$3,8791($16)
	addu	$2,$2,$3
	lb	$2,0($2)
	bltz	$2,$L2882
	move	$7,$2

	bne	$2,$0,$L3182
	nop

$L2881:
	lw	$2,8992($16)
	andi	$2,$2,0x8000
	bne	$2,$0,$L2887
	lui	$2,%hi(left.10291)

	lb	$3,8788($16)
	addiu	$2,$2,%lo(left.10291)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L2888
	move	$7,$3

	bne	$3,$0,$L3183
	nop

$L2889:
	lb	$3,8796($16)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L2888
	move	$7,$3

	bne	$3,$0,$L3184
	nop

$L2890:
	lb	$3,8804($16)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L2888
	move	$7,$3

	bne	$3,$0,$L3185
	nop

$L2891:
	lb	$3,8812($16)
	addu	$2,$2,$3
	lb	$2,0($2)
	bltz	$2,$L2888
	move	$7,$2

	beq	$2,$0,$L2887
	nop

	sb	$2,8812($16)
$L2887:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$5,-6288($3)
	lw	$2,8768($16)
	lw	$4,-6296($3)
	addu	$3,$5,$2
	lbu	$6,0($3)
	li	$3,131072			# 0x20000
	addu	$3,$16,$3
	lw	$19,8676($3)
	beq	$6,$4,$L2894
	lw	$3,8764($16)

	move	$2,$0
$L2895:
	addu	$5,$5,$3
	lbu	$5,0($5)
	bne	$4,$5,$L3238
	li	$21,131072			# 0x20000

	addu	$3,$19,$3
	lbu	$4,0($3)
	addiu	$3,$2,1
	movn	$2,$3,$4
$L3238:
	ori	$5,$21,0x2040
	addu	$2,$2,$5
	ori	$20,$21,0x1fd8
	addu	$5,$16,$2
	addu	$20,$16,$20
	addiu	$5,$5,4
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$20

	bne	$2,$0,$L2897
	move	$3,$0

	move	$5,$0
$L2898:
	addu	$19,$19,$18
	sb	$3,0($19)
	.option	pic0
	jal	check_intra_pred_mode
	.option	pic2
	move	$4,$16

	bltz	$2,$L2893
	nop

	sw	$2,8756($16)
	lw	$8,40($sp)
$L2901:
	andi	$2,$8,0x78
$L3225:
	bne	$2,$0,$L3186
	li	$2,131072			# 0x20000

$L3067:
	andi	$2,$8,0x2
	beq	$2,$0,$L3187
	li	$2,65536			# 0x10000

$L3068:
	li	$3,131072			# 0x20000
	addu	$2,$16,$3
	lw	$25,72($sp)
	lw	$5,8660($2)
	sll	$4,$18,1
	sw	$25,8664($2)
	lw	$2,76($sp)
	addu	$4,$5,$4
	beq	$2,$0,$L3087
	sh	$25,0($4)

	andi	$2,$25,0xf
	beq	$2,$0,$L3087
	andi	$2,$8,0x7

	beq	$2,$0,$L3188
	ori	$2,$3,0x218f

$L3088:
	lw	$3,1568($16)
	sll	$2,$18,2
	addu	$2,$3,$2
	sw	$8,0($2)
$L3168:
	lw	$2,40($sp)
	andi	$2,$2,0x80
$L3239:
	beq	$2,$0,$L3093
	nop

	lw	$2,2056($16)
	beq	$2,$0,$L3094
	li	$2,131072			# 0x20000

	li	$20,131072			# 0x20000
	ori	$19,$20,0x23f4
	lui	$21,%hi(luma_dc_field_scan)
	ori	$20,$20,0x2404
	addu	$20,$16,$20
	addu	$19,$16,$19
	b	$L3249
	addiu	$21,$21,%lo(luma_dc_field_scan)

$L3177:
	slt	$3,$2,23
	beq	$3,$0,$L2849
	lui	$3,%hi(b_mb_type_info)

	sll	$2,$2,2
	addiu	$3,$3,%lo(b_mb_type_info)
$L3164:
	addu	$2,$2,$3
	lhu	$3,0($2)
	lbu	$19,2($2)
	sw	$3,40($sp)
	b	$L2850
	sw	$0,72($sp)

$L2783:
	.option	pic0
	jal	predict_field_decoding_flag
	.option	pic2
	move	$4,$16

	lw	$3,-6276($19)
	bne	$3,$0,$L2785
	lw	$28,32($sp)

	lw	$4,-6284($19)
$L2780:
	lw	$2,152($16)
	lw	$5,6172($16)
	lw	$3,6168($16)
	mul	$6,$2,$5
	li	$5,65536			# 0x10000
	addu	$5,$16,$5
	addu	$3,$6,$3
	lw	$6,-6288($5)
	subu	$2,$3,$2
	addiu	$3,$3,-1
	addu	$8,$6,$3
	addu	$6,$6,$2
	lbu	$7,0($6)
	lw	$5,-6296($5)
	lbu	$6,0($8)
$L2789:
	beq	$5,$6,$L2796
	nop

$L3194:
	beq	$5,$7,$L3189
	move	$3,$0

$L2798:
	xori	$4,$4,0x3
	addiu	$5,$3,13
	li	$2,131072			# 0x20000
	movz	$3,$5,$4
	ori	$5,$2,0x200b
	addu	$3,$3,$5
	addu	$5,$16,$3
	ori	$2,$2,0x1fd8
	addu	$4,$16,$2
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	addiu	$5,$5,4

	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$28,32($sp)
	b	$L2788
	lw	$3,-6276($3)

$L2860:
	li	$2,4			# 0x4
	beq	$19,$2,$L3190
	andi	$2,$8,0x100

	bne	$2,$0,$L3191
	andi	$2,$8,0x8

	beq	$2,$0,$L3021
	andi	$2,$8,0x10

	li	$22,65536			# 0x10000
	addu	$3,$16,$22
	lw	$2,5944($3)
	beq	$2,$0,$L2901
	nop

	ori	$22,$22,0x1730
	addu	$22,$16,$22
	addiu	$23,$16,9456
	move	$20,$0
	move	$19,$0
	li	$fp,4096			# 0x1000
	li	$21,-1			# 0xffffffffffffffff
$L3027:
	sll	$4,$20,3
	sll	$2,$20,5
	addu	$2,$4,$2
	sll	$4,$19,1
	sll	$4,$fp,$4
	addiu	$2,$2,12
	and	$4,$4,$8
	beq	$4,$0,$L3022
	addu	$2,$23,$2

	lw	$7,0($22)
	move	$4,$16
	sltu	$7,$7,2
	move	$5,$19
	move	$6,$0
	bne	$7,$0,$L3024
	move	$2,$0

	.option	pic0
	jal	decode_cabac_mb_ref
	.option	pic2
	sw	$3,168($sp)

	sll	$4,$2,8
	addu	$2,$4,$2
	sll	$4,$2,16
	lw	$8,40($sp)
	lw	$3,168($sp)
	addu	$2,$2,$4
$L3024:
	sll	$4,$20,5
	sll	$20,$20,3
	addu	$4,$20,$4
	addiu	$4,$4,12
	addu	$4,$23,$4
	sw	$2,24($4)
	sw	$2,0($4)
	sw	$2,8($4)
	sw	$2,16($4)
$L3025:
	lw	$2,5944($3)
	addiu	$19,$19,1
	sltu	$4,$19,$2
	addiu	$22,$22,4
	bne	$4,$0,$L3027
	move	$20,$19

	beq	$2,$0,$L3225
	andi	$2,$8,0x78

	li	$fp,131072			# 0x20000
	ori	$fp,$fp,0x21f8
	li	$23,65536			# 0x10000
	addu	$fp,$16,$fp
	addu	$23,$16,$23
	addiu	$22,$16,9136
	move	$21,$16
	move	$20,$0
	move	$19,$0
	li	$9,4096			# 0x1000
	addiu	$10,$sp,44
	addiu	$11,$sp,48
$L3031:
	sll	$2,$19,1
	sll	$2,$9,$2
	and	$2,$2,$8
	bne	$2,$0,$L3192
	sll	$2,$20,5

	sll	$20,$20,3
	addu	$2,$20,$2
	addiu	$2,$2,12
	sll	$2,$2,2
	addu	$2,$22,$2
	sw	$0,108($2)
	sw	$0,0($2)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,12($2)
	sw	$0,32($2)
	sw	$0,36($2)
	sw	$0,40($2)
	sw	$0,44($2)
	sw	$0,64($2)
	sw	$0,68($2)
	sw	$0,72($2)
	sw	$0,76($2)
	sw	$0,96($2)
	sw	$0,100($2)
	sw	$0,104($2)
$L3030:
	lw	$2,5944($23)
	addiu	$19,$19,1
	sltu	$2,$19,$2
	addiu	$21,$21,40
	bne	$2,$0,$L3031
	move	$20,$19

	b	$L3225
	andi	$2,$8,0x78

$L2835:
	ori	$5,$20,0x2015
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	addu	$5,$16,$5

	lw	$28,32($sp)
	b	$L2832
	subu	$2,$19,$2

$L2785:
	lw	$2,6172($16)
	andi	$7,$2,0x1
	bne	$7,$0,$L2784
	li	$10,-2			# 0xfffffffffffffffe

	lw	$4,152($16)
	and	$10,$2,$10
	mul	$3,$10,$4
	lw	$11,6168($16)
	li	$5,65536			# 0x10000
	addu	$5,$16,$5
	lw	$8,-6288($5)
	addu	$10,$3,$11
	addiu	$3,$10,-1
	addu	$6,$8,$3
	lw	$9,-6272($5)
	lbu	$6,0($6)
	lw	$5,-6296($5)
$L2791:
	beq	$9,$0,$L2792
	addiu	$2,$2,-1

	bne	$7,$0,$L3193
	subu	$2,$10,$4

	addu	$7,$8,$2
	lbu	$7,0($7)
	beq	$7,$5,$L2794
	sll	$9,$2,2

$L3163:
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	bne	$5,$6,$L3194
	lw	$4,-6284($4)

$L2796:
	lw	$6,1568($16)
	sll	$3,$3,2
	addu	$3,$6,$3
	lw	$3,0($3)
	srl	$3,$3,11
	xori	$3,$3,0x1
	bne	$5,$7,$L2798
	andi	$3,$3,0x1

$L3189:
	lw	$5,1568($16)
	sll	$2,$2,2
	addu	$2,$5,$2
	lw	$5,0($2)
	addiu	$2,$3,1
	andi	$5,$5,0x800
	b	$L2798
	movz	$3,$2,$5

$L2849:
	addiu	$2,$2,-23
	b	$L2851
	move	$8,$2

$L3087:
	lw	$3,1568($16)
	sll	$2,$18,2
	addu	$2,$3,$2
	lw	$3,72($sp)
	bne	$3,$0,$L3168
	sw	$8,0($2)

	lw	$2,40($sp)
	andi	$3,$2,0x2
	bne	$3,$0,$L3239
	andi	$2,$2,0x80

	li	$4,131072			# 0x20000
	addiu	$2,$16,9080
	addiu	$3,$16,9092
	addu	$4,$16,$4
	sw	$0,9092($16)
	sw	$0,24($3)
	sw	$0,8($3)
	sw	$0,16($3)
	sb	$0,9($2)
	sb	$0,42($2)
	sb	$0,41($2)
	sb	$0,34($2)
	sb	$0,33($2)
	sb	$0,18($2)
	sb	$0,17($2)
	sb	$0,10($2)
	sw	$0,8680($4)
$L3143:
	lw	$3,1548($16)
$L3228:
	lw	$2,2056($16)
	addu	$18,$3,$18
	sb	$2,0($18)
	lw	$2,6172($16)
	lw	$5,152($16)
	lw	$4,6168($16)
	mul	$6,$5,$2
	lw	$3,9128($16)
	addu	$2,$6,$4
	sll	$2,$2,4
	lbu	$4,9095($16)
	addu	$3,$3,$2
	sb	$4,0($3)
	lw	$3,9128($16)
	lbu	$4,9103($16)
	addu	$3,$3,$2
	sb	$4,1($3)
	lw	$3,9128($16)
	lbu	$4,9111($16)
	addu	$3,$3,$2
	sb	$4,2($3)
	lw	$3,9128($16)
	lbu	$4,9119($16)
	addu	$3,$3,$2
	sb	$4,3($3)
	lw	$3,9128($16)
	lbu	$4,9116($16)
	addu	$3,$3,$2
	sb	$4,4($3)
	lw	$3,9128($16)
	lbu	$4,9117($16)
	addu	$3,$3,$2
	sb	$4,5($3)
	lw	$3,9128($16)
	lbu	$4,9118($16)
	addu	$3,$3,$2
	sb	$4,6($3)
	lw	$3,9128($16)
	lbu	$4,9097($16)
	addu	$3,$3,$2
	sb	$4,9($3)
	lw	$3,9128($16)
	lbu	$4,9098($16)
	addu	$3,$3,$2
	sb	$4,8($3)
	lw	$3,9128($16)
	lbu	$4,9090($16)
	addu	$3,$3,$2
	sb	$4,7($3)
	lw	$3,9128($16)
	lbu	$4,9121($16)
	addu	$3,$3,$2
	sb	$4,12($3)
	lw	$3,9128($16)
	lbu	$4,9122($16)
	addu	$3,$3,$2
	sb	$4,11($3)
	lw	$3,9128($16)
	lbu	$4,9114($16)
	addu	$3,$3,$2
	sb	$4,10($3)
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$3,-6276($3)
	beq	$3,$0,$L3144
	nop

	lbu	$5,9093($16)
	lbu	$7,9092($16)
	lbu	$4,9100($16)
	lbu	$3,9101($16)
	sltu	$5,$0,$5
	sll	$5,$5,1
	lbu	$6,9094($16)
	sltu	$7,$0,$7
	sltu	$4,$0,$4
	addu	$7,$7,$5
	sll	$4,$4,2
	lbu	$5,9095($16)
	sltu	$3,$0,$3
	addu	$7,$7,$4
	sll	$3,$3,3
	lbu	$4,9102($16)
	sltu	$6,$0,$6
	addu	$7,$7,$3
	sll	$6,$6,4
	lbu	$3,9103($16)
	sltu	$5,$0,$5
	addu	$7,$7,$6
	sll	$5,$5,5
	lbu	$6,9108($16)
	sltu	$4,$0,$4
	addu	$7,$7,$5
	sll	$4,$4,6
	lbu	$5,9109($16)
	sltu	$3,$0,$3
	addu	$7,$7,$4
	sll	$3,$3,7
	lbu	$4,9116($16)
	sltu	$6,$0,$6
	addu	$7,$7,$3
	sll	$6,$6,8
	lbu	$3,9117($16)
	sltu	$5,$0,$5
	addu	$7,$7,$6
	sll	$5,$5,9
	lbu	$6,9110($16)
	sltu	$4,$0,$4
	addu	$7,$7,$5
	sll	$4,$4,10
	lbu	$5,9111($16)
	sltu	$3,$0,$3
	addu	$7,$7,$4
	sll	$3,$3,11
	lbu	$4,9118($16)
	sltu	$6,$0,$6
	addu	$7,$7,$3
	sll	$6,$6,12
	lbu	$3,9119($16)
	sltu	$5,$0,$5
	sll	$5,$5,13
	addu	$6,$7,$6
	sltu	$4,$0,$4
	addu	$6,$6,$5
	sll	$4,$4,14
	sltu	$3,$0,$3
	lw	$5,9128($16)
	addu	$4,$6,$4
	sll	$3,$3,15
	addu	$2,$5,$2
	addu	$3,$3,$4
	sh	$3,14($2)
$L3144:
	li	$2,65536			# 0x10000
	addu	$16,$16,$2
	lw	$2,-6268($16)
	beq	$2,$0,$L2820
	lw	$31,220($sp)

	lw	$2,5936($16)
	lw	$3,5940($16)
	srl	$2,$2,1
	srl	$3,$3,1
	sw	$2,5936($16)
	sw	$3,5940($16)
	move	$2,$0
	lw	$fp,216($sp)
	lw	$23,212($sp)
	lw	$22,208($sp)
	lw	$21,204($sp)
	lw	$20,200($sp)
	lw	$19,196($sp)
	lw	$18,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	j	$31
	addiu	$sp,$sp,224

$L2852:
	slt	$3,$2,5
	beq	$3,$0,$L2853
	lui	$3,%hi(p_mb_type_info)

	sll	$2,$2,2
	b	$L3164
	addiu	$3,$3,%lo(p_mb_type_info)

$L2833:
	li	$3,3			# 0x3
	beq	$19,$3,$L3195
	nop

	li	$2,-1			# 0xffffffffffffffff
	sw	$2,40($sp)
$L3147:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC34)
	addiu	$6,$6,%lo($LC34)
	jalr	$25
	move	$5,$0

	b	$L2820
	li	$2,-1			# 0xffffffffffffffff

$L2792:
	mul	$7,$4,$2
	li	$5,65536			# 0x10000
	addu	$5,$16,$5
	addu	$2,$7,$11
	lw	$7,-6288($5)
	lw	$4,-6284($5)
	addu	$7,$7,$2
	lbu	$7,0($7)
	b	$L2789
	lw	$5,-6296($5)

$L3175:
	lw	$7,152($16)
	and	$2,$2,$3
	mul	$5,$2,$7
	lw	$6,6168($16)
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	addiu	$3,$6,-1
	addu	$3,$5,$3
	lw	$5,-6288($4)
	lw	$4,-6296($4)
	addu	$8,$5,$3
	lbu	$8,0($8)
	beq	$8,$4,$L2823
	sll	$3,$3,2

	move	$3,$0
$L2824:
	addiu	$2,$2,-2
	mul	$8,$2,$7
	addu	$2,$8,$6
	addu	$5,$5,$2
	lbu	$5,0($5)
	bne	$4,$5,$L2825
	nop

	lw	$4,1568($16)
	sll	$2,$2,2
	addu	$2,$4,$2
	lw	$4,0($2)
	addiu	$2,$3,1
	andi	$4,$4,0x80
	movn	$3,$2,$4
$L2825:
	li	$2,131072			# 0x20000
	ori	$5,$2,0x2046
	addu	$3,$3,$5
	addu	$5,$16,$3
	ori	$2,$2,0x1fd8
	addu	$4,$16,$2
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	addiu	$5,$5,4

	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	sw	$2,-6268($3)
	sw	$2,-6272($3)
	lw	$28,32($sp)
	b	$L2822
	lw	$2,6172($16)

$L2787:
	lw	$4,152($16)
	and	$10,$2,$10
	mul	$3,$10,$4
	lw	$11,6168($16)
	li	$9,65536			# 0x10000
	addu	$9,$16,$9
	addu	$10,$3,$11
	lw	$8,-6288($9)
	addiu	$3,$10,-1
	addu	$5,$8,$3
	lbu	$5,0($5)
	lw	$12,-6296($9)
	beq	$5,$12,$L3146
	move	$6,$5

	lw	$9,-6272($9)
	b	$L2791
	move	$5,$12

$L2853:
	addiu	$2,$2,-5
	b	$L2851
	move	$8,$2

$L3093:
	lw	$2,2056($16)
	beq	$2,$0,$L3096
	li	$2,131072			# 0x20000

	li	$20,131072			# 0x20000
	ori	$19,$20,0x2364
	lui	$21,%hi(luma_dc_zigzag_scan)
	ori	$20,$20,0x2374
	addu	$20,$16,$20
	addu	$19,$16,$19
	addiu	$21,$21,%lo(luma_dc_zigzag_scan)
$L3095:
	li	$2,131072			# 0x20000
$L3249:
	addu	$3,$16,$2
	lw	$23,8680($3)
	ori	$3,$2,0x1fd8
	addu	$3,$16,$3
	sw	$17,76($sp)
	sltu	$23,$0,$23
	move	$22,$0
	li	$fp,3			# 0x3
	move	$17,$3
	li	$6,131072			# 0x20000
$L3240:
	ori	$6,$6,0x203c
	addu	$5,$23,$6
	addu	$5,$16,$5
	addiu	$5,$5,4
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$17

	slt	$23,$23,2
	li	$7,2			# 0x2
	movz	$7,$fp,$23
	lw	$28,32($sp)
	move	$23,$7
	beq	$2,$0,$L3196
	li	$3,131072			# 0x20000

	addiu	$22,$22,1
	li	$4,103			# 0x67
	bne	$22,$4,$L3240
	li	$6,131072			# 0x20000

	li	$2,-2147483648			# 0xffffffff80000000
	addu	$3,$16,$3
	sw	$2,8680($3)
	lw	$2,6172($16)
	lui	$6,%hi($LC35)
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lw	$7,6168($16)
	addiu	$6,$6,%lo($LC35)
	sw	$2,16($sp)
$L3169:
	jalr	$25
	move	$5,$0

	lw	$31,220($sp)
	li	$2,-1			# 0xffffffffffffffff
	lw	$fp,216($sp)
	lw	$23,212($sp)
	lw	$22,208($sp)
	lw	$21,204($sp)
	lw	$20,200($sp)
	lw	$19,196($sp)
	lw	$18,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	j	$31
	addiu	$sp,$sp,224

$L3176:
	move	$4,$16
	li	$5,3			# 0x3
	.option	pic0
	jal	decode_cabac_intra_mb_type
	.option	pic2
	li	$6,1			# 0x1

	b	$L2832
	lw	$28,32($sp)

$L3174:
	lw	$8,1568($16)
	addu	$2,$8,$2
	li	$3,2048			# 0x800
	li	$6,65536			# 0x10000
	sw	$3,0($2)
	addu	$6,$16,$6
	lw	$2,6172($16)
	lw	$4,-6276($6)
	lw	$11,6168($16)
	beq	$4,$0,$L2803
	addiu	$3,$2,1

	lw	$9,152($16)
	li	$13,-2			# 0xfffffffffffffffe
	and	$13,$3,$13
	mul	$4,$13,$9
	andi	$12,$3,0x1
	addu	$13,$4,$11
	beq	$12,$0,$L3197
	addiu	$5,$13,-1

	lw	$4,-6288($6)
	addu	$3,$4,$5
	lbu	$7,0($3)
	lw	$3,-6296($6)
	beq	$7,$3,$L2806
	nop

	lw	$10,-6272($6)
$L2805:
	beq	$10,$0,$L2808
	nop

	beq	$12,$0,$L2809
	subu	$2,$13,$9

	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	lw	$3,-6296($4)
	lw	$4,-6288($4)
$L2810:
	beq	$3,$7,$L2812
	sll	$5,$5,2

	move	$5,$0
$L2813:
	addu	$4,$4,$2
	lbu	$4,0($4)
	beq	$4,$3,$L3198
	sll	$2,$2,2

$L2814:
	li	$17,65536			# 0x10000
	addu	$17,$16,$17
	lw	$3,-6284($17)
	addiu	$2,$5,13
	xori	$3,$3,0x3
	li	$19,131072			# 0x20000
	movz	$5,$2,$3
	ori	$2,$19,0x200b
	addu	$5,$5,$2
	ori	$19,$19,0x1fd8
	addu	$19,$16,$19
	addu	$5,$16,$5
	addiu	$5,$5,4
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$19

	beq	$2,$0,$L2816
	sw	$2,8752($16)

	.option	pic0
	jal	predict_field_decoding_flag
	.option	pic2
	move	$4,$16

	b	$L2801
	nop

$L3187:
	addu	$2,$16,$2
	lw	$5,-6288($2)
	lw	$3,8768($16)
	lw	$4,-6296($2)
	addu	$2,$5,$3
	lbu	$2,0($2)
	beq	$2,$4,$L3069
	li	$2,131072			# 0x20000

	move	$3,$0
	move	$2,$0
$L3070:
	lw	$6,8764($16)
	addu	$5,$5,$6
	lbu	$5,0($5)
	beq	$4,$5,$L3071
	li	$fp,8			# 0x8

$L3072:
	move	$4,$0
$L3074:
	li	$20,131072			# 0x20000
	ori	$21,$20,0x2049
	addu	$5,$4,$2
	addu	$5,$5,$21
	ori	$19,$20,0x1fd8
	addu	$19,$16,$19
	addu	$5,$16,$5
	addiu	$5,$5,4
	move	$4,$19
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	sw	$3,168($sp)

	li	$23,2			# 0x2
	move	$22,$2
	move	$5,$0
	andi	$2,$2,0x1
	movz	$5,$23,$fp
	xori	$2,$2,0x1
	addu	$5,$5,$2
	addu	$5,$5,$21
	addu	$5,$16,$5
	addiu	$5,$5,4
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$19

	sll	$2,$2,1
	or	$22,$2,$22
	lw	$3,168($sp)
	andi	$5,$22,0x1
	move	$24,$23
	movn	$24,$0,$5
	addu	$5,$24,$3
	addu	$5,$5,$21
	addu	$5,$16,$5
	addiu	$5,$5,4
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$19

	sll	$2,$2,2
	or	$22,$2,$22
	srl	$2,$22,2
	andi	$5,$22,0x2
	xori	$2,$2,0x1
	movn	$23,$0,$5
	andi	$2,$2,0x1
	addu	$5,$23,$2
	addu	$5,$5,$21
	addu	$5,$16,$5
	addiu	$5,$5,4
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$19

	addu	$3,$16,$20
	lw	$23,8672($3)
	lw	$21,8668($3)
	sra	$23,$23,4
	andi	$23,$23,0x3
	sltu	$3,$0,$23
	sra	$21,$21,4
	addiu	$4,$3,2
	andi	$21,$21,0x3
	movn	$3,$4,$21
	ori	$5,$20,0x204d
	addu	$3,$3,$5
	addu	$5,$16,$3
	addiu	$5,$5,4
	move	$4,$19
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$fp,$2

	beq	$2,$0,$L3083
	li	$4,83			# 0x53

	xori	$23,$23,0x2
	li	$3,84			# 0x54
	movn	$3,$4,$23
	li	$2,82			# 0x52
	li	$4,81			# 0x51
	movn	$2,$4,$23
	xori	$21,$21,0x2
	movz	$2,$3,$21
	ori	$20,$20,0x2000
	addu	$2,$2,$20
	addu	$5,$16,$2
	move	$4,$19
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	addiu	$5,$5,4

	addiu	$2,$2,1
	sll	$2,$2,4
$L3083:
	sll	$fp,$fp,3
	or	$22,$fp,$22
	or	$22,$22,$2
	lw	$8,40($sp)
	b	$L3068
	sw	$22,72($sp)

$L3193:
	li	$5,65536			# 0x10000
	addu	$5,$16,$5
	lw	$4,-6288($5)
	addu	$4,$4,$2
	lbu	$7,0($4)
	lw	$4,-6284($5)
	b	$L2789
	lw	$5,-6296($5)

$L3186:
	addu	$2,$16,$2
	lw	$2,8676($2)
	move	$4,$16
	addu	$2,$2,$18
	sb	$0,0($2)
	.option	pic0
	jal	write_back_motion
	.option	pic2
	lw	$5,40($sp)

	b	$L3067
	lw	$8,40($sp)

$L2861:
	lw	$5,8760($16)
	.option	pic0
	jal	check_intra_pred_mode
	.option	pic2
	move	$4,$16

	bgez	$2,$L2887
	sw	$2,8760($16)

$L2893:
	lw	$31,220($sp)
	li	$2,-1			# 0xffffffffffffffff
	lw	$fp,216($sp)
	lw	$23,212($sp)
	lw	$22,208($sp)
	lw	$21,204($sp)
	lw	$20,200($sp)
	lw	$19,196($sp)
	lw	$18,192($sp)
	lw	$17,188($sp)
	lw	$16,184($sp)
	j	$31
	addiu	$sp,$sp,224

$L3195:
	lw	$5,-6288($2)
	lw	$6,8768($16)
	lw	$4,-6296($2)
	addu	$2,$5,$6
	lbu	$2,0($2)
	beq	$2,$4,$L2837
	lw	$3,8764($16)

	move	$2,$0
$L2838:
	addu	$5,$5,$3
	lbu	$5,0($5)
	beq	$4,$5,$L3199
	sll	$3,$3,2

$L2839:
	li	$19,131072			# 0x20000
	ori	$5,$19,0x201b
	addu	$2,$2,$5
	ori	$20,$19,0x1fd8
	addu	$5,$16,$2
	addu	$20,$16,$20
	addiu	$5,$5,4
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$20

	bne	$2,$0,$L3200
	lw	$28,32($sp)

	b	$L2847
	sw	$2,40($sp)

$L3190:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,-6284($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L3201
	li	$5,131072			# 0x20000

	addu	$5,$16,$5
	lw	$3,8156($5)
	lbu	$9,8217($5)
	andi	$2,$3,0xc0
	sll	$2,$2,1
	lw	$4,%got(ff_h264_lps_range)($28)
	addu	$2,$2,$9
	addu	$2,$4,$2
	lbu	$7,0($2)
	lw	$11,8152($5)
	subu	$3,$3,$7
	sll	$6,$3,17
	subu	$8,$6,$11
	sra	$8,$8,31
	lw	$2,%got(ff_h264_norm_shift)($28)
	movz	$7,$3,$8
	lw	$3,%got(ff_h264_mlps_state)($28)
	and	$6,$8,$6
	addu	$10,$2,$7
	subu	$6,$11,$6
	lbu	$10,0($10)
	xor	$8,$8,$9
	addiu	$3,$3,128
	sw	$6,8152($5)
	sw	$7,8156($5)
	addu	$9,$3,$8
	sll	$6,$6,$10
	lbu	$9,0($9)
	sll	$10,$7,$10
	andi	$7,$6,0xffff
	sb	$9,8217($5)
	sw	$10,8156($5)
	bne	$7,$0,$L2924
	sw	$6,8152($5)

	lw	$7,8168($5)
	addiu	$12,$6,-1
	lbu	$13,0($7)
	xor	$12,$12,$6
	lbu	$9,1($7)
	sra	$12,$12,15
	li	$11,-65536			# 0xffffffffffff0000
	addu	$12,$2,$12
	sll	$13,$13,9
	ori	$11,$11,0x1
	sll	$9,$9,1
	lbu	$12,0($12)
	addu	$11,$13,$11
	addu	$11,$11,$9
	li	$9,7			# 0x7
	subu	$9,$9,$12
	sll	$9,$11,$9
	addu	$6,$9,$6
	addiu	$7,$7,2
	sw	$7,8168($5)
	sw	$6,8152($5)
$L2924:
	andi	$8,$8,0x1
	beq	$8,$0,$L3202
	move	$6,$0

$L2928:
	li	$5,131072			# 0x20000
$L3253:
	addu	$5,$16,$5
	lw	$8,8156($5)
	lui	$7,%hi(p_sub_mb_type_info)
	sll	$6,$6,2
	addiu	$7,$7,%lo(p_sub_mb_type_info)
	lbu	$12,8217($5)
	addu	$10,$7,$6
	andi	$6,$8,0xc0
	lhu	$11,0($10)
	sll	$6,$6,1
	li	$9,65536			# 0x10000
	addu	$9,$16,$9
	addu	$6,$6,$12
	sw	$11,-6264($9)
	addu	$6,$4,$6
	lbu	$11,0($6)
	lw	$13,8152($5)
	subu	$8,$8,$11
	sll	$6,$8,17
	subu	$9,$6,$13
	sra	$9,$9,31
	movn	$8,$11,$9
	and	$6,$9,$6
	addu	$11,$2,$8
	subu	$6,$13,$6
	lbu	$11,0($11)
	xor	$9,$9,$12
	sw	$6,8152($5)
	sw	$8,8156($5)
	addu	$12,$3,$9
	lbu	$12,0($12)
	sll	$6,$6,$11
	lbu	$10,2($10)
	sll	$11,$8,$11
	andi	$8,$6,0xffff
	sw	$10,52($sp)
	sb	$12,8217($5)
	sw	$11,8156($5)
	bne	$8,$0,$L2933
	sw	$6,8152($5)

	lw	$8,8168($5)
	addiu	$10,$6,-1
	xor	$10,$10,$6
	lw	$13,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($8)
	sra	$10,$10,15
	addu	$13,$13,$10
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$10,1($8)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$10,$10,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$10
	li	$10,7			# 0x7
	subu	$10,$10,$13
	sll	$10,$12,$10
	addu	$6,$10,$6
	addiu	$8,$8,2
	sw	$8,8168($5)
	sw	$6,8152($5)
$L2933:
	andi	$9,$9,0x1
	beq	$9,$0,$L3203
	move	$6,$0

$L2937:
	li	$5,131072			# 0x20000
$L3252:
	addu	$5,$16,$5
	lw	$8,8156($5)
	sll	$6,$6,2
	lbu	$12,8217($5)
	addu	$10,$7,$6
	andi	$6,$8,0xc0
	lhu	$11,0($10)
	sll	$6,$6,1
	li	$9,65536			# 0x10000
	addu	$9,$16,$9
	addu	$6,$6,$12
	sw	$11,-6260($9)
	addu	$6,$4,$6
	lbu	$11,0($6)
	lw	$13,8152($5)
	subu	$8,$8,$11
	sll	$6,$8,17
	subu	$9,$6,$13
	sra	$9,$9,31
	movn	$8,$11,$9
	and	$6,$9,$6
	addu	$11,$2,$8
	subu	$6,$13,$6
	lbu	$11,0($11)
	xor	$9,$9,$12
	sw	$6,8152($5)
	sw	$8,8156($5)
	addu	$12,$3,$9
	lbu	$12,0($12)
	sll	$6,$6,$11
	lbu	$10,2($10)
	sll	$11,$8,$11
	andi	$8,$6,0xffff
	sw	$10,56($sp)
	sb	$12,8217($5)
	sw	$11,8156($5)
	bne	$8,$0,$L2942
	sw	$6,8152($5)

	lw	$8,8168($5)
	addiu	$10,$6,-1
	xor	$10,$10,$6
	lw	$13,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($8)
	sra	$10,$10,15
	addu	$13,$13,$10
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$10,1($8)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$10,$10,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$10
	li	$10,7			# 0x7
	subu	$10,$10,$13
	sll	$10,$12,$10
	addu	$6,$10,$6
	addiu	$8,$8,2
	sw	$8,8168($5)
	sw	$6,8152($5)
$L2942:
	andi	$9,$9,0x1
	beq	$9,$0,$L3204
	move	$6,$0

$L2946:
	li	$5,131072			# 0x20000
$L3251:
	addu	$5,$16,$5
	lw	$8,8156($5)
	sll	$6,$6,2
	lbu	$12,8217($5)
	addu	$11,$7,$6
	andi	$6,$8,0xc0
	lhu	$10,0($11)
	sll	$6,$6,1
	li	$9,65536			# 0x10000
	addu	$9,$16,$9
	addu	$6,$6,$12
	sw	$10,-6256($9)
	addu	$6,$4,$6
	lbu	$10,0($6)
	lw	$13,8152($5)
	subu	$8,$8,$10
	sll	$6,$8,17
	subu	$9,$6,$13
	sra	$9,$9,31
	movn	$8,$10,$9
	and	$6,$9,$6
	addu	$10,$2,$8
	subu	$6,$13,$6
	lbu	$10,0($10)
	xor	$9,$9,$12
	sw	$6,8152($5)
	sw	$8,8156($5)
	addu	$12,$3,$9
	lbu	$12,0($12)
	sll	$6,$6,$10
	lbu	$11,2($11)
	sll	$10,$8,$10
	andi	$8,$6,0xffff
	sw	$11,60($sp)
	sb	$12,8217($5)
	sw	$10,8156($5)
	bne	$8,$0,$L2951
	sw	$6,8152($5)

	lw	$8,8168($5)
	addiu	$11,$6,-1
	xor	$11,$11,$6
	lw	$13,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($8)
	sra	$11,$11,15
	addu	$13,$13,$11
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$11,1($8)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$11,$11,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$11
	li	$11,7			# 0x7
	subu	$11,$11,$13
	sll	$11,$12,$11
	addu	$6,$11,$6
	addiu	$8,$8,2
	sw	$8,8168($5)
	sw	$6,8152($5)
$L2951:
	andi	$9,$9,0x1
	beq	$9,$0,$L2952
	li	$5,131072			# 0x20000

	move	$2,$0
$L2953:
	sll	$2,$2,2
	addu	$7,$7,$2
	lhu	$4,0($7)
	lbu	$2,2($7)
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	sw	$4,-6252($3)
	sw	$2,64($sp)
	li	$22,65536			# 0x10000
$L3226:
	addu	$23,$16,$22
$L3250:
	lw	$2,5944($23)
	beq	$2,$0,$L2960
	move	$3,$0

	ori	$22,$22,0x1730
	addu	$22,$16,$22
	move	$19,$16
	move	$21,$0
	move	$20,$0
	li	$fp,4096			# 0x1000
$L2959:
	lw	$2,-6264($23)
	andi	$3,$2,0x100
	bne	$3,$0,$L2961
	sll	$3,$fp,$21

	and	$2,$3,$2
	bne	$2,$0,$L2962
	li	$2,-1			# 0xffffffffffffffff

$L2964:
	sb	$2,9469($19)
	sb	$2,9477($19)
	sb	$2,9476($19)
$L2961:
	lw	$2,-6260($23)
	andi	$3,$2,0x100
	bne	$3,$0,$L2965
	sll	$3,$fp,$21

	and	$2,$3,$2
	bne	$2,$0,$L2966
	li	$2,-1			# 0xffffffffffffffff

$L2968:
	sb	$2,9471($19)
	sb	$2,9479($19)
	sb	$2,9478($19)
$L2965:
	lw	$2,-6256($23)
	andi	$3,$2,0x100
	bne	$3,$0,$L2969
	sll	$3,$fp,$21

	and	$2,$3,$2
	bne	$2,$0,$L2970
	li	$2,-1			# 0xffffffffffffffff

$L2972:
	sb	$2,9485($19)
	sb	$2,9493($19)
	sb	$2,9492($19)
$L2969:
	lw	$2,-6252($23)
	andi	$3,$2,0x100
	bne	$3,$0,$L2973
	sll	$3,$fp,$21

	and	$2,$3,$2
	bne	$2,$0,$L2974
	li	$2,-1			# 0xffffffffffffffff

$L2976:
	sb	$2,9487($19)
	sb	$2,9495($19)
	sb	$2,9494($19)
$L2973:
	lw	$3,5944($23)
	addiu	$20,$20,1
	sltu	$2,$20,$3
	addiu	$19,$19,40
	addiu	$21,$21,2
	bne	$2,$0,$L2959
	addiu	$22,$22,4

$L2960:
	lw	$7,76($sp)
	beq	$7,$0,$L2977
	li	$2,65536			# 0x10000

	addu	$2,$16,$2
	lw	$4,-6264($2)
	andi	$2,$4,0x8
	beq	$2,$0,$L2978
	nop

	lw	$2,9980($16)
	bne	$2,$0,$L2979
	andi	$4,$4,0x100

	bne	$4,$0,$L2978
	nop

$L2979:
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	lw	$4,-6260($4)
	andi	$5,$4,0x8
	beq	$5,$0,$L2978
	nop

	bne	$2,$0,$L2980
	andi	$4,$4,0x100

	bne	$4,$0,$L2978
	nop

$L2980:
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	lw	$4,-6256($4)
	andi	$5,$4,0x8
	beq	$5,$0,$L2978
	nop

	bne	$2,$0,$L2981
	andi	$4,$4,0x100

	bne	$4,$0,$L2978
	nop

$L2981:
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	lw	$4,-6252($4)
	andi	$5,$4,0x8
	beq	$5,$0,$L2978
	nop

	beq	$2,$0,$L2982
	li	$8,1			# 0x1

	sw	$8,76($sp)
$L2977:
	beq	$3,$0,$L2983
	li	$2,131072			# 0x20000

	ori	$2,$2,0x21f8
	addu	$2,$16,$2
	sw	$2,84($sp)
	li	$2,59272			# 0xe788
	addu	$2,$16,$2
	li	$10,65536			# 0x10000
	addiu	$9,$sp,52
	sw	$2,136($sp)
	addu	$10,$16,$10
	addiu	$fp,$16,9136
	sw	$16,112($sp)
	sw	$16,92($sp)
	move	$8,$0
	move	$23,$0
	sw	$9,140($sp)
	sw	$18,144($sp)
	sw	$17,148($sp)
$L2984:
	sll	$2,$8,2
	sll	$5,$8,4
	addu	$5,$2,$5
	sll	$3,$23,5
	addu	$2,$2,$8
	sll	$5,$5,3
	sll	$22,$23,3
	addu	$22,$22,$3
	addiu	$6,$2,-1
	addiu	$5,$5,40
	sll	$2,$23,1
	addiu	$4,$23,24
	addiu	$3,$23,46
	li	$14,12288			# 0x3000
	li	$15,4096			# 0x1000
	sll	$11,$8,3
	sll	$14,$14,$2
	sll	$8,$8,5
	sll	$6,$6,3
	addu	$5,$fp,$5
	sll	$4,$4,2
	sll	$3,$3,2
	sll	$2,$15,$2
	lui	$12,%hi(scan8)
	lw	$13,136($sp)
	addu	$11,$11,$8
	sw	$6,96($sp)
	sw	$5,104($sp)
	sw	$14,116($sp)
	addu	$22,$16,$22
	sw	$4,124($sp)
	sw	$3,128($sp)
	sw	$2,120($sp)
	addiu	$12,$12,%lo(scan8)
	move	$9,$0
	sw	$23,80($sp)
$L3019:
	lbu	$4,0($12)
	lw	$2,0($13)
	addu	$3,$22,$4
	lbu	$6,9457($3)
	andi	$5,$2,0x100
	beq	$5,$0,$L2985
	sb	$6,9456($3)

	addu	$2,$11,$4
	lw	$14,84($sp)
	sll	$2,$2,2
	addu	$2,$14,$2
	sw	$0,36($2)
	sw	$0,0($2)
	sw	$0,4($2)
	sw	$0,32($2)
$L2986:
	addiu	$9,$9,4
	li	$2,16			# 0x10
	addiu	$12,$12,4
	bne	$9,$2,$L3019
	addiu	$13,$13,4

	lw	$23,80($sp)
	lw	$9,92($sp)
	lw	$13,112($sp)
	lw	$2,5944($10)
	addiu	$23,$23,1
	addiu	$9,$9,160
	addiu	$13,$13,40
	sltu	$2,$23,$2
	sw	$9,92($sp)
	sw	$13,112($sp)
	bne	$2,$0,$L2984
	move	$8,$23

	lw	$18,144($sp)
	lw	$17,148($sp)
	b	$L2901
	lw	$8,40($sp)

$L3021:
	beq	$2,$0,$L3205
	li	$23,65536			# 0x10000

	addu	$2,$16,$23
	lw	$3,5944($2)
	beq	$3,$0,$L2901
	nop

	ori	$23,$23,0x1730
	addu	$23,$16,$23
	sw	$2,80($sp)
	addiu	$22,$16,9456
	li	$fp,1			# 0x1
	move	$20,$0
	move	$19,$0
	li	$21,-1			# 0xffffffffffffffff
$L3036:
	sll	$2,$19,1
	li	$3,4096			# 0x1000
	sll	$2,$3,$2
	and	$2,$2,$8
	bne	$2,$0,$L3039
	sll	$2,$20,5

	sll	$20,$20,3
	addu	$20,$20,$2
	addiu	$2,$20,12
	addu	$2,$22,$2
	sw	$21,8($2)
	sw	$21,0($2)
$L3040:
	li	$4,4096			# 0x1000
	sll	$2,$4,$fp
	and	$2,$2,$8
	bne	$2,$0,$L3043
	nop

	addiu	$20,$20,28
	addu	$20,$22,$20
	sw	$21,8($20)
	sw	$21,0($20)
$L3044:
	lw	$24,80($sp)
	addiu	$19,$19,1
	lw	$2,5944($24)
	addiu	$fp,$fp,2
	sltu	$3,$19,$2
	addiu	$23,$23,4
	bne	$3,$0,$L3036
	move	$20,$19

	beq	$2,$0,$L2901
	li	$2,65536			# 0x10000

	addu	$2,$16,$2
	li	$23,131072			# 0x20000
	ori	$23,$23,0x21f8
	sw	$2,88($sp)
	addiu	$25,$sp,44
	addiu	$2,$sp,48
	addu	$23,$16,$23
	addiu	$22,$16,9136
	move	$21,$16
	li	$fp,1			# 0x1
	move	$20,$0
	move	$19,$0
	sw	$25,80($sp)
	sw	$2,84($sp)
$L3038:
	sll	$2,$19,1
	li	$6,4096			# 0x1000
	sll	$2,$6,$2
	and	$2,$2,$8
	bne	$2,$0,$L3047
	sll	$2,$20,5

	sll	$20,$20,3
	addu	$20,$20,$2
	addiu	$3,$20,12
	sll	$3,$3,2
	addu	$2,$22,$3
	addu	$3,$23,$3
	sw	$0,44($3)
	sw	$0,0($3)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$0,12($3)
	sw	$0,32($3)
	sw	$0,36($3)
	sw	$0,40($3)
	sw	$0,44($2)
	sw	$0,0($2)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,12($2)
	sw	$0,32($2)
	sw	$0,36($2)
	sw	$0,40($2)
$L3048:
	li	$13,4096			# 0x1000
	sll	$2,$13,$fp
	and	$2,$2,$8
	bne	$2,$0,$L3049
	addiu	$3,$20,28

	sll	$3,$3,2
	addu	$2,$22,$3
	addu	$3,$23,$3
	sw	$0,44($3)
	sw	$0,0($3)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$0,12($3)
	sw	$0,32($3)
	sw	$0,36($3)
	sw	$0,40($3)
	sw	$0,44($2)
	sw	$0,0($2)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,12($2)
	sw	$0,32($2)
	sw	$0,36($2)
	sw	$0,40($2)
$L3050:
	lw	$5,88($sp)
	addiu	$19,$19,1
	lw	$2,5944($5)
	addiu	$21,$21,40
	sltu	$2,$19,$2
	addiu	$fp,$fp,2
	bne	$2,$0,$L3038
	move	$20,$19

	b	$L3225
	andi	$2,$8,0x78

$L3184:
	b	$L2890
	sb	$3,8796($16)

$L3185:
	b	$L2891
	sb	$3,8804($16)

$L3096:
	addu	$2,$16,$2
	lui	$21,%hi(luma_dc_zigzag_scan)
	lw	$19,9348($2)
	lw	$20,9352($2)
	b	$L3095
	addiu	$21,$21,%lo(luma_dc_zigzag_scan)

$L3094:
	addu	$2,$16,$2
	lui	$21,%hi(luma_dc_field_scan)
	lw	$19,9360($2)
	addiu	$21,$21,%lo(luma_dc_field_scan)
	b	$L3095
	lw	$20,9364($2)

$L3183:
	b	$L2889
	sb	$3,8788($16)

$L3181:
	b	$L2885
	sb	$3,8790($16)

$L3180:
	b	$L2884
	sb	$3,8789($16)

$L3179:
	b	$L2883
	sb	$3,8788($16)

$L2803:
	lw	$9,152($16)
	lw	$4,-6288($6)
	mul	$5,$3,$9
	lw	$3,-6296($6)
	addu	$2,$5,$11
	addiu	$5,$2,-1
	addu	$6,$4,$5
	lbu	$7,0($6)
	b	$L2810
	subu	$2,$2,$9

$L3182:
	b	$L2881
	sb	$2,8791($16)

$L3205:
	addu	$2,$16,$23
	lw	$3,5944($2)
	beq	$3,$0,$L2901
	nop

	ori	$23,$23,0x1730
	addu	$23,$16,$23
	sw	$2,80($sp)
	addiu	$22,$16,9456
	li	$fp,1			# 0x1
	move	$19,$0
	move	$21,$0
	li	$20,-1			# 0xffffffffffffffff
$L3052:
	sll	$2,$21,1
	li	$3,4096			# 0x1000
	sll	$2,$3,$2
	and	$2,$2,$8
	bne	$2,$0,$L3055
	sll	$3,$19,3

	sll	$2,$19,5
	addu	$2,$3,$2
	addiu	$2,$2,12
	addu	$2,$22,$2
	sh	$20,24($2)
	sh	$20,0($2)
	sh	$20,8($2)
	sh	$20,16($2)
$L3056:
	li	$4,4096			# 0x1000
	sll	$2,$4,$fp
	and	$2,$2,$8
	bne	$2,$0,$L3059
	sll	$2,$19,4

	sll	$19,$19,2
	addu	$2,$19,$2
	sll	$2,$2,1
	addiu	$2,$2,14
	addu	$2,$22,$2
	sh	$20,24($2)
	sh	$20,0($2)
	sh	$20,8($2)
	sh	$20,16($2)
$L3060:
	lw	$24,80($sp)
	addiu	$21,$21,1
	lw	$2,5944($24)
	addiu	$fp,$fp,2
	sltu	$3,$21,$2
	addiu	$23,$23,4
	bne	$3,$0,$L3052
	move	$19,$21

	beq	$2,$0,$L2901
	li	$2,65536			# 0x10000

	addu	$2,$16,$2
	li	$23,131072			# 0x20000
	ori	$23,$23,0x21f8
	sw	$2,88($sp)
	addiu	$25,$sp,44
	addiu	$2,$sp,48
	addu	$23,$16,$23
	addiu	$22,$16,9136
	move	$21,$16
	li	$fp,1			# 0x1
	move	$20,$0
	move	$19,$0
	sw	$25,80($sp)
	sw	$2,84($sp)
$L3054:
	sll	$2,$19,1
	li	$6,4096			# 0x1000
	sll	$2,$6,$2
	and	$2,$2,$8
	bne	$2,$0,$L3063
	sll	$2,$20,5

	sll	$3,$20,3
	addu	$3,$3,$2
	addiu	$3,$3,12
	sll	$3,$3,2
	addu	$2,$22,$3
	addu	$3,$23,$3
	sw	$0,100($3)
	sw	$0,0($3)
	sw	$0,4($3)
	sw	$0,32($3)
	sw	$0,36($3)
	sw	$0,64($3)
	sw	$0,68($3)
	sw	$0,96($3)
	sw	$0,100($2)
	sw	$0,0($2)
	sw	$0,4($2)
	sw	$0,32($2)
	sw	$0,36($2)
	sw	$0,64($2)
	sw	$0,68($2)
	sw	$0,96($2)
$L3064:
	li	$13,4096			# 0x1000
	sll	$2,$13,$fp
	and	$2,$2,$8
	bne	$2,$0,$L3065
	sll	$2,$20,4

	sll	$3,$20,2
	addu	$3,$3,$2
	sll	$3,$3,3
	addiu	$3,$3,56
	addu	$2,$22,$3
	addu	$3,$23,$3
	sw	$0,100($3)
	sw	$0,0($3)
	sw	$0,4($3)
	sw	$0,32($3)
	sw	$0,36($3)
	sw	$0,64($3)
	sw	$0,68($3)
	sw	$0,96($3)
	sw	$0,100($2)
	sw	$0,0($2)
	sw	$0,4($2)
	sw	$0,32($2)
	sw	$0,36($2)
	sw	$0,64($2)
	sw	$0,68($2)
	sw	$0,96($2)
$L3066:
	lw	$5,88($sp)
	addiu	$19,$19,1
	lw	$2,5944($5)
	addiu	$21,$21,40
	sltu	$2,$19,$2
	addiu	$fp,$fp,2
	bne	$2,$0,$L3054
	move	$20,$19

	b	$L3225
	andi	$2,$8,0x78

$L3069:
	addu	$2,$16,$2
	lw	$2,8672($2)
	srl	$3,$2,3
	srl	$2,$2,1
	xori	$2,$2,0x1
	xori	$3,$3,0x1
	andi	$2,$2,0x1
	b	$L3070
	andi	$3,$3,0x1

$L3200:
	ori	$5,$19,0x2022
	addu	$5,$16,$5
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$20

	beq	$2,$0,$L3206
	ori	$5,$19,0x2024

	ori	$5,$19,0x2023
	ori	$19,$19,0x2024
	addu	$19,$16,$19
	addu	$5,$16,$5
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$20

	move	$4,$20
	move	$5,$19
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	sll	$22,$2,3

	move	$4,$20
	move	$5,$19
	move	$23,$2
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	sll	$23,$23,2

	move	$4,$20
	move	$5,$19
	move	$21,$2
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	or	$22,$22,$23

	or	$22,$22,$2
	sll	$21,$21,1
	or	$21,$22,$21
	slt	$2,$21,8
	bne	$2,$0,$L3207
	lw	$28,32($sp)

	li	$2,13			# 0xd
	beq	$21,$2,$L3208
	move	$4,$16

	li	$2,14			# 0xe
	beq	$21,$2,$L3209
	li	$2,11			# 0xb

	li	$2,15			# 0xf
	beq	$21,$2,$L2846
	move	$5,$19

	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$4,$20

	sll	$19,$21,1
	or	$2,$2,$19
	lw	$28,32($sp)
	b	$L2832
	addiu	$2,$2,-4

$L2837:
	lw	$2,1568($16)
	sll	$6,$6,2
	addu	$6,$2,$6
	lw	$2,0($6)
	srl	$2,$2,8
	xori	$2,$2,0x1
	b	$L2838
	andi	$2,$2,0x1

$L3188:
	lw	$5,9544($16)
	addu	$5,$5,$2
	ori	$3,$3,0x1fd8
	addu	$5,$16,$5
	addu	$4,$16,$3
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	addiu	$5,$5,4

	bne	$2,$0,$L3089
	li	$2,16777216			# 0x1000000

	b	$L3088
	lw	$8,40($sp)

$L3201:
	lw	$3,%got(ff_h264_mlps_state)($28)
	lw	$2,%got(ff_h264_norm_shift)($28)
	li	$20,59272			# 0xe788
	addu	$20,$16,$20
	lui	$14,%hi(b_sub_mb_type_info)
	li	$8,-65536			# 0xffffffffffff0000
	lw	$4,%got(ff_h264_lps_range)($28)
	addiu	$3,$3,128
	addiu	$14,$14,%lo(b_sub_mb_type_info)
	addu	$5,$16,$5
	ori	$8,$8,0x1
	addiu	$11,$sp,52
	addiu	$13,$sp,68
	move	$12,$20
	move	$7,$2
	li	$6,7			# 0x7
$L2918:
	lw	$10,8156($5)
	lbu	$25,8232($5)
	andi	$9,$10,0xc0
	sll	$9,$9,1
	addu	$9,$9,$25
	addu	$9,$4,$9
	lbu	$24,0($9)
	lw	$19,8152($5)
	subu	$10,$10,$24
	sll	$9,$10,17
	subu	$15,$9,$19
	sra	$15,$15,31
	movn	$10,$24,$15
	and	$9,$15,$9
	addu	$24,$2,$10
	subu	$9,$19,$9
	lbu	$24,0($24)
	xor	$15,$15,$25
	sw	$9,8152($5)
	sw	$10,8156($5)
	addu	$25,$3,$15
	sll	$9,$9,$24
	lbu	$25,0($25)
	sll	$24,$10,$24
	andi	$10,$9,0xffff
	sb	$25,8232($5)
	sw	$24,8156($5)
	bne	$10,$0,$L2904
	sw	$9,8152($5)

	lw	$10,8168($5)
	addiu	$25,$9,-1
	xor	$25,$25,$9
	lbu	$21,0($10)
	sra	$25,$25,15
	lbu	$19,1($10)
	addu	$25,$7,$25
	sll	$21,$21,9
	lbu	$25,0($25)
	addu	$21,$21,$8
	sll	$19,$19,1
	addu	$19,$21,$19
	subu	$25,$6,$25
	sll	$25,$19,$25
	addu	$9,$25,$9
	addiu	$10,$10,2
	sw	$9,8152($5)
	sw	$10,8168($5)
$L2904:
	andi	$15,$15,0x1
	bne	$15,$0,$L2905
	move	$9,$0

$L2906:
	sll	$9,$9,2
	addu	$9,$14,$9
	lbu	$10,2($9)
	lhu	$9,0($9)
	sw	$10,0($11)
	addiu	$11,$11,4
	sw	$9,0($12)
	bne	$11,$13,$L2918
	addiu	$12,$12,4

	li	$19,65536			# 0x10000
	addu	$19,$16,$19
	lw	$3,-6260($19)
	lw	$2,-6264($19)
	lw	$4,-6256($19)
	or	$2,$3,$2
	lw	$3,-6252($19)
	or	$2,$2,$4
	or	$2,$2,$3
	andi	$2,$2,0x100
	beq	$2,$0,$L3226
	li	$22,65536			# 0x10000

	move	$4,$16
	.option	pic0
	jal	pred_direct_motion
	.option	pic2
	addiu	$5,$sp,40

	lw	$3,5936($19)
	li	$2,-2			# 0xfffffffffffffffe
	sltu	$3,$3,2
	sb	$2,9470($16)
	sb	$2,9526($16)
	sb	$2,9486($16)
	bne	$3,$0,$L2920
	sb	$2,9510($16)

	li	$6,131072			# 0x20000
$L3248:
	lui	$2,%hi(scan8)
	ori	$6,$6,0x233c
	lui	$5,%hi(scan8+16)
	addu	$6,$16,$6
	addiu	$2,$2,%lo(scan8)
	addiu	$5,$5,%lo(scan8+16)
	li	$3,257			# 0x101
$L2921:
	lw	$4,0($20)
	andi	$4,$4,0x100
	beq	$4,$0,$L2923
	addiu	$20,$20,4

	lbu	$4,0($2)
	addu	$4,$6,$4
	sh	$3,8($4)
	sh	$3,0($4)
$L2923:
	addiu	$2,$2,4
	bne	$2,$5,$L2921
	li	$22,65536			# 0x10000

	b	$L3250
	addu	$23,$16,$22

$L2794:
	lw	$10,1568($16)
	addu	$9,$10,$9
	lw	$9,0($9)
	andi	$9,$9,0x80
	beq	$9,$0,$L3163
	nop

	subu	$2,$2,$4
	li	$4,65536			# 0x10000
	addu	$8,$8,$2
	addu	$4,$16,$4
	lw	$4,-6284($4)
	b	$L2789
	lbu	$7,0($8)

$L2985:
	lw	$15,120($sp)
	and	$3,$15,$2
	beq	$3,$0,$L2987
	addu	$3,$11,$4

	lw	$20,140($sp)
	andi	$8,$2,0x18
	addu	$3,$20,$9
	lw	$3,0($3)
	li	$24,1			# 0x1
	li	$25,2			# 0x2
	movn	$24,$25,$8
	sw	$3,88($sp)
	blez	$3,$L2986
	move	$8,$24

	andi	$31,$2,0x20
	andi	$3,$2,0x8
	andi	$2,$2,0x10
	sw	$31,132($sp)
	sw	$3,100($sp)
	sw	$2,108($sp)
	move	$21,$9
	move	$23,$0
	sw	$9,152($sp)
	sw	$13,156($sp)
	b	$L3018
	sw	$12,160($sp)

$L3212:
	lw	$20,104($sp)
	lw	$14,1880($16)
	sw	$0,0($20)
	lw	$25,-6272($10)
	bne	$25,$0,$L2991
	lw	$15,104($14)

	lw	$24,6172($16)
	andi	$31,$24,0x1
	beq	$31,$0,$L2991
	slt	$31,$2,20

	beq	$31,$0,$L3241
	li	$20,-2			# 0xfffffffffffffffe

	li	$31,-2			# 0xfffffffffffffffe
	beq	$4,$31,$L2992
	nop

	lw	$31,152($16)
	addiu	$5,$24,-1
	mul	$20,$5,$31
	lw	$25,6168($16)
	xori	$5,$2,0xf
	addu	$19,$20,$25
	sltu	$5,$5,1
	addu	$5,$19,$5
	sll	$5,$5,2
	addu	$5,$15,$5
	lw	$5,0($5)
	andi	$5,$5,0x80
	beq	$5,$0,$L3242
	addu	$5,$11,$9

	sll	$24,$24,2
	addiu	$24,$24,-1
	sra	$5,$24,2
	sll	$4,$25,2
	mul	$9,$5,$31
	addiu	$4,$4,-4
	addu	$4,$4,$8
	andi	$2,$2,0x7
	addu	$2,$4,$2
	sra	$4,$2,2
	addu	$4,$9,$4
	sll	$4,$4,2
	addu	$4,$15,$4
	lw	$4,0($4)
	lw	$15,116($sp)
	and	$5,$4,$15
	beq	$5,$0,$L3210
	andi	$4,$4,0x40

	lw	$4,9748($16)
$L3233:
	lw	$20,124($sp)
	mul	$9,$24,$4
	addu	$5,$14,$20
	addu	$4,$9,$2
	lw	$5,0($5)
	sll	$4,$4,2
	addu	$4,$5,$4
	lw	$15,128($sp)
	lhu	$5,0($4)
	lw	$20,92($sp)
	addu	$14,$14,$15
	sh	$5,9176($20)
	lw	$9,9752($16)
	lw	$5,4($14)
	sra	$2,$2,1
	sra	$24,$24,1
	addu	$2,$5,$2
	mul	$5,$24,$9
	lhu	$4,2($4)
	addu	$2,$5,$2
	sll	$4,$4,1
	sh	$4,9178($20)
	lb	$4,0($2)
	lw	$5,104($sp)
	sra	$4,$4,1
$L2996:
	xor	$14,$3,$12
	xor	$9,$3,$13
	sltu	$14,$14,1
	sltu	$9,$9,1
	xor	$2,$3,$4
	addu	$9,$14,$9
	sltu	$2,$2,1
	addu	$2,$9,$2
	slt	$9,$2,2
	bne	$9,$0,$L3243
	li	$24,1			# 0x1

$L3213:
	lh	$2,0($6)
	lh	$20,0($7)
	slt	$4,$20,$2
	beq	$4,$0,$L3003
	lh	$3,0($5)

	slt	$4,$20,$3
	beq	$4,$0,$L3012
	nop

	slt	$20,$2,$3
	movz	$2,$3,$20
	move	$20,$2
$L3012:
	lh	$2,2($6)
	lh	$19,2($7)
	slt	$4,$19,$2
	beq	$4,$0,$L3013
	lh	$3,2($5)

	slt	$4,$19,$3
	beq	$4,$0,$L3244
	lw	$5,80($sp)

	slt	$19,$2,$3
	movz	$2,$3,$19
	move	$19,$2
$L3006:
	lw	$5,80($sp)
$L3244:
	move	$4,$16
	move	$6,$21
	move	$7,$0
	sw	$8,164($sp)
	sw	$10,176($sp)
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	sw	$11,172($sp)

	lw	$5,80($sp)
	addu	$3,$20,$2
	move	$4,$16
	move	$6,$21
	li	$7,1			# 0x1
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	sw	$3,168($sp)

	lw	$4,100($sp)
	addu	$2,$19,$2
	lw	$3,168($sp)
	lw	$8,164($sp)
	lw	$10,176($sp)
	beq	$4,$0,$L3014
	lw	$11,172($sp)

	subu	$20,$3,$20
	subu	$19,$2,$19
	sll	$20,$20,16
	sll	$19,$19,16
	sll	$3,$3,16
	sll	$2,$2,16
	sra	$20,$20,16
	sra	$19,$19,16
	sra	$3,$3,16
	sra	$2,$2,16
	sh	$3,36($18)
	sh	$3,32($18)
	sh	$3,4($18)
	sh	$2,38($18)
	sh	$2,34($18)
	sh	$2,6($18)
	sh	$20,36($17)
	sh	$20,32($17)
	sh	$20,4($17)
	sh	$19,38($17)
	sh	$19,34($17)
	sh	$19,6($17)
$L3015:
	lw	$7,88($sp)
	addiu	$23,$23,1
	slt	$4,$23,$7
	sh	$2,2($18)
	sh	$3,0($18)
	addu	$21,$21,$8
	sh	$19,2($17)
	beq	$4,$0,$L3211
	sh	$20,0($17)

$L3018:
	lui	$4,%hi(scan8)
	addiu	$4,$4,%lo(scan8)
	addu	$2,$21,$4
	lbu	$2,0($2)
	lw	$13,96($sp)
	addu	$5,$11,$2
	addiu	$12,$2,-8
	addu	$9,$12,$8
	addu	$7,$2,$13
	addiu	$6,$5,-1
	lw	$15,84($sp)
	lw	$14,-6276($10)
	sll	$18,$5,2
	addu	$3,$22,$2
	addu	$12,$22,$12
	sll	$6,$6,2
	sll	$7,$7,2
	addu	$4,$22,$9
	addu	$17,$15,$18
	lb	$13,9456($12)
	addu	$6,$fp,$6
	lb	$12,9455($3)
	addu	$7,$fp,$7
	lb	$4,9456($4)
	addu	$18,$fp,$18
	bne	$14,$0,$L3212
	lb	$3,9456($3)

	li	$20,-2			# 0xfffffffffffffffe
	beq	$4,$20,$L2998
	nop

$L2993:
	addu	$5,$11,$9
$L3242:
	xor	$14,$3,$12
	xor	$9,$3,$13
	sltu	$14,$14,1
	sltu	$9,$9,1
	xor	$2,$3,$4
	addu	$9,$14,$9
	sltu	$2,$2,1
	addu	$2,$9,$2
	sll	$5,$5,2
	slt	$9,$2,2
	beq	$9,$0,$L3213
	addu	$5,$fp,$5

	li	$24,1			# 0x1
$L3243:
	beq	$2,$24,$L3214
	li	$25,-2			# 0xfffffffffffffffe

	beq	$13,$25,$L3215
	nop

$L3010:
	lh	$3,0($6)
	lh	$20,0($7)
	slt	$4,$20,$3
	beq	$4,$0,$L3011
	lh	$2,0($5)

	slt	$4,$20,$2
	beq	$4,$0,$L3012
	nop

	slt	$20,$3,$2
	movz	$3,$2,$20
	b	$L3012
	move	$20,$3

$L3014:
	lw	$5,108($sp)
	beq	$5,$0,$L3016
	lw	$6,132($sp)

	subu	$20,$3,$20
	subu	$19,$2,$19
	sll	$20,$20,16
	sll	$19,$19,16
	sll	$3,$3,16
	sll	$2,$2,16
	sra	$20,$20,16
	sra	$19,$19,16
	sra	$3,$3,16
	sra	$2,$2,16
	sh	$3,4($18)
	sh	$2,6($18)
	sh	$20,4($17)
	b	$L3015
	sh	$19,6($17)

$L3013:
	slt	$4,$3,$19
	beq	$4,$0,$L3244
	lw	$5,80($sp)

	slt	$19,$3,$2
	movz	$2,$3,$19
	b	$L3244
	move	$19,$2

$L2991:
	li	$20,-2			# 0xfffffffffffffffe
$L3241:
	bne	$4,$20,$L2993
	nop

	lw	$24,6172($16)
	andi	$4,$24,0x1
	bne	$4,$0,$L2992
	slt	$9,$2,20

	bne	$9,$0,$L2998
	nop

$L2997:
	andi	$9,$2,0x7
	li	$31,4			# 0x4
	beq	$9,$31,$L3216
	lw	$20,112($sp)

$L2998:
	addiu	$5,$5,-9
$L3246:
	sll	$5,$5,2
	addu	$2,$22,$2
	addu	$5,$fp,$5
	b	$L2996
	lb	$4,9447($2)

$L3003:
	slt	$4,$3,$20
	beq	$4,$0,$L3012
	nop

	slt	$20,$3,$2
	movz	$2,$3,$20
	b	$L3012
	move	$20,$2

$L2987:
	lw	$8,84($sp)
	sll	$3,$3,2
	addu	$2,$8,$3
	addu	$3,$fp,$3
	sw	$0,0($3)
	sw	$0,36($3)
	sw	$0,32($3)
	sw	$0,4($3)
	sw	$0,0($2)
	sw	$0,36($2)
	sw	$0,32($2)
	b	$L2986
	sw	$0,4($2)

$L3016:
	bne	$6,$0,$L3017
	nop

	subu	$20,$3,$20
	subu	$19,$2,$19
	sll	$20,$20,16
	sll	$19,$19,16
	sll	$3,$3,16
	sll	$2,$2,16
	sra	$20,$20,16
	sra	$19,$19,16
	sra	$3,$3,16
	b	$L3015
	sra	$2,$2,16

$L3017:
	subu	$20,$3,$20
	subu	$19,$2,$19
	sll	$20,$20,16
	sll	$19,$19,16
	sll	$3,$3,16
	sll	$2,$2,16
	sra	$20,$20,16
	sra	$19,$19,16
	sra	$3,$3,16
	sra	$2,$2,16
	sh	$3,32($18)
	sh	$2,34($18)
	sh	$20,32($17)
	b	$L3015
	sh	$19,34($17)

$L3011:
	slt	$4,$2,$20
	beq	$4,$0,$L3012
	nop

	slt	$20,$2,$3
	movz	$3,$2,$20
	b	$L3012
	move	$20,$3

$L3211:
	lw	$9,152($sp)
	lw	$13,156($sp)
	b	$L2986
	lw	$12,160($sp)

$L3022:
	sw	$21,24($2)
	sw	$21,0($2)
	sw	$21,8($2)
	b	$L3025
	sw	$21,16($2)

$L2862:
	li	$19,131072			# 0x20000
	lw	$5,9544($16)
	ori	$2,$19,0x218f
	addu	$5,$5,$2
	addu	$5,$16,$5
	ori	$4,$19,0x1fd8
	addu	$4,$16,$4
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	addiu	$5,$5,4

	beq	$2,$0,$L2864
	lw	$28,32($sp)

	lw	$5,40($sp)
	li	$4,16777216			# 0x1000000
	lw	$3,%got(ff_h264_mlps_state)($28)
	lw	$2,%got(ff_h264_norm_shift)($28)
	or	$5,$5,$4
	lui	$10,%hi(scan8)
	lui	$15,%hi(scan8+16)
	li	$9,-65536			# 0xffffffffffff0000
	lw	$4,%got(ff_h264_lps_range)($28)
	sw	$5,40($sp)
	addiu	$10,$10,%lo(scan8)
	addiu	$15,$15,%lo(scan8+16)
	addiu	$3,$3,128
	addu	$19,$16,$19
	ori	$9,$9,0x1
	addiu	$25,$16,8776
	li	$24,2			# 0x2
	move	$8,$2
	li	$7,7			# 0x7
$L2872:
	lw	$5,8156($19)
	lbu	$20,8264($19)
	andi	$6,$5,0xc0
	sll	$6,$6,1
	addu	$6,$6,$20
	addu	$6,$4,$6
	lbu	$11,0($6)
	lw	$21,8152($19)
	subu	$5,$5,$11
	sll	$6,$5,17
	subu	$13,$6,$21
	lbu	$14,0($10)
	sra	$13,$13,31
	movz	$11,$5,$13
	addu	$5,$16,$14
	lb	$31,8775($5)
	and	$6,$13,$6
	lb	$5,8768($5)
	addu	$12,$2,$11
	subu	$6,$21,$6
	lbu	$12,0($12)
	xor	$13,$13,$20
	sw	$6,8152($19)
	sw	$11,8156($19)
	slt	$21,$31,$5
	addu	$20,$3,$13
	movn	$5,$31,$21
	sll	$6,$6,$12
	lbu	$31,0($20)
	sll	$12,$11,$12
	slt	$20,$5,0
	andi	$11,$6,0xffff
	movn	$5,$24,$20
	sb	$31,8264($19)
	sw	$12,8156($19)
	bne	$11,$0,$L2866
	sw	$6,8152($19)

	lw	$11,8168($19)
	addiu	$31,$6,-1
	xor	$31,$31,$6
	lbu	$21,0($11)
	sra	$31,$31,15
	lbu	$20,1($11)
	addu	$31,$8,$31
	sll	$21,$21,9
	lbu	$31,0($31)
	addu	$21,$21,$9
	sll	$20,$20,1
	addu	$20,$21,$20
	subu	$31,$7,$31
	sll	$31,$20,$31
	addu	$6,$31,$6
	addiu	$11,$11,2
	sw	$6,8152($19)
	sw	$11,8168($19)
$L2866:
	andi	$13,$13,0x1
	beq	$13,$0,$L2867
	move	$6,$5

$L2868:
	sll	$5,$6,8
	addu	$6,$5,$6
	andi	$6,$6,0xffff
	addu	$14,$25,$14
	addiu	$10,$10,4
	sh	$6,8($14)
	bne	$10,$15,$L2872
	sh	$6,0($14)

	b	$L3227
	lw	$2,6172($16)

$L3214:
	beq	$3,$12,$L3167
	nop

	beq	$3,$13,$L3217
	nop

	lh	$19,2($5)
	b	$L3006
	lh	$20,0($5)

$L3196:
	andi	$2,$22,0x1
	bne	$2,$0,$L3218
	lw	$17,76($sp)

	nor	$22,$0,$22
	srl	$2,$22,31
	addu	$22,$2,$22
	sra	$22,$22,1
	addu	$3,$16,$3
	sw	$22,8680($3)
$L3104:
	lw	$3,2056($16)
	addu	$3,$22,$3
	sltu	$2,$3,52
	bne	$2,$0,$L3105
	sw	$3,2056($16)

	bltz	$3,$L3219
	nop

	addiu	$3,$3,-52
	sw	$3,2056($16)
$L3105:
	andi	$4,$3,0xff
	addu	$4,$16,$4
	lw	$2,40($sp)
	lbu	$5,12352($4)
	lbu	$6,12096($4)
	andi	$4,$2,0x2
	sw	$6,8740($16)
	bne	$4,$0,$L3220
	sw	$5,8744($16)

	lw	$9,72($sp)
	andi	$4,$9,0x1
	bne	$4,$0,$L3110
	li	$4,16777216			# 0x1000000

	addiu	$2,$16,9092
	sb	$0,1($2)
	sb	$0,9($2)
	sb	$0,8($2)
	sb	$0,9092($16)
	lw	$13,72($sp)
$L3231:
	andi	$2,$13,0x2
	bne	$2,$0,$L3117
	lw	$2,40($sp)

	addiu	$2,$16,9094
	sb	$0,1($2)
	sb	$0,9($2)
	sb	$0,8($2)
	sb	$0,9094($16)
	lw	$14,72($sp)
$L3230:
	andi	$2,$14,0x4
	bne	$2,$0,$L3124
	lw	$2,40($sp)

	addiu	$2,$16,9108
	sb	$0,1($2)
	sb	$0,9($2)
	sb	$0,8($2)
	sb	$0,9108($16)
	lw	$15,72($sp)
$L3229:
	andi	$2,$15,0x8
	beq	$2,$0,$L3131
	addiu	$2,$16,9110

	lw	$2,40($sp)
	li	$3,16777216			# 0x1000000
	and	$3,$2,$3
	bne	$3,$0,$L3221
	andi	$3,$2,0x7

	li	$2,3			# 0x3
	movn	$2,$0,$3
	addiu	$3,$2,14800
	sll	$3,$3,2
	addu	$3,$16,$3
	lw	$2,2056($16)
	lw	$21,4($3)
	sll	$2,$2,6
	addu	$21,$21,$2
	li	$20,16			# 0x10
	move	$4,$16
	addiu	$5,$17,384
	li	$6,2			# 0x2
	li	$7,12			# 0xc
	sw	$19,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,416
	li	$6,2			# 0x2
	li	$7,13			# 0xd
	sw	$19,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,448
	li	$6,2			# 0x2
	li	$7,14			# 0xe
	sw	$19,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,480
	li	$6,2			# 0x2
	li	$7,15			# 0xf
	sw	$21,20($sp)
	sw	$20,24($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$19,16($sp)

$L3109:
	lw	$20,72($sp)
$L3232:
	andi	$2,$20,0x30
	beq	$2,$0,$L3245
	lw	$24,72($sp)

	lui	$21,%hi(chroma_dc_scan)
	addiu	$21,$21,%lo(chroma_dc_scan)
	li	$20,4			# 0x4
	move	$4,$16
	addiu	$5,$17,512
	li	$6,3			# 0x3
	move	$7,$0
	sw	$21,16($sp)
	sw	$0,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,640
	li	$6,3			# 0x3
	li	$7,1			# 0x1
	sw	$21,16($sp)
	sw	$20,24($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$0,20($sp)

	lw	$24,72($sp)
$L3245:
	andi	$2,$24,0x20
	beq	$2,$0,$L3138
	addiu	$2,$16,9080

	lw	$3,40($sp)
	li	$22,3			# 0x3
	andi	$3,$3,0x7
	move	$25,$22
	movn	$25,$0,$3
	addiu	$3,$25,14801
	sll	$3,$3,2
	addu	$3,$16,$3
	lw	$2,8740($16)
	lw	$21,4($3)
	sll	$2,$2,6
	addu	$21,$21,$2
	addiu	$19,$19,1
	li	$20,15			# 0xf
	move	$4,$16
	addiu	$5,$17,512
	li	$6,4			# 0x4
	move	$7,$0
	sw	$21,20($sp)
	sw	$19,16($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,544
	li	$6,4			# 0x4
	li	$7,1			# 0x1
	sw	$21,20($sp)
	sw	$19,16($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,576
	li	$6,4			# 0x4
	li	$7,2			# 0x2
	sw	$21,20($sp)
	sw	$19,16($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,608
	li	$6,4			# 0x4
	li	$7,3			# 0x3
	sw	$21,20($sp)
	sw	$19,16($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	lw	$3,40($sp)
	lw	$2,8744($16)
	andi	$3,$3,0x7
	movn	$22,$0,$3
	addiu	$3,$22,14802
	sll	$3,$3,2
	addu	$3,$16,$3
	lw	$21,4($3)
	sll	$2,$2,6
	addu	$21,$21,$2
	move	$4,$16
	addiu	$5,$17,640
	li	$6,4			# 0x4
	li	$7,4			# 0x4
	sw	$19,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,672
	li	$6,4			# 0x4
	li	$7,5			# 0x5
	sw	$19,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,704
	li	$6,4			# 0x4
	li	$7,6			# 0x6
	sw	$19,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	addiu	$5,$17,736
	move	$4,$16
	li	$6,4			# 0x4
	li	$7,7			# 0x7
	sw	$19,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	b	$L3228
	lw	$3,1548($16)

$L3138:
	sb	$0,9($2)
	sb	$0,42($2)
	sb	$0,41($2)
	sb	$0,34($2)
	sb	$0,33($2)
	sb	$0,18($2)
	sb	$0,17($2)
	b	$L3143
	sb	$0,10($2)

$L3131:
	sb	$0,1($2)
	sb	$0,9($2)
	sb	$0,8($2)
	b	$L3109
	sb	$0,9110($16)

$L3124:
	li	$3,16777216			# 0x1000000
	and	$3,$2,$3
	bne	$3,$0,$L3126
	move	$4,$16

	andi	$2,$2,0x7
	li	$3,3			# 0x3
	movn	$3,$0,$2
	addiu	$3,$3,14800
	sll	$3,$3,2
	addu	$3,$16,$3
	lw	$2,2056($16)
	lw	$22,4($3)
	sll	$2,$2,6
	addu	$22,$22,$2
	li	$21,16			# 0x10
	addiu	$5,$17,256
	li	$6,2			# 0x2
	li	$7,8			# 0x8
	sw	$19,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$21,24($sp)

	move	$4,$16
	addiu	$5,$17,288
	li	$6,2			# 0x2
	li	$7,9			# 0x9
	sw	$19,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$21,24($sp)

	move	$4,$16
	addiu	$5,$17,320
	li	$6,2			# 0x2
	li	$7,10			# 0xa
	sw	$19,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$21,24($sp)

	move	$4,$16
	addiu	$5,$17,352
	li	$6,2			# 0x2
	li	$7,11			# 0xb
	sw	$22,20($sp)
	sw	$21,24($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$19,16($sp)

	b	$L3229
	lw	$15,72($sp)

$L3117:
	li	$3,16777216			# 0x1000000
	and	$3,$2,$3
	bne	$3,$0,$L3119
	move	$4,$16

	andi	$2,$2,0x7
	li	$3,3			# 0x3
	movn	$3,$0,$2
	addiu	$3,$3,14800
	sll	$3,$3,2
	addu	$3,$16,$3
	lw	$2,2056($16)
	lw	$22,4($3)
	sll	$2,$2,6
	addu	$22,$22,$2
	li	$21,16			# 0x10
	addiu	$5,$17,128
	li	$6,2			# 0x2
	li	$7,4			# 0x4
	sw	$19,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$21,24($sp)

	move	$4,$16
	addiu	$5,$17,160
	li	$6,2			# 0x2
	li	$7,5			# 0x5
	sw	$19,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$21,24($sp)

	move	$4,$16
	addiu	$5,$17,192
	li	$6,2			# 0x2
	li	$7,6			# 0x6
	sw	$19,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$21,24($sp)

	move	$4,$16
	addiu	$5,$17,224
	li	$6,2			# 0x2
	li	$7,7			# 0x7
	sw	$22,20($sp)
	sw	$21,24($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$19,16($sp)

	b	$L3230
	lw	$14,72($sp)

$L3110:
	and	$4,$2,$4
	bne	$4,$0,$L3112
	li	$4,3			# 0x3

	andi	$2,$2,0x7
	movn	$4,$0,$2
	addiu	$2,$4,14800
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$22,4($2)
	sll	$3,$3,6
	addu	$22,$22,$3
	li	$21,16			# 0x10
	move	$4,$16
	move	$5,$17
	li	$6,2			# 0x2
	move	$7,$0
	sw	$19,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$21,24($sp)

	move	$4,$16
	addiu	$5,$17,32
	li	$6,2			# 0x2
	li	$7,1			# 0x1
	sw	$19,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$21,24($sp)

	move	$4,$16
	addiu	$5,$17,64
	li	$6,2			# 0x2
	li	$7,2			# 0x2
	sw	$19,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$21,24($sp)

	move	$4,$16
	addiu	$5,$17,96
	li	$6,2			# 0x2
	li	$7,3			# 0x3
	sw	$22,20($sp)
	sw	$21,24($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$19,16($sp)

	b	$L3231
	lw	$13,72($sp)

$L3220:
	li	$2,16			# 0x10
	move	$4,$16
	move	$5,$17
	move	$6,$0
	move	$7,$0
	sw	$2,24($sp)
	sw	$21,16($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$0,20($sp)

	lw	$8,72($sp)
	andi	$2,$8,0xf
	beq	$2,$0,$L3108
	addiu	$2,$16,9092

	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$2,2056($16)
	lw	$21,-6332($3)
	sll	$2,$2,6
	addu	$21,$21,$2
	addiu	$22,$19,1
	li	$20,15			# 0xf
	move	$4,$16
	move	$5,$17
	li	$6,1			# 0x1
	move	$7,$0
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,32
	li	$6,1			# 0x1
	li	$7,1			# 0x1
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,64
	li	$6,1			# 0x1
	li	$7,2			# 0x2
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,96
	li	$6,1			# 0x1
	li	$7,3			# 0x3
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,128
	li	$6,1			# 0x1
	li	$7,4			# 0x4
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,160
	li	$6,1			# 0x1
	li	$7,5			# 0x5
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,192
	li	$6,1			# 0x1
	li	$7,6			# 0x6
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,224
	li	$6,1			# 0x1
	li	$7,7			# 0x7
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,256
	li	$6,1			# 0x1
	li	$7,8			# 0x8
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,288
	li	$6,1			# 0x1
	li	$7,9			# 0x9
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,320
	li	$6,1			# 0x1
	li	$7,10			# 0xa
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,352
	li	$6,1			# 0x1
	li	$7,11			# 0xb
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,384
	li	$6,1			# 0x1
	li	$7,12			# 0xc
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,416
	li	$6,1			# 0x1
	li	$7,13			# 0xd
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,448
	li	$6,1			# 0x1
	li	$7,14			# 0xe
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	move	$4,$16
	addiu	$5,$17,480
	li	$6,1			# 0x1
	li	$7,15			# 0xf
	sw	$22,16($sp)
	sw	$21,20($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,24($sp)

	b	$L3232
	lw	$20,72($sp)

$L3191:
	move	$4,$16
	.option	pic0
	jal	pred_direct_motion
	.option	pic2
	addiu	$5,$sp,40

	li	$4,131072			# 0x20000
	ori	$4,$4,0x21f8
	addu	$4,$16,$4
	addiu	$2,$4,208
	addiu	$3,$4,48
	sw	$0,48($4)
	sw	$0,108($3)
	sw	$0,4($3)
	sw	$0,8($3)
	sw	$0,12($3)
	sw	$0,32($3)
	sw	$0,36($3)
	sw	$0,40($3)
	sw	$0,44($3)
	sw	$0,64($3)
	sw	$0,68($3)
	sw	$0,72($3)
	sw	$0,76($3)
	sw	$0,96($3)
	sw	$0,100($3)
	sw	$0,104($3)
	sw	$0,208($4)
	sw	$0,108($2)
	sw	$0,4($2)
	sw	$0,8($2)
	sw	$0,12($2)
	sw	$0,32($2)
	sw	$0,36($2)
	sw	$0,40($2)
	sw	$0,44($2)
	sw	$0,64($2)
	sw	$0,68($2)
	sw	$0,72($2)
	sw	$0,76($2)
	sw	$0,96($2)
	sw	$0,100($2)
	sw	$0,104($2)
	lw	$2,9980($16)
	lw	$20,76($sp)
	lw	$8,40($sp)
	and	$20,$20,$2
	b	$L2901
	sw	$20,76($sp)

$L2992:
	b	$L2997
	li	$4,1			# 0x1

$L3146:
	lw	$12,1568($16)
	sll	$6,$3,2
	addu	$6,$12,$6
	lw	$6,0($6)
	lw	$9,-6272($9)
	srl	$6,$6,7
	andi	$6,$6,0x1
	beq	$9,$6,$L2790
	nop

	b	$L2791
	move	$6,$5

$L2823:
	lw	$8,1568($16)
	addu	$3,$8,$3
	lw	$3,0($3)
	srl	$3,$3,7
	b	$L2824
	andi	$3,$3,0x1

$L2867:
	lbu	$31,8265($19)
	andi	$6,$12,0xc0
	sll	$6,$6,1
	addu	$6,$6,$31
	addu	$6,$4,$6
	lbu	$20,0($6)
	lw	$13,8152($19)
	subu	$11,$12,$20
	sll	$6,$11,17
	subu	$12,$6,$13
	sra	$12,$12,31
	movn	$11,$20,$12
	and	$6,$12,$6
	addu	$20,$2,$11
	subu	$6,$13,$6
	lbu	$20,0($20)
	xor	$31,$12,$31
	sw	$6,8152($19)
	sw	$11,8156($19)
	addu	$12,$3,$31
	sll	$6,$6,$20
	lbu	$12,0($12)
	sll	$20,$11,$20
	andi	$11,$6,0xffff
	sb	$12,8265($19)
	sw	$20,8156($19)
	bne	$11,$0,$L2869
	sw	$6,8152($19)

	lw	$11,8168($19)
	addiu	$13,$6,-1
	xor	$13,$13,$6
	lbu	$22,0($11)
	sra	$13,$13,15
	lbu	$21,1($11)
	addu	$13,$8,$13
	sll	$22,$22,9
	lbu	$13,0($13)
	addu	$22,$22,$9
	sll	$21,$21,1
	addu	$21,$22,$21
	subu	$13,$7,$13
	sll	$13,$21,$13
	addu	$6,$13,$6
	addiu	$11,$11,2
	sw	$6,8152($19)
	sw	$11,8168($19)
$L2869:
	andi	$6,$20,0xc0
	sll	$6,$6,1
	addu	$6,$6,$12
	addu	$6,$4,$6
	lbu	$13,0($6)
	lw	$21,8152($19)
	subu	$11,$20,$13
	sll	$6,$11,17
	subu	$20,$6,$21
	sra	$20,$20,31
	movn	$11,$13,$20
	and	$6,$20,$6
	addu	$13,$2,$11
	subu	$6,$21,$6
	lbu	$13,0($13)
	xor	$20,$20,$12
	sw	$6,8152($19)
	sw	$11,8156($19)
	addu	$12,$3,$20
	sll	$6,$6,$13
	lbu	$12,0($12)
	sll	$13,$11,$13
	andi	$11,$6,0xffff
	sb	$12,8265($19)
	sw	$13,8156($19)
	bne	$11,$0,$L2870
	sw	$6,8152($19)

	lw	$11,8168($19)
	addiu	$21,$6,-1
	xor	$21,$21,$6
	lbu	$23,0($11)
	sra	$21,$21,15
	lbu	$22,1($11)
	addu	$21,$8,$21
	sll	$23,$23,9
	lbu	$21,0($21)
	addu	$23,$23,$9
	sll	$22,$22,1
	addu	$22,$23,$22
	subu	$21,$7,$21
	sll	$21,$22,$21
	addu	$6,$21,$6
	addiu	$11,$11,2
	sw	$6,8152($19)
	sw	$11,8168($19)
$L2870:
	andi	$6,$13,0xc0
	sll	$6,$6,1
	addu	$6,$6,$12
	addu	$6,$4,$6
	lbu	$22,0($6)
	lw	$21,8152($19)
	subu	$11,$13,$22
	sll	$6,$11,17
	subu	$13,$6,$21
	sra	$13,$13,31
	movn	$11,$22,$13
	addu	$22,$2,$11
	and	$6,$13,$6
	subu	$6,$21,$6
	xor	$12,$13,$12
	lbu	$13,0($22)
	sw	$6,8152($19)
	sw	$11,8156($19)
	addu	$21,$3,$12
	lbu	$22,0($21)
	sll	$6,$6,$13
	sll	$11,$11,$13
	andi	$21,$6,0xffff
	sb	$22,8265($19)
	sw	$11,8156($19)
	bne	$21,$0,$L2871
	sw	$6,8152($19)

	lw	$11,8168($19)
	addiu	$13,$6,-1
	xor	$13,$13,$6
	lbu	$22,0($11)
	sra	$13,$13,15
	lbu	$21,1($11)
	addu	$13,$8,$13
	sll	$22,$22,9
	lbu	$13,0($13)
	addu	$22,$22,$9
	sll	$21,$21,1
	addu	$21,$22,$21
	subu	$13,$7,$13
	sll	$13,$21,$13
	addu	$6,$13,$6
	addiu	$11,$11,2
	sw	$6,8152($19)
	sw	$11,8168($19)
$L2871:
	andi	$6,$20,0x1
	sll	$6,$6,1
	andi	$31,$31,0x1
	andi	$12,$12,0x1
	addu	$6,$6,$31
	sll	$12,$12,2
	addu	$6,$6,$12
	slt	$5,$6,$5
	addiu	$11,$6,1
	b	$L2868
	movz	$6,$11,$5

$L2816:
	lw	$3,6172($16)
	li	$2,-2			# 0xfffffffffffffffe
	lw	$7,152($16)
	and	$3,$3,$2
	mul	$4,$3,$7
	lw	$6,6168($16)
	lw	$5,-6288($17)
	addiu	$2,$6,-1
	addu	$2,$4,$2
	addu	$8,$5,$2
	lw	$4,-6296($17)
	lbu	$8,0($8)
	beq	$8,$4,$L2817
	sll	$2,$2,2

	move	$2,$0
$L2818:
	addiu	$3,$3,-2
	mul	$8,$3,$7
	addu	$3,$8,$6
	addu	$5,$5,$3
	lbu	$5,0($5)
	bne	$4,$5,$L2819
	sll	$3,$3,2

	lw	$4,1568($16)
	addu	$3,$4,$3
	lw	$4,0($3)
	addiu	$3,$2,1
	andi	$4,$4,0x80
	movn	$2,$3,$4
$L2819:
	li	$5,131072			# 0x20000
	ori	$5,$5,0x2046
	addu	$2,$2,$5
	addu	$5,$16,$2
	move	$4,$19
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	addiu	$5,$5,4

	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	sw	$2,-6268($3)
	b	$L2801
	sw	$2,-6272($3)

$L3215:
	bne	$4,$25,$L3010
	nop

	beq	$12,$25,$L3010
	nop

$L3167:
	lh	$19,2($6)
	b	$L3006
	lh	$20,0($6)

$L2974:
	lw	$2,0($22)
	sltu	$2,$2,2
	beq	$2,$0,$L2975
	move	$4,$16

	b	$L2976
	move	$2,$0

$L3192:
	lb	$2,9468($21)
	move	$4,$16
	move	$5,$0
	li	$6,4			# 0x4
	move	$7,$19
	sw	$10,20($sp)
	sw	$11,24($sp)
	sw	$9,164($sp)
	sw	$10,176($sp)
	sw	$11,172($sp)
	.option	pic0
	jal	pred_motion
	.option	pic2
	sw	$2,16($sp)

	move	$4,$16
	move	$5,$19
	move	$6,$0
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	move	$7,$0

	lw	$3,44($sp)
	move	$4,$16
	addu	$3,$2,$3
	move	$5,$19
	move	$6,$0
	li	$7,1			# 0x1
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	sw	$3,168($sp)

	lw	$5,48($sp)
	lw	$6,44($sp)
	lw	$3,168($sp)
	sll	$4,$20,5
	sll	$20,$20,3
	addu	$4,$20,$4
	addu	$5,$2,$5
	subu	$6,$3,$6
	addiu	$4,$4,12
	sll	$4,$4,2
	sll	$2,$2,16
	andi	$6,$6,0xffff
	sll	$5,$5,16
	andi	$3,$3,0xffff
	addu	$6,$2,$6
	addu	$3,$5,$3
	addu	$2,$22,$4
	addu	$4,$fp,$4
	sw	$6,108($4)
	sw	$6,0($4)
	sw	$6,4($4)
	sw	$6,8($4)
	sw	$6,12($4)
	sw	$6,32($4)
	sw	$6,36($4)
	sw	$6,40($4)
	sw	$6,44($4)
	sw	$6,64($4)
	sw	$6,68($4)
	sw	$6,72($4)
	sw	$6,76($4)
	sw	$6,96($4)
	sw	$6,100($4)
	sw	$6,104($4)
	sw	$3,0($2)
	sw	$3,4($2)
	sw	$3,8($2)
	sw	$3,12($2)
	sw	$3,32($2)
	sw	$3,36($2)
	sw	$3,40($2)
	sw	$3,44($2)
	sw	$3,64($2)
	sw	$3,68($2)
	sw	$3,72($2)
	sw	$3,76($2)
	sw	$3,96($2)
	sw	$3,100($2)
	sw	$3,104($2)
	sw	$3,108($2)
	lw	$8,40($sp)
	lw	$9,164($sp)
	lw	$10,176($sp)
	b	$L3030
	lw	$11,172($sp)

$L2962:
	lw	$2,0($22)
	sltu	$2,$2,2
	beq	$2,$0,$L2963
	move	$4,$16

	b	$L2964
	move	$2,$0

$L2966:
	lw	$2,0($22)
	sltu	$2,$2,2
	beq	$2,$0,$L2967
	move	$4,$16

	b	$L2968
	move	$2,$0

$L2905:
	lbu	$25,8233($5)
	andi	$9,$24,0xc0
	sll	$9,$9,1
	addu	$9,$9,$25
	addu	$9,$4,$9
	lbu	$10,0($9)
	lw	$19,8152($5)
	subu	$24,$24,$10
	sll	$9,$24,17
	subu	$15,$9,$19
	sra	$15,$15,31
	movz	$10,$24,$15
	and	$9,$15,$9
	addu	$21,$2,$10
	subu	$9,$19,$9
	xor	$24,$15,$25
	lbu	$15,0($21)
	sw	$9,8152($5)
	sw	$10,8156($5)
	addu	$25,$3,$24
	lbu	$25,0($25)
	sll	$9,$9,$15
	sll	$10,$10,$15
	andi	$15,$9,0xffff
	sb	$25,8233($5)
	sw	$10,8156($5)
	bne	$15,$0,$L2907
	sw	$9,8152($5)

	lw	$15,8168($5)
	addiu	$25,$9,-1
	xor	$25,$25,$9
	lbu	$21,0($15)
	sra	$25,$25,15
	lbu	$19,1($15)
	addu	$25,$7,$25
	sll	$21,$21,9
	lbu	$25,0($25)
	addu	$21,$21,$8
	sll	$19,$19,1
	addu	$19,$21,$19
	subu	$25,$6,$25
	sll	$25,$19,$25
	addu	$9,$25,$9
	addiu	$15,$15,2
	sw	$9,8152($5)
	sw	$15,8168($5)
$L2907:
	andi	$24,$24,0x1
	beq	$24,$0,$L3222
	andi	$9,$10,0xc0

	lbu	$24,8234($5)
	sll	$9,$9,1
	addu	$9,$9,$24
	addu	$9,$4,$9
	lbu	$25,0($9)
	lw	$19,8152($5)
	subu	$10,$10,$25
	sll	$9,$10,17
	subu	$15,$9,$19
	sra	$15,$15,31
	movn	$10,$25,$15
	and	$9,$15,$9
	addu	$25,$2,$10
	subu	$9,$19,$9
	lbu	$25,0($25)
	xor	$15,$15,$24
	sw	$9,8152($5)
	sw	$10,8156($5)
	addu	$24,$3,$15
	sll	$9,$9,$25
	lbu	$24,0($24)
	sll	$25,$10,$25
	andi	$10,$9,0xffff
	sb	$24,8234($5)
	sw	$25,8156($5)
	bne	$10,$0,$L2910
	sw	$9,8152($5)

	lw	$10,8168($5)
	addiu	$24,$9,-1
	xor	$24,$24,$9
	lbu	$21,0($10)
	sra	$24,$24,15
	lbu	$19,1($10)
	addu	$24,$7,$24
	sll	$21,$21,9
	lbu	$24,0($24)
	addu	$21,$21,$8
	sll	$19,$19,1
	addu	$19,$21,$19
	subu	$24,$6,$24
	sll	$24,$19,$24
	addu	$9,$24,$9
	addiu	$10,$10,2
	sw	$9,8152($5)
	sw	$10,8168($5)
$L2910:
	andi	$15,$15,0x1
	beq	$15,$0,$L2911
	andi	$9,$25,0xc0

	lbu	$19,8235($5)
	sll	$9,$9,1
	addu	$9,$9,$19
	addu	$9,$4,$9
	lbu	$10,0($9)
	lw	$21,8152($5)
	subu	$25,$25,$10
	sll	$9,$25,17
	subu	$15,$9,$21
	sra	$15,$15,31
	movz	$10,$25,$15
	and	$9,$15,$9
	addu	$24,$2,$10
	subu	$9,$21,$9
	lbu	$24,0($24)
	xor	$25,$15,$19
	sw	$9,8152($5)
	sw	$10,8156($5)
	addu	$15,$3,$25
	sll	$9,$9,$24
	lbu	$15,0($15)
	sll	$24,$10,$24
	andi	$10,$9,0xffff
	sb	$15,8235($5)
	sw	$24,8156($5)
	bne	$10,$0,$L2912
	sw	$9,8152($5)

	lw	$10,8168($5)
	addiu	$19,$9,-1
	xor	$19,$19,$9
	lbu	$22,0($10)
	sra	$19,$19,15
	lbu	$21,1($10)
	addu	$19,$7,$19
	sll	$22,$22,9
	lbu	$19,0($19)
	addu	$22,$22,$8
	sll	$21,$21,1
	addu	$21,$22,$21
	subu	$19,$6,$19
	sll	$19,$21,$19
	addu	$9,$19,$9
	addiu	$10,$10,2
	sw	$9,8152($5)
	sw	$10,8168($5)
$L2912:
	andi	$25,$25,0x1
	bne	$25,$0,$L2913
	li	$25,7			# 0x7

$L2914:
	lw	$10,8156($5)
	lbu	$19,8235($5)
	andi	$9,$10,0xc0
	sll	$9,$9,1
	addu	$9,$9,$19
	addu	$9,$4,$9
	lbu	$24,0($9)
	lw	$21,8152($5)
	subu	$10,$10,$24
	sll	$9,$10,17
	subu	$15,$9,$21
	sra	$15,$15,31
	movn	$10,$24,$15
	and	$9,$15,$9
	addu	$24,$2,$10
	subu	$9,$21,$9
	lbu	$24,0($24)
	xor	$19,$15,$19
	sw	$9,8152($5)
	sw	$10,8156($5)
	addu	$15,$3,$19
	sll	$9,$9,$24
	lbu	$15,0($15)
	sll	$24,$10,$24
	andi	$10,$9,0xffff
	sb	$15,8235($5)
	sw	$24,8156($5)
	bne	$10,$0,$L2916
	sw	$9,8152($5)

	lw	$10,8168($5)
	addiu	$21,$9,-1
	xor	$21,$21,$9
	lbu	$23,0($10)
	sra	$21,$21,15
	lbu	$22,1($10)
	addu	$21,$7,$21
	sll	$23,$23,9
	lbu	$21,0($21)
	addu	$23,$23,$8
	sll	$22,$22,1
	addu	$22,$23,$22
	subu	$21,$6,$21
	sll	$21,$22,$21
	addu	$9,$21,$9
	addiu	$10,$10,2
	sw	$9,8152($5)
	sw	$10,8168($5)
$L2916:
	andi	$9,$24,0xc0
	sll	$9,$9,1
	addu	$9,$9,$15
	addu	$9,$4,$9
	lbu	$22,0($9)
	lw	$21,8152($5)
	subu	$10,$24,$22
	sll	$9,$10,17
	subu	$24,$9,$21
	sra	$24,$24,31
	movn	$10,$22,$24
	addu	$22,$2,$10
	and	$9,$24,$9
	subu	$9,$21,$9
	xor	$15,$24,$15
	lbu	$24,0($22)
	sw	$9,8152($5)
	sw	$10,8156($5)
	addu	$21,$3,$15
	lbu	$22,0($21)
	sll	$9,$9,$24
	sll	$10,$10,$24
	andi	$21,$9,0xffff
	sb	$22,8235($5)
	sw	$10,8156($5)
	bne	$21,$0,$L2917
	sw	$9,8152($5)

	lw	$10,8168($5)
	addiu	$24,$9,-1
	xor	$24,$24,$9
	lbu	$22,0($10)
	sra	$24,$24,15
	lbu	$21,1($10)
	addu	$24,$7,$24
	sll	$22,$22,9
	lbu	$24,0($24)
	addu	$22,$22,$8
	sll	$21,$21,1
	addu	$21,$22,$21
	subu	$24,$6,$24
	sll	$24,$21,$24
	addu	$9,$24,$9
	addiu	$10,$10,2
	sw	$9,8152($5)
	sw	$10,8168($5)
$L2917:
	andi	$19,$19,0x1
	andi	$15,$15,0x1
	sll	$19,$19,1
	addu	$9,$15,$19
	b	$L2906
	addu	$9,$9,$25

$L2970:
	lw	$2,0($22)
	sltu	$2,$2,2
	beq	$2,$0,$L2971
	move	$4,$16

	b	$L2972
	move	$2,$0

$L2983:
	b	$L2901
	lw	$8,40($sp)

$L3059:
	lw	$2,0($23)
	sltu	$2,$2,2
	beq	$2,$0,$L3061
	move	$4,$16

	move	$3,$0
$L3062:
	sll	$2,$19,4
	sll	$19,$19,2
	addu	$2,$19,$2
	sll	$2,$2,1
	addiu	$2,$2,14
	addu	$2,$22,$2
	sh	$3,24($2)
	sh	$3,0($2)
	sh	$3,8($2)
	b	$L3060
	sh	$3,16($2)

$L3055:
	lw	$2,0($23)
	sltu	$2,$2,2
	beq	$2,$0,$L3057
	move	$4,$16

	move	$3,$0
$L3058:
	sll	$4,$19,3
	sll	$2,$19,5
	addu	$2,$4,$2
	addiu	$2,$2,12
	addu	$2,$22,$2
	sh	$3,24($2)
	sh	$3,0($2)
	sh	$3,8($2)
	b	$L3056
	sh	$3,16($2)

$L3197:
	lw	$4,-6288($6)
	lw	$10,-6272($6)
	addu	$3,$4,$5
	lbu	$7,0($3)
	b	$L2805
	lw	$3,-6296($6)

$L3043:
	lw	$2,0($23)
	sltu	$2,$2,2
	beq	$2,$0,$L3045
	move	$4,$16

	move	$3,$0
$L3046:
	addiu	$20,$20,28
	addu	$20,$22,$20
	sw	$3,8($20)
	b	$L3044
	sw	$3,0($20)

$L3039:
	lw	$2,0($23)
	sltu	$2,$2,2
	beq	$2,$0,$L3041
	move	$4,$16

	move	$3,$0
$L3042:
	sll	$2,$20,5
	sll	$20,$20,3
	addu	$20,$20,$2
	addiu	$2,$20,12
	addu	$2,$22,$2
	sw	$3,8($2)
	b	$L3040
	sw	$3,0($2)

$L3108:
	sw	$0,9092($16)
	sw	$0,24($2)
	sw	$0,8($2)
	b	$L3109
	sw	$0,16($2)

$L3219:
	addiu	$3,$3,52
	b	$L3105
	sw	$3,2056($16)

$L3071:
	li	$4,131072			# 0x20000
	addu	$4,$16,$4
	lw	$fp,8668($4)
	andi	$4,$fp,0x4
	bne	$4,$0,$L3073
	nop

	andi	$fp,$fp,0x8
	b	$L3074
	li	$4,2			# 0x2

$L3198:
	addu	$8,$8,$2
	lw	$3,0($8)
	addiu	$2,$5,1
	andi	$3,$3,0x800
	b	$L2814
	movz	$5,$2,$3

$L2812:
	addu	$5,$8,$5
	lw	$5,0($5)
	srl	$5,$5,11
	xori	$5,$5,0x1
	b	$L2813
	andi	$5,$5,0x1

$L3041:
	move	$5,$19
	.option	pic0
	jal	decode_cabac_mb_ref
	.option	pic2
	move	$6,$0

	sll	$3,$2,8
	addu	$2,$3,$2
	sll	$3,$2,16
	addu	$3,$2,$3
	b	$L3042
	lw	$8,40($sp)

$L3065:
	lb	$7,9470($21)
	lw	$14,80($sp)
	lw	$15,84($sp)
	move	$4,$16
	li	$5,4			# 0x4
	move	$6,$19
	sw	$14,16($sp)
	.option	pic0
	jal	pred_8x16_motion
	.option	pic2
	sw	$15,20($sp)

	move	$4,$16
	move	$5,$19
	li	$6,4			# 0x4
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	move	$7,$0

	lw	$3,44($sp)
	move	$4,$16
	addu	$3,$2,$3
	move	$5,$19
	li	$6,4			# 0x4
	li	$7,1			# 0x1
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	sw	$3,168($sp)

	lw	$5,48($sp)
	lw	$6,44($sp)
	sll	$4,$20,4
	lw	$3,168($sp)
	sll	$20,$20,2
	addu	$4,$20,$4
	addu	$5,$2,$5
	subu	$6,$3,$6
	sll	$4,$4,3
	addiu	$4,$4,56
	sll	$2,$2,16
	andi	$6,$6,0xffff
	sll	$5,$5,16
	andi	$3,$3,0xffff
	addu	$6,$2,$6
	addu	$3,$5,$3
	addu	$2,$22,$4
	addu	$4,$23,$4
	sw	$6,100($4)
	sw	$6,0($4)
	sw	$6,4($4)
	sw	$6,32($4)
	sw	$6,36($4)
	sw	$6,64($4)
	sw	$6,68($4)
	sw	$6,96($4)
	sw	$3,100($2)
	sw	$3,0($2)
	sw	$3,4($2)
	sw	$3,32($2)
	sw	$3,36($2)
	sw	$3,64($2)
	sw	$3,68($2)
	sw	$3,96($2)
	b	$L3066
	lw	$8,40($sp)

$L3063:
	lw	$8,80($sp)
	lb	$7,9468($21)
	lw	$9,84($sp)
	move	$4,$16
	move	$5,$0
	move	$6,$19
	sw	$8,16($sp)
	.option	pic0
	jal	pred_8x16_motion
	.option	pic2
	sw	$9,20($sp)

	move	$4,$16
	move	$5,$19
	move	$6,$0
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	move	$7,$0

	lw	$3,44($sp)
	move	$4,$16
	addu	$3,$2,$3
	move	$5,$19
	move	$6,$0
	li	$7,1			# 0x1
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	sw	$3,168($sp)

	sll	$5,$20,3
	sll	$4,$20,5
	lw	$6,44($sp)
	addu	$4,$5,$4
	lw	$3,168($sp)
	lw	$5,48($sp)
	subu	$6,$3,$6
	addu	$5,$2,$5
	addiu	$4,$4,12
	sll	$4,$4,2
	sll	$2,$2,16
	andi	$6,$6,0xffff
	sll	$5,$5,16
	andi	$3,$3,0xffff
	addu	$6,$2,$6
	addu	$3,$5,$3
	addu	$2,$22,$4
	addu	$4,$23,$4
	lw	$8,40($sp)
	sw	$6,100($4)
	sw	$6,0($4)
	sw	$6,4($4)
	sw	$6,32($4)
	sw	$6,36($4)
	sw	$6,64($4)
	sw	$6,68($4)
	sw	$6,96($4)
	sw	$3,100($2)
	sw	$3,0($2)
	sw	$3,4($2)
	sw	$3,32($2)
	sw	$3,36($2)
	sw	$3,64($2)
	sw	$3,68($2)
	b	$L3064
	sw	$3,96($2)

$L2967:
	move	$5,$20
	.option	pic0
	jal	decode_cabac_mb_ref
	.option	pic2
	li	$6,4			# 0x4

	sll	$2,$2,24
	b	$L2968
	sra	$2,$2,24

$L2982:
	srl	$4,$4,8
	xori	$4,$4,0x1
	andi	$4,$4,0x1
	b	$L2977
	sw	$4,76($sp)

$L2888:
	lw	$2,6172($16)
	lw	$3,6168($16)
	lui	$6,%hi($LC26)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	sw	$3,16($sp)
	sw	$2,20($sp)
	b	$L3169
	addiu	$6,$6,%lo($LC26)

$L2975:
	move	$5,$20
	.option	pic0
	jal	decode_cabac_mb_ref
	.option	pic2
	li	$6,12			# 0xc

	sll	$2,$2,24
	b	$L2976
	sra	$2,$2,24

$L3216:
	li	$31,-2			# 0xfffffffffffffffe
	lb	$9,9467($20)
	beq	$9,$31,$L2998
	nop

	bne	$25,$0,$L2999
	nop

	lw	$9,8768($16)
	sll	$9,$9,2
	addu	$9,$15,$9
	lw	$9,0($9)
	andi	$9,$9,0x80
	beq	$9,$0,$L3246
	addiu	$5,$5,-9

	ori	$24,$24,0x1
	sll	$24,$24,1
	addu	$4,$24,$4
	sra	$2,$2,4
	addiu	$2,$2,-1
	sll	$4,$4,1
	addu	$4,$2,$4
	lw	$24,152($16)
	sra	$9,$4,2
	lw	$5,6168($16)
	mul	$20,$9,$24
	sll	$5,$5,2
	addiu	$2,$5,-1
	sra	$5,$2,2
	addu	$5,$20,$5
	sll	$5,$5,2
	addu	$5,$15,$5
	lw	$5,0($5)
	lw	$24,116($sp)
	and	$9,$24,$5
	beq	$9,$0,$L3223
	nop

$L3000:
	lw	$5,9748($16)
	lw	$25,124($sp)
	mul	$15,$4,$5
	addu	$9,$14,$25
	addu	$5,$15,$2
	lw	$9,0($9)
	sll	$5,$5,2
	addu	$5,$9,$5
	lw	$20,128($sp)
	lhu	$9,0($5)
	lw	$24,92($sp)
	addu	$14,$14,$20
	sh	$9,9176($24)
	lw	$9,4($14)
	lw	$14,9752($16)
	sra	$4,$4,1
	mul	$15,$4,$14
	lhu	$5,2($5)
	addu	$4,$15,$9
	sll	$5,$5,1
	sra	$2,$2,1
	sh	$5,9178($24)
	addu	$2,$4,$2
	lb	$4,0($2)
	lw	$5,104($sp)
	b	$L2996
	sra	$4,$4,1

$L2963:
	move	$5,$20
	.option	pic0
	jal	decode_cabac_mb_ref
	.option	pic2
	move	$6,$0

	sll	$2,$2,24
	b	$L2964
	sra	$2,$2,24

$L3061:
	move	$5,$21
	.option	pic0
	jal	decode_cabac_mb_ref
	.option	pic2
	li	$6,4			# 0x4

	sll	$3,$2,8
	addu	$3,$3,$2
	andi	$3,$3,0xffff
	b	$L3062
	lw	$8,40($sp)

$L3221:
	andi	$2,$2,0x7
	li	$4,59224			# 0xe758
	li	$3,59228			# 0xe75c
	movn	$3,$4,$2
	addu	$3,$16,$3
	lw	$2,2056($16)
	lw	$3,4($3)
	sll	$2,$2,8
	addu	$2,$3,$2
	sw	$2,20($sp)
	move	$4,$16
	li	$2,64			# 0x40
	addiu	$5,$17,384
	li	$6,5			# 0x5
	li	$7,12			# 0xc
	sw	$20,16($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$2,24($sp)

	b	$L3232
	lw	$20,72($sp)

$L3126:
	andi	$4,$2,0x7
	li	$3,59224			# 0xe758
	li	$2,59228			# 0xe75c
	movn	$2,$3,$4
	addu	$3,$16,$2
	lw	$2,2056($16)
	lw	$3,4($3)
	sll	$2,$2,8
	addu	$2,$3,$2
	sw	$2,20($sp)
	move	$4,$16
	li	$2,64			# 0x40
	addiu	$5,$17,256
	li	$6,5			# 0x5
	li	$7,8			# 0x8
	sw	$2,24($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,16($sp)

	b	$L3229
	lw	$15,72($sp)

$L2971:
	move	$5,$20
	.option	pic0
	jal	decode_cabac_mb_ref
	.option	pic2
	li	$6,8			# 0x8

	sll	$2,$2,24
	b	$L2972
	sra	$2,$2,24

$L2808:
	mul	$3,$9,$2
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	addu	$2,$3,$11
	lw	$3,-6296($4)
	b	$L2810
	lw	$4,-6288($4)

$L3057:
	move	$5,$21
	.option	pic0
	jal	decode_cabac_mb_ref
	.option	pic2
	move	$6,$0

	sll	$3,$2,8
	addu	$3,$3,$2
	andi	$3,$3,0xffff
	b	$L3058
	lw	$8,40($sp)

$L3218:
	addiu	$22,$22,1
	sra	$22,$22,1
	addu	$3,$16,$3
	b	$L3104
	sw	$22,8680($3)

$L2952:
	addu	$5,$16,$5
	lbu	$11,8218($5)
	andi	$6,$10,0xc0
	sll	$6,$6,1
	addu	$6,$6,$11
	addu	$6,$4,$6
	lbu	$8,0($6)
	lw	$12,8152($5)
	subu	$10,$10,$8
	sll	$6,$10,17
	subu	$9,$6,$12
	sra	$9,$9,31
	movz	$8,$10,$9
	and	$6,$9,$6
	addu	$13,$2,$8
	subu	$6,$12,$6
	xor	$10,$9,$11
	lbu	$9,0($13)
	sw	$6,8152($5)
	sw	$8,8156($5)
	addu	$11,$3,$10
	lbu	$11,0($11)
	sll	$6,$6,$9
	sll	$8,$8,$9
	andi	$9,$6,0xffff
	sb	$11,8218($5)
	sw	$8,8156($5)
	bne	$9,$0,$L2954
	sw	$6,8152($5)

	lw	$9,8168($5)
	addiu	$11,$6,-1
	xor	$11,$11,$6
	lw	$13,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($9)
	sra	$11,$11,15
	addu	$13,$13,$11
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$11,1($9)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$11,$11,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$11
	li	$11,7			# 0x7
	subu	$11,$11,$13
	sll	$11,$12,$11
	addu	$6,$11,$6
	addiu	$9,$9,2
	sw	$9,8168($5)
	sw	$6,8152($5)
$L2954:
	andi	$10,$10,0x1
	bne	$10,$0,$L2955
	li	$5,131072			# 0x20000

	b	$L2953
	li	$2,1			# 0x1

$L3045:
	move	$5,$19
	.option	pic0
	jal	decode_cabac_mb_ref
	.option	pic2
	li	$6,8			# 0x8

	sll	$3,$2,8
	addu	$2,$3,$2
	sll	$3,$2,16
	addu	$3,$2,$3
	b	$L3046
	lw	$8,40($sp)

$L3204:
	li	$5,131072			# 0x20000
	addu	$5,$16,$5
	lbu	$12,8218($5)
	andi	$6,$11,0xc0
	sll	$6,$6,1
	addu	$6,$6,$12
	addu	$6,$4,$6
	lbu	$8,0($6)
	lw	$13,8152($5)
	subu	$11,$11,$8
	sll	$6,$11,17
	subu	$10,$6,$13
	sra	$10,$10,31
	movz	$8,$11,$10
	and	$6,$10,$6
	addu	$9,$2,$8
	subu	$6,$13,$6
	lbu	$9,0($9)
	xor	$10,$10,$12
	sw	$6,8152($5)
	sw	$8,8156($5)
	addu	$11,$3,$10
	sll	$6,$6,$9
	lbu	$11,0($11)
	sll	$9,$8,$9
	andi	$8,$6,0xffff
	sb	$11,8218($5)
	sw	$9,8156($5)
	bne	$8,$0,$L2950
	sw	$6,8152($5)

	lw	$8,8168($5)
	addiu	$11,$6,-1
	xor	$11,$11,$6
	lw	$13,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($8)
	sra	$11,$11,15
	addu	$13,$13,$11
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$11,1($8)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$11,$11,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$11
	li	$11,7			# 0x7
	subu	$11,$11,$13
	sll	$11,$12,$11
	addu	$6,$11,$6
	addiu	$8,$8,2
	sw	$8,8168($5)
	sw	$6,8152($5)
$L2950:
	andi	$10,$10,0x1
	bne	$10,$0,$L2945
	li	$6,1			# 0x1

	b	$L3251
	li	$5,131072			# 0x20000

$L2882:
	lw	$2,6172($16)
	lw	$3,6168($16)
	lui	$6,%hi($LC25)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	sw	$3,16($sp)
	sw	$2,20($sp)
	b	$L3169
	addiu	$6,$6,%lo($LC25)

$L3199:
	lw	$4,1568($16)
	addu	$3,$4,$3
	lw	$4,0($3)
	addiu	$3,$2,1
	andi	$4,$4,0x100
	b	$L2839
	movz	$2,$3,$4

$L3049:
	lb	$7,9484($21)
	lw	$14,80($sp)
	lw	$15,84($sp)
	move	$4,$16
	li	$5,8			# 0x8
	move	$6,$19
	sw	$14,16($sp)
	.option	pic0
	jal	pred_16x8_motion
	.option	pic2
	sw	$15,20($sp)

	move	$4,$16
	move	$5,$19
	li	$6,8			# 0x8
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	move	$7,$0

	lw	$3,44($sp)
	move	$4,$16
	addu	$3,$2,$3
	move	$5,$19
	li	$6,8			# 0x8
	li	$7,1			# 0x1
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	sw	$3,168($sp)

	lw	$4,48($sp)
	lw	$5,44($sp)
	lw	$3,168($sp)
	addu	$4,$2,$4
	subu	$5,$3,$5
	addiu	$20,$20,28
	sll	$20,$20,2
	sll	$2,$2,16
	andi	$5,$5,0xffff
	sll	$4,$4,16
	andi	$3,$3,0xffff
	addu	$5,$2,$5
	addu	$3,$4,$3
	addu	$2,$22,$20
	addu	$20,$23,$20
	sw	$5,44($20)
	sw	$5,0($20)
	sw	$5,4($20)
	sw	$5,8($20)
	sw	$5,12($20)
	sw	$5,32($20)
	sw	$5,36($20)
	sw	$5,40($20)
	sw	$3,44($2)
	sw	$3,0($2)
	sw	$3,4($2)
	sw	$3,8($2)
	sw	$3,12($2)
	sw	$3,32($2)
	sw	$3,36($2)
	sw	$3,40($2)
	b	$L3050
	lw	$8,40($sp)

$L3047:
	lw	$8,80($sp)
	lb	$7,9468($21)
	lw	$9,84($sp)
	move	$4,$16
	move	$5,$0
	move	$6,$19
	sw	$8,16($sp)
	.option	pic0
	jal	pred_16x8_motion
	.option	pic2
	sw	$9,20($sp)

	move	$4,$16
	move	$5,$19
	move	$6,$0
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	move	$7,$0

	lw	$3,44($sp)
	move	$4,$16
	addu	$3,$2,$3
	move	$5,$19
	move	$6,$0
	li	$7,1			# 0x1
	.option	pic0
	jal	decode_cabac_mb_mvd
	.option	pic2
	sw	$3,168($sp)

	lw	$5,48($sp)
	lw	$6,44($sp)
	sll	$4,$20,5
	lw	$3,168($sp)
	sll	$20,$20,3
	addu	$20,$20,$4
	addu	$5,$2,$5
	subu	$6,$3,$6
	addiu	$4,$20,12
	sll	$4,$4,2
	sll	$2,$2,16
	andi	$6,$6,0xffff
	sll	$5,$5,16
	andi	$3,$3,0xffff
	addu	$6,$2,$6
	addu	$3,$5,$3
	addu	$2,$22,$4
	addu	$4,$23,$4
	lw	$8,40($sp)
	sw	$6,44($4)
	sw	$6,0($4)
	sw	$6,4($4)
	sw	$6,8($4)
	sw	$6,12($4)
	sw	$6,32($4)
	sw	$6,36($4)
	sw	$6,40($4)
	sw	$3,44($2)
	sw	$3,0($2)
	sw	$3,4($2)
	sw	$3,8($2)
	sw	$3,12($2)
	sw	$3,32($2)
	sw	$3,36($2)
	b	$L3048
	sw	$3,40($2)

$L3203:
	li	$5,131072			# 0x20000
	addu	$5,$16,$5
	lbu	$12,8218($5)
	andi	$6,$11,0xc0
	sll	$6,$6,1
	addu	$6,$6,$12
	addu	$6,$4,$6
	lbu	$8,0($6)
	lw	$13,8152($5)
	subu	$11,$11,$8
	sll	$6,$11,17
	subu	$10,$6,$13
	sra	$10,$10,31
	movz	$8,$11,$10
	and	$6,$10,$6
	addu	$9,$2,$8
	subu	$6,$13,$6
	lbu	$9,0($9)
	xor	$10,$10,$12
	sw	$6,8152($5)
	sw	$8,8156($5)
	addu	$11,$3,$10
	sll	$6,$6,$9
	lbu	$11,0($11)
	sll	$9,$8,$9
	andi	$8,$6,0xffff
	sb	$11,8218($5)
	sw	$9,8156($5)
	bne	$8,$0,$L2941
	sw	$6,8152($5)

	lw	$8,8168($5)
	addiu	$11,$6,-1
	xor	$11,$11,$6
	lw	$13,%got(ff_h264_norm_shift)($28)
	lbu	$14,0($8)
	sra	$11,$11,15
	addu	$13,$13,$11
	li	$12,-65536			# 0xffffffffffff0000
	lbu	$11,1($8)
	sll	$14,$14,9
	ori	$12,$12,0x1
	sll	$11,$11,1
	lbu	$13,0($13)
	addu	$12,$14,$12
	addu	$12,$12,$11
	li	$11,7			# 0x7
	subu	$11,$11,$13
	sll	$11,$12,$11
	addu	$6,$11,$6
	addiu	$8,$8,2
	sw	$8,8168($5)
	sw	$6,8152($5)
$L2941:
	andi	$10,$10,0x1
	bne	$10,$0,$L2936
	li	$6,1			# 0x1

	b	$L3252
	li	$5,131072			# 0x20000

$L3202:
	li	$5,131072			# 0x20000
	addu	$5,$16,$5
	lbu	$11,8218($5)
	andi	$6,$10,0xc0
	sll	$6,$6,1
	addu	$6,$6,$11
	addu	$6,$4,$6
	lbu	$7,0($6)
	lw	$12,8152($5)
	subu	$10,$10,$7
	sll	$6,$10,17
	subu	$9,$6,$12
	sra	$9,$9,31
	movz	$7,$10,$9
	and	$6,$9,$6
	addu	$8,$2,$7
	subu	$6,$12,$6
	lbu	$8,0($8)
	xor	$9,$9,$11
	sw	$6,8152($5)
	sw	$7,8156($5)
	addu	$10,$3,$9
	sll	$6,$6,$8
	lbu	$10,0($10)
	sll	$8,$7,$8
	andi	$7,$6,0xffff
	sb	$10,8218($5)
	sw	$8,8156($5)
	bne	$7,$0,$L2932
	sw	$6,8152($5)

	lw	$7,8168($5)
	addiu	$10,$6,-1
	xor	$10,$10,$6
	lw	$12,%got(ff_h264_norm_shift)($28)
	lbu	$13,0($7)
	sra	$10,$10,15
	addu	$12,$12,$10
	li	$11,-65536			# 0xffffffffffff0000
	lbu	$10,1($7)
	sll	$13,$13,9
	ori	$11,$11,0x1
	sll	$10,$10,1
	lbu	$12,0($12)
	addu	$11,$13,$11
	addu	$11,$11,$10
	li	$10,7			# 0x7
	subu	$10,$10,$12
	sll	$10,$11,$10
	addu	$6,$10,$6
	addiu	$7,$7,2
	sw	$7,8168($5)
	sw	$6,8152($5)
$L2932:
	andi	$9,$9,0x1
	bne	$9,$0,$L2927
	li	$6,1			# 0x1

	b	$L3253
	li	$5,131072			# 0x20000

$L3119:
	andi	$4,$2,0x7
	li	$3,59224			# 0xe758
	li	$2,59228			# 0xe75c
	movn	$2,$3,$4
	addu	$3,$16,$2
	lw	$2,2056($16)
	lw	$3,4($3)
	sll	$2,$2,8
	addu	$2,$3,$2
	sw	$2,20($sp)
	move	$4,$16
	li	$2,64			# 0x40
	addiu	$5,$17,128
	li	$6,5			# 0x5
	li	$7,4			# 0x4
	sw	$2,24($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,16($sp)

	b	$L3230
	lw	$14,72($sp)

$L3112:
	andi	$2,$2,0x7
	li	$5,59224			# 0xe758
	li	$4,59228			# 0xe75c
	movn	$4,$5,$2
	addu	$4,$16,$4
	lw	$2,4($4)
	sll	$3,$3,8
	addu	$2,$2,$3
	sw	$2,20($sp)
	move	$4,$16
	li	$2,64			# 0x40
	move	$5,$17
	li	$6,5			# 0x5
	move	$7,$0
	sw	$2,24($sp)
	.option	pic0
	jal	decode_cabac_residual
	.option	pic2
	sw	$20,16($sp)

	b	$L3231
	lw	$13,72($sp)

$L3222:
	lbu	$24,8235($5)
	sll	$9,$9,1
	addu	$9,$9,$24
	addu	$9,$4,$9
	lbu	$19,0($9)
	lw	$25,8152($5)
	subu	$10,$10,$19
	sll	$9,$10,17
	subu	$15,$9,$25
	sra	$15,$15,31
	movn	$10,$19,$15
	addu	$19,$2,$10
	and	$9,$15,$9
	subu	$9,$25,$9
	xor	$15,$15,$24
	lbu	$24,0($19)
	sw	$9,8152($5)
	sw	$10,8156($5)
	addu	$25,$3,$15
	lbu	$19,0($25)
	sll	$9,$9,$24
	sll	$10,$10,$24
	andi	$25,$9,0xffff
	sb	$19,8235($5)
	sw	$10,8156($5)
	bne	$25,$0,$L2909
	sw	$9,8152($5)

	lw	$10,8168($5)
	addiu	$24,$9,-1
	xor	$24,$24,$9
	lbu	$19,0($10)
	sra	$24,$24,15
	lbu	$25,1($10)
	addu	$24,$7,$24
	sll	$19,$19,9
	lbu	$24,0($24)
	addu	$19,$19,$8
	sll	$25,$25,1
	addu	$25,$19,$25
	subu	$24,$6,$24
	sll	$24,$25,$24
	addu	$9,$24,$9
	addiu	$10,$10,2
	sw	$9,8152($5)
	sw	$10,8168($5)
$L2909:
	andi	$15,$15,0x1
	b	$L2906
	addiu	$9,$15,1

$L2945:
	li	$5,131072			# 0x20000
	addu	$5,$16,$5
	lbu	$10,8219($5)
	andi	$6,$9,0xc0
	sll	$6,$6,1
	addu	$6,$6,$10
	addu	$6,$4,$6
	lbu	$12,0($6)
	lw	$11,8152($5)
	subu	$9,$9,$12
	sll	$6,$9,17
	subu	$8,$6,$11
	sra	$8,$8,31
	movn	$9,$12,$8
	and	$6,$8,$6
	addu	$12,$2,$9
	subu	$6,$11,$6
	xor	$10,$8,$10
	lbu	$8,0($12)
	sw	$6,8152($5)
	sw	$9,8156($5)
	addu	$11,$3,$10
	lbu	$12,0($11)
	sll	$6,$6,$8
	andi	$11,$6,0xffff
	sll	$8,$9,$8
	sb	$12,8219($5)
	sw	$8,8156($5)
	bne	$11,$0,$L2949
	sw	$6,8152($5)

	lw	$8,8168($5)
	addiu	$9,$6,-1
	xor	$9,$9,$6
	lw	$12,%got(ff_h264_norm_shift)($28)
	lbu	$13,0($8)
	sra	$9,$9,15
	addu	$12,$12,$9
	li	$11,-65536			# 0xffffffffffff0000
	lbu	$9,1($8)
	sll	$13,$13,9
	ori	$11,$11,0x1
	sll	$9,$9,1
	lbu	$12,0($12)
	addu	$11,$13,$11
	addu	$11,$11,$9
	li	$9,7			# 0x7
	subu	$9,$9,$12
	sll	$9,$11,$9
	addu	$6,$9,$6
	addiu	$8,$8,2
	sw	$8,8168($5)
	sw	$6,8152($5)
$L2949:
	andi	$10,$10,0x1
	li	$6,3			# 0x3
	li	$5,2			# 0x2
	b	$L2946
	movn	$6,$5,$10

$L2936:
	li	$5,131072			# 0x20000
	addu	$5,$16,$5
	lbu	$10,8219($5)
	andi	$6,$9,0xc0
	sll	$6,$6,1
	addu	$6,$6,$10
	addu	$6,$4,$6
	lbu	$12,0($6)
	lw	$11,8152($5)
	subu	$9,$9,$12
	sll	$6,$9,17
	subu	$8,$6,$11
	sra	$8,$8,31
	movn	$9,$12,$8
	and	$6,$8,$6
	addu	$12,$2,$9
	subu	$6,$11,$6
	xor	$10,$8,$10
	lbu	$8,0($12)
	sw	$6,8152($5)
	sw	$9,8156($5)
	addu	$11,$3,$10
	lbu	$12,0($11)
	sll	$6,$6,$8
	andi	$11,$6,0xffff
	sll	$8,$9,$8
	sb	$12,8219($5)
	sw	$8,8156($5)
	bne	$11,$0,$L2940
	sw	$6,8152($5)

	lw	$8,8168($5)
	addiu	$9,$6,-1
	xor	$9,$9,$6
	lw	$12,%got(ff_h264_norm_shift)($28)
	lbu	$13,0($8)
	sra	$9,$9,15
	addu	$12,$12,$9
	li	$11,-65536			# 0xffffffffffff0000
	lbu	$9,1($8)
	sll	$13,$13,9
	ori	$11,$11,0x1
	sll	$9,$9,1
	lbu	$12,0($12)
	addu	$11,$13,$11
	addu	$11,$11,$9
	li	$9,7			# 0x7
	subu	$9,$9,$12
	sll	$9,$11,$9
	addu	$6,$9,$6
	addiu	$8,$8,2
	sw	$8,8168($5)
	sw	$6,8152($5)
$L2940:
	andi	$10,$10,0x1
	li	$6,3			# 0x3
	li	$5,2			# 0x2
	b	$L2937
	movn	$6,$5,$10

$L2927:
	li	$5,131072			# 0x20000
	addu	$5,$16,$5
	lbu	$9,8219($5)
	andi	$6,$8,0xc0
	sll	$6,$6,1
	addu	$6,$6,$9
	addu	$6,$4,$6
	lbu	$11,0($6)
	lw	$10,8152($5)
	subu	$8,$8,$11
	sll	$6,$8,17
	subu	$7,$6,$10
	sra	$7,$7,31
	movn	$8,$11,$7
	and	$6,$7,$6
	addu	$11,$2,$8
	subu	$6,$10,$6
	xor	$9,$7,$9
	lbu	$7,0($11)
	sw	$6,8152($5)
	sw	$8,8156($5)
	addu	$10,$3,$9
	lbu	$11,0($10)
	sll	$6,$6,$7
	andi	$10,$6,0xffff
	sll	$7,$8,$7
	sb	$11,8219($5)
	sw	$7,8156($5)
	bne	$10,$0,$L2931
	sw	$6,8152($5)

	lw	$7,8168($5)
	addiu	$8,$6,-1
	xor	$8,$8,$6
	lw	$11,%got(ff_h264_norm_shift)($28)
	lbu	$12,0($7)
	sra	$8,$8,15
	addu	$11,$11,$8
	li	$10,-65536			# 0xffffffffffff0000
	lbu	$8,1($7)
	sll	$12,$12,9
	ori	$10,$10,0x1
	sll	$8,$8,1
	lbu	$11,0($11)
	addu	$10,$12,$10
	addu	$10,$10,$8
	li	$8,7			# 0x7
	subu	$8,$8,$11
	sll	$8,$10,$8
	addu	$6,$8,$6
	addiu	$7,$7,2
	sw	$7,8168($5)
	sw	$6,8152($5)
$L2931:
	andi	$9,$9,0x1
	li	$6,3			# 0x3
	li	$5,2			# 0x2
	b	$L2928
	movn	$6,$5,$9

$L2911:
	b	$L2914
	li	$25,3			# 0x3

$L2809:
	addu	$6,$4,$2
	lbu	$6,0($6)
	bne	$6,$3,$L2810
	sll	$6,$2,2

	addu	$6,$8,$6
	lw	$6,0($6)
	subu	$9,$2,$9
	andi	$6,$6,0x80
	b	$L2810
	movn	$2,$9,$6

$L2806:
	sll	$3,$5,2
	addu	$3,$8,$3
	lw	$3,0($3)
	lw	$10,-6272($6)
	srl	$3,$3,7
	andi	$3,$3,0x1
	beq	$10,$3,$L2807
	nop

	b	$L2805
	move	$3,$7

$L2897:
	ori	$21,$21,0x2047
	addu	$21,$16,$21
	move	$4,$20
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$5,$21

	bne	$2,$0,$L2899
	move	$4,$20

	li	$3,1			# 0x1
	b	$L2898
	li	$5,1			# 0x1

$L2955:
	addu	$5,$16,$5
	lbu	$9,8219($5)
	andi	$6,$8,0xc0
	sll	$6,$6,1
	addu	$6,$6,$9
	addu	$4,$4,$6
	lbu	$4,0($4)
	lw	$10,8152($5)
	subu	$8,$8,$4
	sll	$11,$8,17
	subu	$6,$11,$10
	sra	$6,$6,31
	movz	$4,$8,$6
	addu	$8,$2,$4
	and	$11,$6,$11
	subu	$2,$10,$11
	xor	$6,$6,$9
	lbu	$8,0($8)
	sw	$2,8152($5)
	sw	$4,8156($5)
	addu	$3,$3,$6
	lbu	$9,0($3)
	sll	$2,$2,$8
	sll	$4,$4,$8
	andi	$3,$2,0xffff
	sb	$9,8219($5)
	sw	$4,8156($5)
	bne	$3,$0,$L2956
	sw	$2,8152($5)

	lw	$3,8168($5)
	addiu	$4,$2,-1
	xor	$4,$4,$2
	lw	$9,%got(ff_h264_norm_shift)($28)
	lbu	$10,0($3)
	sra	$4,$4,15
	addu	$9,$9,$4
	li	$8,-65536			# 0xffffffffffff0000
	lbu	$4,1($3)
	sll	$10,$10,9
	ori	$8,$8,0x1
	sll	$4,$4,1
	lbu	$9,0($9)
	addu	$8,$10,$8
	addu	$8,$8,$4
	li	$4,7			# 0x7
	subu	$4,$4,$9
	sll	$4,$8,$4
	addu	$2,$4,$2
	addiu	$3,$3,2
	sw	$3,8168($5)
	sw	$2,8152($5)
$L2956:
	andi	$6,$6,0x1
	li	$2,3			# 0x3
	li	$3,2			# 0x2
	b	$L2953
	movn	$2,$3,$6

$L2899:
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	move	$5,$21

	li	$3,3			# 0x3
	li	$4,2			# 0x2
	movz	$3,$4,$2
	b	$L2898
	move	$5,$3

$L2817:
	lw	$8,1568($16)
	addu	$2,$8,$2
	lw	$2,0($2)
	srl	$2,$2,7
	b	$L2818
	andi	$2,$2,0x1

$L2894:
	addu	$2,$19,$2
	lbu	$2,0($2)
	b	$L2895
	sltu	$2,$0,$2

$L2790:
	addu	$3,$3,$4
	addu	$6,$8,$3
	b	$L2791
	lbu	$6,0($6)

$L3217:
	lh	$19,2($7)
	b	$L3006
	lh	$20,0($7)

$L2999:
	lw	$4,8768($16)
	sll	$4,$4,2
	addu	$4,$15,$4
	lw	$4,0($4)
	andi	$4,$4,0x80
	bne	$4,$0,$L2998
	nop

	slt	$4,$2,20
	bne	$4,$0,$L3246
	addiu	$5,$5,-9

	li	$20,-2			# 0xfffffffffffffffe
	and	$24,$24,$20
	addiu	$2,$2,-12
	sll	$24,$24,1
	sra	$4,$2,3
	addu	$4,$24,$4
	sll	$4,$4,1
	lw	$24,152($16)
	addiu	$4,$4,-1
	sra	$9,$4,2
	lw	$2,6168($16)
	mul	$20,$9,$24
	sll	$2,$2,2
	addiu	$2,$2,-1
	sra	$5,$2,2
	addu	$5,$20,$5
	sll	$5,$5,2
	addu	$5,$15,$5
	lw	$5,0($5)
	lw	$24,116($sp)
	and	$9,$24,$5
	beq	$9,$0,$L3224
	nop

	lw	$5,9748($16)
$L3234:
	lw	$25,124($sp)
	mul	$15,$4,$5
	addu	$9,$14,$25
	addu	$5,$15,$2
	lw	$9,0($9)
	sll	$5,$5,2
	addu	$5,$9,$5
	lw	$20,128($sp)
	lhu	$9,0($5)
	lw	$24,92($sp)
	addu	$14,$14,$20
	sh	$9,9176($24)
	lw	$9,4($14)
	lw	$14,9752($16)
	sra	$4,$4,1
	mul	$15,$4,$14
	lh	$5,2($5)
	addu	$4,$15,$9
	sra	$5,$5,1
	sra	$2,$2,1
	sh	$5,9178($24)
	addu	$2,$4,$2
	lb	$4,0($2)
	lw	$5,104($sp)
	b	$L2996
	sll	$4,$4,1

$L3089:
	lw	$8,40($sp)
	or	$8,$8,$2
	b	$L3088
	sw	$8,40($sp)

$L3207:
	b	$L2832
	addiu	$2,$21,3

$L3206:
	move	$4,$20
	.option	pic0
	jal	get_cabac_noinline
	.option	pic2
	addu	$5,$16,$5

	lw	$28,32($sp)
	b	$L2832
	addiu	$2,$2,1

$L3223:
	andi	$5,$5,0x40
	bne	$5,$0,$L3000
	nop

$L2995:
	lw	$5,104($sp)
$L3247:
	b	$L2996
	li	$4,-1			# 0xffffffffffffffff

$L3209:
	b	$L2847
	sw	$2,40($sp)

$L3208:
	li	$5,32			# 0x20
	.option	pic0
	jal	decode_cabac_intra_mb_type
	.option	pic2
	move	$6,$0

	lw	$28,32($sp)
	b	$L2832
	addiu	$2,$2,23

$L2913:
	andi	$9,$24,0xc0
	sll	$9,$9,1
	addu	$9,$9,$15
	addu	$9,$4,$9
	lbu	$19,0($9)
	lw	$25,8152($5)
	subu	$10,$24,$19
	sll	$9,$10,17
	subu	$24,$9,$25
	sra	$24,$24,31
	movn	$10,$19,$24
	addu	$19,$2,$10
	and	$9,$24,$9
	subu	$9,$25,$9
	xor	$15,$24,$15
	lbu	$24,0($19)
	sw	$9,8152($5)
	sw	$10,8156($5)
	addu	$25,$3,$15
	lbu	$19,0($25)
	sll	$9,$9,$24
	sll	$10,$10,$24
	andi	$25,$9,0xffff
	sb	$19,8235($5)
	sw	$10,8156($5)
	bne	$25,$0,$L2915
	sw	$9,8152($5)

	lw	$10,8168($5)
	addiu	$24,$9,-1
	xor	$24,$24,$9
	lbu	$19,0($10)
	sra	$24,$24,15
	lbu	$25,1($10)
	addu	$24,$7,$24
	sll	$19,$19,9
	lbu	$24,0($24)
	addu	$19,$19,$8
	sll	$25,$25,1
	addu	$25,$19,$25
	subu	$24,$6,$24
	sll	$24,$25,$24
	addu	$9,$24,$9
	addiu	$10,$10,2
	sw	$9,8152($5)
	sw	$10,8168($5)
$L2915:
	andi	$15,$15,0x1
	b	$L2906
	addiu	$9,$15,11

$L2807:
	addu	$5,$5,$9
	addu	$6,$4,$5
	move	$3,$7
	b	$L2805
	lbu	$7,0($6)

$L3073:
	b	$L3072
	andi	$fp,$fp,0x8

$L3210:
	beq	$4,$0,$L3247
	lw	$5,104($sp)

	b	$L3233
	lw	$4,9748($16)

$L2920:
	lw	$2,5940($19)
	sltu	$2,$2,2
	beq	$2,$0,$L3248
	li	$6,131072			# 0x20000

	b	$L3226
	li	$22,65536			# 0x10000

$L2846:
	li	$2,22			# 0x16
	b	$L2847
	sw	$2,40($sp)

$L2978:
	b	$L2977
	sw	$0,76($sp)

$L3224:
	andi	$5,$5,0x40
	beq	$5,$0,$L2995
	nop

	b	$L3234
	lw	$5,9748($16)

	.set	macro
	.set	reorder
	.end	decode_mb_cabac
	.size	decode_mb_cabac, .-decode_mb_cabac
	.section	.rodata.str1.4
	.align	2
$LC36:
	.ascii	"mb_type %d in %c slice too large at %d %d\012\000"
	.align	2
$LC37:
	.ascii	"B sub_mb_type %u out of range at %d %d\012\000"
	.align	2
$LC38:
	.ascii	"P sub_mb_type %u out of range at %d %d\012\000"
	.align	2
$LC39:
	.ascii	"ref %u overflow\012\000"
	.align	2
$LC40:
	.ascii	"cbp too large (%u) at %d %d\012\000"
	.align	2
$LC41:
	.ascii	"dquant out of range (%d) at %d %d\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_mb_cavlc
	.type	decode_mb_cavlc, @function
decode_mb_cavlc:
	.frame	$sp,288,$31		# vars= 208, regs= 10/0, args= 32, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-288
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,284($sp)
	sw	$fp,280($sp)
	sw	$23,276($sp)
	sw	$22,272($sp)
	sw	$21,268($sp)
	sw	$20,264($sp)
	sw	$19,260($sp)
	sw	$18,256($sp)
	sw	$17,252($sp)
	sw	$16,248($sp)
	.cprestore	32
	li	$17,131072			# 0x20000
	ori	$17,$17,0x1ad8
	lw	$25,2180($4)
	addu	$17,$4,$17
	move	$16,$4
	move	$4,$17
	lw	$22,6168($16)
	lw	$18,6172($16)
	lw	$23,152($16)
	jalr	$25
	lw	$20,11868($16)

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,-6284($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L3255
	lw	$28,32($sp)

	li	$3,5			# 0x5
	beq	$2,$3,$L3255
	li	$3,-1			# 0xffffffffffffffff

	lw	$2,6176($16)
	beq	$2,$3,$L3623
	nop

$L3256:
	addiu	$3,$2,-1
	beq	$2,$0,$L3255
	sw	$3,6176($16)

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$4,-6276($2)
	beq	$4,$0,$L3257
	nop

	lw	$4,6172($16)
	andi	$4,$4,0x1
	bne	$4,$0,$L3257
	nop

	bne	$3,$0,$L3258
	nop

	lw	$3,8456($16)
	lw	$5,8448($16)
	sra	$4,$3,3
	addu	$4,$5,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	srl	$4,$4,7
	addiu	$3,$3,1
	sw	$4,-6268($2)
	sw	$3,8456($16)
	sw	$4,-6272($2)
$L3257:
	.option	pic0
	jal	decode_mb_skip
	.option	pic2
	move	$4,$16

	lw	$31,284($sp)
	move	$2,$0
	lw	$fp,280($sp)
	lw	$23,276($sp)
	lw	$22,272($sp)
	lw	$21,268($sp)
	lw	$20,264($sp)
	lw	$19,260($sp)
	lw	$18,256($sp)
	lw	$17,252($sp)
	lw	$16,248($sp)
	j	$31
	addiu	$sp,$sp,288

$L3255:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$2,-6276($3)
	bne	$2,$0,$L3624
	nop

	lw	$4,8500($16)
	lw	$2,8456($16)
	xori	$4,$4,0x3
	sltu	$4,$0,$4
	lw	$6,8448($16)
	sw	$4,-6272($3)
$L3261:
	sra	$3,$2,3
	addu	$6,$6,$3
	sw	$0,8748($16)
	lbu	$5,0($6)
	lbu	$7,3($6)
	lbu	$4,1($6)
	sll	$5,$5,24
	lbu	$3,2($6)
	or	$5,$7,$5
	sll	$4,$4,16
	sll	$3,$3,8
	or	$4,$5,$4
	or	$4,$4,$3
	andi	$3,$2,0x7
	sll	$3,$4,$3
	li	$4,134217728			# 0x8000000
	sltu	$4,$3,$4
	beq	$4,$0,$L3625
	li	$4,-65536			# 0xffffffffffff0000

	and	$4,$3,$4
	bne	$4,$0,$L3264
	srl	$4,$3,16

	move	$4,$3
	li	$5,8			# 0x8
	move	$7,$0
$L3265:
	andi	$6,$4,0xff00
	bne	$6,$0,$L3266
	nop

	move	$5,$7
$L3267:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$2,$2,32
	addu	$4,$6,$4
	lbu	$4,0($4)
	addu	$4,$4,$5
	sll	$4,$4,1
	addiu	$4,$4,-31
	subu	$2,$2,$4
	sw	$2,8456($16)
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	srl	$3,$3,$4
	lw	$2,-6284($2)
	addiu	$3,$3,-1
	li	$4,3			# 0x3
	sw	$3,40($sp)
	beq	$2,$4,$L3626
	move	$7,$3

$L3268:
	li	$4,2			# 0x2
	beq	$2,$4,$L3627
	sltu	$2,$3,5

$L3271:
	sltu	$2,$7,26
	beq	$2,$0,$L3628
	move	$21,$0

	lw	$4,40($sp)
	lui	$2,%hi(i_mb_type_info)
	addiu	$2,$2,%lo(i_mb_type_info)
	sll	$7,$7,2
	sll	$4,$4,2
	addu	$7,$7,$2
	addu	$4,$4,$2
	lbu	$3,2($7)
	lhu	$2,0($4)
	lbu	$19,3($7)
	sw	$3,8760($16)
	sw	$2,40($sp)
$L3270:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$3,-6272($3)
	beq	$3,$0,$L3692
	mul	$3,$23,$18

	ori	$2,$2,0x80
	sw	$2,40($sp)
$L3692:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	addu	$18,$3,$22
	lw	$3,-6288($2)
	lw	$4,-6296($2)
	addu	$3,$3,$18
	sb	$4,0($3)
	lw	$5,40($sp)
	andi	$3,$5,0x4
	beq	$3,$0,$L3275
	nop

	lw	$15,8456($16)
	subu	$2,$0,$15
	andi	$2,$2,0x7
	bne	$2,$0,$L3629
	nop

$L3276:
	li	$10,65536			# 0x10000
	lw	$6,8448($16)
	ori	$13,$10,0xdbc
	ori	$12,$10,0xd6c
	ori	$11,$10,0xd7c
	move	$2,$15
	move	$4,$0
	ori	$10,$10,0xdac
	li	$14,16			# 0x10
$L3277:
	sra	$5,$2,3
	addu	$5,$6,$5
	srl	$7,$4,2
	srl	$3,$4,3
	lbu	$9,0($5)
	andi	$7,$7,0x1
	sll	$3,$3,2
	lbu	$8,3($5)
	addu	$3,$7,$3
	lbu	$7,1($5)
	andi	$24,$4,0x3
	lbu	$5,2($5)
	sll	$3,$3,3
	sll	$9,$9,24
	addu	$3,$3,$24
	or	$9,$8,$9
	sll	$7,$7,16
	sll	$3,$3,2
	or	$9,$9,$7
	sll	$5,$5,8
	or	$9,$9,$5
	addu	$8,$3,$12
	andi	$5,$2,0x7
	addiu	$7,$2,8
	sll	$9,$9,$5
	sll	$8,$8,1
	srl	$9,$9,24
	addu	$8,$16,$8
	sra	$5,$7,3
	sw	$7,8456($16)
	sh	$9,0($8)
	addu	$5,$6,$5
	lbu	$25,0($5)
	lbu	$24,3($5)
	lbu	$8,1($5)
	lbu	$9,2($5)
	sll	$5,$25,24
	or	$5,$24,$5
	sll	$8,$8,16
	or	$5,$5,$8
	sll	$9,$9,8
	addiu	$8,$3,1
	or	$5,$5,$9
	addu	$24,$8,$12
	andi	$7,$7,0x7
	addiu	$9,$2,16
	sll	$7,$5,$7
	sll	$24,$24,1
	srl	$7,$7,24
	addu	$24,$16,$24
	sra	$5,$9,3
	sw	$9,8456($16)
	sh	$7,0($24)
	addu	$5,$6,$5
	lbu	$25,0($5)
	lbu	$24,3($5)
	lbu	$7,1($5)
	sll	$25,$25,24
	lbu	$5,2($5)
	or	$25,$24,$25
	sll	$7,$7,16
	or	$25,$25,$7
	sll	$5,$5,8
	addiu	$7,$3,2
	or	$25,$25,$5
	andi	$9,$9,0x7
	addu	$24,$7,$12
	sll	$25,$25,$9
	sll	$24,$24,1
	addiu	$9,$2,24
	srl	$25,$25,24
	addu	$24,$16,$24
	sra	$5,$9,3
	sw	$9,8456($16)
	sh	$25,0($24)
	addu	$5,$6,$5
	lbu	$17,0($5)
	lbu	$19,3($5)
	lbu	$25,1($5)
	lbu	$24,2($5)
	sll	$17,$17,24
	sll	$5,$25,16
	or	$17,$19,$17
	or	$17,$17,$5
	sll	$24,$24,8
	addiu	$5,$3,3
	or	$17,$17,$24
	andi	$9,$9,0x7
	addu	$25,$5,$12
	addiu	$24,$2,32
	sll	$17,$17,$9
	sll	$25,$25,1
	srl	$17,$17,24
	addu	$25,$16,$25
	sra	$9,$24,3
	sw	$24,8456($16)
	sh	$17,0($25)
	addu	$9,$6,$9
	lbu	$17,0($9)
	lbu	$19,3($9)
	lbu	$25,1($9)
	sll	$17,$17,24
	lbu	$9,2($9)
	or	$17,$19,$17
	sll	$25,$25,16
	or	$17,$17,$25
	sll	$9,$9,8
	or	$17,$17,$9
	andi	$24,$24,0x7
	addu	$25,$3,$11
	sll	$17,$17,$24
	sll	$25,$25,1
	addiu	$24,$2,40
	srl	$17,$17,24
	addu	$25,$16,$25
	sra	$9,$24,3
	sw	$24,8456($16)
	sh	$17,0($25)
	addu	$9,$6,$9
	lbu	$17,0($9)
	lbu	$19,3($9)
	lbu	$25,1($9)
	sll	$17,$17,24
	lbu	$9,2($9)
	or	$17,$19,$17
	sll	$25,$25,16
	or	$17,$17,$25
	sll	$9,$9,8
	or	$17,$17,$9
	andi	$24,$24,0x7
	addu	$25,$8,$11
	sll	$17,$17,$24
	sll	$25,$25,1
	addiu	$24,$2,48
	srl	$17,$17,24
	addu	$25,$16,$25
	sra	$9,$24,3
	sw	$24,8456($16)
	addu	$9,$6,$9
	sh	$17,0($25)
	lbu	$17,0($9)
	lbu	$19,3($9)
	lbu	$25,1($9)
	sll	$17,$17,24
	lbu	$9,2($9)
	or	$17,$19,$17
	sll	$25,$25,16
	or	$17,$17,$25
	sll	$9,$9,8
	or	$17,$17,$9
	andi	$24,$24,0x7
	addu	$25,$7,$11
	sll	$17,$17,$24
	sll	$25,$25,1
	addiu	$24,$2,56
	srl	$17,$17,24
	addu	$25,$16,$25
	sra	$9,$24,3
	sw	$24,8456($16)
	sh	$17,0($25)
	addu	$9,$6,$9
	lbu	$17,0($9)
	lbu	$19,3($9)
	lbu	$25,1($9)
	sll	$17,$17,24
	lbu	$9,2($9)
	or	$17,$19,$17
	sll	$25,$25,16
	or	$17,$17,$25
	sll	$9,$9,8
	or	$17,$17,$9
	andi	$24,$24,0x7
	addu	$25,$5,$11
	sll	$17,$17,$24
	sll	$25,$25,1
	addiu	$24,$2,64
	srl	$17,$17,24
	addu	$25,$16,$25
	sra	$9,$24,3
	sw	$24,8456($16)
	sh	$17,0($25)
	addu	$9,$6,$9
	lbu	$17,0($9)
	lbu	$19,3($9)
	lbu	$25,1($9)
	sll	$17,$17,24
	lbu	$9,2($9)
	or	$17,$19,$17
	sll	$25,$25,16
	or	$17,$17,$25
	sll	$9,$9,8
	or	$17,$17,$9
	andi	$24,$24,0x7
	addu	$25,$3,$10
	sll	$17,$17,$24
	sll	$25,$25,1
	addiu	$24,$2,72
	srl	$17,$17,24
	addu	$25,$16,$25
	sra	$9,$24,3
	sw	$24,8456($16)
	sh	$17,0($25)
	addu	$9,$6,$9
	lbu	$17,0($9)
	lbu	$19,3($9)
	lbu	$25,1($9)
	sll	$17,$17,24
	lbu	$9,2($9)
	or	$17,$19,$17
	sll	$25,$25,16
	or	$17,$17,$25
	sll	$9,$9,8
	or	$17,$17,$9
	andi	$24,$24,0x7
	addu	$25,$8,$10
	sll	$17,$17,$24
	sll	$25,$25,1
	addiu	$24,$2,80
	srl	$17,$17,24
	addu	$25,$16,$25
	sra	$9,$24,3
	sw	$24,8456($16)
	sh	$17,0($25)
	addu	$9,$6,$9
	lbu	$17,0($9)
	lbu	$19,3($9)
	lbu	$25,1($9)
	sll	$17,$17,24
	lbu	$9,2($9)
	or	$17,$19,$17
	sll	$25,$25,16
	or	$17,$17,$25
	sll	$9,$9,8
	or	$17,$17,$9
	andi	$24,$24,0x7
	addu	$25,$7,$10
	sll	$17,$17,$24
	sll	$25,$25,1
	addiu	$24,$2,88
	srl	$17,$17,24
	addu	$25,$16,$25
	sra	$9,$24,3
	sw	$24,8456($16)
	sh	$17,0($25)
	addu	$9,$6,$9
	lbu	$17,0($9)
	lbu	$19,3($9)
	lbu	$25,1($9)
	sll	$17,$17,24
	lbu	$9,2($9)
	or	$17,$19,$17
	sll	$25,$25,16
	or	$17,$17,$25
	sll	$9,$9,8
	or	$17,$17,$9
	andi	$24,$24,0x7
	addu	$25,$5,$10
	sll	$17,$17,$24
	sll	$25,$25,1
	addiu	$24,$2,96
	srl	$17,$17,24
	addu	$25,$16,$25
	sra	$9,$24,3
	sw	$24,8456($16)
	addu	$9,$6,$9
	sh	$17,0($25)
	lbu	$20,0($9)
	lbu	$19,3($9)
	lbu	$17,1($9)
	lbu	$25,2($9)
	sll	$9,$20,24
	sll	$17,$17,16
	or	$9,$19,$9
	or	$9,$9,$17
	sll	$25,$25,8
	or	$9,$9,$25
	andi	$24,$24,0x7
	addu	$25,$3,$13
	sll	$24,$9,$24
	sll	$25,$25,1
	addiu	$9,$2,104
	srl	$24,$24,24
	addu	$25,$16,$25
	sra	$3,$9,3
	sw	$9,8456($16)
	sh	$24,0($25)
	addu	$3,$6,$3
	lbu	$24,0($3)
	lbu	$17,3($3)
	lbu	$25,1($3)
	sll	$24,$24,24
	lbu	$3,2($3)
	or	$24,$17,$24
	sll	$25,$25,16
	or	$24,$24,$25
	sll	$3,$3,8
	or	$24,$24,$3
	andi	$9,$9,0x7
	addu	$8,$8,$13
	sll	$24,$24,$9
	sll	$8,$8,1
	addiu	$9,$2,112
	srl	$24,$24,24
	addu	$8,$16,$8
	sra	$3,$9,3
	sw	$9,8456($16)
	sh	$24,0($8)
	addu	$3,$6,$3
	lbu	$17,0($3)
	lbu	$25,3($3)
	lbu	$24,1($3)
	lbu	$8,2($3)
	sll	$3,$17,24
	or	$3,$25,$3
	sll	$24,$24,16
	or	$3,$3,$24
	sll	$8,$8,8
	or	$3,$3,$8
	andi	$9,$9,0x7
	addu	$7,$7,$13
	addiu	$8,$2,120
	sll	$9,$3,$9
	sll	$7,$7,1
	srl	$9,$9,24
	addu	$7,$16,$7
	sra	$3,$8,3
	sw	$8,8456($16)
	sh	$9,0($7)
	addu	$3,$6,$3
	lbu	$25,0($3)
	lbu	$24,3($3)
	lbu	$9,1($3)
	lbu	$7,2($3)
	sll	$3,$25,24
	or	$3,$24,$3
	sll	$9,$9,16
	or	$3,$3,$9
	sll	$7,$7,8
	or	$3,$3,$7
	andi	$8,$8,0x7
	addu	$5,$5,$13
	sll	$8,$3,$8
	sll	$5,$5,1
	srl	$8,$8,24
	addiu	$2,$2,128
	addu	$5,$16,$5
	addiu	$4,$4,1
	sh	$8,0($5)
	bne	$4,$14,$L3277
	sw	$2,8456($16)

	li	$8,65536			# 0x10000
	addiu	$2,$15,2048
	ori	$9,$8,0xd7c
	move	$3,$2
	move	$5,$0
	ori	$8,$8,0xd6c
	li	$14,8			# 0x8
$L3278:
	sra	$7,$3,3
	addu	$7,$6,$7
	lbu	$12,0($7)
	lbu	$11,3($7)
	lbu	$10,1($7)
	andi	$13,$5,0x3
	srl	$4,$5,2
	lbu	$7,2($7)
	addiu	$13,$13,64
	sll	$4,$4,3
	sll	$12,$12,24
	addu	$4,$13,$4
	or	$12,$11,$12
	sll	$10,$10,16
	sll	$4,$4,2
	or	$12,$12,$10
	sll	$7,$7,8
	or	$12,$12,$7
	addu	$11,$4,$8
	andi	$7,$3,0x7
	addiu	$10,$3,8
	sll	$12,$12,$7
	sll	$11,$11,1
	srl	$12,$12,24
	addu	$11,$16,$11
	sra	$7,$10,3
	sw	$10,8456($16)
	sh	$12,0($11)
	addu	$7,$6,$7
	lbu	$12,0($7)
	lbu	$13,3($7)
	lbu	$11,1($7)
	sll	$12,$12,24
	lbu	$7,2($7)
	or	$12,$13,$12
	sll	$11,$11,16
	addiu	$13,$4,1
	or	$12,$12,$11
	sll	$7,$7,8
	or	$12,$12,$7
	andi	$10,$10,0x7
	addu	$11,$13,$8
	sll	$12,$12,$10
	sll	$11,$11,1
	addiu	$10,$3,16
	srl	$12,$12,24
	addu	$11,$16,$11
	sra	$7,$10,3
	sw	$10,8456($16)
	sh	$12,0($11)
	addu	$7,$6,$7
	lbu	$15,0($7)
	lbu	$12,3($7)
	lbu	$11,1($7)
	sll	$15,$15,24
	lbu	$7,2($7)
	or	$15,$12,$15
	sll	$11,$11,16
	addiu	$12,$4,2
	or	$15,$15,$11
	sll	$7,$7,8
	or	$15,$15,$7
	andi	$10,$10,0x7
	addu	$11,$12,$8
	sll	$15,$15,$10
	sll	$11,$11,1
	addiu	$10,$3,24
	srl	$15,$15,24
	addu	$11,$16,$11
	sra	$7,$10,3
	sw	$10,8456($16)
	sh	$15,0($11)
	addu	$7,$6,$7
	lbu	$24,0($7)
	lbu	$15,3($7)
	lbu	$11,1($7)
	sll	$24,$24,24
	lbu	$7,2($7)
	or	$24,$15,$24
	sll	$11,$11,16
	or	$24,$24,$11
	sll	$7,$7,8
	addiu	$11,$4,3
	or	$24,$24,$7
	andi	$10,$10,0x7
	addu	$15,$11,$8
	sll	$24,$24,$10
	sll	$15,$15,1
	addiu	$10,$3,32
	srl	$24,$24,24
	addu	$15,$16,$15
	sra	$7,$10,3
	sw	$10,8456($16)
	sh	$24,0($15)
	addu	$7,$6,$7
	lbu	$17,0($7)
	lbu	$25,3($7)
	lbu	$24,1($7)
	lbu	$15,2($7)
	sll	$7,$17,24
	sll	$24,$24,16
	or	$7,$25,$7
	or	$7,$7,$24
	sll	$15,$15,8
	or	$7,$7,$15
	andi	$10,$10,0x7
	addu	$15,$4,$9
	sll	$10,$7,$10
	sll	$15,$15,1
	addiu	$7,$3,40
	srl	$10,$10,24
	addu	$15,$16,$15
	sra	$4,$7,3
	sw	$7,8456($16)
	sh	$10,0($15)
	addu	$4,$6,$4
	lbu	$10,0($4)
	lbu	$24,3($4)
	lbu	$15,1($4)
	sll	$10,$10,24
	lbu	$4,2($4)
	sll	$15,$15,16
	or	$10,$24,$10
	or	$10,$10,$15
	sll	$4,$4,8
	or	$10,$10,$4
	andi	$7,$7,0x7
	addu	$13,$13,$9
	sll	$10,$10,$7
	sll	$13,$13,1
	addiu	$7,$3,48
	srl	$10,$10,24
	addu	$13,$16,$13
	sra	$4,$7,3
	sw	$7,8456($16)
	addu	$4,$6,$4
	sh	$10,0($13)
	lbu	$10,0($4)
	lbu	$15,3($4)
	lbu	$13,1($4)
	sll	$10,$10,24
	lbu	$4,2($4)
	or	$10,$15,$10
	sll	$13,$13,16
	or	$10,$10,$13
	sll	$4,$4,8
	or	$10,$10,$4
	andi	$7,$7,0x7
	addu	$12,$12,$9
	sll	$10,$10,$7
	sll	$12,$12,1
	addiu	$7,$3,56
	srl	$10,$10,24
	addu	$12,$16,$12
	sra	$4,$7,3
	sw	$7,8456($16)
	sh	$10,0($12)
	addu	$4,$6,$4
	lbu	$15,0($4)
	lbu	$13,3($4)
	lbu	$12,1($4)
	lbu	$10,2($4)
	sll	$4,$15,24
	or	$4,$13,$4
	sll	$12,$12,16
	or	$4,$4,$12
	sll	$10,$10,8
	or	$4,$4,$10
	andi	$7,$7,0x7
	addu	$11,$11,$9
	sll	$7,$4,$7
	sll	$11,$11,1
	srl	$7,$7,24
	addiu	$3,$3,64
	addu	$11,$16,$11
	addiu	$5,$5,1
	sh	$7,0($11)
	bne	$5,$14,$L3278
	sw	$3,8456($16)

	li	$7,65536			# 0x10000
	ori	$8,$7,0xd7c
	addiu	$2,$2,512
	move	$4,$0
	ori	$7,$7,0xd6c
	li	$13,8			# 0x8
$L3279:
	sra	$5,$2,3
	addu	$5,$6,$5
	lbu	$11,0($5)
	lbu	$10,3($5)
	lbu	$9,1($5)
	andi	$12,$4,0x3
	srl	$3,$4,2
	lbu	$5,2($5)
	addiu	$12,$12,80
	sll	$3,$3,3
	sll	$11,$11,24
	addu	$3,$12,$3
	or	$11,$10,$11
	sll	$9,$9,16
	sll	$3,$3,2
	or	$11,$11,$9
	sll	$5,$5,8
	or	$11,$11,$5
	addu	$10,$3,$7
	andi	$5,$2,0x7
	addiu	$9,$2,8
	sll	$11,$11,$5
	sll	$10,$10,1
	srl	$11,$11,24
	addu	$10,$16,$10
	sra	$5,$9,3
	sw	$9,8456($16)
	sh	$11,0($10)
	addu	$5,$6,$5
	lbu	$11,0($5)
	lbu	$12,3($5)
	lbu	$10,1($5)
	sll	$11,$11,24
	lbu	$5,2($5)
	or	$11,$12,$11
	sll	$10,$10,16
	addiu	$12,$3,1
	or	$11,$11,$10
	sll	$5,$5,8
	or	$11,$11,$5
	andi	$9,$9,0x7
	addu	$10,$12,$7
	sll	$11,$11,$9
	sll	$10,$10,1
	addiu	$9,$2,16
	srl	$11,$11,24
	addu	$10,$16,$10
	sra	$5,$9,3
	sw	$9,8456($16)
	sh	$11,0($10)
	addu	$5,$6,$5
	lbu	$14,0($5)
	lbu	$11,3($5)
	lbu	$10,1($5)
	sll	$14,$14,24
	lbu	$5,2($5)
	or	$14,$11,$14
	sll	$10,$10,16
	addiu	$11,$3,2
	or	$14,$14,$10
	sll	$5,$5,8
	or	$14,$14,$5
	andi	$9,$9,0x7
	addu	$10,$11,$7
	sll	$14,$14,$9
	sll	$10,$10,1
	addiu	$9,$2,24
	srl	$14,$14,24
	addu	$10,$16,$10
	sra	$5,$9,3
	sw	$9,8456($16)
	sh	$14,0($10)
	addu	$5,$6,$5
	lbu	$15,0($5)
	lbu	$14,3($5)
	lbu	$10,1($5)
	sll	$15,$15,24
	lbu	$5,2($5)
	or	$15,$14,$15
	sll	$10,$10,16
	or	$15,$15,$10
	sll	$5,$5,8
	addiu	$10,$3,3
	or	$15,$15,$5
	andi	$9,$9,0x7
	addu	$14,$10,$7
	sll	$15,$15,$9
	sll	$14,$14,1
	addiu	$9,$2,32
	srl	$15,$15,24
	addu	$14,$16,$14
	sra	$5,$9,3
	sw	$9,8456($16)
	sh	$15,0($14)
	addu	$5,$6,$5
	lbu	$25,0($5)
	lbu	$24,3($5)
	lbu	$15,1($5)
	lbu	$14,2($5)
	sll	$5,$25,24
	sll	$15,$15,16
	or	$5,$24,$5
	or	$5,$5,$15
	sll	$14,$14,8
	or	$5,$5,$14
	andi	$9,$9,0x7
	addu	$14,$3,$8
	sll	$9,$5,$9
	sll	$14,$14,1
	addiu	$5,$2,40
	srl	$9,$9,24
	addu	$14,$16,$14
	sra	$3,$5,3
	sw	$5,8456($16)
	sh	$9,0($14)
	addu	$3,$6,$3
	lbu	$9,0($3)
	lbu	$15,3($3)
	lbu	$14,1($3)
	sll	$9,$9,24
	lbu	$3,2($3)
	sll	$14,$14,16
	or	$9,$15,$9
	or	$9,$9,$14
	sll	$3,$3,8
	or	$9,$9,$3
	andi	$5,$5,0x7
	addu	$12,$12,$8
	sll	$9,$9,$5
	sll	$12,$12,1
	addiu	$5,$2,48
	srl	$9,$9,24
	addu	$12,$16,$12
	sra	$3,$5,3
	sw	$5,8456($16)
	addu	$3,$6,$3
	sh	$9,0($12)
	lbu	$9,0($3)
	lbu	$14,3($3)
	lbu	$12,1($3)
	sll	$9,$9,24
	lbu	$3,2($3)
	or	$9,$14,$9
	sll	$12,$12,16
	or	$9,$9,$12
	sll	$3,$3,8
	or	$9,$9,$3
	andi	$5,$5,0x7
	addu	$11,$11,$8
	sll	$9,$9,$5
	sll	$11,$11,1
	addiu	$5,$2,56
	srl	$9,$9,24
	addu	$11,$16,$11
	sra	$3,$5,3
	sw	$5,8456($16)
	sh	$9,0($11)
	addu	$3,$6,$3
	lbu	$14,0($3)
	lbu	$12,3($3)
	lbu	$11,1($3)
	lbu	$9,2($3)
	sll	$3,$14,24
	or	$3,$12,$3
	sll	$11,$11,16
	or	$3,$3,$11
	sll	$9,$9,8
	or	$3,$3,$9
	andi	$5,$5,0x7
	addu	$10,$10,$8
	sll	$5,$3,$5
	sll	$10,$10,1
	srl	$5,$5,24
	addiu	$2,$2,64
	addu	$10,$16,$10
	addiu	$4,$4,1
	sh	$5,0($10)
	bne	$4,$13,$L3279
	sw	$2,8456($16)

	lw	$2,1548($16)
	lw	$25,%call16(memset)($28)
	addu	$2,$2,$18
	sb	$0,0($2)
	lbu	$5,12096($16)
	lbu	$3,12352($16)
	lw	$4,9128($16)
	sll	$2,$18,4
	sw	$5,8740($16)
	sw	$3,8744($16)
	addu	$4,$4,$2
	li	$5,16			# 0x10
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,1568($16)
	sll	$18,$18,2
	addu	$18,$2,$18
	lw	$2,40($sp)
	sw	$2,0($18)
	move	$2,$0
$L3259:
	lw	$31,284($sp)
$L3694:
	lw	$fp,280($sp)
	lw	$23,276($sp)
	lw	$22,272($sp)
	lw	$21,268($sp)
	lw	$20,264($sp)
	lw	$19,260($sp)
	lw	$18,256($sp)
	lw	$17,252($sp)
	lw	$16,248($sp)
	j	$31
	addiu	$sp,$sp,288

$L3624:
	lw	$2,6172($16)
	andi	$2,$2,0x1
	bne	$2,$0,$L3630
	nop

	lw	$2,8456($16)
	lw	$6,8448($16)
	sra	$4,$2,3
	addu	$4,$6,$4
	lbu	$5,0($4)
	andi	$4,$2,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	srl	$4,$4,7
	addiu	$2,$2,1
	sw	$4,-6268($3)
	sw	$2,8456($16)
	b	$L3261
	sw	$4,-6272($3)

$L3275:
	lw	$3,-6268($2)
	beq	$3,$0,$L3693
	move	$4,$16

	lw	$3,5936($2)
	lw	$4,5940($2)
	sll	$3,$3,1
	sll	$4,$4,1
	sw	$4,5940($2)
	sw	$3,5936($2)
	move	$4,$16
$L3693:
	.option	pic0
	jal	fill_caches
	.option	pic2
	move	$6,$0

	lw	$5,40($sp)
	andi	$2,$5,0x7
	bne	$2,$0,$L3631
	lw	$28,32($sp)

	li	$2,4			# 0x4
	beq	$21,$2,$L3632
	andi	$2,$5,0x100

	bne	$2,$0,$L3633
	andi	$2,$5,0x8

	beq	$2,$0,$L3445
	andi	$2,$5,0x10

	li	$4,65536			# 0x10000
	addu	$10,$16,$4
	lw	$2,5944($10)
	beq	$2,$0,$L3305
	lw	$25,%got(ff_log2_tab)($28)

	ori	$4,$4,0x1730
	lw	$24,%got(ff_golomb_vlc_len)($28)
	lw	$15,%got(ff_ue_golomb_vlc_code)($28)
	addu	$4,$16,$4
	addiu	$9,$16,9456
	move	$3,$0
	move	$2,$0
	li	$8,4096			# 0x1000
	li	$11,1			# 0x1
	li	$12,2			# 0x2
	b	$L3458
	li	$14,134217728			# 0x8000000

$L3446:
$L3456:
	sll	$7,$3,5
	sll	$3,$3,3
	addu	$3,$3,$7
	addiu	$3,$3,12
	addu	$3,$9,$3
	sw	$6,24($3)
	sw	$6,0($3)
	sw	$6,8($3)
	sw	$6,16($3)
	lw	$6,5944($10)
	addiu	$2,$2,1
	sltu	$7,$2,$6
	addiu	$4,$4,4
	beq	$7,$0,$L3634
	move	$3,$2

$L3458:
	sll	$6,$2,1
	sll	$6,$8,$6
	and	$6,$6,$5
	beq	$6,$0,$L3446
	li	$6,-1			# 0xffffffffffffffff

	lw	$6,0($4)
	beq	$6,$11,$L3448
	move	$7,$0

	beq	$6,$12,$L3636
	nop

	lw	$22,8456($16)
	lw	$7,8448($16)
	sra	$21,$22,3
	addu	$7,$7,$21
	lbu	$23,0($7)
	lbu	$fp,3($7)
	lbu	$21,1($7)
	sll	$23,$23,24
	lbu	$7,2($7)
	or	$23,$fp,$23
	sll	$21,$21,16
	sll	$7,$7,8
	or	$21,$23,$21
	or	$21,$21,$7
	andi	$7,$22,0x7
	sll	$7,$21,$7
	sltu	$21,$7,$14
	beq	$21,$0,$L3637
	li	$23,-65536			# 0xffffffffffff0000

	and	$21,$7,$23
	bne	$21,$0,$L3452
	srl	$21,$7,16

	move	$21,$7
	li	$fp,8			# 0x8
	move	$23,$0
$L3453:
	andi	$13,$21,0xff00
	beq	$13,$0,$L3454
	nop

	srl	$21,$21,8
	move	$23,$fp
$L3454:
	addu	$21,$25,$21
	lbu	$21,0($21)
	addiu	$22,$22,32
	addu	$21,$21,$23
	sll	$21,$21,1
	addiu	$21,$21,-31
	subu	$22,$22,$21
	srl	$7,$7,$21
	sw	$22,8456($16)
	b	$L3448
	addiu	$7,$7,-1

$L3625:
	lw	$4,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$4,$4,$3
	lbu	$4,0($4)
	addu	$2,$4,$2
	lw	$4,%got(ff_ue_golomb_vlc_code)($28)
	sw	$2,8456($16)
	li	$2,65536			# 0x10000
	addu	$3,$4,$3
	addu	$2,$16,$2
	lbu	$3,0($3)
	lw	$2,-6284($2)
	li	$4,3			# 0x3
	sw	$3,40($sp)
	bne	$2,$4,$L3268
	move	$7,$3

$L3626:
	sltu	$2,$3,23
	beq	$2,$0,$L3269
	lui	$2,%hi(b_mb_type_info)

	sll	$3,$3,2
	addiu	$2,$2,%lo(b_mb_type_info)
$L3609:
	addu	$3,$3,$2
	lhu	$2,0($3)
	lbu	$21,2($3)
	sw	$2,40($sp)
	b	$L3270
	move	$19,$0

$L3266:
	b	$L3267
	srl	$4,$4,8

$L3264:
	li	$5,24			# 0x18
	b	$L3265
	li	$7,16			# 0x10

$L3630:
	lw	$2,8456($16)
	b	$L3261
	lw	$6,8448($16)

$L3629:
	addu	$15,$15,$2
	b	$L3276
	sw	$15,8456($16)

$L3631:
	andi	$2,$5,0x1
	beq	$2,$0,$L3282
	nop

	bne	$20,$0,$L3283
	nop

	lw	$7,8456($16)
	lw	$6,8448($16)
$L3284:
	lui	$4,%hi(scan8)
	addiu	$4,$4,%lo(scan8)
	move	$3,$0
	b	$L3289
	li	$12,2			# 0x2

$L3287:
	lbu	$5,0($9)
	addu	$5,$16,$5
	beq	$8,$0,$L3288
	sb	$2,8776($5)

$L3638:
	lw	$7,8456($16)
$L3289:
	addu	$2,$3,$4
	lbu	$2,0($2)
	sra	$5,$7,3
	addu	$2,$16,$2
	addu	$5,$6,$5
	lbu	$10,0($5)
	lb	$5,8768($2)
	lb	$2,8775($2)
	andi	$8,$7,0x7
	sll	$10,$10,$8
	slt	$8,$5,$2
	movn	$2,$5,$8
	andi	$10,$10,0x00ff
	addu	$9,$3,$4
	addiu	$5,$7,1
	addiu	$3,$3,1
	slt	$11,$2,0
	srl	$10,$10,7
	slt	$8,$3,16
	movn	$2,$12,$11
	bne	$10,$0,$L3287
	sw	$5,8456($16)

	sra	$10,$5,3
	addu	$10,$6,$10
	lbu	$13,0($10)
	lbu	$14,3($10)
	lbu	$11,2($10)
	sll	$13,$13,24
	lbu	$10,1($10)
	or	$13,$14,$13
	sll	$11,$11,8
	or	$11,$13,$11
	sll	$10,$10,16
	or	$10,$11,$10
	andi	$5,$5,0x7
	sll	$5,$10,$5
	srl	$5,$5,29
	slt	$2,$5,$2
	xori	$2,$2,0x1
	addu	$2,$2,$5
	lbu	$5,0($9)
	addiu	$7,$7,4
	addu	$5,$16,$5
	sw	$7,8456($16)
	bne	$8,$0,$L3638
	sb	$2,8776($5)

$L3288:
	lw	$2,6172($16)
	lw	$5,152($16)
	lw	$4,6168($16)
	mul	$6,$5,$2
	lw	$3,8816($16)
	addu	$2,$6,$4
	sll	$2,$2,3
	lbu	$4,8791($16)
	addu	$3,$3,$2
	sb	$4,0($3)
	lw	$3,8816($16)
	lbu	$4,8799($16)
	addu	$3,$3,$2
	sb	$4,1($3)
	lw	$3,8816($16)
	lbu	$4,8807($16)
	addu	$3,$3,$2
	sb	$4,2($3)
	lw	$3,8816($16)
	lbu	$4,8815($16)
	addu	$3,$3,$2
	sb	$4,3($3)
	lw	$3,8816($16)
	lbu	$4,8812($16)
	addu	$3,$3,$2
	sb	$4,4($3)
	lw	$3,8816($16)
	lbu	$4,8813($16)
	addu	$3,$3,$2
	sb	$4,5($3)
	lw	$4,8816($16)
	lbu	$3,8814($16)
	addu	$2,$4,$2
	sb	$3,6($2)
	lw	$2,8984($16)
	andi	$2,$2,0x8000
	bne	$2,$0,$L3292
	lui	$2,%hi(top.10290)

	lb	$3,8788($16)
	addiu	$2,$2,%lo(top.10290)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L3293
	move	$7,$3

	bne	$3,$0,$L3639
	nop

$L3294:
	lb	$3,8789($16)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L3293
	move	$7,$3

	bne	$3,$0,$L3640
	nop

$L3295:
	lb	$3,8790($16)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L3293
	move	$7,$3

	bne	$3,$0,$L3641
	nop

$L3296:
	lb	$3,8791($16)
	addu	$2,$2,$3
	lb	$2,0($2)
	bltz	$2,$L3293
	move	$7,$2

	bne	$2,$0,$L3642
	nop

$L3292:
	lw	$2,8992($16)
	andi	$2,$2,0x8000
	bne	$2,$0,$L3298
	lui	$2,%hi(left.10291)

	lb	$3,8788($16)
	addiu	$2,$2,%lo(left.10291)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L3299
	move	$7,$3

	bne	$3,$0,$L3643
	nop

$L3300:
	lb	$3,8796($16)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L3299
	move	$7,$3

	bne	$3,$0,$L3644
	nop

$L3301:
	lb	$3,8804($16)
	addu	$3,$2,$3
	lb	$3,0($3)
	bltz	$3,$L3299
	move	$7,$3

	bne	$3,$0,$L3645
	nop

$L3302:
	lb	$3,8812($16)
	addu	$2,$2,$3
	lb	$2,0($2)
	bltz	$2,$L3299
	move	$7,$2

	beq	$2,$0,$L3298
	nop

	sb	$2,8812($16)
$L3298:
	.option	pic0
	jal	get_ue_golomb
	.option	pic2
	addiu	$4,$16,8448

	move	$5,$2
	.option	pic0
	jal	check_intra_pred_mode
	.option	pic2
	move	$4,$16

	bltz	$2,$L3304
	lw	$28,32($sp)

	sw	$2,8756($16)
	lw	$5,40($sp)
$L3305:
	andi	$2,$5,0x78
$L3691:
	bne	$2,$0,$L3646
	nop

$L3521:
	andi	$2,$5,0x2
	beq	$2,$0,$L3647
	nop

$L3522:
	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	beq	$20,$0,$L3525
	sw	$19,8664($2)

	andi	$2,$19,0xf
	beq	$2,$0,$L3525
	andi	$2,$5,0x7

	beq	$2,$0,$L3603
	nop

	lw	$6,8448($16)
$L3526:
	lw	$3,1568($16)
	sll	$2,$18,2
	addu	$2,$3,$2
	sw	$5,0($2)
	b	$L3529
	lw	$5,40($sp)

$L3269:
	addiu	$7,$3,-23
	b	$L3271
	sw	$7,40($sp)

$L3623:
	.option	pic0
	jal	get_ue_golomb
	.option	pic2
	addiu	$4,$16,8448

	lw	$28,32($sp)
	b	$L3256
	sw	$2,6176($16)

$L3627:
	beq	$2,$0,$L3272
	lui	$2,%hi(p_mb_type_info)

	sll	$3,$3,2
	b	$L3609
	addiu	$2,$2,%lo(p_mb_type_info)

$L3525:
	lw	$3,1568($16)
	sll	$2,$18,2
	addu	$2,$3,$2
	bne	$19,$0,$L3648
	sw	$5,0($2)

	lw	$5,40($sp)
	andi	$2,$5,0x2
	beq	$2,$0,$L3530
	addiu	$3,$16,9092

	lw	$6,8448($16)
$L3529:
	andi	$2,$5,0x7
	beq	$2,$0,$L3531
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lw	$20,6864($2)
$L3532:
	andi	$2,$5,0x80
	beq	$2,$0,$L3533
	nop

	lw	$4,2056($16)
	beq	$4,$0,$L3534
	li	$3,131072			# 0x20000

	li	$2,131072			# 0x20000
	ori	$3,$2,0x23f4
	ori	$2,$2,0x2444
	addu	$2,$16,$2
	sw	$2,108($sp)
	addu	$3,$16,$3
	lui	$2,%hi(luma_dc_field_scan)
	sw	$3,104($sp)
	addiu	$2,$2,%lo(luma_dc_field_scan)
$L3535:
	lw	$7,8456($16)
	sra	$3,$7,3
	addu	$6,$6,$3
	lbu	$8,0($6)
	lbu	$10,3($6)
	lbu	$9,1($6)
	lbu	$3,2($6)
	sll	$8,$8,24
	or	$8,$10,$8
	sll	$6,$9,16
	sll	$3,$3,8
	or	$6,$8,$6
	or	$6,$6,$3
	andi	$3,$7,0x7
	sll	$3,$6,$3
	li	$6,134217728			# 0x8000000
	sltu	$6,$3,$6
	beq	$6,$0,$L3649
	lw	$6,%got(ff_golomb_vlc_len)($28)

	li	$6,-65536			# 0xffffffffffff0000
	and	$6,$3,$6
	beq	$6,$0,$L3650
	move	$6,$3

	srl	$6,$3,16
	li	$9,24			# 0x18
	li	$8,16			# 0x10
$L3540:
	andi	$10,$6,0xff00
	beq	$10,$0,$L3541
	nop

	srl	$6,$6,8
	move	$8,$9
$L3541:
	lw	$9,%got(ff_log2_tab)($28)
	addiu	$7,$7,32
	addu	$6,$9,$6
	lbu	$6,0($6)
	addu	$6,$6,$8
	sll	$6,$6,1
	addiu	$6,$6,-31
	srl	$3,$3,$6
	andi	$8,$3,0x1
	subu	$6,$7,$6
	beq	$8,$0,$L3542
	sw	$6,8456($16)

	srl	$3,$3,1
	subu	$3,$0,$3
$L3543:
	move	$7,$3
$L3538:
	addiu	$3,$7,26
	sltu	$3,$3,52
	beq	$3,$0,$L3651
	lui	$6,%hi($LC41)

	addu	$4,$7,$4
	sltu	$6,$4,52
	sw	$4,2056($16)
	bne	$6,$0,$L3545
	move	$3,$4

	bltz	$4,$L3652
	addiu	$3,$4,52

	addiu	$3,$4,-52
	sw	$3,2056($16)
	move	$4,$3
$L3545:
	andi	$3,$3,0xff
	andi	$7,$4,0xff
	addu	$3,$16,$3
	addu	$7,$16,$7
	lbu	$6,12096($3)
	lbu	$3,12352($7)
	andi	$5,$5,0x2
	sw	$6,8740($16)
	bne	$5,$0,$L3653
	sw	$3,8744($16)

	lw	$12,108($sp)
	lw	$13,108($sp)
	lw	$14,108($sp)
	lui	$23,%hi(scan8)
	li	$4,1			# 0x1
	li	$3,2			# 0x2
	move	$2,$0
	addiu	$12,$12,16
	addiu	$13,$13,32
	addiu	$14,$14,48
	move	$22,$17
	sw	$19,112($sp)
	sw	$18,132($sp)
	sw	$17,136($sp)
	addiu	$23,$23,%lo(scan8)
	li	$fp,3			# 0x3
	move	$21,$0
	sw	$12,116($sp)
	sw	$13,120($sp)
	sw	$14,128($sp)
	move	$19,$2
	move	$18,$3
	move	$17,$4
$L3571:
	li	$3,1			# 0x1
	lw	$4,112($sp)
	sll	$2,$3,$21
	and	$2,$2,$4
	beq	$2,$0,$L3552
	lw	$2,40($sp)

	li	$5,16777216			# 0x1000000
	and	$3,$2,$5
	bne	$3,$0,$L3553
	andi	$3,$2,0x7

	li	$6,3			# 0x3
	movn	$6,$0,$3
	addiu	$3,$6,14800
	sll	$3,$3,2
	lw	$2,2056($16)
	addu	$3,$16,$3
	lw	$3,4($3)
	lw	$9,104($sp)
	sll	$2,$2,6
	addu	$2,$3,$2
	li	$10,16			# 0x10
	move	$4,$16
	move	$5,$20
	move	$6,$22
	move	$7,$19
	sw	$2,20($sp)
	sw	$9,16($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$10,24($sp)

	bltz	$2,$L3304
	lw	$3,40($sp)

	li	$12,3			# 0x3
	andi	$3,$3,0x7
	movn	$12,$0,$3
	addiu	$3,$12,14800
	sll	$3,$3,2
	lw	$2,2056($16)
	addu	$3,$16,$3
	lw	$3,4($3)
	lw	$13,104($sp)
	sll	$2,$2,6
	addu	$2,$3,$2
	li	$14,16			# 0x10
	move	$4,$16
	move	$5,$20
	addiu	$6,$22,32
	move	$7,$17
	sw	$2,20($sp)
	sw	$13,16($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$14,24($sp)

	bltz	$2,$L3304
	lw	$3,40($sp)

	li	$4,3			# 0x3
	andi	$3,$3,0x7
	movn	$4,$0,$3
	addiu	$3,$4,14800
	sll	$3,$3,2
	lw	$2,2056($16)
	addu	$3,$16,$3
	lw	$3,4($3)
	lw	$9,104($sp)
	sll	$2,$2,6
	addu	$2,$3,$2
	li	$10,16			# 0x10
	move	$4,$16
	move	$5,$20
	addiu	$6,$22,64
	move	$7,$18
	sw	$2,20($sp)
	sw	$9,16($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$10,24($sp)

	bltz	$2,$L3304
	lw	$3,40($sp)

	li	$12,3			# 0x3
	andi	$3,$3,0x7
	movn	$12,$0,$3
	addiu	$3,$12,14800
	sll	$3,$3,2
	lw	$2,2056($16)
	addu	$3,$16,$3
	lw	$3,4($3)
	lw	$13,104($sp)
	sll	$2,$2,6
	addu	$2,$3,$2
	li	$14,16			# 0x10
	move	$4,$16
	move	$5,$20
	addiu	$6,$22,96
	move	$7,$fp
	sw	$2,20($sp)
	sw	$13,16($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$14,24($sp)

	bltz	$2,$L3686
	li	$2,-1			# 0xffffffffffffffff

$L3562:
	addiu	$21,$21,1
	li	$3,4			# 0x4
	addiu	$22,$22,128
	addiu	$fp,$fp,4
	addiu	$19,$19,4
	addiu	$23,$23,4
	addiu	$18,$18,4
	bne	$21,$3,$L3571
	addiu	$17,$17,4

	lw	$19,112($sp)
	lw	$18,132($sp)
	lw	$17,136($sp)
$L3551:
	andi	$2,$19,0x30
	beq	$2,$0,$L3572
	lui	$22,%hi(chroma_dc_scan)

	addiu	$22,$22,%lo(chroma_dc_scan)
	li	$21,4			# 0x4
	move	$4,$16
	move	$5,$20
	addiu	$6,$17,512
	li	$7,26			# 0x1a
	sw	$22,16($sp)
	sw	$0,20($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$21,24($sp)

	bltz	$2,$L3304
	move	$5,$20

	move	$4,$16
	addiu	$6,$17,640
	li	$7,26			# 0x1a
	sw	$22,16($sp)
	sw	$21,24($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$0,20($sp)

	bltz	$2,$L3686
	li	$2,-1			# 0xffffffffffffffff

$L3572:
	andi	$19,$19,0x20
	bne	$19,$0,$L3654
	lw	$3,40($sp)

	b	$L3613
	addiu	$2,$16,9080

$L3272:
	addiu	$7,$3,-5
	b	$L3271
	sw	$7,40($sp)

$L3636:
	lw	$21,8456($16)
	lw	$7,8448($16)
	sra	$22,$21,3
	addu	$7,$7,$22
	lbu	$22,0($7)
	andi	$7,$21,0x7
	sll	$7,$22,$7
	andi	$7,$7,0x00ff
	addiu	$21,$21,1
	srl	$7,$7,7
	sw	$21,8456($16)
	xori	$7,$7,0x1
$L3448:
	sltu	$6,$7,$6
	beq	$6,$0,$L3501
	nop

	sll	$6,$7,8
	addu	$7,$6,$7
	sll	$6,$7,16
	b	$L3456
	addu	$6,$7,$6

$L3283:
	lw	$7,8456($16)
	lw	$6,8448($16)
	sra	$2,$7,3
	addu	$2,$6,$2
	lbu	$3,0($2)
	andi	$2,$7,0x7
	sll	$2,$3,$2
	andi	$2,$2,0x00ff
	addiu	$7,$7,1
	srl	$2,$2,7
	beq	$2,$0,$L3284
	sw	$7,8456($16)

	li	$2,16777216			# 0x1000000
	or	$5,$5,$2
	lui	$4,%hi(scan8)
	sw	$5,40($sp)
	addiu	$4,$4,%lo(scan8)
	addiu	$13,$16,8776
	move	$3,$0
	b	$L3285
	li	$12,2			# 0x2

$L3291:
	lbu	$5,0($9)
	sll	$7,$2,8
	addu	$2,$7,$2
	andi	$2,$2,0xffff
	addu	$5,$13,$5
	sh	$2,8($5)
	beq	$8,$0,$L3288
	sh	$2,0($5)

	lw	$7,8456($16)
$L3285:
	addu	$2,$3,$4
	lbu	$2,0($2)
	sra	$5,$7,3
	addu	$2,$16,$2
	addu	$5,$6,$5
	lbu	$10,0($5)
	lb	$5,8775($2)
	lb	$2,8768($2)
	andi	$8,$7,0x7
	sll	$10,$10,$8
	slt	$8,$5,$2
	movn	$2,$5,$8
	andi	$10,$10,0x00ff
	addu	$9,$3,$4
	addiu	$5,$7,1
	addiu	$3,$3,4
	slt	$11,$2,0
	srl	$10,$10,7
	slt	$8,$3,16
	movn	$2,$12,$11
	bne	$10,$0,$L3291
	sw	$5,8456($16)

	sra	$10,$5,3
	addu	$10,$6,$10
	lbu	$14,0($10)
	lbu	$15,3($10)
	lbu	$11,1($10)
	sll	$14,$14,24
	lbu	$10,2($10)
	or	$14,$15,$14
	sll	$11,$11,16
	or	$11,$14,$11
	sll	$10,$10,8
	or	$10,$11,$10
	andi	$5,$5,0x7
	sll	$5,$10,$5
	srl	$5,$5,29
	slt	$2,$5,$2
	addiu	$7,$7,4
	xori	$2,$2,0x1
	sw	$7,8456($16)
	b	$L3291
	addu	$2,$2,$5

$L3282:
	lw	$5,8760($16)
	.option	pic0
	jal	check_intra_pred_mode
	.option	pic2
	move	$4,$16

	bgez	$2,$L3298
	sw	$2,8760($16)

$L3304:
	li	$2,-1			# 0xffffffffffffffff
$L3686:
	lw	$31,284($sp)
$L3701:
	lw	$fp,280($sp)
	lw	$23,276($sp)
	lw	$22,272($sp)
	lw	$21,268($sp)
	lw	$20,264($sp)
	lw	$19,260($sp)
	lw	$18,256($sp)
	lw	$17,252($sp)
	lw	$16,248($sp)
	j	$31
	addiu	$sp,$sp,288

$L3632:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,-6284($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L3655
	li	$22,59272			# 0xe788

	lw	$4,8456($16)
	lw	$6,8448($16)
	sra	$2,$4,3
	addu	$2,$6,$2
	lbu	$5,0($2)
	lbu	$7,3($2)
	lbu	$3,2($2)
	sll	$5,$5,24
	lbu	$2,1($2)
	or	$5,$5,$7
	sll	$3,$3,8
	sll	$2,$2,16
	or	$3,$5,$3
	or	$3,$3,$2
	andi	$2,$4,0x7
	sll	$2,$3,$2
	li	$3,134217728			# 0x8000000
	sltu	$3,$2,$3
	beq	$3,$0,$L3314
	li	$3,-65536			# 0xffffffffffff0000

	and	$3,$2,$3
	bne	$3,$0,$L3315
	srl	$3,$2,16

	move	$3,$2
	li	$7,8			# 0x8
	move	$5,$0
$L3319:
	andi	$8,$3,0xff00
	beq	$8,$0,$L3318
	nop

	srl	$3,$3,8
	move	$5,$7
$L3318:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$3,$7,$3
	lbu	$3,0($3)
	addu	$3,$3,$5
	sll	$3,$3,1
	addiu	$3,$3,-31
	subu	$4,$4,$3
	srl	$2,$2,$3
	sw	$4,8456($16)
	addiu	$2,$2,-1
$L3317:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	sltu	$4,$2,4
	sw	$2,-6264($3)
	beq	$4,$0,$L3320
	move	$7,$2

	lui	$4,%hi(p_sub_mb_type_info)
	sll	$2,$2,2
	addiu	$4,$4,%lo(p_sub_mb_type_info)
	addu	$2,$4,$2
	lw	$5,8456($16)
	lhu	$8,0($2)
	lbu	$7,2($2)
	sra	$2,$5,3
	sw	$8,-6264($3)
	addu	$2,$6,$2
	sw	$7,52($sp)
	lbu	$7,0($2)
	lbu	$8,3($2)
	lbu	$3,1($2)
	sll	$7,$7,24
	lbu	$2,2($2)
	or	$7,$8,$7
	sll	$3,$3,16
	sll	$2,$2,8
	or	$3,$7,$3
	or	$3,$3,$2
	andi	$2,$5,0x7
	sll	$2,$3,$2
	li	$3,134217728			# 0x8000000
	sltu	$3,$2,$3
	beq	$3,$0,$L3321
	li	$3,-65536			# 0xffffffffffff0000

	and	$3,$2,$3
	bne	$3,$0,$L3322
	srl	$3,$2,16

	move	$3,$2
	li	$8,8			# 0x8
	move	$7,$0
$L3326:
	andi	$9,$3,0xff00
	beq	$9,$0,$L3325
	nop

	srl	$3,$3,8
	move	$7,$8
$L3325:
	lw	$8,%got(ff_log2_tab)($28)
	addiu	$5,$5,32
	addu	$3,$8,$3
	lbu	$3,0($3)
	addu	$3,$3,$7
	sll	$3,$3,1
	addiu	$3,$3,-31
	subu	$5,$5,$3
	srl	$2,$2,$3
	sw	$5,8456($16)
	addiu	$2,$2,-1
$L3324:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	sltu	$5,$2,4
	sw	$2,-6260($3)
	beq	$5,$0,$L3320
	move	$7,$2

	sll	$2,$2,2
	addu	$2,$4,$2
	lw	$5,8456($16)
	lhu	$8,0($2)
	lbu	$7,2($2)
	sra	$2,$5,3
	sw	$8,-6260($3)
	addu	$2,$6,$2
	sw	$7,56($sp)
	lbu	$7,0($2)
	lbu	$8,3($2)
	lbu	$3,1($2)
	sll	$7,$7,24
	lbu	$2,2($2)
	or	$7,$8,$7
	sll	$3,$3,16
	sll	$2,$2,8
	or	$3,$7,$3
	or	$3,$3,$2
	andi	$2,$5,0x7
	sll	$2,$3,$2
	li	$3,134217728			# 0x8000000
	sltu	$3,$2,$3
	beq	$3,$0,$L3327
	li	$3,-65536			# 0xffffffffffff0000

	and	$3,$2,$3
	bne	$3,$0,$L3328
	srl	$3,$2,16

	move	$3,$2
	li	$8,8			# 0x8
	move	$7,$0
$L3332:
	andi	$9,$3,0xff00
	beq	$9,$0,$L3331
	nop

	srl	$3,$3,8
	move	$7,$8
$L3331:
	lw	$8,%got(ff_log2_tab)($28)
	addiu	$5,$5,32
	addu	$3,$8,$3
	lbu	$3,0($3)
	addu	$3,$3,$7
	sll	$3,$3,1
	addiu	$3,$3,-31
	subu	$5,$5,$3
	srl	$2,$2,$3
	sw	$5,8456($16)
	addiu	$2,$2,-1
$L3330:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	sltu	$5,$2,4
	sw	$2,-6256($3)
	beq	$5,$0,$L3320
	move	$7,$2

	sll	$2,$2,2
	addu	$2,$4,$2
	lw	$5,8456($16)
	lhu	$8,0($2)
	lbu	$7,2($2)
	sra	$2,$5,3
	sw	$8,-6256($3)
	addu	$6,$6,$2
	sw	$7,60($sp)
	lbu	$7,0($6)
	lbu	$3,1($6)
	lbu	$8,3($6)
	lbu	$2,2($6)
	sll	$7,$7,24
	or	$6,$8,$7
	sll	$3,$3,16
	sll	$2,$2,8
	or	$3,$6,$3
	or	$3,$3,$2
	andi	$2,$5,0x7
	sll	$2,$3,$2
	li	$3,134217728			# 0x8000000
	sltu	$3,$2,$3
	beq	$3,$0,$L3656
	li	$3,-65536			# 0xffffffffffff0000

	and	$3,$2,$3
	bne	$3,$0,$L3335
	srl	$3,$2,16

	move	$3,$2
	li	$7,8			# 0x8
	move	$6,$0
$L3336:
	andi	$8,$3,0xff00
	beq	$8,$0,$L3337
	nop

	srl	$3,$3,8
	move	$6,$7
$L3337:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$5,$5,32
	addu	$3,$7,$3
	lbu	$3,0($3)
	addu	$3,$3,$6
	sll	$3,$3,1
	addiu	$3,$3,-31
	subu	$5,$5,$3
	srl	$2,$2,$3
	sw	$5,8456($16)
	addiu	$2,$2,-1
$L3334:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	sltu	$5,$2,4
	sw	$2,-6252($3)
	beq	$5,$0,$L3320
	move	$7,$2

	sll	$2,$2,2
	addu	$4,$4,$2
	lhu	$5,0($4)
	lbu	$2,2($4)
	sw	$5,-6252($3)
	sw	$2,64($sp)
$L3311:
	li	$6,65536			# 0x10000
$L3696:
	addu	$2,$16,$6
	lw	$3,5944($2)
	beq	$3,$0,$L3657
	mtlo	$20

	lw	$13,-6264($2)
	lw	$12,40($sp)
	ori	$6,$6,0x1730
	lw	$22,%got(ff_golomb_vlc_len)($28)
	lw	$21,%got(ff_ue_golomb_vlc_code)($28)
	lw	$25,%got(ff_log2_tab)($28)
	andi	$12,$12,0x200
	addu	$6,$16,$6
	andi	$11,$13,0x100
	addiu	$4,$sp,80
	move	$3,$0
	move	$5,$0
	li	$24,1			# 0x1
	li	$9,4096			# 0x1000
	li	$15,2			# 0x2
	li	$14,134217728			# 0x8000000
	li	$10,-1			# 0xffffffffffffffff
	sw	$17,112($sp)
$L3386:
	beq	$12,$0,$L3339
	nop

	li	$8,1			# 0x1
$L3340:
	bne	$11,$0,$L3341
	sll	$7,$9,$3

	and	$7,$7,$13
	bne	$7,$0,$L3342
	nop

	sw	$10,-12($4)
$L3341:
	lw	$7,-6260($2)
	andi	$20,$7,0x100
	bne	$20,$0,$L3353
	sll	$20,$9,$3

	and	$7,$20,$7
	bne	$7,$0,$L3354
	nop

	sw	$10,-8($4)
$L3353:
	lw	$7,-6256($2)
	andi	$20,$7,0x100
	bne	$20,$0,$L3364
	sll	$20,$9,$3

	and	$7,$20,$7
	bne	$7,$0,$L3365
	nop

	sw	$10,-4($4)
$L3364:
	lw	$7,-6252($2)
	andi	$20,$7,0x100
	bne	$20,$0,$L3375
	sll	$20,$9,$3

	and	$7,$20,$7
	bne	$7,$0,$L3376
	nop

	sw	$10,0($4)
$L3375:
	lw	$7,5944($2)
	addiu	$5,$5,1
	sltu	$8,$5,$7
	addiu	$4,$4,16
	addiu	$6,$6,4
	bne	$8,$0,$L3386
	addiu	$3,$3,2

	mflo	$20
	lw	$17,112($sp)
$L3313:
	beq	$20,$0,$L3387
	li	$2,59272			# 0xe788

	li	$4,59288			# 0xe798
	addu	$2,$16,$2
	addu	$4,$16,$4
$L3390:
	lw	$3,0($2)
	andi	$5,$3,0x100
	andi	$3,$3,0x8
	beq	$3,$0,$L3388
	addiu	$2,$2,4

	lw	$3,9980($16)
	bne	$3,$0,$L3389
	nop

	bne	$5,$0,$L3388
	nop

$L3389:
	bne	$2,$4,$L3390
	nop

	li	$20,1			# 0x1
$L3387:
	beq	$7,$0,$L3391
	li	$2,59272			# 0xe788

	lui	$4,%hi(scan8)
	addu	$2,$16,$2
	li	$fp,65536			# 0x10000
	addiu	$22,$sp,68
	addiu	$23,$sp,52
	addiu	$4,$4,%lo(scan8)
	sw	$2,188($sp)
	addu	$fp,$16,$fp
	addiu	$5,$16,9136
	sw	$16,152($sp)
	sw	$16,128($sp)
	move	$11,$0
	sw	$0,104($sp)
	sw	$22,160($sp)
	sw	$23,192($sp)
	li	$21,134217728			# 0x8000000
	sw	$20,196($sp)
	sw	$19,200($sp)
	sw	$18,204($sp)
	sw	$17,176($sp)
$L3392:
	sll	$2,$11,2
	sll	$9,$11,4
	lw	$3,104($sp)
	lw	$6,104($sp)
	addu	$9,$2,$9
	lw	$12,104($sp)
	addu	$2,$2,$11
	sll	$8,$3,3
	sll	$18,$11,3
	sll	$3,$3,5
	sll	$11,$11,5
	sll	$9,$9,3
	lw	$13,160($sp)
	addu	$8,$8,$3
	addiu	$10,$2,-1
	sll	$7,$6,4
	sll	$2,$6,1
	addiu	$9,$9,40
	addiu	$6,$6,24
	addiu	$3,$12,46
	addu	$18,$18,$11
	li	$14,4096			# 0x1000
	li	$11,12288			# 0x3000
	lw	$17,188($sp)
	sll	$11,$11,$2
	sll	$10,$10,3
	addu	$9,$5,$9
	addu	$7,$13,$7
	sll	$6,$6,2
	sll	$3,$3,2
	sll	$2,$14,$2
	sw	$11,156($sp)
	sw	$10,108($sp)
	sw	$9,136($sp)
	sw	$7,144($sp)
	addu	$8,$16,$8
	sw	$6,164($sp)
	sw	$3,168($sp)
	sw	$2,180($sp)
	sw	$17,112($sp)
	sw	$4,132($sp)
	move	$22,$0
$L3443:
	lw	$3,112($sp)
	lw	$2,0($3)
	andi	$3,$2,0x100
	beq	$3,$0,$L3393
	lw	$6,132($sp)

	lbu	$2,0($6)
	addu	$2,$8,$2
	lbu	$3,9457($2)
	sb	$3,9456($2)
$L3394:
	lw	$13,112($sp)
	lw	$14,132($sp)
	lw	$17,144($sp)
	addiu	$13,$13,4
	addiu	$14,$14,4
	addiu	$17,$17,4
	addiu	$22,$22,4
	li	$2,16			# 0x10
	sw	$13,112($sp)
	sw	$14,132($sp)
	bne	$22,$2,$L3443
	sw	$17,144($sp)

	lw	$20,104($sp)
	lw	$22,128($sp)
	lw	$23,152($sp)
	lw	$2,5944($fp)
	addiu	$20,$20,1
	addiu	$22,$22,160
	addiu	$23,$23,40
	sltu	$2,$20,$2
	sw	$20,104($sp)
	sw	$22,128($sp)
	sw	$23,152($sp)
	bne	$2,$0,$L3392
	move	$11,$20

	lw	$20,196($sp)
	lw	$19,200($sp)
	lw	$18,204($sp)
	lw	$17,176($sp)
	b	$L3305
	lw	$5,40($sp)

$L3637:
	srl	$7,$7,23
	addu	$21,$24,$7
	lbu	$21,0($21)
	addu	$7,$15,$7
	addu	$22,$21,$22
	sw	$22,8456($16)
	b	$L3448
	lbu	$7,0($7)

$L3445:
	beq	$2,$0,$L3658
	li	$8,65536			# 0x10000

	li	$3,65536			# 0x10000
	addu	$9,$16,$3
	lw	$2,5944($9)
	beq	$2,$0,$L3659
	ori	$3,$3,0x1730

	addu	$3,$16,$3
	addiu	$22,$16,8448
	addiu	$8,$16,9456
	li	$fp,1			# 0x1
	move	$23,$0
	move	$21,$0
	b	$L3482
	li	$6,4096			# 0x1000

$L3660:
$L3470:
	sll	$2,$23,5
	sll	$23,$23,3
	addu	$23,$23,$2
	addiu	$2,$23,12
	sll	$7,$6,$fp
	addu	$2,$8,$2
	and	$7,$7,$5
	sw	$4,8($2)
	bne	$7,$0,$L3475
	sw	$4,0($2)

	li	$2,-1			# 0xffffffffffffffff
$L3476:
	addiu	$23,$23,28
	addu	$23,$8,$23
	sw	$2,8($23)
	sw	$2,0($23)
	lw	$2,5944($9)
	addiu	$21,$21,1
	sltu	$4,$21,$2
	addiu	$fp,$fp,2
	addiu	$3,$3,4
	beq	$4,$0,$L3481
	move	$23,$21

$L3482:
	sll	$2,$21,1
	sll	$2,$6,$2
	and	$2,$2,$5
	beq	$2,$0,$L3660
	li	$4,-1			# 0xffffffffffffffff

	lw	$4,0($3)
	li	$5,1			# 0x1
	beq	$4,$5,$L3661
	li	$7,2			# 0x2

	beq	$4,$7,$L3473
	nop

	move	$4,$22
	sw	$3,236($sp)
	sw	$6,212($sp)
	sw	$8,232($sp)
	.option	pic0
	jal	get_ue_golomb
	.option	pic2
	sw	$9,228($sp)

	lw	$3,236($sp)
	lw	$28,32($sp)
	lw	$4,0($3)
	lw	$6,212($sp)
	lw	$8,232($sp)
	lw	$9,228($sp)
$L3472:
	sltu	$4,$2,$4
	beq	$4,$0,$L3474
	nop

	sll	$4,$2,8
	addu	$2,$4,$2
	sll	$4,$2,16
	lw	$5,40($sp)
	b	$L3470
	addu	$4,$2,$4

$L3647:
	.option	pic0
	jal	get_ue_golomb
	.option	pic2
	addiu	$4,$16,8448

	sltu	$3,$2,48
	beq	$3,$0,$L3662
	lw	$28,32($sp)

	lw	$5,40($sp)
	andi	$3,$5,0x1
	beq	$3,$0,$L3524
	lui	$3,%hi(golomb_to_inter_cbp)

	lui	$3,%hi(golomb_to_intra4x4_cbp)
	addiu	$3,$3,%lo(golomb_to_intra4x4_cbp)
	addu	$2,$2,$3
	b	$L3522
	lbu	$19,0($2)

$L3646:
	.option	pic0
	jal	write_back_motion
	.option	pic2
	move	$4,$16

	lw	$28,32($sp)
	b	$L3521
	lw	$5,40($sp)

$L3530:
	sw	$0,9092($16)
	addiu	$2,$16,9080
	sw	$0,24($3)
	sw	$0,8($3)
	sw	$0,16($3)
$L3613:
	sb	$0,9($2)
	sb	$0,42($2)
	sb	$0,41($2)
	sb	$0,34($2)
	sb	$0,33($2)
	sb	$0,18($2)
	sb	$0,17($2)
	sb	$0,10($2)
$L3578:
	lw	$3,1548($16)
	lw	$2,2056($16)
	addu	$18,$3,$18
	sb	$2,0($18)
	lw	$2,6172($16)
	lw	$5,152($16)
	lw	$4,6168($16)
	mul	$6,$5,$2
	lw	$3,9128($16)
	addu	$2,$6,$4
	sll	$2,$2,4
	lbu	$4,9095($16)
	addu	$3,$3,$2
	sb	$4,0($3)
	lw	$3,9128($16)
	lbu	$4,9103($16)
	addu	$3,$3,$2
	sb	$4,1($3)
	lw	$3,9128($16)
	lbu	$4,9111($16)
	addu	$3,$3,$2
	sb	$4,2($3)
	lw	$3,9128($16)
	lbu	$4,9119($16)
	addu	$3,$3,$2
	sb	$4,3($3)
	lw	$3,9128($16)
	lbu	$4,9116($16)
	addu	$3,$3,$2
	sb	$4,4($3)
	lw	$3,9128($16)
	lbu	$4,9117($16)
	addu	$3,$3,$2
	sb	$4,5($3)
	lw	$3,9128($16)
	lbu	$4,9118($16)
	addu	$3,$3,$2
	sb	$4,6($3)
	lw	$3,9128($16)
	lbu	$4,9097($16)
	addu	$3,$3,$2
	sb	$4,9($3)
	lw	$3,9128($16)
	lbu	$4,9098($16)
	addu	$3,$3,$2
	sb	$4,8($3)
	lw	$3,9128($16)
	lbu	$4,9090($16)
	addu	$3,$3,$2
	sb	$4,7($3)
	lw	$3,9128($16)
	lbu	$4,9121($16)
	addu	$3,$3,$2
	sb	$4,12($3)
	lw	$3,9128($16)
	lbu	$4,9122($16)
	addu	$3,$3,$2
	sb	$4,11($3)
	lw	$3,9128($16)
	lbu	$4,9114($16)
	addu	$3,$3,$2
	sb	$4,10($3)
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$3,-6276($3)
	beq	$3,$0,$L3579
	nop

	lbu	$5,9093($16)
	lbu	$7,9092($16)
	lbu	$4,9100($16)
	lbu	$3,9101($16)
	sltu	$5,$0,$5
	sll	$5,$5,1
	lbu	$6,9094($16)
	sltu	$7,$0,$7
	sltu	$4,$0,$4
	addu	$7,$7,$5
	sll	$4,$4,2
	lbu	$5,9095($16)
	sltu	$3,$0,$3
	addu	$7,$7,$4
	sll	$3,$3,3
	lbu	$4,9102($16)
	sltu	$6,$0,$6
	addu	$7,$7,$3
	sll	$6,$6,4
	lbu	$3,9103($16)
	sltu	$5,$0,$5
	addu	$7,$7,$6
	sll	$5,$5,5
	lbu	$6,9108($16)
	sltu	$4,$0,$4
	addu	$7,$7,$5
	sll	$4,$4,6
	lbu	$5,9109($16)
	sltu	$3,$0,$3
	addu	$7,$7,$4
	sll	$3,$3,7
	lbu	$4,9116($16)
	sltu	$6,$0,$6
	addu	$7,$7,$3
	sll	$6,$6,8
	lbu	$3,9117($16)
	sltu	$5,$0,$5
	addu	$7,$7,$6
	sll	$5,$5,9
	lbu	$6,9110($16)
	sltu	$4,$0,$4
	addu	$7,$7,$5
	sll	$4,$4,10
	lbu	$5,9111($16)
	sltu	$3,$0,$3
	addu	$7,$7,$4
	sll	$3,$3,11
	lbu	$4,9118($16)
	sltu	$6,$0,$6
	addu	$7,$7,$3
	sll	$6,$6,12
	lbu	$3,9119($16)
	sltu	$5,$0,$5
	sll	$5,$5,13
	addu	$6,$7,$6
	sltu	$4,$0,$4
	addu	$6,$6,$5
	sll	$4,$4,14
	sltu	$3,$0,$3
	lw	$5,9128($16)
	addu	$4,$6,$4
	sll	$3,$3,15
	addu	$2,$5,$2
	addu	$3,$3,$4
	sh	$3,14($2)
$L3579:
	li	$2,65536			# 0x10000
	addu	$16,$16,$2
	lw	$2,-6268($16)
	beq	$2,$0,$L3694
	lw	$31,284($sp)

	lw	$2,5936($16)
	lw	$3,5940($16)
	srl	$2,$2,1
	srl	$3,$3,1
	sw	$2,5936($16)
	sw	$3,5940($16)
	b	$L3259
	move	$2,$0

$L3645:
	b	$L3302
	sb	$3,8804($16)

$L3644:
	b	$L3301
	sb	$3,8796($16)

$L3643:
	b	$L3300
	sb	$3,8788($16)

$L3452:
	li	$fp,24			# 0x18
	b	$L3453
	li	$23,16			# 0x10

$L3641:
	b	$L3296
	sb	$3,8790($16)

$L3640:
	b	$L3295
	sb	$3,8789($16)

$L3639:
	b	$L3294
	sb	$3,8788($16)

$L3642:
	b	$L3292
	sb	$2,8791($16)

$L3658:
	addu	$11,$16,$8
	lw	$2,5944($11)
	beq	$2,$0,$L3663
	ori	$8,$8,0x1730

	lw	$21,%got(ff_golomb_vlc_len)($28)
	lw	$25,%got(ff_ue_golomb_vlc_code)($28)
	lw	$24,%got(ff_log2_tab)($28)
	addu	$8,$16,$8
	addiu	$10,$16,9456
	li	$4,1			# 0x1
	move	$3,$0
	move	$2,$0
	li	$9,4096			# 0x1000
	li	$15,1			# 0x1
	li	$14,2			# 0x2
	li	$13,134217728			# 0x8000000
	b	$L3514
	mtlo	$17

$L3665:
$L3490:
	sll	$7,$3,4
	sll	$3,$3,2
	addu	$12,$3,$7
	sll	$3,$12,1
	addiu	$3,$3,12
	sll	$7,$9,$4
	addu	$3,$10,$3
	and	$7,$5,$7
	sh	$6,24($3)
	sh	$6,0($3)
	sh	$6,8($3)
	bne	$7,$0,$L3502
	sh	$6,16($3)

	li	$7,65535			# 0xffff
$L3503:
	sll	$3,$12,1
	lw	$6,5944($11)
	addiu	$2,$2,1
	addiu	$3,$3,14
	addu	$3,$10,$3
	sltu	$12,$2,$6
	sh	$7,24($3)
	sh	$7,0($3)
	sh	$7,8($3)
	sh	$7,16($3)
	addiu	$4,$4,2
	addiu	$8,$8,4
	beq	$12,$0,$L3664
	move	$3,$2

$L3514:
	sll	$6,$2,1
	sll	$6,$9,$6
	and	$6,$5,$6
	beq	$6,$0,$L3665
	li	$6,65535			# 0xffff

	lw	$6,0($8)
	beq	$6,$15,$L3492
	move	$7,$0

	beq	$6,$14,$L3493
	nop

	lw	$22,8456($16)
	lw	$7,8448($16)
	sra	$12,$22,3
	addu	$7,$7,$12
	lbu	$23,0($7)
	lbu	$fp,3($7)
	lbu	$12,1($7)
	sll	$23,$23,24
	lbu	$7,2($7)
	or	$23,$fp,$23
	sll	$12,$12,16
	sll	$7,$7,8
	or	$12,$23,$12
	or	$12,$12,$7
	andi	$7,$22,0x7
	sll	$7,$12,$7
	sltu	$12,$7,$13
	beq	$12,$0,$L3494
	li	$17,-65536			# 0xffffffffffff0000

	and	$12,$7,$17
	beq	$12,$0,$L3667
	move	$12,$7

	srl	$12,$7,16
	li	$fp,24			# 0x18
	li	$23,16			# 0x10
$L3500:
	andi	$17,$12,0xff00
	beq	$17,$0,$L3499
	nop

	srl	$12,$12,8
	move	$23,$fp
$L3499:
	addu	$12,$24,$12
	lbu	$12,0($12)
	addiu	$22,$22,32
	addu	$12,$12,$23
	sll	$12,$12,1
	addiu	$12,$12,-31
	subu	$22,$22,$12
	srl	$7,$7,$12
	sw	$22,8456($16)
	addiu	$7,$7,-1
$L3492:
	sltu	$6,$7,$6
	beq	$6,$0,$L3501
	nop

	sll	$6,$7,8
	addu	$6,$6,$7
	b	$L3490
	andi	$6,$6,0xffff

$L3524:
	addiu	$3,$3,%lo(golomb_to_inter_cbp)
	addu	$2,$2,$3
	b	$L3522
	lbu	$19,0($2)

$L3655:
	lui	$fp,%hi(b_sub_mb_type_info)
	addiu	$7,$sp,68
	addu	$22,$16,$22
	addiu	$fp,$fp,%lo(b_sub_mb_type_info)
	addiu	$23,$16,8448
	addiu	$21,$sp,52
	sw	$7,160($sp)
$L3309:
	.option	pic0
	jal	get_ue_golomb
	.option	pic2
	move	$4,$23

	sll	$3,$2,2
	sltu	$4,$2,13
	lw	$28,32($sp)
	addu	$3,$3,$fp
	beq	$4,$0,$L3668
	sw	$2,0($22)

	lbu	$4,2($3)
	lhu	$2,0($3)
	lw	$9,160($sp)
	sw	$4,0($21)
	addiu	$21,$21,4
	sw	$2,0($22)
	bne	$9,$21,$L3309
	addiu	$22,$22,4

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,-6264($2)
	andi	$3,$3,0x100
	bne	$3,$0,$L3310
	nop

	lw	$3,-6260($2)
	andi	$3,$3,0x100
	bne	$3,$0,$L3695
	move	$4,$16

	lw	$3,-6256($2)
	andi	$3,$3,0x100
	bne	$3,$0,$L3695
	nop

	lw	$2,-6252($2)
	andi	$2,$2,0x100
	beq	$2,$0,$L3696
	li	$6,65536			# 0x10000

$L3310:
	move	$4,$16
$L3695:
	.option	pic0
	jal	pred_direct_motion
	.option	pic2
	addiu	$5,$sp,40

	li	$2,-2			# 0xfffffffffffffffe
	lw	$28,32($sp)
	sb	$2,9470($16)
	sb	$2,9526($16)
	sb	$2,9486($16)
	b	$L3311
	sb	$2,9510($16)

$L3339:
	b	$L3340
	lw	$8,0($6)

$L3552:
	lbu	$3,0($23)
	addiu	$2,$3,9080
	addu	$2,$16,$2
	addu	$3,$16,$3
	sb	$0,1($2)
	sb	$0,9($2)
	sb	$0,8($2)
	b	$L3562
	sb	$0,9080($3)

$L3393:
	lw	$9,132($sp)
	lw	$10,144($sp)
	lw	$12,180($sp)
	lbu	$7,0($9)
	lb	$6,0($10)
	addu	$3,$8,$7
	and	$9,$12,$2
	sb	$6,9456($3)
	sb	$6,9465($3)
	sb	$6,9464($3)
	beq	$9,$0,$L3395
	sb	$6,9457($3)

	lw	$13,192($sp)
	andi	$6,$2,0x18
	addu	$3,$13,$22
	lw	$23,0($3)
	li	$15,1			# 0x1
	li	$3,2			# 0x2
	blez	$23,$L3394
	movn	$15,$3,$6

	andi	$14,$2,0x20
	andi	$20,$2,0x8
	andi	$2,$2,0x10
	lw	$17,8448($16)
	sw	$14,172($sp)
	sw	$20,116($sp)
	sw	$2,148($sp)
	move	$11,$22
	move	$10,$0
	li	$19,-2			# 0xfffffffffffffffe
	sw	$22,208($sp)
	b	$L3442
	sw	$23,240($sp)

$L3673:
	lw	$23,136($sp)
	lw	$20,1880($16)
	sw	$0,0($23)
	lw	$22,-6272($fp)
	lw	$23,104($20)
	sw	$22,124($sp)
	bne	$22,$0,$L3399
	sw	$23,120($sp)

	lw	$22,6172($16)
	andi	$23,$22,0x1
	beq	$23,$0,$L3399
	slt	$23,$3,20

	beq	$23,$0,$L3399
	nop

	beq	$7,$19,$L3400
	nop

	lw	$9,6168($16)
	lw	$23,152($16)
	sw	$9,124($sp)
	sw	$23,140($sp)
	lw	$23,124($sp)
	addiu	$9,$22,-1
	mtlo	$23
	lw	$23,140($sp)
	madd	$9,$23
	xori	$9,$3,0xf
	mflo	$23
	sltu	$9,$9,1
	addu	$9,$23,$9
	sw	$23,184($sp)
	lw	$23,120($sp)
	sll	$9,$9,2
	addu	$9,$23,$9
	lw	$9,0($9)
	andi	$9,$9,0x80
	beq	$9,$0,$L3697
	addu	$9,$14,$18

	lw	$9,124($sp)
	sll	$22,$22,2
	sll	$7,$9,2
	addiu	$7,$7,-4
	addu	$7,$7,$15
	lw	$14,140($sp)
	andi	$3,$3,0x7
	addiu	$22,$22,-1
	addu	$3,$7,$3
	sra	$7,$22,2
	mul	$23,$7,$14
	sra	$9,$3,2
	addu	$7,$23,$9
	lw	$9,120($sp)
	sll	$7,$7,2
	addu	$7,$9,$7
	lw	$9,0($7)
	lw	$14,156($sp)
	and	$7,$9,$14
	beq	$7,$0,$L3669
	andi	$7,$9,0x40

$L3402:
	lw	$9,9748($16)
	lw	$23,164($sp)
	mul	$14,$22,$9
	addu	$7,$20,$23
	addu	$9,$14,$3
	lw	$14,0($7)
	sll	$7,$9,2
	addu	$7,$14,$7
	lw	$23,168($sp)
	lhu	$9,0($7)
	lw	$14,128($sp)
	addu	$20,$20,$23
	sh	$9,9176($14)
	lw	$9,4($20)
	lw	$14,9752($16)
	sra	$3,$3,1
	sra	$22,$22,1
	addu	$3,$9,$3
	mul	$9,$22,$14
	lhu	$7,2($7)
	lw	$14,128($sp)
	sll	$7,$7,1
	addu	$3,$9,$3
	sh	$7,9178($14)
	lb	$7,0($3)
	lw	$9,136($sp)
	sra	$7,$7,1
$L3404:
	xor	$20,$6,$24
	xor	$14,$6,$25
	sltu	$20,$20,1
	sltu	$14,$14,1
	xor	$3,$6,$7
	addu	$14,$20,$14
	sltu	$3,$3,1
	addu	$3,$14,$3
	slt	$14,$3,2
	bne	$14,$0,$L3698
	li	$14,1			# 0x1

$L3674:
	lh	$3,0($12)
	lh	$14,0($13)
	slt	$7,$14,$3
	beq	$7,$0,$L3411
	lh	$6,0($9)

	slt	$7,$14,$6
	beq	$7,$0,$L3420
	nop

	slt	$14,$3,$6
	movz	$3,$6,$14
	move	$14,$3
$L3420:
	lh	$3,2($12)
	lh	$7,2($13)
	lh	$6,2($9)
	slt	$9,$7,$3
	beq	$9,$0,$L3421
	slt	$9,$6,$7

	slt	$9,$7,$6
	beq	$9,$0,$L3414
	nop

	slt	$7,$3,$6
	movz	$3,$6,$7
	move	$7,$3
$L3414:
	lw	$6,8456($16)
	sra	$3,$6,3
	addu	$3,$17,$3
	lbu	$12,0($3)
	lbu	$13,3($3)
	lbu	$9,1($3)
	lbu	$24,2($3)
	sll	$12,$12,24
	or	$12,$13,$12
	sll	$9,$9,16
	or	$9,$12,$9
	sll	$24,$24,8
	or	$9,$9,$24
	andi	$3,$6,0x7
	sll	$3,$9,$3
	sltu	$9,$3,$21
	beq	$9,$0,$L3670
	li	$23,-65536			# 0xffffffffffff0000

	and	$9,$3,$23
	bne	$9,$0,$L3424
	srl	$9,$3,16

	move	$9,$3
	li	$12,8			# 0x8
	move	$24,$0
$L3425:
	andi	$13,$9,0xff00
	bne	$13,$0,$L3426
	nop

	move	$12,$24
$L3427:
	lw	$13,%got(ff_log2_tab)($28)
	addiu	$6,$6,32
	addu	$9,$13,$9
	lbu	$9,0($9)
	addu	$9,$9,$12
	sll	$9,$9,1
	addiu	$9,$9,-31
	srl	$3,$3,$9
	subu	$6,$6,$9
	andi	$9,$3,0x1
	beq	$9,$0,$L3428
	sw	$6,8456($16)

	srl	$3,$3,1
	subu	$13,$0,$3
$L3423:
	sra	$3,$6,3
	addu	$3,$17,$3
	lbu	$12,0($3)
	lbu	$24,3($3)
	lbu	$9,1($3)
	lbu	$25,2($3)
	sll	$12,$12,24
	or	$12,$24,$12
	sll	$9,$9,16
	or	$9,$12,$9
	sll	$25,$25,8
	or	$9,$9,$25
	andi	$3,$6,0x7
	sll	$3,$9,$3
	sltu	$9,$3,$21
	beq	$9,$0,$L3671
	addu	$13,$13,$14

	li	$22,-65536			# 0xffffffffffff0000
	and	$9,$3,$22
	bne	$9,$0,$L3432
	srl	$9,$3,16

	move	$9,$3
	li	$12,8			# 0x8
	move	$24,$0
$L3433:
	andi	$14,$9,0xff00
	bne	$14,$0,$L3434
	nop

	move	$12,$24
$L3435:
	lw	$23,%got(ff_log2_tab)($28)
	addiu	$6,$6,32
	addu	$9,$23,$9
	lbu	$9,0($9)
	addu	$9,$9,$12
	sll	$9,$9,1
	addiu	$9,$9,-31
	srl	$3,$3,$9
	subu	$6,$6,$9
	andi	$12,$3,0x1
	beq	$12,$0,$L3436
	sw	$6,8456($16)

	srl	$3,$3,1
	subu	$3,$0,$3
$L3431:
	lw	$6,116($sp)
	beq	$6,$0,$L3438
	addu	$3,$3,$7

	sll	$13,$13,16
	sll	$3,$3,16
	sra	$13,$13,16
	sra	$3,$3,16
	sh	$13,36($2)
	sh	$13,32($2)
	sh	$13,4($2)
	sh	$3,38($2)
	sh	$3,34($2)
	sh	$3,6($2)
$L3439:
	lw	$12,240($sp)
	addiu	$10,$10,1
	sh	$3,2($2)
	sh	$13,0($2)
	beq	$10,$12,$L3672
	addu	$11,$11,$15

$L3442:
	addu	$2,$11,$4
	lbu	$3,0($2)
	lw	$22,108($sp)
	addu	$9,$3,$18
	addiu	$24,$3,-8
	addu	$14,$24,$15
	addiu	$12,$9,-1
	addu	$13,$3,$22
	lw	$20,-6276($fp)
	addu	$6,$8,$3
	addu	$24,$8,$24
	sll	$12,$12,2
	sll	$13,$13,2
	sll	$2,$9,2
	addu	$7,$8,$14
	lb	$25,9456($24)
	addu	$2,$5,$2
	lb	$24,9455($6)
	addu	$12,$5,$12
	addu	$13,$5,$13
	lb	$7,9456($7)
	bne	$20,$0,$L3673
	lb	$6,9456($6)

	beq	$7,$19,$L3406
	nop

$L3401:
	addu	$9,$14,$18
$L3697:
	xor	$20,$6,$24
	xor	$14,$6,$25
	sltu	$20,$20,1
	sltu	$14,$14,1
	xor	$3,$6,$7
	addu	$14,$20,$14
	sltu	$3,$3,1
	addu	$3,$14,$3
	sll	$9,$9,2
	slt	$14,$3,2
	beq	$14,$0,$L3674
	addu	$9,$5,$9

	li	$14,1			# 0x1
$L3698:
	beq	$3,$14,$L3675
	nop

	beq	$25,$19,$L3676
	nop

$L3418:
	lh	$6,0($12)
	lh	$14,0($13)
	slt	$7,$14,$6
	beq	$7,$0,$L3419
	lh	$3,0($9)

	slt	$7,$14,$3
	beq	$7,$0,$L3420
	nop

	slt	$14,$6,$3
	movz	$6,$3,$14
	b	$L3420
	move	$14,$6

$L3438:
	lw	$7,148($sp)
	beq	$7,$0,$L3440
	lw	$9,172($sp)

	sll	$13,$13,16
	sll	$3,$3,16
	sra	$13,$13,16
	sra	$3,$3,16
	sh	$13,4($2)
	b	$L3439
	sh	$3,6($2)

$L3421:
	beq	$9,$0,$L3414
	nop

	slt	$7,$6,$3
	movz	$3,$6,$7
	b	$L3414
	move	$7,$3

$L3399:
	bne	$7,$19,$L3401
	nop

	lw	$22,6172($16)
	andi	$14,$22,0x1
	bne	$14,$0,$L3400
	slt	$7,$3,20

	bne	$7,$0,$L3406
	nop

$L3405:
	andi	$7,$3,0x7
	li	$23,4			# 0x4
	beq	$7,$23,$L3677
	lw	$23,152($sp)

$L3406:
	addiu	$9,$9,-9
$L3700:
	sll	$9,$9,2
	addu	$3,$8,$3
	addu	$9,$5,$9
	b	$L3404
	lb	$7,9447($3)

$L3670:
	lw	$20,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$9,$20,$3
	lbu	$9,0($9)
	lw	$22,%got(ff_se_golomb_vlc_code)($28)
	addu	$6,$9,$6
	addu	$3,$22,$3
	sw	$6,8456($16)
	b	$L3423
	lb	$13,0($3)

$L3671:
	lw	$14,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$9,$14,$3
	lbu	$9,0($9)
	lw	$20,%got(ff_se_golomb_vlc_code)($28)
	addu	$6,$9,$6
	addu	$3,$20,$3
	sw	$6,8456($16)
	b	$L3431
	lb	$3,0($3)

$L3411:
	slt	$7,$6,$14
	beq	$7,$0,$L3420
	nop

	slt	$14,$6,$3
	movz	$3,$6,$14
	b	$L3420
	move	$14,$3

$L3428:
	b	$L3423
	srl	$13,$3,1

$L3436:
	b	$L3431
	srl	$3,$3,1

$L3426:
	b	$L3427
	srl	$9,$9,8

$L3424:
	li	$12,24			# 0x18
	b	$L3425
	li	$24,16			# 0x10

$L3434:
	b	$L3435
	srl	$9,$9,8

$L3432:
	li	$12,24			# 0x18
	b	$L3433
	li	$24,16			# 0x10

$L3440:
	bne	$9,$0,$L3441
	nop

	sll	$13,$13,16
	sll	$3,$3,16
	sra	$13,$13,16
	b	$L3439
	sra	$3,$3,16

$L3475:
	lw	$4,0($3)
	li	$10,1			# 0x1
	beq	$4,$10,$L3678
	li	$12,2			# 0x2

	beq	$4,$12,$L3479
	nop

	move	$4,$22
	sw	$3,236($sp)
	sw	$6,212($sp)
	sw	$8,232($sp)
	.option	pic0
	jal	get_ue_golomb
	.option	pic2
	sw	$9,228($sp)

	lw	$3,236($sp)
	lw	$28,32($sp)
	lw	$4,0($3)
	lw	$6,212($sp)
	lw	$8,232($sp)
	lw	$9,228($sp)
$L3478:
	sltu	$4,$2,$4
	beq	$4,$0,$L3474
	nop

	sll	$4,$2,8
	addu	$2,$4,$2
	sll	$4,$2,16
	lw	$5,40($sp)
	b	$L3476
	addu	$2,$2,$4

$L3502:
	lw	$6,0($8)
	beq	$6,$15,$L3505
	move	$7,$0

	beq	$6,$14,$L3506
	nop

	lw	$22,8456($16)
	lw	$7,8448($16)
	sra	$3,$22,3
	addu	$7,$7,$3
	lbu	$3,3($7)
	lbu	$23,0($7)
	sw	$3,104($sp)
	lbu	$fp,1($7)
	lbu	$3,2($7)
	lw	$7,104($sp)
	sll	$23,$23,24
	or	$23,$7,$23
	sll	$7,$fp,16
	sll	$3,$3,8
	or	$7,$23,$7
	or	$7,$7,$3
	andi	$3,$22,0x7
	sll	$3,$7,$3
	sltu	$7,$3,$13
	beq	$7,$0,$L3507
	li	$17,-65536			# 0xffffffffffff0000

	and	$7,$3,$17
	beq	$7,$0,$L3680
	move	$7,$3

	srl	$7,$3,16
	li	$fp,24			# 0x18
	li	$23,16			# 0x10
$L3513:
	andi	$17,$7,0xff00
	beq	$17,$0,$L3512
	nop

	srl	$7,$7,8
	move	$23,$fp
$L3512:
	addu	$7,$24,$7
	lbu	$7,0($7)
	addiu	$22,$22,32
	addu	$7,$7,$23
	sll	$7,$7,1
	addiu	$7,$7,-31
	subu	$22,$22,$7
	srl	$7,$3,$7
	sw	$22,8456($16)
	addiu	$7,$7,-1
$L3505:
	sltu	$6,$7,$6
	beq	$6,$0,$L3699
	lui	$6,%hi($LC39)

	sll	$3,$7,8
	addu	$7,$3,$7
	b	$L3503
	andi	$7,$7,0xffff

$L3342:
	beq	$8,$24,$L3681
	move	$20,$0

	beq	$8,$15,$L3345
	nop

	lw	$23,8456($16)
	lw	$7,8448($16)
	sra	$20,$23,3
	addu	$7,$7,$20
	lbu	$20,0($7)
	lbu	$fp,3($7)
	lbu	$17,1($7)
	sll	$20,$20,24
	lbu	$7,2($7)
	or	$20,$fp,$20
	sll	$fp,$17,16
	or	$20,$20,$fp
	sll	$7,$7,8
	or	$7,$20,$7
	andi	$20,$23,0x7
	sll	$7,$7,$20
	sltu	$20,$7,$14
	beq	$20,$0,$L3346
	li	$17,-65536			# 0xffffffffffff0000

	and	$20,$7,$17
	bne	$20,$0,$L3347
	li	$17,24			# 0x18

	li	$17,8			# 0x8
	move	$20,$7
	sw	$17,104($sp)
	move	$fp,$0
$L3351:
	andi	$17,$20,0xff00
	beq	$17,$0,$L3350
	nop

	lw	$fp,104($sp)
	srl	$20,$20,8
$L3350:
	addu	$20,$25,$20
	lbu	$20,0($20)
	addiu	$23,$23,32
	addu	$20,$20,$fp
	sll	$20,$20,1
	addiu	$20,$20,-31
	subu	$23,$23,$20
	srl	$20,$7,$20
	sw	$23,8456($16)
	addiu	$20,$20,-1
$L3349:
	sltu	$23,$20,$8
	beq	$23,$0,$L3501
	move	$7,$20

	b	$L3341
	sw	$20,-12($4)

$L3376:
	beq	$8,$24,$L3682
	move	$20,$0

	beq	$8,$15,$L3379
	nop

	lw	$23,8456($16)
	lw	$7,8448($16)
	sra	$20,$23,3
	addu	$7,$7,$20
	lbu	$20,0($7)
	lbu	$fp,3($7)
	lbu	$17,1($7)
	sll	$20,$20,24
	lbu	$7,2($7)
	or	$20,$fp,$20
	sll	$fp,$17,16
	or	$20,$20,$fp
	sll	$7,$7,8
	or	$7,$20,$7
	andi	$20,$23,0x7
	sll	$7,$7,$20
	sltu	$20,$7,$14
	beq	$20,$0,$L3380
	li	$17,-65536			# 0xffffffffffff0000

	and	$20,$7,$17
	bne	$20,$0,$L3381
	li	$17,24			# 0x18

	li	$17,8			# 0x8
	move	$20,$7
	sw	$17,104($sp)
	move	$fp,$0
$L3385:
	andi	$17,$20,0xff00
	beq	$17,$0,$L3384
	nop

	lw	$fp,104($sp)
	srl	$20,$20,8
$L3384:
	addu	$20,$25,$20
	lbu	$20,0($20)
	addiu	$23,$23,32
	addu	$20,$20,$fp
	sll	$20,$20,1
	addiu	$20,$20,-31
	subu	$23,$23,$20
	srl	$20,$7,$20
	sw	$23,8456($16)
	addiu	$20,$20,-1
$L3383:
	sltu	$8,$20,$8
	bne	$8,$0,$L3378
	move	$7,$20

$L3501:
	lui	$6,%hi($LC39)
$L3699:
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	addiu	$6,$6,%lo($LC39)
$L3615:
	jalr	$25
	move	$5,$0

	b	$L3259
	li	$2,-1			# 0xffffffffffffffff

$L3354:
	beq	$8,$24,$L3683
	move	$20,$0

	beq	$8,$15,$L3357
	nop

	lw	$23,8456($16)
	lw	$7,8448($16)
	sra	$20,$23,3
	addu	$7,$7,$20
	lbu	$20,0($7)
	lbu	$fp,3($7)
	lbu	$17,1($7)
	sll	$20,$20,24
	lbu	$7,2($7)
	or	$20,$fp,$20
	sll	$fp,$17,16
	or	$20,$20,$fp
	sll	$7,$7,8
	or	$7,$20,$7
	andi	$20,$23,0x7
	sll	$7,$7,$20
	sltu	$20,$7,$14
	beq	$20,$0,$L3358
	li	$17,-65536			# 0xffffffffffff0000

	and	$20,$7,$17
	bne	$20,$0,$L3359
	li	$17,24			# 0x18

	li	$17,8			# 0x8
	move	$20,$7
	sw	$17,104($sp)
	move	$fp,$0
$L3363:
	andi	$17,$20,0xff00
	beq	$17,$0,$L3362
	nop

	lw	$fp,104($sp)
	srl	$20,$20,8
$L3362:
	addu	$20,$25,$20
	lbu	$20,0($20)
	addiu	$23,$23,32
	addu	$20,$20,$fp
	sll	$20,$20,1
	addiu	$20,$20,-31
	subu	$23,$23,$20
	srl	$20,$7,$20
	sw	$23,8456($16)
	addiu	$20,$20,-1
$L3361:
	sltu	$23,$20,$8
	beq	$23,$0,$L3501
	move	$7,$20

	b	$L3353
	sw	$20,-8($4)

$L3365:
	beq	$8,$24,$L3684
	move	$20,$0

	beq	$8,$15,$L3368
	nop

	lw	$23,8456($16)
	lw	$7,8448($16)
	sra	$20,$23,3
	addu	$7,$7,$20
	lbu	$20,0($7)
	lbu	$fp,3($7)
	lbu	$17,1($7)
	sll	$20,$20,24
	lbu	$7,2($7)
	or	$20,$fp,$20
	sll	$fp,$17,16
	or	$20,$20,$fp
	sll	$7,$7,8
	or	$7,$20,$7
	andi	$20,$23,0x7
	sll	$7,$7,$20
	sltu	$20,$7,$14
	beq	$20,$0,$L3369
	li	$17,-65536			# 0xffffffffffff0000

	and	$20,$7,$17
	bne	$20,$0,$L3370
	li	$17,24			# 0x18

	li	$17,8			# 0x8
	move	$20,$7
	sw	$17,104($sp)
	move	$fp,$0
$L3374:
	andi	$17,$20,0xff00
	beq	$17,$0,$L3373
	nop

	lw	$fp,104($sp)
	srl	$20,$20,8
$L3373:
	addu	$20,$25,$20
	lbu	$20,0($20)
	addiu	$23,$23,32
	addu	$20,$20,$fp
	sll	$20,$20,1
	addiu	$20,$20,-31
	subu	$23,$23,$20
	srl	$20,$7,$20
	sw	$23,8456($16)
	addiu	$20,$20,-1
$L3372:
	sltu	$23,$20,$8
	beq	$23,$0,$L3501
	move	$7,$20

	b	$L3364
	sw	$20,-4($4)

$L3682:
$L3378:
	b	$L3375
	sw	$20,0($4)

$L3553:
	li	$4,59224			# 0xe758
	li	$2,59228			# 0xe75c
	movn	$2,$4,$3
	addu	$3,$16,$2
	lw	$2,2056($16)
	lw	$3,4($3)
	lw	$9,108($sp)
	sll	$2,$2,8
	addu	$2,$3,$2
	li	$10,16			# 0x10
	move	$4,$16
	move	$5,$20
	move	$6,$22
	move	$7,$19
	sw	$2,20($sp)
	sw	$9,16($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$10,24($sp)

	bltz	$2,$L3304
	lw	$3,40($sp)

	li	$13,59224			# 0xe758
	andi	$3,$3,0x7
	li	$12,59228			# 0xe75c
	movn	$12,$13,$3
	lw	$2,2056($16)
	addu	$3,$16,$12
	lw	$3,4($3)
	sll	$2,$2,8
	addu	$2,$3,$2
	lw	$14,116($sp)
	sw	$2,20($sp)
	move	$4,$16
	li	$2,16			# 0x10
	move	$5,$20
	move	$6,$22
	move	$7,$17
	sw	$14,16($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$2,24($sp)

	bltz	$2,$L3304
	lw	$3,40($sp)

	li	$5,59224			# 0xe758
	andi	$3,$3,0x7
	li	$4,59228			# 0xe75c
	movn	$4,$5,$3
	lw	$2,2056($16)
	addu	$3,$16,$4
	lw	$3,4($3)
	lw	$9,120($sp)
	sll	$2,$2,8
	addu	$2,$3,$2
	li	$10,16			# 0x10
	move	$4,$16
	move	$5,$20
	move	$6,$22
	move	$7,$18
	sw	$2,20($sp)
	sw	$9,16($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$10,24($sp)

	bltz	$2,$L3304
	lw	$3,40($sp)

	li	$13,59224			# 0xe758
	andi	$3,$3,0x7
	li	$12,59228			# 0xe75c
	movn	$12,$13,$3
	lw	$2,2056($16)
	addu	$3,$16,$12
	lw	$3,4($3)
	sll	$2,$2,8
	addu	$2,$3,$2
	lw	$14,128($sp)
	sw	$2,20($sp)
	move	$4,$16
	li	$2,16			# 0x10
	move	$5,$20
	move	$6,$22
	move	$7,$fp
	sw	$14,16($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$2,24($sp)

	bltz	$2,$L3686
	li	$2,-1			# 0xffffffffffffffff

	lbu	$3,0($23)
	addiu	$2,$3,9080
	addu	$2,$16,$2
	addu	$3,$16,$3
	lbu	$6,1($2)
	lbu	$4,9080($3)
	lbu	$5,8($2)
	addu	$6,$6,$4
	lbu	$4,9($2)
	addu	$2,$6,$5
	addu	$2,$2,$4
	b	$L3562
	sb	$2,9080($3)

$L3441:
	sll	$13,$13,16
	sll	$3,$3,16
	sra	$13,$13,16
	sra	$3,$3,16
	sh	$13,32($2)
	b	$L3439
	sh	$3,34($2)

$L3395:
	addu	$2,$7,$18
	sll	$2,$2,2
	addu	$2,$5,$2
	sw	$0,0($2)
	sw	$0,36($2)
	sw	$0,32($2)
	b	$L3394
	sw	$0,4($2)

$L3533:
	lw	$4,2056($16)
	beq	$4,$0,$L3536
	nop

	li	$2,131072			# 0x20000
	ori	$3,$2,0x2364
	ori	$2,$2,0x23b4
	addu	$2,$16,$2
	sw	$2,108($sp)
	addu	$3,$16,$3
	lui	$2,%hi(luma_dc_zigzag_scan)
	sw	$3,104($sp)
	b	$L3535
	addiu	$2,$2,%lo(luma_dc_zigzag_scan)

$L3531:
	addu	$2,$16,$2
	b	$L3532
	lw	$20,6868($2)

$L3672:
	b	$L3394
	lw	$22,208($sp)

$L3419:
	slt	$7,$3,$14
	beq	$7,$0,$L3420
	nop

	slt	$14,$3,$6
	movz	$6,$3,$14
	b	$L3420
	move	$14,$6

$L3675:
	beq	$6,$24,$L3612
	nop

	beq	$6,$25,$L3685
	nop

	lh	$7,2($9)
	b	$L3414
	lh	$14,0($9)

$L3654:
	li	$23,3			# 0x3
	andi	$3,$3,0x7
	move	$4,$23
	movn	$4,$0,$3
	addiu	$3,$4,14801
	sll	$3,$3,2
	lw	$2,8740($16)
	addu	$3,$16,$3
	lw	$22,4($3)
	lw	$5,104($sp)
	sll	$2,$2,6
	addu	$22,$22,$2
	addiu	$21,$5,1
	li	$19,15			# 0xf
	move	$4,$16
	move	$5,$20
	addiu	$6,$17,512
	li	$7,16			# 0x10
	sw	$21,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$19,24($sp)

	bltz	$2,$L3304
	move	$5,$20

	move	$4,$16
	addiu	$6,$17,544
	li	$7,17			# 0x11
	sw	$21,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$19,24($sp)

	bltz	$2,$L3304
	move	$5,$20

	move	$4,$16
	addiu	$6,$17,576
	li	$7,18			# 0x12
	sw	$21,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$19,24($sp)

	bltz	$2,$L3304
	move	$5,$20

	move	$4,$16
	addiu	$6,$17,608
	li	$7,19			# 0x13
	sw	$22,20($sp)
	sw	$21,16($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$19,24($sp)

	bltz	$2,$L3304
	lw	$3,40($sp)

	lw	$2,8744($16)
	andi	$3,$3,0x7
	movn	$23,$0,$3
	addiu	$3,$23,14802
	sll	$3,$3,2
	addu	$3,$16,$3
	lw	$22,4($3)
	sll	$2,$2,6
	addu	$22,$22,$2
	move	$4,$16
	move	$5,$20
	addiu	$6,$17,640
	li	$7,20			# 0x14
	sw	$21,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$19,24($sp)

	bltz	$2,$L3304
	move	$5,$20

	move	$4,$16
	addiu	$6,$17,672
	li	$7,21			# 0x15
	sw	$21,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$19,24($sp)

	bltz	$2,$L3304
	move	$5,$20

	move	$4,$16
	addiu	$6,$17,704
	li	$7,22			# 0x16
	sw	$21,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$19,24($sp)

	bltz	$2,$L3304
	move	$5,$20

	addiu	$6,$17,736
	move	$4,$16
	li	$7,23			# 0x17
	sw	$21,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$19,24($sp)

	bgez	$2,$L3578
	li	$2,-1			# 0xffffffffffffffff

	b	$L3701
	lw	$31,284($sp)

$L3649:
	srl	$3,$3,23
	addu	$6,$6,$3
	lbu	$6,0($6)
	addu	$7,$6,$7
	lw	$6,%got(ff_se_golomb_vlc_code)($28)
	sw	$7,8456($16)
	addu	$3,$6,$3
	b	$L3538
	lb	$7,0($3)

$L3650:
	li	$9,8			# 0x8
	b	$L3540
	move	$8,$0

$L3633:
	addiu	$5,$sp,40
	.option	pic0
	jal	pred_direct_motion
	.option	pic2
	move	$4,$16

	lw	$2,9980($16)
	lw	$28,32($sp)
	lw	$5,40($sp)
	b	$L3305
	and	$20,$20,$2

$L3648:
	lw	$5,40($sp)
	b	$L3529
	lw	$6,8448($16)

$L3400:
	b	$L3405
	li	$14,1			# 0x1

$L3506:
	lw	$3,8456($16)
	lw	$7,8448($16)
	sra	$22,$3,3
	addu	$7,$7,$22
	lbu	$22,0($7)
	andi	$7,$3,0x7
	sll	$7,$22,$7
	andi	$7,$7,0x00ff
	addiu	$3,$3,1
	srl	$7,$7,7
	sw	$3,8456($16)
	b	$L3505
	xori	$7,$7,0x1

$L3676:
	bne	$7,$19,$L3418
	nop

	beq	$24,$19,$L3418
	nop

$L3612:
	lh	$7,2($12)
	b	$L3414
	lh	$14,0($12)

$L3493:
	lw	$12,8456($16)
	lw	$7,8448($16)
	sra	$22,$12,3
	addu	$7,$7,$22
	lbu	$22,0($7)
	andi	$7,$12,0x7
	sll	$7,$22,$7
	andi	$7,$7,0x00ff
	addiu	$12,$12,1
	srl	$7,$7,7
	sw	$12,8456($16)
	b	$L3492
	xori	$7,$7,0x1

$L3473:
	lw	$5,8456($16)
	lw	$2,8448($16)
	sra	$7,$5,3
	addu	$2,$2,$7
	lbu	$7,0($2)
	andi	$2,$5,0x7
	sll	$2,$7,$2
	andi	$2,$2,0x00ff
	addiu	$5,$5,1
	srl	$2,$2,7
	sw	$5,8456($16)
	b	$L3472
	xori	$2,$2,0x1

$L3634:
	beq	$6,$0,$L3305
	li	$8,65536			# 0x10000

	addu	$8,$16,$8
	addiu	$fp,$16,8448
	addiu	$3,$16,9136
	move	$23,$16
	move	$22,$0
	move	$21,$0
	li	$9,4096			# 0x1000
	addiu	$10,$sp,44
	addiu	$11,$sp,48
$L3462:
	sll	$2,$21,1
	sll	$2,$9,$2
	and	$2,$2,$5
	bne	$2,$0,$L3460
	li	$6,4			# 0x4

	move	$4,$0
$L3461:
	sll	$2,$22,5
	sll	$22,$22,3
	addu	$2,$22,$2
	addiu	$2,$2,12
	sll	$2,$2,2
	addu	$2,$3,$2
	sw	$4,108($2)
	sw	$4,0($2)
	sw	$4,4($2)
	sw	$4,8($2)
	sw	$4,12($2)
	sw	$4,32($2)
	sw	$4,36($2)
	sw	$4,40($2)
	sw	$4,44($2)
	sw	$4,64($2)
	sw	$4,68($2)
	sw	$4,72($2)
	sw	$4,76($2)
	sw	$4,96($2)
	sw	$4,100($2)
	sw	$4,104($2)
	lw	$2,5944($8)
	addiu	$21,$21,1
	sltu	$2,$21,$2
	addiu	$23,$23,40
	bne	$2,$0,$L3462
	move	$22,$21

	b	$L3691
	andi	$2,$5,0x78

$L3479:
	lw	$5,8456($16)
	lw	$2,8448($16)
	sra	$7,$5,3
	addu	$2,$2,$7
	lbu	$7,0($2)
	andi	$2,$5,0x7
	sll	$2,$7,$2
	andi	$2,$2,0x00ff
	addiu	$5,$5,1
	srl	$2,$2,7
	sw	$5,8456($16)
	b	$L3478
	xori	$2,$2,0x1

$L3542:
	b	$L3543
	srl	$3,$3,1

$L3534:
	addu	$3,$16,$3
	lw	$7,9360($3)
	lw	$3,9368($3)
	lui	$2,%hi(luma_dc_field_scan)
	sw	$7,104($sp)
	addiu	$2,$2,%lo(luma_dc_field_scan)
	b	$L3535
	sw	$3,108($sp)

$L3258:
	.option	pic0
	jal	predict_field_decoding_flag
	.option	pic2
	move	$4,$16

	b	$L3257
	nop

$L3368:
	lw	$23,8456($16)
	lw	$7,8448($16)
	sra	$20,$23,3
	addu	$7,$7,$20
	lbu	$20,0($7)
	andi	$7,$23,0x7
	sll	$20,$20,$7
	andi	$20,$20,0x00ff
	addiu	$23,$23,1
	srl	$20,$20,7
	sw	$23,8456($16)
	b	$L3372
	xori	$20,$20,0x1

$L3357:
	lw	$23,8456($16)
	lw	$7,8448($16)
	sra	$20,$23,3
	addu	$7,$7,$20
	lbu	$20,0($7)
	andi	$7,$23,0x7
	sll	$20,$20,$7
	andi	$20,$20,0x00ff
	addiu	$23,$23,1
	srl	$20,$20,7
	sw	$23,8456($16)
	b	$L3361
	xori	$20,$20,0x1

$L3345:
	lw	$23,8456($16)
	lw	$7,8448($16)
	sra	$20,$23,3
	addu	$7,$7,$20
	lbu	$20,0($7)
	andi	$7,$23,0x7
	sll	$20,$20,$7
	andi	$20,$20,0x00ff
	addiu	$23,$23,1
	srl	$20,$20,7
	sw	$23,8456($16)
	b	$L3349
	xori	$20,$20,0x1

$L3536:
	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lw	$9,9348($2)
	lw	$2,9356($2)
	sw	$9,104($sp)
	sw	$2,108($sp)
	lui	$2,%hi(luma_dc_zigzag_scan)
	b	$L3535
	addiu	$2,$2,%lo(luma_dc_zigzag_scan)

$L3379:
	lw	$23,8456($16)
	lw	$7,8448($16)
	sra	$20,$23,3
	addu	$7,$7,$20
	lbu	$20,0($7)
	andi	$7,$23,0x7
	sll	$20,$20,$7
	andi	$20,$20,0x00ff
	addiu	$23,$23,1
	srl	$20,$20,7
	sw	$23,8456($16)
	b	$L3383
	xori	$20,$20,0x1

$L3380:
	srl	$7,$7,23
	addu	$20,$22,$7
	lbu	$20,0($20)
	addu	$7,$21,$7
	addu	$23,$20,$23
	sw	$23,8456($16)
	b	$L3383
	lbu	$20,0($7)

$L3678:
	b	$L3478
	move	$2,$0

$L3460:
	lb	$2,9468($23)
	move	$7,$21
	move	$5,$0
	move	$4,$16
	sw	$10,20($sp)
	sw	$11,24($sp)
	sw	$3,236($sp)
	sw	$8,232($sp)
	sw	$9,228($sp)
	sw	$10,220($sp)
	sw	$11,224($sp)
	.option	pic0
	jal	pred_motion
	.option	pic2
	sw	$2,16($sp)

	.option	pic0
	jal	get_se_golomb
	.option	pic2
	move	$4,$fp

	lw	$5,44($sp)
	move	$4,$fp
	addu	$2,$5,$2
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	sw	$2,44($sp)

	lw	$5,48($sp)
	lhu	$4,44($sp)
	addu	$2,$2,$5
	sll	$6,$2,16
	lw	$28,32($sp)
	lw	$5,40($sp)
	addu	$4,$6,$4
	sw	$2,48($sp)
	lw	$11,224($sp)
	lw	$10,220($sp)
	lw	$9,228($sp)
	lw	$8,232($sp)
	b	$L3461
	lw	$3,236($sp)

$L3661:
	b	$L3472
	move	$2,$0

$L3680:
	li	$fp,8			# 0x8
	b	$L3513
	move	$23,$0

$L3507:
	srl	$3,$3,23
	addu	$7,$21,$3
	lbu	$7,0($7)
	addu	$3,$25,$3
	addu	$22,$7,$22
	sw	$22,8456($16)
	b	$L3505
	lbu	$7,0($3)

$L3667:
	li	$fp,8			# 0x8
	b	$L3500
	move	$23,$0

$L3494:
	srl	$7,$7,23
	addu	$12,$21,$7
	lbu	$12,0($12)
	addu	$7,$25,$7
	addu	$22,$12,$22
	sw	$22,8456($16)
	b	$L3492
	lbu	$7,0($7)

$L3684:
	b	$L3364
	sw	$20,-4($4)

$L3369:
	srl	$7,$7,23
	addu	$20,$22,$7
	lbu	$20,0($20)
	addu	$7,$21,$7
	addu	$23,$20,$23
	sw	$23,8456($16)
	b	$L3372
	lbu	$20,0($7)

$L3683:
	b	$L3353
	sw	$20,-8($4)

$L3346:
	srl	$7,$7,23
	addu	$20,$22,$7
	lbu	$20,0($20)
	addu	$7,$21,$7
	addu	$23,$20,$23
	sw	$23,8456($16)
	b	$L3349
	lbu	$20,0($7)

$L3677:
	lb	$7,9467($23)
	beq	$7,$19,$L3406
	nop

	lw	$7,124($sp)
	bne	$7,$0,$L3407
	lw	$23,120($sp)

	lw	$7,8768($16)
	sll	$7,$7,2
	addu	$7,$23,$7
	lw	$7,0($7)
	andi	$7,$7,0x80
	beq	$7,$0,$L3700
	addiu	$9,$9,-9

	ori	$22,$22,0x1
	sll	$22,$22,1
	addu	$7,$22,$14
	sra	$3,$3,4
	addiu	$3,$3,-1
	sll	$7,$7,1
	addu	$7,$3,$7
	lw	$22,152($16)
	sra	$14,$7,2
	lw	$9,6168($16)
	mul	$23,$14,$22
	sll	$9,$9,2
	addiu	$3,$9,-1
	sra	$9,$3,2
	lw	$14,120($sp)
	addu	$9,$23,$9
	sll	$9,$9,2
	addu	$9,$14,$9
	lw	$14,0($9)
	lw	$22,156($sp)
	and	$9,$22,$14
	beq	$9,$0,$L3687
	nop

$L3408:
	lw	$14,9748($16)
	lw	$23,164($sp)
	mul	$22,$7,$14
	addu	$9,$20,$23
	addu	$14,$22,$3
	lw	$22,0($9)
	sll	$9,$14,2
	addu	$9,$22,$9
	lw	$23,168($sp)
	lhu	$14,0($9)
	lw	$22,128($sp)
	addu	$20,$20,$23
	sh	$14,9176($22)
	lw	$14,4($20)
	lw	$20,9752($16)
	sra	$7,$7,1
	mul	$22,$7,$20
	lhu	$9,2($9)
	lw	$23,128($sp)
	addu	$7,$22,$14
	sll	$9,$9,1
	sra	$3,$3,1
	sh	$9,9178($23)
	addu	$3,$7,$3
	lb	$7,0($3)
	lw	$9,136($sp)
	b	$L3404
	sra	$7,$7,1

$L3603:
	lw	$2,8456($16)
	lw	$6,8448($16)
	sra	$3,$2,3
	addu	$3,$6,$3
	lbu	$4,0($3)
	andi	$3,$2,0x7
	sll	$3,$4,$3
	andi	$3,$3,0x00ff
	addiu	$2,$2,1
	srl	$3,$3,7
	beq	$3,$0,$L3526
	sw	$2,8456($16)

	li	$2,16777216			# 0x1000000
	or	$5,$5,$2
	b	$L3526
	sw	$5,40($sp)

$L3358:
	srl	$7,$7,23
	addu	$20,$22,$7
	lbu	$20,0($20)
	addu	$7,$21,$7
	addu	$23,$20,$23
	sw	$23,8456($16)
	b	$L3361
	lbu	$20,0($7)

$L3681:
	b	$L3341
	sw	$20,-12($4)

$L3359:
	srl	$20,$7,16
	sw	$17,104($sp)
	b	$L3363
	li	$fp,16			# 0x10

$L3347:
	srl	$20,$7,16
	sw	$17,104($sp)
	b	$L3351
	li	$fp,16			# 0x10

$L3685:
	lh	$7,2($13)
	b	$L3414
	lh	$14,0($13)

$L3664:
	mflo	$17
$L3515:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	addiu	$13,$sp,44
	addiu	$14,$sp,48
	sw	$2,112($sp)
	addiu	$fp,$16,8448
	addiu	$21,$16,9136
	move	$23,$16
	li	$3,1			# 0x1
	move	$22,$0
	sw	$13,104($sp)
	sw	$14,108($sp)
$L3488:
	sll	$2,$22,1
	li	$4,4096			# 0x1000
	sll	$2,$4,$2
	sltu	$6,$22,$6
	beq	$6,$0,$L3305
	and	$2,$2,$5

	bne	$2,$0,$L3517
	lw	$9,104($sp)

	move	$4,$0
$L3518:
	sw	$4,148($21)
	sw	$4,48($21)
	sw	$4,52($21)
	sw	$4,80($21)
	sw	$4,84($21)
	sw	$4,112($21)
	sw	$4,116($21)
	sw	$4,144($21)
	li	$12,4096			# 0x1000
	lw	$2,40($sp)
	sll	$4,$12,$3
	and	$2,$4,$2
	bne	$2,$0,$L3519
	lw	$13,104($sp)

	move	$4,$0
$L3520:
	lw	$2,112($sp)
	sw	$4,156($21)
	sw	$4,56($21)
	sw	$4,60($21)
	sw	$4,88($21)
	sw	$4,92($21)
	sw	$4,120($21)
	sw	$4,124($21)
	sw	$4,152($21)
	addiu	$22,$22,1
	addiu	$21,$21,160
	addiu	$3,$3,2
	addiu	$23,$23,40
	lw	$6,5944($2)
	b	$L3488
	lw	$5,40($sp)

$L3370:
	srl	$20,$7,16
	sw	$17,104($sp)
	b	$L3374
	li	$fp,16			# 0x10

$L3519:
	lb	$7,9470($23)
	lw	$14,108($sp)
	move	$6,$22
	li	$5,4			# 0x4
	move	$4,$16
	sw	$3,236($sp)
	sw	$13,16($sp)
	.option	pic0
	jal	pred_8x16_motion
	.option	pic2
	sw	$14,20($sp)

	.option	pic0
	jal	get_se_golomb
	.option	pic2
	move	$4,$fp

	lw	$5,44($sp)
	move	$4,$fp
	addu	$2,$5,$2
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	sw	$2,44($sp)

	lw	$5,48($sp)
	lhu	$4,44($sp)
	addu	$2,$2,$5
	sll	$5,$2,16
	lw	$28,32($sp)
	addu	$4,$5,$4
	sw	$2,48($sp)
	b	$L3520
	lw	$3,236($sp)

$L3517:
	lb	$7,9468($23)
	lw	$10,108($sp)
	move	$6,$22
	move	$5,$0
	move	$4,$16
	sw	$3,236($sp)
	sw	$9,16($sp)
	.option	pic0
	jal	pred_8x16_motion
	.option	pic2
	sw	$10,20($sp)

	.option	pic0
	jal	get_se_golomb
	.option	pic2
	move	$4,$fp

	lw	$5,44($sp)
	move	$4,$fp
	addu	$2,$5,$2
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	sw	$2,44($sp)

	lw	$5,48($sp)
	lhu	$4,44($sp)
	addu	$2,$2,$5
	sll	$5,$2,16
	lw	$28,32($sp)
	addu	$4,$5,$4
	sw	$2,48($sp)
	b	$L3518
	lw	$3,236($sp)

$L3314:
	lw	$3,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$3,$3,$2
	lbu	$3,0($3)
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	addu	$4,$3,$4
	addu	$2,$5,$2
	lbu	$2,0($2)
	b	$L3317
	sw	$4,8456($16)

$L3335:
	li	$7,24			# 0x18
	b	$L3336
	li	$6,16			# 0x10

$L3656:
	lw	$3,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$3,$3,$2
	lbu	$3,0($3)
	addu	$5,$3,$5
	lw	$3,%got(ff_ue_golomb_vlc_code)($28)
	sw	$5,8456($16)
	addu	$2,$3,$2
	b	$L3334
	lbu	$2,0($2)

$L3328:
	li	$8,24			# 0x18
	b	$L3332
	li	$7,16			# 0x10

$L3327:
	lw	$3,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$3,$3,$2
	lbu	$3,0($3)
	lw	$7,%got(ff_ue_golomb_vlc_code)($28)
	addu	$5,$3,$5
	addu	$2,$7,$2
	lbu	$2,0($2)
	b	$L3330
	sw	$5,8456($16)

$L3322:
	li	$8,24			# 0x18
	b	$L3326
	li	$7,16			# 0x10

$L3321:
	lw	$3,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$3,$3,$2
	lbu	$3,0($3)
	lw	$7,%got(ff_ue_golomb_vlc_code)($28)
	addu	$5,$3,$5
	addu	$2,$7,$2
	lbu	$2,0($2)
	b	$L3324
	sw	$5,8456($16)

$L3659:
	move	$2,$0
	addiu	$22,$16,8448
$L3481:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	addiu	$14,$sp,44
	addiu	$4,$sp,48
	sw	$3,112($sp)
	addiu	$21,$16,9136
	move	$fp,$16
	li	$3,1			# 0x1
	move	$23,$0
	sw	$14,104($sp)
	sw	$4,108($sp)
$L3468:
	sll	$4,$23,1
	li	$13,4096			# 0x1000
	sll	$4,$13,$4
	sltu	$2,$23,$2
	beq	$2,$0,$L3305
	and	$4,$4,$5

	beq	$4,$0,$L3485
	lw	$14,104($sp)

	lb	$7,9468($fp)
	lw	$2,108($sp)
	move	$6,$23
	move	$5,$0
	move	$4,$16
	sw	$3,236($sp)
	sw	$14,16($sp)
	.option	pic0
	jal	pred_16x8_motion
	.option	pic2
	sw	$2,20($sp)

	.option	pic0
	jal	get_se_golomb
	.option	pic2
	move	$4,$22

	lw	$5,44($sp)
	move	$4,$22
	addu	$2,$5,$2
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	sw	$2,44($sp)

	lw	$5,48($sp)
	lhu	$4,44($sp)
	addu	$2,$2,$5
	sll	$5,$2,16
	lw	$28,32($sp)
	lw	$3,236($sp)
	addu	$4,$5,$4
	sw	$2,48($sp)
$L3485:
	sw	$4,92($21)
	sw	$4,48($21)
	sw	$4,52($21)
	sw	$4,56($21)
	sw	$4,60($21)
	sw	$4,80($21)
	sw	$4,84($21)
	sw	$4,88($21)
	li	$5,4096			# 0x1000
	lw	$2,40($sp)
	sll	$4,$5,$3
	and	$2,$4,$2
	bne	$2,$0,$L3486
	lw	$9,104($sp)

	move	$4,$0
$L3487:
	lw	$12,112($sp)
	sw	$4,156($21)
	sw	$4,112($21)
	sw	$4,116($21)
	sw	$4,120($21)
	sw	$4,124($21)
	sw	$4,144($21)
	sw	$4,148($21)
	sw	$4,152($21)
	addiu	$23,$23,1
	addiu	$21,$21,160
	addiu	$3,$3,2
	addiu	$fp,$fp,40
	lw	$2,5944($12)
	b	$L3468
	lw	$5,40($sp)

$L3315:
	li	$7,24			# 0x18
	b	$L3319
	li	$5,16			# 0x10

$L3293:
	lw	$2,6172($16)
	lw	$3,6168($16)
	lui	$6,%hi($LC25)
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	addiu	$6,$6,%lo($LC25)
	sw	$3,16($sp)
	sw	$2,20($sp)
$L3614:
	jalr	$25
	move	$5,$0

	b	$L3259
	li	$2,-1			# 0xffffffffffffffff

$L3652:
	sw	$3,2056($16)
	b	$L3545
	move	$4,$3

$L3381:
	srl	$20,$7,16
	sw	$17,104($sp)
	b	$L3385
	li	$fp,16			# 0x10

$L3299:
	lw	$2,6172($16)
	lw	$3,6168($16)
	lui	$6,%hi($LC26)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	sw	$3,16($sp)
	sw	$2,20($sp)
	b	$L3614
	addiu	$6,$6,%lo($LC26)

$L3486:
	lb	$7,9484($fp)
	lw	$10,108($sp)
	move	$6,$23
	li	$5,8			# 0x8
	move	$4,$16
	sw	$3,236($sp)
	sw	$9,16($sp)
	.option	pic0
	jal	pred_16x8_motion
	.option	pic2
	sw	$10,20($sp)

	.option	pic0
	jal	get_se_golomb
	.option	pic2
	move	$4,$22

	lw	$5,44($sp)
	move	$4,$22
	addu	$2,$5,$2
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	sw	$2,44($sp)

	lw	$5,48($sp)
	lhu	$4,44($sp)
	addu	$2,$2,$5
	sll	$5,$2,16
	lw	$28,32($sp)
	addu	$4,$5,$4
	sw	$2,48($sp)
	b	$L3487
	lw	$3,236($sp)

$L3320:
	lw	$2,6172($16)
	lw	$3,6168($16)
	lui	$6,%hi($LC38)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	sw	$3,16($sp)
	sw	$2,20($sp)
	b	$L3614
	addiu	$6,$6,%lo($LC38)

$L3391:
	b	$L3305
	lw	$5,40($sp)

$L3474:
	lui	$6,%hi($LC39)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	addiu	$6,$6,%lo($LC39)
	b	$L3615
	move	$7,$2

$L3628:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$25,%call16(av_get_pict_type_char)($28)
	lw	$4,-6284($2)
	sw	$7,212($sp)
	jalr	$25
	lw	$17,0($16)

	lw	$28,32($sp)
	lw	$4,6168($16)
	lw	$3,6172($16)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC36)
	lw	$7,212($sp)
	sw	$2,16($sp)
	sw	$4,20($sp)
	sw	$3,24($sp)
	move	$4,$17
	addiu	$6,$6,%lo($LC36)
	jalr	$25
	move	$5,$0

	b	$L3259
	li	$2,-1			# 0xffffffffffffffff

$L3407:
	lw	$7,8768($16)
	lw	$14,120($sp)
	sll	$7,$7,2
	addu	$7,$14,$7
	lw	$7,0($7)
	andi	$7,$7,0x80
	bne	$7,$0,$L3406
	nop

	slt	$7,$3,20
	bne	$7,$0,$L3700
	addiu	$9,$9,-9

	and	$22,$22,$19
	addiu	$3,$3,-12
	sll	$22,$22,1
	sra	$3,$3,3
	lw	$7,6168($16)
	addu	$3,$22,$3
	sll	$22,$3,1
	sll	$7,$7,2
	addiu	$3,$7,-1
	addiu	$7,$22,-1
	lw	$22,152($16)
	sra	$14,$7,2
	mul	$23,$14,$22
	sra	$9,$3,2
	lw	$14,120($sp)
	addu	$9,$23,$9
	sll	$9,$9,2
	addu	$9,$14,$9
	lw	$14,0($9)
	lw	$22,156($sp)
	and	$9,$22,$14
	beq	$9,$0,$L3688
	nop

$L3409:
	lw	$14,9748($16)
	lw	$23,164($sp)
	mul	$22,$7,$14
	addu	$9,$20,$23
	addu	$14,$22,$3
	lw	$22,0($9)
	sll	$9,$14,2
	addu	$9,$22,$9
	lw	$23,168($sp)
	lhu	$14,0($9)
	lw	$22,128($sp)
	addu	$20,$20,$23
	sh	$14,9176($22)
	lw	$14,4($20)
	lw	$20,9752($16)
	sra	$7,$7,1
	mul	$22,$7,$20
	lh	$9,2($9)
	lw	$23,128($sp)
	addu	$7,$22,$14
	sra	$9,$9,1
	sra	$3,$3,1
	sh	$9,9178($23)
	addu	$3,$7,$3
	lb	$7,0($3)
	lw	$9,136($sp)
	b	$L3404
	sll	$7,$7,1

$L3651:
	lw	$2,6172($16)
	lw	$3,6168($16)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	sw	$3,16($sp)
	sw	$2,20($sp)
	b	$L3614
	addiu	$6,$6,%lo($LC41)

$L3687:
	andi	$9,$14,0x40
	bne	$9,$0,$L3408
	nop

	lw	$9,136($sp)
	b	$L3404
	li	$7,-1			# 0xffffffffffffffff

$L3688:
	andi	$9,$14,0x40
	bne	$9,$0,$L3409
	nop

	lw	$9,136($sp)
	b	$L3404
	li	$7,-1			# 0xffffffffffffffff

$L3668:
	lw	$3,6172($16)
	lw	$5,6168($16)
	lui	$6,%hi($LC37)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	sw	$5,16($sp)
	sw	$3,20($sp)
	addiu	$6,$6,%lo($LC37)
	b	$L3614
	move	$7,$2

$L3662:
	lw	$3,6172($16)
	lw	$5,6168($16)
	lui	$6,%hi($LC40)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	sw	$5,16($sp)
	sw	$3,20($sp)
	addiu	$6,$6,%lo($LC40)
	b	$L3614
	move	$7,$2

$L3657:
	b	$L3313
	move	$7,$0

$L3653:
	li	$21,65536			# 0x10000
	li	$22,131072			# 0x20000
	addu	$21,$16,$21
	lw	$3,-6332($21)
	addu	$22,$16,$22
	lw	$5,6864($22)
	sll	$4,$4,6
	addu	$3,$3,$4
	sw	$2,16($sp)
	move	$4,$16
	li	$2,16			# 0x10
	move	$6,$17
	li	$7,25			# 0x19
	sw	$3,20($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$2,24($sp)

	bltz	$2,$L3304
	andi	$2,$19,0xf

	beq	$2,$0,$L3548
	addiu	$2,$16,9092

	lw	$10,104($sp)
	move	$8,$22
	move	$3,$21
	addiu	$9,$10,1
	move	$23,$17
	move	$21,$0
	li	$10,4			# 0x4
	li	$11,15			# 0xf
	li	$12,16			# 0x10
	move	$22,$20
	move	$13,$19
$L3549:
	move	$20,$23
	b	$L3550
	move	$19,$0

$L3690:
	beq	$19,$10,$L3689
	addiu	$20,$20,32

$L3550:
	lw	$2,2056($16)
	lw	$4,-6332($3)
	lw	$5,6864($8)
	sll	$2,$2,6
	addu	$2,$4,$2
	addu	$7,$21,$19
	move	$6,$20
	move	$4,$16
	sw	$9,16($sp)
	sw	$11,24($sp)
	sw	$3,236($sp)
	sw	$8,232($sp)
	sw	$9,228($sp)
	sw	$10,220($sp)
	sw	$11,224($sp)
	sw	$12,212($sp)
	sw	$13,216($sp)
	.option	pic0
	jal	decode_residual
	.option	pic2
	sw	$2,20($sp)

	addiu	$19,$19,1
	lw	$3,236($sp)
	lw	$8,232($sp)
	lw	$9,228($sp)
	lw	$10,220($sp)
	lw	$11,224($sp)
	lw	$12,212($sp)
	bgez	$2,$L3690
	lw	$13,216($sp)

	b	$L3686
	li	$2,-1			# 0xffffffffffffffff

$L3669:
	bne	$7,$0,$L3402
	lw	$9,136($sp)

	b	$L3404
	li	$7,-1			# 0xffffffffffffffff

$L3388:
	b	$L3387
	move	$20,$0

$L3663:
	b	$L3515
	move	$6,$0

$L3689:
	addiu	$21,$21,4
	bne	$21,$12,$L3549
	addiu	$23,$23,128

	move	$20,$22
	b	$L3551
	move	$19,$13

$L3548:
	sw	$0,9092($16)
	sw	$0,24($2)
	sw	$0,8($2)
	b	$L3551
	sw	$0,16($2)

	.set	macro
	.set	reorder
	.end	decode_mb_cavlc
	.size	decode_mb_cavlc, .-decode_mb_cavlc
	.section	.rodata.str1.4
	.align	2
$LC42:
	.ascii	"slice type too large (%d) at %d %d\012\000"
	.align	2
$LC43:
	.ascii	"pps_id out of range\012\000"
	.align	2
$LC44:
	.ascii	"non existing PPS referenced\012\000"
	.align	2
$LC45:
	.ascii	"non existing SPS referenced\012\000"
	.align	2
$LC46:
	.ascii	"PAFF interlacing is not implemented\012\000"
	.align	2
$LC47:
	.ascii	"first_mb_in_slice overflow\012\000"
	.align	2
$LC48:
	.ascii	"MBAFF + spatial direct mode is not implemented\012\000"
	.align	2
$LC49:
	.ascii	"reference overflow\012\000"
	.align	2
$LC50:
	.ascii	"illegal long ref in memory management control operation "
	.ascii	"%d\012\000"
	.align	2
$LC51:
	.ascii	"illegal memory management control operation %d\012\000"
	.align	2
$LC52:
	.ascii	"cabac_init_idc overflow\012\000"
	.align	2
$LC53:
	.ascii	"QP %u out of range\012\000"
	.align	2
$LC54:
	.ascii	"deblocking_filter_idc %u out of range\012\000"
	.align	2
$LC55:
	.ascii	"Cannot parallelize deblocking type 1, decoding such fram"
	.ascii	"es in sequential order\012\000"
	.align	2
$LC56:
	.ascii	"F\000"
	.align	2
$LC57:
	.ascii	"B\000"
	.align	2
$LC58:
	.ascii	"T\000"
	.align	2
$LC59:
	.ascii	"c\000"
	.align	2
$LC60:
	.ascii	"\000"
	.align	2
$LC61:
	.ascii	"slice:%d %s mb:%d %c pps:%u frame:%d poc:%d/%d ref:%d/%d"
	.ascii	" qp:%d loop:%d:%d:%d weight:%d%s\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_slice_header
	.type	decode_slice_header, @function
decode_slice_header:
	.frame	$sp,160,$31		# vars= 32, regs= 10/0, args= 80, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-160
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,156($sp)
	sw	$fp,152($sp)
	sw	$23,148($sp)
	sw	$22,144($sp)
	sw	$21,140($sp)
	sw	$20,136($sp)
	sw	$19,132($sp)
	sw	$18,128($sp)
	sw	$17,124($sp)
	sw	$16,120($sp)
	.cprestore	80
	move	$16,$4
	lw	$6,8704($16)
	lw	$4,8456($4)
	lw	$2,8448($16)
	sltu	$6,$6,1
	sra	$3,$4,3
	sw	$6,2096($16)
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$8,3($3)
	lbu	$6,1($3)
	sll	$7,$7,24
	lbu	$3,2($3)
	or	$7,$8,$7
	sll	$6,$6,16
	sll	$3,$3,8
	or	$6,$7,$6
	or	$6,$6,$3
	andi	$3,$4,0x7
	sll	$3,$6,$3
	li	$6,134217728			# 0x8000000
	sltu	$6,$3,$6
	beq	$6,$0,$L4052
	move	$17,$5

	li	$5,-65536			# 0xffffffffffff0000
	and	$5,$3,$5
	bne	$5,$0,$L3705
	srl	$5,$3,16

	move	$5,$3
	andi	$7,$5,0xff00
	li	$6,8			# 0x8
	bne	$7,$0,$L3707
	move	$8,$0

$L4062:
	move	$6,$8
$L3708:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$5,$7,$5
	lbu	$19,0($5)
	addu	$19,$19,$6
	sll	$19,$19,1
	addiu	$19,$19,-31
	subu	$4,$4,$19
	srl	$19,$3,$19
	sw	$4,8456($16)
	addiu	$19,$19,-1
$L3704:
	lw	$3,60($16)
	andi	$3,$3,0x8000
	beq	$3,$0,$L4144
	sra	$3,$4,3

	bne	$19,$0,$L4145
	addu	$3,$2,$3

	li	$3,131072			# 0x20000
	addu	$3,$17,$3
	lw	$4,8456($16)
	sw	$0,9408($3)
	sw	$0,1880($16)
	sra	$3,$4,3
$L4144:
	addu	$3,$2,$3
$L4145:
	lbu	$6,0($3)
	lbu	$7,3($3)
	lbu	$5,1($3)
	sll	$6,$6,24
	lbu	$3,2($3)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$3,$3,8
	or	$5,$6,$5
	or	$5,$5,$3
	andi	$3,$4,0x7
	sll	$3,$5,$3
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4053
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L3712
	srl	$5,$3,16

	move	$5,$3
	andi	$7,$5,0xff00
	li	$6,8			# 0x8
	bne	$7,$0,$L3714
	move	$8,$0

$L4093:
	move	$6,$8
$L3715:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$5,$7,$5
	lbu	$5,0($5)
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$4,$4,$5
	srl	$3,$3,$5
	sw	$4,8456($16)
	addiu	$3,$3,-1
$L3711:
	sltu	$4,$3,10
	beq	$4,$0,$L4054
	sltu	$4,$3,5

	bne	$4,$0,$L3718
	li	$4,65536			# 0x10000

	addu	$4,$16,$4
	li	$5,1			# 0x1
	sw	$5,-6280($4)
	lui	$4,%hi(slice_type_map.15291)
	addiu	$3,$3,-5
	addiu	$4,$4,%lo(slice_type_map.15291)
	addu	$3,$3,$4
	lbu	$18,0($3)
	li	$3,1			# 0x1
	beq	$18,$3,$L3721
	li	$21,1			# 0x1

	li	$3,131072			# 0x20000
$L4147:
	addu	$3,$17,$3
	lw	$4,9408($3)
	bne	$4,$0,$L3722
	nop

	move	$21,$0
$L3721:
	lw	$3,8456($16)
	li	$5,65536			# 0x10000
	addu	$5,$16,$5
	sra	$4,$3,3
	sw	$18,-6284($5)
	addu	$2,$2,$4
	sw	$18,2084($16)
	lbu	$5,0($2)
	lbu	$6,3($2)
	lbu	$4,1($2)
	sll	$5,$5,24
	lbu	$2,2($2)
	or	$5,$6,$5
	sll	$4,$4,16
	sll	$2,$2,8
	or	$4,$5,$4
	or	$4,$4,$2
	andi	$2,$3,0x7
	sll	$2,$4,$2
	li	$4,134217728			# 0x8000000
	sltu	$4,$2,$4
	beq	$4,$0,$L4056
	li	$4,-65536			# 0xffffffffffff0000

	and	$4,$2,$4
	bne	$4,$0,$L3725
	srl	$4,$2,16

	move	$4,$2
	li	$5,8			# 0x8
	move	$7,$0
$L3726:
	andi	$6,$4,0xff00
	bne	$6,$0,$L3727
	nop

	move	$5,$7
$L3728:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$3,$3,32
	addu	$4,$6,$4
	lbu	$20,0($4)
	addu	$20,$20,$5
	sll	$20,$20,1
	addiu	$20,$20,-31
	subu	$3,$3,$20
	srl	$20,$2,$20
	sw	$3,8456($16)
	addiu	$20,$20,-1
$L3724:
	sltu	$2,$20,256
	beq	$2,$0,$L4057
	lui	$6,%hi($LC43)

	addiu	$2,$20,2694
	sll	$2,$2,2
	addu	$2,$17,$2
	lw	$2,4($2)
	beq	$2,$0,$L4058
	addiu	$fp,$16,11804

	move	$3,$fp
	addiu	$4,$2,800
$L3731:
	lw	$8,0($2)
	lw	$7,4($2)
	lw	$6,8($2)
	lw	$5,12($2)
	addiu	$2,$2,16
	sw	$8,0($3)
	sw	$7,4($3)
	sw	$6,8($3)
	sw	$5,12($3)
	bne	$2,$4,$L3731
	addiu	$3,$3,16

	lw	$4,4($2)
	lw	$2,0($2)
	sw	$4,4($3)
	sw	$2,0($3)
	lw	$2,11804($16)
	addiu	$2,$2,2446
	sll	$2,$2,2
	addu	$2,$17,$2
	lw	$2,4($2)
	beq	$2,$0,$L4059
	addiu	$23,$16,9916

	move	$3,$23
	addiu	$4,$2,864
$L3733:
	lw	$8,0($2)
	lw	$7,4($2)
	lw	$6,8($2)
	lw	$5,12($2)
	addiu	$2,$2,16
	sw	$8,0($3)
	sw	$7,4($3)
	sw	$6,8($3)
	sw	$5,12($3)
	bne	$2,$4,$L3733
	addiu	$3,$3,16

	beq	$16,$17,$L4060
	li	$2,65536			# 0x10000

$L3734:
	lw	$3,9972($16)
	lw	$2,9964($16)
	lw	$6,9968($16)
	li	$4,2			# 0x2
	subu	$4,$4,$3
	lw	$5,9992($16)
	mul	$4,$4,$6
	sll	$7,$2,3
	lw	$6,9988($16)
	subu	$5,$7,$5
	subu	$5,$5,$6
	sll	$5,$5,1
	sll	$7,$2,2
	sll	$6,$2,1
	sw	$7,9748($16)
	sw	$6,9752($16)
	sw	$2,144($16)
	sw	$4,148($16)
	beq	$3,$0,$L3735
	sw	$5,4($16)

	lw	$2,10000($16)
	lw	$6,9996($16)
	subu	$2,$0,$2
	sll	$4,$4,3
	subu	$2,$2,$6
	addu	$2,$2,$4
	lw	$4,112($16)
	sll	$2,$2,1
	bne	$4,$0,$L4061
	sw	$2,8($16)

$L3737:
	beq	$16,$17,$L4146
	lw	$25,%call16(MPV_common_init)($28)

$L3740:
	li	$2,-1			# 0xffffffffffffffff
$L3717:
	lw	$31,156($sp)
	lw	$fp,152($sp)
	lw	$23,148($sp)
	lw	$22,144($sp)
	lw	$21,140($sp)
	lw	$20,136($sp)
	lw	$19,132($sp)
	lw	$18,128($sp)
	lw	$17,124($sp)
	lw	$16,120($sp)
	j	$31
	addiu	$sp,$sp,160

$L3705:
	andi	$7,$5,0xff00
	li	$6,24			# 0x18
	beq	$7,$0,$L4062
	li	$8,16			# 0x10

$L3707:
	b	$L3708
	srl	$5,$5,8

$L3718:
	addu	$4,$16,$4
	sw	$0,-6280($4)
	lui	$4,%hi(slice_type_map.15291)
	addiu	$4,$4,%lo(slice_type_map.15291)
	addu	$3,$3,$4
	lbu	$18,0($3)
	li	$3,1			# 0x1
	bne	$18,$3,$L4147
	li	$3,131072			# 0x20000

	b	$L3721
	li	$21,1			# 0x1

$L3735:
	lw	$2,10000($16)
	lw	$6,9996($16)
	subu	$2,$0,$2
	sll	$4,$4,2
	subu	$2,$2,$6
	addu	$2,$2,$4
	lw	$4,112($16)
	sll	$2,$2,2
	beq	$4,$0,$L3737
	sw	$2,8($16)

$L4061:
	lw	$4,0($16)
	lw	$6,40($4)
	bne	$5,$6,$L3738
	nop

	lw	$4,44($4)
	bne	$4,$2,$L3738
	nop

$L3739:
	lw	$5,8456($16)
	lw	$2,8448($16)
	sra	$4,$5,3
	addu	$4,$2,$4
	lbu	$9,0($4)
	lbu	$7,3($4)
	lbu	$8,1($4)
	lbu	$6,2($4)
	sll	$4,$9,24
	or	$7,$7,$4
	sll	$4,$8,16
	or	$7,$7,$4
	sll	$6,$6,8
	lw	$4,9928($16)
	or	$7,$7,$6
	andi	$6,$5,0x7
	sll	$7,$7,$6
	addu	$5,$5,$4
	subu	$6,$0,$4
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	srl	$6,$7,$6
	sw	$6,-6228($4)
	sw	$5,8456($16)
	sw	$0,-6268($4)
	bne	$3,$0,$L4043
	sw	$0,-6276($4)

	sra	$3,$5,3
	addu	$3,$2,$3
	lbu	$6,0($3)
	andi	$3,$5,0x7
	sll	$6,$6,$3
	andi	$6,$6,0x00ff
	addiu	$3,$5,1
	srl	$6,$6,7
	bne	$6,$0,$L4063
	sw	$3,8456($16)

	lw	$2,9976($16)
	sw	$2,-6276($4)
$L4043:
	li	$2,3			# 0x3
	sw	$2,8500($16)
$L3758:
	li	$2,131072			# 0x20000
	addu	$2,$17,$2
	lw	$2,9408($2)
	beq	$2,$0,$L4064
	nop

$L3760:
	beq	$16,$17,$L3761
	addiu	$2,$17,9548

	addiu	$3,$16,9548
	addiu	$4,$17,9740
$L3762:
	lw	$8,0($2)
	lw	$7,4($2)
	lw	$6,8($2)
	lw	$5,12($2)
	addiu	$2,$2,16
	sw	$8,0($3)
	sw	$7,4($3)
	sw	$6,8($3)
	sw	$5,12($3)
	bne	$2,$4,$L3762
	addiu	$3,$3,16

	lw	$3,1880($17)
	addiu	$2,$17,1464
	sw	$3,1880($16)
	addiu	$4,$17,1864
	addiu	$3,$16,1464
$L3763:
	lw	$8,0($2)
	lw	$7,4($2)
	lw	$6,8($2)
	lw	$5,12($2)
	addiu	$2,$2,16
	sw	$8,0($3)
	sw	$7,4($3)
	sw	$6,8($3)
	sw	$5,12($3)
	bne	$2,$4,$L3763
	addiu	$3,$3,16

	lw	$6,4($2)
	lw	$2,0($2)
	li	$4,65536			# 0x10000
	li	$5,131072			# 0x20000
	sw	$6,4($3)
	sw	$2,0($3)
	addu	$6,$17,$5
	addu	$2,$17,$4
	ori	$3,$4,0x173c
	lw	$12,-6208($2)
	lw	$11,6828($6)
	lw	$8,-6224($2)
	lw	$7,-6220($2)
	lw	$6,-6212($2)
	lw	$10,176($17)
	lw	$9,180($17)
	addu	$4,$16,$4
	addu	$2,$17,$3
	addu	$5,$16,$5
	sw	$12,-6208($4)
	sw	$8,-6224($4)
	sw	$7,-6220($4)
	sw	$6,-6212($4)
	sw	$11,6828($5)
	sw	$10,176($16)
	sw	$9,180($16)
	addu	$3,$16,$3
	addiu	$4,$2,128
$L3764:
	lw	$8,0($2)
	lw	$7,4($2)
	lw	$6,8($2)
	lw	$5,12($2)
	addiu	$2,$2,16
	sw	$8,0($3)
	sw	$7,4($3)
	sw	$6,8($3)
	sw	$5,12($3)
	bne	$2,$4,$L3764
	addiu	$3,$3,16

	li	$3,65536			# 0x10000
	ori	$3,$3,0x17bc
	addu	$2,$17,$3
	addiu	$4,$2,128
	addu	$3,$16,$3
$L3765:
	lw	$8,0($2)
	lw	$7,4($2)
	lw	$6,8($2)
	lw	$5,12($2)
	addiu	$2,$2,16
	sw	$8,0($3)
	sw	$7,4($3)
	sw	$6,8($3)
	sw	$5,12($3)
	bne	$2,$4,$L3765
	addiu	$3,$3,16

	li	$3,65536			# 0x10000
	ori	$3,$3,0x1840
	addu	$2,$17,$3
	addiu	$4,$2,26112
	addu	$3,$16,$3
$L3766:
	lw	$8,0($2)
	lw	$7,4($2)
	lw	$6,8($2)
	lw	$5,12($2)
	addiu	$2,$2,16
	sw	$8,0($3)
	sw	$7,4($3)
	sw	$6,8($3)
	sw	$5,12($3)
	bne	$2,$4,$L3766
	addiu	$3,$3,16

	li	$3,65536			# 0x10000
	ori	$3,$3,0x7e40
	addu	$2,$17,$3
	li	$4,39168			# 0x9900
	addu	$3,$16,$3
	addu	$4,$2,$4
$L3767:
	lw	$8,0($2)
	lw	$7,4($2)
	lw	$6,8($2)
	lw	$5,12($2)
	addiu	$2,$2,16
	sw	$8,0($3)
	sw	$7,4($3)
	sw	$6,8($3)
	sw	$5,12($3)
	bne	$2,$4,$L3767
	addiu	$3,$3,16

	li	$2,59204			# 0xe744
	li	$4,59228			# 0xe75c
	addu	$3,$17,$2
	addu	$5,$17,$4
	lw	$12,20($3)
	lw	$10,0($3)
	lw	$9,4($3)
	lw	$8,8($3)
	lw	$7,12($3)
	lw	$6,16($3)
	lw	$11,4($5)
	lw	$5,0($5)
	addu	$2,$16,$2
	addu	$3,$16,$4
	sw	$12,20($2)
	sw	$11,4($3)
	sw	$10,0($2)
	sw	$9,4($2)
	sw	$8,8($2)
	sw	$7,12($2)
	sw	$6,16($2)
	sw	$5,0($3)
$L3761:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$4,-6228($2)
	lw	$3,1880($16)
	sw	$4,232($3)
	lw	$4,-6276($2)
	lw	$2,172($16)
	sltu	$4,$0,$4
	sll	$3,$19,$4
	sltu	$3,$3,$2
	beq	$3,$0,$L4148
	lui	$6,%hi($LC47)

	sltu	$2,$19,$2
	beq	$2,$0,$L3768
	nop

	lw	$2,144($16)
	lw	$3,8500($16)
	divu	$0,$19,$2
	teq	$2,$0,7
	mfhi	$2
	mflo	$9
	sw	$2,7960($16)
	sll	$4,$9,$4
	sw	$2,6168($16)
	li	$2,2			# 0x2
	sw	$4,6172($16)
	beq	$3,$2,$L4065
	sw	$4,7964($16)

$L3770:
	li	$2,3			# 0x3
	beq	$3,$2,$L4066
	li	$2,65536			# 0x10000

	addu	$2,$16,$2
	lw	$4,-6228($2)
	lw	$5,9928($16)
	sll	$4,$4,1
	addiu	$4,$4,1
	addiu	$5,$5,1
	li	$6,1			# 0x1
	sw	$4,-6204($2)
	sll	$5,$6,$5
	lw	$4,8708($16)
	sw	$5,-6200($2)
	li	$2,5			# 0x5
	beq	$4,$2,$L4067
	nop

$L3773:
	lw	$22,9932($16)
	beq	$22,$0,$L4068
	nop

$L3778:
	li	$2,1			# 0x1
$L4152:
	beq	$22,$2,$L4032
	nop

$L4044:
	lw	$3,8500($16)
$L3781:
	lw	$5,8708($16)
	li	$2,5			# 0x5
	beq	$5,$2,$L4069
	lw	$7,9928($16)

	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	lw	$6,-6228($4)
	lw	$2,-6208($4)
	slt	$2,$6,$2
	beq	$2,$0,$L3784
	nop

	lw	$2,-6212($4)
	li	$6,1			# 0x1
	sll	$6,$6,$7
	addu	$6,$6,$2
	sw	$6,-6216($4)
$L3783:
	bne	$22,$0,$L3785
	li	$2,1			# 0x1

	lw	$2,9936($16)
	li	$4,1			# 0x1
	sll	$4,$4,$2
	li	$2,5			# 0x5
	beq	$5,$2,$L3786
	li	$5,65536			# 0x10000

	addu	$5,$16,$5
	lw	$2,-6224($5)
	lw	$6,-6220($5)
$L3787:
	li	$7,65536			# 0x10000
	addu	$7,$16,$7
	lw	$5,-6248($7)
	slt	$8,$5,$6
	beq	$8,$0,$L3788
	slt	$8,$6,$5

	srl	$8,$4,31
	addu	$8,$8,$4
	subu	$5,$6,$5
	sra	$8,$8,1
	slt	$5,$5,$8
	beq	$5,$0,$L4070
	nop

$L3789:
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	sw	$2,-6244($4)
$L3790:
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	lw	$5,-6248($4)
	addu	$2,$2,$5
	li	$5,3			# 0x3
	beq	$3,$5,$L3791
	nop

$L4045:
	move	$5,$2
	move	$4,$2
$L3792:
	li	$6,2			# 0x2
	beq	$3,$6,$L4071
	nop

$L3999:
	lw	$3,1880($16)
	li	$6,1			# 0x1
	sw	$2,220($3)
	sw	$2,228($3)
	lw	$7,8500($16)
	beq	$7,$6,$L3809
	nop

	slt	$5,$2,$4
	movz	$2,$4,$5
	move	$5,$2
$L3808:
	sw	$4,228($3)
	sw	$4,224($3)
$L3809:
	sw	$5,228($3)
	lw	$2,11864($16)
	bne	$2,$0,$L4072
	nop

$L3810:
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	lw	$3,11828($16)
	lw	$5,11824($16)
	lw	$2,-6284($4)
	sw	$3,5940($4)
	li	$3,2			# 0x2
	beq	$2,$3,$L4046
	sw	$5,5936($4)

	li	$3,6			# 0x6
	beq	$2,$3,$L4046
	nop

	li	$3,3			# 0x3
	bne	$2,$3,$L3819
	nop

	lw	$3,8456($16)
	lw	$2,8448($16)
	sra	$5,$3,3
	addu	$5,$2,$5
	lbu	$6,0($5)
	andi	$5,$3,0x7
	sll	$5,$6,$5
	andi	$5,$5,0x00ff
	lw	$6,9976($16)
	addiu	$3,$3,1
	srl	$5,$5,7
	sw	$5,5356($4)
	bne	$6,$0,$L4073
	sw	$3,8456($16)

$L3817:
	sra	$4,$3,3
$L4150:
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,1
	srl	$4,$4,7
	beq	$4,$0,$L3820
	sw	$3,8456($16)

	sra	$4,$3,3
	addu	$2,$2,$4
	lbu	$5,0($2)
	lbu	$6,3($2)
	lbu	$4,1($2)
	sll	$5,$5,24
	lbu	$2,2($2)
	or	$5,$6,$5
	sll	$4,$4,16
	sll	$2,$2,8
	or	$4,$5,$4
	or	$4,$4,$2
	andi	$2,$3,0x7
	sll	$2,$4,$2
	li	$4,134217728			# 0x8000000
	sltu	$4,$2,$4
	beq	$4,$0,$L4074
	li	$4,-65536			# 0xffffffffffff0000

	and	$4,$2,$4
	bne	$4,$0,$L3823
	srl	$4,$2,16

	move	$4,$2
	li	$5,8			# 0x8
	move	$7,$0
$L3824:
	andi	$6,$4,0xff00
	bne	$6,$0,$L3825
	nop

	move	$5,$7
$L3826:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$3,$3,32
	addu	$4,$6,$4
	lbu	$4,0($4)
	addu	$4,$4,$5
	sll	$4,$4,1
	addiu	$4,$4,-31
	subu	$3,$3,$4
	srl	$2,$2,$4
	sw	$3,8456($16)
	addiu	$3,$2,-1
$L3822:
	li	$22,65536			# 0x10000
	addu	$22,$16,$22
	lw	$4,-6284($22)
	addiu	$3,$3,1
	li	$2,3			# 0x3
	beq	$4,$2,$L4075
	sw	$3,5936($22)

$L3827:
	addiu	$3,$3,-1
	sltu	$3,$3,32
	beq	$3,$0,$L3828
	li	$2,65536			# 0x10000

	addu	$2,$16,$2
	lw	$2,5940($2)
	addiu	$2,$2,-1
	sltu	$2,$2,32
	bne	$2,$0,$L4149
	li	$2,65536			# 0x10000

$L3828:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC49)
	addiu	$6,$6,%lo($LC49)
	jalr	$25
	move	$5,$0

	li	$2,65536			# 0x10000
	lw	$31,156($sp)
	addu	$16,$16,$2
	li	$2,1			# 0x1
	sw	$2,5936($16)
	sw	$2,5940($16)
	lw	$fp,152($sp)
	li	$2,-1			# 0xffffffffffffffff
	lw	$23,148($sp)
	lw	$22,144($sp)
	lw	$21,140($sp)
	lw	$20,136($sp)
	lw	$19,132($sp)
	lw	$18,128($sp)
	lw	$17,124($sp)
	lw	$16,120($sp)
	j	$31
	addiu	$sp,$sp,160

$L4032:
	lw	$2,9940($16)
	bne	$2,$0,$L4044
	nop

	addiu	$fp,$16,8448
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	move	$4,$fp

	li	$23,65536			# 0x10000
	lw	$3,11812($16)
	addu	$23,$16,$23
	lw	$28,80($sp)
	beq	$3,$22,$L4034
	sw	$2,-6236($23)

	lw	$3,8500($16)
	b	$L3781
	lw	$22,9932($16)

$L4073:
	beq	$5,$0,$L4150
	sra	$4,$3,3

	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC48)
	addiu	$6,$6,%lo($LC48)
	jalr	$25
	move	$5,$0

	lw	$28,80($sp)
$L4046:
	lw	$3,8456($16)
	b	$L3817
	lw	$2,8448($16)

$L4052:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$4,8456($16)
	addu	$3,$5,$3
	b	$L3704
	lbu	$19,0($3)

$L4053:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$4,8456($16)
	addu	$3,$5,$3
	b	$L3711
	lbu	$3,0($3)

$L3820:
	li	$2,65536			# 0x10000
$L4149:
	addu	$2,$16,$2
	lw	$4,-6284($2)
	li	$3,3			# 0x3
	beq	$4,$3,$L4076
	li	$3,1			# 0x1

	sw	$3,5944($2)
$L3830:
	beq	$21,$0,$L4077
	nop

$L3831:
	.option	pic0
	jal	decode_ref_pic_list_reordering
	.option	pic2
	move	$4,$16

	bltz	$2,$L3740
	lw	$28,80($sp)

	lw	$2,11832($16)
	beq	$2,$0,$L3832
	li	$2,65536			# 0x10000

	addu	$2,$16,$2
	lw	$2,-6284($2)
	li	$3,2			# 0x2
	beq	$2,$3,$L3833
	li	$3,6			# 0x6

	beq	$2,$3,$L3833
	nop

$L3832:
	lw	$2,11836($16)
	li	$3,1			# 0x1
	beq	$2,$3,$L4078
	li	$4,2			# 0x2

	beq	$2,$4,$L4079
	li	$2,65536			# 0x10000

$L3835:
	li	$2,65536			# 0x10000
$L4153:
	addu	$2,$16,$2
	sw	$0,-6196($2)
$L3912:
	lw	$2,8704($16)
$L4140:
	bne	$2,$0,$L4080
	nop

$L3925:
	li	$13,65536			# 0x10000
	addu	$2,$16,$13
	lw	$2,-6276($2)
	bne	$2,$0,$L4081
	ori	$2,$13,0x1730

$L3954:
	li	$2,65536			# 0x10000
$L4141:
	addu	$2,$16,$2
	lw	$2,-6284($2)
	li	$3,1			# 0x1
	beq	$2,$3,$L3966
	li	$3,5			# 0x5

	beq	$2,$3,$L3966
	nop

	lw	$2,11808($16)
	bne	$2,$0,$L4082
	nop

$L3966:
	lw	$3,8456($16)
	lw	$4,8448($16)
	li	$5,131072			# 0x20000
	addu	$5,$16,$5
	sra	$2,$3,3
	sw	$0,8680($5)
	addu	$2,$4,$2
	lbu	$5,0($2)
	lbu	$6,3($2)
	lbu	$4,1($2)
	sll	$5,$5,24
	lbu	$2,2($2)
	or	$5,$6,$5
	sll	$4,$4,16
	or	$4,$5,$4
	sll	$2,$2,8
	or	$4,$4,$2
	andi	$2,$3,0x7
	sll	$2,$4,$2
	li	$4,134217728			# 0x8000000
	sltu	$4,$2,$4
	beq	$4,$0,$L4083
	lw	$5,11840($16)

	li	$4,-65536			# 0xffffffffffff0000
	and	$4,$2,$4
	bne	$4,$0,$L3970
	srl	$4,$2,16

	move	$4,$2
	li	$7,8			# 0x8
	move	$6,$0
$L3971:
	andi	$8,$4,0xff00
	beq	$8,$0,$L3972
	nop

	srl	$4,$4,8
	move	$6,$7
$L3972:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$3,$3,32
	addu	$4,$7,$4
	lbu	$4,0($4)
	addu	$4,$4,$6
	sll	$4,$4,1
	addiu	$4,$4,-31
	srl	$2,$2,$4
	andi	$6,$2,0x1
	subu	$4,$3,$4
	beq	$6,$0,$L3973
	sw	$4,8456($16)

	srl	$2,$2,1
	subu	$2,$0,$2
$L3974:
	move	$7,$2
$L3969:
	addu	$7,$7,$5
	sltu	$2,$7,52
	beq	$2,$0,$L4084
	lui	$6,%hi($LC53)

	andi	$3,$7,0xff
	addu	$3,$16,$3
	li	$2,65536			# 0x10000
	lbu	$4,12352($3)
	addu	$2,$16,$2
	lbu	$3,12096($3)
	lw	$2,-6284($2)
	sw	$3,8740($16)
	li	$3,6			# 0x6
	sw	$4,8744($16)
	beq	$2,$3,$L4085
	sw	$7,2056($16)

$L3976:
	addiu	$2,$2,-5
	sltu	$2,$2,2
	bne	$2,$0,$L4086
	nop

$L3977:
	li	$21,65536			# 0x10000
	lw	$2,11856($16)
	addu	$21,$16,$21
	li	$3,1			# 0x1
	sw	$3,5340($21)
	sw	$0,5344($21)
	bne	$2,$0,$L4087
	sw	$0,5348($21)

$L3978:
	lw	$22,0($16)
	lw	$2,708($22)
	slt	$3,$2,48
	beq	$3,$0,$L3981
	slt	$3,$2,32

	bne	$3,$0,$L3982
	slt	$3,$2,16

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,-6284($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L3983
	nop

$L3981:
	li	$2,65536			# 0x10000
$L4142:
	addu	$2,$16,$2
$L4158:
	sw	$0,5340($2)
$L3986:
	li	$2,131072			# 0x20000
	lw	$5,56($16)
	li	$3,65536			# 0x10000
	addu	$17,$17,$2
	addu	$3,$16,$3
	lw	$4,-6276($3)
	lw	$7,9408($17)
	andi	$5,$5,0x4000
	li	$2,16			# 0x10
	movn	$2,$0,$5
	addiu	$7,$7,1
	sw	$2,9764($16)
	movn	$2,$0,$4
	sw	$2,9768($16)
	sw	$18,9420($17)
	sw	$7,9408($17)
	sw	$7,-6296($3)
	lw	$3,412($22)
	andi	$3,$3,0x1
	beq	$3,$0,$L3992
	move	$2,$22

	lw	$2,8500($16)
	li	$3,3			# 0x3
	beq	$2,$3,$L4088
	li	$3,1			# 0x1

	beq	$2,$3,$L3995
	lui	$18,%hi($LC58)

	lui	$18,%hi($LC57)
	addiu	$18,$18,%lo($LC57)
$L3994:
	li	$17,65536			# 0x10000
	addu	$17,$16,$17
	lw	$25,%call16(av_get_pict_type_char)($28)
	lw	$4,-6284($17)
	jalr	$25
	sw	$7,112($sp)

	lw	$4,1880($16)
	lw	$3,-6196($17)
	lw	$12,224($4)
	lw	$13,220($4)
	li	$4,1			# 0x1
	lw	$28,80($sp)
	lw	$14,-6228($17)
	lw	$11,5936($17)
	lw	$10,5940($17)
	lw	$9,2056($16)
	lw	$8,5340($17)
	lw	$6,5344($17)
	lw	$5,5348($17)
	beq	$3,$4,$L4089
	lw	$7,112($sp)

$L3996:
	lui	$4,%hi($LC60)
	addiu	$4,$4,%lo($LC60)
$L3997:
	srl	$24,$6,31
	srl	$15,$5,31
	addu	$6,$24,$6
	addu	$5,$15,$5
	sra	$6,$6,1
	sra	$5,$5,1
	lw	$25,%call16(av_log)($28)
	sw	$6,60($sp)
	lui	$6,%hi($LC61)
	sw	$2,24($sp)
	sw	$5,64($sp)
	sw	$4,72($sp)
	sw	$18,16($sp)
	sw	$19,20($sp)
	sw	$20,28($sp)
	sw	$14,32($sp)
	sw	$13,36($sp)
	sw	$12,40($sp)
	sw	$11,44($sp)
	sw	$10,48($sp)
	sw	$9,52($sp)
	sw	$8,56($sp)
	sw	$3,68($sp)
	move	$4,$22
	addiu	$6,$6,%lo($LC61)
	jalr	$25
	li	$5,2			# 0x2

	lw	$2,0($16)
$L3992:
	lw	$2,604($2)
	andi	$2,$2,0x1
	beq	$2,$0,$L4151
	lw	$31,156($sp)

	lw	$2,8704($16)
	beq	$2,$0,$L4090
	addiu	$2,$16,4040

$L4151:
	addiu	$2,$16,3528
	addiu	$3,$16,3784
	sw	$2,6140($16)
	sw	$3,6144($16)
	move	$2,$0
	lw	$fp,152($sp)
	lw	$23,148($sp)
	lw	$22,144($sp)
	lw	$21,140($sp)
	lw	$20,136($sp)
	lw	$19,132($sp)
	lw	$18,128($sp)
	lw	$17,124($sp)
	lw	$16,120($sp)
	j	$31
	addiu	$sp,$sp,160

$L4056:
	lw	$4,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$4,$4,$2
	lbu	$4,0($4)
	addu	$3,$4,$3
	lw	$4,%got(ff_ue_golomb_vlc_code)($28)
	sw	$3,8456($16)
	addu	$2,$4,$2
	b	$L3724
	lbu	$20,0($2)

$L3785:
	beq	$22,$2,$L4091
	li	$2,5			# 0x5

	beq	$5,$2,$L4092
	move	$5,$0

	lw	$2,8704($16)
	beq	$2,$0,$L3807
	nop

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,-6228($2)
	addu	$2,$6,$2
	sll	$2,$2,1
	move	$5,$2
	b	$L3792
	move	$4,$2

$L3722:
	lw	$21,9420($3)
	xor	$21,$18,$21
	b	$L3721
	sltu	$21,$21,1

$L3712:
	andi	$7,$5,0xff00
	li	$6,24			# 0x18
	beq	$7,$0,$L4093
	li	$8,16			# 0x10

$L3714:
	b	$L3715
	srl	$5,$5,8

$L3727:
	b	$L3728
	srl	$4,$4,8

$L3725:
	li	$5,24			# 0x18
	b	$L3726
	li	$7,16			# 0x10

$L3784:
	lw	$6,-6212($4)
	b	$L3783
	sw	$6,-6216($4)

$L4074:
	lw	$4,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$4,$4,$2
	lbu	$4,0($4)
	addu	$3,$4,$3
	lw	$4,%got(ff_ue_golomb_vlc_code)($28)
	sw	$3,8456($16)
	addu	$2,$4,$2
	b	$L3822
	lbu	$3,0($2)

$L4069:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	sw	$0,-6216($2)
	b	$L3783
	move	$6,$0

$L4072:
	lw	$4,8456($16)
	lw	$2,8448($16)
	sra	$3,$4,3
	addu	$2,$2,$3
	lbu	$5,0($2)
	lbu	$6,3($2)
	lbu	$3,1($2)
	sll	$5,$5,24
	lbu	$2,2($2)
	or	$5,$6,$5
	sll	$3,$3,16
	sll	$2,$2,8
	or	$3,$5,$3
	or	$3,$3,$2
	andi	$2,$4,0x7
	sll	$2,$3,$2
	li	$3,134217728			# 0x8000000
	sltu	$3,$2,$3
	beq	$3,$0,$L4094
	li	$3,-65536			# 0xffffffffffff0000

	and	$3,$2,$3
	bne	$3,$0,$L3813
	srl	$3,$2,16

	move	$3,$2
	li	$6,8			# 0x8
	move	$5,$0
$L3814:
	andi	$7,$3,0xff00
	beq	$7,$0,$L3815
	nop

	srl	$3,$3,8
	move	$5,$6
$L3815:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$3,$6,$3
	lbu	$3,0($3)
	addu	$3,$3,$5
	sll	$3,$3,1
	addiu	$3,$3,-31
	subu	$4,$4,$3
	srl	$2,$2,$3
	sw	$4,8456($16)
	addiu	$2,$2,-1
$L3812:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	b	$L3810
	sw	$2,5352($3)

$L4066:
	addu	$2,$16,$2
	lw	$4,-6228($2)
	lw	$5,9928($16)
	li	$6,1			# 0x1
	sw	$4,-6204($2)
	sll	$5,$6,$5
	lw	$4,8708($16)
	sw	$5,-6200($2)
	li	$2,5			# 0x5
	bne	$4,$2,$L3773
	nop

$L4067:
	lw	$4,8456($16)
	lw	$2,8448($16)
	sra	$5,$4,3
	addu	$2,$2,$5
	lbu	$6,0($2)
	lbu	$7,3($2)
	lbu	$5,1($2)
	sll	$6,$6,24
	lbu	$2,2($2)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$2,$2,8
	or	$5,$6,$5
	or	$5,$5,$2
	andi	$2,$4,0x7
	sll	$2,$5,$2
	li	$5,134217728			# 0x8000000
	sltu	$5,$2,$5
	beq	$5,$0,$L4095
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$2,$5
	bne	$5,$0,$L3775
	li	$6,24			# 0x18

	li	$6,8			# 0x8
$L3776:
	andi	$7,$2,0xff00
	beq	$7,$0,$L3777
	nop

	srl	$2,$2,8
	move	$5,$6
$L3777:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$4,$4,63
	addu	$2,$6,$2
	lbu	$2,0($2)
	addu	$5,$2,$5
	sll	$5,$5,1
	subu	$4,$4,$5
	b	$L3773
	sw	$4,8456($16)

$L4065:
	addiu	$4,$4,1
	sw	$4,7964($16)
	b	$L3770
	sw	$4,6172($16)

$L4071:
	b	$L3808
	lw	$3,1880($16)

$L4068:
	lw	$4,8456($16)
	lw	$2,8448($16)
	sra	$5,$4,3
	addu	$2,$2,$5
	lbu	$8,0($2)
	lbu	$6,1($2)
	lbu	$7,3($2)
	lbu	$5,2($2)
	sll	$2,$8,24
	or	$7,$7,$2
	sll	$2,$6,16
	or	$7,$7,$2
	sll	$5,$5,8
	lw	$2,9936($16)
	or	$7,$7,$5
	andi	$5,$4,0x7
	sll	$7,$7,$5
	subu	$6,$0,$2
	li	$23,65536			# 0x10000
	addu	$2,$4,$2
	lw	$5,11812($16)
	srl	$6,$7,$6
	addu	$23,$16,$23
	sw	$2,8456($16)
	li	$2,1			# 0x1
	bne	$5,$2,$L4152
	sw	$6,-6248($23)

	li	$2,3			# 0x3
	bne	$3,$2,$L4152
	li	$2,1			# 0x1

	.option	pic0
	jal	get_se_golomb
	.option	pic2
	addiu	$4,$16,8448

	lw	$28,80($sp)
	lw	$22,9932($16)
	b	$L3778
	sw	$2,-6240($23)

$L3825:
	b	$L3826
	srl	$4,$4,8

$L3823:
	li	$5,24			# 0x18
	b	$L3824
	li	$7,16			# 0x10

$L3788:
	beq	$8,$0,$L3789
	srl	$8,$4,31

	addu	$8,$8,$4
	sra	$8,$8,1
	subu	$5,$6,$5
	subu	$8,$0,$8
	slt	$8,$5,$8
	beq	$8,$0,$L3789
	nop

	subu	$2,$2,$4
	b	$L3790
	sw	$2,-6244($7)

$L3970:
	li	$7,24			# 0x18
	b	$L3971
	li	$6,16			# 0x10

$L3791:
	lw	$4,-6240($4)
	addu	$4,$2,$4
$L3793:
	slt	$5,$2,$4
	move	$9,$2
	movz	$9,$4,$5
	b	$L3999
	move	$5,$9

$L4070:
	addu	$2,$2,$4
	b	$L3790
	sw	$2,-6244($7)

$L3807:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$2,-6228($2)
	addu	$2,$6,$2
	sll	$2,$2,1
	b	$L4045
	addiu	$2,$2,-1

$L4094:
	lw	$3,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$3,$3,$2
	lbu	$3,0($3)
	addu	$4,$3,$4
	lw	$3,%got(ff_ue_golomb_vlc_code)($28)
	sw	$4,8456($16)
	addu	$2,$3,$2
	b	$L3812
	lbu	$2,0($2)

$L4079:
	addu	$2,$16,$2
	lw	$5,-6284($2)
	li	$4,3			# 0x3
	bne	$5,$4,$L3835
	nop

	lw	$5,1880($16)
	lw	$4,5936($2)
	beq	$4,$3,$L4096
	lw	$14,228($5)

	li	$12,65536			# 0x10000
$L4156:
	addu	$13,$16,$12
$L4157:
	lw	$2,5936($13)
	li	$4,2			# 0x2
	li	$3,5			# 0x5
	sw	$4,-6192($13)
	sw	$3,-6184($13)
	sw	$4,-6196($13)
	beq	$2,$0,$L3912
	sw	$3,-6188($13)

	ori	$21,$12,0xcba4
	lw	$5,5940($13)
	ori	$12,$12,0x7f24
	addu	$12,$16,$12
	addu	$21,$16,$21
	move	$11,$0
	li	$25,61656			# 0xf0d8
	li	$24,127			# 0x7f
	li	$15,-128			# 0xffffffffffffff80
	li	$7,32			# 0x20
	li	$10,64			# 0x40
$L3924:
	beq	$5,$0,$L3914
	lw	$6,0($12)

	subu	$2,$14,$6
	sll	$3,$11,6
	slt	$8,$2,128
	sll	$4,$11,8
	subu	$4,$4,$3
	movz	$2,$24,$8
	slt	$8,$2,-128
	addu	$4,$4,$25
	movn	$2,$15,$8
	addu	$4,$16,$4
	move	$8,$2
	lw	$5,5940($13)
	addiu	$4,$4,4
	move	$3,$21
	b	$L3923
	move	$2,$0

$L4098:
	li	$9,-128			# 0xffffffffffffff80
$L3916:
	div	$0,$22,$9
	teq	$9,$0,7
	mflo	$22
	mul	$9,$22,$8
	addiu	$9,$9,32
	sra	$23,$9,6
	slt	$22,$23,-1024
	bne	$22,$0,$L3918
	slt	$23,$23,1024

	beq	$23,$0,$L3918
	sra	$9,$9,8

	addiu	$22,$9,64
	sltu	$22,$22,193
	beq	$22,$0,$L3918
	subu	$9,$10,$9

	addiu	$2,$2,1
	sw	$9,0($4)
	sltu	$9,$2,$5
	addiu	$3,$3,408
	beq	$9,$0,$L4097
	addiu	$4,$4,4

$L3923:
	lw	$9,0($3)
	subu	$9,$9,$6
	slt	$22,$9,-128
	bne	$22,$0,$L4098
	li	$22,16448			# 0x4040

	slt	$22,$9,128
	beq	$22,$0,$L3917
	nop

	bne	$9,$0,$L4099
	subu	$22,$0,$9

$L3918:
	addiu	$2,$2,1
	sltu	$9,$2,$5
	sw	$7,0($4)
	addiu	$3,$3,408
	bne	$9,$0,$L3923
	addiu	$4,$4,4

$L4097:
	lw	$2,5936($13)
$L3914:
	addiu	$11,$11,1
	sltu	$3,$11,$2
	bne	$3,$0,$L3924
	addiu	$12,$12,408

	b	$L4140
	lw	$2,8704($16)

$L4082:
	.option	pic0
	jal	get_ue_golomb
	.option	pic2
	addiu	$4,$16,8448

	sltu	$3,$2,3
	beq	$3,$0,$L4100
	lw	$28,80($sp)

	li	$3,131072			# 0x20000
	addu	$3,$16,$3
	b	$L3966
	sw	$2,8656($3)

$L4089:
	lw	$4,-6192($17)
	beq	$4,$0,$L3996
	lui	$4,%hi($LC59)

	b	$L3997
	addiu	$4,$4,%lo($LC59)

$L4078:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,-6284($2)
	li	$2,3			# 0x3
	bne	$3,$2,$L4153
	li	$2,65536			# 0x10000

$L3833:
	lw	$5,8456($16)
	lw	$2,8448($16)
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	sra	$3,$5,3
	sw	$0,-6192($4)
	sw	$0,-6196($4)
	addu	$3,$2,$3
	lbu	$6,0($3)
	lbu	$7,3($3)
	lbu	$4,1($3)
	sll	$6,$6,24
	lbu	$3,2($3)
	or	$6,$7,$6
	sll	$4,$4,16
	sll	$3,$3,8
	or	$4,$6,$4
	or	$4,$4,$3
	andi	$3,$5,0x7
	sll	$3,$4,$3
	li	$4,134217728			# 0x8000000
	sltu	$4,$3,$4
	beq	$4,$0,$L4101
	lw	$4,%got(ff_golomb_vlc_len)($28)

	li	$4,-65536			# 0xffffffffffff0000
	and	$4,$3,$4
	bne	$4,$0,$L3838
	srl	$4,$3,16

	move	$4,$3
	li	$7,8			# 0x8
	move	$6,$0
$L3839:
	andi	$8,$4,0xff00
	beq	$8,$0,$L3840
	nop

	srl	$4,$4,8
	move	$6,$7
$L3840:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$5,$5,32
	addu	$4,$7,$4
	lbu	$4,0($4)
	addu	$4,$4,$6
	sll	$4,$4,1
	addiu	$4,$4,-31
	subu	$5,$5,$4
	srl	$4,$3,$4
	sw	$5,8456($16)
	addiu	$4,$4,-1
$L3837:
	lw	$5,8456($16)
	li	$6,65536			# 0x10000
	addu	$6,$16,$6
	sra	$3,$5,3
	sw	$4,-6188($6)
	addu	$3,$2,$3
	lbu	$6,0($3)
	lbu	$7,3($3)
	lbu	$4,1($3)
	sll	$6,$6,24
	lbu	$3,2($3)
	or	$6,$7,$6
	sll	$4,$4,16
	sll	$3,$3,8
	or	$4,$6,$4
	or	$4,$4,$3
	andi	$3,$5,0x7
	sll	$3,$4,$3
	li	$4,134217728			# 0x8000000
	sltu	$4,$3,$4
	beq	$4,$0,$L4102
	li	$4,-65536			# 0xffffffffffff0000

	and	$4,$3,$4
	bne	$4,$0,$L3843
	srl	$4,$3,16

	move	$4,$3
	li	$7,8			# 0x8
	move	$6,$0
$L3844:
	andi	$8,$4,0xff00
	beq	$8,$0,$L3845
	nop

	srl	$4,$4,8
	move	$6,$7
$L3845:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$5,$5,32
	addu	$4,$7,$4
	lbu	$4,0($4)
	addu	$4,$4,$6
	sll	$4,$4,1
	addiu	$4,$4,-31
	subu	$5,$5,$4
	srl	$3,$3,$4
	sw	$5,8456($16)
	addiu	$3,$3,-1
$L3842:
	li	$4,65536			# 0x10000
	addu	$12,$16,$4
	ori	$5,$4,0x1730
	lw	$15,-6188($12)
	li	$4,1			# 0x1
	addu	$5,$16,$5
	lw	$10,%got(ff_log2_tab)($28)
	lw	$25,%got(ff_golomb_vlc_len)($28)
	lw	$24,%got(ff_se_golomb_vlc_code)($28)
	sll	$9,$4,$3
	sw	$3,-6184($12)
	sll	$15,$4,$15
	sw	$5,92($sp)
	move	$21,$0
	li	$7,134217728			# 0x8000000
	li	$13,1			# 0x1
	li	$11,-65536			# 0xffffffffffff0000
	lw	$4,92($sp)
$L4154:
	lw	$14,0($4)
	beq	$14,$0,$L3909
	sll	$3,$21,7

	sll	$4,$21,9
	subu	$4,$4,$3
	sll	$6,$21,8
	sll	$5,$21,6
	li	$3,60120			# 0xead8
	subu	$5,$6,$5
	addu	$3,$4,$3
	li	$4,59352			# 0xe7d8
	addu	$5,$5,$4
	addu	$3,$16,$3
	addu	$5,$16,$5
	addiu	$3,$3,4
	addiu	$5,$5,4
	b	$L3907
	move	$6,$0

$L4104:
	sw	$9,0($3)
	sw	$0,768($3)
	sw	$9,4($3)
	sw	$0,772($3)
$L3867:
	addiu	$6,$6,1
	sltu	$4,$6,$14
	addiu	$3,$3,8
	beq	$4,$0,$L3909
	addiu	$5,$5,4

$L3907:
	lw	$4,8456($16)
	sra	$8,$4,3
	addu	$8,$2,$8
	lbu	$22,0($8)
	andi	$8,$4,0x7
	sll	$8,$22,$8
	andi	$8,$8,0x00ff
	addiu	$4,$4,1
	srl	$8,$8,7
	bne	$8,$0,$L4103
	sw	$4,8456($16)

	sw	$15,0($5)
	sw	$0,384($5)
$L3865:
	sra	$8,$4,3
	addu	$8,$2,$8
	lbu	$22,0($8)
	andi	$8,$4,0x7
	sll	$8,$22,$8
	andi	$8,$8,0x00ff
	addiu	$4,$4,1
	srl	$8,$8,7
	beq	$8,$0,$L4104
	sw	$4,8456($16)

	sra	$8,$4,3
	addu	$8,$2,$8
	lbu	$fp,0($8)
	lbu	$22,3($8)
	lbu	$23,1($8)
	sll	$fp,$fp,24
	lbu	$8,2($8)
	or	$fp,$22,$fp
	sll	$23,$23,16
	sll	$22,$8,8
	or	$23,$fp,$23
	or	$8,$23,$22
	andi	$22,$4,0x7
	sll	$8,$8,$22
	sltu	$22,$8,$7
	beq	$22,$0,$L4105
	nop

	and	$22,$8,$11
	bne	$22,$0,$L3870
	li	$fp,16			# 0x10

	move	$22,$8
	li	$23,8			# 0x8
	sw	$0,88($sp)
$L3876:
	andi	$fp,$22,0xff00
	bne	$fp,$0,$L3871
	nop

	lw	$23,88($sp)
$L3875:
	addu	$22,$10,$22
	lbu	$22,0($22)
	addiu	$4,$4,32
	addu	$22,$22,$23
	sll	$22,$22,1
	addiu	$22,$22,-31
	srl	$8,$8,$22
	andi	$23,$8,0x1
	subu	$22,$4,$22
	bne	$23,$0,$L3872
	sw	$22,8456($16)

	lw	$22,8456($16)
	srl	$8,$8,1
$L3869:
	sra	$4,$22,3
	sw	$8,0($3)
	addu	$4,$2,$4
	lbu	$fp,0($4)
	lbu	$8,3($4)
	lbu	$23,1($4)
	sll	$fp,$fp,24
	lbu	$4,2($4)
	or	$fp,$8,$fp
	sll	$23,$23,16
	sll	$8,$4,8
	or	$23,$fp,$23
	or	$4,$23,$8
	andi	$8,$22,0x7
	sll	$4,$4,$8
	sltu	$8,$4,$7
	beq	$8,$0,$L4106
	and	$8,$4,$11

	bne	$8,$0,$L3879
	li	$fp,16			# 0x10

	move	$8,$4
	andi	$fp,$8,0xff00
	li	$23,8			# 0x8
	bne	$fp,$0,$L3880
	sw	$0,88($sp)

$L4128:
	addu	$8,$10,$8
	lw	$23,88($sp)
	lbu	$8,0($8)
	addiu	$22,$22,32
	addu	$8,$8,$23
	sll	$8,$8,1
	addiu	$8,$8,-31
	srl	$4,$4,$8
	andi	$23,$4,0x1
	subu	$8,$22,$8
	bne	$23,$0,$L3881
	sw	$8,8456($16)

$L4129:
	srl	$4,$4,1
$L3878:
	lw	$8,0($3)
	beq	$9,$8,$L4107
	sw	$4,768($3)

	sw	$13,-6192($12)
$L3887:
	lw	$8,8456($16)
	sra	$4,$8,3
	addu	$4,$2,$4
	lbu	$fp,0($4)
	lbu	$22,3($4)
	lbu	$23,1($4)
	sll	$fp,$fp,24
	lbu	$4,2($4)
	or	$fp,$22,$fp
	sll	$23,$23,16
	sll	$22,$4,8
	or	$23,$fp,$23
	or	$4,$23,$22
	andi	$22,$8,0x7
	sll	$4,$4,$22
	sltu	$22,$4,$7
	beq	$22,$0,$L4108
	and	$22,$4,$11

	bne	$22,$0,$L3890
	li	$fp,16			# 0x10

	move	$22,$4
	li	$23,8			# 0x8
	sw	$0,88($sp)
$L3896:
	andi	$fp,$22,0xff00
	bne	$fp,$0,$L3891
	nop

	lw	$23,88($sp)
$L3895:
	addu	$22,$10,$22
	lbu	$22,0($22)
	addiu	$8,$8,32
	addu	$22,$22,$23
	sll	$22,$22,1
	addiu	$22,$22,-31
	srl	$4,$4,$22
	andi	$23,$4,0x1
	subu	$22,$8,$22
	bne	$23,$0,$L3892
	sw	$22,8456($16)

	lw	$8,8456($16)
	srl	$4,$4,1
$L3889:
	sw	$4,4($3)
	sra	$4,$8,3
	addu	$4,$2,$4
	lbu	$fp,0($4)
	lbu	$22,3($4)
	lbu	$23,1($4)
	sll	$fp,$fp,24
	lbu	$4,2($4)
	or	$fp,$22,$fp
	sll	$23,$23,16
	sll	$22,$4,8
	or	$23,$fp,$23
	or	$4,$23,$22
	andi	$22,$8,0x7
	sll	$4,$4,$22
	sltu	$22,$4,$7
	beq	$22,$0,$L4109
	nop

	and	$22,$4,$11
	bne	$22,$0,$L3899
	li	$fp,16			# 0x10

	move	$22,$4
	li	$23,8			# 0x8
	sw	$0,88($sp)
$L3905:
	andi	$fp,$22,0xff00
	bne	$fp,$0,$L3900
	nop

	addu	$22,$10,$22
	lw	$23,88($sp)
	lbu	$22,0($22)
	addiu	$8,$8,32
	addu	$22,$22,$23
	sll	$22,$22,1
	addiu	$22,$22,-31
	srl	$4,$4,$22
	andi	$23,$4,0x1
	subu	$22,$8,$22
	bne	$23,$0,$L3901
	sw	$22,8456($16)

$L4130:
	srl	$4,$4,1
$L3898:
	lw	$8,4($3)
	beq	$9,$8,$L4110
	sw	$4,772($3)

	sw	$13,-6192($12)
$L4124:
	addiu	$6,$6,1
	sltu	$4,$6,$14
	addiu	$3,$3,8
	bne	$4,$0,$L3907
	addiu	$5,$5,4

$L3909:
	lw	$4,-6284($12)
	li	$3,3			# 0x3
	bne	$4,$3,$L3908
	lw	$3,92($sp)

	addiu	$21,$21,1
	addiu	$3,$3,4
	sw	$3,92($sp)
	li	$3,2			# 0x2
	bne	$21,$3,$L4154
	lw	$4,92($sp)

$L3908:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,-6196($2)
	bne	$3,$0,$L4111
	nop

	lw	$2,-6192($2)
	sltu	$2,$0,$2
$L3911:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	b	$L3912
	sw	$2,-6196($3)

$L4060:
	addu	$2,$16,$2
	lw	$3,-6300($2)
	beq	$3,$20,$L3734
	nop

	sw	$20,-6300($2)
	.option	pic0
	jal	init_dequant_tables
	.option	pic2
	move	$4,$16

	b	$L3734
	lw	$28,80($sp)

$L4083:
	lw	$4,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$4,$4,$2
	lbu	$4,0($4)
	addu	$3,$4,$3
	lw	$4,%got(ff_se_golomb_vlc_code)($28)
	sw	$3,8456($16)
	addu	$2,$4,$2
	b	$L3969
	lb	$7,0($2)

$L4063:
	sra	$4,$3,3
	addu	$2,$2,$4
	lbu	$2,0($2)
	andi	$3,$3,0x7
	sll	$2,$2,$3
	andi	$2,$2,0x00ff
	srl	$2,$2,7
	addiu	$3,$5,2
	lw	$25,%call16(av_log)($28)
	addiu	$2,$2,1
	lw	$4,0($16)
	lui	$6,%hi($LC46)
	sw	$3,8456($16)
	sw	$2,8500($16)
	addiu	$6,$6,%lo($LC46)
	jalr	$25
	move	$5,$0

	b	$L3758
	lw	$28,80($sp)

$L4077:
	.option	pic0
	jal	fill_default_ref_list
	.option	pic2
	move	$4,$16

	b	$L3831
	nop

$L3786:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	sw	$0,-6224($2)
	sw	$0,-6220($2)
	move	$6,$0
	b	$L3787
	move	$2,$0

$L4091:
	lw	$5,9952($16)
	beq	$5,$0,$L3796
	move	$9,$0

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$9,-6228($2)
	addu	$9,$6,$9
$L3796:
	lw	$4,8704($16)
	bne	$4,$0,$L3797
	slt	$2,$0,$9

	subu	$9,$9,$2
$L3797:
	blez	$5,$L4113
	nop

	sll	$8,$5,1
	move	$6,$0
	move	$2,$0
$L3800:
	addu	$7,$16,$6
	lh	$7,10032($7)
	addiu	$6,$6,2
	bne	$6,$8,$L3800
	addu	$2,$2,$7

$L3799:
	blez	$9,$L4114
	nop

	addiu	$9,$9,-1
	div	$0,$9,$5
	teq	$5,$0,7
	mfhi	$5
	mflo	$9
	bltz	$5,$L3802
	mul	$2,$2,$9

	addiu	$5,$5,1
	sll	$5,$5,1
	move	$6,$0
$L3803:
	addu	$7,$16,$6
	lh	$7,10032($7)
	addiu	$6,$6,2
	bne	$6,$5,$L3803
	addu	$2,$2,$7

$L3802:
	bne	$4,$0,$L4155
	li	$5,65536			# 0x10000

	lw	$4,9944($16)
	addu	$2,$2,$4
$L4155:
	addu	$5,$16,$5
	lw	$6,-6236($5)
	lw	$4,9948($16)
	addu	$2,$2,$6
	li	$6,3			# 0x3
	beq	$3,$6,$L3805
	addu	$4,$2,$4

	slt	$5,$2,$4
	move	$6,$2
	movz	$6,$4,$5
	b	$L3792
	move	$5,$6

$L4076:
	li	$3,2			# 0x2
	b	$L3830
	sw	$3,5944($2)

$L3973:
	b	$L3974
	srl	$2,$2,1

$L4085:
	lw	$3,8456($16)
	addiu	$3,$3,1
	b	$L3976
	sw	$3,8456($16)

$L4081:
	addu	$2,$16,$2
	ori	$13,$13,0x7e40
	addu	$13,$16,$13
	sw	$16,92($sp)
	move	$12,$0
	sw	$0,88($sp)
	sw	$18,104($sp)
	move	$16,$2
$L3955:
	lw	$2,0($16)
	beq	$2,$0,$L3960
	lw	$2,88($sp)

	lw	$6,88($sp)
	sll	$5,$2,8
	sll	$4,$6,9
	sll	$3,$2,6
	sll	$2,$2,7
	subu	$3,$5,$3
	lw	$6,92($sp)
	subu	$2,$4,$2
	li	$9,59736			# 0xe958
	li	$4,59352			# 0xe7d8
	li	$11,60888			# 0xedd8
	li	$5,60120			# 0xead8
	addu	$fp,$3,$4
	addu	$23,$3,$9
	addu	$14,$2,$11
	addu	$24,$2,$5
	addu	$fp,$6,$fp
	addu	$23,$6,$23
	addu	$24,$6,$24
	addu	$14,$6,$14
	addiu	$fp,$fp,4
	addiu	$23,$23,4
	addiu	$24,$24,4
	addiu	$14,$14,4
	addu	$4,$13,$12
	move	$22,$fp
	move	$21,$23
	move	$18,$14
	move	$15,$24
	move	$3,$0
	move	$25,$0
$L3958:
	sll	$2,$3,5
	sll	$3,$3,3
	subu	$2,$2,$3
	sll	$5,$2,4
	addu	$5,$2,$5
	addu	$5,$5,$12
	addu	$5,$13,$5
	addiu	$6,$4,6528
	move	$2,$5
	move	$3,$6
	addiu	$7,$5,400
$L3956:
	lw	$11,0($2)
	lw	$10,4($2)
	lw	$9,8($2)
	lw	$8,12($2)
	addiu	$2,$2,16
	sw	$11,0($3)
	sw	$10,4($3)
	sw	$9,8($3)
	sw	$8,12($3)
	bne	$2,$7,$L3956
	addiu	$3,$3,16

	lw	$7,4($2)
	lw	$2,0($2)
	sw	$7,4($3)
	sw	$2,0($3)
	lw	$7,6544($4)
	lw	$3,6548($4)
	lw	$2,6552($4)
	sll	$3,$3,1
	sll	$2,$2,1
	sll	$7,$7,1
	sw	$3,6548($4)
	sw	$2,6552($4)
	sw	$7,6544($4)
	addiu	$2,$4,6936
	addiu	$3,$4,6928
$L3957:
	lw	$10,0($6)
	lw	$9,4($6)
	lw	$8,8($6)
	lw	$7,12($6)
	addiu	$6,$6,16
	sw	$10,0($2)
	sw	$9,4($2)
	sw	$8,8($2)
	sw	$7,12($2)
	bne	$6,$3,$L3957
	addiu	$2,$2,16

	lw	$7,4($6)
	lw	$3,0($6)
	sw	$7,4($2)
	sw	$3,0($2)
	lw	$10,16($5)
	lw	$8,20($5)
	lw	$3,0($24)
	lw	$2,0($18)
	lw	$11,6936($4)
	lw	$9,6940($4)
	lw	$7,24($5)
	addu	$10,$11,$10
	sw	$3,128($15)
	sw	$2,128($14)
	sw	$3,136($15)
	sw	$2,136($14)
	addu	$8,$9,$8
	lw	$11,0($16)
	lw	$9,6944($4)
	lw	$3,4($24)
	lw	$6,0($fp)
	lw	$5,0($23)
	lw	$2,4($18)
	addiu	$25,$25,1
	addu	$7,$9,$7
	sltu	$9,$25,$11
	sw	$3,132($15)
	sw	$3,140($15)
	sw	$10,6936($4)
	sw	$8,6940($4)
	sw	$7,6944($4)
	sw	$6,64($22)
	sw	$5,64($21)
	sw	$2,132($14)
	sw	$6,68($22)
	sw	$5,68($21)
	sw	$2,140($14)
	addiu	$4,$4,816
	addiu	$fp,$fp,4
	addiu	$22,$22,8
	addiu	$23,$23,4
	addiu	$21,$21,8
	addiu	$24,$24,8
	addiu	$15,$15,16
	addiu	$18,$18,8
	addiu	$14,$14,16
	bne	$9,$0,$L3958
	move	$3,$25

$L3960:
	lw	$23,88($sp)
	li	$fp,2			# 0x2
	addiu	$23,$23,1
	sw	$23,88($sp)
	addiu	$16,$16,4
	bne	$23,$fp,$L3955
	addiu	$12,$12,19584

	lw	$16,92($sp)
	li	$11,65536			# 0x10000
	addu	$11,$16,$11
	lw	$2,5940($11)
	beq	$2,$0,$L3954
	lw	$18,104($sp)

	li	$12,61660			# 0xf0dc
	addu	$12,$16,$12
	addiu	$10,$12,3072
	move	$15,$0
	move	$9,$0
	li	$14,61656			# 0xf0d8
	li	$13,61724			# 0xf11c
$L3961:
	lw	$7,5936($11)
	beq	$7,$0,$L3965
	sll	$4,$9,8

	sll	$2,$9,6
	subu	$4,$4,$2
	addu	$2,$4,$13
	addu	$4,$4,$14
	addu	$4,$16,$4
	addu	$2,$16,$2
	addiu	$4,$4,4
	addiu	$2,$2,4
	move	$3,$0
$L3962:
	lw	$5,0($4)
	addiu	$3,$3,1
	sltu	$6,$3,$7
	sw	$5,-4($2)
	sw	$5,0($2)
	addiu	$4,$4,4
	bne	$6,$0,$L3962
	addiu	$2,$2,8

$L3965:
	sll	$8,$15,8
	sll	$15,$15,6
	subu	$8,$8,$15
	addu	$8,$12,$8
	move	$3,$8
	move	$2,$10
	addiu	$15,$8,192
$L3963:
	lwl	$7,3($3)
	lwl	$6,7($3)
	lwl	$5,11($3)
	lwl	$4,15($3)
	lwr	$7,0($3)
	lwr	$6,4($3)
	lwr	$5,8($3)
	lwr	$4,12($3)
	swl	$7,3($2)
	swr	$7,0($2)
	swl	$6,7($2)
	swr	$6,4($2)
	swl	$5,11($2)
	swr	$5,8($2)
	addiu	$3,$3,16
	swl	$4,15($2)
	swr	$4,12($2)
	bne	$3,$15,$L3963
	addiu	$2,$2,16

	move	$3,$8
	addiu	$2,$10,192
$L3964:
	lwl	$7,3($3)
	lwl	$6,7($3)
	lwl	$5,11($3)
	lwl	$4,15($3)
	lwr	$7,0($3)
	lwr	$6,4($3)
	lwr	$5,8($3)
	lwr	$4,12($3)
	swl	$7,3($2)
	swr	$7,0($2)
	swl	$6,7($2)
	swr	$6,4($2)
	swl	$5,11($2)
	swr	$5,8($2)
	addiu	$3,$3,16
	swl	$4,15($2)
	swr	$4,12($2)
	bne	$3,$15,$L3964
	addiu	$2,$2,16

	lw	$2,5940($11)
	addiu	$9,$9,1
	sltu	$2,$9,$2
	addiu	$10,$10,384
	bne	$2,$0,$L3961
	move	$15,$9

	b	$L4141
	li	$2,65536			# 0x10000

$L4080:
	lw	$4,8708($17)
	li	$3,5			# 0x5
	beq	$4,$3,$L4115
	addiu	$2,$16,8448

	lw	$3,8456($16)
	lw	$9,8448($16)
	sra	$4,$3,3
	addu	$4,$9,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,1
	srl	$4,$4,7
	beq	$4,$0,$L3928
	sw	$3,8456($16)

	li	$3,131072			# 0x20000
	ori	$3,$3,0x1790
	li	$22,65536			# 0x10000
	lw	$14,%got(ff_log2_tab)($28)
	lw	$21,%got(ff_golomb_vlc_len)($28)
	lw	$25,%got(ff_ue_golomb_vlc_code)($28)
	addu	$3,$17,$3
	addu	$22,$17,$22
	move	$4,$0
	li	$6,134217728			# 0x8000000
	li	$13,-65536			# 0xffffffffffff0000
	li	$12,1			# 0x1
	li	$24,3			# 0x3
	li	$15,6			# 0x6
	b	$L3952
	li	$11,66			# 0x42

$L3929:
	bne	$8,$0,$L3931
	srl	$8,$5,16

	move	$8,$5
	li	$10,8			# 0x8
	move	$fp,$0
$L3932:
	andi	$23,$8,0xff00
	bne	$23,$0,$L3933
	nop

	move	$10,$fp
$L3934:
	addu	$8,$14,$8
	lbu	$8,0($8)
	addiu	$7,$7,32
	addu	$8,$8,$10
	sll	$8,$8,1
	addiu	$8,$8,-31
	subu	$7,$7,$8
	srl	$5,$5,$8
	sw	$7,8($2)
	addiu	$7,$5,-1
$L3930:
	beq	$7,$12,$L3935
	sw	$7,-4($3)

	beq	$7,$24,$L3935
	nop

$L3936:
	addiu	$5,$7,-2
	sltu	$5,$5,2
	bne	$5,$0,$L3942
	nop

	beq	$7,$15,$L3942
	li	$fp,4			# 0x4

	beq	$7,$fp,$L3942
	nop

$L3943:
	sltu	$5,$7,7
	beq	$5,$0,$L4116
	nop

	beq	$7,$0,$L3951
	nop

	addiu	$4,$4,1
	beq	$4,$11,$L3951
	addiu	$3,$3,12

$L3952:
	lw	$7,8($2)
	sra	$5,$7,3
	addu	$5,$9,$5
	lbu	$10,0($5)
	lbu	$23,3($5)
	lbu	$8,1($5)
	sll	$10,$10,24
	lbu	$5,2($5)
	or	$10,$23,$10
	sll	$8,$8,16
	sll	$5,$5,8
	or	$8,$10,$8
	or	$8,$8,$5
	andi	$5,$7,0x7
	sll	$5,$8,$5
	sltu	$8,$5,$6
	bne	$8,$0,$L3929
	and	$8,$5,$13

	srl	$5,$5,23
	addu	$8,$21,$5
	lbu	$8,0($8)
	addu	$5,$25,$5
	addu	$7,$8,$7
	sw	$7,8($2)
	b	$L3930
	lbu	$7,0($5)

$L4087:
	addiu	$22,$16,8448
	.option	pic0
	jal	get_ue_golomb
	.option	pic2
	move	$4,$22

	sltu	$3,$2,3
	beq	$3,$0,$L4117
	lw	$28,80($sp)

	li	$3,2			# 0x2
	bne	$2,$3,$L4118
	sw	$2,5340($21)

$L3980:
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	move	$4,$22

	li	$21,65536			# 0x10000
	addu	$21,$16,$21
	sll	$2,$2,1
	sw	$2,5344($21)
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	move	$4,$22

	sll	$2,$2,1
	lw	$28,80($sp)
	b	$L3978
	sw	$2,5348($21)

$L4075:
	.option	pic0
	jal	get_ue_golomb
	.option	pic2
	addiu	$4,$16,8448

	addiu	$2,$2,1
	lw	$28,80($sp)
	lw	$3,5936($22)
	b	$L3827
	sw	$2,5940($22)

$L3982:
	beq	$3,$0,$L4119
	slt	$2,$2,8

	beq	$2,$0,$L3983
	nop

$L3985:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$23,5340($2)
	li	$3,1			# 0x1
	bne	$23,$3,$L3986
	nop

	li	$21,131072			# 0x20000
	addu	$21,$17,$21
	lw	$3,9412($21)
	slt	$3,$3,2
	bne	$3,$0,$L3986
	nop

	lw	$3,604($22)
	andi	$3,$3,0x1
	beq	$3,$0,$L3987
	li	$3,2			# 0x2

	b	$L3986
	sw	$3,5340($2)

$L3738:
	bne	$16,$17,$L3717
	li	$2,-1			# 0xffffffffffffffff

	.option	pic0
	jal	free_tables
	.option	pic2
	move	$4,$16

	lw	$28,80($sp)
	lw	$25,%call16(MPV_common_end)($28)
	jalr	$25
	move	$4,$16

	lw	$2,112($16)
	bne	$2,$0,$L4042
	lw	$28,80($sp)

	lw	$25,%call16(MPV_common_init)($28)
$L4146:
	jalr	$25
	move	$4,$16

	bltz	$2,$L3717
	li	$2,-1			# 0xffffffffffffffff

	.option	pic0
	jal	init_scan_tables
	.option	pic2
	move	$4,$16

	.option	pic0
	jal	alloc_tables
	.option	pic2
	move	$4,$16

	li	$2,131072			# 0x20000
	ori	$2,$2,0x24a4
	addu	$2,$16,$2
	li	$6,65536			# 0x10000
	addiu	$3,$16,8704
	sw	$2,88($sp)
	addiu	$4,$16,10780
	li	$2,1			# 0x1
	addiu	$5,$16,12604
	addu	$6,$16,$6
	li	$9,131072			# 0x20000
	lw	$28,80($sp)
	sw	$3,100($sp)
	sw	$2,92($sp)
	sw	$4,104($sp)
	sw	$5,96($sp)
	sw	$6,108($sp)
	addu	$3,$16,$9
$L3742:
	lw	$22,0($16)
	lw	$11,92($sp)
	lw	$2,620($22)
	sltu	$4,$11,$2
	beq	$4,$0,$L4120
	lw	$25,%call16(av_malloc)($28)

	li	$4,131072			# 0x20000
	ori	$4,$4,0x24d0
	jalr	$25
	sw	$3,112($sp)

	lw	$11,88($sp)
	move	$22,$2
	lw	$28,80($sp)
	lw	$3,112($sp)
	sw	$2,0($11)
	move	$4,$22
	move	$2,$16
$L3743:
	lw	$5,12($2)
	lw	$8,0($2)
	lw	$7,4($2)
	lw	$6,8($2)
	sw	$8,0($4)
	sw	$7,4($4)
	sw	$6,8($4)
	sw	$5,12($4)
	lw	$5,100($sp)
	addiu	$2,$2,16
	bne	$2,$5,$L3743
	addiu	$4,$4,16

	lw	$25,%call16(memset)($28)
	li	$6,131072			# 0x20000
	addiu	$4,$22,8704
	sw	$3,112($sp)
	move	$5,$0
	jalr	$25
	ori	$6,$6,0x2d0

	lw	$3,112($sp)
	move	$2,$23
	addiu	$4,$22,9916
$L3744:
	lw	$6,8($2)
	lw	$8,0($2)
	lw	$7,4($2)
	lw	$5,12($2)
	sw	$8,0($4)
	sw	$7,4($4)
	sw	$6,8($4)
	sw	$5,12($4)
	lw	$6,104($sp)
	addiu	$2,$2,16
	bne	$2,$6,$L3744
	addiu	$4,$4,16

	move	$4,$fp
	addiu	$2,$22,11804
$L3745:
	lw	$8,0($4)
	lw	$7,4($4)
	lw	$6,8($4)
	lw	$5,12($4)
	sw	$8,0($2)
	sw	$7,4($2)
	sw	$6,8($2)
	sw	$5,12($2)
	lw	$9,96($sp)
	addiu	$4,$4,16
	bne	$4,$9,$L3745
	addiu	$2,$2,16

	lw	$5,0($9)
	lw	$4,4($9)
	sw	$5,0($2)
	sw	$4,4($2)
	move	$4,$22
	.option	pic0
	jal	init_scan_tables
	.option	pic2
	sw	$3,112($sp)

	lw	$3,112($sp)
	li	$11,131072			# 0x20000
	lw	$4,8684($3)
	addu	$2,$22,$11
	lw	$9,8660($3)
	lw	$6,8676($3)
	sw	$4,8684($2)
	lw	$4,108($sp)
	lw	$28,80($sp)
	sw	$9,8660($2)
	sw	$6,8676($2)
	lw	$9,88($sp)
	lw	$6,92($sp)
	lw	$14,-6288($4)
	lw	$12,9016($3)
	lw	$4,8688($3)
	lw	$11,8816($16)
	lw	$10,9128($16)
	lw	$8,9740($16)
	lw	$7,9744($16)
	li	$5,65536			# 0x10000
	lw	$25,%call16(ff_h264_pred_init)($28)
	addu	$13,$22,$5
	addiu	$6,$6,1
	addiu	$9,$9,4
	lw	$5,44($16)
	sw	$4,8688($2)
	sw	$14,-6288($13)
	sw	$12,9016($2)
	sw	$11,8816($22)
	sw	$10,9128($22)
	sw	$8,9740($22)
	sw	$7,9744($22)
	sw	$0,2048($22)
	addiu	$4,$22,8820
	sw	$6,92($sp)
	jalr	$25
	sw	$9,88($sp)

	lw	$28,80($sp)
	b	$L3742
	lw	$3,112($sp)

$L4092:
	move	$4,$0
	b	$L3792
	move	$2,$0

$L3813:
	li	$6,24			# 0x18
	b	$L3814
	li	$5,16			# 0x10

$L4090:
	addiu	$3,$16,4296
	sw	$2,6140($16)
	sw	$3,6144($16)
	b	$L3717
	move	$2,$0

$L4119:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,-6284($2)
	li	$2,3			# 0x3
	beq	$3,$2,$L4142
	li	$2,65536			# 0x10000

$L3983:
	lw	$2,8704($16)
	bne	$2,$0,$L3985
	li	$2,65536			# 0x10000

	b	$L4158
	addu	$2,$16,$2

$L3768:
$L4148:
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	addiu	$6,$6,%lo($LC47)
$L4048:
	jalr	$25
	move	$5,$0

	b	$L3717
	li	$2,-1			# 0xffffffffffffffff

$L4086:
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	addiu	$4,$16,8448

	b	$L3977
	lw	$28,80($sp)

$L4088:
	lui	$18,%hi($LC56)
	b	$L3994
	addiu	$18,$18,%lo($LC56)

$L3987:
	lw	$2,9416($21)
	beq	$2,$0,$L4121
	sw	$23,9412($21)

$L3988:
	beq	$16,$17,$L4122
	nop

	b	$L3717
	li	$2,1			# 0x1

$L3928:
	li	$2,131072			# 0x20000
	addu	$2,$17,$2
	lw	$3,6828($2)
	lw	$5,6824($2)
	lw	$4,9956($17)
	addu	$5,$3,$5
	beq	$5,$4,$L4123
	nop

$L3953:
	b	$L3925
	sw	$0,6820($2)

$L4110:
	beq	$4,$0,$L3867
	nop

	b	$L4124
	sw	$13,-6192($12)

$L4107:
	beq	$4,$0,$L3887
	nop

	b	$L3887
	sw	$13,-6192($12)

$L3838:
	li	$7,24			# 0x18
	b	$L3839
	li	$6,16			# 0x10

$L3775:
	srl	$2,$2,16
	b	$L3776
	li	$5,16			# 0x10

$L4064:
	.option	pic0
	jal	frame_start
	.option	pic2
	move	$4,$16

	bgez	$2,$L3760
	lw	$28,80($sp)

	b	$L3717
	li	$2,-1			# 0xffffffffffffffff

$L4123:
	addiu	$3,$3,17869
	sll	$3,$3,2
	addu	$3,$17,$3
	lw	$4,4($3)
	li	$3,1			# 0x1
	lw	$4,232($4)
	sw	$3,6028($2)
	sw	$3,6820($2)
	b	$L3925
	sw	$4,6032($2)

$L4121:
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC55)
	move	$4,$22
	addiu	$6,$6,%lo($LC55)
	jalr	$25
	li	$5,1			# 0x1

	lw	$28,80($sp)
	b	$L3988
	sw	$23,9416($21)

$L3917:
	li	$22,16447			# 0x403f
	b	$L3916
	li	$9,127			# 0x7f

$L4103:
	sra	$8,$4,3
	addu	$8,$2,$8
	lbu	$fp,0($8)
	lbu	$22,3($8)
	lbu	$23,1($8)
	sll	$fp,$fp,24
	lbu	$8,2($8)
	or	$22,$22,$fp
	sll	$23,$23,16
	sll	$8,$8,8
	or	$22,$22,$23
	or	$22,$22,$8
	andi	$8,$4,0x7
	sll	$8,$22,$8
	sltu	$22,$8,$7
	beq	$22,$0,$L4125
	nop

	and	$22,$8,$11
	bne	$22,$0,$L3850
	li	$fp,16			# 0x10

	move	$22,$8
	andi	$fp,$22,0xff00
	li	$23,8			# 0x8
	bne	$fp,$0,$L3852
	sw	$0,88($sp)

$L4131:
	addu	$22,$10,$22
	lw	$23,88($sp)
	lbu	$22,0($22)
	addiu	$4,$4,32
	addu	$22,$22,$23
	sll	$22,$22,1
	addiu	$22,$22,-31
	srl	$8,$8,$22
	andi	$23,$8,0x1
	subu	$22,$4,$22
	beq	$23,$0,$L3854
	sw	$22,8456($16)

$L4132:
	srl	$8,$8,1
	lw	$22,8456($16)
	subu	$8,$0,$8
$L3849:
	sra	$4,$22,3
	sw	$8,0($5)
	addu	$4,$2,$4
	lbu	$fp,0($4)
	lbu	$8,3($4)
	lbu	$23,1($4)
	sll	$fp,$fp,24
	lbu	$4,2($4)
	or	$8,$8,$fp
	sll	$23,$23,16
	sll	$4,$4,8
	or	$8,$8,$23
	or	$8,$8,$4
	andi	$4,$22,0x7
	sll	$4,$8,$4
	sltu	$8,$4,$7
	beq	$8,$0,$L4126
	and	$8,$4,$11

	bne	$8,$0,$L3858
	li	$fp,16			# 0x10

	move	$8,$4
	li	$23,8			# 0x8
	sw	$0,88($sp)
$L3859:
	andi	$fp,$8,0xff00
	bne	$fp,$0,$L3860
	nop

	lw	$23,88($sp)
$L3861:
	addu	$8,$10,$8
	lbu	$8,0($8)
	addiu	$22,$22,32
	addu	$8,$8,$23
	sll	$8,$8,1
	addiu	$8,$8,-31
	srl	$4,$4,$8
	andi	$23,$4,0x1
	subu	$8,$22,$8
	beq	$23,$0,$L3862
	sw	$8,8456($16)

	srl	$4,$4,1
	subu	$4,$0,$4
$L3857:
	lw	$8,0($5)
	beq	$15,$8,$L4127
	sw	$4,384($5)

	sw	$13,-6196($12)
$L4047:
	b	$L3865
	lw	$4,8456($16)

$L4127:
	beq	$4,$0,$L4047
	nop

	b	$L4047
	sw	$13,-6196($12)

$L4109:
	srl	$4,$4,23
	addu	$22,$25,$4
	lbu	$22,0($22)
	addu	$4,$24,$4
	addu	$8,$22,$8
	sw	$8,8456($16)
	b	$L3898
	lb	$4,0($4)

$L4105:
	srl	$8,$8,23
	addu	$22,$25,$8
	lbu	$22,0($22)
	addu	$8,$24,$8
	addu	$4,$22,$4
	sw	$4,8456($16)
	lb	$8,0($8)
	b	$L3869
	move	$22,$4

$L4108:
	srl	$4,$4,23
	addu	$22,$25,$4
	lbu	$22,0($22)
	addu	$4,$24,$4
	addu	$8,$22,$8
	sw	$8,8456($16)
	b	$L3889
	lb	$4,0($4)

$L4106:
	srl	$4,$4,23
	addu	$8,$25,$4
	lbu	$8,0($8)
	addu	$4,$24,$4
	addu	$22,$8,$22
	sw	$22,8456($16)
	b	$L3878
	lb	$4,0($4)

$L3879:
	srl	$8,$4,16
	sw	$fp,88($sp)
	andi	$fp,$8,0xff00
	beq	$fp,$0,$L4128
	li	$23,24			# 0x18

$L3880:
	srl	$8,$8,8
	addu	$8,$10,$8
	lbu	$8,0($8)
	addiu	$22,$22,32
	addu	$8,$8,$23
	sll	$8,$8,1
	addiu	$8,$8,-31
	srl	$4,$4,$8
	andi	$23,$4,0x1
	subu	$8,$22,$8
	beq	$23,$0,$L4129
	sw	$8,8456($16)

$L3881:
	srl	$4,$4,1
	b	$L3878
	subu	$4,$0,$4

$L3892:
	srl	$4,$4,1
	subu	$4,$0,$4
	b	$L3889
	lw	$8,8456($16)

$L3900:
	srl	$22,$22,8
	addu	$22,$10,$22
	lbu	$22,0($22)
	addiu	$8,$8,32
	addu	$22,$22,$23
	sll	$22,$22,1
	addiu	$22,$22,-31
	srl	$4,$4,$22
	andi	$23,$4,0x1
	subu	$22,$8,$22
	beq	$23,$0,$L4130
	sw	$22,8456($16)

$L3901:
	srl	$4,$4,1
	b	$L3898
	subu	$4,$0,$4

$L3899:
	srl	$22,$4,16
	li	$23,24			# 0x18
	b	$L3905
	sw	$fp,88($sp)

$L3872:
	srl	$8,$8,1
	subu	$8,$0,$8
	b	$L3869
	lw	$22,8456($16)

$L3871:
	b	$L3875
	srl	$22,$22,8

$L3870:
	srl	$22,$8,16
	li	$23,24			# 0x18
	b	$L3876
	sw	$fp,88($sp)

$L3891:
	b	$L3895
	srl	$22,$22,8

$L3890:
	srl	$22,$4,16
	li	$23,24			# 0x18
	b	$L3896
	sw	$fp,88($sp)

$L4126:
	srl	$4,$4,23
	addu	$8,$25,$4
	lbu	$8,0($8)
	addu	$4,$24,$4
	addu	$22,$8,$22
	sw	$22,8456($16)
	b	$L3857
	lb	$4,0($4)

$L4125:
	srl	$8,$8,23
	addu	$22,$25,$8
	lbu	$22,0($22)
	addu	$8,$24,$8
	addu	$4,$22,$4
	sw	$4,8456($16)
	lb	$8,0($8)
	b	$L3849
	move	$22,$4

$L3850:
	srl	$22,$8,16
	sw	$fp,88($sp)
	andi	$fp,$22,0xff00
	beq	$fp,$0,$L4131
	li	$23,24			# 0x18

$L3852:
	srl	$22,$22,8
	addu	$22,$10,$22
	lbu	$22,0($22)
	addiu	$4,$4,32
	addu	$22,$22,$23
	sll	$22,$22,1
	addiu	$22,$22,-31
	srl	$8,$8,$22
	andi	$23,$8,0x1
	subu	$22,$4,$22
	bne	$23,$0,$L4132
	sw	$22,8456($16)

$L3854:
	srl	$8,$8,1
	b	$L3849
	lw	$22,8456($16)

$L3862:
	b	$L3857
	srl	$4,$4,1

$L3860:
	b	$L3861
	srl	$8,$8,8

$L3858:
	srl	$8,$4,16
	li	$23,24			# 0x18
	b	$L3859
	sw	$fp,88($sp)

$L3942:
	lw	$8,8($2)
	lw	$10,0($2)
	sra	$5,$8,3
	addu	$5,$10,$5
	lbu	$23,0($5)
	lbu	$fp,3($5)
	lbu	$10,1($5)
	sll	$23,$23,24
	lbu	$5,2($5)
	or	$23,$fp,$23
	sll	$10,$10,16
	sll	$5,$5,8
	or	$10,$23,$10
	or	$10,$10,$5
	andi	$5,$8,0x7
	sll	$5,$10,$5
	sltu	$10,$5,$6
	beq	$10,$0,$L4133
	and	$10,$5,$13

	bne	$10,$0,$L3946
	li	$fp,24			# 0x18

	li	$23,8			# 0x8
	sw	$23,92($sp)
	move	$10,$5
	move	$23,$0
$L3947:
	andi	$fp,$10,0xff00
	beq	$fp,$0,$L3948
	nop

	lw	$23,92($sp)
	srl	$10,$10,8
$L3948:
	addu	$10,$14,$10
	lbu	$10,0($10)
	addiu	$8,$8,32
	addu	$10,$10,$23
	sll	$10,$10,1
	addiu	$10,$10,-31
	subu	$8,$8,$10
	srl	$5,$5,$10
	sw	$8,8($2)
	addiu	$5,$5,-1
$L3945:
	sltu	$8,$5,16
	beq	$8,$0,$L4134
	nop

	b	$L3943
	sw	$5,4($3)

$L3935:
	lw	$10,8($2)
	lw	$8,0($2)
	sra	$5,$10,3
	addu	$5,$8,$5
	lbu	$23,0($5)
	lbu	$fp,3($5)
	lbu	$8,1($5)
	sll	$23,$23,24
	lbu	$5,2($5)
	or	$23,$fp,$23
	sll	$8,$8,16
	or	$8,$23,$8
	sll	$5,$5,8
	or	$8,$8,$5
	andi	$5,$10,0x7
	sll	$5,$8,$5
	lw	$23,-6204($22)
	sltu	$8,$5,$6
	beq	$8,$0,$L4135
	sw	$23,88($sp)

	and	$8,$5,$13
	bne	$8,$0,$L3939
	li	$23,24			# 0x18

	li	$fp,8			# 0x8
	move	$8,$5
	sw	$fp,96($sp)
	move	$23,$0
$L3940:
	andi	$fp,$8,0xff00
	beq	$fp,$0,$L3941
	nop

	lw	$23,96($sp)
	srl	$8,$8,8
$L3941:
	addu	$8,$14,$8
	lbu	$8,0($8)
	addiu	$10,$10,32
	addu	$8,$8,$23
	sll	$8,$8,1
	addiu	$8,$8,-31
	subu	$10,$10,$8
	srl	$5,$5,$8
	sw	$10,8($2)
	addiu	$5,$5,-1
$L3938:
	lw	$23,88($sp)
	lw	$8,-6200($22)
	addiu	$10,$23,-1
	subu	$5,$10,$5
	addiu	$8,$8,-1
	and	$5,$5,$8
	b	$L3936
	sw	$5,0($3)

$L3933:
	b	$L3934
	srl	$8,$8,8

$L3931:
	li	$10,24			# 0x18
	b	$L3932
	li	$fp,16			# 0x10

$L4133:
	srl	$5,$5,23
	addu	$10,$21,$5
	lbu	$10,0($10)
	addu	$5,$25,$5
	addu	$8,$10,$8
	sw	$8,8($2)
	b	$L3945
	lbu	$5,0($5)

$L3946:
	srl	$10,$5,16
	sw	$fp,92($sp)
	b	$L3947
	li	$23,16			# 0x10

$L4135:
	srl	$5,$5,23
	addu	$8,$21,$5
	lbu	$8,0($8)
	addu	$5,$25,$5
	addu	$10,$8,$10
	sw	$10,8($2)
	b	$L3938
	lbu	$5,0($5)

$L3939:
	sw	$23,96($sp)
	srl	$8,$5,16
	b	$L3940
	li	$23,16			# 0x10

$L4111:
	b	$L3911
	li	$2,1			# 0x1

$L3843:
	li	$7,24			# 0x18
	b	$L3844
	li	$6,16			# 0x10

$L4102:
	lw	$4,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$4,$4,$3
	lbu	$4,0($4)
	addu	$5,$4,$5
	lw	$4,%got(ff_ue_golomb_vlc_code)($28)
	sw	$5,8456($16)
	addu	$3,$4,$3
	b	$L3842
	lbu	$3,0($3)

$L4095:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$2,$5,$2
	lbu	$2,0($2)
	addu	$4,$2,$4
	b	$L3773
	sw	$4,8456($16)

$L4101:
	srl	$3,$3,23
	addu	$4,$4,$3
	lbu	$4,0($4)
	addu	$5,$4,$5
	lw	$4,%got(ff_ue_golomb_vlc_code)($28)
	sw	$5,8456($16)
	addu	$3,$4,$3
	b	$L3837
	lbu	$4,0($3)

$L3819:
	b	$L3830
	sw	$0,5944($4)

$L3995:
	b	$L3994
	addiu	$18,$18,%lo($LC58)

$L4115:
	lw	$2,8456($16)
	lw	$4,8448($16)
	sra	$3,$2,3
	addu	$3,$4,$3
	lbu	$6,0($3)
	andi	$3,$2,0x7
	sll	$6,$6,$3
	andi	$6,$6,0x00ff
	addiu	$3,$2,1
	srl	$6,$6,7
	sra	$5,$3,3
	addiu	$6,$6,-1
	sw	$3,8456($16)
	sw	$6,8472($17)
	addu	$4,$4,$5
	lbu	$4,0($4)
	andi	$3,$3,0x7
	sll	$3,$4,$3
	andi	$3,$3,0x00ff
	addiu	$4,$2,2
	srl	$3,$3,7
	li	$2,131072			# 0x20000
	addiu	$3,$3,-1
	addu	$2,$17,$2
	sw	$4,8456($16)
	bne	$3,$0,$L3953
	sw	$3,6036($2)

	li	$3,1			# 0x1
	sw	$3,6820($2)
	li	$3,6			# 0x6
	b	$L3925
	sw	$3,6028($2)

$L3951:
	li	$2,131072			# 0x20000
	addu	$2,$17,$2
	b	$L3925
	sw	$4,6820($2)

$L3805:
	lw	$3,-6232($5)
	b	$L3793
	addu	$4,$4,$3

$L4114:
	b	$L3802
	move	$2,$0

$L4118:
	xori	$2,$2,0x1
	beq	$2,$0,$L3978
	sw	$2,5340($21)

	b	$L3980
	nop

$L4116:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($17)
	lui	$6,%hi($LC51)
	addiu	$6,$6,%lo($LC51)
	jalr	$25
	move	$5,$0

	b	$L3925
	lw	$28,80($sp)

$L4054:
	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$7,-6284($2)
	lw	$3,6168($16)
	lw	$2,6172($16)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC42)
	sw	$2,20($sp)
	sw	$3,16($sp)
	addiu	$6,$6,%lo($LC42)
	jalr	$25
	move	$5,$0

	b	$L3717
	li	$2,-1			# 0xffffffffffffffff

$L4057:
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L4048
	addiu	$6,$6,%lo($LC43)

$L4034:
	lw	$3,8500($16)
	li	$2,3			# 0x3
	beq	$3,$2,$L4035
	nop

	b	$L3781
	lw	$22,9932($16)

$L4134:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($17)
	lui	$6,%hi($LC50)
	addiu	$6,$6,%lo($LC50)
	jalr	$25
	move	$5,$0

	b	$L3925
	lw	$28,80($sp)

$L4122:
	b	$L3986
	lw	$22,0($16)

$L4035:
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	move	$4,$fp

	lw	$28,80($sp)
	lw	$3,8500($16)
	lw	$22,9932($16)
	b	$L3781
	sw	$2,-6232($23)

$L4059:
	lui	$6,%hi($LC45)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L4048
	addiu	$6,$6,%lo($LC45)

$L4100:
	lui	$6,%hi($LC52)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L4048
	addiu	$6,$6,%lo($LC52)

$L4136:
	lw	$2,4($16)
	sw	$2,40($22)
	lw	$2,8($16)
	sw	$2,44($22)
	lw	$3,10008($16)
	lw	$2,10012($16)
	sw	$3,400($22)
	bne	$2,$0,$L3755
	sw	$2,404($22)

	li	$2,1			# 0x1
	sw	$2,404($22)
$L3755:
	lw	$2,10016($16)
	beq	$2,$0,$L4042
	nop

	lw	$3,10020($16)
	lw	$2,10024($16)
	sll	$3,$3,1
	sw	$3,32($22)
	li	$3,131072			# 0x20000
	sw	$2,36($22)
	addu	$3,$16,$3
	lw	$3,9372($3)
	addiu	$3,$3,-1
	sltu	$3,$3,43
	beq	$3,$0,$L3756
	sll	$2,$2,1

	sw	$2,36($22)
$L3756:
	lw	$2,36($22)
	lw	$6,32($22)
	lw	$25,%call16(av_reduce)($28)
	sra	$3,$2,31
	li	$4,1073741824			# 0x40000000
	move	$5,$0
	sw	$4,24($sp)
	sw	$5,28($sp)
	sw	$3,20($sp)
	sw	$2,16($sp)
	addiu	$5,$22,36
	addiu	$4,$22,32
	jalr	$25
	sra	$7,$6,31

	lw	$28,80($sp)
$L4042:
	b	$L3739
	lw	$3,9972($16)

$L4099:
	slt	$23,$9,0
	movz	$22,$9,$23
	sra	$22,$22,1
	b	$L3916
	addiu	$22,$22,16384

$L4120:
	li	$3,131072			# 0x20000
	ori	$3,$3,0x24a0
	addu	$3,$16,$3
	sw	$3,88($sp)
	move	$fp,$0
$L3747:
	sltu	$2,$fp,$2
	beq	$2,$0,$L4136
	lw	$2,88($sp)

	lw	$25,%call16(av_mallocz)($28)
	lw	$23,0($2)
	lw	$4,144($23)
	jalr	$25
	sll	$4,$4,5

	lw	$28,80($sp)
	beq	$2,$0,$L4137
	sw	$2,8996($23)

	lw	$4,144($23)
$L3750:
	lw	$25,%call16(av_mallocz)($28)
	jalr	$25
	sll	$4,$4,5

	lw	$28,80($sp)
	beq	$2,$0,$L4138
	sw	$2,9000($23)

$L3751:
	lw	$3,4($23)
	lw	$25,%call16(av_mallocz)($28)
	sll	$2,$3,4
	sll	$3,$3,2
	subu	$2,$2,$3
	sll	$3,$2,3
	subu	$2,$3,$2
	jalr	$25
	addiu	$4,$2,5376

	lw	$28,80($sp)
	beq	$2,$0,$L4139
	sw	$2,2036($23)

	lw	$3,4($23)
$L3753:
	sll	$4,$3,3
	sll	$3,$3,1
	subu	$3,$4,$3
	sll	$4,$3,3
	lw	$6,88($sp)
	subu	$3,$4,$3
	lw	$22,0($16)
	addiu	$3,$3,2688
	addu	$3,$2,$3
	addiu	$6,$6,4
	lw	$2,620($22)
	sw	$3,2040($23)
	addiu	$fp,$fp,1
	b	$L3747
	sw	$6,88($sp)

$L4139:
	lw	$3,4($23)
	sll	$5,$3,4
	sll	$4,$3,2
	subu	$4,$5,$4
	sll	$5,$4,3
	subu	$4,$5,$4
	li	$5,-5376			# 0xffffffffffffeb00
	beq	$4,$5,$L3753
	lw	$25,%call16(perror)($28)

$L4143:
	lui	$4,%hi($LC3)
$L4159:
	jalr	$25
	addiu	$4,$4,%lo($LC3)

	b	$L3717
	li	$2,-1			# 0xffffffffffffffff

$L4138:
	lw	$2,144($23)
	beq	$2,$0,$L3751
	lw	$25,%call16(perror)($28)

	b	$L4159
	lui	$4,%hi($LC3)

$L4137:
	lw	$2,144($23)
	bne	$2,$0,$L4143
	lw	$25,%call16(perror)($28)

	b	$L3750
	move	$4,$0

$L4113:
	b	$L3799
	move	$2,$0

$L4117:
	lui	$6,%hi($LC54)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	addiu	$6,$6,%lo($LC54)
	move	$7,$2
$L4050:
	jalr	$25
	move	$5,$0

	b	$L3717
	li	$2,-1			# 0xffffffffffffffff

$L4096:
	lw	$3,5940($2)
	bne	$3,$4,$L4156
	li	$12,65536			# 0x10000

	li	$3,131072			# 0x20000
	addu	$3,$16,$3
	lw	$5,-13404($3)
	lw	$4,32548($2)
	sll	$3,$14,1
	addu	$4,$5,$4
	bne	$4,$3,$L4157
	addu	$13,$16,$12

	sw	$0,-6192($2)
	b	$L3912
	sw	$0,-6196($2)

$L4084:
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L4050
	addiu	$6,$6,%lo($LC53)

$L4058:
	lui	$6,%hi($LC44)
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	b	$L4048
	addiu	$6,$6,%lo($LC44)

	.set	macro
	.set	reorder
	.end	decode_slice_header
	.size	decode_slice_header, .-decode_slice_header
	.section	.rodata.str1.4
	.align	2
$LC62:
	.ascii	"%s_id (%d) out of range\012\000"
	.align	2
$LC63:
	.ascii	"sps\000"
	.align	2
$LC64:
	.ascii	"cannot allocate memory for %s\012\000"
	.align	2
$LC65:
	.ascii	"poc_cycle_length overflow %u\012\000"
	.align	2
$LC66:
	.ascii	"illegal POC type %d\012\000"
	.align	2
$LC67:
	.ascii	"too many reference frames\012\000"
	.align	2
$LC68:
	.ascii	"mb_width/height overflow\012\000"
	.align	2
$LC69:
	.ascii	"MBAFF + !direct_8x8_inference is not implemented\012\000"
	.align	2
$LC70:
	.ascii	"insane cropping not completely supported, this could loo"
	.ascii	"k slightly wrong ...\012\000"
	.align	2
$LC71:
	.ascii	"illegal aspect ratio\012\000"
	.align	2
$LC72:
	.ascii	"illegal num_reorder_frames %d\012\000"
	.align	2
$LC73:
	.ascii	"FRM\000"
	.align	2
$LC74:
	.ascii	"PIC-AFF\000"
	.align	2
$LC75:
	.ascii	"MB-AFF\000"
	.align	2
$LC76:
	.ascii	"8B8\000"
	.align	2
$LC77:
	.ascii	"VUI\000"
	.align	2
$LC78:
	.ascii	"sps:%u profile:%d/%d poc:%d ref:%d %dx%d %s %s crop:%d/%"
	.ascii	"d/%d/%d %s\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_seq_parameter_set
	.type	decode_seq_parameter_set, @function
decode_seq_parameter_set:
	.frame	$sp,144,$31		# vars= 24, regs= 10/0, args= 72, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-144
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,140($sp)
	sw	$fp,136($sp)
	sw	$23,132($sp)
	sw	$22,128($sp)
	sw	$21,124($sp)
	sw	$20,120($sp)
	sw	$19,116($sp)
	sw	$18,112($sp)
	sw	$17,108($sp)
	sw	$16,104($sp)
	.cprestore	72
	lw	$18,8456($4)
	lw	$2,8448($4)
	addiu	$19,$18,16
	sra	$5,$18,3
	addu	$5,$2,$5
	move	$16,$4
	addiu	$6,$18,24
	sra	$4,$19,3
	addu	$4,$2,$4
	lbu	$8,3($5)
	lbu	$9,0($5)
	lbu	$3,1($5)
	lbu	$22,2($5)
	sw	$19,8456($16)
	sra	$5,$6,3
	addu	$2,$2,$5
	lbu	$23,3($4)
	lbu	$fp,0($4)
	lbu	$10,1($4)
	lbu	$11,2($4)
	sw	$6,8456($16)
	lbu	$7,0($2)
	lbu	$5,1($2)
	lbu	$12,3($2)
	lbu	$4,2($2)
	sll	$7,$7,24
	or	$2,$12,$7
	sll	$5,$5,16
	sll	$4,$4,8
	or	$2,$2,$5
	or	$2,$2,$4
	andi	$4,$6,0x7
	sll	$2,$2,$4
	li	$4,134217728			# 0x8000000
	sltu	$4,$2,$4
	beq	$4,$0,$L4391
	li	$4,-65536			# 0xffffffffffff0000

	and	$4,$2,$4
	bne	$4,$0,$L4163
	srl	$4,$2,16

	move	$4,$2
	andi	$7,$4,0xff00
	li	$5,8			# 0x8
	bne	$7,$0,$L4165
	move	$12,$0

$L4415:
	move	$5,$12
$L4166:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$6,$6,32
	addu	$4,$7,$4
	lbu	$20,0($4)
	addu	$20,$20,$5
	sll	$20,$20,1
	addiu	$20,$20,-31
	subu	$6,$6,$20
	srl	$20,$2,$20
	sw	$6,8456($16)
	addiu	$20,$20,-1
$L4162:
	sltu	$2,$20,32
	beq	$2,$0,$L4392
	addiu	$21,$16,9788

	sll	$2,$20,2
	addu	$21,$21,$2
	lw	$17,0($21)
	beq	$17,$0,$L4393
	lw	$25,%call16(av_mallocz)($28)

$L4169:
	beq	$17,$0,$L4390
	sll	$fp,$fp,24

	sll	$9,$9,24
	or	$8,$8,$9
	sll	$3,$3,16
	or	$3,$8,$3
	or	$23,$23,$fp
	sll	$22,$22,8
	sll	$10,$10,16
	or	$22,$3,$22
	or	$10,$23,$10
	andi	$18,$18,0x7
	sll	$11,$11,8
	sll	$18,$22,$18
	or	$11,$10,$11
	andi	$19,$19,0x7
	srl	$18,$18,24
	sll	$19,$11,$19
	srl	$19,$19,24
	slt	$2,$18,100
	sw	$19,4($17)
	beq	$2,$0,$L4394
	sw	$18,0($17)

	sw	$0,636($17)
$L4192:
	lw	$4,8456($16)
	lw	$2,8448($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$6,1($3)
	lbu	$8,3($3)
	lbu	$5,2($3)
	sll	$7,$7,24
	or	$3,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$3,$3,$6
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4395
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4195
	srl	$5,$3,16

	move	$5,$3
	li	$6,8			# 0x8
	move	$8,$0
$L4196:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4197
	nop

	move	$6,$8
$L4198:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$5,$7,$5
	lbu	$5,0($5)
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$4,$4,$5
	srl	$3,$3,$5
	sw	$4,8456($16)
	addiu	$3,$3,-1
$L4194:
	addiu	$3,$3,4
	sw	$3,12($17)
	lw	$4,8456($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$6,1($3)
	lbu	$8,3($3)
	lbu	$5,2($3)
	sll	$7,$7,24
	or	$3,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$3,$3,$6
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4396
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4201
	srl	$5,$3,16

	move	$5,$3
	li	$6,8			# 0x8
	move	$8,$0
$L4202:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4203
	nop

	move	$6,$8
$L4204:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$5,$7,$5
	lbu	$7,0($5)
	addu	$7,$7,$6
	sll	$7,$7,1
	addiu	$7,$7,-31
	subu	$4,$4,$7
	srl	$7,$3,$7
	addiu	$7,$7,-1
	sw	$4,8456($16)
	beq	$7,$0,$L4397
	sw	$7,16($17)

$L4205:
	li	$3,1			# 0x1
	beq	$7,$3,$L4398
	li	$3,2			# 0x2

	bne	$7,$3,$L4399
	lw	$25,%call16(av_log)($28)

$L4212:
	lw	$4,8456($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$6,1($3)
	lbu	$8,3($3)
	lbu	$5,2($3)
	sll	$7,$7,24
	or	$3,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$3,$3,$6
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4400
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4226
	srl	$5,$3,16

	move	$5,$3
	li	$6,8			# 0x8
	move	$8,$0
$L4227:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4228
	nop

	move	$6,$8
$L4229:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$5,$7,$5
	lbu	$18,0($5)
	addu	$18,$18,$6
	sll	$18,$18,1
	addiu	$18,$18,-31
	subu	$4,$4,$18
	srl	$18,$3,$18
	addiu	$18,$18,-1
	sltu	$3,$18,31
	beq	$3,$0,$L4401
	sw	$4,8456($16)

$L4230:
	sw	$18,40($17)
	lw	$3,8456($16)
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,1
	srl	$4,$4,7
	sw	$3,8456($16)
	sw	$4,44($17)
	lw	$3,8456($16)
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$7,0($4)
	lbu	$6,1($4)
	lbu	$8,3($4)
	lbu	$5,2($4)
	sll	$7,$7,24
	or	$4,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$4,$4,$6
	or	$4,$4,$5
	andi	$5,$3,0x7
	sll	$4,$4,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$4,$5
	beq	$5,$0,$L4402
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$4,$5
	bne	$5,$0,$L4233
	srl	$5,$4,16

	move	$5,$4
	li	$6,8			# 0x8
	move	$8,$0
$L4234:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4235
	nop

	move	$6,$8
$L4236:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$3,$3,32
	addu	$5,$7,$5
	lbu	$18,0($5)
	addu	$18,$18,$6
	sll	$18,$18,1
	addiu	$18,$18,-31
	subu	$3,$3,$18
	srl	$18,$4,$18
	sw	$3,8456($16)
	addiu	$18,$18,-1
$L4232:
	sra	$4,$3,3
	addu	$2,$2,$4
	lbu	$6,0($2)
	lbu	$5,1($2)
	lbu	$7,3($2)
	lbu	$4,2($2)
	sll	$6,$6,24
	sll	$5,$5,16
	or	$2,$7,$6
	or	$2,$2,$5
	sll	$4,$4,8
	or	$2,$2,$4
	andi	$4,$3,0x7
	sll	$2,$2,$4
	li	$5,134217728			# 0x8000000
	sltu	$5,$2,$5
	beq	$5,$0,$L4403
	addiu	$18,$18,1

	li	$4,-65536			# 0xffffffffffff0000
	and	$4,$2,$4
	bne	$4,$0,$L4239
	srl	$4,$2,16

	move	$4,$2
	andi	$6,$4,0xff00
	li	$5,8			# 0x8
	bne	$6,$0,$L4241
	move	$7,$0

$L4417:
	move	$5,$7
$L4242:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$3,$3,32
	addu	$4,$6,$4
	lbu	$19,0($4)
	addu	$19,$19,$5
	sll	$19,$19,1
	addiu	$19,$19,-31
	subu	$3,$3,$19
	srl	$19,$2,$19
	sw	$3,8456($16)
	addiu	$19,$19,-1
$L4238:
	li	$3,134152192			# 0x7ff0000
	ori	$3,$3,0xffff
	sltu	$4,$18,$3
	beq	$4,$0,$L4243
	addiu	$19,$19,1

	sltu	$3,$19,$3
	beq	$3,$0,$L4243
	lw	$25,%call16(avcodec_check_dimensions)($28)

	move	$4,$0
	sll	$5,$18,4
	jalr	$25
	sll	$6,$19,4

	bne	$2,$0,$L4243
	lw	$28,72($sp)

	sw	$18,48($17)
	sw	$19,52($17)
	lw	$3,8456($16)
	lw	$2,8448($16)
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,1
	srl	$4,$4,7
	sw	$3,8456($16)
	bne	$4,$0,$L4245
	sw	$4,56($17)

	lw	$3,8456($16)
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,1
	srl	$4,$4,7
	sw	$3,8456($16)
	sw	$4,60($17)
$L4246:
	lw	$3,8456($16)
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,1
	srl	$4,$4,7
	sw	$3,8456($16)
	bne	$4,$0,$L4247
	sw	$4,64($17)

	lw	$3,60($17)
	bne	$3,$0,$L4404
	nop

$L4247:
	lw	$3,8456($16)
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,1
	srl	$4,$4,7
	sw	$3,8456($16)
	bne	$4,$0,$L4405
	sw	$4,68($17)

	sw	$0,84($17)
	sw	$0,80($17)
	sw	$0,76($17)
	sw	$0,72($17)
$L4274:
	lw	$3,8456($16)
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,1
	srl	$4,$4,7
	sw	$3,8456($16)
	beq	$4,$0,$L4275
	sw	$4,88($17)

	lw	$3,8456($16)
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$5,$5,$4
	andi	$5,$5,0x00ff
	addiu	$4,$3,1
	srl	$5,$5,7
	bne	$5,$0,$L4406
	sw	$4,8456($16)

	sw	$0,96($17)
	sw	$0,92($17)
$L4278:
	lw	$4,8456($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$5,0($3)
	andi	$3,$4,0x7
	sll	$5,$5,$3
	andi	$5,$5,0x00ff
	addiu	$3,$4,1
	srl	$5,$5,7
	bne	$5,$0,$L4407
	sw	$3,8456($16)

	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$5,$5,$4
	andi	$5,$5,0x00ff
	addiu	$4,$3,1
	srl	$5,$5,7
	bne	$5,$0,$L4408
	sw	$4,8456($16)

$L4281:
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$5,0($3)
	andi	$3,$4,0x7
	sll	$5,$5,$3
	andi	$5,$5,0x00ff
	addiu	$3,$4,1
	srl	$4,$5,7
	bne	$4,$0,$L4409
	sw	$3,8456($16)

$L4282:
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,1
	srl	$4,$4,7
	sw	$3,8456($16)
	bne	$4,$0,$L4410
	sw	$4,100($17)

$L4294:
	lw	$4,8456($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$8,0($3)
	andi	$3,$4,0x7
	sll	$8,$8,$3
	andi	$8,$8,0x00ff
	addiu	$4,$4,1
	srl	$8,$8,7
	bne	$8,$0,$L4411
	sw	$4,8456($16)

$L4295:
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$13,0($3)
	andi	$3,$4,0x7
	sll	$13,$13,$3
	andi	$13,$13,0x00ff
	addiu	$4,$4,1
	srl	$13,$13,7
	bne	$13,$0,$L4412
	sw	$4,8456($16)

	beq	$8,$0,$L4413
	nop

$L4337:
	addiu	$4,$4,1
	sw	$4,8456($16)
$L4338:
	addiu	$3,$4,1
	sra	$5,$3,3
	sw	$3,8456($16)
	addu	$5,$2,$5
	lbu	$5,0($5)
	andi	$3,$3,0x7
	sll	$3,$5,$3
	andi	$3,$3,0x00ff
	addiu	$4,$4,2
	srl	$3,$3,7
	sw	$4,8456($16)
	bne	$3,$0,$L4414
	sw	$3,628($17)

$L4275:
	lw	$4,0($16)
	lw	$2,412($4)
	andi	$2,$2,0x1
	beq	$2,$0,$L4168
	nop

	lw	$2,56($17)
	lw	$12,0($17)
	lw	$11,4($17)
	lw	$10,16($17)
	lw	$9,40($17)
	lw	$8,48($17)
	beq	$2,$0,$L4377
	lw	$7,52($17)

	lui	$15,%hi($LC73)
	addiu	$15,$15,%lo($LC73)
$L4378:
	lw	$2,64($17)
	bne	$2,$0,$L4380
	lui	$14,%hi($LC76)

	lui	$14,%hi($LC60)
	addiu	$14,$14,%lo($LC60)
$L4381:
	lw	$13,88($17)
	lw	$6,72($17)
	lw	$5,76($17)
	lw	$3,80($17)
	bne	$13,$0,$L4382
	lw	$2,84($17)

	lui	$13,%hi($LC60)
	addiu	$13,$13,%lo($LC60)
$L4383:
	lw	$25,%call16(av_log)($28)
	sw	$6,48($sp)
	lui	$6,%hi($LC78)
	sw	$7,36($sp)
	sw	$5,52($sp)
	sw	$2,60($sp)
	sw	$12,16($sp)
	sw	$11,20($sp)
	sw	$10,24($sp)
	sw	$9,28($sp)
	sw	$8,32($sp)
	sw	$15,40($sp)
	sw	$14,44($sp)
	sw	$3,56($sp)
	sw	$13,64($sp)
	addiu	$6,$6,%lo($LC78)
	move	$7,$20
	jalr	$25
	li	$5,2			# 0x2

	move	$2,$0
$L4168:
	lw	$31,140($sp)
	lw	$fp,136($sp)
	lw	$23,132($sp)
	lw	$22,128($sp)
	lw	$21,124($sp)
	lw	$20,120($sp)
	lw	$19,116($sp)
	lw	$18,112($sp)
	lw	$17,108($sp)
	lw	$16,104($sp)
	j	$31
	addiu	$sp,$sp,144

$L4163:
	andi	$7,$4,0xff00
	li	$5,24			# 0x18
	beq	$7,$0,$L4415
	li	$12,16			# 0x10

$L4165:
	b	$L4166
	srl	$4,$4,8

$L4391:
	lw	$4,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$4,$4,$2
	lbu	$4,0($4)
	addu	$6,$4,$6
	lw	$4,%got(ff_ue_golomb_vlc_code)($28)
	sw	$6,8456($16)
	addu	$2,$4,$2
	b	$L4162
	lbu	$20,0($2)

$L4245:
	b	$L4246
	sw	$0,60($17)

$L4396:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$4,8456($16)
	addu	$3,$5,$3
	lbu	$7,0($3)
	bne	$7,$0,$L4205
	sw	$7,16($17)

$L4397:
	lw	$4,8456($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$6,1($3)
	lbu	$8,3($3)
	lbu	$5,2($3)
	sll	$7,$7,24
	or	$3,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$3,$3,$6
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4416
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4208
	srl	$5,$3,16

	move	$5,$3
	li	$6,8			# 0x8
	move	$8,$0
$L4209:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4210
	nop

	move	$6,$8
$L4211:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$5,$7,$5
	lbu	$5,0($5)
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	srl	$3,$3,$5
	addiu	$3,$3,-1
	subu	$4,$4,$5
	addiu	$3,$3,4
	sw	$4,8456($16)
	b	$L4212
	sw	$3,20($17)

$L4395:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$4,8456($16)
	addu	$3,$5,$3
	b	$L4194
	lbu	$3,0($3)

$L4403:
	lw	$4,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$4,$4,$2
	lbu	$4,0($4)
	addu	$3,$4,$3
	lw	$4,%got(ff_ue_golomb_vlc_code)($28)
	sw	$3,8456($16)
	addu	$2,$4,$2
	b	$L4238
	lbu	$19,0($2)

$L4402:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$4,$4,23
	addu	$5,$5,$4
	lbu	$5,0($5)
	addu	$3,$5,$3
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$3,8456($16)
	addu	$4,$5,$4
	b	$L4232
	lbu	$18,0($4)

$L4400:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	addu	$3,$5,$3
	lbu	$18,0($3)
	sltu	$3,$18,31
	bne	$3,$0,$L4230
	sw	$4,8456($16)

$L4401:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC67)
	addiu	$6,$6,%lo($LC67)
	jalr	$25
	move	$5,$0

	lw	$28,72($sp)
	b	$L4230
	lw	$2,8448($16)

$L4197:
	b	$L4198
	srl	$5,$5,8

$L4203:
	b	$L4204
	srl	$5,$5,8

$L4201:
	li	$6,24			# 0x18
	b	$L4202
	li	$8,16			# 0x10

$L4195:
	li	$6,24			# 0x18
	b	$L4196
	li	$8,16			# 0x10

$L4239:
	andi	$6,$4,0xff00
	li	$5,24			# 0x18
	beq	$6,$0,$L4417
	li	$7,16			# 0x10

$L4241:
	b	$L4242
	srl	$4,$4,8

$L4235:
	b	$L4236
	srl	$5,$5,8

$L4233:
	li	$6,24			# 0x18
	b	$L4234
	li	$8,16			# 0x10

$L4228:
	b	$L4229
	srl	$5,$5,8

$L4226:
	li	$6,24			# 0x18
	b	$L4227
	li	$8,16			# 0x10

$L4394:
	lw	$4,8456($16)
	lw	$2,8448($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$6,1($3)
	lbu	$8,3($3)
	lbu	$5,2($3)
	sll	$7,$7,24
	or	$3,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$3,$3,$6
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4418
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4174
	srl	$5,$3,16

	move	$5,$3
	li	$6,8			# 0x8
	move	$8,$0
$L4175:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4176
	nop

	move	$6,$8
$L4177:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$5,$7,$5
	lbu	$5,0($5)
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$4,$4,$5
	srl	$3,$3,$5
	sw	$4,8456($16)
	addiu	$3,$3,-1
$L4173:
	li	$5,3			# 0x3
	beq	$3,$5,$L4178
	addiu	$4,$4,1

	lw	$4,8456($16)
$L4179:
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$6,1($3)
	lbu	$8,3($3)
	lbu	$5,2($3)
	sll	$7,$7,24
	or	$3,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$3,$3,$6
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4419
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4182
	li	$5,24			# 0x18

	li	$5,8			# 0x8
	move	$7,$0
$L4183:
	andi	$6,$3,0xff00
	bne	$6,$0,$L4184
	nop

	move	$5,$7
$L4185:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$4,$4,63
	addu	$3,$6,$3
	lbu	$3,0($3)
	addu	$5,$3,$5
	sll	$5,$5,1
	subu	$4,$4,$5
	sw	$4,8456($16)
$L4181:
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$6,1($3)
	lbu	$8,3($3)
	lbu	$5,2($3)
	sll	$7,$7,24
	or	$3,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$3,$3,$6
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4420
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4188
	li	$5,24			# 0x18

	li	$5,8			# 0x8
	move	$7,$0
$L4189:
	andi	$6,$3,0xff00
	bne	$6,$0,$L4190
	nop

	move	$5,$7
$L4191:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$4,$4,63
	addu	$3,$6,$3
	lbu	$3,0($3)
	addu	$5,$3,$5
	sll	$5,$5,1
	subu	$3,$4,$5
	sw	$3,8456($16)
$L4187:
	sra	$4,$3,3
	addu	$2,$2,$4
	lbu	$4,0($2)
	andi	$2,$3,0x7
	sll	$2,$4,$2
	andi	$2,$2,0x00ff
	addiu	$3,$3,1
	srl	$2,$2,7
	sw	$3,8456($16)
	move	$4,$16
	sw	$2,8($17)
	addiu	$3,$17,640
	addiu	$2,$17,736
	move	$5,$17
	move	$6,$0
	li	$7,1			# 0x1
	sw	$3,16($sp)
	.option	pic0
	jal	decode_scaling_matrices
	.option	pic2
	sw	$2,20($sp)

	b	$L4192
	lw	$28,72($sp)

$L4382:
	lui	$13,%hi($LC77)
	b	$L4383
	addiu	$13,$13,%lo($LC77)

$L4380:
	b	$L4381
	addiu	$14,$14,%lo($LC76)

$L4377:
	lw	$2,60($17)
	beq	$2,$0,$L4421
	nop

	lui	$15,%hi($LC75)
	b	$L4378
	addiu	$15,$15,%lo($LC75)

$L4405:
	lw	$4,8456($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$6,1($3)
	lbu	$8,3($3)
	lbu	$5,2($3)
	sll	$7,$7,24
	or	$3,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$3,$3,$6
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4422
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4251
	srl	$5,$3,16

	move	$5,$3
	li	$6,8			# 0x8
	move	$8,$0
$L4252:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4253
	nop

	move	$6,$8
$L4254:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$5,$7,$5
	lbu	$5,0($5)
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$4,$4,$5
	srl	$3,$3,$5
	sw	$4,8456($16)
	addiu	$3,$3,-1
$L4250:
	sw	$3,72($17)
	lw	$4,8456($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$6,1($3)
	lbu	$8,3($3)
	lbu	$5,2($3)
	sll	$7,$7,24
	or	$3,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$3,$3,$6
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4423
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4257
	srl	$5,$3,16

	move	$5,$3
	li	$6,8			# 0x8
	move	$8,$0
$L4258:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4259
	nop

	move	$6,$8
$L4260:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$5,$7,$5
	lbu	$5,0($5)
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$4,$4,$5
	srl	$3,$3,$5
	sw	$4,8456($16)
	addiu	$3,$3,-1
$L4256:
	sw	$3,76($17)
	lw	$4,8456($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$6,1($3)
	lbu	$8,3($3)
	lbu	$5,2($3)
	sll	$7,$7,24
	or	$3,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$3,$3,$6
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4424
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4263
	srl	$5,$3,16

	move	$5,$3
	li	$6,8			# 0x8
	move	$8,$0
$L4264:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4265
	nop

	move	$6,$8
$L4266:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$5,$7,$5
	lbu	$5,0($5)
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$4,$4,$5
	srl	$3,$3,$5
	sw	$4,8456($16)
	addiu	$3,$3,-1
$L4262:
	sw	$3,80($17)
	lw	$4,8456($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$7,0($3)
	lbu	$6,1($3)
	lbu	$8,3($3)
	lbu	$5,2($3)
	sll	$7,$7,24
	or	$3,$8,$7
	sll	$6,$6,16
	sll	$5,$5,8
	or	$3,$3,$6
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4425
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4269
	srl	$5,$3,16

	move	$5,$3
	li	$6,8			# 0x8
	move	$8,$0
$L4270:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4271
	nop

	move	$6,$8
$L4272:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$4,$4,32
	addu	$5,$7,$5
	lbu	$5,0($5)
	addu	$5,$5,$6
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$4,$4,$5
	srl	$3,$3,$5
	sw	$4,8456($16)
	addiu	$3,$3,-1
$L4268:
	lw	$4,72($17)
	bne	$4,$0,$L4273
	sw	$3,84($17)

	lw	$3,80($17)
	beq	$3,$0,$L4274
	nop

$L4273:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC70)
	addiu	$6,$6,%lo($LC70)
	jalr	$25
	move	$5,$0

	lw	$28,72($sp)
	b	$L4274
	lw	$2,8448($16)

$L4413:
	bne	$13,$0,$L4337
	nop

	b	$L4338
	lw	$4,8456($16)

$L4407:
	addiu	$3,$4,2
	sra	$4,$3,3
	sw	$3,8456($16)
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$5,$5,$4
	andi	$5,$5,0x00ff
	addiu	$4,$3,1
	srl	$5,$5,7
	beq	$5,$0,$L4281
	sw	$4,8456($16)

$L4408:
	addiu	$4,$3,5
	sra	$5,$4,3
	sw	$4,8456($16)
	addu	$5,$2,$5
	lbu	$5,0($5)
	andi	$4,$4,0x7
	sll	$5,$5,$4
	andi	$5,$5,0x00ff
	addiu	$4,$3,6
	srl	$3,$5,7
	beq	$3,$0,$L4281
	sw	$4,8456($16)

	addiu	$18,$16,8448
	move	$4,$18
	.option	pic0
	jal	get_bits
	.option	pic2
	li	$5,8			# 0x8

	move	$4,$18
	.option	pic0
	jal	get_bits
	.option	pic2
	li	$5,8			# 0x8

	move	$4,$18
	.option	pic0
	jal	get_bits
	.option	pic2
	li	$5,8			# 0x8

	lw	$28,72($sp)
	lw	$4,8456($16)
	b	$L4281
	lw	$2,8448($16)

$L4421:
	lui	$15,%hi($LC74)
	b	$L4378
	addiu	$15,$15,%lo($LC74)

$L4416:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$4,8456($16)
	addu	$3,$5,$3
	lbu	$3,0($3)
	addiu	$3,$3,4
	b	$L4212
	sw	$3,20($17)

$L4418:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$4,8456($16)
	addu	$3,$5,$3
	b	$L4173
	lbu	$3,0($3)

$L4412:
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$6,0($3)
	lbu	$7,3($3)
	lbu	$5,1($3)
	sll	$6,$6,24
	lbu	$3,2($3)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$3,$3,8
	or	$5,$6,$5
	or	$5,$5,$3
	andi	$3,$4,0x7
	sll	$3,$5,$3
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4426
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4319
	srl	$5,$3,16

	move	$5,$3
	li	$6,8			# 0x8
	move	$9,$0
$L4320:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4321
	nop

	move	$6,$9
$L4322:
	lw	$7,%got(ff_log2_tab)($28)
	addu	$5,$7,$5
	lbu	$11,0($5)
	addu	$11,$11,$6
	sll	$11,$11,1
	addiu	$11,$11,-31
	subu	$4,$4,$11
	srl	$11,$3,$11
	addiu	$4,$4,40
	addiu	$11,$11,-1
	bltz	$11,$L4323
	sw	$4,8456($16)

$L4318:
	lw	$10,%got(ff_log2_tab)($28)
	lw	$12,%got(ff_golomb_vlc_len)($28)
	move	$6,$0
	li	$7,134217728			# 0x8000000
	b	$L4336
	li	$9,-65536			# 0xffffffffffff0000

$L4324:
	bne	$5,$0,$L4326
	li	$5,24			# 0x18

	li	$5,8			# 0x8
	move	$15,$0
$L4327:
	andi	$14,$3,0xff00
	bne	$14,$0,$L4328
	nop

	move	$5,$15
$L4329:
	addu	$3,$10,$3
	lbu	$3,0($3)
	addiu	$4,$4,63
	addu	$5,$3,$5
	sll	$5,$5,1
	subu	$4,$4,$5
	sw	$4,8456($16)
$L4325:
	sra	$5,$4,3
	addu	$5,$2,$5
	lbu	$3,0($5)
	lbu	$15,3($5)
	lbu	$14,1($5)
	sll	$3,$3,24
	lbu	$5,2($5)
	or	$3,$15,$3
	sll	$14,$14,16
	sll	$5,$5,8
	or	$3,$3,$14
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	sltu	$5,$3,$7
	beq	$5,$0,$L4427
	and	$5,$3,$9

	bne	$5,$0,$L4332
	li	$5,24			# 0x18

	andi	$14,$3,0xff00
	li	$5,8			# 0x8
	bne	$14,$0,$L4334
	move	$15,$0

$L4442:
	move	$5,$15
$L4335:
	addu	$3,$10,$3
	lbu	$3,0($3)
	addiu	$4,$4,63
	addu	$5,$3,$5
	sll	$5,$5,1
	subu	$4,$4,$5
	sw	$4,8456($16)
$L4331:
	addiu	$6,$6,1
	addiu	$4,$4,1
	slt	$3,$11,$6
	bne	$3,$0,$L4323
	sw	$4,8456($16)

$L4336:
	sra	$5,$4,3
	addu	$5,$2,$5
	lbu	$3,0($5)
	lbu	$15,3($5)
	lbu	$14,1($5)
	sll	$3,$3,24
	lbu	$5,2($5)
	or	$3,$15,$3
	sll	$14,$14,16
	sll	$5,$5,8
	or	$3,$3,$14
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	sltu	$5,$3,$7
	bne	$5,$0,$L4324
	and	$5,$3,$9

	srl	$3,$3,23
	addu	$3,$12,$3
	lbu	$3,0($3)
	addu	$4,$3,$4
	b	$L4325
	sw	$4,8456($16)

$L4422:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$4,8456($16)
	addu	$3,$5,$3
	b	$L4250
	lbu	$3,0($3)

$L4393:
	sw	$3,92($sp)
	sw	$8,88($sp)
	sw	$9,96($sp)
	sw	$10,84($sp)
	sw	$11,80($sp)
	jalr	$25
	li	$4,864			# 0x360

	lw	$28,72($sp)
	move	$17,$2
	sw	$2,0($21)
	lw	$3,92($sp)
	lw	$8,88($sp)
	lw	$9,96($sp)
	lw	$10,84($sp)
	bne	$2,$0,$L4169
	lw	$11,80($sp)

	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC64)
	lui	$7,%hi($LC63)
	addiu	$6,$6,%lo($LC64)
	addiu	$7,$7,%lo($LC63)
	jalr	$25
	move	$5,$0

	lw	$28,72($sp)
	lw	$17,0($21)
	lw	$11,80($sp)
	lw	$10,84($sp)
	lw	$9,96($sp)
	lw	$8,88($sp)
	b	$L4169
	lw	$3,92($sp)

$L4243:
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC68)
	addiu	$6,$6,%lo($LC68)
	jalr	$25
	move	$5,$0

	lw	$31,140($sp)
	li	$2,-1			# 0xffffffffffffffff
	lw	$fp,136($sp)
	lw	$23,132($sp)
	lw	$22,128($sp)
	lw	$21,124($sp)
	lw	$20,120($sp)
	lw	$19,116($sp)
	lw	$18,112($sp)
	lw	$17,108($sp)
	lw	$16,104($sp)
	j	$31
	addiu	$sp,$sp,144

$L4404:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC69)
	addiu	$6,$6,%lo($LC69)
	jalr	$25
	move	$5,$0

	lw	$28,72($sp)
	b	$L4247
	lw	$2,8448($16)

$L4406:
	sra	$5,$4,3
	addu	$5,$2,$5
	lbu	$7,0($5)
	lbu	$8,3($5)
	lbu	$6,1($5)
	sll	$7,$7,24
	lbu	$5,2($5)
	or	$7,$8,$7
	sll	$6,$6,16
	or	$6,$7,$6
	sll	$5,$5,8
	or	$5,$6,$5
	andi	$4,$4,0x7
	addiu	$3,$3,9
	sll	$4,$5,$4
	sw	$3,8456($16)
	srl	$4,$4,24
	li	$3,255			# 0xff
	beq	$4,$3,$L4428
	sltu	$3,$4,14

	beq	$3,$0,$L4279
	sll	$4,$4,3

	lui	$3,%hi(pixel_aspect)
	addiu	$3,$3,%lo(pixel_aspect)
	addu	$4,$4,$3
	lw	$5,4($4)
	lw	$3,0($4)
	sw	$5,96($17)
	b	$L4278
	sw	$3,92($17)

$L4420:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$3,$5,$3
	lbu	$3,0($3)
	addu	$3,$3,$4
	b	$L4187
	sw	$3,8456($16)

$L4419:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$3,$5,$3
	lbu	$3,0($3)
	addu	$4,$3,$4
	b	$L4181
	sw	$4,8456($16)

$L4409:
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$6,0($4)
	lbu	$7,3($4)
	lbu	$5,1($4)
	sll	$6,$6,24
	lbu	$4,2($4)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$4,$4,8
	or	$5,$6,$5
	or	$5,$5,$4
	andi	$4,$3,0x7
	sll	$4,$5,$4
	li	$5,134217728			# 0x8000000
	sltu	$5,$4,$5
	beq	$5,$0,$L4429
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$4,$5
	bne	$5,$0,$L4285
	li	$5,24			# 0x18

	li	$5,8			# 0x8
	move	$7,$0
$L4286:
	andi	$6,$4,0xff00
	bne	$6,$0,$L4287
	nop

	move	$5,$7
$L4288:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$3,$3,63
	addu	$4,$6,$4
	lbu	$4,0($4)
	addu	$5,$4,$5
	sll	$5,$5,1
	subu	$3,$3,$5
	sw	$3,8456($16)
$L4284:
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$6,0($4)
	lbu	$7,3($4)
	lbu	$5,1($4)
	sll	$6,$6,24
	lbu	$4,2($4)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$4,$4,8
	or	$5,$6,$5
	or	$5,$5,$4
	andi	$4,$3,0x7
	sll	$4,$5,$4
	li	$5,134217728			# 0x8000000
	sltu	$5,$4,$5
	beq	$5,$0,$L4430
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$4,$5
	bne	$5,$0,$L4290
	li	$5,24			# 0x18

	li	$5,8			# 0x8
	move	$7,$0
$L4291:
	andi	$6,$4,0xff00
	bne	$6,$0,$L4292
	nop

	move	$5,$7
$L4293:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$3,$3,63
	addu	$4,$6,$4
	lbu	$4,0($4)
	addu	$5,$4,$5
	sll	$5,$5,1
	subu	$3,$3,$5
	b	$L4282
	sw	$3,8456($16)

$L4414:
	lw	$4,8456($16)
	addiu	$4,$4,1
	sra	$3,$4,3
	sw	$4,8456($16)
	addu	$3,$2,$3
	lbu	$6,0($3)
	lbu	$7,3($3)
	lbu	$5,1($3)
	sll	$6,$6,24
	lbu	$3,2($3)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$3,$3,8
	or	$5,$6,$5
	or	$5,$5,$3
	andi	$3,$4,0x7
	sll	$3,$5,$3
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4431
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4341
	li	$5,24			# 0x18

	li	$5,8			# 0x8
	move	$7,$0
$L4342:
	andi	$6,$3,0xff00
	bne	$6,$0,$L4343
	nop

	move	$5,$7
$L4344:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$4,$4,63
	addu	$3,$6,$3
	lbu	$3,0($3)
	addu	$5,$3,$5
	sll	$5,$5,1
	subu	$4,$4,$5
	sw	$4,8456($16)
$L4340:
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$6,0($3)
	lbu	$7,3($3)
	lbu	$5,1($3)
	sll	$6,$6,24
	lbu	$3,2($3)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$3,$3,8
	or	$5,$6,$5
	or	$5,$5,$3
	andi	$3,$4,0x7
	sll	$3,$5,$3
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4432
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4347
	li	$5,24			# 0x18

	li	$5,8			# 0x8
	move	$7,$0
$L4348:
	andi	$6,$3,0xff00
	bne	$6,$0,$L4349
	nop

	move	$5,$7
$L4350:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$4,$4,63
	addu	$3,$6,$3
	lbu	$3,0($3)
	addu	$5,$3,$5
	sll	$5,$5,1
	subu	$4,$4,$5
	sw	$4,8456($16)
$L4346:
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$6,0($3)
	lbu	$7,3($3)
	lbu	$5,1($3)
	sll	$6,$6,24
	lbu	$3,2($3)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$3,$3,8
	or	$5,$6,$5
	or	$5,$5,$3
	andi	$3,$4,0x7
	sll	$3,$5,$3
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4433
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4353
	li	$5,24			# 0x18

	li	$5,8			# 0x8
	move	$7,$0
$L4354:
	andi	$6,$3,0xff00
	bne	$6,$0,$L4355
	nop

	move	$5,$7
$L4356:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$4,$4,63
	addu	$3,$6,$3
	lbu	$3,0($3)
	addu	$5,$3,$5
	sll	$5,$5,1
	subu	$4,$4,$5
	sw	$4,8456($16)
$L4352:
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$6,0($3)
	lbu	$7,3($3)
	lbu	$5,1($3)
	sll	$6,$6,24
	lbu	$3,2($3)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$3,$3,8
	or	$5,$6,$5
	or	$5,$5,$3
	andi	$3,$4,0x7
	sll	$3,$5,$3
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4434
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4359
	li	$5,24			# 0x18

	li	$5,8			# 0x8
	move	$7,$0
$L4360:
	andi	$6,$3,0xff00
	bne	$6,$0,$L4361
	nop

	move	$5,$7
$L4362:
	lw	$6,%got(ff_log2_tab)($28)
	addiu	$4,$4,63
	addu	$3,$6,$3
	lbu	$3,0($3)
	addu	$5,$3,$5
	sll	$5,$5,1
	subu	$3,$4,$5
	sw	$3,8456($16)
$L4358:
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$6,0($4)
	lbu	$7,3($4)
	lbu	$5,1($4)
	sll	$6,$6,24
	lbu	$4,2($4)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$4,$4,8
	or	$5,$6,$5
	or	$5,$5,$4
	andi	$4,$3,0x7
	sll	$4,$5,$4
	li	$5,134217728			# 0x8000000
	sltu	$5,$4,$5
	beq	$5,$0,$L4435
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$4,$5
	bne	$5,$0,$L4365
	srl	$5,$4,16

	move	$5,$4
	li	$6,8			# 0x8
	move	$8,$0
$L4366:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4367
	nop

	move	$6,$8
$L4368:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$3,$3,32
	addu	$5,$7,$5
	lbu	$7,0($5)
	addu	$7,$7,$6
	sll	$7,$7,1
	addiu	$7,$7,-31
	subu	$3,$3,$7
	srl	$7,$4,$7
	sw	$3,8456($16)
	addiu	$7,$7,-1
$L4364:
	sra	$4,$3,3
	addu	$2,$2,$4
	lbu	$5,0($2)
	lbu	$6,3($2)
	lbu	$4,1($2)
	sll	$5,$5,24
	lbu	$2,2($2)
	or	$5,$6,$5
	sll	$4,$4,16
	sll	$2,$2,8
	or	$4,$5,$4
	or	$4,$4,$2
	andi	$2,$3,0x7
	sll	$2,$4,$2
	li	$4,134217728			# 0x8000000
	sltu	$4,$2,$4
	beq	$4,$0,$L4436
	li	$4,-65536			# 0xffffffffffff0000

	and	$4,$2,$4
	bne	$4,$0,$L4371
	li	$4,24			# 0x18

	li	$4,8			# 0x8
	move	$6,$0
$L4372:
	andi	$5,$2,0xff00
	bne	$5,$0,$L4373
	nop

	move	$4,$6
$L4374:
	lw	$5,%got(ff_log2_tab)($28)
	addiu	$3,$3,63
	addu	$2,$5,$2
	lbu	$2,0($2)
	addu	$4,$2,$4
	sll	$4,$4,1
	subu	$3,$3,$4
	sw	$3,8456($16)
$L4370:
	sltu	$2,$7,17
	beq	$2,$0,$L4437
	nop

	b	$L4275
	sw	$7,632($17)

$L4411:
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$6,0($3)
	lbu	$7,3($3)
	lbu	$5,1($3)
	sll	$6,$6,24
	lbu	$3,2($3)
	or	$6,$7,$6
	sll	$5,$5,16
	sll	$3,$3,8
	or	$5,$6,$5
	or	$5,$5,$3
	andi	$3,$4,0x7
	sll	$3,$5,$3
	li	$5,134217728			# 0x8000000
	sltu	$5,$3,$5
	beq	$5,$0,$L4438
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$3,$5
	bne	$5,$0,$L4298
	srl	$5,$3,16

	move	$5,$3
	li	$6,8			# 0x8
	move	$9,$0
$L4299:
	andi	$7,$5,0xff00
	bne	$7,$0,$L4300
	nop

	move	$6,$9
$L4301:
	lw	$7,%got(ff_log2_tab)($28)
	addu	$5,$7,$5
	lbu	$12,0($5)
	addu	$12,$12,$6
	sll	$12,$12,1
	addiu	$12,$12,-31
	subu	$4,$4,$12
	srl	$12,$3,$12
	addiu	$4,$4,40
	addiu	$12,$12,-1
	bltz	$12,$L4302
	sw	$4,8456($16)

$L4297:
	lw	$11,%got(ff_log2_tab)($28)
	lw	$13,%got(ff_golomb_vlc_len)($28)
	move	$6,$0
	li	$7,134217728			# 0x8000000
	b	$L4315
	li	$10,-65536			# 0xffffffffffff0000

$L4303:
	bne	$5,$0,$L4305
	li	$5,24			# 0x18

	li	$5,8			# 0x8
	move	$14,$0
$L4306:
	andi	$9,$3,0xff00
	bne	$9,$0,$L4307
	nop

	move	$5,$14
$L4308:
	addu	$3,$11,$3
	lbu	$3,0($3)
	addiu	$4,$4,63
	addu	$5,$3,$5
	sll	$5,$5,1
	subu	$4,$4,$5
	sw	$4,8456($16)
$L4304:
	sra	$5,$4,3
	addu	$5,$2,$5
	lbu	$3,0($5)
	lbu	$14,3($5)
	lbu	$9,1($5)
	sll	$3,$3,24
	lbu	$5,2($5)
	or	$3,$14,$3
	sll	$9,$9,16
	sll	$5,$5,8
	or	$3,$3,$9
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	sltu	$5,$3,$7
	beq	$5,$0,$L4439
	and	$5,$3,$10

	bne	$5,$0,$L4311
	li	$5,24			# 0x18

	andi	$9,$3,0xff00
	li	$5,8			# 0x8
	bne	$9,$0,$L4313
	move	$14,$0

$L4443:
	move	$5,$14
$L4314:
	addu	$3,$11,$3
	lbu	$3,0($3)
	addiu	$4,$4,63
	addu	$5,$3,$5
	sll	$5,$5,1
	subu	$4,$4,$5
	sw	$4,8456($16)
$L4310:
	addiu	$6,$6,1
	addiu	$4,$4,1
	slt	$3,$12,$6
	bne	$3,$0,$L4302
	sw	$4,8456($16)

$L4315:
	sra	$5,$4,3
	addu	$5,$2,$5
	lbu	$3,0($5)
	lbu	$14,3($5)
	lbu	$9,1($5)
	sll	$3,$3,24
	lbu	$5,2($5)
	or	$3,$14,$3
	sll	$9,$9,16
	sll	$5,$5,8
	or	$3,$3,$9
	or	$3,$3,$5
	andi	$5,$4,0x7
	sll	$3,$3,$5
	sltu	$5,$3,$7
	bne	$5,$0,$L4303
	and	$5,$3,$10

	srl	$3,$3,23
	addu	$3,$13,$3
	lbu	$3,0($3)
	addu	$4,$3,$4
	b	$L4304
	sw	$4,8456($16)

$L4410:
	lw	$3,8456($16)
	addiu	$6,$3,16
	sra	$5,$3,3
	addu	$5,$2,$5
	sra	$4,$6,3
	lbu	$10,2($5)
	lbu	$11,3($5)
	lbu	$7,0($5)
	lbu	$8,1($5)
	addu	$4,$2,$4
	sw	$6,8456($16)
	lbu	$12,0($4)
	lbu	$9,3($4)
	sll	$5,$7,24
	lbu	$7,1($4)
	or	$11,$11,$5
	sll	$8,$8,16
	lbu	$5,2($4)
	sll	$4,$12,24
	or	$9,$9,$4
	or	$8,$11,$8
	sll	$4,$10,8
	sll	$7,$7,16
	or	$8,$8,$4
	or	$7,$9,$7
	andi	$4,$3,0x7
	sll	$5,$5,8
	sll	$4,$8,$4
	or	$5,$7,$5
	andi	$6,$6,0x7
	sll	$5,$5,$6
	srl	$4,$4,16
	srl	$5,$5,16
	sll	$4,$4,16
	or	$4,$5,$4
	addiu	$3,$3,32
	sw	$3,8456($16)
	sw	$4,104($17)
	lw	$3,8456($16)
	addiu	$6,$3,16
	sra	$5,$3,3
	addu	$5,$2,$5
	sra	$4,$6,3
	lbu	$10,2($5)
	lbu	$11,3($5)
	lbu	$7,0($5)
	lbu	$8,1($5)
	addu	$4,$2,$4
	sw	$6,8456($16)
	lbu	$12,0($4)
	lbu	$9,3($4)
	sll	$5,$7,24
	lbu	$7,1($4)
	or	$11,$11,$5
	sll	$8,$8,16
	lbu	$5,2($4)
	sll	$4,$12,24
	or	$9,$9,$4
	or	$8,$11,$8
	sll	$4,$10,8
	sll	$7,$7,16
	or	$8,$8,$4
	or	$7,$9,$7
	andi	$4,$3,0x7
	sll	$5,$5,8
	sll	$4,$8,$4
	or	$5,$7,$5
	andi	$6,$6,0x7
	sll	$5,$5,$6
	srl	$4,$4,16
	srl	$5,$5,16
	sll	$4,$4,16
	or	$4,$5,$4
	addiu	$3,$3,32
	sw	$3,8456($16)
	sw	$4,108($17)
	lw	$3,8456($16)
	sra	$4,$3,3
	addu	$4,$2,$4
	lbu	$5,0($4)
	andi	$4,$3,0x7
	sll	$4,$5,$4
	andi	$4,$4,0x00ff
	addiu	$3,$3,1
	srl	$4,$4,7
	sw	$3,8456($16)
	b	$L4294
	sw	$4,112($17)

$L4398:
	lw	$3,8456($16)
	addiu	$18,$16,8448
	sra	$4,$3,3
	addu	$2,$2,$4
	lbu	$4,0($2)
	andi	$2,$3,0x7
	sll	$2,$4,$2
	andi	$2,$2,0x00ff
	addiu	$3,$3,1
	srl	$2,$2,7
	sw	$3,8456($16)
	move	$4,$18
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	sw	$2,24($17)

	move	$4,$18
	.option	pic0
	jal	get_se_golomb
	.option	pic2
	sw	$2,28($17)

	sw	$2,32($17)
	.option	pic0
	jal	get_ue_golomb
	.option	pic2
	move	$4,$18

	sltu	$3,$2,256
	beq	$3,$0,$L4440
	lw	$28,72($sp)

	beq	$2,$0,$L4441
	sw	$2,36($17)

	lw	$2,8448($16)
	lw	$13,%got(ff_log2_tab)($28)
	lw	$15,%got(ff_golomb_vlc_len)($28)
	lw	$14,%got(ff_se_golomb_vlc_code)($28)
	move	$6,$17
	move	$5,$0
	li	$11,134217728			# 0x8000000
	b	$L4223
	li	$12,-65536			# 0xffffffffffff0000

$L4215:
	bne	$7,$0,$L4217
	srl	$7,$3,16

	move	$7,$3
	li	$8,8			# 0x8
	move	$10,$0
$L4218:
	andi	$9,$7,0xff00
	bne	$9,$0,$L4219
	nop

	move	$8,$10
$L4220:
	addu	$7,$13,$7
	lbu	$7,0($7)
	addiu	$4,$4,32
	addu	$7,$7,$8
	sll	$7,$7,1
	addiu	$7,$7,-31
	srl	$3,$3,$7
	andi	$8,$3,0x1
	subu	$7,$4,$7
	beq	$8,$0,$L4221
	sw	$7,8456($16)

	srl	$3,$3,1
	subu	$3,$0,$3
$L4216:
	lw	$4,36($17)
	addiu	$5,$5,1
	slt	$4,$5,$4
	sh	$3,116($6)
	beq	$4,$0,$L4212
	addiu	$6,$6,2

$L4223:
	lw	$4,8456($16)
	sra	$3,$4,3
	addu	$3,$2,$3
	lbu	$9,0($3)
	lbu	$8,1($3)
	lbu	$10,3($3)
	lbu	$7,2($3)
	sll	$9,$9,24
	or	$3,$10,$9
	sll	$8,$8,16
	sll	$7,$7,8
	or	$3,$3,$8
	or	$3,$3,$7
	andi	$7,$4,0x7
	sll	$3,$3,$7
	sltu	$7,$3,$11
	bne	$7,$0,$L4215
	and	$7,$3,$12

	srl	$3,$3,23
	addu	$7,$15,$3
	lbu	$7,0($7)
	addu	$3,$14,$3
	addu	$4,$7,$4
	sw	$4,8456($16)
	b	$L4216
	lb	$3,0($3)

$L4221:
	b	$L4216
	srl	$3,$3,1

$L4219:
	b	$L4220
	srl	$7,$7,8

$L4217:
	li	$8,24			# 0x18
	b	$L4218
	li	$10,16			# 0x10

$L4425:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$4,8456($16)
	addu	$3,$5,$3
	b	$L4268
	lbu	$3,0($3)

$L4424:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$4,8456($16)
	addu	$3,$5,$3
	b	$L4262
	lbu	$3,0($3)

$L4423:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$4,8456($16)
	addu	$3,$5,$3
	b	$L4256
	lbu	$3,0($3)

$L4210:
	b	$L4211
	srl	$5,$5,8

$L4190:
	b	$L4191
	srl	$3,$3,8

$L4176:
	b	$L4177
	srl	$5,$5,8

$L4174:
	li	$6,24			# 0x18
	b	$L4175
	li	$8,16			# 0x10

$L4188:
	srl	$3,$3,16
	b	$L4189
	li	$7,16			# 0x10

$L4184:
	b	$L4185
	srl	$3,$3,8

$L4182:
	srl	$3,$3,16
	b	$L4183
	li	$7,16			# 0x10

$L4208:
	li	$6,24			# 0x18
	b	$L4209
	li	$8,16			# 0x10

$L4178:
	b	$L4179
	sw	$4,8456($16)

$L4271:
	b	$L4272
	srl	$5,$5,8

$L4253:
	b	$L4254
	srl	$5,$5,8

$L4251:
	li	$6,24			# 0x18
	b	$L4252
	li	$8,16			# 0x10

$L4259:
	b	$L4260
	srl	$5,$5,8

$L4257:
	li	$6,24			# 0x18
	b	$L4258
	li	$8,16			# 0x10

$L4269:
	li	$6,24			# 0x18
	b	$L4270
	li	$8,16			# 0x10

$L4265:
	b	$L4266
	srl	$5,$5,8

$L4263:
	li	$6,24			# 0x18
	b	$L4264
	li	$8,16			# 0x10

$L4440:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC65)
	addiu	$6,$6,%lo($LC65)
	move	$7,$2
	jalr	$25
	move	$5,$0

$L4390:
	b	$L4168
	li	$2,-1			# 0xffffffffffffffff

$L4298:
	li	$6,24			# 0x18
	b	$L4299
	li	$9,16			# 0x10

$L4341:
	srl	$3,$3,16
	b	$L4342
	li	$7,16			# 0x10

$L4285:
	srl	$4,$4,16
	b	$L4286
	li	$7,16			# 0x10

$L4319:
	li	$6,24			# 0x18
	b	$L4320
	li	$9,16			# 0x10

$L4439:
	srl	$3,$3,23
	addu	$3,$13,$3
	lbu	$3,0($3)
	addu	$4,$3,$4
	b	$L4310
	sw	$4,8456($16)

$L4427:
	srl	$3,$3,23
	addu	$3,$12,$3
	lbu	$3,0($3)
	addu	$4,$3,$4
	b	$L4331
	sw	$4,8456($16)

$L4332:
	srl	$3,$3,16
	andi	$14,$3,0xff00
	beq	$14,$0,$L4442
	li	$15,16			# 0x10

$L4334:
	b	$L4335
	srl	$3,$3,8

$L4328:
	b	$L4329
	srl	$3,$3,8

$L4326:
	srl	$3,$3,16
	b	$L4327
	li	$15,16			# 0x10

$L4311:
	srl	$3,$3,16
	andi	$9,$3,0xff00
	beq	$9,$0,$L4443
	li	$14,16			# 0x10

$L4313:
	b	$L4314
	srl	$3,$3,8

$L4307:
	b	$L4308
	srl	$3,$3,8

$L4305:
	srl	$3,$3,16
	b	$L4306
	li	$14,16			# 0x10

$L4302:
	addiu	$4,$4,20
	b	$L4295
	sw	$4,8456($16)

$L4323:
	addiu	$4,$4,20
	bne	$8,$0,$L4337
	sw	$4,8456($16)

	b	$L4413
	nop

$L4392:
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC62)
	lui	$7,%hi($LC63)
	sw	$20,16($sp)
	addiu	$6,$6,%lo($LC62)
	addiu	$7,$7,%lo($LC63)
	jalr	$25
	move	$5,$0

	b	$L4168
	li	$2,-1			# 0xffffffffffffffff

$L4438:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	addiu	$4,$4,8
	addu	$3,$5,$3
	lbu	$12,0($3)
	b	$L4297
	sw	$4,8456($16)

$L4431:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$3,$5,$3
	lbu	$3,0($3)
	addu	$4,$3,$4
	b	$L4340
	sw	$4,8456($16)

$L4426:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$5,$5,$3
	lbu	$5,0($5)
	addu	$4,$5,$4
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	addiu	$4,$4,8
	addu	$3,$5,$3
	lbu	$11,0($3)
	b	$L4318
	sw	$4,8456($16)

$L4429:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$4,$4,23
	addu	$4,$5,$4
	lbu	$4,0($4)
	addu	$3,$4,$3
	b	$L4284
	sw	$3,8456($16)

$L4430:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$4,$4,23
	addu	$4,$5,$4
	lbu	$4,0($4)
	addu	$3,$4,$3
	b	$L4282
	sw	$3,8456($16)

$L4436:
	lw	$4,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$2,$4,$2
	lbu	$2,0($2)
	addu	$3,$2,$3
	b	$L4370
	sw	$3,8456($16)

$L4435:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$4,$4,23
	addu	$5,$5,$4
	lbu	$5,0($5)
	addu	$3,$5,$3
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$3,8456($16)
	addu	$4,$5,$4
	b	$L4364
	lbu	$7,0($4)

$L4434:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$3,$5,$3
	lbu	$3,0($3)
	addu	$3,$3,$4
	b	$L4358
	sw	$3,8456($16)

$L4433:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$3,$5,$3
	lbu	$3,0($3)
	addu	$4,$3,$4
	b	$L4352
	sw	$4,8456($16)

$L4432:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$3,$3,23
	addu	$3,$5,$3
	lbu	$3,0($3)
	addu	$4,$3,$4
	b	$L4346
	sw	$4,8456($16)

$L4365:
	li	$6,24			# 0x18
	b	$L4366
	li	$8,16			# 0x10

$L4355:
	b	$L4356
	srl	$3,$3,8

$L4353:
	srl	$3,$3,16
	b	$L4354
	li	$7,16			# 0x10

$L4343:
	b	$L4344
	srl	$3,$3,8

$L4349:
	b	$L4350
	srl	$3,$3,8

$L4347:
	srl	$3,$3,16
	b	$L4348
	li	$7,16			# 0x10

$L4321:
	b	$L4322
	srl	$5,$5,8

$L4300:
	b	$L4301
	srl	$5,$5,8

$L4292:
	b	$L4293
	srl	$4,$4,8

$L4290:
	srl	$4,$4,16
	b	$L4291
	li	$7,16			# 0x10

$L4361:
	b	$L4362
	srl	$3,$3,8

$L4359:
	srl	$3,$3,16
	b	$L4360
	li	$7,16			# 0x10

$L4287:
	b	$L4288
	srl	$4,$4,8

$L4367:
	b	$L4368
	srl	$5,$5,8

$L4373:
	b	$L4374
	srl	$2,$2,8

$L4371:
	srl	$2,$2,16
	b	$L4372
	li	$6,16			# 0x10

$L4437:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC72)
	addiu	$6,$6,%lo($LC72)
	jalr	$25
	move	$5,$0

	b	$L4275
	lw	$28,72($sp)

$L4279:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC71)
	addiu	$6,$6,%lo($LC71)
	jalr	$25
	move	$5,$0

	b	$L4275
	lw	$28,72($sp)

$L4399:
	lw	$4,0($16)
	lui	$6,%hi($LC66)
	addiu	$6,$6,%lo($LC66)
	jalr	$25
	move	$5,$0

	b	$L4168
	li	$2,-1			# 0xffffffffffffffff

$L4428:
	addiu	$18,$16,8448
	move	$4,$18
	.option	pic0
	jal	get_bits
	.option	pic2
	li	$5,16			# 0x10

	sw	$2,92($17)
	move	$4,$18
	.option	pic0
	jal	get_bits
	.option	pic2
	li	$5,16			# 0x10

	sw	$2,96($17)
	lw	$28,72($sp)
	b	$L4278
	lw	$2,8448($16)

$L4441:
	b	$L4212
	lw	$2,8448($16)

	.set	macro
	.set	reorder
	.end	decode_seq_parameter_set
	.size	decode_seq_parameter_set, .-decode_seq_parameter_set
	.align	2
	.set	nomips16
	.ent	mc_part
	.type	mc_part, @function
mc_part:
	.frame	$sp,192,$31		# vars= 88, regs= 10/0, args= 56, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-192
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,188($sp)
	sw	$fp,184($sp)
	sw	$23,180($sp)
	sw	$22,176($sp)
	sw	$21,172($sp)
	sw	$20,168($sp)
	sw	$19,164($sp)
	sw	$18,160($sp)
	sw	$17,156($sp)
	sw	$16,152($sp)
	.cprestore	56
	li	$2,65536			# 0x10000
	addu	$2,$4,$2
	lw	$9,-6196($2)
	li	$2,2			# 0x2
	move	$16,$4
	move	$8,$5
	move	$20,$6
	move	$19,$7
	lw	$22,208($sp)
	lw	$25,212($sp)
	lw	$5,216($sp)
	lw	$24,220($sp)
	lw	$15,224($sp)
	lw	$14,228($sp)
	lw	$18,232($sp)
	lw	$17,236($sp)
	lw	$6,240($sp)
	lw	$7,244($sp)
	lw	$13,248($sp)
	lw	$12,252($sp)
	lw	$4,256($sp)
	beq	$9,$2,$L4479
	lw	$21,260($sp)

	li	$2,1			# 0x1
	beq	$9,$2,$L4480
	lui	$2,%hi(scan8)

	li	$10,65536			# 0x10000
$L4493:
	addu	$2,$16,$10
$L4496:
	lw	$3,-6268($2)
	lw	$23,9756($16)
	lw	$9,9760($16)
	lw	$2,6172($16)
	sltu	$3,$0,$3
	sra	$3,$2,$3
	mul	$11,$14,$23
	mul	$2,$14,$9
	lw	$fp,6168($16)
	addu	$9,$2,$15
	addu	$23,$11,$15
	sll	$23,$23,1
	sll	$fp,$fp,3
	sll	$3,$3,3
	addu	$24,$24,$9
	addu	$5,$5,$9
	addu	$23,$25,$23
	sw	$24,64($sp)
	addu	$fp,$15,$fp
	addu	$3,$14,$3
	bne	$4,$0,$L4481
	sw	$5,68($sp)

	bne	$21,$0,$L4482
	lui	$2,%hi(scan8)

$L4476:
	lw	$31,188($sp)
$L4495:
	lw	$fp,184($sp)
	lw	$23,180($sp)
	lw	$22,176($sp)
	lw	$21,172($sp)
	lw	$20,168($sp)
	lw	$19,164($sp)
	lw	$18,160($sp)
	lw	$17,156($sp)
	lw	$16,152($sp)
	j	$31
	addiu	$sp,$sp,192

$L4482:
$L4494:
	addiu	$2,$2,%lo(scan8)
	addu	$8,$8,$2
	lbu	$2,0($8)
	li	$4,65536			# 0x10000
	addu	$12,$16,$2
	sw	$12,84($sp)
	lb	$6,9496($12)
	ori	$7,$4,0x7e40
	sll	$5,$6,5
	sll	$6,$6,3
	subu	$5,$5,$6
	sll	$6,$5,4
	addu	$5,$5,$6
	addiu	$5,$5,19584
	addu	$6,$16,$7
	addu	$5,$6,$5
	sw	$5,76($sp)
	lw	$13,76($sp)
	addiu	$5,$2,2324
	sll	$5,$5,2
	sll	$2,$2,2
	lw	$7,0($13)
	addu	$5,$16,$5
	addu	$4,$16,$4
	addu	$2,$16,$2
	lh	$11,0($5)
	lw	$9,-6268($4)
	lh	$2,9298($2)
	lw	$6,9756($16)
	lw	$4,9764($16)
	lw	$5,9768($16)
	lw	$8,144($16)
	beq	$7,$0,$L4476
	lw	$10,148($16)

	sll	$3,$3,3
	addu	$21,$3,$2
	sra	$3,$21,2
	mul	$12,$3,$6
	sll	$fp,$fp,3
	addu	$fp,$fp,$11
	andi	$14,$fp,0x7
	addiu	$2,$4,-3
	andi	$13,$21,0x7
	movn	$4,$2,$14
	sra	$11,$fp,2
	sw	$13,72($sp)
	addu	$2,$12,$11
	sw	$14,80($sp)
	subu	$12,$0,$4
	sll	$10,$10,4
	sltu	$9,$0,$9
	lw	$14,72($sp)
	addiu	$13,$5,-3
	sra	$9,$10,$9
	sll	$8,$8,4
	slt	$12,$11,$12
	movn	$5,$13,$14
	addu	$2,$7,$2
	sw	$9,88($sp)
	bne	$12,$0,$L4467
	sw	$8,92($sp)

	subu	$7,$0,$5
	slt	$7,$3,$7
	bne	$7,$0,$L4467
	nop

	addu	$4,$4,$8
	addiu	$7,$11,15
	slt	$4,$7,$4
	bne	$4,$0,$L4483
	addu	$5,$5,$9

$L4467:
	nor	$5,$0,$6
$L4497:
	lw	$15,92($sp)
	lw	$31,88($sp)
	sll	$5,$5,1
	lw	$4,2040($16)
	addiu	$7,$11,-2
	addiu	$3,$3,-2
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	addu	$5,$2,$5
	li	$2,21			# 0x15
	sw	$2,16($sp)
	sw	$7,20($sp)
	sw	$3,24($sp)
	sw	$15,28($sp)
	sw	$31,32($sp)
	jalr	$25
	li	$7,21			# 0x15

	lw	$6,9756($16)
	lw	$3,2040($16)
	addiu	$2,$6,1
	sll	$2,$2,1
	addu	$2,$3,$2
	li	$3,1			# 0x1
	sw	$3,96($sp)
$L4468:
	andi	$3,$21,0x3
	andi	$4,$fp,0x3
	sll	$3,$3,2
	addu	$3,$3,$4
	sll	$3,$3,2
	addu	$18,$18,$3
	lw	$25,0($18)
	move	$5,$2
	sw	$2,140($sp)
	jalr	$25
	move	$4,$23

	lw	$28,56($sp)
	beq	$20,$0,$L4484
	lw	$2,140($sp)

$L4469:
	lw	$2,56($16)
	andi	$2,$2,0x2000
	bne	$2,$0,$L4476
	li	$2,65536			# 0x10000

	addu	$2,$16,$2
	lw	$2,-6268($2)
	bne	$2,$0,$L4470
	lw	$4,84($sp)

	sra	$18,$21,3
$L4471:
	lw	$6,9760($16)
	lw	$8,76($sp)
	mul	$3,$18,$6
	sra	$fp,$fp,3
	lw	$20,8($8)
	lw	$5,4($8)
	lw	$4,96($sp)
	addu	$2,$3,$fp
	addu	$20,$20,$2
	bne	$4,$0,$L4485
	addu	$5,$5,$2

	lw	$fp,80($sp)
	lw	$31,72($sp)
	lw	$4,68($sp)
	sw	$fp,16($sp)
	sw	$31,20($sp)
	move	$25,$17
	jalr	$25
	move	$7,$19

	lw	$28,56($sp)
$L4475:
	lw	$fp,80($sp)
	lw	$2,72($sp)
	lw	$6,9760($16)
	lw	$4,64($sp)
	sw	$fp,208($sp)
	sw	$2,212($sp)
	move	$5,$20
	move	$7,$19
	move	$25,$17
	lw	$31,188($sp)
	lw	$fp,184($sp)
	lw	$23,180($sp)
	lw	$22,176($sp)
	lw	$21,172($sp)
	lw	$20,168($sp)
	lw	$19,164($sp)
	lw	$18,160($sp)
	lw	$17,156($sp)
	lw	$16,152($sp)
	jr	$25
	addiu	$sp,$sp,192

$L4480:
	addiu	$2,$2,%lo(scan8)
	addu	$2,$8,$2
	lbu	$23,0($2)
$L4447:
	lw	$6,9756($16)
	li	$10,65536			# 0x10000
	mul	$fp,$14,$6
	lw	$11,9760($16)
	addu	$9,$16,$10
	addu	$2,$fp,$15
	lw	$7,-6268($9)
	mul	$fp,$14,$11
	sll	$2,$2,1
	lw	$3,6172($16)
	sw	$2,64($sp)
	sltu	$7,$0,$7
	lw	$2,6168($16)
	sra	$3,$3,$7
	addu	$31,$fp,$15
	sll	$3,$3,3
	sll	$fp,$2,3
	lw	$2,64($sp)
	addu	$fp,$15,$fp
	addu	$3,$14,$3
	lw	$15,12($12)
	lw	$14,12($13)
	lw	$13,0($13)
	addu	$25,$25,$2
	addu	$24,$24,$31
	addu	$5,$5,$31
	sw	$25,68($sp)
	sw	$24,84($sp)
	sw	$14,116($sp)
	sw	$15,92($sp)
	sw	$5,88($sp)
	sw	$13,100($sp)
	beq	$4,$0,$L4448
	lw	$2,0($12)

	bne	$21,$0,$L4486
	sll	$11,$11,3

$L4448:
	sltu	$21,$0,$21
	sll	$31,$21,3
	sll	$2,$21,5
	sw	$2,96($sp)
	addu	$2,$31,$2
	addu	$4,$16,$2
	sw	$31,92($sp)
	addu	$4,$4,$23
	lb	$4,9456($4)
	sll	$8,$21,7
	sll	$9,$4,5
	sll	$5,$4,3
	sw	$4,64($sp)
	sll	$4,$21,10
	subu	$5,$9,$5
	addu	$4,$8,$4
	sll	$9,$5,4
	sll	$8,$4,4
	addu	$5,$5,$9
	addu	$4,$4,$8
	addu	$4,$5,$4
	li	$5,65536			# 0x10000
	ori	$5,$5,0x7e40
	addu	$5,$16,$5
	addu	$4,$5,$4
	sw	$4,76($sp)
	addu	$2,$2,$23
	lw	$5,76($sp)
	addiu	$4,$2,2284
	sll	$4,$4,2
	sll	$2,$2,2
	lw	$10,0($5)
	addu	$4,$16,$4
	addu	$2,$16,$2
	lh	$9,0($4)
	lh	$8,9138($2)
	lw	$4,9764($16)
	lw	$5,9768($16)
	lw	$11,144($16)
	beq	$10,$0,$L4450
	lw	$13,148($16)

	sll	$2,$3,3
	addu	$2,$2,$8
	sll	$fp,$fp,3
	addu	$fp,$fp,$9
	sra	$9,$2,2
	mul	$12,$9,$6
	andi	$8,$fp,0x7
	addiu	$3,$4,-3
	andi	$14,$2,0x7
	movn	$4,$3,$8
	sw	$14,72($sp)
	sw	$8,80($sp)
	sra	$8,$fp,2
	addu	$3,$12,$8
	sll	$13,$13,4
	subu	$12,$0,$4
	lw	$15,72($sp)
	addiu	$14,$5,-3
	sra	$13,$13,$7
	sll	$11,$11,4
	slt	$12,$8,$12
	movn	$5,$14,$15
	addu	$3,$10,$3
	sw	$13,104($sp)
	bne	$12,$0,$L4453
	sw	$11,108($sp)

	subu	$7,$0,$5
	slt	$7,$9,$7
	bne	$7,$0,$L4453
	addu	$7,$4,$11

	addiu	$4,$8,15
	slt	$4,$4,$7
	bne	$4,$0,$L4487
	addu	$4,$5,$13

$L4453:
	nor	$5,$0,$6
$L4498:
	sll	$5,$5,1
	addu	$5,$3,$5
	li	$3,21			# 0x15
	lw	$4,2040($16)
	lw	$31,108($sp)
	sw	$3,16($sp)
	lw	$3,104($sp)
	addiu	$8,$8,-2
	addiu	$9,$9,-2
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	sw	$3,32($sp)
	sw	$2,140($sp)
	sw	$8,20($sp)
	sw	$9,24($sp)
	sw	$31,28($sp)
	jalr	$25
	li	$7,21			# 0x15

	lw	$6,9756($16)
	lw	$4,2040($16)
	addiu	$3,$6,1
	sll	$3,$3,1
	addu	$3,$4,$3
	lw	$2,140($sp)
	li	$4,1			# 0x1
	sw	$4,112($sp)
$L4454:
	andi	$4,$2,0x3
	andi	$5,$fp,0x3
	sll	$4,$4,2
	addu	$4,$4,$5
	sll	$4,$4,2
	addu	$18,$18,$4
	lw	$25,0($18)
	lw	$4,68($sp)
	move	$5,$3
	sw	$2,140($sp)
	jalr	$25
	sw	$3,136($sp)

	lw	$28,56($sp)
	lw	$2,140($sp)
	beq	$20,$0,$L4488
	lw	$3,136($sp)

$L4455:
	lw	$3,56($16)
	andi	$3,$3,0x2000
	bne	$3,$0,$L4477
	li	$3,65536			# 0x10000

	addu	$3,$16,$3
	lw	$3,-6268($3)
	bne	$3,$0,$L4457
	lw	$8,92($sp)

	sra	$18,$2,3
$L4458:
	lw	$6,9760($16)
	lw	$14,76($sp)
	mul	$3,$18,$6
	sra	$fp,$fp,3
	lw	$20,8($14)
	lw	$5,4($14)
	lw	$4,112($sp)
	addu	$2,$3,$fp
	addu	$20,$20,$2
	bne	$4,$0,$L4489
	addu	$5,$5,$2

	lw	$fp,80($sp)
	lw	$31,72($sp)
	lw	$4,88($sp)
	sw	$fp,16($sp)
	sw	$31,20($sp)
	move	$25,$17
	jalr	$25
	move	$7,$19

$L4462:
	lw	$fp,80($sp)
	lw	$31,72($sp)
	lw	$6,9760($16)
	lw	$4,84($sp)
	sw	$fp,16($sp)
	sw	$31,20($sp)
	move	$5,$20
	move	$25,$17
	jalr	$25
	move	$7,$19

$L4477:
	lw	$6,9756($16)
$L4450:
	sll	$2,$21,6
	lw	$fp,64($sp)
	sll	$21,$21,4
	subu	$21,$2,$21
	addu	$21,$21,$fp
	addiu	$3,$21,14838
	addiu	$2,$21,14934
	sll	$3,$3,2
	sll	$2,$2,2
	li	$18,65536			# 0x10000
	addu	$3,$16,$3
	addu	$2,$16,$2
	addu	$17,$16,$18
	lw	$7,4($3)
	lw	$3,4($2)
	lw	$2,-6188($17)
	lw	$4,68($sp)
	lw	$25,100($sp)
	move	$5,$6
	sw	$3,16($sp)
	jalr	$25
	move	$6,$2

	lw	$2,-6192($17)
	beq	$2,$0,$L4495
	lw	$31,188($sp)

	addiu	$2,$21,7611
	addiu	$3,$21,7515
	sll	$2,$2,3
	addu	$2,$16,$2
	sll	$3,$3,3
	addu	$3,$16,$3
	lw	$2,4($2)
	sll	$21,$21,3
	lw	$5,9760($16)
	lw	$6,-6184($17)
	lw	$7,4($3)
	lw	$4,88($sp)
	lw	$25,116($sp)
	addu	$21,$16,$21
	addu	$18,$18,$21
	jalr	$25
	sw	$2,16($sp)

	lw	$2,-4640($18)
	lw	$6,-6184($17)
	lw	$7,-5408($18)
	lw	$5,9760($16)
	lw	$28,56($sp)
	lw	$4,84($sp)
	lw	$25,116($sp)
	sw	$2,208($sp)
	lw	$31,188($sp)
	lw	$fp,184($sp)
	lw	$23,180($sp)
	lw	$22,176($sp)
	lw	$21,172($sp)
	lw	$20,168($sp)
	lw	$19,164($sp)
	lw	$18,160($sp)
	lw	$17,156($sp)
	lw	$16,152($sp)
	jr	$25
	addiu	$sp,$sp,192

$L4479:
	beq	$4,$0,$L4493
	li	$10,65536			# 0x10000

	beq	$21,$0,$L4496
	addu	$2,$16,$10

	lui	$2,%hi(scan8)
	addiu	$2,$2,%lo(scan8)
	addu	$2,$8,$2
	lbu	$23,0($2)
	addu	$3,$16,$23
	lb	$2,9456($3)
	lb	$3,9496($3)
	sll	$9,$2,6
	sll	$2,$2,4
	subu	$2,$9,$2
	addu	$2,$2,$3
	addiu	$2,$2,15414
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$3,4($2)
	li	$2,32			# 0x20
	bne	$3,$2,$L4447
	nop

	b	$L4496
	addu	$2,$16,$10

$L4481:
	lui	$2,%hi(scan8)
	addiu	$2,$2,%lo(scan8)
	addu	$2,$8,$2
	lbu	$2,0($2)
	ori	$10,$10,0x7e40
	addu	$2,$16,$2
	lb	$4,9456($2)
	addu	$5,$16,$10
	sll	$2,$4,5
	sll	$4,$4,3
	subu	$2,$2,$4
	sll	$4,$2,4
	addu	$2,$2,$4
	lw	$10,68($sp)
	sw	$18,48($sp)
	sw	$17,52($sp)
	addu	$5,$5,$2
	move	$17,$7
	move	$18,$6
	move	$4,$16
	move	$6,$8
	move	$7,$20
	sw	$3,44($sp)
	sw	$3,136($sp)
	sw	$8,132($sp)
	sw	$19,16($sp)
	sw	$22,20($sp)
	sw	$0,24($sp)
	sw	$23,28($sp)
	sw	$10,32($sp)
	sw	$24,36($sp)
	.option	pic0
	jal	mc_dir_part
	.option	pic2
	sw	$fp,40($sp)

	lw	$28,56($sp)
	lw	$8,132($sp)
	beq	$21,$0,$L4476
	lw	$3,136($sp)

	b	$L4494
	lui	$2,%hi(scan8)

$L4484:
	lw	$25,0($18)
	lw	$6,9756($16)
	addu	$5,$2,$22
	jalr	$25
	addu	$4,$23,$22

	b	$L4469
	lw	$28,56($sp)

$L4488:
	lw	$7,68($sp)
	lw	$25,0($18)
	lw	$6,9756($16)
	addu	$5,$3,$22
	jalr	$25
	addu	$4,$7,$22

	lw	$28,56($sp)
	b	$L4455
	lw	$2,140($sp)

$L4486:
	addu	$23,$16,$23
	lb	$21,9456($23)
	lw	$31,2048($16)
	sll	$25,$21,3
	sll	$4,$21,5
	subu	$4,$4,$25
	ori	$12,$10,0x7e40
	addu	$11,$31,$11
	sw	$25,76($sp)
	sll	$5,$4,4
	lb	$23,9496($23)
	addu	$12,$16,$12
	lw	$13,88($sp)
	addu	$4,$4,$5
	sw	$11,72($sp)
	lw	$11,68($sp)
	addu	$5,$12,$4
	move	$6,$8
	move	$7,$20
	move	$4,$16
	sw	$2,140($sp)
	sw	$9,128($sp)
	sw	$10,124($sp)
	sw	$31,64($sp)
	sw	$11,28($sp)
	sw	$13,32($sp)
	sw	$24,36($sp)
	sw	$fp,40($sp)
	sw	$3,44($sp)
	sw	$3,136($sp)
	sw	$8,132($sp)
	sw	$12,120($sp)
	sw	$19,16($sp)
	sw	$22,20($sp)
	sw	$0,24($sp)
	sw	$18,48($sp)
	.option	pic0
	jal	mc_dir_part
	.option	pic2
	sw	$17,52($sp)

	sll	$15,$23,3
	sll	$4,$23,5
	subu	$4,$4,$15
	sll	$5,$4,4
	lw	$8,132($sp)
	lw	$25,64($sp)
	addu	$4,$4,$5
	lw	$12,120($sp)
	lw	$3,136($sp)
	addiu	$5,$4,19584
	sw	$fp,40($sp)
	lw	$fp,72($sp)
	move	$6,$8
	move	$7,$20
	move	$4,$16
	addiu	$20,$25,8
	li	$8,1			# 0x1
	addu	$5,$12,$5
	sw	$3,44($sp)
	sw	$15,80($sp)
	sw	$19,16($sp)
	sw	$22,20($sp)
	sw	$8,24($sp)
	sw	$18,48($sp)
	sw	$17,52($sp)
	sw	$fp,28($sp)
	sw	$25,32($sp)
	.option	pic0
	jal	mc_dir_part
	.option	pic2
	sw	$20,36($sp)

	lw	$9,128($sp)
	li	$3,2			# 0x2
	lw	$4,-6196($9)
	lw	$2,140($sp)
	beq	$4,$3,$L4490
	lw	$10,124($sp)

	addiu	$6,$23,14982
	addiu	$3,$21,14934
	addiu	$5,$21,14838
	addiu	$4,$23,14886
	sll	$6,$6,2
	sll	$3,$3,2
	sll	$5,$5,2
	sll	$4,$4,2
	addu	$6,$16,$6
	addu	$3,$16,$3
	addu	$5,$16,$5
	addu	$4,$16,$4
	lw	$8,4($6)
	lw	$3,4($3)
	lw	$5,4($5)
	lw	$4,4($4)
	lw	$7,-6188($9)
	lw	$6,9756($16)
	addu	$3,$8,$3
	sw	$5,16($sp)
	sw	$4,20($sp)
	lw	$5,72($sp)
	lw	$4,68($sp)
	sw	$10,124($sp)
	move	$25,$2
	sw	$3,24($sp)
	jalr	$25
	sw	$9,128($sp)

	addiu	$3,$23,7659
	addiu	$2,$21,7611
	addiu	$21,$21,7515
	sll	$3,$3,3
	sll	$2,$2,3
	addiu	$23,$23,7563
	sll	$21,$21,3
	addu	$3,$16,$3
	sll	$23,$23,3
	addu	$2,$16,$2
	addu	$21,$16,$21
	lw	$5,4($3)
	lw	$2,4($2)
	lw	$4,4($21)
	lw	$9,128($sp)
	addu	$23,$16,$23
	lw	$3,4($23)
	lw	$7,-6184($9)
	lw	$6,9760($16)
	addu	$2,$5,$2
	sw	$4,16($sp)
	lw	$5,64($sp)
	lw	$4,88($sp)
	lw	$25,92($sp)
	sw	$3,20($sp)
	jalr	$25
	sw	$2,24($sp)

	lw	$fp,76($sp)
	lw	$10,124($sp)
	addu	$2,$16,$fp
	addu	$2,$10,$2
	lw	$5,80($sp)
	lw	$4,-5408($2)
	addu	$3,$16,$5
	sw	$4,208($sp)
	addu	$10,$10,$3
	lw	$3,-5024($10)
	lw	$9,128($sp)
	lw	$28,56($sp)
	lw	$7,-6184($9)
	sw	$3,212($sp)
	lw	$3,-4256($10)
	lw	$2,-4640($2)
	lw	$4,84($sp)
	addu	$2,$3,$2
	lw	$6,9760($16)
	move	$5,$20
	sw	$2,216($sp)
$L4478:
	lw	$25,92($sp)
	lw	$31,188($sp)
	lw	$fp,184($sp)
	lw	$23,180($sp)
	lw	$22,176($sp)
	lw	$21,172($sp)
	lw	$20,168($sp)
	lw	$19,164($sp)
	lw	$18,160($sp)
	lw	$17,156($sp)
	lw	$16,152($sp)
	jr	$25
	addiu	$sp,$sp,192

$L4470:
	lw	$2,6172($16)
	lbu	$3,9496($4)
	andi	$2,$2,0x1
	andi	$3,$3,0x1
	subu	$2,$2,$3
	sll	$2,$2,1
	addu	$21,$21,$2
	sra	$18,$21,3
	bltz	$18,$L4491
	lw	$6,88($sp)

	addiu	$3,$18,8
	sra	$2,$6,1
	lw	$7,96($sp)
	slt	$2,$3,$2
	xori	$2,$2,0x1
	or	$7,$7,$2
	andi	$21,$21,0x7
	sw	$7,96($sp)
	b	$L4471
	sw	$21,72($sp)

$L4457:
	lw	$10,96($sp)
	addu	$3,$8,$10
	addu	$3,$16,$3
	addu	$23,$3,$23
	lbu	$4,9456($23)
	lw	$3,6172($16)
	andi	$4,$4,0x1
	andi	$3,$3,0x1
	subu	$3,$3,$4
	sll	$3,$3,1
	addu	$2,$3,$2
	sra	$18,$2,3
	bltz	$18,$L4492
	lw	$12,104($sp)

	addiu	$4,$18,8
	sra	$3,$12,1
	lw	$13,112($sp)
	slt	$3,$4,$3
	xori	$3,$3,0x1
	or	$13,$13,$3
	andi	$2,$2,0x7
	sw	$13,112($sp)
	b	$L4458
	sw	$2,72($sp)

$L4483:
	addiu	$4,$3,15
	slt	$5,$4,$5
	beq	$5,$0,$L4497
	nor	$5,$0,$6

	b	$L4468
	sw	$0,96($sp)

$L4487:
	addiu	$5,$9,15
	slt	$5,$5,$4
	beq	$5,$0,$L4498
	nor	$5,$0,$6

	b	$L4454
	sw	$0,112($sp)

$L4490:
	sll	$3,$21,6
	sll	$21,$21,4
	subu	$3,$3,$21
	addu	$3,$3,$23
	addiu	$3,$3,15414
	sll	$3,$3,2
	addu	$3,$16,$3
	lw	$17,4($3)
	li	$18,64			# 0x40
	lw	$6,9756($16)
	subu	$18,$18,$17
	lw	$4,68($sp)
	lw	$5,72($sp)
	move	$25,$2
	li	$7,5			# 0x5
	sw	$17,16($sp)
	sw	$18,20($sp)
	jalr	$25
	sw	$0,24($sp)

	lw	$6,9760($16)
	lw	$4,88($sp)
	lw	$5,64($sp)
	lw	$25,92($sp)
	li	$7,5			# 0x5
	sw	$17,16($sp)
	sw	$18,20($sp)
	jalr	$25
	sw	$0,24($sp)

	lw	$6,9760($16)
	lw	$28,56($sp)
	sw	$17,208($sp)
	sw	$18,212($sp)
	sw	$0,216($sp)
	lw	$4,84($sp)
	move	$5,$20
	b	$L4478
	li	$7,5			# 0x5

$L4485:
	lw	$8,88($sp)
	lw	$7,92($sp)
	lw	$4,2040($16)
	sra	$21,$8,1
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	sra	$22,$7,1
	li	$23,9			# 0x9
	li	$7,9			# 0x9
	sw	$23,16($sp)
	sw	$fp,20($sp)
	sw	$18,24($sp)
	sw	$22,28($sp)
	jalr	$25
	sw	$21,32($sp)

	lw	$10,80($sp)
	lw	$11,72($sp)
	lw	$5,2040($16)
	lw	$6,9760($16)
	lw	$4,68($sp)
	sw	$10,16($sp)
	sw	$11,20($sp)
	move	$25,$17
	jalr	$25
	move	$7,$19

	lw	$28,56($sp)
	lw	$4,2040($16)
	lw	$6,9760($16)
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	move	$5,$20
	sw	$23,16($sp)
	sw	$fp,20($sp)
	sw	$18,24($sp)
	sw	$22,28($sp)
	sw	$21,32($sp)
	jalr	$25
	li	$7,9			# 0x9

	lw	$28,56($sp)
	b	$L4475
	lw	$20,2040($16)

$L4489:
	lw	$8,104($sp)
	lw	$7,108($sp)
	lw	$4,2040($16)
	sra	$2,$8,1
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	sra	$23,$7,1
	li	$22,9			# 0x9
	sw	$2,32($sp)
	sw	$2,140($sp)
	li	$7,9			# 0x9
	sw	$22,16($sp)
	sw	$fp,20($sp)
	sw	$18,24($sp)
	jalr	$25
	sw	$23,28($sp)

	lw	$10,80($sp)
	lw	$11,72($sp)
	lw	$5,2040($16)
	lw	$6,9760($16)
	lw	$4,88($sp)
	sw	$10,16($sp)
	sw	$11,20($sp)
	move	$25,$17
	jalr	$25
	move	$7,$19

	lw	$28,56($sp)
	lw	$2,140($sp)
	lw	$4,2040($16)
	lw	$6,9760($16)
	lw	$25,%call16(ff_emulated_edge_mc)($28)
	move	$5,$20
	sw	$22,16($sp)
	sw	$fp,20($sp)
	sw	$18,24($sp)
	sw	$23,28($sp)
	sw	$2,32($sp)
	jalr	$25
	li	$7,9			# 0x9

	b	$L4462
	lw	$20,2040($16)

$L4491:
	li	$5,1			# 0x1
	andi	$21,$21,0x7
	sw	$5,96($sp)
	b	$L4471
	sw	$21,72($sp)

$L4492:
	li	$11,1			# 0x1
	andi	$2,$2,0x7
	sw	$11,112($sp)
	b	$L4458
	sw	$2,72($sp)

	.set	macro
	.set	reorder
	.end	mc_part
	.size	mc_part, .-mc_part
	.align	2
	.set	nomips16
	.ent	hl_motion
	.type	hl_motion, @function
hl_motion:
	.frame	$sp,216,$31		# vars= 96, regs= 10/0, args= 72, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-216
	sw	$16,176($sp)
	move	$16,$4
	lw	$2,152($16)
	lw	$9,6172($16)
	lw	$4,6168($4)
	mul	$8,$9,$2
	lw	$3,1568($16)
	addu	$2,$8,$4
	sll	$2,$2,2
	sw	$fp,208($sp)
	sw	$23,204($sp)
	sw	$22,200($sp)
	sw	$21,196($sp)
	sw	$20,192($sp)
	sw	$19,188($sp)
	sw	$18,184($sp)
	sw	$17,180($sp)
	addu	$2,$3,$2
	sw	$31,212($sp)
	lb	$8,9468($16)
	lw	$21,0($2)
	lw	$10,236($sp)
	lw	$2,244($sp)
	move	$18,$5
	move	$19,$6
	move	$20,$7
	lw	$22,232($sp)
	sw	$10,108($sp)
	lw	$17,240($sp)
	sw	$2,112($sp)
	lw	$23,248($sp)
	bltz	$8,$L4500
	lw	$fp,252($sp)

	lh	$3,9186($16)
	sll	$7,$4,4
	sll	$9,$9,4
	sra	$3,$3,2
	andi	$4,$4,0x3
	addu	$3,$3,$9
	sll	$2,$8,5
	lw	$9,9756($16)
	sll	$8,$8,3
	sll	$4,$4,2
	addu	$4,$3,$4
	subu	$8,$2,$8
	lh	$2,9184($16)
	mul	$10,$4,$9
	sll	$5,$8,4
	addu	$8,$8,$5
	sra	$2,$2,2
	addiu	$7,$7,8
	addu	$7,$7,$2
	addu	$5,$16,$8
	li	$2,65536			# 0x10000
	addiu	$6,$7,64
	addu	$5,$2,$5
	ori	$2,$2,0x7e40
	addu	$4,$10,$6
	addu	$2,$8,$2
	lw	$6,32320($5)
	addu	$2,$16,$2
	lw	$5,176($16)
	lw	$25,5148($16)
	addu	$4,$6,$4
	sw	$2,172($sp)
	li	$6,4			# 0x4
	sw	$3,168($sp)
	jalr	$25
	sw	$7,164($sp)

	lw	$4,6168($16)
	lw	$3,168($sp)
	lw	$5,180($16)
	sra	$3,$3,1
	andi	$4,$4,0x7
	addu	$4,$3,$4
	mul	$3,$4,$5
	lw	$7,164($sp)
	lw	$2,172($sp)
	sra	$7,$7,1
	lw	$5,8($2)
	addiu	$7,$7,64
	lw	$2,4($2)
	addu	$4,$3,$7
	lw	$25,5148($16)
	subu	$5,$5,$2
	addu	$4,$2,$4
	jalr	$25
	li	$6,2			# 0x2

$L4500:
	andi	$2,$21,0x8
	bne	$2,$0,$L4513
	andi	$2,$21,0x10

	bne	$2,$0,$L4514
	andi	$2,$21,0x20

	bne	$2,$0,$L4515
	lw	$10,112($sp)

	addiu	$3,$17,128
	addiu	$10,$10,8
	sw	$3,84($sp)
	lw	$9,108($sp)
	addiu	$3,$23,20
	sw	$10,96($sp)
	sw	$3,148($sp)
	lw	$10,108($sp)
	lw	$3,112($sp)
	addiu	$2,$22,128
	addiu	$4,$23,12
	addiu	$8,$fp,12
	addiu	$9,$9,8
	addiu	$22,$22,64
	addiu	$17,$17,64
	sw	$2,88($sp)
	li	$21,59272			# 0xe788
	sw	$4,156($sp)
	sw	$8,160($sp)
	addiu	$4,$fp,20
	addiu	$8,$23,24
	li	$2,1			# 0x1
	sw	$9,92($sp)
	addiu	$10,$10,4
	addiu	$9,$fp,24
	addiu	$3,$3,4
	addiu	$23,$23,16
	addiu	$fp,$fp,16
	sw	$22,144($sp)
	sw	$17,140($sp)
	sw	$20,80($sp)
	addu	$21,$16,$21
	move	$20,$19
	li	$22,2			# 0x2
	move	$19,$18
	move	$17,$0
	sw	$4,152($sp)
	sw	$8,116($sp)
	sw	$9,120($sp)
	sw	$10,124($sp)
	sw	$3,128($sp)
	sw	$23,132($sp)
	sw	$fp,136($sp)
	move	$18,$2
$L4509:
	lw	$3,0($21)
	andi	$fp,$17,0x1
	andi	$23,$17,0x2
	andi	$2,$3,0x8
	sll	$fp,$fp,2
	sll	$23,$23,1
	bne	$2,$0,$L4516
	sll	$5,$17,2

	andi	$2,$3,0x10
	bne	$2,$0,$L4517
	andi	$2,$3,0x20

	bne	$2,$0,$L4508
	lw	$9,96($sp)

	lw	$4,92($sp)
	lw	$2,0($9)
	andi	$10,$3,0x4000
	andi	$3,$3,0x1000
	lw	$8,0($4)
	sw	$3,104($sp)
	sw	$2,52($sp)
	lw	$3,88($sp)
	lw	$2,80($sp)
	sw	$10,100($sp)
	lw	$9,116($sp)
	lw	$10,120($sp)
	sw	$8,44($sp)
	sw	$2,28($sp)
	lw	$8,84($sp)
	lw	$2,104($sp)
	sw	$3,40($sp)
	lw	$3,100($sp)
	move	$4,$16
	li	$6,1			# 0x1
	li	$7,2			# 0x2
	sw	$23,36($sp)
	sw	$8,48($sp)
	sw	$9,56($sp)
	sw	$10,60($sp)
	sw	$2,64($sp)
	sw	$3,68($sp)
	sw	$0,16($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$fp,32($sp)

	lw	$4,92($sp)
	lw	$9,96($sp)
	lw	$8,0($4)
	lw	$3,0($9)
	lw	$10,80($sp)
	sw	$8,44($sp)
	sw	$3,52($sp)
	lw	$8,84($sp)
	lw	$3,88($sp)
	lw	$9,116($sp)
	sw	$10,28($sp)
	sw	$3,40($sp)
	lw	$10,120($sp)
	lw	$3,104($sp)
	sw	$8,48($sp)
	lw	$8,100($sp)
	addiu	$2,$fp,2
	move	$4,$16
	move	$5,$18
	li	$6,1			# 0x1
	li	$7,2			# 0x2
	sw	$2,32($sp)
	sw	$2,172($sp)
	sw	$23,36($sp)
	sw	$9,56($sp)
	sw	$10,60($sp)
	sw	$3,64($sp)
	sw	$8,68($sp)
	sw	$0,16($sp)
	sw	$19,20($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$20,24($sp)

	lw	$9,92($sp)
	lw	$10,96($sp)
	lw	$3,0($9)
	lw	$8,0($10)
	lw	$9,84($sp)
	sw	$3,44($sp)
	sw	$8,52($sp)
	lw	$3,80($sp)
	lw	$8,88($sp)
	lw	$10,116($sp)
	sw	$3,28($sp)
	sw	$8,40($sp)
	lw	$3,120($sp)
	lw	$8,104($sp)
	sw	$9,48($sp)
	lw	$9,100($sp)
	addiu	$23,$23,2
	move	$4,$16
	move	$5,$22
	li	$6,1			# 0x1
	li	$7,2			# 0x2
	sw	$10,56($sp)
	sw	$3,60($sp)
	sw	$8,64($sp)
	sw	$9,68($sp)
	sw	$fp,32($sp)
	sw	$0,16($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$23,36($sp)

	lw	$10,92($sp)
	lw	$4,96($sp)
	lw	$8,0($10)
	lw	$3,0($4)
	lw	$2,172($sp)
	lw	$9,100($sp)
	sw	$8,44($sp)
	lw	$8,104($sp)
	sw	$2,32($sp)
	sw	$3,52($sp)
	sw	$8,64($sp)
	sw	$9,68($sp)
	lw	$10,80($sp)
	lw	$2,88($sp)
	lw	$3,84($sp)
	lw	$8,116($sp)
	lw	$9,120($sp)
	move	$4,$16
	addiu	$5,$22,1
	li	$6,1			# 0x1
	li	$7,2			# 0x2
	sw	$23,36($sp)
	sw	$0,16($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	sw	$10,28($sp)
	sw	$2,40($sp)
	sw	$3,48($sp)
	sw	$8,56($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$9,60($sp)

	addiu	$17,$17,1
$L4518:
	li	$2,4			# 0x4
	addiu	$21,$21,4
	addiu	$22,$22,4
	bne	$17,$2,$L4509
	addiu	$18,$18,4

	lb	$3,9508($16)
$L4519:
	bltz	$3,$L4511
	sll	$2,$3,5

	sll	$3,$3,3
	lw	$4,6168($16)
	subu	$3,$2,$3
	lh	$18,9346($16)
	lw	$5,6172($16)
	sll	$2,$3,4
	addu	$2,$3,$2
	sll	$5,$5,4
	andi	$3,$4,0x3
	sra	$18,$18,2
	addu	$18,$18,$5
	lw	$7,9756($16)
	sll	$3,$3,2
	addu	$5,$16,$2
	lh	$6,9344($16)
	addu	$3,$18,$3
	sll	$19,$4,4
	li	$4,131072			# 0x20000
	addu	$5,$4,$5
	mul	$4,$3,$7
	sra	$6,$6,2
	addiu	$19,$19,8
	addu	$19,$19,$6
	addiu	$6,$19,64
	addu	$3,$4,$6
	lw	$4,-13632($5)
	lw	$25,5148($16)
	lw	$5,176($16)
	li	$17,65536			# 0x10000
	addu	$4,$4,$3
	li	$6,4			# 0x4
	ori	$17,$17,0xcac0
	jalr	$25
	addu	$17,$2,$17

	lw	$4,6168($16)
	lw	$2,180($16)
	sra	$18,$18,1
	andi	$4,$4,0x7
	addu	$4,$18,$4
	mul	$3,$4,$2
	addu	$17,$16,$17
	sra	$19,$19,1
	lw	$2,4($17)
	addiu	$19,$19,64
	lw	$5,8($17)
	addu	$4,$3,$19
	lw	$25,5148($16)
	lw	$31,212($sp)
	lw	$fp,208($sp)
	lw	$23,204($sp)
	lw	$22,200($sp)
	lw	$21,196($sp)
	lw	$20,192($sp)
	lw	$19,188($sp)
	lw	$18,184($sp)
	lw	$17,180($sp)
	lw	$16,176($sp)
	subu	$5,$5,$2
	addu	$4,$2,$4
	li	$6,2			# 0x2
	jr	$25
	addiu	$sp,$sp,216

$L4516:
	lw	$4,108($sp)
	lw	$10,112($sp)
	lw	$9,4($4)
	lw	$8,4($10)
	andi	$2,$3,0x4000
	andi	$3,$3,0x1000
	sw	$9,44($sp)
	sw	$8,52($sp)
	sw	$3,64($sp)
	sw	$2,68($sp)
	lw	$3,144($sp)
	lw	$2,80($sp)
	lw	$8,140($sp)
	lw	$9,156($sp)
	lw	$10,160($sp)
	move	$4,$16
	li	$6,1			# 0x1
	li	$7,4			# 0x4
	sw	$fp,32($sp)
	sw	$23,36($sp)
	sw	$0,16($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	sw	$2,28($sp)
	sw	$3,40($sp)
	sw	$8,48($sp)
	sw	$9,56($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$10,60($sp)

	b	$L4518
	addiu	$17,$17,1

$L4517:
	lw	$4,128($sp)
	lw	$2,124($sp)
	lw	$9,0($4)
	lw	$10,0($2)
	sw	$9,52($sp)
	lw	$9,80($sp)
	sw	$10,44($sp)
	sw	$9,28($sp)
	lw	$10,88($sp)
	lw	$9,84($sp)
	sw	$10,40($sp)
	sw	$9,48($sp)
	lw	$10,132($sp)
	lw	$9,136($sp)
	andi	$8,$3,0x4000
	li	$2,4			# 0x4
	andi	$3,$3,0x1000
	move	$4,$16
	move	$6,$0
	li	$7,2			# 0x2
	sw	$2,16($sp)
	sw	$23,36($sp)
	sw	$10,56($sp)
	sw	$9,60($sp)
	sw	$3,64($sp)
	sw	$8,68($sp)
	sw	$2,172($sp)
	sw	$3,168($sp)
	sw	$8,164($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$fp,32($sp)

	lw	$10,124($sp)
	lw	$4,128($sp)
	lw	$9,0($10)
	lw	$2,172($sp)
	lw	$10,0($4)
	lw	$3,168($sp)
	lw	$8,164($sp)
	sw	$2,16($sp)
	sw	$9,44($sp)
	sw	$10,52($sp)
	sw	$3,64($sp)
	sw	$8,68($sp)
	lw	$9,88($sp)
	lw	$8,80($sp)
	lw	$10,84($sp)
	lw	$2,132($sp)
	lw	$3,136($sp)
	addiu	$23,$23,2
	move	$4,$16
	move	$5,$22
	move	$6,$0
	li	$7,2			# 0x2
	sw	$fp,32($sp)
	sw	$23,36($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	sw	$8,28($sp)
	sw	$9,40($sp)
	sw	$10,48($sp)
	sw	$2,56($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$3,60($sp)

	b	$L4518
	addiu	$17,$17,1

$L4511:
	lw	$31,212($sp)
	lw	$fp,208($sp)
	lw	$23,204($sp)
	lw	$22,200($sp)
	lw	$21,196($sp)
	lw	$20,192($sp)
	lw	$19,188($sp)
	lw	$18,184($sp)
	lw	$17,180($sp)
	lw	$16,176($sp)
	j	$31
	addiu	$sp,$sp,216

$L4508:
	lw	$10,92($sp)
	lw	$8,9756($16)
	lw	$9,0($10)
	lw	$2,96($sp)
	sll	$8,$8,2
	lw	$10,0($2)
	sw	$8,16($sp)
	sw	$9,44($sp)
	lw	$8,80($sp)
	lw	$9,88($sp)
	sw	$10,52($sp)
	sw	$8,28($sp)
	lw	$10,84($sp)
	lw	$8,148($sp)
	sw	$9,40($sp)
	lw	$9,152($sp)
	andi	$2,$3,0x4000
	move	$4,$16
	andi	$3,$3,0x1000
	move	$6,$0
	li	$7,4			# 0x4
	sw	$fp,32($sp)
	sw	$10,48($sp)
	sw	$8,56($sp)
	sw	$9,60($sp)
	sw	$3,64($sp)
	sw	$2,68($sp)
	sw	$2,172($sp)
	sw	$3,168($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$23,36($sp)

	lw	$10,92($sp)
	lw	$4,96($sp)
	lw	$9,9756($16)
	lw	$8,0($10)
	lw	$3,168($sp)
	lw	$10,0($4)
	lw	$2,172($sp)
	sll	$9,$9,2
	sw	$9,16($sp)
	sw	$8,44($sp)
	sw	$10,52($sp)
	sw	$3,64($sp)
	sw	$2,68($sp)
	lw	$8,80($sp)
	lw	$9,88($sp)
	lw	$10,84($sp)
	lw	$2,148($sp)
	lw	$3,152($sp)
	addiu	$fp,$fp,2
	move	$4,$16
	move	$5,$18
	move	$6,$0
	li	$7,4			# 0x4
	sw	$fp,32($sp)
	sw	$23,36($sp)
	sw	$19,20($sp)
	sw	$20,24($sp)
	sw	$8,28($sp)
	sw	$9,40($sp)
	sw	$10,48($sp)
	sw	$2,56($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$3,60($sp)

	b	$L4518
	addiu	$17,$17,1

$L4513:
	lw	$4,108($sp)
	lw	$9,112($sp)
	lw	$8,0($4)
	lw	$3,0($9)
	andi	$2,$21,0x4000
	move	$4,$16
	andi	$21,$21,0x1000
	move	$5,$0
	li	$6,1			# 0x1
	li	$7,8			# 0x8
	sw	$18,20($sp)
	sw	$19,24($sp)
	sw	$20,28($sp)
	sw	$22,40($sp)
	sw	$8,44($sp)
	sw	$17,48($sp)
	sw	$3,52($sp)
	sw	$23,56($sp)
	sw	$fp,60($sp)
	sw	$21,64($sp)
	sw	$2,68($sp)
	sw	$0,16($sp)
	sw	$0,32($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$0,36($sp)

	b	$L4519
	lb	$3,9508($16)

$L4515:
	lw	$2,108($sp)
	lw	$3,112($sp)
	lw	$10,9756($16)
	lw	$9,4($2)
	lw	$8,4($3)
	andi	$2,$21,0x4000
	andi	$3,$21,0x1000
	sll	$10,$10,3
	addiu	$22,$22,64
	addiu	$17,$17,64
	addiu	$23,$23,8
	addiu	$fp,$fp,8
	move	$4,$16
	move	$5,$0
	move	$6,$0
	li	$7,8			# 0x8
	sw	$10,16($sp)
	sw	$9,44($sp)
	sw	$8,52($sp)
	sw	$3,64($sp)
	sw	$2,68($sp)
	sw	$18,20($sp)
	sw	$19,24($sp)
	sw	$20,28($sp)
	sw	$0,32($sp)
	sw	$0,36($sp)
	sw	$22,40($sp)
	sw	$17,48($sp)
	sw	$23,56($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$fp,60($sp)

	lw	$9,9756($16)
	lw	$4,108($sp)
	lw	$10,112($sp)
	lw	$8,4($4)
	lw	$3,4($10)
	sll	$9,$9,3
	andi	$2,$21,0x8000
	sw	$9,16($sp)
	andi	$21,$21,0x2000
	li	$9,4			# 0x4
	move	$4,$16
	li	$5,4			# 0x4
	move	$6,$0
	li	$7,8			# 0x8
	sw	$18,20($sp)
	sw	$19,24($sp)
	sw	$20,28($sp)
	sw	$9,32($sp)
	sw	$22,40($sp)
	sw	$8,44($sp)
	sw	$17,48($sp)
	sw	$3,52($sp)
	sw	$23,56($sp)
	sw	$fp,60($sp)
	sw	$21,64($sp)
	sw	$2,68($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$0,36($sp)

	b	$L4519
	lb	$3,9508($16)

$L4514:
	lw	$2,108($sp)
	lw	$3,112($sp)
	lw	$10,0($2)
	lw	$9,0($3)
	li	$2,8			# 0x8
	andi	$8,$21,0x1000
	andi	$3,$21,0x4000
	addiu	$22,$22,64
	addiu	$17,$17,64
	addiu	$23,$23,4
	addiu	$fp,$fp,4
	move	$4,$16
	move	$5,$0
	move	$6,$0
	li	$7,4			# 0x4
	sw	$10,44($sp)
	sw	$9,52($sp)
	sw	$8,64($sp)
	sw	$3,68($sp)
	sw	$2,16($sp)
	sw	$2,172($sp)
	sw	$18,20($sp)
	sw	$19,24($sp)
	sw	$20,28($sp)
	sw	$0,32($sp)
	sw	$0,36($sp)
	sw	$22,40($sp)
	sw	$17,48($sp)
	sw	$23,56($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$fp,60($sp)

	lw	$4,108($sp)
	lw	$10,112($sp)
	lw	$2,172($sp)
	lw	$9,0($4)
	lw	$8,0($10)
	andi	$3,$21,0x8000
	sw	$2,16($sp)
	andi	$21,$21,0x2000
	li	$2,4			# 0x4
	move	$4,$16
	li	$5,8			# 0x8
	move	$6,$0
	li	$7,4			# 0x4
	sw	$18,20($sp)
	sw	$19,24($sp)
	sw	$20,28($sp)
	sw	$2,36($sp)
	sw	$22,40($sp)
	sw	$9,44($sp)
	sw	$17,48($sp)
	sw	$8,52($sp)
	sw	$23,56($sp)
	sw	$fp,60($sp)
	sw	$21,64($sp)
	sw	$3,68($sp)
	.option	pic0
	jal	mc_part
	.option	pic2
	sw	$0,32($sp)

	b	$L4519
	lb	$3,9508($16)

	.set	macro
	.set	reorder
	.end	hl_motion
	.size	hl_motion, .-hl_motion
	.align	2
	.set	nomips16
	.ent	hl_decode_mb_complex
	.type	hl_decode_mb_complex, @function
hl_decode_mb_complex:
	.frame	$sp,288,$31		# vars= 200, regs= 10/0, args= 40, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$2,6172($4)
	addiu	$sp,$sp,-288
	sw	$2,136($sp)
	lw	$3,136($sp)
	lw	$2,152($4)
	lw	$5,1568($4)
	sw	$23,276($sp)
	sw	$16,248($sp)
	lw	$23,6168($4)
	move	$16,$4
	mul	$4,$3,$2
	lw	$3,2056($16)
	addu	$2,$4,$23
	sll	$4,$2,2
	addu	$4,$5,$4
	lw	$5,136($sp)
	lw	$4,0($4)
	andi	$5,$5,0x1
	sw	$31,284($sp)
	sw	$fp,280($sp)
	sw	$22,272($sp)
	sw	$21,268($sp)
	sw	$20,264($sp)
	sw	$19,260($sp)
	sw	$18,256($sp)
	sw	$17,252($sp)
	sw	$4,148($sp)
	beq	$3,$0,$L4521
	sw	$5,172($sp)

	sw	$0,168($sp)
$L4522:
	lw	$5,176($16)
	lw	$4,136($sp)
	sll	$7,$5,2
	mul	$6,$4,$5
	andi	$4,$23,0x3
	lw	$3,180($16)
	mul	$4,$7,$4
	lw	$7,136($sp)
	sll	$8,$23,4
	mul	$3,$7,$3
	lw	$18,1464($16)
	sll	$6,$6,4
	addu	$6,$6,$8
	lw	$10,44($16)
	sll	$9,$23,3
	addu	$18,$18,$6
	lw	$19,1468($16)
	lw	$20,1472($16)
	lw	$25,5148($16)
	sll	$3,$3,3
	addiu	$4,$4,64
	addu	$3,$3,$9
	sw	$2,240($sp)
	sw	$8,160($sp)
	sw	$9,164($sp)
	addu	$4,$18,$4
	li	$6,4			# 0x4
	sw	$10,128($sp)
	addu	$19,$19,$3
	jalr	$25
	addu	$20,$20,$3

	lw	$4,6168($16)
	lw	$3,180($16)
	andi	$4,$4,0x7
	mul	$4,$4,$3
	lw	$25,5148($16)
	addiu	$4,$4,64
	addu	$4,$19,$4
	subu	$5,$20,$19
	jalr	$25
	li	$6,2			# 0x2

	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$4,-6272($3)
	beq	$4,$0,$L4523
	lw	$2,240($sp)

	lw	$3,176($16)
	lw	$4,180($16)
	lw	$5,172($sp)
	sll	$21,$3,1
	sll	$22,$4,1
	sw	$21,9756($16)
	sw	$22,9760($16)
	beq	$5,$0,$L4524
	addiu	$17,$16,9644

	sll	$5,$3,4
	sll	$6,$4,3
	subu	$4,$4,$6
	subu	$3,$3,$5
	addu	$18,$18,$3
	addu	$20,$20,$4
	addu	$19,$19,$4
$L4524:
	li	$4,65536			# 0x10000
	addu	$4,$16,$4
	lw	$3,-6276($4)
	bne	$3,$0,$L4718
	nop

$L4525:
	lw	$8,168($sp)
	beq	$8,$0,$L4778
	lw	$10,148($sp)

$L4720:
	lw	$9,148($sp)
	li	$4,16777216			# 0x1000000
	and	$4,$9,$4
	beq	$4,$0,$L4534
	nop

	lw	$fp,2160($16)
	sw	$fp,144($sp)
$L4535:
	beq	$3,$0,$L4779
	lw	$10,148($sp)

	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$3,5340($3)
	beq	$3,$0,$L4779
	lw	$13,148($sp)

	andi	$3,$13,0x7
	beq	$3,$0,$L4779
	lw	$14,172($sp)

	beq	$14,$0,$L4538
	nop

	lw	$4,152($16)
	lw	$3,1568($16)
	subu	$2,$2,$4
	sll	$2,$2,2
	addu	$2,$3,$2
	lw	$2,0($2)
	andi	$2,$2,0x7
	bne	$2,$0,$L4780
	andi	$2,$10,0x4

$L4538:
	lw	$3,176($16)
	lw	$25,136($sp)
	li	$4,-2			# 0xfffffffffffffffe
	lw	$2,180($16)
	and	$4,$25,$4
	sll	$5,$3,4
	mul	$8,$5,$4
	sll	$6,$2,3
	lw	$7,160($sp)
	mul	$9,$6,$4
	addu	$5,$8,$7
	lw	$7,164($sp)
	lw	$8,1464($16)
	addu	$4,$9,$7
	lw	$6,1468($16)
	lw	$7,1472($16)
	addu	$6,$6,$4
	addu	$7,$7,$4
	sw	$2,20($sp)
	addu	$5,$8,$5
	li	$2,1			# 0x1
	move	$4,$16
	sw	$3,16($sp)
	.option	pic0
	jal	xchg_pair_border
	.option	pic2
	sw	$2,24($sp)

	lw	$10,148($sp)
$L4779:
	andi	$2,$10,0x4
$L4780:
	beq	$2,$0,$L4539
	lw	$11,128($sp)

	sll	$24,$21,1
	addu	$12,$24,$21
	addiu	$2,$21,1
	li	$3,131072			# 0x20000
	addiu	$15,$24,1
	addiu	$14,$24,2
	addiu	$13,$24,3
	addiu	$11,$12,1
	addiu	$10,$12,2
	addiu	$9,$12,3
	addu	$5,$18,$2
	addu	$8,$18,$21
	addiu	$fp,$21,2
	addiu	$25,$21,3
	ori	$3,$3,0x1ad8
	addu	$3,$16,$3
	mtlo	$16
	addu	$fp,$18,$fp
	move	$16,$8
	addu	$25,$18,$25
	addu	$24,$18,$24
	addu	$15,$18,$15
	addu	$14,$18,$14
	addu	$13,$18,$13
	addu	$12,$18,$12
	addu	$11,$18,$11
	addu	$10,$18,$10
	addu	$9,$18,$9
	move	$2,$17
	move	$4,$0
	li	$7,16			# 0x10
	move	$8,$5
$L4540:
	lw	$5,0($2)
	lhu	$6,0($3)
	addu	$5,$18,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,2($3)
	addu	$5,$18,$5
	sb	$6,1($5)
	lw	$5,0($2)
	lhu	$6,4($3)
	addu	$5,$18,$5
	sb	$6,2($5)
	lw	$5,0($2)
	lhu	$6,6($3)
	addu	$5,$18,$5
	sb	$6,3($5)
	lw	$5,0($2)
	lhu	$6,8($3)
	addu	$5,$16,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,10($3)
	addu	$5,$8,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,12($3)
	addu	$5,$fp,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,14($3)
	addu	$5,$25,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,16($3)
	addu	$5,$24,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,18($3)
	addu	$5,$15,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,20($3)
	addu	$5,$14,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,22($3)
	addu	$5,$13,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,24($3)
	addu	$5,$12,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,26($3)
	addu	$5,$11,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,28($3)
	addu	$5,$10,$5
	sb	$6,0($5)
	lw	$5,0($2)
	lhu	$6,30($3)
	addu	$5,$9,$5
	addiu	$4,$4,1
	sb	$6,0($5)
	addiu	$2,$2,4
	bne	$4,$7,$L4540
	addiu	$3,$3,32

	mflo	$16
	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lw	$3,64($17)
	lhu	$4,7384($2)
	addu	$3,$19,$3
	sb	$4,0($3)
	lw	$3,64($17)
	lhu	$4,7386($2)
	addu	$3,$19,$3
	sb	$4,1($3)
	lw	$3,64($17)
	lhu	$4,7388($2)
	addu	$3,$19,$3
	sb	$4,2($3)
	lw	$3,64($17)
	lhu	$4,7390($2)
	addu	$3,$19,$3
	sb	$4,3($3)
	lw	$3,64($17)
	lhu	$4,7392($2)
	addu	$3,$19,$3
	addu	$3,$3,$22
	sb	$4,0($3)
	lw	$3,64($17)
	lhu	$4,7394($2)
	addiu	$13,$22,1
	addu	$3,$19,$3
	addu	$3,$3,$13
	sb	$4,0($3)
	lw	$3,64($17)
	addiu	$12,$22,2
	lhu	$4,7396($2)
	addu	$3,$19,$3
	addu	$3,$3,$12
	sb	$4,0($3)
	lw	$3,64($17)
	addiu	$11,$22,3
	lhu	$4,7398($2)
	addu	$3,$19,$3
	addu	$3,$3,$11
	sb	$4,0($3)
	lw	$4,64($17)
	sll	$3,$22,1
	lhu	$5,7400($2)
	addu	$4,$19,$4
	addu	$4,$4,$3
	sb	$5,0($4)
	lw	$4,64($17)
	addiu	$10,$3,1
	lhu	$5,7402($2)
	addu	$4,$19,$4
	addu	$4,$4,$10
	sb	$5,0($4)
	lw	$4,64($17)
	addiu	$9,$3,2
	lhu	$5,7404($2)
	addu	$4,$19,$4
	addu	$4,$4,$9
	sb	$5,0($4)
	lw	$4,64($17)
	addiu	$8,$3,3
	lhu	$5,7406($2)
	addu	$4,$19,$4
	addu	$4,$4,$8
	sb	$5,0($4)
	lw	$5,64($17)
	lhu	$6,7408($2)
	addu	$4,$3,$22
	addu	$5,$19,$5
	addu	$5,$5,$4
	sb	$6,0($5)
	lw	$5,64($17)
	lhu	$6,7410($2)
	addiu	$7,$4,1
	addu	$5,$19,$5
	addu	$5,$5,$7
	sb	$6,0($5)
	lw	$5,64($17)
	lhu	$14,7412($2)
	addiu	$6,$4,2
	addu	$5,$19,$5
	addu	$5,$5,$6
	sb	$14,0($5)
	lw	$14,64($17)
	lhu	$15,7414($2)
	addiu	$5,$4,3
	addu	$14,$19,$14
	addu	$14,$14,$5
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7416($2)
	addu	$14,$19,$14
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7418($2)
	addu	$14,$19,$14
	sb	$15,1($14)
	lw	$14,68($17)
	lhu	$15,7420($2)
	addu	$14,$19,$14
	sb	$15,2($14)
	lw	$14,68($17)
	lhu	$15,7422($2)
	addu	$14,$19,$14
	sb	$15,3($14)
	lw	$14,68($17)
	lhu	$15,7424($2)
	addu	$14,$19,$14
	addu	$14,$14,$22
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7426($2)
	addu	$14,$19,$14
	addu	$14,$14,$13
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7428($2)
	addu	$14,$19,$14
	addu	$14,$14,$12
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7430($2)
	addu	$14,$19,$14
	addu	$14,$14,$11
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7432($2)
	addu	$14,$19,$14
	addu	$14,$14,$3
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7434($2)
	addu	$14,$19,$14
	addu	$14,$14,$10
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7436($2)
	addu	$14,$19,$14
	addu	$14,$14,$9
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7438($2)
	addu	$14,$19,$14
	addu	$14,$14,$8
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7440($2)
	addu	$14,$19,$14
	addu	$14,$14,$4
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7442($2)
	addu	$14,$19,$14
	addu	$14,$14,$7
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7444($2)
	addu	$14,$19,$14
	addu	$14,$14,$6
	sb	$15,0($14)
	lw	$14,68($17)
	lhu	$15,7446($2)
	addu	$14,$19,$14
	addu	$14,$14,$5
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7448($2)
	addu	$14,$19,$14
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7450($2)
	addu	$14,$19,$14
	sb	$15,1($14)
	lw	$14,72($17)
	lhu	$15,7452($2)
	addu	$14,$19,$14
	sb	$15,2($14)
	lw	$14,72($17)
	lhu	$15,7454($2)
	addu	$14,$19,$14
	sb	$15,3($14)
	lw	$14,72($17)
	lhu	$15,7456($2)
	addu	$14,$19,$14
	addu	$14,$14,$22
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7458($2)
	addu	$14,$19,$14
	addu	$14,$14,$13
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7460($2)
	addu	$14,$19,$14
	addu	$14,$14,$12
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7462($2)
	addu	$14,$19,$14
	addu	$14,$14,$11
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7464($2)
	addu	$14,$19,$14
	addu	$14,$14,$3
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7466($2)
	addu	$14,$19,$14
	addu	$14,$14,$10
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7468($2)
	addu	$14,$19,$14
	addu	$14,$14,$9
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7470($2)
	addu	$14,$19,$14
	addu	$14,$14,$8
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7472($2)
	addu	$14,$19,$14
	addu	$14,$14,$4
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7474($2)
	addu	$14,$19,$14
	addu	$14,$14,$7
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7476($2)
	addu	$14,$19,$14
	addu	$14,$14,$6
	sb	$15,0($14)
	lw	$14,72($17)
	lhu	$15,7478($2)
	addu	$14,$19,$14
	addu	$14,$14,$5
	sb	$15,0($14)
	lw	$14,76($17)
	lhu	$15,7480($2)
	addu	$14,$19,$14
	sb	$15,0($14)
	lw	$14,76($17)
	lhu	$15,7482($2)
	addu	$14,$19,$14
	sb	$15,1($14)
	lw	$14,76($17)
	lhu	$15,7484($2)
	addu	$14,$19,$14
	sb	$15,2($14)
	lw	$14,76($17)
	lhu	$15,7486($2)
	addu	$14,$19,$14
	sb	$15,3($14)
	lw	$14,76($17)
	lhu	$15,7488($2)
	addu	$14,$19,$14
	addu	$14,$14,$22
	sb	$15,0($14)
	lw	$14,76($17)
	lhu	$15,7490($2)
	addu	$14,$19,$14
	addu	$14,$14,$13
	sb	$15,0($14)
	lw	$14,76($17)
	lhu	$15,7492($2)
	addu	$14,$19,$14
	addu	$14,$14,$12
	sb	$15,0($14)
	lw	$14,76($17)
	lhu	$15,7494($2)
	addu	$14,$19,$14
	addu	$14,$14,$11
	sb	$15,0($14)
	lw	$14,76($17)
	lhu	$15,7496($2)
	addu	$14,$19,$14
	addu	$14,$14,$3
	sb	$15,0($14)
	lw	$15,76($17)
	lhu	$24,7498($2)
	addu	$14,$19,$10
	addu	$14,$14,$15
	sb	$24,0($14)
	lw	$15,76($17)
	lhu	$24,7500($2)
	addu	$14,$19,$9
	addu	$14,$14,$15
	sb	$24,0($14)
	lw	$15,76($17)
	lhu	$24,7502($2)
	addu	$14,$19,$8
	addu	$14,$14,$15
	sb	$24,0($14)
	lw	$14,76($17)
	lhu	$15,7504($2)
	addu	$14,$19,$14
	addu	$14,$14,$4
	sb	$15,0($14)
	lw	$15,76($17)
	lhu	$24,7506($2)
	addu	$14,$19,$7
	addu	$14,$14,$15
	sb	$24,0($14)
	lw	$15,76($17)
	lhu	$24,7508($2)
	addu	$14,$19,$6
	addu	$14,$14,$15
	sb	$24,0($14)
	lw	$15,76($17)
	lhu	$24,7510($2)
	addu	$14,$19,$5
	addu	$14,$14,$15
	sb	$24,0($14)
	lw	$14,80($17)
	lhu	$15,7512($2)
	addu	$14,$20,$14
	sb	$15,0($14)
	lw	$14,80($17)
	lhu	$15,7514($2)
	addu	$14,$20,$14
	sb	$15,1($14)
	lw	$14,80($17)
	lhu	$15,7516($2)
	addu	$14,$20,$14
	sb	$15,2($14)
	lw	$14,80($17)
	lhu	$15,7518($2)
	addu	$14,$20,$14
	sb	$15,3($14)
	lw	$15,80($17)
	lhu	$24,7520($2)
	addu	$14,$20,$22
	addu	$15,$14,$15
	sb	$24,0($15)
	lw	$15,80($17)
	lhu	$24,7522($2)
	addu	$15,$20,$15
	addu	$15,$15,$13
	sb	$24,0($15)
	lw	$15,80($17)
	lhu	$24,7524($2)
	addu	$15,$20,$15
	addu	$15,$15,$12
	sb	$24,0($15)
	lw	$15,80($17)
	lhu	$24,7526($2)
	addu	$15,$20,$15
	addu	$15,$15,$11
	sb	$24,0($15)
	lw	$15,80($17)
	lhu	$25,7528($2)
	addu	$24,$20,$3
	addu	$15,$24,$15
	sb	$25,0($15)
	lw	$15,80($17)
	lhu	$25,7530($2)
	addu	$15,$20,$15
	addu	$15,$15,$10
	sb	$25,0($15)
	lw	$15,80($17)
	lhu	$25,7532($2)
	addu	$15,$20,$15
	addu	$15,$15,$9
	sb	$25,0($15)
	lw	$15,80($17)
	lhu	$25,7534($2)
	addu	$15,$20,$15
	addu	$15,$15,$8
	sb	$25,0($15)
	lw	$15,80($17)
	lhu	$fp,7536($2)
	addu	$25,$20,$4
	addu	$15,$25,$15
	sb	$fp,0($15)
	lw	$15,80($17)
	lhu	$fp,7538($2)
	addu	$15,$20,$15
	addu	$15,$15,$7
	sb	$fp,0($15)
	lw	$15,80($17)
	lhu	$fp,7540($2)
	addu	$15,$20,$15
	addu	$15,$15,$6
	sb	$fp,0($15)
	lw	$15,80($17)
	lhu	$fp,7542($2)
	addu	$15,$20,$15
	addu	$15,$15,$5
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7544($2)
	addu	$15,$20,$15
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7546($2)
	addu	$15,$20,$15
	sb	$fp,1($15)
	lw	$15,84($17)
	lhu	$fp,7548($2)
	addu	$15,$20,$15
	sb	$fp,2($15)
	lw	$15,84($17)
	lhu	$fp,7550($2)
	addu	$15,$20,$15
	sb	$fp,3($15)
	lw	$15,84($17)
	lhu	$fp,7552($2)
	addu	$15,$14,$15
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7554($2)
	addu	$15,$20,$15
	addu	$15,$15,$13
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7556($2)
	addu	$15,$20,$15
	addu	$15,$15,$12
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7558($2)
	addu	$15,$20,$15
	addu	$15,$15,$11
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7560($2)
	addu	$15,$24,$15
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7562($2)
	addu	$15,$20,$15
	addu	$15,$15,$10
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7564($2)
	addu	$15,$20,$15
	addu	$15,$15,$9
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7566($2)
	addu	$15,$20,$15
	addu	$15,$15,$8
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7568($2)
	addu	$15,$25,$15
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7570($2)
	addu	$15,$20,$15
	addu	$15,$15,$7
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7572($2)
	addu	$15,$20,$15
	addu	$15,$15,$6
	sb	$fp,0($15)
	lw	$15,84($17)
	lhu	$fp,7574($2)
	addu	$15,$20,$15
	addu	$15,$15,$5
	sb	$fp,0($15)
	lw	$15,88($17)
	lhu	$fp,7576($2)
	addu	$15,$20,$15
	sb	$fp,0($15)
	lw	$15,88($17)
	lhu	$fp,7578($2)
	addu	$15,$20,$15
	sb	$fp,1($15)
	lw	$15,88($17)
	lhu	$fp,7580($2)
	addu	$15,$20,$15
	sb	$fp,2($15)
	lw	$15,88($17)
	lhu	$fp,7582($2)
	addu	$15,$20,$15
	sb	$fp,3($15)
	lw	$15,88($17)
	lhu	$fp,7584($2)
	addu	$14,$14,$15
	sb	$fp,0($14)
	lw	$14,88($17)
	lhu	$15,7586($2)
	addu	$14,$20,$14
	addu	$14,$14,$13
	sb	$15,0($14)
	lw	$14,88($17)
	lhu	$15,7588($2)
	addu	$14,$20,$14
	addu	$14,$14,$12
	sb	$15,0($14)
	lw	$14,88($17)
	lhu	$15,7590($2)
	addu	$14,$20,$14
	addu	$14,$14,$11
	sb	$15,0($14)
	lw	$14,88($17)
	lhu	$15,7592($2)
	addu	$24,$24,$14
	sb	$15,0($24)
	lw	$14,88($17)
	lhu	$15,7594($2)
	addu	$14,$20,$14
	addu	$14,$14,$10
	sb	$15,0($14)
	lw	$14,88($17)
	lhu	$15,7596($2)
	addu	$14,$20,$14
	addu	$14,$14,$9
	sb	$15,0($14)
	lw	$14,88($17)
	lhu	$15,7598($2)
	addu	$14,$20,$14
	addu	$14,$14,$8
	sb	$15,0($14)
	lw	$14,88($17)
	lhu	$15,7600($2)
	addu	$14,$25,$14
	sb	$15,0($14)
	lw	$14,88($17)
	lhu	$15,7602($2)
	addu	$14,$20,$14
	addu	$14,$14,$7
	sb	$15,0($14)
	lw	$14,88($17)
	lhu	$15,7604($2)
	addu	$14,$20,$14
	addu	$14,$14,$6
	sb	$15,0($14)
	lw	$14,88($17)
	lhu	$15,7606($2)
	addu	$14,$20,$14
	addu	$14,$14,$5
	sb	$15,0($14)
	lw	$14,92($17)
	lhu	$15,7608($2)
	addu	$14,$20,$14
	sb	$15,0($14)
	lw	$14,92($17)
	lhu	$15,7610($2)
	addu	$14,$20,$14
	sb	$15,1($14)
	lw	$14,92($17)
	lhu	$15,7612($2)
	addu	$14,$20,$14
	sb	$15,2($14)
	lw	$14,92($17)
	lhu	$15,7614($2)
	addu	$14,$20,$14
	sb	$15,3($14)
	lw	$14,92($17)
	lhu	$15,7616($2)
	addu	$14,$20,$14
	addu	$14,$14,$22
	sb	$15,0($14)
	lw	$14,92($17)
	lhu	$15,7618($2)
	addu	$14,$20,$14
	addu	$13,$14,$13
	sb	$15,0($13)
	lw	$14,92($17)
	lhu	$13,7620($2)
	addu	$14,$20,$14
	addu	$12,$14,$12
	sb	$13,0($12)
	lw	$13,92($17)
	lhu	$12,7622($2)
	addu	$13,$20,$13
	addu	$11,$13,$11
	sb	$12,0($11)
	lw	$12,92($17)
	lhu	$11,7624($2)
	addu	$12,$20,$12
	addu	$3,$12,$3
	sb	$11,0($3)
	lw	$11,92($17)
	lhu	$3,7626($2)
	addu	$10,$20,$10
	addu	$10,$10,$11
	sb	$3,0($10)
	lw	$10,92($17)
	lhu	$3,7628($2)
	addu	$9,$20,$9
	addu	$9,$9,$10
	sb	$3,0($9)
	lw	$9,92($17)
	lhu	$3,7630($2)
	addu	$8,$20,$8
	addu	$8,$8,$9
	sb	$3,0($8)
	lw	$8,92($17)
	lhu	$3,7632($2)
	addu	$8,$20,$8
	addu	$4,$8,$4
	sb	$3,0($4)
	lw	$4,92($17)
	lhu	$3,7634($2)
	addu	$7,$20,$7
	addu	$7,$7,$4
	sb	$3,0($7)
	lw	$4,92($17)
	lhu	$3,7636($2)
	addu	$6,$20,$6
	addu	$6,$6,$4
	sb	$3,0($6)
	lw	$3,92($17)
	addu	$5,$20,$5
	lhu	$2,7638($2)
	addu	$5,$5,$3
	sb	$2,0($5)
$L4541:
	li	$2,65536			# 0x10000
$L4747:
	addu	$2,$16,$2
	lw	$3,5340($2)
	beq	$3,$0,$L4707
	nop

	lw	$2,-6276($2)
	beq	$2,$0,$L4702
	subu	$2,$18,$21

	lw	$4,6172($16)
	lw	$3,152($16)
	addiu	$fp,$4,-1
	mul	$2,$fp,$3
	sw	$4,144($sp)
	addu	$17,$2,$23
	addu	$5,$17,$3
	lw	$2,1568($16)
	sll	$5,$5,2
	addu	$5,$2,$5
	lw	$5,0($5)
	sll	$6,$17,2
	sw	$5,148($sp)
	lw	$5,172($sp)
	addu	$2,$2,$6
	beq	$5,$0,$L4707
	lw	$3,0($2)

	lw	$11,180($16)
	lw	$10,176($16)
	sll	$5,$11,3
	mul	$7,$5,$fp
	sll	$2,$10,4
	lw	$6,164($sp)
	mul	$8,$2,$fp
	addu	$5,$7,$6
	lw	$12,148($sp)
	lw	$6,160($sp)
	lw	$7,1464($16)
	addu	$2,$8,$6
	lw	$9,1468($16)
	lw	$8,1472($16)
	or	$6,$12,$3
	andi	$6,$6,0x7
	addu	$2,$7,$2
	addu	$8,$8,$5
	bne	$6,$0,$L4719
	addu	$9,$9,$5

$L4703:
	lw	$13,6168($16)
	lw	$31,8996($16)
	sll	$5,$13,5
	sw	$13,128($sp)
	addu	$6,$31,$5
	lbu	$6,15($6)
	lw	$25,9000($16)
	sb	$6,9004($16)
	addu	$5,$25,$5
	lbu	$6,15($5)
	sll	$24,$11,1
	sll	$5,$10,1
	subu	$15,$0,$24
	subu	$5,$2,$5
	sb	$6,9005($16)
	addu	$14,$8,$15
	sw	$5,136($sp)
	addu	$15,$9,$15
	addiu	$6,$2,15
	li	$5,2			# 0x2
	li	$13,34			# 0x22
$L4704:
	lbu	$12,0($6)
	addu	$7,$16,$5
	addiu	$5,$5,1
	sb	$12,9004($7)
	bne	$5,$13,$L4704
	addu	$6,$6,$10

	lw	$6,136($sp)
	sll	$7,$10,5
	addu	$5,$6,$7
	lw	$13,4($5)
	lw	$12,0($5)
	sw	$13,156($sp)
	lw	$13,128($sp)
	sw	$12,152($sp)
	sll	$6,$13,5
	lw	$13,156($sp)
	addu	$5,$31,$6
	sw	$13,4($5)
	lw	$13,136($sp)
	lw	$12,152($sp)
	addu	$13,$13,$7
	sw	$13,152($sp)
	lw	$13,152($sp)
	sw	$12,0($5)
	lw	$12,8($13)
	lw	$13,12($13)
	sw	$12,152($sp)
	sw	$13,156($sp)
	addiu	$12,$6,8
	lw	$13,156($sp)
	addu	$10,$7,$10
	addu	$7,$31,$12
	sw	$13,4($7)
	sw	$12,160($sp)
	lw	$13,136($sp)
	lw	$12,152($sp)
	addu	$10,$13,$10
	sw	$12,0($7)
	lw	$12,0($10)
	lw	$13,4($10)
	addu	$6,$25,$6
	sw	$12,0($6)
	sw	$13,4($6)
	lw	$13,12($10)
	lw	$12,8($10)
	sw	$13,140($sp)
	lw	$13,160($sp)
	lw	$7,56($16)
	sw	$12,136($sp)
	addu	$10,$25,$13
	lw	$12,136($sp)
	lw	$13,140($sp)
	andi	$7,$7,0x2000
	sw	$12,0($10)
	bne	$7,$0,$L4705
	sw	$13,4($10)

	lbu	$10,23($5)
	addiu	$7,$24,7
	sb	$10,9038($16)
	lbu	$10,23($6)
	addu	$12,$15,$7
	sb	$10,9039($16)
	lbu	$10,31($5)
	addu	$7,$14,$7
	sb	$10,9056($16)
	lbu	$13,31($6)
	addu	$10,$24,$11
	sb	$13,9057($16)
	lbu	$12,0($12)
	addiu	$10,$10,7
	sb	$12,9040($16)
	lbu	$12,0($7)
	addu	$7,$15,$10
	sb	$12,9058($16)
	lbu	$7,0($7)
	addu	$10,$14,$10
	sb	$7,9041($16)
	lbu	$12,0($10)
	sll	$10,$11,2
	addiu	$7,$10,7
	sb	$12,9059($16)
	addu	$12,$15,$7
	lbu	$12,0($12)
	addu	$7,$14,$7
	sb	$12,9042($16)
	lbu	$7,0($7)
	addu	$12,$10,$11
	addiu	$12,$12,7
	sb	$7,9060($16)
	addu	$7,$15,$12
	lbu	$7,0($7)
	addu	$12,$14,$12
	sb	$7,9043($16)
	sll	$7,$11,3
	lbu	$13,0($12)
	subu	$12,$7,$24
	addiu	$12,$12,7
	sb	$13,9061($16)
	addu	$13,$15,$12
	lbu	$13,0($13)
	addu	$12,$14,$12
	sb	$13,9044($16)
	lbu	$13,0($12)
	subu	$12,$7,$11
	addiu	$12,$12,7
	sb	$13,9062($16)
	addu	$13,$15,$12
	lbu	$13,0($13)
	addu	$12,$14,$12
	sb	$13,9045($16)
	lbu	$13,0($12)
	addiu	$12,$7,7
	sb	$13,9063($16)
	addu	$13,$15,$12
	lbu	$13,0($13)
	addu	$12,$14,$12
	sb	$13,9046($16)
	lbu	$13,0($12)
	addu	$12,$7,$11
	addiu	$12,$12,7
	sb	$13,9064($16)
	addu	$13,$15,$12
	lbu	$13,0($13)
	addu	$12,$14,$12
	sb	$13,9047($16)
	lbu	$13,0($12)
	addu	$7,$24,$7
	addiu	$12,$7,7
	sb	$13,9065($16)
	addu	$7,$15,$12
	lbu	$13,0($7)
	sll	$7,$11,4
	sb	$13,9048($16)
	subu	$10,$7,$10
	addu	$12,$14,$12
	lbu	$13,0($12)
	subu	$12,$10,$11
	addiu	$12,$12,7
	sb	$13,9066($16)
	addu	$13,$15,$12
	lbu	$13,0($13)
	addu	$12,$14,$12
	sb	$13,9049($16)
	lbu	$13,0($12)
	addiu	$12,$10,7
	sb	$13,9067($16)
	addu	$13,$15,$12
	lbu	$13,0($13)
	addu	$12,$14,$12
	sb	$13,9050($16)
	lbu	$12,0($12)
	addu	$10,$10,$11
	addiu	$10,$10,7
	sb	$12,9068($16)
	addu	$12,$15,$10
	lbu	$12,0($12)
	addu	$10,$14,$10
	sb	$12,9051($16)
	lbu	$10,0($10)
	subu	$24,$7,$24
	addiu	$24,$24,7
	sb	$10,9069($16)
	addu	$10,$15,$24
	lbu	$10,0($10)
	addu	$24,$14,$24
	sb	$10,9052($16)
	lbu	$12,0($24)
	subu	$10,$7,$11
	addiu	$10,$10,7
	sb	$12,9070($16)
	addu	$12,$15,$10
	lbu	$12,0($12)
	addu	$10,$14,$10
	sb	$12,9053($16)
	lbu	$12,0($10)
	addiu	$10,$7,7
	sb	$12,9071($16)
	addu	$12,$15,$10
	lbu	$12,0($12)
	addu	$11,$7,$11
	sb	$12,9054($16)
	addu	$10,$14,$10
	lbu	$13,0($10)
	addiu	$10,$11,7
	addu	$12,$15,$10
	sb	$13,9072($16)
	lbu	$12,0($12)
	addu	$10,$14,$10
	sb	$12,9055($16)
	lbu	$12,0($10)
	lw	$13,128($sp)
	sb	$12,9073($16)
	sll	$10,$13,5
	addu	$12,$15,$7
	lw	$13,4($12)
	addiu	$10,$10,16
	lw	$12,0($12)
	addu	$31,$31,$10
	sw	$12,0($31)
	sw	$13,4($31)
	addu	$7,$14,$7
	lw	$12,0($7)
	lw	$13,4($7)
	addu	$15,$15,$11
	sw	$12,24($5)
	sw	$13,28($5)
	lw	$12,0($15)
	lw	$13,4($15)
	addu	$10,$25,$10
	sw	$12,0($10)
	sw	$13,4($10)
	addu	$11,$14,$11
	lw	$10,0($11)
	lw	$11,4($11)
	sw	$10,24($6)
	sw	$11,28($6)
$L4705:
	addiu	$4,$4,-1
	move	$5,$3
	sw	$4,6172($16)
	li	$6,1			# 0x1
	move	$4,$16
	sw	$2,240($sp)
	sw	$8,216($sp)
	.option	pic0
	jal	fill_caches
	.option	pic2
	sw	$9,232($sp)

	lw	$3,1548($16)
	lw	$2,240($sp)
	lw	$9,232($sp)
	move	$7,$2
	addu	$2,$3,$17
	lbu	$3,0($2)
	lw	$8,216($sp)
	addu	$3,$16,$3
	lbu	$3,12096($3)
	move	$6,$fp
	sw	$3,8740($16)
	lbu	$2,0($2)
	move	$4,$16
	addu	$2,$16,$2
	lbu	$2,12352($2)
	move	$5,$23
	sw	$9,16($sp)
	sw	$2,8744($16)
	sw	$8,20($sp)
	sw	$21,24($sp)
	.option	pic0
	jal	filter_mb
	.option	pic2
	sw	$22,28($sp)

	lw	$2,6172($16)
	lw	$5,148($sp)
	addiu	$2,$2,1
	sw	$2,6172($16)
	move	$4,$16
	.option	pic0
	jal	fill_caches
	.option	pic2
	li	$6,1			# 0x1

	lw	$3,1548($16)
	lw	$2,152($16)
	addu	$17,$3,$17
	addu	$17,$17,$2
	lbu	$2,0($17)
	lw	$6,144($sp)
	addu	$2,$16,$2
	lbu	$2,12096($2)
	move	$4,$16
	sw	$2,8740($16)
	lbu	$2,0($17)
	move	$5,$23
	addu	$2,$16,$2
	lbu	$2,12352($2)
	move	$7,$18
	sw	$2,8744($16)
	sw	$19,16($sp)
	sw	$20,20($sp)
	sw	$21,24($sp)
	.option	pic0
	jal	filter_mb
	.option	pic2
	sw	$22,28($sp)

$L4707:
	lw	$31,284($sp)
	lw	$fp,280($sp)
	lw	$23,276($sp)
	lw	$22,272($sp)
	lw	$21,268($sp)
	lw	$20,264($sp)
	lw	$19,260($sp)
	lw	$18,256($sp)
	lw	$17,252($sp)
	lw	$16,248($sp)
	j	$31
	addiu	$sp,$sp,288

$L4523:
	lw	$21,176($16)
	lw	$22,180($16)
	lw	$8,168($sp)
	lw	$3,-6276($3)
	sw	$21,9756($16)
	sw	$22,9760($16)
	bne	$8,$0,$L4720
	addiu	$17,$16,9548

	lw	$10,148($sp)
$L4778:
	li	$4,16777216			# 0x1000000
	and	$4,$10,$4
	beq	$4,$0,$L4536
	nop

	lw	$11,5120($16)
	lw	$fp,5128($16)
	b	$L4535
	sw	$11,144($sp)

$L4521:
	lw	$3,9924($16)
	sltu	$3,$0,$3
	b	$L4522
	sw	$3,168($sp)

$L4536:
	lw	$12,5116($16)
	lw	$fp,5124($16)
	b	$L4535
	sw	$12,144($sp)

$L4534:
	lw	$fp,2164($16)
	b	$L4535
	sw	$fp,144($sp)

$L4718:
	lw	$6,5944($4)
	beq	$6,$0,$L4525
	lw	$7,148($sp)

	lw	$12,148($sp)
	move	$10,$4
	andi	$11,$7,0x8
	move	$5,$16
	addiu	$7,$16,9456
	move	$4,$0
	move	$3,$0
	li	$9,12288			# 0x3000
$L4532:
	sll	$8,$3,1
	sll	$8,$9,$8
	and	$8,$8,$12
	beq	$8,$0,$L4526
	nop

	bne	$11,$0,$L4527
	sll	$6,$4,5

	lb	$6,9468($5)
	bltz	$6,$L4528
	addiu	$6,$6,16

	lw	$8,6172($16)
	andi	$8,$8,0x1
	xor	$8,$6,$8
	sll	$13,$4,3
	sll	$6,$4,5
	addu	$6,$13,$6
	sll	$13,$8,8
	addu	$8,$13,$8
	addiu	$6,$6,12
	andi	$8,$8,0xffff
	addu	$6,$7,$6
	sh	$8,8($6)
	sh	$8,0($6)
$L4528:
	lb	$6,9470($5)
	bltz	$6,$L4529
	addiu	$6,$6,16

	lw	$8,6172($16)
	andi	$8,$8,0x1
	xor	$8,$6,$8
	sll	$13,$4,3
	sll	$6,$4,5
	addu	$6,$13,$6
	sll	$13,$8,8
	addu	$8,$13,$8
	addiu	$6,$6,14
	andi	$8,$8,0xffff
	addu	$6,$7,$6
	sh	$8,8($6)
	sh	$8,0($6)
$L4529:
	lb	$6,9484($5)
	bltz	$6,$L4530
	addiu	$6,$6,16

	lw	$8,6172($16)
	andi	$8,$8,0x1
	xor	$8,$6,$8
	sll	$13,$4,3
	sll	$6,$4,5
	addu	$6,$13,$6
	sll	$13,$8,8
	addu	$8,$13,$8
	addiu	$6,$6,28
	andi	$8,$8,0xffff
	addu	$6,$7,$6
	sh	$8,8($6)
	sh	$8,0($6)
$L4530:
	lb	$6,9486($5)
	bltz	$6,$L4717
	nop

	lw	$8,6172($16)
	addiu	$6,$6,16
	andi	$8,$8,0x1
	xor	$6,$6,$8
	sll	$8,$4,5
	sll	$4,$4,3
	addu	$4,$4,$8
	sll	$8,$6,8
	addu	$6,$8,$6
	addiu	$4,$4,30
	andi	$6,$6,0xffff
	addu	$4,$7,$4
	sh	$6,8($4)
	sh	$6,0($4)
	lw	$6,5944($10)
$L4526:
	addiu	$3,$3,1
	sltu	$8,$3,$6
	addiu	$5,$5,40
	bne	$8,$0,$L4532
	move	$4,$3

	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	b	$L4525
	lw	$3,-6276($3)

$L4539:
	andi	$12,$10,0x7
	xori	$2,$11,0x1c
	sltu	$2,$2,1
	sw	$12,152($sp)
	beq	$12,$0,$L4542
	sw	$2,176($sp)

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,5340($2)
	beq	$3,$0,$L4543
	nop

	lw	$2,-6276($2)
	beq	$2,$0,$L4721
	li	$2,1			# 0x1

$L4543:
	lw	$2,56($16)
$L4752:
	andi	$2,$2,0x2000
	beq	$2,$0,$L4722
	move	$4,$19

	lw	$13,148($sp)
$L4749:
	andi	$13,$13,0x1
	beq	$13,$0,$L4545
	sw	$13,180($sp)

	lw	$2,52($16)
	bne	$2,$0,$L4748
	li	$2,65536			# 0x10000

	lw	$14,148($sp)
	li	$2,16777216			# 0x1000000
	and	$2,$14,$2
	beq	$2,$0,$L4547
	li	$2,131072			# 0x20000

	addiu	$3,$16,12
	lb	$4,8776($3)
	li	$9,131072			# 0x20000
	addiu	$4,$4,2218
	lw	$2,0($17)
	sll	$4,$4,2
	lbu	$8,9080($3)
	addu	$4,$16,$4
	ori	$3,$9,0x1ad8
	lw	$5,8980($16)
	lw	$6,8988($16)
	addu	$2,$18,$2
	lw	$25,4($4)
	addu	$3,$16,$3
	move	$4,$2
	sw	$2,240($sp)
	sw	$8,216($sp)
	sw	$9,232($sp)
	andi	$5,$5,0x8000
	andi	$6,$6,0x4000
	move	$7,$21
	jalr	$25
	sw	$3,128($sp)

	lw	$8,216($sp)
	lw	$2,240($sp)
	beq	$8,$0,$L4548
	lw	$9,232($sp)

	li	$3,1			# 0x1
	beq	$8,$3,$L4549
	addu	$9,$16,$9

	lw	$5,128($sp)
$L4785:
	lw	$25,144($sp)
	move	$4,$2
	jalr	$25
	move	$6,$21

$L4548:
	addiu	$3,$16,14
$L4777:
	lb	$4,8776($3)
	lw	$2,16($17)
	addiu	$4,$4,2218
	lw	$5,8980($16)
	lw	$6,8988($16)
	sll	$4,$4,2
	lbu	$3,9080($3)
	addu	$4,$16,$4
	addu	$2,$18,$2
	lw	$25,4($4)
	sll	$5,$5,4
	sll	$6,$6,4
	move	$4,$2
	sw	$2,240($sp)
	sw	$3,236($sp)
	andi	$5,$5,0x8000
	andi	$6,$6,0x4000
	jalr	$25
	move	$7,$21

	lw	$3,236($sp)
	beq	$3,$0,$L4551
	lw	$2,240($sp)

	li	$4,1			# 0x1
	beq	$3,$4,$L4552
	li	$3,131072			# 0x20000

	move	$4,$2
$L4784:
	lw	$2,128($sp)
	lw	$25,144($sp)
	addiu	$5,$2,128
	jalr	$25
	move	$6,$21

$L4551:
	addiu	$3,$16,28
$L4776:
	lb	$4,8776($3)
	lw	$2,32($17)
	addiu	$4,$4,2218
	lw	$5,8980($16)
	lw	$6,8988($16)
	sll	$4,$4,2
	lbu	$3,9080($3)
	addu	$4,$16,$4
	addu	$2,$18,$2
	lw	$25,4($4)
	sll	$5,$5,8
	sll	$6,$6,8
	move	$4,$2
	sw	$2,240($sp)
	sw	$3,236($sp)
	andi	$5,$5,0x8000
	andi	$6,$6,0x4000
	jalr	$25
	move	$7,$21

	lw	$3,236($sp)
	beq	$3,$0,$L4554
	lw	$2,240($sp)

	li	$4,1			# 0x1
	beq	$3,$4,$L4555
	li	$3,131072			# 0x20000

	move	$4,$2
$L4783:
	lw	$2,128($sp)
	lw	$25,144($sp)
	addiu	$5,$2,256
	jalr	$25
	move	$6,$21

$L4554:
	addiu	$3,$16,30
$L4775:
	lb	$4,8776($3)
	lw	$2,48($17)
	addiu	$4,$4,2218
	lw	$5,8980($16)
	lw	$6,8988($16)
	sll	$4,$4,2
	lbu	$3,9080($3)
	addu	$4,$16,$4
	addu	$2,$18,$2
	lw	$25,4($4)
	sll	$5,$5,12
	sll	$6,$6,12
	move	$4,$2
	sw	$2,240($sp)
	sw	$3,236($sp)
	andi	$5,$5,0x8000
	andi	$6,$6,0x4000
	jalr	$25
	move	$7,$21

	lw	$3,236($sp)
	beq	$3,$0,$L4546
	lw	$2,240($sp)

	li	$4,1			# 0x1
	bne	$3,$4,$L4781
	move	$4,$2

	li	$3,131072			# 0x20000
	addu	$3,$16,$3
	lh	$3,7256($3)
	bne	$3,$0,$L4723
	lw	$2,128($sp)

$L4781:
	lw	$2,128($sp)
	lw	$25,144($sp)
	addiu	$5,$2,384
	jalr	$25
	move	$6,$21

$L4546:
	li	$2,65536			# 0x10000
$L4748:
	addu	$2,$16,$2
	lw	$3,5340($2)
	beq	$3,$0,$L4746
	lw	$13,180($sp)

	lw	$2,-6276($2)
	bne	$2,$0,$L4746
	move	$4,$16

	move	$5,$18
	move	$6,$19
	move	$7,$20
	sw	$21,16($sp)
	sw	$22,20($sp)
	sw	$0,24($sp)
	.option	pic0
	jal	xchg_mb_border
	.option	pic2
	sw	$0,28($sp)

	b	$L4746
	lw	$13,180($sp)

$L4702:
	lw	$8,6168($16)
	lw	$7,8996($16)
	sll	$4,$8,5
	addu	$4,$7,$4
	lbu	$3,15($4)
	sb	$3,9004($16)
	lbu	$5,15($18)
	sll	$3,$21,1
	sb	$5,9005($16)
	addu	$5,$2,$3
	lbu	$6,15($5)
	addu	$5,$3,$21
	sb	$6,9006($16)
	addu	$5,$2,$5
	lbu	$5,15($5)
	sll	$9,$21,2
	sb	$5,9007($16)
	addu	$5,$2,$9
	lbu	$6,15($5)
	addu	$5,$9,$21
	sb	$6,9008($16)
	addu	$5,$2,$5
	lbu	$10,15($5)
	sll	$5,$21,3
	subu	$6,$5,$3
	sb	$10,9009($16)
	addu	$6,$2,$6
	lbu	$10,15($6)
	subu	$6,$5,$21
	sb	$10,9010($16)
	addu	$6,$2,$6
	lbu	$10,15($6)
	addu	$6,$2,$5
	sb	$10,9011($16)
	lbu	$10,15($6)
	addu	$6,$5,$21
	sb	$10,9012($16)
	addu	$6,$2,$6
	lbu	$6,15($6)
	addu	$5,$3,$5
	sb	$6,9013($16)
	addu	$5,$2,$5
	sll	$6,$21,4
	lbu	$10,15($5)
	subu	$5,$6,$9
	subu	$9,$5,$21
	sb	$10,9014($16)
	addu	$9,$2,$9
	lbu	$10,15($9)
	addu	$9,$2,$5
	sb	$10,9015($16)
	lbu	$9,15($9)
	addu	$5,$5,$21
	sb	$9,9016($16)
	addu	$5,$2,$5
	lbu	$9,15($5)
	subu	$5,$6,$3
	sb	$9,9017($16)
	addu	$5,$2,$5
	lbu	$9,15($5)
	subu	$5,$6,$21
	sb	$9,9018($16)
	addu	$5,$2,$5
	lbu	$5,15($5)
	addu	$6,$2,$6
	sb	$5,9019($16)
	lbu	$5,15($6)
	addiu	$3,$3,1
	sb	$5,9020($16)
	lw	$10,0($6)
	lw	$11,4($6)
	sll	$3,$3,3
	addu	$2,$2,$3
	sw	$10,0($4)
	sw	$11,4($4)
	lw	$5,56($16)
	lw	$10,0($2)
	lw	$11,4($2)
	subu	$3,$0,$22
	andi	$5,$5,0x2000
	addu	$2,$20,$3
	sw	$10,8($4)
	sw	$11,12($4)
	bne	$5,$0,$L4706
	addu	$3,$19,$3

	lbu	$6,23($4)
	addiu	$5,$22,7
	sb	$6,9021($16)
	lbu	$9,31($4)
	addu	$6,$3,$5
	sb	$9,9030($16)
	lbu	$6,0($6)
	addu	$5,$2,$5
	sb	$6,9022($16)
	lbu	$9,0($5)
	sll	$6,$22,1
	addiu	$5,$6,7
	sb	$9,9031($16)
	addu	$9,$3,$5
	lbu	$9,0($9)
	addu	$5,$2,$5
	sb	$9,9023($16)
	lbu	$9,0($5)
	addu	$5,$6,$22
	addiu	$5,$5,7
	sb	$9,9032($16)
	addu	$9,$3,$5
	lbu	$9,0($9)
	addu	$5,$2,$5
	sb	$9,9024($16)
	lbu	$10,0($5)
	sll	$5,$22,2
	addiu	$9,$5,7
	sb	$10,9033($16)
	addu	$10,$3,$9
	lbu	$10,0($10)
	addu	$9,$2,$9
	sb	$10,9025($16)
	lbu	$9,0($9)
	addu	$5,$5,$22
	addiu	$5,$5,7
	sb	$9,9034($16)
	addu	$9,$3,$5
	lbu	$10,0($9)
	addu	$9,$2,$5
	sb	$10,9026($16)
	sll	$5,$22,3
	lbu	$9,0($9)
	subu	$6,$5,$6
	addiu	$6,$6,7
	sb	$9,9035($16)
	addu	$9,$3,$6
	lbu	$9,0($9)
	addu	$6,$2,$6
	sb	$9,9027($16)
	lbu	$9,0($6)
	subu	$6,$5,$22
	addiu	$6,$6,7
	sb	$9,9036($16)
	addu	$9,$3,$6
	lbu	$9,0($9)
	addu	$6,$2,$6
	sb	$9,9028($16)
	lbu	$9,0($6)
	addiu	$6,$5,7
	sb	$9,9037($16)
	addu	$9,$3,$6
	lbu	$9,0($9)
	addu	$6,$2,$6
	sb	$9,9029($16)
	lbu	$6,0($6)
	addu	$3,$3,$5
	sb	$6,9038($16)
	lw	$10,0($3)
	lw	$11,4($3)
	addu	$2,$2,$5
	sw	$10,16($4)
	sw	$11,20($4)
	lw	$3,4($2)
	lw	$2,0($2)
	sw	$3,28($4)
	sw	$2,24($4)
$L4706:
	lw	$5,148($sp)
	move	$4,$16
	.option	pic0
	jal	fill_caches
	.option	pic2
	li	$6,1			# 0x1

	lw	$6,136($sp)
	move	$4,$16
	move	$5,$23
	move	$7,$18
	sw	$19,16($sp)
	sw	$20,20($sp)
	sw	$21,24($sp)
	.option	pic0
	jal	filter_mb_fast
	.option	pic2
	sw	$22,28($sp)

	lw	$31,284($sp)
	lw	$fp,280($sp)
	lw	$23,276($sp)
	lw	$22,272($sp)
	lw	$21,268($sp)
	lw	$20,264($sp)
	lw	$19,260($sp)
	lw	$18,256($sp)
	lw	$17,252($sp)
	lw	$16,248($sp)
	j	$31
	addiu	$sp,$sp,288

$L4542:
	bne	$2,$0,$L4571
	lw	$2,148($sp)

	andi	$2,$2,0x1
	sw	$2,180($sp)
	lw	$13,180($sp)
$L4746:
	bne	$13,$0,$L4572
	lw	$14,176($sp)

	beq	$14,$0,$L4573
	li	$2,131072			# 0x20000

	lw	$25,148($sp)
	andi	$2,$25,0x2
	beq	$2,$0,$L4574
	lw	$2,148($sp)

	li	$2,131072			# 0x20000
	lbu	$3,9092($16)
	ori	$4,$2,0x1ad8
	addu	$4,$16,$4
	bne	$3,$0,$L4575
	sw	$4,128($sp)

	addu	$2,$16,$2
	lh	$2,6872($2)
	bne	$2,$0,$L4724
	lw	$5,128($sp)

	lbu	$2,9093($16)
$L4753:
	bne	$2,$0,$L4577
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,6904($2)
	bne	$2,$0,$L4725
	lw	$2,128($sp)

	lbu	$2,9100($16)
$L4757:
	bne	$2,$0,$L4579
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,6936($2)
	bne	$2,$0,$L4726
	lw	$2,128($sp)

	lbu	$2,9101($16)
$L4756:
	bne	$2,$0,$L4581
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,6968($2)
	bne	$2,$0,$L4727
	lw	$2,128($sp)

	lbu	$2,9094($16)
$L4755:
	bne	$2,$0,$L4583
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7000($2)
	bne	$2,$0,$L4728
	lw	$2,128($sp)

	lbu	$2,9095($16)
$L4754:
	bne	$2,$0,$L4585
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7032($2)
	bne	$2,$0,$L4729
	lw	$2,128($sp)

	lbu	$2,9102($16)
$L4767:
	bne	$2,$0,$L4587
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7064($2)
	bne	$2,$0,$L4730
	lw	$2,128($sp)

	lbu	$2,9103($16)
$L4766:
	bne	$2,$0,$L4589
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7096($2)
	bne	$2,$0,$L4731
	lw	$2,128($sp)

	lbu	$2,9108($16)
$L4765:
	bne	$2,$0,$L4591
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7128($2)
	bne	$2,$0,$L4732
	lw	$2,128($sp)

	lbu	$2,9109($16)
$L4764:
	bne	$2,$0,$L4593
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7160($2)
	bne	$2,$0,$L4733
	lw	$2,128($sp)

	lbu	$2,9116($16)
$L4763:
	bne	$2,$0,$L4595
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7192($2)
	bne	$2,$0,$L4734
	lw	$2,128($sp)

	lbu	$2,9117($16)
$L4762:
	bne	$2,$0,$L4597
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7224($2)
	bne	$2,$0,$L4735
	lw	$2,128($sp)

	lbu	$2,9110($16)
$L4761:
	bne	$2,$0,$L4599
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7256($2)
	bne	$2,$0,$L4736
	lw	$2,128($sp)

	lbu	$2,9111($16)
$L4760:
	bne	$2,$0,$L4601
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7288($2)
	bne	$2,$0,$L4737
	lw	$2,128($sp)

	lbu	$2,9118($16)
$L4759:
	bne	$2,$0,$L4603
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7320($2)
	bne	$2,$0,$L4738
	lw	$2,128($sp)

	lbu	$2,9119($16)
$L4758:
	bne	$2,$0,$L4739
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7352($2)
	bne	$2,$0,$L4740
	lw	$2,128($sp)

$L4572:
	lw	$2,56($16)
$L4750:
	andi	$2,$2,0x2000
	bne	$2,$0,$L4541
	nop

	lw	$10,168($sp)
	sw	$19,52($sp)
	beq	$10,$0,$L4657
	sw	$20,56($sp)

	lw	$fp,2164($16)
	sw	$fp,144($sp)
$L4658:
	lw	$9,176($sp)
	beq	$9,$0,$L4663
	li	$2,131072			# 0x20000

	lbu	$3,9089($16)
	ori	$4,$2,0x1ad8
	addu	$4,$16,$4
	bne	$3,$0,$L4664
	sw	$4,128($sp)

	addu	$2,$16,$2
	lh	$2,7384($2)
	beq	$2,$0,$L4665
	addiu	$5,$4,512

	lw	$2,64($17)
	lw	$4,52($sp)
	lw	$25,144($sp)
	addu	$4,$4,$2
	jalr	$25
	move	$6,$22

$L4665:
	lbu	$2,9090($16)
$L4768:
	bne	$2,$0,$L4666
	lw	$3,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7416($2)
	beq	$2,$0,$L4667
	lw	$4,52($sp)

	lw	$2,68($17)
	lw	$25,144($sp)
	addiu	$5,$3,544
	addu	$4,$4,$2
	jalr	$25
	move	$6,$22

$L4667:
	lbu	$2,9097($16)
$L4770:
	bne	$2,$0,$L4668
	lw	$3,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7448($2)
	beq	$2,$0,$L4669
	lw	$4,52($sp)

	lw	$2,72($17)
	lw	$25,144($sp)
	addiu	$5,$3,576
	addu	$4,$4,$2
	jalr	$25
	move	$6,$22

$L4669:
	lbu	$2,9098($16)
$L4769:
	bne	$2,$0,$L4670
	lw	$3,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7480($2)
	beq	$2,$0,$L4671
	lw	$4,52($sp)

	lw	$2,76($17)
	lw	$25,144($sp)
	addiu	$5,$3,608
	addu	$4,$4,$2
	jalr	$25
	move	$6,$22

$L4671:
	lbu	$2,9113($16)
$L4774:
	bne	$2,$0,$L4672
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7512($2)
	beq	$2,$0,$L4673
	lw	$2,128($sp)

	lw	$4,80($17)
	lw	$25,144($sp)
	addiu	$5,$2,640
	addu	$4,$20,$4
	jalr	$25
	move	$6,$22

$L4673:
	lbu	$2,9114($16)
$L4773:
	bne	$2,$0,$L4674
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7544($2)
	beq	$2,$0,$L4675
	lw	$2,128($sp)

	lw	$4,84($17)
	lw	$25,144($sp)
	addiu	$5,$2,672
	addu	$4,$20,$4
	jalr	$25
	move	$6,$22

$L4675:
	lbu	$2,9121($16)
$L4772:
	bne	$2,$0,$L4676
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7576($2)
	beq	$2,$0,$L4677
	lw	$2,128($sp)

	lw	$4,88($17)
	lw	$25,144($sp)
	addiu	$5,$2,704
	addu	$4,$20,$4
	jalr	$25
	move	$6,$22

$L4677:
	lbu	$2,9122($16)
$L4771:
	bne	$2,$0,$L4741
	lw	$2,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7608($2)
	beq	$2,$0,$L4541
	lw	$2,128($sp)

	lw	$4,92($17)
	lw	$25,144($sp)
	addiu	$5,$2,736
	addu	$4,$20,$4
	jalr	$25
	move	$6,$22

	b	$L4747
	li	$2,65536			# 0x10000

$L4545:
	lw	$2,8760($16)
	move	$4,$18
	addiu	$2,$2,2236
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$25,8($2)
	jalr	$25
	move	$5,$21

	lw	$4,176($sp)
	beq	$4,$0,$L4565
	lw	$5,168($sp)

	bne	$5,$0,$L4748
	li	$2,65536			# 0x10000

	li	$6,65536			# 0x10000
	lw	$2,2056($16)
	addu	$3,$16,$6
	lw	$3,-6332($3)
	sll	$2,$2,6
	addu	$2,$3,$2
	lw	$4,0($2)
	lui	$5,%hi(y_offset.11815)
	addiu	$2,$sp,60
	lui	$12,%hi(y_offset.11815+16)
	addiu	$5,$5,%lo(y_offset.11815)
	addiu	$12,$12,%lo(y_offset.11815+16)
	ori	$13,$6,0xdbc
	move	$3,$2
	ori	$14,$6,0xd6c
	ori	$15,$6,0xdac
	ori	$24,$6,0xd7c
$L4566:
	lw	$7,0($5)
	addiu	$5,$5,4
	addu	$6,$7,$13
	addu	$8,$7,$14
	addu	$9,$7,$15
	addu	$7,$7,$24
	sll	$8,$8,1
	sll	$9,$9,1
	sll	$7,$7,1
	sll	$6,$6,1
	addu	$9,$16,$9
	addu	$7,$16,$7
	addu	$6,$16,$6
	addu	$8,$16,$8
	lh	$11,0($9)
	lh	$10,0($7)
	lh	$8,0($8)
	lh	$7,0($6)
	subu	$6,$8,$11
	addu	$9,$7,$10
	addu	$8,$11,$8
	subu	$7,$10,$7
	subu	$11,$6,$7
	subu	$10,$8,$9
	addu	$6,$7,$6
	addu	$8,$9,$8
	sw	$8,0($3)
	sw	$6,4($3)
	sw	$11,8($3)
	sw	$10,12($3)
	bne	$5,$12,$L4566
	addiu	$3,$3,16

	li	$5,65536			# 0x10000
	lui	$3,%hi(x_offset.11814)
	lui	$13,%hi(x_offset.11814+16)
	addiu	$3,$3,%lo(x_offset.11814)
	addiu	$13,$13,%lo(x_offset.11814+16)
	ori	$14,$5,0xe0c
	ori	$15,$5,0xd6c
	ori	$24,$5,0xd8c
	ori	$25,$5,0xdec
$L4567:
	lw	$9,32($2)
	lw	$7,48($2)
	lw	$6,0($2)
	lw	$10,16($2)
	subu	$5,$6,$9
	addu	$8,$7,$10
	addu	$6,$9,$6
	subu	$10,$10,$7
	subu	$9,$5,$10
	subu	$7,$6,$8
	addu	$10,$10,$5
	addu	$6,$8,$6
	mul	$6,$6,$4
	mul	$10,$10,$4
	mul	$9,$9,$4
	mul	$7,$7,$4
	lw	$5,0($3)
	addiu	$6,$6,128
	addu	$8,$5,$14
	addu	$12,$5,$15
	addu	$11,$5,$24
	addu	$5,$5,$25
	sll	$12,$12,1
	sll	$11,$11,1
	addiu	$10,$10,128
	sll	$5,$5,1
	addiu	$9,$9,128
	sll	$8,$8,1
	addiu	$7,$7,128
	addu	$12,$16,$12
	sra	$6,$6,8
	addu	$11,$16,$11
	sra	$10,$10,8
	addu	$5,$16,$5
	sra	$9,$9,8
	addu	$8,$16,$8
	sra	$7,$7,8
	addiu	$3,$3,4
	sh	$6,0($12)
	addiu	$2,$2,4
	sh	$10,0($11)
	sh	$9,0($5)
	bne	$3,$13,$L4567
	sh	$7,0($8)

	b	$L4748
	li	$2,65536			# 0x10000

$L4571:
	lw	$12,148($sp)
	lw	$11,6140($16)
	lw	$3,6144($16)
	addiu	$2,$16,3492
	addiu	$8,$16,3516
	addiu	$9,$16,4552
	addiu	$10,$16,4592
	andi	$12,$12,0x1
	move	$4,$16
	move	$5,$18
	move	$6,$19
	move	$7,$20
	sw	$12,180($sp)
	sw	$11,16($sp)
	sw	$2,20($sp)
	sw	$3,24($sp)
	sw	$8,28($sp)
	sw	$9,32($sp)
	.option	pic0
	jal	hl_motion
	.option	pic2
	sw	$10,36($sp)

	b	$L4746
	lw	$13,180($sp)

$L4722:
	lw	$2,8756($16)
	addiu	$2,$2,2230
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$25,4($2)
	jalr	$25
	move	$5,$22

	lw	$2,8756($16)
	move	$4,$20
	addiu	$2,$2,2230
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$25,4($2)
	jalr	$25
	move	$5,$22

	b	$L4749
	lw	$13,148($sp)

$L4719:
	move	$4,$16
	move	$5,$2
	move	$6,$9
	move	$7,$8
	sw	$10,16($sp)
	sw	$11,20($sp)
	sw	$2,240($sp)
	sw	$3,236($sp)
	sw	$8,216($sp)
	sw	$9,232($sp)
	.option	pic0
	jal	xchg_pair_border
	.option	pic2
	sw	$0,24($sp)

	lw	$10,176($16)
	lw	$11,180($16)
	lw	$4,6172($16)
	lw	$9,232($sp)
	lw	$8,216($sp)
	lw	$3,236($sp)
	b	$L4703
	lw	$2,240($sp)

$L4527:
	sll	$4,$4,3
	addu	$4,$4,$6
	addiu	$4,$4,12
	addu	$4,$7,$4
	lw	$8,6172($16)
	lb	$6,0($4)
	andi	$8,$8,0x1
	addiu	$6,$6,16
	xor	$6,$6,$8
	sll	$8,$6,8
	addu	$6,$8,$6
	sll	$8,$6,16
	addu	$6,$6,$8
	sw	$6,24($4)
	sw	$6,0($4)
	sw	$6,8($4)
	sw	$6,16($4)
$L4717:
	b	$L4526
	lw	$6,5944($10)

$L4663:
	lbu	$3,9089($16)
	ori	$fp,$2,0x1ad8
	bne	$3,$0,$L4681
	addu	$fp,$16,$fp

	addu	$2,$16,$2
	lh	$2,7384($2)
	beq	$2,$0,$L4680
	nop

$L4681:
	lw	$3,2056($16)
	lui	$2,%hi(chroma_qp)
	addiu	$2,$2,%lo(chroma_qp)
	addu	$2,$3,$2
	lbu	$7,12($2)
	lw	$4,52($sp)
	lw	$2,64($17)
	addiu	$7,$7,-12
	addu	$4,$4,$2
	addiu	$5,$fp,512
	li	$2,2			# 0x2
	move	$6,$22
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4680:
	lbu	$2,9090($16)
	bne	$2,$0,$L4684
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7416($2)
	beq	$2,$0,$L4683
	nop

$L4684:
	lw	$3,2056($16)
	lui	$2,%hi(chroma_qp)
	addiu	$2,$2,%lo(chroma_qp)
	addu	$2,$3,$2
	lbu	$7,12($2)
	lw	$4,52($sp)
	lw	$2,68($17)
	addiu	$7,$7,-12
	addu	$4,$4,$2
	addiu	$5,$fp,544
	li	$2,2			# 0x2
	move	$6,$22
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4683:
	lbu	$2,9097($16)
	bne	$2,$0,$L4687
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7448($2)
	beq	$2,$0,$L4686
	nop

$L4687:
	lw	$3,2056($16)
	lui	$2,%hi(chroma_qp)
	addiu	$2,$2,%lo(chroma_qp)
	addu	$2,$3,$2
	lbu	$7,12($2)
	lw	$4,52($sp)
	lw	$2,72($17)
	addiu	$7,$7,-12
	addu	$4,$4,$2
	addiu	$5,$fp,576
	li	$2,2			# 0x2
	move	$6,$22
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4686:
	lbu	$2,9098($16)
	bne	$2,$0,$L4690
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7480($2)
	beq	$2,$0,$L4689
	nop

$L4690:
	lw	$3,2056($16)
	lui	$2,%hi(chroma_qp)
	addiu	$2,$2,%lo(chroma_qp)
	addu	$2,$3,$2
	lbu	$7,12($2)
	lw	$4,52($sp)
	lw	$2,76($17)
	addiu	$7,$7,-12
	addu	$4,$4,$2
	addiu	$5,$fp,608
	li	$2,2			# 0x2
	move	$6,$22
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4689:
	lbu	$2,9113($16)
	bne	$2,$0,$L4693
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7512($2)
	beq	$2,$0,$L4692
	nop

$L4693:
	lw	$3,2056($16)
	lui	$2,%hi(chroma_qp)
	addiu	$2,$2,%lo(chroma_qp)
	addu	$2,$3,$2
	lbu	$7,12($2)
	lw	$4,80($17)
	li	$2,2			# 0x2
	addiu	$7,$7,-12
	addu	$4,$20,$4
	addiu	$5,$fp,640
	move	$6,$22
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4692:
	lbu	$2,9114($16)
	bne	$2,$0,$L4696
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7544($2)
	beq	$2,$0,$L4695
	nop

$L4696:
	lw	$3,2056($16)
	lui	$2,%hi(chroma_qp)
	addiu	$2,$2,%lo(chroma_qp)
	addu	$2,$3,$2
	lbu	$7,12($2)
	lw	$4,84($17)
	li	$2,2			# 0x2
	addiu	$7,$7,-12
	addu	$4,$20,$4
	addiu	$5,$fp,672
	move	$6,$22
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4695:
	lbu	$2,9121($16)
	bne	$2,$0,$L4699
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7576($2)
	beq	$2,$0,$L4698
	nop

$L4699:
	lw	$3,2056($16)
	lui	$2,%hi(chroma_qp)
	addiu	$2,$2,%lo(chroma_qp)
	addu	$2,$3,$2
	lbu	$7,12($2)
	lw	$4,88($17)
	li	$2,2			# 0x2
	addiu	$7,$7,-12
	addu	$4,$20,$4
	addiu	$5,$fp,704
	move	$6,$22
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4698:
	lbu	$2,9122($16)
	bne	$2,$0,$L4700
	nop

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7608($2)
	beq	$2,$0,$L4541
	nop

$L4700:
	lw	$3,2056($16)
	lui	$2,%hi(chroma_qp)
	addiu	$2,$2,%lo(chroma_qp)
	addu	$2,$3,$2
	lw	$4,92($17)
	lbu	$7,12($2)
	addu	$4,$20,$4
	li	$2,2			# 0x2
	addiu	$5,$fp,736
	addiu	$7,$7,-12
	move	$6,$22
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

	b	$L4747
	li	$2,65536			# 0x10000

$L4657:
	lw	$11,152($sp)
	li	$3,1			# 0x1
	li	$2,4			# 0x4
	movn	$2,$3,$11
	addiu	$4,$2,14800
	sll	$4,$4,2
	li	$2,131072			# 0x20000
	addu	$4,$16,$4
	ori	$3,$2,0x1cd8
	lw	$5,8740($16)
	addu	$3,$16,$3
	lw	$8,4($4)
	addu	$4,$16,$2
	lh	$11,7384($4)
	lh	$10,64($3)
	lh	$6,32($3)
	lh	$7,96($3)
	sll	$5,$5,6
	addu	$5,$8,$5
	addu	$9,$7,$10
	addu	$8,$6,$11
	lw	$5,0($5)
	subu	$7,$10,$7
	subu	$6,$11,$6
	subu	$12,$8,$9
	subu	$11,$6,$7
	addu	$10,$9,$8
	addu	$6,$7,$6
	lw	$9,152($sp)
	mul	$8,$6,$5
	mul	$11,$11,$5
	mul	$10,$10,$5
	li	$7,2			# 0x2
	mul	$5,$12,$5
	li	$6,5			# 0x5
	movn	$6,$7,$9
	addiu	$7,$6,14800
	sll	$7,$7,2
	sra	$10,$10,7
	sra	$8,$8,7
	sra	$5,$5,7
	sra	$9,$11,7
	lw	$6,8744($16)
	ori	$2,$2,0x1d58
	addu	$7,$16,$7
	sh	$10,7384($4)
	addu	$2,$16,$2
	sh	$8,32($3)
	sh	$9,96($3)
	sh	$5,64($3)
	lw	$7,4($7)
	lh	$10,7512($4)
	lh	$9,64($2)
	lh	$5,32($2)
	sll	$3,$6,6
	lh	$6,96($2)
	addu	$3,$7,$3
	addu	$8,$6,$9
	lw	$3,0($3)
	addu	$7,$5,$10
	subu	$6,$9,$6
	subu	$5,$10,$5
	subu	$9,$5,$6
	subu	$10,$7,$8
	addu	$5,$6,$5
	addu	$7,$8,$7
	mul	$9,$9,$3
	mul	$7,$7,$3
	mul	$5,$5,$3
	mul	$3,$10,$3
	lw	$8,5124($16)
	sra	$7,$7,7
	sra	$5,$5,7
	sra	$3,$3,7
	sra	$6,$9,7
	sh	$7,7512($4)
	lw	$fp,5116($16)
	sw	$8,144($sp)
	sh	$6,96($2)
	sh	$5,32($2)
	b	$L4658
	sh	$3,64($2)

$L4573:
	lbu	$3,9092($16)
	ori	$fp,$2,0x1ad8
	bne	$3,$0,$L4613
	addu	$fp,$16,$fp

	addu	$2,$16,$2
	lh	$2,6872($2)
	beq	$2,$0,$L4612
	nop

$L4613:
	lw	$4,0($17)
	lw	$3,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$3
	addu	$4,$18,$4
	move	$5,$fp
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4612:
	lbu	$2,9093($16)
	bne	$2,$0,$L4616
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,6904($2)
	beq	$2,$0,$L4615
	nop

$L4616:
	lw	$4,4($17)
	lw	$5,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$5
	addu	$4,$18,$4
	addiu	$5,$fp,32
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4615:
	lbu	$2,9100($16)
	bne	$2,$0,$L4619
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,6936($2)
	beq	$2,$0,$L4618
	nop

$L4619:
	lw	$4,8($17)
	lw	$6,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$6
	addu	$4,$18,$4
	addiu	$5,$fp,64
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4618:
	lbu	$2,9101($16)
	bne	$2,$0,$L4622
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,6968($2)
	beq	$2,$0,$L4621
	nop

$L4622:
	lw	$4,12($17)
	lw	$8,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$8
	addu	$4,$18,$4
	addiu	$5,$fp,96
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4621:
	lbu	$2,9094($16)
	bne	$2,$0,$L4625
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7000($2)
	beq	$2,$0,$L4624
	nop

$L4625:
	lw	$4,16($17)
	lw	$9,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$9
	addu	$4,$18,$4
	addiu	$5,$fp,128
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4624:
	lbu	$2,9095($16)
	bne	$2,$0,$L4628
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7032($2)
	beq	$2,$0,$L4627
	nop

$L4628:
	lw	$4,20($17)
	lw	$10,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$10
	addu	$4,$18,$4
	addiu	$5,$fp,160
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4627:
	lbu	$2,9102($16)
	bne	$2,$0,$L4631
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7064($2)
	beq	$2,$0,$L4630
	nop

$L4631:
	lw	$4,24($17)
	lw	$11,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$11
	addu	$4,$18,$4
	addiu	$5,$fp,192
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4630:
	lbu	$2,9103($16)
	bne	$2,$0,$L4634
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7096($2)
	beq	$2,$0,$L4633
	nop

$L4634:
	lw	$4,28($17)
	lw	$12,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$12
	addu	$4,$18,$4
	addiu	$5,$fp,224
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4633:
	lbu	$2,9108($16)
	bne	$2,$0,$L4637
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7128($2)
	beq	$2,$0,$L4636
	nop

$L4637:
	lw	$4,32($17)
	lw	$13,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$13
	addu	$4,$18,$4
	addiu	$5,$fp,256
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4636:
	lbu	$2,9109($16)
	bne	$2,$0,$L4640
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7160($2)
	beq	$2,$0,$L4639
	nop

$L4640:
	lw	$4,36($17)
	lw	$14,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$14
	addu	$4,$18,$4
	addiu	$5,$fp,288
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4639:
	lbu	$2,9116($16)
	bne	$2,$0,$L4643
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7192($2)
	beq	$2,$0,$L4642
	nop

$L4643:
	lw	$4,40($17)
	lw	$25,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$25
	addu	$4,$18,$4
	addiu	$5,$fp,320
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4642:
	lbu	$2,9117($16)
	bne	$2,$0,$L4646
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7224($2)
	beq	$2,$0,$L4645
	nop

$L4646:
	lw	$4,44($17)
	lw	$3,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$3
	addu	$4,$18,$4
	addiu	$5,$fp,352
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4645:
	lbu	$2,9110($16)
	bne	$2,$0,$L4649
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7256($2)
	beq	$2,$0,$L4648
	nop

$L4649:
	lw	$4,48($17)
	lw	$5,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$5
	addu	$4,$18,$4
	addiu	$5,$fp,384
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4648:
	lbu	$2,9111($16)
	bne	$2,$0,$L4652
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7288($2)
	beq	$2,$0,$L4651
	nop

$L4652:
	lw	$4,52($17)
	lw	$6,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$6
	addu	$4,$18,$4
	addiu	$5,$fp,416
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4651:
	lbu	$2,9118($16)
	bne	$2,$0,$L4655
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7320($2)
	beq	$2,$0,$L4654
	nop

$L4655:
	lw	$4,56($17)
	lw	$8,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$8
	addu	$4,$18,$4
	addiu	$5,$fp,448
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

$L4654:
	lbu	$2,9119($16)
	bne	$2,$0,$L4656
	nop

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7352($2)
	beq	$2,$0,$L4572
	nop

$L4656:
	lw	$4,60($17)
	lw	$9,152($sp)
	lw	$7,2056($16)
	sltu	$2,$0,$9
	addu	$4,$18,$4
	addiu	$5,$fp,480
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$2,16($sp)

	b	$L4750
	lw	$2,56($16)

$L4574:
	li	$3,16777216			# 0x1000000
	and	$3,$2,$3
	li	$9,1			# 0x1
	li	$2,4			# 0x4
	movn	$9,$2,$3
	li	$3,131072			# 0x20000
	ori	$3,$3,0x1ad8
	lui	$2,%hi(scan8)
	addiu	$2,$2,%lo(scan8)
	addu	$3,$16,$3
	sw	$2,128($sp)
	sll	$12,$9,2
	move	$7,$17
	sll	$11,$9,5
	move	$10,$3
	move	$2,$0
$L4610:
	lw	$5,128($sp)
	move	$6,$21
	addu	$4,$5,$2
	lbu	$4,0($4)
	addu	$4,$16,$4
	lbu	$4,9080($4)
	beq	$4,$0,$L4608
	move	$5,$3

	sll	$8,$2,5
	addu	$8,$16,$8
	li	$13,131072			# 0x20000
	li	$14,1			# 0x1
	bne	$4,$14,$L4609
	addu	$8,$13,$8

	lh	$4,6872($8)
	bne	$4,$0,$L4742
	move	$25,$fp

$L4609:
	lw	$4,0($7)
	lw	$25,144($sp)
	sw	$2,240($sp)
	sw	$3,236($sp)
	sw	$7,228($sp)
	sw	$9,232($sp)
	sw	$10,216($sp)
	sw	$11,220($sp)
	sw	$12,224($sp)
	jalr	$25
	addu	$4,$18,$4

	lw	$12,224($sp)
	lw	$11,220($sp)
	lw	$10,216($sp)
	lw	$9,232($sp)
	lw	$7,228($sp)
	lw	$3,236($sp)
	lw	$2,240($sp)
$L4608:
	addu	$2,$2,$9
	slt	$4,$2,16
	addu	$7,$7,$12
	addu	$10,$10,$11
	bne	$4,$0,$L4610
	addu	$3,$3,$11

	b	$L4750
	lw	$2,56($16)

$L4547:
	ori	$2,$2,0x1ad8
	addu	$2,$16,$2
	sw	$2,184($sp)
	lui	$2,%hi(scan8)
	addiu	$2,$2,%lo(scan8)
	sw	$2,128($sp)
	li	$2,4			# 0x4
	subu	$2,$2,$21
	lw	$5,184($sp)
	li	$6,3			# 0x3
	sw	$2,188($sp)
	move	$4,$0
	move	$2,$0
	subu	$6,$6,$21
	addiu	$7,$sp,48
	sw	$19,200($sp)
	sw	$20,204($sp)
	sw	$22,208($sp)
	move	$19,$16
	move	$22,$18
	sw	$6,192($sp)
	sw	$7,196($sp)
	move	$20,$5
	move	$18,$4
	sw	$17,212($sp)
	b	$L4564
	move	$16,$2

$L4745:
	li	$10,7			# 0x7
	beq	$4,$10,$L4558
	move	$5,$0

$L4559:
	addiu	$4,$4,2204
	sll	$4,$4,2
	addu	$4,$19,$4
	lw	$25,4($4)
	sw	$2,240($sp)
	move	$4,$2
	sw	$3,236($sp)
	jalr	$25
	move	$6,$21

	lw	$3,236($sp)
	lbu	$3,9080($3)
	beq	$3,$0,$L4561
	lw	$2,240($sp)

	lw	$13,176($sp)
	beq	$13,$0,$L4562
	li	$14,1			# 0x1

	bne	$3,$14,$L4782
	move	$4,$2

	lh	$3,0($20)
	bne	$3,$0,$L4786
	lw	$25,184($sp)

$L4782:
	lw	$2,184($sp)
	lw	$25,144($sp)
	addu	$5,$18,$2
	jalr	$25
	move	$6,$21

$L4561:
	addiu	$16,$16,1
$L4751:
	li	$3,16			# 0x10
	addiu	$17,$17,4
	addiu	$18,$18,32
	beq	$16,$3,$L4744
	addiu	$20,$20,32

$L4564:
	lw	$8,128($sp)
	li	$9,3			# 0x3
	addu	$2,$8,$16
	lbu	$3,0($2)
	lw	$2,0($17)
	addu	$3,$19,$3
	lb	$4,8776($3)
	bne	$4,$9,$L4745
	addu	$2,$22,$2

$L4558:
	lw	$5,8988($19)
	sll	$5,$5,$16
	andi	$5,$5,0x8000
	bne	$5,$0,$L4560
	lw	$12,188($sp)

	lw	$11,192($sp)
	addu	$5,$2,$11
	lbu	$6,0($5)
	lw	$5,196($sp)
	sll	$7,$6,8
	addu	$6,$7,$6
	sll	$7,$6,16
	addu	$6,$6,$7
	b	$L4559
	sw	$6,48($sp)

$L4560:
	b	$L4559
	addu	$5,$2,$12

$L4562:
	move	$4,$2
	lw	$2,184($sp)
	lw	$7,2056($19)
	addu	$5,$18,$2
	move	$6,$21
	.option	pic0
	jal	svq3_add_idct_c
	.option	pic2
	sw	$0,16($sp)

	b	$L4751
	addiu	$16,$16,1

$L4742:
	lw	$4,0($7)
	move	$5,$10
	sw	$2,240($sp)
	sw	$3,236($sp)
	sw	$7,228($sp)
	sw	$9,232($sp)
	sw	$10,216($sp)
	sw	$11,220($sp)
	sw	$12,224($sp)
	jalr	$25
	addu	$4,$18,$4

	lw	$2,240($sp)
	lw	$3,236($sp)
	lw	$7,228($sp)
	lw	$9,232($sp)
	lw	$10,216($sp)
	lw	$11,220($sp)
	b	$L4608
	lw	$12,224($sp)

$L4744:
	move	$18,$22
	move	$16,$19
	lw	$20,204($sp)
	lw	$22,208($sp)
	lw	$17,212($sp)
	b	$L4546
	lw	$19,200($sp)

$L4721:
	move	$4,$16
	move	$5,$18
	move	$6,$19
	move	$7,$20
	sw	$2,24($sp)
	sw	$21,16($sp)
	sw	$22,20($sp)
	.option	pic0
	jal	xchg_mb_border
	.option	pic2
	sw	$0,28($sp)

	b	$L4752
	lw	$2,56($16)

$L4724:
	lw	$4,0($17)
	addu	$4,$18,$4
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4753
	lbu	$2,9093($16)

$L4728:
	lw	$4,16($17)
	addu	$4,$18,$4
	addiu	$5,$2,128
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4754
	lbu	$2,9095($16)

$L4727:
	lw	$4,12($17)
	addu	$4,$18,$4
	addiu	$5,$2,96
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4755
	lbu	$2,9094($16)

$L4726:
	lw	$4,8($17)
	addu	$4,$18,$4
	addiu	$5,$2,64
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4756
	lbu	$2,9101($16)

$L4725:
	lw	$4,4($17)
	addu	$4,$18,$4
	addiu	$5,$2,32
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4757
	lbu	$2,9100($16)

$L4740:
	lw	$4,60($17)
	addu	$4,$18,$4
	addiu	$5,$2,480
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4750
	lw	$2,56($16)

$L4738:
	lw	$4,56($17)
	addu	$4,$18,$4
	addiu	$5,$2,448
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4758
	lbu	$2,9119($16)

$L4737:
	lw	$4,52($17)
	addu	$4,$18,$4
	addiu	$5,$2,416
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4759
	lbu	$2,9118($16)

$L4736:
	lw	$4,48($17)
	addu	$4,$18,$4
	addiu	$5,$2,384
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4760
	lbu	$2,9111($16)

$L4735:
	lw	$4,44($17)
	addu	$4,$18,$4
	addiu	$5,$2,352
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4761
	lbu	$2,9110($16)

$L4734:
	lw	$4,40($17)
	addu	$4,$18,$4
	addiu	$5,$2,320
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4762
	lbu	$2,9117($16)

$L4733:
	lw	$4,36($17)
	addu	$4,$18,$4
	addiu	$5,$2,288
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4763
	lbu	$2,9116($16)

$L4732:
	lw	$4,32($17)
	addu	$4,$18,$4
	addiu	$5,$2,256
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4764
	lbu	$2,9109($16)

$L4731:
	lw	$4,28($17)
	addu	$4,$18,$4
	addiu	$5,$2,224
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4765
	lbu	$2,9108($16)

$L4730:
	lw	$4,24($17)
	addu	$4,$18,$4
	addiu	$5,$2,192
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4766
	lbu	$2,9103($16)

$L4729:
	lw	$4,20($17)
	addu	$4,$18,$4
	addiu	$5,$2,160
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4767
	lbu	$2,9102($16)

$L4664:
	lw	$2,64($17)
	lw	$3,128($sp)
	lw	$4,52($sp)
	addiu	$5,$3,512
	addu	$4,$4,$2
	move	$25,$fp
	jalr	$25
	move	$6,$22

	b	$L4768
	lbu	$2,9090($16)

$L4668:
	lw	$2,72($17)
	lw	$4,52($sp)
	addiu	$5,$3,576
	addu	$4,$4,$2
	move	$25,$fp
	jalr	$25
	move	$6,$22

	b	$L4769
	lbu	$2,9098($16)

$L4666:
	lw	$2,68($17)
	lw	$4,52($sp)
	addiu	$5,$3,544
	addu	$4,$4,$2
	move	$25,$fp
	jalr	$25
	move	$6,$22

	b	$L4770
	lbu	$2,9097($16)

$L4676:
	lw	$4,88($17)
	addu	$4,$20,$4
	addiu	$5,$2,704
	move	$25,$fp
	jalr	$25
	move	$6,$22

	b	$L4771
	lbu	$2,9122($16)

$L4674:
	lw	$4,84($17)
	addu	$4,$20,$4
	addiu	$5,$2,672
	move	$25,$fp
	jalr	$25
	move	$6,$22

	b	$L4772
	lbu	$2,9121($16)

$L4672:
	lw	$4,80($17)
	addu	$4,$20,$4
	addiu	$5,$2,640
	move	$25,$fp
	jalr	$25
	move	$6,$22

	b	$L4773
	lbu	$2,9114($16)

$L4670:
	lw	$2,76($17)
	lw	$4,52($sp)
	addiu	$5,$3,608
	addu	$4,$4,$2
	move	$25,$fp
	jalr	$25
	move	$6,$22

	b	$L4774
	lbu	$2,9113($16)

$L4741:
	lw	$4,92($17)
	addu	$4,$20,$4
	addiu	$5,$2,736
	move	$25,$fp
	jalr	$25
	move	$6,$22

	b	$L4747
	li	$2,65536			# 0x10000

$L4786:
	addu	$5,$18,$25
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4751
	addiu	$16,$16,1

$L4579:
	lw	$4,8($17)
	lw	$25,144($sp)
	addiu	$5,$2,64
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4756
	lbu	$2,9101($16)

$L4589:
	lw	$4,28($17)
	lw	$25,144($sp)
	addiu	$5,$2,224
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4765
	lbu	$2,9108($16)

$L4587:
	lw	$4,24($17)
	lw	$25,144($sp)
	addiu	$5,$2,192
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4766
	lbu	$2,9103($16)

$L4555:
	addu	$3,$16,$3
	lh	$3,7128($3)
	beq	$3,$0,$L4783
	move	$4,$2

	lw	$2,128($sp)
	move	$6,$21
	move	$25,$fp
	jalr	$25
	addiu	$5,$2,256

	b	$L4775
	addiu	$3,$16,30

$L4552:
	addu	$3,$16,$3
	lh	$3,7000($3)
	beq	$3,$0,$L4784
	move	$4,$2

	lw	$2,128($sp)
	move	$6,$21
	move	$25,$fp
	jalr	$25
	addiu	$5,$2,128

	b	$L4776
	addiu	$3,$16,28

$L4593:
	lw	$4,36($17)
	lw	$25,144($sp)
	addiu	$5,$2,288
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4763
	lbu	$2,9116($16)

$L4591:
	lw	$4,32($17)
	lw	$25,144($sp)
	addiu	$5,$2,256
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4764
	lbu	$2,9109($16)

$L4597:
	lw	$4,44($17)
	lw	$25,144($sp)
	addiu	$5,$2,352
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4761
	lbu	$2,9110($16)

$L4595:
	lw	$4,40($17)
	lw	$25,144($sp)
	addiu	$5,$2,320
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4762
	lbu	$2,9117($16)

$L4601:
	lw	$4,52($17)
	lw	$25,144($sp)
	addiu	$5,$2,416
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4759
	lbu	$2,9118($16)

$L4599:
	lw	$4,48($17)
	lw	$25,144($sp)
	addiu	$5,$2,384
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4760
	lbu	$2,9111($16)

$L4739:
	lw	$4,60($17)
	lw	$25,144($sp)
	addiu	$5,$2,480
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4750
	lw	$2,56($16)

$L4603:
	lw	$4,56($17)
	lw	$25,144($sp)
	addiu	$5,$2,448
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4758
	lbu	$2,9119($16)

$L4565:
	lw	$3,2056($16)
	lui	$2,%hi(svq3_dequant_coeff)
	sll	$3,$3,2
	addiu	$2,$2,%lo(svq3_dequant_coeff)
	addu	$2,$3,$2
	lw	$5,0($2)
	li	$2,131072			# 0x20000
	addiu	$3,$sp,60
	ori	$2,$2,0x1ad8
	lui	$6,%hi(y_offset.21450)
	addu	$2,$16,$2
	addiu	$6,$6,%lo(y_offset.21450)
	move	$4,$3
	mtlo	$3
$L4568:
	lw	$7,0($6)
	addiu	$6,$6,4
	addiu	$9,$7,64
	addiu	$8,$7,80
	sll	$10,$7,1
	sll	$9,$9,1
	addiu	$7,$7,16
	addu	$9,$2,$9
	addu	$10,$2,$10
	sll	$7,$7,1
	sll	$8,$8,1
	lh	$11,0($9)
	lh	$10,0($10)
	addu	$7,$2,$7
	addu	$8,$2,$8
	lh	$7,0($7)
	lh	$8,0($8)
	subu	$9,$10,$11
	sll	$12,$8,4
	addu	$10,$11,$10
	sll	$14,$8,3
	sll	$11,$7,3
	sll	$13,$7,4
	sll	$15,$9,2
	sll	$24,$9,4
	subu	$14,$14,$8
	addu	$13,$13,$7
	addu	$8,$12,$8
	subu	$7,$11,$7
	subu	$15,$24,$15
	addu	$15,$15,$9
	subu	$7,$7,$8
	sll	$25,$10,2
	sll	$3,$10,4
	subu	$12,$15,$7
	subu	$25,$3,$25
	addu	$7,$15,$7
	addu	$25,$25,$10
	addu	$13,$14,$13
	sw	$7,4($4)
	lui	$7,%hi(y_offset.21450+16)
	subu	$11,$25,$13
	addiu	$7,$7,%lo(y_offset.21450+16)
	addu	$13,$13,$25
	sw	$13,0($4)
	sw	$12,8($4)
	sw	$11,12($4)
	bne	$6,$7,$L4568
	addiu	$4,$4,16

	lui	$6,%hi(x_offset.21449)
	mflo	$3
	addiu	$6,$6,%lo(x_offset.21449)
	li	$4,524288			# 0x80000
	sw	$16,184($sp)
$L4569:
	lw	$11,32($3)
	lw	$10,0($3)
	lw	$7,16($3)
	subu	$9,$10,$11
	addu	$10,$11,$10
	sll	$11,$10,4
	lw	$8,48($3)
	sw	$11,128($sp)
	lw	$16,128($sp)
	sll	$25,$10,2
	sll	$15,$9,2
	sll	$24,$9,4
	sll	$12,$8,4
	sll	$11,$7,3
	sll	$14,$8,3
	sll	$13,$7,4
	subu	$14,$14,$8
	subu	$25,$16,$25
	addu	$13,$13,$7
	addu	$8,$12,$8
	subu	$7,$11,$7
	subu	$15,$24,$15
	addu	$13,$14,$13
	addu	$25,$25,$10
	subu	$8,$7,$8
	addu	$15,$15,$9
	subu	$11,$25,$13
	subu	$9,$15,$8
	addu	$25,$13,$25
	addu	$8,$15,$8
	mul	$10,$25,$5
	mul	$12,$8,$5
	mul	$13,$9,$5
	mul	$14,$11,$5
	lw	$7,0($6)
	addu	$25,$10,$4
	addu	$8,$12,$4
	addiu	$10,$7,160
	addiu	$12,$7,32
	addu	$9,$13,$4
	addiu	$13,$7,128
	addu	$11,$14,$4
	sll	$12,$12,1
	sll	$13,$13,1
	sll	$10,$10,1
	sll	$7,$7,1
	lui	$16,%hi(x_offset.21449+16)
	addu	$7,$2,$7
	sra	$25,$25,20
	addu	$12,$2,$12
	sra	$8,$8,20
	addu	$13,$2,$13
	sra	$9,$9,20
	addu	$10,$2,$10
	sra	$11,$11,20
	addiu	$6,$6,4
	addiu	$16,$16,%lo(x_offset.21449+16)
	sh	$25,0($7)
	addiu	$3,$3,4
	sh	$8,0($12)
	sh	$9,0($13)
	bne	$6,$16,$L4569
	sh	$11,0($10)

	b	$L4546
	lw	$16,184($sp)

$L4585:
	lw	$4,20($17)
	lw	$25,144($sp)
	addiu	$5,$2,160
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4767
	lbu	$2,9102($16)

$L4583:
	lw	$4,16($17)
	lw	$25,144($sp)
	addiu	$5,$2,128
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4754
	lbu	$2,9095($16)

$L4581:
	lw	$4,12($17)
	lw	$25,144($sp)
	addiu	$5,$2,96
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4755
	lbu	$2,9094($16)

$L4577:
	lw	$4,4($17)
	lw	$25,144($sp)
	addiu	$5,$2,32
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4757
	lbu	$2,9100($16)

$L4575:
	lw	$4,0($17)
	lw	$5,128($sp)
	lw	$25,144($sp)
	addu	$4,$18,$4
	jalr	$25
	move	$6,$21

	b	$L4753
	lbu	$2,9093($16)

$L4549:
	lh	$3,6872($9)
	beq	$3,$0,$L4785
	lw	$5,128($sp)

	move	$4,$2
	move	$25,$fp
	jalr	$25
	move	$6,$21

	b	$L4777
	addiu	$3,$16,14

$L4723:
	move	$6,$21
	move	$25,$fp
	jalr	$25
	addiu	$5,$2,384

	b	$L4748
	li	$2,65536			# 0x10000

	.set	macro
	.set	reorder
	.end	hl_decode_mb_complex
	.size	hl_decode_mb_complex, .-hl_decode_mb_complex
	.align	2
	.set	nomips16
	.ent	hl_decode_mb_simple
	.type	hl_decode_mb_simple, @function
hl_decode_mb_simple:
	.frame	$sp,368,$31		# vars= 280, regs= 10/0, args= 40, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lw	$2,6172($4)
	lw	$3,152($4)
	addiu	$sp,$sp,-368
	mul	$5,$2,$3
	sw	$23,356($sp)
	lw	$23,6168($4)
	sw	$16,328($sp)
	addu	$3,$5,$23
	move	$16,$4
	lw	$4,1568($4)
	sw	$2,140($sp)
	sll	$3,$3,2
	lw	$2,2056($16)
	addu	$3,$4,$3
	sw	$22,352($sp)
	sw	$31,364($sp)
	sw	$fp,360($sp)
	sw	$21,348($sp)
	sw	$20,344($sp)
	sw	$19,340($sp)
	sw	$18,336($sp)
	sw	$17,332($sp)
	beq	$2,$0,$L4788
	lw	$22,0($3)

	sw	$0,148($sp)
$L4789:
	lw	$5,176($16)
	andi	$2,$23,0x3
	sll	$4,$5,2
	mul	$4,$4,$2
	lw	$2,140($sp)
	lw	$21,180($16)
	mul	$3,$2,$5
	lw	$2,1464($16)
	addu	$19,$3,$23
	lw	$3,140($sp)
	sll	$19,$19,4
	mul	$6,$3,$21
	addu	$19,$2,$19
	addu	$21,$6,$23
	lw	$2,1468($16)
	lw	$20,1472($16)
	lw	$25,5148($16)
	addiu	$4,$4,64
	sll	$21,$21,3
	addu	$4,$19,$4
	li	$6,4			# 0x4
	addu	$20,$20,$21
	jalr	$25
	addu	$21,$2,$21

	lw	$4,6168($16)
	lw	$2,180($16)
	andi	$4,$4,0x7
	mul	$4,$4,$2
	lw	$25,5148($16)
	addiu	$4,$4,64
	addu	$4,$21,$4
	subu	$5,$20,$21
	jalr	$25
	li	$6,2			# 0x2

	lw	$18,176($16)
	lw	$17,180($16)
	lw	$2,148($sp)
	sw	$18,9756($16)
	beq	$2,$0,$L4790
	sw	$17,9760($16)

	li	$2,16777216			# 0x1000000
	and	$2,$22,$2
	beq	$2,$0,$L4791
	andi	$10,$22,0x7

	lw	$3,2160($16)
	sw	$3,168($sp)
	sw	$3,128($sp)
	bne	$10,$0,$L4898
	sw	$10,156($sp)

$L4794:
	lw	$11,6140($16)
	lw	$9,6144($16)
	addiu	$10,$16,3492
	addiu	$8,$16,3516
	addiu	$3,$16,4552
	addiu	$2,$16,4592
	andi	$12,$22,0x1
	move	$4,$16
	move	$5,$19
	move	$6,$21
	move	$7,$20
	sw	$12,144($sp)
	sw	$11,16($sp)
	sw	$10,20($sp)
	sw	$9,24($sp)
	sw	$8,28($sp)
	sw	$3,32($sp)
	.option	pic0
	jal	hl_motion
	.option	pic2
	sw	$2,36($sp)

	lw	$14,144($sp)
	beq	$14,$0,$L4975
	andi	$2,$22,0x2

$L4830:
	lw	$fp,148($sp)
$L4946:
	sw	$21,52($sp)
	beq	$fp,$0,$L4868
	sw	$20,56($sp)

	lw	$2,2164($16)
	sw	$2,128($sp)
	sw	$2,132($sp)
	lbu	$3,9089($16)
	li	$2,131072			# 0x20000
	ori	$fp,$2,0x1ad8
	bne	$3,$0,$L4874
	addu	$fp,$16,$fp

$L4932:
	addu	$2,$16,$2
	lh	$2,7384($2)
	bne	$2,$0,$L4900
	lw	$4,52($sp)

	lbu	$2,9090($16)
$L4952:
	bne	$2,$0,$L4876
	li	$2,131072			# 0x20000

$L4981:
	addu	$2,$16,$2
	lh	$2,7416($2)
	bne	$2,$0,$L4901
	lw	$4,52($sp)

	lbu	$2,9097($16)
$L4951:
	bne	$2,$0,$L4878
	li	$2,131072			# 0x20000

$L4982:
	addu	$2,$16,$2
	lh	$2,7448($2)
	bne	$2,$0,$L4902
	lw	$4,52($sp)

	lbu	$2,9098($16)
$L4950:
	bne	$2,$0,$L4880
	li	$2,131072			# 0x20000

$L4983:
	addu	$2,$16,$2
	lh	$2,7480($2)
	bne	$2,$0,$L4903
	lw	$4,52($sp)

	lbu	$2,9113($16)
$L4949:
	bne	$2,$0,$L4882
	li	$2,131072			# 0x20000

$L4984:
	addu	$2,$16,$2
	lh	$2,7512($2)
	bne	$2,$0,$L4904
	lw	$25,132($sp)

	lbu	$2,9114($16)
$L4948:
	bne	$2,$0,$L4884
	li	$2,131072			# 0x20000

$L4985:
	addu	$2,$16,$2
	lh	$2,7544($2)
	bne	$2,$0,$L4905
	lw	$25,132($sp)

	lbu	$2,9121($16)
$L4954:
	bne	$2,$0,$L4886
	li	$2,131072			# 0x20000

$L4986:
	addu	$2,$16,$2
	lh	$2,7576($2)
	bne	$2,$0,$L4906
	lw	$25,132($sp)

	lbu	$2,9122($16)
$L4953:
	bne	$2,$0,$L4907
	nop

$L4888:
	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7608($2)
	bne	$2,$0,$L4908
	lw	$25,132($sp)

	li	$2,65536			# 0x10000
$L4947:
	addu	$2,$16,$2
	lw	$2,5340($2)
	beq	$2,$0,$L4976
	lw	$31,364($sp)

	lw	$8,6168($16)
	lw	$7,8996($16)
	sll	$2,$8,5
	addu	$2,$7,$2
	lbu	$4,15($2)
	subu	$3,$19,$18
	sb	$4,9004($16)
	lbu	$5,15($19)
	sll	$4,$18,1
	sb	$5,9005($16)
	addu	$5,$3,$4
	lbu	$6,15($5)
	addu	$5,$4,$18
	sb	$6,9006($16)
	addu	$5,$3,$5
	lbu	$5,15($5)
	sll	$9,$18,2
	sb	$5,9007($16)
	addu	$5,$3,$9
	lbu	$6,15($5)
	addu	$5,$9,$18
	sb	$6,9008($16)
	addu	$5,$3,$5
	lbu	$10,15($5)
	sll	$5,$18,3
	subu	$6,$5,$4
	sb	$10,9009($16)
	addu	$6,$3,$6
	lbu	$10,15($6)
	subu	$6,$5,$18
	sb	$10,9010($16)
	addu	$6,$3,$6
	lbu	$10,15($6)
	addu	$6,$3,$5
	sb	$10,9011($16)
	lbu	$10,15($6)
	addu	$6,$5,$18
	sb	$10,9012($16)
	addu	$6,$3,$6
	lbu	$6,15($6)
	addu	$5,$4,$5
	sb	$6,9013($16)
	addu	$5,$3,$5
	sll	$6,$18,4
	lbu	$10,15($5)
	subu	$5,$6,$9
	subu	$9,$5,$18
	sb	$10,9014($16)
	addu	$9,$3,$9
	lbu	$10,15($9)
	addu	$9,$3,$5
	sb	$10,9015($16)
	lbu	$9,15($9)
	addu	$5,$5,$18
	sb	$9,9016($16)
	addu	$5,$3,$5
	lbu	$9,15($5)
	subu	$5,$6,$4
	sb	$9,9017($16)
	addu	$5,$3,$5
	lbu	$9,15($5)
	subu	$5,$6,$18
	sb	$9,9018($16)
	addu	$5,$3,$5
	lbu	$5,15($5)
	addu	$6,$3,$6
	sb	$5,9019($16)
	lbu	$5,15($6)
	addiu	$4,$4,1
	sb	$5,9020($16)
	lw	$10,0($6)
	lw	$11,4($6)
	sll	$4,$4,3
	sw	$11,4($2)
	sw	$10,0($2)
	addu	$3,$3,$4
	lw	$4,0($3)
	lw	$5,4($3)
	sw	$4,8($2)
	lbu	$4,23($2)
	sw	$5,12($2)
	sb	$4,9021($16)
	lbu	$6,31($2)
	subu	$3,$0,$17
	addu	$4,$21,$3
	addiu	$5,$17,7
	sb	$6,9030($16)
	addu	$6,$4,$5
	lbu	$6,0($6)
	addu	$3,$20,$3
	sb	$6,9022($16)
	addu	$5,$3,$5
	lbu	$9,0($5)
	sll	$6,$17,1
	addiu	$5,$6,7
	sb	$9,9031($16)
	addu	$9,$4,$5
	lbu	$9,0($9)
	addu	$5,$3,$5
	sb	$9,9023($16)
	lbu	$9,0($5)
	addu	$5,$6,$17
	addiu	$5,$5,7
	sb	$9,9032($16)
	addu	$9,$4,$5
	lbu	$9,0($9)
	addu	$5,$3,$5
	sb	$9,9024($16)
	lbu	$10,0($5)
	sll	$5,$17,2
	addiu	$9,$5,7
	sb	$10,9033($16)
	addu	$10,$4,$9
	lbu	$10,0($10)
	addu	$9,$3,$9
	sb	$10,9025($16)
	lbu	$9,0($9)
	addu	$5,$5,$17
	addiu	$5,$5,7
	sb	$9,9034($16)
	addu	$9,$4,$5
	lbu	$10,0($9)
	addu	$9,$3,$5
	sb	$10,9026($16)
	sll	$5,$17,3
	lbu	$9,0($9)
	subu	$6,$5,$6
	addiu	$6,$6,7
	sb	$9,9035($16)
	addu	$9,$4,$6
	lbu	$9,0($9)
	addu	$6,$3,$6
	sb	$9,9027($16)
	lbu	$10,0($6)
	subu	$9,$5,$17
	addiu	$9,$9,7
	sb	$10,9036($16)
	addu	$6,$4,$9
	lbu	$6,0($6)
	addu	$9,$3,$9
	sb	$6,9028($16)
	lbu	$9,0($9)
	addiu	$6,$5,7
	sb	$9,9037($16)
	addu	$9,$4,$6
	lbu	$9,0($9)
	addu	$6,$3,$6
	sb	$9,9029($16)
	lbu	$6,0($6)
	addu	$4,$4,$5
	sb	$6,9038($16)
	lw	$10,0($4)
	lw	$11,4($4)
	addu	$3,$3,$5
	sw	$10,16($2)
	sw	$11,20($2)
	lw	$6,0($3)
	lw	$7,4($3)
	move	$5,$22
	sw	$6,24($2)
	sw	$7,28($2)
	move	$4,$16
	.option	pic0
	jal	fill_caches
	.option	pic2
	li	$6,1			# 0x1

	lw	$6,140($sp)
	move	$4,$16
	move	$5,$23
	move	$7,$19
	sw	$21,16($sp)
	sw	$20,20($sp)
	sw	$18,24($sp)
	.option	pic0
	jal	filter_mb_fast
	.option	pic2
	sw	$17,28($sp)

	lw	$31,364($sp)
$L4976:
	lw	$fp,360($sp)
	lw	$23,356($sp)
	lw	$22,352($sp)
	lw	$21,348($sp)
	lw	$20,344($sp)
	lw	$19,340($sp)
	lw	$18,336($sp)
	lw	$17,332($sp)
	lw	$16,328($sp)
	j	$31
	addiu	$sp,$sp,368

$L4788:
	lw	$2,9924($16)
	sltu	$2,$0,$2
	b	$L4789
	sw	$2,148($sp)

$L4790:
	li	$2,16777216			# 0x1000000
	and	$2,$22,$2
	bne	$2,$0,$L4909
	nop

	lw	$7,5124($16)
	lw	$8,5116($16)
	sw	$7,168($sp)
	sw	$8,128($sp)
$L4792:
	andi	$10,$22,0x7
	beq	$10,$0,$L4794
	sw	$10,156($sp)

$L4898:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$2,5340($3)
	bne	$2,$0,$L4910
	li	$4,2			# 0x2

$L4795:
	lw	$2,8756($16)
	move	$4,$21
	addiu	$2,$2,2230
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$25,4($2)
	jalr	$25
	move	$5,$17

	lw	$2,8756($16)
	move	$4,$20
	addiu	$2,$2,2230
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$25,4($2)
	andi	$2,$22,0x1
	move	$5,$17
	jalr	$25
	sw	$2,144($sp)

	lw	$3,144($sp)
	beq	$3,$0,$L4803
	li	$2,16777216			# 0x1000000

	and	$2,$22,$2
	beq	$2,$0,$L4804
	li	$2,131072			# 0x20000

	addiu	$2,$16,12
	lb	$3,8776($2)
	lw	$fp,9548($16)
	addiu	$3,$3,2218
	sll	$3,$3,2
	addu	$3,$16,$3
	lw	$25,4($3)
	li	$3,131072			# 0x20000
	lbu	$2,9080($2)
	ori	$8,$3,0x1ad8
	lw	$5,8980($16)
	lw	$6,8988($16)
	addu	$8,$16,$8
	addu	$fp,$19,$fp
	sw	$2,316($sp)
	sw	$3,312($sp)
	andi	$5,$5,0x8000
	andi	$6,$6,0x4000
	move	$4,$fp
	move	$7,$18
	jalr	$25
	sw	$8,132($sp)

	lw	$2,316($sp)
	beq	$2,$0,$L4805
	lw	$3,312($sp)

	li	$4,1			# 0x1
	bne	$2,$4,$L4977
	lw	$5,132($sp)

	addu	$3,$16,$3
	lh	$2,6872($3)
	bne	$2,$0,$L4911
	lw	$25,168($sp)

$L4977:
	lw	$25,128($sp)
	move	$4,$fp
	jalr	$25
	move	$6,$18

$L4805:
	addiu	$2,$16,14
$L4972:
	lb	$3,8776($2)
	lw	$fp,9564($16)
	addiu	$3,$3,2218
	lw	$5,8980($16)
	lw	$6,8988($16)
	sll	$3,$3,2
	lbu	$2,9080($2)
	addu	$3,$16,$3
	addu	$fp,$19,$fp
	sll	$5,$5,4
	sll	$6,$6,4
	lw	$25,4($3)
	sw	$2,316($sp)
	andi	$5,$5,0x8000
	andi	$6,$6,0x4000
	move	$4,$fp
	jalr	$25
	move	$7,$18

	lw	$2,316($sp)
	beq	$2,$0,$L4808
	li	$3,1			# 0x1

	bne	$2,$3,$L4978
	move	$4,$fp

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7000($2)
	bne	$2,$0,$L4912
	lw	$fp,132($sp)

$L4978:
	lw	$fp,132($sp)
	lw	$25,128($sp)
	addiu	$5,$fp,128
	jalr	$25
	move	$6,$18

$L4808:
	addiu	$2,$16,28
$L4973:
	lb	$3,8776($2)
	lw	$fp,9580($16)
	addiu	$3,$3,2218
	lw	$5,8980($16)
	lw	$6,8988($16)
	sll	$3,$3,2
	lbu	$2,9080($2)
	addu	$3,$16,$3
	addu	$fp,$19,$fp
	sll	$5,$5,8
	sll	$6,$6,8
	lw	$25,4($3)
	sw	$2,316($sp)
	andi	$5,$5,0x8000
	andi	$6,$6,0x4000
	move	$4,$fp
	jalr	$25
	move	$7,$18

	lw	$2,316($sp)
	beq	$2,$0,$L4811
	li	$3,1			# 0x1

	bne	$2,$3,$L4979
	move	$4,$fp

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7128($2)
	bne	$2,$0,$L4913
	lw	$fp,132($sp)

$L4979:
	lw	$fp,132($sp)
	lw	$25,128($sp)
	addiu	$5,$fp,256
	jalr	$25
	move	$6,$18

$L4811:
	addiu	$2,$16,30
$L4974:
	lb	$3,8776($2)
	lw	$fp,9596($16)
	addiu	$3,$3,2218
	lw	$5,8980($16)
	lw	$6,8988($16)
	sll	$3,$3,2
	lbu	$2,9080($2)
	addu	$3,$16,$3
	addu	$fp,$19,$fp
	sll	$5,$5,12
	sll	$6,$6,12
	lw	$25,4($3)
	sw	$2,316($sp)
	andi	$5,$5,0x8000
	andi	$6,$6,0x4000
	move	$4,$fp
	jalr	$25
	move	$7,$18

	lw	$2,316($sp)
	bne	$2,$0,$L4914
	li	$3,1			# 0x1

$L4814:
	li	$3,65536			# 0x10000
$L4955:
	addu	$3,$16,$3
	lw	$2,5340($3)
	bne	$2,$0,$L4980
	li	$4,2			# 0x2

$L4822:
	lw	$14,144($sp)
$L4988:
	bne	$14,$0,$L4830
	andi	$2,$22,0x2

$L4975:
	beq	$2,$0,$L4831
	li	$3,16777216			# 0x1000000

	li	$2,131072			# 0x20000
	lbu	$3,9092($16)
	ori	$fp,$2,0x1ad8
	bne	$3,$0,$L4832
	addu	$fp,$16,$fp

	addu	$2,$16,$2
	lh	$2,6872($2)
	bne	$2,$0,$L4916
	lw	$25,168($sp)

	lbu	$2,9093($16)
$L4956:
	bne	$2,$0,$L4834
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,6904($2)
	bne	$2,$0,$L4917
	lw	$25,168($sp)

	lbu	$2,9100($16)
$L4971:
	bne	$2,$0,$L4836
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,6936($2)
	bne	$2,$0,$L4918
	lw	$25,168($sp)

	lbu	$2,9101($16)
$L4970:
	bne	$2,$0,$L4838
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,6968($2)
	bne	$2,$0,$L4919
	lw	$25,168($sp)

	lbu	$2,9094($16)
$L4969:
	bne	$2,$0,$L4840
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7000($2)
	bne	$2,$0,$L4920
	lw	$25,168($sp)

	lbu	$2,9095($16)
$L4968:
	bne	$2,$0,$L4842
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7032($2)
	bne	$2,$0,$L4921
	lw	$25,168($sp)

	lbu	$2,9102($16)
$L4967:
	bne	$2,$0,$L4844
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7064($2)
	bne	$2,$0,$L4922
	lw	$25,168($sp)

	lbu	$2,9103($16)
$L4966:
	bne	$2,$0,$L4846
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7096($2)
	bne	$2,$0,$L4923
	lw	$25,168($sp)

	lbu	$2,9108($16)
$L4965:
	bne	$2,$0,$L4848
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7128($2)
	bne	$2,$0,$L4924
	lw	$25,168($sp)

	lbu	$2,9109($16)
$L4964:
	bne	$2,$0,$L4850
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7160($2)
	bne	$2,$0,$L4925
	lw	$25,168($sp)

	lbu	$2,9116($16)
$L4963:
	bne	$2,$0,$L4852
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7192($2)
	bne	$2,$0,$L4926
	lw	$25,168($sp)

	lbu	$2,9117($16)
$L4962:
	bne	$2,$0,$L4854
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7224($2)
	bne	$2,$0,$L4927
	lw	$25,168($sp)

	lbu	$2,9110($16)
$L4961:
	bne	$2,$0,$L4856
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7256($2)
	bne	$2,$0,$L4928
	lw	$25,168($sp)

	lbu	$2,9111($16)
$L4960:
	bne	$2,$0,$L4858
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7288($2)
	bne	$2,$0,$L4929
	lw	$25,168($sp)

	lbu	$2,9118($16)
$L4959:
	bne	$2,$0,$L4860
	lw	$25,128($sp)

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7320($2)
	bne	$2,$0,$L4930
	lw	$25,168($sp)

	lbu	$2,9119($16)
$L4958:
	bne	$2,$0,$L4931
	li	$2,131072			# 0x20000

	addu	$2,$16,$2
	lh	$2,7352($2)
	beq	$2,$0,$L4830
	lw	$25,168($sp)

	lw	$4,9608($16)
	addiu	$5,$fp,480
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4946
	lw	$fp,148($sp)

$L4909:
	lw	$5,5128($16)
	lw	$6,5120($16)
	sw	$5,168($sp)
	b	$L4792
	sw	$6,128($sp)

$L4791:
	lw	$4,2164($16)
	sw	$4,168($sp)
	b	$L4792
	sw	$4,128($sp)

$L4868:
	lw	$4,156($sp)
	li	$3,1			# 0x1
	li	$2,4			# 0x4
	movn	$2,$3,$4
	addiu	$4,$2,14800
	sll	$4,$4,2
	li	$2,131072			# 0x20000
	addu	$4,$16,$4
	ori	$3,$2,0x1cd8
	lw	$5,8740($16)
	addu	$3,$16,$3
	lw	$8,4($4)
	addu	$4,$16,$2
	lh	$11,7384($4)
	lh	$10,64($3)
	lh	$6,32($3)
	lh	$7,96($3)
	sll	$5,$5,6
	addu	$5,$8,$5
	addu	$9,$7,$10
	addu	$8,$6,$11
	lw	$5,0($5)
	subu	$6,$11,$6
	subu	$7,$10,$7
	subu	$11,$6,$7
	subu	$10,$8,$9
	addu	$7,$7,$6
	addu	$8,$9,$8
	mul	$11,$11,$5
	mul	$8,$8,$5
	mul	$7,$7,$5
	mul	$5,$10,$5
	lw	$10,156($sp)
	li	$9,2			# 0x2
	li	$6,5			# 0x5
	movn	$6,$9,$10
	addiu	$6,$6,14800
	sll	$6,$6,2
	sra	$8,$8,7
	sra	$7,$7,7
	sra	$5,$5,7
	addu	$6,$16,$6
	lw	$10,8744($16)
	sra	$11,$11,7
	ori	$2,$2,0x1d58
	sh	$8,7384($4)
	addu	$2,$16,$2
	sh	$7,32($3)
	sh	$11,96($3)
	sh	$5,64($3)
	lw	$7,4($6)
	lh	$9,64($2)
	lh	$5,32($2)
	lh	$6,96($2)
	sll	$3,$10,6
	lh	$10,7512($4)
	addu	$3,$7,$3
	addu	$8,$6,$9
	lw	$3,0($3)
	addu	$7,$5,$10
	subu	$6,$9,$6
	subu	$5,$10,$5
	subu	$9,$5,$6
	subu	$10,$7,$8
	addu	$5,$6,$5
	addu	$7,$8,$7
	mul	$9,$9,$3
	mul	$7,$7,$3
	mul	$5,$5,$3
	mul	$3,$10,$3
	lw	$8,5116($16)
	lw	$10,5124($16)
	sra	$3,$3,7
	sra	$7,$7,7
	sra	$5,$5,7
	sra	$6,$9,7
	sh	$7,7512($4)
	sw	$8,128($sp)
	sh	$6,96($2)
	sh	$5,32($2)
	sh	$3,64($2)
	sw	$10,132($sp)
	li	$2,131072			# 0x20000
	lbu	$3,9089($16)
	ori	$fp,$2,0x1ad8
	beq	$3,$0,$L4932
	addu	$fp,$16,$fp

$L4874:
	lw	$2,9612($16)
	lw	$4,52($sp)
	lw	$25,128($sp)
	addu	$4,$4,$2
	addiu	$5,$fp,512
	jalr	$25
	move	$6,$17

	lbu	$2,9090($16)
	beq	$2,$0,$L4981
	li	$2,131072			# 0x20000

$L4876:
	lw	$2,9616($16)
	lw	$4,52($sp)
	lw	$25,128($sp)
	addu	$4,$4,$2
	addiu	$5,$fp,544
	jalr	$25
	move	$6,$17

	lbu	$2,9097($16)
	beq	$2,$0,$L4982
	li	$2,131072			# 0x20000

$L4878:
	lw	$2,9620($16)
	lw	$4,52($sp)
	lw	$25,128($sp)
	addu	$4,$4,$2
	addiu	$5,$fp,576
	jalr	$25
	move	$6,$17

	lbu	$2,9098($16)
	beq	$2,$0,$L4983
	li	$2,131072			# 0x20000

$L4880:
	lw	$2,9624($16)
	lw	$4,52($sp)
	lw	$25,128($sp)
	addu	$4,$4,$2
	addiu	$5,$fp,608
	jalr	$25
	move	$6,$17

	lbu	$2,9113($16)
	beq	$2,$0,$L4984
	li	$2,131072			# 0x20000

$L4882:
	lw	$4,9628($16)
	lw	$25,128($sp)
	addiu	$5,$fp,640
	addu	$4,$20,$4
	jalr	$25
	move	$6,$17

	lbu	$2,9114($16)
	beq	$2,$0,$L4985
	li	$2,131072			# 0x20000

$L4884:
	lw	$4,9632($16)
	lw	$25,128($sp)
	addiu	$5,$fp,672
	addu	$4,$20,$4
	jalr	$25
	move	$6,$17

	lbu	$2,9121($16)
	beq	$2,$0,$L4986
	li	$2,131072			# 0x20000

$L4886:
	lw	$4,9636($16)
	lw	$25,128($sp)
	addiu	$5,$fp,704
	addu	$4,$20,$4
	jalr	$25
	move	$6,$17

	lbu	$2,9122($16)
	beq	$2,$0,$L4888
	nop

$L4907:
	lw	$4,9640($16)
	lw	$25,128($sp)
	addiu	$5,$fp,736
	addu	$4,$20,$4
	jalr	$25
	move	$6,$17

	b	$L4947
	li	$2,65536			# 0x10000

$L4804:
	lui	$3,%hi(scan8)
	ori	$2,$2,0x1ad8
	addiu	$3,$3,%lo(scan8)
	addu	$4,$16,$2
	sw	$3,132($sp)
	li	$2,4			# 0x4
	li	$3,3			# 0x3
	subu	$2,$2,$18
	subu	$3,$3,$18
	addiu	$7,$sp,48
	sw	$23,184($sp)
	sw	$22,172($sp)
	sw	$19,136($sp)
	sw	$21,180($sp)
	sw	$20,188($sp)
	sw	$2,160($sp)
	move	$fp,$0
	sw	$3,164($sp)
	sw	$7,152($sp)
	sw	$17,176($sp)
	move	$23,$18
	move	$22,$4
	move	$21,$4
	move	$20,$4
	b	$L4821
	move	$19,$16

$L4941:
	li	$12,7			# 0x7
	beq	$2,$12,$L4816
	move	$5,$0

$L4817:
	addiu	$2,$2,2204
	sll	$2,$2,2
	addu	$2,$19,$2
	lw	$25,4($2)
	move	$4,$18
	jalr	$25
	move	$6,$23

	lbu	$2,9080($17)
	beq	$2,$0,$L4819
	li	$25,1			# 0x1

	bne	$2,$25,$L4987
	lw	$25,128($sp)

	lh	$2,0($21)
	bne	$2,$0,$L4939
	move	$5,$22

$L4987:
	move	$4,$18
	move	$5,$20
	jalr	$25
	move	$6,$23

$L4819:
	addiu	$fp,$fp,1
	li	$2,16			# 0x10
	addiu	$16,$16,4
	addiu	$22,$22,32
	addiu	$20,$20,32
	beq	$fp,$2,$L4940
	addiu	$21,$21,32

$L4821:
	lw	$8,132($sp)
	lw	$18,9548($16)
	addu	$2,$8,$fp
	lbu	$17,0($2)
	lw	$10,136($sp)
	addu	$17,$19,$17
	lb	$2,8776($17)
	li	$11,3			# 0x3
	bne	$2,$11,$L4941
	addu	$18,$10,$18

$L4816:
	lw	$3,8988($19)
	sll	$3,$3,$fp
	andi	$3,$3,0x8000
	bne	$3,$0,$L4818
	lw	$15,160($sp)

	lw	$14,164($sp)
	lw	$5,152($sp)
	addu	$3,$18,$14
	lbu	$3,0($3)
	sll	$4,$3,8
	addu	$3,$4,$3
	sll	$4,$3,16
	addu	$3,$3,$4
	b	$L4817
	sw	$3,48($sp)

$L4818:
	b	$L4817
	addu	$5,$18,$15

$L4939:
	lw	$25,168($sp)
	move	$4,$18
	jalr	$25
	move	$6,$23

	addiu	$fp,$fp,1
	li	$2,16			# 0x10
	addiu	$16,$16,4
	addiu	$22,$22,32
	addiu	$20,$20,32
	bne	$fp,$2,$L4821
	addiu	$21,$21,32

$L4940:
	move	$16,$19
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$2,5340($3)
	move	$18,$23
	lw	$17,176($sp)
	lw	$23,184($sp)
	lw	$22,172($sp)
	lw	$21,180($sp)
	lw	$20,188($sp)
	beq	$2,$0,$L4822
	lw	$19,136($sp)

	li	$4,2			# 0x2
$L4980:
	beq	$2,$4,$L4942
	nop

	lw	$4,6168($16)
	lw	$2,6172($16)
	slt	$4,$0,$4
	slt	$2,$0,$2
$L4824:
	nor	$6,$0,$17
	nor	$3,$0,$18
	addu	$5,$20,$6
	addu	$3,$19,$3
	beq	$4,$0,$L4825
	addu	$6,$21,$6

	xori	$7,$2,0x1
	mul	$10,$7,$18
	addu	$8,$16,$7
	addu	$9,$10,$3
	addiu	$8,$8,9004
$L4826:
	lbu	$11,0($8)
	addiu	$7,$7,1
	slt	$10,$7,17
	sb	$11,0($9)
	addiu	$8,$8,1
	bne	$10,$0,$L4826
	addu	$9,$9,$18

$L4825:
	beq	$2,$0,$L4827
	nop

	lw	$9,6168($16)
	lw	$7,8996($16)
	sll	$8,$9,5
	addu	$8,$7,$8
	lw	$10,0($8)
	lw	$11,4($8)
	sll	$8,$9,5
	addiu	$8,$8,8
	sw	$10,1($3)
	sw	$11,5($3)
	addu	$8,$7,$8
	lw	$10,144($16)
	lw	$12,0($8)
	lw	$13,4($8)
	lw	$14,9($3)
	lw	$15,13($3)
	addiu	$9,$9,1
	slt	$10,$9,$10
	sw	$14,0($8)
	sw	$15,4($8)
	sw	$12,9($3)
	beq	$10,$0,$L4827
	sw	$13,13($3)

	sll	$9,$9,5
	addu	$7,$7,$9
	lw	$8,0($7)
	lw	$9,4($7)
	lw	$10,17($3)
	lw	$11,21($3)
	sw	$10,0($7)
	sw	$11,4($7)
	sw	$8,17($3)
	sw	$9,21($3)
$L4827:
	beq	$4,$0,$L4828
	nop

	xori	$4,$2,0x1
	mul	$7,$4,$17
	addu	$3,$16,$4
	addu	$8,$5,$7
	addiu	$3,$3,9021
	addu	$7,$6,$7
$L4829:
	lbu	$9,0($3)
	addiu	$4,$4,1
	sb	$9,0($7)
	lbu	$10,9($3)
	slt	$9,$4,9
	sb	$10,0($8)
	addiu	$3,$3,1
	addu	$7,$7,$17
	bne	$9,$0,$L4829
	addu	$8,$8,$17

$L4828:
	beq	$2,$0,$L4988
	lw	$14,144($sp)

	lw	$2,6168($16)
	lw	$3,8996($16)
	sll	$4,$2,5
	addiu	$4,$4,16
	addu	$4,$3,$4
	lw	$8,0($4)
	lw	$9,4($4)
	lw	$10,1($6)
	lw	$11,5($6)
	sll	$2,$2,5
	addiu	$2,$2,24
	sw	$10,0($4)
	sw	$11,4($4)
	addu	$2,$3,$2
	sw	$8,1($6)
	sw	$9,5($6)
	lw	$6,0($2)
	lw	$7,4($2)
	lw	$8,1($5)
	lw	$9,5($5)
	sw	$8,0($2)
	sw	$9,4($2)
	sw	$6,1($5)
	b	$L4822
	sw	$7,5($5)

$L4831:
	and	$3,$22,$3
	li	$2,4			# 0x4
	li	$8,1			# 0x1
	movn	$8,$2,$3
	lui	$3,%hi(scan8)
	li	$2,131072			# 0x20000
	addiu	$3,$3,%lo(scan8)
	ori	$2,$2,0x1ad8
	sw	$3,132($sp)
	addu	$2,$16,$2
	sll	$7,$8,5
	sw	$21,164($sp)
	lw	$21,132($sp)
	sw	$17,136($sp)
	sw	$23,144($sp)
	sw	$22,160($sp)
	move	$23,$19
	move	$22,$18
	sw	$20,152($sp)
	move	$17,$16
	move	$fp,$0
	move	$18,$2
	move	$19,$7
	move	$20,$8
	move	$16,$2
$L4867:
	addu	$2,$21,$fp
	lbu	$2,0($2)
	addiu	$3,$fp,2386
	addu	$2,$17,$2
	lbu	$2,9080($2)
	sll	$3,$3,2
	addu	$3,$17,$3
	beq	$2,$0,$L4865
	move	$5,$16

	sll	$4,$fp,5
	addu	$4,$17,$4
	li	$6,131072			# 0x20000
	li	$7,1			# 0x1
	bne	$2,$7,$L4866
	addu	$4,$6,$4

	lh	$2,6872($4)
	bne	$2,$0,$L4943
	lw	$25,168($sp)

$L4866:
	lw	$4,4($3)
	lw	$25,128($sp)
	move	$6,$22
	jalr	$25
	addu	$4,$23,$4

$L4865:
	addu	$fp,$20,$fp
$L4957:
	slt	$2,$fp,16
	addu	$18,$18,$19
	bne	$2,$0,$L4867
	addu	$16,$16,$19

	move	$18,$22
	move	$19,$23
	move	$16,$17
	lw	$22,160($sp)
	lw	$23,144($sp)
	lw	$21,164($sp)
	lw	$20,152($sp)
	b	$L4830
	lw	$17,136($sp)

$L4904:
	lw	$4,9628($16)
	addiu	$5,$fp,640
	addu	$4,$20,$4
	jalr	$25
	move	$6,$17

	b	$L4948
	lbu	$2,9114($16)

$L4908:
	lw	$4,9640($16)
	addiu	$5,$fp,736
	addu	$4,$20,$4
	jalr	$25
	move	$6,$17

	b	$L4947
	li	$2,65536			# 0x10000

$L4903:
	lw	$2,9624($16)
	lw	$25,132($sp)
	addiu	$5,$fp,608
	addu	$4,$4,$2
	jalr	$25
	move	$6,$17

	b	$L4949
	lbu	$2,9113($16)

$L4902:
	lw	$2,9620($16)
	lw	$25,132($sp)
	addiu	$5,$fp,576
	addu	$4,$4,$2
	jalr	$25
	move	$6,$17

	b	$L4950
	lbu	$2,9098($16)

$L4901:
	lw	$2,9616($16)
	lw	$25,132($sp)
	addiu	$5,$fp,544
	addu	$4,$4,$2
	jalr	$25
	move	$6,$17

	b	$L4951
	lbu	$2,9097($16)

$L4900:
	lw	$2,9612($16)
	lw	$25,132($sp)
	addiu	$5,$fp,512
	addu	$4,$4,$2
	jalr	$25
	move	$6,$17

	b	$L4952
	lbu	$2,9090($16)

$L4906:
	lw	$4,9636($16)
	addiu	$5,$fp,704
	addu	$4,$20,$4
	jalr	$25
	move	$6,$17

	b	$L4953
	lbu	$2,9122($16)

$L4905:
	lw	$4,9632($16)
	addiu	$5,$fp,672
	addu	$4,$20,$4
	jalr	$25
	move	$6,$17

	b	$L4954
	lbu	$2,9121($16)

$L4803:
	lw	$2,8760($16)
	move	$4,$19
	addiu	$2,$2,2236
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$25,8($2)
	jalr	$25
	move	$5,$18

	lw	$3,148($sp)
	bne	$3,$0,$L4955
	li	$3,65536			# 0x10000

	li	$2,65536			# 0x10000
	ori	$5,$2,0xdac
	addiu	$12,$5,32
	ori	$3,$2,0xdbc
	ori	$6,$2,0xd6c
	addiu	$8,$5,128
	sll	$12,$12,1
	ori	$4,$2,0xd7c
	addiu	$13,$6,32
	addiu	$10,$3,32
	addu	$12,$16,$12
	sll	$8,$8,1
	sw	$12,236($sp)
	addiu	$11,$4,32
	addiu	$9,$6,128
	addu	$8,$16,$8
	sll	$13,$13,1
	sll	$10,$10,1
	sw	$8,252($sp)
	addiu	$15,$6,160
	lw	$8,236($sp)
	addiu	$25,$4,160
	addiu	$7,$4,128
	addiu	$14,$3,128
	addu	$13,$16,$13
	addu	$10,$16,$10
	sll	$11,$11,1
	sll	$9,$9,1
	sll	$6,$6,1
	sll	$4,$4,1
	addu	$6,$16,$6
	sw	$13,232($sp)
	addu	$11,$16,$11
	sw	$10,244($sp)
	addiu	$fp,$3,160
	addu	$4,$16,$4
	addu	$9,$16,$9
	sll	$7,$7,1
	sll	$14,$14,1
	sll	$15,$15,1
	sw	$4,224($sp)
	sw	$9,248($sp)
	lh	$4,0($6)
	lh	$9,0($8)
	addiu	$24,$5,160
	lh	$8,0($11)
	sw	$6,216($sp)
	sw	$11,240($sp)
	lw	$6,232($sp)
	lw	$11,244($sp)
	addu	$7,$16,$7
	addu	$14,$16,$14
	addu	$15,$16,$15
	sll	$25,$25,1
	sll	$fp,$fp,1
	sw	$7,256($sp)
	sw	$14,260($sp)
	sw	$15,264($sp)
	addu	$25,$16,$25
	addu	$fp,$16,$fp
	sll	$24,$24,1
	lh	$7,0($6)
	sw	$25,272($sp)
	lh	$6,0($11)
	sw	$fp,276($sp)
	lw	$14,248($sp)
	lw	$25,256($sp)
	lw	$fp,260($sp)
	lw	$11,264($sp)
	addu	$24,$16,$24
	sll	$5,$5,1
	sll	$3,$3,1
	addu	$5,$16,$5
	addu	$3,$16,$3
	sw	$24,268($sp)
	addu	$2,$16,$2
	lh	$10,0($3)
	lh	$24,0($11)
	lh	$13,0($5)
	lw	$15,252($sp)
	lw	$11,276($sp)
	sw	$5,220($sp)
	sw	$3,228($sp)
	lw	$5,224($sp)
	lh	$3,0($14)
	sw	$4,188($sp)
	lh	$14,0($fp)
	lh	$4,0($25)
	lw	$fp,272($sp)
	lw	$25,268($sp)
	lw	$2,-6332($2)
	lh	$12,0($5)
	lh	$5,0($15)
	lh	$15,0($25)
	lh	$25,0($fp)
	lh	$fp,0($11)
	sw	$2,180($sp)
	lw	$2,188($sp)
	addu	$11,$10,$12
	subu	$2,$2,$13
	sw	$2,152($sp)
	subu	$2,$7,$9
	sw	$2,164($sp)
	subu	$2,$3,$5
	sw	$2,136($sp)
	subu	$2,$24,$15
	sw	$2,184($sp)
	lw	$2,2056($16)
	sw	$11,192($sp)
	addu	$11,$6,$8
	sw	$11,160($sp)
	sll	$2,$2,6
	addu	$11,$14,$4
	sw	$11,132($sp)
	sw	$2,172($sp)
	addu	$11,$fp,$25
	addu	$15,$15,$24
	lw	$2,160($sp)
	subu	$24,$25,$fp
	lw	$fp,164($sp)
	sw	$11,176($sp)
	subu	$4,$4,$14
	lw	$11,188($sp)
	addu	$9,$9,$7
	subu	$8,$8,$6
	lw	$14,152($sp)
	subu	$7,$fp,$8
	subu	$6,$9,$2
	subu	$12,$12,$10
	lw	$fp,184($sp)
	lw	$2,176($sp)
	addu	$13,$13,$11
	lw	$25,192($sp)
	subu	$11,$14,$12
	lw	$14,136($sp)
	subu	$fp,$fp,$24
	subu	$2,$15,$2
	subu	$10,$13,$25
	addu	$5,$5,$3
	sw	$4,188($sp)
	subu	$3,$14,$4
	lw	$25,132($sp)
	lw	$4,180($sp)
	sw	$fp,324($sp)
	sw	$2,320($sp)
	lw	$fp,172($sp)
	lw	$2,192($sp)
	subu	$14,$5,$25
	addu	$13,$2,$13
	addu	$25,$4,$fp
	lw	$2,164($sp)
	lw	$4,152($sp)
	lw	$fp,160($sp)
	addu	$12,$12,$4
	addu	$8,$8,$2
	addu	$9,$fp,$9
	lw	$4,132($sp)
	lw	$fp,188($sp)
	lw	$2,136($sp)
	addu	$5,$4,$5
	addu	$4,$fp,$2
	lw	$fp,176($sp)
	lw	$2,184($sp)
	addu	$15,$fp,$15
	addu	$24,$24,$2
	subu	$fp,$13,$5
	addu	$2,$15,$9
	sw	$fp,192($sp)
	subu	$fp,$12,$4
	sw	$2,180($sp)
	addu	$2,$24,$8
	sw	$fp,184($sp)
	sw	$2,152($sp)
	subu	$fp,$11,$3
	lw	$2,324($sp)
	sw	$fp,160($sp)
	subu	$fp,$10,$14
	addu	$2,$2,$7
	sw	$fp,208($sp)
	subu	$fp,$9,$15
	sw	$fp,188($sp)
	sw	$2,132($sp)
	subu	$fp,$8,$24
	lw	$2,320($sp)
	sw	$fp,176($sp)
	lw	$fp,324($sp)
	addu	$2,$2,$6
	subu	$fp,$7,$fp
	sw	$2,200($sp)
	lw	$2,0($25)
	addu	$25,$5,$13
	sw	$25,196($sp)
	sw	$fp,136($sp)
	addu	$25,$4,$12
	lw	$fp,320($sp)
	sw	$25,172($sp)
	addu	$25,$3,$11
	subu	$fp,$6,$fp
	sw	$25,164($sp)
	addu	$25,$14,$10
	sw	$25,212($sp)
	sw	$fp,204($sp)
	lw	$25,192($sp)
	lw	$fp,188($sp)
	subu	$25,$25,$fp
	sw	$25,280($sp)
	lw	$fp,180($sp)
	lw	$25,196($sp)
	subu	$25,$25,$fp
	sw	$25,284($sp)
	lw	$fp,176($sp)
	lw	$25,184($sp)
	subu	$25,$25,$fp
	sw	$25,288($sp)
	lw	$fp,152($sp)
	lw	$25,172($sp)
	subu	$25,$25,$fp
	sw	$25,292($sp)
	lw	$fp,136($sp)
	lw	$25,160($sp)
	subu	$25,$25,$fp
	sw	$25,296($sp)
	lw	$fp,132($sp)
	lw	$25,164($sp)
	subu	$25,$25,$fp
	sw	$25,300($sp)
	lw	$fp,204($sp)
	lw	$25,208($sp)
	subu	$25,$25,$fp
	sw	$25,304($sp)
	lw	$fp,200($sp)
	lw	$25,212($sp)
	subu	$25,$25,$fp
	sw	$25,308($sp)
	lw	$fp,196($sp)
	lw	$25,180($sp)
	addu	$25,$25,$fp
	sw	$25,180($sp)
	lw	$fp,192($sp)
	lw	$25,188($sp)
	addu	$25,$25,$fp
	sw	$25,188($sp)
	lw	$fp,172($sp)
	lw	$25,152($sp)
	addu	$25,$25,$fp
	sw	$25,152($sp)
	lw	$fp,184($sp)
	lw	$25,176($sp)
	addu	$25,$25,$fp
	sw	$25,176($sp)
	lw	$fp,164($sp)
	lw	$25,132($sp)
	addu	$25,$25,$fp
	sw	$25,192($sp)
	lw	$fp,160($sp)
	lw	$25,136($sp)
	addu	$25,$25,$fp
	sw	$25,196($sp)
	lw	$fp,212($sp)
	lw	$25,200($sp)
	addu	$25,$25,$fp
	sw	$25,200($sp)
	lw	$fp,208($sp)
	lw	$25,204($sp)
	addu	$25,$25,$fp
	sw	$25,204($sp)
	lw	$25,308($sp)
	mul	$25,$25,$2
	sw	$25,208($sp)
	lw	$25,180($sp)
	mul	$25,$25,$2
	sw	$25,132($sp)
	lw	$25,188($sp)
	mul	$25,$25,$2
	sw	$25,136($sp)
	lw	$25,280($sp)
	mul	$25,$25,$2
	sw	$25,160($sp)
	lw	$25,284($sp)
	mul	$25,$25,$2
	sw	$25,164($sp)
	lw	$25,152($sp)
	mul	$25,$25,$2
	sw	$25,152($sp)
	lw	$25,176($sp)
	mul	$25,$25,$2
	sw	$25,176($sp)
	lw	$25,288($sp)
	mul	$25,$25,$2
	sw	$25,184($sp)
	lw	$25,292($sp)
	mul	$25,$25,$2
	sw	$25,172($sp)
	lw	$25,192($sp)
	mul	$25,$25,$2
	sw	$25,180($sp)
	lw	$25,196($sp)
	mul	$25,$25,$2
	sw	$25,188($sp)
	lw	$25,296($sp)
	mul	$25,$25,$2
	sw	$25,192($sp)
	lw	$25,300($sp)
	mul	$25,$25,$2
	sw	$25,196($sp)
	lw	$25,200($sp)
	mul	$25,$25,$2
	sw	$25,200($sp)
	lw	$25,204($sp)
	mul	$fp,$25,$2
	lw	$25,304($sp)
	addiu	$fp,$fp,128
	mul	$2,$25,$2
	lw	$25,132($sp)
	addiu	$2,$2,128
	addiu	$25,$25,128
	sw	$25,132($sp)
	lw	$25,136($sp)
	sra	$2,$2,8
	addiu	$25,$25,128
	sw	$25,136($sp)
	lw	$25,160($sp)
	addiu	$25,$25,128
	sw	$25,160($sp)
	lw	$25,164($sp)
	sw	$fp,204($sp)
	addiu	$25,$25,128
	sw	$25,164($sp)
	lw	$25,152($sp)
	addiu	$25,$25,128
	sw	$25,152($sp)
	lw	$25,176($sp)
	addiu	$25,$25,128
	sw	$25,176($sp)
	lw	$25,184($sp)
	addiu	$25,$25,128
	sw	$25,184($sp)
	lw	$25,172($sp)
	addiu	$25,$25,128
	sw	$25,172($sp)
	lw	$25,180($sp)
	addiu	$25,$25,128
	sw	$25,180($sp)
	lw	$25,188($sp)
	addiu	$25,$25,128
	sw	$25,188($sp)
	lw	$25,192($sp)
	addiu	$25,$25,128
	sw	$25,192($sp)
	lw	$25,196($sp)
	addiu	$25,$25,128
	sw	$25,196($sp)
	lw	$25,200($sp)
	addiu	$25,$25,128
	sw	$25,200($sp)
	lw	$25,208($sp)
	addiu	$fp,$25,128
	lw	$25,132($sp)
	sra	$25,$25,8
	sw	$25,132($sp)
	lw	$25,136($sp)
	sra	$25,$25,8
	sw	$25,136($sp)
	lw	$25,160($sp)
	sra	$25,$25,8
	sw	$25,160($sp)
	lw	$25,164($sp)
	sra	$25,$25,8
	sw	$25,164($sp)
	lw	$25,152($sp)
	sra	$25,$25,8
	sw	$25,152($sp)
	lw	$25,176($sp)
	sra	$25,$25,8
	sw	$25,176($sp)
	lw	$25,184($sp)
	sw	$2,208($sp)
	sra	$25,$25,8
	sw	$25,184($sp)
	lw	$25,172($sp)
	sra	$2,$fp,8
	sra	$25,$25,8
	sw	$25,172($sp)
	lw	$25,180($sp)
	lw	$fp,324($sp)
	sra	$25,$25,8
	sw	$25,180($sp)
	lw	$25,188($sp)
	sw	$4,96($sp)
	sra	$25,$25,8
	sw	$25,188($sp)
	lw	$25,192($sp)
	sw	$3,100($sp)
	sra	$25,$25,8
	sw	$25,192($sp)
	lw	$25,196($sp)
	lw	$4,132($sp)
	sra	$25,$25,8
	sw	$25,196($sp)
	lw	$25,200($sp)
	lw	$3,216($sp)
	sra	$25,$25,8
	sw	$25,200($sp)
	lw	$25,204($sp)
	sw	$12,64($sp)
	sra	$25,$25,8
	sw	$25,204($sp)
	sw	$11,68($sp)
	sw	$10,72($sp)
	sw	$8,80($sp)
	sw	$7,84($sp)
	sw	$6,88($sp)
	sw	$5,92($sp)
	sw	$14,104($sp)
	sw	$15,108($sp)
	sw	$fp,116($sp)
	sw	$13,60($sp)
	sw	$9,76($sp)
	sw	$24,112($sp)
	sh	$4,0($3)
	lw	$6,136($sp)
	lw	$5,232($sp)
	lw	$8,160($sp)
	lw	$7,248($sp)
	lw	$11,164($sp)
	lw	$10,264($sp)
	lw	$14,152($sp)
	lw	$12,224($sp)
	lw	$25,176($sp)
	lw	$15,240($sp)
	lw	$3,184($sp)
	lw	$fp,256($sp)
	sh	$6,0($5)
	lw	$4,272($sp)
	sh	$8,0($7)
	lw	$5,172($sp)
	sh	$11,0($10)
	lw	$7,180($sp)
	sh	$14,0($12)
	lw	$6,220($sp)
	sh	$25,0($15)
	lw	$8,236($sp)
	sh	$3,0($fp)
	lw	$10,188($sp)
	lw	$12,192($sp)
	lw	$11,252($sp)
	lw	$15,196($sp)
	lw	$14,268($sp)
	lw	$fp,200($sp)
	lw	$25,228($sp)
	sh	$5,0($4)
	sh	$7,0($6)
	sh	$10,0($8)
	sh	$12,0($11)
	sh	$15,0($14)
	sh	$fp,0($25)
	lw	$4,204($sp)
	lw	$3,244($sp)
	lw	$6,208($sp)
	lw	$5,260($sp)
	lw	$7,276($sp)
	lw	$8,320($sp)
	sh	$4,0($3)
	sw	$8,120($sp)
	sh	$6,0($5)
	b	$L4814
	sh	$2,0($7)

$L4910:
	beq	$2,$4,$L4944
	nop

	lw	$12,6168($16)
	lw	$9,6172($16)
	slt	$12,$0,$12
	slt	$9,$0,$9
$L4797:
	nor	$11,$0,$17
	nor	$8,$0,$18
	addu	$10,$20,$11
	addu	$8,$19,$8
	beq	$12,$0,$L4798
	addu	$11,$21,$11

	xori	$4,$9,0x1
	mul	$5,$4,$18
	addu	$2,$16,$4
	addu	$3,$5,$8
	addiu	$2,$2,9004
$L4799:
	lbu	$6,0($2)
	lbu	$7,0($3)
	addiu	$4,$4,1
	slt	$5,$4,17
	sb	$7,0($2)
	sb	$6,0($3)
	addiu	$2,$2,1
	bne	$5,$0,$L4799
	addu	$3,$3,$18

$L4798:
	beq	$9,$0,$L4800
	nop

	lw	$2,6168($16)
	lw	$3,8996($16)
	sll	$5,$2,5
	addu	$5,$3,$5
	lw	$6,0($5)
	lw	$7,4($5)
	lw	$14,1($8)
	lw	$15,5($8)
	sll	$4,$2,5
	addiu	$4,$4,8
	sw	$14,0($5)
	sw	$15,4($5)
	addu	$4,$3,$4
	sw	$6,1($8)
	sw	$7,5($8)
	lw	$5,144($16)
	lw	$6,0($4)
	lw	$7,4($4)
	lw	$14,9($8)
	lw	$15,13($8)
	addiu	$2,$2,1
	slt	$5,$2,$5
	sw	$14,0($4)
	sw	$15,4($4)
	sw	$6,9($8)
	beq	$5,$0,$L4800
	sw	$7,13($8)

	sll	$2,$2,5
	addu	$3,$3,$2
	lw	$4,0($3)
	lw	$5,4($3)
	lw	$6,17($8)
	lw	$7,21($8)
	sw	$6,0($3)
	sw	$7,4($3)
	sw	$4,17($8)
	sw	$5,21($8)
$L4800:
	beq	$12,$0,$L4801
	nop

	xori	$5,$9,0x1
	mul	$3,$5,$17
	addu	$2,$16,$5
	addu	$4,$10,$3
	addiu	$2,$2,9021
	addu	$3,$11,$3
$L4802:
	lbu	$7,0($3)
	lbu	$6,0($2)
	sb	$7,0($2)
	sb	$6,0($3)
	lbu	$7,9($2)
	lbu	$8,0($4)
	addiu	$5,$5,1
	slt	$6,$5,9
	sb	$8,9($2)
	addu	$3,$3,$17
	sb	$7,0($4)
	addiu	$2,$2,1
	bne	$6,$0,$L4802
	addu	$4,$4,$17

$L4801:
	beq	$9,$0,$L4795
	nop

	lw	$2,6168($16)
	lw	$3,8996($16)
	sll	$4,$2,5
	addiu	$4,$4,16
	addu	$4,$3,$4
	lw	$6,0($4)
	lw	$7,4($4)
	lw	$8,1($11)
	lw	$9,5($11)
	sll	$2,$2,5
	addiu	$2,$2,24
	sw	$8,0($4)
	sw	$9,4($4)
	addu	$2,$3,$2
	sw	$6,1($11)
	sw	$7,5($11)
	lw	$4,0($2)
	lw	$5,4($2)
	lw	$6,1($10)
	lw	$7,5($10)
	sw	$6,0($2)
	sw	$7,4($2)
	sw	$4,1($10)
	b	$L4795
	sw	$5,5($10)

$L4914:
	bne	$2,$3,$L4989
	move	$4,$fp

	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	lh	$2,7256($2)
	bne	$2,$0,$L4945
	lw	$25,168($sp)

$L4989:
	lw	$fp,132($sp)
	lw	$25,128($sp)
	addiu	$5,$fp,384
	jalr	$25
	move	$6,$18

	b	$L4955
	li	$3,65536			# 0x10000

$L4832:
	lw	$4,9548($16)
	lw	$25,128($sp)
	move	$5,$fp
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4956
	lbu	$2,9093($16)

$L4944:
	lw	$6,152($16)
	lw	$5,6172($16)
	lw	$4,6168($16)
	mul	$7,$6,$5
	lw	$2,-6288($3)
	addu	$3,$7,$4
	lw	$4,8764($16)
	addu	$3,$2,$3
	addu	$2,$2,$4
	lbu	$12,-1($3)
	lbu	$9,0($2)
	lbu	$2,0($3)
	xor	$9,$9,$2
	xor	$2,$12,$2
	sltu	$12,$2,1
	b	$L4797
	sltu	$9,$9,1

$L4942:
	lw	$5,6172($16)
	lw	$6,152($16)
	lw	$2,-6288($3)
	mul	$3,$6,$5
	lw	$4,6168($16)
	addu	$5,$3,$4
	lw	$3,8764($16)
	addu	$5,$2,$5
	addu	$2,$2,$3
	lbu	$4,-1($5)
	lbu	$3,0($5)
	lbu	$2,0($2)
	xor	$2,$2,$3
	xor	$3,$4,$3
	sltu	$4,$3,1
	b	$L4824
	sltu	$2,$2,1

$L4943:
	lw	$4,4($3)
	move	$5,$18
	addu	$4,$23,$4
	jalr	$25
	move	$6,$22

	b	$L4957
	addu	$fp,$20,$fp

$L4931:
	lw	$4,9608($16)
	lw	$25,128($sp)
	addiu	$5,$fp,480
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4946
	lw	$fp,148($sp)

$L4860:
	lw	$4,9604($16)
	addiu	$5,$fp,448
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4958
	lbu	$2,9119($16)

$L4858:
	lw	$4,9600($16)
	addiu	$5,$fp,416
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4959
	lbu	$2,9118($16)

$L4856:
	lw	$4,9596($16)
	addiu	$5,$fp,384
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4960
	lbu	$2,9111($16)

$L4854:
	lw	$4,9592($16)
	addiu	$5,$fp,352
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4961
	lbu	$2,9110($16)

$L4852:
	lw	$4,9588($16)
	addiu	$5,$fp,320
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4962
	lbu	$2,9117($16)

$L4850:
	lw	$4,9584($16)
	addiu	$5,$fp,288
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4963
	lbu	$2,9116($16)

$L4848:
	lw	$4,9580($16)
	addiu	$5,$fp,256
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4964
	lbu	$2,9109($16)

$L4846:
	lw	$4,9576($16)
	addiu	$5,$fp,224
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4965
	lbu	$2,9108($16)

$L4844:
	lw	$4,9572($16)
	addiu	$5,$fp,192
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4966
	lbu	$2,9103($16)

$L4842:
	lw	$4,9568($16)
	addiu	$5,$fp,160
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4967
	lbu	$2,9102($16)

$L4840:
	lw	$4,9564($16)
	addiu	$5,$fp,128
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4968
	lbu	$2,9095($16)

$L4838:
	lw	$4,9560($16)
	addiu	$5,$fp,96
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4969
	lbu	$2,9094($16)

$L4836:
	lw	$4,9556($16)
	addiu	$5,$fp,64
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4970
	lbu	$2,9101($16)

$L4834:
	lw	$4,9552($16)
	addiu	$5,$fp,32
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4971
	lbu	$2,9100($16)

$L4916:
	lw	$4,9548($16)
	move	$5,$fp
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4956
	lbu	$2,9093($16)

$L4918:
	lw	$4,9556($16)
	addiu	$5,$fp,64
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4970
	lbu	$2,9101($16)

$L4917:
	lw	$4,9552($16)
	addiu	$5,$fp,32
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4971
	lbu	$2,9100($16)

$L4922:
	lw	$4,9572($16)
	addiu	$5,$fp,192
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4966
	lbu	$2,9103($16)

$L4921:
	lw	$4,9568($16)
	addiu	$5,$fp,160
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4967
	lbu	$2,9102($16)

$L4920:
	lw	$4,9564($16)
	addiu	$5,$fp,128
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4968
	lbu	$2,9095($16)

$L4919:
	lw	$4,9560($16)
	addiu	$5,$fp,96
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4969
	lbu	$2,9094($16)

$L4930:
	lw	$4,9604($16)
	addiu	$5,$fp,448
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4958
	lbu	$2,9119($16)

$L4929:
	lw	$4,9600($16)
	addiu	$5,$fp,416
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4959
	lbu	$2,9118($16)

$L4928:
	lw	$4,9596($16)
	addiu	$5,$fp,384
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4960
	lbu	$2,9111($16)

$L4927:
	lw	$4,9592($16)
	addiu	$5,$fp,352
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4961
	lbu	$2,9110($16)

$L4926:
	lw	$4,9588($16)
	addiu	$5,$fp,320
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4962
	lbu	$2,9117($16)

$L4925:
	lw	$4,9584($16)
	addiu	$5,$fp,288
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4963
	lbu	$2,9116($16)

$L4924:
	lw	$4,9580($16)
	addiu	$5,$fp,256
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4964
	lbu	$2,9109($16)

$L4923:
	lw	$4,9576($16)
	addiu	$5,$fp,224
	addu	$4,$19,$4
	jalr	$25
	move	$6,$18

	b	$L4965
	lbu	$2,9108($16)

$L4911:
	move	$4,$fp
	jalr	$25
	move	$6,$18

	b	$L4972
	addiu	$2,$16,14

$L4912:
	lw	$25,168($sp)
	addiu	$5,$fp,128
	jalr	$25
	move	$6,$18

	b	$L4973
	addiu	$2,$16,28

$L4913:
	lw	$25,168($sp)
	addiu	$5,$fp,256
	jalr	$25
	move	$6,$18

	b	$L4974
	addiu	$2,$16,30

$L4945:
	lw	$fp,132($sp)
	addiu	$5,$fp,384
	jalr	$25
	move	$6,$18

	b	$L4955
	li	$3,65536			# 0x10000

	.set	macro
	.set	reorder
	.end	hl_decode_mb_simple
	.size	hl_decode_mb_simple, .-hl_decode_mb_simple
	.section	.rodata.str1.4
	.align	2
$LC79:
	.ascii	"SEQH\000"
	.align	2
$LC80:
	.ascii	"%c hpel:%d, tpel:%d aqp:%d qp:%d\012\000"
	.align	2
$LC81:
	.ascii	"error in B-frame picture id\012\000"
	.align	2
$LC82:
	.ascii	"error while decoding MB %d %d\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	svq3_decode_frame
	.type	svq3_decode_frame, @function
svq3_decode_frame:
	.frame	$sp,112,$31		# vars= 32, regs= 10/0, args= 32, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-112
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,108($sp)
	sw	$fp,104($sp)
	sw	$23,100($sp)
	sw	$22,96($sp)
	sw	$21,92($sp)
	sw	$20,88($sp)
	sw	$19,84($sp)
	sw	$18,80($sp)
	sw	$17,76($sp)
	sw	$16,72($sp)
	.cprestore	32
	lw	$16,136($4)
	lw	$2,12($4)
	lw	$18,128($sp)
	sw	$2,56($16)
	move	$17,$4
	lw	$3,112($16)
	lw	$4,604($4)
	li	$2,1			# 0x1
	sw	$4,60($16)
	move	$19,$5
	move	$20,$6
	beq	$3,$0,$L5072
	sw	$2,2128($16)

$L4991:
	bne	$18,$0,$L5001
	sll	$21,$18,3

	lw	$2,1876($16)
	beq	$2,$0,$L5091
	lw	$31,108($sp)

	lw	$2,8240($16)
	bne	$2,$0,$L5092
	move	$2,$18

	addiu	$2,$16,840
	addiu	$16,$16,648
$L5003:
	lw	$6,0($16)
	lw	$5,4($16)
	lw	$4,8($16)
	lw	$3,12($16)
	addiu	$16,$16,16
	sw	$6,0($19)
	sw	$5,4($19)
	sw	$4,8($19)
	sw	$3,12($19)
	bne	$16,$2,$L5003
	addiu	$19,$19,16

	lw	$2,0($16)
	lw	$3,4($16)
	sw	$2,0($19)
	li	$2,200			# 0xc8
	sw	$3,4($19)
	sw	$2,0($20)
$L5002:
	lw	$31,108($sp)
$L5091:
	move	$2,$18
$L5092:
	lw	$fp,104($sp)
	lw	$23,100($sp)
	lw	$22,96($sp)
	lw	$21,92($sp)
	lw	$20,88($sp)
	lw	$19,84($sp)
	lw	$18,80($sp)
	lw	$17,76($sp)
	lw	$16,72($sp)
	j	$31
	addiu	$sp,$sp,112

$L5072:
	lw	$4,40($17)
	li	$3,4			# 0x4
	sw	$4,4($16)
	lw	$4,44($17)
	lw	$25,%call16(MPV_common_init)($28)
	sw	$4,8($16)
	sw	$2,9776($16)
	sw	$3,8740($16)
	sw	$2,9772($16)
	sw	$0,9780($16)
	sw	$3,8744($16)
	move	$4,$16
	jalr	$25
	sw	$7,64($sp)

	bltz	$2,$L4992
	move	$4,$16

	lw	$2,144($16)
	sll	$2,$2,2
	.option	pic0
	jal	alloc_tables
	.option	pic2
	sw	$2,9748($16)

	lw	$23,28($17)
	lw	$28,32($sp)
	lw	$21,24($17)
	blez	$23,$L4993
	lw	$7,64($sp)

	lui	$fp,%hi($LC79)
	addiu	$fp,$fp,%lo($LC79)
	b	$L4994
	move	$22,$0

$L5073:
	beq	$3,$0,$L4993
	addiu	$21,$21,1

$L4994:
	lw	$25,%call16(memcmp)($28)
	sw	$7,64($sp)
	move	$4,$21
	move	$5,$fp
	jalr	$25
	li	$6,4			# 0x4

	addiu	$22,$22,1
	lw	$28,32($sp)
	slt	$3,$22,$23
	bne	$2,$0,$L5073
	lw	$7,64($sp)

$L4993:
	beq	$21,$0,$L4991
	lw	$25,%call16(memcmp)($28)

	lui	$5,%hi($LC79)
	sw	$7,64($sp)
	addiu	$5,$5,%lo($LC79)
	move	$4,$21
	jalr	$25
	li	$6,4			# 0x4

	bne	$2,$0,$L4991
	lw	$7,64($sp)

	lbu	$5,4($21)
	lbu	$3,5($21)
	sll	$5,$5,24
	sll	$3,$3,16
	lbu	$4,7($21)
	lbu	$2,6($21)
	or	$3,$5,$3
	or	$3,$3,$4
	sll	$2,$2,8
	or	$2,$3,$2
	sll	$2,$2,3
	sra	$3,$2,3
	bltz	$3,$L4995
	nop

	bltz	$2,$L4995
	nop

	addiu	$21,$21,8
	addu	$3,$21,$3
$L4996:
	addiu	$4,$sp,40
	li	$5,3			# 0x3
	sw	$3,44($sp)
	sw	$7,64($sp)
	sw	$21,40($sp)
	sw	$2,52($sp)
	.option	pic0
	jal	get_bits
	.option	pic2
	sw	$0,48($sp)

	li	$3,7			# 0x7
	beq	$2,$3,$L4997
	lw	$7,64($sp)

	lw	$2,48($sp)
$L4998:
	lw	$5,40($sp)
	sra	$3,$2,3
	addu	$3,$5,$3
	lbu	$6,0($3)
	andi	$3,$2,0x7
	sll	$6,$6,$3
	andi	$6,$6,0x00ff
	addiu	$3,$2,1
	srl	$6,$6,7
	sra	$4,$3,3
	sw	$3,48($sp)
	addu	$4,$5,$4
	sw	$6,9772($16)
	lbu	$6,0($4)
	andi	$3,$3,0x7
	sll	$6,$6,$3
	andi	$6,$6,0x00ff
	addiu	$3,$2,6
	srl	$6,$6,7
	sra	$4,$3,3
	sw	$6,9776($16)
	addu	$4,$5,$4
	sw	$3,48($sp)
	lbu	$6,0($4)
	andi	$3,$3,0x7
	sll	$6,$6,$3
	andi	$6,$6,0x00ff
	addiu	$3,$2,8
	srl	$6,$6,7
	sra	$4,$3,3
	sw	$6,8240($16)
	addu	$4,$5,$4
	b	$L5066
	sw	$3,48($sp)

$L5074:
	addiu	$3,$2,8
	sra	$4,$3,3
	sw	$3,48($sp)
	addu	$4,$5,$4
$L5066:
	lbu	$4,0($4)
	andi	$3,$3,0x7
	sll	$3,$4,$3
	andi	$3,$3,0x00ff
	addiu	$2,$2,9
	srl	$3,$3,7
	bne	$3,$0,$L5074
	sw	$2,48($sp)

	sra	$3,$2,3
	addu	$5,$5,$3
	lbu	$3,0($5)
	addiu	$4,$2,1
	sw	$4,48($sp)
	andi	$2,$2,0x7
	sll	$3,$3,$2
	lw	$2,8240($16)
	andi	$3,$3,0x00ff
	srl	$3,$3,7
	sltu	$2,$2,1
	sw	$3,9780($16)
	b	$L4991
	sw	$2,268($17)

$L5001:
	sra	$2,$21,3
	bltz	$2,$L5004
	nop

	bltz	$21,$L5004
	nop

	addu	$2,$7,$2
	move	$3,$21
$L5005:
	sw	$7,8448($16)
	sw	$3,8460($16)
	sw	$2,8452($16)
	sw	$0,8456($16)
	sw	$0,6172($16)
	sw	$0,6168($16)
	.option	pic0
	jal	svq3_decode_slice_header
	.option	pic2
	move	$4,$16

	bne	$2,$0,$L4992
	lw	$28,32($sp)

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$4,-6284($2)
	sw	$4,2084($16)
	lw	$2,-6296($2)
	sw	$2,124($16)
	lw	$2,412($17)
	andi	$2,$2,0x1
	bne	$2,$0,$L5063
	lw	$25,%call16(av_get_pict_type_char)($28)

$L5067:
	xori	$5,$4,0x1
	lw	$3,1872($16)
	sltu	$5,$5,1
	move	$2,$4
	sw	$4,1516($16)
	beq	$3,$0,$L5075
	sw	$5,1512($16)

$L5007:
	lw	$3,128($17)
	beq	$3,$0,$L5009
	li	$4,3			# 0x3

	beq	$2,$4,$L5008
	slt	$3,$3,5

	bne	$3,$0,$L5009
	nop

$L5008:
	b	$L5002
	move	$18,$0

$L5009:
	lw	$3,716($17)
	slt	$4,$3,8
	beq	$4,$0,$L5076
	li	$4,3			# 0x3

$L5010:
	lw	$3,7988($16)
	beq	$3,$0,$L5011
	li	$3,3			# 0x3

	beq	$2,$3,$L5008
	nop

	sw	$0,7988($16)
$L5011:
	.option	pic0
	jal	frame_start
	.option	pic2
	move	$4,$16

	bltz	$2,$L4992
	lw	$28,32($sp)

	lw	$3,2084($16)
	li	$2,3			# 0x3
	beq	$3,$2,$L5077
	li	$2,65536			# 0x10000

	addu	$2,$16,$2
	lw	$3,-6228($2)
	lw	$4,-6296($2)
	sw	$3,-6208($2)
	subu	$3,$4,$3
	sw	$4,-6228($2)
	bgez	$3,$L5015
	sw	$3,-6212($2)

	addiu	$3,$3,256
	sw	$3,-6212($2)
$L5015:
	move	$2,$16
$L5094:
	move	$5,$0
	li	$3,1			# 0x1
	li	$4,-2			# 0xfffffffffffffffe
	li	$6,2			# 0x2
$L5016:
	addiu	$5,$5,1
	sb	$3,9467($2)
	sb	$3,9468($2)
	sb	$3,9469($2)
	sb	$3,9470($2)
	sb	$3,9471($2)
	sb	$4,9472($2)
	sb	$3,9475($2)
	sb	$3,9476($2)
	sb	$3,9477($2)
	sb	$3,9478($2)
	sb	$3,9479($2)
	sb	$4,9480($2)
	sb	$3,9483($2)
	sb	$3,9484($2)
	sb	$3,9485($2)
	sb	$3,9486($2)
	sb	$3,9487($2)
	sb	$4,9488($2)
	sb	$3,9491($2)
	sb	$3,9492($2)
	sb	$3,9493($2)
	sb	$3,9494($2)
	sb	$3,9495($2)
	bne	$5,$6,$L5016
	addiu	$2,$2,40

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	sw	$2,56($sp)
	lw	$22,%got(ff_interleaved_golomb_vlc_len)($28)
	addiu	$2,$16,8448
	lw	$23,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	sw	$2,60($sp)
	sw	$0,6172($16)
	move	$2,$0
	li	$fp,9			# 0x9
$L5017:
	lw	$3,148($16)
	slt	$2,$2,$3
	beq	$2,$0,$L5078
	lw	$25,%call16(MPV_frame_end)($28)

	lw	$2,144($16)
	blez	$2,$L5018
	sw	$0,6168($16)

$L5053:
	lw	$2,8456($16)
	lw	$3,8460($16)
	addiu	$4,$2,7
	slt	$3,$4,$3
	bne	$3,$0,$L5068
	andi	$5,$2,0x7

	beq	$5,$0,$L5021
	sra	$3,$2,3

	lw	$4,8448($16)
	addu	$3,$4,$3
	lbu	$6,0($3)
	lbu	$8,3($3)
	lbu	$7,1($3)
	lbu	$4,2($3)
	sll	$6,$6,24
	sll	$3,$7,16
	or	$6,$8,$6
	or	$6,$6,$3
	sll	$4,$4,8
	subu	$3,$0,$2
	or	$4,$6,$4
	sll	$4,$4,$5
	andi	$3,$3,0x7
	li	$5,32			# 0x20
	subu	$3,$5,$3
	srl	$3,$4,$3
	beq	$3,$0,$L5021
	nop

$L5020:
	li	$6,-1434451968			# 0xffffffffaa800000
	and	$3,$4,$6
	bne	$3,$0,$L5022
	lw	$7,%got(ff_interleaved_ue_golomb_vlc_code)($28)

	srl	$4,$4,24
	addu	$3,$22,$4
	lbu	$3,0($3)
	sltu	$5,$3,9
	beq	$5,$0,$L5079
	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

	li	$5,1			# 0x1
$L5029:
	addu	$2,$2,$3
$L5027:
	addiu	$3,$3,-1
$L5089:
	addu	$4,$9,$4
	sra	$6,$3,1
	lbu	$3,0($4)
	sll	$5,$5,$6
	or	$3,$3,$5
	sw	$2,8456($16)
	addiu	$3,$3,-1
$L5025:
	lw	$2,2084($16)
	li	$4,1			# 0x1
	beq	$2,$4,$L5080
	li	$5,3			# 0x3

	beq	$2,$5,$L5081
	slt	$2,$3,4

$L5032:
	slt	$2,$3,34
	beq	$2,$0,$L5034
	move	$5,$3

$L5093:
	move	$4,$16
	.option	pic0
	jal	svq3_decode_mb
	.option	pic2
	sw	$3,64($sp)

	lw	$28,32($sp)
	bne	$2,$0,$L5034
	lw	$3,64($sp)

	bne	$3,$0,$L5082
	lw	$8,56($sp)

$L5036:
	lw	$2,2084($16)
	li	$5,3			# 0x3
	beq	$2,$5,$L5040
	nop

	lw	$4,8240($16)
	bne	$4,$0,$L5040
	li	$8,2			# 0x2

	lw	$4,1568($16)
	lw	$5,6168($16)
	lw	$6,6172($16)
	beq	$2,$8,$L5083
	lw	$7,152($16)

$L5041:
	li	$3,-1			# 0xffffffffffffffff
	mul	$8,$7,$6
$L5097:
	addu	$2,$8,$5
	sll	$2,$2,2
	addu	$2,$4,$2
	sw	$3,0($2)
$L5040:
	lw	$2,6168($16)
	lw	$3,144($16)
	addiu	$2,$2,1
	slt	$3,$2,$3
	bne	$3,$0,$L5053
	sw	$2,6168($16)

$L5018:
	lw	$5,6172($16)
	lw	$25,%call16(ff_draw_horiz_band)($28)
	sll	$5,$5,4
	move	$4,$16
	jalr	$25
	li	$6,16			# 0x10

	lw	$2,6172($16)
	lw	$28,32($sp)
	addiu	$2,$2,1
	b	$L5017
	sw	$2,6172($16)

$L5083:
	slt	$2,$3,8
	beq	$2,$0,$L5041
	addiu	$3,$3,-1

	b	$L5097
	mul	$8,$7,$6

$L4992:
	b	$L5002
	li	$18,-1			# 0xffffffffffffffff

$L5004:
	move	$2,$0
	move	$3,$0
	b	$L5005
	move	$7,$0

$L5063:
	jalr	$25
	lw	$22,0($16)

	lw	$3,9772($16)
	lw	$28,32($sp)
	sw	$3,16($sp)
	lw	$3,9776($16)
	lw	$25,%call16(av_log)($28)
	sw	$3,20($sp)
	lw	$3,2076($16)
	lui	$6,%hi($LC80)
	sw	$3,24($sp)
	lw	$3,2056($16)
	move	$4,$22
	addiu	$6,$6,%lo($LC80)
	sw	$3,28($sp)
	move	$7,$2
	jalr	$25
	li	$5,2			# 0x2

	b	$L5067
	lw	$4,2084($16)

$L5076:
	beq	$2,$4,$L5008
	slt	$4,$3,32

	bne	$4,$0,$L5010
	li	$4,1			# 0x1

	bne	$2,$4,$L5008
	slt	$3,$3,48

	bne	$3,$0,$L5010
	nop

	b	$L5002
	move	$18,$0

$L5075:
	li	$3,3			# 0x3
	bne	$4,$3,$L5007
	nop

	b	$L5002
	move	$18,$0

$L5022:
	srl	$4,$4,24
	addu	$3,$22,$4
	lbu	$3,0($3)
	addu	$2,$3,$2
	addu	$4,$7,$4
	sw	$2,8456($16)
	b	$L5025
	lbu	$3,0($4)

$L5021:
	lw	$2,9784($16)
	sw	$21,8460($16)
	sw	$2,8456($16)
	.option	pic0
	jal	svq3_decode_slice_header
	.option	pic2
	move	$4,$16

	bne	$2,$0,$L4992
	lw	$28,32($sp)

	lw	$2,8456($16)
$L5068:
	lw	$4,8448($16)
	sra	$3,$2,3
	addu	$3,$4,$3
	lbu	$5,0($3)
	lbu	$4,1($3)
	lbu	$6,3($3)
	sll	$5,$5,24
	lbu	$3,2($3)
	or	$5,$6,$5
	sll	$4,$4,16
	sll	$3,$3,8
	or	$4,$5,$4
	or	$4,$4,$3
	andi	$3,$2,0x7
	b	$L5020
	sll	$4,$4,$3

$L5079:
	bne	$3,$fp,$L5084
	addiu	$2,$2,8

	lw	$3,60($sp)
	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)
	lw	$8,0($3)
	li	$5,1			# 0x1
$L5028:
	sra	$3,$2,3
	addu	$3,$8,$3
	lbu	$10,0($3)
	lbu	$7,1($3)
	lbu	$11,3($3)
	lbu	$6,2($3)
	sll	$10,$10,24
	sll	$7,$7,16
	or	$3,$11,$10
	or	$3,$3,$7
	sll	$6,$6,8
	or	$3,$3,$6
	andi	$6,$2,0x7
	sll	$3,$3,$6
	addu	$6,$23,$4
	srl	$4,$3,24
	addu	$3,$22,$4
	lbu	$3,0($3)
	lbu	$7,0($6)
	sll	$5,$5,4
	sltu	$6,$3,9
	bne	$6,$0,$L5029
	or	$5,$7,$5

	beq	$3,$fp,$L5028
	addiu	$2,$2,8

	b	$L5089
	addiu	$3,$3,-1

$L5080:
	b	$L5032
	addiu	$3,$3,8

$L5082:
	lw	$4,6172($16)
	lw	$6,152($16)
	lw	$2,6168($16)
	mul	$7,$6,$4
	addu	$4,$7,$2
	lw	$5,1568($16)
	sll	$4,$4,2
	lw	$2,-6276($8)
	addu	$4,$5,$4
	bne	$2,$0,$L5037
	lw	$4,0($4)

	lw	$2,-6272($8)
	bne	$2,$0,$L5038
	li	$2,1			# 0x1

	andi	$4,$4,0x4
	bne	$4,$0,$L5038
	li	$4,28			# 0x1c

	lw	$2,44($16)
	beq	$2,$4,$L5085
	nop

$L5037:
	li	$2,1			# 0x1
$L5038:
	lw	$4,2136($16)
	beq	$4,$0,$L5036
	nop

	bne	$2,$0,$L5086
	move	$4,$16

	.option	pic0
	jal	hl_decode_mb_simple
	.option	pic2
	sw	$3,64($sp)

	lw	$28,32($sp)
	b	$L5036
	lw	$3,64($sp)

$L5085:
	lw	$2,56($16)
	andi	$2,$2,0x2000
	bne	$2,$0,$L5037
	nop

	lw	$2,52($16)
	b	$L5038
	sltu	$2,$0,$2

$L4995:
	move	$3,$0
	move	$2,$0
	b	$L4996
	move	$21,$0

$L5081:
	bne	$2,$0,$L5093
	move	$5,$3

	b	$L5032
	addiu	$3,$3,4

$L4997:
	lw	$2,48($sp)
	addiu	$2,$2,24
	b	$L4998
	sw	$2,48($sp)

$L5086:
	.option	pic0
	jal	hl_decode_mb_complex
	.option	pic2
	sw	$3,64($sp)

	lw	$28,32($sp)
	b	$L5036
	lw	$3,64($sp)

$L5034:
	lw	$2,6172($16)
	lw	$4,0($16)
	lw	$7,6168($16)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC82)
	sw	$2,16($sp)
	addiu	$6,$6,%lo($LC82)
	jalr	$25
	move	$5,$0

	b	$L5002
	li	$18,-1			# 0xffffffffffffffff

$L5077:
	li	$3,65536			# 0x10000
	addu	$3,$16,$3
	lw	$4,-6296($3)
	lw	$2,-6208($3)
	subu	$2,$4,$2
	bltz	$2,$L5087
	sw	$2,-6216($3)

$L5013:
	beq	$2,$0,$L5014
	li	$3,65536			# 0x10000

	addu	$3,$16,$3
	lw	$3,-6212($3)
	slt	$2,$2,$3
	bne	$2,$0,$L5094
	move	$2,$16

$L5014:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC81)
	addiu	$6,$6,%lo($LC81)
	jalr	$25
	move	$5,$0

	b	$L5002
	li	$18,-1			# 0xffffffffffffffff

$L5087:
	addiu	$2,$2,256
	b	$L5013
	sw	$2,-6216($3)

$L5084:
	li	$5,1			# 0x1
	b	$L5027
	lw	$9,%got(ff_interleaved_dirac_golomb_vlc_code)($28)

$L5078:
	jalr	$25
	move	$4,$16

	lw	$3,2084($16)
	li	$2,3			# 0x3
	beq	$3,$2,$L5095
	addiu	$2,$16,1464

	lw	$2,8240($16)
	beq	$2,$0,$L5046
	addiu	$2,$16,240

	addiu	$2,$16,1464
$L5095:
	addiu	$3,$16,1656
$L5047:
	lw	$7,0($2)
	lw	$6,4($2)
	lw	$5,8($2)
	lw	$4,12($2)
	addiu	$2,$2,16
	sw	$7,0($19)
	sw	$6,4($19)
	sw	$5,8($19)
	sw	$4,12($19)
	bne	$2,$3,$L5047
	addiu	$19,$19,16

	lw	$3,4($2)
$L5090:
	lw	$2,0($2)
	sw	$3,4($19)
	sw	$2,0($19)
	lw	$3,124($16)
	lw	$2,1872($16)
	addiu	$3,$3,-1
	beq	$2,$0,$L5088
	sw	$3,80($17)

	li	$2,200			# 0xc8
$L5096:
	b	$L5002
	sw	$2,0($20)

$L5046:
	addiu	$3,$16,432
$L5049:
	lw	$7,0($2)
	lw	$6,4($2)
	lw	$5,8($2)
	lw	$4,12($2)
	addiu	$2,$2,16
	sw	$7,0($19)
	sw	$6,4($19)
	sw	$5,8($19)
	sw	$4,12($19)
	bne	$2,$3,$L5049
	addiu	$19,$19,16

	b	$L5090
	lw	$3,4($2)

$L5088:
	lw	$2,8240($16)
	bne	$2,$0,$L5096
	li	$2,200			# 0xc8

	b	$L5091
	lw	$31,108($sp)

	.set	macro
	.set	reorder
	.end	svq3_decode_frame
	.size	svq3_decode_frame, .-svq3_decode_frame
	.section	.rodata.str1.4
	.align	2
$LC83:
	.ascii	"error while decoding MB %d %d, bytestream (%td)\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_slice
	.type	decode_slice, @function
decode_slice:
	.frame	$sp,72,$31		# vars= 8, regs= 8/0, args= 24, gp= 8
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-72
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,68($sp)
	sw	$22,64($sp)
	sw	$21,60($sp)
	sw	$20,56($sp)
	sw	$19,52($sp)
	sw	$18,48($sp)
	sw	$17,44($sp)
	sw	$16,40($sp)
	.cprestore	24
	lw	$4,8228($5)
	li	$3,18			# 0x12
	li	$17,127			# 0x7f
	lw	$2,11808($5)
	movn	$17,$3,$4
	li	$3,-1			# 0xffffffffffffffff
	move	$16,$5
	beq	$2,$0,$L5164
	sw	$3,6176($5)

	lw	$2,8456($5)
	subu	$3,$0,$2
	andi	$3,$3,0x7
	beq	$3,$0,$L5195
	li	$18,131072			# 0x20000

	addu	$2,$3,$2
	sw	$2,8456($5)
$L5195:
	ori	$19,$18,0x1fd8
	lw	$25,%call16(ff_init_cabac_states)($28)
	addu	$19,$16,$19
	jalr	$25
	move	$4,$19

	lw	$6,8460($16)
	lw	$2,8456($16)
	addiu	$6,$6,7
	subu	$6,$6,$2
	lw	$28,24($sp)
	addiu	$3,$2,7
	slt	$4,$2,0
	movn	$2,$3,$4
	lw	$5,8448($16)
	addiu	$3,$6,7
	slt	$4,$6,0
	movn	$6,$3,$4
	sra	$2,$2,3
	lw	$25,%call16(ff_init_cabac_decoder)($28)
	addu	$5,$5,$2
	move	$4,$19
	jalr	$25
	sra	$6,$6,3

	li	$2,65536			# 0x10000
	addu	$2,$16,$2
	lw	$3,-6284($2)
	li	$2,1			# 0x1
	beq	$3,$2,$L5105
	li	$9,63			# 0x3f

	ori	$4,$18,0x2004
	lui	$8,%hi(cabac_context_init_PB)
	lw	$7,2056($16)
	addu	$4,$16,$4
	addiu	$8,$8,%lo(cabac_context_init_PB)
	addu	$18,$16,$18
	move	$2,$0
	b	$L5114
	li	$6,460			# 0x1cc

$L5171:
	bne	$5,$0,$L5179
	slt	$5,$3,64

	li	$3,125			# 0x7d
$L5110:
	addiu	$2,$2,1
	sb	$3,0($4)
	beq	$2,$6,$L5115
	addiu	$4,$4,1

$L5114:
	lw	$5,8656($18)
	mul	$3,$5,$6
	addu	$5,$3,$2
	sll	$5,$5,1
	addu	$5,$8,$5
	lb	$3,0($5)
	lb	$5,1($5)
	mul	$3,$3,$7
	sra	$3,$3,4
	addu	$3,$3,$5
	bgtz	$3,$L5171
	slt	$5,$3,127

	li	$3,124			# 0x7c
	addiu	$2,$2,1
	sb	$3,0($4)
	bne	$2,$6,$L5114
	addiu	$4,$4,1

$L5115:
	li	$19,65536			# 0x10000
	li	$18,131072			# 0x20000
	li	$20,-65536			# 0xffffffffffff0000
	addu	$19,$16,$19
	addu	$18,$16,$18
	ori	$20,$20,0x1
	li	$21,28			# 0x1c
$L5165:
	.option	pic0
	jal	decode_mb_cabac
	.option	pic2
	move	$4,$16

	bgez	$2,$L5173
	lw	$28,24($sp)

	lw	$5,6172($16)
	lw	$7,6168($16)
$L5123:
	lw	$6,8156($18)
	lw	$4,8152($18)
	addiu	$3,$6,-2
	sll	$8,$3,17
	slt	$8,$4,$8
	beq	$8,$0,$L5133
	sw	$3,8156($18)

$L5188:
	addiu	$6,$6,-258
	srl	$6,$6,31
	sll	$4,$4,$6
	sll	$3,$3,$6
	andi	$8,$4,0xffff
	sw	$3,8156($18)
	beq	$8,$0,$L5134
	sw	$4,8152($18)

	lw	$3,8168($18)
	move	$22,$0
$L5135:
	bltz	$2,$L5180
	li	$2,131072			# 0x20000

	lw	$2,8172($18)
	addiu	$4,$2,2
	sltu	$4,$4,$3
	bne	$4,$0,$L5137
	nop

	lw	$2,144($16)
	addiu	$7,$7,1
	slt	$2,$7,$2
	beq	$2,$0,$L5140
	sw	$7,6168($16)

	move	$2,$5
$L5141:
	bne	$22,$0,$L5178
	nop

	lw	$3,148($16)
	slt	$3,$2,$3
	bne	$3,$0,$L5165
	nop

$L5178:
	lw	$5,7960($16)
	lw	$6,7964($16)
	lw	$7,6168($16)
$L5175:
	lw	$25,%call16(ff_er_add_slice)($28)
	andi	$17,$17,0x70
	sw	$2,16($sp)
	sw	$17,20($sp)
	move	$4,$16
	jalr	$25
	addiu	$7,$7,-1

	lw	$31,68($sp)
	move	$2,$0
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	j	$31
	addiu	$sp,$sp,72

$L5164:
	li	$18,65536			# 0x10000
	addu	$18,$5,$18
	li	$19,28			# 0x1c
$L5170:
	.option	pic0
	jal	decode_mb_cavlc
	.option	pic2
	move	$4,$16

	bgez	$2,$L5143
	lw	$28,24($sp)

	lw	$2,6172($16)
$L5144:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lw	$7,6168($16)
	lui	$6,%hi($LC82)
	sw	$2,16($sp)
	addiu	$6,$6,%lo($LC82)
	jalr	$25
	move	$5,$0

	lw	$28,24($sp)
$L5157:
	lw	$5,7960($16)
	lw	$6,7964($16)
	lw	$7,6168($16)
	lw	$2,6172($16)
	andi	$17,$17,0xe
$L5176:
	lw	$25,%call16(ff_er_add_slice)($28)
	sw	$2,16($sp)
	sw	$17,20($sp)
	jalr	$25
	move	$4,$16

	lw	$31,68($sp)
	li	$2,-1			# 0xffffffffffffffff
	lw	$22,64($sp)
	lw	$21,60($sp)
	lw	$20,56($sp)
	lw	$19,52($sp)
	lw	$18,48($sp)
	lw	$17,44($sp)
	lw	$16,40($sp)
	j	$31
	addiu	$sp,$sp,72

$L5143:
	lw	$2,6172($16)
	lw	$4,152($16)
	lw	$7,6168($16)
	mul	$5,$4,$2
	lw	$3,1568($16)
	addu	$7,$5,$7
	sll	$7,$7,2
	lw	$2,-6276($18)
	addu	$7,$3,$7
	bne	$2,$0,$L5145
	lw	$3,0($7)

	lw	$4,-6272($18)
	bne	$4,$0,$L5145
	andi	$3,$3,0x4

	bne	$3,$0,$L5146
	li	$4,1			# 0x1

	lw	$3,44($16)
	beq	$3,$19,$L5181
	nop

$L5145:
	li	$4,1			# 0x1
$L5146:
	lw	$3,2136($16)
	beq	$3,$0,$L5147
	nop

	bne	$4,$0,$L5182
	nop

	.option	pic0
	jal	hl_decode_mb_simple
	.option	pic2
	move	$4,$16

	lw	$28,24($sp)
	lw	$2,-6276($18)
$L5147:
	bne	$2,$0,$L5159
	move	$4,$16

	lw	$7,6168($16)
$L5160:
	lw	$2,144($16)
	addiu	$7,$7,1
	slt	$2,$7,$2
	beq	$2,$0,$L5183
	sw	$7,6168($16)

$L5154:
	lw	$3,8456($16)
	lw	$2,8460($16)
	slt	$4,$3,$2
	bne	$4,$0,$L5170
	nop

	lw	$4,6176($16)
	bgtz	$4,$L5170
	nop

	bne	$3,$2,$L5157
	nop

	lw	$5,7960($16)
	lw	$6,7964($16)
	lw	$7,6168($16)
	b	$L5175
	lw	$2,6172($16)

$L5183:
	lw	$5,6172($16)
	lw	$25,%call16(ff_draw_horiz_band)($28)
	move	$4,$16
	sw	$0,6168($16)
	sll	$5,$5,4
	jalr	$25
	li	$6,16			# 0x10

	lw	$3,6172($16)
	lw	$4,-6276($18)
	addiu	$2,$3,1
	lw	$28,24($sp)
	beq	$4,$0,$L5155
	sw	$2,6172($16)

	addiu	$2,$3,2
	sw	$2,6172($16)
$L5155:
	lw	$3,148($16)
	slt	$3,$2,$3
	bne	$3,$0,$L5154
	nop

	lw	$4,8460($16)
	lw	$3,8456($16)
	beq	$4,$3,$L5178
	nop

	lw	$5,7960($16)
	lw	$6,7964($16)
	lw	$7,6168($16)
	b	$L5176
	andi	$17,$17,0x70

$L5159:
	lw	$2,6172($16)
	addiu	$2,$2,1
	.option	pic0
	jal	decode_mb_cavlc
	.option	pic2
	sw	$2,6172($16)

	bltz	$2,$L5149
	lw	$28,24($sp)

	lw	$4,152($16)
	lw	$2,6172($16)
	lw	$7,6168($16)
	mul	$3,$2,$4
	lw	$5,1568($16)
	addu	$4,$3,$7
	sll	$4,$4,2
	lw	$3,-6276($18)
	addu	$4,$5,$4
	beq	$3,$0,$L5184
	lw	$4,0($4)

$L5150:
	li	$4,1			# 0x1
$L5151:
	lw	$3,2136($16)
	beq	$3,$0,$L5196
	addiu	$2,$2,-1

	bne	$4,$0,$L5185
	nop

	.option	pic0
	jal	hl_decode_mb_simple
	.option	pic2
	move	$4,$16

	lw	$28,24($sp)
	lw	$2,6172($16)
	lw	$7,6168($16)
	addiu	$2,$2,-1
$L5196:
	b	$L5160
	sw	$2,6172($16)

$L5182:
	.option	pic0
	jal	hl_decode_mb_complex
	.option	pic2
	move	$4,$16

	lw	$28,24($sp)
	b	$L5147
	lw	$2,-6276($18)

$L5149:
	lw	$2,6172($16)
	addiu	$2,$2,-1
	b	$L5144
	sw	$2,6172($16)

$L5184:
	lw	$3,-6272($18)
	bne	$3,$0,$L5150
	andi	$4,$4,0x4

	bne	$4,$0,$L5150
	nop

	lw	$3,44($16)
	bne	$3,$19,$L5150
	nop

	lw	$3,56($16)
	andi	$3,$3,0x2000
	bne	$3,$0,$L5150
	nop

	lw	$4,52($16)
	b	$L5151
	sltu	$4,$0,$4

$L5185:
	.option	pic0
	jal	hl_decode_mb_complex
	.option	pic2
	move	$4,$16

	lw	$2,6172($16)
	lw	$28,24($sp)
	addiu	$2,$2,-1
	lw	$7,6168($16)
	b	$L5160
	sw	$2,6172($16)

$L5179:
	beq	$5,$0,$L5109
	nop

	subu	$3,$9,$3
	sll	$3,$3,1
	b	$L5110
	andi	$3,$3,0x00ff

$L5109:
	addiu	$3,$3,-64
	andi	$3,$3,0x00ff
	sll	$3,$3,1
	addiu	$3,$3,1
	b	$L5110
	andi	$3,$3,0x00ff

$L5173:
	lw	$3,152($16)
	lw	$5,6172($16)
	lw	$7,6168($16)
	mul	$6,$3,$5
	lw	$4,1568($16)
	addu	$7,$6,$7
	sll	$7,$7,2
	lw	$3,-6276($19)
	addu	$7,$4,$7
	bne	$3,$0,$L5124
	lw	$4,0($7)

	lw	$6,-6272($19)
	bne	$6,$0,$L5125
	li	$6,1			# 0x1

	andi	$4,$4,0x4
	beq	$4,$0,$L5186
	nop

$L5124:
	li	$6,1			# 0x1
$L5125:
	lw	$4,2136($16)
	beq	$4,$0,$L5126
	nop

	bne	$6,$0,$L5187
	move	$4,$16

	.option	pic0
	jal	hl_decode_mb_simple
	.option	pic2
	sw	$2,32($sp)

	lw	$28,24($sp)
$L5193:
	lw	$3,-6276($19)
	lw	$5,6172($16)
	lw	$2,32($sp)
$L5126:
	bne	$3,$0,$L5158
	nop

	lw	$6,8156($18)
	lw	$4,8152($18)
	addiu	$3,$6,-2
	sll	$8,$3,17
	slt	$8,$4,$8
	lw	$7,6168($16)
	bne	$8,$0,$L5188
	sw	$3,8156($18)

$L5133:
	lw	$3,8168($18)
	lw	$22,8164($18)
	b	$L5135
	subu	$22,$3,$22

$L5158:
	addiu	$5,$5,1
	sw	$5,6172($16)
	.option	pic0
	jal	decode_mb_cabac
	.option	pic2
	move	$4,$16

	bgez	$2,$L5128
	lw	$28,24($sp)

	lw	$5,6172($16)
	lw	$7,6168($16)
	addiu	$5,$5,-1
$L5197:
	b	$L5123
	sw	$5,6172($16)

$L5140:
	lw	$25,%call16(ff_draw_horiz_band)($28)
	move	$4,$16
	sw	$0,6168($16)
	sll	$5,$5,4
	jalr	$25
	li	$6,16			# 0x10

	lw	$3,6172($16)
	lw	$4,-6276($19)
	addiu	$2,$3,1
	lw	$28,24($sp)
	beq	$4,$0,$L5141
	sw	$2,6172($16)

	addiu	$2,$3,2
	b	$L5141
	sw	$2,6172($16)

$L5134:
	lw	$3,8168($18)
	move	$22,$0
	lbu	$8,0($3)
	lbu	$6,1($3)
	sll	$8,$8,9
	addu	$8,$8,$20
	sll	$6,$6,1
	addu	$6,$8,$6
	addu	$4,$6,$4
	addiu	$3,$3,2
	sw	$4,8152($18)
	b	$L5135
	sw	$3,8168($18)

$L5128:
	lw	$4,152($16)
	lw	$5,6172($16)
	lw	$7,6168($16)
	mul	$3,$5,$4
	lw	$6,1568($16)
	addu	$4,$3,$7
	sll	$4,$4,2
	lw	$3,-6276($19)
	addu	$4,$6,$4
	bne	$3,$0,$L5130
	lw	$4,0($4)

	lw	$3,-6272($19)
	beq	$3,$0,$L5189
	andi	$4,$4,0x4

$L5130:
	li	$4,1			# 0x1
$L5131:
	lw	$3,2136($16)
	beq	$3,$0,$L5197
	addiu	$5,$5,-1

	bne	$4,$0,$L5190
	move	$4,$16

	.option	pic0
	jal	hl_decode_mb_simple
	.option	pic2
	sw	$2,32($sp)

	lw	$5,6172($16)
$L5194:
	lw	$28,24($sp)
	addiu	$5,$5,-1
	lw	$7,6168($16)
	lw	$2,32($sp)
	b	$L5123
	sw	$5,6172($16)

$L5187:
	.option	pic0
	jal	hl_decode_mb_complex
	.option	pic2
	sw	$2,32($sp)

	b	$L5193
	lw	$28,24($sp)

$L5186:
	lw	$4,44($16)
	bne	$4,$21,$L5125
	li	$6,1			# 0x1

	lw	$4,56($16)
	andi	$4,$4,0x2000
	bne	$4,$0,$L5125
	nop

	lw	$6,52($16)
	b	$L5125
	sltu	$6,$0,$6

$L5181:
	lw	$3,56($16)
	andi	$3,$3,0x2000
	bne	$3,$0,$L5145
	nop

	lw	$4,52($16)
	b	$L5146
	sltu	$4,$0,$4

$L5105:
	ori	$18,$18,0x2004
	lui	$2,%hi(cabac_context_init_I)
	lui	$5,%hi(cabac_context_init_I+920)
	lw	$7,2056($16)
	addiu	$2,$2,%lo(cabac_context_init_I)
	addu	$18,$16,$18
	addiu	$5,$5,%lo(cabac_context_init_I+920)
	b	$L5122
	li	$8,63			# 0x3f

$L5116:
	bne	$4,$0,$L5191
	slt	$6,$3,64

	li	$3,125			# 0x7d
$L5120:
	addiu	$2,$2,2
	sb	$3,0($18)
	beq	$2,$5,$L5115
	addiu	$18,$18,1

$L5122:
	lb	$3,0($2)
	lb	$4,1($2)
	mul	$3,$3,$7
	sra	$3,$3,4
	addu	$3,$3,$4
	bgtz	$3,$L5116
	slt	$4,$3,127

	b	$L5120
	li	$3,124			# 0x7c

$L5189:
	bne	$4,$0,$L5130
	nop

	lw	$3,44($16)
	bne	$3,$21,$L5130
	nop

	lw	$3,56($16)
	andi	$3,$3,0x2000
	bne	$3,$0,$L5130
	nop

	lw	$4,52($16)
	b	$L5131
	sltu	$4,$0,$4

$L5190:
	.option	pic0
	jal	hl_decode_mb_complex
	.option	pic2
	sw	$2,32($sp)

	b	$L5194
	lw	$5,6172($16)

$L5191:
	subu	$4,$8,$3
	beq	$6,$0,$L5192
	sll	$4,$4,1

	b	$L5120
	andi	$3,$4,0x00ff

$L5192:
	addiu	$3,$3,-64
	andi	$3,$3,0x00ff
	sll	$3,$3,1
	addiu	$3,$3,1
	b	$L5120
	andi	$3,$3,0x00ff

$L5180:
	addu	$2,$16,$2
	lw	$2,8172($2)
$L5137:
	lw	$4,0($16)
	lw	$25,%call16(av_log)($28)
	subu	$2,$2,$3
	lui	$6,%hi($LC83)
	sw	$5,16($sp)
	sw	$2,20($sp)
	addiu	$6,$6,%lo($LC83)
	jalr	$25
	move	$5,$0

	b	$L5157
	lw	$28,24($sp)

	.set	macro
	.set	reorder
	.end	decode_slice
	.size	decode_slice, .-decode_slice
	.section	.rodata.str1.4
	.align	2
$LC84:
	.ascii	"AVC: nal size %d\012\000"
	.align	2
$LC85:
	.ascii	"NAL %d at %d/%d length %d\012\000"
	.align	2
$LC86:
	.ascii	"AVC: Consumed only %d bytes instead of %d\012\000"
	.align	2
$LC87:
	.ascii	"Invalid mix of idr and non-idr slices\000"
	.align	2
$LC88:
	.ascii	"pps\000"
	.align	2
$LC89:
	.ascii	"sps_id out of range\012\000"
	.align	2
$LC90:
	.ascii	"FMO not supported\012\000"
	.align	2
$LC91:
	.ascii	"reference overflow (pps)\012\000"
	.align	2
$LC92:
	.ascii	"CAVLC\000"
	.align	2
$LC93:
	.ascii	"CABAC\000"
	.align	2
$LC94:
	.ascii	"weighted\000"
	.align	2
$LC95:
	.ascii	"LPAR\000"
	.align	2
$LC96:
	.ascii	"CONSTR\000"
	.align	2
$LC97:
	.ascii	"REDU\000"
	.align	2
$LC98:
	.ascii	"8x8DCT\000"
	.align	2
$LC99:
	.ascii	"pps:%u sps:%u %s slice_groups:%d ref:%d/%d %s qp:%d/%d/%"
	.ascii	"d/%d %s %s %s %s\012\000"
	.align	2
$LC100:
	.ascii	"Unknown NAL code: %d (%d bits)\012\000"
	.align	2
$LC101:
	.ascii	"decode_slice_header error\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_nal_units
	.type	decode_nal_units, @function
decode_nal_units:
	.frame	$sp,160,$31		# vars= 40, regs= 10/0, args= 72, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-160
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,156($sp)
	sw	$fp,152($sp)
	sw	$23,148($sp)
	sw	$22,144($sp)
	sw	$21,140($sp)
	sw	$20,136($sp)
	sw	$19,132($sp)
	sw	$18,128($sp)
	sw	$17,124($sp)
	sw	$16,120($sp)
	.cprestore	72
	lw	$2,0($4)
	lw	$3,60($4)
	move	$16,$4
	sw	$2,80($sp)
	lw	$4,620($2)
	li	$2,131072			# 0x20000
	addu	$2,$16,$2
	andi	$3,$3,0x8000
	sw	$4,9412($2)
	sw	$5,164($sp)
	bne	$3,$0,$L5199
	move	$22,$6

	sw	$0,9408($2)
	sw	$0,1880($16)
$L5199:
	li	$2,131072			# 0x20000
	ori	$2,$2,0x24a0
	addu	$2,$16,$2
	lui	$23,%hi(chroma_qp)
	addiu	$3,$16,10780
	addiu	$4,$16,8448
	lw	$6,8728($16)
	sw	$2,84($sp)
	addiu	$23,$23,%lo(chroma_qp)
	sw	$3,88($sp)
	sw	$4,100($sp)
	move	$19,$0
	move	$18,$0
$L5416:
	bne	$6,$0,$L5201
	slt	$2,$18,$22

	addiu	$3,$18,3
	slt	$4,$3,$22
	beq	$4,$0,$L5203
	lw	$25,164($sp)

	li	$6,1			# 0x1
	addu	$2,$25,$18
$L5211:
	lbu	$5,0($2)
	bne	$5,$0,$L5209
	nop

	lbu	$5,1($2)
	bne	$5,$0,$L5209
	nop

	lbu	$5,2($2)
	beq	$5,$6,$L5210
	nop

$L5209:
	addiu	$18,$18,1
	addiu	$3,$18,3
	slt	$4,$3,$22
	bne	$4,$0,$L5211
	addiu	$2,$2,1

$L5203:
	bne	$19,$0,$L5480
	li	$2,1			# 0x1

$L5263:
	lw	$31,156($sp)
$L5475:
	move	$2,$18
	lw	$fp,152($sp)
	lw	$23,148($sp)
	lw	$22,144($sp)
	lw	$21,140($sp)
	lw	$20,136($sp)
	lw	$19,132($sp)
	lw	$18,128($sp)
	lw	$17,124($sp)
	lw	$16,120($sp)
	j	$31
	addiu	$sp,$sp,160

$L5201:
	beq	$2,$0,$L5203
	nop

	lw	$3,8736($16)
	blez	$3,$L5434
	lw	$5,164($sp)

	move	$7,$0
	addu	$4,$5,$18
	move	$2,$0
$L5206:
	lbu	$5,0($4)
	sll	$7,$7,8
	addiu	$2,$2,1
	or	$7,$7,$5
	bne	$2,$3,$L5206
	addiu	$4,$4,1

	slt	$3,$7,2
	bne	$3,$0,$L5207
	addu	$18,$18,$2

	addu	$2,$7,$18
	slt	$2,$22,$2
	beq	$2,$0,$L5435
	li	$2,35112			# 0x8928

$L5205:
	lw	$25,%call16(av_log)($28)
$L5501:
	lw	$4,0($16)
	lui	$6,%hi($LC84)
	addiu	$6,$6,%lo($LC84)
	jalr	$25
	move	$5,$0

	beq	$19,$0,$L5475
	lw	$31,156($sp)

	li	$2,1			# 0x1
$L5480:
	beq	$19,$2,$L5392
	lw	$4,0($16)

	slt	$2,$19,2
	bne	$2,$0,$L5436
	li	$20,131072			# 0x20000

	ori	$20,$20,0x24a4
	addu	$20,$16,$20
	move	$2,$20
	li	$17,1			# 0x1
$L5395:
	lw	$3,0($2)
	lw	$5,256($4)
	addiu	$17,$17,1
	sw	$5,7992($3)
	sw	$0,7952($3)
	bne	$17,$19,$L5395
	addiu	$2,$2,4

	sw	$17,16($sp)
	lw	$25,624($4)
	lui	$5,%hi(decode_slice)
	lw	$6,84($sp)
	addiu	$5,$5,%lo(decode_slice)
	jalr	$25
	move	$7,$0

	li	$2,35111			# 0x8927
	addu	$2,$17,$2
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,0($2)
	li	$3,131072			# 0x20000
	lw	$4,6172($2)
	lw	$5,6168($2)
	ori	$3,$3,0x24a0
	addu	$3,$16,$3
	sll	$17,$17,2
	lw	$2,7952($16)
	sw	$5,6168($16)
	sw	$4,6172($16)
	addu	$17,$3,$17
$L5396:
	lw	$3,0($20)
	addiu	$20,$20,4
	lw	$3,7952($3)
	addu	$2,$2,$3
	bne	$20,$17,$L5396
	sw	$2,7952($16)

	b	$L5475
	lw	$31,156($sp)

$L5210:
	beq	$4,$0,$L5203
	li	$2,35112			# 0x8928

	addu	$2,$19,$2
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$4,164($sp)
	lw	$17,0($2)
	move	$18,$3
	addu	$21,$4,$3
	subu	$7,$22,$3
	move	$20,$0
$L5397:
	lbu	$2,0($21)
	addiu	$5,$7,-1
	srl	$2,$2,5
	sw	$2,8704($17)
	lbu	$7,0($21)
	slt	$2,$5,2
	andi	$7,$7,0x1f
	sw	$7,8708($17)
	bne	$2,$0,$L5437
	addiu	$21,$21,1

	move	$3,$0
	addu	$2,$21,$3
	lbu	$4,0($2)
	bne	$4,$0,$L5215
	nop

$L5441:
	beq	$3,$0,$L5438
	nop

	lbu	$2,-1($2)
	bne	$2,$0,$L5217
	addiu	$2,$3,2

	addiu	$3,$3,-1
	addiu	$2,$3,2
$L5217:
	slt	$4,$2,$5
	beq	$4,$0,$L5219
	addu	$4,$21,$3

	lbu	$6,1($4)
	bne	$6,$0,$L5219
	nop

	lbu	$4,2($4)
	sltu	$6,$4,4
	bne	$6,$0,$L5439
	nop

$L5219:
	addiu	$3,$2,1
	slt	$3,$3,$5
	beq	$3,$0,$L5214
	move	$3,$5

	move	$3,$2
$L5481:
	addu	$2,$21,$3
	lbu	$4,0($2)
	beq	$4,$0,$L5441
	nop

$L5215:
	addiu	$2,$3,2
	addiu	$3,$2,1
	slt	$3,$3,$5
	bne	$3,$0,$L5481
	move	$3,$2

	move	$3,$5
$L5214:
	addiu	$4,$3,-1
	slt	$2,$2,$4
	bne	$2,$0,$L5223
	xori	$5,$7,0x4

	beq	$21,$0,$L5224
	nop

	bltz	$3,$L5224
	addiu	$2,$3,1

	move	$fp,$21
$L5225:
	addu	$4,$fp,$3
	lbu	$5,-1($4)
	bne	$5,$0,$L5233
	nop

	bne	$3,$0,$L5235
	nop

	b	$L5476
	lw	$4,0($16)

$L5442:
	beq	$3,$0,$L5234
	addiu	$4,$4,-1

$L5235:
	lbu	$5,-2($4)
	beq	$5,$0,$L5442
	addiu	$3,$3,-1

$L5233:
	beq	$3,$0,$L5234
	andi	$4,$5,0x1

	bne	$4,$0,$L5237
	li	$4,1			# 0x1

	sra	$4,$5,1
	andi	$4,$4,0x1
	bne	$4,$0,$L5237
	li	$4,2			# 0x2

	sra	$4,$5,2
	andi	$4,$4,0x1
	bne	$4,$0,$L5237
	li	$4,3			# 0x3

	sra	$4,$5,3
	andi	$4,$4,0x1
	bne	$4,$0,$L5237
	li	$4,4			# 0x4

	sra	$4,$5,4
	andi	$4,$4,0x1
	bne	$4,$0,$L5237
	li	$4,5			# 0x5

	sra	$4,$5,5
	andi	$4,$4,0x1
	bne	$4,$0,$L5448
	sra	$5,$5,6

	andi	$4,$5,0x1
	bne	$4,$0,$L5449
	andi	$5,$5,0x2

	li	$4,8			# 0x8
	movz	$4,$0,$5
$L5237:
	sll	$21,$3,3
	subu	$21,$21,$4
	lw	$4,0($16)
	lw	$5,412($4)
	andi	$5,$5,0x100
	bne	$5,$0,$L5450
	nop

$L5246:
	lw	$3,8728($16)
	beq	$3,$0,$L5247
	nop

	beq	$20,$2,$L5247
	lw	$25,%call16(av_log)($28)

	lw	$4,0($16)
	lui	$6,%hi($LC86)
	move	$7,$2
	sw	$2,104($sp)
	sw	$20,16($sp)
	addiu	$6,$6,%lo($LC86)
	jalr	$25
	move	$5,$0

	lw	$28,72($sp)
	lw	$2,104($sp)
$L5247:
	lw	$3,6164($16)
	addu	$18,$18,$2
	li	$2,1			# 0x1
	beq	$3,$2,$L5248
	lw	$3,80($sp)

	lw	$2,716($3)
	slt	$2,$2,8
	bne	$2,$0,$L5482
	addiu	$2,$21,7

$L5248:
	lw	$2,8704($16)
	bne	$2,$0,$L5249
	addiu	$2,$21,7

	b	$L5416
	lw	$6,8728($16)

$L5438:
	b	$L5217
	li	$2,2			# 0x2

$L5249:
$L5482:
	sra	$20,$2,3
	lw	$2,8708($17)
	addu	$3,$fp,$20
	sw	$22,96($sp)
	move	$22,$3
	sltu	$3,$2,20
	bne	$3,$0,$L5451
	sw	$18,92($sp)

$L5251:
	lw	$25,%call16(av_log)($28)
	lw	$7,8708($16)
	lui	$2,%hi($LC100)
	lw	$4,80($sp)
	sw	$21,16($sp)
	li	$5,2			# 0x2
	jalr	$25
	addiu	$6,$2,%lo($LC100)

	lw	$28,72($sp)
	move	$3,$0
$L5282:
	li	$2,131072			# 0x20000
$L5498:
	addu	$4,$16,$2
$L5499:
	lw	$18,9412($4)
	beq	$18,$19,$L5452
	li	$5,1			# 0x1

$L5383:
	bltz	$3,$L5483
	lw	$25,%call16(av_log)($28)

$L5389:
	li	$2,1			# 0x1
	bne	$3,$2,$L5454
	nop

	lw	$3,8704($17)
	lw	$2,8708($17)
	sw	$3,8704($16)
	sltu	$3,$2,20
	sw	$2,8708($16)
	beq	$3,$0,$L5251
	move	$17,$16

$L5451:
	lui	$4,%hi($L5261)
	sll	$2,$2,2
	addiu	$4,$4,%lo($L5261)
	addu	$2,$4,$2
	lw	$2,0($2)
	j	$2
	nop

	.rdata
	.align	2
	.align	2
$L5261:
	.word	$L5251
	.word	$L5252
	.word	$L5253
	.word	$L5254
	.word	$L5255
	.word	$L5256
	.word	$L5257
	.word	$L5258
	.word	$L5259
	.word	$L5260
	.word	$L5260
	.word	$L5260
	.word	$L5260
	.word	$L5260
	.word	$L5251
	.word	$L5251
	.word	$L5251
	.word	$L5251
	.word	$L5251
	.word	$L5260
	.text
$L5452:
	beq	$19,$5,$L5384
	lw	$4,0($16)

	slt	$5,$19,2
	bne	$5,$0,$L5455
	ori	$2,$2,0x24a4

	addu	$19,$16,$2
	move	$5,$19
	li	$2,1			# 0x1
$L5387:
	lw	$6,0($5)
	lw	$7,256($4)
	addiu	$2,$2,1
	sw	$7,7992($6)
	sw	$0,7952($6)
	bne	$18,$2,$L5387
	addiu	$5,$5,4

	sw	$18,16($sp)
	lw	$25,624($4)
	lw	$6,84($sp)
	lui	$5,%hi(decode_slice)
	addiu	$5,$5,%lo(decode_slice)
	sw	$3,112($sp)
	jalr	$25
	move	$7,$0

	li	$2,35111			# 0x8927
	addu	$2,$18,$2
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,0($2)
	li	$4,131072			# 0x20000
	lw	$5,6172($2)
	lw	$6,6168($2)
	ori	$4,$4,0x24a0
	addu	$4,$16,$4
	sll	$18,$18,2
	lw	$28,72($sp)
	lw	$2,7952($16)
	lw	$3,112($sp)
	sw	$6,6168($16)
	sw	$5,6172($16)
	addu	$18,$4,$18
$L5388:
	lw	$4,0($19)
	addiu	$19,$19,4
	lw	$4,7952($4)
	addu	$2,$2,$4
	bne	$19,$18,$L5388
	sw	$2,7952($16)

	bgez	$3,$L5389
	move	$19,$0

	lw	$25,%call16(av_log)($28)
$L5483:
	lw	$4,0($16)
	lui	$6,%hi($LC101)
	addiu	$6,$6,%lo($LC101)
	move	$5,$0
	lw	$18,92($sp)
	jalr	$25
	lw	$22,96($sp)

	lw	$28,72($sp)
	b	$L5416
	lw	$6,8728($16)

$L5467:
	lw	$4,8704($17)
	beq	$4,$0,$L5260
	slt	$4,$2,16

	bne	$4,$0,$L5290
	li	$4,3			# 0x3

	lw	$3,-6284($3)
	beq	$3,$4,$L5260
	slt	$4,$2,32

	bne	$4,$0,$L5290
	li	$4,1			# 0x1

	bne	$3,$4,$L5282
	move	$3,$0

	slt	$2,$2,48
	bne	$2,$0,$L5290
	nop

$L5260:
	b	$L5282
	move	$3,$0

$L5273:
	sw	$10,80($8)
$L5274:
	lw	$2,6828($7)
$L5477:
	addiu	$6,$6,1
	slt	$2,$6,$2
	sw	$0,0($5)
	bne	$2,$0,$L5279
	addiu	$5,$5,4

$L5272:
	li	$2,131072			# 0x20000
$L5478:
	addu	$2,$16,$2
	sw	$0,6828($2)
$L5252:
	bltz	$20,$L5484
	move	$4,$0

	bltz	$21,$L5280
	nop

	move	$4,$22
	move	$5,$21
	move	$6,$fp
$L5281:
	li	$2,131072			# 0x20000
	addiu	$3,$17,8448
	addu	$2,$17,$2
	sw	$3,6864($2)
	sw	$5,8460($17)
	sw	$4,8452($17)
	sw	$3,6868($2)
	sw	$6,8448($17)
	sw	$0,8456($17)
	sw	$0,8224($17)
	move	$4,$17
	.option	pic0
	jal	decode_slice_header
	.option	pic2
	move	$5,$16

	lw	$28,72($sp)
	bne	$2,$0,$L5282
	move	$3,$2

	lw	$2,1880($16)
	lw	$4,8708($17)
	lw	$5,48($2)
	xori	$4,$4,0x5
	sltu	$4,$4,1
	or	$4,$5,$4
	sw	$4,48($2)
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$4,5352($2)
	bne	$4,$0,$L5282
	nop

	lw	$4,6164($17)
	slt	$4,$4,5
	beq	$4,$0,$L5282
	lw	$5,80($sp)

	lw	$4,716($5)
	slt	$5,$4,8
	beq	$5,$0,$L5456
	nop

$L5283:
	b	$L5282
	addiu	$19,$19,1

$L5259:
	bltz	$20,$L5485
	li	$4,3			# 0x3

	bltz	$21,$L5486
	li	$6,2			# 0x2

	addiu	$3,$fp,1
	addiu	$6,$fp,2
	addiu	$4,$fp,3
	move	$5,$22
	move	$7,$21
	move	$2,$fp
$L5304:
	sw	$7,8460($16)
	sw	$5,8452($16)
	sw	$2,8448($16)
	sw	$0,8456($16)
	lbu	$5,0($2)
	lbu	$3,0($3)
	sll	$5,$5,24
	sll	$3,$3,16
	lbu	$4,0($4)
	lbu	$2,0($6)
	or	$3,$5,$3
	or	$3,$3,$4
	sll	$2,$2,8
	or	$2,$3,$2
	li	$3,134217728			# 0x8000000
	sltu	$3,$2,$3
	beq	$3,$0,$L5457
	li	$3,-65536			# 0xffffffffffff0000

	and	$3,$2,$3
	bne	$3,$0,$L5307
	srl	$3,$2,16

	move	$3,$2
	li	$4,8			# 0x8
	move	$6,$0
$L5308:
	andi	$5,$3,0xff00
	bne	$5,$0,$L5309
	nop

	move	$4,$6
$L5310:
	lw	$5,%got(ff_log2_tab)($28)
	addu	$3,$5,$3
	lbu	$3,0($3)
	addu	$3,$3,$4
	sll	$3,$3,1
	addiu	$3,$3,-31
	li	$4,32			# 0x20
	subu	$4,$4,$3
	srl	$3,$2,$3
	addiu	$3,$3,-1
	sltu	$2,$3,256
	beq	$2,$0,$L5458
	sw	$4,8456($16)

	lw	$5,88($sp)
$L5500:
	sll	$8,$3,2
	addu	$8,$5,$8
	lw	$18,0($8)
	beq	$18,$0,$L5459
	lw	$25,%call16(av_mallocz)($28)

$L5312:
	beq	$18,$0,$L5260
	nop

	lw	$5,8456($16)
	lw	$2,8448($16)
	sra	$4,$5,3
	addu	$4,$2,$4
	lbu	$7,0($4)
	lbu	$8,3($4)
	lbu	$6,1($4)
	sll	$7,$7,24
	lbu	$4,2($4)
	or	$7,$8,$7
	sll	$6,$6,16
	sll	$4,$4,8
	or	$6,$7,$6
	or	$6,$6,$4
	andi	$4,$5,0x7
	sll	$4,$6,$4
	li	$6,134217728			# 0x8000000
	sltu	$6,$4,$6
	beq	$6,$0,$L5460
	li	$6,-65536			# 0xffffffffffff0000

	and	$6,$4,$6
	beq	$6,$0,$L5461
	move	$6,$4

	srl	$6,$4,16
	li	$8,24			# 0x18
	li	$7,16			# 0x10
$L5316:
	andi	$9,$6,0xff00
	beq	$9,$0,$L5317
	nop

	srl	$6,$6,8
	move	$7,$8
$L5317:
	lw	$8,%got(ff_log2_tab)($28)
	addiu	$5,$5,32
	addu	$6,$8,$6
	lbu	$6,0($6)
	addu	$6,$6,$7
	sll	$6,$6,1
	addiu	$6,$6,-31
	subu	$5,$5,$6
	srl	$4,$4,$6
	sw	$5,8456($16)
	addiu	$4,$4,-1
$L5314:
	sltu	$5,$4,32
	beq	$5,$0,$L5318
	addiu	$5,$4,2446

	sll	$5,$5,2
	addu	$5,$16,$5
	lw	$5,4($5)
	beq	$5,$0,$L5487
	lw	$25,%call16(av_log)($28)

	sw	$4,0($18)
	lw	$4,8456($16)
	sra	$5,$4,3
	addu	$5,$2,$5
	lbu	$6,0($5)
	andi	$5,$4,0x7
	sll	$5,$6,$5
	andi	$5,$5,0x00ff
	addiu	$4,$4,1
	srl	$5,$5,7
	sw	$4,8456($16)
	sw	$5,4($18)
	lw	$4,8456($16)
	sra	$5,$4,3
	addu	$5,$2,$5
	lbu	$6,0($5)
	andi	$5,$4,0x7
	sll	$5,$6,$5
	andi	$5,$5,0x00ff
	addiu	$4,$4,1
	srl	$5,$5,7
	sw	$4,8456($16)
	sw	$5,8($18)
	lw	$6,8456($16)
	sra	$4,$6,3
	addu	$4,$2,$4
	lbu	$7,0($4)
	lbu	$8,3($4)
	lbu	$5,1($4)
	sll	$7,$7,24
	lbu	$4,2($4)
	or	$7,$8,$7
	sll	$5,$5,16
	sll	$4,$4,8
	or	$5,$7,$5
	or	$5,$5,$4
	andi	$4,$6,0x7
	sll	$4,$5,$4
	li	$5,134217728			# 0x8000000
	sltu	$5,$4,$5
	beq	$5,$0,$L5462
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$4,$5
	bne	$5,$0,$L5322
	srl	$5,$4,16

	move	$5,$4
	li	$8,8			# 0x8
	move	$7,$0
$L5323:
	andi	$9,$5,0xff00
	beq	$9,$0,$L5324
	nop

	srl	$5,$5,8
	move	$7,$8
$L5324:
	lw	$8,%got(ff_log2_tab)($28)
	addiu	$6,$6,32
	addu	$5,$8,$5
	lbu	$5,0($5)
	addu	$5,$5,$7
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$6,$6,$5
	srl	$4,$4,$5
	sw	$6,8456($16)
	addiu	$4,$4,-1
$L5321:
	addiu	$4,$4,1
	slt	$5,$4,2
	bne	$5,$0,$L5325
	sw	$4,12($18)

	lw	$5,8456($16)
	sra	$4,$5,3
	addu	$2,$2,$4
	lbu	$6,0($2)
	lbu	$7,3($2)
	lbu	$4,1($2)
	sll	$6,$6,24
	lbu	$2,2($2)
	or	$6,$7,$6
	sll	$4,$4,16
	sll	$2,$2,8
	or	$4,$6,$4
	or	$4,$4,$2
	andi	$2,$5,0x7
	sll	$2,$4,$2
	li	$4,134217728			# 0x8000000
	sltu	$4,$2,$4
	beq	$4,$0,$L5463
	li	$4,-65536			# 0xffffffffffff0000

	and	$4,$2,$4
	bne	$4,$0,$L5328
	srl	$4,$2,16

	move	$4,$2
	li	$7,8			# 0x8
	move	$6,$0
$L5329:
	andi	$8,$4,0xff00
	beq	$8,$0,$L5330
	nop

	srl	$4,$4,8
	move	$6,$7
$L5330:
	lw	$7,%got(ff_log2_tab)($28)
	addiu	$5,$5,32
	addu	$4,$7,$4
	lbu	$4,0($4)
	addu	$4,$4,$6
	sll	$4,$4,1
	addiu	$4,$4,-31
	subu	$5,$5,$4
	srl	$2,$2,$4
	sw	$5,8456($16)
	addiu	$2,$2,-1
$L5327:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC90)
	sw	$2,16($18)
	sw	$3,112($sp)
	addiu	$6,$6,%lo($LC90)
	jalr	$25
	move	$5,$0

	lw	$28,72($sp)
	lw	$2,8448($16)
	lw	$3,112($sp)
$L5325:
	lw	$6,8456($16)
	sra	$4,$6,3
	addu	$4,$2,$4
	lbu	$7,0($4)
	lbu	$8,3($4)
	lbu	$5,1($4)
	sll	$7,$7,24
	lbu	$4,2($4)
	or	$7,$8,$7
	sll	$5,$5,16
	sll	$4,$4,8
	or	$5,$7,$5
	or	$5,$5,$4
	andi	$4,$6,0x7
	sll	$4,$5,$4
	li	$5,134217728			# 0x8000000
	sltu	$5,$4,$5
	beq	$5,$0,$L5464
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$4,$5
	bne	$5,$0,$L5333
	srl	$5,$4,16

	move	$5,$4
	li	$8,8			# 0x8
	move	$7,$0
$L5334:
	andi	$9,$5,0xff00
	beq	$9,$0,$L5335
	nop

	srl	$5,$5,8
	move	$7,$8
$L5335:
	lw	$8,%got(ff_log2_tab)($28)
	addiu	$6,$6,32
	addu	$5,$8,$5
	lbu	$5,0($5)
	addu	$5,$5,$7
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$6,$6,$5
	srl	$4,$4,$5
	sw	$6,8456($16)
	addiu	$4,$4,-1
$L5332:
	addiu	$4,$4,1
	sw	$4,20($18)
	lw	$6,8456($16)
	sra	$4,$6,3
	addu	$4,$2,$4
	lbu	$7,0($4)
	lbu	$8,3($4)
	lbu	$5,1($4)
	sll	$7,$7,24
	lbu	$4,2($4)
	or	$7,$8,$7
	sll	$5,$5,16
	sll	$4,$4,8
	or	$5,$7,$5
	or	$5,$5,$4
	andi	$4,$6,0x7
	sll	$4,$5,$4
	li	$5,134217728			# 0x8000000
	sltu	$5,$4,$5
	beq	$5,$0,$L5465
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$4,$5
	bne	$5,$0,$L5338
	srl	$5,$4,16

	move	$5,$4
	li	$8,8			# 0x8
	move	$7,$0
$L5339:
	andi	$9,$5,0xff00
	beq	$9,$0,$L5340
	nop

	srl	$5,$5,8
	move	$7,$8
$L5340:
	lw	$8,%got(ff_log2_tab)($28)
	addiu	$6,$6,32
	addu	$5,$8,$5
	lbu	$5,0($5)
	addu	$5,$5,$7
	sll	$5,$5,1
	addiu	$5,$5,-31
	subu	$6,$6,$5
	srl	$4,$4,$5
	sw	$6,8456($16)
	addiu	$4,$4,-1
$L5337:
	lw	$5,20($18)
	addiu	$6,$4,1
	addiu	$5,$5,-1
	sltu	$5,$5,32
	beq	$5,$0,$L5341
	sw	$6,24($18)

	sltu	$4,$4,32
	bne	$4,$0,$L5342
	nop

$L5341:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC91)
	addiu	$6,$6,%lo($LC91)
	jalr	$25
	move	$5,$0

	li	$2,1			# 0x1
	lw	$28,72($sp)
	sw	$2,20($18)
	sw	$2,24($18)
	b	$L5282
	move	$3,$0

$L5254:
	bltz	$20,$L5488
	move	$3,$0

	bltz	$21,$L5489
	move	$4,$0

	move	$3,$22
	move	$4,$21
	move	$5,$fp
$L5287:
	li	$2,131072			# 0x20000
	ori	$6,$2,0x1ab0
	addu	$6,$17,$6
	addu	$2,$17,$2
	sw	$3,6836($2)
	sw	$6,6864($2)
	sw	$5,6832($2)
	sw	$4,6844($2)
	sw	$0,6840($2)
	b	$L5282
	move	$3,$0

$L5253:
	bltz	$20,$L5490
	move	$3,$0

	bltz	$21,$L5491
	move	$4,$0

	move	$3,$22
	move	$4,$21
	move	$5,$fp
$L5285:
	li	$2,131072			# 0x20000
	addu	$2,$17,$2
	sw	$3,8452($17)
	li	$3,1			# 0x1
	sw	$5,8448($17)
	sw	$4,8460($17)
	sw	$3,8224($17)
	sw	$0,6864($2)
	sw	$0,8456($17)
	sw	$0,6868($2)
	move	$4,$17
	.option	pic0
	jal	decode_slice_header
	.option	pic2
	move	$5,$16

	lw	$28,72($sp)
	b	$L5282
	move	$3,$2

$L5258:
	bltz	$20,$L5492
	move	$2,$0

	bltz	$21,$L5493
	move	$3,$0

	move	$2,$22
	move	$3,$21
	move	$4,$fp
$L5301:
	sw	$4,8448($16)
	sw	$3,8460($16)
	sw	$2,8452($16)
	sw	$0,8456($16)
	.option	pic0
	jal	decode_seq_parameter_set
	.option	pic2
	move	$4,$16

	lw	$3,56($16)
	li	$2,524288			# 0x80000
	and	$2,$3,$2
	beq	$2,$0,$L5302
	lw	$28,72($sp)

	li	$2,1			# 0x1
	sw	$2,8240($16)
$L5302:
	lw	$3,80($sp)
	lw	$2,268($3)
	slt	$2,$2,2
	beq	$2,$0,$L5260
	move	$4,$3

	lw	$2,8240($16)
	sltu	$2,$2,1
	move	$3,$0
	b	$L5282
	sw	$2,268($4)

$L5256:
	lw	$3,8708($16)
	li	$2,5			# 0x5
	bne	$3,$2,$L5466
	li	$5,65536			# 0x10000

	li	$6,131072			# 0x20000
	ori	$7,$5,0x17fc
	ori	$8,$6,0x1744
	ori	$5,$5,0x17bc
	addu	$5,$16,$5
	addu	$7,$16,$7
	addu	$8,$16,$8
	addu	$6,$16,$6
	li	$9,4			# 0x4
$L5271:
	lw	$4,0($5)
	beq	$4,$0,$L5264
	nop

	lw	$2,6024($6)
	beq	$4,$2,$L5267
	sw	$0,80($4)

	lw	$2,5952($6)
	beq	$2,$0,$L5266
	nop

	beq	$4,$2,$L5267
	nop

	b	$L5269
	move	$2,$8

$L5270:
	beq	$4,$3,$L5267
	addiu	$2,$2,4

$L5269:
	lw	$3,0($2)
	bne	$3,$0,$L5270
	nop

$L5266:
	sw	$0,0($5)
$L5264:
	addiu	$5,$5,4
	bne	$5,$7,$L5271
	nop

	li	$9,131072			# 0x20000
	addu	$7,$16,$9
	lw	$2,6828($7)
	blez	$2,$L5272
	sw	$0,6824($7)

	li	$5,65536			# 0x10000
	ori	$9,$9,0x1744
	ori	$5,$5,0x173c
	lw	$8,6024($7)
	addu	$5,$16,$5
	addu	$9,$16,$9
	move	$6,$0
	li	$10,4			# 0x4
$L5279:
	lw	$4,0($5)
	beq	$4,$8,$L5273
	sw	$0,80($4)

	lw	$2,5952($7)
	beq	$2,$0,$L5274
	nop

	beq	$4,$2,$L5275
	move	$2,$9

	b	$L5503
	lw	$3,0($2)

$L5278:
	beq	$4,$3,$L5275
	addiu	$2,$2,4

	lw	$3,0($2)
$L5503:
	bne	$3,$0,$L5278
	nop

	b	$L5477
	lw	$2,6828($7)

$L5255:
	bltz	$20,$L5494
	move	$6,$0

	bltz	$21,$L5495
	move	$7,$0

	move	$6,$22
	move	$7,$21
	move	$8,$fp
$L5289:
	li	$3,65536			# 0x10000
	li	$2,131072			# 0x20000
	addu	$3,$17,$3
	ori	$5,$2,0x1ac0
	lw	$4,5352($3)
	addu	$2,$17,$2
	addu	$5,$17,$5
	sw	$8,6848($2)
	sw	$7,6860($2)
	sw	$6,6852($2)
	sw	$5,6868($2)
	bne	$4,$0,$L5260
	sw	$0,6856($2)

	lw	$2,6864($2)
	beq	$2,$0,$L5260
	nop

	lw	$2,8224($17)
	beq	$2,$0,$L5260
	nop

	lw	$2,112($16)
	beq	$2,$0,$L5260
	nop

	lw	$2,6164($16)
	slt	$2,$2,5
	beq	$2,$0,$L5260
	lw	$25,80($sp)

	lw	$2,716($25)
	slt	$4,$2,8
	beq	$4,$0,$L5467
	nop

$L5290:
	addiu	$19,$19,1
	b	$L5282
	move	$3,$0

$L5257:
	bltz	$20,$L5496
	move	$2,$0

	bltz	$21,$L5497
	move	$4,$0

	move	$2,$22
	move	$4,$21
	move	$3,$fp
$L5292:
	sw	$3,8448($16)
	sw	$2,8452($16)
	sw	$4,8460($16)
	sw	$0,8456($16)
	move	$2,$0
	li	$18,255			# 0xff
	li	$3,5			# 0x5
$L5421:
	addiu	$5,$2,16
	slt	$4,$5,$4
	beq	$4,$0,$L5260
	nop

	lw	$7,8448($16)
	move	$6,$0
$L5294:
	sra	$4,$2,3
	addu	$4,$7,$4
	lbu	$10,0($4)
	lbu	$9,3($4)
	lbu	$8,1($4)
	lbu	$5,2($4)
	sll	$4,$10,24
	or	$4,$9,$4
	sll	$8,$8,16
	sll	$5,$5,8
	or	$4,$4,$8
	or	$4,$4,$5
	andi	$5,$2,0x7
	sll	$4,$4,$5
	srl	$4,$4,24
	addiu	$2,$2,8
	addu	$6,$4,$6
	beq	$4,$18,$L5294
	sw	$2,8456($16)

	move	$5,$0
$L5295:
	sra	$4,$2,3
	addu	$4,$7,$4
	lbu	$11,0($4)
	lbu	$10,3($4)
	lbu	$9,1($4)
	lbu	$8,2($4)
	sll	$4,$11,24
	or	$4,$10,$4
	sll	$9,$9,16
	sll	$8,$8,8
	or	$4,$4,$9
	or	$4,$4,$8
	andi	$8,$2,0x7
	sll	$4,$4,$8
	srl	$4,$4,24
	addiu	$2,$2,8
	addu	$5,$4,$5
	beq	$4,$18,$L5295
	sw	$2,8456($16)

	beq	$6,$3,$L5468
	move	$4,$16

	sll	$5,$5,3
	addu	$2,$2,$5
	sw	$2,8456($16)
$L5298:
	subu	$4,$0,$2
	andi	$4,$4,0x7
	bne	$4,$0,$L5299
	nop

	b	$L5421
	lw	$4,8460($16)

$L5456:
	lw	$5,8704($17)
	beq	$5,$0,$L5282
	slt	$5,$4,16

	bne	$5,$0,$L5283
	li	$5,3			# 0x3

	lw	$2,-6284($2)
	beq	$2,$5,$L5282
	slt	$5,$4,32

	bne	$5,$0,$L5283
	li	$5,1			# 0x1

	bne	$2,$5,$L5498
	li	$2,131072			# 0x20000

	slt	$4,$4,48
	beq	$4,$0,$L5499
	addu	$4,$16,$2

	b	$L5499
	addiu	$19,$19,1

$L5275:
	sw	$10,80($4)
	lw	$2,6828($7)
	addiu	$6,$6,1
	slt	$2,$6,$2
	sw	$0,0($5)
	bne	$2,$0,$L5279
	addiu	$5,$5,4

	b	$L5478
	li	$2,131072			# 0x20000

$L5299:
	addu	$2,$2,$4
	sw	$2,8456($16)
	b	$L5421
	lw	$4,8460($16)

$L5267:
	b	$L5266
	sw	$9,80($4)

$L5280:
$L5484:
	move	$5,$0
	b	$L5281
	move	$6,$0

$L5468:
	.option	pic0
	jal	decode_unregistered_user_data
	.option	pic2
	sw	$3,112($sp)

	lw	$28,72($sp)
	bltz	$2,$L5260
	lw	$3,112($sp)

	b	$L5298
	lw	$2,8456($16)

$L5485:
	li	$6,2			# 0x2
$L5486:
	li	$3,1			# 0x1
	move	$5,$0
	move	$7,$0
	b	$L5304
	move	$2,$0

$L5488:
	move	$4,$0
$L5489:
	b	$L5287
	move	$5,$0

$L5496:
	move	$4,$0
$L5497:
	b	$L5292
	move	$3,$0

$L5490:
	move	$4,$0
$L5491:
	b	$L5285
	move	$5,$0

$L5494:
	move	$7,$0
$L5495:
	b	$L5289
	move	$8,$0

$L5492:
	move	$3,$0
$L5493:
	b	$L5301
	move	$4,$0

$L5234:
	lw	$4,0($16)
$L5476:
	lw	$5,412($4)
	andi	$5,$5,0x100
	beq	$5,$0,$L5246
	move	$21,$0

$L5450:
	lw	$7,8708($17)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC85)
	sw	$2,104($sp)
	sw	$3,24($sp)
	sw	$18,16($sp)
	sw	$22,20($sp)
	addiu	$6,$6,%lo($LC85)
	jalr	$25
	li	$5,2			# 0x2

	lw	$28,72($sp)
	b	$L5246
	lw	$2,104($sp)

$L5457:
	lw	$3,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$3,$3,$2
	lw	$4,%got(ff_ue_golomb_vlc_code)($28)
	lbu	$3,0($3)
	addu	$2,$4,$2
	sw	$3,8456($16)
	lbu	$3,0($2)
	sltu	$2,$3,256
	bne	$2,$0,$L5500
	lw	$5,88($sp)

$L5458:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC62)
	lui	$7,%hi($LC88)
	sw	$3,16($sp)
	addiu	$6,$6,%lo($LC62)
	addiu	$7,$7,%lo($LC88)
	jalr	$25
	move	$5,$0

	lw	$28,72($sp)
	b	$L5282
	move	$3,$0

$L5318:
	lw	$25,%call16(av_log)($28)
$L5487:
	lw	$4,0($16)
	lui	$6,%hi($LC89)
	addiu	$6,$6,%lo($LC89)
	jalr	$25
	move	$5,$0

	lw	$28,72($sp)
	b	$L5282
	move	$3,$0

$L5309:
	b	$L5310
	srl	$3,$3,8

$L5307:
	li	$4,24			# 0x18
	b	$L5308
	li	$6,16			# 0x10

$L5454:
	lw	$18,92($sp)
	lw	$22,96($sp)
	b	$L5416
	lw	$6,8728($16)

$L5460:
	lw	$6,%got(ff_golomb_vlc_len)($28)
	srl	$4,$4,23
	addu	$6,$6,$4
	lbu	$6,0($6)
	addu	$5,$6,$5
	lw	$6,%got(ff_ue_golomb_vlc_code)($28)
	sw	$5,8456($16)
	addu	$4,$6,$4
	b	$L5314
	lbu	$4,0($4)

$L5461:
	li	$8,8			# 0x8
	b	$L5316
	move	$7,$0

$L5207:
	li	$2,1			# 0x1
	bne	$7,$2,$L5501
	lw	$25,%call16(av_log)($28)

	b	$L5416
	addiu	$18,$18,1

$L5462:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$4,$4,23
	addu	$5,$5,$4
	lbu	$5,0($5)
	addu	$6,$5,$6
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$6,8456($16)
	addu	$4,$5,$4
	b	$L5321
	lbu	$4,0($4)

$L5464:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$4,$4,23
	addu	$5,$5,$4
	lbu	$5,0($5)
	addu	$6,$5,$6
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$6,8456($16)
	addu	$4,$5,$4
	b	$L5332
	lbu	$4,0($4)

$L5455:
	sw	$19,16($sp)
	lw	$25,624($4)
	lui	$5,%hi(decode_slice)
	lw	$6,84($sp)
	sw	$3,112($sp)
	addiu	$5,$5,%lo(decode_slice)
	jalr	$25
	move	$7,$0

	li	$2,35111			# 0x8927
	addu	$2,$19,$2
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,0($2)
	lw	$28,72($sp)
	lw	$4,6172($2)
	lw	$2,6168($2)
	move	$19,$0
	sw	$4,6172($16)
	sw	$2,6168($16)
	b	$L5383
	lw	$3,112($sp)

$L5384:
	move	$5,$16
	sw	$3,112($sp)
	.option	pic0
	jal	decode_slice
	.option	pic2
	move	$19,$0

	lw	$28,72($sp)
	b	$L5383
	lw	$3,112($sp)

$L5465:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$4,$4,23
	addu	$5,$5,$4
	lbu	$5,0($5)
	addu	$6,$5,$6
	lw	$5,%got(ff_ue_golomb_vlc_code)($28)
	sw	$6,8456($16)
	addu	$4,$5,$4
	b	$L5337
	lbu	$4,0($4)

$L5333:
	li	$8,24			# 0x18
	b	$L5334
	li	$7,16			# 0x10

$L5338:
	li	$8,24			# 0x18
	b	$L5339
	li	$7,16			# 0x10

$L5322:
	li	$8,24			# 0x18
	b	$L5323
	li	$7,16			# 0x10

$L5459:
	sw	$3,112($sp)
	sw	$8,108($sp)
	jalr	$25
	li	$4,808			# 0x328

	lw	$8,108($sp)
	lw	$28,72($sp)
	move	$18,$2
	sw	$2,0($8)
	bne	$2,$0,$L5312
	lw	$3,112($sp)

	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC64)
	lui	$7,%hi($LC88)
	addiu	$6,$6,%lo($LC64)
	addiu	$7,$7,%lo($LC88)
	jalr	$25
	move	$5,$0

	lw	$8,108($sp)
	lw	$28,72($sp)
	lw	$18,0($8)
	b	$L5312
	lw	$3,112($sp)

$L5328:
	li	$7,24			# 0x18
	b	$L5329
	li	$6,16			# 0x10

$L5439:
	li	$2,3			# 0x3
	beq	$4,$2,$L5469
	nop

	b	$L5214
	move	$2,$3

$L5434:
	b	$L5205
	move	$7,$0

$L5463:
	lw	$4,%got(ff_golomb_vlc_len)($28)
	srl	$2,$2,23
	addu	$4,$4,$2
	lbu	$4,0($4)
	addu	$5,$4,$5
	lw	$4,%got(ff_ue_golomb_vlc_code)($28)
	sw	$5,8456($16)
	addu	$2,$4,$2
	b	$L5327
	lbu	$2,0($2)

$L5342:
	lw	$4,8456($16)
	sra	$5,$4,3
	addu	$5,$2,$5
	lbu	$6,0($5)
	andi	$5,$4,0x7
	sll	$5,$6,$5
	andi	$5,$5,0x00ff
	addiu	$4,$4,1
	srl	$5,$5,7
	sw	$4,8456($16)
	sw	$5,28($18)
	lw	$5,8456($16)
	sra	$4,$5,3
	addu	$4,$2,$4
	lbu	$7,0($4)
	lbu	$8,3($4)
	lbu	$6,1($4)
	sll	$7,$7,24
	lbu	$4,2($4)
	or	$7,$8,$7
	sll	$6,$6,16
	or	$6,$7,$6
	sll	$4,$4,8
	or	$6,$6,$4
	andi	$4,$5,0x7
	sll	$4,$6,$4
	srl	$4,$4,30
	addiu	$5,$5,2
	sw	$5,8456($16)
	sw	$4,32($18)
	lw	$6,8456($16)
	sra	$4,$6,3
	addu	$4,$2,$4
	lbu	$7,0($4)
	lbu	$8,3($4)
	lbu	$5,1($4)
	sll	$7,$7,24
	lbu	$4,2($4)
	or	$7,$8,$7
	sll	$5,$5,16
	sll	$4,$4,8
	or	$5,$7,$5
	or	$5,$5,$4
	andi	$4,$6,0x7
	sll	$4,$5,$4
	li	$5,134217728			# 0x8000000
	sltu	$5,$4,$5
	beq	$5,$0,$L5470
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$4,$5
	bne	$5,$0,$L5345
	srl	$5,$4,16

	move	$5,$4
	li	$8,8			# 0x8
	move	$7,$0
$L5346:
	andi	$9,$5,0xff00
	beq	$9,$0,$L5347
	nop

	srl	$5,$5,8
	move	$7,$8
$L5347:
	lw	$8,%got(ff_log2_tab)($28)
	addiu	$6,$6,32
	addu	$5,$8,$5
	lbu	$5,0($5)
	addu	$5,$5,$7
	sll	$5,$5,1
	addiu	$5,$5,-31
	srl	$4,$4,$5
	andi	$7,$4,0x1
	subu	$5,$6,$5
	beq	$7,$0,$L5348
	sw	$5,8456($16)

	srl	$4,$4,1
	subu	$4,$0,$4
$L5344:
	addiu	$4,$4,26
	sw	$4,36($18)
	lw	$6,8456($16)
	sra	$4,$6,3
	addu	$4,$2,$4
	lbu	$7,0($4)
	lbu	$8,3($4)
	lbu	$5,1($4)
	sll	$7,$7,24
	lbu	$4,2($4)
	or	$7,$8,$7
	sll	$5,$5,16
	sll	$4,$4,8
	or	$5,$7,$5
	or	$5,$5,$4
	andi	$4,$6,0x7
	sll	$4,$5,$4
	li	$5,134217728			# 0x8000000
	sltu	$5,$4,$5
	beq	$5,$0,$L5471
	li	$5,-65536			# 0xffffffffffff0000

	and	$5,$4,$5
	bne	$5,$0,$L5352
	srl	$5,$4,16

	move	$5,$4
	li	$8,8			# 0x8
	move	$7,$0
$L5353:
	andi	$9,$5,0xff00
	beq	$9,$0,$L5354
	nop

	srl	$5,$5,8
	move	$7,$8
$L5354:
	lw	$8,%got(ff_log2_tab)($28)
	addiu	$6,$6,32
	addu	$5,$8,$5
	lbu	$5,0($5)
	addu	$5,$5,$7
	sll	$5,$5,1
	addiu	$5,$5,-31
	srl	$4,$4,$5
	andi	$7,$4,0x1
	subu	$5,$6,$5
	beq	$7,$0,$L5355
	sw	$5,8456($16)

	srl	$4,$4,1
	subu	$4,$0,$4
$L5351:
	addiu	$4,$4,26
	sw	$4,40($18)
	lw	$6,8456($16)
	sra	$4,$6,3
	addu	$4,$2,$4
	lbu	$7,0($4)
	lbu	$8,3($4)
	lbu	$5,1($4)
	sll	$7,$7,24
	lbu	$4,2($4)
	or	$7,$8,$7
	sll	$5,$5,16
	sll	$4,$4,8
	or	$5,$7,$5
	or	$5,$5,$4
	andi	$4,$6,0x7
	sll	$4,$5,$4
	li	$5,134217728			# 0x8000000
	sltu	$5,$4,$5
	beq	$5,$0,$L5472
	lw	$5,%got(ff_golomb_vlc_len)($28)

	li	$5,-65536			# 0xffffffffffff0000
	and	$5,$4,$5
	bne	$5,$0,$L5359
	srl	$5,$4,16

	move	$5,$4
	li	$8,8			# 0x8
	move	$7,$0
$L5360:
	andi	$9,$5,0xff00
	beq	$9,$0,$L5361
	nop

	srl	$5,$5,8
	move	$7,$8
$L5361:
	lw	$8,%got(ff_log2_tab)($28)
	addiu	$6,$6,32
	addu	$5,$8,$5
	lbu	$5,0($5)
	addu	$5,$5,$7
	sll	$5,$5,1
	addiu	$5,$5,-31
	srl	$4,$4,$5
	andi	$7,$4,0x1
	subu	$5,$6,$5
	beq	$7,$0,$L5362
	sw	$5,8456($16)

	srl	$4,$4,1
	subu	$4,$0,$4
$L5358:
	sw	$4,44($18)
	lw	$4,8456($16)
	addiu	$8,$18,68
	sra	$5,$4,3
	addu	$5,$2,$5
	lbu	$6,0($5)
	andi	$5,$4,0x7
	sll	$5,$6,$5
	andi	$5,$5,0x00ff
	addiu	$4,$4,1
	srl	$5,$5,7
	sw	$4,8456($16)
	sw	$5,52($18)
	lw	$4,8456($16)
	li	$5,65536			# 0x10000
	sra	$6,$4,3
	addu	$6,$2,$6
	lbu	$7,0($6)
	andi	$6,$4,0x7
	sll	$6,$7,$6
	andi	$6,$6,0x00ff
	addiu	$4,$4,1
	srl	$6,$6,7
	sw	$4,8456($16)
	sw	$6,56($18)
	lw	$4,8456($16)
	lw	$25,%call16(memset)($28)
	sra	$6,$4,3
	addu	$2,$2,$6
	lbu	$6,0($2)
	andi	$2,$4,0x7
	sll	$2,$6,$2
	andi	$2,$2,0x00ff
	addiu	$4,$4,1
	srl	$2,$2,7
	sw	$4,8456($16)
	addu	$5,$16,$5
	sw	$2,60($18)
	li	$2,-1			# 0xffffffffffffffff
	move	$4,$8
	sw	$3,112($sp)
	sw	$8,108($sp)
	sw	$0,64($18)
	li	$6,96			# 0x60
	sw	$2,-6300($5)
	jalr	$25
	li	$5,16			# 0x10

	lw	$28,72($sp)
	addiu	$9,$18,164
	lw	$25,%call16(memset)($28)
	move	$4,$9
	sw	$9,104($sp)
	li	$5,16			# 0x10
	jalr	$25
	li	$6,128			# 0x80

	lw	$2,8456($16)
	lw	$28,72($sp)
	slt	$4,$2,$21
	lw	$3,112($sp)
	lw	$8,108($sp)
	bne	$4,$0,$L5473
	lw	$9,104($sp)

	lw	$6,44($18)
	sw	$6,48($18)
$L5365:
	move	$2,$0
	li	$8,51			# 0x33
	li	$7,255			# 0xff
$L5366:
	addu	$4,$2,$6
	slt	$5,$4,52
	movz	$4,$8,$5
	slt	$5,$4,0
	movn	$4,$0,$5
	addu	$4,$23,$4
	lbu	$5,0($4)
	andi	$4,$2,0xff
	addu	$4,$18,$4
	addiu	$2,$2,1
	bne	$2,$7,$L5366
	sb	$5,292($4)

	lw	$7,48($18)
	beq	$6,$7,$L5367
	li	$8,51			# 0x33

	move	$2,$0
	li	$6,255			# 0xff
$L5368:
	addu	$4,$2,$7
	slt	$5,$4,52
	movz	$4,$8,$5
	slt	$5,$4,0
	movn	$4,$0,$5
	addu	$4,$23,$4
	lbu	$5,0($4)
	andi	$4,$2,0xff
	addu	$4,$18,$4
	addiu	$2,$2,1
	bne	$2,$6,$L5368
	sb	$5,548($4)

	li	$2,1			# 0x1
	sw	$2,12608($16)
	lw	$4,0($16)
$L5479:
	lw	$2,412($4)
	andi	$2,$2,0x1
	beq	$2,$0,$L5260
	lui	$31,%hi($LC93)

	lw	$2,64($18)
	lw	$25,4($18)
	lw	$12,28($18)
	lw	$7,52($18)
	lw	$6,56($18)
	lw	$5,60($18)
	lw	$24,0($18)
	lw	$15,12($18)
	lw	$14,20($18)
	lw	$13,24($18)
	lw	$11,36($18)
	lw	$10,40($18)
	lw	$9,44($18)
	lw	$8,48($18)
	lui	$18,%hi($LC92)
	addiu	$31,$31,%lo($LC93)
	addiu	$18,$18,%lo($LC92)
	movn	$18,$31,$25
	lui	$25,%hi($LC60)
	lui	$31,%hi($LC94)
	addiu	$31,$31,%lo($LC94)
	addiu	$25,$25,%lo($LC60)
	movn	$25,$31,$12
	move	$12,$25
	lui	$31,%hi($LC95)
	lui	$25,%hi($LC60)
	addiu	$31,$31,%lo($LC95)
	addiu	$25,$25,%lo($LC60)
	movn	$25,$31,$7
	move	$7,$25
	lui	$31,%hi($LC96)
	lui	$25,%hi($LC60)
	addiu	$31,$31,%lo($LC96)
	addiu	$25,$25,%lo($LC60)
	movn	$25,$31,$6
	move	$6,$25
	lui	$31,%hi($LC97)
	lui	$25,%hi($LC60)
	addiu	$31,$31,%lo($LC97)
	addiu	$25,$25,%lo($LC60)
	movn	$25,$31,$5
	move	$5,$25
	lui	$31,%hi($LC98)
	lui	$25,%hi($LC60)
	addiu	$31,$31,%lo($LC98)
	addiu	$25,$25,%lo($LC60)
	movn	$25,$31,$2
	move	$2,$25
	sw	$6,60($sp)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC99)
	sw	$7,56($sp)
	sw	$5,64($sp)
	move	$7,$3
	sw	$24,16($sp)
	sw	$18,20($sp)
	sw	$15,24($sp)
	sw	$14,28($sp)
	sw	$13,32($sp)
	sw	$12,36($sp)
	sw	$11,40($sp)
	sw	$10,44($sp)
	sw	$9,48($sp)
	sw	$8,52($sp)
	sw	$2,68($sp)
	addiu	$6,$6,%lo($LC99)
	jalr	$25
	li	$5,2			# 0x2

	lw	$28,72($sp)
	b	$L5282
	move	$3,$0

$L5437:
	move	$3,$5
	b	$L5214
	move	$2,$0

$L5223:
	sltu	$5,$5,1
	addiu	$7,$5,2178
	sll	$7,$7,2
	addu	$7,$17,$7
	addiu	$5,$5,2180
	lw	$25,%call16(av_fast_realloc)($28)
	lw	$4,0($7)
	sll	$5,$5,2
	move	$6,$3
	sw	$3,112($sp)
	sw	$7,104($sp)
	jalr	$25
	addu	$5,$17,$5

	lw	$7,104($sp)
	lw	$28,72($sp)
	move	$fp,$2
	sw	$2,0($7)
	beq	$2,$0,$L5224
	lw	$3,112($sp)

	blez	$3,$L5474
	move	$4,$0

	move	$2,$0
	li	$7,3			# 0x3
	addiu	$5,$2,2
$L5502:
	slt	$5,$5,$3
	beq	$5,$0,$L5228
	addu	$5,$21,$2

	addu	$6,$21,$2
	lbu	$5,0($6)
	bne	$5,$0,$L5229
	nop

	lbu	$8,1($6)
	bne	$8,$0,$L5229
	nop

	lbu	$6,2($6)
	sltu	$8,$6,4
	beq	$8,$0,$L5229
	nop

	beq	$6,$7,$L5230
	addu	$6,$fp,$4

	addiu	$2,$2,1
$L5227:
	b	$L5225
	move	$3,$4

$L5228:
	lbu	$5,0($5)
$L5229:
	addu	$6,$fp,$4
	sb	$5,0($6)
	addiu	$4,$4,1
	addiu	$2,$2,1
$L5231:
	slt	$5,$2,$3
	bne	$5,$0,$L5502
	addiu	$5,$2,2

	b	$L5227
	addiu	$2,$2,1

$L5224:
	b	$L5263
	li	$18,-1			# 0xffffffffffffffff

$L5449:
	b	$L5237
	li	$4,7			# 0x7

$L5448:
	b	$L5237
	li	$4,6			# 0x6

$L5472:
	srl	$4,$4,23
	addu	$5,$5,$4
	lbu	$5,0($5)
	addu	$6,$5,$6
	lw	$5,%got(ff_se_golomb_vlc_code)($28)
	sw	$6,8456($16)
	addu	$4,$5,$4
	b	$L5358
	lb	$4,0($4)

$L5355:
	b	$L5351
	srl	$4,$4,1

$L5352:
	li	$8,24			# 0x18
	b	$L5353
	li	$7,16			# 0x10

$L5471:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$4,$4,23
	addu	$5,$5,$4
	lbu	$5,0($5)
	addu	$6,$5,$6
	lw	$5,%got(ff_se_golomb_vlc_code)($28)
	sw	$6,8456($16)
	addu	$4,$5,$4
	b	$L5351
	lb	$4,0($4)

$L5348:
	b	$L5344
	srl	$4,$4,1

$L5345:
	li	$8,24			# 0x18
	b	$L5346
	li	$7,16			# 0x10

$L5470:
	lw	$5,%got(ff_golomb_vlc_len)($28)
	srl	$4,$4,23
	addu	$5,$5,$4
	lbu	$5,0($5)
	addu	$6,$5,$6
	lw	$5,%got(ff_se_golomb_vlc_code)($28)
	sw	$6,8456($16)
	addu	$4,$5,$4
	b	$L5344
	lb	$4,0($4)

$L5469:
	move	$2,$3
	b	$L5214
	move	$3,$5

$L5466:
	lw	$25,%call16(av_log)($28)
	lw	$4,0($16)
	lui	$6,%hi($LC87)
	addiu	$6,$6,%lo($LC87)
	jalr	$25
	move	$5,$0

	b	$L5263
	li	$18,-1			# 0xffffffffffffffff

$L5362:
	b	$L5358
	srl	$4,$4,1

$L5359:
	li	$8,24			# 0x18
	b	$L5360
	li	$7,16			# 0x10

$L5473:
	lw	$5,8448($16)
	sra	$4,$2,3
	addu	$5,$5,$4
	addiu	$4,$2,1
	lbu	$5,0($5)
	sw	$4,8456($16)
	lw	$4,0($18)
	andi	$2,$2,0x7
	addiu	$4,$4,2446
	sll	$2,$5,$2
	sll	$4,$4,2
	addu	$4,$16,$4
	andi	$2,$2,0x00ff
	lw	$5,4($4)
	srl	$2,$2,7
	sw	$2,64($18)
	move	$6,$18
	move	$4,$16
	move	$7,$0
	sw	$8,16($sp)
	.option	pic0
	jal	decode_scaling_matrices
	.option	pic2
	sw	$9,20($sp)

	.option	pic0
	jal	get_se_golomb
	.option	pic2
	lw	$4,100($sp)

	lw	$28,72($sp)
	sw	$2,48($18)
	lw	$6,44($18)
	b	$L5365
	lw	$3,112($sp)

$L5436:
	sw	$19,16($sp)
	lw	$25,624($4)
	lui	$5,%hi(decode_slice)
	lw	$6,84($sp)
	addiu	$5,$5,%lo(decode_slice)
	jalr	$25
	move	$7,$0

	li	$2,35111			# 0x8927
	addu	$2,$19,$2
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$2,0($2)
	lw	$3,6172($2)
	lw	$2,6168($2)
	sw	$3,6172($16)
	b	$L5263
	sw	$2,6168($16)

$L5392:
	.option	pic0
	jal	decode_slice
	.option	pic2
	move	$5,$16

	b	$L5475
	lw	$31,156($sp)

$L5435:
	addu	$2,$19,$2
	sll	$2,$2,2
	addu	$2,$16,$2
	lw	$17,0($2)
	lw	$2,164($sp)
	move	$20,$7
	b	$L5397
	addu	$21,$2,$18

$L5230:
	sb	$0,0($6)
	sb	$0,1($6)
	addiu	$4,$4,2
	b	$L5231
	addiu	$2,$2,3

$L5474:
	li	$2,1			# 0x1
	b	$L5225
	move	$3,$4

$L5367:
	addiu	$9,$18,548
	addiu	$4,$18,292
	move	$2,$9
$L5370:
	lwl	$8,3($4)
	lwl	$7,7($4)
	lwl	$6,11($4)
	lwl	$5,15($4)
	lwr	$8,0($4)
	lwr	$7,4($4)
	lwr	$6,8($4)
	lwr	$5,12($4)
	swl	$8,3($2)
	swr	$8,0($2)
	swl	$7,7($2)
	swr	$7,4($2)
	swl	$6,11($2)
	swr	$6,8($2)
	addiu	$4,$4,16
	swl	$5,15($2)
	swr	$5,12($2)
	bne	$4,$9,$L5370
	addiu	$2,$2,16

	b	$L5479
	lw	$4,0($16)

	.set	macro
	.set	reorder
	.end	decode_nal_units
	.size	decode_nal_units, .-decode_nal_units
	.section	.rodata.str1.4
	.align	2
$LC102:
	.ascii	"avcC too short\012\000"
	.align	2
$LC103:
	.ascii	"Unknown avcC version %d\012\000"
	.align	2
$LC104:
	.ascii	"Decoding sps %d from avcC failed\012\000"
	.align	2
$LC105:
	.ascii	"Decoding pps %d from avcC failed\012\000"
	.align	2
$LC106:
	.ascii	"no frame!\012\000"
	.align	2
$LC107:
	.ascii	"no mmco here\012\000"
	.align	2
$LC108:
	.ascii	"mmco:%d %d %d\012\000"
	.align	2
$LC109:
	.ascii	"remove short %d count %d\012\000"
	.align	2
$LC110:
	.ascii	"%d %d %p\012\000"
	.align	2
$LC111:
	.ascii	"mmco: remove_short() failure\012\000"
	.align	2
$LC112:
	.ascii	"mmco: remove_long() failure\012\000"
	.align	2
$LC113:
	.ascii	"illegal short term buffer state detected\012\000"
	.align	2
$LC114:
	.ascii	"no picture\012\000"
	.text
	.align	2
	.set	nomips16
	.ent	decode_frame
	.type	decode_frame, @function
decode_frame:
	.frame	$sp,128,$31		# vars= 48, regs= 10/0, args= 32, gp= 8
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-128
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$31,124($sp)
	sw	$fp,120($sp)
	sw	$23,116($sp)
	sw	$22,112($sp)
	sw	$21,108($sp)
	sw	$20,104($sp)
	sw	$19,100($sp)
	sw	$18,96($sp)
	sw	$17,92($sp)
	sw	$16,88($sp)
	.cprestore	32
	lw	$17,136($4)
	lw	$2,12($4)
	lw	$3,144($sp)
	sw	$2,56($17)
	sw	$4,128($sp)
	lw	$4,604($4)
	sw	$5,132($sp)
	sw	$4,60($17)
	sw	$6,136($sp)
	bne	$3,$0,$L5505
	sw	$7,140($sp)

	li	$4,131072			# 0x20000
	addu	$3,$17,$4
	lw	$2,5956($3)
	beq	$2,$0,$L5506
	lw	$8,5952($3)

	lw	$3,48($2)
	bne	$3,$0,$L5506
	nop

	ori	$4,$4,0x1748
	lw	$6,228($8)
	addu	$4,$17,$4
	move	$9,$0
	b	$L5514
	li	$5,1			# 0x1

$L5750:
	lw	$2,0($4)
	move	$3,$6
	beq	$2,$0,$L5513
	addiu	$5,$5,1

$L5509:
	lw	$6,48($2)
	bne	$6,$0,$L5513
	addiu	$4,$4,4

	move	$6,$3
$L5514:
	lw	$3,228($2)
	slt	$7,$3,$6
	beq	$7,$0,$L5750
	nop

	move	$8,$2
	lw	$2,0($4)
	move	$9,$5
	bne	$2,$0,$L5509
	addiu	$5,$5,1

$L5513:
	li	$2,34256			# 0x85d0
	addu	$2,$9,$2
	sll	$2,$2,2
	addu	$2,$17,$2
	lw	$2,0($2)
$L5510:
	beq	$2,$0,$L5512
	li	$2,34257			# 0x85d1

	addu	$2,$9,$2
	sll	$2,$2,2
	addu	$17,$17,$2
$L5515:
	lw	$2,0($17)
	sw	$2,-4($17)
	bne	$2,$0,$L5515
	addiu	$17,$17,4

$L5512:
	beq	$8,$0,$L5516
	lw	$3,136($sp)

	li	$2,200			# 0xc8
	sw	$2,0($3)
	lw	$2,132($sp)
	addiu	$3,$8,192
$L5517:
	lw	$7,0($8)
	lw	$6,4($8)
	lw	$5,8($8)
	lw	$4,12($8)
	addiu	$8,$8,16
	sw	$7,0($2)
	sw	$6,4($2)
	sw	$5,8($2)
	sw	$4,12($2)
	bne	$8,$3,$L5517
	addiu	$2,$2,16

	lw	$4,4($8)
	lw	$3,0($8)
	sw	$4,4($2)
	sw	$3,0($2)
	lw	$31,124($sp)
	move	$2,$0
	lw	$fp,120($sp)
	lw	$23,116($sp)
	lw	$22,112($sp)
	lw	$21,108($sp)
	lw	$20,104($sp)
	lw	$19,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	j	$31
	addiu	$sp,$sp,128

$L5505:
	li	$4,65536			# 0x10000
	and	$2,$2,$4
	bne	$2,$0,$L5751
	lw	$25,%call16(ff_h264_find_frame_end)($28)

$L5519:
	lw	$2,8728($17)
	beq	$2,$0,$L5786
	lw	$6,128($sp)

	lw	$2,8732($17)
	bne	$2,$0,$L5786
	lw	$4,128($sp)

	lw	$2,28($4)
	slt	$2,$2,7
	bne	$2,$0,$L5752
	lw	$16,24($4)

	lbu	$7,0($16)
	li	$2,1			# 0x1
	bne	$7,$2,$L5753
	li	$2,2			# 0x2

	sw	$2,8736($17)
	lbu	$20,5($16)
	andi	$20,$20,0x1f
	beq	$20,$0,$L5523
	addiu	$16,$16,6

	b	$L5525
	move	$18,$0

$L5524:
	addiu	$18,$18,1
	slt	$2,$18,$20
	beq	$2,$0,$L5523
	addu	$16,$16,$19

$L5525:
	lbu	$2,0($16)
	lbu	$19,1($16)
	sll	$2,$2,8
	or	$19,$19,$2
	addiu	$19,$19,2
	move	$4,$17
	move	$5,$16
	.option	pic0
	jal	decode_nal_units
	.option	pic2
	move	$6,$19

	bgez	$2,$L5524
	lw	$28,32($sp)

	lui	$6,%hi($LC104)
	lw	$25,%call16(av_log)($28)
	lw	$4,128($sp)
	addiu	$6,$6,%lo($LC104)
	move	$7,$18
$L5748:
	jalr	$25
	move	$5,$0

$L5749:
	li	$2,-1			# 0xffffffffffffffff
$L5518:
	lw	$31,124($sp)
	lw	$fp,120($sp)
	lw	$23,116($sp)
	lw	$22,112($sp)
	lw	$21,108($sp)
	lw	$20,104($sp)
	lw	$19,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	j	$31
	addiu	$sp,$sp,128

$L5526:
	lw	$5,128($sp)
	li	$3,1			# 0x1
	lw	$2,24($5)
	lbu	$2,4($2)
	sw	$3,8732($17)
	andi	$2,$2,0x3
	addiu	$2,$2,1
	sw	$2,8736($17)
	lw	$6,128($sp)
$L5786:
	lw	$2,80($6)
	bne	$2,$0,$L5782
	lw	$5,140($sp)

	lw	$2,8728($17)
	bne	$2,$0,$L5787
	lw	$6,144($sp)

	lw	$2,0($17)
	lw	$6,28($2)
	bne	$6,$0,$L5754
	nop

$L5782:
	lw	$6,144($sp)
$L5787:
	.option	pic0
	jal	decode_nal_units
	.option	pic2
	move	$4,$17

	lw	$28,32($sp)
	bltz	$2,$L5749
	sw	$2,60($sp)

	lw	$2,60($17)
	andi	$2,$2,0x8000
	bne	$2,$0,$L5531
	nop

	lw	$2,1880($17)
	beq	$2,$0,$L5755
	sw	$2,68($sp)

$L5532:
	li	$3,2			# 0x2
	sw	$0,6172($17)
	sw	$3,160($2)
	lw	$3,2084($17)
	li	$7,131072			# 0x20000
	sw	$3,52($2)
	li	$3,65536			# 0x10000
	addu	$3,$17,$3
	lw	$5,-6216($3)
	lw	$4,-6228($3)
	sw	$5,-6212($3)
	sw	$4,-6208($3)
	lw	$4,80($2)
	lw	$5,8500($17)
	and	$5,$5,$4
	addu	$4,$17,$7
	lw	$8,6024($4)
	bne	$5,$0,$L5756
	sw	$8,52($sp)

$L5534:
	lw	$25,%call16(ff_er_frame_end)($28)
$L5794:
	jalr	$25
	move	$4,$17

	lw	$28,32($sp)
	lw	$25,%call16(MPV_frame_end)($28)
	jalr	$25
	move	$4,$17

	lw	$2,10544($17)
	beq	$2,$0,$L5648
	lw	$28,32($sp)

	lw	$4,0($17)
	lw	$2,10548($17)
	lw	$3,268($4)
	slt	$3,$3,$2
	bne	$3,$0,$L5757
	nop

$L5648:
	li	$2,131072			# 0x20000
	addu	$3,$17,$2
	lw	$3,5952($3)
	beq	$3,$0,$L5758
	ori	$2,$2,0x1744

	addu	$2,$17,$2
	move	$5,$0
$L5651:
	lw	$3,0($2)
	addiu	$5,$5,1
	bne	$3,$0,$L5651
	addiu	$2,$2,4

	addiu	$12,$5,1
$L5650:
	lw	$8,68($sp)
	li	$3,34256			# 0x85d0
	addu	$3,$5,$3
	sll	$3,$3,2
	lw	$2,80($8)
	addu	$3,$17,$3
	bne	$2,$0,$L5652
	sw	$8,0($3)

	li	$2,4			# 0x4
	sw	$2,80($8)
$L5652:
	li	$3,131072			# 0x20000
	addu	$2,$17,$3
	lw	$10,5952($2)
	beq	$10,$0,$L5759
	move	$2,$10

	ori	$3,$3,0x1744
	addu	$3,$17,$3
	move	$9,$0
$L5657:
	lw	$4,48($2)
	bne	$4,$0,$L5655
	nop

	lw	$2,228($2)
	bne	$2,$0,$L5656
	nop

$L5655:
	li	$9,1			# 0x1
$L5656:
	lw	$2,0($3)
	bne	$2,$0,$L5657
	addiu	$3,$3,4

$L5654:
	li	$4,131072			# 0x20000
	addu	$2,$17,$4
	lw	$2,5956($2)
	beq	$2,$0,$L5661
	move	$11,$0

	lw	$3,48($2)
	bne	$3,$0,$L5661
	ori	$4,$4,0x1748

	lw	$7,228($10)
	addu	$4,$17,$4
	move	$11,$0
	b	$L5662
	li	$6,1			# 0x1

$L5760:
	move	$3,$7
$L5660:
	lw	$2,0($4)
	beq	$2,$0,$L5661
	addiu	$6,$6,1

	lw	$7,48($2)
	bne	$7,$0,$L5661
	addiu	$4,$4,4

	move	$7,$3
$L5662:
	lw	$3,228($2)
	slt	$8,$3,$7
	beq	$8,$0,$L5760
	nop

	move	$10,$2
	b	$L5660
	move	$11,$6

$L5751:
	move	$5,$7
	move	$6,$3
	jalr	$25
	move	$4,$17

	lw	$28,32($sp)
	move	$5,$2
	lw	$25,%call16(ff_combine_frame)($28)
	addiu	$4,$17,7996
	addiu	$6,$sp,140
	jalr	$25
	addiu	$7,$sp,144

	bgez	$2,$L5519
	lw	$28,32($sp)

	b	$L5518
	lw	$2,144($sp)

$L5531:
	lw	$2,148($17)
	lw	$3,6172($17)
	slt	$3,$3,$2
	bne	$3,$0,$L5788
	lw	$25,%call16(ff_print_debug_info)($28)

	bne	$2,$0,$L5761
	nop

$L5533:
	lw	$25,%call16(ff_print_debug_info)($28)
$L5788:
	lw	$5,132($sp)
	jalr	$25
	move	$4,$17

	lw	$3,56($17)
	li	$2,65536			# 0x10000
	and	$3,$3,$2
	beq	$3,$0,$L5683
	lw	$2,144($sp)

	lw	$2,8004($17)
	lw	$4,60($sp)
	lw	$31,124($sp)
	subu	$2,$4,$2
	slt	$3,$2,0
	movn	$2,$0,$3
	lw	$fp,120($sp)
	lw	$23,116($sp)
	lw	$22,112($sp)
	lw	$21,108($sp)
	lw	$20,104($sp)
	lw	$19,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	j	$31
	addiu	$sp,$sp,128

$L5506:
	move	$2,$8
	b	$L5510
	move	$9,$0

$L5661:
	bne	$9,$0,$L5664
	move	$2,$0

	lw	$2,52($sp)
	beq	$2,$0,$L5663
	nop

	lw	$3,228($10)
	lw	$2,228($2)
	slt	$2,$3,$2
$L5664:
	lw	$3,10544($17)
	beq	$3,$0,$L5789
	lw	$3,52($sp)

	lw	$4,0($17)
	lw	$3,10548($17)
	lw	$6,268($4)
	slt	$3,$6,$3
	bne	$3,$0,$L5665
	lw	$3,52($sp)

$L5666:
	beq	$2,$0,$L5673
	nop

$L5674:
	li	$2,34256			# 0x85d0
$L5790:
	addu	$2,$11,$2
	sll	$2,$2,2
	addu	$2,$17,$2
	lw	$2,0($2)
	beq	$2,$0,$L5676
	li	$2,34257			# 0x85d1

	addu	$2,$11,$2
	sll	$2,$2,2
	addu	$2,$17,$2
$L5677:
	lw	$3,0($2)
	sw	$3,-4($2)
	bne	$3,$0,$L5677
	addiu	$2,$2,4

$L5676:
	lw	$6,52($sp)
$L5783:
	beq	$6,$10,$L5762
	lw	$8,136($sp)

	li	$2,200			# 0xc8
	sw	$2,0($8)
$L5679:
	lw	$2,52($sp)
	beq	$2,$0,$L5680
	nop

	beq	$2,$10,$L5680
	nop

	lw	$3,80($2)
	li	$2,4			# 0x4
	beq	$3,$2,$L5763
	lw	$3,52($sp)

$L5680:
	li	$2,131072			# 0x20000
	addu	$2,$17,$2
	beq	$10,$0,$L5681
	sw	$10,6024($2)

	lw	$2,132($sp)
	addiu	$3,$10,192
$L5682:
	lw	$7,0($10)
	lw	$6,4($10)
	lw	$5,8($10)
	lw	$4,12($10)
	addiu	$10,$10,16
	sw	$7,0($2)
	sw	$6,4($2)
	sw	$5,8($2)
	sw	$4,12($2)
	bne	$10,$3,$L5682
	addiu	$2,$2,16

	lw	$4,4($10)
	lw	$3,0($10)
	sw	$4,4($2)
	b	$L5533
	sw	$3,0($2)

$L5665:
$L5789:
	beq	$3,$0,$L5667
	nop

	lw	$4,0($17)
	lw	$3,268($4)
	slt	$3,$3,$12
	bne	$3,$0,$L5667
	nop

	b	$L5666
	lw	$10,52($sp)

$L5683:
	lw	$5,60($sp)
	bne	$5,$0,$L5684
	lw	$7,60($sp)

	li	$6,1			# 0x1
	li	$3,10			# 0xa
	move	$8,$6
	slt	$3,$3,$2
	sw	$6,60($sp)
	movn	$2,$8,$3
$L5765:
	lw	$31,124($sp)
	lw	$fp,120($sp)
	lw	$23,116($sp)
	lw	$22,112($sp)
	lw	$21,108($sp)
	lw	$20,104($sp)
	lw	$19,100($sp)
	lw	$18,96($sp)
	lw	$17,92($sp)
	lw	$16,88($sp)
	j	$31
	addiu	$sp,$sp,128

$L5754:
	lw	$5,24($2)
	.option	pic0
	jal	decode_nal_units
	.option	pic2
	move	$4,$17

	bltz	$2,$L5518
	li	$2,-1			# 0xffffffffffffffff

	b	$L5782
	lw	$5,140($sp)

$L5516:
	b	$L5518
	move	$2,$0

$L5663:
	b	$L5664
	move	$2,$0

$L5667:
	bne	$2,$0,$L5764
	nop

$L5669:
	lw	$3,8240($17)
	beq	$3,$0,$L5671
	nop

	bne	$9,$0,$L5672
	lw	$4,52($sp)

	beq	$4,$0,$L5672
	nop

	lw	$3,228($4)
	lw	$4,228($10)
	addiu	$3,$3,2
	slt	$3,$3,$4
	bne	$3,$0,$L5745
	nop

$L5672:
	lw	$5,68($sp)
	li	$3,3			# 0x3
	lw	$4,52($5)
	beq	$4,$3,$L5745
	nop

$L5671:
	bne	$2,$0,$L5729
	nop

	lw	$4,0($17)
$L5673:
	lw	$2,268($4)
	slt	$12,$2,$12
	bne	$12,$0,$L5790
	li	$2,34256			# 0x85d0

	b	$L5783
	lw	$6,52($sp)

$L5523:
	lbu	$20,0($16)
	beq	$20,$0,$L5526
	addiu	$16,$16,1

	b	$L5528
	move	$18,$0

$L5527:
	addiu	$18,$18,1
	slt	$3,$18,$20
	beq	$3,$0,$L5526
	addu	$16,$16,$2

$L5528:
	lbu	$2,0($16)
	lbu	$19,1($16)
	sll	$2,$2,8
	or	$19,$19,$2
	addiu	$19,$19,2
	move	$4,$17
	move	$5,$16
	.option	pic0
	jal	decode_nal_units
	.option	pic2
	move	$6,$19

	beq	$2,$19,$L5527
	lw	$28,32($sp)

	lw	$25,%call16(av_log)($28)
	lw	$4,128($sp)
	lui	$6,%hi($LC105)
	addiu	$6,$6,%lo($LC105)
	move	$7,$18
	jalr	$25
	move	$5,$0

	b	$L5518
	li	$2,-1			# 0xffffffffffffffff

$L5684:
	addiu	$3,$7,9
	move	$8,$7
	slt	$3,$3,$2
	b	$L5765
	movn	$2,$8,$3

$L5757:
	sw	$2,268($4)
	b	$L5648
	sw	$0,8240($17)

$L5761:
	lw	$2,1880($17)
	b	$L5532
	sw	$2,68($sp)

$L5729:
	b	$L5674
	lw	$10,52($sp)

$L5764:
	lw	$4,0($17)
	lw	$3,268($4)
	bne	$3,$5,$L5669
	slt	$3,$12,15

	beq	$3,$0,$L5669
	nop

$L5670:
	sw	$0,8240($17)
	lw	$3,268($4)
	lw	$10,52($sp)
	addiu	$3,$3,1
	b	$L5666
	sw	$3,268($4)

$L5745:
	b	$L5670
	lw	$4,0($17)

$L5756:
	lw	$6,-6244($3)
	lw	$8,-6248($3)
	lw	$5,0($17)
	sw	$8,-6220($3)
	sw	$6,-6224($3)
	lw	$6,412($5)
	lw	$4,6820($4)
	ori	$21,$7,0x178c
	andi	$6,$6,0x800
	sw	$4,48($sp)
	addu	$21,$17,$21
	move	$4,$5
	beq	$6,$0,$L5535
	move	$3,$6

	lw	$7,48($sp)
	beq	$7,$0,$L5766
	lw	$25,%call16(av_log)($28)

$L5535:
	lw	$8,48($sp)
	blez	$8,$L5536
	li	$20,65536			# 0x10000

	li	$5,131072			# 0x20000
	ori	$20,$20,0x173c
	ori	$2,$5,0x1744
	li	$fp,131072			# 0x20000
	addu	$20,$17,$20
	ori	$fp,$fp,0x178c
	addu	$2,$17,$2
	lui	$19,%hi($LC110)
	addu	$fp,$17,$fp
	sw	$2,56($sp)
	addiu	$19,$19,%lo($LC110)
	sw	$0,72($sp)
	move	$23,$0
	bne	$3,$0,$L5767
	sw	$20,64($sp)

$L5537:
	lw	$2,0($21)
	sltu	$3,$2,7
	beq	$3,$0,$L5743
	lui	$6,%hi($L5545)

	sll	$2,$2,2
	addiu	$6,$6,%lo($L5545)
	addu	$2,$6,$2
	lw	$2,0($2)
	j	$2
	nop

	.rdata
	.align	2
	.align	2
$L5545:
	.word	$L5743
	.word	$L5539
	.word	$L5540
	.word	$L5541
	.word	$L5542
	.word	$L5543
	.word	$L5544
	.text
$L5575:
	lw	$2,412($4)
	andi	$2,$2,0x800
	beq	$2,$0,$L5579
	move	$5,$4

	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC112)
	li	$5,2			# 0x2
	jalr	$25
	addiu	$6,$6,%lo($LC112)

	lw	$28,32($sp)
$L5742:
	lw	$4,0($17)
$L5743:
	lw	$3,412($4)
$L5784:
	move	$5,$4
	andi	$3,$3,0x800
$L5547:
	lw	$6,48($sp)
	addiu	$23,$23,1
	slt	$2,$23,$6
	addiu	$21,$21,12
	beq	$2,$0,$L5618
	addiu	$fp,$fp,12

	lw	$3,412($4)
	andi	$3,$3,0x800
	beq	$3,$0,$L5537
	nop

$L5767:
	lw	$2,4($fp)
	lw	$7,0($fp)
	sw	$2,16($sp)
	lw	$2,8($fp)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC108)
	sw	$2,20($sp)
	li	$5,2			# 0x2
	jalr	$25
	addiu	$6,$6,%lo($LC108)

	lw	$28,32($sp)
	b	$L5537
	lw	$4,0($17)

$L5544:
	lw	$2,8($21)
	addiu	$3,$2,17902
	sll	$6,$3,2
	addu	$6,$17,$6
	lw	$5,4($6)
	beq	$5,$0,$L5585
	li	$7,131072			# 0x20000

	addu	$2,$17,$7
	lw	$7,6824($2)
	lw	$3,6024($2)
	addiu	$7,$7,-1
	sw	$7,6824($2)
	sw	$0,4($6)
	beq	$5,$3,$L5588
	sw	$0,80($5)

	lw	$2,5952($2)
	beq	$2,$0,$L5737
	nop

	beq	$5,$2,$L5588
	nop

	b	$L5590
	lw	$2,56($sp)

$L5591:
	beq	$5,$3,$L5588
	addiu	$2,$2,4

$L5590:
	lw	$3,0($2)
	bne	$3,$0,$L5591
	nop

$L5737:
	lw	$2,8($21)
	addiu	$3,$2,17902
$L5585:
	lw	$5,1880($17)
	sll	$3,$3,2
	addiu	$2,$2,17902
	addu	$3,$17,$3
	sll	$2,$2,2
	sw	$5,4($3)
	addu	$2,$17,$2
	lw	$2,4($2)
	li	$3,1			# 0x1
	li	$8,131072			# 0x20000
	sw	$3,240($2)
	addu	$2,$17,$8
	lw	$3,6824($2)
	move	$5,$4
	addiu	$3,$3,1
	sw	$3,6824($2)
	lw	$3,412($4)
	li	$2,1			# 0x1
	sw	$2,72($sp)
	b	$L5547
	andi	$3,$3,0x800

$L5543:
	li	$7,131072			# 0x20000
	addu	$2,$17,$7
	li	$8,65536			# 0x10000
	lw	$5,6828($2)
	move	$18,$2
	addu	$22,$17,$8
	sw	$17,40($sp)
$L5719:
	beq	$5,$0,$L5791
	lw	$17,40($sp)

$L5610:
	lw	$2,412($4)
	lw	$3,5948($22)
	andi	$2,$2,0x800
	bne	$2,$0,$L5769
	lw	$8,232($3)

$L5600:
	blez	$5,$L5719
	move	$2,$0

	move	$3,$20
	sw	$20,44($sp)
	move	$16,$2
	b	$L5603
	lw	$20,40($sp)

$L5601:
	lw	$2,232($17)
	beq	$8,$2,$L5792
	move	$2,$16

$L5771:
	lw	$5,6828($18)
	addiu	$16,$16,1
	slt	$2,$16,$5
	beq	$2,$0,$L5770
	addiu	$3,$3,4

	lw	$4,0($20)
$L5603:
	lw	$2,412($4)
	andi	$2,$2,0x800
	beq	$2,$0,$L5601
	lw	$17,0($3)

	lw	$2,232($17)
	lw	$25,%call16(av_log)($28)
	sw	$2,16($sp)
	sw	$3,80($sp)
	sw	$8,76($sp)
	sw	$17,20($sp)
	li	$5,2			# 0x2
	move	$6,$19
	jalr	$25
	move	$7,$16

	lw	$8,76($sp)
	lw	$2,232($17)
	lw	$28,32($sp)
	bne	$8,$2,$L5771
	lw	$3,80($sp)

	move	$2,$16
$L5792:
	lw	$6,6828($18)
	addiu	$3,$2,17870
	lw	$8,40($sp)
	sll	$3,$3,2
	addu	$3,$8,$3
	addiu	$6,$6,-1
	move	$16,$17
	lw	$20,44($sp)
	sw	$0,4($3)
	beq	$6,$0,$L5604
	sw	$6,6828($18)

	addiu	$5,$2,1
	lw	$25,%call16(memmove)($28)
	subu	$6,$6,$2
	sll	$5,$5,2
	sll	$2,$2,2
	addu	$4,$20,$2
	addu	$5,$20,$5
	jalr	$25
	sll	$6,$6,2

	lw	$28,32($sp)
$L5604:
	lw	$2,6024($18)
	beq	$2,$16,$L5772
	sw	$0,80($16)

	lw	$2,5952($18)
	beq	$2,$0,$L5738
	nop

	beq	$2,$16,$L5606
	lw	$2,56($sp)

	b	$L5795
	lw	$3,0($2)

$L5609:
	beq	$3,$16,$L5606
	addiu	$2,$2,4

	lw	$3,0($2)
$L5795:
	bne	$3,$0,$L5609
	nop

$L5738:
	lw	$2,40($sp)
	lw	$5,6828($18)
	bne	$5,$0,$L5610
	lw	$4,0($2)

	lw	$17,40($sp)
$L5791:
	li	$3,65536			# 0x10000
	li	$5,65536			# 0x10000
	ori	$6,$3,0x17bc
	ori	$5,$5,0x17fc
	li	$2,131072			# 0x20000
	lw	$10,56($sp)
	addu	$6,$17,$6
	addu	$8,$17,$5
	addu	$7,$17,$2
	li	$9,4			# 0x4
$L5617:
	lw	$5,0($6)
	beq	$5,$0,$L5611
	nop

	lw	$3,6824($7)
	lw	$2,6024($7)
	addiu	$3,$3,-1
	sw	$3,6824($7)
	sw	$0,0($6)
	beq	$5,$2,$L5613
	sw	$0,80($5)

	lw	$2,5952($7)
	beq	$2,$0,$L5611
	nop

	beq	$5,$2,$L5613
	move	$2,$10

	b	$L5796
	lw	$3,0($2)

$L5616:
	beq	$5,$3,$L5613
	addiu	$2,$2,4

	lw	$3,0($2)
$L5796:
	bne	$3,$0,$L5616
	nop

$L5611:
	addiu	$6,$6,4
	bne	$6,$8,$L5617
	nop

	b	$L5784
	lw	$3,412($4)

$L5769:
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC109)
	sw	$5,16($sp)
	addiu	$6,$6,%lo($LC109)
	li	$5,2			# 0x2
	move	$7,$8
	jalr	$25
	sw	$8,76($sp)

	lw	$6,40($sp)
	lw	$28,32($sp)
	lw	$5,6828($18)
	lw	$4,0($6)
	b	$L5600
	lw	$8,76($sp)

$L5542:
	lw	$2,8($21)
	slt	$3,$2,16
	beq	$3,$0,$L5743
	addiu	$6,$2,17902

	sll	$6,$6,2
	li	$3,65536			# 0x10000
	addu	$6,$17,$6
	ori	$3,$3,0x17fc
	li	$5,131072			# 0x20000
	lw	$10,56($sp)
	addiu	$6,$6,4
	addu	$8,$17,$3
	addu	$7,$17,$5
	li	$9,4			# 0x4
$L5599:
	lw	$5,0($6)
	beq	$5,$0,$L5593
	nop

	lw	$3,6824($7)
	lw	$2,6024($7)
	addiu	$3,$3,-1
	sw	$3,6824($7)
	sw	$0,0($6)
	beq	$5,$2,$L5595
	sw	$0,80($5)

	lw	$2,5952($7)
	beq	$2,$0,$L5593
	nop

	beq	$5,$2,$L5595
	move	$2,$10

	b	$L5797
	lw	$3,0($2)

$L5598:
	beq	$5,$3,$L5595
	addiu	$2,$2,4

	lw	$3,0($2)
$L5797:
	bne	$3,$0,$L5598
	nop

$L5593:
	addiu	$6,$6,4
	bne	$6,$8,$L5599
	nop

	b	$L5784
	lw	$3,412($4)

$L5540:
	lw	$3,8($21)
	addiu	$3,$3,17902
	sll	$3,$3,2
	addu	$3,$17,$3
	lw	$5,4($3)
	beq	$5,$0,$L5575
	li	$6,131072			# 0x20000

	addu	$2,$17,$6
	lw	$7,6824($2)
	lw	$6,6024($2)
	addiu	$7,$7,-1
	sw	$7,6824($2)
	sw	$0,4($3)
	beq	$5,$6,$L5581
	sw	$0,80($5)

	lw	$2,5952($2)
	beq	$2,$0,$L5743
	nop

	beq	$5,$2,$L5581
	lw	$2,56($sp)

	b	$L5798
	lw	$3,0($2)

$L5584:
	beq	$5,$3,$L5581
	addiu	$2,$2,4

	lw	$3,0($2)
$L5798:
	bne	$3,$0,$L5584
	nop

	b	$L5784
	lw	$3,412($4)

$L5539:
	lw	$6,412($4)
	lw	$2,4($21)
	andi	$6,$6,0x800
	bne	$6,$0,$L5548
	move	$5,$4

	move	$8,$0
$L5549:
	li	$7,131072			# 0x20000
	addu	$3,$17,$7
	lw	$7,6828($3)
	blez	$7,$L5550
	lw	$22,64($sp)

	move	$18,$0
	b	$L5554
	move	$4,$5

$L5551:
	lw	$4,232($16)
	beq	$2,$4,$L5793
	li	$8,131072			# 0x20000

$L5774:
	lw	$4,6828($3)
	addiu	$18,$18,1
	slt	$4,$18,$4
	beq	$4,$0,$L5773
	addiu	$22,$22,4

	lw	$4,0($17)
	lw	$6,412($4)
	andi	$6,$6,0x800
$L5554:
	beq	$6,$0,$L5551
	lw	$16,0($22)

	lw	$5,232($16)
	lw	$25,%call16(av_log)($28)
	sw	$5,16($sp)
	sw	$2,76($sp)
	sw	$3,80($sp)
	sw	$16,20($sp)
	li	$5,2			# 0x2
	move	$6,$19
	jalr	$25
	move	$7,$18

	lw	$2,76($sp)
	lw	$4,232($16)
	lw	$28,32($sp)
	bne	$2,$4,$L5774
	lw	$3,80($sp)

	li	$8,131072			# 0x20000
$L5793:
	addu	$2,$17,$8
	lw	$6,6828($2)
	addiu	$3,$18,17870
	sll	$3,$3,2
	addu	$3,$17,$3
	addiu	$6,$6,-1
	sw	$0,4($3)
	beq	$6,$0,$L5555
	sw	$6,6828($2)

	addiu	$5,$18,1
	lw	$25,%call16(memmove)($28)
	subu	$6,$6,$18
	sll	$5,$5,2
	sll	$4,$18,2
	addu	$4,$20,$4
	addu	$5,$20,$5
	jalr	$25
	sll	$6,$6,2

	lw	$28,32($sp)
$L5555:
	li	$3,131072			# 0x20000
	addu	$2,$17,$3
	lw	$3,6024($2)
	beq	$3,$16,$L5557
	sw	$0,80($16)

	lw	$2,5952($2)
	beq	$2,$0,$L5742
	nop

	beq	$2,$16,$L5557
	lw	$2,56($sp)

	b	$L5799
	lw	$3,0($2)

$L5560:
	beq	$3,$16,$L5557
	addiu	$2,$2,4

	lw	$3,0($2)
$L5799:
	bne	$3,$0,$L5560
	nop

	b	$L5743
	lw	$4,0($17)

$L5541:
	lw	$18,8($21)
	addiu	$18,$18,17902
	sll	$3,$18,2
	addu	$3,$17,$3
	lw	$5,4($3)
	beq	$5,$0,$L5561
	li	$6,131072			# 0x20000

	addu	$2,$17,$6
	lw	$7,6824($2)
	lw	$6,6024($2)
	addiu	$7,$7,-1
	sw	$7,6824($2)
	sw	$0,4($3)
	beq	$5,$6,$L5564
	sw	$0,80($5)

	lw	$2,5952($2)
	beq	$2,$0,$L5735
	nop

	beq	$5,$2,$L5564
	lw	$2,56($sp)

	b	$L5800
	lw	$3,0($2)

$L5567:
	beq	$5,$3,$L5564
	addiu	$2,$2,4

	lw	$3,0($2)
$L5800:
	bne	$3,$0,$L5567
	nop

$L5735:
	lw	$18,8($21)
	addiu	$18,$18,17902
$L5561:
	lw	$2,412($4)
	andi	$2,$2,0x800
	bne	$2,$0,$L5775
	lw	$3,4($21)

$L5568:
	li	$2,131072			# 0x20000
	addu	$8,$17,$2
	lw	$2,6828($8)
	blez	$2,$L5569
	lw	$2,64($sp)

	sw	$18,40($sp)
	move	$22,$0
	move	$16,$2
	b	$L5572
	move	$18,$17

$L5570:
	lw	$2,232($17)
	beq	$3,$2,$L5571
	nop

$L5777:
	lw	$2,6828($8)
	addiu	$22,$22,1
	slt	$2,$22,$2
	beq	$2,$0,$L5776
	addiu	$16,$16,4

	lw	$4,0($18)
$L5572:
	lw	$2,412($4)
	andi	$2,$2,0x800
	beq	$2,$0,$L5570
	lw	$17,0($16)

	lw	$2,232($17)
	lw	$25,%call16(av_log)($28)
	sw	$2,16($sp)
	sw	$3,80($sp)
	sw	$8,76($sp)
	sw	$17,20($sp)
	li	$5,2			# 0x2
	move	$6,$19
	jalr	$25
	move	$7,$22

	lw	$3,80($sp)
	lw	$2,232($17)
	lw	$28,32($sp)
	bne	$3,$2,$L5777
	lw	$8,76($sp)

$L5571:
	li	$3,131072			# 0x20000
	move	$16,$17
	move	$17,$18
	addu	$2,$17,$3
	lw	$6,6828($2)
	addiu	$3,$22,17870
	sll	$3,$3,2
	addu	$3,$17,$3
	addiu	$6,$6,-1
	lw	$18,40($sp)
	sw	$0,4($3)
	bne	$6,$0,$L5722
	sw	$6,6828($2)

	b	$L5573
	lw	$4,0($17)

$L5770:
	lw	$7,40($sp)
	lw	$20,44($sp)
	b	$L5719
	lw	$4,0($7)

$L5595:
	addiu	$6,$6,4
	bne	$6,$8,$L5599
	sw	$9,80($5)

	b	$L5784
	lw	$3,412($4)

$L5613:
	addiu	$6,$6,4
	bne	$6,$8,$L5617
	sw	$9,80($5)

	b	$L5784
	lw	$3,412($4)

$L5773:
	lw	$4,0($17)
	lw	$8,412($4)
	move	$5,$4
	andi	$8,$8,0x800
$L5550:
	bne	$8,$0,$L5778
	lw	$25,%call16(av_log)($28)

$L5579:
	b	$L5547
	move	$3,$0

$L5778:
	lui	$6,%hi($LC111)
	li	$5,2			# 0x2
	jalr	$25
	addiu	$6,$6,%lo($LC111)

	lw	$28,32($sp)
	b	$L5743
	lw	$4,0($17)

$L5776:
	move	$17,$18
	lw	$4,0($17)
	lw	$18,40($sp)
$L5569:
	move	$16,$0
$L5573:
	lw	$2,8($21)
	sll	$18,$18,2
	addiu	$2,$2,17902
	addu	$18,$17,$18
	sll	$2,$2,2
	sw	$16,4($18)
	addu	$2,$17,$2
	lw	$2,4($2)
	beq	$2,$0,$L5743
	li	$3,1			# 0x1

	li	$5,131072			# 0x20000
	sw	$3,240($2)
	addu	$2,$17,$5
	lw	$3,6824($2)
	move	$5,$4
	addiu	$3,$3,1
	sw	$3,6824($2)
	lw	$3,412($4)
	b	$L5547
	andi	$3,$3,0x800

$L5722:
	addiu	$5,$22,1
	lw	$25,%call16(memmove)($28)
	subu	$6,$6,$22
	sll	$5,$5,2
	sll	$4,$22,2
	addu	$4,$20,$4
	addu	$5,$20,$5
	jalr	$25
	sll	$6,$6,2

	lw	$28,32($sp)
	b	$L5573
	lw	$4,0($17)

$L5548:
	li	$5,131072			# 0x20000
	addu	$3,$17,$5
	lw	$3,6828($3)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC109)
	li	$5,2			# 0x2
	addiu	$6,$6,%lo($LC109)
	move	$7,$2
	sw	$2,76($sp)
	jalr	$25
	sw	$3,16($sp)

	lw	$4,0($17)
	lw	$28,32($sp)
	lw	$6,412($4)
	move	$5,$4
	andi	$6,$6,0x800
	move	$8,$6
	b	$L5549
	lw	$2,76($sp)

$L5775:
	li	$7,131072			# 0x20000
	addu	$2,$17,$7
	lw	$2,6828($2)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC109)
	move	$7,$3
	sw	$3,80($sp)
	sw	$2,16($sp)
	li	$5,2			# 0x2
	jalr	$25
	addiu	$6,$6,%lo($LC109)

	lw	$28,32($sp)
	lw	$4,0($17)
	b	$L5568
	lw	$3,80($sp)

$L5588:
	li	$2,4			# 0x4
	sw	$2,80($5)
	lw	$2,8($21)
	b	$L5585
	addiu	$3,$2,17902

$L5564:
	li	$2,4			# 0x4
	sw	$2,80($5)
	lw	$18,8($21)
	b	$L5561
	addiu	$18,$18,17902

$L5557:
	lw	$4,0($17)
	li	$2,4			# 0x4
	sw	$2,80($16)
	lw	$3,412($4)
	move	$5,$4
	b	$L5547
	andi	$3,$3,0x800

$L5581:
	li	$2,4			# 0x4
	sw	$2,80($5)
	lw	$3,412($4)
	move	$5,$4
	b	$L5547
	andi	$3,$3,0x800

$L5606:
	li	$7,4			# 0x4
	lw	$8,40($sp)
	sw	$7,80($16)
	lw	$5,6828($18)
	b	$L5719
	lw	$4,0($8)

$L5772:
	li	$3,4			# 0x4
	lw	$6,40($sp)
	sw	$3,80($16)
	lw	$5,6828($18)
	b	$L5719
	lw	$4,0($6)

$L5618:
	lw	$7,72($sp)
	beq	$7,$0,$L5779
	nop

$L5620:
	beq	$3,$0,$L5794
	lw	$25,%call16(ff_er_frame_end)($28)

	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC15)
	li	$19,131072			# 0x20000
	move	$4,$5
	addiu	$6,$6,%lo($LC15)
	li	$5,2			# 0x2
	jalr	$25
	addu	$19,$17,$19

	lw	$2,6828($19)
	beq	$2,$0,$L5631
	lw	$28,32($sp)

	li	$18,65536			# 0x10000
	ori	$18,$18,0x173c
	lui	$20,%hi($LC16)
	addu	$18,$17,$18
	addiu	$20,$20,%lo($LC16)
	move	$16,$0
$L5632:
	lw	$2,0($18)
	lw	$4,0($17)
	lw	$3,232($2)
	lw	$25,%call16(av_log)($28)
	sw	$3,16($sp)
	lw	$3,228($2)
	move	$7,$16
	sw	$3,20($sp)
	lw	$2,0($2)
	li	$5,2			# 0x2
	sw	$2,24($sp)
	jalr	$25
	move	$6,$20

	lw	$2,6828($19)
	addiu	$16,$16,1
	sltu	$2,$16,$2
	lw	$28,32($sp)
	bne	$2,$0,$L5632
	addiu	$18,$18,4

$L5631:
	lw	$4,0($17)
	lw	$2,412($4)
	andi	$2,$2,0x800
	beq	$2,$0,$L5534
	lw	$25,%call16(av_log)($28)

	lui	$6,%hi($LC17)
	addiu	$6,$6,%lo($LC17)
	jalr	$25
	li	$5,2			# 0x2

	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6076($2)
	beq	$2,$0,$L5633
	lw	$28,32($sp)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	lw	$25,%call16(av_log)($28)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	move	$7,$0

	lw	$28,32($sp)
$L5633:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6080($2)
	beq	$2,$0,$L5634
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,1			# 0x1

	lw	$28,32($sp)
$L5634:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6084($2)
	beq	$2,$0,$L5635
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,2			# 0x2

	lw	$28,32($sp)
$L5635:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6088($2)
	beq	$2,$0,$L5636
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,3			# 0x3

	lw	$28,32($sp)
$L5636:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6092($2)
	beq	$2,$0,$L5637
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,4			# 0x4

	lw	$28,32($sp)
$L5637:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6096($2)
	beq	$2,$0,$L5638
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,5			# 0x5

	lw	$28,32($sp)
$L5638:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6100($2)
	beq	$2,$0,$L5639
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,6			# 0x6

	lw	$28,32($sp)
$L5639:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6104($2)
	beq	$2,$0,$L5640
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,7			# 0x7

	lw	$28,32($sp)
$L5640:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6108($2)
	beq	$2,$0,$L5641
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,8			# 0x8

	lw	$28,32($sp)
$L5641:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6112($2)
	beq	$2,$0,$L5642
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,9			# 0x9

	lw	$28,32($sp)
$L5642:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6116($2)
	beq	$2,$0,$L5643
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,10			# 0xa

	lw	$28,32($sp)
$L5643:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6120($2)
	beq	$2,$0,$L5644
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,11			# 0xb

	lw	$28,32($sp)
$L5644:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6124($2)
	beq	$2,$0,$L5645
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,12			# 0xc

	lw	$28,32($sp)
$L5645:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6128($2)
	beq	$2,$0,$L5646
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,13			# 0xd

	lw	$28,32($sp)
$L5646:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6132($2)
	beq	$2,$0,$L5647
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,14			# 0xe

	lw	$28,32($sp)
$L5647:
	li	$2,65536			# 0x10000
	addu	$2,$17,$2
	lw	$2,6136($2)
	beq	$2,$0,$L5534
	lw	$25,%call16(av_log)($28)

	lw	$3,232($2)
	lw	$4,0($17)
	sw	$3,16($sp)
	lw	$3,228($2)
	sw	$3,20($sp)
	lw	$2,0($2)
	lui	$6,%hi($LC16)
	sw	$2,24($sp)
	addiu	$6,$6,%lo($LC16)
	li	$5,2			# 0x2
	jalr	$25
	li	$7,15			# 0xf

	b	$L5534
	lw	$28,32($sp)

$L5779:
	lw	$6,412($4)
	lw	$2,1880($17)
	move	$5,$4
	andi	$6,$6,0x800
$L5536:
	bne	$6,$0,$L5780
	lw	$20,232($2)

$L5621:
	li	$21,131072			# 0x20000
	addu	$21,$17,$21
	lw	$6,6828($21)
	blez	$6,$L5622
	li	$19,65536			# 0x10000

	ori	$19,$19,0x173c
	lui	$22,%hi($LC110)
	addu	$19,$17,$19
	addiu	$22,$22,%lo($LC110)
	b	$L5625
	move	$18,$0

$L5623:
	lw	$2,232($16)
	beq	$20,$2,$L5624
	li	$2,131072			# 0x20000

	lw	$6,6828($21)
	addiu	$18,$18,1
	slt	$2,$18,$6
	beq	$2,$0,$L5622
	addiu	$19,$19,4

$L5625:
	lw	$4,0($17)
	lw	$2,412($4)
	andi	$2,$2,0x800
	beq	$2,$0,$L5623
	lw	$16,0($19)

	lw	$2,232($16)
	lw	$25,%call16(av_log)($28)
	sw	$2,16($sp)
	sw	$16,20($sp)
	li	$5,2			# 0x2
	move	$6,$22
	jalr	$25
	move	$7,$18

	b	$L5623
	lw	$28,32($sp)

$L5763:
	b	$L5680
	sw	$0,80($3)

$L5762:
	lw	$7,136($sp)
	b	$L5679
	sw	$0,0($7)

$L5744:
	li	$2,4			# 0x4
	sw	$2,80($16)
	lw	$25,%call16(av_log)($28)
	lw	$4,0($17)
$L5801:
	lui	$6,%hi($LC113)
	addiu	$6,$6,%lo($LC113)
	jalr	$25
	move	$5,$0

	li	$2,131072			# 0x20000
	addu	$2,$17,$2
	lw	$28,32($sp)
	lw	$6,6828($2)
$L5622:
	bne	$6,$0,$L5781
	li	$4,65536			# 0x10000

$L5630:
	lw	$2,1880($17)
	li	$3,131072			# 0x20000
	sw	$0,240($2)
	addu	$3,$17,$3
	lw	$4,6828($3)
	lw	$5,0($17)
	addiu	$4,$4,1
	sw	$4,6828($3)
	lw	$3,412($5)
	li	$4,65536			# 0x10000
	addu	$4,$17,$4
	sw	$2,5948($4)
	b	$L5620
	andi	$3,$3,0x800

$L5755:
	lw	$7,128($sp)
	lw	$2,716($7)
	slt	$2,$2,8
	beq	$2,$0,$L5518
	move	$2,$0

	lw	$2,6164($17)
	bne	$2,$0,$L5516
	lui	$6,%hi($LC106)

	lw	$25,%call16(av_log)($28)
	move	$4,$7
	addiu	$6,$6,%lo($LC106)
$L5746:
	jalr	$25
	move	$5,$0

	b	$L5518
	li	$2,-1			# 0xffffffffffffffff

$L5759:
	b	$L5654
	move	$9,$0

$L5758:
	li	$12,1			# 0x1
	b	$L5650
	move	$5,$0

$L5766:
	lui	$6,%hi($LC107)
	addiu	$6,$6,%lo($LC107)
	jalr	$25
	li	$5,2			# 0x2

	lw	$5,0($17)
	lw	$28,32($sp)
	lw	$6,412($5)
	lw	$2,1880($17)
	b	$L5536
	andi	$6,$6,0x800

$L5624:
	addu	$2,$17,$2
	lw	$6,6828($2)
	addiu	$3,$18,17870
	sll	$3,$3,2
	addu	$3,$17,$3
	addiu	$6,$6,-1
	sw	$0,4($3)
	beq	$6,$0,$L5626
	sw	$6,6828($2)

	li	$2,65536			# 0x10000
	addiu	$5,$18,1
	ori	$2,$2,0x173c
	addu	$2,$17,$2
	lw	$25,%call16(memmove)($28)
	subu	$6,$6,$18
	sll	$5,$5,2
	sll	$4,$18,2
	addu	$5,$2,$5
	addu	$4,$2,$4
	jalr	$25
	sll	$6,$6,2

	lw	$28,32($sp)
$L5626:
	li	$2,131072			# 0x20000
	addu	$3,$17,$2
	lw	$3,6024($3)
	beq	$3,$16,$L5744
	sw	$0,80($16)

	ori	$2,$2,0x1740
	b	$L5628
	addu	$2,$17,$2

$L5629:
	beq	$3,$16,$L5744
	addiu	$2,$2,4

$L5628:
	lw	$3,0($2)
	bne	$3,$0,$L5629
	lw	$25,%call16(av_log)($28)

	b	$L5801
	lw	$4,0($17)

$L5681:
	lw	$25,%call16(av_log)($28)
	lw	$4,128($sp)
	lui	$6,%hi($LC114)
	addiu	$6,$6,%lo($LC114)
	jalr	$25
	li	$5,2			# 0x2

	b	$L5533
	lw	$28,32($sp)

$L5753:
	lui	$6,%hi($LC103)
	lw	$25,%call16(av_log)($28)
	lw	$4,128($sp)
	b	$L5748
	addiu	$6,$6,%lo($LC103)

$L5781:
	ori	$4,$4,0x173c
	lw	$25,%call16(memmove)($28)
	addu	$4,$17,$4
	move	$5,$4
	sll	$6,$6,2
	jalr	$25
	addiu	$4,$4,4

	b	$L5630
	lw	$28,32($sp)

$L5752:
	lui	$6,%hi($LC102)
	lw	$25,%call16(av_log)($28)
	b	$L5746
	addiu	$6,$6,%lo($LC102)

$L5780:
	li	$2,131072			# 0x20000
	addu	$2,$17,$2
	lw	$2,6828($2)
	lw	$25,%call16(av_log)($28)
	lui	$6,%hi($LC109)
	move	$4,$5
	sw	$2,16($sp)
	addiu	$6,$6,%lo($LC109)
	li	$5,2			# 0x2
	jalr	$25
	move	$7,$20

	b	$L5621
	lw	$28,32($sp)

	.set	macro
	.set	reorder
	.end	decode_frame
	.size	decode_frame, .-decode_frame
	.globl	ff_rem6
	.rdata
	.align	2
	.type	ff_rem6, @object
	.size	ff_rem6, 52
ff_rem6:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.globl	ff_div6
	.align	2
	.type	ff_div6, @object
	.size	ff_div6, 52
ff_div6:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.globl	h264_decoder
	.section	.rodata.str1.4
	.align	2
$LC115:
	.ascii	"h264\000"
	.section	.data.rel.local,"aw",@progbits
	.align	2
	.type	h264_decoder, @object
	.size	h264_decoder, 52
h264_decoder:
	.word	$LC115
	.word	0
	.word	28
	.word	140496
	.word	decode_init
	.word	0
	.word	decode_end
	.word	decode_frame
	.word	42
	.space	4
	.word	flush_dpb
	.space	8
	.globl	svq3_decoder
	.section	.rodata.str1.4
	.align	2
$LC116:
	.ascii	"svq3\000"
	.section	.data.rel.local
	.align	2
	.type	svq3_decoder, @object
	.size	svq3_decoder, 52
svq3_decoder:
	.word	$LC116
	.word	0
	.word	24
	.word	140496
	.word	decode_init
	.word	0
	.word	decode_end
	.word	svq3_decode_frame
	.word	35
	.space	16
	.rdata
	.align	2
	.type	last_coeff_flag_offset_8x8, @object
	.size	last_coeff_flag_offset_8x8, 63
last_coeff_flag_offset_8x8:
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	8
	.align	2
	.type	scan8, @object
	.size	scan8, 24
scan8:
	.byte	12
	.byte	13
	.byte	20
	.byte	21
	.byte	14
	.byte	15
	.byte	22
	.byte	23
	.byte	28
	.byte	29
	.byte	36
	.byte	37
	.byte	30
	.byte	31
	.byte	38
	.byte	39
	.byte	9
	.byte	10
	.byte	17
	.byte	18
	.byte	33
	.byte	34
	.byte	41
	.byte	42
	.align	2
	.type	dequant4_coeff_init, @object
	.size	dequant4_coeff_init, 18
dequant4_coeff_init:
	.byte	10
	.byte	13
	.byte	16
	.byte	11
	.byte	14
	.byte	18
	.byte	13
	.byte	16
	.byte	20
	.byte	14
	.byte	18
	.byte	23
	.byte	16
	.byte	20
	.byte	25
	.byte	18
	.byte	23
	.byte	29
	.align	2
	.type	dequant8_coeff_init_scan, @object
	.size	dequant8_coeff_init_scan, 16
dequant8_coeff_init_scan:
	.byte	0
	.byte	3
	.byte	4
	.byte	3
	.byte	3
	.byte	1
	.byte	5
	.byte	1
	.byte	4
	.byte	5
	.byte	2
	.byte	5
	.byte	3
	.byte	1
	.byte	5
	.byte	1
	.align	2
	.type	dequant8_coeff_init, @object
	.size	dequant8_coeff_init, 36
dequant8_coeff_init:
	.byte	20
	.byte	18
	.byte	32
	.byte	19
	.byte	25
	.byte	24
	.byte	22
	.byte	19
	.byte	35
	.byte	21
	.byte	28
	.byte	26
	.byte	26
	.byte	23
	.byte	42
	.byte	24
	.byte	33
	.byte	31
	.byte	28
	.byte	25
	.byte	45
	.byte	26
	.byte	35
	.byte	33
	.byte	32
	.byte	28
	.byte	51
	.byte	30
	.byte	40
	.byte	38
	.byte	36
	.byte	32
	.byte	58
	.byte	34
	.byte	46
	.byte	43
	.align	2
	.type	golomb_to_pict_type, @object
	.size	golomb_to_pict_type, 5
golomb_to_pict_type:
	.byte	2
	.byte	3
	.byte	1
	.byte	6
	.byte	5
	.align	2
	.type	svq3_pred_0, @object
	.size	svq3_pred_0, 50
svq3_pred_0:
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	2
	.byte	1
	.byte	1
	.byte	2
	.byte	0
	.byte	3
	.byte	0
	.byte	2
	.byte	1
	.byte	1
	.byte	2
	.byte	0
	.byte	3
	.byte	0
	.byte	4
	.byte	1
	.byte	3
	.byte	2
	.byte	2
	.byte	3
	.byte	1
	.byte	4
	.byte	0
	.byte	4
	.byte	1
	.byte	3
	.byte	2
	.byte	2
	.byte	3
	.byte	1
	.byte	4
	.byte	2
	.byte	4
	.byte	3
	.byte	3
	.byte	4
	.byte	2
	.byte	4
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	4
	.align	2
	.type	svq3_pred_1, @object
	.size	svq3_pred_1, 180
svq3_pred_1:
	.byte	2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	2
	.byte	1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	1
	.byte	2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	2
	.byte	1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	1
	.byte	2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	1
	.byte	2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	0
	.byte	2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	0
	.byte	2
	.byte	1
	.byte	4
	.byte	3
	.byte	0
	.byte	1
	.byte	2
	.byte	4
	.byte	3
	.byte	0
	.byte	2
	.byte	1
	.byte	4
	.byte	3
	.byte	2
	.byte	0
	.byte	1
	.byte	3
	.byte	4
	.byte	0
	.byte	4
	.byte	2
	.byte	1
	.byte	3
	.byte	2
	.byte	0
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	2
	.byte	1
	.byte	0
	.byte	4
	.byte	3
	.byte	1
	.byte	2
	.byte	4
	.byte	0
	.byte	3
	.byte	2
	.byte	1
	.byte	0
	.byte	4
	.byte	3
	.byte	2
	.byte	1
	.byte	4
	.byte	3
	.byte	0
	.byte	1
	.byte	2
	.byte	4
	.byte	0
	.byte	3
	.byte	2
	.byte	0
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	2
	.byte	0
	.byte	1
	.byte	4
	.byte	3
	.byte	1
	.byte	2
	.byte	0
	.byte	4
	.byte	3
	.byte	2
	.byte	1
	.byte	0
	.byte	4
	.byte	3
	.byte	2
	.byte	1
	.byte	3
	.byte	4
	.byte	0
	.byte	2
	.byte	4
	.byte	1
	.byte	0
	.byte	3
	.byte	0
	.byte	2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	0
	.byte	2
	.byte	1
	.byte	3
	.byte	4
	.byte	1
	.byte	2
	.byte	3
	.byte	0
	.byte	4
	.byte	2
	.byte	0
	.byte	1
	.byte	3
	.byte	4
	.byte	2
	.byte	1
	.byte	3
	.byte	0
	.byte	4
	.byte	2
	.byte	0
	.byte	4
	.byte	3
	.byte	1
	.byte	0
	.byte	2
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	0
	.byte	2
	.byte	4
	.byte	1
	.byte	3
	.byte	1
	.byte	4
	.byte	2
	.byte	0
	.byte	3
	.byte	4
	.byte	2
	.byte	0
	.byte	1
	.byte	3
	.byte	2
	.byte	0
	.byte	1
	.byte	4
	.byte	3
	.byte	4
	.byte	2
	.byte	1
	.byte	0
	.byte	3
	.align	2
	.type	i_mb_type_info, @object
	.size	i_mb_type_info, 104
i_mb_type_info:
	.half	1
	.byte	-1
	.byte	-1
	.half	2
	.byte	2
	.byte	0
	.half	2
	.byte	1
	.byte	0
	.half	2
	.byte	0
	.byte	0
	.half	2
	.byte	3
	.byte	0
	.half	2
	.byte	2
	.byte	16
	.half	2
	.byte	1
	.byte	16
	.half	2
	.byte	0
	.byte	16
	.half	2
	.byte	3
	.byte	16
	.half	2
	.byte	2
	.byte	32
	.half	2
	.byte	1
	.byte	32
	.half	2
	.byte	0
	.byte	32
	.half	2
	.byte	3
	.byte	32
	.half	2
	.byte	2
	.byte	15
	.half	2
	.byte	1
	.byte	15
	.half	2
	.byte	0
	.byte	15
	.half	2
	.byte	3
	.byte	15
	.half	2
	.byte	2
	.byte	31
	.half	2
	.byte	1
	.byte	31
	.half	2
	.byte	0
	.byte	31
	.half	2
	.byte	3
	.byte	31
	.half	2
	.byte	2
	.byte	47
	.half	2
	.byte	1
	.byte	47
	.half	2
	.byte	0
	.byte	47
	.half	2
	.byte	3
	.byte	47
	.half	4
	.byte	-1
	.byte	-1
	.align	2
	.type	golomb_to_intra4x4_cbp, @object
	.size	golomb_to_intra4x4_cbp, 48
golomb_to_intra4x4_cbp:
	.byte	47
	.byte	31
	.byte	15
	.byte	0
	.byte	23
	.byte	27
	.byte	29
	.byte	30
	.byte	7
	.byte	11
	.byte	13
	.byte	14
	.byte	39
	.byte	43
	.byte	45
	.byte	46
	.byte	16
	.byte	3
	.byte	5
	.byte	10
	.byte	12
	.byte	19
	.byte	21
	.byte	26
	.byte	28
	.byte	35
	.byte	37
	.byte	42
	.byte	44
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	17
	.byte	18
	.byte	20
	.byte	24
	.byte	6
	.byte	9
	.byte	22
	.byte	25
	.byte	32
	.byte	33
	.byte	34
	.byte	36
	.byte	40
	.byte	38
	.byte	41
	.align	2
	.type	golomb_to_inter_cbp, @object
	.size	golomb_to_inter_cbp, 48
golomb_to_inter_cbp:
	.byte	0
	.byte	16
	.byte	1
	.byte	2
	.byte	4
	.byte	8
	.byte	32
	.byte	3
	.byte	5
	.byte	10
	.byte	12
	.byte	15
	.byte	47
	.byte	7
	.byte	11
	.byte	13
	.byte	14
	.byte	6
	.byte	9
	.byte	31
	.byte	35
	.byte	37
	.byte	42
	.byte	44
	.byte	33
	.byte	34
	.byte	36
	.byte	40
	.byte	39
	.byte	43
	.byte	45
	.byte	46
	.byte	17
	.byte	18
	.byte	20
	.byte	24
	.byte	19
	.byte	21
	.byte	26
	.byte	28
	.byte	23
	.byte	27
	.byte	29
	.byte	30
	.byte	22
	.byte	25
	.byte	38
	.byte	41
	.align	2
	.type	left.10291, @object
	.size	left.10291, 12
left.10291:
	.byte	0
	.byte	-1
	.byte	10
	.byte	0
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	0
	.byte	-1
	.byte	11
	.space	2
	.align	2
	.type	top.10290, @object
	.size	top.10290, 12
top.10290:
	.byte	-1
	.byte	0
	.byte	9
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	0
	.space	3
	.align	2
	.type	svq3_dct_tables, @object
	.size	svq3_dct_tables, 64
svq3_dct_tables:
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	0
	.byte	2
	.byte	3
	.byte	1
	.byte	4
	.byte	1
	.byte	5
	.byte	1
	.byte	0
	.byte	3
	.byte	1
	.byte	2
	.byte	2
	.byte	2
	.byte	6
	.byte	1
	.byte	7
	.byte	1
	.byte	8
	.byte	1
	.byte	9
	.byte	1
	.byte	0
	.byte	4
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	0
	.byte	2
	.byte	2
	.byte	1
	.byte	0
	.byte	3
	.byte	0
	.byte	4
	.byte	0
	.byte	5
	.byte	3
	.byte	1
	.byte	4
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	3
	.byte	0
	.byte	6
	.byte	0
	.byte	7
	.byte	0
	.byte	8
	.byte	0
	.byte	9
	.section	.data.rel.ro.local,"aw",@progbits
	.align	2
	.type	scan_patterns.21716, @object
	.size	scan_patterns.21716, 16
scan_patterns.21716:
	.word	luma_dc_zigzag_scan
	.word	zigzag_scan
	.word	svq3_scan
	.word	chroma_dc_scan
	.rdata
	.align	2
	.type	luma_dc_zigzag_scan, @object
	.size	luma_dc_zigzag_scan, 16
luma_dc_zigzag_scan:
	.byte	0
	.byte	16
	.byte	32
	.byte	-128
	.byte	48
	.byte	64
	.byte	80
	.byte	96
	.byte	-112
	.byte	-96
	.byte	-80
	.byte	-64
	.byte	112
	.byte	-48
	.byte	-32
	.byte	-16
	.align	2
	.type	zigzag_scan, @object
	.size	zigzag_scan, 16
zigzag_scan:
	.byte	0
	.byte	1
	.byte	4
	.byte	8
	.byte	5
	.byte	2
	.byte	3
	.byte	6
	.byte	9
	.byte	12
	.byte	13
	.byte	10
	.byte	7
	.byte	11
	.byte	14
	.byte	15
	.align	2
	.type	chroma_dc_scan, @object
	.size	chroma_dc_scan, 4
chroma_dc_scan:
	.byte	0
	.byte	16
	.byte	32
	.byte	48
	.align	2
	.type	left.10340, @object
	.size	left.10340, 7
left.10340:
	.byte	5
	.byte	-1
	.byte	2
	.byte	-1
	.byte	6
	.space	2
	.align	2
	.type	top.10339, @object
	.size	top.10339, 7
top.10339:
	.byte	4
	.byte	1
	.byte	-1
	.byte	-1
	.space	3
	.align	2
	.type	chroma_qp, @object
	.size	chroma_qp, 52
chroma_qp:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.byte	24
	.byte	25
	.byte	26
	.byte	27
	.byte	28
	.byte	29
	.byte	29
	.byte	30
	.byte	31
	.byte	32
	.byte	32
	.byte	33
	.byte	34
	.byte	34
	.byte	35
	.byte	35
	.byte	36
	.byte	36
	.byte	37
	.byte	37
	.byte	37
	.byte	38
	.byte	38
	.byte	38
	.byte	39
	.byte	39
	.byte	39
	.byte	39
	.align	2
	.type	y_offset.11815, @object
	.size	y_offset.11815, 16
y_offset.11815:
	.word	0
	.word	32
	.word	128
	.word	160
	.align	2
	.type	x_offset.11814, @object
	.size	x_offset.11814, 16
x_offset.11814:
	.word	0
	.word	16
	.word	64
	.word	80
	.align	2
	.type	svq3_dequant_coeff, @object
	.size	svq3_dequant_coeff, 128
svq3_dequant_coeff:
	.word	3881
	.word	4351
	.word	4890
	.word	5481
	.word	6154
	.word	6914
	.word	7761
	.word	8718
	.word	9781
	.word	10987
	.word	12339
	.word	13828
	.word	15523
	.word	17435
	.word	19561
	.word	21873
	.word	24552
	.word	27656
	.word	30847
	.word	34870
	.word	38807
	.word	43747
	.word	49103
	.word	54683
	.word	61694
	.word	68745
	.word	77615
	.word	89113
	.word	100253
	.word	109366
	.word	126635
	.word	141533
	.align	2
	.type	y_offset.21450, @object
	.size	y_offset.21450, 16
y_offset.21450:
	.word	0
	.word	32
	.word	128
	.word	160
	.align	2
	.type	x_offset.21449, @object
	.size	x_offset.21449, 16
x_offset.21449:
	.word	0
	.word	16
	.word	64
	.word	80
	.align	2
	.type	nnz_idx.19718, @object
	.size	nnz_idx.19718, 16
nnz_idx.19718:
	.word	4
	.word	5
	.word	6
	.word	3
	.align	2
	.type	ref2frm.19690, @object
	.size	ref2frm.19690, 136
ref2frm.19690:
	.word	-1
	.word	-1
	.word	0
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.word	10
	.word	11
	.word	12
	.word	13
	.word	14
	.word	15
	.word	16
	.word	17
	.word	18
	.word	19
	.word	20
	.word	21
	.word	22
	.word	23
	.word	24
	.word	25
	.word	26
	.word	27
	.word	28
	.word	29
	.word	30
	.word	31
	.align	2
	.type	alpha_table, @object
	.size	alpha_table, 156
alpha_table:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	12
	.byte	13
	.byte	15
	.byte	17
	.byte	20
	.byte	22
	.byte	25
	.byte	28
	.byte	32
	.byte	36
	.byte	40
	.byte	45
	.byte	50
	.byte	56
	.byte	63
	.byte	71
	.byte	80
	.byte	90
	.byte	101
	.byte	113
	.byte	127
	.byte	-112
	.byte	-94
	.byte	-74
	.byte	-53
	.byte	-30
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.align	2
	.type	beta_table, @object
	.size	beta_table, 156
beta_table:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	4
	.byte	6
	.byte	6
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	9
	.byte	9
	.byte	10
	.byte	10
	.byte	11
	.byte	11
	.byte	12
	.byte	12
	.byte	13
	.byte	13
	.byte	14
	.byte	14
	.byte	15
	.byte	15
	.byte	16
	.byte	16
	.byte	17
	.byte	17
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.align	2
	.type	tc0_table, @object
	.size	tc0_table, 468
tc0_table:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	2
	.byte	3
	.byte	1
	.byte	2
	.byte	3
	.byte	2
	.byte	2
	.byte	3
	.byte	2
	.byte	2
	.byte	4
	.byte	2
	.byte	3
	.byte	4
	.byte	2
	.byte	3
	.byte	4
	.byte	3
	.byte	3
	.byte	5
	.byte	3
	.byte	4
	.byte	6
	.byte	3
	.byte	4
	.byte	6
	.byte	4
	.byte	5
	.byte	7
	.byte	4
	.byte	5
	.byte	8
	.byte	4
	.byte	6
	.byte	9
	.byte	5
	.byte	7
	.byte	10
	.byte	6
	.byte	8
	.byte	11
	.byte	6
	.byte	8
	.byte	13
	.byte	7
	.byte	10
	.byte	14
	.byte	8
	.byte	11
	.byte	16
	.byte	9
	.byte	12
	.byte	18
	.byte	10
	.byte	13
	.byte	20
	.byte	11
	.byte	15
	.byte	23
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.byte	13
	.byte	17
	.byte	25
	.align	2
	.type	C.680.19517, @object
	.size	C.680.19517, 8
C.680.19517:
	.half	3
	.half	3
	.half	3
	.half	3
	.align	2
	.type	C.679.19516, @object
	.size	C.679.19516, 8
C.679.19516:
	.half	4
	.half	4
	.half	4
	.half	4
	.align	2
	.type	slice_type_map.15291, @object
	.size	slice_type_map.15291, 5
slice_type_map.15291:
	.byte	2
	.byte	3
	.byte	1
	.byte	6
	.byte	5
	.align	2
	.type	field_scan, @object
	.size	field_scan, 16
field_scan:
	.byte	0
	.byte	4
	.byte	1
	.byte	8
	.byte	12
	.byte	5
	.byte	9
	.byte	13
	.byte	2
	.byte	6
	.byte	10
	.byte	14
	.byte	3
	.byte	7
	.byte	11
	.byte	15
	.align	2
	.type	zigzag_scan8x8, @object
	.size	zigzag_scan8x8, 64
zigzag_scan8x8:
	.byte	0
	.byte	1
	.byte	8
	.byte	16
	.byte	9
	.byte	2
	.byte	3
	.byte	10
	.byte	17
	.byte	24
	.byte	32
	.byte	25
	.byte	18
	.byte	11
	.byte	4
	.byte	5
	.byte	12
	.byte	19
	.byte	26
	.byte	33
	.byte	40
	.byte	48
	.byte	41
	.byte	34
	.byte	27
	.byte	20
	.byte	13
	.byte	6
	.byte	7
	.byte	14
	.byte	21
	.byte	28
	.byte	35
	.byte	42
	.byte	49
	.byte	56
	.byte	57
	.byte	50
	.byte	43
	.byte	36
	.byte	29
	.byte	22
	.byte	15
	.byte	23
	.byte	30
	.byte	37
	.byte	44
	.byte	51
	.byte	58
	.byte	59
	.byte	52
	.byte	45
	.byte	38
	.byte	31
	.byte	39
	.byte	46
	.byte	53
	.byte	60
	.byte	61
	.byte	54
	.byte	47
	.byte	55
	.byte	62
	.byte	63
	.align	2
	.type	zigzag_scan8x8_cavlc, @object
	.size	zigzag_scan8x8_cavlc, 64
zigzag_scan8x8_cavlc:
	.byte	0
	.byte	9
	.byte	17
	.byte	18
	.byte	12
	.byte	40
	.byte	27
	.byte	7
	.byte	35
	.byte	57
	.byte	29
	.byte	30
	.byte	58
	.byte	38
	.byte	53
	.byte	47
	.byte	1
	.byte	2
	.byte	24
	.byte	11
	.byte	19
	.byte	48
	.byte	20
	.byte	14
	.byte	42
	.byte	50
	.byte	22
	.byte	37
	.byte	59
	.byte	31
	.byte	60
	.byte	55
	.byte	8
	.byte	3
	.byte	32
	.byte	4
	.byte	26
	.byte	41
	.byte	13
	.byte	21
	.byte	49
	.byte	43
	.byte	15
	.byte	44
	.byte	52
	.byte	39
	.byte	61
	.byte	62
	.byte	16
	.byte	10
	.byte	25
	.byte	5
	.byte	33
	.byte	34
	.byte	6
	.byte	28
	.byte	56
	.byte	36
	.byte	23
	.byte	51
	.byte	45
	.byte	46
	.byte	54
	.byte	63
	.align	2
	.type	field_scan8x8, @object
	.size	field_scan8x8, 64
field_scan8x8:
	.byte	0
	.byte	8
	.byte	16
	.byte	1
	.byte	9
	.byte	24
	.byte	32
	.byte	17
	.byte	2
	.byte	25
	.byte	40
	.byte	48
	.byte	56
	.byte	33
	.byte	10
	.byte	3
	.byte	18
	.byte	41
	.byte	49
	.byte	57
	.byte	26
	.byte	11
	.byte	4
	.byte	19
	.byte	34
	.byte	42
	.byte	50
	.byte	58
	.byte	27
	.byte	12
	.byte	5
	.byte	20
	.byte	35
	.byte	43
	.byte	51
	.byte	59
	.byte	28
	.byte	13
	.byte	6
	.byte	21
	.byte	36
	.byte	44
	.byte	52
	.byte	60
	.byte	29
	.byte	14
	.byte	22
	.byte	37
	.byte	45
	.byte	53
	.byte	61
	.byte	30
	.byte	7
	.byte	15
	.byte	38
	.byte	46
	.byte	54
	.byte	62
	.byte	23
	.byte	31
	.byte	39
	.byte	47
	.byte	55
	.byte	63
	.align	2
	.type	field_scan8x8_cavlc, @object
	.size	field_scan8x8_cavlc, 64
field_scan8x8_cavlc:
	.byte	0
	.byte	9
	.byte	2
	.byte	56
	.byte	18
	.byte	26
	.byte	34
	.byte	27
	.byte	35
	.byte	28
	.byte	36
	.byte	29
	.byte	45
	.byte	7
	.byte	54
	.byte	39
	.byte	8
	.byte	24
	.byte	25
	.byte	33
	.byte	41
	.byte	11
	.byte	42
	.byte	12
	.byte	43
	.byte	13
	.byte	44
	.byte	14
	.byte	53
	.byte	15
	.byte	62
	.byte	47
	.byte	16
	.byte	32
	.byte	40
	.byte	10
	.byte	49
	.byte	4
	.byte	50
	.byte	5
	.byte	51
	.byte	6
	.byte	52
	.byte	22
	.byte	61
	.byte	38
	.byte	23
	.byte	55
	.byte	1
	.byte	17
	.byte	48
	.byte	3
	.byte	57
	.byte	19
	.byte	58
	.byte	20
	.byte	59
	.byte	21
	.byte	60
	.byte	37
	.byte	30
	.byte	46
	.byte	31
	.byte	63
	.align	2
	.type	default_scaling4, @object
	.size	default_scaling4, 32
default_scaling4:
	.byte	6
	.byte	13
	.byte	20
	.byte	28
	.byte	13
	.byte	20
	.byte	28
	.byte	32
	.byte	20
	.byte	28
	.byte	32
	.byte	37
	.byte	28
	.byte	32
	.byte	37
	.byte	42
	.byte	10
	.byte	14
	.byte	20
	.byte	24
	.byte	14
	.byte	20
	.byte	24
	.byte	27
	.byte	20
	.byte	24
	.byte	27
	.byte	30
	.byte	24
	.byte	27
	.byte	30
	.byte	34
	.align	2
	.type	default_scaling8, @object
	.size	default_scaling8, 128
default_scaling8:
	.byte	6
	.byte	10
	.byte	13
	.byte	16
	.byte	18
	.byte	23
	.byte	25
	.byte	27
	.byte	10
	.byte	11
	.byte	16
	.byte	18
	.byte	23
	.byte	25
	.byte	27
	.byte	29
	.byte	13
	.byte	16
	.byte	18
	.byte	23
	.byte	25
	.byte	27
	.byte	29
	.byte	31
	.byte	16
	.byte	18
	.byte	23
	.byte	25
	.byte	27
	.byte	29
	.byte	31
	.byte	33
	.byte	18
	.byte	23
	.byte	25
	.byte	27
	.byte	29
	.byte	31
	.byte	33
	.byte	36
	.byte	23
	.byte	25
	.byte	27
	.byte	29
	.byte	31
	.byte	33
	.byte	36
	.byte	38
	.byte	25
	.byte	27
	.byte	29
	.byte	31
	.byte	33
	.byte	36
	.byte	38
	.byte	40
	.byte	27
	.byte	29
	.byte	31
	.byte	33
	.byte	36
	.byte	38
	.byte	40
	.byte	42
	.byte	9
	.byte	13
	.byte	15
	.byte	17
	.byte	19
	.byte	21
	.byte	22
	.byte	24
	.byte	13
	.byte	13
	.byte	17
	.byte	19
	.byte	21
	.byte	22
	.byte	24
	.byte	25
	.byte	15
	.byte	17
	.byte	19
	.byte	21
	.byte	22
	.byte	24
	.byte	25
	.byte	27
	.byte	17
	.byte	19
	.byte	21
	.byte	22
	.byte	24
	.byte	25
	.byte	27
	.byte	28
	.byte	19
	.byte	21
	.byte	22
	.byte	24
	.byte	25
	.byte	27
	.byte	28
	.byte	30
	.byte	21
	.byte	22
	.byte	24
	.byte	25
	.byte	27
	.byte	28
	.byte	30
	.byte	32
	.byte	22
	.byte	24
	.byte	25
	.byte	27
	.byte	28
	.byte	30
	.byte	32
	.byte	33
	.byte	24
	.byte	25
	.byte	27
	.byte	28
	.byte	30
	.byte	32
	.byte	33
	.byte	35
	.align	2
	.type	pixel_aspect, @object
	.size	pixel_aspect, 112
pixel_aspect:
	.word	0
	.word	1
	.word	1
	.word	1
	.word	12
	.word	11
	.word	10
	.word	11
	.word	16
	.word	11
	.word	40
	.word	33
	.word	24
	.word	11
	.word	20
	.word	11
	.word	32
	.word	11
	.word	80
	.word	33
	.word	18
	.word	11
	.word	15
	.word	11
	.word	64
	.word	33
	.word	160
	.word	99
	.align	2
	.type	cabac_context_init_I, @object
	.size	cabac_context_init_I, 920
cabac_context_init_I:
	.byte	20
	.byte	-15
	.byte	2
	.byte	54
	.byte	3
	.byte	74
	.byte	20
	.byte	-15
	.byte	2
	.byte	54
	.byte	3
	.byte	74
	.byte	-28
	.byte	127
	.byte	-23
	.byte	104
	.byte	-6
	.byte	53
	.byte	-1
	.byte	54
	.byte	7
	.byte	51
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	41
	.byte	0
	.byte	63
	.byte	0
	.byte	63
	.byte	0
	.byte	63
	.byte	-9
	.byte	83
	.byte	4
	.byte	86
	.byte	0
	.byte	97
	.byte	-7
	.byte	72
	.byte	13
	.byte	41
	.byte	3
	.byte	62
	.byte	0
	.byte	11
	.byte	1
	.byte	55
	.byte	0
	.byte	69
	.byte	-17
	.byte	127
	.byte	-13
	.byte	102
	.byte	0
	.byte	82
	.byte	-7
	.byte	74
	.byte	-21
	.byte	107
	.byte	-27
	.byte	127
	.byte	-31
	.byte	127
	.byte	-24
	.byte	127
	.byte	-18
	.byte	95
	.byte	-27
	.byte	127
	.byte	-21
	.byte	114
	.byte	-30
	.byte	127
	.byte	-17
	.byte	123
	.byte	-12
	.byte	115
	.byte	-16
	.byte	122
	.byte	-11
	.byte	115
	.byte	-12
	.byte	63
	.byte	-2
	.byte	68
	.byte	-15
	.byte	84
	.byte	-13
	.byte	104
	.byte	-3
	.byte	70
	.byte	-8
	.byte	93
	.byte	-10
	.byte	90
	.byte	-30
	.byte	127
	.byte	-1
	.byte	74
	.byte	-6
	.byte	97
	.byte	-7
	.byte	91
	.byte	-20
	.byte	127
	.byte	-4
	.byte	56
	.byte	-5
	.byte	82
	.byte	-7
	.byte	76
	.byte	-22
	.byte	125
	.byte	-7
	.byte	93
	.byte	-11
	.byte	87
	.byte	-3
	.byte	77
	.byte	-5
	.byte	71
	.byte	-4
	.byte	63
	.byte	-4
	.byte	68
	.byte	-12
	.byte	84
	.byte	-7
	.byte	62
	.byte	-7
	.byte	65
	.byte	8
	.byte	61
	.byte	5
	.byte	56
	.byte	-2
	.byte	66
	.byte	1
	.byte	64
	.byte	0
	.byte	61
	.byte	-2
	.byte	78
	.byte	1
	.byte	50
	.byte	7
	.byte	52
	.byte	10
	.byte	35
	.byte	0
	.byte	44
	.byte	11
	.byte	38
	.byte	1
	.byte	45
	.byte	0
	.byte	46
	.byte	5
	.byte	44
	.byte	31
	.byte	17
	.byte	1
	.byte	51
	.byte	7
	.byte	50
	.byte	28
	.byte	19
	.byte	16
	.byte	33
	.byte	14
	.byte	62
	.byte	-13
	.byte	108
	.byte	-15
	.byte	100
	.byte	-13
	.byte	101
	.byte	-13
	.byte	91
	.byte	-12
	.byte	94
	.byte	-10
	.byte	88
	.byte	-16
	.byte	84
	.byte	-10
	.byte	86
	.byte	-7
	.byte	83
	.byte	-13
	.byte	87
	.byte	-19
	.byte	94
	.byte	1
	.byte	70
	.byte	0
	.byte	72
	.byte	-5
	.byte	74
	.byte	18
	.byte	59
	.byte	-8
	.byte	102
	.byte	-15
	.byte	100
	.byte	0
	.byte	95
	.byte	-4
	.byte	75
	.byte	2
	.byte	72
	.byte	-11
	.byte	75
	.byte	-3
	.byte	71
	.byte	15
	.byte	46
	.byte	-13
	.byte	69
	.byte	0
	.byte	62
	.byte	0
	.byte	65
	.byte	21
	.byte	37
	.byte	-15
	.byte	72
	.byte	9
	.byte	57
	.byte	16
	.byte	54
	.byte	0
	.byte	62
	.byte	12
	.byte	72
	.byte	24
	.byte	0
	.byte	15
	.byte	9
	.byte	8
	.byte	25
	.byte	13
	.byte	18
	.byte	15
	.byte	9
	.byte	13
	.byte	19
	.byte	10
	.byte	37
	.byte	12
	.byte	18
	.byte	6
	.byte	29
	.byte	20
	.byte	33
	.byte	15
	.byte	30
	.byte	4
	.byte	45
	.byte	1
	.byte	58
	.byte	0
	.byte	62
	.byte	7
	.byte	61
	.byte	12
	.byte	38
	.byte	11
	.byte	45
	.byte	15
	.byte	39
	.byte	11
	.byte	42
	.byte	13
	.byte	44
	.byte	16
	.byte	45
	.byte	12
	.byte	41
	.byte	10
	.byte	49
	.byte	30
	.byte	34
	.byte	18
	.byte	42
	.byte	10
	.byte	55
	.byte	17
	.byte	51
	.byte	17
	.byte	46
	.byte	0
	.byte	89
	.byte	26
	.byte	-19
	.byte	22
	.byte	-17
	.byte	26
	.byte	-17
	.byte	30
	.byte	-25
	.byte	28
	.byte	-20
	.byte	33
	.byte	-23
	.byte	37
	.byte	-27
	.byte	33
	.byte	-23
	.byte	40
	.byte	-28
	.byte	38
	.byte	-17
	.byte	33
	.byte	-11
	.byte	40
	.byte	-15
	.byte	41
	.byte	-6
	.byte	38
	.byte	1
	.byte	41
	.byte	17
	.byte	30
	.byte	-6
	.byte	27
	.byte	3
	.byte	26
	.byte	22
	.byte	37
	.byte	-16
	.byte	35
	.byte	-4
	.byte	38
	.byte	-8
	.byte	38
	.byte	-3
	.byte	37
	.byte	3
	.byte	38
	.byte	5
	.byte	42
	.byte	0
	.byte	35
	.byte	16
	.byte	39
	.byte	22
	.byte	14
	.byte	48
	.byte	27
	.byte	37
	.byte	21
	.byte	60
	.byte	12
	.byte	68
	.byte	2
	.byte	97
	.byte	-3
	.byte	71
	.byte	-6
	.byte	42
	.byte	-5
	.byte	50
	.byte	-3
	.byte	54
	.byte	-2
	.byte	62
	.byte	0
	.byte	58
	.byte	1
	.byte	63
	.byte	-2
	.byte	72
	.byte	-1
	.byte	74
	.byte	-9
	.byte	91
	.byte	-5
	.byte	67
	.byte	-5
	.byte	27
	.byte	-3
	.byte	39
	.byte	-2
	.byte	44
	.byte	0
	.byte	46
	.byte	-16
	.byte	64
	.byte	-8
	.byte	68
	.byte	-10
	.byte	78
	.byte	-6
	.byte	77
	.byte	-10
	.byte	86
	.byte	-12
	.byte	92
	.byte	-15
	.byte	55
	.byte	-10
	.byte	60
	.byte	-6
	.byte	62
	.byte	-4
	.byte	65
	.byte	-12
	.byte	73
	.byte	-8
	.byte	76
	.byte	-7
	.byte	80
	.byte	-9
	.byte	88
	.byte	-17
	.byte	110
	.byte	-11
	.byte	97
	.byte	-20
	.byte	84
	.byte	-11
	.byte	79
	.byte	-6
	.byte	73
	.byte	-4
	.byte	74
	.byte	-13
	.byte	86
	.byte	-13
	.byte	96
	.byte	-11
	.byte	97
	.byte	-19
	.byte	117
	.byte	-8
	.byte	78
	.byte	-5
	.byte	33
	.byte	-4
	.byte	48
	.byte	-2
	.byte	53
	.byte	-3
	.byte	62
	.byte	-13
	.byte	71
	.byte	-10
	.byte	79
	.byte	-12
	.byte	86
	.byte	-13
	.byte	90
	.byte	-14
	.byte	97
	.byte	0
	.byte	0
	.byte	-6
	.byte	93
	.byte	-6
	.byte	84
	.byte	-8
	.byte	79
	.byte	0
	.byte	66
	.byte	-1
	.byte	71
	.byte	0
	.byte	62
	.byte	-2
	.byte	60
	.byte	-2
	.byte	59
	.byte	-5
	.byte	75
	.byte	-3
	.byte	62
	.byte	-4
	.byte	58
	.byte	-9
	.byte	66
	.byte	-1
	.byte	79
	.byte	0
	.byte	71
	.byte	3
	.byte	68
	.byte	10
	.byte	44
	.byte	-7
	.byte	62
	.byte	15
	.byte	36
	.byte	14
	.byte	40
	.byte	16
	.byte	27
	.byte	12
	.byte	29
	.byte	1
	.byte	44
	.byte	20
	.byte	36
	.byte	18
	.byte	32
	.byte	5
	.byte	42
	.byte	1
	.byte	48
	.byte	10
	.byte	62
	.byte	17
	.byte	46
	.byte	9
	.byte	64
	.byte	-12
	.byte	104
	.byte	-11
	.byte	97
	.byte	-16
	.byte	96
	.byte	-7
	.byte	88
	.byte	-8
	.byte	85
	.byte	-7
	.byte	85
	.byte	-9
	.byte	85
	.byte	-13
	.byte	88
	.byte	4
	.byte	66
	.byte	-3
	.byte	77
	.byte	-3
	.byte	76
	.byte	-6
	.byte	76
	.byte	10
	.byte	58
	.byte	-1
	.byte	76
	.byte	-1
	.byte	83
	.byte	-7
	.byte	99
	.byte	-14
	.byte	95
	.byte	2
	.byte	95
	.byte	0
	.byte	76
	.byte	-5
	.byte	74
	.byte	0
	.byte	70
	.byte	-11
	.byte	75
	.byte	1
	.byte	68
	.byte	0
	.byte	65
	.byte	-14
	.byte	73
	.byte	3
	.byte	62
	.byte	4
	.byte	62
	.byte	-1
	.byte	68
	.byte	-13
	.byte	75
	.byte	11
	.byte	55
	.byte	5
	.byte	64
	.byte	12
	.byte	70
	.byte	15
	.byte	6
	.byte	6
	.byte	19
	.byte	7
	.byte	16
	.byte	12
	.byte	14
	.byte	18
	.byte	13
	.byte	13
	.byte	11
	.byte	13
	.byte	15
	.byte	15
	.byte	16
	.byte	12
	.byte	23
	.byte	13
	.byte	23
	.byte	15
	.byte	20
	.byte	14
	.byte	26
	.byte	14
	.byte	44
	.byte	17
	.byte	40
	.byte	17
	.byte	47
	.byte	24
	.byte	17
	.byte	21
	.byte	21
	.byte	25
	.byte	22
	.byte	31
	.byte	27
	.byte	22
	.byte	29
	.byte	19
	.byte	35
	.byte	14
	.byte	50
	.byte	10
	.byte	57
	.byte	7
	.byte	63
	.byte	-2
	.byte	77
	.byte	-4
	.byte	82
	.byte	-3
	.byte	94
	.byte	9
	.byte	69
	.byte	-12
	.byte	109
	.byte	36
	.byte	-35
	.byte	36
	.byte	-34
	.byte	32
	.byte	-26
	.byte	37
	.byte	-30
	.byte	44
	.byte	-32
	.byte	34
	.byte	-18
	.byte	34
	.byte	-15
	.byte	40
	.byte	-15
	.byte	33
	.byte	-7
	.byte	35
	.byte	-5
	.byte	33
	.byte	0
	.byte	38
	.byte	2
	.byte	33
	.byte	13
	.byte	23
	.byte	35
	.byte	13
	.byte	58
	.byte	29
	.byte	-3
	.byte	26
	.byte	0
	.byte	22
	.byte	30
	.byte	31
	.byte	-7
	.byte	35
	.byte	-15
	.byte	34
	.byte	-3
	.byte	34
	.byte	3
	.byte	36
	.byte	-1
	.byte	34
	.byte	5
	.byte	32
	.byte	11
	.byte	35
	.byte	5
	.byte	34
	.byte	12
	.byte	39
	.byte	11
	.byte	30
	.byte	29
	.byte	34
	.byte	26
	.byte	29
	.byte	39
	.byte	19
	.byte	66
	.byte	31
	.byte	21
	.byte	31
	.byte	31
	.byte	25
	.byte	50
	.byte	-17
	.byte	120
	.byte	-20
	.byte	112
	.byte	-18
	.byte	114
	.byte	-11
	.byte	85
	.byte	-15
	.byte	92
	.byte	-14
	.byte	89
	.byte	-26
	.byte	71
	.byte	-15
	.byte	81
	.byte	-14
	.byte	80
	.byte	0
	.byte	68
	.byte	-14
	.byte	70
	.byte	-24
	.byte	56
	.byte	-23
	.byte	68
	.byte	-24
	.byte	50
	.byte	-11
	.byte	74
	.byte	23
	.byte	-13
	.byte	26
	.byte	-13
	.byte	40
	.byte	-15
	.byte	49
	.byte	-14
	.byte	44
	.byte	3
	.byte	45
	.byte	6
	.byte	44
	.byte	34
	.byte	33
	.byte	54
	.byte	19
	.byte	82
	.byte	-3
	.byte	75
	.byte	-1
	.byte	23
	.byte	1
	.byte	34
	.byte	1
	.byte	43
	.byte	0
	.byte	54
	.byte	-2
	.byte	55
	.byte	0
	.byte	61
	.byte	1
	.byte	64
	.byte	0
	.byte	68
	.byte	-9
	.byte	92
	.byte	-14
	.byte	106
	.byte	-13
	.byte	97
	.byte	-15
	.byte	90
	.byte	-12
	.byte	90
	.byte	-18
	.byte	88
	.byte	-10
	.byte	73
	.byte	-9
	.byte	79
	.byte	-14
	.byte	86
	.byte	-10
	.byte	73
	.byte	-10
	.byte	70
	.byte	-10
	.byte	69
	.byte	-5
	.byte	66
	.byte	-9
	.byte	64
	.byte	-5
	.byte	58
	.byte	2
	.byte	59
	.byte	21
	.byte	-10
	.byte	24
	.byte	-11
	.byte	28
	.byte	-8
	.byte	28
	.byte	-1
	.byte	29
	.byte	3
	.byte	29
	.byte	9
	.byte	35
	.byte	20
	.byte	29
	.byte	36
	.byte	14
	.byte	67
	.align	2
	.type	cabac_context_init_PB, @object
	.size	cabac_context_init_PB, 2760
cabac_context_init_PB:
	.byte	20
	.byte	-15
	.byte	2
	.byte	54
	.byte	3
	.byte	74
	.byte	20
	.byte	-15
	.byte	2
	.byte	54
	.byte	3
	.byte	74
	.byte	-28
	.byte	127
	.byte	-23
	.byte	104
	.byte	-6
	.byte	53
	.byte	-1
	.byte	54
	.byte	7
	.byte	51
	.byte	23
	.byte	33
	.byte	23
	.byte	2
	.byte	21
	.byte	0
	.byte	1
	.byte	9
	.byte	0
	.byte	49
	.byte	-37
	.byte	118
	.byte	5
	.byte	57
	.byte	-13
	.byte	78
	.byte	-11
	.byte	65
	.byte	1
	.byte	62
	.byte	12
	.byte	49
	.byte	-4
	.byte	73
	.byte	17
	.byte	50
	.byte	18
	.byte	64
	.byte	9
	.byte	43
	.byte	29
	.byte	0
	.byte	26
	.byte	67
	.byte	16
	.byte	90
	.byte	9
	.byte	104
	.byte	-46
	.byte	127
	.byte	-20
	.byte	104
	.byte	1
	.byte	67
	.byte	-13
	.byte	78
	.byte	-11
	.byte	65
	.byte	1
	.byte	62
	.byte	-6
	.byte	86
	.byte	-17
	.byte	95
	.byte	-6
	.byte	61
	.byte	9
	.byte	45
	.byte	-3
	.byte	69
	.byte	-6
	.byte	81
	.byte	-11
	.byte	96
	.byte	6
	.byte	55
	.byte	7
	.byte	67
	.byte	-5
	.byte	86
	.byte	2
	.byte	88
	.byte	0
	.byte	58
	.byte	-3
	.byte	76
	.byte	-10
	.byte	94
	.byte	5
	.byte	54
	.byte	4
	.byte	69
	.byte	-3
	.byte	81
	.byte	0
	.byte	88
	.byte	-7
	.byte	67
	.byte	-5
	.byte	74
	.byte	-4
	.byte	74
	.byte	-5
	.byte	80
	.byte	-7
	.byte	72
	.byte	1
	.byte	58
	.byte	0
	.byte	41
	.byte	0
	.byte	63
	.byte	0
	.byte	63
	.byte	0
	.byte	63
	.byte	-9
	.byte	83
	.byte	4
	.byte	86
	.byte	0
	.byte	97
	.byte	-7
	.byte	72
	.byte	13
	.byte	41
	.byte	3
	.byte	62
	.byte	0
	.byte	45
	.byte	-4
	.byte	78
	.byte	-3
	.byte	96
	.byte	-27
	.byte	126
	.byte	-28
	.byte	98
	.byte	-25
	.byte	101
	.byte	-23
	.byte	67
	.byte	-28
	.byte	82
	.byte	-20
	.byte	94
	.byte	-16
	.byte	83
	.byte	-22
	.byte	110
	.byte	-21
	.byte	91
	.byte	-18
	.byte	102
	.byte	-13
	.byte	93
	.byte	-29
	.byte	127
	.byte	-7
	.byte	92
	.byte	-5
	.byte	89
	.byte	-7
	.byte	96
	.byte	-13
	.byte	108
	.byte	-3
	.byte	46
	.byte	-1
	.byte	65
	.byte	-1
	.byte	57
	.byte	-9
	.byte	93
	.byte	-3
	.byte	74
	.byte	-9
	.byte	92
	.byte	-8
	.byte	87
	.byte	-23
	.byte	126
	.byte	5
	.byte	54
	.byte	6
	.byte	60
	.byte	6
	.byte	59
	.byte	6
	.byte	69
	.byte	-1
	.byte	48
	.byte	0
	.byte	68
	.byte	-4
	.byte	69
	.byte	-8
	.byte	88
	.byte	-2
	.byte	85
	.byte	-6
	.byte	78
	.byte	-1
	.byte	75
	.byte	-7
	.byte	77
	.byte	2
	.byte	54
	.byte	5
	.byte	50
	.byte	-3
	.byte	68
	.byte	1
	.byte	50
	.byte	6
	.byte	42
	.byte	-4
	.byte	81
	.byte	1
	.byte	63
	.byte	-4
	.byte	70
	.byte	0
	.byte	67
	.byte	2
	.byte	57
	.byte	-2
	.byte	76
	.byte	11
	.byte	35
	.byte	4
	.byte	64
	.byte	1
	.byte	61
	.byte	11
	.byte	35
	.byte	18
	.byte	25
	.byte	12
	.byte	24
	.byte	13
	.byte	29
	.byte	13
	.byte	36
	.byte	-10
	.byte	93
	.byte	-7
	.byte	73
	.byte	-2
	.byte	73
	.byte	13
	.byte	46
	.byte	9
	.byte	49
	.byte	-7
	.byte	100
	.byte	9
	.byte	53
	.byte	2
	.byte	53
	.byte	5
	.byte	53
	.byte	-2
	.byte	61
	.byte	0
	.byte	56
	.byte	0
	.byte	56
	.byte	-13
	.byte	63
	.byte	-5
	.byte	60
	.byte	-1
	.byte	62
	.byte	4
	.byte	57
	.byte	-6
	.byte	69
	.byte	4
	.byte	57
	.byte	14
	.byte	39
	.byte	4
	.byte	51
	.byte	13
	.byte	68
	.byte	3
	.byte	64
	.byte	1
	.byte	61
	.byte	9
	.byte	63
	.byte	7
	.byte	50
	.byte	16
	.byte	39
	.byte	5
	.byte	44
	.byte	4
	.byte	52
	.byte	11
	.byte	48
	.byte	-5
	.byte	60
	.byte	-1
	.byte	59
	.byte	0
	.byte	59
	.byte	22
	.byte	33
	.byte	5
	.byte	44
	.byte	14
	.byte	43
	.byte	-1
	.byte	78
	.byte	0
	.byte	60
	.byte	9
	.byte	69
	.byte	11
	.byte	28
	.byte	2
	.byte	40
	.byte	3
	.byte	44
	.byte	0
	.byte	49
	.byte	0
	.byte	46
	.byte	2
	.byte	44
	.byte	2
	.byte	51
	.byte	0
	.byte	47
	.byte	4
	.byte	39
	.byte	2
	.byte	62
	.byte	6
	.byte	46
	.byte	0
	.byte	54
	.byte	3
	.byte	54
	.byte	2
	.byte	58
	.byte	4
	.byte	63
	.byte	6
	.byte	51
	.byte	6
	.byte	57
	.byte	7
	.byte	53
	.byte	6
	.byte	52
	.byte	6
	.byte	55
	.byte	11
	.byte	45
	.byte	14
	.byte	36
	.byte	8
	.byte	53
	.byte	-1
	.byte	82
	.byte	7
	.byte	55
	.byte	-3
	.byte	78
	.byte	15
	.byte	46
	.byte	22
	.byte	31
	.byte	-1
	.byte	84
	.byte	25
	.byte	7
	.byte	30
	.byte	-7
	.byte	28
	.byte	3
	.byte	28
	.byte	4
	.byte	32
	.byte	0
	.byte	34
	.byte	-1
	.byte	30
	.byte	6
	.byte	30
	.byte	6
	.byte	32
	.byte	9
	.byte	31
	.byte	19
	.byte	26
	.byte	27
	.byte	26
	.byte	30
	.byte	37
	.byte	20
	.byte	28
	.byte	34
	.byte	17
	.byte	70
	.byte	1
	.byte	67
	.byte	5
	.byte	59
	.byte	9
	.byte	67
	.byte	16
	.byte	30
	.byte	18
	.byte	32
	.byte	18
	.byte	35
	.byte	22
	.byte	29
	.byte	24
	.byte	31
	.byte	23
	.byte	38
	.byte	18
	.byte	43
	.byte	20
	.byte	41
	.byte	11
	.byte	63
	.byte	9
	.byte	59
	.byte	9
	.byte	64
	.byte	-1
	.byte	94
	.byte	-2
	.byte	89
	.byte	-9
	.byte	108
	.byte	-6
	.byte	76
	.byte	-2
	.byte	44
	.byte	0
	.byte	45
	.byte	0
	.byte	52
	.byte	-3
	.byte	64
	.byte	-2
	.byte	59
	.byte	-4
	.byte	70
	.byte	-4
	.byte	75
	.byte	-8
	.byte	82
	.byte	-17
	.byte	102
	.byte	-9
	.byte	77
	.byte	3
	.byte	24
	.byte	0
	.byte	42
	.byte	0
	.byte	48
	.byte	0
	.byte	55
	.byte	-6
	.byte	59
	.byte	-7
	.byte	71
	.byte	-12
	.byte	83
	.byte	-11
	.byte	87
	.byte	-30
	.byte	119
	.byte	1
	.byte	58
	.byte	-3
	.byte	29
	.byte	-1
	.byte	36
	.byte	1
	.byte	38
	.byte	2
	.byte	43
	.byte	-6
	.byte	55
	.byte	0
	.byte	58
	.byte	0
	.byte	64
	.byte	-3
	.byte	74
	.byte	-10
	.byte	90
	.byte	0
	.byte	70
	.byte	-4
	.byte	29
	.byte	5
	.byte	31
	.byte	7
	.byte	42
	.byte	1
	.byte	59
	.byte	-2
	.byte	58
	.byte	-3
	.byte	72
	.byte	-3
	.byte	81
	.byte	-11
	.byte	97
	.byte	0
	.byte	58
	.byte	8
	.byte	5
	.byte	10
	.byte	14
	.byte	14
	.byte	18
	.byte	13
	.byte	27
	.byte	2
	.byte	40
	.byte	0
	.byte	58
	.byte	-3
	.byte	70
	.byte	-6
	.byte	79
	.byte	-8
	.byte	85
	.byte	0
	.byte	0
	.byte	-13
	.byte	106
	.byte	-16
	.byte	106
	.byte	-10
	.byte	87
	.byte	-21
	.byte	114
	.byte	-18
	.byte	110
	.byte	-14
	.byte	98
	.byte	-22
	.byte	110
	.byte	-21
	.byte	106
	.byte	-18
	.byte	103
	.byte	-21
	.byte	107
	.byte	-23
	.byte	108
	.byte	-26
	.byte	112
	.byte	-10
	.byte	96
	.byte	-12
	.byte	95
	.byte	-5
	.byte	91
	.byte	-9
	.byte	93
	.byte	-22
	.byte	94
	.byte	-5
	.byte	86
	.byte	9
	.byte	67
	.byte	-4
	.byte	80
	.byte	-10
	.byte	85
	.byte	-1
	.byte	70
	.byte	7
	.byte	60
	.byte	9
	.byte	58
	.byte	5
	.byte	61
	.byte	12
	.byte	50
	.byte	15
	.byte	50
	.byte	18
	.byte	49
	.byte	17
	.byte	54
	.byte	10
	.byte	41
	.byte	7
	.byte	46
	.byte	-1
	.byte	51
	.byte	7
	.byte	49
	.byte	8
	.byte	52
	.byte	9
	.byte	41
	.byte	6
	.byte	47
	.byte	2
	.byte	55
	.byte	13
	.byte	41
	.byte	10
	.byte	44
	.byte	6
	.byte	50
	.byte	5
	.byte	53
	.byte	13
	.byte	49
	.byte	4
	.byte	63
	.byte	6
	.byte	64
	.byte	-2
	.byte	69
	.byte	-2
	.byte	59
	.byte	6
	.byte	70
	.byte	10
	.byte	44
	.byte	9
	.byte	31
	.byte	12
	.byte	43
	.byte	3
	.byte	53
	.byte	14
	.byte	34
	.byte	10
	.byte	38
	.byte	-3
	.byte	52
	.byte	13
	.byte	40
	.byte	17
	.byte	32
	.byte	7
	.byte	44
	.byte	7
	.byte	38
	.byte	13
	.byte	50
	.byte	10
	.byte	57
	.byte	26
	.byte	43
	.byte	14
	.byte	11
	.byte	11
	.byte	14
	.byte	9
	.byte	11
	.byte	18
	.byte	11
	.byte	21
	.byte	9
	.byte	23
	.byte	-2
	.byte	32
	.byte	-15
	.byte	32
	.byte	-15
	.byte	34
	.byte	-21
	.byte	39
	.byte	-23
	.byte	42
	.byte	-33
	.byte	41
	.byte	-31
	.byte	46
	.byte	-28
	.byte	38
	.byte	-12
	.byte	21
	.byte	29
	.byte	45
	.byte	-24
	.byte	53
	.byte	-45
	.byte	48
	.byte	-26
	.byte	65
	.byte	-43
	.byte	43
	.byte	-19
	.byte	39
	.byte	-10
	.byte	30
	.byte	9
	.byte	18
	.byte	26
	.byte	20
	.byte	27
	.byte	0
	.byte	57
	.byte	-14
	.byte	82
	.byte	-5
	.byte	75
	.byte	-19
	.byte	97
	.byte	-35
	.byte	125
	.byte	27
	.byte	0
	.byte	28
	.byte	0
	.byte	31
	.byte	-4
	.byte	27
	.byte	6
	.byte	34
	.byte	8
	.byte	30
	.byte	10
	.byte	24
	.byte	22
	.byte	33
	.byte	19
	.byte	22
	.byte	32
	.byte	26
	.byte	31
	.byte	21
	.byte	41
	.byte	26
	.byte	44
	.byte	23
	.byte	47
	.byte	16
	.byte	65
	.byte	14
	.byte	71
	.byte	8
	.byte	60
	.byte	6
	.byte	63
	.byte	17
	.byte	65
	.byte	21
	.byte	24
	.byte	23
	.byte	20
	.byte	26
	.byte	23
	.byte	27
	.byte	32
	.byte	28
	.byte	23
	.byte	28
	.byte	24
	.byte	23
	.byte	40
	.byte	24
	.byte	32
	.byte	28
	.byte	29
	.byte	23
	.byte	42
	.byte	19
	.byte	57
	.byte	22
	.byte	53
	.byte	22
	.byte	61
	.byte	11
	.byte	86
	.byte	12
	.byte	40
	.byte	11
	.byte	51
	.byte	14
	.byte	59
	.byte	-4
	.byte	79
	.byte	-7
	.byte	71
	.byte	-5
	.byte	69
	.byte	-9
	.byte	70
	.byte	-8
	.byte	66
	.byte	-10
	.byte	68
	.byte	-19
	.byte	73
	.byte	-12
	.byte	69
	.byte	-16
	.byte	70
	.byte	-15
	.byte	67
	.byte	-20
	.byte	62
	.byte	-19
	.byte	70
	.byte	-16
	.byte	66
	.byte	-22
	.byte	65
	.byte	-20
	.byte	63
	.byte	9
	.byte	-2
	.byte	26
	.byte	-9
	.byte	33
	.byte	-9
	.byte	39
	.byte	-7
	.byte	41
	.byte	-2
	.byte	45
	.byte	3
	.byte	49
	.byte	9
	.byte	45
	.byte	27
	.byte	36
	.byte	59
	.byte	-6
	.byte	66
	.byte	-7
	.byte	35
	.byte	-7
	.byte	42
	.byte	-8
	.byte	45
	.byte	-5
	.byte	48
	.byte	-12
	.byte	56
	.byte	-6
	.byte	60
	.byte	-5
	.byte	62
	.byte	-8
	.byte	66
	.byte	-8
	.byte	76
	.byte	-5
	.byte	85
	.byte	-6
	.byte	81
	.byte	-10
	.byte	77
	.byte	-7
	.byte	81
	.byte	-17
	.byte	80
	.byte	-18
	.byte	73
	.byte	-4
	.byte	74
	.byte	-10
	.byte	83
	.byte	-9
	.byte	71
	.byte	-9
	.byte	67
	.byte	-1
	.byte	61
	.byte	-8
	.byte	66
	.byte	-14
	.byte	66
	.byte	0
	.byte	59
	.byte	2
	.byte	59
	.byte	21
	.byte	-13
	.byte	33
	.byte	-14
	.byte	39
	.byte	-7
	.byte	46
	.byte	-2
	.byte	51
	.byte	2
	.byte	60
	.byte	6
	.byte	61
	.byte	17
	.byte	55
	.byte	34
	.byte	42
	.byte	62
	.byte	20
	.byte	-15
	.byte	2
	.byte	54
	.byte	3
	.byte	74
	.byte	20
	.byte	-15
	.byte	2
	.byte	54
	.byte	3
	.byte	74
	.byte	-28
	.byte	127
	.byte	-23
	.byte	104
	.byte	-6
	.byte	53
	.byte	-1
	.byte	54
	.byte	7
	.byte	51
	.byte	22
	.byte	25
	.byte	34
	.byte	0
	.byte	16
	.byte	0
	.byte	-2
	.byte	9
	.byte	4
	.byte	41
	.byte	-29
	.byte	118
	.byte	2
	.byte	65
	.byte	-6
	.byte	71
	.byte	-13
	.byte	79
	.byte	5
	.byte	52
	.byte	9
	.byte	50
	.byte	-3
	.byte	70
	.byte	10
	.byte	54
	.byte	26
	.byte	34
	.byte	19
	.byte	22
	.byte	40
	.byte	0
	.byte	57
	.byte	2
	.byte	41
	.byte	36
	.byte	26
	.byte	69
	.byte	-45
	.byte	127
	.byte	-15
	.byte	101
	.byte	-4
	.byte	76
	.byte	-6
	.byte	71
	.byte	-13
	.byte	79
	.byte	5
	.byte	52
	.byte	6
	.byte	69
	.byte	-13
	.byte	90
	.byte	0
	.byte	52
	.byte	8
	.byte	43
	.byte	-2
	.byte	69
	.byte	-5
	.byte	82
	.byte	-10
	.byte	96
	.byte	2
	.byte	59
	.byte	2
	.byte	75
	.byte	-3
	.byte	87
	.byte	-3
	.byte	100
	.byte	1
	.byte	56
	.byte	-3
	.byte	74
	.byte	-6
	.byte	85
	.byte	0
	.byte	59
	.byte	-3
	.byte	81
	.byte	-7
	.byte	86
	.byte	-5
	.byte	95
	.byte	-1
	.byte	66
	.byte	-1
	.byte	77
	.byte	1
	.byte	70
	.byte	-2
	.byte	86
	.byte	-5
	.byte	72
	.byte	0
	.byte	61
	.byte	0
	.byte	41
	.byte	0
	.byte	63
	.byte	0
	.byte	63
	.byte	0
	.byte	63
	.byte	-9
	.byte	83
	.byte	4
	.byte	86
	.byte	0
	.byte	97
	.byte	-7
	.byte	72
	.byte	13
	.byte	41
	.byte	3
	.byte	62
	.byte	13
	.byte	15
	.byte	7
	.byte	51
	.byte	2
	.byte	80
	.byte	-39
	.byte	127
	.byte	-18
	.byte	91
	.byte	-17
	.byte	96
	.byte	-26
	.byte	81
	.byte	-35
	.byte	98
	.byte	-24
	.byte	102
	.byte	-23
	.byte	97
	.byte	-27
	.byte	119
	.byte	-24
	.byte	99
	.byte	-21
	.byte	110
	.byte	-18
	.byte	102
	.byte	-36
	.byte	127
	.byte	0
	.byte	80
	.byte	-5
	.byte	89
	.byte	-7
	.byte	94
	.byte	-4
	.byte	92
	.byte	0
	.byte	39
	.byte	0
	.byte	65
	.byte	-15
	.byte	84
	.byte	-35
	.byte	127
	.byte	-2
	.byte	73
	.byte	-12
	.byte	104
	.byte	-9
	.byte	91
	.byte	-31
	.byte	127
	.byte	3
	.byte	55
	.byte	7
	.byte	56
	.byte	7
	.byte	55
	.byte	8
	.byte	61
	.byte	-3
	.byte	53
	.byte	0
	.byte	68
	.byte	-7
	.byte	74
	.byte	-9
	.byte	88
	.byte	-13
	.byte	103
	.byte	-13
	.byte	91
	.byte	-9
	.byte	89
	.byte	-14
	.byte	92
	.byte	-8
	.byte	76
	.byte	-12
	.byte	87
	.byte	-23
	.byte	110
	.byte	-24
	.byte	105
	.byte	-10
	.byte	78
	.byte	-20
	.byte	112
	.byte	-17
	.byte	99
	.byte	-78
	.byte	127
	.byte	-70
	.byte	127
	.byte	-50
	.byte	127
	.byte	-46
	.byte	127
	.byte	-4
	.byte	66
	.byte	-5
	.byte	78
	.byte	-4
	.byte	71
	.byte	-8
	.byte	72
	.byte	2
	.byte	59
	.byte	-1
	.byte	55
	.byte	-7
	.byte	70
	.byte	-6
	.byte	75
	.byte	-8
	.byte	89
	.byte	-34
	.byte	119
	.byte	-3
	.byte	75
	.byte	32
	.byte	20
	.byte	30
	.byte	22
	.byte	-44
	.byte	127
	.byte	0
	.byte	54
	.byte	-5
	.byte	61
	.byte	0
	.byte	58
	.byte	-1
	.byte	60
	.byte	-3
	.byte	61
	.byte	-8
	.byte	67
	.byte	-25
	.byte	84
	.byte	-14
	.byte	74
	.byte	-5
	.byte	65
	.byte	5
	.byte	52
	.byte	2
	.byte	57
	.byte	0
	.byte	61
	.byte	-9
	.byte	69
	.byte	-11
	.byte	70
	.byte	18
	.byte	55
	.byte	-4
	.byte	71
	.byte	0
	.byte	58
	.byte	7
	.byte	61
	.byte	9
	.byte	41
	.byte	18
	.byte	25
	.byte	9
	.byte	32
	.byte	5
	.byte	43
	.byte	9
	.byte	47
	.byte	0
	.byte	44
	.byte	0
	.byte	51
	.byte	2
	.byte	46
	.byte	19
	.byte	38
	.byte	-4
	.byte	66
	.byte	15
	.byte	38
	.byte	12
	.byte	42
	.byte	9
	.byte	34
	.byte	0
	.byte	89
	.byte	4
	.byte	45
	.byte	10
	.byte	28
	.byte	10
	.byte	31
	.byte	33
	.byte	-11
	.byte	52
	.byte	-43
	.byte	18
	.byte	15
	.byte	28
	.byte	0
	.byte	35
	.byte	-22
	.byte	38
	.byte	-25
	.byte	34
	.byte	0
	.byte	39
	.byte	-18
	.byte	32
	.byte	-12
	.byte	102
	.byte	-94
	.byte	0
	.byte	0
	.byte	56
	.byte	-15
	.byte	33
	.byte	-4
	.byte	29
	.byte	10
	.byte	37
	.byte	-5
	.byte	51
	.byte	-29
	.byte	39
	.byte	-9
	.byte	52
	.byte	-34
	.byte	69
	.byte	-58
	.byte	67
	.byte	-63
	.byte	44
	.byte	-5
	.byte	32
	.byte	7
	.byte	55
	.byte	-29
	.byte	32
	.byte	1
	.byte	0
	.byte	0
	.byte	27
	.byte	36
	.byte	33
	.byte	-25
	.byte	34
	.byte	-30
	.byte	36
	.byte	-28
	.byte	38
	.byte	-28
	.byte	38
	.byte	-27
	.byte	34
	.byte	-18
	.byte	35
	.byte	-16
	.byte	34
	.byte	-14
	.byte	32
	.byte	-8
	.byte	37
	.byte	-6
	.byte	35
	.byte	0
	.byte	30
	.byte	10
	.byte	28
	.byte	18
	.byte	26
	.byte	25
	.byte	29
	.byte	41
	.byte	0
	.byte	75
	.byte	2
	.byte	72
	.byte	8
	.byte	77
	.byte	14
	.byte	35
	.byte	18
	.byte	31
	.byte	17
	.byte	35
	.byte	21
	.byte	30
	.byte	17
	.byte	45
	.byte	20
	.byte	42
	.byte	18
	.byte	45
	.byte	27
	.byte	26
	.byte	16
	.byte	54
	.byte	7
	.byte	66
	.byte	16
	.byte	56
	.byte	11
	.byte	73
	.byte	10
	.byte	67
	.byte	-10
	.byte	116
	.byte	-23
	.byte	112
	.byte	-15
	.byte	71
	.byte	-7
	.byte	61
	.byte	0
	.byte	53
	.byte	-5
	.byte	66
	.byte	-11
	.byte	77
	.byte	-9
	.byte	80
	.byte	-9
	.byte	84
	.byte	-10
	.byte	87
	.byte	-34
	.byte	127
	.byte	-21
	.byte	101
	.byte	-3
	.byte	39
	.byte	-5
	.byte	53
	.byte	-7
	.byte	61
	.byte	-11
	.byte	75
	.byte	-15
	.byte	77
	.byte	-17
	.byte	91
	.byte	-25
	.byte	107
	.byte	-25
	.byte	111
	.byte	-28
	.byte	122
	.byte	-11
	.byte	76
	.byte	-10
	.byte	44
	.byte	-10
	.byte	52
	.byte	-10
	.byte	57
	.byte	-9
	.byte	58
	.byte	-16
	.byte	72
	.byte	-7
	.byte	69
	.byte	-4
	.byte	69
	.byte	-5
	.byte	74
	.byte	-9
	.byte	86
	.byte	2
	.byte	66
	.byte	-9
	.byte	34
	.byte	1
	.byte	32
	.byte	11
	.byte	31
	.byte	5
	.byte	52
	.byte	-2
	.byte	55
	.byte	-2
	.byte	67
	.byte	0
	.byte	73
	.byte	-8
	.byte	89
	.byte	3
	.byte	52
	.byte	7
	.byte	4
	.byte	10
	.byte	8
	.byte	17
	.byte	8
	.byte	16
	.byte	19
	.byte	3
	.byte	37
	.byte	-1
	.byte	61
	.byte	-5
	.byte	73
	.byte	-1
	.byte	70
	.byte	-4
	.byte	78
	.byte	0
	.byte	0
	.byte	-21
	.byte	126
	.byte	-23
	.byte	124
	.byte	-20
	.byte	110
	.byte	-26
	.byte	126
	.byte	-25
	.byte	124
	.byte	-17
	.byte	105
	.byte	-27
	.byte	121
	.byte	-27
	.byte	117
	.byte	-17
	.byte	102
	.byte	-26
	.byte	117
	.byte	-27
	.byte	116
	.byte	-33
	.byte	122
	.byte	-10
	.byte	95
	.byte	-14
	.byte	100
	.byte	-8
	.byte	95
	.byte	-17
	.byte	111
	.byte	-28
	.byte	114
	.byte	-6
	.byte	89
	.byte	-2
	.byte	80
	.byte	-4
	.byte	82
	.byte	-9
	.byte	85
	.byte	-8
	.byte	81
	.byte	-1
	.byte	72
	.byte	5
	.byte	64
	.byte	1
	.byte	67
	.byte	9
	.byte	56
	.byte	0
	.byte	69
	.byte	1
	.byte	69
	.byte	7
	.byte	69
	.byte	-7
	.byte	69
	.byte	-6
	.byte	67
	.byte	-16
	.byte	77
	.byte	-2
	.byte	64
	.byte	2
	.byte	61
	.byte	-6
	.byte	67
	.byte	-3
	.byte	64
	.byte	2
	.byte	57
	.byte	-3
	.byte	65
	.byte	-3
	.byte	66
	.byte	0
	.byte	62
	.byte	9
	.byte	51
	.byte	-1
	.byte	66
	.byte	-2
	.byte	71
	.byte	-2
	.byte	75
	.byte	-1
	.byte	70
	.byte	-9
	.byte	72
	.byte	14
	.byte	60
	.byte	16
	.byte	37
	.byte	0
	.byte	47
	.byte	18
	.byte	35
	.byte	11
	.byte	37
	.byte	12
	.byte	41
	.byte	10
	.byte	41
	.byte	2
	.byte	48
	.byte	12
	.byte	41
	.byte	13
	.byte	41
	.byte	0
	.byte	59
	.byte	3
	.byte	50
	.byte	19
	.byte	40
	.byte	3
	.byte	66
	.byte	18
	.byte	50
	.byte	19
	.byte	-6
	.byte	18
	.byte	-6
	.byte	14
	.byte	0
	.byte	26
	.byte	-12
	.byte	31
	.byte	-16
	.byte	33
	.byte	-25
	.byte	33
	.byte	-22
	.byte	37
	.byte	-28
	.byte	39
	.byte	-30
	.byte	42
	.byte	-30
	.byte	47
	.byte	-42
	.byte	45
	.byte	-36
	.byte	49
	.byte	-34
	.byte	41
	.byte	-17
	.byte	32
	.byte	9
	.byte	69
	.byte	-71
	.byte	63
	.byte	-63
	.byte	66
	.byte	-64
	.byte	77
	.byte	-74
	.byte	54
	.byte	-39
	.byte	52
	.byte	-35
	.byte	41
	.byte	-10
	.byte	36
	.byte	0
	.byte	40
	.byte	-1
	.byte	30
	.byte	14
	.byte	28
	.byte	26
	.byte	23
	.byte	37
	.byte	12
	.byte	55
	.byte	11
	.byte	65
	.byte	37
	.byte	-33
	.byte	39
	.byte	-36
	.byte	40
	.byte	-37
	.byte	38
	.byte	-30
	.byte	46
	.byte	-33
	.byte	42
	.byte	-30
	.byte	40
	.byte	-24
	.byte	49
	.byte	-29
	.byte	38
	.byte	-12
	.byte	40
	.byte	-10
	.byte	38
	.byte	-3
	.byte	46
	.byte	-5
	.byte	31
	.byte	20
	.byte	29
	.byte	30
	.byte	25
	.byte	44
	.byte	12
	.byte	48
	.byte	11
	.byte	49
	.byte	26
	.byte	45
	.byte	22
	.byte	22
	.byte	23
	.byte	22
	.byte	27
	.byte	21
	.byte	33
	.byte	20
	.byte	26
	.byte	28
	.byte	30
	.byte	24
	.byte	27
	.byte	34
	.byte	18
	.byte	42
	.byte	25
	.byte	39
	.byte	18
	.byte	50
	.byte	12
	.byte	70
	.byte	21
	.byte	54
	.byte	14
	.byte	71
	.byte	11
	.byte	83
	.byte	25
	.byte	32
	.byte	21
	.byte	49
	.byte	21
	.byte	54
	.byte	-5
	.byte	85
	.byte	-6
	.byte	81
	.byte	-10
	.byte	77
	.byte	-7
	.byte	81
	.byte	-17
	.byte	80
	.byte	-18
	.byte	73
	.byte	-4
	.byte	74
	.byte	-10
	.byte	83
	.byte	-9
	.byte	71
	.byte	-9
	.byte	67
	.byte	-1
	.byte	61
	.byte	-8
	.byte	66
	.byte	-14
	.byte	66
	.byte	0
	.byte	59
	.byte	2
	.byte	59
	.byte	17
	.byte	-10
	.byte	32
	.byte	-13
	.byte	42
	.byte	-9
	.byte	49
	.byte	-5
	.byte	53
	.byte	0
	.byte	64
	.byte	3
	.byte	68
	.byte	10
	.byte	66
	.byte	27
	.byte	47
	.byte	57
	.byte	-5
	.byte	71
	.byte	0
	.byte	24
	.byte	-1
	.byte	36
	.byte	-2
	.byte	42
	.byte	-2
	.byte	52
	.byte	-9
	.byte	57
	.byte	-6
	.byte	63
	.byte	-4
	.byte	65
	.byte	-4
	.byte	67
	.byte	-7
	.byte	82
	.byte	-3
	.byte	81
	.byte	-3
	.byte	76
	.byte	-7
	.byte	72
	.byte	-6
	.byte	78
	.byte	-12
	.byte	72
	.byte	-14
	.byte	68
	.byte	-3
	.byte	70
	.byte	-6
	.byte	76
	.byte	-5
	.byte	66
	.byte	-5
	.byte	62
	.byte	0
	.byte	57
	.byte	-4
	.byte	61
	.byte	-9
	.byte	60
	.byte	1
	.byte	54
	.byte	2
	.byte	58
	.byte	17
	.byte	-10
	.byte	32
	.byte	-13
	.byte	42
	.byte	-9
	.byte	49
	.byte	-5
	.byte	53
	.byte	0
	.byte	64
	.byte	3
	.byte	68
	.byte	10
	.byte	66
	.byte	27
	.byte	47
	.byte	57
	.byte	20
	.byte	-15
	.byte	2
	.byte	54
	.byte	3
	.byte	74
	.byte	20
	.byte	-15
	.byte	2
	.byte	54
	.byte	3
	.byte	74
	.byte	-28
	.byte	127
	.byte	-23
	.byte	104
	.byte	-6
	.byte	53
	.byte	-1
	.byte	54
	.byte	7
	.byte	51
	.byte	29
	.byte	16
	.byte	25
	.byte	0
	.byte	14
	.byte	0
	.byte	-10
	.byte	51
	.byte	-3
	.byte	62
	.byte	-27
	.byte	99
	.byte	26
	.byte	16
	.byte	-4
	.byte	85
	.byte	-24
	.byte	102
	.byte	5
	.byte	57
	.byte	6
	.byte	57
	.byte	-17
	.byte	73
	.byte	14
	.byte	57
	.byte	20
	.byte	40
	.byte	20
	.byte	10
	.byte	29
	.byte	0
	.byte	54
	.byte	0
	.byte	37
	.byte	42
	.byte	12
	.byte	97
	.byte	-32
	.byte	127
	.byte	-22
	.byte	117
	.byte	-2
	.byte	74
	.byte	-4
	.byte	85
	.byte	-24
	.byte	102
	.byte	5
	.byte	57
	.byte	-6
	.byte	93
	.byte	-14
	.byte	88
	.byte	-6
	.byte	44
	.byte	4
	.byte	55
	.byte	-11
	.byte	89
	.byte	-15
	.byte	103
	.byte	-21
	.byte	116
	.byte	19
	.byte	57
	.byte	20
	.byte	58
	.byte	4
	.byte	84
	.byte	6
	.byte	96
	.byte	1
	.byte	63
	.byte	-5
	.byte	85
	.byte	-13
	.byte	106
	.byte	5
	.byte	63
	.byte	6
	.byte	75
	.byte	-3
	.byte	90
	.byte	-1
	.byte	101
	.byte	3
	.byte	55
	.byte	-4
	.byte	79
	.byte	-2
	.byte	75
	.byte	-12
	.byte	97
	.byte	-7
	.byte	50
	.byte	1
	.byte	60
	.byte	0
	.byte	41
	.byte	0
	.byte	63
	.byte	0
	.byte	63
	.byte	0
	.byte	63
	.byte	-9
	.byte	83
	.byte	4
	.byte	86
	.byte	0
	.byte	97
	.byte	-7
	.byte	72
	.byte	13
	.byte	41
	.byte	3
	.byte	62
	.byte	7
	.byte	34
	.byte	-9
	.byte	88
	.byte	-20
	.byte	127
	.byte	-36
	.byte	127
	.byte	-17
	.byte	91
	.byte	-14
	.byte	95
	.byte	-25
	.byte	84
	.byte	-25
	.byte	86
	.byte	-12
	.byte	89
	.byte	-17
	.byte	91
	.byte	-31
	.byte	127
	.byte	-14
	.byte	76
	.byte	-18
	.byte	103
	.byte	-13
	.byte	90
	.byte	-37
	.byte	127
	.byte	11
	.byte	80
	.byte	5
	.byte	76
	.byte	2
	.byte	84
	.byte	5
	.byte	78
	.byte	-6
	.byte	55
	.byte	4
	.byte	61
	.byte	-14
	.byte	83
	.byte	-37
	.byte	127
	.byte	-5
	.byte	79
	.byte	-11
	.byte	104
	.byte	-11
	.byte	91
	.byte	-30
	.byte	127
	.byte	0
	.byte	65
	.byte	-2
	.byte	79
	.byte	0
	.byte	72
	.byte	-4
	.byte	92
	.byte	-6
	.byte	56
	.byte	3
	.byte	68
	.byte	-8
	.byte	71
	.byte	-13
	.byte	98
	.byte	-4
	.byte	86
	.byte	-12
	.byte	88
	.byte	-5
	.byte	82
	.byte	-3
	.byte	72
	.byte	-4
	.byte	67
	.byte	-8
	.byte	72
	.byte	-16
	.byte	89
	.byte	-9
	.byte	69
	.byte	-1
	.byte	59
	.byte	5
	.byte	66
	.byte	4
	.byte	57
	.byte	-4
	.byte	71
	.byte	-2
	.byte	71
	.byte	2
	.byte	58
	.byte	-1
	.byte	74
	.byte	-4
	.byte	44
	.byte	-1
	.byte	69
	.byte	0
	.byte	62
	.byte	-7
	.byte	51
	.byte	-4
	.byte	47
	.byte	-6
	.byte	42
	.byte	-3
	.byte	41
	.byte	-6
	.byte	53
	.byte	8
	.byte	76
	.byte	-9
	.byte	78
	.byte	-11
	.byte	83
	.byte	9
	.byte	52
	.byte	0
	.byte	67
	.byte	-5
	.byte	90
	.byte	1
	.byte	67
	.byte	-15
	.byte	72
	.byte	-5
	.byte	75
	.byte	-8
	.byte	80
	.byte	-21
	.byte	83
	.byte	-21
	.byte	64
	.byte	-13
	.byte	31
	.byte	-25
	.byte	64
	.byte	-29
	.byte	94
	.byte	9
	.byte	75
	.byte	17
	.byte	63
	.byte	-8
	.byte	74
	.byte	-5
	.byte	35
	.byte	-2
	.byte	27
	.byte	13
	.byte	91
	.byte	3
	.byte	65
	.byte	-7
	.byte	69
	.byte	8
	.byte	77
	.byte	-10
	.byte	66
	.byte	3
	.byte	62
	.byte	-3
	.byte	68
	.byte	-20
	.byte	81
	.byte	0
	.byte	30
	.byte	1
	.byte	7
	.byte	-3
	.byte	23
	.byte	-21
	.byte	74
	.byte	16
	.byte	66
	.byte	-23
	.byte	124
	.byte	17
	.byte	37
	.byte	44
	.byte	-18
	.byte	50
	.byte	-34
	.byte	-22
	.byte	127
	.byte	4
	.byte	39
	.byte	0
	.byte	42
	.byte	7
	.byte	34
	.byte	11
	.byte	29
	.byte	8
	.byte	31
	.byte	6
	.byte	37
	.byte	7
	.byte	42
	.byte	3
	.byte	40
	.byte	8
	.byte	33
	.byte	13
	.byte	43
	.byte	13
	.byte	36
	.byte	4
	.byte	47
	.byte	3
	.byte	55
	.byte	2
	.byte	58
	.byte	6
	.byte	60
	.byte	8
	.byte	44
	.byte	11
	.byte	44
	.byte	14
	.byte	42
	.byte	7
	.byte	48
	.byte	4
	.byte	56
	.byte	4
	.byte	52
	.byte	13
	.byte	37
	.byte	9
	.byte	49
	.byte	19
	.byte	58
	.byte	10
	.byte	48
	.byte	12
	.byte	45
	.byte	0
	.byte	69
	.byte	20
	.byte	33
	.byte	8
	.byte	63
	.byte	35
	.byte	-18
	.byte	33
	.byte	-25
	.byte	28
	.byte	-3
	.byte	24
	.byte	10
	.byte	27
	.byte	0
	.byte	34
	.byte	-14
	.byte	52
	.byte	-44
	.byte	39
	.byte	-24
	.byte	19
	.byte	17
	.byte	31
	.byte	25
	.byte	36
	.byte	29
	.byte	24
	.byte	33
	.byte	34
	.byte	15
	.byte	30
	.byte	20
	.byte	22
	.byte	73
	.byte	20
	.byte	34
	.byte	19
	.byte	31
	.byte	27
	.byte	44
	.byte	19
	.byte	16
	.byte	15
	.byte	36
	.byte	15
	.byte	36
	.byte	21
	.byte	28
	.byte	25
	.byte	21
	.byte	30
	.byte	20
	.byte	31
	.byte	12
	.byte	27
	.byte	16
	.byte	24
	.byte	42
	.byte	0
	.byte	93
	.byte	14
	.byte	56
	.byte	15
	.byte	57
	.byte	26
	.byte	38
	.byte	-24
	.byte	127
	.byte	-24
	.byte	115
	.byte	-22
	.byte	82
	.byte	-9
	.byte	62
	.byte	0
	.byte	53
	.byte	0
	.byte	59
	.byte	-14
	.byte	85
	.byte	-13
	.byte	89
	.byte	-13
	.byte	94
	.byte	-11
	.byte	92
	.byte	-29
	.byte	127
	.byte	-21
	.byte	100
	.byte	-14
	.byte	57
	.byte	-12
	.byte	67
	.byte	-11
	.byte	71
	.byte	-10
	.byte	77
	.byte	-21
	.byte	85
	.byte	-16
	.byte	88
	.byte	-23
	.byte	104
	.byte	-15
	.byte	98
	.byte	-37
	.byte	127
	.byte	-10
	.byte	82
	.byte	-8
	.byte	48
	.byte	-8
	.byte	61
	.byte	-8
	.byte	66
	.byte	-7
	.byte	70
	.byte	-14
	.byte	75
	.byte	-10
	.byte	79
	.byte	-9
	.byte	83
	.byte	-12
	.byte	92
	.byte	-18
	.byte	108
	.byte	-4
	.byte	79
	.byte	-22
	.byte	69
	.byte	-16
	.byte	75
	.byte	-2
	.byte	58
	.byte	1
	.byte	58
	.byte	-13
	.byte	78
	.byte	-9
	.byte	83
	.byte	-4
	.byte	81
	.byte	-13
	.byte	99
	.byte	-13
	.byte	81
	.byte	-6
	.byte	38
	.byte	-13
	.byte	62
	.byte	-6
	.byte	58
	.byte	-2
	.byte	59
	.byte	-16
	.byte	73
	.byte	-10
	.byte	76
	.byte	-13
	.byte	86
	.byte	-9
	.byte	83
	.byte	-10
	.byte	87
	.byte	0
	.byte	0
	.byte	-22
	.byte	127
	.byte	-25
	.byte	127
	.byte	-25
	.byte	120
	.byte	-27
	.byte	127
	.byte	-19
	.byte	114
	.byte	-23
	.byte	117
	.byte	-25
	.byte	118
	.byte	-26
	.byte	117
	.byte	-24
	.byte	113
	.byte	-28
	.byte	118
	.byte	-31
	.byte	120
	.byte	-37
	.byte	124
	.byte	-10
	.byte	94
	.byte	-15
	.byte	102
	.byte	-10
	.byte	99
	.byte	-13
	.byte	106
	.byte	-50
	.byte	127
	.byte	-5
	.byte	92
	.byte	17
	.byte	57
	.byte	-5
	.byte	86
	.byte	-13
	.byte	94
	.byte	-12
	.byte	91
	.byte	-2
	.byte	77
	.byte	0
	.byte	71
	.byte	-1
	.byte	73
	.byte	4
	.byte	64
	.byte	-7
	.byte	81
	.byte	5
	.byte	64
	.byte	15
	.byte	57
	.byte	1
	.byte	67
	.byte	0
	.byte	68
	.byte	-10
	.byte	67
	.byte	1
	.byte	68
	.byte	0
	.byte	77
	.byte	2
	.byte	64
	.byte	0
	.byte	68
	.byte	-5
	.byte	78
	.byte	7
	.byte	55
	.byte	5
	.byte	59
	.byte	2
	.byte	65
	.byte	14
	.byte	54
	.byte	15
	.byte	44
	.byte	5
	.byte	60
	.byte	2
	.byte	70
	.byte	-2
	.byte	76
	.byte	-18
	.byte	86
	.byte	12
	.byte	70
	.byte	5
	.byte	64
	.byte	-12
	.byte	70
	.byte	11
	.byte	55
	.byte	5
	.byte	56
	.byte	0
	.byte	69
	.byte	2
	.byte	65
	.byte	-6
	.byte	74
	.byte	5
	.byte	54
	.byte	7
	.byte	54
	.byte	-6
	.byte	76
	.byte	-11
	.byte	82
	.byte	-2
	.byte	77
	.byte	-2
	.byte	77
	.byte	25
	.byte	42
	.byte	17
	.byte	-13
	.byte	16
	.byte	-9
	.byte	17
	.byte	-12
	.byte	27
	.byte	-21
	.byte	37
	.byte	-30
	.byte	41
	.byte	-40
	.byte	42
	.byte	-41
	.byte	48
	.byte	-47
	.byte	39
	.byte	-32
	.byte	46
	.byte	-40
	.byte	52
	.byte	-51
	.byte	46
	.byte	-41
	.byte	52
	.byte	-39
	.byte	43
	.byte	-19
	.byte	32
	.byte	11
	.byte	61
	.byte	-55
	.byte	56
	.byte	-46
	.byte	62
	.byte	-50
	.byte	81
	.byte	-67
	.byte	45
	.byte	-20
	.byte	35
	.byte	-2
	.byte	28
	.byte	15
	.byte	34
	.byte	1
	.byte	39
	.byte	1
	.byte	30
	.byte	17
	.byte	20
	.byte	38
	.byte	18
	.byte	45
	.byte	15
	.byte	54
	.byte	0
	.byte	79
	.byte	36
	.byte	-16
	.byte	37
	.byte	-14
	.byte	37
	.byte	-17
	.byte	32
	.byte	1
	.byte	34
	.byte	15
	.byte	29
	.byte	15
	.byte	24
	.byte	25
	.byte	34
	.byte	22
	.byte	31
	.byte	16
	.byte	35
	.byte	18
	.byte	31
	.byte	28
	.byte	33
	.byte	41
	.byte	36
	.byte	28
	.byte	27
	.byte	47
	.byte	21
	.byte	62
	.byte	18
	.byte	31
	.byte	19
	.byte	26
	.byte	36
	.byte	24
	.byte	24
	.byte	23
	.byte	27
	.byte	16
	.byte	24
	.byte	30
	.byte	31
	.byte	29
	.byte	22
	.byte	41
	.byte	22
	.byte	42
	.byte	16
	.byte	60
	.byte	15
	.byte	52
	.byte	14
	.byte	60
	.byte	3
	.byte	78
	.byte	-16
	.byte	123
	.byte	21
	.byte	53
	.byte	22
	.byte	56
	.byte	25
	.byte	61
	.byte	21
	.byte	33
	.byte	19
	.byte	50
	.byte	17
	.byte	61
	.byte	-3
	.byte	78
	.byte	-8
	.byte	74
	.byte	-9
	.byte	72
	.byte	-10
	.byte	72
	.byte	-18
	.byte	75
	.byte	-12
	.byte	71
	.byte	-11
	.byte	63
	.byte	-5
	.byte	70
	.byte	-17
	.byte	75
	.byte	-14
	.byte	72
	.byte	-16
	.byte	67
	.byte	-8
	.byte	53
	.byte	-14
	.byte	59
	.byte	-9
	.byte	52
	.byte	-11
	.byte	68
	.byte	9
	.byte	-2
	.byte	30
	.byte	-10
	.byte	31
	.byte	-4
	.byte	33
	.byte	-1
	.byte	33
	.byte	7
	.byte	31
	.byte	12
	.byte	37
	.byte	23
	.byte	31
	.byte	38
	.byte	20
	.byte	64
	.byte	-9
	.byte	71
	.byte	-7
	.byte	37
	.byte	-8
	.byte	44
	.byte	-11
	.byte	49
	.byte	-10
	.byte	56
	.byte	-12
	.byte	59
	.byte	-8
	.byte	63
	.byte	-9
	.byte	67
	.byte	-6
	.byte	68
	.byte	-10
	.byte	79
	.byte	-3
	.byte	78
	.byte	-8
	.byte	74
	.byte	-9
	.byte	72
	.byte	-10
	.byte	72
	.byte	-18
	.byte	75
	.byte	-12
	.byte	71
	.byte	-11
	.byte	63
	.byte	-5
	.byte	70
	.byte	-17
	.byte	75
	.byte	-14
	.byte	72
	.byte	-16
	.byte	67
	.byte	-8
	.byte	53
	.byte	-14
	.byte	59
	.byte	-9
	.byte	52
	.byte	-11
	.byte	68
	.byte	9
	.byte	-2
	.byte	30
	.byte	-10
	.byte	31
	.byte	-4
	.byte	33
	.byte	-1
	.byte	33
	.byte	7
	.byte	31
	.byte	12
	.byte	37
	.byte	23
	.byte	31
	.byte	38
	.byte	20
	.byte	64
	.align	2
	.type	b_mb_type_info, @object
	.size	b_mb_type_info, 92
b_mb_type_info:
	.half	256
	.byte	1
	.space	1
	.half	4104
	.byte	1
	.space	1
	.half	16392
	.byte	1
	.space	1
	.half	20488
	.byte	1
	.space	1
	.half	12304
	.byte	2
	.space	1
	.half	12320
	.byte	2
	.space	1
	.half	-16368
	.byte	2
	.space	1
	.half	-16352
	.byte	2
	.space	1
	.half	-28656
	.byte	2
	.space	1
	.half	-28640
	.byte	2
	.space	1
	.half	24592
	.byte	2
	.space	1
	.half	24608
	.byte	2
	.space	1
	.half	-20464
	.byte	2
	.space	1
	.half	-20448
	.byte	2
	.space	1
	.half	-8176
	.byte	2
	.space	1
	.half	-8160
	.byte	2
	.space	1
	.half	28688
	.byte	2
	.space	1
	.half	28704
	.byte	2
	.space	1
	.half	-12272
	.byte	2
	.space	1
	.half	-12256
	.byte	2
	.space	1
	.half	-4080
	.byte	2
	.space	1
	.half	-4064
	.byte	2
	.space	1
	.half	-4032
	.byte	4
	.space	1
	.align	2
	.type	p_mb_type_info, @object
	.size	p_mb_type_info, 20
p_mb_type_info:
	.half	4104
	.byte	1
	.space	1
	.half	12304
	.byte	2
	.space	1
	.half	12320
	.byte	2
	.space	1
	.half	12352
	.byte	4
	.space	1
	.half	12864
	.byte	4
	.space	1
	.align	2
	.type	b_sub_mb_type_info, @object
	.size	b_sub_mb_type_info, 52
b_sub_mb_type_info:
	.half	256
	.byte	1
	.space	1
	.half	4104
	.byte	1
	.space	1
	.half	16392
	.byte	1
	.space	1
	.half	20488
	.byte	1
	.space	1
	.half	12304
	.byte	2
	.space	1
	.half	12320
	.byte	2
	.space	1
	.half	-16368
	.byte	2
	.space	1
	.half	-16352
	.byte	2
	.space	1
	.half	-4080
	.byte	2
	.space	1
	.half	-4064
	.byte	2
	.space	1
	.half	12352
	.byte	4
	.space	1
	.half	-16320
	.byte	4
	.space	1
	.half	-4032
	.byte	4
	.space	1
	.align	2
	.type	p_sub_mb_type_info, @object
	.size	p_sub_mb_type_info, 16
p_sub_mb_type_info:
	.half	4104
	.byte	1
	.space	1
	.half	4112
	.byte	2
	.space	1
	.half	4128
	.byte	2
	.space	1
	.half	4160
	.byte	4
	.space	1
	.align	2
	.type	luma_dc_field_scan, @object
	.size	luma_dc_field_scan, 16
luma_dc_field_scan:
	.byte	0
	.byte	32
	.byte	16
	.byte	-128
	.byte	-96
	.byte	48
	.byte	-112
	.byte	-80
	.byte	64
	.byte	96
	.byte	-64
	.byte	-32
	.byte	80
	.byte	112
	.byte	-48
	.byte	-16
	.align	2
	.type	significant_coeff_flag_offset_8x8.17571, @object
	.size	significant_coeff_flag_offset_8x8.17571, 126
significant_coeff_flag_offset_8x8.17571:
	.byte	0
	.byte	1
	.byte	2
	.byte	3
	.byte	4
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	3
	.byte	3
	.byte	6
	.byte	7
	.byte	7
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	9
	.byte	8
	.byte	7
	.byte	7
	.byte	6
	.byte	11
	.byte	12
	.byte	13
	.byte	11
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	14
	.byte	10
	.byte	9
	.byte	8
	.byte	6
	.byte	11
	.byte	12
	.byte	13
	.byte	11
	.byte	6
	.byte	9
	.byte	14
	.byte	10
	.byte	9
	.byte	11
	.byte	12
	.byte	13
	.byte	11
	.byte	14
	.byte	10
	.byte	12
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	7
	.byte	7
	.byte	8
	.byte	4
	.byte	5
	.byte	6
	.byte	9
	.byte	10
	.byte	10
	.byte	8
	.byte	11
	.byte	12
	.byte	11
	.byte	9
	.byte	9
	.byte	10
	.byte	10
	.byte	8
	.byte	11
	.byte	12
	.byte	11
	.byte	9
	.byte	9
	.byte	10
	.byte	10
	.byte	8
	.byte	11
	.byte	12
	.byte	11
	.byte	9
	.byte	9
	.byte	10
	.byte	10
	.byte	8
	.byte	13
	.byte	13
	.byte	9
	.byte	9
	.byte	10
	.byte	10
	.byte	8
	.byte	13
	.byte	13
	.byte	9
	.byte	9
	.byte	10
	.byte	10
	.byte	14
	.byte	14
	.byte	14
	.byte	14
	.byte	14
	.align	2
	.type	coeff_abs_level_m1_offset.17570, @object
	.size	coeff_abs_level_m1_offset.17570, 24
coeff_abs_level_m1_offset.17570:
	.word	227
	.word	237
	.word	247
	.word	257
	.word	266
	.word	426
	.align	2
	.type	last_coeff_flag_offset.17569, @object
	.size	last_coeff_flag_offset.17569, 48
last_coeff_flag_offset.17569:
	.word	166
	.word	181
	.word	195
	.word	210
	.word	213
	.word	417
	.word	338
	.word	353
	.word	367
	.word	382
	.word	385
	.word	451
	.align	2
	.type	significant_coeff_flag_offset.17568, @object
	.size	significant_coeff_flag_offset.17568, 48
significant_coeff_flag_offset.17568:
	.word	105
	.word	120
	.word	134
	.word	149
	.word	152
	.word	402
	.word	277
	.word	292
	.word	306
	.word	321
	.word	324
	.word	436
	.align	2
	.type	suffix_limit.15764, @object
	.size	suffix_limit.15764, 28
suffix_limit.15764:
	.word	0
	.word	5
	.word	11
	.word	23
	.word	47
	.word	95
	.word	2147483647
	.align	2
	.type	coeff_token_table_index.15747, @object
	.size	coeff_token_table_index.15747, 68
coeff_token_table_index.15747:
	.word	0
	.word	0
	.word	1
	.word	1
	.word	2
	.word	2
	.word	2
	.word	2
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.word	3
	.align	2
	.type	chroma_dc_coeff_token_len, @object
	.size	chroma_dc_coeff_token_len, 20
chroma_dc_coeff_token_len:
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	1
	.byte	0
	.byte	0
	.byte	6
	.byte	6
	.byte	3
	.byte	0
	.byte	6
	.byte	7
	.byte	7
	.byte	6
	.byte	6
	.byte	8
	.byte	8
	.byte	7
	.align	2
	.type	chroma_dc_coeff_token_bits, @object
	.size	chroma_dc_coeff_token_bits, 20
chroma_dc_coeff_token_bits:
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	7
	.byte	1
	.byte	0
	.byte	0
	.byte	4
	.byte	6
	.byte	1
	.byte	0
	.byte	3
	.byte	3
	.byte	2
	.byte	5
	.byte	2
	.byte	3
	.byte	2
	.byte	0
	.align	2
	.type	coeff_token_len, @object
	.size	coeff_token_len, 272
coeff_token_len:
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	2
	.byte	0
	.byte	0
	.byte	8
	.byte	6
	.byte	3
	.byte	0
	.byte	9
	.byte	8
	.byte	7
	.byte	5
	.byte	10
	.byte	9
	.byte	8
	.byte	6
	.byte	11
	.byte	10
	.byte	9
	.byte	7
	.byte	13
	.byte	11
	.byte	10
	.byte	8
	.byte	13
	.byte	13
	.byte	11
	.byte	9
	.byte	13
	.byte	13
	.byte	13
	.byte	10
	.byte	14
	.byte	14
	.byte	13
	.byte	11
	.byte	14
	.byte	14
	.byte	14
	.byte	13
	.byte	15
	.byte	15
	.byte	14
	.byte	14
	.byte	15
	.byte	15
	.byte	15
	.byte	14
	.byte	16
	.byte	15
	.byte	15
	.byte	15
	.byte	16
	.byte	16
	.byte	16
	.byte	15
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	2
	.byte	0
	.byte	0
	.byte	6
	.byte	5
	.byte	3
	.byte	0
	.byte	7
	.byte	6
	.byte	6
	.byte	4
	.byte	8
	.byte	6
	.byte	6
	.byte	4
	.byte	8
	.byte	7
	.byte	7
	.byte	5
	.byte	9
	.byte	8
	.byte	8
	.byte	6
	.byte	11
	.byte	9
	.byte	9
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	7
	.byte	12
	.byte	11
	.byte	11
	.byte	9
	.byte	12
	.byte	12
	.byte	12
	.byte	11
	.byte	12
	.byte	12
	.byte	12
	.byte	11
	.byte	13
	.byte	13
	.byte	13
	.byte	12
	.byte	13
	.byte	13
	.byte	13
	.byte	13
	.byte	13
	.byte	14
	.byte	13
	.byte	13
	.byte	14
	.byte	14
	.byte	14
	.byte	13
	.byte	14
	.byte	14
	.byte	14
	.byte	14
	.byte	4
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	4
	.byte	0
	.byte	0
	.byte	6
	.byte	5
	.byte	4
	.byte	0
	.byte	6
	.byte	5
	.byte	5
	.byte	4
	.byte	7
	.byte	5
	.byte	5
	.byte	4
	.byte	7
	.byte	5
	.byte	5
	.byte	4
	.byte	7
	.byte	6
	.byte	6
	.byte	4
	.byte	7
	.byte	6
	.byte	6
	.byte	4
	.byte	8
	.byte	7
	.byte	7
	.byte	5
	.byte	8
	.byte	8
	.byte	7
	.byte	6
	.byte	9
	.byte	8
	.byte	8
	.byte	7
	.byte	9
	.byte	9
	.byte	8
	.byte	8
	.byte	9
	.byte	9
	.byte	9
	.byte	8
	.byte	10
	.byte	9
	.byte	9
	.byte	9
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	6
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	6
	.byte	0
	.byte	0
	.byte	6
	.byte	6
	.byte	6
	.byte	0
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.align	2
	.type	coeff_token_bits, @object
	.size	coeff_token_bits, 272
coeff_token_bits:
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	5
	.byte	1
	.byte	0
	.byte	0
	.byte	7
	.byte	4
	.byte	1
	.byte	0
	.byte	7
	.byte	6
	.byte	5
	.byte	3
	.byte	7
	.byte	6
	.byte	5
	.byte	3
	.byte	7
	.byte	6
	.byte	5
	.byte	4
	.byte	15
	.byte	6
	.byte	5
	.byte	4
	.byte	11
	.byte	14
	.byte	5
	.byte	4
	.byte	8
	.byte	10
	.byte	13
	.byte	4
	.byte	15
	.byte	14
	.byte	9
	.byte	4
	.byte	11
	.byte	10
	.byte	13
	.byte	12
	.byte	15
	.byte	14
	.byte	9
	.byte	12
	.byte	11
	.byte	10
	.byte	13
	.byte	8
	.byte	15
	.byte	1
	.byte	9
	.byte	12
	.byte	11
	.byte	14
	.byte	13
	.byte	8
	.byte	7
	.byte	10
	.byte	9
	.byte	12
	.byte	4
	.byte	6
	.byte	5
	.byte	8
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	2
	.byte	0
	.byte	0
	.byte	7
	.byte	7
	.byte	3
	.byte	0
	.byte	7
	.byte	10
	.byte	9
	.byte	5
	.byte	7
	.byte	6
	.byte	5
	.byte	4
	.byte	4
	.byte	6
	.byte	5
	.byte	6
	.byte	7
	.byte	6
	.byte	5
	.byte	8
	.byte	15
	.byte	6
	.byte	5
	.byte	4
	.byte	11
	.byte	14
	.byte	13
	.byte	4
	.byte	15
	.byte	10
	.byte	9
	.byte	4
	.byte	11
	.byte	14
	.byte	13
	.byte	12
	.byte	8
	.byte	10
	.byte	9
	.byte	8
	.byte	15
	.byte	14
	.byte	13
	.byte	12
	.byte	11
	.byte	10
	.byte	9
	.byte	12
	.byte	7
	.byte	11
	.byte	6
	.byte	8
	.byte	9
	.byte	8
	.byte	10
	.byte	1
	.byte	7
	.byte	6
	.byte	5
	.byte	4
	.byte	15
	.byte	0
	.byte	0
	.byte	0
	.byte	15
	.byte	14
	.byte	0
	.byte	0
	.byte	11
	.byte	15
	.byte	13
	.byte	0
	.byte	8
	.byte	12
	.byte	14
	.byte	12
	.byte	15
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	8
	.byte	9
	.byte	10
	.byte	9
	.byte	14
	.byte	13
	.byte	9
	.byte	8
	.byte	10
	.byte	9
	.byte	8
	.byte	15
	.byte	14
	.byte	13
	.byte	13
	.byte	11
	.byte	14
	.byte	10
	.byte	12
	.byte	15
	.byte	10
	.byte	13
	.byte	12
	.byte	11
	.byte	14
	.byte	9
	.byte	12
	.byte	8
	.byte	10
	.byte	13
	.byte	8
	.byte	13
	.byte	7
	.byte	9
	.byte	12
	.byte	9
	.byte	12
	.byte	11
	.byte	10
	.byte	5
	.byte	8
	.byte	7
	.byte	6
	.byte	1
	.byte	4
	.byte	3
	.byte	2
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	4
	.byte	5
	.byte	6
	.byte	0
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.byte	16
	.byte	17
	.byte	18
	.byte	19
	.byte	20
	.byte	21
	.byte	22
	.byte	23
	.byte	24
	.byte	25
	.byte	26
	.byte	27
	.byte	28
	.byte	29
	.byte	30
	.byte	31
	.byte	32
	.byte	33
	.byte	34
	.byte	35
	.byte	36
	.byte	37
	.byte	38
	.byte	39
	.byte	40
	.byte	41
	.byte	42
	.byte	43
	.byte	44
	.byte	45
	.byte	46
	.byte	47
	.byte	48
	.byte	49
	.byte	50
	.byte	51
	.byte	52
	.byte	53
	.byte	54
	.byte	55
	.byte	56
	.byte	57
	.byte	58
	.byte	59
	.byte	60
	.byte	61
	.byte	62
	.byte	63
	.align	2
	.type	chroma_dc_total_zeros_len, @object
	.size	chroma_dc_total_zeros_len, 12
chroma_dc_total_zeros_len:
	.byte	1
	.byte	2
	.byte	3
	.byte	3
	.byte	1
	.byte	2
	.byte	2
	.byte	0
	.byte	1
	.byte	1
	.byte	0
	.byte	0
	.align	2
	.type	chroma_dc_total_zeros_bits, @object
	.size	chroma_dc_total_zeros_bits, 12
chroma_dc_total_zeros_bits:
	.byte	1
	.byte	1
	.byte	1
	.byte	0
	.byte	1
	.byte	1
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.align	2
	.type	total_zeros_len, @object
	.size	total_zeros_len, 256
total_zeros_len:
	.byte	1
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	7
	.byte	7
	.byte	8
	.byte	8
	.byte	9
	.byte	9
	.byte	9
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.space	1
	.byte	4
	.byte	3
	.byte	3
	.byte	3
	.byte	4
	.byte	4
	.byte	3
	.byte	3
	.byte	4
	.byte	5
	.byte	5
	.byte	6
	.byte	5
	.byte	6
	.space	2
	.byte	5
	.byte	3
	.byte	4
	.byte	4
	.byte	3
	.byte	3
	.byte	3
	.byte	4
	.byte	3
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.space	3
	.byte	4
	.byte	4
	.byte	4
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	4
	.byte	5
	.byte	4
	.byte	5
	.space	4
	.byte	6
	.byte	5
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	4
	.byte	3
	.byte	6
	.space	5
	.byte	6
	.byte	5
	.byte	3
	.byte	3
	.byte	3
	.byte	2
	.byte	3
	.byte	4
	.byte	3
	.byte	6
	.space	6
	.byte	6
	.byte	4
	.byte	5
	.byte	3
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	6
	.space	7
	.byte	6
	.byte	6
	.byte	4
	.byte	2
	.byte	2
	.byte	3
	.byte	2
	.byte	5
	.space	8
	.byte	5
	.byte	5
	.byte	3
	.byte	2
	.byte	2
	.byte	2
	.byte	4
	.space	9
	.byte	4
	.byte	4
	.byte	3
	.byte	3
	.byte	1
	.byte	3
	.space	10
	.byte	4
	.byte	4
	.byte	2
	.byte	1
	.byte	3
	.space	11
	.byte	3
	.byte	3
	.byte	1
	.byte	2
	.space	12
	.byte	2
	.byte	2
	.byte	1
	.space	13
	.byte	1
	.byte	1
	.space	14
	.space	16
	.align	2
	.type	total_zeros_bits, @object
	.size	total_zeros_bits, 256
total_zeros_bits:
	.byte	1
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	1
	.byte	7
	.byte	6
	.byte	5
	.byte	4
	.byte	3
	.byte	5
	.byte	4
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	1
	.byte	0
	.space	1
	.byte	5
	.byte	7
	.byte	6
	.byte	5
	.byte	4
	.byte	3
	.byte	4
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	1
	.byte	1
	.byte	0
	.space	2
	.byte	3
	.byte	7
	.byte	5
	.byte	4
	.byte	6
	.byte	5
	.byte	4
	.byte	3
	.byte	3
	.byte	2
	.byte	2
	.byte	1
	.byte	0
	.space	3
	.byte	5
	.byte	4
	.byte	3
	.byte	7
	.byte	6
	.byte	5
	.byte	4
	.byte	3
	.byte	2
	.byte	1
	.byte	1
	.byte	0
	.space	4
	.byte	1
	.byte	1
	.byte	7
	.byte	6
	.byte	5
	.byte	4
	.byte	3
	.byte	2
	.byte	1
	.byte	1
	.byte	0
	.space	5
	.byte	1
	.byte	1
	.byte	5
	.byte	4
	.byte	3
	.byte	3
	.byte	2
	.byte	1
	.byte	1
	.byte	0
	.space	6
	.byte	1
	.byte	1
	.byte	1
	.byte	3
	.byte	3
	.byte	2
	.byte	2
	.byte	1
	.byte	0
	.space	7
	.byte	1
	.byte	0
	.byte	1
	.byte	3
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.space	8
	.byte	1
	.byte	0
	.byte	1
	.byte	3
	.byte	2
	.byte	1
	.byte	1
	.space	9
	.byte	0
	.byte	1
	.byte	1
	.byte	2
	.byte	1
	.byte	3
	.space	10
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.space	11
	.byte	0
	.byte	1
	.byte	1
	.byte	1
	.space	12
	.byte	0
	.byte	1
	.byte	1
	.space	13
	.byte	0
	.byte	1
	.space	14
	.space	16
	.align	2
	.type	run_len, @object
	.size	run_len, 112
run_len:
	.byte	1
	.byte	1
	.space	14
	.byte	1
	.byte	2
	.byte	2
	.space	13
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.space	12
	.byte	2
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.space	11
	.byte	2
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.space	10
	.byte	2
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.space	9
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	4
	.byte	5
	.byte	6
	.byte	7
	.byte	8
	.byte	9
	.byte	10
	.byte	11
	.space	1
	.align	2
	.type	run_bits, @object
	.size	run_bits, 112
run_bits:
	.byte	1
	.byte	0
	.space	14
	.byte	1
	.byte	1
	.byte	0
	.space	13
	.byte	3
	.byte	2
	.byte	1
	.byte	0
	.space	12
	.byte	3
	.byte	2
	.byte	1
	.byte	1
	.byte	0
	.space	11
	.byte	3
	.byte	2
	.byte	3
	.byte	2
	.byte	1
	.byte	0
	.space	10
	.byte	3
	.byte	0
	.byte	1
	.byte	3
	.byte	2
	.byte	5
	.byte	4
	.space	9
	.byte	7
	.byte	6
	.byte	5
	.byte	4
	.byte	3
	.byte	2
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.space	1
	.local	done.12554
	.comm	done.12554,4,4
	.local	coeff_token_vlc
	.comm	coeff_token_vlc,64,4
	.local	chroma_dc_coeff_token_vlc
	.comm	chroma_dc_coeff_token_vlc,16,4
	.local	total_zeros_vlc
	.comm	total_zeros_vlc,240,4
	.local	chroma_dc_total_zeros_vlc
	.comm	chroma_dc_total_zeros_vlc,48,4
	.local	run_vlc
	.comm	run_vlc,96,4
	.local	run7_vlc
	.comm	run7_vlc,16,4
	.align	2
	.type	svq3_scan, @object
	.size	svq3_scan, 16
svq3_scan:
	.byte	0
	.byte	1
	.byte	2
	.byte	6
	.byte	10
	.byte	3
	.byte	7
	.byte	11
	.byte	4
	.byte	8
	.byte	5
	.byte	9
	.byte	12
	.byte	13
	.byte	14
	.byte	15
	.ident	"GCC: (GNU) 4.4.2"
