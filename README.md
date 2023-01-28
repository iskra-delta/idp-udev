![status.badge] [![language.badge]][language.url] [![standard.badge]][standard.url] [![license.badge]][license.url]

# idp-udev

A micro-library to create computer games for the Iskra Delta Partner. The library is stripped to the bare minimum and optimized for size and speed.

It consists of three micro-libraries:
 * [**μsdcc**](src/ulibc/README.md]. Support for integer arithmetic for the SDCC compiler.
 * [**μlibc**](src/usdcc/README.md). Minimal subset of the standard C library.
 * [**μgpx**](src/ugpx/README.md). The graphics library.

# Compiling the idp-udev

You need Linux to compile the micro-library. 

First, install the SDCC suite if you don't already have it. Then clone the library source code to your target directory. Finally, change the current directory to your target directory, and run the make.
~~~
sudo apt-get install sdcc
git clone https://github.com/tstih/idp-udev.git
cd idp-udev
make
~~~
To include the micro-library in your project, you can pass the BUILD_DIR and BIN_DIR to the make like this. 
~~~
make BUILD_DIR=mybuild BIN_DIR=mybin
~~~
If you redirect those two directories, you are responsible for implementing the `make clean` command. 

# Demo

[Explore the Lunatik project](https://github.com/tstih/lunatik) to see this library in action.

[language.url]:   https://en.wikipedia.org/wiki/ANSI_C
[language.badge]: https://img.shields.io/badge/language-C-blue.svg

[standard.url]:   https://en.wikipedia.org/wiki/C89/
[standard.badge]: https://img.shields.io/badge/standard-C89-blue.svg

[license.url]:    https://github.com/tstih/idp-udev/blob/main/LICENSE
[license.badge]:  https://img.shields.io/badge/license-MIT-blue.svg

[status.badge]:  https://img.shields.io/badge/status-stable-green.svg
