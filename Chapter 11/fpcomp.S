#
# Function to compare two floating point numbers
# the parameters are a pointer to the two numbers
# and an error epsilon.
#
# Inputs:
# 	a0 - pointer to the 3 FP numbers
#       	they are x1, x2, e
# Outputs:
# 	a0 - 1 if they are equal, else 0
 
.global fpcomp # Allow function to be called by others
 
fpcomp:  	# load the 3 numbers
   	flw	ft0, 0(a0)
	flw	ft1, 4(a0)
	flw	ft2, 8(a0)
 
   	# calc ft3 = ft2 - ft1
   	fsub.s	ft3, ft1, ft0
   	fabs.s	ft3, ft3
	fle.s	t0, ft3, ft2
   	beqz	t0, notequal
   	li	a0, 1
   	j	done  
   	
notequal:li	a0, 0
   	
done:  ret
