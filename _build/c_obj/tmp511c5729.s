	.align 4
	.text
.globl _program
_program:
	movl 4(%esp), %edx
	movl 4(%esp), %edx
	movl %edx, %eax
	pushl %eax
	movl $4, %eax
	cmpl 0(%esp), %eax
	movl $0, %eax
	setGE %al
	addl $4, %esp
	ret
