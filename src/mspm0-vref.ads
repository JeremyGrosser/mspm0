package MSPM0.VREF
   with Pure
is
   type CTL0_Register is record
      SHMODE            : Boolean := False;
      BUFCONFIG         : Boolean := False;
      COMP_VREF_ENABLE  : Boolean := False;
      ENABLE            : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CTL0_Register use record
      SHMODE            at 0 range 8 .. 8;
      BUFCONFIG         at 0 range 7 .. 7;
      COMP_VREF_ENABLE  at 0 range 1 .. 1;
      ENABLE            at 0 range 0 .. 0;
   end record;

   type CTL2_Register is record
      HCYCLE   : UInt16 := 0;
      SHCYCLE  : UInt16 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for CTL2_Register use record
      HCYCLE  at 0 range 16 .. 31;
      SHCYCLE at 0 range 0 .. 15;
   end record;

   type VREF_Peripheral is record
      PWREN    : UInt32;
      RSTCTL   : UInt32;
      CLKDIV   : UInt32;
      CLKSEL   : CLKSEL_Register;
      CTL0     : CTL0_Register;
      CTL1     : UInt32;
      CTL2     : CTL2_Register;
   end record
      with Volatile,
           Effective_Writes,
           Async_Readers,
           Async_Writers;
   for VREF_Peripheral use record
      PWREN    at 16#0800# range 0 .. 31;
      RSTCTL   at 16#0804# range 0 .. 31;
      CLKDIV   at 16#1000# range 0 .. 31;
      CLKSEL   at 16#1008# range 0 .. 31;
      CTL0     at 16#1100# range 0 .. 31;
      CTL1     at 16#1104# range 0 .. 31;
      CTL2     at 16#1108# range 0 .. 31;
   end record;
end MSPM0.VREF;
