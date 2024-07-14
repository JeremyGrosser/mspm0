--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package MSPM0.NVIC
   with Pure
is
   type IRQ is range 0 .. 31;

   INT_GROUP0_IRQ : constant IRQ := 0;
   INT_GROUP1_IRQ : constant IRQ := 1;
   TIMG8_IRQ      : constant IRQ := 2;
   UART3_IRQ      : constant IRQ := 3;
   ADC0_IRQ       : constant IRQ := 4;
   ADC1_IRQ       : constant IRQ := 5;
   CANFD0_IRQ     : constant IRQ := 6;
   DAC0_IRQ       : constant IRQ := 7;
   SPI0_IRQ       : constant IRQ := 9;
   SPI1_IRQ       : constant IRQ := 10;
   UART1_IRQ      : constant IRQ := 13;
   UART2_IRQ      : constant IRQ := 14;
   UART0_IRQ      : constant IRQ := 15;
   TIMG0_IRQ      : constant IRQ := 16;
   TIMG6_IRQ      : constant IRQ := 17;
   TIMA0_IRQ      : constant IRQ := 18;
   TIMA1_IRQ      : constant IRQ := 19;
   TIMG7_IRQ      : constant IRQ := 20;
   TIMG12_IRQ     : constant IRQ := 21;
   I2C0_IRQ       : constant IRQ := 24;
   I2C1_IRQ       : constant IRQ := 25;
   AES_IRQ        : constant IRQ := 28;
   RTC_IRQ        : constant IRQ := 29;
   DMA_IRQ        : constant IRQ := 30;

   procedure Enable
      (Interrupt : IRQ);

   procedure Disable
      (Interrupt : IRQ);

   procedure Clear_Pending
      (Interrupt : IRQ);

   procedure Wait_For_Interrupt;

end MSPM0.NVIC;
