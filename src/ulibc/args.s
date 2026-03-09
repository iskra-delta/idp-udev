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
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module args


        .globl  pargs
        .globl  argc
        .globl  argv


        .area   _CODE
        ;; ----------------
        ;; void pargs(void)
        ;; ----------------
        ;; parses the CP/M command tail at 0x80 into argc/argv storage
        ;; NOTES:
        ;;  argv[0] remains NULL because CP/M does not provide the program name
        ;;  spaces in the command tail are replaced with 0x00 terminators
        ;; inputs: none
        ;; outputs: argc and argv globals updated in place
        ;; affects: af, bc, de, hl, alternate bc/de/hl, flags
        ;; parse command line in CP/M
pargs::
        ld      hl,#0x81                ; first command-tail character
        ld      a,(#0x80)               ; command-tail length
        ld      b,a                     ; remaining character count
        ;; argv[0] is NULL
        ld      de,#argv                ; argv pointers
        xor     a
        ld      (de),a
        inc     de
        ld      (de),a
        inc     de                      ; de points to first real argv slot
        ;; argc=1 (default)
        ld      a,#1
        ld      (argc),a
        xor     a
        ld      (argc+1),a

pargs_skip_spaces:
        ld      a,b
        or      a
        jr      z,pargs_done
        ld      a,(hl)
        cp      #' '
        jr      nz,pargs_store_arg
        inc     hl
        djnz    pargs_skip_spaces
        jr      pargs_done

pargs_store_arg:
        ld      a,l
        ld      (de),a
        inc     de
        ld      a,h
        ld      (de),a
        inc     de
        ld      a,(argc)
        inc     a
        ld      (argc),a

pargs_scan_arg:
        ld      a,b
        or      a
        jr      z,pargs_terminate
        ld      a,(hl)
        cp      #' '
        jr      z,pargs_end_arg
        inc     hl
        djnz    pargs_scan_arg
        jr      pargs_terminate

pargs_end_arg:
        xor     a
        ld      (hl),a
        inc     hl
        djnz    pargs_skip_spaces
        jr      pargs_done

pargs_terminate:
        xor     a
        ld      (hl),a
pargs_done:
        ret

        .area   _DATA
argc::
        .dw 1                           ; default argc is 1 (filename!)
argv::
        .ds 16                          ; max 8 argv arguments
