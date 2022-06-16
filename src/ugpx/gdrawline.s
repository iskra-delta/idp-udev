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

        ;; --- include ef9367 ports and regs definitions ----------------------
        .include "gdp.inc"

        .area	_CODE

        ;; ---------------------
        ;; void gdrawline(
        ;;     g_t *g,
        ;;     unsigned int  x0, 
        ;;     unsigned int  y0, 
        ;;     unsigned int  x1,
        ;;     unsigned int  y1)
        ;; ---------------------  
_gdrawline:
        ;; pick parameters
        ld      iy,#4                   ; skip over g
        add     iy,sp
        ;; first goto x,y
        ld      l,(iy)                  ; hl=x0
        ld      h,1(iy)         
        ld      e,2(iy)                 ; hl=y0
        ld      d,3(iy)
        call    gdp_set_xy
        ;; are x coordinates the same?
        xor     a                       ; clear carry
        ;; hl is already x0
        ld      e,4(iy)                 ; de=x1
        ld      d,5(iy)
        sbc     hl,de                   ; x0==x1?
        push    hl                      ; dx on stack
        push    af                      ; flags on stack
        jr      nz,gdl_diff_x
        ;; if we are here x is the same, test y
        call    gdl_test_yeq            ; y0==y1?
        push    hl                      ; store results
        push    af
        jr      nz,gdl_vline            ; vertical line!
        jr      gdl_pixel               ; a pixel!
gdl_diff_x:
        call    gdl_test_yeq            ; y0==y1?
        push    hl                      ; store result!
        push    af
        jr      z,gdl_hline             ; horizontal line
        jp      gdl_line
gdl_test_yeq:
        ld      l,2(iy)                 ; hl=y0
        ld      h,3(iy)
        ld      e,6(iy)                 ; de=y1
        ld      d,7(iy)
        or      a                       ; clear carry flag...
        sbc     hl,de                   ; x0==x1?
        ret
gdl_pixel:                              ; both coordinates are the same!
        ;; clear stack of dx and dy
        pop     hl
        pop     hl
        pop     hl
        pop     hl
        ;; and exec command draw pixel
        ld      a,#0x80                 ; fast pixel code
        call    gdp_exec_cmd
        ret
gdl_hline:
        ;; set dy to 0 (not needed?)
        call    gdp_wait_ready
        xor     a                       ; set...
        ld      (EF9367_DY),a           ; ...dy to 0!
        ;; get dx into hl
        pop     af
        pop     de                      ; de=dy (ignore!)
        pop     af                      ; get flags
        pop     hl                      ; hl=dx
        jr      c,gdl_hl_neg            ; all clear
        ;; we have left to right
        ld      a,#0b00010110           ; negative a
        jr      gdl_hl_set
gdl_hl_neg:
        call    gdl_abs_hl
        ld      a,#0b00010000           ; assume left to right
gdl_hl_set:
        ld      c,#EF9367_DX            ; port dx
        jr      gdl_straight_line       ; and draw
gdl_vline:
        ;; set dx to 0 (not needed?)
        call    gdp_wait_ready
        xor     a                       ; set...
        ld      (EF9367_DX),a           ; ...dx to 0!
        ;; get dy into hl
        pop     af                      ; get flags
        pop     hl                      ; hl=dy 
        pop     de                      ; ignore...
        pop     de                      ; ...dx
        jr      c,gdl_vl_neg            ; all clear
        ;; we have left to right
        ld      a,#0b00010010           ; negative a
        jr      gdl_vl_set
gdl_vl_neg:
        call    gdl_abs_hl
        ld      a,#0b00010100           ; assume left to right
gdl_vl_set:
        ld      c,#EF9367_DY            ; port dy
        ;; fall through to straight line
        ;; ---
        ;; draw straight line 
        ;; inputs: 
        ;;  hl=len
        ;;  a=command
gdl_straight_line:
        ld      b,a                     ; store the command
        dec     hl                      ; last pix. correction
gdpsl_loop:
        ld      de, #GDP_MAX_DELTA
        push    hl                      ; store hl
        or      a                       ; clear carry
        sbc     hl,de                   ; compare len to max
        jr      c,gdpsl_tail            ; len is smaller
        ;; line is longer or equal to max delta...
        ;; draw max delta line
        pop     hl
        call    gdp_wait_ready
        ld      a,#GDP_MAX_DELTA
        out     (c),a                   ; full len.
        ld      a,b
        call    gdp_exec_cmd
        or      a                       ; ccy
        sbc     hl,de                   ; new len
        jr      gdpsl_loop
        ;;      draw last line (length is in l)
gdpsl_tail:
        pop     hl                      ; restore hl
        call    gdp_wait_ready
        ld      a,l
        out     (c),a
        ;; and draw
        ld      a,b                     ; command
        call    gdp_exec_cmd    
        ret
        ;; abs hl
gdl_abs_hl:
        bit     7,h
        ret     z
        xor     a  
        sub     l 
        ld      l,a
        sbc     a,a 
        sub     h 
        ld      h,a
        ret
        ;; TODO: finish the line.
gdl_line:
        ret