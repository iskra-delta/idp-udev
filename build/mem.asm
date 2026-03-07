;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
	.module mem
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memset
	.globl __list_find
	.globl __list_match_eq
	.globl _malloc
	.globl _calloc
	.globl _free
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
	Fmem$_match_free_block$0$0	= .
	.globl	Fmem$_match_free_block$0$0
	C$mem.c$15$0_0$12	= .
	.globl	C$mem.c$15$0_0$12
;/workspace/idp-udev/src/ulibc/mem.c:15: static unsigned char _match_free_block(list_header_t *p, unsigned int size)
;	---------------------------------
; Function _match_free_block
; ---------------------------------
__match_free_block:
	C$mem.c$17$1_0$12	= .
	.globl	C$mem.c$17$1_0$12
;/workspace/idp-udev/src/ulibc/mem.c:17: block_t *b = (block_t *)p;
	C$mem.c$18$1_0$12	= .
	.globl	C$mem.c$18$1_0$12
;/workspace/idp-udev/src/ulibc/mem.c:18: return !(b->stat & ALLOCATED) && b->size >= size;
	ld	c,l
	ld	b,h
	inc	hl
	inc	hl
	ld	a, (hl)
	and	a, #0x01
	jr	NZ, 00103$
	ld	hl, #3
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, c
	sub	a, e
	ld	a, b
	sbc	a, d
	jr	NC, 00104$
00103$:
	xor	a, a
	ret
00104$:
	ld	a, #0x01
	C$mem.c$19$1_0$12	= .
	.globl	C$mem.c$19$1_0$12
;/workspace/idp-udev/src/ulibc/mem.c:19: }
	C$mem.c$19$1_0$12	= .
	.globl	C$mem.c$19$1_0$12
	XFmem$_match_free_block$0$0	= .
	.globl	XFmem$_match_free_block$0$0
	ret
	Fmem$_merge_with_next$0$0	= .
	.globl	Fmem$_merge_with_next$0$0
	C$mem.c$22$1_0$14	= .
	.globl	C$mem.c$22$1_0$14
;/workspace/idp-udev/src/ulibc/mem.c:22: static void _merge_with_next(block_t *b)
;	---------------------------------
; Function _merge_with_next
; ---------------------------------
__merge_with_next:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ex	de, hl
	C$mem.c$24$1_0$14	= .
	.globl	C$mem.c$24$1_0$14
;/workspace/idp-udev/src/ulibc/mem.c:24: block_t *bnext = b->hdr.next;
	inc	sp
	inc	sp
	push	de
	pop	hl
	push	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	pop	iy
	C$mem.c$25$1_0$14	= .
	.globl	C$mem.c$25$1_0$14
;/workspace/idp-udev/src/ulibc/mem.c:25: b->size += (BLK_SIZE + bnext->size);
	inc	de
	inc	de
	inc	de
	ld	l, e
	ld	h, d
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	iy
	pop	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	add	hl, bc
	ld	a, l
	ld	(de), a
	inc	de
	ld	a, h
	ld	(de), a
	C$mem.c$26$1_0$14	= .
	.globl	C$mem.c$26$1_0$14
;/workspace/idp-udev/src/ulibc/mem.c:26: b->hdr.next = bnext->hdr.next;
	ld	c, 0 (iy)
	ld	b, 1 (iy)
	pop	hl
	push	hl
	ld	(hl), c
	inc	hl
	ld	(hl), b
	C$mem.c$27$1_0$14	= .
	.globl	C$mem.c$27$1_0$14
;/workspace/idp-udev/src/ulibc/mem.c:27: }
	ld	sp, ix
	pop	ix
	C$mem.c$27$1_0$14	= .
	.globl	C$mem.c$27$1_0$14
	XFmem$_merge_with_next$0$0	= .
	.globl	XFmem$_merge_with_next$0$0
	ret
	Fmem$_split$0$0	= .
	.globl	Fmem$_split$0$0
	C$mem.c$30$1_0$16	= .
	.globl	C$mem.c$30$1_0$16
