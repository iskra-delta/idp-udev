        ;; 8-bit unsigned division wrapper
        ;;
        ;; NOTES:
        ;;  rearranges SDCC's 8-bit argument registers before entering the shared core
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module divuchar
        .optsdcc -mz80

        .globl  __divuchar_rrx_s
        .globl  __divuchar_rrf_s
        .globl  __divuchar
        .globl  __divu8
        .area   _CODE

        ;; --------------------------------------------------
        ;; unsigned char __divuchar(unsigned char a, unsigned char b)
        ;; --------------------------------------------------
        ;; SDCC wrapper for unsigned 8-bit division
        ;; NOTES:
        ;;  rearranges SDCC's 8-bit arguments and then enters __divu8
        ;; inputs: a=dividend, l=divisor
        ;; outputs: e=quotient, l=remainder scratch from downstream helpers
        ;; affects: same as __divu8 and __divu16
__divuchar_rrx_s::
__divuchar_rrf_s::
__divuchar::
        ld      e, l
        ld      l, a
        jp      __divu8
