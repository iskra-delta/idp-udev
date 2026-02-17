        ;; 8-bit unsigned division wrapper
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module divuchar
        .optsdcc -mz80 sdcccall(1)

        .globl  __divuchar
        .globl  __divu8
        .area   _CODE

__divuchar::
        jp      __divu8
