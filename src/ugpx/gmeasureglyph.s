		;; gmeasureglyph.s
        ;; 
        ;; measure a glyph
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 11.06.2022    tstih
		.module gmeasureglyph

        .globl  _gmeasureglyph

        .area	_CODE
        ;; ----------------------------------------------------
		;; void gmeasureglyph(void* glyph, uint8_t* w, coord h)
        ;; ----------------------------------------------------
        ;; extracts glyph size
        ;; supports only LINE and TINY glyphs
_gmeasureglyph:
        pop     bc                      ; save return address
        pop     hl                      ; glyph
        inc     hl                      ; skip over signature byte
        ld      a,(hl)                  ; width
        pop     de                      ; get pointer to w
        ld      (de),a                  ; store width
        inc     hl                      ; point to height
        ld      a,(hl)                  ; height
        pop     de                      ; get pointer to h
        ld      (de),a
        ;; restore stack
        push    bc
        push    bc
        push    bc
        push    bc
        ret