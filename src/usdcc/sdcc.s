		;; sdcc.s
        ;; 
        ;; minimal sdcc library contains only functions to support
        ;; basic integer operations.
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 31.03.2022    tstih
        .module sdcc

        .globl  __mulint
        .globl  __divuint
        .globl  __divuchar
        .globl  __moduchar
        .globl  __moduint
        .globl  ___sdcc_call_hl

        .area   _CODE

__mulint::
        pop     af
        pop     bc
        pop     de
        push    de
        push    bc
        push    af
__mul16:
        xor     a,a
        ld      l,a
        or      a,b
        ld      b,#16
        jr      nz,2$
        ld      b,#8
        ld      a,c
1$:
        add     hl,hl
2$:
        rl      c
        rla
        jr      nc,3$
        add     hl,de
3$:
        djnz    1$
        ret
 __divuint::
        pop     af
        pop     hl
        pop     de
        push    de
        push    hl
        push    af
        jr      __divu16
__divuchar::
        ld      hl,#2+1
        add     hl,sp
        ld      e,(hl)
        dec     hl
        ld      l,(hl)
__divu8:
        ld      h,#0x00
        ld      d,h
__divu16:
        ld      a,e
        and     a,#0x80
        or      a,d
        jr      NZ,.morethan7bits
.atmost7bits:
        ld      b,#16          
        adc     hl,hl
.dvloop7:
        rla
        sub     a,e
        jr      NC,.nodrop7   
        add     a,e            
.nodrop7:
        ccf                               
        adc     hl,hl
        djnz    .dvloop7
        ld      e,a             
        ret
.morethan7bits:
        ld      b,#9           
        ld      a,l             
        ld      l,h           
        ld      h,#0
        rr      l              
.dvloop:
        adc     hl,hl           
        sbc     hl,de
        jr      NC,.nodrop      
        add     hl,de           
.nodrop:
        ccf                    
        rla
        djnz    .dvloop
        rl      b               
        ld      d,b
        ld      e,a           
        ex      de,hl           
        ret
__moduchar::
        ld      hl,#2+1
        add     hl,sp
        ld      e,(hl)
        dec     hl
        ld      l,(hl)
        call    __divu8
	    ex	de,hl
        ret
__moduint::
        pop     af
        pop     hl
        pop     de
        push    de
        push    hl
        push    af
        call    __divu16
        ex      de,hl
        ret
___sdcc_call_hl:
	    jp	(hl)
