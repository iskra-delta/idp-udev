		;; gputglyph.s
        ;; 
        ;; draw a glyph
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 06.06.2022    tstih
		.module gputglyph

        .globl  _gputglyph

        .area	_CODE
        ;; ------------------------------------------------------
		;; void gputglyph(g_t *g, void* sprite, coord x, coord y)
        ;; ------------------------------------------------------
        ;; draws glyph at x,y without clipping!
        ;; recognizes standard glyphs from libgpx
_gputglyph:
        ;; first obtain arguments
        ;;  de=g_t *
        ;;  hl=void *
        ;;  hl'=x
        ;;  de'=y
        pop     bc                      ; return address
        pop     de                      ; g
        pop     hl                      ; glyph address
        exx
        pop     hl                      ; hl'=x
        pop     de                      ; de'=y
        ;; and restore stack!
        push    de
        push    hl
        exx
        push    hl
        push    de
        push    bc
        ;; now get number of bytes into bc
        ld      a,(hl)                  ; get sprite signature
        inc     hl                      ; next byte...
        ;; recognize glyph type
        ld      b,a                     ; store to b
        and     #0b01100000             ; only leave signature
        cp      #0b01000000             ; test for lines glyph
        jr      z,gpg_lines
        cp      #0b00100000             ; test for tiny glyph
        jp      z,gpg_tiny
        ;; if we're here, we failed to recognize the glyph!
        ret
        ;; draw lines glyph
gpg_lines:
        ld      a,b                     ; restore a
        inc     hl                      ; skip width
        inc     hl                      ; skip height
        ld      b,(hl)                  ; b=count MSB
        inc     hl                      ; hl=first line
        ld      c,#0                    ; for now
        ;; move BC to the right 4 bits...
        srl     b
        rr      c
        srl     b
        rr      c
        srl     b
        rr      c
        srl     b
        rr      c
        ;; and OR with A
        and     #0x0f                   ; a=count LSN (LS nibble)
        or      c
        ld      c,a                     ; and BC=count!
        ;; loop through all points
gpgl_loop:
        ld      a,(hl)                  ; get byte
        dec     bc                      ; decrease count
        inc     hl                      ; next byte
        cp      #-128                   ; is escape sequence?
        jr      z,gpgl_escape
        ;; it's not an escape sequence
        push    bc                      ; store counter
        ld      c,a                     ; c=dx
        ld      b,(hl)                  ; b=dy
        call    gpgl_drawline           ; set dx and dy
        pop     bc                      ; restore counter
        dec     bc                      ; we picked a value from bc
        inc     hl                      ; increase ptr.
        ld      a,b                     ; if
        or      c
        jr      nz,gpgl_loop            ; then loop
        ret
gpgl_escape:
        ;; DISCLAIMER: at present there's only one command
        ;; (cmd value = 0), so there's no parsing...
        ;; count bounds are also not checked so glyph 
        ;; definition must be correct!
        dec     bc                      ; skip over 0!
        inc     hl
        ld      e,(hl)                  ; e=x
        dec     bc
        inc     hl
        ld      d,(hl)                  ; d=y
        dec     bc
        inc     hl
        push    de                      ; store x,y
        ;; now get x and y and move there!
        ;; preserve hl and de
        exx
        pop     bc                      ; b=y, c=x
        push    hl
        push    de
        ld      a,b                     ; store y
        ld      b,#0                    ; only dx left in bc
        add     hl,bc                   ; add dx+x
        ex      de,hl                   ; de=X, hl=y
        ld      c,a                     ; bc=y
        add     hl,bc                   ; hl=Y
        ex      de,hl                   ; de and hl are set
        call    gdp_set_xy              ; move to x,y
        ;; restore origin!
        pop     de
        pop     hl
        exx
        jr      gpgl_loop               ; and loop!
gpgl_drawline:
        ;; values are signed! b=dy, c=dx
        ;; need to create command and run it...
        ld      d,#0b00010001           ; basic command
        ld      a,b                     ; get dy
        or      a                       ; test
        jp      m,gpgl_negdy            ; dy is negative
        jr      z,gpgl_dx
        ;; positive dy but reverse axix
        ld      d,#0b00010101           ; command with signed dy!
        jr      gpgl_dx
