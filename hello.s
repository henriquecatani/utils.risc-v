.global _start

.section .text
_start:
exit0:
	li	a0, 0	; exit return value
	li	a7, 93	; 93: exit syscall value on riscv linux
	ecall		; syscall
