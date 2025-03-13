--
--  Copyright (C) 2025 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package MSPM0.ADC
   with Pure
is
   type CLKCFG_SAMPCLK_Field is (ULPCLK, SYSOSC, HFCLK)
      with Size => 2;
   for CLKCFG_SAMPCLK_Field use
      (ULPCLK => 0,
       SYSOSC => 1,
       HFCLK  => 2);

   type CLKCFG_Register is record
      KEY      : UInt8 := 16#A9#;
      CCONSTOP : Boolean := False;
      CCONRUN  : Boolean := False;
      SAMPCLK  : CLKCFG_SAMPCLK_Field := ULPCLK;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for CLKCFG_Register use record
      KEY      at 0 range 24 .. 31;
      CCONSTOP at 0 range 5 .. 5;
      CCONRUN  at 0 range 4 .. 4;
      SAMPCLK  at 0 range 0 .. 1;
   end record;

   type MEMRESIFG_Array is array (0 .. 23) of Boolean
      with Component_Size => 1;

   type INT_Field is record
      MEMRESIFG   : MEMRESIFG_Array;
      ASCDONE     : Boolean;
      UVIFG       : Boolean;
      DMADONE     : Boolean;
      INIFG       : Boolean;
      LOWIFG      : Boolean;
      HIGHIFG     : Boolean;
      TOVIFG      : Boolean;
      OVIFG       : Boolean;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for INT_Field use record
      MEMRESIFG   at 0 range 8 .. 31;
      ASCDONE     at 0 range 7 .. 7;
      UVIFG       at 0 range 6 .. 6;
      DMADONE     at 0 range 5 .. 5;
      INIFG       at 0 range 4 .. 4;
      LOWIFG      at 0 range 3 .. 3;
      HIGHIFG     at 0 range 2 .. 2;
      TOVIFG      at 0 range 1 .. 1;
      OVIFG       at 0 range 0 .. 0;
   end record;

   type INT_Register is record
      IIDX  : UInt32;
      IMASK : INT_Field;
      RIS   : INT_Field;
      MIS   : INT_Field;
      ISET  : INT_Field;
      ICLR  : INT_Field;
   end record
      with Volatile,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 352;
   for INT_Register use record
      IIDX  at 16#00# range 0 .. 31;
      IMASK at 16#08# range 0 .. 31;
      RIS   at 16#10# range 0 .. 31;
      MIS   at 16#18# range 0 .. 31;
      ISET  at 16#20# range 0 .. 31;
      ICLR  at 16#28# range 0 .. 31;
   end record;

   type CTL0_Register is record
      SCLKDIV  : UInt3 := 0;
      PWRDN    : Boolean := False;
      ENC      : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CTL0_Register use record
      SCLKDIV  at 0 range 24 .. 26;
      PWRDN    at 0 range 16 .. 16;
      ENC      at 0 range 0 .. 0;
   end record;

   type CTL1_Register is record
      AVGD     : UInt3 := 0;
      AVGN     : UInt3 := 0;
      SAMPMODE : Boolean := False;
      CONSEQ   : UInt2 := 0;
      SC       : Boolean := False;
      TRIGSRC  : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for CTL1_Register use record
      AVGD     at 0 range 28 .. 30;
      AVGN     at 0 range 24 .. 26;
      SAMPMODE at 0 range 20 .. 20;
      CONSEQ   at 0 range 16 .. 17;
      SC       at 0 range 8 .. 8;
      TRIGSRC  at 0 range 0 .. 0;
   end record;

   type CTL2_Register is record
      ENDADD         : UInt5 := 0;
      STARTADD       : UInt5 := 0;
      SAMPCNT        : UInt5 := 0;
      FIFOEN         : Boolean := False;
      DMAEN          : Boolean := False;
      RSTSAMPCAPEN   : Boolean := False;
      RES            : UInt2 := 0;
      DF             : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CTL2_Register use record
      ENDADD         at 0 range 24 .. 28;
      STARTADD       at 0 range 16 .. 20;
      SAMPCNT        at 0 range 11 .. 15;
      FIFOEN         at 0 range 10 .. 10;
      DMAEN          at 0 range 8 .. 8;
      RSTSAMPCAPEN   at 0 range 4 .. 4;
      RES            at 0 range 1 .. 2;
      DF             at 0 range 0 .. 0;
   end record;

   type CTL3_Register is record
      ASCVRSEL : UInt2 := 0;
      ASCSTIME : Boolean := False;
      ASCCHSEL : UInt5 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CTL3_Register use record
      ASCVRSEL at 0 range 12 .. 13;
      ASCSTIME at 0 range 8 .. 8;
      ASCCHSEL at 0 range 0 .. 4;
   end record;

   type REFCFG_Register is record
      IBPROG : UInt2 := 0;
      REFVSEL : Boolean := False;
      REFEN    : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for REFCFG_Register use record
      IBPROG   at 0 range 3 .. 4;
      REFVSEL  at 0 range 1 .. 1;
      REFEN    at 0 range 0 .. 0;
   end record;

   type MEMCTL_Register is record
      WINCOMP  : Boolean := False;
      TRIG     : Boolean := False;
      BCSEN    : Boolean := False;
      AVGEN    : Boolean := False;
      STIME    : Boolean := False;
      VRSEL    : UInt2 := 0;
      CHANSEL  : UInt5 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for MEMCTL_Register use record
      WINCOMP  at 0 range 28 .. 28;
      TRIG     at 0 range 24 .. 24;
      BCSEN    at 0 range 20 .. 20;
      AVGEN    at 0 range 16 .. 16;
      STIME    at 0 range 12 .. 12;
      VRSEL    at 0 range 8 .. 9;
      CHANSEL  at 0 range 0 .. 4;
   end record;

   type MEMCTL_Array is array (0 .. 17) of MEMCTL_Register
      with Component_Size => 32;

   type MEMRES_Register is record
      RESULT : UInt16;
   end record
      with Volatile_Full_Access,
           Async_Writers,
           Effective_Reads,
           Object_Size => 32;
   for MEMRES_Register use record
      RESULT at 0 range 0 .. 15;
   end record;

   type MEMRES_Array is array (0 .. 17) of MEMRES_Register
      with Component_Size => 32;

   type STATUS_Register is record
      ASCACT      : Boolean;
      REFBUFRDY   : Boolean;
      BUSY        : Boolean;
   end record
      with Volatile_Full_Access,
           Async_Writers,
           Object_Size => 32;
   for STATUS_Register use record
      ASCACT      at 0 range 2 .. 2;
      REFBUFRDY   at 0 range 1 .. 1;
      BUSY        at 0 range 0 .. 0;
   end record;

   type ADC_Peripheral is record
      PWREN       : UInt32;
      RSTCTL      : UInt32;
      CLKCFG      : CLKCFG_Register;
      CPU_INT     : INT_Register;
      GEN_EVENT   : INT_Register;
      DMA_TRIG    : INT_Register;
      CTL0        : CTL0_Register;
      CTL1        : CTL1_Register;
      CTL2        : CTL2_Register;
      CTL3        : CTL3_Register;
      SCOMP0      : UInt8;
      SCOMP1      : UInt8;
      ASCRES      : UInt16;
      REFCFG      : REFCFG_Register;
      MEMCTL      : MEMCTL_Array;
      MEMRES      : MEMRES_Array;
      STATUS      : STATUS_Register;
   end record
      with Volatile,
           Effective_Writes,
           Async_Readers,
           Async_Writers;
   for ADC_Peripheral use record
      PWREN       at 16#0800# range 0 .. 31;
      RSTCTL      at 16#0804# range 0 .. 31;
      CPU_INT     at 16#1020# range 0 .. 351;
      GEN_EVENT   at 16#1050# range 0 .. 351;
      DMA_TRIG    at 16#1080# range 0 .. 351;
      CTL0        at 16#1100# range 0 .. 31;
      CTL1        at 16#1104# range 0 .. 31;
      CTL2        at 16#1108# range 0 .. 31;
      CTL3        at 16#110C# range 0 .. 31;
      SCOMP0      at 16#1114# range 0 .. 7;
      SCOMP1      at 16#1118# range 0 .. 7;
      ASCRES      at 16#1170# range 0 .. 15;
      REFCFG      at 16#111C# range 0 .. 31;
      MEMCTL      at 16#1180# range 0 .. 575;
      MEMRES      at 16#1280# range 0 .. 575;
      STATUS      at 16#1340# range 0 .. 31;
   end record;
end MSPM0.ADC;
