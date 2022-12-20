![status.badge] [![language.badge]][language.url] [![standard.badge]][standard.url] [![license.badge]][license.url]

# μgpx

*Micro Graphics* is an ultralight graphics library for
the Iskra Delta Partner. It is optimized for computer
games and lacks sophisticated features such as clipping,
scaling, etc.

# Using Micro Graphics

Use this library in conjunction with the *μsdcc* and the
*μlibc* libraries. The library consists of only two files - the `ugpx.lib`and the `ugpx.h` files.

## Initialize the library

You initiate the library by calling the 
[ginit()](ginit.s) function.
~~~cpp
/* enter graphics mode */
#define RES_512x256     0xff
#define RES_1024x256    0x00
#define RES_1024x512    0x18
extern void ginit(uint8_t resolution);
~~~
This function will initialize the ef9367 chip and set the resolution. 

 > Unfortunately, you can't effectively use the highest resolution because the Iskra Delta Partner refresh frequency is too low. As a result, the screen will blink like a Christmas tree if you draw something complex on it. And the 1024x256 mode has rectangular pixels and a 4:1 ratio. So the library also allows you to use the recommended *emulated* 512x256 pixel resolution. The latter is not a native resolution of the ef9367 chip. It is produced by double painting each horizontal pixel in the 1024x256 mode.

## Exiting the library

To leave the graphics mode, call the [gexit()](gexit.s) function. 
~~~cpp
/* leave graphics mode */
extern void gexit();
~~~
At present, this function doesn't do anything, but sometimes in the future, it might.

## Set graphics page

To set the display/write page, call the [gsetpage()](gsetpage.s) function.
~~~cpp
/* pages */
#define PG_DISPLAY  1
#define PG_WRITE    2
extern void gsetpage(uint8_t op, uint8_t page);
~~~
Use the `PG_DISPLAY` for the `op` argument to set the page 
shown to you, and the `PG_WRITE` to select the page your commands draw on. You can also set both at the same time,
like this:
~~~cpp
gsetpage(PG_DISPLAY|PG_WRITE,0);
~~~

> The Iskra Delta Partner has two pages: 0 and 1. By drawing on both and quickly switching you can implement *double buffering* in games.


[language.url]:   https://en.wikipedia.org/wiki/ANSI_C
[language.badge]: https://img.shields.io/badge/language-C-blue.svg

[standard.url]:   https://en.wikipedia.org/wiki/C89/
[standard.badge]: https://img.shields.io/badge/standard-C89-blue.svg

[license.url]:    https://github.com/tstih/idp-udev/blob/main/LICENSE
[license.badge]:  https://img.shields.io/badge/license-MIT-blue.svg

[status.badge]:  https://img.shields.io/badge/status-stable-green.svg
