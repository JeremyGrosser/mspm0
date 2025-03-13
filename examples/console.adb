--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with MSPM0.Device; use MSPM0.Device;

package body Console is

   RXD_Mux : constant := Mux.PA22;
   TXD_Mux : constant := Mux.PA23;

   procedure Initialize is
   begin
      PINCM (TXD_Mux) :=
         (PC => True,
          PF => 6,
          others => False);
      PINCM (RXD_Mux) :=
         (PC => True,
          PF => 6,
          INENA => True,
          others => <>);

      UART_1.RSTCTL := RSTCTL_RESET;
      UART_1.PWREN := PWREN_ENABLE;

      SYSCTL.MCLKCFG.USEMFTICK := True;
      UART_1.CLKSEL.SEL := MFCLK;
      UART_1.CLKDIV.RATIO := 0;
      UART_1.CTL0.ENABLE := False;
      UART_1.IBRD := 2;
      UART_1.FBRD := 11;

      UART_1.CTL0 :=
         (MSBFIRST   => False,
          MAJVOTE    => False,
          FEN        => True,
          HSE        => 0,
          CTSEN      => False,
          RTSEN      => False,
          RTS        => False,
          MODE       => 0,
          MENC       => False,
          TXD_OUT    => False,
          TXD_OUT_EN => True,
          TXE        => True,
          RXE        => True,
          LBE        => False,
          ENABLE     => False);

      --  UART_1.IFLS.RXIFLSEL := 7; --  Interrupt on RXF not empty
      --  UART_1.IFLS.TXIFLSEL := 5; --  Interrupt on TXF empty
      UART_1.LCRH.WLEN := 3;
      UART_1.CTL0.ENABLE := True;
   end Initialize;

   procedure Put
      (Data : UInt8)
   is
      TX_FIFO_Full, TX_FIFO_Empty : Boolean;
   begin
      loop
         TX_FIFO_Full := UART_1.STAT.TXFF;
         exit when not TX_FIFO_Full;
      end loop;
      UART_1.TXDATA := UInt32 (Data);
      loop
         TX_FIFO_Empty := UART_1.STAT.TXFE;
         exit when TX_FIFO_Empty;
      end loop;
   end Put;

   procedure Put
      (Ch : Character)
   is
   begin
      Put (UInt8 (Character'Pos (Ch)));
   end Put;

   procedure Put
      (Str : String)
   is
   begin
      for I in Str'Range loop
         Put (Str (I));
      end loop;
   end Put;

   procedure New_Line is
   begin
      Put (ASCII.CR);
      Put (ASCII.LF);
   end New_Line;

   procedure Put_Line
      (Line : String)
   is
   begin
      Put (Line);
      New_Line;
   end Put_Line;

   procedure Data_Ready
      (Ready : out Boolean)
   is
   begin
      Ready := UART_1.STAT.RXFE;
      Ready := not Ready;
   end Data_Ready;

   procedure Get
      (Ch : out Character)
   is
      RX_FIFO_Empty : Boolean;
      Data : UInt8;
   begin
      RX_FIFO_Empty := UART_1.STAT.RXFE;
      if RX_FIFO_Empty then
         Ch := ASCII.NUL;
      else
         Data := UART_1.RXDATA.DATA;
         Ch := Character'Val (Natural (Data));
      end if;
   end Get;
end Console;
