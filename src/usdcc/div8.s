        ;; shared 8-bit signed division core entry
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module div8
        .optsdcc -mz80 sdcccall(1)

        .globl  __div8
        .globl  __div_signexte
        .area   _CODE

__div8::
        ld      a, l
        rlca
        sbc     a, a
        ld      h, a
        jp      __div_signexte
