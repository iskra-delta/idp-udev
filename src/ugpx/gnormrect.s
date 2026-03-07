        ;; gnormrect.s
        ;; 
        ;; normalize rectangles' coordinates
        ;; after normalization x0 < x1 and y0 < y1
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 22.03.2022    tstih
        .module gnormrect       

        .globl  _gnormrect
        .globl  gnormrectraw

        .include "gdp.inc"

        .area    _CODE

        ;; ---------------------
        ;; rect_t *gnormrect(
        ;;     rect_t *r)
        ;; ---------------------
        ;; normalizes rectangle coordinates
        ;; NOTES:
        ;;  swaps x endpoints and y endpoints in place so
        ;;  the resulting rectangle satisfies x0<x1 and
        ;;  y0<y1 before returning the same pointer
        ;; inputs: hl=rect_t*
        ;; outputs: hl=rect_t*
        ;; affects: af, de, hl, iy
_gnormrect:
        ;; move HL to IY
        push    hl
        pop     iy
        ;; iy=pointer to rect...
gnormrectraw:
        ;; gnormrectraw
        ;; normalizes an IY-based rectangle in place
        ;; NOTES:
        ;;  shared raw entry used when the rectangle
        ;;  pointer is already loaded into iy
        ;; inputs: iy=rect_t*
        ;; outputs: hl=rect_t*
        ;; affects: af, de, hl, iy
        ;; now compare x0 and x1
        ld      l,(iy)                  ; hl=x0
        ld      h,1(iy)         
        ld      e,4(iy)                 ; de=x1
        ld      d,5(iy)
        ld      a,h                     ; compare signs first
        xor     d
        jp      m,gnr_x_sign_diff
        xor     a                       ; clear carry
        sbc     hl,de                   ; signed compare, same sign
        jr      c,gnr_test_y            ; x0 < x1, we're done
        jr      z,gnr_test_y            ; x0 == x1, leave as-is
        ;; if we are here, switch values
        add     hl,de                   ; restore hl
        ex      de,hl                   ; switch
        jr      gnr_store_x
gnr_x_sign_diff:
        bit     7,h                     ; x0 negative, x1 positive?
        jr      nz,gnr_test_y           ; already ordered
        ex      de,hl                   ; swap positive/negative pair
gnr_store_x:
        ld      (iy),l                  ; hl=x0
        ld      1(iy),h         
        ld      4(iy),e                 ; de=x1
        ld      5(iy),d
        ;; now test y...
gnr_test_y:
        ld      l,2(iy)                 ; hl=y0
        ld      h,3(iy)         
        ld      e,6(iy)                 ; de=y1
        ld      d,7(iy)
        ld      a,h                     ; compare signs first
        xor     d
        jp      m,gnr_y_sign_diff
        xor     a                       ; clear carry
        sbc     hl,de                   ; signed compare, same sign
        jr      c,gnr_done              ; y0 < y1, all good
        jr      z,gnr_done              ; y0 == y1, leave as-is
        ;; switch values
        add     hl,de                   ; restore hl
        ex      de,hl                   ; switch
        jr      gnr_store_y
gnr_y_sign_diff:
        bit     7,h                     ; y0 negative, y1 positive?
        jr      nz,gnr_done             ; already ordered
        ex      de,hl                   ; swap positive/negative pair
gnr_store_y:
        ld      2(iy),l                 ; hl=x0
        ld      3(iy),h         
        ld      6(iy),e                 ; de=x1
        ld      7(iy),d
        ;; and done!
gnr_done:
        push    iy                      ; return rect ptr.
        pop     hl
        ret        
