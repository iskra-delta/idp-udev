		;; gsetcolor.s
        ;; 
        ;; set current color
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 11.06.2022    tstih
		.module gsetcolor

        .globl  _gsetcolor
        .globl  gsc_raw

        .include "gdp.inc"

        .area	_CODE
        ;; --------------------------------------
		;; extern void gsetcolor(g_t *g, color c)
        ;; --------------------------------------
        ;; sets color (pen)
_gsetcolor:
        ld      iy,#4
        add     iy,sp
        ld      l,(iy)                  ; l=color
        ;; input parameters
        ;; l=color
gsc_raw:
        ld      a,(gdata+3)             ; previous color to a
        cp      l                       ; compare to current color
        jr      z,gsc_unroll            ; if same...nothing to do
        ld      a,l                     ; current color to a
        ;; we need to change color
        cp      #0                      ; test a
        jr      z,gsc_none
        cp      #2
        jr      z,gsc_back
        jr      gsc_fore                ; if not none and back
gsc_none:
        ;; just raise pen up
        ld      a,#EF9367_CMD_PEN_UP    ; pen/eraser up
        call    gdp_exec_cmd
        jr      gsc_done
gsc_fore:
        call    gsc_prev_pen
        ld      a,#EF9367_CMD_DMOD_SET
        call    gdp_exec_cmd
        jr      gsc_done
gsc_back:
        call    gsc_prev_pen
        ld      a,#EF9367_CMD_DMOD_CLR
        call    gdp_exec_cmd
gsc_done:
        ;; update cached color
        ld      a,l                     ; get color
        ld      (gdata+3),a             ; and write to cachec buffer
gsc_unroll:
        ret
        ;; toggle pen
gsc_prev_pen:
        ld      a,(gdata+3)             ; cached color
        or      a                       ; was pen up?
        ret     nz                      ; yes!
        ;; prev. pen was up, put it down
        ld      a,#EF9367_CMD_PEN_DOWN  ; pen down
        call    gdp_exec_cmd
        ret