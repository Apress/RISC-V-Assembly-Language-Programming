#
# Examples of Integer Division
#

.include "debug.S"

.global main # Provide program starting address

# Load the registers with some data
# Perform various division instructions
main:		
	li	x5, 100
	li	x6, 6

	printStr "Inputs:"
	printReg 5
	printReg 6

	div	x7, x5, x6
	rem	x28, x5, x6
	printStr "x5 / x6 (signed):"
	printReg 7
	printStr "x5 %% x6 (signed):"
	printReg 28

	divu	x7, x5, x6
	remu	x28, x5, x6
	printStr "x5 / x6 (unsigned):"
	printReg 7 
	printStr "x5 %% x6 (unsigned):"
	printReg 28

	# Signed division by zero
	li	x6, 0
	div	x7, x5, x6
	rem	x28, x5, x6	
	printStr "Signed division by zero:"
	printReg 7
	printStr "Signed remainder on division by zero:"
	printReg 28

	# Unsigned division by zero
	li	x6, 0
	divu	x7, x5, x6
	remu	x28, x5, x6	
	printStr "Unsigned division by zero:"
	printReg 7
	printStr "Unsigned remainder on division by zero:"
	printReg 28

	# Overflow
	li	x5, -9223372036854775808
	li	x6, -1
	div	x7, x5, x6
	rem	x28, x5, x6	
	printStr "Overflow division:"
	printReg 7
	printStr "Overflow remainder:"
	printReg 28

	li	a0, 0		# return code
	ret
