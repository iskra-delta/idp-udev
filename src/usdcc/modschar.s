        ;; 8-bit signed modulo wrapper
        ;;
        ;; NOTES:
        ;;  rearranges SDCC's 8-bit argument registers before using the shared core
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module modschar
        .optsdcc -mz80

        .globl  __modschar_rrx_s
        .globl  __modschar_rrf_s
        .globl  __modschar
        .globl  __div8
        .globl  __get_remainder
        .area   _CODE

        ;; ----------------------------------
        ;; char __modschar(char a, char b)
        ;; ----------------------------------
        ;; SDCC wrapper for signed 8-bit modulo
        ;; NOTES:
        ;;  rearranges SDCC's 8-bit args, divides, then fixes the remainder sign
        ;; inputs: a=dividend, l=divisor
        ;; outputs: e=remainder
        ;; affects: same as __div8 and __get_remainder
__modschar_rrx_s::
__modschar_rrf_s::
__modschar::
        ld      e, l
        ld      l, a
        call    __div8
        jp      __get_remainder
