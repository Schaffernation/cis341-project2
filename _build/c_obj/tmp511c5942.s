	.align 4
	.text
.globl _program
_program:
	movl 4(%esp), %edx
	movl 4(%esp), %edx
	movl $17, %eax
	pushl %eax
	movl %edx, %eax
	subl %eax, 0(%esp)
	addl $4, %esp
	ret
