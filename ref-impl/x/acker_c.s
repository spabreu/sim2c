#NO_APP
.text
	.align 1
.globl _Ack
_Ack:
	.word 0x40
	movl 4(ap),r2
	movl 8(ap),r1
L4:
	tstl r2
	jneq L1
	movab 1(r1),r0
	ret
L1:
	tstl r1
	jneq L3
	decl r2
	movl $1,r1
	jbr L4
L3:
	movab -1(r2),r6
	pushab -1(r1)
	pushl r2
	calls $2,_Ack
	movl r0,r1
	movl r6,r2
	jbr L4
	.align 0
LC0:
	.ascii "%d\12\0"
	.align 1
.globl _main
_main:
	.word 0x0
	pushl $8
	pushl $3
	calls $2,_Ack
	pushl r0
	pushab LC0
	calls $2,_printf
	ret
