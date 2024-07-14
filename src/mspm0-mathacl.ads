--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package MSPM0.MATHACL
   with Pure
is
   type CTL_FUNC_Field is
      (NOOP, SINCOS, ATAN2, DIV, SQRT, MUL32, SQ32, MUL64, MAC, SAC)
   with Size => 5;

   for CTL_FUNC_Field use
      (NOOP    => 16#00#,
       SINCOS  => 16#01#,
       ATAN2   => 16#02#,
       DIV     => 16#04#,
       SQRT    => 16#05#,
       MUL32   => 16#06#,
       SQ32    => 16#07#,
       MUL64   => 16#08#,
       MAC     => 16#0A#,
       SAC     => 16#0B#);

   type CTL_OPTYPE_Field is (Unsigned, Signed)
      with Size => 1;

   type CTL_Register is record
      NUMITER  : UInt5;
      SATEN    : Boolean;
      SFACTOR  : UInt6;
      QVAL     : UInt5;
      OPTYPE   : CTL_OPTYPE_Field;
      FUNC     : CTL_FUNC_Field;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CTL_Register use record
      NUMITER  at 0 range 24 .. 28;
      SATEN    at 0 range 22 .. 22;
      SFACTOR  at 0 range 16 .. 21;
      QVAL     at 0 range 8 .. 12;
      OPTYPE   at 0 range 5 .. 5;
      FUNC     at 0 range 0 .. 4;
   end record;

   type STATUS_Register is record
      BUSY : Boolean;
      ERR  : UInt2;
      OVF  : Boolean;
      UF   : Boolean;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for STATUS_Register use record
      BUSY  at 0 range 8 .. 8;
      ERR   at 0 range 2 .. 3;
      OVF   at 0 range 1 .. 1;
      UF    at 0 range 0 .. 0;
   end record;

   type MATHACL_Peripheral is record
      PWREN       : UInt32;
      RSTCTL      : UInt32;
      CTL         : CTL_Register;
      OP2         : UInt32;
      OP1         : UInt32;
      RES1        : UInt32;
      RES2        : UInt32;
      STATUS      : STATUS_Register;
      STATUSCLR   : STATUS_Register;
   end record
      with Volatile;

   for MATHACL_Peripheral use record
      PWREN       at 16#0800# range 0 .. 31;
      RSTCTL      at 16#0804# range 0 .. 31;
      CTL         at 16#1100# range 0 .. 31;
      OP2         at 16#1118# range 0 .. 31;
      OP1         at 16#111C# range 0 .. 31;
      RES1        at 16#1120# range 0 .. 31;
      RES2        at 16#1124# range 0 .. 31;
      STATUS      at 16#1130# range 0 .. 31;
      STATUSCLR   at 16#1140# range 0 .. 31;
   end record;
end MSPM0.MATHACL;
