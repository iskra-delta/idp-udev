        ;; clear current (graphics) page
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module gcls

        .globl  _gcls

        .include "gdp.inc"

        .area    _CODE
        ;; -----------
        ;; void gcls()
        ;; -----------
        ;; clears the active graphics page
        ;; NOTES:
        ;;  sends the EF9367 clear-screen command to the
        ;;  currently selected write page
        ;; inputs: none
        ;; outputs: none
        ;; affects: af
_gcls:
        ld      a,#EF9367_CMD_CLS
        call    gdp_exec_cmd
        ret
