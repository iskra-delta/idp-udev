        ;; abs.s
        ;; 
        ;; iumplementation of abs(0 function)
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 16.06.2022    tstih
        .module abs

        .globl  _abs
        .globl  absraw

        .area   _CODE
        ;; --------------
        ;; int abs(int x)
        ;; --------------
_abs:
absraw:
        ;; abs hl
        bit     7,h
        ret     z
        xor     a  
        sub     l 
        ld      l,a
        sbc     a,a 
        sub     h 
        ld      h,a
        ret