
# CodeSnippets from Chapter 5.
# Includes examples of all the instructions covered.

.global _start      # Provide program starting address to linker

.text

_start:	

	auipc	x5, 0x12345
	
	la	x5, 0x12345678

# All the load instructions
	la	x5, bytes
	lb	x6, 0(x5)
	la	x5, halves
	lh	x6, 0(x5)
	la	x5, words
	lw	x6, 0(x5)
	la	x5, quads
	ld	x6, 0(x5)	# RV64I only
	
	la	x5, bytes
	lbu	x6, 0(x5)
	la	x5, halves
	lhu	x6, 0(x5)
	la	x5, words
	lwu	x6, 0(x5)

# All the load pseudoinstructions
	lb	x5, bytes
	lh	x5, halves
	lw	x5, words
	ld	x5, quads	# RV64I only

	lbu	x5, bytes
	lhu	x5, halves
	lwu	x5, words

# store instructions
	la	x6, bytes
	sb	x5, 0(x6)
	srli	x5, x5, 8
	sb	x5, 1(x6)
	srli	x5, x5, 8
	sb	x5, 2(x6)
	
	sh	x5, 0(x6)
	sw	x5, 0(x6)
	sd	x5, 0(x6)

# store pseudoinstructions
	sb	x5, bytes, x6
	sh	x5, bytes, x6
	sw	x5, bytes, x6
	sd	x5, bytes, x6

# load the address of mynumbers into x5
  	la	x5, mynumbers
# load the words stored at mynumbers into x28, x29, x30
  	lw	x28, 0(x5)
   	lw	x29, 4(x5)
  	lw	x30, 8(x5)

label:			
	auipc	x6, %pcrel_hi(mynumber)
	lw	x6, %pcrel_lo(label)(x6)
	# x6 now contains 0x12345678.

# load/store with same address in x5.
	la	x5, mynumber		# address of our variable in two instructions
# …
	lw	x6, 0(x5)		# load value in one instruction
# …
	sw	x6, 0(x5)		# save value in one instruction

	li	a0, 1		# stdout
	li	a2, 26
	li	a7, 64     	# linux write system call
	
	lui	a1, %hi(msg)
	addi	a1, a1, %lo(msg)
        ecall                # Call linux to output the string

	li	a0, 1		# stdout
	li	a2, 26
	li	a7, 64     	# linux write system call
	
	li	a0, 1		# stdout
	li	a2, 26
	li	a7, 64     	# linux write system call

1:			
	auipc	a1, %pcrel_hi(msg)
	addi	a1,  a1, %pcrel_lo(1b)
        ecall                # Call linux to output the string
	
# Initialize x3 as a pointer to the start of the data section.
label1:	auipc	x3, %pcrel_hi(x3init)
  		addi  x3, x3, %pcrel_lo(label1)
# … more code
# Now load the address of msg, perhaps in a loop body
		addi	x5, x3, 14 # msg2-x3init
# x5 now contains the address of msg2, obtained in one instruction.
	li	a0, 1		# stdout
	mv	a1, x5		# address of string
	li	a2, 19		# length of string
	li	a7, 64     	# linux write system call
        ecall                # Call linux to output the string

# Setup the parameters to exit the program
# and then call Linux to do it.

	addi	a0, x0, 0	# Use 0 return code
	addi	a7, x0, 93	# Service command code 93 terminates
	ecall		# Call linux to terminate the program
	
.data
		.align	4
bytes:		.byte	74, 0112, 0b00101010, 0x4A, 0X4a, 'J', 'H' + 2
halves:		.half	0x1234,  4949
words:		.word	0x1234ABCD, -1434
quads:		.quad	0x1234567890ABCDEF
ascii:		.ascii	"Hello World\n"
asciz:		.asciz	"Hello World"
		.balign 4
msg:		.asciz	"Hi there, how's it going?\n"

negs:		.byte	-0x45, -33, ~0b00111001

zeros:		.fill	10, 4, 0

rpn:		.rept	3
		.byte	0, 1, 2
		.endr
mynumbers:	.word	0x12345678, 0x9ABCDEF0, 0x1234
mynumber:	.word	0x12345678

x3init:
msg1: 	.asciz	"First message\n"
msg2:	.asciz	"This is a message\n"
