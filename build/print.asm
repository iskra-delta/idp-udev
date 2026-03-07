;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.0 #15242 (Linux)
;--------------------------------------------------------
	.module print
	
	.optsdcc -mz80 sdcccall(1)
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _puts
	.globl _printf
	.globl _putchar
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
	Fprint$_prints$0$0	= .
	.globl	Fprint$_prints$0$0
	C$print.c$34$0_0$4	= .
	.globl	C$print.c$34$0_0$4
;/workspace/idp-udev/src/ulibc/print.c:34: static void _prints(const char *string, int width, int flags)
;	---------------------------------
; Function _prints
; ---------------------------------
__prints:
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
	push	af
	push	af
	ld	-4 (ix), l
	ld	-3 (ix), h
	inc	sp
	inc	sp
	push	de
	C$print.c$36$2_0$4	= .
	.globl	C$print.c$36$2_0$4
;/workspace/idp-udev/src/ulibc/print.c:36: int padchar = ' ';
	ld	bc, #0x0020
	C$print.c$38$1_0$4	= .
	.globl	C$print.c$38$1_0$4
;/workspace/idp-udev/src/ulibc/print.c:38: if (width > 0) {
	xor	a, a
	cp	a, -6 (ix)
	sbc	a, -5 (ix)
	jp	PO, 00215$
	xor	a, #0x80
00215$:
	jp	P, 00108$
	C$print.c$41$2_0$4	= .
	.globl	C$print.c$41$2_0$4
;/workspace/idp-udev/src/ulibc/print.c:41: for (ptr = string; *ptr; ++ptr) ++len;
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
	pop	de
	pop	hl
	push	hl
	push	de
00115$:
	ld	a, (hl)
	or	a, a
	jr	Z, 00101$
	inc	-2 (ix)
	jr	NZ, 00216$
	inc	-1 (ix)
00216$:
	inc	hl
	jr	00115$
00101$:
	C$print.c$42$2_0$5	= .
	.globl	C$print.c$42$2_0$5
;/workspace/idp-udev/src/ulibc/print.c:42: if (len >= width) width = 0;
	ld	a, -2 (ix)
	sub	a, -6 (ix)
	ld	a, -1 (ix)
	sbc	a, -5 (ix)
	jp	PO, 00217$
	xor	a, #0x80
00217$:
	jp	M, 00103$
	ld	hl, #0x0000
	ex	(sp), hl
	jr	00104$
00103$:
	C$print.c$43$2_0$5	= .
	.globl	C$print.c$43$2_0$5
;/workspace/idp-udev/src/ulibc/print.c:43: else width -= len;
	ld	a, -6 (ix)
	sub	a, -2 (ix)
	ld	-6 (ix), a
	ld	a, -5 (ix)
	sbc	a, -1 (ix)
	ld	-5 (ix), a
00104$:
	C$print.c$44$2_0$5	= .
	.globl	C$print.c$44$2_0$5
;/workspace/idp-udev/src/ulibc/print.c:44: if (flags & PAD_ZERO)
	bit	0, 4 (ix)
	jr	Z, 00108$
	C$print.c$45$2_0$5	= .
	.globl	C$print.c$45$2_0$5
;/workspace/idp-udev/src/ulibc/print.c:45: padchar = '0';
	ld	bc, #0x0030
00108$:
	C$print.c$47$1_0$4	= .
	.globl	C$print.c$47$1_0$4
;/workspace/idp-udev/src/ulibc/print.c:47: if (!(flags & PAD_RIGHT)) {
	bit	1, 4 (ix)
	jr	NZ, 00136$
	pop	de
	push	de
00118$:
	C$print.c$48$3_0$8	= .
	.globl	C$print.c$48$3_0$8
;/workspace/idp-udev/src/ulibc/print.c:48: for ( ; width > 0; --width) {
	xor	a, a
	cp	a, e
	sbc	a, d
	jp	PO, 00221$
	xor	a, #0x80
00221$:
	jp	P, 00140$
	C$print.c$49$4_0$9	= .
	.globl	C$print.c$49$4_0$9
;/workspace/idp-udev/src/ulibc/print.c:49: putchar(padchar);
	push	bc
	push	de
	ld	l, c
	ld	h, b
	call	_putchar
	pop	de
	pop	bc
	C$print.c$48$3_0$8	= .
	.globl	C$print.c$48$3_0$8
;/workspace/idp-udev/src/ulibc/print.c:48: for ( ; width > 0; --width) {
	dec	de
	jr	00118$
00140$:
	inc	sp
	inc	sp
	push	de
00136$:
	ld	a, -4 (ix)
	ld	-2 (ix), a
	ld	a, -3 (ix)
	ld	-1 (ix), a
00121$:
	C$print.c$52$2_0$10	= .
	.globl	C$print.c$52$2_0$10
;/workspace/idp-udev/src/ulibc/print.c:52: for ( ; *string ; ++string) {
	ld	l, -2 (ix)
	ld	h, -1 (ix)
	ld	a, (hl)
	or	a, a
	jr	Z, 00138$
	C$print.c$53$3_0$11	= .
	.globl	C$print.c$53$3_0$11
;/workspace/idp-udev/src/ulibc/print.c:53: putchar(*string);
	ld	h, #0x00
	push	bc
	ld	l, a
	call	_putchar
	pop	bc
	C$print.c$52$2_0$10	= .
	.globl	C$print.c$52$2_0$10
;/workspace/idp-udev/src/ulibc/print.c:52: for ( ; *string ; ++string) {
	inc	-2 (ix)
	jr	NZ, 00121$
	inc	-1 (ix)
	jr	00121$
00138$:
	pop	de
	push	de
00124$:
	C$print.c$55$2_0$12	= .
	.globl	C$print.c$55$2_0$12
;/workspace/idp-udev/src/ulibc/print.c:55: for ( ; width > 0; --width) {
	xor	a, a
	cp	a, e
	sbc	a, d
	jp	PO, 00223$
	xor	a, #0x80
00223$:
	jp	P, 00126$
	C$print.c$56$3_0$13	= .
	.globl	C$print.c$56$3_0$13
;/workspace/idp-udev/src/ulibc/print.c:56: putchar(padchar);
	push	bc
	push	de
	ld	l, c
	ld	h, b
	call	_putchar
	pop	de
	pop	bc
	C$print.c$55$2_0$12	= .
	.globl	C$print.c$55$2_0$12
;/workspace/idp-udev/src/ulibc/print.c:55: for ( ; width > 0; --width) {
	dec	de
	jr	00124$
00126$:
	C$print.c$58$2_0$4	= .
	.globl	C$print.c$58$2_0$4
;/workspace/idp-udev/src/ulibc/print.c:58: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	jp	(hl)
	Fprint$_printi$0$0	= .
	.globl	Fprint$_printi$0$0
	C$print.c$61$2_0$15	= .
	.globl	C$print.c$61$2_0$15
;/workspace/idp-udev/src/ulibc/print.c:61: static void _printi(int i, int base, int sign, int width, int flags, int letbase)
;	---------------------------------
; Function _printi
; ---------------------------------
__printi:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	iy, #-137
	add	iy, sp
	ld	sp, iy
	ld	c, l
	ld	b, h
	ld	-4 (ix), e
	ld	-3 (ix), d
	C$print.c$65$2_0$15	= .
	.globl	C$print.c$65$2_0$15
;/workspace/idp-udev/src/ulibc/print.c:65: int t, neg = 0, pc = 0;
	ld	-9 (ix), #0x00
	C$print.c$66$2_0$15	= .
	.globl	C$print.c$66$2_0$15
;/workspace/idp-udev/src/ulibc/print.c:66: unsigned int u = i;
	ld	-8 (ix), c
	ld	-7 (ix), b
	C$print.c$67$1_0$15	= .
	.globl	C$print.c$67$1_0$15
;/workspace/idp-udev/src/ulibc/print.c:67: if (i == 0) {
	ld	a, b
	or	a, c
	jr	NZ, 00102$
	C$print.c$68$2_0$16	= .
	.globl	C$print.c$68$2_0$16
;/workspace/idp-udev/src/ulibc/print.c:68: print_buf[0] = '0';
	ld	iy, #0
	add	iy, sp
	ld	0 (iy), #0x30
	C$print.c$69$2_0$16	= .
	.globl	C$print.c$69$2_0$16
;/workspace/idp-udev/src/ulibc/print.c:69: print_buf[1] = '\0';
	inc	iy
	ld	0 (iy), #0x00
	C$print.c$70$2_0$16	= .
	.globl	C$print.c$70$2_0$16
;/workspace/idp-udev/src/ulibc/print.c:70: _prints(print_buf, width, flags);
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	ld	e, 6 (ix)
	ld	d, 7 (ix)
	ld	hl, #2
	add	hl, sp
	call	__prints
	C$print.c$71$2_0$16	= .
	.globl	C$print.c$71$2_0$16
;/workspace/idp-udev/src/ulibc/print.c:71: return;
	jp	00118$
00102$:
	C$print.c$73$1_0$15	= .
	.globl	C$print.c$73$1_0$15
;/workspace/idp-udev/src/ulibc/print.c:73: if (sign && base == 10 && i < 0) {
	ld	a, 5 (ix)
	or	a, 4 (ix)
	jr	Z, 00104$
	ld	a, -4 (ix)
	sub	a, #0x0a
	or	a, -3 (ix)
	jr	NZ, 00104$
	bit	7, b
	jr	Z, 00104$
	C$print.c$74$2_0$17	= .
	.globl	C$print.c$74$2_0$17
;/workspace/idp-udev/src/ulibc/print.c:74: neg = 1;
	ld	-9 (ix), #0x01
	C$print.c$75$2_0$17	= .
	.globl	C$print.c$75$2_0$17
;/workspace/idp-udev/src/ulibc/print.c:75: u = -i;
	xor	a, a
	sub	a, c
	ld	-8 (ix), a
	sbc	a, a
	sub	a, b
	ld	-7 (ix), a
00104$:
	C$print.c$77$1_0$15	= .
	.globl	C$print.c$77$1_0$15
;/workspace/idp-udev/src/ulibc/print.c:77: s = print_buf + PRINT_BUF_LEN-1;
	ld	hl, #127
	add	hl, sp
	ld	c, l
	ld	b, h
	C$print.c$78$1_0$15	= .
	.globl	C$print.c$78$1_0$15
;/workspace/idp-udev/src/ulibc/print.c:78: *s = '\0';
	xor	a, a
	ld	(bc), a
	C$print.c$79$2_0$18	= .
	.globl	C$print.c$79$2_0$18
;/workspace/idp-udev/src/ulibc/print.c:79: while (u) {
	ld	a, 10 (ix)
	add	a, #0xc6
	ld	-6 (ix), a
	ld	a, 11 (ix)
	adc	a, #0xff
	ld	-5 (ix), a
00109$:
	ld	a, -7 (ix)
	or	a, -8 (ix)
	jr	Z, 00130$
	C$print.c$80$2_0$18	= .
	.globl	C$print.c$80$2_0$18
;/workspace/idp-udev/src/ulibc/print.c:80: t = u % base;
	ld	e, -4 (ix)
	ld	d, -3 (ix)
	push	bc
	push	de
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	call	__moduint
	ex	de, hl
	pop	de
	pop	bc
	ld	-2 (ix), l
	ld	-1 (ix), h
	C$print.c$81$2_0$18	= .
	.globl	C$print.c$81$2_0$18
;/workspace/idp-udev/src/ulibc/print.c:81: if( t >= 10 )
	ld	a, -2 (ix)
	sub	a, #0x0a
	ld	a, -1 (ix)
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00108$
	C$print.c$82$2_0$18	= .
	.globl	C$print.c$82$2_0$18
;/workspace/idp-udev/src/ulibc/print.c:82: t += letbase - '0' - 10;
	ld	a, -2 (ix)
	add	a, -6 (ix)
	ld	-2 (ix), a
	ld	a, -1 (ix)
	adc	a, -5 (ix)
	ld	-1 (ix), a
00108$:
	C$print.c$83$2_0$18	= .
	.globl	C$print.c$83$2_0$18
;/workspace/idp-udev/src/ulibc/print.c:83: *--s = t + '0';
	dec	bc
	ld	a, -2 (ix)
	add	a, #0x30
	ld	(bc), a
	C$print.c$84$1_0$15	= .
	.globl	C$print.c$84$1_0$15
;/workspace/idp-udev/src/ulibc/print.c:84: u /= base;
	push	bc
	ld	l, -8 (ix)
	ld	h, -7 (ix)
	call	__divuint
	ld	-8 (ix), e
	ld	-7 (ix), d
	pop	bc
	jr	00109$
00130$:
	C$print.c$86$1_0$15	= .
	.globl	C$print.c$86$1_0$15
;/workspace/idp-udev/src/ulibc/print.c:86: if (neg) {
	ld	a, -9 (ix)
	or	a, a
	jr	Z, 00117$
	C$print.c$87$2_0$19	= .
	.globl	C$print.c$87$2_0$19
;/workspace/idp-udev/src/ulibc/print.c:87: if( width && (flags & PAD_ZERO) ) {
	ld	a, 7 (ix)
	or	a, 6 (ix)
	jr	Z, 00113$
	bit	0, 8 (ix)
	jr	Z, 00113$
	C$print.c$88$3_0$20	= .
	.globl	C$print.c$88$3_0$20
;/workspace/idp-udev/src/ulibc/print.c:88: putchar ('-');
	push	bc
	ld	hl, #0x002d
	call	_putchar
	pop	bc
	C$print.c$90$3_0$20	= .
	.globl	C$print.c$90$3_0$20
;/workspace/idp-udev/src/ulibc/print.c:90: --width;
	ld	l, 6 (ix)
	ld	h, 7 (ix)
	dec	hl
	ld	6 (ix), l
	ld	7 (ix), h
	jr	00117$
00113$:
	C$print.c$93$3_0$21	= .
	.globl	C$print.c$93$3_0$21
;/workspace/idp-udev/src/ulibc/print.c:93: *--s = '-';
	dec	bc
	ld	a, #0x2d
	ld	(bc), a
00117$:
	C$print.c$96$1_0$15	= .
	.globl	C$print.c$96$1_0$15
;/workspace/idp-udev/src/ulibc/print.c:96: _prints(s, width, flags);
	ld	l, 8 (ix)
	ld	h, 9 (ix)
	push	hl
	ld	e, 6 (ix)
	ld	d, 7 (ix)
	ld	l, c
	ld	h, b
	call	__prints
00118$:
	C$print.c$97$1_0$15	= .
	.globl	C$print.c$97$1_0$15
;/workspace/idp-udev/src/ulibc/print.c:97: }
	ld	sp, ix
	pop	ix
	pop	hl
	pop	af
	pop	af
	pop	af
	pop	af
	jp	(hl)
	G$printf$0$0	= .
	.globl	G$printf$0$0
	C$print.c$99$1_0$23	= .
	.globl	C$print.c$99$1_0$23
;/workspace/idp-udev/src/ulibc/print.c:99: void printf(const char *format, ...)
;	---------------------------------
; Function printf
; ---------------------------------
_printf::
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl, #-12
	add	hl, sp
	ld	sp, hl
	C$print.c$103$2_0$24	= .
	.globl	C$print.c$103$2_0$24
;/workspace/idp-udev/src/ulibc/print.c:103: va_start(ap, format);
	ld	hl, #18
	add	hl, sp
	ld	-8 (ix), l
	ld	-7 (ix), h
00132$:
	C$print.c$116$2_1$23	= .
	.globl	C$print.c$116$2_1$23
;/workspace/idp-udev/src/ulibc/print.c:116: for (; *format != 0; ++format) {
	ld	c, 4 (ix)
	ld	b, 5 (ix)
	ld	a, (bc)
	or	a, a
	jp	Z, 00134$
	C$print.c$118$3_1$27	= .
	.globl	C$print.c$118$3_1$27
;/workspace/idp-udev/src/ulibc/print.c:118: if (*format == '%') {
	cp	a, #0x25
	jp	NZ, 00122$
	C$print.c$119$4_1$28	= .
	.globl	C$print.c$119$4_1$28
;/workspace/idp-udev/src/ulibc/print.c:119: ++format;                   /* peek at next char after % */
	inc	bc
	ld	4 (ix), c
	ld	5 (ix), b
	C$print.c$120$4_1$28	= .
	.globl	C$print.c$120$4_1$28
;/workspace/idp-udev/src/ulibc/print.c:120: width = flags = 0;
	xor	a, a
	ld	-2 (ix), a
	ld	-1 (ix), a
	xor	a, a
	ld	-6 (ix), a
	ld	-5 (ix), a
	C$print.c$116$2_1$23	= .
	.globl	C$print.c$116$2_1$23
;/workspace/idp-udev/src/ulibc/print.c:116: for (; *format != 0; ++format) {
	ld	a, 4 (ix)
	ld	-4 (ix), a
	ld	a, 5 (ix)
	ld	-3 (ix), a
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	C$print.c$121$4_1$28	= .
	.globl	C$print.c$121$4_1$28
;/workspace/idp-udev/src/ulibc/print.c:121: if (*format == '\0')        /* if end of string it's a mistake: ignore */
	or	a, a
	jp	Z, 00134$
	C$print.c$123$4_1$28	= .
	.globl	C$print.c$123$4_1$28
;/workspace/idp-udev/src/ulibc/print.c:123: if (*format == '%')         /* if %% then it's escape code */
	cp	a, #0x25
	jp	Z, 00122$
	C$print.c$125$4_1$28	= .
	.globl	C$print.c$125$4_1$28
;/workspace/idp-udev/src/ulibc/print.c:125: if (*format == '-') {       /* if - then pad right and get next format specifier */
	sub	a, #0x2d
	jr	NZ, 00144$
	C$print.c$126$5_1$29	= .
	.globl	C$print.c$126$5_1$29
;/workspace/idp-udev/src/ulibc/print.c:126: ++format;
	ld	a, -4 (ix)
	add	a, #0x01
	ld	4 (ix), a
	ld	a, -3 (ix)
	adc	a, #0x00
	ld	5 (ix), a
	C$print.c$127$5_1$29	= .
	.globl	C$print.c$127$5_1$29
;/workspace/idp-udev/src/ulibc/print.c:127: flags = PAD_RIGHT;
	ld	-2 (ix), #0x02
	ld	-1 (ix), #0
	C$print.c$129$2_1$23	= .
	.globl	C$print.c$129$2_1$23
;/workspace/idp-udev/src/ulibc/print.c:129: while (*format == '0') {    /* if 0 then pad zero and get next format specifier */
00144$:
	ld	a, 4 (ix)
	ld	-4 (ix), a
	ld	a, 5 (ix)
	ld	-3 (ix), a
00107$:
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	e, (hl)
	C$print.c$130$2_1$23	= .
	.globl	C$print.c$130$2_1$23
;/workspace/idp-udev/src/ulibc/print.c:130: ++format;
	ld	c, -4 (ix)
	ld	b, -3 (ix)
	inc	bc
	C$print.c$129$4_1$28	= .
	.globl	C$print.c$129$4_1$28
;/workspace/idp-udev/src/ulibc/print.c:129: while (*format == '0') {    /* if 0 then pad zero and get next format specifier */
	ld	a, e
	sub	a, #0x30
	jr	NZ, 00157$
	C$print.c$130$5_1$30	= .
	.globl	C$print.c$130$5_1$30
;/workspace/idp-udev/src/ulibc/print.c:130: ++format;
	ld	-4 (ix), c
	ld	-3 (ix), b
	ld	4 (ix), c
	ld	5 (ix), b
	C$print.c$131$5_1$30	= .
	.globl	C$print.c$131$5_1$30
;/workspace/idp-udev/src/ulibc/print.c:131: flags |= PAD_ZERO;
	ld	a, -2 (ix)
	ld	-2 (ix), a
	set	0, -2 (ix)
	ld	-1 (ix), #0x00
	jr	00107$
00157$:
	ld	a, -4 (ix)
	ld	4 (ix), a
	ld	a, -3 (ix)
	ld	5 (ix), a
	C$print.c$133$4_1$28	= .
	.globl	C$print.c$133$4_1$28
;/workspace/idp-udev/src/ulibc/print.c:133: if (*format == '*') {
	ld	a, e
	sub	a, #0x2a
	jr	NZ, 00148$
	C$print.c$134$5_1$31	= .
	.globl	C$print.c$134$5_1$31
;/workspace/idp-udev/src/ulibc/print.c:134: width = va_arg(ap, int);
	ld	e, -8 (ix)
	ld	d, -7 (ix)
	inc	de
	inc	de
	ld	-8 (ix), e
	ld	-7 (ix), d
	dec	de
	dec	de
	ld	a, (de)
	ld	-6 (ix), a
	inc	de
	ld	a, (de)
	ld	-5 (ix), a
	C$print.c$135$5_1$31	= .
	.globl	C$print.c$135$5_1$31
;/workspace/idp-udev/src/ulibc/print.c:135: format++;
	ld	4 (ix), c
	ld	5 (ix), b
	jr	00113$
00148$:
	ld	c, -4 (ix)
	ld	b, -3 (ix)
00129$:
	C$print.c$137$6_1$33	= .
	.globl	C$print.c$137$6_1$33
;/workspace/idp-udev/src/ulibc/print.c:137: for ( ; *format >= '0' && *format <= '9'; ++format) {
	ld	a, (bc)
	ld	e, a
	sub	a, #0x30
	jr	C, 00158$
	ld	a, #0x39
	sub	a, e
	jr	C, 00158$
	C$print.c$138$7_1$34	= .
	.globl	C$print.c$138$7_1$34
;/workspace/idp-udev/src/ulibc/print.c:138: width *= 10;
	push	de
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	pop	de
	C$print.c$139$7_1$34	= .
	.globl	C$print.c$139$7_1$34
;/workspace/idp-udev/src/ulibc/print.c:139: width += *format - '0';
	ld	d, #0x00
	ld	a, e
	add	a, #0xd0
	ld	e, a
	ld	a, d
	adc	a, #0xff
	ld	d, a
	add	hl, de
	ld	-6 (ix), l
	ld	-5 (ix), h
	C$print.c$137$6_1$33	= .
	.globl	C$print.c$137$6_1$33
;/workspace/idp-udev/src/ulibc/print.c:137: for ( ; *format >= '0' && *format <= '9'; ++format) {
	inc	bc
	ld	4 (ix), c
	ld	5 (ix), b
	jr	00129$
00158$:
	ld	4 (ix), c
	ld	5 (ix), b
00113$:
	C$print.c$143$4_1$28	= .
	.globl	C$print.c$143$4_1$28
;/workspace/idp-udev/src/ulibc/print.c:143: switch (*format) {
	ld	l, 4 (ix)
	ld	h, 5 (ix)
	ld	a, (hl)
	C$print.c$134$2_1$23	= .
	.globl	C$print.c$134$2_1$23
;/workspace/idp-udev/src/ulibc/print.c:134: width = va_arg(ap, int);
	ld	c, -8 (ix)
	ld	b, -7 (ix)
	inc	bc
	inc	bc
	C$print.c$145$2_1$23	= .
	.globl	C$print.c$145$2_1$23
;/workspace/idp-udev/src/ulibc/print.c:145: u.i = va_arg(ap, int);
	ld	e, c
	ld	d, b
	dec	de
	dec	de
	C$print.c$150$2_1$23	= .
	.globl	C$print.c$150$2_1$23
;/workspace/idp-udev/src/ulibc/print.c:150: u.u = va_arg(ap, unsigned int);
	ld	l, e
	ld	h, d
	C$print.c$143$4_1$28	= .
	.globl	C$print.c$143$4_1$28
;/workspace/idp-udev/src/ulibc/print.c:143: switch (*format) {
	cp	a, #0x58
	jp	Z, 00117$
	C$print.c$145$2_1$23	= .
	.globl	C$print.c$145$2_1$23
;/workspace/idp-udev/src/ulibc/print.c:145: u.i = va_arg(ap, int);
	ld	-4 (ix), e
	ld	-3 (ix), d
	C$print.c$143$4_1$28	= .
	.globl	C$print.c$143$4_1$28
;/workspace/idp-udev/src/ulibc/print.c:143: switch (*format) {
	cp	a, #0x63
	jp	Z, 00118$
	cp	a, #0x64
	jr	Z, 00114$
	cp	a, #0x73
	jp	Z, 00119$
	cp	a, #0x75
	jr	Z, 00115$
	sub	a, #0x78
	jr	Z, 00116$
	jp	00133$
	C$print.c$144$5_1$35	= .
	.globl	C$print.c$144$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:144: case('d'):              /* decimal! */
00114$:
	C$print.c$145$5_1$35	= .
	.globl	C$print.c$145$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:145: u.i = va_arg(ap, int);
	ld	-8 (ix), c
	ld	-7 (ix), b
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	-10 (ix), l
	ld	-9 (ix), h
	C$print.c$146$5_1$35	= .
	.globl	C$print.c$146$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:146: _printi(u.i, 10, 1, width, flags, 'a');
	ld	de, #0x0061
	push	de
	ld	e, -2 (ix)
	ld	d, #0x00
	push	de
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	push	de
	ld	de, #0x0001
	push	de
	ld	de, #0x000a
	call	__printi
	C$print.c$147$5_1$35	= .
	.globl	C$print.c$147$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:147: break;
	jp	00133$
	C$print.c$149$5_1$35	= .
	.globl	C$print.c$149$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:149: case('u'):              /* unsigned */
00115$:
	C$print.c$150$5_1$35	= .
	.globl	C$print.c$150$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:150: u.u = va_arg(ap, unsigned int);
	ld	-8 (ix), c
	ld	-7 (ix), b
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	-10 (ix), l
	ld	-9 (ix), h
	C$print.c$151$5_1$35	= .
	.globl	C$print.c$151$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:151: _printi(u.u, 10, 0, width, flags, 'a');
	ld	de, #0x0061
	push	de
	ld	e, -2 (ix)
	ld	d, #0x00
	push	de
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	push	de
	ld	de, #0x0000
	push	de
	ld	de, #0x000a
	call	__printi
	C$print.c$152$5_1$35	= .
	.globl	C$print.c$152$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:152: break;
	jp	00133$
	C$print.c$154$5_1$35	= .
	.globl	C$print.c$154$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:154: case('x'):              /* hex */
00116$:
	C$print.c$155$5_1$35	= .
	.globl	C$print.c$155$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:155: u.u = va_arg(ap, unsigned int);
	ld	-8 (ix), c
	ld	-7 (ix), b
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	-10 (ix), l
	ld	-9 (ix), h
	C$print.c$156$5_1$35	= .
	.globl	C$print.c$156$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:156: _printi(u.u, 16, 0, width, flags, 'a');
	ld	de, #0x0061
	push	de
	ld	e, -2 (ix)
	ld	d, #0x00
	push	de
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	push	de
	ld	de, #0x0000
	push	de
	ld	de, #0x0010
	call	__printi
	C$print.c$157$5_1$35	= .
	.globl	C$print.c$157$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:157: break;
	jp	00133$
	C$print.c$159$5_1$35	= .
	.globl	C$print.c$159$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:159: case('X'):              /* hex, capital */
00117$:
	C$print.c$160$5_1$35	= .
	.globl	C$print.c$160$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:160: u.u = va_arg(ap, unsigned int);
	ld	-8 (ix), c
	ld	-7 (ix), b
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ld	-10 (ix), l
	ld	-9 (ix), h
	C$print.c$161$5_1$35	= .
	.globl	C$print.c$161$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:161: _printi(u.u, 16, 0, width, flags, 'A');
	ld	de, #0x0041
	push	de
	ld	e, -2 (ix)
	ld	d, #0x00
	push	de
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	push	de
	ld	de, #0x0000
	push	de
	ld	de, #0x0010
	call	__printi
	C$print.c$162$5_1$35	= .
	.globl	C$print.c$162$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:162: break;
	jp	00133$
	C$print.c$164$5_1$35	= .
	.globl	C$print.c$164$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:164: case('c'):              /* char */
00118$:
	C$print.c$165$5_1$35	= .
	.globl	C$print.c$165$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:165: u.c = va_arg(ap, int);
	ld	-8 (ix), c
	ld	-7 (ix), b
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	ld	c, (hl)
	ld	-10 (ix), c
	C$print.c$166$5_1$35	= .
	.globl	C$print.c$166$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:166: scr[0] = u.c;
	ld	hl, #0
	add	hl, sp
	ld	(hl), c
	C$print.c$167$5_1$35	= .
	.globl	C$print.c$167$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:167: scr[1] = '\0';
	ld	-11 (ix), #0x00
	C$print.c$168$5_1$35	= .
	.globl	C$print.c$168$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:168: _prints(scr, width, flags);
	ld	e, -2 (ix)
	ld	d, #0x00
	push	de
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	call	__prints
	C$print.c$169$5_1$35	= .
	.globl	C$print.c$169$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:169: break;
	jr	00133$
	C$print.c$171$5_1$35	= .
	.globl	C$print.c$171$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:171: case('s'):              /* string */
00119$:
	C$print.c$172$5_1$35	= .
	.globl	C$print.c$172$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:172: u.s = va_arg(ap, char *);
	ld	-8 (ix), c
	ld	-7 (ix), b
	ld	a, (de)
	ld	-4 (ix), a
	inc	de
	ld	a, (de)
	ld	-3 (ix), a
	ld	a, -4 (ix)
	ld	-10 (ix), a
	ld	a, -3 (ix)
	ld	-9 (ix), a
	C$print.c$174$5_1$35	= .
	.globl	C$print.c$174$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:174: _prints(u.s ? u.s : "(null)", width, flags);
	ld	a, -3 (ix)
	or	a, -4 (ix)
	jr	Z, 00136$
	ld	a, -10 (ix)
	ld	-4 (ix), a
	ld	a, -9 (ix)
	ld	-3 (ix), a
	jr	00137$
00136$:
	ld	-4 (ix), #<(___str_0)
	ld	-3 (ix), #>(___str_0)
00137$:
	ld	l, -2 (ix)
	ld	h, #0x00
	push	hl
	ld	e, -6 (ix)
	ld	d, -5 (ix)
	ld	l, -4 (ix)
	ld	h, -3 (ix)
	call	__prints
	C$print.c$175$5_1$35	= .
	.globl	C$print.c$175$5_1$35
;/workspace/idp-udev/src/ulibc/print.c:175: break;
	jr	00133$
	C$print.c$181$4_1$36	= .
	.globl	C$print.c$181$4_1$36
;/workspace/idp-udev/src/ulibc/print.c:181: esc:
00122$:
	C$print.c$182$4_1$36	= .
	.globl	C$print.c$182$4_1$36
;/workspace/idp-udev/src/ulibc/print.c:182: putchar(*format);
	ld	h, #0x00
	ld	l, a
	call	_putchar
00133$:
	C$print.c$116$2_1$26	= .
	.globl	C$print.c$116$2_1$26
;/workspace/idp-udev/src/ulibc/print.c:116: for (; *format != 0; ++format) {
	inc	4 (ix)
	jp	NZ, 00132$
	inc	5 (ix)
	jp	00132$
00134$:
	C$print.c$185$2_1$23	= .
	.globl	C$print.c$185$2_1$23
;/workspace/idp-udev/src/ulibc/print.c:185: }
	ld	sp, ix
	pop	ix
	C$print.c$185$2_1$23	= .
	.globl	C$print.c$185$2_1$23
	XG$printf$0$0	= .
	.globl	XG$printf$0$0
	ret
Fprint$__str_0$0_0$0 == .
___str_0:
	.ascii "(null)"
	.db 0x00
	G$puts$0$0	= .
	.globl	G$puts$0$0
	C$print.c$187$2_1$38	= .
	.globl	C$print.c$187$2_1$38
;/workspace/idp-udev/src/ulibc/print.c:187: int puts(const char *s)
;	---------------------------------
; Function puts
; ---------------------------------
_puts::
	ex	de, hl
	C$print.c$190$1_0$38	= .
	.globl	C$print.c$190$1_0$38
;/workspace/idp-udev/src/ulibc/print.c:190: if (s==NULL || s[0]==0) return 0;
	ld	a, d
	or	a, e
	jr	Z, 00101$
	ld	a, (de)
	or	a, a
	jr	NZ, 00111$
00101$:
	ld	de, #0x0000
	ret
	C$print.c$192$1_1$38	= .
	.globl	C$print.c$192$1_1$38
;/workspace/idp-udev/src/ulibc/print.c:192: while(s[i]) { putchar(s[i]); i++; }
00111$:
	ld	bc, #0x0000
00104$:
	ld	l, c
	ld	h, b
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00106$
	ld	h, #0x00
	push	bc
	push	de
	ld	l, a
	call	_putchar
	pop	de
	pop	bc
	inc	bc
	jr	00104$
00106$:
	C$print.c$193$1_1$39	= .
	.globl	C$print.c$193$1_1$39
;/workspace/idp-udev/src/ulibc/print.c:193: return 1;
	ld	de, #0x0001
	C$print.c$194$1_1$38	= .
	.globl	C$print.c$194$1_1$38
;/workspace/idp-udev/src/ulibc/print.c:194: }
	C$print.c$194$1_1$38	= .
	.globl	C$print.c$194$1_1$38
	XG$puts$0$0	= .
	.globl	XG$puts$0$0
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
