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

        .area	_CODE

        ;; ---------------------
        ;; rect_t *gnormrect(
        ;;     rect_t *r)
        ;; ---------------------  
_gnormrect:
        ;; get args
        pop     bc                      ; ret address
        pop     iy                      ; rect address
        ;; restore stack
        push    iy
        push    bc
        ;; iy=pointer to rect...
gnormrectraw:
        ;; now compare x0 and x1
        ld      l,(iy)                  ; hl=x0
        ld      h,1(iy)         
        ld      e,4(iy)                 ; de=x1
        ld      d,5(iy)
        xor     a                       ; clear carry
        sbc     hl,de                   ; test
        jr      c,gnr_test_y            ; second is larger, we're done
        ;; if we are here, switch values
        add     hl,de                   ; restore hl
        ex      de,hl                   ; switch
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
        xor     a                       ; clear carry
        sbc     hl,de                   ; test (again!)
        jr      c,gnr_done              ; all good!
        ;; switch values
        add     hl,de                   ; restore hl
        ex      de,hl                   ; switch
        ld      2(iy),l                 ; hl=x0
        ld      3(iy),h         
        ld      6(iy),e                 ; de=x1
        ld      7(iy),d
        ;; and done!
gnr_done:
        push    iy                      ; return rect ptr.
        pop     hl
        ret        