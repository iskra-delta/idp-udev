        ;; 16-bit signed division wrapper
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module divsint
        .optsdcc -mz80 sdcccall(1)

        .globl  __divsint
        .globl  __div16
        .area   _CODE

__divsint::
        jp      __div16