;/workspace/idp-udev/src/ulibc/mem.c:30: static void _split(block_t *b, unsigned int size)
;	---------------------------------
; Function _split
; ---------------------------------
__split:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-8
	add	iy, sp
	ld	sp, iy
	ld	c, l
	ld	b, h
	ld	-2 (ix), e
	ld	-1 (ix), d
	C$mem.c$33$1_0$16	= .
	.globl	C$mem.c$33$1_0$16
;/workspace/idp-udev/src/ulibc/mem.c:33: nw = (block_t *)((unsigned int)(b->data) + size);
	ld	hl, #0x0005
	add	hl, bc
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	add	hl, de
	push	hl
	pop	iy
	C$mem.c$34$1_0$16	= .
	.globl	C$mem.c$34$1_0$16
;/workspace/idp-udev/src/ulibc/mem.c:34: nw->hdr.next = b->hdr.next;
	push	iy
	pop	de
	inc	sp
	inc	sp
	push	bc
	pop	hl
	push	hl
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	(de), a
	inc	de
	ld	a, h
	ld	(de), a
	C$mem.c$35$1_0$16	= .
	.globl	C$mem.c$35$1_0$16
;/workspace/idp-udev/src/ulibc/mem.c:35: nw->size = b->size - (size + BLK_SIZE);
	push	iy
	pop	de
	inc	de
	inc	de
	inc	de
	ld	hl, #0x0003
	add	hl, bc
	ld	-6 (ix), l
	ld	-5 (ix), h
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	a, -2 (ix)
	add	a, #0x05
	ld	-4 (ix), a
	ld	a, -1 (ix)
	adc	a, #0x00
	ld	-3 (ix), a
	ld	a, l
	sub	a, -4 (ix)
	ld	l, a
	ld	a, h
	sbc	a, -3 (ix)
	ld	h, a
	ld	a, l
	ld	(de), a
	inc	de
	ld	a, h
	ld	(de), a
	C$mem.c$36$1_0$16	= .
	.globl	C$mem.c$36$1_0$16
;/workspace/idp-udev/src/ulibc/mem.c:36: nw->stat = b->stat;
	push	iy
	pop	de
	inc	de
	inc	de
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	(de), a
	C$mem.c$39$1_0$16	= .
	.globl	C$mem.c$39$1_0$16
;/workspace/idp-udev/src/ulibc/mem.c:39: b->size = size;
	pop	de
	pop	hl
	push	hl
	push	de
	ld	a, -2 (ix)
	ld	(hl), a
	inc	hl
	ld	a, -1 (ix)
	ld	(hl), a
	C$mem.c$40$1_0$16	= .
	.globl	C$mem.c$40$1_0$16
;/workspace/idp-udev/src/ulibc/mem.c:40: b->hdr.next = nw;
	push	iy
	pop	bc
	pop	hl
	push	hl
	ld	(hl), c
	inc	hl
	ld	(hl), b
	C$mem.c$41$1_0$16	= .
	.globl	C$mem.c$41$1_0$16
;/workspace/idp-udev/src/ulibc/mem.c:41: }
	ld	sp, ix
	pop	ix
	C$mem.c$41$1_0$16	= .
	.globl	C$mem.c$41$1_0$16
	XFmem$_split$0$0	= .
	.globl	XFmem$_split$0$0
	ret
	G$malloc$0$0	= .
	.globl	G$malloc$0$0
	C$mem.c$44$1_0$18	= .
	.globl	C$mem.c$44$1_0$18
;/workspace/idp-udev/src/ulibc/mem.c:44: void *malloc(unsigned int size)
;	---------------------------------
; Function malloc
; ---------------------------------
_malloc::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	ld	-2 (ix), l
	ld	-1 (ix), h
	C$mem.c$51$1_0$18	= .
	.globl	C$mem.c$51$1_0$18
