--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");

package MSPM0.SYSCTL
   with Pure
is
   type SYSOSCCFG_FREQ_Field is (SYSOSC_32MHz, SYSOSC_4MHz, SYSOSC_User)
      with Size => 2;

   type SYSOSCCFG_Register is record
      FASTCPUEVENT   : Boolean := True;
      BLOCKASYNCALL  : Boolean := False;
      DISABLE        : Boolean := False;
      DISABLESTOP    : Boolean := False;
      USE4MHZSTOP    : Boolean := False;
      FREQ           : SYSOSCCFG_FREQ_Field := SYSOSC_32MHz;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for SYSOSCCFG_Register use record
      FASTCPUEVENT   at 0 range 17 .. 17;
      BLOCKASYNCALL  at 0 range 16 .. 16;
      DISABLE        at 0 range 10 .. 10;
      DISABLESTOP    at 0 range 9 .. 9;
      USE4MHZSTOP    at 0 range 8 .. 8;
      FREQ           at 0 range 0 .. 1;
   end record;

   type MCLKCFG_Register is record
      MCLKDEADCHK : Boolean := False;
      STOPCLKSTBY : Boolean := False;
      USELFCLK    : Boolean := False;
      USEHSCLK    : Boolean := False;
      USEMFTICK   : Boolean := False;
      FLASHWAIT   : UInt4 := 2;
      UDIV        : UInt2 := 1;
      MDIV        : UInt4 := 0;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for MCLKCFG_Register use record
      MCLKDEADCHK at 0 range 22 .. 22;
      STOPCLKSTBY at 0 range 21 .. 21;
      USELFCLK    at 0 range 20 .. 20;
      USEHSCLK    at 0 range 16 .. 16;
      USEMFTICK   at 0 range 12 .. 12;
      FLASHWAIT   at 0 range 8 .. 11;
      UDIV        at 0 range 4 .. 5;
      MDIV        at 0 range 0 .. 3;
   end record;

   type HSCLKEN_Register is record
      USEEXTHFCLK : Boolean;
      SYSPLLEN    : Boolean;
      HFXTEN      : Boolean;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for HSCLKEN_Register use record
      USEEXTHFCLK at 0 range 16 .. 16;
      SYSPLLEN    at 0 range 8 .. 8;
      HFXTEN      at 0 range 0 .. 0;
   end record;

   type HSCLKCFG_Register is record
      HSCLKSEL : Boolean;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for HSCLKCFG_Register use record
      HSCLKSEL at 0 range 0 .. 0;
   end record;

   type HFCLKCFG_Register is record
      HFCLKFLTCHK : Boolean;
      HFXTRSEL    : UInt2;
      HFXTTIME    : UInt8;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for HFCLKCFG_Register use record
      HFCLKFLTCHK at 0 range 28 .. 28;
      HFXTRSEL    at 0 range 12 .. 13;
      HFXTTIME    at 0 range 0 .. 7;
   end record;

   type LFCLKCFG_Register is record
      LOWCAP   : Boolean;
      MONITOR  : Boolean;
      XT1DRIVE : UInt2;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for LFCLKCFG_Register use record
      LOWCAP   at 0 range 8 .. 8;
      MONITOR  at 0 range 4 .. 4;
      XT1DRIVE at 0 range 0 .. 1;
   end record;

   type SYSPLLCFG0_Register is record
      RDIVCLK2X   : UInt4 := 0;
      RDIVCLK1    : UInt4 := 0;
      RDIVCLK0    : UInt4 := 0;
      ENABLECLK2X : Boolean := False;
      ENABLECLK1  : Boolean := False;
      ENABLECLK0  : Boolean := False;
      MCLK2XVCO   : Boolean := False;
      SYSPLLREF   : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for SYSPLLCFG0_Register use record
      RDIVCLK2X   at 0 range 16 .. 19;
      RDIVCLK1    at 0 range 12 .. 15;
      RDIVCLK0    at 0 range 8 .. 11;
      ENABLECLK2X at 0 range 6 .. 6;
      ENABLECLK1  at 0 range 5 .. 5;
      ENABLECLK0  at 0 range 4 .. 4;
      MCLK2XVCO   at 0 range 1 .. 1;
      SYSPLLREF   at 0 range 0 .. 0;
   end record;

   type SYSPLLCFG1_Register is record
      QDIV  : UInt7 := 0;
      PDIV  : UInt2 := 0;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for SYSPLLCFG1_Register use record
      QDIV  at 0 range 8 .. 14;
      PDIV  at 0 range 0 .. 1;
   end record;

   type GENCLKCFG_FCCSELCLK_Field is
      (MCLK, SYSOSC, HFCLK, CLK_OUT, SYSPLLCLK0, SYSPLLCLK1, SYSPLLCLK2X, FCCIN)
   with Size => 4;

   type GENCLKCFG_Register is record
      FCCTRIGCNT        : UInt5;
      ANACPUMPCFG       : UInt2;
      FCCLVLTRIG        : Boolean;
      FCCTRIGSRC        : Boolean;
      FCCSELCLK         : GENCLKCFG_FCCSELCLK_Field := MCLK;
      HFCLK4MFPCLKDIV   : UInt4;
      MFPCLKSRC         : Boolean;
      CANCLKSRC         : Boolean;
      EXCLKDIVEN        : Boolean;
      EXCLKDIVVAL       : UInt3;
      EXCLKSRC          : UInt3;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for GENCLKCFG_Register use record
      FCCTRIGCNT        at 0 range 24 .. 28;
      ANACPUMPCFG       at 0 range 22 .. 23;
      FCCLVLTRIG        at 0 range 21 .. 21;
      FCCTRIGSRC        at 0 range 20 .. 20;
      FCCSELCLK         at 0 range 16 .. 19;
      HFCLK4MFPCLKDIV   at 0 range 12 .. 15;
      MFPCLKSRC         at 0 range 9 .. 9;
      CANCLKSRC         at 0 range 8 .. 8;
      EXCLKDIVEN        at 0 range 7 .. 7;
      EXCLKDIVVAL       at 0 range 4 .. 6;
      EXCLKSRC          at 0 range 0 .. 2;
   end record;

   type GENCLKEN_Register is record
      MFPCLKEN : Boolean;
      EXCLKEN  : Boolean;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for GENCLKEN_Register use record
      MFPCLKEN at 0 range 4 .. 4;
      EXCLKEN  at 0 range 0 .. 0;
   end record;

   type PMODECFG_Register is record
      DSLEEP : UInt2 := 0;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for PMODECFG_Register use record
      DSLEEP at 0 range 0 .. 1;
   end record;

   type CLKSTATUS_Register is record
      ANACLKERR      : Boolean;
      OPAMPCLKERR    : Boolean;
      SYSPLLBLKUPD   : Boolean;
      HFCLKBLKUPD    : Boolean;
      FCCDONE        : Boolean;
      FCLMODE        : Boolean;
      LFCLKFAIL      : Boolean;
      HSCLKGOOD      : Boolean;
      HSCLKDEAD      : Boolean;
      CURMCLKSEL     : Boolean;
      CURHSCLKSEL    : Boolean;
      SYSPLLOFF      : Boolean;
      HFCLKOFF       : Boolean;
      HSCLKSOFF      : Boolean;
      LFOSCGOOD      : Boolean;
      LFXTGOOD       : Boolean;
      SYSPLLGOOD     : Boolean;
      HFCLKGOOD      : Boolean;
      LFCLKMUX       : UInt2;
      HSCLKMUX       : Boolean;
      SYSOSCFREQ     : UInt2;
   end record
      with Volatile_Full_Access, Async_Writers, Object_Size => 32;
   for CLKSTATUS_Register use record
      ANACLKERR      at 0 range 31 .. 31;
      OPAMPCLKERR    at 0 range 30 .. 30;
      SYSPLLBLKUPD   at 0 range 29 .. 29;
      HFCLKBLKUPD    at 0 range 28 .. 28;
      FCCDONE        at 0 range 25 .. 25;
      FCLMODE        at 0 range 24 .. 24;
      LFCLKFAIL      at 0 range 23 .. 23;
      HSCLKGOOD      at 0 range 21 .. 21;
      HSCLKDEAD      at 0 range 20 .. 20;
      CURMCLKSEL     at 0 range 17 .. 17;
      CURHSCLKSEL    at 0 range 16 .. 16;
      SYSPLLOFF      at 0 range 14 .. 14;
      HFCLKOFF       at 0 range 13 .. 13;
      HSCLKSOFF      at 0 range 12 .. 12;
      LFOSCGOOD      at 0 range 11 .. 11;
      LFXTGOOD       at 0 range 10 .. 10;
      SYSPLLGOOD     at 0 range 9 .. 9;
      HFCLKGOOD      at 0 range 8 .. 8;
      LFCLKMUX       at 0 range 6 .. 7;
      HSCLKMUX       at 0 range 4 .. 4;
      SYSOSCFREQ     at 0 range 0 .. 1;
   end record;

   type SYSOSCFCLCTL_Register is record
      KEY         : UInt8 := 16#2A#;
      SETUSEEXRES : Boolean := False;
      SETUSEFCL   : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for SYSOSCFCLCTL_Register use record
      KEY         at 0 range 24 .. 31;
      SETUSEEXRES at 0 range 1 .. 1;
      SETUSEFCL   at 0 range 0 .. 0;
   end record;

   type LFXTCTL_Register is record
      KEY         : UInt8 := 16#91#;
      SETUSELFXT  : Boolean := False;
      STARTLFXT   : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for LFXTCTL_Register use record
      KEY         at 0 range 24 .. 31;
      SETUSELFXT  at 0 range 1 .. 1;
      STARTLFXT   at 0 range 0 .. 0;
   end record;

   type FCCCMD_Register is record
      KEY : UInt8 := 16#0E#;
      GO  : Boolean;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Async_Writers, Object_Size => 32;
   for FCCCMD_Register use record
      KEY at 0 range 24 .. 31;
      GO  at 0 range 0 .. 0;
   end record;

   type SYSCTL_Peripheral is record
      SYSOSCCFG      : SYSOSCCFG_Register;
      MCLKCFG        : MCLKCFG_Register;
      HSCLKEN        : HSCLKEN_Register;
      HSCLKCFG       : HSCLKCFG_Register;
      HFCLKCFG       : HFCLKCFG_Register;
      LFCLKCFG       : LFCLKCFG_Register;
      SYSPLLCFG0     : SYSPLLCFG0_Register;
      SYSPLLCFG1     : SYSPLLCFG1_Register;
      SYSPLLPARAM0   : UInt32;
      SYSPLLPARAM1   : UInt32;
      GENCLKCFG      : GENCLKCFG_Register;
      GENCLKEN       : GENCLKEN_Register;
      PMODECFG       : PMODECFG_Register;
      FCC            : UInt22;
      CLKSTATUS      : CLKSTATUS_Register;
      SYSOSCFCLCTL   : SYSOSCFCLCTL_Register;
      LFXTCTL        : LFXTCTL_Register;
      FCCCMD         : FCCCMD_Register;
   end record
      with Volatile, Effective_Writes, Async_Readers, Async_Writers;
   for SYSCTL_Peripheral use record
      SYSOSCCFG      at 16#1100# range 0 .. 31;
      MCLKCFG        at 16#1104# range 0 .. 31;
      HSCLKEN        at 16#1108# range 0 .. 31;
      HSCLKCFG       at 16#110C# range 0 .. 31;
      HFCLKCFG       at 16#1110# range 0 .. 31;
      LFCLKCFG       at 16#1114# range 0 .. 31;
      SYSPLLCFG0     at 16#1120# range 0 .. 31;
      SYSPLLCFG1     at 16#1124# range 0 .. 31;
      SYSPLLPARAM0   at 16#1128# range 0 .. 31;
      SYSPLLPARAM1   at 16#112C# range 0 .. 31;
      GENCLKCFG      at 16#1138# range 0 .. 31;
      GENCLKEN       at 16#113C# range 0 .. 31;
      PMODECFG       at 16#1140# range 0 .. 31;
      FCC            at 16#1150# range 0 .. 21;
      CLKSTATUS      at 16#1204# range 0 .. 31;
      SYSOSCFCLCTL   at 16#1310# range 0 .. 31;
      LFXTCTL        at 16#1314# range 0 .. 31;
      FCCCMD         at 16#132C# range 0 .. 31;
   end record;

end MSPM0.SYSCTL;
