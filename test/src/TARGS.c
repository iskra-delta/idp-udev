#include <stdio.h>

#include "testfw.h"

int main(int argc, char **argv)
{
    tf_set_output("TARGS.TXT");
    tf_banner("TARGS");
    tf_expect_int("argc", 3, argc);
    tf_expect_ptr("argv0", 0, argv[0]);
    tf_expect_str("argv1", "ALPHA", argv[1]);
    tf_expect_str("argv2", "BETA", argv[2]);
    return tf_report();
}
