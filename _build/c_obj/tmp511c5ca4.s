	.align 4
	.text
.globl _program
_program:
	movl 4(%esp), %edx
	movl 4(%esp), %edx
	movl 4(%esp), %edx
	movl %edx, %eax
	pushl %eax
	movl $17, %eax
	andl 0(%esp), %eax
	addl $4, %esp
	pushl %eax
	movl $42, %eax
	orl 0(%esp), %eax
	addl $4, %esp
	ret
