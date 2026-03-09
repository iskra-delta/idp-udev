        ;; 16-bit signed division wrapper
        ;;
        ;; NOTES:
        ;;  aliases directly to the shared signed division core
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module divsint
        .optsdcc -mz80

        .globl  __divsint_rrx_s
        .globl  __divsint_rrf_s
        .globl  __divsint
        .globl  __div16
        .area   _CODE

        ;; --------------------------------
        ;; int __divsint(int a, int b)
        ;; --------------------------------
        ;; SDCC wrapper for signed 16-bit division
        ;; NOTES:
        ;;  aliases directly to the shared __div16 implementation
        ;; inputs: hl=dividend, de=divisor
        ;; outputs: de=quotient, hl=remainder state
        ;; affects: same as __div16
__divsint_rrx_s::
__divsint_rrf_s::
__divsint::
        jp      __div16
