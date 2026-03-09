        ;; 16-bit unsigned division wrapper
        ;;
        ;; NOTES:
        ;;  aliases directly to the shared unsigned division core
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module divuint
        .optsdcc -mz80

        .globl  __divuint_rrx_s
        .globl  __divuint_rrf_s
        .globl  __divuint
        .globl  __divu16
        .area   _CODE

        ;; ------------------------------------------------
        ;; unsigned int __divuint(unsigned int a, unsigned int b)
        ;; ------------------------------------------------
        ;; SDCC wrapper for unsigned 16-bit division
        ;; NOTES:
        ;;  aliases directly to the shared __divu16 implementation
        ;; inputs: hl=dividend, de=divisor
        ;; outputs: de=quotient, hl=remainder
        ;; affects: same as __divu16
__divuint_rrx_s::
__divuint_rrf_s::
__divuint::
        jp      __divu16
