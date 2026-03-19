package MSPM0.COMP
   with Pure
is

   type CTL0_Register is record
      IMEN     : Boolean := False;
      IMSEL    : UInt3 := 0;
      IPEN     : Boolean := False;
      IPSEL    : UInt3 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CTL0_Register use record
      IMEN  at 0 range 31 .. 31;
      IMSEL at 0 range 16 .. 18;
      IPEN  at 0 range 15 .. 15;
      IPSEL at 0 range 0 .. 2;
   end record;

   type CTL1_Register is record
      WINCOMPEN   : Boolean := False;
      FLTDLY      : Boolean := False;
      FLTEN       : Boolean := False;
      OUTPOL      : Boolean := False;
      HYST        : UInt2 := 0;
      IES         : Boolean := False;
      SHORT       : Boolean := False;
      EXCH        : Boolean := False;
      MODE        : Boolean := False;
      ENABLE      : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CTL1_Register use record
      WINCOMPEN   at 0 range 12 .. 12;
      FLTDLY      at 0 range 9 .. 10;
      FLTEN       at 0 range 8 .. 8;
      OUTPOL      at 0 range 7 .. 7;
      HYST        at 0 range 5 .. 6;
      IES         at 0 range 4 .. 4;
      SHORT       at 0 range 3 .. 3;
      EXCH        at 0 range 2 .. 2;
      MODE        at 0 range 1 .. 1;
      ENABLE      at 0 range 0 .. 0;
   end record;

   type CTL2_Register is record
      SAMPMODE : Boolean := False;
      DACSW    : Boolean := False;
      DACCTL   : Boolean := False;
      BLANKSRC : UInt3 := 0;
      REFSEL   : Boolean := False;
      REFSRC   : UInt3 := 0;
      REFMODE  : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CTL2_Register use record
      SAMPMODE at 0 range 24 .. 24;
      DACSW    at 0 range 17 .. 17;
      DACCTL   at 0 range 16 .. 16;
      BLANKSRC at 0 range 8 .. 10;
      REFSEL   at 0 range 7 .. 7;
      REFSRC   at 0 range 3 .. 5;
      REFMODE  at 0 range 0 .. 0;
   end record;

   type CTL3_Register is record
      DACCODE1 : UInt8 := 0;
      DACCODE0 : UInt8 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CTL3_Register use record
      DACCODE1 at 0 range 16 .. 23;
      DACCODE0 at 0 range 0 .. 7;
   end record;

   type COMP_Peripheral is record
      PWREN    : UInt32;
      RSTCTL   : UInt32;
      CTL0     : CTL0_Register;
      CTL1     : CTL1_Register;
      CTL2     : CTL2_Register;
      CTL3     : CTL3_Register;
   end record
      with Volatile;

   for COMP_Peripheral use record
      PWREN    at 16#0800# range 0 .. 31;
      RSTCTL   at 16#0804# range 0 .. 31;
      CTL0     at 16#1100# range 0 .. 31;
      CTL1     at 16#1104# range 0 .. 31;
      CTL2     at 16#1108# range 0 .. 31;
      CTL3     at 16#110C# range 0 .. 31;
   end record;

end MSPM0.COMP;
