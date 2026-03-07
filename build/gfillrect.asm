;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
	.module gfillrect
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gdrawline
	.globl _gfillrect
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
	G$gfillrect$0$0	= .
	.globl	G$gfillrect$0$0
	C$gfillrect.c$14$0_0$18	= .
	.globl	C$gfillrect.c$14$0_0$18
;/workspace/idp-udev/src/ugpx/gfillrect.c:14: void gfillrect(rect_t *r) {
;	---------------------------------
; Function gfillrect
; ---------------------------------
_gfillrect::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-10
	add	iy, sp
	ld	sp, iy
	ld	-2 (ix), l
	ld	-1 (ix), h
	C$gfillrect.c$15$1_0$18	= .
	.globl	C$gfillrect.c$15$1_0$18
;/workspace/idp-udev/src/ugpx/gfillrect.c:15: if (r->y1 > r->y0)
	ld	a, -2 (ix)
	add	a, #0x06
	ld	-10 (ix), a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	-9 (ix), a
	pop	hl
	push	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, -2 (ix)
	add	a, #0x02
	ld	-8 (ix), a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	-7 (ix), a
	pop	de
	pop	hl
	push	hl
	push	de
	ld	a, (hl)
	ld	-6 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-5 (ix), a
	C$gfillrect.c$16$1_0$18	= .
	.globl	C$gfillrect.c$16$1_0$18
;/workspace/idp-udev/src/ugpx/gfillrect.c:16: for (int y=r->y0; y<=r->y1; y++)
	ld	a, -2 (ix)
	add	a, #0x04
	ld	e, a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	d, a
	C$gfillrect.c$17$1_0$18	= .
	.globl	C$gfillrect.c$17$1_0$18
;/workspace/idp-udev/src/ugpx/gfillrect.c:17: gdrawline(r->x0, y, r->x1, y);
	ld	a, -2 (ix)
	ld	-4 (ix), a
	ld	a, -1 (ix)
	ld	-3 (ix), a
	C$gfillrect.c$15$1_0$18	= .
	.globl	C$gfillrect.c$15$1_0$18
;/workspace/idp-udev/src/ugpx/gfillrect.c:15: if (r->y1 > r->y0)
	ld	a, -6 (ix)
	sub	a, c
	ld	a, -5 (ix)
	sbc	a, b
	jp	PO, 00151$
	xor	a, #0x80
00151$:
	jp	P, 00104$
	C$gfillrect.c$16$2_0$19	= .
	.globl	C$gfillrect.c$16$2_0$19
;/workspace/idp-udev/src/ugpx/gfillrect.c:16: for (int y=r->y0; y<=r->y1; y++)
	ld	c, -6 (ix)
	ld	b, -5 (ix)
	push	de
	pop	iy
00107$:
	pop	hl
	push	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jp	PO, 00152$
	xor	a, #0x80
00152$:
	jp	M, 00112$
	C$gfillrect.c$17$2_0$19	= .
	.globl	C$gfillrect.c$17$2_0$19
;/workspace/idp-udev/src/ugpx/gfillrect.c:17: gdrawline(r->x0, y, r->x1, y);
	ld	e, 0 (iy)
	ld	d, 1 (iy)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	push	bc
	push	iy
	push	bc
	push	de
	ld	e, c
	ld	d, b
	call	_gdrawline
	pop	iy
	pop	bc
	C$gfillrect.c$16$2_0$19	= .
	.globl	C$gfillrect.c$16$2_0$19
;/workspace/idp-udev/src/ugpx/gfillrect.c:16: for (int y=r->y0; y<=r->y1; y++)
	inc	bc
	jr	00107$
00104$:
	C$gfillrect.c$19$2_0$20	= .
	.globl	C$gfillrect.c$19$2_0$20
;/workspace/idp-udev/src/ugpx/gfillrect.c:19: for (int y=r->y1; y<r->y0; y++)
	ld	-6 (ix), e
	ld	-5 (ix), d
00110$:
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	a, b
	sbc	a, d
	jp	PO, 00153$
	xor	a, #0x80
00153$:
	jp	P, 00112$
	C$gfillrect.c$20$2_0$20	= .
	.globl	C$gfillrect.c$20$2_0$20
;/workspace/idp-udev/src/ugpx/gfillrect.c:20: gdrawline(r->x0, y, r->x1, y);
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	push	bc
	push	bc
	push	de
	ld	e, c
	ld	d, b
	call	_gdrawline
	pop	bc
	C$gfillrect.c$19$2_0$20	= .
	.globl	C$gfillrect.c$19$2_0$20
;/workspace/idp-udev/src/ugpx/gfillrect.c:19: for (int y=r->y1; y<r->y0; y++)
	inc	bc
	jr	00110$
00112$:
	C$gfillrect.c$21$1_0$18	= .
	.globl	C$gfillrect.c$21$1_0$18
;/workspace/idp-udev/src/ugpx/gfillrect.c:21: }
	ld	sp, ix
	pop	ix
	C$gfillrect.c$21$1_0$18	= .
	.globl	C$gfillrect.c$21$1_0$18
	XG$gfillrect$0$0	= .
	.globl	XG$gfillrect$0$0
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
