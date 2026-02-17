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
        .globl  gpg_raw
        .globl  gpgt_set_palette

        .equ    ESCAPE,-128

        .area    _CODE
        ;; ---------------------------------------------
        ;; void gputglyph(void* glyph, coord x, coord y)
        ;; ---------------------------------------------
        ;; draws glyph at x,y without clipping!
        ;; recognizes standard glyphs from libgpx
_gputglyph:
        ;;  hl=void * (glyph) - already in HL
        ;;  hl'=x - from DE
        ;;  de'=y - from stack
        ld      ix,#0
        add     ix,sp
        exx
        ex      de,hl                   ; hl'=x (from DE parameter)
        ld      e,(ix)                  ; de'=y from stack
        ld      d,1(ix)
        exx
        ;; HL contains glyph pointer, alternate regs contain x,y
gpg_raw:
        ;; now get number of bytes into bc
        ld      a,(hl)                  ; get sprite signature
        inc     hl                      ; next byte...
        ;; recognize glyph type
        ld      b,a                     ; store to b
        and     #0b11100000             ; only leave signature
        cp      #0b01000000             ; test for lines glyph
        jr      z,gpg_lines
        cp      #0b00100000             ; test for tiny glyph
        jp      z,gpg_tiny
        ;; if we're here, we failed to recognize the glyph!
        ret
        ;; draw lines glyph
gpg_lines:
        call    gpgt_set_palette        ; get the pallete.
        ld      a,b                     ; restore a
        and     #0x0f                   ; a=msb
        ld      b,a                     ; b=msb
        inc     hl                      ; skip width
        inc     hl                      ; skip height
        ld      c,(hl)                  ; c=count LSB
        inc     hl                      ; hl=first line
        ;; loop through all points, BC=count
gpgl_loop:
        ld      a,(hl)                  ; get byte
        dec     bc                      ; decrease count
        inc     hl                      ; next byte
        cp      #ESCAPE                 ; is escape sequence?
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
        ;; NOTE: 
        ;;      there is no bound check here, the glyph
        ;;      must be correct!!!
gpgl_escape:
        ;; first check if we change the color?
        ld      a,(hl)                  ; command to a
        and     #0b00000010             ; bit 1 = set color
        jr      z,pgl_chk_eos           ; no color change
        ;; let's change color!
        ld      a,(hl)
        and     #0b00001100             ; get the color
        sra     a                       ; color into a
        sra     a                       ; xxxxxxbb
        rrca                            ; bxxxxxxb
        call    gpgt_handle_pen         ; set pen
        ;; check end of stroke?
pgl_chk_eos:
        ld      a,(hl)                  ; command to a (again!)
        and     #0b00000001             ; bit 0 = end of stroke
        jr      z,pgl_eos
        ;; we don't change the position...
        ;; ...next 2 parameters are relative.
        ;; so don't do anything!
        dec     bc
        inc     hl
        jr gpgl_loop
pgl_eos:
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
        call    gpgt_set_palette        ; get the pallete.
gpgt_moves:
        ;; extract no of moves
        inc     hl                      ; skip width
        inc     hl                      ; skip height
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
        call    gpgt_handle_pen
        inc     hl
        or      #0b10000001             ; set both bits to 1
        xor     #0b00000100             ; negate y sign (rev.axis)
        call    gdp_exec_cmd            ; and draw!
        djnz    gpgt_loop
        ret
gpgt_set_palette:
        ;; this sets the correct pallete for drawing
        ;; palette is mapping from currently set ink to 
        ;; ink inside tiny glyph
        ;; affects: a, de
        xor     a
        ld      (gpgt_none_value),a
        push    hl
        ld      a,(gdata+3)             ; get current pen
        ld      (gpgt_stored_pen),a     ; and write to cache as init value
        ld      hl, #gpgt_palette       ; get gpgt_palette
        ld      d,#0
        add     a                       ; a=a*2
        ld      e,a                     ; de=2*a
        add     hl,de                   ; gl points to palette
        ld      de,#gpgt_fore_value
        ldi
        ldi                             ; copy  palette
        pop     hl
        ret
gpgt_palette:
        .db     0, 0
        .db     1, 2
        .db     2, 1
        .db     1, 2
        ;; handle pen and color
        ;; inputs: a is the tiny command
        ;; affects: de
gpgt_handle_pen:
        push    af
        ;; get the pen
        rlca                            ; get color to first 2 bits
        and     #0b00000011             ; get color
        ;; if same as current color, don't do anything expensive
        ld      e,a
        ld      a,(gdata+3)
        cp      e
        jr      z, gpgtp_end
        ;; map to palette
        push    hl                      ; store hl
        ld      hl,#gpgt_none_value     ; hl=assume
        ld      d,#0                    ; de=a (index)
        add     hl,de                   ; point to color
        ld      l,(hl)                  ; l=color
        ;; prepare args for the call!
        call    gsc_raw
        ;; restore original hl
        pop     hl
gpgtp_end:
        pop     af
        ret

        ;; place to store cached values
gpgt_stored_pen:
        .db     0
gpgt_none_value:
        .db     0
gpgt_fore_value:
        .db     1
gpgt_back_value:
        .db     2
