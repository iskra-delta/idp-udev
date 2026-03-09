        ;; 16-bit signed modulo wrapper
        ;;
        ;; NOTES:
        ;;  aliases directly to the shared signed division and remainder helpers
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module modsint
        .optsdcc -mz80

        .globl  __modsint_rrx_s
        .globl  __modsint_rrf_s
        .globl  __modsint
        .globl  __div16
        .globl  __get_remainder
        .area   _CODE

        ;; --------------------------------
        ;; int __modsint(int a, int b)
        ;; --------------------------------
        ;; SDCC wrapper for signed 16-bit modulo
        ;; NOTES:
        ;;  computes division first, then converts the saved remainder state
        ;; inputs: hl=dividend, de=divisor
        ;; outputs: de=remainder
        ;; affects: same as __div16 and __get_remainder
__modsint_rrx_s::
__modsint_rrf_s::
__modsint::
        call    __div16
        jp      __get_remainder
