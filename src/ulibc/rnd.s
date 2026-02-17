        ;; rnd.s
        ;; 
        ;; iumplementation of rand and srand
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 13.06.2022    tstih
        .module rnd

        .globl  _rand
        .globl  _srand
        .globl  __rand_init

        .equ    RTC_THOUS_S,    0xa0
        .equ    RTC_HUNDR_S,    0xa1
        .equ    RTC_SECOND,     0xa2
        .equ    RTC_MINUTE,     0xa3

        .area _CODE
__rand_init:
        in      a,(RTC_SECOND)
        ld      l,a
        in      a,(RTC_MINUTE)
        ld      h,a
        push    hl
        call    _srand
        pop     hl
        ret

_srand:
        ;; first seed is from system clock.
        in      a,(RTC_THOUS_S)
        ld      (rnd_seedA),a
        in      a,(RTC_HUNDR_S)
        ld      (rnd_seedA+1),a
        ;; second from hl
        ld      (rnd_seedB),hl
        ret

        ;; return random between 0 and 32767
        ;; source: https://wikiti.brandonw.net/index.php?title=Z80_Routines:Math:Random
_rand:
        ld      hl,(rnd_seedA)
        ld      b,h
        ld      c,l
        add     hl,hl
        add     hl,hl
        inc     l
        add     hl,bc
        ld      (rnd_seedA),hl
        ld      hl,(rnd_seedB)
        add     hl,hl
        sbc     a,a
        and     #0b00101101
        xor     l
        ld      l,a
        ld      (rnd_seedB),hl
        add     hl,bc
        srl     h
        rr      l
        ret

rnd_seedA:
        .dw 0
rnd_seedB:
        .dw 0