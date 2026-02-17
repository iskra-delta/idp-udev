        ;; banked call helper for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module banked_call
        .optsdcc -mz80 sdcccall(1)

        .globl  ___sdcc_bcall
        .globl  __sdcc_bcall
        .globl  __sdcc_banked_call
        .area   _CODE

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
