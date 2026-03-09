        ;; minimal ctype.h implementation
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
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

        ;; --------------------
        ;; int isdigit(int c)
        ;; --------------------
        ;; reports whether the low byte of c is an ASCII decimal digit
        ;; NOTES:
        ;;  only the low byte is tested, matching the rest of this ctype subset
        ;; inputs: l=c low byte
        ;; outputs: hl=1 if digit, else hl=0
        ;; affects: af, de, hl, flags
_isdigit::
        call    ctype_args
        call    test_is_digit
        jr      ctype_is_end

        ;; --------------------
        ;; int isalpha(int c)
        ;; --------------------
        ;; reports whether the low byte of c is an ASCII alphabetic character
        ;; NOTES:
        ;;  accepts only ASCII A-Z and a-z
        ;; inputs: l=c low byte
        ;; outputs: hl=1 if alphabetic, else hl=0
        ;; affects: af, de, hl, flags
_isalpha::
        call    ctype_args
        call    test_is_alpha
        jr      ctype_is_end

        ;; --------------------
        ;; int isalnum(int c)
        ;; --------------------
        ;; reports whether the low byte of c is ASCII alphanumeric
        ;; NOTES:
        ;;  combines the local digit and alpha tests
        ;; inputs: l=c low byte
        ;; outputs: hl=1 if alphanumeric, else hl=0
        ;; affects: af, de, hl, flags
_isalnum::
        call    ctype_args
        call    test_is_alphanumeric
        jr      ctype_is_end

        ;; --------------------
        ;; int islower(int c)
        ;; --------------------
        ;; reports whether the low byte of c is an ASCII lowercase letter
        ;; NOTES:
        ;;  accepts only ASCII a-z
        ;; inputs: l=c low byte
        ;; outputs: hl=1 if lowercase, else hl=0
        ;; affects: af, de, hl, flags
_islower::
        call    ctype_args
        call    test_is_lower
        jr      ctype_is_end

        ;; --------------------
        ;; int isupper(int c)
        ;; --------------------
        ;; reports whether the low byte of c is an ASCII uppercase letter
        ;; NOTES:
        ;;  accepts only ASCII A-Z
        ;; inputs: l=c low byte
        ;; outputs: hl=1 if uppercase, else hl=0
        ;; affects: af, de, hl, flags
_isupper::
        call    ctype_args
        call    test_is_upper
        jr      ctype_is_end

        ;; --------------------
        ;; int toupper(int c)
        ;; --------------------
        ;; converts an ASCII lowercase letter to uppercase
        ;; NOTES:
        ;;  returns the input unchanged when it is not lowercase ASCII
        ;; inputs: l=c low byte
        ;; outputs: hl=converted character code
        ;; affects: af, de, hl, flags
_toupper::
        call    ctype_args
        call    char_to_upper
        ret

        ;; --------------------
        ;; int tolower(int c)
        ;; --------------------
        ;; converts an ASCII uppercase letter to lowercase
        ;; NOTES:
        ;;  returns the input unchanged when it is not uppercase ASCII
        ;; inputs: l=c low byte
        ;; outputs: hl=converted character code
        ;; affects: af, de, hl, flags
_tolower::
        call    ctype_args
        call    char_to_lower
        ret


        ;; ----- utility functions --------------------------------------------
        ;; ------------------------
        ;; void ctype_args(void)
        ;; ------------------------
        ;; normalizes the incoming int argument for the local ctype helpers
        ;; NOTES:
        ;;  extracts the low byte to A and clears HL for boolean return assembly
        ;; inputs: l=c low byte
        ;; outputs: a=c low byte, hl=0
        ;; affects: af, hl, flags
ctype_args:
        ld      a,l                     ; get low byte from L
        ld      hl,#0                   ; init hl
        ret

        ;; --------------------------
        ;; void ctype_is_end(void)
        ;; --------------------------
        ;; converts the current zero flag into the standard 0 or 1 HL result
        ;; NOTES:
        ;;  expects HL to be zero on entry
        ;; inputs: hl=0, z flag from the preceding test
        ;; outputs: hl=1 if z is set, else hl=0
        ;; affects: l, flags
