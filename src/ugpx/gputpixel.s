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

        .area    _CODE
        ;; --------------------------------
        ;; void gputpixel(coord x, coord y)
        ;; --------------------------------
        ;; draws a single pixel
        ;; NOTES:
        ;;  positions the GDP cursor and issues the fast
        ;;  pixel command using the current pen mode
        ;; inputs: hl=x, de=y
        ;; outputs: none
        ;; affects: af, hl
_gputpixel:
        call    gdp_set_xy
        ;; and draw pixel
        ld      a,#0x80                 ; fast pixel code
        call    gdp_exec_cmd
        ret
