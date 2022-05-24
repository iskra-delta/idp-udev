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

		.globl	_gdp_init
        .globl  _gdp_cls
        

        ;; --- include ef9367 ports and regs definitions ----------------------
        .include "gdp.inc"


        ;; --- limits ---------------------------------------------------------
        .equ    GDP_WIDTH,          1024
        .equ    GDP_HEIGHT,         256
        .equ    GDP_MAX_DELTA,      255


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


        ;; execute command in a
        ;; input:	a=command
        ;; affects: -
gdp_exec_cmd::
        push    af
        call    gdp_wait_ready        ; wait gdp
        pop     af
        out     (#EF9367_CMD), a        ; exec. command
        ret


        ;; set deltas to dx, dy
        ;; inputs:  b=dy, c=dx
        ;; affect:  a, bc
gdp_set_dxdy::
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
gdp_set_xy::
        ;; store hl and de regs
        push    de
        push    hl
        ;; reverse y coordinate
        push    hl                      ; store x
        ld      hl,#(GDP_HEIGHT-1)      ; hl=max y
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

        ;; draw horizontal line 
        ;; input: hl=len
        ;; affects: a
gdp_hline::
        ;; pen down
        ld      a,#0b00000010
        call    gdp_exec_cmd
        ;; store hl and de
        push    hl                      
        push    de
        ld      h,b                     ; hl=bc
        ld      l,c
        dec     hl                      ; last pix. correction
        ;; make sure dy is 0
        call    gdp_wait_ready
        xor     a
        out     (#EF9367_DY),a
gdphl_loop:
        ld      de, #GDP_MAX_DELTA
        push    hl                      ; store hl
        or      a                       ; clear carry
        sbc     hl,de                   ; compare len to max
        jr      c,gdphl_tail            ; len is smaller
        ;; line is longer or equal to max delta...
        ;; draw max delta line
        pop     hl
        call    gdp_wait_ready
        ld      a,#GDP_MAX_DELTA
        out     (#EF9367_DX),a
        ld      a,#0b00010000           ; ignore dy
        call    gdp_exec_cmd
        or      a                       ; ccy
        sbc     hl,de                   ; new len
        jr      gdphl_loop
        ;;      draw last line (length is in l)
gdphl_tail:
        pop     hl                      ; restore hl
        call    gdp_wait_ready
        ld      a,l
        out     (#EF9367_DX),a
        ld      a,#0b00010000           ; ignore dy
        call    gdp_exec_cmd
        ;; restore de and hl
        pop     de
        pop     hl
        ;; pen up
        ld      a,#0b00000011
        call    gdp_exec_cmd
        ;; move 1 pixel to the right
        ld      a,#0b10100000
        call    gdp_exec_cmd
        ret


        ;; ---------------
		;; void gdp_init()
        ;; ---------------
        ;; initializes the ef9367, sets the 1024x256 graphics mode
        ;; no waiting for gdp bcs no command should be executing!
        ;; affect:  a, bc, flags
_gdp_init::
        ;; pen down, set default drawing mode to pen
        ld      a,#(EF9367_CR1_PEN_DOWN|EF9367_CR1_SET_PEN) 
        out     (EF9367_CR1),a          ; control reg 1 to default
        xor     a                       ; a=0
        out     (EF9367_CR2),a          ; control reg 2 to default
        out     (EF9367_CH_SIZE),a      ; no scaling!
        ;; this sets resolution to 1024x256
        ;; and default page to 0
		out     (PIO_GR_CMN),a
        ret


        ;; ------------------
		;; void _gdp_cls()
        ;; ------------------
		;; clear graphic screen
        ;; affect:  af
_gdp_cls::
		ld      a,#EF9367_CMD_CLS
		call    gdp_exec_cmd
        ret