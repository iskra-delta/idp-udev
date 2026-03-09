        ;; a minimal crt0.s startup code for Iskra Delta Partner program
        ;;
        ;; NOTES:
        ;;  initializes data, argv, memory management, and the PRNG before _main
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module crt0

           .globl  _main
        .globl  _exit
        .globl  __heap

        .area     _CODE
        ;; -----------------
        ;; void start(void)
        ;; -----------------
        ;; initializes the runtime and transfers control to _main
        ;; NOTES:
        ;;  installs the stack, copies initialized data, parses argv, and
        ;;  initializes the allocator and PRNG before calling _main
        ;; inputs: none
        ;; outputs: does not return directly; execution falls through to _exit
        ;; affects: af, bc, de, hl, sp, flags
start:
        ;; define a stack   
        ld      sp,#stack

        ;; SDCC init globals
        call    gsinit

        call    pargs
        ld      hl, (argc)
        ld      de, #argv

        ;; initialize memory management
        call    __memory_init

        ;; initialize random generator
        call    __rand_init

        ;; call the main
        call    _main
        ;; -----------------
        ;; void exit(void)
        ;; -----------------
        ;; terminates the process by issuing the CP/M warm reset BDOS call
        ;; NOTES:
        ;;  shared label used both after _main returns and for external _exit calls
        ;; inputs: none
        ;; outputs: does not return
        ;; affects: bc
_exit:
        ;; Warm boot back to the CCP.
        jp      0

        ;; Ordering of segments for the linker (after header)
        .area     _CODE
        .area   _GSINIT
        .area   _GSFINAL    
        .area   _HOME
        .area   _INITIALIZER
        .area   _INITFINAL
        .area   _INITIALIZED
        .area   _DATA
        .area   _BSS
        .area    _STACK
        .area   _HEAP


        ;; init code for functions/var.
        .area   _GSINIT
        ;; ------------------
        ;; void gsinit(void)
        ;; ------------------
        ;; copies linker-provided initializers into the initialized data segment
        ;; NOTES:
        ;;  returns immediately when the initializer segment is empty
        ;; inputs: linker symbols for initializer regions
        ;; outputs: initialized globals copied into RAM
        ;; affects: af, bc, de, hl, flags
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


        .area    _STACK
        .ds        1024
stack:


        .area   _HEAP
__heap::                                ; start of our heap.
