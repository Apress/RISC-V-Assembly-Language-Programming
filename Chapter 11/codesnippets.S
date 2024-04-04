#
# Code snippets for Chapter 6
# Examples of using the stack and calling
# functions.
#

.global _start	            # Provide program starting address to linker

	.equ	rne, 0
	.equ	rtz, 1
	.equ	rdn, 2
	.equ	rup, 3
	.equ	rmm, 4
	.equ	dyn, 7
	
_start:
# fcsr pseudoinstructions
	frcsr	x5	# read the fcsr into x5
	fscsr	x6, x5	# x6 = old value fcsr, fcsr = x5
	fscsr	x6	# write fcsr = x6
	frrm	x5	# read rounding mode into x5
	fsrm	x6, x5	# swap rounding mode with x5
	fsrm	x6	# write rounding mode = X6
	fsrmi	x6, rtz	# swap rounding mode with immediate
	fsrmi	rtz	# write rounding mode with immediate
	frflags	x5	# read exception flags
	fsflags	x6, x5	# swap exception flags
	fsflags	x6	# write exception flags
	fsflagsi x6, rup	# swap exception flags with immediate
	fsflagsi rmm	# write exception flags with immediate

# load/store instructions
 	la	x5, fp1		# load address of fp1
 	flw	f0, 0(x5)	# load single precision fp1
 	fld	f1, 4(x5)	# load double precision fp2
 	fsw	f0, 12(x5)	# store single precision fp3
 	fsd	f1, 16(x5)	# store double precision fp4

# Move instruction
	fmv.w.x	f0, x5	# move 32-bits of x5 to f0
	fmv.x.w	x5, f0	# move 32-bits of f0 to x5
	fmv.d.x	f0, x5	# move 64-bits of x5 to f0
	fmv.x.d	x5, f0	# move 64-bits of f0 to x5

# Pseudoinstructions
	fmv.s	f0, f1	# f0 = f1 single precision
	fmv.d	f0, f2	# f0 = f1 double precision


# Computation instructions
#	fadd.h	f0, f1, f2     	# fd = fn + fm half precision
	fadd.s 	f0, f1, f2, rne	# fd = fn + fm single precision
	fadd.d 	f0, f1, f2     	# fd = fn + fm double precision
#	fadd.q	f0, f1, f2	# fd = fn + fm quad precision
	fsub.d	f0, f1, f2     	# fd = fn - fm
	fmul.d	f0, f1, f2     	# fd = fn * fm
	fdiv.d	f0, f1, f2     	# fd = fn / fm
	fmadd.d	f0, f1, f2, f3  # fd = fa + fm * fn
	fmsub.d	f0, f1, f2, f3  # fd = fm *fn - fa
	fnmsub.d	f0, f1, f2, f3  # fd = fa - fm *fn
	fnmadd.d	f0, f1, f2, f3  # fd = -fa - fm * fn
	fmax.d	f0, f1, f2     	# fd = Max( fn, fm )
	fmin.d	f0, f1, f2     	# fd = Min( fn, fm )
	fsqrt.d	f0, f1		# fd = Square Root( fn )

	fneg.d	f0, f1		# fd = - fn
	fabs.d	f0, f1		# fd = Absolute Value( fn )

# Conversions
	fcvt.s.w	f0, x5		# f0 = float(x5)
	fcvt.lu.d	x5, f7, rup	# x5 = int(f7), rounding mode up
	fcvt.s.w	f5, x0		# f5 = 0.0 single precision
	fcvt.d.w	f5, x0		# f5 = 0.0 double precision
	fcvt.d.s	f4, f5		# f4 (double) = f5 (single)
	fcvt.s.d	f4, f5		# f4 (single) = f5 (double)

# Comparisons
	feq.s	x5, f4, f5	# if f4 = f5 then x5 = 1 else x5 = 0
	flt.d	x5, f4, f5	# if f4 < f5 then x5 = 1 else x5 = 0
	fle.d	x5, f4, f5	# if f4 <= f5 then x5 = 1 else x5 = 0

	fclass.d	x5, f5		# classify double f5 putting result in x5

# Signs
	fsgnj.s		f5, f6, f7	# x5 = abs(x6) with sign x7
	fsgnjn.d	f5, f6, f7	# x5 = abs(x6) with sign -x7
	fsgnjx.d	f5, f6, f7	# x5 = abs(x6) with sign(x6) xor sign(x7)
 
# Setup the parameters to exit the program
# and then call Linux to do it.
	li	a0, 0		# Use 0 return code
        li	a7, 93		# Service command code 1 terminates this program
        ecall			# Call linux to terminate the program

.data
.single	1.343, 4.343e20, -0.4343, -0.4444e-10
.double	-4.24322322332e-10, 3.141592653589793
fp1: .single	3.14159
fp2: .double	4.3341
fp3: .single	0.0
fp4: .double	0.0

