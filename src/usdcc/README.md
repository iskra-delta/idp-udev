![status.badge] [![language.badge]][language.url] [![standard.badge]][standard.url] [![license.badge]][license.url]

# μsdcc

*Micro SDCC* is an ultralight version of the [libsdcc-z80.](https://github.com/tstih/libsdcc-z80), without supporting floating point and long types.
The SDCC supports all standard data types _except double_, but bare-metal projects commonly exclude its startup files, header files, and libraries by using switches `--no-std-crt0`, `--nostdinc`, and `--nostdlib`. 

The two libraries are extracts from the entire SDCC standard library, with just the support you need. 

Following table shows included data types for each scenario.

| type      | bits | bare | μsdcc | libsdcc-z80 | sdcc |
|-----------|-----:|:----:|:-----:|:-----------:|:-----|
| char      |   8  |   *  |   *   |      *      |   *  |
| short     |   8  |   *  |   *   |      *      |   *  |
| int       |  16  |      |   *   |      *      |   *  |
| long      |  32  |      |       |      *      |   *  |
| long long |  64  |      |       |      *      |   *  |
| float     |  32  |      |       |      *      |   *  |
| double    |  64  |      |       |             |      |

[language.url]:   https://en.wikipedia.org/wiki/ANSI_C
[language.badge]: https://img.shields.io/badge/language-C-blue.svg

[standard.url]:   https://en.wikipedia.org/wiki/C89/
[standard.badge]: https://img.shields.io/badge/standard-C89-blue.svg

[license.url]:    https://github.com/tstih/idp-udev/blob/main/LICENSE
[license.badge]:  https://img.shields.io/badge/license-MIT-blue.svg

[status.badge]:  https://img.shields.io/badge/status-stable-dkgreen.svg
