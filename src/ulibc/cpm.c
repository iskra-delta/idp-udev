/*
 * cpm.h
 *
 * Core CP/M functions.
 *
 * MIT License (see: LICENSE)
 * copyright (c) 2022 tomaz stih
 *
 * 31.03.2022   tstih
 *
 */
#include <ulibc/bdos.h>

int putchar(int c) {
    /* Extend newline. */
    if ((char)c=='\n') {
        bdos(C_WRITE,'\r');
        bdos(C_WRITE,'\n');
    } else bdos(C_WRITE,c);
    return c;
}

int kbhit(void) {
    return bdos(C_RAWIO,0xff);
}