        ;; 16-bit multiply helper for sdcc
        ;;
        ;; NOTES:
        ;;  returns the product in DE to match the SDCC z80 runtime ABI
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module mulint
        .optsdcc -mz80

        .globl  __mulint_rrx_s
        .globl  __mulint_rrf_s
        .globl  __mulint
        .globl  __mul16
        .area   _CODE

        ;; --------------------------------
        ;; int __mulint(int a, int b)
        ;; --------------------------------
        ;; multiplies two 16-bit values for the SDCC runtime
        ;; NOTES:
        ;;  __mulint loads BC from HL and then jumps into the shared __mul16 loop
        ;; inputs: hl=multiplicand, de=multiplier
        ;; outputs: de=product
        ;; affects: af, bc, de, hl, flags
__mulint_rrx_s::
__mulint_rrf_s::
__mulint::
        ld      c, l
        ld      b, h
        jp      __mul16

        ;; ------------------------
        ;; int __mul16(int a, int b)
        ;; ------------------------
        ;; shared shift-add multiply core entered with BC and DE prepared
        ;; NOTES:
        ;;  returns the low 16 bits of the product in DE
        ;; inputs: bc=multiplicand, de=multiplier
        ;; outputs: de=product
        ;; affects: af, bc, de, hl, flags
__mul16:
        ld      a, b
        or      a, c
        jr      z, .ret_zero

        ld      a, d
        or      a, e
        jr      z, .ret_zero

        ld      a, c
        sub     a, e
        ld      a, b
        sbc     a, d
        jr      c, .no_swap

        ld      a, c
        ld      c, e
        ld      e, a
        ld      a, b
        ld      b, d
        ld      d, a

.no_swap:
        xor     a
        ld      h, a
        ld      l, a

.mul_loop:
        bit     0, c
        jr      z, .skip_add
        add     hl, de
.skip_add:
        sla     e
        rl      d

        srl     b
        rr      c

        ld      a, b
        or      a, c
        jr      nz, .mul_loop

        ex      de, hl
        ret

.ret_zero:
        xor     a
        ld      d, a
        ld      e, a
        ret
