        ;; scn2674.s
        ;; 
        ;; scn2674 minimal code
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 05.05.2022    tstih
        .module avdc

        .globl    avdc_cls
        .globl  avdc_hide_cursor
        .globl  avdc_show_cursor

        .include "avdc.inc"

        .area    _CODE


        ;; ----- support functions --------------------------------------------

        ;; avdc_wait_mem_acc
        ;; waits for AVDC memory access window
        ;; NOTES:
        ;;  waits for the SCN2674A memory access signal
        ;;  to assert and then deassert before returning
        ;; inputs: none
        ;; outputs: none
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

        ;; avdc_wait_rdy
        ;; waits for AVDC ready state
        ;; NOTES:
        ;;  polls the SCN2674 status register until the
        ;;  ready bit becomes set
        ;; inputs: none
        ;; outputs: none
        ;; affects: af
avdc_wait_rdy:
        in      a,(#SCN2674_STS)
        and     #SCN2674_STS_RDY
        jr      z,avdc_wait_rdy
        ret

        ;; avdc_hl2cursor
        ;; writes cursor address from hl
        ;; NOTES:
        ;;  updates the SCN2674 cursor low and high
        ;;  registers after waiting for the device
        ;; inputs: hl=cursor address
        ;; outputs: none
        ;; affects: af
avdc_hl2cursor:
        call    avdc_wait_rdy
        ;; set cursor
        ld      a,l
        out     (#SCN2674_CUR_LO),a
        ld      a,h
        out     (#SCN2674_CUR_HI),a
        ret

        ;; avdc_cursor2hl
        ;; reads cursor address into hl
        ;; NOTES:
        ;;  reads the SCN2674 cursor low and high
        ;;  registers after waiting for the device
        ;; inputs: none
        ;; outputs: hl=cursor address
        ;; affects: af, hl
avdc_cursor2hl:
        call    avdc_wait_rdy
        ;; get cursor
        in      a,(#SCN2674_CUR_LO)
        ld      l,a
        in      a,(#SCN2674_CUR_HI)
        ld      h,a
        ret

        ;; avdc_hl2pointer
        ;; writes pointer address from hl
        ;; NOTES:
        ;;  programs the SCN2674 pointer registers by
        ;;  first selecting the initialization register
        ;;  pair and then writing low/high bytes
        ;; inputs: hl=pointer address
        ;; outputs: none
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

        ;; avdc_cls
        ;; clears the text screen through row pointers
        ;; NOTES:
        ;;  iterates all 26 rows, resolves each row start
        ;;  address from the row table, then fills the row
        ;;  with spaces and zero attributes
        ;; inputs: none
        ;; outputs: none
        ;; affects: af, bc, de, hl
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

        ;; avdc_show_cursor
        ;; enables the text cursor
        ;; NOTES:
        ;;  waits for a safe memory access window before
        ;;  sending the cursor-on command
        ;; inputs: none
        ;; outputs: none
        ;; affects: af
avdc_show_cursor:
        call    avdc_wait_mem_acc
        ld      a, #SCN2674_CMD_CURS_ON
        out     (SCN2674_CMD), a
        ret

        ;; avdc_hide_cursor
        ;; disables the text cursor
        ;; NOTES:
        ;;  waits for a safe memory access window before
        ;;  sending the cursor-off command
        ;; inputs: none
        ;; outputs: none
        ;; affects: af
avdc_hide_cursor:
        call    avdc_wait_mem_acc
        ld      a, #SCN2674_CMD_CURS_OFF
        out     (SCN2674_CMD), a
        ret
