        ;; banked return helper for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module banked_ret
        .optsdcc -mz80

        .globl  __sdcc_banked_ret
        .area   _CODE

        ;; -----------------------------------
        ;; void __sdcc_banked_ret(void)
        ;; -----------------------------------
        ;; returns from a banked SDCC call site
        ;; NOTES:
        ;;  the two NOPs are the platform-specific bank-restore hook site
        ;; inputs: none
        ;; outputs: returns to caller
        ;; affects: none
__sdcc_banked_ret:
        ;; platform-specific bank restore hook.
        nop
        nop
        ret
