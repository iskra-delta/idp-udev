   		;; gxy.s
        ;; 
        ;; move cursor to x,y!
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 18.06.2022    tstih
		.module gxy

        .globl  _gxy

        .area	_CODE
        ;; --------------------------
		;; void gxy(coord x, coord y)
        ;; --------------------------
_gxy:
        pop     bc                      ; ret addr
        pop     hl                      ; hl=x
        pop     de                      ; de=y
        ;; restore stack
        push    de
        push    hl
        push    bc
        call    gdp_set_xy
        ret