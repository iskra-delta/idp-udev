/*
 * fload.c
 *
 * Load entire file into memory.
 *
 * MIT License (see: LICENSE)
 * copyright (c) 2022 tomaz stih
 *
 * 04.04.2022   tstih
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

/* load entire file into memory 
    if out == NULL then allocates the block, 
    else uses existing block
    we assume successfull memory allocation!
*/
void *fload(char *path, void* out, unsigned int *flen) {

    /* return value */
    void *retval=NULL;
    *flen=0; /* default */

    /* allocate fcb */
    fcb_t *fcb=calloc(1,sizeof(fcb_t));

    /* parse filename */
    unsigned char area;
    if (fparse(path, fcb, &area)) {
        free(fcb); 
        return retval;
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
    if (result.reta==BDOS_FAILURE) goto fload_done;
    file_opened=1; /* file is open... */
  
    /* Gef file length */
    bdosret(F_SIZE,(unsigned int)fcb,&result);
    if (result.reta==BDOS_FAILURE) goto fload_done;
    *flen=fcb->rrec * DMA_SIZE;

    /* if out is NULL then allocate out find out file size */
    if (out==NULL) {
        /* if we are here, we have approx file len.
            CPM 3 Plus enables exact file len, but we are
            happy with aligned flen (to 128 bytes) */
        out=malloc(*flen);
        blk_allocated=1;
    }

    /* set DMA to our block, this is a bit
        problematic because i can't restore prev. dma address */
    bdos(F_DMAOFF,(unsigned int)dma);

    unsigned int bcount = 0; /* block count */
    unsigned char *pout=(unsigned char *)out;
    while (bcount<fcb->rrec) {
        /* read a block */
        bdosret(F_READ,(unsigned int)fcb,&result);
        if (result.reta!=0) goto fload_done;
        memcpy(pout, dma, DMA_SIZE);
        /* next block */
        pout+=DMA_SIZE;
        bcount++;
    }

    /* yaay, we did it! */
    retval=out;

fload_done:

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