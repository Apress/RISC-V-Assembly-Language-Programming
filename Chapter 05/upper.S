#
# Assembler program to convert a string to
# all upper case.
#
# a0-a2 - parameters to Linux function services
# x5 - address of output string
# x6 - address of input string
# x7 - current character being processed
# a7 - linux function number
#

.global _start # Provide program starting address to linker

_start:
.option push
.option norelax
1:	auipc gp, %pcrel_hi(__global_pointer$)
	addi  gp, gp, %pcrel_lo(1b)
.option pop

	la	x5, outstr 	# address of output string
	la	x6, instr	# start of input string
	
# The loop is until null (zero) character is encountered.
loop:	lb	x7, 0(x6)	# load character
	addi	x6, x6, 1	# increment buffer pointer
# If x7 > 'z' then goto cont
	li	x28, 'z'	# load 'z' for comparison
	bgt	x7, x28, cont	# branch if letter > 'z'?
# Else if x7 < 'a' then goto end if
	li	x28, 'a'		# load 'a' for comparison
	blt	x7, x28, cont	# goto to end if not lowercase
# if we got here then the letter is lower case, so convert it.
	addi	x7, x7, ('A'-'a')
cont:	# end if
	sb	x7, 0(x5)	# store character to output str
	addi	x5, x5, 1	# increment buffer for next char
	li	x28, 0		# load 0 char for comparison
	bne	x7, x28, loop	# loop if character isn't null

# Setup the parameters to print our hex number
# and then call Linux to do it.
	li	a0, 1		# 1 = StdOut
	la	a1, outstr	# string to print
	sub	a2, x5, a1 	# get the len by sub’ing the pointers
	li	a7, 64		# Linux write system call
	ecall			# Call Linux to output the string

# Setup the parameters to exit the program
# and then call Linux to do it.
	li	a0, 0		# Use 0 return code
	li	a7, 93		# Service code 93 terminates
        ecall 			# Call Linux to terminate the program

.data
gpinit:	.quad	. +  0x800
instr:  .asciz  "This is our Test String that we will convert.\n"
outstr:	.fill	255, 1, 0