;/workspace/idp-udev/src/ulibc/mem.c:51: (list_header_t **)&prev,
	C$mem.c$50$1_0$18	= .
	.globl	C$mem.c$50$1_0$18
;/workspace/idp-udev/src/ulibc/mem.c:50: (list_header_t *)&_heap,
	pop	de
	pop	hl
	push	hl
	push	de
	push	hl
	ld	hl, #__match_free_block
	push	hl
	ld	hl, #4
	add	hl, sp
	ex	de, hl
	ld	hl, #__heap
	call	__list_find
	ld	c, e
	ld	b, d
	C$mem.c$54$1_0$18	= .
	.globl	C$mem.c$54$1_0$18
;/workspace/idp-udev/src/ulibc/mem.c:54: if (b)
	ld	a, b
	or	a, c
	jr	Z, 00104$
	C$mem.c$56$2_0$19	= .
	.globl	C$mem.c$56$2_0$19
;/workspace/idp-udev/src/ulibc/mem.c:56: if (b->size - size > BLK_SIZE + MIN_CHUNK_SIZE)
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, e
	sub	a, -2 (ix)
	ld	e, a
	ld	a, d
	sbc	a, -1 (ix)
	ld	d, a
	ld	a, #0x09
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00102$
	C$mem.c$57$2_0$19	= .
	.globl	C$mem.c$57$2_0$19
;/workspace/idp-udev/src/ulibc/mem.c:57: _split(b, size);
	push	bc
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	l, c
	ld	h, b
	call	__split
	pop	bc
00102$:
	C$mem.c$58$2_0$19	= .
	.globl	C$mem.c$58$2_0$19
;/workspace/idp-udev/src/ulibc/mem.c:58: b->stat = ALLOCATED;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0x01
	C$mem.c$59$2_0$19	= .
	.globl	C$mem.c$59$2_0$19
;/workspace/idp-udev/src/ulibc/mem.c:59: return b->data;
	ld	hl, #0x0005
	add	hl, bc
	ex	de, hl
	jr	00106$
00104$:
	C$mem.c$62$1_0$18	= .
	.globl	C$mem.c$62$1_0$18
;/workspace/idp-udev/src/ulibc/mem.c:62: return NULL;
	ld	de, #0x0000
00106$:
	C$mem.c$63$1_0$18	= .
	.globl	C$mem.c$63$1_0$18
;/workspace/idp-udev/src/ulibc/mem.c:63: }
	ld	sp, ix
	pop	ix
	C$mem.c$63$1_0$18	= .
	.globl	C$mem.c$63$1_0$18
	XG$malloc$0$0	= .
	.globl	XG$malloc$0$0
	ret
	G$calloc$0$0	= .
	.globl	G$calloc$0$0
	C$mem.c$67$1_0$22	= .
	.globl	C$mem.c$67$1_0$22
;/workspace/idp-udev/src/ulibc/mem.c:67: void* calloc (unsigned int num, unsigned int size) {
;	---------------------------------
; Function calloc
; ---------------------------------
_calloc::
	C$mem.c$68$1_0$22	= .
	.globl	C$mem.c$68$1_0$22
;/workspace/idp-udev/src/ulibc/mem.c:68: void *p=malloc(num*size);
	call	__mulint
	ld	c, e
	ld	b, d
	push	bc
	ld	l, c
	ld	h, b
	call	_malloc
	pop	bc
	ld	l, e
	C$mem.c$69$1_0$22	= .
	.globl	C$mem.c$69$1_0$22
;/workspace/idp-udev/src/ulibc/mem.c:69: if (p==NULL) return NULL;
	ld	a,d
	ld	h,a
	or	a, e
	jr	NZ, 00102$
	ld	de, #0x0000
	ret
00102$:
	C$mem.c$70$1_0$22	= .
	.globl	C$mem.c$70$1_0$22
;/workspace/idp-udev/src/ulibc/mem.c:70: return memset(p,0,num*size);
	push	bc
	ld	de, #0x0000
	call	_memset
	C$mem.c$71$1_0$22	= .
	.globl	C$mem.c$71$1_0$22
;/workspace/idp-udev/src/ulibc/mem.c:71: }
	C$mem.c$71$1_0$22	= .
	.globl	C$mem.c$71$1_0$22
	XG$calloc$0$0	= .
	.globl	XG$calloc$0$0
	ret
	G$free$0$0	= .
	.globl	G$free$0$0
	C$mem.c$74$1_0$24	= .
	.globl	C$mem.c$74$1_0$24
