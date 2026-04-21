package MSPM0.OPA
   with Pure
is

   type CFGBASE_Register is record
      RRI : Boolean := False;
      GBW : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CFGBASE_Register use record
      RRI at 0 range 2 .. 2;
      GBW at 0 range 0 .. 0;
   end record;

   type CFG_Register is record
      GAIN     : UInt3 := 0;
      MSEL     : UInt3 := 0;
      NSEL     : UInt3 := 0;
      PSEL     : UInt4 := 0;
      OUTPIN   : Boolean := False;
      CHOP     : UInt2 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CFG_Register use record
      GAIN     at 0 range 13 .. 15;
      MSEL     at 0 range 10 .. 12;
      NSEL     at 0 range 7 .. 9;
      PSEL     at 0 range 3 .. 6;
      OUTPIN   at 0 range 2 .. 2;
      CHOP     at 0 range 0 .. 1;
   end record;

   type OPA_Peripheral is record
      PWREN    : UInt32;
      RSTCTL   : UInt32;
      CTL      : UInt32;
      CFGBASE  : CFGBASE_Register;
      CFG      : CFG_Register;
      STAT     : UInt32;
   end record
      with Volatile;

   for OPA_Peripheral use record
      PWREN    at 16#0800# range 0 .. 31;
      RSTCTL   at 16#0804# range 0 .. 31;
      CTL      at 16#1100# range 0 .. 31;
      CFGBASE  at 16#1104# range 0 .. 31;
      CFG      at 16#1108# range 0 .. 31;
      STAT     at 16#1118# range 0 .. 31;
   end record;

end MSPM0.OPA;
