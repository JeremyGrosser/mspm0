/*****************************************************************************

  Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions
  are met:

   Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

   Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the
   distribution.

   Neither the name of Texas Instruments Incorporated nor the names of
   its contributors may be used to endorse or promote products derived
   from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*****************************************************************************/

#include <stdint.h>

/* Entry point for the application. */
extern void SystemInit(void);
extern int  main( void );

extern uint32_t __data_load__;
extern uint32_t __data_start__;
extern uint32_t __data_end__;
extern uint32_t __ramfunct_load__;
extern uint32_t __ramfunct_start__;
extern uint32_t __ramfunct_end__;
extern uint32_t __bss_start__;
extern uint32_t __bss_end__;
extern uint32_t __StackTop;

typedef void( *pFunc )( void );

/* Forward declaration of the default fault handlers. */
void Default_Handler(void);
extern void Reset_Handler       (void) __attribute__((weak));
extern void __libc_init_array(void);

/* Processor Exceptions */
extern void NMI_Handler         (void) __attribute__((weak, alias("Default_Handler")));
extern void HardFault_Handler   (void) __attribute__((weak, alias("Default_Handler")));
extern void SVC_Handler         (void) __attribute__((weak, alias("Default_Handler")));
extern void PendSV_Handler      (void) __attribute__((weak, alias("Default_Handler")));
extern void SysTick_Handler     (void) __attribute__((weak, alias("Default_Handler")));

/* Device Specific Interrupt Handlers */
extern void GROUP0_IRQHandler   (void) __attribute__((weak, alias("Default_Handler")));
extern void GROUP1_IRQHandler   (void) __attribute__((weak, alias("Default_Handler")));
extern void TIMG1_IRQHandler    (void) __attribute__((weak, alias("Default_Handler")));
extern void ADC0_IRQHandler     (void) __attribute__((weak, alias("Default_Handler")));
extern void SPI0_IRQHandler     (void) __attribute__((weak, alias("Default_Handler")));
extern void UART1_IRQHandler    (void) __attribute__((weak, alias("Default_Handler")));
extern void UART0_IRQHandler    (void) __attribute__((weak, alias("Default_Handler")));
extern void TIMG0_IRQHandler    (void) __attribute__((weak, alias("Default_Handler")));
extern void TIMG2_IRQHandler    (void) __attribute__((weak, alias("Default_Handler")));
extern void TIMG4_IRQHandler    (void) __attribute__((weak, alias("Default_Handler")));
extern void I2C0_IRQHandler     (void) __attribute__((weak, alias("Default_Handler")));
extern void I2C1_IRQHandler     (void) __attribute__((weak, alias("Default_Handler")));
extern void DMA_IRQHandler      (void) __attribute__((weak, alias("Default_Handler")));


/* Interrupt vector table.  Note that the proper constructs must be placed on this to */
/* ensure that it ends up at physical address 0x0000.0000 or at the start of          */
/* the program if located at a start address other than 0.                            */
void (* const interruptVectors[])(void) __attribute__ ((used)) __attribute__ ((section (".intvecs"))) =
{
    (pFunc)&__StackTop,                    /* The initial stack pointer */
    Reset_Handler,                         /* The reset handler         */
    NMI_Handler,                           /* The NMI handler           */
    HardFault_Handler,                     /* The hard fault handler    */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    SVC_Handler,                           /* SVCall handler            */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    PendSV_Handler,                        /* The PendSV handler        */
    SysTick_Handler,                       /* SysTick handler           */
    GROUP0_IRQHandler,                     /* GROUP0 interrupt handler  */
    GROUP1_IRQHandler,                     /* GROUP1 interrupt handler  */
    TIMG1_IRQHandler,                      /* TIMG1 interrupt handler   */
    0,                                     /* Reserved                  */
    ADC0_IRQHandler,                       /* ADC0 interrupt handler    */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    SPI0_IRQHandler,                       /* SPI0 interrupt handler    */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    UART1_IRQHandler,                      /* UART1 interrupt handler   */
    0,                                     /* Reserved                  */
    UART0_IRQHandler,                      /* UART0 interrupt handler   */
    TIMG0_IRQHandler,                      /* TIMG0 interrupt handler   */
    0,                                     /* Reserved                  */
    TIMG2_IRQHandler,                      /* TIMG2 interrupt handler   */
    0,                                     /* Reserved                  */
    TIMG4_IRQHandler,                      /* TIMG4 interrupt handler   */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    I2C0_IRQHandler,                       /* I2C0 interrupt handler    */
    I2C1_IRQHandler,                       /* I2C1 interrupt handler    */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    0,                                     /* Reserved                  */
    DMA_IRQHandler,                        /* DMA interrupt handler     */

};

/* Forward declaration of the default fault handlers. */
/* This is the code that gets called when the processor first starts execution */
/* following a reset event.  Only the absolutely necessary set is performed,   */
/* after which the application supplied entry() routine is called.  Any fancy  */
/* actions (such as making decisions based on the reset cause register, and    */
/* resetting the bits in that register) are left solely in the hands of the    */
/* application.                                                                */
void Reset_Handler(void)
{
    uint32_t *pui32Src, *pui32Dest;
    uint32_t *bs, *be;

    //
    // Copy the data segment initializers from flash to SRAM.
    //
    pui32Src = &__data_load__;
    for(pui32Dest = &__data_start__; pui32Dest < &__data_end__; )
    {
        *pui32Dest++ = *pui32Src++;
    }

    //
    // Copy the ramfunct segment initializers from flash to SRAM.
    //
    pui32Src = &__ramfunct_load__;
    for(pui32Dest = &__ramfunct_start__; pui32Dest < &__ramfunct_end__; )
    {
        *pui32Dest++ = *pui32Src++;
    }

    // Initialize .bss to zero
    bs = &__bss_start__;
    be = &__bss_end__;
    while (bs < be)
    {
        *bs = 0;
        bs++;
    }

    /*
     * System initialization routine can be called here, but it's not
     * required for MSPM0.
     */
    // SystemInit();

	//
	// Initialize virtual tables, along executing init, init_array, constructors
	// and preinit_array functions
	//
	//  __libc_init_array();

    //
    // Call the application's entry point.
    //
    main();

    //
    // If we ever return signal Error
    //
    HardFault_Handler();
}

#define SCB_BASE                (0xE000E000UL + 0x0D00UL)                    /* System Control Block Base Address */
#define SCB_AIRCR               (*(volatile uint32_t *)(SCB_BASE + 0x00CUL)) /* Application Interrupt and Reset Control Register */
#define SCB_AIRCR_VECTKEY_POS   16                                        /* Vector Key Position */
#define SCB_AIRCR_VECTKEY_MASK  (0xFFFFUL << SCB_AIRCR_VECTKEY_POS)       /* Vector Key Mask */
#define SCB_AIRCR_VECTKEY       (0x5FAUL << SCB_AIRCR_VECTKEY_POS)        /* Vector Key */
#define SCB_AIRCR_SYSRESETREQ   (1UL << 2)                                /* System Reset Request */

void Default_Handler(void)
{
    // ensure all memory writes are complete
    __asm volatile("dsb");

    // break if a debugger is attached
    __asm volatile("bkpt #1");

    // reset
    SCB_AIRCR = SCB_AIRCR_VECTKEY | SCB_AIRCR_SYSRESETREQ;

    // wait for reset
    while(1)
    {
    }
}
