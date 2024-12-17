#
# Assembler program to convert a string to
# all upper case by calling a function.
#
# a0-a2, a7 - used by macros to call linux
# s1 - input file descriptor
# s2 - output file descriptor
# t0 - number of characters read
#

#include <asm/unistd.h>
#include "fileio.S"

.equ	BUFFERLEN, 250

.global _start	            # Provide program starting address to linker

_start: openFile	inFile, O_RDONLY
	mv		s1, a0		# save file descriptor
	bgez		a0, nxtfil	# pos number file opened ok
	li		a1, 1		# stdout
	la		a2, inpErrsz	# Error msg
	lw		a2, 0(a2)
	writeFile	a1, inpErr, a2 # print the error
	j		exit

nxtfil: openFile	outFile, O_CREAT+O_WRONLY
	mv		s2, a0		# save file descriptor
	bgez		a0, loop		# pos number file opened ok
	li		a1, 1
	la		a2, outErrsz
	lw		a2, 0(a2)
	writeFile	a1, outErr, a2
	j		exit

# loop through file until done.
loop:	readFile	s1, buffer, BUFFERLEN
	mv		t0, a0	# Keep the length read
	li		t1, 0	# Null terminator for string

	# setup call to toupper and call function
	la		a0, buffer	# first param for toupper
	add		a1, a0, t0	# addr to put null, buffer + len
	sb		t1, 0(a1)	# put null at end of string.
	la		a1, outBuf
	jal		toupper		

	writeFile	s2, outBuf, t0

	li		t1, BUFFERLEN
	beq		t0, t1, loop

	flushClose	s1
	flushClose	s2

# Setup the parameters to exit the program
# and then call Linux to do it.
exit:	li	a0, 0	# Use 0 return code
	li	a7, __NR_exit
	ecall		# Call Linux to terminate

.data
inFile:  .asciz  "main.S"
outFile: .asciz	 "upper.txt"
buffer:	.fill	BUFFERLEN + 1, 1, 0
outBuf:	.fill	BUFFERLEN + 1, 1, 0
inpErr: .asciz	"Failed to open input file.\n"
inpErrsz: .word  .-inpErr 
outErr:	.asciz	"Failed to open output file.\n"
outErrsz: .word	.-outErr
