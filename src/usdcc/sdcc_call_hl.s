        ;; indirect call through hl for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module call_hl
        .optsdcc -mz80 sdcccall(1)

        .globl  ___sdcc_call_hl
        .globl  __sdcc_call_hl
        .area   _CODE

___sdcc_call_hl:
__sdcc_call_hl:
        jp      (hl)
