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

/* standard types */
typedef int coord;
typedef uint8_t color;

typedef struct rect_s {                 /* the rectangle */
	coord x0;
	coord y0;
	coord x1;
	coord y1;
} rect_t;

/* basic graphics structure */
typedef struct g_s {
    uint16_t height;                    /* 256 or 512 */
    color ccolor;                       /* current color */
} g_t;

/* enter graphics mode */
#define RES_1024x256    0x00
#define RES_1024x512    0x18
extern g_t* ginit(uint8_t resolution);

/* leave graphics mode */
extern void gexit(g_t* g);

/* clear current (display page) graphics screen */
extern void gcls(g_t *g);

/* manually move graphics cursor to x,y */
extern void gxy(g_t *g, coord x, coord y);

/* draw pixel */
extern void gputpixel(g_t *g, coord x, coord y);

/* draw unclipped LINE or TINY glyph. */
extern void gputglyph(g_t *g, void* glyph, coord x, coord y);

/* return LINE or TINY glyph dimensions */
extern void gmeasureglyph(void *glyph, coord *x, coord *y);

/* print string */
extern uint16_t gputtext(g_t *g, void *font, char *text, coord x, coord y);

/* set color, sets drawing color 
   NOTES: 
    when drawing glyph this color
    is used to draw lines and its
    inverse is used to draw empty space */
#define CO_NONE         0x00
#define CO_FORE         0x01
#define CO_BACK         0x02
extern void gsetcolor(g_t *g, color c);

/* draw line (optimized!) */
extern void gdrawline(g_t *g, coord x0, coord y0, coord x1, coord y1);
extern void gdrawdelta(g_t *g, uint8_t dx, uint8_t dy);

/* rectangles */
extern void gdrawrect(g_t *g, rect_t *r);
extern void gfillrect(g_t *g, rect_t *r);

#endif /* __UGPX_H__ */