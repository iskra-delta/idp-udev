        ;; minimal bdos wrapper
        ;;
        ;; NOTES:
        ;;  preserves IX so the wrappers remain C-call-safe
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module bdos

        .globl _bdos
        .globl _bdosret

        .equ    BDOS, 5

        .area _CODE


        ;; ---------------------------------------------------------
        ;; unsigned char bdos(unsigned char fn, unsigned int param);
        ;; ---------------------------------------------------------
        ;; calls cp/m bdos
        ;; NOTES:
        ;;  preserves ix across the BDOS jump so it remains C-call-safe
        ;; inputs: a=fn, de=param
        ;; outputs: l=BDOS return value from a
        ;; affects: af, bc, de, hl, flags
_bdos::
        push    ix                      ; store ix
        ld      c,a                     ; fn to C for BDOS call
        ;; DE already contains param
        call    BDOS                    ; make BDOS call
        pop     ix                      ; restore ix
        ld      l,a                     ; return a
        ret


        ;; -------------------------------------------------------------------------
        ;; bdos_ret_t *bdosret(unsigned char fn, unsigned int param, bdos_ret_t *p);
        ;; -------------------------------------------------------------------------
        ;; calls CP/M BDOS and stores the returned A, B, and HL values into *p
        ;; NOTES:
        ;;  the return value is p so the function matches the C declaration
        ;; inputs: a=fn, de=param, stack[0]=p
        ;; outputs: hl=p, *p={a,b,hl} from BDOS
        ;; affects: af, bc, de, hl, ix, flags
_bdosret::
        push    ix
        ld      c,a                     ; fn to C for BDOS
        call    BDOS
        push    af                      ; preserve returned A/F
        push    bc                      ; preserve returned B/C
        push    hl                      ; preserve returned HL
        ld      ix,#10                  ; saved regs + saved ix + return address
        add     ix,sp
        ld      e,(ix)                  ; p
        ld      d,1(ix)
        pop     hl                      ; hl=BDOS HL
        pop     bc                      ; b=BDOS B
        pop     af                      ; a=BDOS A
        push    de                      ; preserve p for return value
        ld      (de),a
        inc     de
        ld      a,b
        ld      (de),a
        inc     de
        ld      a,l
        ld      (de),a
        inc     de
        ld      a,h
        ld      (de),a
        pop     hl                      ; return p
        pop     ix
        ret
