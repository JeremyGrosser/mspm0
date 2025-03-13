with System;

package MSPM0.DMA
   with Preelaborate
is
   type Channel_Id is range 0 .. 15;

   type INT_Register is record
      DATAERR : Boolean := False;
      ADDRERR : Boolean := False;
      PREIRQ  : UInt8 := 0;
      DMACH   : UInt16 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for INT_Register use record
      DATAERR  at 0 range 25 .. 25;
      ADDRERR  at 0 range 24 .. 24;
      PREIRQ   at 0 range 16 .. 23;
      DMACH    at 0 range 0 .. 15;
   end record;

   type Interrupt_Group is record
      IIDX  : UInt32 := 0;
      IMASK : INT_Register;
      RIS   : INT_Register;
      MIS   : INT_Register;
      ISET  : INT_Register;
      ICLR  : INT_Register;
   end record
      with Volatile;
   for Interrupt_Group use record
      IIDX  at 16#00# range 0 .. 31;
      IMASK at 16#08# range 0 .. 31;
      RIS   at 16#10# range 0 .. 31;
      MIS   at 16#18# range 0 .. 31;
      ISET  at 16#20# range 0 .. 31;
      ICLR  at 16#28# range 0 .. 31;
   end record;

   type DMATCTL_Register is record
      DMATINT : Boolean := False;
      DMATSEL : UInt6 := 0;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Object_Size => 32;
   for DMATCTL_Register use record
      DMATINT at 0 range 7 .. 7;
      DMATSEL at 0 range 0 .. 5;
   end record;

   type DMATCTL_Array is array (Channel_Id) of DMATCTL_Register
      with Component_Size => 32;

   type DMACTL_Register is record
      DMATM       : UInt2 := 0;
      DMAEM       : UInt2 := 0;
      DMADSTINCR  : UInt4 := 0;
      DMASRCINCR  : UInt4 := 0;
      DMADSTWDTH  : UInt2 := 0;
      DMASRCWDTH  : UInt2 := 0;
      DMAPREIRQ   : UInt3 := 0;
      DMAEN       : Boolean := False;
      DMAREQ      : Boolean := False;
   end record
      with Volatile_Full_Access,
           Effective_Writes,
           Async_Readers,
           Async_Writers,
           Object_Size => 32;
   for DMACTL_Register use record
      DMATM       at 0 range 28 .. 29;
      DMAEM       at 0 range 24 .. 25;
      DMADSTINCR  at 0 range 20 .. 23;
      DMASRCINCR  at 0 range 16 .. 19;
      DMADSTWDTH  at 0 range 12 .. 13;
      DMASRCWDTH  at 0 range 8 .. 9;
      DMAPREIRQ   at 0 range 4 .. 6;
      DMAEN       at 0 range 1 .. 1;
      DMAREQ      at 0 range 0 .. 0;
   end record;

   type DMA_Channel is record
      CTL   : DMACTL_Register;
      SA    : System.Address;
      DA    : System.Address;
      SZ    : UInt32;
   end record
      with Volatile;
   for DMA_Channel use record
      CTL   at 16#00# range 0 .. 31;
      SA    at 16#04# range 0 .. 31;
      DA    at 16#08# range 0 .. 31;
      SZ    at 16#0C# range 0 .. 31;
   end record;

   type DMA_Channel_Array is array (Channel_Id) of DMA_Channel
      with Component_Size => 128;

   type DMA_Peripheral is record
      FSUB_0      : UInt32;
      FSUB_1      : UInt32;
      FPUB_1      : UInt32;
      CPU_INT     : Interrupt_Group;
      GEN_EVENT   : Interrupt_Group;
      DMATCTL     : DMATCTL_Array;
      CH          : DMA_Channel_Array;
   end record
      with Volatile;
   for DMA_Peripheral use record
      FSUB_0      at 16#0400# range 0 .. 31;
      FSUB_1      at 16#0404# range 0 .. 31;
      FPUB_1      at 16#0444# range 0 .. 31;
      CPU_INT     at 16#1020# range 0 .. 351;
      GEN_EVENT   at 16#1050# range 0 .. 351;
      DMATCTL     at 16#1110# range 0 .. 511;
      CH          at 16#1200# range 0 .. 2047;
   end record;

end MSPM0.DMA;
