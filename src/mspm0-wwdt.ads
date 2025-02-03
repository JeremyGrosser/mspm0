--
--  Copyright (C) 2025 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");

package MSPM0.WWDT
   with Pure
is
   type CTL0_Register is record
      KEY      : UInt8 := 16#C9#;
      STISM    : Boolean := False;
      MODE     : Boolean := False;
      WINDOW1  : UInt3 := 0;
      WINDOW0  : UInt3 := 0;
      PER      : UInt3 := 4;
      CLKDIV   : UInt3 := 3;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Async_Writers, Object_Size => 32;
   for CTL0_Register use record
      KEY      at 0 range 24 .. 31;
      STISM    at 0 range 17 .. 17;
      MODE     at 0 range 16 .. 16;
      WINDOW1  at 0 range 12 .. 14;
      WINDOW0  at 0 range 8 .. 10;
      PER      at 0 range 4 .. 6;
      CLKDIV   at 0 range 0 .. 2;
   end record;

   type CTL1_Register is record
      KEY      : UInt8 := 16#BE#;
      WINSEL   : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Async_Writers, Object_Size => 32;
   for CTL1_Register use record
      KEY      at 0 range 24 .. 31;
      WINSEL   at 0 range 0 .. 0;
   end record;

   CNTRST_RESTART : constant UInt32 := 16#0000_00A7#;

   type WWDT_Peripheral is record
      PWREN    : UInt32;
      RSTCTL   : UInt32;
      IIDX     : UInt32;
      IMASK    : UInt32;
      RIS      : UInt32;
      MIS      : UInt32;
      ISET     : UInt32;
      ICLR     : UInt32;
      CTL0     : CTL0_Register;
      CTL1     : CTL1_Register;
      CNTRST   : UInt32;
      STAT     : UInt32;
   end record
      with Volatile, Effective_Writes, Async_Readers, Async_Writers;

   for WWDT_Peripheral use record
      PWREN    at 16#0800# range 0 .. 31;
      RSTCTL   at 16#0804# range 0 .. 31;
      IIDX     at 16#1020# range 0 .. 31;
      IMASK    at 16#1028# range 0 .. 31;
      RIS      at 16#1030# range 0 .. 31;
      MIS      at 16#1038# range 0 .. 31;
      ISET     at 16#1040# range 0 .. 31;
      ICLR     at 16#1048# range 0 .. 31;
      CTL0     at 16#1100# range 0 .. 31;
      CTL1     at 16#1104# range 0 .. 31;
      CNTRST   at 16#1108# range 0 .. 31;
      STAT     at 16#110C# range 0 .. 31;
   end record;
end MSPM0.WWDT;
