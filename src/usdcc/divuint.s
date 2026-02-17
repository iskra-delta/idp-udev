        ;; 16-bit unsigned division wrapper
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module divuint
        .optsdcc -mz80 sdcccall(1)

        .globl  __divuint
        .globl  __divu16
        .area   _CODE

__divuint::
        jp      __divu16
