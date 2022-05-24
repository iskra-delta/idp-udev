		;; args.s
        ;; 
        ;; the pargs routine handles cp/m plus 3 program arguments.
        ;; 
        ;; NOTES:
        ;;  program arguments start at address 0x80. all arguments 
        ;;  are uppercase. the layout is as follows.
        ;;
        ;;  0   1     2                           n-1         n
        ;;  ┌───┬─────┬────────────────────────────┬──────────┐
        ;;  │len│space│program arguments           │terminator│
        ;;  └───┴─────┴────────────────────────────┴──────────┘
        ;;
        ;;  the first byte is length. if > 0 then second byte
        ;;  is a space (0x20), followed by space delimited arguments,
        ;;  and a terminator (0x00). 
        ;;
        ;;  the parser does not allocate extra space for arguments,
        ;;  but instead replaces spaces in program arguments with 0x00
        ;;  to create multiple zero terminated strings and then points
        ;;  the argv[] to addresses following 0x80.
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 22.03.2022    tstih
        .module args


        .globl  pargs
        .globl  argc
        .globl  argv


        .area   _CODE
        ;; parse command line in CP/M
pargs::
        ld      hl,#0x80                ; args start
        ;; argv[0] is NULL
        ld      de,#argv                ; argv pointers
        xor     a
        ld      (de),a
        inc     de
        ld      (de),a
        inc     de                      ; dl points to first "real" argv
        ;; argc=1 (default)
        xor     a
        ld      (argc+1),a
        inc     a
        ld      (argc),a
        ;; let de point to first char which is length
        ld      a,(hl)                  ; get number of bytes to b
        ld      b,a                     ; b is counter
        inc     hl                      ; hl points to first char
        ld      a,(hl)                  ; check it
        cp      #' '                    ; skip initial space...
        jr      nz,pargs_go 
        inc     hl                      ; next char...
pargs_go:
        push    hl                      ; "remember" start of current arg
pargs_loop:
        ;; now iterate
        ld      a,(hl)
        ;; is it end of arguments?
        cp      #0                      
        jr      z,pargs_end
        ;; is it end of current argument?
        cp      #' '                    
        jr      z,pargs_next
        ;; if we're here it's a simple char...
        inc     hl
        djnz    pargs_loop
        ;; if no more looping we're done
pargs_end:
        ;; get a at start of arg
        exx
        pop     hl
        ld      a,(hl)
        push    hl
        exx
        ;; is it 0?
        or      a
        jr      z,pargs_noarg
        ;; else store argument
        pop     hl                      ; get arg
        ex      de,hl
        ld      (hl),e
        inc     hl
        ld      (hl),d
        ex      de,hl
        ;; inc. argc
        ld      a,(argc)
        inc     a
        ld      (argc),a
        ;; and return
        jr      pargs_done   
pargs_next:
        xor     a                       ; zero terminate
        ld      (hl),a                  ; the argument
        inc     hl                      ; next arg
        push    de                      ; current arg to stack
        exx
        pop     de                      ; get current arg from stack
        pop     hl                      ; get start of arg from stack
        ex      de,hl
        ld      (hl),e                  ; write arg to arg list
        inc     hl
        ld      (hl),d
        inc     hl
        ex      de,hl
        push    de                      ; store arg list new end
        exx
        pop     de                      ; get arg list 
        push    hl                      ; next arg to stack
        ld      a,(argc)                ; increase argc
        inc     a
        ld      (argc),a
        djnz    pargs_loop
pargs_noarg:
        pop     hl                      ; clean stack
pargs_done:
        ret

        .area   _DATA
argc::
        .dw 1                           ; default argc is 1 (filename!)
argv::
        .ds 16                          ; max 8 argv arguments
