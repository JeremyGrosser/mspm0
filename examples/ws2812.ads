--
--  Copyright (C) 2025 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
--  Driver for a chain of WS2812B RGB LED modules. Uses a TIMG module and DMA.
--  TIMG CCVAL sets the duration of a bit pulse.
--  On TIMG LOAD, event group 0 triggers DMA to write the next CCVAL.
--  DMA is triggered once for each of 24 bits per LED.
--  After LED_Count * 24 bits are transferred, the DMA transfer is complete and triggers a CPU interrupt.
--  The CPU interrupt stops the TIMG counter and sets the counter value to 0,
--   forcing the output low during idle periods.
--
with MSPM0; use MSPM0;

package WS2812 is
   type RGB is record
      R, G, B : UInt8 := 0;
   end record;

   LED_Count : constant := 30;
   type LED_Index is mod LED_Count + 1;

   procedure Initialize;

   procedure Set_Color
      (LED   : LED_Index;
       Color : RGB);

   procedure Update;

   procedure DMA_IRQHandler
      with Export, Convention => C, External_Name => "DMA_IRQHandler";
end WS2812;
