/*
 * print.h
 *
 * printf and puts functions
 *
 * MIT License (see: LICENSE)
 *
 * 04.04.2022   tstih
 *
 */
#include <ulibc/cpm.h>

#ifndef NULL
#define NULL (void *)0
#endif

/* Standard C var arg macros */
#define va_list                 unsigned char *
#define va_start(marker, last)  { marker = (va_list)&last + sizeof(last); }
#define va_arg(marker, type)    *((type *)((marker += sizeof(type)) - sizeof(type)))
#define va_end(marker)          marker = (va_list) 0;

#define PRINT_BUF_LEN 128

enum flags {
	PAD_ZERO	= 1,
	PAD_RIGHT	= 2,
};

/* used for all print functions */
extern int putchar(int c);

/* prints the string of width with flags */
static void _prints(const char *string, int width, int flags)
{
	int padchar = ' ';

	if (width > 0) {
		int len = 0;
		const char *ptr;
		for (ptr = string; *ptr; ++ptr) ++len;
		if (len >= width) width = 0;
		else width -= len;
		if (flags & PAD_ZERO)
			padchar = '0';
	}
	if (!(flags & PAD_RIGHT)) {
		for ( ; width > 0; --width) {
			putchar(padchar);
		}
	}
	for ( ; *string ; ++string) {
		putchar(*string);
	}
	for ( ; width > 0; --width) {
		putchar(padchar);
	}
}

/* print the integer */
static void _printi(int i, int base, int sign, int width, int flags, int letbase)
{
	char print_buf[PRINT_BUF_LEN];
	char *s;
	int t, neg = 0, pc = 0;
	unsigned int u = i;
	if (i == 0) {
		print_buf[0] = '0';
		print_buf[1] = '\0';
		_prints(print_buf, width, flags);
        return;
	}
	if (sign && base == 10 && i < 0) {
		neg = 1;
		u = -i;
	}
	s = print_buf + PRINT_BUF_LEN-1;
	*s = '\0';
	while (u) {
		t = u % base;
		if( t >= 10 )
			t += letbase - '0' - 10;
		*--s = t + '0';
		u /= base;
	}
	if (neg) {
		if( width && (flags & PAD_ZERO) ) {
			putchar ('-');
			++pc;
			--width;
		}
		else {
			*--s = '-';
		}
	}
	_prints(s, width, flags);
}

void printf(const char *format, ...)
{
    /* handle variable args */
    va_list ap;
    va_start(ap, format);

	int width, flags;
	char scr[2];
	union {
		char c;
		char *s;
		int i;
		unsigned int u;
		void *p;
	} u;

    /* for each char in format */
	for (; *format != 0; ++format) {
        /* if it is formatting */
		if (*format == '%') {
			++format;                   /* peek at next char after % */
			width = flags = 0;
			if (*format == '\0')        /* if end of string it's a mistake: ignore */
				break;
			if (*format == '%')         /* if %% then it's escape code */
				goto esc;
			if (*format == '-') {       /* if - then pad right and get next format specifier */
				++format;
				flags = PAD_RIGHT;
			}
			while (*format == '0') {    /* if 0 then pad zero and get next format specifier */
				++format;
				flags |= PAD_ZERO;
			}
			if (*format == '*') {
				width = va_arg(ap, int);
				format++;
			} else {
				for ( ; *format >= '0' && *format <= '9'; ++format) {
					width *= 10;
					width += *format - '0';
				}
			}
            /* "main" format specifier */
			switch (*format) {
				case('d'):              /* decimal! */
					u.i = va_arg(ap, int);
					_printi(u.i, 10, 1, width, flags, 'a');
					break;

				case('u'):              /* unsigned */
					u.u = va_arg(ap, unsigned int);
					_printi(u.u, 10, 0, width, flags, 'a');
					break;

				case('x'):              /* hex */
					u.u = va_arg(ap, unsigned int);
					_printi(u.u, 16, 0, width, flags, 'a');
					break;

				case('X'):              /* hex, capital */
					u.u = va_arg(ap, unsigned int);
					_printi(u.u, 16, 0, width, flags, 'A');
					break;

				case('c'):              /* char */
					u.c = va_arg(ap, int);
					scr[0] = u.c;
					scr[1] = '\0';
					_prints(scr, width, flags);
					break;

				case('s'):              /* string */
					u.s = va_arg(ap, char *);
                    #pragma disable_warning 196
					_prints(u.s ? u.s : "(null)", width, flags);
					break;

				default:
					break;
			}
		} else { /* char is not formatting, just display it */
esc:
			putchar(*format);
		}
	}
}

int puts(const char *s)
{
    /* Nothing to print? */
    if (s==NULL || s[0]==0) return 0;
    int i = 0;
    while(s[i]) { putchar(s[i]); i++; }
    return 1;
}