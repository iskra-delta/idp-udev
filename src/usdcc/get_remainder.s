        ;; shared signed remainder post-processing
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module get_remainder
        .optsdcc -mz80 sdcccall(1)

        .globl  __get_remainder
        .area   _CODE

__get_remainder::
        rla
        ex      de, hl
        ret     nc
        sub     a, a
        sub     a, l
        ld      l, a
        sbc     a, a
        sub     a, h
        ld      h, a
        ret
