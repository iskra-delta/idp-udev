;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
	.module init
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __memory_init
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
	G$_memory_init$0$0	= .
	.globl	G$_memory_init$0$0
	C$init.c$15$0_0$12	= .
	.globl	C$init.c$15$0_0$12
;/workspace/idp-udev/src/ulibc/init.c:15: void _memory_init(void)
;	---------------------------------
; Function _memory_init
; ---------------------------------
__memory_init::
	C$init.c$18$1_0$12	= .
	.globl	C$init.c$18$1_0$12
;/workspace/idp-udev/src/ulibc/init.c:18: block_t *first = (block_t *)&_heap;
	C$init.c$19$1_0$12	= .
	.globl	C$init.c$19$1_0$12
;/workspace/idp-udev/src/ulibc/init.c:19: first->hdr.next = NULL;
	ld	hl, #0x0000
	ld	(__heap), hl
	C$init.c$20$1_0$12	= .
	.globl	C$init.c$20$1_0$12
;/workspace/idp-udev/src/ulibc/init.c:20: first->size = ( MEM_TOP - (unsigned int)&_heap ) - BLK_SIZE;
	ld	bc, #__heap+0
	ld	hl, #0xbffb
	cp	a, a
	sbc	hl, bc
	ld	((__heap + 3)), hl
	C$init.c$21$1_0$12	= .
	.globl	C$init.c$21$1_0$12
;/workspace/idp-udev/src/ulibc/init.c:21: first->stat = NEW;
	ld	hl, #__heap + 2
	ld	(hl), #0x00
	C$init.c$22$1_0$12	= .
	.globl	C$init.c$22$1_0$12
;/workspace/idp-udev/src/ulibc/init.c:22: }
	C$init.c$22$1_0$12	= .
	.globl	C$init.c$22$1_0$12
	XG$_memory_init$0$0	= .
	.globl	XG$_memory_init$0$0
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
