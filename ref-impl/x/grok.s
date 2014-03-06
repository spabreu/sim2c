#NO_APP
.text
	.align 1
_fact:
	.word 0x0
	movl 4(ap),r1
	movl 8(ap),r0
	cmpl r1,$1
	jgtr L1
	ret
L1:
	mull2 r1,(r0)
	pushl r0
	pushab -1(r1)
	calls $2,_fact
	ret
	.align 0
LC0:
	.ascii "%d\12\0"
	.align 1
.globl _main
_main:
	.word 0x0
	subl2 $4,sp
	pushab -4(fp)
	movl 8(ap),r1
	pushl 4(r1)
	calls $1,_atoi
	pushl r0
	calls $2,_fact
	pushl -4(fp)
	pushab LC0
	calls $2,_printf
	ret
