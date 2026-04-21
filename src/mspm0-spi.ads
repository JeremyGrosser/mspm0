--
--  Copyright (C) 2026 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");

package MSPM0.SPI
   with Pure
is
   type IIDX_STAT_Field is
      (No_Interrupt,
       RX_FIFO_Overflow,
       TX_Parity,
       RX_Timeout,
       RX,
       TX,
       TX_FIFO_Empty,
       TX_Done,
       RX_DMA_Done,
       TX_DMA_Done,
       TX_FIFO_Underflow,
       RX_FIFO_Full);

   type IIDX_Register is record
      STAT : IIDX_STAT_Field := No_Interrupt;
   end record
      with Volatile_Full_Access, Async_Writers, Object_Size => 32;
   for IIDX_Register use record
      STAT at 0 range 0 .. 7;
   end record;

   type IMASK_Register is record
      RXFULL      : Boolean;
      TXFIFO_UNF  : Boolean;
      DMA_DONE_TX : Boolean;
      DMA_DONE_RX : Boolean;
      IDLE        : Boolean;
      TXEMPTY     : Boolean;
      TX          : Boolean;
      RX          : Boolean;
      RTOUT       : Boolean;
      PER         : Boolean;
      RXFIFO_OVF  : Boolean;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Async_Writers, Object_Size => 32;
   for IMASK_Register use record
      RXFULL      at 0 range 10 .. 10;
      TXFIFO_UNF  at 0 range 9 .. 9;
      DMA_DONE_TX at 0 range 8 .. 8;
      DMA_DONE_RX at 0 range 7 .. 7;
      IDLE        at 0 range 6 .. 6;
      TXEMPTY     at 0 range 5 .. 5;
      TX          at 0 range 4 .. 4;
      RX          at 0 range 3 .. 3;
      RTOUT       at 0 range 2 .. 2;
      PER         at 0 range 1 .. 1;
      RXFIFO_OVF  at 0 range 0 .. 0;
   end record;

   type Interrupt_Group is record
      IIDX : IIDX_Register;
      IMASK, RIS, MIS, ISET, ICLR : IMASK_Register;
   end record
      with Volatile, Effective_Writes, Async_Readers, Async_Writers;
   for Interrupt_Group use record
      IIDX  at 16#00# range 0 .. 31;
      IMASK at 16#08# range 0 .. 31;
      RIS   at 16#10# range 0 .. 31;
      MIS   at 16#18# range 0 .. 31;
      ISET  at 16#20# range 0 .. 31;
      ICLR  at 16#28# range 0 .. 31;
   end record;

   type CTL0_Register is record
      CSCLR    : Boolean := False;
      CSSEL    : UInt2 := 0;
      SPH      : Boolean := False;
      SPO      : Boolean := False;
      PACKEN   : Boolean := False;
      FRF      : UInt2 := 0;
      DSS      : UInt5 := 0;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CTL0_Register use record
      CSCLR    at 0 range 14 .. 14;
      CSSEL    at 0 range 12 .. 13;
      SPH      at 0 range 9 .. 9;
      SPO      at 0 range 8 .. 8;
      PACKEN   at 0 range 7 .. 7;
      FRF      at 0 range 5 .. 6;
      DSS      at 0 range 0 .. 4;
   end record;

   type CTL1_Register is record
      RXTIMEOUT   : UInt6 := 0;
      REPEATTX    : UInt8 := 0;
      CDMODE      : UInt4 := 0;
      CDENABLE    : Boolean := False;
      PTEN        : Boolean := False;
      PES         : Boolean := False;
      PREN        : Boolean := False;
      MSB         : Boolean := False;
      POD         : Boolean := False;
      CP          : Boolean := True;
      LBM         : Boolean := False;
      ENABLE      : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CTL1_Register use record
      RXTIMEOUT   at 0 range 24 .. 29;
      REPEATTX    at 0 range 16 .. 23;
      CDMODE      at 0 range 12 .. 15;
      CDENABLE    at 0 range 11 .. 11;
      PTEN        at 0 range 8 .. 8;
      PES         at 0 range 6 .. 6;
      PREN        at 0 range 5 .. 5;
      MSB         at 0 range 4 .. 4;
      POD         at 0 range 3 .. 3;
      CP          at 0 range 2 .. 2;
      LBM         at 0 range 1 .. 1;
      ENABLE      at 0 range 0 .. 0;
   end record;

   type CLKCTL_Register is record
      DSAMPLE  : UInt4 := 0;
      SCR      : UInt10 := 0;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for CLKCTL_Register use record
      DSAMPLE  at 0 range 28 .. 31;
      SCR      at 0 range 0 .. 9;
   end record;

   type IFLS_Register is record
      RXIFLSEL : UInt3 := 2;
      TXIFLSEL : UInt3 := 2;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for IFLS_Register use record
      RXIFLSEL at 0 range 3 .. 5;
      TXIFLSEL at 0 range 0 .. 2;
   end record;

   type STAT_Register is record
      BUSY  : Boolean := False;
      RNF   : Boolean := False;
      RFE   : Boolean := False;
      TNF   : Boolean := False;
      TFE   : Boolean := False;
   end record
      with Volatile_Full_Access, Async_Writers, Object_Size => 32;
   for STAT_Register use record
      BUSY  at 0 range 4 .. 4;
      RNF   at 0 range 3 .. 3;
      RFE   at 0 range 2 .. 2;
      TNF   at 0 range 1 .. 1;
      TFE   at 0 range 0 .. 0;
   end record;

   type SPI_Peripheral is record
      PWREN       : UInt32;
      RSTCTL      : UInt32;
      CLKDIV      : CLKDIV_Register;
      CLKSEL      : CLKSEL_Register;
      PDBGCTL     : PDBGCTL_Register;
      CPU_INT     : Interrupt_Group;
      DMA_TRIG_RX : Interrupt_Group;
      DMA_TRIG_TX : Interrupt_Group;
      CTL0        : CTL0_Register;
      CTL1        : CTL1_Register;
      CLKCTL      : CLKCTL_Register;
      IFLS        : IFLS_Register;
      STAT        : STAT_Register;
      RXDATA      : UInt32;
      TXDATA      : UInt32;
   end record
      with Volatile, Effective_Writes, Effective_Reads, Async_Writers, Async_Readers;

   for SPI_Peripheral use record
      PWREN       at 16#0800# range 0 .. 31;
      RSTCTL      at 16#0804# range 0 .. 31;
      CLKDIV      at 16#1000# range 0 .. 31;
      CLKSEL      at 16#1004# range 0 .. 31;
      PDBGCTL     at 16#1018# range 0 .. 31;
      CPU_INT     at 16#1020# range 0 .. 351;
      DMA_TRIG_RX at 16#1050# range 0 .. 351;
      DMA_TRIG_TX at 16#1080# range 0 .. 351;
      CTL0        at 16#1100# range 0 .. 31;
      CTL1        at 16#1104# range 0 .. 31;
      CLKCTL      at 16#1108# range 0 .. 31;
      IFLS        at 16#110C# range 0 .. 31;
      STAT        at 16#1110# range 0 .. 31;
      RXDATA      at 16#1130# range 0 .. 31;
      TXDATA      at 16#1140# range 0 .. 31;
   end record;

end MSPM0.SPI;
