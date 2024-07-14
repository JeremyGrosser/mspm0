--
--  Copyright (C) 2024 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with MSPM0.Device; use MSPM0.Device;
with MSPM0.GPIO; use MSPM0.GPIO;

package body Console is

   Mode : PINCM_Register :=
      (WCOMP      => False,
       WUEN       => False,
       INV        => False,
       HIZ1       => False,
       DRV        => False,
       HYSTEN     => False,
       INENA      => False,
       PIPU       => False,
       PIPD       => False,
       WAKESTAT   => False,
       PC         => True,
       PF         => 2);

   procedure Initialize is
   begin
      --  PA10 UART0_TX
      --  PA11 UART0_RX
      PINCM (Mux.PA10) := Mode;
      Mode.INENA := True;
      PINCM (Mux.PA11) := Mode;

      UART_0.RSTCTL := RSTCTL_RESET;
      UART_0.PWREN := PWREN_ENABLE;

      SYSCTL.MCLKCFG.USEMFTICK := True;
      UART_0.CLKSEL.SEL := MFCLK;
      UART_0.CLKDIV.RATIO := 0;
      UART_0.CTL0.ENABLE := False;
      UART_0.IBRD := 2;
      UART_0.FBRD := 11;

      UART_0.CTL0 :=
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

      --  UART_0.IFLS.RXIFLSEL := 7; --  Interrupt on RXF not empty
      --  UART_0.IFLS.TXIFLSEL := 5; --  Interrupt on TXF empty
      UART_0.LCRH.WLEN := 3;
      UART_0.CTL0.ENABLE := True;
   end Initialize;

   procedure Put
      (Data : UInt8)
   is
      TX_FIFO_Full, TX_FIFO_Empty : Boolean;
   begin
      loop
         TX_FIFO_Full := UART_0.STAT.TXFF;
         exit when not TX_FIFO_Full;
      end loop;
      UART_0.TXDATA := UInt32 (Data);
      loop
         TX_FIFO_Empty := UART_0.STAT.TXFE;
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
      Ready := UART_0.STAT.RXFE;
      Ready := not Ready;
   end Data_Ready;

   procedure Get
      (Ch : out Character)
   is
      RX_FIFO_Empty : Boolean;
      Data : UInt8;
   begin
      RX_FIFO_Empty := UART_0.STAT.RXFE;
      if RX_FIFO_Empty then
         Ch := ASCII.NUL;
      else
         Data := UART_0.RXDATA.DATA;
         Ch := Character'Val (Natural (Data));
      end if;
   end Get;
end Console;
