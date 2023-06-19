/*
 * gmeglyph.c
 *
 * measure glyph
 *
 * MIT License (see: LICENSE)
 * copyright (c) 2023 tomaz stih
 *
 * 16.06.2023   tstih
 *
 */
#include <ugpx.h>

/* get text size */
void gmegpy(void *glyph, dim_t *dim) {   
    uint8_t *g8=(uint8_t *)glyph;
    g8++; dim->w=(*g8)+1; g8++; dim->h=(*g8)+1; 
}