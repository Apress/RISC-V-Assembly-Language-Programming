#
# Assembler program to print a register in hex
# to stdout.
#
# a0-a2 (x10-x12) - parameters to linux function services
# a1 - is also address of byte we are writing
# x5 - register to print
# x6 - loop index
# x7 - current character
# a7 (x17) - linux function number
#
 
.global _start  # Provide program starting address
 
_start: li	x5, 0x1234FEDC4F5D6E3A 
 	la	a1, hexstr	# start of string
 	add	a1, a1, 17	# start at least sig digit
# The loop is FOR x6 = 16 TO 1 STEP -1
 	li  x6, 16	 # 16 digits to print
loop:	and x7, x5, 0xf	# mask of least sig digit
# If x7 >= 10 then goto letter
 	li	x28, 10	# is 0-9 or A-F
 	bge	x7, x28, letter
# Else its a number so convert to an ASCII digit
 	addi	x7, x7, '0'
 	j	cont	# goto to end if
letter: # handle the digits A to F
 	addi	x7, x7, ('A'-10)
cont: # end if
 	sb x7, 0(a1)		# store ascii digit
 	addi  a1, a1, -1	# decrement address for next digit
 	srli	x5, x5, 4	# shift off the digit
 
 	# next W5
 	addi	x6, x6, -1	# step x6 by -1
 	bnez	x6, loop	# another for loop if not done
 
# Setup the parameters to print our hex number
# and then call Linux to do it.
	li	a0, 1		# 1 = StdOut
 	la	a1, hexstr	# string to print
 	li	a2, 19		# length of our string
 	li	a7, 64		# linux write system call
 	ecall			# Call linux to output the string
 
# Setup the parameters to exit the program
# and then call Linux to do it.
 	li	a0, 0		# Use 0 return code
	li     a7, 93		# Service code 93 terminates
    	ecall			# Call linux to terminate
 
.data
hexstr:      .ascii  "0x123456789ABCDEFG\n"
