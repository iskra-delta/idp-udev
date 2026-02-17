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
        ;; calculates absolute value of hl
        ;; inputs:  hl
        ;; outputs: hl = abs(hl)
        ;; affect:  af, hl
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