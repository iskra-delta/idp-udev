        ;; shared 16-bit signed division core
        ;;
        ;; NOTES:
        ;;  returns the quotient in DE and the remainder in HL
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module div16
        .optsdcc -mz80

        .globl  __div16
        .globl  __divu16
        .area   _CODE

        ;; ------------------------
        ;; int __div16(int a, int b)
        ;; ------------------------
        ;; performs signed 16-bit division for the SDCC runtime
        ;; NOTES:
        ;;  converts both operands to unsigned, calls __divu16, then fixes the sign
        ;; inputs: hl=dividend, de=divisor
        ;; outputs: de=quotient, hl=remainder magnitude/sign per __divu16
        ;; affects: af, de, hl, flags
__div16::
        ld      a, h
        xor     a, d
        rla
        ld      a, h
        push    af

        rla
        jr      nc, .chkde
        sub     a, a
        sub     a, l
        ld      l, a
        sbc     a, a
        sub     a, h
        ld      h, a

.chkde:
        bit     7, d
        jr      z, .dodiv
        sub     a, a
        sub     a, e
        ld      e, a
        sbc     a, a
        sub     a, d
        ld      d, a

.dodiv:
        call    __divu16

.fix_quotient:
        pop     af
        ret     nc
        sub     a, a
        sub     a, e
        ld      e, a
        sbc     a, a
        sub     a, d
        ld      d, a
        ret
