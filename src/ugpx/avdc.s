		;; scn2674.s
        ;; 
        ;; scn2674 minimal code
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 05.05.2022    tstih
		.module avdc

		.globl	avdc_cls
        .globl  avdc_hide_cursor
        .globl  avdc_show_cursor

        .include "avdc.inc"

        .area	_CODE


        ;; ----- support functions --------------------------------------------

        ;; wait for avdc int
        ;; affects: af
avdc_wait_mem_acc:
        ;; if low, wait for high
        in      a, (#SCN2674_GR_CMNI)
        and     #SCN2674_GR_CMNI_SCN2674A
        jr      z,avdc_wait_mem_acc
        ;; ...wait for high to end
awint:
        in      a, (#SCN2674_GR_CMNI)
        and     #SCN2674_GR_CMNI_SCN2674A
        jr      nz,awint
        ret

        ;; wait for avdc ready
        ;; affects: af
avdc_wait_rdy:
        in      a,(#SCN2674_STS)
        and     #SCN2674_STS_RDY
        jr      z,avdc_wait_rdy
        ret

        ;; write hl to cursor
avdc_hl2cursor:
        call    avdc_wait_rdy
        ;; set cursor
        ld      a,l
        out     (#SCN2674_CUR_LO),a
        ld      a,h
        out     (#SCN2674_CUR_HI),a
        ret

        ;; write cursor to hl
avdc_cursor2hl:
        call    avdc_wait_rdy
        ;; get cursor
        in      a,(#SCN2674_CUR_LO)
        ld      l,a
        in      a,(#SCN2674_CUR_HI)
        ld      h,a
        ret

        ;; write hl to pointer
        ;; affects: af
avdc_hl2pointer:
        call    avdc_wait_rdy
        ;; set pointer to correct row ptr address.
        ld      a,#0x1A                 ; set IR to A (10)
        out     (#SCN2674_CMD), a       ; command!
        ld      a,l
        out     (#SCN2674_INIT),a       ; pointer low
        ld      a,h
        out     (#SCN2674_INIT),a       ; pointer high
        ret

        ;; avdc_read
        ;; read SCN (video!) memory and attr at hl
        ;; NOTES:
        ;;  must be preceeded by avdc_wait_int and
        ;;  avdc_wait_rdy!
        ;; inputs:  hl=memory address
        ;; outputs: e=char, d=attribute
        ;; affects: af, de
avdc_read:
        call    avdc_hl2pointer    
        ;; read char into a
        ld      a,#SCN2674_CMD_RDPTR    ; read at pointer
        out     (SCN2674_CMD), a        ; read into char reg.    
        call    avdc_wait_rdy           ; makes sure we're done
        in      a,(SCN2674_CHR)         ; get char
        ld      e,a                     ; char into e
        in      a,(SCN2674_AT)          ; get attr
        ld      d,a                     ; into d
        ret

		;; avdc_rowptr (l=row index) into hl
        ;; returns row address
        ;; NOTES:
        ;;  on idp a row table mode is used to access
        ;;  rows. row table spans from addr 0 to addr 52.
        ;;  this is enough to store pointers for 26
        ;;  rows (2 bytes per pointer).
        ;;  each row is 132 characters wide.
        ;; inputs: l=row index
        ;; outputs: hl=row address
        ;; affects: hl, de, af
avdc_rowptr:
        ;; calculate exact row addr
        ld      h, #0                   ; hl=row
        add     hl,hl                   ; hl=hl*2
        ;; wait for interrupt
        ;; read it
        call    avdc_read               ; read first byte
        push    de                      ; store result
        inc     hl                      ; addr+1
        call    avdc_read               ; and read to de
        ld      h,e
        pop     de
        ld      l,e
        ret  


        ;; ----- functions ----------------------------------------------------

        ;; clear screen
avdc_cls:
        ld      b,#26                   ; 26 rows
        ld      hl,#0                   ; row #
scls_loop:
        ;; wait access
        call    avdc_wait_mem_acc
        ;; row to hl
        ld      h,#0
        ld      l,b                     ; b=row
        dec     l                       ; make l 0 based index
        call    avdc_rowptr             ; row pointer 2 hl
        ;; now move cursor to hl
        call    avdc_hl2cursor          ; set cursor to start
        ld      de,#131                 ; row length
        add     hl,de                   ; add to hl
        call    avdc_hl2pointer         ; set pointer to end
        ;; set char
        call    avdc_wait_rdy
        ld      a,#32                   ; space
        out     (#SCN2674_CHR),a
        xor     a                       ; attr=0
        out     (#SCN2674_AT),a
        ;; finally, delete from cursor to pointer
        ld      a,#SCN2674_CMD_WC2P
        out     (#SCN2674_CMD), a       ; write from curs. to ptr.
        ;; next row
        djnz    scls_loop
        ;; move cursor to 0,0
        ld      l,#0
        call    avdc_rowptr
        call    avdc_hl2cursor
        ret

        ;; show cursor
avdc_show_cursor:
        call    avdc_wait_mem_acc
        ld      a, #SCN2674_CMD_CURS_ON
        out     (SCN2674_CMD), a
        ret

        ;; hide cursor
avdc_hide_cursor:
        call    avdc_wait_mem_acc
        ld      a, #SCN2674_CMD_CURS_OFF
        out     (SCN2674_CMD), a
        ret