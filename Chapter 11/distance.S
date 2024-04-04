#
# Example function to calculate the distance
# between two points in double precision
# floating point.
#
# Inputs:
# 	a0 - pointer to the 4 FP numbers
#       	they are x1, y1, x2, y2
# Outputs:
# 	a0 - the length (as double precision FP)
 
.global distance # Allow function to be called by others
 
	.equ	rne, 0
#
distance:
	# save return address incase printf is called for error
	addi	sp, sp, -16	# allocate 16 bytes on stack
	sd	ra, 0(sp)	# push return address	
	
	# save and set the fcsr
	frcsr	t0	# t0 = original fcsr
	fsrmi	rne	# set rounding mode
	fsflagsi 0	# clear flags
	
   	# load the 4 numbers
	fld	ft0, 0(a0)
	fld	ft1, 8(a0)
	fld	ft2, 16(a0)
	fld	ft3, 24(a0)
 
   	# calc ft4 = x2 - x1
   	fsub.d	ft4, ft2, ft0
   	# calc ft5 = y2 - y1
   	fsub.d	ft5, ft3, ft1
   	# calc ft4 = ft4 * ft4 (x2-X1)^2
   	fmul.d	ft4, ft4, ft4
   	# calc ft5 = ft5 * ft5 (Y2-Y1)^2
   	fmul.d	ft5, ft5, ft5
   	# calc ft4 = ft4 + ft5
   	fadd.d	ft4, ft4, ft5
   	# calc sqrt(ft4)
   	fsqrt.d	ft4, ft4

   	# did a floating point error occur?
   	frflags	t1	# read exceptions flags
   	beqz	t1, nerror # no error then go to exit
   	la	a0, errormsg	
   	mv	a1, t1
   	call	printf
 nerror: 
    	# move result to fa0 to be returned
   	fmv.x.d   a0, ft4	
   	fscsr	t0	# restore fcsr
	ld	ra, 0(sp)	# pop ra
	addi	sp, sp, 16	# deallocate stack space   	
   	ret
   	
.data
errormsg: .asciz "Floating-point error = %x\n"
