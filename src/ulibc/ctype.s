        ;; ctype.s
        ;; 
        ;; minimal ctype.h implementation
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 18.04.2022    tstih
        .module ctype

        ;; standard C library
        .globl  _isdigit
        .globl  _isalpha
        .globl  _isalnum
        .globl  _islower
        .globl  _isupper
        .globl  _tolower
        .globl  _toupper

        ;; internal functions
        .globl  test_is_alpha
        .globl  test_is_digit
        .globl  test_is_alphanumeric
        .globl  test_is_lower
        .globl  test_is_upper
        .globl  test_inside_interval
        .globl  char_to_upper
        .globl  char_to_lower

        .area _CODE



        ;; ----- standard library functions -----------------------------------

        ;; ----- int isdigit(int c) -------------------------------------------
_isdigit::
        call    ctype_args
        call    test_is_digit
        jr      ctype_is_end

        ;; ----- int isalpha(int c) -------------------------------------------
_isalpha::
        call    ctype_args
        call    test_is_alpha
        jr      ctype_is_end

        ;; ----- int isalnum(int c) -------------------------------------------
_isalnum::
        call    ctype_args
        call    test_is_alphanumeric
        jr      ctype_is_end

        ;; ----- int islower(int c) -------------------------------------------
_islower::
        call    ctype_args
        call    test_is_lower
        jr      ctype_is_end

        ;; ----- int isupper(int c) -------------------------------------------
_isupper::
        call    ctype_args
        call    test_is_upper
        jr      ctype_is_end

        ;; ----- int toupper(int c) -------------------------------------------
_toupper::
        call    ctype_args
        call    char_to_upper
        ret

        ;; ----- int tolower(int c) -------------------------------------------
_tolower::
        call    ctype_args
        call    char_to_lower
        ret


        ;; ----- utility functions --------------------------------------------
        ;; get low byte of int argument to a
        ;; and reset hl
        ;; input(s):
        ;;  stack + 4   int argument
        ;; output(s):
        ;;  a           lo byte of argument
        ;;  hl          reset to 0
        ;; affects:
        ;;  a, hl, iy
ctype_args:
        ld      iy,#4                   ; skip over 2x ret value
        add     iy,sp
        ld      a,(iy)                  ; get lo byte arg to a
        ld      hl,#0                   ; init hl
        ret

        ;; adjust return code in hl based on the z flag
        ;; input(s):
        ;;  hl = 0 
        ;;  z flag
        ;; output(s):
        ;;  if z then hl = 1 else hl = 0
ctype_is_end:
        ret     nz                      ; hl=0
        inc     l                       ; hl=1
        ret


        ;; ----- char functions  ----------------------------------------------
char_to_upper:
        call    test_is_lower           ; only convert if lower
        jr      nz,ctu_done
        sub     #32
ctu_done:
        ld      l,a
        ret

char_to_lower:
        call    test_is_upper           ; only convert if upper
        jr      nz,ctl_done
        add     #32
ctl_done:
        ld      l,a
        ret


        ;; ----- test functions -----------------------------------------------
test_is_alpha:
        call    test_is_upper
        ret     z
        jr      test_is_lower

test_is_upper:
        ld      de,#0x5a41              ; d='Z'. e='A'
        jr      test_inside_interval

test_is_lower:
        ld      de,#0x7a61              ; d='z', e='a'
        jr      test_inside_interval    ; last tests' result is the end result

test_is_alphanumeric:
        call    test_is_digit
        ret     z
        jr      test_is_alpha

test_is_digit:
	    ld      de,#0x3930	            ; d='9', e='0'
        ;; test if a is within DE: D >= A >= E
        ;; input(s):
        ;;  A   value to test
        ;;  DE   interval
        ;; output(s):
        ;;  Z    zero flag is 1 if inside, 0 if outside
        ;; affects:
        ;;  D, E, flags
test_inside_interval:
        push    bc                      ; store original bc
        ld      c,a                     ; store a
        cp      e			            ; a=a-e
        jr      nc, tidg_possible	    ; a>=e       
        jr      tidg_false              ; false
tidg_possible:
        cp      d                       ; a=a-d
        jr      c,tidg_true		        ; a<d
        jr      z,tidg_true             ; a=d
        jr      tidg_false
tidg_true:
        ;; set zero flag
        xor     a                       ; a=0, set zero flag
        ld      a,c                     ; restore a
        pop     bc                      ; restore bc
        ret
tidg_false:
        ;; reset zero flag
        xor     a
        cp      #0xff                   ; reset zero flag
        ld      a,c                     ; restore a
        pop     bc                      ; restore original bc
        ret