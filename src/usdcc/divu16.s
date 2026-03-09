        ;; shared 16-bit unsigned division core
        ;;
        ;; NOTES:
        ;;  returns the quotient in DE and the remainder in HL
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module divu16
        .optsdcc -mz80

        .globl  __divu16
        .area   _CODE

        ;; -----------------------------------------
        ;; unsigned int __divu16(unsigned int a, unsigned int b)
        ;; -----------------------------------------
        ;; performs unsigned 16-bit division for the SDCC runtime
        ;; NOTES:
        ;;  returns quotient in DE and remainder in HL for reuse by modulo helpers
        ;; inputs: hl=dividend, de=divisor
        ;; outputs: de=quotient, hl=remainder
        ;; affects: af, bc, de, hl, flags
__divu16::
        ld      a, e
        and     a, #0x80
        or      a, d
        jr      nz, .morethan7bits

.atmost7bits:
        ld      b, #16
        adc     hl, hl
.dvloop7:
        rla
        sub     a, e
        jr      nc, .nodrop7
        add     a, e
.nodrop7:
        ccf
        adc     hl, hl
        djnz    .dvloop7
        ld      e, a
        ex      de, hl
        ret

.morethan7bits:
        ld      b, #9
        ld      a, l
        ld      l, h
        ld      h, #0
        rr      l
.dvloop:
        adc     hl, hl
        sbc     hl, de
        jr      nc, .nodrop
        add     hl, de
.nodrop:
        ccf
        rla
        djnz    .dvloop
        rl      b
        ld      d, b
        ld      e, a
        ret
