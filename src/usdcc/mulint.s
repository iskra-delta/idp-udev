        ;; 16-bit multiply helper for sdcc
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module mulint
        .optsdcc -mz80 sdcccall(1)

        .globl  __mulint
        .area   _CODE

__mulint::
        ;; Move HL to BC for the multiplication algorithm.
        ld      b, h
        ld      c, l
__mul16:
        xor     a, a
        ld      l, a
        or      a, b
        ld      b, #16
        jr      nz, 2$
        ld      b, #8
        ld      a, c
1$:
        add     hl, hl
2$:
        rl      c
        rla
        jr      nc, 3$
        add     hl, de
3$:
        djnz    1$
        ret
