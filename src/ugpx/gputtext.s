		;; gputtext.s
        ;; 
        ;; write string
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 13.06.2022    tstih
		.module gputtext

        .globl  _gputtext

        .include "gdp.inc"

        .area	_CODE
        ;; ---------------------------------------------------------------
		;; void gputtext(g_t *g, void *font, char *text, coord x, coord y)
        ;; ---------------------------------------------------------------
        ;; write string to display at x,y
        ;; affect:  a, 
_gputtext:
        ;; get args from stack
        pop     bc                      ; return address
        pop     de                      ; g (ignored, disposed)
        pop     hl                      ; font
        pop     iy                      ; string
        exx
        pop     hl                      ; hl'=x
        pop     de                      ; de'=y
        ;; and restore stack
        push    de
        push    hl
        ld      b,#0                    ; prepare bc
        exx
        push    iy
        push    hl
        push    de
        push    bc
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
gpt_end:
        ret