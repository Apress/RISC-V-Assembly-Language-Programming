#
# Assembler program to convert a string to
# all upper case by calling a function.
#
# a0-a2 - parameters to linux function services
# a1 - address of output string
# a0 - address of input string
# a7 - linux function number
#

.global _start	            # Provide program starting address to linker

_start: la	a0, instr	# start of input string
	la	a1, outstr	# address of output string

	jal	toupper

# Setup the parameters to print the resulting string
# and then call Linux to do it.
	mv	a2,a0		# return code is the length of the string

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
instr:  .asciz  "This is our Test String that we will convert.\n"
outstr:	.fill	255, 1, 0

