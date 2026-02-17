        ;; gcls.s
        ;; 
        ;; clear current (graphics) page
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 06.06.2022    tstih
        .module gcls

        .globl  _gcls

        .include "gdp.inc"

        .area    _CODE
        ;; -----------
        ;; void gcls()
        ;; -----------
        ;; clear graphic screen
        ;; affect:  af
_gcls:
        ld      a,#EF9367_CMD_CLS
        call    gdp_exec_cmd
        ret