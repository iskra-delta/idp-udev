;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
	.module fsave
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _fsave
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
	G$fsave$0$0	= .
	.globl	G$fsave$0$0
	C$fsave.c$28$0_0$16	= .
	.globl	C$fsave.c$28$0_0$16
;/workspace/idp-udev/src/ulibc/fsave.c:28: int fsave(char *path, void* buf, unsigned int flen) {
;	---------------------------------
; Function fsave
; ---------------------------------
_fsave::
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
	C$fsave.c$31$2_0$16	= .
	.globl	C$fsave.c$31$2_0$16
;/workspace/idp-udev/src/ulibc/fsave.c:31: int retval = 0;
	xor	a, a
	ld	-18 (ix), a
	ld	-17 (ix), a
	C$fsave.c$34$1_0$16	= .
	.globl	C$fsave.c$34$1_0$16
;/workspace/idp-udev/src/ulibc/fsave.c:34: fcb_t *fcb=calloc(1,sizeof(fcb_t));
	push	bc
	ld	de, #0x0024
	ld	hl, #0x0001
	call	_calloc
	pop	bc
	ld	-2 (ix), e
	ld	-1 (ix), d
	C$fsave.c$38$1_0$16	= .
	.globl	C$fsave.c$38$1_0$16
;/workspace/idp-udev/src/ulibc/fsave.c:38: if (fparse(path, fcb, &area)) {
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	l, c
	ld	h, b
	call	_fparse
	ld	-4 (ix), e
	ld	-3 (ix), d
	C$fsave.c$39$1_3$16	= .
	.globl	C$fsave.c$39$1_3$16
;/workspace/idp-udev/src/ulibc/fsave.c:39: free(fcb); 
	ld	a, -2 (ix)
	ld	-16 (ix), a
	ld	a, -1 (ix)
	ld	-15 (ix), a
	C$fsave.c$38$1_0$16	= .
	.globl	C$fsave.c$38$1_0$16
;/workspace/idp-udev/src/ulibc/fsave.c:38: if (fparse(path, fcb, &area)) {
	ld	a, -3 (ix)
	or	a, -4 (ix)
	jr	Z, 00102$
	C$fsave.c$39$2_0$17	= .
	.globl	C$fsave.c$39$2_0$17
;/workspace/idp-udev/src/ulibc/fsave.c:39: free(fcb); 
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	call	_free
	C$fsave.c$40$2_0$17	= .
	.globl	C$fsave.c$40$2_0$17
;/workspace/idp-udev/src/ulibc/fsave.c:40: return 0;
	ld	de, #0x0000
	jp	00119$
00102$:
	C$fsave.c$44$1_1$18	= .
	.globl	C$fsave.c$44$1_1$18
;/workspace/idp-udev/src/ulibc/fsave.c:44: unsigned char prev_area = bdos(F_USERNUM, 0xff);
	ld	de, #0x00ff
	ld	a, #0x20
	call	_bdos
	ld	-14 (ix), a
	C$fsave.c$45$1_1$18	= .
	.globl	C$fsave.c$45$1_1$18
;/workspace/idp-udev/src/ulibc/fsave.c:45: if (area!=prev_area) { /* only if different */
	ld	a, -23 (ix)
	sub	a, -14 (ix)
	jr	Z, 00104$
	C$fsave.c$46$2_1$19	= .
	.globl	C$fsave.c$46$2_1$19
;/workspace/idp-udev/src/ulibc/fsave.c:46: bdos(F_USERNUM, area);
	ld	a, -23 (ix)
	ld	-4 (ix), a
	ld	-3 (ix), #0x00
	ld	e, -4 (ix)
	ld	d, #0x00
	ld	a, #0x20
	call	_bdos
00104$:
	C$fsave.c$50$1_2$20	= .
	.globl	C$fsave.c$50$1_2$20
;/workspace/idp-udev/src/ulibc/fsave.c:50: void *dma=malloc(DMA_SIZE);
	ld	hl, #0x0080
	call	_malloc
	ld	-13 (ix), e
	ld	-12 (ix), d
	C$fsave.c$54$1_2$20	= .
	.globl	C$fsave.c$54$1_2$20
;/workspace/idp-udev/src/ulibc/fsave.c:54: unsigned char file_opened=0, blk_allocated=0;
	ld	-11 (ix), #0x00
	C$fsave.c$57$1_2$20	= .
	.globl	C$fsave.c$57$1_2$20
;/workspace/idp-udev/src/ulibc/fsave.c:57: bdosret(F_OPEN,(unsigned int)fcb,&result);
	ld	a, -2 (ix)
	ld	-10 (ix), a
	ld	a, -1 (ix)
	ld	-9 (ix), a
	ld	hl, #1
	add	hl, sp
	push	hl
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	ld	a, #0x0f
	call	_bdosret
	C$fsave.c$58$1_2$20	= .
	.globl	C$fsave.c$58$1_2$20
;/workspace/idp-udev/src/ulibc/fsave.c:58: if (result.reta==BDOS_FAILURE) {
	ld	a, -22 (ix)
	inc	a
	jr	NZ, 00108$
	C$fsave.c$60$2_2$21	= .
	.globl	C$fsave.c$60$2_2$21
;/workspace/idp-udev/src/ulibc/fsave.c:60: bdosret(F_MAKE, (unsigned int)fcb, &result);
	ld	hl, #1
	add	hl, sp
	push	hl
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	ld	a, #0x16
	call	_bdosret
	C$fsave.c$61$2_2$21	= .
	.globl	C$fsave.c$61$2_2$21
;/workspace/idp-udev/src/ulibc/fsave.c:61: if (result.reta == BDOS_FAILURE) goto fsave_done;
	ld	a, -22 (ix)
	inc	a
	jp	Z, 00114$
00108$:
	C$fsave.c$63$1_2$20	= .
	.globl	C$fsave.c$63$1_2$20
;/workspace/idp-udev/src/ulibc/fsave.c:63: file_opened=1; /* file is open or created... */
	ld	-11 (ix), #0x01
	C$fsave.c$67$1_2$20	= .
	.globl	C$fsave.c$67$1_2$20
;/workspace/idp-udev/src/ulibc/fsave.c:67: bdos(F_DMAOFF,(unsigned int)dma);
	ld	e, -13 (ix)
	ld	d, -12 (ix)
	ld	a, #0x1a
	call	_bdos
	C$fsave.c$70$2_2$22	= .
	.globl	C$fsave.c$70$2_2$22
;/workspace/idp-udev/src/ulibc/fsave.c:70: unsigned int w_len = 0;
	xor	a, a
	ld	-4 (ix), a
	ld	-3 (ix), a
	C$fsave.c$71$2_2$22	= .
	.globl	C$fsave.c$71$2_2$22
;/workspace/idp-udev/src/ulibc/fsave.c:71: unsigned char *p_buf = buf;
	ld	a, -6 (ix)
	ld	-2 (ix), a
	ld	a, -5 (ix)
	ld	-1 (ix), a
	C$fsave.c$72$1_3$22	= .
	.globl	C$fsave.c$72$1_3$22
;/workspace/idp-udev/src/ulibc/fsave.c:72: while (w_len < flen) {
00111$:
	ld	a, -4 (ix)
	sub	a, 4 (ix)
	ld	a, -3 (ix)
	sbc	a, 5 (ix)
	jr	NC, 00113$
	C$fsave.c$74$2_3$23	= .
	.globl	C$fsave.c$74$2_3$23
;/workspace/idp-udev/src/ulibc/fsave.c:74: unsigned int sz = (flen - w_len) > DMA_SIZE ? DMA_SIZE : (flen - w_len);
	ld	a, 4 (ix)
	sub	a, -4 (ix)
	ld	c, a
	ld	a, 5 (ix)
	sbc	a, -3 (ix)
	ld	b, a
	ld	a, #0x80
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00121$
	ld	bc, #0x0080
00121$:
	ld	-8 (ix), c
	ld	-7 (ix), b
	C$fsave.c$75$2_3$23	= .
	.globl	C$fsave.c$75$2_3$23
;/workspace/idp-udev/src/ulibc/fsave.c:75: memcpy(dma, p_buf, sz);
	ld	e, -2 (ix)
	ld	d, -1 (ix)
	ld	l, -8 (ix)
	ld	h, #0x00
	push	hl
	ld	l, -13 (ix)
	ld	h, -12 (ix)
	call	_memcpy
	C$fsave.c$77$2_3$23	= .
	.globl	C$fsave.c$77$2_3$23
;/workspace/idp-udev/src/ulibc/fsave.c:77: bdosret(F_WRITE, (unsigned int)fcb, &result);
	ld	hl, #1
	add	hl, sp
	push	hl
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	ld	a, #0x15
	call	_bdosret
	C$fsave.c$78$2_3$23	= .
	.globl	C$fsave.c$78$2_3$23
;/workspace/idp-udev/src/ulibc/fsave.c:78: if (result.reta != 0) goto fsave_done;
	ld	a, -22 (ix)
	or	a, a
	jr	NZ, 00114$
	C$fsave.c$79$2_3$23	= .
	.globl	C$fsave.c$79$2_3$23
;/workspace/idp-udev/src/ulibc/fsave.c:79: p_buf += sz;
	ld	a, -2 (ix)
	add	a, -8 (ix)
	ld	-2 (ix), a
	jr	NC, 00190$
	inc	-1 (ix)
00190$:
	C$fsave.c$80$2_3$23	= .
	.globl	C$fsave.c$80$2_3$23
;/workspace/idp-udev/src/ulibc/fsave.c:80: w_len += sz;
	ld	a, -4 (ix)
	add	a, -8 (ix)
	ld	-4 (ix), a
	jr	NC, 00111$
	inc	-3 (ix)
	jr	00111$
00113$:
	C$fsave.c$84$1_3$22	= .
	.globl	C$fsave.c$84$1_3$22
;/workspace/idp-udev/src/ulibc/fsave.c:84: retval=1;
	ld	-18 (ix), #0x01
	ld	-17 (ix), #0
	C$fsave.c$86$1_3$22	= .
	.globl	C$fsave.c$86$1_3$22
;/workspace/idp-udev/src/ulibc/fsave.c:86: fsave_done:
00114$:
	C$fsave.c$89$1_3$22	= .
	.globl	C$fsave.c$89$1_3$22
;/workspace/idp-udev/src/ulibc/fsave.c:89: if (file_opened) 
	ld	a, -11 (ix)
	or	a, a
	jr	Z, 00116$
	C$fsave.c$90$1_3$22	= .
	.globl	C$fsave.c$90$1_3$22
;/workspace/idp-udev/src/ulibc/fsave.c:90: bdosret(F_CLOSE,(unsigned int)fcb,&result);
	ld	hl, #1
	add	hl, sp
	push	hl
	ld	e, -10 (ix)
	ld	d, -9 (ix)
	ld	a, #0x10
	call	_bdosret
00116$:
	C$fsave.c$93$1_3$22	= .
	.globl	C$fsave.c$93$1_3$22
;/workspace/idp-udev/src/ulibc/fsave.c:93: if (area!=prev_area) bdos(F_USERNUM,prev_area);
	ld	a, -23 (ix)
	sub	a, -14 (ix)
	jr	Z, 00118$
	ld	a, -14 (ix)
	ld	-2 (ix), a
	ld	-1 (ix), #0x00
	ld	e, -2 (ix)
	ld	d, #0x00
	ld	a, #0x20
	call	_bdos
00118$:
	C$fsave.c$96$1_3$22	= .
	.globl	C$fsave.c$96$1_3$22
;/workspace/idp-udev/src/ulibc/fsave.c:96: free(fcb);
	ld	l, -16 (ix)
	ld	h, -15 (ix)
	call	_free
	C$fsave.c$99$1_3$22	= .
	.globl	C$fsave.c$99$1_3$22
;/workspace/idp-udev/src/ulibc/fsave.c:99: free(dma);
	ld	l, -13 (ix)
	ld	h, -12 (ix)
	call	_free
	C$fsave.c$102$1_3$22	= .
	.globl	C$fsave.c$102$1_3$22
;/workspace/idp-udev/src/ulibc/fsave.c:102: return  retval;
	ld	e, -18 (ix)
	ld	d, #0x00
00119$:
	C$fsave.c$103$1_3$16	= .
	.globl	C$fsave.c$103$1_3$16
;/workspace/idp-udev/src/ulibc/fsave.c:103: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
