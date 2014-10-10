	.file	1 "h264idct.c"
	.section .mdebug.abi32
	.previous
	.gnu_attribute 4, 3
	.abicalls
	.text
	.align	2
	.globl	ff_h264_idct_add_c
	.set	nomips16
	.ent	ff_h264_idct_add_c
	.type	ff_h264_idct_add_c, @function
ff_h264_idct_add_c:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lhu	$2,0($5)
	addiu	$2,$2,32
	sh	$2,0($5)
#APP
 # 89 "h264idct.c" 1
	S32LDD xr1,$5,0
 # 0 "" 2
 # 90 "h264idct.c" 1
	S32LDD xr2,$5,4
 # 0 "" 2
 # 91 "h264idct.c" 1
	S32LDD xr3,$5,8
 # 0 "" 2
 # 92 "h264idct.c" 1
	S32LDD xr4,$5,12
 # 0 "" 2
 # 94 "h264idct.c" 1
	S32SFL xr7,xr1,xr3,xr5,ptn3
 # 0 "" 2
 # 95 "h264idct.c" 1
	S32SFL xr8,xr2,xr4,xr6,ptn3
 # 0 "" 2
 # 96 "h264idct.c" 1
	Q16SAR xr9,xr7,xr8,xr10,1
 # 0 "" 2
 # 98 "h264idct.c" 1
	Q16ADD xr1,xr5,xr6,xr2,AS,WW
 # 0 "" 2
 # 100 "h264idct.c" 1
	Q16ADD xr3,xr9,xr8,xr0,SA,WW
 # 0 "" 2
 # 101 "h264idct.c" 1
	Q16ADD xr4,xr7,xr10,xr0,AA,WW
 # 0 "" 2
 # 104 "h264idct.c" 1
	Q16ADD xr5,xr1,xr4,xr6,AS,WW
 # 0 "" 2
 # 106 "h264idct.c" 1
	Q16ADD xr7,xr2,xr3,xr8,AS,WW
 # 0 "" 2
 # 108 "h264idct.c" 1
	S32SFL xr1,xr7,xr5,xr3,ptn3
 # 0 "" 2
 # 109 "h264idct.c" 1
	S32SFL xr2,xr6,xr8,xr4,ptn3
 # 0 "" 2
 # 111 "h264idct.c" 1
	S32STD xr1,$5,0
 # 0 "" 2
 # 112 "h264idct.c" 1
	S32STD xr2,$5,4
 # 0 "" 2
 # 113 "h264idct.c" 1
	S32STD xr3,$5,8
 # 0 "" 2
 # 114 "h264idct.c" 1
	S32STD xr4,$5,12
 # 0 "" 2
 # 118 "h264idct.c" 1
	S32LDD xr1,$5,16
 # 0 "" 2
 # 119 "h264idct.c" 1
	S32LDD xr2,$5,20
 # 0 "" 2
 # 120 "h264idct.c" 1
	S32LDD xr3,$5,24
 # 0 "" 2
 # 121 "h264idct.c" 1
	S32LDD xr4,$5,28
 # 0 "" 2
 # 123 "h264idct.c" 1
	S32SFL xr7,xr1,xr3,xr5,ptn3
 # 0 "" 2
 # 124 "h264idct.c" 1
	S32SFL xr8,xr2,xr4,xr6,ptn3
 # 0 "" 2
 # 125 "h264idct.c" 1
	Q16SAR xr9,xr7,xr8,xr10,1
 # 0 "" 2
 # 127 "h264idct.c" 1
	Q16ADD xr1,xr5,xr6,xr2,AS,WW
 # 0 "" 2
 # 129 "h264idct.c" 1
	Q16ADD xr3,xr9,xr8,xr0,SA,WW
 # 0 "" 2
 # 130 "h264idct.c" 1
	Q16ADD xr4,xr7,xr10,xr0,AA,WW
 # 0 "" 2
 # 133 "h264idct.c" 1
	Q16ADD xr5,xr1,xr4,xr6,AS,WW
 # 0 "" 2
 # 135 "h264idct.c" 1
	Q16ADD xr7,xr2,xr3,xr8,AS,WW
 # 0 "" 2
 # 137 "h264idct.c" 1
	S32SFL xr1,xr7,xr5,xr3,ptn3
 # 0 "" 2
 # 138 "h264idct.c" 1
	S32SFL xr2,xr6,xr8,xr4,ptn3
 # 0 "" 2
 # 140 "h264idct.c" 1
	S32STD xr1,$5,16
 # 0 "" 2
 # 141 "h264idct.c" 1
	S32STD xr2,$5,20
 # 0 "" 2
 # 142 "h264idct.c" 1
	S32STD xr3,$5,24
 # 0 "" 2
 # 143 "h264idct.c" 1
	S32STD xr4,$5,28
 # 0 "" 2
 # 160 "h264idct.c" 1
	S32LDD xr10,$5,0
 # 0 "" 2
 # 161 "h264idct.c" 1
	S32LDD xr1,$5,8
 # 0 "" 2
 # 162 "h264idct.c" 1
	S32LDD xr2,$5,16
 # 0 "" 2
 # 163 "h264idct.c" 1
	S32LDD xr3,$5,24
 # 0 "" 2
 # 164 "h264idct.c" 1
	Q16SAR xr4,xr1,xr3,xr5,1
 # 0 "" 2
 # 166 "h264idct.c" 1
	Q16ADD xr6,xr10,xr2,xr7,AS,WW
 # 0 "" 2
 # 168 "h264idct.c" 1
	Q16ADD xr8,xr4,xr3,xr0,SA,WW
 # 0 "" 2
 # 169 "h264idct.c" 1
	Q16ADD xr9,xr1,xr5,xr0,AA,WW
 # 0 "" 2
 # 171 "h264idct.c" 1
	Q16ADD xr11,xr6,xr9,xr12,AS,WW
 # 0 "" 2
 # 173 "h264idct.c" 1
	Q16ADD xr13,xr7,xr8,xr14,AS,WW
 # 0 "" 2
 # 175 "h264idct.c" 1
	Q16SAR xr11,xr11,xr12,xr12,6
 # 0 "" 2
 # 176 "h264idct.c" 1
	Q16SAR xr13,xr13,xr14,xr14,6
 # 0 "" 2
 # 180 "h264idct.c" 1
	S32LDD xr10,$5,4
 # 0 "" 2
 # 181 "h264idct.c" 1
	S32LDD xr1,$5,12
 # 0 "" 2
 # 182 "h264idct.c" 1
	S32LDD xr2,$5,20
 # 0 "" 2
 # 183 "h264idct.c" 1
	S32LDD xr3,$5,28
 # 0 "" 2
 # 184 "h264idct.c" 1
	Q16SAR xr4,xr1,xr3,xr5,1
 # 0 "" 2
 # 186 "h264idct.c" 1
	Q16ADD xr6,xr10,xr2,xr7,AS,WW
 # 0 "" 2
 # 188 "h264idct.c" 1
	Q16ADD xr8,xr4,xr3,xr0,SA,WW
 # 0 "" 2
 # 189 "h264idct.c" 1
	Q16ADD xr9,xr1,xr5,xr0,AA,WW
 # 0 "" 2
 # 191 "h264idct.c" 1
	Q16ADD xr1,xr6,xr9,xr2,AS,WW
 # 0 "" 2
 # 193 "h264idct.c" 1
	Q16ADD xr3,xr7,xr8,xr4,AS,WW
 # 0 "" 2
 # 195 "h264idct.c" 1
	Q16SAR xr1,xr1,xr2,xr2,6
 # 0 "" 2
 # 196 "h264idct.c" 1
	Q16SAR xr3,xr3,xr4,xr4,6
 # 0 "" 2
 # 200 "h264idct.c" 1
	S32LDD xr5,$4,0
 # 0 "" 2
 # 201 "h264idct.c" 1
	Q8ACCE xr1,xr5,xr0,xr11,AA
 # 0 "" 2
 # 202 "h264idct.c" 1
	Q16SAT xr5,xr1,xr11
 # 0 "" 2
 # 203 "h264idct.c" 1
	S32STD xr5,$4,0
 # 0 "" 2
 # 205 "h264idct.c" 1
	S32LDIV xr5,$4,$6,0
 # 0 "" 2
 # 206 "h264idct.c" 1
	Q8ACCE xr3,xr5,xr0,xr13,AA
 # 0 "" 2
 # 207 "h264idct.c" 1
	Q16SAT xr5,xr3,xr13
 # 0 "" 2
 # 208 "h264idct.c" 1
	S32STD xr5,$4,0
 # 0 "" 2
 # 210 "h264idct.c" 1
	S32LDIV xr5,$4,$6,0
 # 0 "" 2
 # 211 "h264idct.c" 1
	Q8ACCE xr4,xr5,xr0,xr14,AA
 # 0 "" 2
 # 212 "h264idct.c" 1
	Q16SAT xr5,xr4,xr14
 # 0 "" 2
 # 213 "h264idct.c" 1
	S32STD xr5,$4,0
 # 0 "" 2
 # 215 "h264idct.c" 1
	S32LDIV xr5,$4,$6,0
 # 0 "" 2
 # 216 "h264idct.c" 1
	Q8ACCE xr2,xr5,xr0,xr12,AA
 # 0 "" 2
 # 217 "h264idct.c" 1
	Q16SAT xr5,xr2,xr12
 # 0 "" 2
 # 218 "h264idct.c" 1
	S32STD xr5,$4,0
 # 0 "" 2
