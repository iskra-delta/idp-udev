/*
 * gdrawrect.c
 *
 * Draw a rectangle!
 *
 * MIT License (see: LICENSE)
 * copyright (c) 2022 tomaz stih
 *
 * 16.06.2022   tstih
 *
 */
#include <ugpx.h>

void gdrawrect(rect_t *r) {
    gdrawline(r->x0, r->y0, r->x1, r->y0);
    gdrawline(r->x0, r->y0, r->x0, r->y1);
    gdrawline(r->x1, r->y0, r->x1, r->y1);
    gdrawline(r->x0, r->y1, r->x1, r->y1); 
}