		;; gdp.s
        ;; 
        ;; a library of primitives for the thompson ef9367 card (GDP)
        ;; 
        ;; TODO: 
        ;;  - 
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 22.03.2022    tstih
		.module gdp       

        .globl  gdp_set_xy
        .globl  gdp_set_dxdy
        .globl  gdp_exec_cmd
        .globl  gdp_wait_ready
        .globl  gdp_wait_vbl

        ;; --- include ef9367 ports and regs definitions ----------------------
        .include "gdp.inc"

        .area	_CODE
        ;; wait for the GDP to finish previous operation
        ;; don't touch interrupts!
        ;; affects: a
gdp_wait_ready:
        ;; make sure GDP is free
        in      a,(EF9367_STS_NI)       ; read the status register
        and     #EF9367_STS_NI_READY    ; get ready flag, it's the same bit
        jr      z,gdp_wait_ready
        ret

        ;; wait for VBL
        ;; affects: a
gdp_wait_vbl:
        in      a,(EF9367_STS_NI)
        and     #EF9367_STS_NI_VBLANK
        jr      z,gdp_wait_vbl
        ret

        ;; execute command in a
        ;; input:	a=command
        ;; affects: -
gdp_exec_cmd:
        push    af
        call    gdp_wait_ready        ; wait gdp
        pop     af
        out     (#EF9367_CMD), a        ; exec. command
        ret

        ;; set deltas to dx, dy
        ;; inputs:  b=dy, c=dx
        ;; affect:  a
gdp_set_dxdy:
        call    gdp_wait_ready
        ld      a,b
        out     (#EF9367_DY),a
        ld      a,c
        out     (#EF9367_DX),a
        ret

        ;; move the cursor to x,y
        ;; notes:   y is transformed (ef9367 has negative axis!
        ;; inputs:  hl=x, de=y
        ;; affect:  af
gdp_set_xy:
        ;; store hl and de regs
        push    de
        push    hl
        ;; reverse y coordinate
        push    hl                      ; store x
        ld      hl,(gdata)              ; hl=height
        dec     hl                      ; -1
        or      a                       ; clear carry
        sbc     hl,de                   ; hl=maxy-y
        pop     de                      ; de=x
        ex      de,hl                   ; switch
        ;; wait for gdp
        call    gdp_wait_ready
        ld      a,l
        out     (EF9367_XPOS_LO),a
        ld      a,h
        out     (EF9367_XPOS_HI),a
        ld      a,e
        out     (EF9367_YPOS_LO),a
        ld      a,d
        out     (EF9367_YPOS_HI),a
        ;; restore de and hl
        pop     hl
        pop     de
        ret