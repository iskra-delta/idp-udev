        ;; shared 8-bit unsigned division core entry
        ;;
        ;; NOTES:
        ;;  zero-extends 8-bit operands and falls into the 16-bit unsigned divider
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module divu8
        .optsdcc -mz80

        .globl  __divu8
        .globl  __divu16
        .area   _CODE

        ;; --------------------------------------------
        ;; unsigned char __divu8(unsigned char a, unsigned char b)
        ;; --------------------------------------------
        ;; zero-extends 8-bit operands and forwards to __divu16
        ;; NOTES:
        ;;  helper for SDCC 8-bit unsigned division
        ;; inputs: l=dividend, e=divisor
        ;; outputs: de=quotient, hl=remainder
        ;; affects: d, h
__divu8::
        ld      h, #0x00
        ld      d, h
        jp      __divu16
