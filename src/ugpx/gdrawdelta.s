		;; gdrawdelta.s
        ;; 
        ;; delta drawing functions!
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 17.06.2022    tstih
		.module gdrawdelta

        .globl  _gdrawdelta

        .area	_CODE
        ;; -----------------------------------------------
		;; void gdrawdelta(g_t *g, uint8_t dx, uint8_t dy)
        ;; -----------------------------------------------
        ;; idealised quick draw delta line 
_gdrawdelta:
        pop     de                      ; ret addr
        pop     hl                      ; g(ignore)
        pop     bc                      ; c=dx, b=dy
        push    bc
        push    hl
        push    de
        ;; check the sign of dy
        xor     a                       ; a=0
        add     b                       ; add dy
        jp      m,gdd_negdy             ; is positive?
        ;; due to reverse axis this is good! 
        ld      a,#0b00010101
        jr      gdd_testx
gdd_negdy:
        ld      a,b
        neg
        ld      b,a
        ld      a,#0b00010001 
gdd_testx:
        push    af                      ; store command
        xor     a                       ; a=0
        add     c                       ; add dx
        jp      m,gdd_negdx             ; is it positive?
        pop     af
        jr      gdd_draw                ; if positive all is done!
gdd_negdx:
        ld      a,c             
        neg
        ld      c,a
        pop     af
        or      #2                      ; set neg bit for x
gdd_draw:
        push    af
        call    gdp_set_dxdy            ; move to
        pop     af
        call    gdp_exec_cmd            ; and draw!
        ret

