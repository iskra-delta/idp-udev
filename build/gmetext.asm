;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
	.module gmetext
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gmetext
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	G$gmetext$0$0	= .
	.globl	G$gmetext$0$0
	C$gmetext.c$22$0_0$18	= .
	.globl	C$gmetext.c$22$0_0$18
;/workspace/idp-udev/src/ugpx/gmetext.c:22: void gmetext(void *font, char *text, dim_t *dim) {   
;	---------------------------------
; Function gmetext
; ---------------------------------
_gmetext::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-10
	add	iy, sp
	ld	sp, iy
	ld	-2 (ix), e
	ld	-1 (ix), d
	C$gmetext.c$23$1_0$18	= .
	.globl	C$gmetext.c$23$1_0$18
;/workspace/idp-udev/src/ugpx/gmetext.c:23: uint8_t *f8=(uint8_t *)font, *g8;
	ex	de, hl
	C$gmetext.c$24$1_0$18	= .
	.globl	C$gmetext.c$24$1_0$18
;/workspace/idp-udev/src/ugpx/gmetext.c:24: uint8_t hsh=*(f8)&0x0f;
	ld	a, (de)
	and	a, #0x0f
	ld	-10 (ix), a
	C$gmetext.c$25$1_0$18	= .
	.globl	C$gmetext.c$25$1_0$18
;/workspace/idp-udev/src/ugpx/gmetext.c:25: uint8_t first_ascii=f8[FONT_1STASCII_NDX];
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	ld	-9 (ix), a
	C$gmetext.c$26$1_0$18	= .
	.globl	C$gmetext.c$26$1_0$18
;/workspace/idp-udev/src/ugpx/gmetext.c:26: dim->h=f8[FONT_HEIGHT_NDX] + 1; /* store height */
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	inc	bc
	inc	bc
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	inc	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
	C$gmetext.c$27$1_0$18	= .
	.globl	C$gmetext.c$27$1_0$18
;/workspace/idp-udev/src/ugpx/gmetext.c:27: dim->w=0;
	ld	a, 4 (ix)
	ld	-8 (ix), a
	ld	a, 5 (ix)
	ld	-7 (ix), a
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	C$gmetext.c$29$1_1$19	= .
	.globl	C$gmetext.c$29$1_1$19
;/workspace/idp-udev/src/ugpx/gmetext.c:29: uint16_t *offstbl=(uint16_t *)(f8+FONT_OFFSET_TBL);
	ld	hl, #0x0005
	add	hl, de
	ld	-6 (ix), l
	ld	-5 (ix), h
	C$gmetext.c$30$1_1$19	= .
	.globl	C$gmetext.c$30$1_1$19
;/workspace/idp-udev/src/ugpx/gmetext.c:30: while(*text) {
00101$:
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
	C$gmetext.c$31$2_1$20	= .
	.globl	C$gmetext.c$31$2_1$20
;/workspace/idp-udev/src/ugpx/gmetext.c:31: g8 = f8 + (offstbl[(*text)-first_ascii]);
	ld	l, a
	ld	h, #0x00
	ld	c, -9 (ix)
	ld	b, #0x00
	cp	a, a
	sbc	hl, bc
	add	hl, hl
	ld	c, -6 (ix)
	ld	b, -5 (ix)
	add	hl, bc
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	-4 (ix), l
	ld	-3 (ix), h
	C$gmetext.c$32$2_1$20	= .
	.globl	C$gmetext.c$32$2_1$20
;/workspace/idp-udev/src/ugpx/gmetext.c:32: dim->w = dim->w + (g8[GPY_WIDTH_OFFSET] + 1) + hsh;
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	inc	hl
	add	hl, bc
	ld	c, -10 (ix)
	ld	b, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	C$gmetext.c$33$2_1$20	= .
	.globl	C$gmetext.c$33$2_1$20
;/workspace/idp-udev/src/ugpx/gmetext.c:33: text++;
	inc	-2 (ix)
	jr	NZ, 00101$
	inc	-1 (ix)
	jr	00101$
00104$:
	C$gmetext.c$35$1_1$18	= .
	.globl	C$gmetext.c$35$1_1$18
;/workspace/idp-udev/src/ugpx/gmetext.c:35: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
