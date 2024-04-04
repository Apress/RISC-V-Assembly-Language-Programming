
# This is a simple Assembly Language program
# to practice using gdb with.

.global _start      # Provide program starting address to linker

_start:

# load register x5 with 0x12345678
	lui	x5, 0x12345
	addi	x5, x5, 0x678

	li	x6, 10	# load x6 = 10  

	add	x7, x5, x6  # add 10 to x5
	sub	x8, x7, x6  # subtract  10 from x7
	
# Setup the parameters to exit the program
# and then call Linux to do it.

        mv      a0, x0      # Use 0 return code
        li      a7, 93      # Service command code 93 terminates
        ecall               # Call linux to terminate the program	
