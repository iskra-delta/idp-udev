        ;; move cursor to x,y!
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module gxy

        .globl  _gxy

        .area    _CODE
        ;; --------------------------
        ;; void gxy(coord x, coord y)
        ;; --------------------------
        ;; moves the graphics cursor
        ;; NOTES:
        ;;  thin wrapper around gdp_set_xy using the C
        ;;  calling convention registers
        ;; inputs: hl=x, de=y
        ;; outputs: none
        ;; affects: af, hl
_gxy:
        call    gdp_set_xy
        ret