#NO_APP
	j	$31
	.end	ff_h264_idct_add_c
	.size	ff_h264_idct_add_c, .-ff_h264_idct_add_c
	.align	2
	.globl	ff_h264_lowres_idct_add_c
	.set	nomips16
	.ent	ff_h264_lowres_idct_add_c
	.type	ff_h264_lowres_idct_add_c, @function
ff_h264_lowres_idct_add_c:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lhu	$2,0($6)
	addiu	$2,$2,4
	sh	$2,0($6)
#APP
 # 249 "h264idct.c" 1
	S32LDD xr1,$6,0
 # 0 "" 2
 # 250 "h264idct.c" 1
	S32LDD xr2,$6,4
 # 0 "" 2
 # 251 "h264idct.c" 1
	S32LDD xr3,$6,16
 # 0 "" 2
 # 252 "h264idct.c" 1
	S32LDD xr4,$6,20
 # 0 "" 2
 # 254 "h264idct.c" 1
	S32SFL xr7,xr1,xr3,xr5,ptn3
 # 0 "" 2
 # 255 "h264idct.c" 1
	S32SFL xr8,xr2,xr4,xr6,ptn3
 # 0 "" 2
 # 256 "h264idct.c" 1
	Q16SAR xr9,xr7,xr8,xr10,1
 # 0 "" 2
 # 258 "h264idct.c" 1
	Q16ADD xr1,xr5,xr6,xr2,AS,WW
 # 0 "" 2
 # 260 "h264idct.c" 1
	Q16ADD xr3,xr9,xr8,xr0,SA,WW
 # 0 "" 2
 # 261 "h264idct.c" 1
	Q16ADD xr4,xr7,xr10,xr0,AA,WW
 # 0 "" 2
 # 264 "h264idct.c" 1
	Q16ADD xr5,xr1,xr4,xr6,AS,WW
 # 0 "" 2
 # 266 "h264idct.c" 1
	Q16ADD xr7,xr2,xr3,xr8,AS,WW
 # 0 "" 2
 # 268 "h264idct.c" 1
	S32SFL xr1,xr7,xr5,xr3,ptn3
 # 0 "" 2
 # 269 "h264idct.c" 1
	S32SFL xr2,xr6,xr8,xr4,ptn3
 # 0 "" 2
 # 271 "h264idct.c" 1
	S32STD xr1,$6,0
 # 0 "" 2
 # 272 "h264idct.c" 1
	S32STD xr2,$6,4
 # 0 "" 2
 # 273 "h264idct.c" 1
	S32STD xr3,$6,16
 # 0 "" 2
 # 274 "h264idct.c" 1
	S32STD xr4,$6,20
 # 0 "" 2
 # 278 "h264idct.c" 1
	S32LDD xr1,$6,32
 # 0 "" 2
 # 279 "h264idct.c" 1
	S32LDD xr2,$6,36
 # 0 "" 2
 # 280 "h264idct.c" 1
	S32LDD xr3,$6,48
 # 0 "" 2
 # 281 "h264idct.c" 1
	S32LDD xr4,$6,52
 # 0 "" 2
 # 283 "h264idct.c" 1
	S32SFL xr7,xr1,xr3,xr5,ptn3
 # 0 "" 2
 # 284 "h264idct.c" 1
	S32SFL xr8,xr2,xr4,xr6,ptn3
 # 0 "" 2
 # 285 "h264idct.c" 1
	Q16SAR xr9,xr7,xr8,xr10,1
 # 0 "" 2
 # 287 "h264idct.c" 1
	Q16ADD xr1,xr5,xr6,xr2,AS,WW
 # 0 "" 2
 # 289 "h264idct.c" 1
	Q16ADD xr3,xr9,xr8,xr0,SA,WW
 # 0 "" 2
 # 290 "h264idct.c" 1
	Q16ADD xr4,xr7,xr10,xr0,AA,WW
 # 0 "" 2
 # 293 "h264idct.c" 1
	Q16ADD xr5,xr1,xr4,xr6,AS,WW
 # 0 "" 2
 # 295 "h264idct.c" 1
	Q16ADD xr7,xr2,xr3,xr8,AS,WW
 # 0 "" 2
 # 297 "h264idct.c" 1
	S32SFL xr1,xr7,xr5,xr3,ptn3
 # 0 "" 2
 # 298 "h264idct.c" 1
	S32SFL xr2,xr6,xr8,xr4,ptn3
 # 0 "" 2
 # 300 "h264idct.c" 1
	S32STD xr1,$6,32
 # 0 "" 2
 # 301 "h264idct.c" 1
	S32STD xr2,$6,36
 # 0 "" 2
 # 302 "h264idct.c" 1
	S32STD xr3,$6,48
 # 0 "" 2
 # 303 "h264idct.c" 1
	S32STD xr4,$6,52
 # 0 "" 2
 # 320 "h264idct.c" 1
	S32LDD xr10,$6,0
 # 0 "" 2
 # 321 "h264idct.c" 1
	S32LDD xr1,$6,16
 # 0 "" 2
 # 322 "h264idct.c" 1
	S32LDD xr2,$6,32
 # 0 "" 2
 # 323 "h264idct.c" 1
	S32LDD xr3,$6,48
 # 0 "" 2
 # 324 "h264idct.c" 1
	Q16SAR xr4,xr1,xr3,xr5,1
 # 0 "" 2
 # 326 "h264idct.c" 1
	Q16ADD xr6,xr10,xr2,xr7,AS,WW
 # 0 "" 2
 # 328 "h264idct.c" 1
	Q16ADD xr8,xr4,xr3,xr0,SA,WW
 # 0 "" 2
 # 329 "h264idct.c" 1
	Q16ADD xr9,xr1,xr5,xr0,AA,WW
 # 0 "" 2
 # 331 "h264idct.c" 1
	Q16ADD xr11,xr6,xr9,xr12,AS,WW
 # 0 "" 2
 # 333 "h264idct.c" 1
	Q16ADD xr13,xr7,xr8,xr14,AS,WW
 # 0 "" 2
 # 335 "h264idct.c" 1
	Q16SAR xr11,xr11,xr12,xr12,3
 # 0 "" 2
 # 336 "h264idct.c" 1
	Q16SAR xr13,xr13,xr14,xr14,3
 # 0 "" 2
 # 340 "h264idct.c" 1
	S32LDD xr10,$6,4
 # 0 "" 2
 # 341 "h264idct.c" 1
	S32LDD xr1,$6,20
 # 0 "" 2
 # 342 "h264idct.c" 1
	S32LDD xr2,$6,36
 # 0 "" 2
 # 343 "h264idct.c" 1
	S32LDD xr3,$6,52
 # 0 "" 2
 # 344 "h264idct.c" 1
	Q16SAR xr4,xr1,xr3,xr5,1
 # 0 "" 2
 # 346 "h264idct.c" 1
	Q16ADD xr6,xr10,xr2,xr7,AS,WW
 # 0 "" 2
 # 348 "h264idct.c" 1
	Q16ADD xr8,xr4,xr3,xr0,SA,WW
 # 0 "" 2
 # 349 "h264idct.c" 1
	Q16ADD xr9,xr1,xr5,xr0,AA,WW
 # 0 "" 2
 # 351 "h264idct.c" 1
	Q16ADD xr1,xr6,xr9,xr2,AS,WW
 # 0 "" 2
 # 353 "h264idct.c" 1
	Q16ADD xr3,xr7,xr8,xr4,AS,WW
 # 0 "" 2
 # 355 "h264idct.c" 1
	Q16SAR xr1,xr1,xr2,xr2,3
 # 0 "" 2
 # 356 "h264idct.c" 1
	Q16SAR xr3,xr3,xr4,xr4,3
 # 0 "" 2
 # 360 "h264idct.c" 1
	S32LDD xr5,$4,0
 # 0 "" 2
 # 361 "h264idct.c" 1
	Q8ACCE xr1,xr5,xr0,xr11,AA
 # 0 "" 2
 # 362 "h264idct.c" 1
	Q16SAT xr5,xr1,xr11
 # 0 "" 2
 # 363 "h264idct.c" 1
	S32STD xr5,$4,0
 # 0 "" 2
 # 365 "h264idct.c" 1
	S32LDIV xr5,$4,$5,0
 # 0 "" 2
 # 366 "h264idct.c" 1
	Q8ACCE xr3,xr5,xr0,xr13,AA
 # 0 "" 2
 # 367 "h264idct.c" 1
	Q16SAT xr5,xr3,xr13
 # 0 "" 2
 # 368 "h264idct.c" 1
	S32STD xr5,$4,0
 # 0 "" 2
 # 370 "h264idct.c" 1
	S32LDIV xr5,$4,$5,0
 # 0 "" 2
 # 371 "h264idct.c" 1
	Q8ACCE xr4,xr5,xr0,xr14,AA
 # 0 "" 2
 # 372 "h264idct.c" 1
	Q16SAT xr5,xr4,xr14
 # 0 "" 2
 # 373 "h264idct.c" 1
	S32STD xr5,$4,0
 # 0 "" 2
 # 375 "h264idct.c" 1
	S32LDIV xr5,$4,$5,0
 # 0 "" 2
 # 376 "h264idct.c" 1
	Q8ACCE xr2,xr5,xr0,xr12,AA
 # 0 "" 2
 # 377 "h264idct.c" 1
	Q16SAT xr5,xr2,xr12
 # 0 "" 2
 # 378 "h264idct.c" 1
	S32STD xr5,$4,0
 # 0 "" 2
