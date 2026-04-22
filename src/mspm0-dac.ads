--
--  Copyright (C) 2026 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package MSPM0.DAC
   with Pure
is

   type DAC_Peripheral is record
      PWREN : UInt32;
      RSTCTL : UInt32;
   end record;

   for DAC_Peripheral use record
      PWREN  at 16#800# range 0 .. 31;
      RSTCTL at 16#804# range 0 .. 31;
   end record;

end MSPM0.DAC;
