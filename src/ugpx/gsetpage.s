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

        .area    _CODE
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
        ;; inputs: a=ops, l=page
        ;; outputs: none
        ;; affects: af, bc
        ld      b,a                     ; preserve ops
        ld      a,l                     ; page to a
        and     #1                      ; keep only bit 0
        jr      z,gsp_select            ; is it 0?
        or      #2                      ; set bit 2
        ;; gsp_select
        ;; normalizes page select bits
        ;; NOTES:
        ;;  expands the one-bit page number into the
        ;;  EF9367 page bit layout and masks it with
        ;;  the requested page operation flags
        ;; inputs: a=page bits, b=ops
        ;; outputs: c=selected page bits
        ;; affects: af, bc
gsp_select:
        and     b                       ; and with selector (op)
        ld      c,a                     ; store extended page in C
        ld      a,b                     ; get selector (op)
        cpl                             ; complement it
        ld      b,a                     ; store neg selector into reg B
        ;; get current state of the page register to a
        call    gdp_wait_ready
        in      a,(PIO_GR_CMN)
        ;; a=xxxxxxxx
        and     b                       ; A=neg selector and current
        ld      b,a                     ; store into b
        or      c                       ; final result is in a (OR with extended page)
        push    af                      ; store result
        ld      a,b                     ; get negated selector
        cpl                             ; get selector (op)
        and     #1                      ; test display page?
        jr      z,gsp_write
        ;; need to wait for vblank
        call    gdp_wait_vbl
        ;; write back to reg!
        ;; gsp_write
        ;; writes the new page selection to hardware
        ;; NOTES:
        ;;  waits for vertical blank when the display
        ;;  page changes, then updates the shared page
        ;;  control register
        ;; inputs: a=selector, stack=result byte
        ;; outputs: none
        ;; affects: af
gsp_write:
        pop     af                      ; restore a
        out     (PIO_GR_CMN),a          ; set pages!
        ret
