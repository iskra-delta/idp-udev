        ;; indirect call through hl for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module call_hl
        .optsdcc -mz80

        .globl  ___sdcc_call_hl
        .globl  __sdcc_call_hl
        .area   _CODE

        ;; -------------------------------
        ;; void __sdcc_call_hl(void)
        ;; -------------------------------
        ;; performs an indirect jump through HL for SDCC
        ;; NOTES:
        ;;  ___sdcc_call_hl and __sdcc_call_hl are aliases
        ;; inputs: hl=target address
        ;; outputs: jumps to target
        ;; affects: none
___sdcc_call_hl:
__sdcc_call_hl:
        jp      (hl)
