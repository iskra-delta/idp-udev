        ;; banked-call helper variant for e:hl target
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module bcall_ehl
        .optsdcc -mz80 sdcccall(1)

        .globl  ___sdcc_bcall_ehl
        .area   _CODE

___sdcc_bcall_ehl:
        jp      (hl)
