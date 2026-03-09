        ;; a library of primitives for the thompson ef9367 card (GDP)
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module gdp       

        .globl  gdp_set_xy
        .globl  gdp_set_dxdy
        .globl  gdp_exec_cmd
        .globl  gdp_wait_ready
        .globl  gdp_wait_vbl
        .globl  gdp_get_delta_cmd

        ;; --- include ef9367 ports and regs definitions ----------------------
        .include "gdp.inc"

        .area    _CODE
        ;; gdp_wait_ready
        ;; waits for GDP to finish the previous operation
        ;; NOTES:
        ;;  polls the EF9367 ready bit and does not
        ;;  manipulate interrupt state while waiting
        ;; inputs: none
        ;; outputs: none
        ;; affects: af
gdp_wait_ready:
        ;; make sure GDP is free
        in      a,(EF9367_STS_NI)       ; read the status register
        and     #EF9367_STS_NI_READY    ; get ready flag, it's the same bit
        jr      z,gdp_wait_ready
        ret

        ;; gdp_wait_vbl
        ;; waits for vertical blank
        ;; NOTES:
        ;;  polls the EF9367 status register until the
        ;;  vertical blank flag becomes set
        ;; inputs: none
        ;; outputs: none
        ;; affects: af
gdp_wait_vbl:
        in      a,(EF9367_STS_NI)
        and     #EF9367_STS_NI_VBLANK
        jr      z,gdp_wait_vbl
        ret

        ;; gdp_exec_cmd
        ;; executes a GDP command from a
        ;; NOTES:
        ;;  waits for the device to become ready before
        ;;  writing the command register
        ;; inputs: a=command
        ;; outputs: none
        ;; affects: af
gdp_exec_cmd:
        push    af
        call    gdp_wait_ready        ; wait gdp
        pop     af
        out     (#EF9367_CMD), a        ; exec. command
        ret

        ;; gdp_set_dxdy
        ;; writes GDP delta registers
        ;; NOTES:
        ;;  waits for readiness and then stores the
        ;;  8-bit dy and dx values to hardware
        ;; inputs: b=dy, c=dx
        ;; outputs: none
        ;; affects: af
gdp_set_dxdy:
        call    gdp_wait_ready
        ld      a,b
        out     (#EF9367_DY),a
        ld      a,c
        out     (#EF9367_DX),a
        ret

        ;; gdp_set_xy
        ;; moves the graphics cursor to x,y
        ;; NOTES:
        ;;  the EF9367 uses an inverted y axis, so the
        ;;  routine transforms y using the cached screen
        ;;  height before programming the position regs
        ;; inputs: hl=x, de=y
        ;; outputs: none
        ;; affects: af, hl
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

        ;; gdp_get_delta_cmd
        ;; builds a GDP delta-draw command
        ;; NOTES:
        ;;  accepts signed 16-bit dx and dy values and
        ;;  derives the command bits for axis direction,
        ;;  zero-delta cases, and the inverted y axis
        ;; inputs: hl=dx, de=dy
        ;; outputs: a=delta command
        ;; affects: af, bc
gdp_get_delta_cmd:
        ;; first grab both sign bits
        ld      a,h                     ; check if hl is neg.
        and     #0b10000000             ; sign bit?
        rlca                            ; rotate sign bit to...
        rlca                            ; ...bit 1
        ld      b,a                     ; store sign of x
        ld      a,d                     ; the same for de...
        and     #0b10000000
        rlca                            
        rlca
        rlca
        ld      c,a                     ; store sign of y
        ;; now find out if dx=0 or dy=0
        ld      a,h
        or      l
        jr      z,gdp_gd_ign_dx         ; ignore dx?
        ld      a,d
        or      e
        jr      z,gdp_gd_ign_dy         ; ignore dy?
        ;; if we are here there's no ignore so
        ;; create command in a
        ;; NOTE: because y is reverse axis, you need
        ;;       to invert dy sign bit!
        ld      a,#0b00010001           ; draw command
        or      b                       ; add dx sign
        or      c                       ; add dy sign
        xor     #0b00000100             ; invert dy bit
        ret
        ;; ignore dx command...
gdp_gd_ign_dx:
        ld      a,c                     ; dy to a
        rrca                            ; move into dx
        or      c                       ; set dy again!
        xor     #0b00000100             ; negate it (neg. axis)
        or      #0b00010000             ; and set the command bit
        ret
gdp_gd_ign_dy:
        ld      a,b                     ; dx to a
        rlca                            ; move into dy
        or      b                       ; set dx again!
        or      #0b00010000             ; and set the command bit
        ret
