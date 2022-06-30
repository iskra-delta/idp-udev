/*
 * gfillrect.c
 *
 * Fills a rectangle!
 *
 * MIT License (see: LICENSE)
 * copyright (c) 2022 tomaz stih
 *
 * 16.06.2022   tstih
 *
 */
#include <ugpx.h>

void gfillrect(rect_t *r) {
    if (r->y1 > r->y0)
        for (int y=r->y0; y<=r->y1; y++)
            gdrawline(r->x0, y, r->x1, y);
    else
        for (int y=r->y1; y<r->y0; y++)
            gdrawline(r->x0, y, r->x1, y);
}