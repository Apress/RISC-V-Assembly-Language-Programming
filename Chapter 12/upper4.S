#
# Assembly Language function to convert a string to
# all upper case.
#
# a1 - address of output string
# a0 - address of input string
# t2 - current character being processed
# t3 - temp register for comparisons
# t4 - minus 'a' to compare < 26.
# t5 - original output string for length calc.
#

.global toupper	     # Allow other files to call this routine

toupper:
	mv	t5, a1		# save original outstr for len calc
# The loop is until null (zero) character is encountered.
loop:	lb	t2, 0(a0)	# load character
	addi	a0, a0, 1	# increment buffer pointer
# Want to know if 'a' <= W5 <= 'z'
# First subtract 'a'
   	addi	t4, t2, -'a'
	sltiu	t3, t4, 26	# is t4 < 26
	li	t5, ('A'-'a')	# number to add if lower case
	.word	0xfcf5e33	# czero.eqz t3, t5, t3 # if condition false, set to zero
	add	t2, t2, t3	# add adjustment

	sb	t2, 0(a1)	# store character to output str
	addi	a1, a1, 1	# increment buffer for next char
	li	t3, 0		# load 0 char for comparison
	bne	t2, t3, loop	# loop if character isn't null

# Setup the parameters to print our hex number
# and then call Linux to do it.
	sub	a0, a1, t5 	# get the len by sub’ing the pointers

	ret			# Return to caller
