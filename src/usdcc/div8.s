        ;; shared 8-bit signed division core entry
        ;;
        ;; NOTES:
        ;;  provides both the signed 8-bit wrapper and the shared sign-extension path
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih

        .module div8
        .optsdcc -mz80

        .globl  __divschar_rrx_s
        .globl  __divschar_rrf_s
        .globl  __divschar
        .globl  __div8
        .globl  __div_signexte
        .area   _CODE

        ;; ----------------------------------
        ;; char __divschar(char a, char b)
        ;; ----------------------------------
        ;; arranges 8-bit signed arguments for the shared signed division core
        ;; NOTES:
        ;;  SDCC passes the dividend in A and divisor in L for this helper
        ;; inputs: a=dividend, l=divisor
        ;; outputs: e=quotient, l=remainder scratch from downstream helpers
        ;; affects: af, de, hl, flags
__divschar_rrx_s::
__divschar_rrf_s::
__divschar:
        ld      e, l
        ld      l, a

        ;; --------------------------
        ;; int __div8(char a, char b)
        ;; --------------------------
        ;; sign-extends an 8-bit dividend and forwards to the signed divider
        ;; NOTES:
        ;;  helper for SDCC 8-bit signed division
        ;; inputs: l=dividend, e=divisor
        ;; outputs: de=quotient, hl=remainder state from downstream helpers
        ;; affects: af, hl, flags
__div8::
        ld      a, l
        rlca
        sbc     a, a
        ld      h, a
        jp      __div_signexte
