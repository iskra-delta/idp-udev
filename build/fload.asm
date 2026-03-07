;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
	.module fload
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _fload
	.globl _memcpy
	.globl _fparse
	.globl _malloc
	.globl _free
	.globl _calloc
	.globl _bdosret
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
	G$fload$0$0	= .
	.globl	G$fload$0$0
	C$fload.c$34$0_0$20	= .
	.globl	C$fload.c$34$0_0$20
;/workspace/idp-udev/src/ulibc/fload.c:34: void *fload(char *path, void* out, unsigned int pos, unsigned int *flen) {
;	---------------------------------
; Function fload
; ---------------------------------
_fload::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-23
	add	iy, sp
	ld	sp, iy
	ld	c, l
	ld	b, h
	ld	-6 (ix), e
	ld	-5 (ix), d
	C$fload.c$37$2_0$20	= .
	.globl	C$fload.c$37$2_0$20
;/workspace/idp-udev/src/ulibc/fload.c:37: void *retval=NULL;
	xor	a, a
	ld	-18 (ix), a
	ld	-17 (ix), a
	C$fload.c$40$1_0$20	= .
	.globl	C$fload.c$40$1_0$20
;/workspace/idp-udev/src/ulibc/fload.c:40: fcb_t *fcb=calloc(1,sizeof(fcb_t));
	push	bc
	ld	de, #0x0024
	ld	hl, #0x0001
	call	_calloc
	pop	bc
	ld	-4 (ix), e
	ld	-3 (ix), d
	C$fload.c$44$1_0$20	= .
	.globl	C$fload.c$44$1_0$20
;/workspace/idp-udev/src/ulibc/fload.c:44: if (fparse(path, fcb, &area)) {
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	ld	l, c
	ld	h, b
	call	_fparse
	C$fload.c$45$1_3$20	= .
	.globl	C$fload.c$45$1_3$20
;/workspace/idp-udev/src/ulibc/fload.c:45: free(fcb); 
	ld	a, -4 (ix)
	ld	-16 (ix), a
	ld	a, -3 (ix)
	ld	-15 (ix), a
	C$fload.c$44$1_0$20	= .
	.globl	C$fload.c$44$1_0$20
;/workspace/idp-udev/src/ulibc/fload.c:44: if (fparse(path, fcb, &area)) {
	ld	a, d
	or	a, e
	jr	Z, 00102$
	C$fload.c$45$2_0$21	= .
	.globl	C$fload.c$45$2_0$21
;/workspace/idp-udev/src/ulibc/fload.c:45: free(fcb); 
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	call	_free
	C$fload.c$46$2_0$21	= .
	.globl	C$fload.c$46$2_0$21
;/workspace/idp-udev/src/ulibc/fload.c:46: return retval;
	ld	de, #0x0000
	jp	00133$
00102$:
	C$fload.c$50$1_1$22	= .
	.globl	C$fload.c$50$1_1$22
;/workspace/idp-udev/src/ulibc/fload.c:50: unsigned char prev_area = bdos(F_USERNUM, 0xff);
	ld	de, #0x00ff
	ld	a, #0x20
	call	_bdos
	ld	-14 (ix), a
	C$fload.c$51$1_1$22	= .
	.globl	C$fload.c$51$1_1$22
;/workspace/idp-udev/src/ulibc/fload.c:51: if (area!=prev_area) { /* only if different */
	ld	a, -23 (ix)
	sub	a, -14 (ix)
	jr	Z, 00104$
	C$fload.c$52$2_1$23	= .
	.globl	C$fload.c$52$2_1$23
;/workspace/idp-udev/src/ulibc/fload.c:52: bdos(F_USERNUM, area);
	ld	a, -23 (ix)
	ld	-2 (ix), a
	ld	-1 (ix), #0x00
	ld	e, -2 (ix)
	ld	d, #0x00
	ld	a, #0x20
	call	_bdos
00104$:
	C$fload.c$56$1_2$24	= .
	.globl	C$fload.c$56$1_2$24
;/workspace/idp-udev/src/ulibc/fload.c:56: void *dma=malloc(DMA_SIZE);
	ld	hl, #0x0080
	call	_malloc
	C$fload.c$60$1_2$24	= .
	.globl	C$fload.c$60$1_2$24
;/workspace/idp-udev/src/ulibc/fload.c:60: unsigned char file_opened=0, blk_allocated=0;
	ld	-13 (ix), #0x00
	C$fload.c$63$1_2$24	= .
	.globl	C$fload.c$63$1_2$24
;/workspace/idp-udev/src/ulibc/fload.c:63: bdosret(F_OPEN,(unsigned int)fcb,&result);
	ld	a, -4 (ix)
	ld	-12 (ix), a
	ld	a, -3 (ix)
	ld	-11 (ix), a
	push	de
	ld	hl, #3
	add	hl, sp
	push	hl
	ld	e, -12 (ix)
	ld	d, -11 (ix)
	ld	a, #0x0f
	call	_bdosret
	pop	de
	C$fload.c$64$1_2$24	= .
	.globl	C$fload.c$64$1_2$24
;/workspace/idp-udev/src/ulibc/fload.c:64: if (result.reta==BDOS_FAILURE) 
	ld	a, -22 (ix)
	inc	a
	jp	Z, 00128$
	C$fload.c$66$1_2$24	= .
	.globl	C$fload.c$66$1_2$24
;/workspace/idp-udev/src/ulibc/fload.c:66: file_opened=1; /* file is open... */
	ld	-13 (ix), #0x01
	C$fload.c$69$1_2$24	= .
	.globl	C$fload.c$69$1_2$24
;/workspace/idp-udev/src/ulibc/fload.c:69: if ((*flen)==0) {
	ld	a, 6 (ix)
	ld	-10 (ix), a
	ld	a, 7 (ix)
	ld	-9 (ix), a
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	C$fload.c$72$1_3$20	= .
	.globl	C$fload.c$72$1_3$20
;/workspace/idp-udev/src/ulibc/fload.c:72: *flen=fcb->rrec * DMA_SIZE;
	ld	a, -4 (ix)
	add	a, #0x21
	ld	-2 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	-1 (ix), a
	C$fload.c$69$1_2$24	= .
	.globl	C$fload.c$69$1_2$24
;/workspace/idp-udev/src/ulibc/fload.c:69: if ((*flen)==0) {
	ld	a, b
	or	a, c
	jr	NZ, 00112$
	C$fload.c$70$2_2$25	= .
	.globl	C$fload.c$70$2_2$25
;/workspace/idp-udev/src/ulibc/fload.c:70: bdosret(F_SIZE,(unsigned int)fcb,&result);
	push	de
	ld	hl, #3
	add	hl, sp
	push	hl
	ld	e, -12 (ix)
	ld	d, -11 (ix)
	ld	a, #0x23
	call	_bdosret
	pop	de
	C$fload.c$71$2_2$25	= .
	.globl	C$fload.c$71$2_2$25
;/workspace/idp-udev/src/ulibc/fload.c:71: if (result.reta==BDOS_FAILURE) goto fload_done;
	ld	a, -22 (ix)
	inc	a
	jp	Z, 00128$
	C$fload.c$72$2_2$25	= .
	.globl	C$fload.c$72$2_2$25
;/workspace/idp-udev/src/ulibc/fload.c:72: *flen=fcb->rrec * DMA_SIZE;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	xor	a, a
	rr	b
	ld	b, c
	rr	b
	rra
	ld	c, a
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	C$fload.c$74$2_2$25	= .
	.globl	C$fload.c$74$2_2$25
;/workspace/idp-udev/src/ulibc/fload.c:74: if (pos>0) (*flen) -= pos;
	ld	a, 5 (ix)
	or	a, 4 (ix)
	jr	Z, 00112$
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, c
	sub	a, 4 (ix)
	ld	c, a
	ld	a, b
	sbc	a, 5 (ix)
	ld	b, a
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	(hl), c
	inc	hl
	ld	(hl), b
00112$:
	C$fload.c$78$1_2$24	= .
	.globl	C$fload.c$78$1_2$24
;/workspace/idp-udev/src/ulibc/fload.c:78: if (out==NULL) {
	ld	a, -5 (ix)
	or	a, -6 (ix)
	jr	NZ, 00116$
	C$fload.c$82$2_2$26	= .
	.globl	C$fload.c$82$2_2$26
;/workspace/idp-udev/src/ulibc/fload.c:82: out=malloc(*flen);
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	push	de
	call	_malloc
	ld	-6 (ix), e
	ld	-5 (ix), d
	pop	de
	C$fload.c$83$2_2$26	= .
	.globl	C$fload.c$83$2_2$26
;/workspace/idp-udev/src/ulibc/fload.c:83: if (out==NULL) goto fload_done;
	ld	a, -5 (ix)
	or	a, -6 (ix)
	jp	Z, 00128$
	C$fload.c$84$1_2$24	= .
	.globl	C$fload.c$84$1_2$24
;/workspace/idp-udev/src/ulibc/fload.c:84: blk_allocated=1;
00116$:
	C$fload.c$89$1_2$24	= .
	.globl	C$fload.c$89$1_2$24
;/workspace/idp-udev/src/ulibc/fload.c:89: bdos(F_DMAOFF,(unsigned int)dma);
	ld	l, e
	ld	h, d
	ex	de, hl
	push	hl
	ld	a, #0x1a
	call	_bdos
	pop	de
	C$fload.c$92$1_2$24	= .
	.globl	C$fload.c$92$1_2$24
;/workspace/idp-udev/src/ulibc/fload.c:92: if (pos > 0) {
	ld	a, 5 (ix)
	or	a, 4 (ix)
	jr	Z, 00120$
	C$fload.c$93$2_2$27	= .
	.globl	C$fload.c$93$2_2$27
;/workspace/idp-udev/src/ulibc/fload.c:93: unsigned int rec = pos / DMA_SIZE;
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	C$fload.c$94$2_2$27	= .
	.globl	C$fload.c$94$2_2$27
;/workspace/idp-udev/src/ulibc/fload.c:94: fcb->rrec = rec;
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	(hl), c
	inc	hl
	ld	(hl), b
	C$fload.c$95$2_2$27	= .
	.globl	C$fload.c$95$2_2$27
;/workspace/idp-udev/src/ulibc/fload.c:95: bdosret(F_READRAND, (unsigned int)fcb, &result);
	push	de
	ld	hl, #3
	add	hl, sp
	push	hl
	ld	e, -12 (ix)
	ld	d, -11 (ix)
	ld	a, #0x21
	call	_bdosret
	pop	de
	C$fload.c$96$2_2$27	= .
	.globl	C$fload.c$96$2_2$27
;/workspace/idp-udev/src/ulibc/fload.c:96: if (result.reta == BDOS_FAILURE) goto fload_done;
	ld	a, -22 (ix)
	inc	a
	jp	Z, 00128$
00120$:
	C$fload.c$100$2_2$28	= .
	.globl	C$fload.c$100$2_2$28
;/workspace/idp-udev/src/ulibc/fload.c:100: unsigned int bcount = 0; /* block count */
	xor	a, a
	ld	-4 (ix), a
	ld	-3 (ix), a
	C$fload.c$101$1_3$28	= .
	.globl	C$fload.c$101$1_3$28
;/workspace/idp-udev/src/ulibc/fload.c:101: unsigned int dma_offs = pos % DMA_SIZE; /* where are we? */
	ld	a, 4 (ix)
	and	a, #0x7f
	ld	-8 (ix), a
	ld	-7 (ix), #0x00
	C$fload.c$102$1_3$28	= .
	.globl	C$fload.c$102$1_3$28
;/workspace/idp-udev/src/ulibc/fload.c:102: unsigned char *pout=(unsigned char *)out;
	ld	a, -6 (ix)
	ld	-2 (ix), a
	ld	a, -5 (ix)
	ld	-1 (ix), a
	C$fload.c$103$1_3$28	= .
	.globl	C$fload.c$103$1_3$28
;/workspace/idp-udev/src/ulibc/fload.c:103: while (bcount < (*flen)) {
00125$:
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	a, -4 (ix)
	sub	a, c
	ld	a, -3 (ix)
	sbc	a, b
	jp	NC, 00127$
	C$fload.c$105$2_3$29	= .
	.globl	C$fload.c$105$2_3$29
;/workspace/idp-udev/src/ulibc/fload.c:105: bdosret(F_READ,(unsigned int)fcb,&result);
	push	de
	ld	hl, #3
	add	hl, sp
	push	hl
	ld	e, -12 (ix)
	ld	d, -11 (ix)
	ld	a, #0x14
	call	_bdosret
	pop	de
	C$fload.c$106$2_3$29	= .
	.globl	C$fload.c$106$2_3$29
;/workspace/idp-udev/src/ulibc/fload.c:106: if (result.reta != BDOS_SUCCESS) goto fload_done;
	ld	a, -22 (ix)
	or	a, a
	jr	NZ, 00128$
	C$fload.c$107$2_4$30	= .
	.globl	C$fload.c$107$2_4$30
;/workspace/idp-udev/src/ulibc/fload.c:107: unsigned int bytes2copy=DMA_SIZE-dma_offs;
	ld	a, #0x80
	sub	a, -8 (ix)
	ld	c, a
	sbc	a, a
	sub	a, -7 (ix)
	ld	b, a
	C$fload.c$108$2_4$30	= .
	.globl	C$fload.c$108$2_4$30
;/workspace/idp-udev/src/ulibc/fload.c:108: if (bcount + bytes2copy > (*flen)) bytes2copy=(*flen)-bcount;
	ld	a, -4 (ix)
	add	a, c
	ld	-8 (ix), a
	ld	a, -3 (ix)
	adc	a, b
	ld	-7 (ix), a
	C$fload.c$69$1_3$20	= .
	.globl	C$fload.c$69$1_3$20
;/workspace/idp-udev/src/ulibc/fload.c:69: if ((*flen)==0) {
	ld	l, -10 (ix)
	ld	h, -9 (ix)
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	C$fload.c$108$2_4$30	= .
	.globl	C$fload.c$108$2_4$30
;/workspace/idp-udev/src/ulibc/fload.c:108: if (bcount + bytes2copy > (*flen)) bytes2copy=(*flen)-bcount;
	ld	l, a
	sub	a, -8 (ix)
	ld	a, h
	sbc	a, -7 (ix)
	jr	NC, 00124$
	ld	a, l
	sub	a, -4 (ix)
	ld	c, a
	ld	a, h
	sbc	a, -3 (ix)
	ld	b, a
00124$:
	C$fload.c$110$2_4$30	= .
	.globl	C$fload.c$110$2_4$30
;/workspace/idp-udev/src/ulibc/fload.c:110: memcpy(pout, dma + dma_offs, bytes2copy);
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	push	bc
	push	de
	push	bc
	call	_memcpy
	pop	de
	pop	bc
	C$fload.c$111$2_4$30	= .
	.globl	C$fload.c$111$2_4$30
;/workspace/idp-udev/src/ulibc/fload.c:111: dma_offs=0; /* just first DMA may have the offset */
	xor	a, a
	ld	-8 (ix), a
	ld	-7 (ix), a
	C$fload.c$113$2_4$30	= .
	.globl	C$fload.c$113$2_4$30
;/workspace/idp-udev/src/ulibc/fload.c:113: pout+=bytes2copy;
	ld	a, c
	add	a, -2 (ix)
	ld	-2 (ix), a
	ld	a, b
	adc	a, -1 (ix)
	ld	-1 (ix), a
	C$fload.c$114$2_4$30	= .
	.globl	C$fload.c$114$2_4$30
;/workspace/idp-udev/src/ulibc/fload.c:114: bcount+=bytes2copy;
	ld	a, c
	add	a, -4 (ix)
	ld	-4 (ix), a
	ld	a, b
	adc	a, -3 (ix)
	ld	-3 (ix), a
	jp	00125$
00127$:
	C$fload.c$118$1_3$28	= .
	.globl	C$fload.c$118$1_3$28
;/workspace/idp-udev/src/ulibc/fload.c:118: retval=out;
	ld	a, -6 (ix)
	ld	-18 (ix), a
	ld	a, -5 (ix)
	ld	-17 (ix), a
	C$fload.c$120$1_3$28	= .
	.globl	C$fload.c$120$1_3$28
;/workspace/idp-udev/src/ulibc/fload.c:120: fload_done:
00128$:
	C$fload.c$123$1_3$28	= .
	.globl	C$fload.c$123$1_3$28
;/workspace/idp-udev/src/ulibc/fload.c:123: if (file_opened) 
	ld	a, -13 (ix)
	or	a, a
	jr	Z, 00130$
	C$fload.c$124$1_3$28	= .
	.globl	C$fload.c$124$1_3$28
;/workspace/idp-udev/src/ulibc/fload.c:124: bdosret(F_CLOSE,(unsigned int)fcb,&result);
	push	de
	ld	hl, #3
	add	hl, sp
	push	hl
	ld	e, -12 (ix)
	ld	d, -11 (ix)
	ld	a, #0x10
	call	_bdosret
	pop	de
00130$:
	C$fload.c$127$1_3$28	= .
	.globl	C$fload.c$127$1_3$28
;/workspace/idp-udev/src/ulibc/fload.c:127: if (area!=prev_area) bdos(F_USERNUM,prev_area);
	ld	a, -23 (ix)
	sub	a, -14 (ix)
	jr	Z, 00132$
	ld	l, -14 (ix)
	ld	h, #0x00
	ex	de, hl
	push	hl
	ld	a, #0x20
	call	_bdos
	pop	de
00132$:
	C$fload.c$130$1_3$28	= .
	.globl	C$fload.c$130$1_3$28
;/workspace/idp-udev/src/ulibc/fload.c:130: free(fcb);
	push	de
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	call	_free
	pop	de
	C$fload.c$133$1_3$28	= .
	.globl	C$fload.c$133$1_3$28
;/workspace/idp-udev/src/ulibc/fload.c:133: free(dma);
	ex	de, hl
	call	_free
	C$fload.c$136$1_3$28	= .
	.globl	C$fload.c$136$1_3$28
;/workspace/idp-udev/src/ulibc/fload.c:136: return  retval;
	ld	e, -18 (ix)
	ld	d, -17 (ix)
00133$:
	C$fload.c$137$1_3$20	= .
	.globl	C$fload.c$137$1_3$20
;/workspace/idp-udev/src/ulibc/fload.c:137: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
