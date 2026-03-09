        ;; write string
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module gputtext

        .globl  _gputtext

        .include "gdp.inc"
        
        .area    _CODE
        ;; ---------------------------------------------------------------
        ;; void gputtext(void *font, char *text, coord x, coord y)
        ;; ---------------------------------------------------------------
        ;; draws a text string
        ;; NOTES:
        ;;  resolves glyph offsets from the font table,
        ;;  draws each glyph through gpg_raw, and advances
        ;;  the x position by glyph width plus spacing
        ;; inputs: hl=font, de=text, stack=x,y
        ;; outputs: none
        ;; affects: af, bc, de, hl, iy, ix
_gputtext:
        push    iy                      ; preserve caller's iy
        push    ix                      ; preserve caller's ix
        push    de                      ; save text pointer
        pop     iy                      ; iy=text (from DE)
        ld      ix,#0
        add     ix,sp
        exx
        ld      l,6(ix)                 ; hl'=x from stack
        ld      h,7(ix)
        ld      e,8(ix)                 ; de'=y from stack
        ld      d,9(ix)
        ld      b,#0                    ; prepare bc
        exx
        ;; HL contains font, IY contains text, alt regs contain x,y
        ;; obtain first ascii to b, and hor spacing to c
        ;; point hl to glyph offset table
        ld      a,(hl)
        and     #0x0f
        ld      c,a
        inc     hl
        inc     hl
        inc     hl
        ld      b,(hl)
        inc     hl
        inc     hl
        ;; main loop
gpt_loop:
        ld      a,(iy)                  ; get char
        or      a                       ; test
        jr      z,gpt_end               ; terminator (0)?
        sub     b                       ; minust first ascii
        call    gpt_draw                ; draw glyph
        exx
        ld      c,a
        add     hl,bc                   ; add width!
        exx
        inc     iy                      ; next char 
        jr      gpt_loop                ; loop
gpt_draw:
        ;; gpt_draw
        ;; resolves and draws one glyph from the font
        ;; NOTES:
        ;;  uses the character index in a, looks up the
        ;;  glyph offset table, and returns the glyph
        ;;  advance width in a after drawing
        ;; inputs: a=char index, c=spacing, hl=offset table
        ;; outputs: a=advance width
        ;; affects: af, de, hl
        push    hl                      ; store table of offsets
        ex      de,hl
        ld      h,#0                    ; hl=char
        ld      l,A
        add     hl,hl                   ; multiply by 2
        ex      de,hl
        add     hl,de                   ; hl points to offset
        ld      e,(hl)                  ; de points to glyph
        inc     hl
        ld      d,(hl)
        pop     hl                      ; restore table of offsets
        push    hl                      ; and store again
        add     hl,de                   ; point to glyph plus offset
        ld      de,#5                   ; minus 5
        or      a                       ; clear carry
        sbc     hl,de                   ; correct for table offset
        inc     hl                      ; hl points to width
        ld      a,(hl)                  ; get width to a
        add     c                       ; add default width hint
        dec     hl                      ; restore hl
        call    gpt_gdraw               ; draw glyph            
        pop     hl                      ; restore table of offsets
        ret 
gpt_gdraw:
        ;; gpt_gdraw
        ;; draws a glyph while preserving caller state
        ;; NOTES:
        ;;  saves width and cursor state around the gpg_raw
        ;;  call so the caller can continue iterating text
        ;; inputs: hl=glyph, af=width
        ;; outputs: a=width
        ;; affects: af, bc, de, hl
        push    af
        push    bc
        exx
        push    hl
        push    de
        exx
        call    gpg_raw                 ; print glyph
        exx
        pop     de
        pop     hl
        exx
        pop     bc
        pop     af                      ; return width in a
        ret
gpt_end:
        pop     ix                      ; restore caller's ix
        pop     iy                      ; restore caller's iy
        pop     bc                      ; preserve return address
        pop     hl                      ; discard stacked x argument
        pop     hl                      ; discard stacked y argument
        push    bc
        ret
