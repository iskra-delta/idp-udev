/*
 * bdos.h
 *
 * BDOS calls and definitions.
 *
 * MIT License (see: LICENSE)
 * copyright (c) 2021 tomaz stih
 *
 * 27.04.2021   tstih
 *
 */
#ifndef __BDOS_H__
#define __BDOS_H__


/* The usual exit codes. */
#define BDOS_SUCCESS 0
#define BDOS_FAILURE 0xff


/* CP/M 3 BDOS function codes
 * See here: https://www.seasip.info/Cpm/bdos.html
 */

/* Process commands */
#define P_TERMCPM       0               /* Process terminate */
#define P_CODE          108             /* Set process return code */
/* Console commands */
#define C_READ          1               /* Console read */
#define C_WRITE         2               /* Console write */
#define C_RAWIO         6               /* Console raw input */
#define C_DELIMIT       110             /* Get or set delimiter $ */
#define C_WRITEBLK      111             /* Send block of text to console */
/* Drive commands */
#define DRV_SET         14              /* Set drive */
#define DRV_LOGINVEC    24              /* Enumerate drives */
#define DRV_GET         25              /* Get current drive */
#define DRV_DPB         31              /* Get drive info block */
/* File commands */
#define F_OPEN          15              /* Open file */
#define F_CLOSE         16              /* Close file */
#define F_READ          20              /* Read from file */
#define F_WRITE         21              /* Write to file */
#define F_MAKE          22              /* Create file */
#define F_DMAOFF        26              /* Set DMA offset */
#define F_USERNUM       32              /* Get/set user area */
#define F_READRAND      33              /* Read random record */
#define F_WRITERAND     34              /* Write random record */
#define F_SIZE          35              /* Get file size in blocks */
#define F_RANDREC       36              /* Store current pos. */
#define F_TRUNCATE      99              /* Truncate a file */
#define F_PARSE         152             /* Parse filename into FCB. */


/* BDOS return code */
typedef struct bdos_ret_s {
    unsigned char reta;                 /* return code in reg A */
    unsigned char retb;                 /* return code in reg B */
    unsigned int rethl;                 /* return code in HL */
} bdos_ret_t;


/* Hadrware errors, returned in the H register. */
#define HWERR_SOFTWARE  0               /* Software error (i.e. file not found)*/
#define HWERR_DRV_SEL   1               /* Cant access drive */
#define HWERR_DISK_RO   2               /* Disk is read only */
#define HWERR_FILE_RO   3               /* File is read only */
#define HWERR_INV_DRV   4               /* Invalid drive */
#define HWERR_FOPEN     5               /* File is already open */
#define HWERR_CHECKSUM  6               /* FCB checksum error */
#define HWERR_PASSWORD  7               /* Password error */
#define HWERR_FEXISTS   8               /* File already exists */
#define HWERR_INV_FNME  9               /* Name contains ? */


#define DMA_SIZE        128
typedef struct fcb_s {
	unsigned char drive;                /* 0 -> Searches in default disk drive */
	char filename[8];                   /* file name ('?' means any char) */
	char filetype[3];                   /* file type */
	unsigned char ex;                   /* extent */
   	unsigned int resv;                  /* reserved for CP/M */
	unsigned char rc;                   /* records used in extent */
	unsigned char alb[16];              /* allocation blocks used */
	unsigned char seqreq;               /* sequential records to read/write */
	unsigned int rrec;                  /* rand record to read/write */ 
	unsigned char rrecob;               /* rand record overflow byte (MS) */
} fcb_t; /* file control block */


/* Call bdos, return register A. */
extern unsigned char bdos(unsigned char fn, unsigned int param);

/* Call bdos, return results. */
extern bdos_ret_t *bdosret(unsigned char fn, unsigned int param, bdos_ret_t *p);

#endif /* __BDOS_H__ */