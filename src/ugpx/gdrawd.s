        ;; gdrawd.s
        ;; 
        ;; delta drawing functions!
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 17.06.2022    tstih
        .module gdrawd

        .globl  _gdrawd

        .area	_CODE
        ;; -------------------------------
        ;; void gdrawdelta(int dx, int dy)
        ;; -------------------------------
        ;; idealised quick draw delta line 
_gdrawd:
        pop     bc                      ; ret address
        pop     hl                      ; hl=dx
        pop     de                      ; de=dy
        ;; restore stack
        push    de
        push    hl
        push    bc
        ;; command into a
        call    gdp_get_delta_cmd
        push    af                      ; sotre command
        call    abs_hl                  ; hl=abs(dx)       
        ex      de,hl                   ; de=abs(dx)
        call    abs_hl                  ; hl=abs(dy)
        ld      b,l                     ; b=y
        ld      c,e                     ; c=x
        call    gdp_set_dxdy            ; set dx,dy
        pop     af                      ; a=command
        call    gdp_exec_cmd            ; draw!
        ret