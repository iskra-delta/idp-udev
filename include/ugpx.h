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

typedef struct dim_s {                  /* the dimensions */
    coord w;
    coord h;
} dim_t;

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
extern void ginit(uint8_t resolution);

/* leave graphics mode */
extern void gexit(void);

/* clear current (display page) graphics screen */
extern void gcls(void);

/* manually move graphics cursor to x,y */
extern void gxy(coord x, coord y);

/* draw pixel */
extern void gputpixel(coord x, coord y);

/* draw unclipped LINE or TINY glyph. */
extern void gputglyph(void* glyph, coord x, coord y);

/* print string */
extern void gputtext(void *font, char *text, coord x, coord y);

/* get text size */
extern void gmetext(void *font, char *text, dim_t *dim);

/* get glyph size */
extern void gmegpy(void *glyph, dim_t *dim);

/* set color, sets drawing color 
   NOTES: 
    when drawing glyph this color
    is used to draw lines and its
    inverse is used to draw empty space */
#define CO_NONE         0x00
#define CO_FORE         0x01
#define CO_BACK         0x02
extern void gsetcolor(color c);

/* draw line (optimized!) */
extern void gdrawline(coord x0, coord y0, coord x1, coord y1);
extern void gdrawd(coord dx, coord dy);

/* rectangles */
extern rect_t *gnormrect(rect_t *r);
extern void gdrawrect(rect_t *r);
extern void gfillrect(rect_t *r);

/* pages */
#define PG_DISPLAY  1
#define PG_WRITE    2
extern void gsetpage(uint8_t op, uint8_t page);

#endif /* __UGPX_H__ */
