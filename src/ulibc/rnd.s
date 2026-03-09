        ;; implementation of rand() and srand()
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module rnd

        .globl  _rand
        .globl  _srand
        .globl  __rand_init

        .equ    RTC_THOUS_S,    0xa0
        .equ    RTC_HUNDR_S,    0xa1
        .equ    RTC_SECOND,     0xa2
        .equ    RTC_MINUTE,     0xa3

        .area _CODE
        ;; ------------------------
        ;; void __rand_init(void)
        ;; ------------------------
        ;; seeds the PRNG from the realtime clock during startup
        ;; NOTES:
        ;;  combines seconds and minutes into a 16-bit seed and forwards it to srand
        ;; inputs: RTC ports 0xa2 and 0xa3 readable
        ;; outputs: rnd_seedA and rnd_seedB initialized
        ;; affects: af, hl, flags
__rand_init:
        in      a,(RTC_SECOND)
        ld      l,a
        in      a,(RTC_MINUTE)
        ld      h,a
        push    hl
        call    _srand
        pop     hl
        ret

        ;; --------------------------
        ;; void srand(unsigned int seed)
        ;; --------------------------
        ;; seeds the PRNG state from the RTC and the caller-provided seed
        ;; NOTES:
        ;;  seed A is refreshed from the clock each call; seed B comes from HL
        ;; inputs: hl=seed
        ;; outputs: rnd_seedA and rnd_seedB updated
        ;; affects: af, hl
_srand:
        ;; first seed is from system clock.
        in      a,(RTC_THOUS_S)
        ld      (rnd_seedA),a
        in      a,(RTC_HUNDR_S)
        ld      (rnd_seedA+1),a
        ;; second from hl
        ld      (rnd_seedB),hl
        ret

        ;; -----------------
        ;; int rand(void)
        ;; -----------------
        ;; advances the PRNG state and returns a 15-bit pseudo-random value
        ;; NOTES:
        ;;  based on BrandonW's published Z80 routine
        ;; inputs: rnd_seedA and rnd_seedB hold prior state
        ;; outputs: hl=random value in 0..32767, seeds updated
        ;; affects: af, bc, hl, flags
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