ctype_is_end:
        ret     nz                      ; hl=0
        inc     l                       ; hl=1
        ret


        ;; ----- char functions  ----------------------------------------------
        ;; ----------------------------
        ;; int char_to_upper(int c)
        ;; ----------------------------
        ;; converts a lowercase ASCII byte in A to uppercase
        ;; NOTES:
        ;;  helper for _toupper and fparse
        ;; inputs: a=character
        ;; outputs: l=converted character, a preserved as converted character
        ;; affects: af, de, hl, flags
char_to_upper:
        call    test_is_lower           ; only convert if lower
        jr      nz,ctu_done
        sub     #32
ctu_done:
        ld      l,a
        ret

        ;; ----------------------------
        ;; int char_to_lower(int c)
        ;; ----------------------------
        ;; converts an uppercase ASCII byte in A to lowercase
        ;; NOTES:
        ;;  helper for _tolower
        ;; inputs: a=character
        ;; outputs: l=converted character, a preserved as converted character
        ;; affects: af, de, hl, flags
char_to_lower:
        call    test_is_upper           ; only convert if upper
        jr      nz,ctl_done
        add     #32
ctl_done:
        ld      l,a
        ret


        ;; ----- test functions -----------------------------------------------
        ;; ----------------------------
        ;; int test_is_alpha(int c)
        ;; ----------------------------
        ;; tests whether A is an ASCII alphabetic character
        ;; NOTES:
        ;;  returns through flags only; zero means success
        ;; inputs: a=character
        ;; outputs: z set if alphabetic
        ;; affects: af, de, flags
test_is_alpha:
        call    test_is_upper
        ret     z
        jr      test_is_lower

        ;; ----------------------------
        ;; int test_is_upper(int c)
        ;; ----------------------------
        ;; tests whether A is an ASCII uppercase character
        ;; NOTES:
        ;;  delegates the interval check to test_inside_interval
        ;; inputs: a=character
        ;; outputs: z set if in 'A'..'Z'
        ;; affects: af, de, flags
test_is_upper:
        ld      de,#0x5a41              ; d='Z'. e='A'
        jr      test_inside_interval

        ;; ----------------------------
        ;; int test_is_lower(int c)
        ;; ----------------------------
        ;; tests whether A is an ASCII lowercase character
        ;; NOTES:
        ;;  delegates the interval check to test_inside_interval
        ;; inputs: a=character
        ;; outputs: z set if in 'a'..'z'
        ;; affects: af, de, flags
test_is_lower:
        ld      de,#0x7a61              ; d='z', e='a'
        jr      test_inside_interval    ; last tests' result is the end result

        ;; -----------------------------------
        ;; int test_is_alphanumeric(int c)
        ;; -----------------------------------
        ;; tests whether A is an ASCII letter or digit
        ;; NOTES:
        ;;  tries the digit range first, then the alphabetic ranges
        ;; inputs: a=character
        ;; outputs: z set if alphanumeric
        ;; affects: af, de, flags
test_is_alphanumeric:
        call    test_is_digit
        ret     z
        jr      test_is_alpha

        ;; ----------------------------
        ;; int test_is_digit(int c)
        ;; ----------------------------
        ;; tests whether A is an ASCII decimal digit
        ;; NOTES:
        ;;  delegates the interval check to test_inside_interval
        ;; inputs: a=character
        ;; outputs: z set if in '0'..'9'
        ;; affects: af, de, flags
test_is_digit:
        ld      de,#0x3930                ; d='9', e='0'

        ;; ---------------------------------------
        ;; int test_inside_interval(int value)
        ;; ---------------------------------------
        ;; tests whether A is inside the inclusive ASCII interval E..D
        ;; NOTES:
        ;;  zero flag indicates success and A is restored before return
        ;; inputs: a=value, de={upper,lower} bound
        ;; outputs: z set if e<=a<=d
        ;; affects: af, bc, flags
test_inside_interval:
        push    bc                      ; store original bc
        ld      c,a                     ; store a
        cp      e                        ; a=a-e
        jr      nc, tidg_possible        ; a>=e       
        jr      tidg_false              ; false
tidg_possible:
        cp      d                       ; a=a-d
        jr      c,tidg_true                ; a<d
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