#NO_APP
	j	$31
	.end	ff_h264_lowres_idct_add_c
	.size	ff_h264_lowres_idct_add_c, .-ff_h264_lowres_idct_add_c
	.align	2
	.globl	ff_h264_lowres_idct_put_c
	.set	nomips16
	.ent	ff_h264_lowres_idct_put_c
	.type	ff_h264_lowres_idct_put_c, @function
ff_h264_lowres_idct_put_c:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lhu	$2,0($6)
	addiu	$2,$2,4
	sh	$2,0($6)
#APP
 # 396 "h264idct.c" 1
	S32LDD xr1,$6,0
 # 0 "" 2
 # 397 "h264idct.c" 1
	S32LDD xr2,$6,4
 # 0 "" 2
 # 398 "h264idct.c" 1
	S32LDD xr3,$6,16
 # 0 "" 2
 # 399 "h264idct.c" 1
	S32LDD xr4,$6,20
 # 0 "" 2
 # 401 "h264idct.c" 1
	S32SFL xr7,xr1,xr3,xr5,ptn3
 # 0 "" 2
 # 402 "h264idct.c" 1
	S32SFL xr8,xr2,xr4,xr6,ptn3
 # 0 "" 2
 # 403 "h264idct.c" 1
	Q16SAR xr9,xr7,xr8,xr10,1
 # 0 "" 2
 # 405 "h264idct.c" 1
	Q16ADD xr1,xr5,xr6,xr2,AS,WW
 # 0 "" 2
 # 407 "h264idct.c" 1
	Q16ADD xr3,xr9,xr8,xr0,SA,WW
 # 0 "" 2
 # 408 "h264idct.c" 1
	Q16ADD xr4,xr7,xr10,xr0,AA,WW
 # 0 "" 2
 # 411 "h264idct.c" 1
	Q16ADD xr5,xr1,xr4,xr6,AS,WW
 # 0 "" 2
 # 413 "h264idct.c" 1
	Q16ADD xr7,xr2,xr3,xr8,AS,WW
 # 0 "" 2
 # 415 "h264idct.c" 1
	S32SFL xr1,xr7,xr5,xr3,ptn3
 # 0 "" 2
 # 416 "h264idct.c" 1
	S32SFL xr2,xr6,xr8,xr4,ptn3
 # 0 "" 2
 # 418 "h264idct.c" 1
	S32STD xr1,$6,0
 # 0 "" 2
 # 419 "h264idct.c" 1
	S32STD xr2,$6,4
 # 0 "" 2
 # 420 "h264idct.c" 1
	S32STD xr3,$6,16
 # 0 "" 2
 # 421 "h264idct.c" 1
	S32STD xr4,$6,20
 # 0 "" 2
 # 425 "h264idct.c" 1
	S32LDD xr1,$6,32
 # 0 "" 2
 # 426 "h264idct.c" 1
	S32LDD xr2,$6,36
 # 0 "" 2
 # 427 "h264idct.c" 1
	S32LDD xr3,$6,48
 # 0 "" 2
 # 428 "h264idct.c" 1
	S32LDD xr4,$6,52
 # 0 "" 2
 # 430 "h264idct.c" 1
	S32SFL xr7,xr1,xr3,xr5,ptn3
 # 0 "" 2
 # 431 "h264idct.c" 1
	S32SFL xr8,xr2,xr4,xr6,ptn3
 # 0 "" 2
 # 432 "h264idct.c" 1
	Q16SAR xr9,xr7,xr8,xr10,1
 # 0 "" 2
 # 434 "h264idct.c" 1
	Q16ADD xr1,xr5,xr6,xr2,AS,WW
 # 0 "" 2
 # 436 "h264idct.c" 1
	Q16ADD xr3,xr9,xr8,xr0,SA,WW
 # 0 "" 2
 # 437 "h264idct.c" 1
	Q16ADD xr4,xr7,xr10,xr0,AA,WW
 # 0 "" 2
 # 440 "h264idct.c" 1
	Q16ADD xr5,xr1,xr4,xr6,AS,WW
 # 0 "" 2
 # 442 "h264idct.c" 1
	Q16ADD xr7,xr2,xr3,xr8,AS,WW
 # 0 "" 2
 # 444 "h264idct.c" 1
	S32SFL xr1,xr7,xr5,xr3,ptn3
 # 0 "" 2
 # 445 "h264idct.c" 1
	S32SFL xr2,xr6,xr8,xr4,ptn3
 # 0 "" 2
 # 447 "h264idct.c" 1
	S32STD xr1,$6,32
 # 0 "" 2
 # 448 "h264idct.c" 1
	S32STD xr2,$6,36
 # 0 "" 2
 # 449 "h264idct.c" 1
	S32STD xr3,$6,48
 # 0 "" 2
 # 450 "h264idct.c" 1
	S32STD xr4,$6,52
 # 0 "" 2
 # 467 "h264idct.c" 1
	S32LDD xr10,$6,0
 # 0 "" 2
 # 468 "h264idct.c" 1
	S32LDD xr1,$6,16
 # 0 "" 2
 # 469 "h264idct.c" 1
	S32LDD xr2,$6,32
 # 0 "" 2
 # 470 "h264idct.c" 1
	S32LDD xr3,$6,48
 # 0 "" 2
 # 471 "h264idct.c" 1
	Q16SAR xr4,xr1,xr3,xr5,1
 # 0 "" 2
 # 473 "h264idct.c" 1
	Q16ADD xr6,xr10,xr2,xr7,AS,WW
 # 0 "" 2
 # 475 "h264idct.c" 1
	Q16ADD xr8,xr4,xr3,xr0,SA,WW
 # 0 "" 2
 # 476 "h264idct.c" 1
	Q16ADD xr9,xr1,xr5,xr0,AA,WW
 # 0 "" 2
 # 478 "h264idct.c" 1
	Q16ADD xr11,xr6,xr9,xr12,AS,WW
 # 0 "" 2
 # 480 "h264idct.c" 1
	Q16ADD xr13,xr7,xr8,xr14,AS,WW
 # 0 "" 2
 # 482 "h264idct.c" 1
	Q16SAR xr11,xr11,xr12,xr12,3
 # 0 "" 2
 # 483 "h264idct.c" 1
	Q16SAR xr13,xr13,xr14,xr14,3
 # 0 "" 2
 # 487 "h264idct.c" 1
	S32LDD xr10,$6,4
 # 0 "" 2
 # 488 "h264idct.c" 1
	S32LDD xr1,$6,20
 # 0 "" 2
 # 489 "h264idct.c" 1
	S32LDD xr2,$6,36
 # 0 "" 2
 # 490 "h264idct.c" 1
	S32LDD xr3,$6,52
 # 0 "" 2
 # 491 "h264idct.c" 1
	Q16SAR xr4,xr1,xr3,xr5,1
 # 0 "" 2
 # 493 "h264idct.c" 1
	Q16ADD xr6,xr10,xr2,xr7,AS,WW
 # 0 "" 2
 # 495 "h264idct.c" 1
	Q16ADD xr8,xr4,xr3,xr0,SA,WW
 # 0 "" 2
 # 496 "h264idct.c" 1
	Q16ADD xr9,xr1,xr5,xr0,AA,WW
 # 0 "" 2
 # 498 "h264idct.c" 1
	Q16ADD xr1,xr6,xr9,xr2,AS,WW
 # 0 "" 2
 # 500 "h264idct.c" 1
	Q16ADD xr3,xr7,xr8,xr4,AS,WW
 # 0 "" 2
 # 502 "h264idct.c" 1
	Q16SAR xr1,xr1,xr2,xr2,3
 # 0 "" 2
 # 503 "h264idct.c" 1
	Q16SAR xr3,xr3,xr4,xr4,3
 # 0 "" 2
 # 507 "h264idct.c" 1
	Q16SAT xr5,xr1,xr11
 # 0 "" 2
 # 508 "h264idct.c" 1
	S32STD xr5,$4,0
 # 0 "" 2
 # 510 "h264idct.c" 1
	Q16SAT xr5,xr3,xr13
 # 0 "" 2
 # 511 "h264idct.c" 1
	S32SDIV xr5,$4,$5,0
 # 0 "" 2
 # 513 "h264idct.c" 1
	Q16SAT xr5,xr4,xr14
 # 0 "" 2
 # 514 "h264idct.c" 1
	S32SDIV xr5,$4,$5,0
 # 0 "" 2
 # 516 "h264idct.c" 1
	Q16SAT xr5,xr2,xr12
 # 0 "" 2
 # 517 "h264idct.c" 1
	S32SDIV xr5,$4,$5,0
 # 0 "" 2
