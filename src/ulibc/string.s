		;; string.s
        ;; 
        ;; minimal set of standard string functions
        ;; 
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 02.04.2022    tstih
        .module string


        .globl  _memcpy
        .globl  _memset
        
        .area	_CODE
        ;; void *memcpy(void *dest, const void * src, size_t n)
_memcpy::
        ;; store pc
        exx
        pop     hl                      ; store pc
        exx
        ;; get args
        pop     de                      ; de=dest
        pop     hl                      ; hl=src
        pop     bc                      ; bc=n
        ;; restore stack
        push    bc
        push    hl
        push    de
        push    de                      ; store destination
        ldir                            ; do the copy
        pop     hl                      ; ret value = destination
        ;; restore PC
        exx     
        push    hl
        exx
        ret

        ;; void *memset(void *str, int c, size_t n)
_memset::
        ;; store pc
        exx
        pop     hl
        exx
        ;; get args
        pop     hl                      ; hl=dest
        pop     de                      ; de=char
        pop     bc                      ; bc=count
        ;; restore stack
        push    bc
        push    de
        push    hl
        exx
        push    hl
        exx
        push    hl                      ; store end result
        ;; zero len?
        ld      a,b
        or      c
        ret     z
        ;; if we're here it is not zero
        ld      (hl),e                  ; set first char
        push    hl
        pop     de
        inc     de                      ; de=hl+1
        ldir                            ; set
        pop     hl
        ret