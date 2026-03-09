        ;; delta drawing functions!
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module gdrawd

        .globl  _gdrawd

        .area    _CODE
        ;; -------------------------------
        ;; void gdrawdelta(int dx, int dy)
        ;; -------------------------------
        ;; draws a delta line
        ;; NOTES:
        ;;  builds the GDP delta command from signed dx,dy,
        ;;  converts both magnitudes to absolute values,
        ;;  then issues the hardware line command
        ;; inputs: hl=dx, de=dy
        ;; outputs: none
        ;; affects: af, bc, de, hl
_gdrawd:
        ;; command into a
        call    gdp_get_delta_cmd
        push    af                      ; store command
        call    abs_hl                  ; hl=abs(dx)       
        ex      de,hl                   ; de=abs(dx)
        call    abs_hl                  ; hl=abs(dy)
        ld      b,l                     ; b=y
        ld      c,e                     ; c=x
        call    gdp_set_dxdy            ; set dx,dy
        pop     af                      ; a=command
        call    gdp_exec_cmd            ; draw!
        ret
