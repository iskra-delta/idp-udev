        ;; 16-bit unsigned modulo wrapper
        ;;
        ;; NOTES:
        ;;  swaps the divider result so the remainder is returned in DE
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module moduint
        .optsdcc -mz80

        .globl  __moduint_rrx_s
        .globl  __moduint_rrf_s
        .globl  __moduint
        .globl  __divu16
        .area   _CODE

        ;; ------------------------------------------------
        ;; unsigned int __moduint(unsigned int a, unsigned int b)
        ;; ------------------------------------------------
        ;; SDCC wrapper for unsigned 16-bit modulo
        ;; NOTES:
        ;;  __divu16 leaves the remainder in HL, which is exchanged into DE here
        ;; inputs: hl=dividend, de=divisor
        ;; outputs: de=remainder
        ;; affects: same as __divu16 plus hl/de exchange
__moduint_rrx_s::
__moduint_rrf_s::
__moduint::
        call    __divu16
        ex      de, hl
        ret
