--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package MSPM0.SysTick
   with Preelaborate
is
   CPU_Frequency     : constant := 32_000_000;
   Ticks_Per_Second  : constant := 1_000;
   Cycles_Per_Tick   : constant := CPU_Frequency / Ticks_Per_Second;

   type Time is mod 2 ** 32;

   function Clock
      return Time;

   function Milliseconds
      (Ms : Natural)
      return Time;

   procedure Delay_Until
      (T : Time);

   procedure Enable;

   procedure Disable;

end MSPM0.SysTick;
