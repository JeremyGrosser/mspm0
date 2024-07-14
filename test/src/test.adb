--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with MSPM0.SysTick; use MSPM0.SysTick;
with MSPM0.Device; use MSPM0.Device;
with MSPM0;

with Console;

procedure Test is
   T : Time;
begin
   --  Reset and enable I/O Port A
   PA.RSTCTL := MSPM0.RSTCTL_RESET;
   PA.PWREN := MSPM0.PWREN_ENABLE;

   --  PA0 LED
   PA.DOESET (0) := True;  --  Output enable

   PINCM (Mux.PA0) :=
      (WCOMP      => False,   --  Wakeup Compare Value
       WUEN       => False,   --  Wakeup Enable
       INV        => False,   --  Invert
       HIZ1       => False,   --  HI-Z on high output (open-drain)
       DRV        => False,   --  Drive strength
       HYSTEN     => False,   --  Hysteresis Control
       INENA      => False,   --  Input enable
       PIPU       => False,   --  Pull up
       PIPD       => False,   --  Pull down
       WAKESTAT   => False,   --  Wakeup status (read only)
       PC         => True,    --  Pin connected
       PF         => 1);      --  Pin function (GPIO)
   --  Only PC and PF are changed from reset values here, but we generate
   --  smaller code by avoiding the use of "others", which allows GCC to
   --  precompute a static 32-bit value.

   Console.Initialize;
   Console.New_Line;
   Console.Put_Line ("MSPM0 test console!");

   MSPM0.SysTick.Enable;
   T := Clock;
   loop
      PA.DOUTTGL (0) := True;
      T := T + Milliseconds (250);
      Delay_Until (T);
   end loop;
end Test;
