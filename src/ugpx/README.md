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
#define RES_1024x256    0x00
#define RES_1024x512    0x18
extern void ginit(uint8_t resolution);
~~~
This function will initialize the ef9367 chip and set the resolution. 

 > Unfortunately, you can't effectively use the highest resolution because the Iskra Delta Partner refresh frequency is too low. As a result, the screen will blink like a Christmas tree if you draw something complex on it. And the 1024x256 mode has rectangular pixels and a 4:1 ratio. 
 Thus, many games implement the *emulated* 512x256 pixel resolution. The latter is not a native resolution of the ef9367 chip. It is produced by double painting each horizontal pixel in the 1024x256 mode.

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
shown to you, and the `PG_WRITE` to select the page your commands draw on. The Iskra Delta Partner has two pages.
Use 0 or 1 for the page argument. 
You can set both pages at the same time, like this:
~~~cpp
gsetpage(PG_DISPLAY|PG_WRITE,0);
~~~
By quickly switching between two pages, you can implement the *double buffering* technique in games.

## Clearing the screen

Use the [gcls()](gcls.s) function to clear the display page. When initializing graphics, the pages are in an inconsistent state. We recommend clearing both pages:

~~~cpp
gsetpage(PG_WRITE|PG_DISPLAY,1);
gcls();
gsetpage(PG_WRITE|PG_DISPLAY,0);
gcls();
~~~

## Setting the ink color

You can set the color to foreground, background, and none by calling the [gsetcolor()](gsetcolor.s) function. The foreground color is white, the background color is black, and none means no drawing, just the location change of the graphics cursor.

~~~cpp
/* set color, sets drawing color 
   NOTES: 
    when drawing glyph this color
    is used to draw lines and its
    inverse is used to draw empty space */
#define CO_NONE         0x00
#define CO_FORE         0x01
#define CO_BACK         0x02
typedef uint8_t color;
extern void gsetcolor(color c);
~~~

## The coordinates

Micro Graphics functions use signed integer coordinates. Hence, the coordinates can be used to store off-screen locations. There is no automatic handling of off-screen coordinates. Your code is responsible for that. The coordinates are defined as:
~~~cpp
typedef int coord;
~~~

## Moving to a position

Some drawing functions are relative, and some are absolute. Relative coordinates need a point of origin. We call this
point the graphics cursor. After clearing the screen, the cursor
location is (0,0). You can move the graphics cursor to a new
location using the [gxy()](gxy.s) function.
~~~cpp
/* manually move graphics cursor to x,y */
extern void gxy(coord x, coord y);
~~~
The ef9367 chip implements a reversed y-axis. To mitigate it - the library subtracts the y coordinate from the y-axis for every operation. This hack guarantees that the (0,0) location is in the top-left corner of the screen and the coordinates behave as expected.

## Drawing a pixel

The function for drawing a pixel at x,y is [gputpixel()](gputpixel.s). 
~~~cpp
/* draw pixel */
extern void gputpixel(coord x, coord y);
~~~
This function respects the current color.

## Drawing a line

Micro Graphics library comes with two line drawing functions.  Both respect the current color.

### Draw a relative line

You can draw a relative line with x and y coordinates ranging from -255 to 255 by using the [gdrawdelta()](gdrawdelta.s) function.
~~~cpp
extern void gdrawdelta(coord dx, coord dy);
~~~

### Draw an absolute line

You can also draw a line with absolute coordinates of any length by using the [gdrawline()](gdrawline.s) function.
~~~cpp
extern void gdrawline(coord x0, coord y0, coord x1, coord y1);
~~~
 > This function recursively chops lines of length > 256 to half until they are shorter than 256 pixels, and then uses the `gdrawdelta()` function to draw them.

## Drawing shapes

Most shape drawing functions are implemented in C and combine drawing algorithms and atomic drawing functions `gputpixel()` and `gdrawdelta()`. Only a few functions are optimized and use the hardware directly.

### Rectangles

Rectangle drawing functions use the `rect_t` structure.
~~~cpp
typedef struct rect_s {                 /* the rectangle */
	coord x0;
	coord y0;
	coord x1;
	coord y1;
} rect_t;
~~~
 > The `gdrawline()` function that all rectangle functions use is optimized for fast drawing of horizontal and vertical lines.

#### Normalized rectangle

A normalized rectangle is a rectangle with x0 < x1 and y0 < y1. You can normalize a rectangle by passing it to the [gnormrect()](gnormrect.s) function.
~~~cpp
extern rect_t *gnormrect(rect_t *r);
~~~

#### Draw rectangle

Use the [gdrawrect()](gdrawrect.c) function to draw a rectangle.
~~~cpp
extern void gdrawrect(rect_t *r);
~~~

#### Fill rectangle

Use the [gfillrect()](gfillrect.c) function to draw a filled rectangle.
~~~cpp
extern void gfillrect(rect_t *r);
~~~

## Glyphs

Because the *ef9367* chip is only good at drawing lines, the Micro Graphics library supports only two glyph types: tiny glyph, and line glyph. 

### Drawing a glyph

Use the [gputglyph()](gputglyph.s) function to draw a glyph.
~~~cpp
/* draw unclipped LINE or TINY glyph. */
extern void gputglyph(void* glyph, coord x, coord y);
~~~
The `gputglyph()` supports the current color and combines it with the glyph color. The following table shows the result.

| current color | glyph color | result     | 
|---------------|-------------|------------|
| none          | any         | none       | 
| any           | none        | none       | 
| foreground    | background  | background | 
| background    | foreground  | background | 
| foreground    | foreground  | foreground | 
| background    | background  | foreground | 

### Measuring a glyph

You can measure a glyph by calling the `gmeglyph()` function. It returns the width and the height of the glyph.

~~~cpp
typedef struct dim_s {                  /* the dimensions */
    coord w;
    coord h;
} dim_t;
extern dim_t *gmeglyph(glyph_t *g, dim_t*d);
~~~

## Fonts

In the Micro Graphics library, a font is a set of glyphs with some metadata. Font drawing is implemented using the glyph drawing functions.

The two functions to work with fonts are:

~~~cpp
/* print string */
extern void gputtext(void *font, char *text, coord x, coord y);
/* get text size */
extern dim_t *gmetext(void *font, char *text, dim_t *d);
~~~

# Glyph and font format(s)

See: [libgpx](https://github.com/tstih/libgpx)

# To-do

The glyph and text measuring functions are not implemented yet.

[language.url]:   https://en.wikipedia.org/wiki/ANSI_C
[language.badge]: https://img.shields.io/badge/language-C-blue.svg

[standard.url]:   https://en.wikipedia.org/wiki/C89/
[standard.badge]: https://img.shields.io/badge/standard-C89-blue.svg

[license.url]:    https://github.com/tstih/idp-udev/blob/main/LICENSE
[license.badge]:  https://img.shields.io/badge/license-MIT-blue.svg

[status.badge]:  https://img.shields.io/badge/status-stable-green.svg
