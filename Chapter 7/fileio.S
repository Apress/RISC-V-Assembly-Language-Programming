# Various macros to perform file I/O
#
# The fd parameter needs to be a register.
# Uses a0, a1, a2, a3, a7.
# Return code is in a0.

#include <asm/unistd.h>

.equ	O_RDONLY, 0
.equ	O_WRONLY, 1
.equ	O_CREAT,  0100
.equ	O_EXCL,   0200
.equ	S_RDWR,   0666
.equ	AT_FDCWD, -100

.macro  openFile    fileName, flags
	li	a0, AT_FDCWD
	la	a1, \fileName
	li	a2, \flags
	li	a3, S_RDWR		# RW access rights
	li	a7, __NR_openat
	ecall
.endm
.macro  readFile   fd, buffer, length
	mv	a0, \fd      # file descriptor
	la	a1, \buffer
	li	a2, \length
	li	a7, __NR_read
	ecall
.endm
.macro  writeFile   fd, buffer, length
	mv	a0, \fd      # file descriptor
	la	a1, \buffer
	mv	a2, \length
	li	a7, __NR_write
	ecall
.endm
.macro  flushClose  fd
#fsync syscall
	mv	a0, \fd
	li	a7, __NR_fsync
	ecall

#close syscall
	mv	a0, \fd
	li	a7, __NR_close
 	ecall
.endm
