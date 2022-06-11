		;; ginit.s
        ;; 
        ;; initialize gpx
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 06.06.2022    tstih
		.module ginit

        .globl  _ginit
        .globl  gdata

        .include "gdp.inc"

        .area	_CODE
        ;; -------------------------------
		;; g_t* _ginit(uint8_t resolution)
        ;; -------------------------------        
        ;; initializes the ef9367, sets the resolution to desired
        ;; mode. disclaimer: this command does not waiting for gdp 
        ;; bcs no command should be executing at time of init!
        ;; affect:  a, hl, de, flags
_ginit::
        ;; exit text by hiding cursor and clearing the screen
        call    avdc_hide_cursor
        call    avdc_cls

        ;; get resolution to the L register and restore stack
        pop     de                      ; ret value
        pop     hl                      ; L=resolution
        push    hl
        push    de
        
        ;; pen down, set default drawing mode to pen
        ld      a,#(EF9367_CR1_PEN_DOWN|EF9367_CR1_SET_PEN) 
        out     (EF9367_CR1),a          ; control reg 1 to default
        xor     a                       ; a=0
        out     (EF9367_CR2),a          ; control reg 2 to default
        out     (EF9367_CH_SIZE),a      ; no scaling!
        ;; now set the resolution.
        ld      a,l                     ; resolution const.
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
        ret

        ;; global space for graphics data.
gdata:
        .dw     0                       ; screen height
        .db     0                       ; pen status 0=up, 1=down