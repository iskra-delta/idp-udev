        ;; function prologue helper for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module enter_ix
        .optsdcc -mz80 sdcccall(1)

        .globl  ___sdcc_enter_ix
        .globl  __sdcc_enter_ix
        .area   _CODE

___sdcc_enter_ix:
__sdcc_enter_ix:
        pop     hl
        push    ix
        ld      ix, #0
        add     ix, sp
        jp      (hl)
