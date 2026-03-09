        ;; initialize gpx
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module ginit

        .globl  _ginit
        .globl  gdata

        .include "gdp.inc"

        .area    _CODE
        ;; ------------------------------
        ;; void ginit(uint8_t resolution)
        ;; ------------------------------        
        ;; initializes the graphics subsystem
        ;; NOTES:
        ;;  hides the text cursor, clears the AVDC text
        ;;  screen, initializes EF9367 state, and caches
        ;;  screen height plus default foreground color
        ;; inputs: a=resolution
        ;; outputs: hl=&gdata
        ;; affects: af, de, hl
_ginit::
        push    af                      ; preserve resolution
        ;; pen down, set default drawing mode to pen
        ld      a,#(EF9367_CR1_PEN_DOWN|EF9367_CR1_SET_PEN)
        out     (EF9367_CR1),a          ; control reg 1 to default
        xor     a                       ; a=0
        out     (EF9367_CR2),a          ; control reg 2 to default
        ld      a,#0b00100001
        out     (EF9367_CH_SIZE),a      ; no scaling!
        ;; now set the resolution.
        pop     af                      ; restore resolution
        out     (PIO_GR_CMN),a
        ;; set return value
        ld      hl,#gdata
        ;; store resolution
        ld      de,#256
        or      a                       ; check a
        jr      z,gi_lowres
        ld      de,#512
gi_lowres:
        ld      (gdata),de
        ;; and cache pen
        ld      a,#1                    ; cached color is C_FORE
        ld      (gdata+3),a             ; write to cache
        ret

        ;; global space for graphics data.
gdata:
        .dw     0                       ; screen height
        .db     0                       ; current color
