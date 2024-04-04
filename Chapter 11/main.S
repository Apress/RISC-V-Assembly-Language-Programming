#
# Main program to test our distance function
#
# s1 - loop counter
# s0 - address to current set of points
 
.global main # Provide program starting address to linker
 
#
 
   	.equ   N, 4   # Number of points.
 
main: 
	addi	sp, sp, -32	# allocate 32 bytes on stack
	sd	ra, 16(sp)	# push return address
	sd	s0, 8(sp)	# push s0 register
	sd	s1, 0(sp)	# push s1 register
 
   	la	s0, points # pointer to current points
   	
   	li	s1, N  	# number of loop iterations
 
loop:	mv	a0, s0  	# move pointer to parameter 1 (a0)
 
	call	distance 	# call distance function
 
   	mv	a1, a0   	# return double to a1 to print
   	la	a0, prtstr	# load print string
   	call 	printf   	# print the distance
 
   	addi	s0, s0, (4*8)   # 4 points each 8 bytes
   	addi	s1, s1, -1	# decrement loop counter
   	bnez	s1, loop     	# loop if more points
 
   	li	a0, 0   	# return code

	ld	s1, 0(sp)	# pop s1
	ld	s0, 8(sp)	# pop s0
	ld	ra, 16(sp)	# pop ra
	addi	sp, sp, 32	# deallocate stack space
   	ret
 
.data
points:  	.double  	0.0, 0.0, 3.0, 4.0
         	.double  	1.3, 5.4, 3.1, -1.5
         	.double		1.323e10, -1.2e-4, 34.55, 5454.234
         	.double		9.42e250, 4.44e120, 4.4, 8.8
prtstr:  	.asciz "Distance = %f\n"
