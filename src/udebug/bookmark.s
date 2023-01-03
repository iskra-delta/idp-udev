        ;; bookmark.s
        ;; 
        ;; embedded "bookmark"
        ;;
        ;; MIT License (see: LICENSE)
        ;; copyright (c) 2022 tomaz stih
        ;;
        ;; 05.05.2022    tstih
        .module bookmark

        .globl  _bookmark

        .area   _CODE
        ;; ----- void bookmark(void *addr) ------------------------------------
        ;; stores the current context of the processor to the addr.
        ;; --------------------------------------------------------------------
_bookmark::
        ret