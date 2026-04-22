--
--  Copyright (C) 2026 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with System;

with MSPM0.COMP;
with MSPM0.VREF;
with MSPM0.WWDT;
with MSPM0.TIM;
with MSPM0.GPIO;
with MSPM0.SYSCTL;
with MSPM0.I2C;
with MSPM0.UART;
with MSPM0.CPUSS;
with MSPM0.DMA;
with MSPM0.SPI;
with MSPM0.ADC;
with MSPM0.SCB;

package MSPM0.C1106
   with Preelaborate
is
   COMP0 : aliased MSPM0.COMP.COMP_Peripheral
      with Import, Address => System'To_Address (16#4000_8000#);
   VREF  : aliased MSPM0.VREF.VREF_Peripheral
      with Import, Address => System'To_Address (16#4003_0000#);
   WWDT0 : aliased MSPM0.WWDT.WWDT_Peripheral
      with Import, Address => System'To_Address (16#4008_0000#);
   TIMG14 : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4008_4000#);
   TIMG1  : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4008_6000#);
   TIMG2  : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4008_8000#);
   TIMG8  : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4009_0000#);
   --  LFSS       4009_4000
   --  RTC_B      4009_4000
   --  IWDT       4009_4000
   PA    : aliased MSPM0.GPIO.GPIO_Peripheral
      with Import, Address => System'To_Address (16#400A_0000#);
   PB    : aliased MSPM0.GPIO.GPIO_Peripheral
      with Import, Address => System'To_Address (16#400A_2000#);
   SYSCTL : aliased MSPM0.SYSCTL.SYSCTL_Peripheral
      with Import, Address => System'To_Address (16#400A_F000#);
   --  DEBUGSS    400C_7000
   --  EVENTLP    400C_9000
   --  FLASHCTL   4042_A000
   I2C0  : aliased MSPM0.I2C.I2C_Peripheral
      with Import, Address => System'To_Address (16#4044_0000#);
   I2C1  : aliased MSPM0.I2C.I2C_Peripheral
      with Import, Address => System'To_Address (16#400C_D000#);
   UART1 : aliased MSPM0.UART.UART_Peripheral
      with Import, Address => System'To_Address (16#400F_0000#);
   UART2 : aliased MSPM0.UART.UART_Peripheral
      with Import, Address => System'To_Address (16#400F_2000#);
   UART0 : aliased MSPM0.UART.UART_Peripheral
      with Import, Address => System'To_Address (16#4010_0000#);
   CPUSS : aliased MSPM0.CPUSS.CPUSS_Peripheral
      with Import, Address => System'To_Address (16#4040_0000#);
   --  WUC        4010_8000
   PINCM : aliased MSPM0.GPIO.PINCM_Array
      with Import, Address => System'To_Address (16#4040_0000#);
   DMA   : aliased MSPM0.DMA.DMA_Peripheral
      with Import, Address => System'To_Address (16#4042_A000#);
   --  CRC        4042_8000
   SPI0  : aliased MSPM0.SPI.SPI_Peripheral
      with Import, Address => System'To_Address (16#4046_8000#);
   ADC0_SVT : aliased MSPM0.ADC.ADC_Peripheral
      with Import, Address => System'To_Address (16#4055_A000#);
   TIMA0 : aliased MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4086_0000#);

   SCB   : aliased MSPM0.SCB.SCB_Peripheral
      with Import, Address => System'To_Address (16#E000_ED00#);

   package Mux is
      PA0   : constant := 1;
      PA1   : constant := 2;
      PA2   : constant := 5;
      PA3   : constant := 6;
      PA4   : constant := 7;
      PA5   : constant := 8;
      PA6   : constant := 9;
      PA7   : constant := 10;
      PA8   : constant := 13;
      PA9   : constant := 14;
      PA10  : constant := 15;
      PA11  : constant := 16;
      PA12  : constant := 24;
      PA13  : constant := 25;
      PA14  : constant := 26;
      PA15  : constant := 27;
      PA16  : constant := 28;
      PA17  : constant := 29;
      PA18  : constant := 30;
      PA19  : constant := 32;
      PA20  : constant := 33;
      PA21  : constant := 37;
      PA22  : constant := 38;
      PA23  : constant := 41;
      PA24  : constant := 42;
      PA25  : constant := 43;
      PA26  : constant := 44;
      PA27  : constant := 45;
      PA28  : constant := 3;
      PA29  : constant := 31;
      PA30  : constant := 46;
      PA31  : constant := 4;
      PB2   : constant := 11;
      PB3   : constant := 12;
      PB6   : constant := 17;
      PB7   : constant := 18;
      PB8   : constant := 19;
      PB9   : constant := 20;
      PB14  : constant := 21;
      PB15  : constant := 22;
      PB16  : constant := 23;
      PB17  : constant := 34;
      PB18  : constant := 35;
      PB19  : constant := 36;
      PB20  : constant := 39;
      PB24  : constant := 40;
   end Mux;

   package IRQ is
      SYSCTL   : constant := 0;
      DEBUGSS  : constant := 1;
      TIMG8    : constant := 2;
      UART1    : constant := 3;
      ADC0     : constant := 4;
      COMP0    : constant := 7;
      UART2    : constant := 8;
      SPI0     : constant := 9;
      UART0    : constant := 15;
      TIMG14   : constant := 16;
      TIMG2    : constant := 17;
      TIMA0    : constant := 18;
      TIMG1    : constant := 19;
      GPIOA    : constant := 22;
      GPIOB    : constant := 23;
      I2C0     : constant := 24;
      I2C1     : constant := 25;
      FLASHCTL : constant := 27;
      WWDT0    : constant := 29;
      LFSS     : constant := 30;
      RTC_B    : constant := 30;
      IWDT     : constant := 30;
      DMA      : constant := 31;
   end IRQ;
end MSPM0.C1106;
