        ;; banked return helper for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module banked_ret
        .optsdcc -mz80 sdcccall(1)

        .globl  __sdcc_banked_ret
        .area   _CODE

__sdcc_banked_ret:
        ;; platform-specific bank restore hook.
        nop
        nop
        ret
