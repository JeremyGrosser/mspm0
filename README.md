# MSPM0 support for Ada
This library is provided under the BSD-3-Clause license. No warranty or support should be expected. Use at your own risk.

TI provides register descriptions in a proprietary .ccxml format with Code Composer Studio. While we can generate [Ada type definitions from ccxml](https://github.com/JeremyGrosser/ccs2ada), the structure is often difficult to comprehend and lacks detail provided in the datasheets. Instead, this library uses hand written type definitions for registers.

An effort has been made to reduce code size and ensure compatibility with SPARK Mode where possible. The "drivers" here are fairly minimal and most applications will manipulate registers directly.

This is not a complete library of all registers, just the ones I've needed to accomplish certain tasks. It is straightforward, if a bit tedious, to create definitions for additional registers.

I have only tested this code on MSPM0G3507 but all of the MSPM0 family chips share very similar register layouts and new devices should be easy to add by creating a [device file](src/mspm0-g3507.ads) with instances of the supported peripherals and their base addresses.

The ARM SysTick and NVIC specs are not specific to MSPM0 but are included here for convenience.

Code size can be reduced further by forking [bare_runtime](https://gihtub.com/JeremyGrosser/bare_runtime) and removing support for Semihosting, Floating point 'Image, and simplifying the Last_Chance_Handler.

Upstream OpenOCD does not have support for MSPM0 yet. I've implemented rudimentary flash support on my [mspm0 branch](https://github.com/JeremyGrosser/openocd/tree/mspm0). The TI Launchpad boards are supported by both the CMSIS-DAP and XDS110 interface drivers.

Better and more complete OpenOCD support for MSPM0 is [in review on openocd gerrit](https://review.openocd.org/c/openocd/+/8384).
