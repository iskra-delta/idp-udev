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
        .globl  __modschar
        .globl  __moduint
        .globl  __modsint
        .globl  __divsint
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
__modschar::
        ld      hl,#2+1
        add     hl,sp
        ld      e,(hl)
        dec     hl
        ld      l,(hl)
        call    __div8
        jp	    __get_remainder
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
__modsint:
        pop     af
        pop     hl
        pop     de
        push    de
        push    hl
        push    af
        call    __div16
        jp	    __get_remainder
__div8::
        ld      a, l            
        rlca
        sbc     a,a
        ld      h, a
__div_signexte::
        ld      a, e            
        rlca
        sbc     a,a
        ld      d, a
__div16::
        ld      a, h            
        xor     a, d            
        rla                     
        ld      a, h            
        push    af              
        rla
        jr      nc, .chkde      
        sub     a, a            
        sub     a, l
        ld      l, a
        sbc     a, a            
        sub     a, h
        ld      h, a
.chkde:
        bit     7, d
        jr      Z, .dodiv       
        sub     a, a           
        sub     a, e
        ld      e, a
        sbc     a, a          
        sub     a, d
        ld      d, a
.dodiv:
        call    __divu16
.fix_quotient:
        pop     af             
        ret	    nc
        ld      b, a
        sub     a, a           
        sub     a, l
        ld      l, a
        sbc     a, a           
        sub     a, h
        ld      h, a
        ld      a, b
	    ret
__get_remainder::
        rla
        ex	    de, hl
        ret     nc            
        sub     a, a            
        sub     a, l
        ld      l, a
        sbc     a, a             
        sub     a, h
        ld      h, a
        ret
__divsint::
        pop     af
        pop     hl
        pop     de
        push    de
        push    hl
        push    af
        jp      __div16
___sdcc_call_hl:
	    jp	(hl)
