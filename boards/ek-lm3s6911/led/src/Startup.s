; <<< Use Configuration Wizard in Context Menu >>>
;******************************************************************************
;
; Startup.s - Startup code for Stellaris.
;
; Copyright (c) 2006-2007 Luminary Micro, Inc.  All rights reserved.
; 
; Software License Agreement
; 
; Luminary Micro, Inc. (LMI) is supplying this software for use solely and
; exclusively on LMI's microcontroller products.
; 
; The software is owned by LMI and/or its suppliers, and is protected under
; applicable copyright laws.  All rights are reserved.  Any use in violation
; of the foregoing restrictions may subject the user to criminal sanctions
; under applicable laws, as well as to civil liability for the breach of the
; terms and conditions of this license.
; 
; THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; LMI SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; 
; This is part of revision 1387 of the Stellaris Peripheral Driver Library.
;
;******************************************************************************

;******************************************************************************
;
; <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
;
;******************************************************************************
Stack   EQU     0x00000100

;******************************************************************************
;
; <o> Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
;
;******************************************************************************
Heap    EQU     0x00000000

;******************************************************************************
;
; Allocate space for the stack.
;
;******************************************************************************
        AREA    STACK, NOINIT, READWRITE, ALIGN=3
StackMem
        SPACE   Stack
__initial_sp

;******************************************************************************
;
; Allocate space for the heap.
;
;******************************************************************************
        AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
HeapMem
        SPACE   Heap
__heap_limit

;******************************************************************************
;
; Indicate that the code in this file preserves 8-byte alignment of the stack.
;
;******************************************************************************
        PRESERVE8

;******************************************************************************
;
; Place code into the reset code section.
;
;******************************************************************************
        AREA    RESET, CODE, READONLY
        THUMB

;******************************************************************************
;
; The vector table.
;
;******************************************************************************
        EXPORT  __Vectors
__Vectors
        DCD     StackMem + Stack            ;0 Top of Stack
        DCD     Reset_Handler               ;1 Reset Handler
        DCD     NmiSR                       ;2 NMI Handler
        DCD     FaultISR                    ;3 Hard Fault Handler
        DCD     IntDefaultHandler           ;4 MPU Fault Handler
        DCD     IntDefaultHandler           ;5 Bus Fault Handler
        DCD     IntDefaultHandler           ;6 Usage Fault Handler
        DCD     0                           ;7 Reserved
        DCD     0                           ;8 Reserved
        DCD     0                           ;9 Reserved
        DCD     0                           ;10 Reserved
        DCD     IntDefaultHandler           ;11 SVCall Handler
        DCD     IntDefaultHandler           ;12 Debug Monitor Handler
        DCD     0                           ;13 Reserved
        DCD     IntDefaultHandler           ;14 PendSV Handler
        DCD     IntDefaultHandler           ;15 SysTick Handler
        DCD     IntDefaultHandler           ;0 GPIO Port A
        DCD     IntDefaultHandler           ;1 GPIO Port B
        DCD     IntDefaultHandler           ;2 GPIO Port C
        DCD     IntDefaultHandler           ;3 GPIO Port D
        DCD     IntDefaultHandler           ;4 GPIO Port E
        DCD     IntDefaultHandler           ;5 UART0
        DCD     IntDefaultHandler           ;6 UART1
        DCD     IntDefaultHandler           ;7 SSI
        DCD     IntDefaultHandler           ;8 I2C
        DCD     IntDefaultHandler           ;9 PWM Fault
        DCD     IntDefaultHandler           ;10 PWM Generator 0
        DCD     IntDefaultHandler           ;11 PWM Generator 1
        DCD     IntDefaultHandler           ;12 PWM Generator 2
        DCD     IntDefaultHandler           ;13 Quadrature Encoder
        DCD     IntDefaultHandler           ;14 ADC Sequence 0
        DCD     IntDefaultHandler           ;15 ADC Sequence 1
        DCD     IntDefaultHandler           ;16 ADC Sequence 2
        DCD     IntDefaultHandler           ;17 ADC Sequence 3
        DCD     IntDefaultHandler           ;18 Watchdog
        DCD     IntDefaultHandler           ;19 Timer 0A
        DCD     IntDefaultHandler           ;20 Timer 0B
        DCD     IntDefaultHandler           ;21 Timer 1A
        DCD     IntDefaultHandler           ;22 Timer 1B
        DCD     IntDefaultHandler           ;23 Timer 2A
        DCD     IntDefaultHandler           ;24 Timer 2B
        DCD     IntDefaultHandler           ;25 Comp 0
        DCD     IntDefaultHandler           ;26 Comp 1
        DCD     IntDefaultHandler           ;27 Comp 2
        DCD     IntDefaultHandler           ;28 System Control
        DCD     IntDefaultHandler           ;29 Flash Control
        DCD     IntDefaultHandler           ;30 GPIO Port F
        DCD     IntDefaultHandler           ;31 GPIO Port G
        DCD     IntDefaultHandler           ;32 GPIO Port H
        DCD     IntDefaultHandler           ;33 UART2 Rx and Tx
        DCD     IntDefaultHandler           ;34 SSI1 Rx and Tx
        DCD     IntDefaultHandler           ;35 Timer 3 subtimer A
        DCD     IntDefaultHandler           ;36 Timer 3 subtimer B
        DCD     IntDefaultHandler           ;37 I2C1 Master and Slave
        DCD     IntDefaultHandler           ;38 Quadrature Encoder 1
        DCD     IntDefaultHandler           ;39 CAN0
        DCD     IntDefaultHandler           ;40 CAN1
        DCD     0                           ;41 Reserved
        DCD     IntDefaultHandler           ;42 Ethernet
        DCD     IntDefaultHandler           ;43 Hibernate

