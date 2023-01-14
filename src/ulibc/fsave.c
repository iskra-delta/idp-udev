/*
 * fsave.c
 *
 * Save entire file.
 *
 * MIT License (see: LICENSE)
 * copyright (c) 2023 tomaz stih
 *
 * 14.01.2023   tstih
 *
 */
#include <ulibc/bdos.h>
#include <ulibc/mem.h>

#ifndef NULL
#define NULL (void *)0
#endif

/* external filename parser */
extern int fparse(char *path, fcb_t *fcb, unsigned char *area);

/* external mem copy */
extern void *memcpy(void *dest, const void * src, unsigned int n);

/* save entire file
   0 - fail, 1 - success
*/
int fsave(char *path, void* buf, unsigned int flen) {

    /* assume fail */
    int retval = 0;

    /* allocate fcb */
    fcb_t *fcb=calloc(1,sizeof(fcb_t));

    /* parse filename */
    unsigned char area;
    if (fparse(path, fcb, &area)) {
        free(fcb); 
        return 0;
    }

    /* preserve user area, and change it */
    unsigned char prev_area = bdos(F_USERNUM, 0xff);
    if (area!=prev_area) { /* only if different */
        bdos(F_USERNUM, area);
    }

    /* allocate dma */
    void *dma=malloc(DMA_SIZE);

    /* result of bdos operation */
    bdos_ret_t result;
    unsigned char file_opened=0, blk_allocated=0;

    /* open file */
    bdosret(F_OPEN,(unsigned int)fcb,&result);
    if (result.reta==BDOS_FAILURE) {
        /* if the file does not exist, try creating one*/
        bdosret(F_MAKE, (unsigned int)fcb, &result);
        if (result.reta == BDOS_FAILURE) goto fsave_done;
    }
    file_opened=1; /* file is open or created... */

    /* set DMA to our block, this is a bit
        problematic because i can't restore prev. dma address */
    bdos(F_DMAOFF,(unsigned int)dma);

    /* and write */
    unsigned int w_len = 0;
    unsigned char *p_buf = buf;
    while (w_len < flen) {
        /* calculate bytes to read and copy to dma */
        unsigned int sz = (flen - w_len) > DMA_SIZE ? DMA_SIZE : (flen - w_len);
        memcpy(dma, p_buf, sz);
        /* write */
        bdosret(F_WRITE, (unsigned int)fcb, &result);
        if (result.reta != 0) goto fsave_done;
        p_buf += sz;
        w_len += sz;
    }

    /* yaay, we did it! */
    retval=1;

fsave_done:

    /* close the file if opened */
    if (file_opened) 
        bdosret(F_CLOSE,(unsigned int)fcb,&result);

    /* set area back to previous area */
    if (area!=prev_area) bdos(F_USERNUM,prev_area);

    /* free the fcb. */
    free(fcb);

    /* free the DMA. */
    free(dma);

    /* and return success */
    return  retval;
}