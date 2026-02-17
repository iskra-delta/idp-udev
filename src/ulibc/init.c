/*
 * init.c
 *
 * libc init.
 *
 * MIT License (see: LICENSE)
 * copyright (c) 2022 tomaz stih
 *
 * 02.04.2022   tstih
 *
 */
#include <ulibc/mem.h>

/* memory initialization */
void _memory_init(void)
{
    /* First block is the heap. s*/
    block_t *first = (block_t *)&_heap;
    first->hdr.next = NULL;
    first->size = ( MEM_TOP - (unsigned int)&_heap ) - BLK_SIZE;
    first->stat = NEW;
}
