#
# Assembler program to flash three LEDs connnected to the
# Raspberry Pi GPIO port using direct memory access.
#
# s11 - loop variable to flash lights 10 times
#

#include "gpiomem.S"

.global _start	            # Provide program starting address
_start:
 	mapMem
        nanoSleep         
        
       GPIODirectionOut 50
       GPIODirectionOut 54
       GPIODirectionOut 51
        # setup a loop counter for 10 iterations
        li		s11, 10

loop:
	GPIOTurnOn   50    
        nanoSleep
        GPIOTurnOff   50
        GPIOTurnOn    54
        nanoSleep
        GPIOTurnOff   54
        GPIOTurnOn    51
        nanoSleep
        GPIOTurnOff   51
        #decrement loop counter and see if we loop
        addi		s11, s11, -1      # Subtract 1 from loop register
        bnez		s11, loop        # If we haven't counted down to 0 then loop

_end:	li	a0, 0	# Use 0 return code
	li	a7, __NR_exit
	ecall		# Call Linux to terminate
