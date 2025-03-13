--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");

package MSPM0.TIM
   with Pure
is

   type IIDX_STAT_Field is
      (No_Interrupt,
       Z,
       L,
       CCD0,
       CCD1,
       CCD2,
       CCD3,
       CCU0,
       CCU1,
       CCU2,
       CCU3,
       CCD4,
       CCD5,
       CCU4,
       CCU5,
       Fault,
       TOV,
       REPC,
       DC,
       QEIERR)
   with Size => 8;

   type IIDX_Register is record
      STAT : IIDX_STAT_Field := No_Interrupt;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for IIDX_Register use record
      STAT at 0 range 0 .. 7;
   end record;

   type IMASK_Register is record
      QEIERR   : Boolean;
      DC       : Boolean;
      REPC     : Boolean;
      TOV      : Boolean;
      F        : Boolean;
      CCU5     : Boolean;
      CCU4     : Boolean;
      CCD5     : Boolean;
      CCD4     : Boolean;
      CCU3     : Boolean;
      CCU2     : Boolean;
      CCU1     : Boolean;
      CCU0     : Boolean;
      CCD3     : Boolean;
      CCD2     : Boolean;
      CCD1     : Boolean;
      CCD0     : Boolean;
      L        : Boolean;
      Z        : Boolean;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for IMASK_Register use record
      QEIERR   at 0 range 28 .. 28;
      DC       at 0 range 27 .. 27;
      REPC     at 0 range 26 .. 26;
      TOV      at 0 range 25 .. 25;
      F        at 0 range 24 .. 24;
      CCU5     at 0 range 15 .. 15;
      CCU4     at 0 range 14 .. 14;
      CCD5     at 0 range 13 .. 13;
      CCD4     at 0 range 12 .. 12;
      CCU3     at 0 range 11 .. 11;
      CCU2     at 0 range 10 .. 10;
      CCU1     at 0 range 9 .. 9;
      CCU0     at 0 range 8 .. 8;
      CCD3     at 0 range 7 .. 7;
      CCD2     at 0 range 6 .. 6;
      CCD1     at 0 range 5 .. 5;
      CCD0     at 0 range 4 .. 4;
      L        at 0 range 1 .. 1;
      Z        at 0 range 0 .. 0;
   end record;

   type ODIS_Register is record
      C0CCP3 : Boolean := False;
      C0CCP2 : Boolean := False;
      C0CCP1 : Boolean := False;
      C0CCP0 : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for ODIS_Register use record
      C0CCP3 at 0 range 3 .. 3;
      C0CCP2 at 0 range 2 .. 2;
      C0CCP1 at 0 range 1 .. 1;
      C0CCP0 at 0 range 0 .. 0;
   end record;

   type CCPD_Register is new ODIS_Register;

   type CCLKCTL_Register is record
      CLKEN : Boolean;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CCLKCTL_Register use record
      CLKEN at 0 range 0 .. 0;
   end record;

   type CPS_Register is record
      PCNT : UInt8 := 0;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CPS_Register use record
      PCNT at 0 range 0 .. 7;
   end record;

   type CTR_Register is record
      CCTR : UInt32;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Async_Writers, Object_Size => 32;

   type CTRCTL_Register is record
      CVAE        : UInt2 := 0;
      PLEN        : Boolean := False;
      SLZERCNEZ   : Boolean := False;
      FRB         : Boolean := False;
      FB          : Boolean := False;
      DRB         : Boolean := False;
      CZC         : UInt3 := 7;
      CAC         : UInt3 := 7;
      CLC         : UInt3 := 7;
      CM          : UInt2 := 0;
      REPEAT      : UInt3 := 0;
      EN          : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CTRCTL_Register use record
      CVAE        at 0 range 28 .. 29;
      PLEN        at 0 range 24 .. 24;
      SLZERCNEZ   at 0 range 23 .. 23;
      FRB         at 0 range 19 .. 19;
      FB          at 0 range 18 .. 18;
      DRB         at 0 range 17 .. 17;
      CZC         at 0 range 13 .. 15;
      CAC         at 0 range 10 .. 12;
      CLC         at 0 range 7 .. 9;
      CM          at 0 range 4 .. 5;
      REPEAT      at 0 range 1 .. 3;
      EN          at 0 range 0 .. 0;
   end record;

   type Interrupt_Group is record
      IIDX : IIDX_Register;
      IMASK, RIS, MIS, ISET, ICLR : IMASK_Register;
   end record
      with Volatile, Effective_Writes, Async_Readers, Async_Writers;

   for Interrupt_Group use record
      IIDX  at 16#0000# range 0 .. 31;
      IMASK at 16#0008# range 0 .. 31;
      RIS   at 16#0010# range 0 .. 31;
      MIS   at 16#0018# range 0 .. 31;
      ISET  at 16#0020# range 0 .. 31;
      ICLR  at 16#0028# range 0 .. 31;
   end record;

   type EVT_MODE_Register is record
      EVT2_CFG : UInt2; --  GEN_EVENT1
      EVT1_CFG : UInt2; --  GEN_EVENT0
      EVT0_CFG : UInt2; --  CPU_INT
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for EVT_MODE_Register use record
      EVT2_CFG at 0 range 4 .. 5;
      EVT1_CFG at 0 range 2 .. 3;
      EVT0_CFG at 0 range 0 .. 1;
   end record;

   type CC_Register is record
      CCVAL : UInt16 := 0;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Async_Writers, Object_Size => 32;
   for CC_Register use record
      CCVAL at 0 range 0 .. 15;
   end record;

   type CCCTL_COC_Field is (Compare, Capture)
      with Size => 1;

   type CCCTL_Register is record
      CC2SELD  : UInt3 := 0;
      CCACTUPD : UInt3 := 0;
      SCERCNEZ : Boolean := False;
      CC2SELU  : UInt3 := 0;
      CCUPD    : UInt3 := 0;
      COC      : CCCTL_COC_Field := Compare;
      ZCOND    : UInt3 := 0;
      LCOND    : UInt3 := 0;
      ACOND    : UInt3 := 0;
      CCOND    : UInt3 := 0;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CCCTL_Register use record
      CC2SELD  at 0 range 29 .. 31;
      CCACTUPD at 0 range 26 .. 28;
      SCERCNEZ at 0 range 25 .. 25;
      CC2SELU  at 0 range 22 .. 24;
      CCUPD    at 0 range 18 .. 20;
      COC      at 0 range 17 .. 17;
      ZCOND    at 0 range 12 .. 14;
      LCOND    at 0 range 8 .. 10;
      ACOND    at 0 range 4 .. 6;
      CCOND    at 0 range 0 .. 2;
   end record;

   type OCTL_Register is record
      CCPIV    : Boolean;
      CCPOINV  : Boolean;
      CCPO     : UInt4;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for OCTL_Register use record
      CCPIV    at 0 range 5 .. 5;
      CCPOINV  at 0 range 4 .. 4;
      CCPO     at 0 range 0 .. 3;
   end record;

   type CCACT_ACT_Field is (Disabled, CCP_High, CCP_Low, CCP_Toggle)
      with Size => 2;

   type CCACT_Register is record
      SWFRCACT_CMPL  : UInt2 := 0;
      SWFRCACT       : UInt2 := 0;
      FEXACT         : UInt3 := 0;
      FENACT         : UInt3 := 0;
      CC2UACT        : CCACT_ACT_Field := Disabled;
      CC2DACT        : CCACT_ACT_Field := Disabled;
      CUACT          : CCACT_ACT_Field := Disabled;
      CDACT          : CCACT_ACT_Field := Disabled;
      LACT           : CCACT_ACT_Field := Disabled;
      ZACT           : CCACT_ACT_Field := Disabled;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CCACT_Register use record
      SWFRCACT_CMPL  at 0 range 30 .. 31;
      SWFRCACT       at 0 range 28 .. 29;
      FEXACT         at 0 range 25 .. 27;
      FENACT         at 0 range 22 .. 24;
      CC2UACT        at 0 range 15 .. 16;
      CC2DACT        at 0 range 12 .. 13;
      CUACT          at 0 range 9 .. 10;
      CDACT          at 0 range 6 .. 7;
      LACT           at 0 range 3 .. 4;
      ZACT           at 0 range 0 .. 1;
   end record;

   type TIM_Peripheral is record
      FSUB_0      : UInt32;
      FSUB_1      : UInt32;
      FPUB_0      : UInt32;
      FPUB_1      : UInt32;
      PWREN       : UInt32;
      RSTCTL      : UInt32;
      CLKDIV      : CLKDIV_Register;
      CLKSEL      : CLKSEL_Register;
      PDBGCTL     : PDBGCTL_Register;
      CPU_INT     : Interrupt_Group;
      GEN_EVENT_0 : Interrupt_Group;
      GEN_EVENT_1 : Interrupt_Group;
      EVT_MODE    : EVT_MODE_Register;
      CCPD        : CCPD_Register;
      ODIS        : ODIS_Register;
      CCLKCTL     : CCLKCTL_Register;
      CPS         : CPS_Register;
      CTR         : CTR_Register;
      CTRCTL      : CTRCTL_Register;
      LOAD        : UInt32;
      CC_0        : CC_Register;
      CC_1        : CC_Register;
      CC_2        : CC_Register;
      CC_3        : CC_Register;
      CC_4        : CC_Register;
      CC_5        : CC_Register;
      CCCTL_0     : CCCTL_Register;
      CCCTL_1     : CCCTL_Register;
      CCCTL_2     : CCCTL_Register;
      CCCTL_3     : CCCTL_Register;
      CCCTL_4     : CCCTL_Register;
      CCCTL_5     : CCCTL_Register;
      OCTL_0      : OCTL_Register;
      OCTL_1      : OCTL_Register;
      OCTL_2      : OCTL_Register;
      OCTL_3      : OCTL_Register;
      CCACT_0     : CCACT_Register;
      CCACT_1     : CCACT_Register;
      CCACT_2     : CCACT_Register;
      CCACT_3     : CCACT_Register;
   end record
      with Volatile;

   for TIM_Peripheral use record
      FSUB_0      at 16#0400# range 0 .. 31;
      FSUB_1      at 16#0404# range 0 .. 31;
      FPUB_0      at 16#0444# range 0 .. 31;
      FPUB_1      at 16#0448# range 0 .. 31;
      PWREN       at 16#0800# range 0 .. 31;
      RSTCTL      at 16#0804# range 0 .. 31;
      CLKDIV      at 16#1000# range 0 .. 31;
      CLKSEL      at 16#1008# range 0 .. 31;
      PDBGCTL     at 16#1018# range 0 .. 31;
      CPU_INT     at 16#1020# range 0 .. 351;
      GEN_EVENT_0 at 16#1050# range 0 .. 351;
      GEN_EVENT_1 at 16#1080# range 0 .. 351;
      EVT_MODE    at 16#10E0# range 0 .. 31;
      CCPD        at 16#1100# range 0 .. 31;
      ODIS        at 16#1104# range 0 .. 31;
      CCLKCTL     at 16#1108# range 0 .. 31;
      CPS         at 16#110C# range 0 .. 31;
      CTR         at 16#1800# range 0 .. 31;
      CTRCTL      at 16#1804# range 0 .. 31;
      LOAD        at 16#1808# range 0 .. 31;
      CC_0        at 16#1810# range 0 .. 31;
      CC_1        at 16#1814# range 0 .. 31;
      CC_2        at 16#1818# range 0 .. 31;
      CC_3        at 16#181C# range 0 .. 31;
      CC_4        at 16#1820# range 0 .. 31;
      CC_5        at 16#1824# range 0 .. 31;
      CCCTL_0     at 16#1830# range 0 .. 31;
      CCCTL_1     at 16#1834# range 0 .. 31;
      CCCTL_2     at 16#1838# range 0 .. 31;
      CCCTL_3     at 16#183C# range 0 .. 31;
      CCCTL_4     at 16#1840# range 0 .. 31;
      CCCTL_5     at 16#1844# range 0 .. 31;
      OCTL_0      at 16#1850# range 0 .. 31;
      OCTL_1      at 16#1854# range 0 .. 31;
      OCTL_2      at 16#1858# range 0 .. 31;
      OCTL_3      at 16#185C# range 0 .. 31;
      CCACT_0     at 16#1870# range 0 .. 31;
      CCACT_1     at 16#1874# range 0 .. 31;
      CCACT_2     at 16#1878# range 0 .. 31;
      CCACT_3     at 16#187C# range 0 .. 31;
   end record;

end MSPM0.TIM;
