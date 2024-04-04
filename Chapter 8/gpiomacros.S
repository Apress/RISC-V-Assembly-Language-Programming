# Various macros to access the GPIO pins
# on the Raspberry Pi.
#
# t3 - file descriptor.
#

#include "fileio.S"

# Macro nanoSleep to sleep .1 second
# Calls Linux nanosleep entry point.
# Pass a reference to a timespec in both a0 and a1
# First is input time to sleep in seconds and nanoseconds.
# Second is time left to sleep if interrupted (which we ignore)
.macro  nanoSleep
        la	a0, timespecsec
        la	a1, timespecsec
        li	a7, __NR_nanosleep
        ecall
.endm
.macro  GPIOExport  pin
        openFile	gpioexp, O_WRONLY
        mv		t3, a0      # save the file descriptor
        writeFile	t3, \pin, 2

        flushClose	t3
.endm
.macro  GPIODirectionOut   pin
        # copy pin into filename pattern
        la		a1, \pin
        la		a2, gpiopinfile
        addi		a2, a2, 20
        lb		a3, 0(a1)	# load pin digit
	addi		a1, a1, 1	# increment for second digit
        sb		a3, 0(a2)	# store to filename
	addi		a2, a2, 1	# increment for second digit
        lb		a3, 0(a1)
        sb		a3, 0(a2)
        openFile	gpiopinfile, O_WRONLY
        mv		t3, a0		# save the file descriptor
        writeFile	t3, outstr, 3
        flushClose	t3
.endm
.macro  GPIOWrite   pin, value
        # copy pin into filename pattern
	la		a1, \pin
        la		a2, gpiovaluefile
        addi		a2, a2, 20
        lb		a3, 0(a1)	# load pin digit
	addi		a1, a1, 1	# increment for second digit
        sb		a3, 0(a2)	# store to filename
	addi		a2, a2, 1	# increment for second digit
        lb		a3, 0(a1)
        sb		a3, 0(a2) 
        openFile	gpiovaluefile, O_WRONLY
        mv		t3, a0		# save the file descriptor
        writeFile	t3, \value, 1
        flushClose	t3
.endm

.data
timespecsec:   .dword   0
timespecnano:  .dword   100000000
gpioexp:    .asciz  "/sys/class/gpio/export"
gpiopinfile: .asciz "/sys/class/gpio/gpioxx/direction"
gpiovaluefile: .asciz "/sys/class/gpio/gpioxx/value"
outstr:     .asciz  "out"
            .align  4          # save users of this file having to do this.
.text
