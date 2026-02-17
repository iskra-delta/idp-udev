        ;; indirect call through iy for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module call_iy
        .optsdcc -mz80 sdcccall(1)

        .globl  ___sdcc_call_iy
        .globl  __sdcc_call_iy
        .area   _CODE

___sdcc_call_iy:
__sdcc_call_iy:
        jp      (iy)
