        ;; 8-bit signed modulo wrapper
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module modschar
        .optsdcc -mz80 sdcccall(1)

        .globl  __modschar
        .globl  __div8
        .globl  __get_remainder
        .area   _CODE

__modschar::
        call    __div8
        jp      __get_remainder