#NO_APP
	j	$31
	.end	ff_h264_lowres_idct_put_c
	.size	ff_h264_lowres_idct_put_c, .-ff_h264_lowres_idct_put_c
	.align	2
	.globl	ff_h264_idct8_add_c
	.set	nomips16
	.ent	ff_h264_idct8_add_c
	.type	ff_h264_idct8_add_c, @function
ff_h264_idct8_add_c:
	.frame	$sp,104,$31		# vars= 56, regs= 9/0, args= 0, gp= 8
	.mask	0x40ff0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$28,%hi(__gnu_local_gp)
	addiu	$sp,$sp,-104
	addiu	$28,$28,%lo(__gnu_local_gp)
	sw	$fp,100($sp)
	sw	$23,96($sp)
	sw	$22,92($sp)
	sw	$21,88($sp)
	sw	$20,84($sp)
	sw	$19,80($sp)
	sw	$18,76($sp)
	sw	$17,72($sp)
	sw	$16,68($sp)
	.cprestore	0
	lh	$2,10($5)
	lh	$3,6($5)
	lh	$7,14($5)
	lh	$8,2($5)
	lhu	$15,0($5)
	lh	$10,4($5)
	addu	$11,$3,$2
	addu	$12,$7,$2
	addu	$13,$8,$7
	addiu	$15,$15,32
	lh	$9,12($5)
	lh	$14,8($5)
	subu	$24,$2,$3
	subu	$13,$13,$3
	subu	$12,$12,$8
	addu	$11,$11,$8
	sra	$3,$3,1
	sra	$8,$8,1
	sll	$15,$15,16
	subu	$3,$13,$3
	addu	$8,$11,$8
	sra	$15,$15,16
	sra	$11,$10,1
	sra	$2,$2,1
	subu	$13,$15,$14
	subu	$24,$24,$7
	addu	$14,$14,$15
	addu	$2,$12,$2
	subu	$11,$11,$9
	sra	$15,$3,2
	sra	$12,$9,1
	sra	$7,$7,1
	addu	$12,$12,$10
	sra	$9,$2,2
	sra	$25,$8,2
	subu	$10,$13,$11
	subu	$7,$24,$7
	subu	$2,$15,$2
	addu	$11,$11,$13
	sra	$24,$7,2
	andi	$2,$2,0xffff
	addu	$3,$9,$3
	addu	$7,$25,$7
	subu	$9,$14,$12
	andi	$11,$11,0xffff
	subu	$15,$11,$2
	andi	$7,$7,0xffff
	addu	$11,$2,$11
	subu	$8,$8,$24
	addu	$12,$12,$14
	andi	$9,$9,0xffff
	addiu	$2,$5,16
	sw	$2,32($sp)
	subu	$13,$9,$7
	andi	$8,$8,0xffff
	andi	$3,$3,0xffff
	addu	$9,$7,$9
	andi	$12,$12,0xffff
	andi	$10,$10,0xffff
	sh	$9,6($5)
	subu	$24,$12,$8
	subu	$14,$10,$3
	lw	$9,32($sp)
	addu	$12,$8,$12
	addu	$10,$3,$10
	lw	$7,32($sp)
	sh	$12,0($5)
	sh	$24,14($5)
	sh	$11,2($5)
	sh	$15,12($5)
	sh	$13,8($5)
	sh	$10,4($5)
	sh	$14,10($5)
	lh	$3,6($7)
	lh	$8,2($9)
	lh	$2,10($2)
	lh	$7,14($7)
	lw	$16,32($sp)
	lh	$10,4($9)
	addu	$11,$3,$2
	lh	$9,12($9)
	addu	$12,$7,$2
	subu	$24,$2,$3
	addu	$13,$8,$7
	lh	$15,16($5)
	lh	$14,8($16)
	subu	$24,$24,$7
	subu	$13,$13,$3
	subu	$12,$12,$8
	addu	$11,$11,$8
	sra	$7,$7,1
	sra	$8,$8,1
	sra	$3,$3,1
	sra	$2,$2,1
	subu	$3,$13,$3
	addu	$2,$12,$2
	addu	$8,$11,$8
	subu	$7,$24,$7
	sra	$12,$9,1
	sra	$11,$10,1
	subu	$13,$15,$14
	addu	$12,$12,$10
	addu	$14,$14,$15
	subu	$11,$11,$9
	sra	$25,$8,2
	sra	$9,$2,2
	sra	$24,$7,2
	sra	$15,$3,2
	subu	$10,$13,$11
	addu	$3,$9,$3
	addu	$7,$25,$7
	subu	$9,$14,$12
	subu	$8,$8,$24
	subu	$2,$15,$2
	addu	$12,$12,$14
	addu	$11,$11,$13
	andi	$8,$8,0xffff
	andi	$2,$2,0xffff
	andi	$3,$3,0xffff
	andi	$7,$7,0xffff
	andi	$12,$12,0xffff
	andi	$11,$11,0xffff
	andi	$10,$10,0xffff
	andi	$9,$9,0xffff
	subu	$24,$12,$8
	subu	$15,$11,$2
	subu	$14,$10,$3
	subu	$13,$9,$7
	addu	$12,$8,$12
	addu	$11,$2,$11
	addu	$10,$3,$10
	addu	$9,$7,$9
	addiu	$25,$5,32
	sh	$12,16($5)
	sh	$24,14($16)
	sh	$11,2($16)
	sh	$15,12($16)
	sh	$10,4($16)
	sh	$14,10($16)
	sh	$13,8($16)
	sh	$9,6($16)
	lh	$2,10($25)
	lh	$3,6($25)
	lh	$7,14($25)
	lh	$8,2($25)
	lh	$10,4($25)
	addu	$11,$3,$2
	addu	$12,$7,$2
	addu	$13,$8,$7
	lh	$9,12($25)
	lh	$14,8($25)
	lh	$15,32($5)
	subu	$24,$2,$3
	subu	$13,$13,$3
	subu	$12,$12,$8
	addu	$11,$11,$8
	sra	$3,$3,1
	sra	$8,$8,1
	subu	$24,$24,$7
	subu	$3,$13,$3
	addu	$8,$11,$8
	sra	$7,$7,1
	sra	$11,$10,1
	sra	$2,$2,1
	subu	$13,$15,$14
	addu	$2,$12,$2
	addu	$14,$14,$15
	subu	$11,$11,$9
	sra	$15,$3,2
	subu	$7,$24,$7
	sra	$12,$9,1
	sw	$25,28($sp)
	addu	$12,$12,$10
	sra	$9,$2,2
	sra	$25,$8,2
	sra	$24,$7,2
	subu	$10,$13,$11
	subu	$2,$15,$2
	addu	$11,$11,$13
	andi	$2,$2,0xffff
	addu	$3,$9,$3
	addu	$7,$25,$7
	subu	$9,$14,$12
	subu	$8,$8,$24
	addu	$12,$12,$14
	andi	$11,$11,0xffff
	lw	$fp,28($sp)
	subu	$15,$11,$2
	andi	$8,$8,0xffff
	andi	$7,$7,0xffff
	addu	$11,$2,$11
	andi	$12,$12,0xffff
	andi	$9,$9,0xffff
	addiu	$2,$5,48
	sw	$2,24($sp)
	subu	$24,$12,$8
	subu	$13,$9,$7
	andi	$3,$3,0xffff
	addu	$12,$8,$12
	addu	$9,$7,$9
	andi	$10,$10,0xffff
	sh	$12,32($5)
	subu	$14,$10,$3
	sh	$9,6($fp)
	addu	$10,$3,$10
	lw	$9,24($sp)
	lw	$7,24($sp)
	sh	$24,14($fp)
	sh	$11,2($fp)
	sh	$13,8($fp)
	sh	$15,12($fp)
	sh	$10,4($fp)
	sh	$14,10($fp)
	lh	$3,6($7)
	lh	$8,2($9)
	lh	$2,10($2)
	lh	$7,14($7)
	lw	$16,24($sp)
	lh	$10,4($9)
	addu	$11,$3,$2
	lh	$9,12($9)
	addu	$12,$7,$2
	subu	$24,$2,$3
	addu	$13,$8,$7
	lh	$15,48($5)
	lh	$14,8($16)
	subu	$24,$24,$7
	subu	$13,$13,$3
	subu	$12,$12,$8
	addu	$11,$11,$8
	sra	$7,$7,1
	sra	$8,$8,1
	sra	$3,$3,1
	sra	$2,$2,1
	subu	$3,$13,$3
	addu	$2,$12,$2
	addu	$8,$11,$8
	subu	$7,$24,$7
	sra	$12,$9,1
	sra	$11,$10,1
	subu	$13,$15,$14
	addu	$12,$12,$10
	addu	$14,$14,$15
	subu	$11,$11,$9
	sra	$25,$8,2
	sra	$9,$2,2
	sra	$24,$7,2
	sra	$15,$3,2
	subu	$10,$13,$11
	addu	$3,$9,$3
	addu	$7,$25,$7
	subu	$9,$14,$12
	subu	$8,$8,$24
	subu	$2,$15,$2
	addu	$12,$12,$14
	addu	$11,$11,$13
	andi	$8,$8,0xffff
	andi	$2,$2,0xffff
	andi	$3,$3,0xffff
	andi	$7,$7,0xffff
	andi	$12,$12,0xffff
	andi	$11,$11,0xffff
	andi	$10,$10,0xffff
	andi	$9,$9,0xffff
	subu	$24,$12,$8
	subu	$15,$11,$2
	subu	$14,$10,$3
	subu	$13,$9,$7
	addu	$12,$8,$12
	addu	$11,$2,$11
	addu	$10,$3,$10
	addu	$9,$7,$9
	addiu	$25,$5,64
	sh	$12,48($5)
	sh	$24,14($16)
	sh	$13,8($16)
	sh	$11,2($16)
	sh	$15,12($16)
	sh	$10,4($16)
	sh	$14,10($16)
	sh	$9,6($16)
	lh	$7,14($25)
	lh	$2,10($25)
	lh	$3,6($25)
	lh	$8,2($25)
	lh	$10,4($25)
	addu	$11,$3,$2
	addu	$12,$7,$2
	addu	$13,$8,$7
	lh	$9,12($25)
	lh	$15,64($5)
	lh	$14,8($25)
	subu	$24,$2,$3
	subu	$13,$13,$3
	subu	$12,$12,$8
	addu	$11,$11,$8
	sra	$3,$3,1
	sra	$8,$8,1
	subu	$24,$24,$7
	subu	$3,$13,$3
	addu	$8,$11,$8
	sra	$7,$7,1
	sra	$11,$10,1
	sra	$2,$2,1
	subu	$13,$15,$14
	addu	$2,$12,$2
	addu	$14,$14,$15
	subu	$11,$11,$9
	sra	$15,$3,2
	subu	$7,$24,$7
	sra	$12,$9,1
	sw	$25,20($sp)
	addu	$12,$12,$10
	sra	$9,$2,2
	sra	$25,$8,2
	sra	$24,$7,2
	subu	$10,$13,$11
	subu	$2,$15,$2
	addu	$11,$11,$13
	andi	$2,$2,0xffff
	addu	$3,$9,$3
	addu	$7,$25,$7
	subu	$9,$14,$12
	subu	$8,$8,$24
	addu	$12,$12,$14
	andi	$11,$11,0xffff
	lw	$fp,20($sp)
	subu	$15,$11,$2
	andi	$8,$8,0xffff
	andi	$7,$7,0xffff
	addu	$11,$2,$11
	andi	$12,$12,0xffff
	andi	$9,$9,0xffff
	addiu	$2,$5,80
	sw	$2,16($sp)
	subu	$24,$12,$8
	subu	$13,$9,$7
	andi	$3,$3,0xffff
	addu	$12,$8,$12
	addu	$9,$7,$9
	andi	$10,$10,0xffff
	sh	$12,64($5)
	subu	$14,$10,$3
	sh	$9,6($fp)
	addu	$10,$3,$10
	lw	$9,16($sp)
	lw	$7,16($sp)
	sh	$24,14($fp)
	sh	$11,2($fp)
	sh	$13,8($fp)
	sh	$15,12($fp)
	sh	$10,4($fp)
	sh	$14,10($fp)
	lh	$3,6($7)
	lh	$8,2($9)
	lh	$2,10($2)
	lh	$7,14($7)
	lw	$16,16($sp)
	lh	$10,4($9)
	addu	$11,$3,$2
	lh	$9,12($9)
	addu	$12,$7,$2
	subu	$24,$2,$3
	addu	$13,$8,$7
	lh	$15,80($5)
	lh	$14,8($16)
	subu	$24,$24,$7
	subu	$13,$13,$3
	subu	$12,$12,$8
	addu	$11,$11,$8
	sra	$7,$7,1
	sra	$8,$8,1
	sra	$3,$3,1
	sra	$2,$2,1
	subu	$3,$13,$3
	addu	$2,$12,$2
	addu	$8,$11,$8
	subu	$7,$24,$7
	sra	$12,$9,1
	sra	$11,$10,1
	subu	$13,$15,$14
	addu	$12,$12,$10
	addu	$14,$14,$15
	subu	$11,$11,$9
	sra	$25,$8,2
	sra	$9,$2,2
	sra	$24,$7,2
	sra	$15,$3,2
	subu	$10,$13,$11
	addu	$3,$9,$3
	addu	$7,$25,$7
	subu	$9,$14,$12
	subu	$8,$8,$24
	subu	$2,$15,$2
	addu	$12,$12,$14
	addu	$11,$11,$13
	andi	$8,$8,0xffff
	andi	$2,$2,0xffff
	andi	$3,$3,0xffff
	andi	$7,$7,0xffff
	andi	$12,$12,0xffff
	andi	$11,$11,0xffff
	andi	$10,$10,0xffff
	andi	$9,$9,0xffff
	subu	$24,$12,$8
	subu	$15,$11,$2
	subu	$14,$10,$3
	subu	$13,$9,$7
	addu	$12,$8,$12
	addu	$11,$2,$11
	addu	$10,$3,$10
	addu	$9,$7,$9
	sh	$12,80($5)
	addiu	$25,$5,96
	sh	$24,14($16)
	sh	$11,2($16)
	sh	$13,8($16)
	sh	$15,12($16)
	sh	$10,4($16)
	sh	$14,10($16)
	sh	$9,6($16)
	lh	$7,14($25)
	lh	$8,2($25)
	lh	$2,10($25)
	lh	$3,6($25)
	lh	$10,4($25)
	addu	$12,$7,$2
	addu	$11,$3,$2
	addu	$13,$8,$7
	lh	$9,12($25)
	lh	$15,96($5)
	lh	$14,8($25)
	subu	$24,$2,$3
	subu	$13,$13,$3
	subu	$12,$12,$8
	addu	$11,$11,$8
	sra	$3,$3,1
	sra	$8,$8,1
	subu	$3,$13,$3
	addu	$8,$11,$8
	sra	$2,$2,1
	sra	$11,$10,1
	subu	$13,$15,$14
	subu	$24,$24,$7
	addu	$14,$14,$15
	addu	$2,$12,$2
	subu	$11,$11,$9
	sra	$15,$3,2
	sra	$12,$9,1
	sra	$7,$7,1
	subu	$7,$24,$7
	addu	$12,$12,$10
	sra	$9,$2,2
	subu	$10,$13,$11
	subu	$2,$15,$2
	addu	$11,$11,$13
	sw	$25,12($sp)
	sra	$24,$8,2
	sra	$25,$7,2
	andi	$2,$2,0xffff
	andi	$11,$11,0xffff
	subu	$15,$11,$2
	addu	$3,$9,$3
	addu	$11,$2,$11
	subu	$9,$14,$12
	addiu	$2,$5,112
	addu	$7,$24,$7
	subu	$8,$8,$25
	addu	$12,$12,$14
	lw	$fp,12($sp)
	sw	$2,36($sp)
	andi	$8,$8,0xffff
	andi	$3,$3,0xffff
	andi	$7,$7,0xffff
	andi	$12,$12,0xffff
	andi	$10,$10,0xffff
	andi	$9,$9,0xffff
	subu	$24,$12,$8
	subu	$14,$10,$3
	subu	$13,$9,$7
	addu	$12,$8,$12
	addu	$10,$3,$10
	addu	$9,$7,$9
	lw	$3,36($sp)
	sh	$12,96($5)
	sh	$15,12($fp)
	sh	$10,4($fp)
	sh	$14,10($fp)
	sh	$24,14($fp)
	sh	$11,2($fp)
	sh	$9,6($fp)
	sh	$13,8($fp)
	lh	$12,10($2)
	lh	$7,14($3)
	lh	$11,2($3)
	lh	$2,6($2)
	lw	$14,36($sp)
	addu	$10,$7,$12
	lh	$13,4($3)
	lh	$9,12($3)
	addu	$15,$2,$12
	subu	$3,$12,$2
	addu	$8,$11,$7
	sra	$12,$12,1
	lh	$16,112($5)
	addu	$12,$10,$12
	subu	$8,$8,$2
	lh	$24,8($14)
	subu	$3,$3,$7
	sra	$2,$2,1
	sra	$7,$7,1
	subu	$2,$8,$2
	sra	$10,$11,1
	subu	$3,$3,$7
	sra	$8,$9,1
	addu	$15,$15,$11
	subu	$11,$12,$11
	subu	$14,$16,$24
	addu	$15,$15,$10
	addu	$24,$24,$16
	sra	$7,$13,1
	sra	$12,$3,2
	addu	$13,$8,$13
	sra	$8,$11,2
	sra	$25,$15,2
	sra	$10,$2,2
	addu	$8,$8,$2
	subu	$15,$15,$12
	subu	$2,$24,$13
	addu	$13,$13,$24
	andi	$15,$15,0xffff
	subu	$9,$7,$9
	addu	$3,$25,$3
	andi	$13,$13,0xffff
	subu	$7,$14,$9
	andi	$3,$3,0xffff
	subu	$17,$13,$15
	subu	$10,$10,$11
	addu	$13,$15,$13
	addu	$9,$9,$14
	andi	$2,$2,0xffff
	sh	$13,112($5)
	sll	$12,$6,1
	lw	$fp,36($sp)
	sll	$11,$6,2
	sll	$14,$6,3
	subu	$18,$2,$3
	andi	$9,$9,0xffff
	addu	$2,$3,$2
	andi	$10,$10,0xffff
	andi	$7,$7,0xffff
	andi	$8,$8,0xffff
	lw	$3,%got(ff_cropTbl)($28)
	subu	$20,$14,$6
	addu	$19,$11,$6
	addu	$24,$12,$6
	subu	$16,$9,$10
	subu	$25,$7,$8
	subu	$14,$14,$12
	addu	$9,$10,$9
	addu	$7,$8,$7
	sh	$2,6($fp)
	sh	$17,14($fp)
	sh	$9,2($fp)
	sh	$16,12($fp)
	sh	$7,4($fp)
	sh	$25,10($fp)
	sh	$18,8($fp)
	addu	$24,$4,$24
	addu	$15,$4,$19
	addu	$14,$4,$14
	addu	$13,$4,$20
	addiu	$3,$3,1024
	addu	$6,$4,$6
	addu	$12,$4,$12
	addu	$11,$4,$11
	move	$2,$0
	sw	$5,40($sp)
