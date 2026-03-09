        ;; banked-call helper variant for e:hl target
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module bcall_ehl
        .optsdcc -mz80

        .globl  ___sdcc_bcall_ehl
        .area   _CODE

        ;; ---------------------------------
        ;; void ___sdcc_bcall_ehl(void)
        ;; ---------------------------------
        ;; jumps to a banked-call target already loaded in HL
        ;; NOTES:
        ;;  minimal helper variant used by SDCC-generated stubs
        ;; inputs: hl=target address
        ;; outputs: jumps to target
        ;; affects: none
___sdcc_bcall_ehl:
        jp      (hl)
