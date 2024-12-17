#
# Example of some calculations to show printReg and printStr.
#

.include "debug.S"

.global main	          # Provide program starting address

.equ	DOUT_MASK, 0x7f

# Calculates the mask value needed to use a GPIO
# output register.
main:	
	li	a0, 50		# pin to turn on - GPIO50
	srli	a1, a0, 2	# pin offset div by 4
	slli	a1, a1, 2	# mult by 4, now multiple of 4
	sub	a2, a0, a1	# shift value start with remainder
	slli	a2, a2, 3	# multiply by 8 (bits per gpio)
	li	a3, DOUT_MASK	# mask
	sll	a3, a3, a2	# shift into position
	not	a3, a3		# ones complement bits for anding
	printStr "Register a0 GPIO register"  
	printReg 10		# x10 = a0
	printStr "Register a1 GPIO register offset"
	printReg 11		# x11 = a1
	printStr "Register a2 bit shift value"
	printReg 12		# x12 = a2
	printStr "Register a3 mask value for right bits"
	printReg 13		# x13 = a3

	li	a0, 0		# return code
	ret
