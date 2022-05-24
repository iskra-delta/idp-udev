/*
 * mem.c
 *
 * Memory management utility functions.
 * 
 * MIT License (see: LICENSE)
 * copyright (c) 2021 tomaz stih
 *
 * 25.05.2012   tstih
 *
 */
#include <ulibc/mem.h>

/* Find first unallocated block */
static unsigned char _match_free_block(list_header_t *p, unsigned int size)
{
    block_t *b = (block_t *)p;
    return !(b->stat & ALLOCATED) && b->size >= size;
}

/* Merge two blocks. */
static void _merge_with_next(block_t *b)
{
    block_t *bnext = b->hdr.next;
    b->size += (BLK_SIZE + bnext->size);
    b->hdr.next = bnext->hdr.next;
}

/* Split block (allocate part of it). */
static void _split(block_t *b, unsigned int size)
{
    block_t *nw;
    nw = (block_t *)((unsigned int)(b->data) + size);
    nw->hdr.next = b->hdr.next;
    nw->size = b->size - (size + BLK_SIZE);
    nw->stat = b->stat;
    /* do not set owner and stat because
	   they'll be populated later */
    b->size = size;
    b->hdr.next = nw;
}

/* Allocate memory. */
void *malloc(unsigned int size)
{
    block_t *prev;
    block_t *b;

    b = (block_t *)_list_find(
        (list_header_t *)&_heap,
        (list_header_t **)&prev,
        _match_free_block, size);

    if (b)
    {
        if (b->size - size > BLK_SIZE + MIN_CHUNK_SIZE)
            _split(b, size);
        b->stat = ALLOCATED;
        return b->data;
    }
    else
        return NULL;
}

/* Clear/allocate memory. */
extern void *memset(void *s, int c, unsigned int n);
void* calloc (unsigned int num, unsigned int size) {
    void *p=malloc(num*size);
    if (p==NULL) return NULL;
    return memset(p,0,num*size);
}

/* Free memory. */
void free(void *p)
{
    block_t *prev;
    block_t *b;

    /* calculate block address from pointer */
    b = (block_t *)((unsigned int)p - BLK_SIZE);

    /* make sure it is a valid memory block by finding it */
    if (_list_find((list_header_t *)&_heap, (list_header_t **)&prev, _list_match_eq, (unsigned int)b))
    {
        b->stat = NEW;
        /* merge 3 blocks if possible */
        if (prev && !(prev->stat & ALLOCATED))
        { /* try previous */
            _merge_with_next(prev);
            b = prev;
        }
        /* try next */
        if (b->hdr.next && !(((block_t *)(b->hdr.next))->stat & ALLOCATED))
            _merge_with_next(b);
    }
}