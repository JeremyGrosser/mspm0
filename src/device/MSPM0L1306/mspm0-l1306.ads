--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
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
with MSPM0.VREF;

package MSPM0.L1306
   with Preelaborate
is
   SYSCTL   : aliased MSPM0.SYSCTL.SYSCTL_Peripheral
      with Import, Address => System'To_Address (16#400A_F000#);
   PA       : aliased MSPM0.GPIO.GPIO_Peripheral
      with Import, Address => System'To_Address (16#400A_0000#);
   PINCM    : aliased MSPM0.GPIO.PINCM_Array
      with Import, Address => System'To_Address (16#4042_8004#);
   WWDT0    : aliased MSPM0.WWDT.WWDT_Peripheral
      with Import, Address => System'To_Address (16#4008_0000#);
   CPUSS    : aliased MSPM0.CPUSS.CPUSS_Peripheral
      with Import, Address => System'To_Address (16#4040_0000#);

   UART_0 : aliased MSPM0.UART.UART_Peripheral
      with Import, Address => System'To_Address (16#4010_8000#);
   UART_1 : aliased MSPM0.UART.UART_Peripheral
      with Import, Address => System'To_Address (16#4010_0000#);

   TIMG0 : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4008_4000#);
   TIMG1 : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4008_6000#);
   TIMG2 : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4008_8000#);
   TIMG4 : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4008_C000#);
   ADC0  : aliased MSPM0.ADC.ADC_Peripheral
      with Import, Address => System'To_Address (16#4000_4000#);
   VREF  : aliased MSPM0.VREF.VREF_Peripheral
      with Import, Address => System'To_Address (16#4003_0000#);

   package Mux is
      PA0 : constant := 1;
      PA1 : constant := 2;
      PA2 : constant := 3;
      PA3 : constant := 4;
      PA4 : constant := 5;
      PA5 : constant := 6;
      PA6 : constant := 7;
      PA7 : constant := 8;
      PA8 : constant := 9;
      PA9 : constant := 10;
      PA10 : constant := 11;
      PA11 : constant := 12;
      PA12 : constant := 13;
      PA13 : constant := 14;
      PA14 : constant := 15;
      PA15 : constant := 16;
      PA16 : constant := 17;
      PA17 : constant := 18;
      PA18 : constant := 19;
      PA19 : constant := 20;
      PA20 : constant := 21;
      PA21 : constant := 22;
      PA22 : constant := 23;
      PA23 : constant := 24;
      PA24 : constant := 25;
      PA25 : constant := 26;
      PA26 : constant := 27;
      PA27 : constant := 28;
   end Mux;

   package IRQ is
      INT_GROUP0  : constant := 0;
      INT_GROUP1  : constant := 1;
      TIMG1       : constant := 2;
      ADC         : constant := 4;
      SPI0        : constant := 9;
      UART1       : constant := 13;
      UART0       : constant := 15;
      TIMG0       : constant := 16;
      TIMG2       : constant := 18;
      TIMG4       : constant := 20;
      I2C0        : constant := 24;
      I2C1        : constant := 25;
      DMA         : constant := 31;
   end IRQ;
end MSPM0.L1306;
