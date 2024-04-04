#
# Main program to test our distance function
#
# s0 W19 - loop counter
# s1 X20 - address to current set of points
 
.global main # Provide program starting address
 
   	.equ   N, 100 # Number of additions.
 
main: 
	addi	sp, sp, -32	# allocate 32 bytes on stack
	sd	ra, 16(sp)	# push return address
	sd	s0, 8(sp)	# push s0 register
	sd	s1, 0(sp)	# push s1 register
   	
# Add up one hundred cents and test if they equal $1.00
 
   	li	s0, N         	# number of loop iterations
 
# load cents, running sum and real sum to FPU
   	la	a0, cent
	flw	fs0, 0(a0)
	flw	fs1, 4(a0)
	flw	fs2, 8(a0)
loop:
   	# add cent to running sum
   	fadd.s	fs1, fs1, fs0
   	addi	s0, s0, -1	# decrement loop counter
   	bnez	s0, loop	# loop if more points
 
	# store computed sum
brk1:	fsw	fs1, 4(a0)
   	# compare running sum to real sum
	feq.s	a1, fs1, fs2
   	# print if the numbers are equal or not
   	bnez	a1, equal
   	la	a0, notequalstr
   	call 	printf
   	j	next
equal:	la	a0, equalstr
   	call	printf
 
next:
# load pointer to running sum, real sum and epsilon
   	la	a0, runsum
   	
# call comparison function
   	call 	fpcomp   	# call comparison function
# compare return code to 1 and print if the numbers
# are equal or not (within epsilon).
   	bnez    a0, equal2
   	la	a0, notequalstr
   	call 	printf
   	j  	done
equal2: la	a0, equalstr
   	call 	printf
 
done:	li	a0, 0   	# return code
	ld	s1, 0(sp)	# pop s1
	ld	s0, 8(sp)	# pop s0
	ld	ra, 16(sp)	# pop ra
	addi	sp, sp, 32	# deallocate stack space
   	ret
 
.data
cent:    	.single 0.01
runsum:  	.single 0.0
sum:     	.single 1.00
epsilon: 	.single 0.00001
equalstr:	.asciz "equal\n"
notequalstr: .asciz "not equal\n"
