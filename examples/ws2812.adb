--
--  Copyright (C) 2025 Jeremy Grosser <jeremy@synack.me>
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with MSPM0.Device;
with MSPM0.TIM;
with MSPM0.DMA;
with MSPM0.NVIC;

package body WS2812 is
   TIMG : MSPM0.TIM.TIM_Peripheral renames MSPM0.Device.TIMG2;
   Channel : constant MSPM0.DMA.Channel_Id := 0;

   Pin_Mux : constant := MSPM0.Device.Mux.PA3;

   type Compare_Array is array (LED_Index, 0 .. 23) of UInt8
      with Component_Size => 8;
   CCVAL : aliased Compare_Array;
   CCVAL_0 : constant := 27;
   CCVAL_1 : constant := 14;

   procedure Init_TIMG is
      use MSPM0.Device;
   begin
      MSPM0.Device.PINCM (Pin_Mux) :=
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

      TIMG.RSTCTL := MSPM0.RSTCTL_RESET or 1;
      TIMG.PWREN := MSPM0.PWREN_ENABLE;
      TIMG.RSTCTL := MSPM0.RSTCTL_RESET;

      TIMG.ODIS := (others => True);
      TIMG.CLKSEL := (SEL => MSPM0.BUSCLK);
      TIMG.CTRCTL :=
         (CVAE       => 0,
          PLEN       => False,
          SLZERCNEZ  => False,
          FRB        => False,
          FB         => False,
          DRB        => False,
          CZC        => 0,
          CAC        => 0,
          CLC        => 0,
          CM         => 0,
          REPEAT     => 1,
          EN         => False);
      TIMG.LOAD := 40;
      TIMG.CC_0 := (CCVAL => CCVAL_0);
      TIMG.CCACT_0 :=
         (SWFRCACT_CMPL => 0,
          SWFRCACT      => 0,
          FEXACT        => 0,
          FENACT        => 0,
          CC2UACT       => MSPM0.TIM.Disabled,
          CC2DACT       => MSPM0.TIM.Disabled,
          CUACT         => MSPM0.TIM.Disabled,
          CDACT         => MSPM0.TIM.CCP_Low,
          LACT          => MSPM0.TIM.CCP_High,
          ZACT          => MSPM0.TIM.CCP_Low);
      TIMG.CCPD := (C0CCP0 => True, others => False);
      TIMG.OCTL_0 :=
         (CCPIV   => False,
          CCPOINV => False,
          CCPO    => 0);
      TIMG.ODIS := (C0CCP0 => False, others => True);

      --  Publish generic event channel 1 on LOAD
      TIMG.GEN_EVENT_0.IMASK := (L => True, others => False);
      TIMG.FPUB_0 := 1;

      TIMG.CTR := (CCTR => 0);
   end Init_TIMG;

   procedure Init_DMA is
      P : MSPM0.DMA.DMA_Peripheral renames MSPM0.Device.DMA;
   begin
      --  Subscribe Generic event channel 1 (TIMG LOAD)
      P.FSUB_0 := 1;

      P.DMATCTL (Channel) :=
         (DMATINT => False,
          DMATSEL => 1); --  trigger source FSUB_0
      P.CH (Channel) :=
         (CTL =>
            (DMATM      => 0,   --  single transfer per trigger
             DMAEM      => 0,
             DMADSTINCR => 0,
             DMASRCINCR => 3,    --  SRC is incremented by 1 byte per transfer
             DMADSTWDTH => 2,    --  32-bit destination
             DMASRCWDTH => 0,    --  8-bit source
             DMAPREIRQ  => 0,
             DMAEN      => False,
             DMAREQ     => False),
          SA => CCVAL'Address,
          DA => TIMG.CC_0'Address,
          SZ => 0);

      P.CPU_INT.IMASK := (DMACH => 1, others => <>);
      --  interrupt on DMA complete
      MSPM0.NVIC.Enable (MSPM0.Device.IRQ.DMA);
   end Init_DMA;

   procedure Initialize is
   begin
      Init_TIMG;
      Init_DMA;

      for LED in LED_Index'Range loop
         Set_Color (LED, (0, 0, 0));
      end loop;
   end Initialize;

   procedure Set_Color
      (LED : LED_Index;
       Color : RGB)
   is
      Data : UInt32;
   begin
      Data := Shift_Left (UInt32 (Color.G), 16) or
              Shift_Left (UInt32 (Color.R), 8) or
              UInt32 (Color.B);
      for I in 0 .. 23 loop
         if (Shift_Right (Data, 23 - I) and 1) = 0 then
            CCVAL (LED, I) := CCVAL_0;
         else
            CCVAL (LED, I) := CCVAL_1;
         end if;
      end loop;
   end Set_Color;

   procedure Update is
      P : MSPM0.DMA.DMA_Peripheral renames MSPM0.Device.DMA;
      DMAEN : Boolean;
   begin
      --  Start DMA transfer from CCVAL to CC_0, triggered by TIMG LOAD event
      P.CH (Channel).DA := TIMG.CC_0'Address;
      P.CH (Channel).SA := CCVAL'Address;
      P.CH (Channel).SZ := 24 * LED_Count;
      P.CH (Channel).CTL.DMAEN := True;

      TIMG.CTRCTL.EN := True;

      --  Wait for DMA complete
      loop
         DMAEN := P.CH (Channel).CTL.DMAEN;
         exit when not DMAEN;
      end loop;
      P.GEN_EVENT.ICLR := (DMACH => 1, others => <>);
   end Update;

   procedure DMA_IRQHandler is
   begin
      --  DMA complete, stop timer, idle low (ZCOND)
      TIMG.CTRCTL.EN := False;
      TIMG.CTR := (CCTR => 0);
   end DMA_IRQHandler;

end WS2812;
