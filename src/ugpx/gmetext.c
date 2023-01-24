/*
 * gmetext.c
 *
 * measure text.
 * todo:
 *  RLE fonts dont work!
 *
 * MIT License (see: LICENSE)
 * copyright (c) 2023 tomaz stih
 *
 * 22.01.2023   tstih
 *
 */
#include <ugpx.h>

#define FONT_HEIGHT_NDX     2
#define FONT_1STASCII_NDX   3
#define FONT_OFFSET_TBL     5
#define GPY_WIDTH_OFFSET    1

/* get text size */
void gmetext(void *font, char *text, dim_t *dim) {   
    uint8_t *f8=(uint8_t *)font, *g8;
    uint8_t hsh=*(f8)&0x0f;
    uint8_t first_ascii=f8[FONT_1STASCII_NDX];
    dim->h=f8[FONT_HEIGHT_NDX] + 1; /* store height */
    dim->w=0;

    uint16_t *offstbl=(uint16_t *)(f8+FONT_OFFSET_TBL);
    while(*text) {
        g8 = f8 + (offstbl[(*text)-first_ascii]);
        dim->w = dim->w + (g8[GPY_WIDTH_OFFSET] + 1) + hsh;
        text++;
    }
}