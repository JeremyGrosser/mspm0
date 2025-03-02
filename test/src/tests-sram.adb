--
--  Copyright (C) 2025 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with System.Machine_Code;
with System;

package body Tests.SRAM is
   SRAM_BASE : constant := 16#2000_0000#; --  ECC bypass alias
   SRAM_SIZE : constant := 4096;

   type UInt32 is mod 2 ** 32 with Size => 32;
   type UInt32_Array is array (Positive range <>) of UInt32
      with Component_Size => 32;

   SRAM : UInt32_Array (1 .. SRAM_SIZE / 4)
      with Import, Volatile, Address => System'To_Address (SRAM_BASE);

   Patterns : constant UInt32_Array :=
      (16#0000_0000#,
       16#5555_5555#,
       16#AAAA_AAAA#,
       16#FFFF_FFFF#,
       16#7FFF_FFFF#,
       16#0000_0001#,
       16#3FFF_FFFF#,
       16#0000_0000#);

   --  Wait a few microseconds to test SRAM retention
   procedure Wait is
   begin
      for I in 1 .. 32 loop
         System.Machine_Code.Asm ("nop", Volatile => True);
      end loop;
   end Wait;

   procedure Run
      (Result : out Test_Result)
   is
      use type System.Address;
      Save, Tmp : UInt32
         with Volatile;
   begin
      Result := Fail;
      for I in SRAM'Range loop
         if SRAM (I)'Address /= Tmp'Address and then
            SRAM (I)'Address /= Save'Address
         then
            Save := SRAM (I);
            for Pattern of Patterns loop
               SRAM (I) := Pattern;
               Wait;
               Tmp := SRAM (I);
               if Tmp /= Pattern then
                  SRAM (I) := Save;
                  return;
               end if;
            end loop;
            SRAM (I) := Save;
         end if;
      end loop;
      Result := Pass;
   end Run;
end Tests.SRAM;
