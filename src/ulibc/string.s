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
        
        .area    _CODE
        ;; void *memcpy(void *dest, const void * src, size_t n)
_memcpy::
        push    hl                      ; save dest for return value
        ld      ix,#4
        add     ix,sp
        ld      c,(ix)                  ; bc=n from stack
        ld      b,1(ix)
        ;; For ldir: HL=src, DE=dest, BC=count
        ex      de,hl                   ; swap: HL=src, DE=dest
        ldir                            ; do the copy
        pop     hl                      ; ret value = destination
        ret

        ;; void *memset(void *str, int c, size_t n)
_memset::
        push    hl                      ; save str for return value
        ld      ix,#4
        add     ix,sp
        ld      c,(ix)                  ; bc=n from stack
        ld      b,1(ix)
        ;; zero len?
        ld      a,b
        or      c
        jr      z,ms_done               ; if zero, just return
        ;; E contains the fill character
        ld      (hl),e                  ; set first char
        push    hl
        pop     de
        inc     de                      ; de=hl+1
        dec     bc                      ; one less to copy (already set first)
        ld      a,b
        or      c
        jr      z,ms_done               ; if only 1 byte, done
        ldir                            ; set remaining bytes
ms_done:
        pop     hl                      ; return value = str
        ret
