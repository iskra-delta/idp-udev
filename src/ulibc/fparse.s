		;; fparse.s
        ;; 
        ;; minimal io ops
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 14.04.2022    tstih
        .module fparse

        .globl  _fparse

        ;; automata states
        .equ    S_START,        0b00000000
        .equ    S_AREA,         0b00000001
        .equ    S_DRIVE,        0b00000010
        .equ    S_FNAME0,       0b00000011
        .equ    S_FNAME,        0b00000100
        .equ    S_EXT0,         0b00000101
        .equ    S_EXT,          0b00000110
        .equ    S_END,          0b00000111

        ;; automata test
        .equ    T_ELSE,         0b00000000
        .equ    T_DIGIT,        0b00010000
        .equ    T_COLON,        0b00100000
        .equ    T_DOT,          0b00110000
        .equ    T_ALPHA,        0b01000000
        .equ    T_ASCII7,       0b01010000
        .equ    T_ZERO,         0b01100000

        ;; automata functions
        .equ    F_NONE,         0b00000000
        .equ    F_APPEND_AREA,  0b00010000
        .equ    F_STACK_SYM,    0b00100000
        .equ    F_SET_DRV,      0b00110000
        .equ    F_APPEND_FNAME, 0b01000000
        .equ    F_APPEND_EXT,   0b01010000

        ;; return (status) codes
        .equ    R_SUCCESS,      0       ; all good that ends good
        .equ    R_UNEXPECT,     1       ; unexpected symbol
        .equ    R_INVALID_FN,   2       ; function not defined
        .equ    R_INVALID_AREA, 3       ; area not in 0-15 range
        .equ    R_SSTACK_OF,    4       ; symbol stack overflow
        .equ    R_FNAME_OF,     5       ; filename overflow
        .equ    R_EXT_OF,       6       ; extension overflow

        ;; defaults
        .equ    DEFAULT_AREA,   0xff
        .equ    NO_SYM,         0x00

        .area _CODE
        ;; ----- int fparse(char *path, fcb_t *fcb, uint8_t *area) ------------
_fparse::
        ;; fetch args from stack
        pop     af                      ; ignore the return address...
        pop     hl                      ; pointer to path to hl
        exx
        ;; pad filename and extension (of FCB) with spaces
        pop     de                      ; pointer to fcb to de
        push    de                      ; return it
        xor     a                       ; a=0
        ld      (de),a                  ; default drive
        inc     de                      ; skip over default 
        ld      b,#11                   ; 8+3 filename
        ld      a,#' '                  ; pad with spaces
fpa_init_fcb:
        ld      (de),a
        inc     de
        djnz    fpa_init_fcb
        pop     de                      ; restore de
        pop     bc                      ; pointer to area to bc
        exx
        ;; restore stack and make iy point to it
        ld      iy,#-8
        add     iy,sp
        ld      sp,iy
        ;; we will use space from 2(iy) to 7(iy) as
        ;; local variables ... overwriting arguments
        ld      2(iy),#S_START          ; initial state to 2(iy)!
        ld      3(iy),#R_UNEXPECT       ; status is unexpected
        ld      4(iy),#DEFAULT_AREA     ; default area
        ld      5(iy),#NO_SYM           ; stacked symbol
        ld      6(iy),#0                ; fname len
        ld      7(iy),#0                ; ext len
        ;; main loop
fpa_nextsym:
        ;; get next symbol
        ld      a,(hl)
        push    hl                      ; store hl!
        ;; find transition
        call    fpa_find_transition
        ;; if not found then unexpected error
        jr      nz,fpa_done
        ;; else transition function id is in register l
        call    fpa_execfn
        jr      nz,fpa_done             ; if not zero then status!
        ;; is it final state?
        ld      a,2(iy)
        and     #0x0f
        cp      #S_END
        jr      z,fpa_done
        ;; loop
        pop     hl                      ; restore hl
        inc     hl                      ; next symbol
        jr      fpa_nextsym             ; and loop
        ;; find transition
fpa_find_transition:
        ld      hl,#fpa_automata        ; address of mealy automata
        ;; b=total transitions
        ld      b,#((efpa_automata-fpa_automata)/2)
        ld      c,a                     ; store a
fpaft_loop:
        ld      a,(hl)                  ; get first byte
        and     #0b00001111             ; get state
        cp      2(iy)                   ; is it current state?
        call    z,fpaft_test            ; call test
        jr      nz,fpaft_next           ; test failed, next trans.
        inc     hl                      ; get next byte
        ld      a,(hl)                  ; get second byte to a
        and     #0b00001111             ; grab next state
        ld      2(iy),a                 ; store to current state
        ld      a,(hl)                  ; get second byte to a
        and     #0b11110000             ; extract function
        ld      l,a                     ; get function to l
        ;; and return success
        xor     a
        ld      a,c
        ret
