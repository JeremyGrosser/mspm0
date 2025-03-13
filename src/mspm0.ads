--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");

package MSPM0
   with Pure
is
   type UInt2 is mod 2 ** 2 with Size => 2;
   type UInt3 is mod 2 ** 3 with Size => 3;
   type UInt4 is mod 2 ** 4 with Size => 4;
   type UInt5 is mod 2 ** 5 with Size => 5;
   type UInt6 is mod 2 ** 6 with Size => 6;
   type UInt7 is mod 2 ** 7 with Size => 7;
   type UInt8 is mod 2 ** 8 with Object_Size => 8;
   type UInt9 is mod 2 ** 9 with Size => 9;
   type UInt10 is mod 2 ** 10 with Size => 10;
   type UInt12 is mod 2 ** 12 with Size => 12;
   type UInt16 is mod 2 ** 16 with Size => 16;
   type UInt22 is mod 2 ** 22 with Size => 22;
   type UInt32 is mod 2 ** 32 with Size => 32;
   type UInt64 is mod 2 ** 64 with Size => 64;

   function Shift_Left (N : UInt8; Amount : Natural) return UInt8
      with Import, Convention => Intrinsic;
   function Shift_Right (N : UInt8; Amount : Natural) return UInt8
      with Import, Convention => Intrinsic;
   function Shift_Left (N : UInt16; Amount : Natural) return UInt16
      with Import, Convention => Intrinsic;
   function Shift_Right (N : UInt16; Amount : Natural) return UInt16
      with Import, Convention => Intrinsic;
   function Shift_Left (N : UInt32; Amount : Natural) return UInt32
      with Import, Convention => Intrinsic;
   function Shift_Right (N : UInt32; Amount : Natural) return UInt32
      with Import, Convention => Intrinsic;
   function Shift_Left (N : UInt64; Amount : Natural) return UInt64
      with Import, Convention => Intrinsic;
   function Shift_Right (N : UInt64; Amount : Natural) return UInt64
      with Import, Convention => Intrinsic;

   type UInt8_Array is array (Natural range <>) of UInt8
      with Component_Size => 8;

   RSTCTL_RESET  : constant UInt32 := 16#B100_0003#;
   PWREN_ENABLE  : constant UInt32 := 16#2600_0001#;
   PWREN_DISABLE : constant UInt32 := 16#2600_0000#;

   type CLKSEL_SEL_Field is (NOCLK, LFCLK, MFCLK, BUSCLK)
      with Size => 3;
   for CLKSEL_SEL_Field use
      (NOCLK  => 2#000#,
       LFCLK  => 2#001#,
       MFCLK  => 2#010#,
       BUSCLK => 2#100#);

   type CLKSEL_Register is record
      SEL : CLKSEL_SEL_Field := NOCLK;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CLKSEL_Register use record
      SEL at 0 range 1 .. 3;
   end record;

   type CLKDIV_Register is record
      RATIO : UInt3;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CLKDIV_Register use record
      RATIO at 0 range 0 .. 2;
   end record;

   type PDBGCTL_Register is record
      SOFT : Boolean := True;
      FREE : Boolean := True;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for PDBGCTL_Register use record
      SOFT at 0 range 1 .. 1;
      FREE at 0 range 0 .. 0;
   end record;

end MSPM0;