;/workspace/idp-udev/src/ulibc/mem.c:74: void free(void *p)
;	---------------------------------
; Function free
; ---------------------------------
_free::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	C$mem.c$80$1_0$24	= .
	.globl	C$mem.c$80$1_0$24
;/workspace/idp-udev/src/ulibc/mem.c:80: b = (block_t *)((unsigned int)p - BLK_SIZE);
	ld	bc, #0xfffb
	add	hl,bc
	ld	c, l
	ld	b, h
	C$mem.c$83$1_0$24	= .
	.globl	C$mem.c$83$1_0$24
;/workspace/idp-udev/src/ulibc/mem.c:83: if (_list_find((list_header_t *)&_heap, (list_header_t **)&prev, _list_match_eq, (unsigned int)b))
	ld	e, c
	ld	d, b
	push	bc
	push	de
	ld	hl, #__list_match_eq
	push	hl
	ld	hl, #6
	add	hl, sp
	ex	de, hl
	ld	hl, #__heap
	call	__list_find
	pop	bc
	ld	a, d
	or	a, e
	jr	Z, 00109$
	C$mem.c$85$2_0$25	= .
	.globl	C$mem.c$85$2_0$25
;/workspace/idp-udev/src/ulibc/mem.c:85: b->stat = NEW;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	(hl), #0x00
	C$mem.c$87$2_0$25	= .
	.globl	C$mem.c$87$2_0$25
;/workspace/idp-udev/src/ulibc/mem.c:87: if (prev && !(prev->stat & ALLOCATED))
	ld	a, -1 (ix)
	or	a, -2 (ix)
	jr	Z, 00102$
	pop	de
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a, (hl)
	rrca
	jr	C, 00102$
	C$mem.c$89$3_0$26	= .
	.globl	C$mem.c$89$3_0$26
;/workspace/idp-udev/src/ulibc/mem.c:89: _merge_with_next(prev);
	ex	de, hl
	call	__merge_with_next
	C$mem.c$90$3_0$26	= .
	.globl	C$mem.c$90$3_0$26
;/workspace/idp-udev/src/ulibc/mem.c:90: b = prev;
	pop	bc
	push	bc
00102$:
	C$mem.c$93$2_0$25	= .
	.globl	C$mem.c$93$2_0$25
;/workspace/idp-udev/src/ulibc/mem.c:93: if (b->hdr.next && !(((block_t *)(b->hdr.next))->stat & ALLOCATED))
	ld	l, c
	ld	h, b
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, d
	or	a, e
	jr	Z, 00109$
	inc	de
	inc	de
	ld	a, (de)
	rrca
	jr	C, 00109$
	C$mem.c$94$2_0$25	= .
	.globl	C$mem.c$94$2_0$25
;/workspace/idp-udev/src/ulibc/mem.c:94: _merge_with_next(b);
	ld	l, c
	ld	h, b
	call	__merge_with_next
00109$:
	C$mem.c$96$1_0$24	= .
	.globl	C$mem.c$96$1_0$24
;/workspace/idp-udev/src/ulibc/mem.c:96: }
	ld	sp, ix
	pop	ix
	C$mem.c$96$1_0$24	= .
	.globl	C$mem.c$96$1_0$24
	XG$free$0$0	= .
	.globl	XG$free$0$0
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
