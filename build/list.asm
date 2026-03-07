;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
	.module list
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __list_match_eq
	.globl __list_find
	.globl __list_insert
	.globl __list_append
	.globl __list_remove
	.globl __list_remove_first
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
	G$_list_match_eq$0$0	= .
	.globl	G$_list_match_eq$0$0
	C$list.c$14$0_0$9	= .
	.globl	C$list.c$14$0_0$9
;/workspace/idp-udev/src/ulibc/list.c:14: unsigned char _list_match_eq(list_header_t *p, unsigned int arg) {
;	---------------------------------
; Function _list_match_eq
; ---------------------------------
__list_match_eq::
	C$list.c$15$1_0$9	= .
	.globl	C$list.c$15$1_0$9
;/workspace/idp-udev/src/ulibc/list.c:15: return ( ((unsigned int)p) == arg );
	cp	a, a
	sbc	hl, de
	ld	a, #0x01
	ret	Z
	xor	a, a
	C$list.c$16$1_0$9	= .
	.globl	C$list.c$16$1_0$9
;/workspace/idp-udev/src/ulibc/list.c:16: }
	C$list.c$16$1_0$9	= .
	.globl	C$list.c$16$1_0$9
	XG$_list_match_eq$0$0	= .
	.globl	XG$_list_match_eq$0$0
	ret
	G$_list_find$0$0	= .
	.globl	G$_list_find$0$0
	C$list.c$18$1_0$12	= .
	.globl	C$list.c$18$1_0$12
