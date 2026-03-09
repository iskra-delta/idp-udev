        ;; 8-bit unsigned modulo wrapper
        ;;
        ;; NOTES:
        ;;  rearranges SDCC's 8-bit argument registers before using the shared core
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module moduchar
        .optsdcc -mz80

        .globl  __moduchar_rrx_s
        .globl  __moduchar_rrf_s
        .globl  __moduchar
        .globl  __divu8
        .area   _CODE

        ;; --------------------------------------------------
        ;; unsigned char __moduchar(unsigned char a, unsigned char b)
        ;; --------------------------------------------------
        ;; SDCC wrapper for unsigned 8-bit modulo
        ;; NOTES:
        ;;  rearranges SDCC's 8-bit args and returns the remainder in E
        ;; inputs: a=dividend, l=divisor
        ;; outputs: e=remainder
        ;; affects: same as __divu8 plus hl/de exchange
__moduchar_rrx_s::
__moduchar_rrf_s::
__moduchar::
        ld      e, l
        ld      l, a
        call    __divu8
        ex      de, hl
        ret
