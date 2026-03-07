        ;; qmath.s
        ;; 
        ;; quick math
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 30.06.2022    tstih
        .module qmath

        .globl  abs_hl

        .area    _CODE
        ;; abs_hl
        ;; calculates absolute value of hl
        ;; NOTES:
        ;;  treats hl as a signed 16-bit integer and
        ;;  negates it in place when the sign bit is set
        ;; inputs: hl=value
        ;; outputs: hl=abs(value)
        ;; affects: af, hl
abs_hl:
        bit     7,h
        ret     z
        xor     a  
        sub     l 
        ld      l,a
        sbc     a,a 
        sub     h 
        ld      h,a
        ret
