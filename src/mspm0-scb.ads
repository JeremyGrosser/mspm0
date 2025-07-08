package MSPM0.SCB
   with Pure
is
   type ICSR_Register is record
      NMIPENDSET  : Boolean := False;
      PENDSVSET   : Boolean := False;
      PENDSVCLR   : Boolean := False;
      PENDSTSET   : Boolean := False;
      PENDSTCLR   : Boolean := False;
      VECTPENDING : UInt6 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Effective_Reads,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for ICSR_Register use record
      NMIPENDSET  at 0 range 31 .. 31;
      PENDSVSET   at 0 range 28 .. 28;
      PENDSVCLR   at 0 range 27 .. 27;
      PENDSTSET   at 0 range 26 .. 26;
      PENDSTCLR   at 0 range 25 .. 25;
      VECTPENDING at 0 range 12 .. 17;
   end record;

   type AIRCR_Register is record
      VECTKEY        : UInt16 := 16#05FA#;
      ENDIANNESS     : Boolean := False;
      SYSRESETREQ    : Boolean := False;
      VECTCLRACTIVE  : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for AIRCR_Register use record
      VECTKEY        at 0 range 16 .. 31;
      ENDIANNESS     at 0 range 15 .. 15;
      SYSRESETREQ    at 0 range 2 .. 2;
      VECTCLRACTIVE  at 0 range 1 .. 1;
   end record;

   type SCR_Register is record
      SEVONPEND   : Boolean := False;
      SLEEPDEEP   : Boolean := False;
      SLEEPONEXIT : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for SCR_Register use record
      SEVONPEND   at 0 range 4 .. 4;
      SLEEPDEEP   at 0 range 2 .. 2;
      SLEEPONEXIT at 0 range 1 .. 1;
   end record;

   type SCB_Peripheral is record
      CPUID : UInt32;
      ICSR  : ICSR_Register;
      VTOR  : UInt32;
      AIRCR : AIRCR_Register;
      SCR   : SCR_Register;
   end record
      with Volatile, Effective_Writes, Async_Writers, Async_Readers;

   for SCB_Peripheral use record
      CPUID at 16#00# range 0 .. 31;
      ICSR  at 16#04# range 0 .. 31;
      VTOR  at 16#08# range 0 .. 31;
      AIRCR at 16#0C# range 0 .. 31;
      SCR   at 16#10# range 0 .. 31;
   end record;
end MSPM0.SCB;
