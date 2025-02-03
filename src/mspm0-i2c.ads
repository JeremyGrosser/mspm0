--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");

package MSPM0.I2C
   with Pure
is
   type MSA_Register is record
      MMODE : Boolean := False;
      SADDR : UInt9 := 0;
      DIR   : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Async_Writers, Object_Size => 32;
   for MSA_Register use record
      MMODE at 0 range 15 .. 15;
      SADDR at 0 range 1 .. 10;
      DIR   at 0 range 0 .. 0;
   end record;

   type MCTR_Register is record
      MBLEN          : UInt12 := 0;
      RD_ON_TXEMPTY  : Boolean := False;
      MACKOEN        : Boolean := False;
      ACK            : Boolean := False;
      STOP           : Boolean := False;
      START          : Boolean := False;
      BURSTRUN       : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for MCTR_Register use record
      MBLEN          at 0 range 16 .. 27;
      RD_ON_TXEMPTY  at 0 range 5 .. 5;
      MACKOEN        at 0 range 4 .. 4;
      ACK            at 0 range 3 .. 3;
      STOP           at 0 range 2 .. 2;
      START          at 0 range 1 .. 1;
      BURSTRUN       at 0 range 0 .. 0;
   end record;

   type MSR_Register is record
      MBCNT    : UInt12 := 0;
      BUSBSY   : Boolean := False;
      IDLE     : Boolean := False;
      ARBLST   : Boolean := False;
      DATACK   : Boolean := False;
      ADRACK   : Boolean := False;
      ERR      : Boolean := False;
      BUSY     : Boolean := False;
   end record
      with Volatile_Full_Access, Async_Readers, Async_Writers, Object_Size => 32;
   for MSR_Register use record
      MBCNT    at 0 range 16 .. 27;
      BUSBSY   at 0 range 6 .. 6;
      IDLE     at 0 range 5 .. 5;
      ARBLST   at 0 range 4 .. 4;
      DATACK   at 0 range 3 .. 3;
      ADRACK   at 0 range 2 .. 2;
      ERR      at 0 range 1 .. 1;
      BUSY     at 0 range 0 .. 0;
   end record;

   type MRXDATA_Register is record
      VALUE : UInt8 := 0;
   end record
      with Volatile_Full_Access, Async_Writers, Object_Size => 32;
   for MRXDATA_Register use record
      VALUE at 0 range 0 .. 7;
   end record;

   type MTXDATA_Register is record
      VALUE : UInt8 := 0;
   end record
      with Volatile, Effective_Writes, Async_Readers, Object_Size => 32;
   for MTXDATA_Register use record
      VALUE at 0 range 0 .. 7;
   end record;

   type MTPR_Register is record
      TPR : UInt7 := 1;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for MTPR_Register use record
      TPR at 0 range 0 .. 6;
   end record;

   type MCR_Register is record
      LPBK        : Boolean := False;
      CLKSTRETCH  : Boolean := False;
      MMST        : Boolean := False;
      ACTIVE      : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for MCR_Register use record
      LPBK        at 0 range 8 .. 8;
      CLKSTRETCH  at 0 range 2 .. 2;
      MMST        at 0 range 1 .. 1;
      ACTIVE      at 0 range 0 .. 0;
   end record;

   type MFIFOCTL_Register is record
      RXFLUSH  : Boolean;
      RXTRIG   : UInt3;
      TXFLUSH  : Boolean;
      TXTRIG   : UInt3;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for MFIFOCTL_Register use record
      RXFLUSH  at 0 range 15 .. 15;
      RXTRIG   at 0 range 8 .. 10;
      TXFLUSH  at 0 range 7 .. 7;
      TXTRIG   at 0 range 0 .. 2;
   end record;

   type MFIFOSR_Register is record
      TXFLUSH     : Boolean;
      TXFIFOCNT   : UInt4;
      RXFLUSH     : Boolean;
      RXFIFOCNT   : UInt4;
   end record
      with Volatile_Full_Access, Async_Writers, Object_Size => 32;
   for MFIFOSR_Register use record
      TXFLUSH     at 0 range 15 .. 15;
      TXFIFOCNT   at 0 range 8 .. 11;
      RXFLUSH     at 0 range 7 .. 7;
      RXFIFOCNT   at 0 range 0 .. 3;
   end record;

   type IIDX_STAT_Field is
      (No_Interrupt,
       MRXDONE,
       MTXDONE,
       MRXFIFOTRG,
       MTXFIFOTRG,
       MRXFIFOFULL,
       MTXEMPTY,
       MNACK,
       MSTART,
       MSTOP,
       MARBLOST,
       MDMA_DONE_TX,
       MDMA_DONE_RX,
       MPEC_RX_ERR,
       TIMEOUTA,
       TIMEOUTB,
       SRXDONE,
       STXDONE,
       SRXFIFOTRG,
       STXFIFOTRG,
       SRXFIFOFULL,
       STXEMPTY,
       SSTART,
       SSTOP,
       SGENCALL,
       SDMA_DONE_TX,
       SDMA_DONE_RX,
       SPEC_RX_ERR,
       STX_UNFL,
       SRX_OVFL,
       SARBLOST,
       INTR_OVFL)
   with Size => 8;
   for IIDX_STAT_Field use
      (No_Interrupt  => 0,
       MRXDONE       => 1,
       MTXDONE       => 2,
       MRXFIFOTRG    => 3,
       MTXFIFOTRG    => 4,
       MRXFIFOFULL   => 5,
       MTXEMPTY      => 6,
       MNACK         => 8,
       MSTART        => 9,
       MSTOP         => 10,
       MARBLOST      => 11,
       MDMA_DONE_TX  => 12,
       MDMA_DONE_RX  => 13,
       MPEC_RX_ERR   => 14,
       TIMEOUTA      => 15,
       TIMEOUTB      => 16,
       SRXDONE       => 17,
       STXDONE       => 18,
       SRXFIFOTRG    => 19,
       STXFIFOTRG    => 20,
       SRXFIFOFULL   => 21,
       STXEMPTY      => 22,
       SSTART        => 23,
       SSTOP         => 24,
       SGENCALL      => 25,
       SDMA_DONE_TX  => 26,
       SDMA_DONE_RX  => 27,
       SPEC_RX_ERR   => 28,
       STX_UNFL      => 29,
       SRX_OVFL      => 30,
       SARBLOST      => 31,
       INTR_OVFL     => 32);

   type IIDX_Register is record
      STAT : IIDX_STAT_Field;
   end record
      with Volatile_Full_Access, Async_Writers, Object_Size => 32;
   for IIDX_Register use record
      STAT at 0 range 0 .. 7;
   end record;

   type INT_Register is record
      INTR_OVFL      : Boolean;
      SARBLOST       : Boolean;
      SRX_OVFL       : Boolean;
      STX_UNFL       : Boolean;
      SPEC_RX_ERR    : Boolean;
      SDMA_DONE_RX   : Boolean;
      SDMA_DONE_TX   : Boolean;
      SGENCALL       : Boolean;
      SSTOP          : Boolean;
      SSTART         : Boolean;
      STXEMPTY       : Boolean;
      SRXFIFOFULL    : Boolean;
      STXFIFOTRG     : Boolean;
      SRXFIFOTRG     : Boolean;
      STXDONE        : Boolean;
      SRXDONE        : Boolean;
      TIMEOUTB       : Boolean;
      TIMEOUTA       : Boolean;
      MPEC_RX_ERR    : Boolean;
      MDMA_DONE_RX   : Boolean;
      MDMA_DONE_TX   : Boolean;
      MARBLOST       : Boolean;
      MSTOP          : Boolean;
      MSTART         : Boolean;
      MNACK          : Boolean;
      MTXEMPTY       : Boolean;
      MRXFIFOFULL    : Boolean;
      MTXFIFOTRG     : Boolean;
      MRXFIFOTRG     : Boolean;
      MTXDONE        : Boolean;
      MRXDONE        : Boolean;
   end record
      with Volatile_Full_Access,
           Async_Writers,
           Object_Size => 32;
   for INT_Register use record
      INTR_OVFL      at 0 range 31 .. 31;
      SARBLOST       at 0 range 30 .. 30;
      SRX_OVFL       at 0 range 29 .. 29;
      STX_UNFL       at 0 range 28 .. 28;
      SPEC_RX_ERR    at 0 range 27 .. 27;
      SDMA_DONE_RX   at 0 range 26 .. 26;
      SDMA_DONE_TX   at 0 range 25 .. 25;
      SGENCALL       at 0 range 24 .. 24;
      SSTOP          at 0 range 23 .. 23;
      SSTART         at 0 range 22 .. 22;
      STXEMPTY       at 0 range 21 .. 21;
      SRXFIFOFULL    at 0 range 20 .. 20;
      STXFIFOTRG     at 0 range 19 .. 19;
      SRXFIFOTRG     at 0 range 18 .. 18;
      STXDONE        at 0 range 17 .. 17;
      SRXDONE        at 0 range 16 .. 16;
      TIMEOUTB       at 0 range 15 .. 15;
      TIMEOUTA       at 0 range 14 .. 14;
      MPEC_RX_ERR    at 0 range 13 .. 13;
      MDMA_DONE_RX   at 0 range 12 .. 12;
      MDMA_DONE_TX   at 0 range 11 .. 11;
      MARBLOST       at 0 range 10 .. 10;
      MSTOP          at 0 range 9 .. 9;
      MSTART         at 0 range 8 .. 8;
      MNACK          at 0 range 7 .. 7;
      MTXEMPTY       at 0 range 5 .. 5;
      MRXFIFOFULL    at 0 range 4 .. 4;
      MTXFIFOTRG     at 0 range 3 .. 3;
      MRXFIFOTRG     at 0 range 2 .. 2;
      MTXDONE        at 0 range 1 .. 1;
      MRXDONE        at 0 range 0 .. 0;
   end record;

   type I2C_Peripheral is record
      PWREN    : UInt32;
      RSTCTL   : UInt32;
      CLKDIV   : CLKDIV_Register;
      CLKSEL   : CLKSEL_Register;
      PDBGCTL  : PDBGCTL_Register;
      MSA      : MSA_Register;
      MCTR     : MCTR_Register;
      MSR      : MSR_Register;
      MRXDATA  : MRXDATA_Register;
      MTXDATA  : MTXDATA_Register;
      MTPR     : MTPR_Register;
      MCR      : MCR_Register;
      MFIFOCTL : MFIFOCTL_Register;
      MFIFOSR  : MFIFOSR_Register;
      IMASK    : INT_Register;
      RIS      : INT_Register;
      MIS      : INT_Register;
      ISET     : INT_Register;
      ICLR     : INT_Register;
   end record
      with Volatile;

   for I2C_Peripheral use record
      PWREN    at 16#0800# range 0 .. 31;
      RSTCTL   at 16#0804# range 0 .. 31;
      CLKDIV   at 16#1000# range 0 .. 31;
      CLKSEL   at 16#1004# range 0 .. 31;
      IMASK    at 16#1028# range 0 .. 31;
      RIS      at 16#1030# range 0 .. 31;
      MIS      at 16#1038# range 0 .. 31;
      ISET     at 16#1040# range 0 .. 31;
      ICLR     at 16#1048# range 0 .. 31;
      PDBGCTL  at 16#1018# range 0 .. 31;
      MSA      at 16#1210# range 0 .. 31;
      MCTR     at 16#1214# range 0 .. 31;
      MSR      at 16#1218# range 0 .. 31;
      MRXDATA  at 16#121C# range 0 .. 31;
      MTXDATA  at 16#1220# range 0 .. 31;
      MTPR     at 16#1224# range 0 .. 31;
      MCR      at 16#1228# range 0 .. 31;
      MFIFOCTL at 16#1238# range 0 .. 31;
      MFIFOSR  at 16#123C# range 0 .. 31;
   end record;
end MSPM0.I2C;
