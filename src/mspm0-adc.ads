package MSPM0.ADC
   with Pure
is
   type CTL0_Register is record
      SCLKDIV  : UInt3 := 0;
      PWRDN    : Boolean := False;
      ENC      : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
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
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CTL1_Register use record
      AVGD     at 0 range 28 .. 30;
      AVGN     at 0 range 24 .. 26;
      SAMPMODE at 0 range 20 .. 20;
      CONSEQ   at 0 range 16 .. 17;
      SC       at 0 range 8 .. 8;
      TRIGSRC  at 0 range 0 .. 0;
   end record;

   type CTL2_Register is record
      ENDADD   : UInt5 := 0;
      STARTADD : UInt5 := 0;
      SAMPCNT  : UInt5 := 0;
      FIFOEN   : Boolean := False;
      DMAEN    : Boolean := False;
      RES      : UInt2 := 0;
      DF       : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CTL2_Register use record
      ENDADD   at 0 range 24 .. 28;
      STARTADD at 0 range 16 .. 20;
      SAMPCNT  at 0 range 11 .. 15;
      FIFOEN   at 0 range 10 .. 10;
      DMAEN    at 0 range 8 .. 8;
      RES      at 0 range 1 .. 2;
      DF       at 0 range 0 .. 0;
   end record;

   type CTL3_Register is record
      ASCVRSEL : UInt2 := 0;
      ASCSTIME : Boolean := False;
      ASCCHSEL : UInt5 := 0;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CTL3_Register use record
      ASCVRSEL at 0 range 12 .. 13;
      ASCSTIME at 0 range 8 .. 8;
      ASCCHSEL at 0 range 0 .. 4;
   end record;

   type MEMCTL_Register is record
      WINCMP   : Boolean := False;
      TRIG     : Boolean := False;
      BCSEN    : Boolean := False;
      AVGEN    : Boolean := False;
      STIME    : Boolean := False;
      VRSEL    : UInt2 := 0;
      CHANSEL  : UInt5 := 0;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for MEMCTL_Register use record
      WINCMP   at 0 range 28 .. 28;
      TRIG     at 0 range 24 .. 24;
      BCSEN    at 0 range 20 .. 20;
      AVGEN    at 0 range 16 .. 16;
      STIME    at 0 range 12 .. 12;
      VRSEL    at 0 range 8 .. 9;
      CHANSEL  at 0 range 0 .. 4;
   end record;

   type MEMCTL_Array is array (0 .. 17) of MEMCTL_Register
      with Component_Size => 32;

   type MEMRES_Array is array (0 .. 17) of UInt16
      with Component_Size => 32;

   type ADC_Peripheral is record
      PWREN    : UInt32;
      RSTCTL   : UInt32;
      CTL0     : CTL0_Register;
      CTL1     : CTL1_Register;
      CTL2     : CTL2_Register;
      CTL3     : CTL3_Register;
      ASCRES   : UInt16;
      MEMCTL   : MEMCTL_Array;
      MEMRES   : MEMRES_Array;
   end record
      with Volatile, Effective_Writes, Async_Readers, Async_Writers;
   for ADC_Peripheral use record
      PWREN    at 16#0800# range 0 .. 31;
      RSTCTL   at 16#0804# range 0 .. 31;
      CTL0     at 16#1100# range 0 .. 31;
      CTL1     at 16#1104# range 0 .. 31;
      CTL2     at 16#1108# range 0 .. 31;
      CTL3     at 16#110C# range 0 .. 31;
      ASCRES   at 16#1170# range 0 .. 15;
      MEMCTL   at 16#1180# range 0 .. 575;
      MEMRES   at 16#1280# range 0 .. 575;
   end record;
end MSPM0.ADC;
