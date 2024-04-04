#
# Assembler program to demonstrate a buffer
# overrun hacking attack.
#
# a0-a2 - parameters to Linux function services
# a1 - address of output string
# a0 - address of input string
# a7 - Linux function number
#

.global _start	      # Provide program starting address

DownloadCreditCardNumbers:
# Setup the parameters to print hello world
# and then call Linux to do it.
	li	a0, 1	    # 1 = StdOut
	la	a1, getcreditcards # string to print
	li	a2, 30	    # length of our string
	li	a7, 64		# linux write system call
	ecall	 	    # Call linux to output the string	
	ret

calltoupper:	
	addi	sp, sp, -16	# allocate 16 bytes on stack
	sd	ra, 0(sp)	# push return address
	addi	sp, sp, -16	# 16 bytes for outstr
	la	a0, instr	# start of input string
	mv	a1, sp		# address of output string

	call	toupper

aftertoupper:		# convenient label to use as a breakpoint
	addi	sp, sp, 16	# Free outstr
	ld	ra, 0(sp)	# pop ra
	addi	sp, sp, 16	# deallocate stack space
	ret

_start:

	call	calltoupper


# Setup the parameters to exit the program
# and then call Linux to do it.
	li	a0, 0		# Use 0 return code
        li	a7, 93		# Service command code 93 terminates this program
        ecall			# Call Linux to terminate the program

.data
instr:  .ascii  "This is our Test"	# Correct length string
	.dword 0x00000000000100e8	# overwrite for ra
getcreditcards:	.asciz  "Downloading Credit Card Data!\n"
	.align 4
