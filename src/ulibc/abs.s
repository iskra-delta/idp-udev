        ;; implementation of abs() for 16-bit integers
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module abs

        .globl  _abs
        .globl  absraw

        .area   _CODE
        ;; --------------
        ;; int abs(int x)
        ;; --------------
        ;; returns the absolute value of a signed 16-bit integer
        ;; NOTES:
        ;;  _abs and absraw share the same entry point
        ;; inputs: hl=x
        ;; outputs: hl=abs(x)
        ;; affects: af, flags
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
