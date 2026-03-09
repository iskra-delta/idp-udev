        ;; function prologue helper for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module enter_ix
        .optsdcc -mz80

        .globl  ___sdcc_enter_ix
        .globl  __sdcc_enter_ix
        .area   _CODE

        ;; --------------------------------
        ;; void __sdcc_enter_ix(void)
        ;; --------------------------------
        ;; installs the current stack frame into IX and continues to the callee body
        ;; NOTES:
        ;;  ___sdcc_enter_ix and __sdcc_enter_ix are aliases
        ;; inputs: stack top holds the continuation address
        ;; outputs: ix points at the saved-ix slot in the new frame, execution jumps onward
        ;; affects: hl, ix, sp
___sdcc_enter_ix:
__sdcc_enter_ix:
        pop     hl
        push    ix
        ld      ix, #0
        add     ix, sp
        jp      (hl)
