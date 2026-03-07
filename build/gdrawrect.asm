;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
	.module gdrawrect
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gdrawline
	.globl _gdrawrect
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
	G$gdrawrect$0$0	= .
	.globl	G$gdrawrect$0$0
	C$gdrawrect.c$14$0_0$18	= .
	.globl	C$gdrawrect.c$14$0_0$18
;/workspace/idp-udev/src/ugpx/gdrawrect.c:14: void gdrawrect(rect_t *r) {
;	---------------------------------
; Function gdrawrect
; ---------------------------------
_gdrawrect::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	push	af
	ld	c, l
	ld	b, h
	C$gdrawrect.c$15$1_0$18	= .
	.globl	C$gdrawrect.c$15$1_0$18
;/workspace/idp-udev/src/ugpx/gdrawrect.c:15: gdrawline(r->x0, r->y0, r->x1, r->y0);
	ld	hl, #0x0002
	add	hl, bc
	ex	(sp), hl
	pop	hl
	push	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	iy, #0x0004
	add	iy, bc
	ld	a, 0 (iy)
	ld	-2 (ix), a
	ld	a, 1 (iy)
	ld	-1 (ix), a
	ld	-4 (ix), c
	ld	-3 (ix), b
	ld	l, c
	ld	h, b
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	push	bc
	push	iy
	push	de
	push	hl
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ex	(sp), hl
	call	_gdrawline
	pop	iy
	pop	bc
	C$gdrawrect.c$16$1_0$18	= .
	.globl	C$gdrawrect.c$16$1_0$18
;/workspace/idp-udev/src/ugpx/gdrawrect.c:16: gdrawline(r->x0, r->y0, r->x0, r->y1);
	ld	hl, #0x0006
	add	hl, bc
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	pop	hl
	push	hl
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	push	iy
	push	de
	push	bc
	ex	de, hl
	ld	l, c
	ld	h, b
	call	_gdrawline
	pop	iy
	C$gdrawrect.c$17$1_0$18	= .
	.globl	C$gdrawrect.c$17$1_0$18
;/workspace/idp-udev/src/ugpx/gdrawrect.c:17: gdrawline(r->x1, r->y0, r->x1, r->y1);
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	c, 0 (iy)
	ld	b, 1 (iy)
	pop	hl
	push	hl
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	push	iy
	push	de
	push	bc
	ex	de, hl
	ld	l, c
	ld	h, b
	call	_gdrawline
	pop	iy
	C$gdrawrect.c$18$1_0$18	= .
	.globl	C$gdrawrect.c$18$1_0$18
;/workspace/idp-udev/src/ugpx/gdrawrect.c:18: gdrawline(r->x0, r->y1, r->x1, r->y1); 
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	c, 0 (iy)
	ld	b, 1 (iy)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	push	de
	push	bc
	call	_gdrawline
	C$gdrawrect.c$19$1_0$18	= .
	.globl	C$gdrawrect.c$19$1_0$18
;/workspace/idp-udev/src/ugpx/gdrawrect.c:19: }
	ld	sp, ix
	pop	ix
	C$gdrawrect.c$19$1_0$18	= .
	.globl	C$gdrawrect.c$19$1_0$18
	XG$gdrawrect$0$0	= .
	.globl	XG$gdrawrect$0$0
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
