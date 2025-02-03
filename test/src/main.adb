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
with MSPM0.WWDT;

procedure Main is
   PASS_LED : constant := 27;
   FAIL_LED : constant := 26;
   LED_Mask : constant MSPM0.GPIO.GPIO_Bit_Array :=
      (PASS_LED => True, FAIL_LED => True, others => False);
   PASS_LED_Mux : constant := Mux.PB27;
   FAIL_LED_Mux : constant := Mux.PB26;
begin
   WWDT0.RSTCTL := MSPM0.RSTCTL_RESET;
   WWDT0.PWREN := MSPM0.PWREN_ENABLE;
   WWDT0.CNTRST := MSPM0.WWDT.CNTRST_RESTART;
   WWDT0.CTL0 :=
      (KEY     => 16#C9#,
       STISM   => False,   --  Run in Sleep mode
       MODE    => False,   --  Error on watchdog timeout
       WINDOW1 => 0,       --  no closed window period
       WINDOW0 => 0,
       PER     => 3,       --  Count is 32768 (8 second window)
       CLKDIV  => 7);      --  32768 / 8 = 4096

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

   --  Enable ROSC trim
   SYSCTL.SYSOSCFCLCTL :=
      (KEY         => 16#2A#,
       SETUSEEXRES => True,
       SETUSEFCL   => True);

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
         WWDT0.CNTRST := MSPM0.WWDT.CNTRST_RESTART;
         T := T + Milliseconds (1_000);
         Delay_Until (T);
      end loop;
   end;
end Main;
