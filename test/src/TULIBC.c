#include <ctype.h>
#include <io.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "testfw.h"

#define DRV_LOGINVEC 24

typedef struct bdos_ret_s {
    unsigned char reta;
    unsigned char retb;
    unsigned int rethl;
} bdos_ret_t;

extern unsigned char bdos(unsigned char fn, unsigned int param);
extern bdos_ret_t *bdosret(unsigned char fn, unsigned int param, bdos_ret_t *p);

static void expect_bytes(char *name, char *expected, char *actual, unsigned int len)
{
    unsigned int i;
    for (i = 0; i < len; ++i) {
        if (expected[i] != actual[i]) {
            tf_fail_int(name, expected[i], actual[i]);
            return;
        }
    }
    tf_pass(name);
}

static void test_abs_fn(void)
{
    tf_expect_int("abs.pos", 17, abs(17));
    tf_expect_int("abs.neg", 17, abs(-17));
    tf_expect_int("abs.zero", 0, abs(0));
}

static void test_ctype_fn(void)
{
    tf_expect_int("isdigit.true", 1, isdigit('5'));
    tf_expect_int("isdigit.false", 0, isdigit('X'));
    tf_expect_int("isalpha.true", 1, isalpha('Q'));
    tf_expect_int("isalnum.true", 1, isalnum('7'));
    tf_expect_int("islower.true", 1, islower('z'));
    tf_expect_int("isupper.true", 1, isupper('Z'));
    tf_expect_int("toupper", 'K', toupper('k'));
    tf_expect_int("tolower", 'm', tolower('M'));
    tf_expect_int("toupper.noop", '!', toupper('!'));
}

static void test_string_fn(void)
{
    char src[8];
    char dst[8];
    unsigned int i;

    for (i = 0; i < sizeof(src); ++i)
        src[i] = (char) ('A' + i);
    memset(dst, 0, sizeof(dst));

    tf_expect_ptr("memcpy.ret", dst, memcpy(dst, src, sizeof(src)));
    expect_bytes("memcpy.bytes", src, dst, sizeof(src));

    tf_expect_ptr("memset.ret", dst, memset(dst, 'Z', 4));
    tf_expect_int("memset.byte0", 'Z', dst[0]);
    tf_expect_int("memset.byte3", 'Z', dst[3]);
    tf_expect_int("memset.byte4", src[4], dst[4]);
}

static void test_fparse_fn(void)
{
    fcb_t fcb;
    unsigned char area;
    int st;
    static char file_expected[8] = { 'F', 'I', 'L', 'E', ' ', ' ', ' ', ' ' };
    static char type_expected[3] = { 'T', 'X', 'T' };
    static char bare_expected[8] = { 'T', 'E', 'S', 'T', ' ', ' ', ' ', ' ' };
    static char blank_type[3] = { ' ', ' ', ' ' };

    memset(&fcb, 0, sizeof(fcb));
    area = 0;
    st = fparse("15B:FILE.TXT", &fcb, &area);
    tf_expect_int("fparse.status.ok", FP_STS_SUCCESS, st);
    tf_expect_int("fparse.area", 15, area);
    tf_expect_int("fparse.drive", 2, fcb.drive);
    expect_bytes("fparse.filename", file_expected, fcb.filename, 8);
    expect_bytes("fparse.filetype", type_expected, fcb.filetype, 3);

    memset(&fcb, 0, sizeof(fcb));
    area = 0;
    st = fparse("TEST", &fcb, &area);
    tf_expect_int("fparse.bare.status", FP_STS_SUCCESS, st);
    tf_expect_int("fparse.bare.area", FP_DEFAULT, area);
    tf_expect_int("fparse.bare.drive", 0, fcb.drive);
    expect_bytes("fparse.bare.filename", bare_expected, fcb.filename, 8);
    expect_bytes("fparse.bare.filetype", blank_type, fcb.filetype, 3);

    st = fparse("16A:FILE.TXT", &fcb, &area);
    tf_expect_int("fparse.invalid_area", FP_STS_INVALID_AREA, st);

    st = fparse("A:ABCDEFGHI.TXT", &fcb, &area);
    tf_expect_int("fparse.fname_overflow", FP_STS_FNAME_OVERFLOW, st);

    st = fparse("FILE.ABCD", &fcb, &area);
    tf_expect_int("fparse.ext_overflow", FP_STS_EXT_OVERFLOW, st);
}

static void test_bdos_fn(void)
{
    unsigned char vec_a;
    bdos_ret_t ret;

    vec_a = bdos(DRV_LOGINVEC, 0);
    memset(&ret, 0xaa, sizeof(ret));
    tf_expect_ptr("bdosret.ptr", &ret, bdosret(DRV_LOGINVEC, 0, &ret));
    tf_expect_uint("bdosret.reta", vec_a, ret.reta);
    tf_expect_true("bdosret.rethl_nonzero", ret.rethl != 0);
}

static void test_rand_fn(void)
{
    int r1;
    int r2;

    srand(1234);
    r1 = rand();
    r2 = rand();
    tf_expect_true("rand.distinct", r1 != r2);
}

int main(void)
{
    tf_set_output("TULIBC.TXT");
    tf_banner("TULIBC");
    test_abs_fn();
    test_ctype_fn();
    test_string_fn();
    test_fparse_fn();
    test_bdos_fn();
    test_rand_fn();
    return tf_report();
}
