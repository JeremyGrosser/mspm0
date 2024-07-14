--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");

package MSPM0.I2C
   with Pure
is

   type MSA_Register is record
      MMODE : Boolean := False;
      SADDR : UInt9 := 0;
      DIR   : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for MSA_Register use record
      MMODE at 0 range 15 .. 15;
      SADDR at 0 range 1 .. 10;
      DIR   at 0 range 0 .. 0;
   end record;

   type MCTR_Register is record
      MBLEN          : UInt12 := 0;
      RD_ON_TXEMPTY  : Boolean := False;
      MACKOEN        : Boolean := False;
      ACK            : Boolean := False;
      STOP           : Boolean := False;
      START          : Boolean := False;
      BURSTRUN       : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for MCTR_Register use record
      MBLEN          at 0 range 16 .. 27;
      RD_ON_TXEMPTY  at 0 range 5 .. 5;
      MACKOEN        at 0 range 4 .. 4;
      ACK            at 0 range 3 .. 3;
      STOP           at 0 range 2 .. 2;
      START          at 0 range 1 .. 1;
      BURSTRUN       at 0 range 0 .. 0;
   end record;

   type MSR_Register is record
      MBCNT    : UInt12 := 0;
      BUSBSY   : Boolean := False;
      IDLE     : Boolean := False;
      ARBLST   : Boolean := False;
      DATACK   : Boolean := False;
      ADRACK   : Boolean := False;
      ERR      : Boolean := False;
      BUSY     : Boolean := False;
   end record
      with Volatile_Full_Access, Async_Readers, Async_Writers, Object_Size => 32;
   for MSR_Register use record
      MBCNT    at 0 range 16 .. 27;
      BUSBSY   at 0 range 6 .. 6;
      IDLE     at 0 range 5 .. 5;
      ARBLST   at 0 range 4 .. 4;
      DATACK   at 0 range 3 .. 3;
      ADRACK   at 0 range 2 .. 2;
      ERR      at 0 range 1 .. 1;
      BUSY     at 0 range 0 .. 0;
   end record;

   type MRXDATA_Register is record
      VALUE : UInt8 := 0;
   end record
      with Volatile_Full_Access, Async_Writers, Object_Size => 32;
   for MRXDATA_Register use record
      VALUE at 0 range 0 .. 7;
   end record;

   type MTXDATA_Register is record
      VALUE : UInt8 := 0;
   end record
      with Volatile, Effective_Writes, Async_Readers, Object_Size => 32;
   for MTXDATA_Register use record
      VALUE at 0 range 0 .. 7;
   end record;

   type MTPR_Register is record
      TPR : UInt7 := 1;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for MTPR_Register use record
      TPR at 0 range 0 .. 6;
   end record;

   type MCR_Register is record
      LPBK        : Boolean := False;
      CLKSTRETCH  : Boolean := False;
      MMST        : Boolean := False;
      ACTIVE      : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for MCR_Register use record
      LPBK        at 0 range 8 .. 8;
      CLKSTRETCH  at 0 range 2 .. 2;
      MMST        at 0 range 1 .. 1;
      ACTIVE      at 0 range 0 .. 0;
   end record;

   type MFIFOCTL_Register is record
      RXFLUSH  : Boolean;
      RXTRIG   : UInt3;
      TXFLUSH  : Boolean;
      TXTRIG   : UInt3;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for MFIFOCTL_Register use record
      RXFLUSH  at 0 range 15 .. 15;
      RXTRIG   at 0 range 8 .. 10;
      TXFLUSH  at 0 range 7 .. 7;
      TXTRIG   at 0 range 0 .. 2;
   end record;

   type MFIFOSR_Register is record
      TXFLUSH     : Boolean;
      TXFIFOCNT   : UInt4;
      RXFLUSH     : Boolean;
      RXFIFOCNT   : UInt4;
   end record
      with Volatile_Full_Access, Async_Writers, Object_Size => 32;
   for MFIFOSR_Register use record
      TXFLUSH     at 0 range 15 .. 15;
      TXFIFOCNT   at 0 range 8 .. 11;
      RXFLUSH     at 0 range 7 .. 7;
      RXFIFOCNT   at 0 range 0 .. 3;
   end record;

   type I2C_Peripheral is record
      PWREN    : UInt32;
      RSTCTL   : UInt32;
      CLKDIV   : CLKDIV_Register;
      CLKSEL   : CLKSEL_Register;
      PDBGCTL  : PDBGCTL_Register;
      MSA      : MSA_Register;
      MCTR     : MCTR_Register;
      MSR      : MSR_Register;
      MRXDATA  : MRXDATA_Register;
      MTXDATA  : MTXDATA_Register;
      MTPR     : MTPR_Register;
      MCR      : MCR_Register;
      MFIFOCTL : MFIFOCTL_Register;
      MFIFOSR  : MFIFOSR_Register;
   end record
      with Volatile;

   for I2C_Peripheral use record
      PWREN    at 16#0800# range 0 .. 31;
      RSTCTL   at 16#0804# range 0 .. 31;
      CLKDIV   at 16#1000# range 0 .. 31;
      CLKSEL   at 16#1004# range 0 .. 31;
      PDBGCTL  at 16#1018# range 0 .. 31;
      MSA      at 16#1210# range 0 .. 31;
      MCTR     at 16#1214# range 0 .. 31;
      MSR      at 16#1218# range 0 .. 31;
      MRXDATA  at 16#121C# range 0 .. 31;
      MTXDATA  at 16#1220# range 0 .. 31;
      MTPR     at 16#1224# range 0 .. 31;
      MCR      at 16#1228# range 0 .. 31;
      MFIFOCTL at 16#1238# range 0 .. 31;
      MFIFOSR  at 16#123C# range 0 .. 31;
   end record;

end MSPM0.I2C;
