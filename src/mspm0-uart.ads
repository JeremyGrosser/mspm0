--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
pragma Style_Checks ("M120");

package MSPM0.UART
   with Pure
is
   type UART_CTL0_Register is record
      MSBFIRST    : Boolean := False;
      MAJVOTE     : Boolean := False;
      FEN         : Boolean := False;
      HSE         : UInt2 := 0;
      CTSEN       : Boolean := False;
      RTSEN       : Boolean := False;
      RTS         : Boolean := False;
      MODE        : UInt3 := 0;
      MENC        : Boolean := False;
      TXD_OUT     : Boolean := False;
      TXD_OUT_EN  : Boolean := True;
      TXE         : Boolean := True;
      RXE         : Boolean := True;
      LBE         : Boolean := False;
      ENABLE      : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for UART_CTL0_Register use record
      MSBFIRST    at 0 range 19 .. 19;
      MAJVOTE     at 0 range 18 .. 18;
      FEN         at 0 range 17 .. 17;
      HSE         at 0 range 15 .. 16;
      CTSEN       at 0 range 14 .. 14;
      RTSEN       at 0 range 13 .. 13;
      RTS         at 0 range 12 .. 12;
      MODE        at 0 range 8 .. 10;
      MENC        at 0 range 7 .. 7;
      TXD_OUT     at 0 range 6 .. 6;
      TXD_OUT_EN  at 0 range 5 .. 5;
      TXE         at 0 range 4 .. 4;
      RXE         at 0 range 3 .. 3;
      LBE         at 0 range 2 .. 2;
      ENABLE      at 0 range 0 .. 0;
   end record;

   type UART_LCRH_Register is record
      EXTDIR_HOLD    : UInt5 := 0;
      EXTDIR_SETUP   : UInt5 := 0;
      SENDIDLE       : Boolean := False;
      SPS            : Boolean := False;
      WLEN           : UInt2 := 0;
      STP2           : Boolean := False;
      EPS            : Boolean := False;
      PEN            : Boolean := False;
      BRK            : Boolean := False;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for UART_LCRH_Register use record
      EXTDIR_HOLD    at 0 range 21 .. 25;
      EXTDIR_SETUP   at 0 range 16 .. 20;
      SENDIDLE       at 0 range 7 .. 7;
      SPS            at 0 range 6 .. 6;
      WLEN           at 0 range 4 .. 5;
      STP2           at 0 range 3 .. 3;
      EPS            at 0 range 2 .. 2;
      PEN            at 0 range 1 .. 1;
      BRK            at 0 range 0 .. 0;
   end record;

   type UART_STAT_Register is record
      IDLE : Boolean;
      CTS  : Boolean;
      TXFF : Boolean;
      TXFE : Boolean;
      RXFF : Boolean;
      RXFE : Boolean;
      BUSY : Boolean;
   end record
      with Volatile_Full_Access,
           Async_Writers,
           Object_Size => 32;
   for UART_STAT_Register use record
      IDLE at 0 range 9 .. 9;
      CTS  at 0 range 8 .. 8;
      TXFF at 0 range 7 .. 7;
      TXFE at 0 range 6 .. 6;
      RXFF at 0 range 3 .. 3;
      RXFE at 0 range 2 .. 2;
      BUSY at 0 range 0 .. 0;
   end record;

   type UART_IFLS_Register is record
      RXTOSEL  : UInt4;
      RXIFLSEL : UInt3;
      TXIFLSEL : UInt3;
   end record
      with Volatile_Full_Access, Effective_Writes, Async_Readers, Object_Size => 32;
   for UART_IFLS_Register use record
      RXTOSEL  at 0 range 8 .. 11;
      RXIFLSEL at 0 range 4 .. 6;
      TXIFLSEL at 0 range 0 .. 2;
   end record;

   type UART_RXDATA_Register is record
      NERR   : Boolean;
      OVRERR : Boolean;
      BRKERR : Boolean;
      PARERR : Boolean;
      FRMERR : Boolean;
      DATA   : UInt8;
   end record
      with Volatile_Full_Access, Object_Size => 32;
   for UART_RXDATA_Register use record
      NERR   at 0 range 12 .. 12;
      OVRERR at 0 range 11 .. 11;
      BRKERR at 0 range 10 .. 10;
      PARERR at 0 range 9 .. 9;
      FRMERR at 0 range 8 .. 8;
      DATA   at 0 range 0 .. 7;
   end record;

   type UART_Peripheral is record
      PWREN    : UInt32;
      RSTCTL   : UInt32;
      CLKDIV   : CLKDIV_Register;
      CLKSEL   : CLKSEL_Register;
      CTL0     : UART_CTL0_Register;
      LCRH     : UART_LCRH_Register;
      STAT     : UART_STAT_Register;
      IFLS     : UART_IFLS_Register;
      IBRD     : UInt32;
      FBRD     : UInt32;
      TXDATA   : UInt32;
      RXDATA   : UART_RXDATA_Register;
   end record
      with Volatile, Effective_Writes, Effective_Reads, Async_Writers, Async_Readers;

   for UART_Peripheral use record
      PWREN    at 16#0800# range 0 .. 31;
      RSTCTL   at 16#0804# range 0 .. 31;
      CLKDIV   at 16#1000# range 0 .. 31;
      CLKSEL   at 16#1008# range 0 .. 31;
      CTL0     at 16#1100# range 0 .. 31;
      LCRH     at 16#1104# range 0 .. 31;
      STAT     at 16#1108# range 0 .. 31;
      IFLS     at 16#110C# range 0 .. 31;
      IBRD     at 16#1110# range 0 .. 31;
      FBRD     at 16#1114# range 0 .. 31;
      TXDATA   at 16#1120# range 0 .. 31;
      RXDATA   at 16#1124# range 0 .. 31;
   end record;
end MSPM0.UART;
