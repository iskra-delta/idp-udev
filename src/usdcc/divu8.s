        ;; shared 8-bit unsigned division core entry
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module divu8
        .optsdcc -mz80 sdcccall(1)

        .globl  __divu8
        .globl  __divu16
        .area   _CODE

__divu8::
        ld      h, #0x00
        ld      d, h
        jp      __divu16
