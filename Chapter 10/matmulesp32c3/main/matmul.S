#
# Multiply 2 3x3 integer matrices
#
# Registers:
# 	t0 - Row index
# 	t1 - Column index
# 	t2 - Address of row
# 	t3 - Address of column
# 	t4 - 64 bit accumulated sum
# 	t5 - Cell of A
# 	t6 - Cell of B
# 	s1 - Position in C
# 	s2 - Loop counter for printing
# 	s3 - row in dotloop
# 	s4 - col in dotloop
 
.global app_main # Provide program starting address
 
   	.equ   N, 3   # Matrix dimensions
   	.equ   WDSIZE, 4 # Size of element
app_main: 
	addi	sp, sp, -32
	sw	ra, 16(sp)	# push the return address to the stack
	sw	s1, 12(sp)
	sw	s2, 8(sp)
	sw	s3, 4(sp)
	sw	s4, 0(sp)

   	li	t0, N   	# Row index
   	la	t2, A   	# Address of current row
   	la	s1, C  		# Address of results matrix
rowloop:
   	la	t3, B   	# first column in B
   	li	t1, N   	# Column index (will count down to 0)
 
colloop: 	
   	# Zero accumulator registers
   	li	t4, 0
 
   	li	a0, N   	# dot product loop counter
   	mv	s3, t2  	# row for dot product
   	mv	s4, t3  	# column for dot product
dotloop:
   	# Do dot product of a row of A with column of B
	lw	t5, 0(s3)	# load A[row, i]
	addi	s3, s3, WDSIZE	# increment row counter
 	lw	t6, 0(s4) 	# load B[i, col]
	addi	s4, s4, N*WDSIZE # increment col counter
	mul	t5, t5, t6	# A[row, i] * B[i, col]
	add	t4, t4, t5	# Add to sum	
   	addi	a0, a0, -1	# Dec loop counter
   	bnez	a0, dotloop     # If not zero loop
 
	sw	t4, 0(s1)  	# C[row, col] = dotprod
	add	s1, s1, WDSIZE
   	add	t3, t3, WDSIZE 	# Inc current col
   	addi	t1, t1, -1	# Dec col loop counter
   	bnez	t1, colloop	# If not zero loop
   	
   	add	t2, t2, (N*WDSIZE) # Increment to next row
   	addi	t0, t0, -1	# Dec row loop counter
   	bnez	t0, rowloop 	# If not zero loop
 
# Print out matrix C
# Loop through 3 rows printing 3 cols each time.
   	li	s2, N         	# Print N rows
   	la	s1, C         	# Addr of results matrix
printloop:
         	
   	la	a0, prtstr     	# printf format string
   	lw	a1, 0(s1) # first element in current row
   	lw	a2, WDSIZE(s1)  # second element in current row
   	lw	a3, 2*WDSIZE(s1)  # third element in curent row
	add	s1, s1, WDSIZE * N	# increment N cells
   	call 	printf          	# Call printf
   	addi	s2, s2, -1    	# Dec loop counter
   	bnez	s2, printloop       	# If not zero loop
 
	lw	ra, 16(sp)	# pop the return address from the stack
	lw	s1, 12(sp)
	lw	s2, 8(sp)
	lw	s3, 4(sp)
	lw	s4, 0(sp)
	addi	sp, sp, 32

# Loop forever.
	j	app_main
 
.data
# First matrix
A: 	.word  1, 2, 3
   	.word  4, 5, 6
   	.word  7, 8, 9
# Second matrix
B: 	.word  9, 8, 7
   	.word  6, 5, 4
   	.word  3, 2, 1
# Result matix
C: 	.fill  9, 4, 0
 
prtstr: .asciz  "%3d  %3d  %3d\n"
