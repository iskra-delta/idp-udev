		;; gexit.s
        ;; 
        ;; exit gpx.
		;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
		;; 06.06.2022    tstih
		.module gexit

        .globl  _gexit

        .area	_CODE
        ;; ------------------
		;; void gexit(g_t* g)
        ;; ------------------
        ;; exit graphics mode, restores text cursor.
        ;; affect:  a, hl, de, flags
_gexit::
        call    avdc_show_cursor
        ret