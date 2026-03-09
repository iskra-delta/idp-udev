        ;; minimal set of standard string functions
        ;;
        ;; NOTES:
        ;;  memcpy() uses LDIR and does not support overlapping source and destination
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module string


        .globl  _memcpy
        .globl  _memset
        
        .area    _CODE
        ;; ----------------------------------------------
        ;; void *memcpy(void *dest, const void *src, size_t n)
        ;; ----------------------------------------------
        ;; copies n bytes from src to dest and returns dest
        ;; NOTES:
        ;;  uses LDIR, so overlapping ranges are not handled safely
        ;; inputs: hl=dest, de=src, stack[0]=n
        ;; outputs: memory copied, hl=dest
        ;; affects: af, bc, de, hl, flags
_memcpy::
        push    ix
        push    hl                      ; save dest for return value
        ld      ix,#6
        add     ix,sp
        ld      c,(ix)                  ; bc=n from stack
        ld      b,1(ix)
        ;; For ldir: HL=src, DE=dest, BC=count
        ex      de,hl                   ; swap: HL=src, DE=dest
        ldir                            ; do the copy
        pop     hl                      ; ret value = destination
        pop     ix
        ret

        ;; --------------------------------------------
        ;; void *memset(void *str, int c, size_t n)
        ;; --------------------------------------------
        ;; fills n bytes at str with the low byte of c and returns str
        ;; NOTES:
        ;;  writes the first byte explicitly, then propagates it with LDIR
        ;; inputs: hl=str, e=c low byte, stack[0]=n
        ;; outputs: memory filled, hl=str
        ;; affects: af, bc, de, hl, flags
_memset::
        push    ix
        push    hl                      ; save str for return value
        ld      ix,#6
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
        pop     ix
        ret
