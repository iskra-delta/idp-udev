        ;; gdrawline.s
        ;; 
        ;; line drawing function
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 22.03.2022    tstih
        .module gdrawline       

        .globl  _gdrawline
        .globl  gdrawlineraw

        ;; --- include ef9367 ports and regs definitions ----------------------
        .include "gdp.inc"

        .area	_CODE

        ;; ---------------------
        ;; void gdrawline(
        ;;     unsigned int  x0, 
        ;;     unsigned int  y0, 
        ;;     unsigned int  x1,
        ;;     unsigned int  y1)
        ;; ---------------------  
_gdrawline:
        ;; pick parameters
        ld      iy,#2                   ; skip over ret address
        add     iy,sp
        ;; to support HW patterns we'll draw line
        ;; from back to front!
gdrawlineraw:
        ;; first calculate dx
        ld      l,4(iy)                 ; hl=x1
        ld      h,5(iy)         
        ld      e,(iy)                  ; de=x0
        ld      d,1(iy)
        or      a                       ; clear carry
        sbc     hl,de                   ; hl=dx
        push    hl                      ; store dx
        ;; now goto x,y
        ex      de,hl                   ; hl=x0
        ld      e,2(iy)                 ; de=y0
        ld      d,3(iy)     
        call    gdp_set_xy
        ;; and calc dy
        ld      l,6(iy)                 ; hl=y1
        ld      h,7(iy)
        or      a
        sbc     hl,de                   ; hl=dy
        ex      de,hl                   ; de=dy
        pop     hl                      ; hl=dx
        ;; get commnad into a
        call    gdp_get_delta_cmd
        ld      c,a                     ; store a to c
        ;; we have the draw command
        call    abs_hl                  
        ex      de,hl
        call    abs_hl                  ; hl=abs(dy), de=abs(dy)
        push    de                      ; push dx
        push    hl                      ; push dy
        ld      b,#1                    ; 1 item on stack
gdl_recurse:
        ;; get dx and dy
        pop     de                      ; dy first
        pop     hl                      ; now dx
        ;; test if both <= 255
        ld      a,d
        or      h
        jr      nz, gld_divide
        ;; if we are here, draw delta!
        call    gdp_wait_ready          ; first wait
        ld      a,l                     ; l=dx
        out     (#EF9367_DX),a
        ld      a,e                     ; e=dy
        out     (#EF9367_DY),a
        ld      a,c                     ; command
        call    gdp_exec_cmd            ; draw!
        djnz    gdl_recurse
        ret
gld_divide:
        ;; divide hl and de to half
        ld      a,l                     ; get hl % 2
        and     #1                      ; into a
        ld      (iy),a                  ; store to stack
        srl     h                       ; hl=hl/2
        rr      l
        push    hl                      ; first dx
        ld      a,e                     ; get de % 2
        and     #1                      ; into a
        ld      1(iy),a                 ; store a on stack
        srl     d                       ; de=de/2
        rr      e
        push    de                      ; then dy
        inc     b                       ; one more on stack
        ;; second half and (possible) remainder
        ld      a,#1
        cp      (iy)
        jr      nz,gld_div_xr
        inc     hl
gld_div_xr:
        push    hl
        cp      1(iy)
        jr      nz,gld_div_yr
        inc     de
gld_div_yr:
        push    de
        inc     b
        djnz    gdl_recurse
        ret