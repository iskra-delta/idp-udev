/*
 * ugpx.h
 *
 * gdp (graphical card) functions
 * 
 * MIT License (see: LICENSE)
 * copyright (c) 2022 tomaz stih
 *
 * 02.04.2022   tstih
 *
 */
#ifndef __UGPX_H__
#define __UGPX_H__

#include <stdint.h>

#define RES_1024x256    0x00
#define RES_1024x512    0x18

typedef int coord;

/* basic graphics structure */
typedef struct g_s {
    uint16_t height;                    /* 256 or 512 */
} g_t;

extern g_t* ginit(uint8_t resolution);
extern void gexit(g_t* g);
extern void gcls(g_t *g);
extern int gputglyph(g_t *g, void* glyph, coord x, coord y);
extern void gmeasureglyph(void *glyph, coord *x, coord *y);

#endif /* __UGPX_H__ */