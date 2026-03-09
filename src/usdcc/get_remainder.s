        ;; shared signed remainder post-processing
        ;;
        ;; NOTES:
        ;;  expects the saved dividend sign state in A from the signed division path
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module get_remainder
        .optsdcc -mz80

        .globl  __get_remainder
        .area   _CODE

        ;; --------------------------------
        ;; int __get_remainder(int qsign)
        ;; --------------------------------
        ;; converts the divider state into a signed remainder result
        ;; NOTES:
        ;;  expects A to still carry the saved sign information from __div16
        ;; inputs: a=sign state, de=quotient, hl=remainder magnitude
        ;; outputs: de=signed remainder
        ;; affects: af, de, hl, flags
__get_remainder::
        rla
        ex      de, hl
        ret     nc
        sub     a, a
        sub     a, l
        ld      l, a
        sbc     a, a
        sub     a, h
        ld      h, a
        ret
