with System.Storage_Elements; use System.Storage_Elements;
with System;

package body MSPM0.Reset is
   procedure Reset_Peripheral
      (Base : System.Address)
   is
      PWREN  : UInt32
         with Import, Address => Base + 16#0800#;
      RSTCTL : UInt32
         with Import, Address => Base + 16#0804#;
   begin
      RSTCTL := RSTCTL_RESET;
      PWREN := PWREN_ENABLE;
   end Reset_Peripheral;
end MSPM0.Reset;
