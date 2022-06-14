		;; gputpixel.s
        ;; 
        ;; draw single pixel
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 13.06.2022    tstih
		.module gputpixel

        .globl  _gputpixel

        .include "gdp.inc"

        .area	_CODE
        ;; ----------------------------------------
		;; void gputpixel(g_t *g, coord x, coord y)
        ;; ----------------------------------------
        ;; places pixel at x,y
_gputpixel:
        pop     bc                      ; return address
        pop     de                      ; throwaway g
        pop     hl                      ; hl=x
        pop     de                      ; de=y
        ;; restore stack
        push    de
        push    hl
        push    de
        push    bc
        call    gdp_set_xy
        ;; and draw pixel
        ld      a,#0x80                 ; fast pixel code
        call    gdp_exec_cmd
		ret