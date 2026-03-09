        ;; exit gpx.
        ;;
        ;; NOTES:
        ;;  currently a stub; CP/M warm reset restores the visible text cursor
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module gexit

        .globl  _gexit

        .area    _CODE
        ;; ------------
        ;; void gexit()
        ;; ------------
        ;; leaves graphics mode
        ;; NOTES:
        ;;  currently a stub; CP/M warm reset restores the
        ;;  visible text cursor state for now
        ;; inputs: none
        ;; outputs: none
        ;; affects: none
_gexit::
        ;; restoring AVDC cursor is not required.
        ;; it is done by the CP/M warm reset..
        ret
