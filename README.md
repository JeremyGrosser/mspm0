# MSPM0 support for Ada/SPARK
This library is provided under the BSD-3-Clause license. No warranty or support should be expected. Use at your own risk.

TI provides register descriptions in a proprietary .ccxml format with Code Composer Studio. While we can generate [Ada type definitions from ccxml](https://github.com/JeremyGrosser/ccs2ada), the structure is often difficult to comprehend and lacks detail provided in the datasheets. Instead, this library uses hand written type definitions for registers.

An effort has been made to reduce code size and ensure compatibility with SPARK Mode where possible. The "drivers" here are fairly minimal and most applications will manipulate registers directly.

This is not a complete library of all registers, just the ones I've needed to accomplish certain tasks. It is straightforward, if a bit tedious, to create definitions for additional registers.

I have only tested this code on MSPM0G3507 but all of the MSPM0 family chips share very similar register layouts and new devices should be easy to add by creating a [device file](src/mspm0-g3507.ads) with instances of the supported peripherals and their base addresses.

Code size can be reduced further by forking [bare_runtime](https://gihtub.com/JeremyGrosser/bare_runtime) and removing support for Semihosting, Floating point 'Image, and simplifying the Last_Chance_Handler.

[OpenOCD supports mspm0](https://review.openocd.org/c/openocd/+/8384). The Launchpad boards include an XDS110 debug adapter and I've also successfully used a RP2040 Picoprobe with the `interface/cmsis-dap.cfg` script.
