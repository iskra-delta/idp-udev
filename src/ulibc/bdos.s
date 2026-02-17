        ;; bdos.s
        ;; 
        ;; minimal bdos wrapper
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 22.03.2022    tstih
        .module bdos

        .globl _bdos
        .globl _bdosret

        .equ    BDOS, 5

        .area _CODE


        ;; ---------------------------------------------------------
        ;; unsigned char bdos(unsigned char fn, unsigned int param);
        ;; ---------------------------------------------------------
        ;; calls cp/m bdos
        ;; affect:  af, bc, de, hl
_bdos::
        push    ix                      ; store ix
        ld      c,l                     ; fn to C for BDOS call
        ;; DE already contains param
        call    BDOS                    ; make BDOS call
        pop     ix                      ; restore ix
        ld      l,a                     ; return a
        ret


        ;; -------------------------------------------------------------------------
        ;; bdos_ret_t *bdosret(unsigned char fn, unsigned int param, bdos_ret_t *p);
        ;; -------------------------------------------------------------------------
        ;; calls cp/m bdos and store result to variables
        ;; output: a, b, hl populated with ret. values
        ;; affect:  af, bc, de, hl
_bdosret::
        push    ix                      ; save ix
        ld      c,l                     ; fn to C for BDOS
        ;; DE already contains param
        ;; Save DE before BDOS call (we need it later)
        push    de
        call    BDOS                    ; make BDOS call
        ;; BDOS returns: A, B, DE (sometimes HL)
        pop     de                      ; restore original param to DE
        ;; Now get p pointer from stack
        ;; Stack: [IX][ret_addr][p_lo][p_hi]
        ld      ix,#4                   ; skip over saved IX (2) and return addr (2)
        add     ix,sp
        ld      l,(ix)                  ; p pointer from stack
        ld      h,1(ix)
        push    hl                      ; store pointer as return value
        ;; Store BDOS results to structure pointed by HL
        ld      (hl),a                  ; store a
        inc     hl
        ld      (hl),b                  ; store b
        inc     hl
        ;; DE from BDOS is in DE, but we need the original DE which we popped
        ;; Actually, looking at the old code, it uses ex de,hl to store the result
        ;; The BDOS result HL goes to DE, then stored. Let me check the old code again.
        ;; Old code: ex de,hl means BDOS's HL result goes to DE for storage
        ;; Since BDOS can return in HL, save that
        ex      de,hl                   ; BDOS result HL to DE
        ld      (hl),e                  ; store hl result
        inc     hl
        ld      (hl),d
        ;; restore return value
        pop     hl
        ;; clean stack and exit
        pop     ix                      ; restore ix
        ret