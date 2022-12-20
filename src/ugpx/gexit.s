        ;; gexit.s
        ;; 
        ;; exit gpx.
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 06.06.2022    tstih
        .module gexit

        .globl  _gexit

        .area	_CODE
        ;; ------------
        ;; void gexit()
        ;; ------------
        ;; exit graphics mode.
_gexit::
        ;; restoring AVDC cursor is not required.
        ;; it is done by the CP/M warm reset..
        ret