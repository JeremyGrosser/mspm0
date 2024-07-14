--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package MSPM0.GPIO
   with Pure
is
   type GPIO_Byte_Array is array (0 .. 31) of Boolean
      with Component_Size => 8;

   type GPIO_Bit_Array is array (0 .. 31) of Boolean
      with Component_Size => 1;

   type GPIO_Peripheral is record
      PWREN    : UInt32;
      RSTCTL   : UInt32;
      DOUTB    : GPIO_Byte_Array;
      DOUT     : GPIO_Bit_Array;
      DOUTSET  : GPIO_Bit_Array;
      DOUTCLR  : GPIO_Bit_Array;
      DOUTTGL  : GPIO_Bit_Array;
      DOE      : GPIO_Bit_Array;
      DOESET   : GPIO_Bit_Array;
      DOECLR   : GPIO_Bit_Array;
      DINB     : GPIO_Byte_Array;
   end record
      with Volatile, Effective_Writes, Async_Readers;

   for GPIO_Peripheral use record
      PWREN    at 16#0800# range 0 .. 31;
      RSTCTL   at 16#0804# range 0 .. 31;
      DOUTB    at 16#1200# range 0 .. 255;
      DOUT     at 16#1280# range 0 .. 31;
      DOUTSET  at 16#1290# range 0 .. 31;
      DOUTCLR  at 16#12A0# range 0 .. 31;
      DOUTTGL  at 16#12B0# range 0 .. 31;
      DOE      at 16#12C0# range 0 .. 31;
      DOESET   at 16#12D0# range 0 .. 31;
      DOECLR   at 16#12E0# range 0 .. 31;
      DINB     at 16#1300# range 0 .. 255;
   end record;

   type PINCM_Register is record
      WCOMP    : Boolean := False;
      WUEN     : Boolean := False;
      INV      : Boolean := False;
      HIZ1     : Boolean := False;
      DRV      : Boolean := False;
      HYSTEN   : Boolean := False;
      INENA    : Boolean := False;
      PIPU     : Boolean := False;
      PIPD     : Boolean := False;
      WAKESTAT : Boolean := False;
      PC       : Boolean := False;
      PF       : UInt6 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for PINCM_Register use record
      WCOMP    at 0 range 28 .. 28;
      WUEN     at 0 range 27 .. 27;
      INV      at 0 range 26 .. 26;
      HIZ1     at 0 range 25 .. 25;
      DRV      at 0 range 20 .. 20;
      HYSTEN   at 0 range 19 .. 19;
      INENA    at 0 range 18 .. 18;
      PIPU     at 0 range 17 .. 17;
      PIPD     at 0 range 16 .. 16;
      WAKESTAT at 0 range 13 .. 13;
      PC       at 0 range 7 .. 7;
      PF       at 0 range 0 .. 5;
   end record;

   type PINCM_Index is range 1 .. 250;
   type PINCM_Array is array (PINCM_Index) of PINCM_Register
      with Volatile,
           Component_Size => 32,
           Object_Size => 32 * 250;
end MSPM0.GPIO;
