package MSPM0.COMP
   with Pure
is

   type COMP_Peripheral is record
      PWREN : UInt32;
      RSTCTL : UInt32;
   end record;

   for COMP_Peripheral use record
      PWREN  at 16#800# range 0 .. 31;
      RSTCTL at 16#804# range 0 .. 31;
   end record;

end MSPM0.COMP;
