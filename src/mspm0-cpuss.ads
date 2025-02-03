--
--  Copyright (C) 2025 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");

package MSPM0.CPUSS
   with Pure
is
   type INT_Register is record
      IIDX  : UInt32;
      IMASK : UInt32;
      RIS   : UInt32;
      MIS   : UInt32;
      ISET  : UInt32;
      ICLR  : UInt32;
   end record
      with Volatile, Effective_Writes, Async_Writers, Async_Readers;
   for INT_Register use record
      IIDX  at 16#00# range 0 .. 31;
      IMASK at 16#08# range 0 .. 31;
      RIS   at 16#10# range 0 .. 31;
      MIS   at 16#18# range 0 .. 31;
      ISET  at 16#20# range 0 .. 31;
      ICLR  at 16#28# range 0 .. 31;
   end record;

   type CTL_Register is record
      LITEN    : Boolean := True;
      ICACHE   : Boolean := True;
      PREFETCH : Boolean := True;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CTL_Register use record
      LITEN    at 0 range 2 .. 2;
      ICACHE   at 0 range 1 .. 1;
      PREFETCH at 0 range 0 .. 0;
   end record;

   type CPUSS_Peripheral is record
      INT_GROUP0  : INT_Register;
      INT_GROUP1  : INT_Register;
      INT_GROUP2  : INT_Register;
      INT_GROUP3  : INT_Register;
      INT_GROUP4  : INT_Register;
      CTL         : CTL_Register;
   end record
      with Volatile, Effective_Writes, Async_Readers, Async_Writers;
   for CPUSS_Peripheral use record
      INT_GROUP0  at 16#1100# range 0 .. 351;
      INT_GROUP1  at 16#1130# range 0 .. 351;
      INT_GROUP2  at 16#1160# range 0 .. 351;
      INT_GROUP3  at 16#1190# range 0 .. 351;
      INT_GROUP4  at 16#11C0# range 0 .. 351;
      CTL         at 16#1300# range 0 .. 31;
   end record;
end MSPM0.CPUSS;
