/*
 * stdlib.h
 *
 * standard C header file
 * 
 * MIT License (see: LICENSE)
 * copyright (c) 2021 tomaz stih
 *
 * 01.05.2021   tstih
 *
 */
#ifndef __STDLIB_H__
#define __STDLIB_H__

#include <stddef.h>

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

#endif /* __STDLIB_H__ */