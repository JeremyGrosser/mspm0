--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with System.Machine_Code;
with System;

package body MSPM0.SysTick is

   type UInt24 is mod 2 ** 24 with Size => 24;
   type UInt32 is mod 2 ** 32 with Size => 32;

   type SYST_CSR_Register is record
      COUNTFLAG : Boolean;
      CLKSOURCE : Boolean;
      TICKINT   : Boolean;
      ENABLE    : Boolean;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for SYST_CSR_Register use record
      COUNTFLAG   at 0 range 16 .. 16;
      CLKSOURCE   at 0 range 2 .. 2;
      TICKINT     at 0 range 1 .. 1;
      ENABLE      at 0 range 0 .. 0;
   end record;

   type SYST_Value_Register is record
      VALUE : UInt24;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for SYST_Value_Register use record
      VALUE at 0 range 0 .. 23;
   end record;

   type SYST_Peripheral is record
      CSR : SYST_CSR_Register;
      RVR : SYST_Value_Register;
      CVR : SYST_Value_Register;
   end record
      with Volatile;
   for SYST_Peripheral use record
      CSR at 16#10# range 0 .. 31;
      RVR at 16#14# range 0 .. 31;
      CVR at 16#18# range 0 .. 31;
   end record;

   SYST : SYST_Peripheral
      with Import, Address => System'To_Address (16#E000_E000#);

   SCB_ICSR_PENDSTCLR : constant UInt32 := 16#0200_0000#;

   SCB_ICSR : UInt32
      with Import, Address => System'To_Address (16#E000_ED04#);

   Ticks : Time := 0
      with Volatile, Atomic;

   function Clock
      return Time
   is
      pragma SPARK_Mode (Off);
   begin
      return Ticks;
   end Clock;

   procedure Delay_Until
      (T : Time)
   is
      pragma SPARK_Mode (Off);
      Now : Time;
   begin
      loop
         Now := Ticks;
         exit when Now >= T;
         System.Machine_Code.Asm ("dsb", Volatile => True);
         System.Machine_Code.Asm ("isb", Volatile => True);
         System.Machine_Code.Asm ("wfi", Volatile => True);
      end loop;
   end Delay_Until;

   procedure SysTick_Handler
      with Export, Convention => C, External_Name => "SysTick_Handler";

   procedure SysTick_Handler is
      pragma SPARK_Mode (Off);
   begin
      Ticks := Ticks + 1;
      SCB_ICSR := SCB_ICSR_PENDSTCLR;
   end SysTick_Handler;

   procedure Enable is
   begin
      SYST.CSR.ENABLE := False;
      SYST.CSR.CLKSOURCE := True; --  Reference clock
      SYST.RVR.VALUE := UInt24 (Cycles_Per_Tick);
      SYST.CVR.VALUE := 0;
      SYST.CSR.TICKINT := True;
      SYST.CSR.ENABLE := True;
   end Enable;

   procedure Disable is
   begin
      SYST.CSR.TICKINT := False;
      SYST.CSR.ENABLE := False;
      SYST.CVR.VALUE := 0;
   end Disable;

   function Milliseconds
      (Ms : Natural)
      return Time
   is (Time (Ms));

end MSPM0.SysTick;
