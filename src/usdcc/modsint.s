        ;; 16-bit signed modulo wrapper
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module modsint
        .optsdcc -mz80 sdcccall(1)

        .globl  __modsint
        .globl  __div16
        .globl  __get_remainder
        .area   _CODE

__modsint::
        call    __div16
        jp      __get_remainder
