;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
	.module cpm
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _kbhit
	.globl _putchar
	.globl _bdos
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
	G$putchar$0$0	= .
	.globl	G$putchar$0$0
	C$cpm.c$14$0_0$4	= .
	.globl	C$cpm.c$14$0_0$4
;/workspace/idp-udev/src/ulibc/cpm.c:14: int putchar(int c) {
;	---------------------------------
; Function putchar
; ---------------------------------
_putchar::
	ex	de, hl
	C$cpm.c$16$1_0$4	= .
	.globl	C$cpm.c$16$1_0$4
;/workspace/idp-udev/src/ulibc/cpm.c:16: if ((char)c=='\n') {
	ld	a, e
	sub	a, #0x0a
	jr	NZ, 00102$
	C$cpm.c$17$2_0$5	= .
	.globl	C$cpm.c$17$2_0$5
;/workspace/idp-udev/src/ulibc/cpm.c:17: bdos(C_WRITE,'\r');
	push	de
	ld	de, #0x000d
	ld	a, #0x02
	call	_bdos
	C$cpm.c$18$2_0$5	= .
	.globl	C$cpm.c$18$2_0$5
;/workspace/idp-udev/src/ulibc/cpm.c:18: bdos(C_WRITE,'\n');
	ld	de, #0x000a
	ld	a, #0x02
	call	_bdos
	pop	de
	ret
00102$:
	C$cpm.c$19$1_0$4	= .
	.globl	C$cpm.c$19$1_0$4
;/workspace/idp-udev/src/ulibc/cpm.c:19: } else bdos(C_WRITE,c);
	push	de
	ld	a, #0x02
	call	_bdos
	pop	de
	C$cpm.c$20$1_0$4	= .
	.globl	C$cpm.c$20$1_0$4
;/workspace/idp-udev/src/ulibc/cpm.c:20: return c;
	C$cpm.c$21$1_0$4	= .
	.globl	C$cpm.c$21$1_0$4
;/workspace/idp-udev/src/ulibc/cpm.c:21: }
	C$cpm.c$21$1_0$4	= .
	.globl	C$cpm.c$21$1_0$4
	XG$putchar$0$0	= .
	.globl	XG$putchar$0$0
	ret
	G$kbhit$0$0	= .
	.globl	G$kbhit$0$0
	C$cpm.c$23$1_0$7	= .
	.globl	C$cpm.c$23$1_0$7
;/workspace/idp-udev/src/ulibc/cpm.c:23: int kbhit(void) {
;	---------------------------------
; Function kbhit
; ---------------------------------
_kbhit::
	C$cpm.c$24$1_0$7	= .
	.globl	C$cpm.c$24$1_0$7
;/workspace/idp-udev/src/ulibc/cpm.c:24: return bdos(C_RAWIO,0xff);
	ld	de, #0x00ff
	ld	a, #0x06
	call	_bdos
	ld	e, a
	ld	d, #0x00
	C$cpm.c$25$1_0$7	= .
	.globl	C$cpm.c$25$1_0$7
;/workspace/idp-udev/src/ulibc/cpm.c:25: }
	C$cpm.c$25$1_0$7	= .
	.globl	C$cpm.c$25$1_0$7
	XG$kbhit$0$0	= .
	.globl	XG$kbhit$0$0
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
