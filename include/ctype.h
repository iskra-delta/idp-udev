/*
 * ctype.h
 *
 * minimal ctype
 * 
 * MIT License (see: LICENSE)
 * copyright (c) 2022 tomaz stih
 *
 * 18.04.2022   tstih
 *
 */
#ifndef __CTYPE_H__
#define __CTYPE_H__

extern int isdigit(int c);
extern int isalpha(int c);
extern int isalnum(int c);
extern int islower(int c);
extern int isupper(int c);

extern int toupper(int c);
extern int tolower(int c);

#endif /* __CTYPE_H__ */