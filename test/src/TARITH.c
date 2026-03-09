#include <stdio.h>

#include "testfw.h"

typedef struct {
    signed char a;
    signed char b;
    signed char q;
    signed char r;
} scase_t;

typedef struct {
    unsigned char a;
    unsigned char b;
    unsigned char q;
    unsigned char r;
} ucase_t;

typedef struct {
    int a;
    int b;
    int q;
    int r;
} icase_t;

typedef struct {
    unsigned int a;
    unsigned int b;
    unsigned int q;
    unsigned int r;
} uicase_t;

typedef struct {
    int a;
    int b;
    int p;
} mcase_t;

static signed char sdiv_char(signed char a, signed char b) { return a / b; }
static signed char smod_char(signed char a, signed char b) { return a % b; }
static unsigned char udiv_char(unsigned char a, unsigned char b) { return a / b; }
static unsigned char umod_char(unsigned char a, unsigned char b) { return a % b; }
static int sdiv_int(int a, int b) { return a / b; }
static int smod_int(int a, int b) { return a % b; }
static unsigned int udiv_int(unsigned int a, unsigned int b) { return a / b; }
static unsigned int umod_int(unsigned int a, unsigned int b) { return a % b; }
static int mul_int(int a, int b) { return a * b; }

static void test_signed_char_ops(void)
{
    static scase_t cases[] = {
        { 7, 3, 2, 1 },
        { -7, 3, -2, -1 },
        { 7, -3, -2, 1 },
        { -7, -3, 2, -1 },
        { 100, 7, 14, 2 },
        { -128, 2, -64, 0 }
    };
    unsigned int i;
    volatile signed char a;
    volatile signed char b;

    for (i = 0; i < sizeof(cases) / sizeof(cases[0]); ++i) {
        a = cases[i].a;
        b = cases[i].b;
        tf_expect_int("schar.div", cases[i].q, sdiv_char(a, b));
        tf_expect_int("schar.mod", cases[i].r, smod_char(a, b));
    }
}

static void test_unsigned_char_ops(void)
{
    static ucase_t cases[] = {
        { 7u, 3u, 2u, 1u },
        { 255u, 2u, 127u, 1u },
        { 200u, 13u, 15u, 5u },
        { 1u, 255u, 0u, 1u }
    };
    unsigned int i;
    volatile unsigned char a;
    volatile unsigned char b;

    for (i = 0; i < sizeof(cases) / sizeof(cases[0]); ++i) {
        a = cases[i].a;
        b = cases[i].b;
        tf_expect_uint("uchar.div", cases[i].q, udiv_char(a, b));
        tf_expect_uint("uchar.mod", cases[i].r, umod_char(a, b));
    }
}

static void test_signed_int_ops(void)
{
    static icase_t cases[] = {
        { 30000, 100, 300, 0 },
        { -30000, 100, -300, 0 },
        { 30000, -100, -300, 0 },
        { -30000, -100, 300, 0 },
        { 32767, 255, 128, 127 },
        { -32767, 255, -128, -127 }
    };
    unsigned int i;
    volatile int a;
    volatile int b;

    for (i = 0; i < sizeof(cases) / sizeof(cases[0]); ++i) {
        a = cases[i].a;
        b = cases[i].b;
        tf_expect_int("int.div", cases[i].q, sdiv_int(a, b));
        tf_expect_int("int.mod", cases[i].r, smod_int(a, b));
    }
}

static void test_unsigned_int_ops(void)
{
    static uicase_t cases[] = {
        { 65535u, 255u, 257u, 0u },
        { 50000u, 300u, 166u, 200u },
        { 1u, 65535u, 0u, 1u },
        { 12345u, 16u, 771u, 9u }
    };
    unsigned int i;
    volatile unsigned int a;
    volatile unsigned int b;

    for (i = 0; i < sizeof(cases) / sizeof(cases[0]); ++i) {
        a = cases[i].a;
        b = cases[i].b;
        tf_expect_uint("uint.div", cases[i].q, udiv_int(a, b));
        tf_expect_uint("uint.mod", cases[i].r, umod_int(a, b));
    }
}

static void test_mul_int_ops(void)
{
    static mcase_t cases[] = {
        { 0, 123, 0 },
        { 7, 9, 63 },
        { -7, 9, -63 },
        { -123, 45, -5535 },
        { 300, 100, 30000 },
        { -200, 150, -30000 }
    };
    unsigned int i;
    volatile int a;
    volatile int b;

    for (i = 0; i < sizeof(cases) / sizeof(cases[0]); ++i) {
        a = cases[i].a;
        b = cases[i].b;
        tf_expect_int("int.mul", cases[i].p, mul_int(a, b));
    }
}

int main(void)
{
    tf_set_output("TARITH.TXT");
    tf_banner("TARITH");
    test_signed_char_ops();
    test_unsigned_char_ops();
    test_signed_int_ops();
    test_unsigned_int_ops();
    test_mul_int_ops();
    return tf_report();
}
