        ;; 16-bit unsigned modulo wrapper
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module moduint
        .optsdcc -mz80 sdcccall(1)

        .globl  __moduint
        .globl  __divu16
        .area   _CODE

__moduint::
        call    __divu16
        ex      de, hl
        ret
