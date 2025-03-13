--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with System.Machine_Code;
with System;

package body MSPM0.NVIC is
   pragma Suppress (All_Checks);

   type Interrupt_Mask is array (IRQ) of Boolean
      with Component_Size => 1, Size => 32;

   ISER : Interrupt_Mask
      with Import, Address => System'To_Address (16#E000_E100#);
   ICPR : Interrupt_Mask
      with Import, Address => System'To_Address (16#E000_E280#);

   procedure Enable
      (Interrupt : IRQ)
   is
   begin
      ISER (Interrupt) := True;
   end Enable;

   procedure Disable
      (Interrupt : IRQ)
   is
   begin
      ISER (Interrupt) := False;
   end Disable;

   procedure Clear_Pending
      (Interrupt : IRQ)
   is
   begin
      ICPR (Interrupt) := True;
   end Clear_Pending;

   procedure Wait_For_Interrupt is
   begin
      System.Machine_Code.Asm ("wfi", Volatile => True);
   end Wait_For_Interrupt;

   procedure Enable_All is
   begin
      System.Machine_Code.Asm ("cpsie i", Volatile => True);
   end Enable_All;

   procedure Disable_All is
   begin
      System.Machine_Code.Asm ("cpsid i", Volatile => True);
   end Disable_All;
end MSPM0.NVIC;
