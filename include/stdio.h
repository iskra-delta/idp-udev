/*
 * stdio.h
 *
 * standard C header file
 * 
 * MIT License (see: LICENSE)
 * copyright (c) 2021 tomaz stih
 *
 * 01.05.2021   tstih
 *
 */
#ifndef __STDIO_H__
#define __STDIO_H__

#include <stdbool.h>
#include <stddef.h>
#include <stdarg.h>

#define EOF         0x1a

/* Prints a char. */
extern int putchar(int c);

/* Prints a string. */
extern int puts(const char *s);

/* Print formatted string to stdout. */
extern int printf(char *fmt, ...);

#endif /* __STDIO_H__ */