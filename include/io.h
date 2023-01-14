/*
 * io.h
 *
 * file I/O functions
 * 
 * MIT License (see: LICENSE)
 * copyright (c) 2022 tomaz stih
 *
 * 02.04.2022   tstih
 *
 */
#ifndef __IO_H__
#define __IO_H__

#include <stdint.h>

#define DMA_SIZE                128
typedef struct fcb_s {
	uint8_t drive;          /* 0 -> Searches in default disk drive */
	char filename[8];       /* file name ('?' means any char) */
	char filetype[3];       /* file type */
	uint8_t ex;             /* extent */
   	uint16_t resv;          /* reserved for CP/M */
	uint8_t rc;             /* records used in extent */
	uint8_t alb[16];        /* allocation blocks used */
	uint8_t seqreq;         /* sequential records to read/write */
	uint16_t rrec;          /* rand record to read/write */ 
	uint8_t rrecob;         /* rand record overflow byte (MS) */
} fcb_t; /* file control block */

/* load file into memory, skip first skip bytes (if flen==0 read everything, else return len) */
extern void *fload(char *path, void* out, unsigned int *flen, unsigned int skip);

/* save entire file to disk */
extern int fsave(char *path, void* buf, unsigned int flen);

/* parse path such as 1A:TEST.DAT and returns path_t
   structure */
#define FP_DEFAULT              0xff
#define FP_STS_SUCCESS          0x00
#define FP_STS_UNEXPECTED_SYM   0x01
#define FP_STS_INVALID_FUNC     0x02
#define FP_STS_INVALID_AREA     0x03
#define FP_STS_SYM_STACK_FULL   0x04
#define FP_STS_FNAME_OVERFLOW   0x05
#define FP_STS_EXT_OVERFLOW     0x06
extern int fparse(char *path, fcb_t *fcb, uint8_t *area);

#endif /* __IO_H__ */
