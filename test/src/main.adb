--
--  Copyright (C) 2025 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with Tests.SRAM;
with Tests; use Tests;
with MSPM0.Device; use MSPM0.Device;
with MSPM0.SysTick; use MSPM0.SysTick;
with MSPM0.NVIC;
with MSPM0.GPIO;

procedure Main is
   PASS_LED : constant := 27;
   FAIL_LED : constant := 26;
   LED_Mask : constant MSPM0.GPIO.GPIO_Bit_Array :=
      (PASS_LED => True, FAIL_LED => True, others => False);
   PASS_LED_Mux : constant := Mux.PB27;
   FAIL_LED_Mux : constant := Mux.PB26;
begin
   --  Configure LED pins, FAIL on while starting
   PB.RSTCTL := MSPM0.RSTCTL_RESET;
   PB.PWREN := MSPM0.PWREN_ENABLE;
   PB.DOESET := LED_Mask;
   PB.DOUTCLR := LED_Mask;
   PB.DOUTSET := (FAIL_LED => True, others => False);
   PINCM (PASS_LED_Mux) :=
      (PC      => True,
       PF      => 1,
       others  => False);
   PINCM (FAIL_LED_Mux) :=
      (PC      => True,
       PF      => 1,
       others  => False);

   MSPM0.SysTick.Enable;

   declare
      Result : Test_Result;
   begin
      --  Disable interrupts during SRAM test- we don't want to jump to an
      --  interrupt handler while messing with memory.
      MSPM0.NVIC.Disable_All;
      Tests.SRAM.Run (Result);
      MSPM0.NVIC.Enable_All;

      if Result = Pass then
         PB.DOUTB (FAIL_LED) := False;
         PB.DOUTB (PASS_LED) := True;
      end if;
   end;

   declare
      T : Time := Clock;
   begin
      loop
         PB.DOUTB (PASS_LED) := True;
         T := T + Milliseconds (10);
         Delay_Until (T);
         PB.DOUTB (PASS_LED) := False;
         T := T + Milliseconds (200);
         Delay_Until (T);
      end loop;
   end;
end Main;