gpgl_negdy:
        ;; we have reverse y axis so negative is positive
        neg                             ; abs. a
        ld      b,a                     ; b=abs(dy)
gpgl_dx:
        ld      a,c                     ; get dx
        or      a
        jp      m,gpgl_negdx            ; dx is negative?
        ld      e,#0                    ; OR value for command
        jr      gpgl_draw
gpgl_negdx:
        neg                             ; dx is positive
        ld      c,a                     
        ld      e,#0b00000010           ; OR value for command
        ;; b=dy,c=dx, d or e = cmd
gpgl_draw:
        call    gdp_set_dxdy
        ;; command to a
        ld      a,d
        or      e
        ;; and call command
        call    gdp_exec_cmd
        ret

        ;; draw tiny glyph
gpg_tiny:
        ;; estract moves
        inc     hl                      ; skip width
        int     hl                      ; skip height
        ld      a,(hl)                  ; number of moves
        or      a                       ; test for zero
        ret     z                       ; no moves...
        sub     #2                      ; moves=moves-2
        ld      b,a                     ; b=move counter
        ;; move to origin
        inc     hl                      ; to origin
        ld      e,(hl)                  ; e=x
        inc     hl
        ld      d,(hl)                  ; d=y
        inc     hl
        push    de                      ; store x,y
        ;; now get x and y and move there!
        ;; preserve hl and de
        exx
        pop     bc                      ; b=y, c=x
        ld      a,b                     ; store y
        ld      b,#0                    ; only dx left in bc
        add     hl,bc                   ; add dx+x
        ex      de,hl                   ; de=X, hl=y
        ld      c,a                     ; bc=y
        add     hl,bc                   ; hl=Y
        ex      de,hl                   ; de and hl are set
        call    gdp_set_xy              ; move to x,y
        exx
        ;; and loop hl (pointing to data!)
gpgt_loop:
        ld      a,(hl)                  ; get move
        inc     hl
        or      #0b10000001             ; set both bits to 1
        xor     #0b00000100             ; negate y sign (rev.axis)
        call    gdp_exec_cmd            ; and draw!
        djnz    gpgt_loop

        ret

        ;; handle pen and color
        ;; inputs: a is the tiny command
gpgt_handle_pen:
        ld      d,#0                    ; assume pen up
        ;; now check pen...
        rlca                            ; get color to first 2 bits
        and     #0b00000011             ; get color
        jr      z,gpgt_set_pen          ; CO_NONE=raise the pen
        inc     d                       ; pen down to d
gpgt_set_pen:
        ;; compare d to (pen_down) cached value
        ld      a,(gdata+3)
        cp      d
        jr      z,gpgt_set_color         ; if the same no change
        ;; if we are here we need to change the pen status
        ;; a has the inverse value!
        or      a                       ; cached pen down?
        jr      nz,gpgt_pen_up          ; pen up
        ;; if we are here, pen down!
        call    gdp_wait_ready
        ld      a,#0b00000011           ; pen down
        out     (#EF9367_CR1),a
        and     #1                      ; a=1!
        ld      (gdata+3),a             ; write to cache
        jr      gpgt_set_color 
gpgt_pen_up:
        ;; if we are here, pen up!
        call    gdp_wait_ready
        ld      a,#0b00000010           ; pen up
        out     (#EF9367_CR1),a
        xor     a
        ld      (pen_down),a            ; and set cached value
        ret                             ; to tny_draw_move
        ;; pen is down/up as it should be
        ;; now set the eraser or ink
gpgt_set_color:
        pop     de                      ; return address
        pop     af                      ; get command 
        push    af                      ; and store back
        push    de
        rlca                            ; color to first two bits
        and     #0b00000010             ; mask?
        jr      nz,gpgt_eraser
        ;; if we are here it's pen
        ld      a,#EF9367_CMD_DMOD_SET
        call    ef9367_cmd
        ret
gpgt_eraser:
        ld      a,#EF9367_CMD_DMOD_CLR
        call    ef9367_cmd
        ret