;******************************************************************************
;
; This is the code that gets called when the processor first starts execution
; following a reset event.
;
;******************************************************************************
        EXPORT  Reset_Handler
Reset_Handler
        ;
        ; Call the C library enty point that handles startup.  This will copy
        ; the .data section initializers from flash to SRAM and zero fill the
        ; .bss section.  It will then call __rt_entry, which will be either the
        ; C library version or the one supplied here depending on the
        ; configured startup type.
        ;
        IMPORT  __main
        B       __main

;******************************************************************************
;
; This is the code that gets called when the processor receives a NMI.  This
; simply enters an infinite loop, preserving the system state for examination
; by a debugger.
;
;******************************************************************************
NmiSR
        B       NmiSR

;******************************************************************************
;
; This is the code that gets called when the processor receives a fault
; interrupt.  This simply enters an infinite loop, preserving the system state
; for examination by a debugger.
;
;******************************************************************************
FaultISR
        B       FaultISR

;******************************************************************************
;
; This is the code that gets called when the processor receives an unexpected
; interrupt.  This simply enters an infinite loop, preserving the system state
; for examination by a debugger.
;
;******************************************************************************
IntDefaultHandler
        B       IntDefaultHandler

;******************************************************************************
;
; Make sure the end of this section is aligned.
;
;******************************************************************************
        ALIGN

;******************************************************************************
;
; Some code in the normal code section for initializing the heap and stack.
;
;******************************************************************************
        AREA    |.text|, CODE, READONLY

;******************************************************************************
;
; The function expected of the C library startup code for defining the stack
; and heap memory locations.  For the C library version of the startup code,
; provide this function so that the C library initialization code can find out
; the location of the stack and heap.
;
;******************************************************************************
    IF :DEF: __MICROLIB
        EXPORT  __initial_sp
        EXPORT  __heap_base
        EXPORT __heap_limit
    ELSE
        IMPORT  __use_two_region_memory
        EXPORT  __user_initial_stackheap
__user_initial_stackheap
        LDR     R0, =HeapMem
        LDR     R1, =(StackMem + Stack)
        LDR     R2, =(HeapMem + Heap)
        LDR     R3, =StackMem
        BX      LR
    ENDIF

;******************************************************************************
;
; Make sure the end of this section is aligned.
;
;******************************************************************************
        ALIGN

;******************************************************************************
;
; Tell the assembler that we're done.
;
;******************************************************************************
        END
