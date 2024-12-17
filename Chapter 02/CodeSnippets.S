/* This is a C style comment
   That can go over multiple lines
*/
# This is a more Assembly Language style comment

.global _start      # Provide program starting address to linker

_start:
	// All register add variants.
	add	x5, x6, x7
	add	x5, x5, x6
	add	x5, x6
	addw	x7, x5, x6

	// Mv pseudoinstruction
 	add	x5, x0, x6
 	mv	x5, x6
	addi	x5, x6, 0

	// Immediate instructions
	addi	x7, x6, 15
	add	x7, x6, 15	# The assembler will change this to addi for you.

	li	x7, 15
	lui	x5, 0x12345
	addi	x5, 0x678

	slli	x7, x5, 2

	# Load 0x1234567890ABCDEF into register x5
	lui	x5, 0x12345	# x5 = 0x1234500000000000
	addi	x6, x0, 0x678	# x6 = 0x678
	slli	x6, x6, 32	# x6 = 0x67800000000
	addi	x5, x5, x6	# x5 = 0x1234567800000000
	addi	x6, x0, 0x90A	# x6 = 0x90A
	slli	x6, x6, 20	# x6 = 0x90A00000
	addi 	x5, x5, x6	# x5 = 0x1234567890A00000
	addi	x6, x0, 0xBCD	# x6 = 0xBCD
	slli	x6, x6, 8	# x6 = 0xBCD00
	addi	x5, x5, x6	# x5 = 0x1234567890ABCD00
	addi	x5, x5, 0xEF	# x5 = 0x1234567890ABCDEF

	li	x5, 0x1234567890ABCDEF

	sub	x5, x6, x7
	
# Setup the parameters to exit the program
# and then call Linux to do it.

        mv      a0, x0      # Use 0 return code
        li      a7, 93      # Service command code 93 terminates
        ecall               # Call linux to terminate the program	
