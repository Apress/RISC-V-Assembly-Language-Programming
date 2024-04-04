#
# Examples of Multiplication
#
 
.include "debug.S"
 
.global main # Provide program starting address
 
# Load the registers with some data
# Use small positive numbers that will work for all
# multiply instructions.
main: 
   	li	x5, 25
   	li	x6, 4
 
   	printStr "Inputs:"
   	printReg 5
   	printReg 6
 
   	mul	x7, x5, x6
   	printStr "mul x7=x5*x6:"
   	printReg 7

   	mulw	x7, x5, x6
   	printStr "mulw x7=x5*x6:"
   	printReg 7
 
   	ld	x5, A
   	ld	x6, B
   	printStr "Inputs:"
   	printReg 5
   	printReg 6
   	mulh	x7, x5, x6
   	mul	x28, x5, x6
   	printStr "mulh x7 = top 64 bits of x5*x6 (signed):"
   	printReg 7
   	printStr "mul x28 = bottom 64 bits of x5*x6:"
   	printReg 28

    	mulhu	x7, x5, x6
   	mul	x28, x5, x6
   	printStr "mulhu x7 = top 64 bits of x5*x6 (unsigned):"
   	printReg 7
   	printStr "mul x28 = bottom 64 bits of x5*x6:"
   	printReg 28
 
   	li	a0, 0   	# return code
   	ret
 
.data
.align 16
A: 	.dword   	0x7812345678
B: 	.dword   	0xFABCD12345678901
