--
--  Copyright (C) 2026 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with System;

with MSPM0.SYSCTL;
with MSPM0.WWDT;
with MSPM0.CPUSS;
with MSPM0.GPIO;
with MSPM0.UART;
with MSPM0.TIM;
with MSPM0.ADC;
with MSPM0.COMP;
with MSPM0.OPA;
with MSPM0.VREF;
with MSPM0.DMA;
with MSPM0.SCB;

package MSPM0.C1104
   with Preelaborate
is
   SYSCTL : aliased MSPM0.SYSCTL.SYSCTL_Peripheral
      with Import, Address => System'To_Address (16#400A_F000#);
   PA    : aliased MSPM0.GPIO.GPIO_Peripheral
      with Import, Address => System'To_Address (16#400A_0000#);
   PINCM : aliased MSPM0.GPIO.PINCM_Array
      with Import, Address => System'To_Address (16#4042_8004#);
   WWDT0 : aliased MSPM0.WWDT.WWDT_Peripheral
      with Import, Address => System'To_Address (16#4008_0000#);
   CPUSS : aliased MSPM0.CPUSS.CPUSS_Peripheral
      with Import, Address => System'To_Address (16#4040_0000#);
   DMA   : aliased MSPM0.DMA.DMA_Peripheral
      with Import, Address => System'To_Address (16#4042_A000#);

   UART0 : aliased MSPM0.UART.UART_Peripheral
      with Import, Address => System'To_Address (16#4010_8000#);

   TIMG14 : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4008_4000#);
   TIMG8 : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4009_0000#);
   TIMA0 : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4086_0000#);

   ADC0  : aliased MSPM0.ADC.ADC_Peripheral
      with Import, Address => System'To_Address (16#4000_4000#);

   VREF  : aliased MSPM0.VREF.VREF_Peripheral
      with Import, Address => System'To_Address (16#4003_0000#);

   SCB   : aliased MSPM0.SCB.SCB_Peripheral
      with Import, Address => System'To_Address (16#E000_ED00#);

   package Mux is
      PA0 : constant := 1;
      PA1 : constant := 2;
      PA2 : constant := 3;

      PA4 : constant := 5;

      PA6 : constant := 7;

      PA11 : constant := 12;

      PA16 : constant := 17;
      PA17 : constant := 18;
      PA18 : constant := 19;
      PA19 : constant := 20;
      PA20 : constant := 21;

      PA22 : constant := 23;
      PA23 : constant := 24;
      PA24 : constant := 25;
      PA25 : constant := 26;
      PA26 : constant := 27;
      PA27 : constant := 28;
      PA28 : constant := 29;
   end Mux;

   package IRQ is
      INT_GROUP0  : constant := 0;
      GPIO0       : constant := 1;
      TIMG8       : constant := 2;
      ADC         : constant := 4;
      SPI0        : constant := 9;
      UART0       : constant := 15;
      TIMG14      : constant := 16;
      TIMA0       : constant := 18;
      I2C0        : constant := 24;
      DMA         : constant := 31;
   end IRQ;
end MSPM0.C1104;
