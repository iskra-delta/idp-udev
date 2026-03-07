;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
	.module gmegpy
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gmegpy
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
	G$gmegpy$0$0	= .
	.globl	G$gmegpy$0$0
	C$gmegpy.c$15$0_0$18	= .
	.globl	C$gmegpy.c$15$0_0$18
;/workspace/idp-udev/src/ugpx/gmegpy.c:15: void gmegpy(void *glyph, dim_t *dim) {   
;	---------------------------------
; Function gmegpy
; ---------------------------------
_gmegpy::
	C$gmegpy.c$16$1_0$18	= .
	.globl	C$gmegpy.c$16$1_0$18
;/workspace/idp-udev/src/ugpx/gmegpy.c:16: uint8_t *g8=(uint8_t *)glyph;
	C$gmegpy.c$17$1_0$18	= .
	.globl	C$gmegpy.c$17$1_0$18
;/workspace/idp-udev/src/ugpx/gmegpy.c:17: g8++; dim->w=(*g8)+1; g8++; dim->h=(*g8)+1; 
	inc	hl
	push	hl
	pop	iy
	ld	l, e
	ld	h, d
	ld	c, 0 (iy)
	ld	b, #0x00
	inc	bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
	inc	de
	inc	de
	ld	c, 1 (iy)
	ld	b, #0x00
	inc	bc
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
	C$gmegpy.c$18$1_0$18	= .
	.globl	C$gmegpy.c$18$1_0$18
;/workspace/idp-udev/src/ugpx/gmegpy.c:18: }
	C$gmegpy.c$18$1_0$18	= .
	.globl	C$gmegpy.c$18$1_0$18
	XG$gmegpy$0$0	= .
	.globl	XG$gmegpy$0$0
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
