        ;; gsetpage.s
        ;; 
        ;; set write and/or display page
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 18.06.2022    tstih
        .module gsetpage

        .globl  _gsetpage

        .include "gdp.inc"

        .area	_CODE
        ;; ----------------------------------------
        ;; void gsetpage(uint8_t ops, uint8_t page)
        ;; ----------------------------------------
        ;; sets the current page, ops are flags and can be
        ;; combined (i.e.PG_WRITE|PG_DISPLAY), and the 
        ;; page is 0 or 1
        ;; 
        ;; notes:
        ;;  this function manipulate bits of destination
        ;;  through the mask. the mask tells which bits 
        ;;  from the source are copied to the destination
        ;;
        ;;  following example destination bits that have 
        ;;  mask set to the source bits.
        ;;
        ;;  src       mask      dst      result 
        ;;  10001101  00001111  XXXXXXXX XXXX1101   
        ;;  
        ;;  how does it work?
        ;;  1. and src with mask     00001101 -> S&M
        ;;  2. negate the mask       11110000 -> NM
        ;;  3. and neg.mask with dst XXXX0000 -> NM & D
        ;;  4. or with src and mask  XXXX1101 -> NM & D | S & M
        ;; 
_gsetpage:
        ;; pop arguments from the stack
        ld      iy,#2
        add     iy,sp                   ; spo points to op
        ;; extend page number to 2nd bit
        ld      a,1(iy)                 ; page to a
        and     #1                      ; keep only bit 0
        jr      z,#gsp_select           ; is it 0?
        or      #2                      ; set bit 2
gsp_select:
        and     (iy)                    ; and with selector
        ld      1(iy),a                 ; store to page
        ld      a,(iy)                  ; get selector
        cpl                             ; complement it
        ld      b,a                     ; store neg S into reg b 
        ;; get current state of the page register to a
        call    gdp_wait_ready
        in      a,(PIO_GR_CMN)
        ;; a=xxxxxxxx
        and     b                       ; A=neg S and X
        ld      b,a                     ; store into b
        or      1(iy)                   ; final result is in a
        push    af                      ; store a
        ld      a,(iy)                  ; selector
        and     #1                      ; test display page?
        jr      z,gsp_write
        ;; need to wait for vblank
        call    gdp_wait_vbl
        ;; write back to reg!
gsp_write:
        pop     af                      ; restore a
        out     (PIO_GR_CMN),a          ; set pages!       
        ret