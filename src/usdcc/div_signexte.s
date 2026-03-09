        ;; shared divisor sign-extension helper for signed division
        ;;
        ;; NOTES:
        ;;  sign-extends E into DE and then enters the 16-bit signed divider
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module div_signexte
        .optsdcc -mz80

        .globl  __div_signexte
        .globl  __div16
        .area   _CODE

        ;; ----------------------------------
        ;; int __div_signexte(int a, char b)
        ;; ----------------------------------
        ;; sign-extends the 8-bit divisor in E and jumps to __div16
        ;; NOTES:
        ;;  used after __div8 has already sign-extended the dividend into HL
        ;; inputs: hl=sign-extended dividend, e=divisor
        ;; outputs: de=quotient, hl=remainder state from __div16
        ;; affects: af, d, flags
__div_signexte::
        ld      a, e
        rlca
        sbc     a, a
        ld      d, a
        jp      __div16
