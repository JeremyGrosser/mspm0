--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with System;

with MSPM0.SYSCTL;
with MSPM0.GPIO;
with MSPM0.MATHACL;
with MSPM0.I2C;
with MSPM0.UART;
with MSPM0.TIM;

package MSPM0.G3507
   with Preelaborate
is
   SYSCTL : MSPM0.SYSCTL.SYSCTL_Peripheral
      with Import, Address => System'To_Address (16#400A_F000#);
   PA : MSPM0.GPIO.GPIO_Peripheral
      with Import, Address => System'To_Address (16#400A_0000#);
   PB : MSPM0.GPIO.GPIO_Peripheral
      with Import, Address => System'To_Address (16#400A_2000#);
   MATHACL : MSPM0.MATHACL.MATHACL_Peripheral
      with Import, Address => System'To_Address (16#4041_0000#);
   PINCM : MSPM0.GPIO.PINCM_Array
      with Import, Address => System'To_Address (16#4042_8004#);

   I2C_0 : MSPM0.I2C.I2C_Peripheral
      with Import, Address => System'To_Address (16#400F_0000#);
   I2C_1 : MSPM0.I2C.I2C_Peripheral
      with Import, Address => System'To_Address (16#400F_2000#);

   UART_0 : MSPM0.UART.UART_Peripheral
      with Import, Address => System'To_Address (16#4010_8000#);
   UART_1 : MSPM0.UART.UART_Peripheral
      with Import, Address => System'To_Address (16#4010_0000#);
   UART_2 : MSPM0.UART.UART_Peripheral
      with Import, Address => System'To_Address (16#4010_2000#);

   TIMG0 : MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4008_4000#);
   TIMG8 : MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4009_0000#);
   TIMA0 : MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4086_0000#);
   TIMA1 : MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4086_2000#);
   TIMG6 : MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4086_8000#);
   TIMG7 : MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4086_A000#);
   TIMG12 : MSPM0.TIM.TIM_Peripheral
      with Import, Address => System'To_Address (16#4087_0000#);

   FACTORY_SYSPLLPARAM0_48M : UInt32
      with Import, Address => System'To_Address (16#41C4_0034#);
   FACTORY_SYSPLLPARAM1_48M : UInt32
      with Import, Address => System'To_Address (16#41C4_0038#);

   package Mux is
      PA0 : constant := 1;
      PA1 : constant := 2;
      PA2 : constant := 7;
      PA3 : constant := 8;
      PA4 : constant := 9;
      PA5 : constant := 10;
      PA6 : constant := 11;
      PA7 : constant := 14;
      PA8 : constant := 19;
      PA9 : constant := 20;
      PA10 : constant := 21;
      PA11 : constant := 22;
      PA12 : constant := 34;
      PA13 : constant := 35;
      PA14 : constant := 36;
      PA15 : constant := 37;
      PA16 : constant := 38;
      PA17 : constant := 39;
      PA18 : constant := 40;
      PA19 : constant := 41;
      PA20 : constant := 42;
      PA21 : constant := 46;
      PA22 : constant := 47;
      PA23 : constant := 53;
      PA24 : constant := 54;
      PA25 : constant := 55;
      PA26 : constant := 59;
      PA27 : constant := 60;
      PA28 : constant := 3;
      PA29 : constant := 4;
      PA30 : constant := 5;
      PA31 : constant := 6;

      PB0 : constant := 12;
      PB1 : constant := 13;
      PB2 : constant := 15;
      PB3 : constant := 16;
      PB4 : constant := 17;
      PB5 : constant := 18;
      PB6 : constant := 23;
      PB7 : constant := 24;
      PB8 : constant := 25;
      PB9 : constant := 26;
      PB10 : constant := 27;
      PB11 : constant := 28;
      PB12 : constant := 29;
      PB13 : constant := 30;
      PB14 : constant := 31;
      PB15 : constant := 32;
      PB16 : constant := 33;
      PB17 : constant := 43;
      PB18 : constant := 44;
      PB19 : constant := 45;
      PB20 : constant := 48;
      PB21 : constant := 49;
      PB22 : constant := 50;
      PB23 : constant := 51;
      PB24 : constant := 52;
      PB25 : constant := 56;
      PB26 : constant := 57;
      PB27 : constant := 58;
   end Mux;
end MSPM0.G3507;
