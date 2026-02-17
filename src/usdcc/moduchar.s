        ;; 8-bit unsigned modulo wrapper
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module moduchar
        .optsdcc -mz80 sdcccall(1)

        .globl  __moduchar
        .globl  __divu8
        .area   _CODE

__moduchar::
        call    __divu8
        ex      de, hl
        ret
