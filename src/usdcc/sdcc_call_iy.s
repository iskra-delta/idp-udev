        ;; indirect call through iy for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module call_iy
        .optsdcc -mz80

        .globl  ___sdcc_call_iy
        .globl  __sdcc_call_iy
        .area   _CODE

        ;; -------------------------------
        ;; void __sdcc_call_iy(void)
        ;; -------------------------------
        ;; performs an indirect jump through IY for SDCC
        ;; NOTES:
        ;;  ___sdcc_call_iy and __sdcc_call_iy are aliases
        ;; inputs: iy=target address
        ;; outputs: jumps to target
        ;; affects: none
___sdcc_call_iy:
__sdcc_call_iy:
        jp      (iy)
