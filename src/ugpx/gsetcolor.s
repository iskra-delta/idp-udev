        ;; set current color
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        .module gsetcolor

        .globl  _gsetcolor
        .globl  gsc_raw

        .include "gdp.inc"

        .area    _CODE
        ;; ------------------------------
        ;; extern void gsetcolor(color c)
        ;; ------------------------------
        ;; sets current drawing color
        ;; NOTES:
        ;;  updates the EF9367 drawing mode and caches
        ;;  the logical color in gdata
        ;; inputs: a=color
        ;; outputs: none
        ;; affects: af, hl
_gsetcolor:
        ld      l,a                     ; public byte arg arrives in a
gsc_raw:
        ;; gsc_raw
        ;; sets current drawing color from l
        ;; NOTES:
        ;;  shared raw entry used by glyph code; skips
        ;;  hardware writes when the cached color matches
        ;; inputs: l=color
        ;; outputs: none
        ;; affects: af, hl
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
        ;; gsc_prev_pen
        ;; restores pen-down state if needed
        ;; NOTES:
        ;;  only issues PEN_DOWN when the previous cached
        ;;  color was CO_NONE, otherwise returns directly
        ;; inputs: none
        ;; outputs: none
        ;; affects: af
gsc_prev_pen:
        ld      a,(gdata+3)             ; cached color
        or      a                       ; was pen up?
        ret     nz                      ; yes!
        ;; prev. pen was up, put it down
        ld      a,#EF9367_CMD_PEN_DOWN  ; pen down
        call    gdp_exec_cmd
        ret
