--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with System.Machine_Code;
with System;

package body MSPM0.NVIC is

   type Interrupt_Mask is array (IRQ) of Boolean
      with Component_Size => 1, Size => 32;

   procedure Enable
      (Interrupt : IRQ)
   is
      ISER : Interrupt_Mask
         with Import, Address => System'To_Address (16#E000_E100#);
   begin
      ISER (Interrupt) := True;
   end Enable;

   procedure Disable
      (Interrupt : IRQ)
   is
      ISER : Interrupt_Mask
         with Import, Address => System'To_Address (16#E000_E100#);
   begin
      ISER (Interrupt) := False;
   end Disable;

   procedure Clear_Pending
      (Interrupt : IRQ)
   is
      ICPR : Interrupt_Mask
         with Import, Address => System'To_Address (16#E000_E280#);
   begin
      ICPR (Interrupt) := True;
   end Clear_Pending;

   procedure Wait_For_Interrupt is
   begin
      System.Machine_Code.Asm ("wfi", Volatile => True);
   end Wait_For_Interrupt;

end MSPM0.NVIC;
