		;; crt0.s
        ;; 
        ;; a minimal crt0.s startup code for Iskra Delta Partner program
        ;; 
        ;; TODO: 
        ;;  - handle cmd line
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 22.03.2022    tstih
		.module crt0

       	.globl  _main
        .globl  _exit
        .globl  __heap

		.area 	_CODE
start:
        ;; define a stack   
        ld      sp,#stack

        ;; SDCC init globals
        call    gsinit

        ;; load argc and argv to stack for the main function
        call    pargs
        ld      hl, #argv
        push    hl
        ld      hl, (argc)
        push    hl

        ;; initialize memory management
        call    __memory_init

        ;; initialize random generator
        call    __rand_init

        ;; call the main
	    call    _main
_exit:
        ;; Brute force BDOS exit (reset) return control to CP/M.
        ld      c,#0
	    jp      5

		;; Ordering of segments for the linker (after header)
		.area 	_CODE
        .area   _GSINIT
        .area   _GSFINAL	
        .area   _HOME
        .area   _INITIALIZER
        .area   _INITFINAL
        .area   _INITIALIZED
        .area   _DATA
        .area   _BSS
        .area	_STACK
        .area   _HEAP


        ;; init code for functions/var.
        .area   _GSINIT
gsinit::      
        ;; copy statics.
        ld      bc, #l__INITIALIZER
        ld      a, b
        or      a, c
        jr      Z, gsinit_done
        ld      de, #s__INITIALIZED
        ld      hl, #s__INITIALIZER
        ldir
gsinit_done:
        .area   _GSFINAL
        ret


        .area	_STACK
	    .ds	    1024
stack:


        .area   _HEAP
__heap::                                ; start of our heap.