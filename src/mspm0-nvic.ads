--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package MSPM0.NVIC
   with Preelaborate
is
   type IRQ is range 0 .. 31;

   procedure Enable
      (Interrupt : IRQ);

   procedure Disable
      (Interrupt : IRQ);

   procedure Clear_Pending
      (Interrupt : IRQ);

   procedure Wait_For_Interrupt;

   procedure Enable_All;
   procedure Disable_All;

end MSPM0.NVIC;