;/workspace/idp-udev/src/ulibc/list.c:18: list_header_t* _list_find(
;	---------------------------------
; Function _list_find
; ---------------------------------
__list_find::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ld	c, l
	ld	b, h
	inc	sp
	inc	sp
	C$list.c$25$1_0$12	= .
	.globl	C$list.c$25$1_0$12
;/workspace/idp-udev/src/ulibc/list.c:25: *prev=NULL;
	ex	de,hl
	push	hl
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	C$list.c$26$1_0$12	= .
	.globl	C$list.c$26$1_0$12
;/workspace/idp-udev/src/ulibc/list.c:26: while (first && !match(first,the_arg)) {
00102$:
	ld	a, b
	or	a, c
	jr	Z, 00104$
	push	bc
	ld	e, 6 (ix)
	ld	d, 7 (ix)
	ld	l, c
	ld	h, b
	push	iy
	ex	(sp), hl
	ld	l, 4 (ix)
	ex	(sp), hl
	ex	(sp), hl
	ld	h, 5 (ix)
	ex	(sp), hl
	pop	iy
	call	___sdcc_call_iy
	pop	bc
	or	a, a
	jr	NZ, 00104$
	C$list.c$27$2_0$13	= .
	.globl	C$list.c$27$2_0$13
;/workspace/idp-udev/src/ulibc/list.c:27: *prev=first;
	pop	hl
	push	hl
	ld	(hl), c
	inc	hl
	ld	(hl), b
	C$list.c$28$2_0$13	= .
	.globl	C$list.c$28$2_0$13
;/workspace/idp-udev/src/ulibc/list.c:28: first=first->next;
	ld	l, c
	ld	h, b
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	jr	00102$
00104$:
	C$list.c$31$1_0$12	= .
	.globl	C$list.c$31$1_0$12
;/workspace/idp-udev/src/ulibc/list.c:31: return first; 
	ld	e, c
	ld	d, b
	C$list.c$32$1_0$12	= .
	.globl	C$list.c$32$1_0$12
;/workspace/idp-udev/src/ulibc/list.c:32: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
	G$_list_insert$0$0	= .
	.globl	G$_list_insert$0$0
	C$list.c$34$1_0$15	= .
	.globl	C$list.c$34$1_0$15
;/workspace/idp-udev/src/ulibc/list.c:34: list_header_t *_list_insert(list_header_t** first, list_header_t *el) {
;	---------------------------------
; Function _list_insert
; ---------------------------------
__list_insert::
	push	ix
	ld	ix,#0
	add	ix,sp
	C$list.c$35$1_0$15	= .
	.globl	C$list.c$35$1_0$15
;/workspace/idp-udev/src/ulibc/list.c:35: el->next=*first;
	push	de
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	dec	hl
	push	hl
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	pop	hl
	C$list.c$36$1_0$15	= .
	.globl	C$list.c$36$1_0$15
;/workspace/idp-udev/src/ulibc/list.c:36: *first=el;
	ld	(hl), e
	inc	hl
	ld	(hl), d
	C$list.c$37$1_0$15	= .
	.globl	C$list.c$37$1_0$15
;/workspace/idp-udev/src/ulibc/list.c:37: return el;
	C$list.c$38$1_0$15	= .
	.globl	C$list.c$38$1_0$15
;/workspace/idp-udev/src/ulibc/list.c:38: }
	ld	sp, ix
	pop	ix
	C$list.c$38$1_0$15	= .
	.globl	C$list.c$38$1_0$15
	XG$_list_insert$0$0	= .
	.globl	XG$_list_insert$0$0
	ret
	G$_list_append$0$0	= .
	.globl	G$_list_append$0$0
	C$list.c$40$1_0$17	= .
	.globl	C$list.c$40$1_0$17
;/workspace/idp-udev/src/ulibc/list.c:40: list_header_t *_list_append(list_header_t** first, list_header_t *el) {
;	---------------------------------
; Function _list_append
; ---------------------------------
__list_append::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	ld	c, l
	ld	b, h
	C$list.c$44$1_0$17	= .
	.globl	C$list.c$44$1_0$17
;/workspace/idp-udev/src/ulibc/list.c:44: el->next=NULL;		/* it's always the last element */
	ld	l, e
	ld	h, d
	xor	a, a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	C$list.c$46$1_0$17	= .
	.globl	C$list.c$46$1_0$17
;/workspace/idp-udev/src/ulibc/list.c:46: if (*first==NULL)	/* empty list? */
	ld	a, (bc)
	ld	-2 (ix), a
	inc	bc
	ld	a, (bc)
	ld	-1 (ix), a
	dec	bc
	ld	a, -1 (ix)
	or	a, -2 (ix)
	jr	NZ, 00105$
	C$list.c$47$1_0$17	= .
	.globl	C$list.c$47$1_0$17
;/workspace/idp-udev/src/ulibc/list.c:47: *first=el;
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00106$
00105$:
	C$list.c$49$2_0$18	= .
	.globl	C$list.c$49$2_0$18
;/workspace/idp-udev/src/ulibc/list.c:49: current=*first;
	pop	bc
	push	bc
	C$list.c$50$2_0$18	= .
	.globl	C$list.c$50$2_0$18
;/workspace/idp-udev/src/ulibc/list.c:50: while (current->next) current=current->next;
00101$:
	inc	sp
	inc	sp
	ld	l, c
	ld	h, b
	push	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, b
	or	a, c
	jr	NZ, 00101$
	C$list.c$51$2_0$18	= .
	.globl	C$list.c$51$2_0$18
;/workspace/idp-udev/src/ulibc/list.c:51: current->next=el;
	ld	c, e
	ld	b, d
	pop	hl
	push	hl
	ld	(hl), c
	inc	hl
	ld	(hl), b
00106$:
	C$list.c$53$1_0$17	= .
	.globl	C$list.c$53$1_0$17
;/workspace/idp-udev/src/ulibc/list.c:53: return el;
	C$list.c$54$1_0$17	= .
	.globl	C$list.c$54$1_0$17
;/workspace/idp-udev/src/ulibc/list.c:54: }
	ld	sp, ix
	pop	ix
	C$list.c$54$1_0$17	= .
	.globl	C$list.c$54$1_0$17
	XG$_list_append$0$0	= .
	.globl	XG$_list_append$0$0
	ret
	G$_list_remove$0$0	= .
	.globl	G$_list_remove$0$0
	C$list.c$56$1_0$20	= .
	.globl	C$list.c$56$1_0$20
;/workspace/idp-udev/src/ulibc/list.c:56: list_header_t *_list_remove(list_header_t **first, list_header_t *el) {
;	---------------------------------
; Function _list_remove
; ---------------------------------
__list_remove::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-12
	add	iy, sp
	ld	sp, iy
	ld	-2 (ix), l
	ld	-1 (ix), h
	ld	-4 (ix), e
	ld	-3 (ix), d
	C$list.c$58$1_0$20	= .
	.globl	C$list.c$58$1_0$20
;/workspace/idp-udev/src/ulibc/list.c:58: if (el==*first) {
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	ld	-10 (ix), a
	inc	hl
	ld	a, (hl)
	ld	-9 (ix), a
	C$list.c$59$1_0$20	= .
	.globl	C$list.c$59$1_0$20
;/workspace/idp-udev/src/ulibc/list.c:59: *first=el->next;
	ld	a, -4 (ix)
	ld	-8 (ix), a
	ld	a, -3 (ix)
	ld	-7 (ix), a
	C$list.c$58$1_0$20	= .
	.globl	C$list.c$58$1_0$20
;/workspace/idp-udev/src/ulibc/list.c:58: if (el==*first) {
	ld	a, -4 (ix)
	sub	a, -10 (ix)
	jr	NZ, 00105$
	ld	a, -3 (ix)
	sub	a, -9 (ix)
	jr	NZ, 00105$
	C$list.c$59$2_0$21	= .
	.globl	C$list.c$59$2_0$21
;/workspace/idp-udev/src/ulibc/list.c:59: *first=el->next;
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	jr	00106$
00105$:
	C$list.c$61$2_0$22	= .
	.globl	C$list.c$61$2_0$22
;/workspace/idp-udev/src/ulibc/list.c:61: if (!_list_find(*first, &prev, _list_match_eq, (unsigned int) el))
	ld	a, -4 (ix)
	ld	-6 (ix), a
	ld	a, -3 (ix)
	ld	-5 (ix), a
	ld	l, -6 (ix)
	ld	h, -5 (ix)
	push	hl
	ld	hl, #__list_match_eq
	push	hl
	ld	hl, #4
	add	hl, sp
	ex	de, hl
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	call	__list_find
	ld	a, d
	or	a, e
	jr	NZ, 00102$
	C$list.c$62$2_0$22	= .
	.globl	C$list.c$62$2_0$22
;/workspace/idp-udev/src/ulibc/list.c:62: return NULL;
	ld	de, #0x0000
	jr	00107$
00102$:
	C$list.c$64$2_0$22	= .
	.globl	C$list.c$64$2_0$22
;/workspace/idp-udev/src/ulibc/list.c:64: prev->next=el->next;
	pop	bc
	push	bc
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
00106$:
	C$list.c$66$1_0$20	= .
	.globl	C$list.c$66$1_0$20
;/workspace/idp-udev/src/ulibc/list.c:66: return el;
	ld	e, -4 (ix)
	ld	d, -3 (ix)
00107$:
	C$list.c$67$1_0$20	= .
	.globl	C$list.c$67$1_0$20
;/workspace/idp-udev/src/ulibc/list.c:67: }
	ld	sp, ix
	pop	ix
	C$list.c$67$1_0$20	= .
	.globl	C$list.c$67$1_0$20
	XG$_list_remove$0$0	= .
	.globl	XG$_list_remove$0$0
	ret
	G$_list_remove_first$0$0	= .
	.globl	G$_list_remove_first$0$0
	C$list.c$69$1_0$24	= .
	.globl	C$list.c$69$1_0$24
;/workspace/idp-udev/src/ulibc/list.c:69: list_header_t *_list_remove_first(list_header_t **first) {
;	---------------------------------
; Function _list_remove_first
; ---------------------------------
__list_remove_first::
	C$list.c$71$1_0$24	= .
	.globl	C$list.c$71$1_0$24
;/workspace/idp-udev/src/ulibc/list.c:71: if (*first==NULL) return NULL; /* empty list */
	ld	e, l
	ld	d, h
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	or	a, h
	jr	NZ, 00102$
	ld	de, #0x0000
	ret
00102$:
	C$list.c$72$1_0$24	= .
	.globl	C$list.c$72$1_0$24
;/workspace/idp-udev/src/ulibc/list.c:72: result=*first;
	ld	c, l
	ld	b, h
	C$list.c$73$1_0$24	= .
	.globl	C$list.c$73$1_0$24
;/workspace/idp-udev/src/ulibc/list.c:73: *first = (list_header_t*) ((*first)->next);
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	(de), a
	inc	de
	ld	a, h
	ld	(de), a
	C$list.c$74$1_0$24	= .
	.globl	C$list.c$74$1_0$24
;/workspace/idp-udev/src/ulibc/list.c:74: return result;
	ld	e, c
	ld	d, b
	C$list.c$75$1_0$24	= .
	.globl	C$list.c$75$1_0$24
;/workspace/idp-udev/src/ulibc/list.c:75: }
	C$list.c$75$1_0$24	= .
	.globl	C$list.c$75$1_0$24
	XG$_list_remove_first$0$0	= .
	.globl	XG$_list_remove_first$0$0
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
