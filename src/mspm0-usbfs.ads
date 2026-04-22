--
--  Copyright (C) 2026 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package MSPM0.USBFS
   with Pure
is

   type USBMODE_Register is record
      PHYMODE     : Boolean := False;
      DEVICEONLY  : Boolean := False;
      HOST        : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for USBMODE_Register use record
      PHYMODE     at 0 range 4 .. 4;
      DEVICEONLY  at 0 range 1 .. 1;
      HOST        at 0 range 0 .. 0;
   end record;

   type USBFS_Peripheral is record
      PWREN    : UInt32;
      RSTCTL   : UInt32;
      USBMODE  : USBMODE_Register;
   end record
      with Volatile;
   for USBFS_Peripheral use record
      PWREN    at 16#0800# range 0 .. 31;
      RSTCTL   at 16#0804# range 0 .. 31;
      USBMODE  at 16#1100# range 0 .. 31;
   end record;

end MSPM0.USBFS;
