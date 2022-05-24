/*
 * list.h
 *
 * Linked list header file.
 * 
 * MIT License (see: LICENSE)
 * copyright (c) 2021 tomaz stih
 *
 * 05.06.2012   tstih
 *
 */
#ifndef __LIST_H__
#define __LIST_H__

#ifndef NULL
#define NULL (void *)0
#endif

/* each linked list must start with list_header */
typedef struct list_header_s {
    void *next;
} list_header_t;

/* match functions */
extern unsigned char _list_match_eq(list_header_t *p, unsigned int arg);

/* find element using match function */
extern list_header_t *_list_find(
    list_header_t *first,
    list_header_t **prev,
    unsigned char (*match)(list_header_t *p, unsigned int arg),
    unsigned int the_arg);

/* insert element into linked list at begining */
extern list_header_t *_list_insert(list_header_t** first, list_header_t *el);

/* insert element into linked list at end */
extern list_header_t *_list_append(list_header_t** first, list_header_t *el);

/* removes element from linked list */
extern list_header_t *_list_remove(list_header_t **first, list_header_t *el);

/* remove first element from linked list */
extern list_header_t *_list_remove_first(list_header_t **first);

#endif /* __LIST_H__ */
