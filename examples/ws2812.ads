--
--  Copyright (C) 2025 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
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