fpaft_next:
        inc     hl                      ; next state
        inc     hl
        djnz    fpaft_loop              ; and loop it
        ;; if we are here, we did not find
        ;; the transition. clear zero flag!
fpaft_unexpect_sym:
        ld      3(iy), #R_UNEXPECT
fpaft_set_z:
        xor     a
        cp      #0xff                   ; rest z flag
        ld      a,c                     ; resotre a
        ret
        ;; we're done parsing
fpa_done:
        pop     hl                      ; clear stack
        ;; set result
        ld      h,#0                    
        ld      l,3(iy)
        ;; set area
        ld      a,4(iy)                 ; get area
        exx
        ld      (bc),a                  ; set area
        ;; convert drive to uppercase
        ld      a,(de)                  ; get drive
        or      a                       ; test for no drive
        jr      z,fpa_no_drive
        push    de                      ; store de
        call    char_to_upper           ; convert to upper
        sub     #'A'-1                  ; make 1 based index
        pop     de                      ; restore de
        ld      (de),a                  ; set drive
fpa_no_drive:
        exx
        ;; and return
        ret   

        ;; ----- tests --------------------------------------------------------
        ;; extract test from a and do it!
fpaft_test:
        ld      a,(hl)                  ; get a (again)
        and     #0b11110000             ; extract test
ftaft_t01:
        cp      #T_DIGIT                ; digit test?
        jr      nz,ftaft_t02
        ;; it is digit test
        ld      a,c                     ; symbol to a
        call    test_is_digit
        ret
ftaft_t02:
        cp      #T_COLON
        jr      nz,ftaft_t03
        ld      a,c                     ; symbol to a
        cp      #':'
        ret
ftaft_t03:
        cp      #T_DOT
        jr      nz,ftaft_t04
        ld      a,c                     ; symbol to a
        cp      #'.'
        ret
ftaft_t04:
        cp      #T_ALPHA
        jr      nz,ftaft_t05
        ld      a,c                     ; symbol to a
        call    test_is_alpha
        ret
ftaft_t05:
        cp      #T_ASCII7
        jr      nz,ftaft_t06
        ld      a,c                     ; symbol to a
        call    test_is_alphanumeric
        ret
ftaft_t06:
        cp      #T_ZERO
        jr      nz,ftaft_t07
        ld      a,c                     ; symbol to a
        cp      #0
        ret
ftaft_t07:
        cp      #T_ELSE                 ; else test?
        jr      nz,fpaft_set_z          ; set zero flag and ret
        ;; it is else test, it always succeeds
        xor     a                       ; set z flag
        ret
        
        ;; ----- functions ----------------------------------------------------
        
        ;; execute function (fn code is in register l)
fpa_execfn:
        ld      h,a                     ; store a
        ld      a,l
        cp      #F_NONE
        jr      z,fpafn_nofun           ; there is no function!
        cp      #F_APPEND_AREA
        jr      z,fpafn_append_area
        cp      #F_STACK_SYM
        jr      z,fpafn_stack_sym
        cp      #F_SET_DRV
        jr      z,fpafn_set_drv
        cp      #F_APPEND_FNAME
        jr      z,fpafn_append_fname
        cp      #F_APPEND_EXT
        jp      z,fpafn_append_ext
        ;; if we are here, the function is invalid
        ld      3(iy),#R_INVALID_FN     ; invalid function error
        xor     a
        cp      #1                      ; reset z flag
        ret

        ;; none
fpafn_nofun:
        xor     a                       ; success!
        ret

        ;; append the area
fpafn_append_area:
        ld      a,4(iy)                 ; get current area
        cp      #DEFAULT_AREA           ; default?
        jr      z,fnaa_default
        ;; first digit can only 1
        cp      #1                      ; test 1?
        jr      nz,fnaa_inv_area        ; invalid area
        ;; test second digit
        ld      a,c                     ; get second area
        sub     #'0'                    ; to num
        add     #10                     ; add 10 
        ld      4(iy),a                 ; write back to area
        ld      de,#0x0f00              ; allowed value is 0-15
        call    test_inside_interval
        jr      nz,fnaa_inv_area        ; invalid area
        jr      fnaa_done               ; and all done
fnaa_default:
        ld      a,c                     ; get area number
        sub     #'0'                    ; to int
        ld      4(iy),a                 ; and store
fnaa_done:
        xor     a                       ; success
        ret
fnaa_inv_area:
        ld      3(iy),#R_INVALID_AREA   ; invalid area
        jp      fpaft_set_z             ; set zero flag...

        ;; stack the symbol
