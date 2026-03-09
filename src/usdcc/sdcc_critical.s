        ;; critical-section entry helper for sdcc z80
        ;;
        ;; gpl-2.0-or-later (see: LICENSE)
        ;; copyright (c) 2026 tomaz stih

        .module critical
        .optsdcc -mz80

        .globl  ___sdcc_critical
        .globl  __sdcc_critical
        .area   _CODE

        ;; --------------------------------
        ;; void __sdcc_critical(void)
        ;; --------------------------------
        ;; enters a critical section and returns the previous interrupt state
        ;; NOTES:
        ;;  ___sdcc_critical and __sdcc_critical are aliases
        ;; inputs: none
        ;; outputs: a=previous I register high bit state
        ;; affects: af, interrupts disabled
___sdcc_critical:
__sdcc_critical:
        ld      a, i
        di
        ret