$L8:
	lw	$7,16($sp)
	lw	$8,24($sp)
	lw	$16,12($sp)
	lw	$9,36($sp)
	addu	$10,$16,$2
	addu	$5,$7,$2
	addu	$7,$8,$2
	lh	$8,0($7)
	lh	$5,0($5)
	lh	$20,0($10)
	lw	$25,32($sp)
	lw	$10,20($sp)
	lw	$16,28($sp)
	addu	$7,$9,$2
	lh	$9,0($7)
	addu	$7,$25,$2
	addu	$25,$10,$2
	addu	$10,$16,$2
	subu	$16,$5,$8
	lh	$23,0($10)
	lw	$fp,40($sp)
	subu	$16,$16,$9
	sra	$10,$9,1
	subu	$10,$16,$10
	sw	$10,56($sp)
	lh	$7,0($7)
	addu	$17,$fp,$2
	lh	$22,0($17)
	lh	$21,0($25)
	addu	$19,$8,$5
	lw	$25,56($sp)
	sra	$10,$7,1
	sra	$17,$20,1
	addu	$19,$19,$7
	lbu	$fp,0($4)
	addu	$18,$21,$22
	addu	$17,$17,$23
	addu	$19,$19,$10
	sra	$10,$25,2
	subu	$10,$19,$10
	addu	$25,$17,$18
	sw	$fp,48($sp)
	addu	$16,$10,$25
	sra	$fp,$16,6
	lw	$16,48($sp)
	sra	$23,$23,1
	addu	$16,$fp,$16
	addu	$fp,$7,$9
	addu	$9,$9,$5
	sw	$9,48($sp)
	sw	$16,8($sp)
	addu	$9,$3,$16
	lw	$16,48($sp)
	subu	$fp,$fp,$8
	sra	$8,$8,1
	subu	$8,$fp,$8
	sra	$5,$5,1
	lbu	$fp,0($9)
	subu	$9,$16,$7
	subu	$21,$22,$21
	addu	$9,$9,$5
	subu	$23,$23,$20
	sra	$5,$8,2
	sb	$fp,0($4)
	subu	$5,$5,$9
	addu	$7,$23,$21
	lbu	$20,0($6)
	addu	$22,$5,$7
	sra	$22,$22,6
	addu	$20,$22,$20
	addu	$20,$3,$20
	lbu	$20,0($20)
	sra	$9,$9,2
	sb	$20,0($6)
	addu	$8,$9,$8
	subu	$23,$21,$23
	lbu	$9,0($12)
	addu	$20,$8,$23
	sra	$20,$20,6
	addu	$9,$20,$9
	addu	$9,$3,$9
	lbu	$9,0($9)
	sra	$19,$19,2
	sb	$9,0($12)
	lw	$fp,56($sp)
	subu	$17,$18,$17
	addu	$19,$19,$fp
	lbu	$9,0($24)
	addu	$16,$19,$17
	sra	$16,$16,6
	addu	$9,$16,$9
	addu	$9,$3,$9
	lbu	$9,0($9)
	subu	$19,$17,$19
	sb	$9,0($24)
	lbu	$9,0($11)
	sra	$17,$19,6
	addu	$17,$17,$9
	addu	$17,$3,$17
	lbu	$9,0($17)
	subu	$8,$23,$8
	sb	$9,0($11)
	lbu	$16,0($15)
	sra	$8,$8,6
	addu	$8,$8,$16
	addu	$8,$3,$8
	lbu	$8,0($8)
	subu	$5,$7,$5
	sb	$8,0($15)
	lbu	$8,0($14)
	sra	$5,$5,6
	addu	$5,$5,$8
	addu	$5,$3,$5
	lbu	$5,0($5)
	subu	$10,$25,$10
	sb	$5,0($14)
	lbu	$5,0($13)
	sra	$10,$10,6
	addu	$10,$10,$5
	addu	$10,$3,$10
	lbu	$5,0($10)
	addiu	$2,$2,2
	sb	$5,0($13)
	li	$5,16			# 0x10
	addiu	$4,$4,1
	addiu	$6,$6,1
	addiu	$12,$12,1
	addiu	$24,$24,1
	addiu	$11,$11,1
	addiu	$15,$15,1
	addiu	$14,$14,1
	bne	$2,$5,$L8
	addiu	$13,$13,1

	lw	$fp,100($sp)
	lw	$23,96($sp)
	lw	$22,92($sp)
	lw	$21,88($sp)
	lw	$20,84($sp)
	lw	$19,80($sp)
	lw	$18,76($sp)
	lw	$17,72($sp)
	lw	$16,68($sp)
	j	$31
	addiu	$sp,$sp,104

	.set	macro
	.set	reorder
	.end	ff_h264_idct8_add_c
	.size	ff_h264_idct8_add_c, .-ff_h264_idct8_add_c
	.align	2
	.globl	ff_h264_idct_dc_add_c
	.set	nomips16
	.ent	ff_h264_idct_dc_add_c
	.type	ff_h264_idct_dc_add_c, @function
ff_h264_idct_dc_add_c:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,0($5)
	addiu	$2,$2,32
	sra	$2,$2,6
#APP
 # 610 "h264idct.c" 1
	S32I2M xr1,$2
 # 0 "" 2
 # 611 "h264idct.c" 1
	S32SFL xr0,xr1,xr1,xr2,ptn3
 # 0 "" 2
 # 612 "h264idct.c" 1
	S32SFL xr12,xr2,xr2,xr13,ptn3
 # 0 "" 2
 # 616 "h264idct.c" 1
	S32LDD xr1,$4,0
 # 0 "" 2
 # 617 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 618 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 620 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 621 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
 # 625 "h264idct.c" 1
	S32LDIV xr1,$4,$6,0
 # 0 "" 2
 # 626 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 627 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 629 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 630 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
 # 634 "h264idct.c" 1
	S32LDIV xr1,$4,$6,0
 # 0 "" 2
 # 635 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 636 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 638 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 639 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
 # 643 "h264idct.c" 1
	S32LDIV xr1,$4,$6,0
 # 0 "" 2
 # 644 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 645 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 647 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 648 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
#NO_APP
	j	$31
	.end	ff_h264_idct_dc_add_c
	.size	ff_h264_idct_dc_add_c, .-ff_h264_idct_dc_add_c
	.align	2
	.globl	ff_h264_idct8_dc_add_c
	.set	nomips16
	.ent	ff_h264_idct8_dc_add_c
	.type	ff_h264_idct8_dc_add_c, @function
ff_h264_idct8_dc_add_c:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lh	$2,0($5)
	addiu	$2,$2,32
	sra	$2,$2,6
#APP
 # 679 "h264idct.c" 1
	S32I2M xr1,$2
 # 0 "" 2
 # 680 "h264idct.c" 1
	S32SFL xr0,xr1,xr1,xr2,ptn3
 # 0 "" 2
 # 681 "h264idct.c" 1
	S32SFL xr12,xr2,xr2,xr13,ptn3
 # 0 "" 2
 # 685 "h264idct.c" 1
	S32LDD xr1,$4,0
 # 0 "" 2
 # 686 "h264idct.c" 1
	S32LDD xr3,$4,4
 # 0 "" 2
 # 687 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 688 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 690 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 691 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
 # 694 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 695 "h264idct.c" 1
	Q8ACCE xr4,xr3,xr0,xr5,AA
 # 0 "" 2
 # 697 "h264idct.c" 1
	Q16SAT xr3,xr4,xr5
 # 0 "" 2
 # 698 "h264idct.c" 1
	S32STD xr1,$4,4
 # 0 "" 2
 # 702 "h264idct.c" 1
	S32LDIV xr1,$4,$6,0
 # 0 "" 2
 # 703 "h264idct.c" 1
	S32LDD xr3,$4,4
 # 0 "" 2
 # 704 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 705 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 707 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 708 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
 # 711 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 712 "h264idct.c" 1
	Q8ACCE xr4,xr3,xr0,xr5,AA
 # 0 "" 2
 # 714 "h264idct.c" 1
	Q16SAT xr3,xr4,xr5
 # 0 "" 2
 # 715 "h264idct.c" 1
	S32STD xr1,$4,4
 # 0 "" 2
 # 719 "h264idct.c" 1
	S32LDIV xr1,$4,$6,0
 # 0 "" 2
 # 720 "h264idct.c" 1
	S32LDD xr3,$4,4
 # 0 "" 2
 # 721 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 722 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 724 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 725 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
 # 728 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 729 "h264idct.c" 1
	Q8ACCE xr4,xr3,xr0,xr5,AA
 # 0 "" 2
 # 731 "h264idct.c" 1
	Q16SAT xr3,xr4,xr5
 # 0 "" 2
 # 732 "h264idct.c" 1
	S32STD xr1,$4,4
 # 0 "" 2
 # 736 "h264idct.c" 1
	S32LDIV xr1,$4,$6,0
 # 0 "" 2
 # 737 "h264idct.c" 1
	S32LDD xr3,$4,4
 # 0 "" 2
 # 738 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 739 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 741 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 742 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
 # 745 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 746 "h264idct.c" 1
	Q8ACCE xr4,xr3,xr0,xr5,AA
 # 0 "" 2
 # 748 "h264idct.c" 1
	Q16SAT xr3,xr4,xr5
 # 0 "" 2
 # 749 "h264idct.c" 1
	S32STD xr1,$4,4
 # 0 "" 2
 # 753 "h264idct.c" 1
	S32LDIV xr1,$4,$6,0
 # 0 "" 2
 # 754 "h264idct.c" 1
	S32LDD xr3,$4,4
 # 0 "" 2
 # 755 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 756 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 758 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 759 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
 # 762 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 763 "h264idct.c" 1
	Q8ACCE xr4,xr3,xr0,xr5,AA
 # 0 "" 2
 # 765 "h264idct.c" 1
	Q16SAT xr3,xr4,xr5
 # 0 "" 2
 # 766 "h264idct.c" 1
	S32STD xr1,$4,4
 # 0 "" 2
 # 770 "h264idct.c" 1
	S32LDIV xr1,$4,$6,0
 # 0 "" 2
 # 771 "h264idct.c" 1
	S32LDD xr3,$4,4
 # 0 "" 2
 # 772 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 773 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 775 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 776 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
 # 779 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 780 "h264idct.c" 1
	Q8ACCE xr4,xr3,xr0,xr5,AA
 # 0 "" 2
 # 782 "h264idct.c" 1
	Q16SAT xr3,xr4,xr5
 # 0 "" 2
 # 783 "h264idct.c" 1
	S32STD xr1,$4,4
 # 0 "" 2
 # 787 "h264idct.c" 1
	S32LDIV xr1,$4,$6,0
 # 0 "" 2
 # 788 "h264idct.c" 1
	S32LDD xr3,$4,4
 # 0 "" 2
 # 789 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 790 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 792 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 793 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
 # 796 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 797 "h264idct.c" 1
	Q8ACCE xr4,xr3,xr0,xr5,AA
 # 0 "" 2
 # 799 "h264idct.c" 1
	Q16SAT xr3,xr4,xr5
 # 0 "" 2
 # 800 "h264idct.c" 1
	S32STD xr1,$4,4
 # 0 "" 2
 # 804 "h264idct.c" 1
	S32LDIV xr1,$4,$6,0
 # 0 "" 2
 # 805 "h264idct.c" 1
	S32LDD xr3,$4,4
 # 0 "" 2
 # 806 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 807 "h264idct.c" 1
	Q8ACCE xr4,xr1,xr0,xr5,AA
 # 0 "" 2
 # 809 "h264idct.c" 1
	Q16SAT xr1,xr4,xr5
 # 0 "" 2
 # 810 "h264idct.c" 1
	S32STD xr1,$4,0
 # 0 "" 2
 # 813 "h264idct.c" 1
	D32SLL xr4,xr12,xr13,xr5,0
 # 0 "" 2
 # 814 "h264idct.c" 1
	Q8ACCE xr4,xr3,xr0,xr5,AA
 # 0 "" 2
 # 816 "h264idct.c" 1
	Q16SAT xr3,xr4,xr5
 # 0 "" 2
 # 817 "h264idct.c" 1
	S32STD xr1,$4,4
 # 0 "" 2
#NO_APP
	j	$31
	.end	ff_h264_idct8_dc_add_c
	.size	ff_h264_idct8_dc_add_c, .-ff_h264_idct8_dc_add_c
	.ident	"GCC: (GNU) 4.4.2"