fpafn_stack_sym:
        ld      a,5(iy)                 ; get current symbol
        cp      #NO_SYM                 ; no symbol
        jr      nz,fnss_stack_full      ; no space
        ;; stack it
        ld      a,c                     ; get symbol
        ld      5(iy),a                 ; stack it!
        xor     a
        ret
fnss_stack_full:
        ld      3(iy),#R_SSTACK_OF
        jp      fpaft_set_z             ; raise error

        ;; set drive
fpafn_set_drv:
        ld      a,5(iy)                 ; get stacked symbol
        ld      5(iy),#0                ; empty stack
        exx
        ld      (de),a                  ; first byte of FCB 
        exx
        xor     a
        ret

        ;; append to filename
fpafn_append_fname:
        ld      a,5(iy)                 ; is there a stacked sym?
        cp      #NO_SYM                 ; no?
        jr      z,fnaf_sym2             ; proceed
        ld      5(iy),#NO_SYM           ; clear stack
        call    fnaf_append_char
        ret     nz                      ; error causes abort
fnaf_sym2:
        ld      3(iy),#R_SUCCESS        ; we have 1 char
        ld      a,c                     ; get char
        call    fnaf_append_char        ; append
        ret                             ; Z and err code already set
        ;; append char, test against stacked symbol
        ;; inputs:
        ;;  a=char
fnaf_append_char:
        ld      d,a                     ; store a
        ld      a,6(iy)                 ; get len
        cp      #8                      ; overflow
        jr      z,fnaf_overflow
        exx
        add     #1                      ; skip over drive in FCB
        ld      h,#0
        ld      l,a
        add     hl,de
        push    hl                      ; fcb addreee 
        exx
        ld      a,d                     ; restore a
        pop     de                      ; get FCB+len to DE
        ld      (de),a                  ; write a to buffer
        inc     6(iy)                   ; inc len
        ;; set z flag...
        xor     a
        ret
fnaf_overflow:
        ld      3(iy),#R_FNAME_OF       ; filename too long
        jp      fpaft_set_z             ; set zero flag...

        ;; append to extension
fpafn_append_ext:
        ld      a,c                     ; get char
        call    fnae_append_char        ; append
        ret    
fnae_append_char:
        ld      d,a                     ; store a
        ld      a,7(iy)                 ; get len
        cp      #3                       ; overflow
        jr      z,fnae_overflow
        exx
        add     #9                      ; skip over drive and fname (1+8)
        ld      h,#0
        ld      l,a
        add     hl,de
        push    hl                      ; fcb addreee 
        exx
        ld      a,d                     ; restore a
        pop     de                      ; get FCB+len to DE
        ld      (de),a                  ; write a to buffer
        inc     7(iy)                   ; inc len
        ;; set z flag...
        xor     a
        ret
fnae_overflow:
        ld      3(iy),#R_EXT_OF         ; filename too long
        jp      fpaft_set_z             ; set zero flag...


        ;; ----- automata definition ------------------------------------------
        ;; each transition is 2 bytes
        ;; byte 0:
        ;;  TTTTSSSS    T=test, S=start
        ;; byte 1:
        ;;  FFFFEEEE    F=function, E=end
        ;; example:
        ;;  00010000, 00000001 (start=0, test=1, function=0, end=1)
fpa_automata:
        .db     S_START + T_DIGIT,      S_AREA + F_APPEND_AREA
        .db     S_START + T_ALPHA,      S_DRIVE + F_STACK_SYM
        .db     S_START + T_ASCII7,     S_FNAME + F_APPEND_FNAME
        .db     S_AREA + T_DIGIT,       S_AREA + F_APPEND_AREA
        .db     S_AREA + T_COLON,       S_FNAME0 + F_NONE
        .db     S_AREA + T_ASCII7,      S_DRIVE + F_STACK_SYM
        .db     S_DRIVE + T_COLON,      S_FNAME0 + F_SET_DRV
        .db     S_DRIVE + T_ASCII7,     S_FNAME + F_APPEND_FNAME
        .db     S_FNAME0 + T_ASCII7,    S_FNAME + F_APPEND_FNAME
        .db     S_FNAME + T_ASCII7,     S_FNAME + F_APPEND_FNAME
        .db     S_FNAME + T_ZERO,       S_END + F_NONE
        .db     S_FNAME + T_DOT,        S_EXT0 + F_NONE
        .db     S_EXT0 + T_ASCII7,      S_EXT + F_APPEND_EXT
        .db     S_EXT + T_ASCII7,       S_EXT + F_APPEND_EXT
        .db     S_EXT + T_ZERO,         S_END + F_NONE
efpa_automata: