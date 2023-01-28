![status.badge] [![language.badge]][language.url] [![standard.badge]][standard.url] [![license.badge]][license.url]

# μlibc

*Micro SDCC* is an ultralight version of the C standard library for the Iskra Delta Partner. 

# The Scope

The library includes basic startup glue, including command-line argument handling, and minimal subset of library functions. 

 > The CP/M can't populate argv[0] with program name.

## Supported headers and functions

Click to the header to expand.

<details><summary>ctype.h/</summary>

~~~cpp
extern int isdigit(int c);
extern int isalpha(int c);
extern int isalnum(int c);
extern int islower(int c);
extern int isupper(int c);
extern int toupper(int c);
extern int tolower(int c);
~~~

</details>  

<details><summary>io.h/</summary>

~~~cpp
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
extern void *fload(char *path, void* out, unsigned int pos, unsigned int *flen);

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
~~~

</details> 

<details><summary>limits.h/</summary>

~~~cpp
#define CHAR_BIT    8       /* Bits in char. */
#define SCHAR_MIN   -128
#define SCHAR_MAX   +127
#define UCHAR_MAX   255
#define CHAR_MIN    -128
#define CHAR_MAX    +127
#define MB_LEN_MAX  8       /* Max. bytes in multi byte char. */
#define SHRT_MIN    -128
#define SHRT_MAX    +127
#define USHRT_MAX   255
#define INT_MIN     -32768
#define INT_MAX     +32767
#define UINT_MAX    65535
#define SSIZE_MAX   65535   /* Max bytes for file read */
#ifndef RAND_MAX
#define RAND_MAX    32767
#endif /* RAND_MAX */
~~~

</details>  

<details><summary>stdarg.h/</summary>

~~~cpp
/* Standard C var arg macros. */
#define va_list unsigned char *
#define va_start(marker, last) { marker = (va_list)&last + sizeof(last); }
#define va_arg(marker, type) *((type *)((marker += sizeof(type)) - sizeof(type)))
#define va_end(marker) marker = (va_list) 0;
~~~

</details>  

<details><summary>stdbool.h/</summary>

~~~cpp
#define bool int

#define false 0
#define FALSE 0
#define true 1
#define TRUE 1
~~~

</details>  

<details><summary>stddef.h/</summary>

~~~cpp
typedef uint16_t    ptrdiff_t;          /* Result of sub. two pointers. */
typedef uint16_t    size_t;             /* sizeof type */
~~~

</details>  

<details><summary>stdint.h/</summary>

~~~cpp
typedef signed char     int8_t;
typedef unsigned char   uint8_t;
typedef int             int16_t;
typedef unsigned int    uint16_t;
~~~

</details>  

<details><summary>stdio.h/</summary>

~~~cpp
#define EOF         0x1a

/* Prints a char. */
extern int putchar(int c);

/* Prints a string. */
extern int puts(const char *s);

/* Print formatted string to stdout. */
extern int printf(char *fmt, ...);

/* Non standard extension. */
extern int kbhit(void);
~~~

</details>  

<details><summary>stdlib.h/</summary>

~~~cpp
/* Standard requires it here. */
#ifndef NULL
#define NULL 0
#endif /* NULL */

/* Memory allocation. */
extern void *malloc(size_t size);

/* Memory allocate and clear. */
extern void *calloc (size_t num, size_t size);

/* Free allocated memory block. */
extern void free(void *ptr);

/* random numbers */
#ifndef RAND_MAX
#define RAND_MAX    32767
#endif /* RAND_MAX */
extern int rand(void);
extern void srand(unsigned int seed);

/* absolute value */
extern int abs(int x);
~~~

</details>  

<details><summary>string.h/</summary>

~~~cpp
#ifndef NULL
#define NULL ( (void *) 0)
#endif /* NULL */

/* Set n bytes in memory block to the value c, */
extern void *memset(void *s, int c, size_t n);

/* Copy memory block, */
extern void *memcpy(const void *dest, const void *src, size_t n);
~~~

</details>  

[language.url]:   https://en.wikipedia.org/wiki/ANSI_C
[language.badge]: https://img.shields.io/badge/language-C-blue.svg

[standard.url]:   https://en.wikipedia.org/wiki/C89/
[standard.badge]: https://img.shields.io/badge/standard-C89-blue.svg

[license.url]:    https://github.com/tstih/idp-udev/blob/main/LICENSE
[license.badge]:  https://img.shields.io/badge/license-MIT-blue.svg

[status.badge]:  https://img.shields.io/badge/status-stable-dkgreen.svg
