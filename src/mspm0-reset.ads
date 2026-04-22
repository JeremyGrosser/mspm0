--
--  Copyright (C) 2026 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with System;

package MSPM0.Reset
   with Preelaborate
is
   procedure Reset_Peripheral
      (Base : System.Address);
end MSPM0.Reset;
