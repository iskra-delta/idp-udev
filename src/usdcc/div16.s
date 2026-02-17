        ;; shared 16-bit signed division core
        ;;
        ;; loosely based on sdcc project implementation
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module div16
        .optsdcc -mz80 sdcccall(1)

        .globl  __div16
        .globl  __divu16
        .area   _CODE

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
        ld      b, a
        sub     a, a
        sub     a, l
        ld      l, a
        sbc     a, a
        sub     a, h
        ld      h, a
        ld      a, b
        ret
