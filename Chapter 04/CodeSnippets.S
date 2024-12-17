
# CodeSnippets from Chapter 4.
# Includes examples of all the instructions covered.

.global _start      # Provide program starting address to linker

_start:	

	# Unconditional jump instructions
	jal	x5, label	# direct jump
	la	x6, label
	jalr	x5, x6, 32	# indirect jump

	j label

 label:   li x5, 1
       	j _start

	beq	x5, x6, label	# branch if equal
	bne	x5, x6, label	# branch if not equal
	blt	x5, x6, label	# branch if rs1 < rs2 (signed)
	bge	x5, x6, label	# branch if rs1 >= rs2 (signed)
	bltu	x5, x6, label	# branch if rs1 < rs2 (unsigned)
	bgeu	x5, x6, label	# branch if rs1 >= rs2 (unsigned)

	beqz x5, label	# beq x5, x0, label	# Branch if = zero
	bnez x5, label	# bne x5, x0, label	# Branch if ≠ zero
	blez x5, label	# bge x0, x5, label	# Branch if ≤ zero
	bgez x5, label	# bge x5, x0, label	# Branch if ≥ zero
	bltz x5, label	# blt x5, x0, label	# Branch if < zero
	bgtz x5, label	# blt x0, x5, label	# Branch if > zero
	bgt x5, x6, label	# blt x6, x5, label	# Branch if >
	ble x5, x6, label	# bge x6, x5, label	# Branch if ≤
	bgtu x5, x6, label # bltu x6, x5, label # Branch if >, unsigned
	bleu x5, x6, label # bltu x6, x5, label # Branch if ≤, unsigned

# FOR/NEXT loop
	li	x5, 1 # x5 holds I
loop: # The body of the loop goes here.
 	# Most of the logic is at the end
 	addi	x5, x5, 1    	# I = I + 1
 	li	x6, 10		# end of loop for comparison
 	ble	x5, x6, loop   	# IF I < 10 goto loop

# WHILE Loop
# x5 is X and has been initialized
loop2: li	x6, 5
 	bge x5, x6, loopdone
 	# … other statements in the loop body …
 	j	loop2
loopdone: # program continues

# IF/THEN/ELSE Statement
li	x6, 10
 	bge	x5, x6, elseclause
 
 #	… if statements …
 
 	j	endif
elseclause:
 
 #	… else statements …
 
endif: 	# continue on after the /then/else …

# Bitwise logic instructions
 	and 	x6, x5, x7
	andi	x6, x5, 0xff
 	or 	x6, x5, x7
	ori	x6, x5, 0xff
 	xor 	x6, x5, x7
	xori	x6, x5, 0xff

# mask off the high order byte
li  x6, 0xFF000000	# mask value to x6
and x5, x5, x6
# right shift the byte down to the low order position.
 	srli	x5, x5, 24

	ori	x6, x6, 0xFF

# Conditional set instructions
	slt	x7, x5, x6		# x7 = 1 if x5 < x6, else x7 = 0
	slti	x7, x5, 10	# x7 = 1 if x5 < 10 else x7 = 0
	sltu	x7, x5, x6		# like slt, but for unsigned integers
	sltiu	x7, x5, 10		# like slti, but for unsigned integers

# Pseudoinstructions for conditional set instructions
	seqz	x7, x5	# set x7 = 1 if x5 = 0
	snez	x7, x5	# set x7 = 1 if x5 ≠ 0
	sltz	x7, x5	# set x7 = 1 if x5 < 0
	sgtz	x7, x5	# set x7 = 1 if x5 > 0

# Setup the parameters to exit the program
# and then call Linux to do it.

	addi	a0, x0, 0	# Use 0 return code
	addi	a7, x0, 93	# Service command code 93 terminates
	ecall		# Call linux to terminate the program
