/*
 * mem.h
 *
 * Linked list header file.
 * 
 * MIT License (see: LICENSE)
 * copyright (c) 2021 tomaz stih
 *
 * 05.06.2012   tstih
 *
 */
#ifndef __MEM_H__
#define __MEM_H__

#include <ulibc/list.h>

#ifndef NONE
#define NONE 0
#endif

#define MEM_TOP         0xc000
#define BLK_SIZE        (sizeof(struct block_s) - sizeof(unsigned char[1]))
#define MIN_CHUNK_SIZE  4

/* block status, use as bit operations */
#define NEW             0x00
#define ALLOCATED       0x01

typedef struct block_s {
    list_header_t   hdr;
    unsigned char   stat;
    unsigned int    size;
    unsigned char   data[1];
} block_t;

/* Must be defined in crt0 */
extern void _heap;


/* functions */
extern void* calloc (unsigned int num, unsigned int size);
extern void free(void *p);
extern void *malloc(unsigned int size);

#endif /* __LIST_H__ */
