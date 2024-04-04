
# Various macros to help with debugging
 
# These macros preserve[1]  all registers.
# Beware they will change the condition flags.

.altmacro

.macro	saveReg regNum
       	sw   x\regNum, \regNum * 4 (sp)
.endm

.macro	loadReg regNum
	lw   x\regNum, \regNum * 4 (sp)
.endm

.macro  saveRegs
	.set	i, 1
	.rept	31
       		saveReg %i
	      	.set	i, i+1
      	.endr
.endm

.macro  restoreRegs
	.set	i, 1
	.rept	31
	 	loadReg	%i
        	.set	i, i+1
        .endr
.endm

.macro  printReg    reg
	addi	sp, sp, -128
	saveRegs

 	mv  	a2, x\reg	# for the %d
 	mv  	a3, x\reg	# for the %x
 	li  	a1, \reg   
	la      a0, ptfStr	# printf format str
	call       printf	# call printf
 	restoreRegs
	addi	sp, sp, 128
.endm
 
.macro 	printStr    str
	addi	sp, sp, -128
	saveRegs

 	la  	a0, 1f 	# load print str
 	call   	printf # call printf

  	restoreRegs
	addi	sp, sp, 128
 	j		2f      	# branch around str
1:	.ascii 		\str
	.asciz		"\n"
 	.align 		8
2:
.endm
 
.data
ptfStr: .asciz "x%d = %32ld, 0x%016lx\n"
.align 8
.text
