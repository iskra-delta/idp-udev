        ;; critical-section entry helper for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module critical
        .optsdcc -mz80 sdcccall(1)

        .globl  ___sdcc_critical
        .globl  __sdcc_critical
        .area   _CODE

___sdcc_critical:
__sdcc_critical:
        ld      a, i
        di
        ret
