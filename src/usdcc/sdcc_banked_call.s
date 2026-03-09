        ;; banked call helper for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module banked_call
        .optsdcc -mz80

        .globl  ___sdcc_bcall
        .globl  __sdcc_bcall
        .globl  __sdcc_banked_call
        .area   _CODE

        ;; ------------------------------------
        ;; void __sdcc_banked_call(void)
        ;; ------------------------------------
        ;; enters a banked function using the call stub layout emitted by SDCC
        ;; NOTES:
        ;;  ___sdcc_bcall, __sdcc_bcall, and __sdcc_banked_call are aliases
        ;;  the two NOPs are the platform-specific bank-switch hook site
        ;; inputs: return address points at target address followed by bank token
        ;; outputs: jumps to target in HL
        ;; affects: bc, de, hl, sp
___sdcc_bcall:
__sdcc_bcall:
__sdcc_banked_call:
        pop     hl

        ld      e, (hl)
        inc     hl
        ld      d, (hl)
        inc     hl

        ld      c, (hl)
        inc     hl
        ld      b, (hl)
        inc     hl

        push    hl

        ;; platform-specific bank switch hook.
        nop
        nop

        push    de
        pop     hl
        jp      (hl)
