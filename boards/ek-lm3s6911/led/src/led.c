//*****************************************************************************
//MCU123 LM3S69XX LED Demo
//*****************************************************************************

#include "hw_memmap.h"
#include "hw_types.h"
#include "debug.h"
#include "gpio.h"
#include "sysctl.h"

#define LED1	GPIO_PIN_6	  //对应L1
#define LED2	GPIO_PIN_7	  //对应L2

#ifdef DEBUG
void
__error__(char *pcFilename, unsigned long ulLine)
{
}
#endif


int
main(void)
{
    volatile unsigned long ulLoop;

    //
    // Set the clocking to run directly from the crystal.
    //
    SysCtlClockSet(SYSCTL_SYSDIV_1 | SYSCTL_USE_OSC | SYSCTL_OSC_MAIN |
                   SYSCTL_XTAL_6MHZ);

    //
    // Configure the GPIO that drives the on-board LED.
    //
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOD); //
    GPIOPadConfigSet(GPIO_PORTD_BASE, LED1, GPIO_STRENGTH_2MA,
                     GPIO_PIN_TYPE_STD);
    GPIODirModeSet(GPIO_PORTD_BASE, LED1, GPIO_DIR_MODE_OUT);
	GPIOPadConfigSet(GPIO_PORTD_BASE, LED2, GPIO_STRENGTH_2MA,
                     GPIO_PIN_TYPE_STD);
    GPIODirModeSet(GPIO_PORTD_BASE, LED2, GPIO_DIR_MODE_OUT);
	//beep
	 SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOB);
    GPIOPadConfigSet(GPIO_PORTB_BASE, GPIO_PIN_0, GPIO_STRENGTH_2MA,
                     GPIO_PIN_TYPE_STD);
    GPIODirModeSet(GPIO_PORTB_BASE, GPIO_PIN_0, GPIO_DIR_MODE_OUT);
    //
    // Loop forever.
    //
    while(1)
    {
        //
        // Turn on the LED.
        //
        GPIOPinWrite(GPIO_PORTD_BASE, LED1, LED1);
		GPIOPinWrite(GPIO_PORTD_BASE, LED2, 0);
        GPIOPinWrite(GPIO_PORTB_BASE, GPIO_PIN_0, 0);
		//
        // Delay for a bit.
        //
        for(ulLoop = 0; ulLoop < 200000; ulLoop++)
        {
        }

        //
        // Turn off the LED .
        //
        GPIOPinWrite(GPIO_PORTD_BASE, LED1, 0);
	    GPIOPinWrite(GPIO_PORTD_BASE, LED2, LED2);
		GPIOPinWrite(GPIO_PORTB_BASE, GPIO_PIN_0, GPIO_PIN_0);
        //
        // Delay for a bit.
        //
        for(ulLoop = 0; ulLoop < 200000; ulLoop++)
        {
        }
    }
}
