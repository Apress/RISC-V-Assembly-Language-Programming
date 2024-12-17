# Various macros to access the GPIO pins
# on the Starfive Visionfive 2.
#
# t6 - memory map address.
# Macros use registers: a0, a1, a2, a3, a4, a5, a7, t5
#

#include "fileio.S"

.equ	pagelen, 512
.equ	setregoffset, 0x40
.equ	PROT_READ, 1
.equ	PROT_WRITE, 2
.equ	MAP_SHARED, 1
.equ	DOUT_MASK, 0x7f
.equ	DOEN_MASK, 0x3f

# Macro to map memory for GPIO Registers
.macro mapMem
	openFile	devmem, O_RDWR	# open /dev/mem
	mv		a4, a0		# fd for memmap
	# check for error and print error msg if necessary
	bgez		a4, 1f		# pos number file opened ok
	li		a1, 1		# stdout
	lw		a2, memOpnsz	# Error msg
	writeFileReg	a1, memOpnErr, a2 # print the error
	j		_end

# Setup can call the mmap2 Linux service
1:	ld		a5, gpioaddr	# address we want / 4096	
	li		a1, pagelen	# size of mem we want
	li		a2, (PROT_READ + PROT_WRITE) # mem protection options
	li		a3, MAP_SHARED	# mem share options
	li		a0, 0		# let linux choose a virtual address
	li		a7, __NR_mmap	# mmap service num
	ecall				# call service
	mv		t6, a0		# keep the returned virtual address
	# check for error and print error msg if necessary
	bgez		t6, 2f		# pos number file opened ok
	li		a1, 1		# stdout
	lw		a2, memMapsz	# Error msg
	writeFileReg	a1, memMapErr, a2 # print the error
	j		_end
2:
.endm

# Macro nanoSleep to sleep .1 second
# Calls Linux nanosleep entry point which is function __NR_nanosleep.
# Pass a reference to a timespec in both a0 and a1
# First is input time to sleep in seconds and nanoseconds.
# Second is time left to sleep if interrupted (which we ignore)
.macro  nanoSleep
        la	a0, timespecsec
        la	a1, timespecsec
        li	a7, __NR_nanosleep
	ecall
.endm
.macro  GPIODirectionOut   pin
	li	a0, \pin	# pin to turn on
	srli	a1, a0, 2	# pin offset div by 4
	slli	a1, a1, 2	# mult by 4, now multiple of 4
	sub	a2, a0, a1	# shift value start with remainder
	slli	a2, a2, 3	# multiply by 8 (bits per gpio)
	li	a3, DOEN_MASK	# mask
	sll	a3, a3, a2	# shift into position
	not	a3, a3		# ones complement bits for anding

	add	a4, t6, a1	# add to base address	
	lwu	a5, 0(a4)	# load register value	
	and	a0, a3, a5	# and value to reg value

	sw	a0, 0(a4)	# write to the register
.endm
.macro  GPIOTurnOn   pin
	li	a0, \pin	# pin to turn on
	srli	a1, a0, 2	# pin offset div by 4
	slli	a1, a1, 2	# mult by 4, now multiple of 4
	sub	a2, a0, a1	# shift value start with remainder
	slli	a2, a2, 3	# multiply by 8 (bits per gpio)
	li	a3, DOUT_MASK	# mask
	sll	a3, a3, a2	# shift into position
	not	a3, a3		# ones complement bits for anding
	
	add	a4, t6, a1	# add to base address
	addi	a4, a4, setregoffset # add offset to write registers
	lwu	a5, 0(a4)	# load register value	
	and	a0, a3, a5	# and value to reg value

	li	a3, 1		# load 1 to set on
	sll	a3, a3, a2	# shift into place
	add	a0, a0, a3	# add to register value
	sw	a0, 0(a4)	# write to the register
.endm
.macro  GPIOTurnOff   pin
	li	a0, \pin	# pin to turn on
	srli	a1, a0, 2	# pin offset div by 4
	slli	a1, a1, 2	# mult by 4, now multiple of 4
	sub	a2, a0, a1	# shift value start with remainder
	slli	a2, a2, 3	# multiply by 8 (bits per gpio)
	li	a3, DOUT_MASK	# mask
	sll	a3, a3, a2	# shift into position
	not	a3, a3		# ones complement bits for anding
	
	add	a4, t6, a1	# add to base address
	addi	a4, a4, setregoffset # add offset to write registers
	lwu	a5, 0(a4)	# load register value	
	and	a0, a3, a5	# and value to reg value

	sw	a0, 0(a4)	# write to the register
.endm

.data
timespecsec:   .dword   0
timespecnano:  .dword   100000000
devmem:	       .asciz  "/dev/mem"
memOpnErr:     .asciz  "Failed to open /dev/mem\n"
memOpnsz:      .word  .-memOpnErr 
memMapErr:     .asciz  "Failed to map memory\n"
memMapsz:      .word  .-memMapErr 
	       .align  4 # relign after strings
gpioaddr:      .dword   0x13040000	# mem address of gpio registers
.text
