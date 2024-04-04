#
# Assembler program to flash three LEDs connnected to the
# Starfive Visionfive 2 GPIO port.
#
# t0 - loop variable to flash lights 10 times
#

#include "gpiomacros.S"

.global _start	            # Provide program starting address to linker
_start: GPIOExport  pin50
        GPIOExport  pin54
        GPIOExport  pin51
        nanoSleep

        GPIODirectionOut pin50
        GPIODirectionOut pin54
        GPIODirectionOut pin51
        # setup a loop counter for 10 iterations
        li	t0, 10

loop:   GPIOWrite   pin50, high
        nanoSleep
        GPIOWrite   pin50, low
        GPIOWrite   pin54, high
        nanoSleep
        GPIOWrite   pin54, low
        GPIOWrite   pin51, high
        nanoSleep
        GPIOWrite   pin51, low
        #decrement loop counter and see if we loop
        addi		t0, t0, -1      # Subtract 1 from loop register
        bnez		t0, loop        # If not 0 then loop

_end:   li	a0, 0	# Use 0 return code
	li	a7, __NR_exit
	ecall		# Call Linux to terminate

pin50:      .asciz  "50"
pin54:      .asciz  "54"
pin51:      .asciz  "51"
low:        .asciz  "0"
high:       .asciz  "1"
