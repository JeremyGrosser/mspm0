--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with MSPM0; use MSPM0;

package Console
   with Preelaborate
is

   procedure Initialize;

   procedure Put
      (Data : UInt8);

   procedure Put
      (Ch : Character);

   procedure Put
      (Str : String);

   procedure New_Line;

   procedure Put_Line
      (Line : String);

   procedure Data_Ready
      (Ready : out Boolean);

   procedure Get
      (Ch : out Character);

end Console;
