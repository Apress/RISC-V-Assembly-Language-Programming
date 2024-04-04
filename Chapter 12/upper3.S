#
# Assembly Language function to convert a string to
# all upper case.
#
# a1 - address of output string
# a0 - address of input string
# t2 - current character being processed
# t5 - original output string for length calc.
#

.global _start	     # Entry point for linker.

.MACRO toupper inputstr, outputstr
	la	a0, \inputstr
	la	a1, \outputstr
	mv	t5, a1		# save original outstr for len calc
# The loop is until null (zero) character is encountered.
loop:	lb	t2, 0(a0)	# load character
	addi	a0, a0, 1	# increment buffer pointer
	andi	t2, t2, 0xdf	# clear the bit at 0x20
	sb	t2, 0(a1)	# store character to output str
	addi	a1, a1, 1	# increment buffer for next char
	li	t3, 0		# load 0 char for comparison
	bne	t2, t3, loop	# loop if character isn't null

# Setup the parameters to print our hex number
# and then call Linux to do it.
	sub	a0, a1, t5 	# get the len by sub’ing the pointers
.ENDM

_start:
   	toupper  	instr, outstr
 
# Setup the parameters to print the resulting string
# and then call Linux to do it.
	mv	a2, a0		# return code is the length of the string

	li	a0, 1	    	# 1 = StdOut
	la	a1, outstr	# string to print
	li	a7, 64		# linux write system call
	ecall			# Call linux to output the string

# Setup the parameters to exit the program
# and then call Linux to do it.
	li	a0, 0		# Use 0 return code
        li	a7, 93		# Service command code 1 terminates this program
        ecall			# Call linux to terminate the program

.data
instr:  .asciz  "ThisIsRatherALargeVariableNameAaZz//[`{\n"
outstr:	.fill	255, 1, 0

