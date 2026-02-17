        ;; shared divisor sign-extension helper for signed division
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module div_signexte
        .optsdcc -mz80 sdcccall(1)

        .globl  __div_signexte
        .globl  __div16
        .area   _CODE

__div_signexte::
        ld      a, e
        rlca
        sbc     a, a
        ld      d, a
        jp      __div16
