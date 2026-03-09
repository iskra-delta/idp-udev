#ifndef TESTFW_H
#define TESTFW_H

#include <io.h>

#define TF_LOG_CAP 4096

static unsigned int tf_passes = 0;
static unsigned int tf_failures = 0;
static char tf_log[TF_LOG_CAP];
static unsigned int tf_log_len = 0;
static char *tf_output_path = 0;

static void tf_append_char(char c)
{
    if (tf_log_len < (TF_LOG_CAP - 1)) {
        tf_log[tf_log_len++] = c;
        tf_log[tf_log_len] = 0;
    }
}

static void tf_append_str(char *s)
{
    if (!s)
        s = "(null)";
    while (*s)
        tf_append_char(*s++);
}

static void tf_append_uint_dec(unsigned int value)
{
    char digits[5];
    unsigned int count = 0;

    if (value == 0) {
        tf_append_char('0');
        return;
    }

    while (value && count < sizeof(digits)) {
        digits[count++] = (char)('0' + (value % 10));
        value /= 10;
    }

    while (count)
        tf_append_char(digits[--count]);
}

static void tf_append_int_dec(int value)
{
    unsigned int mag;

    if (value < 0) {
        tf_append_char('-');
        mag = (unsigned int)(-(value + 1)) + 1u;
    } else {
        mag = (unsigned int)value;
    }
    tf_append_uint_dec(mag);
}

static void tf_append_hex4(unsigned int value)
{
    unsigned int shift;
    for (shift = 12; ; shift -= 4) {
        unsigned int nibble = (value >> shift) & 0x0fu;
        tf_append_char((char)(nibble < 10 ? ('0' + nibble) : ('a' + nibble - 10)));
        if (shift == 0)
            break;
    }
}

static void tf_log_line(char *prefix, char *name)
{
    tf_append_str(prefix);
    tf_append_char(' ');
    tf_append_str(name);
    tf_append_char('\n');
}

static void tf_set_output(char *path)
{
    tf_output_path = path;
}

static void tf_banner(char *name)
{
    tf_log_line("BEGIN", name);
}

static void tf_pass(char *name)
{
    ++tf_passes;
    tf_log_line("PASS", name);
}

static void tf_fail_int(char *name, int expected, int actual)
{
    ++tf_failures;
    tf_append_str("FAIL ");
    tf_append_str(name);
    tf_append_str(" expected=");
    tf_append_int_dec(expected);
    tf_append_str(" actual=");
    tf_append_int_dec(actual);
    tf_append_char('\n');
}

static void tf_fail_uint(char *name, unsigned int expected, unsigned int actual)
{
    ++tf_failures;
    tf_append_str("FAIL ");
    tf_append_str(name);
    tf_append_str(" expected=");
    tf_append_uint_dec(expected);
    tf_append_str(" actual=");
    tf_append_uint_dec(actual);
    tf_append_char('\n');
}

static void tf_fail_ptr(char *name, unsigned int expected, unsigned int actual)
{
    ++tf_failures;
    tf_append_str("FAIL ");
    tf_append_str(name);
    tf_append_str(" expected=0x");
    tf_append_hex4(expected);
    tf_append_str(" actual=0x");
    tf_append_hex4(actual);
    tf_append_char('\n');
}

static void tf_fail_str(char *name, char *expected, char *actual)
{
    ++tf_failures;
    tf_append_str("FAIL ");
    tf_append_str(name);
    tf_append_str(" expected=\"");
    tf_append_str(expected);
    tf_append_str("\" actual=\"");
    tf_append_str(actual);
    tf_append_str("\"\n");
}

static void tf_expect_true(char *name, int cond)
{
    if (cond)
        tf_pass(name);
    else
        tf_fail_int(name, 1, 0);
}

static void tf_expect_int(char *name, int expected, int actual)
{
    if (expected == actual)
        tf_pass(name);
    else
        tf_fail_int(name, expected, actual);
}

static void tf_expect_uint(char *name, unsigned int expected, unsigned int actual)
{
    if (expected == actual)
        tf_pass(name);
    else
        tf_fail_uint(name, expected, actual);
}

static void tf_expect_ptr(char *name, void *expected, void *actual)
{
    unsigned int ex = (unsigned int)expected;
    unsigned int ac = (unsigned int)actual;
    if (ex == ac)
        tf_pass(name);
    else
        tf_fail_ptr(name, ex, ac);
}

static int tf_streq(char *lhs, char *rhs)
{
    while (*lhs && *rhs) {
        if (*lhs != *rhs)
            return 0;
        ++lhs;
        ++rhs;
    }
    return *lhs == *rhs;
}

static void tf_expect_str(char *name, char *expected, char *actual)
{
    if (actual && tf_streq(expected, actual))
        tf_pass(name);
    else
        tf_fail_str(name, expected, actual ? actual : "(null)");
}

static int tf_report(void)
{
    tf_append_str("SUMMARY pass=");
    tf_append_uint_dec(tf_passes);
    tf_append_str(" fail=");
    tf_append_uint_dec(tf_failures);
    tf_append_char('\n');

    if (tf_output_path)
        fsave(tf_output_path, tf_log, tf_log_len);

    return tf_failures ? 1 : 0;
}

#endif
