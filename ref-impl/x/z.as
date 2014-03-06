	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	readReal
	.globl	writeReal
	.globl	readString
	.globl	writeString
	.globl	writeChar
	.globl	program
	.text
program:
Lp_1:
# args:   0 bytes
# result: 0 bytes
# locals: 0 bytes
# temps:  4 bytes
#
#
	movl	sp, fp
	subl2	$4, sp
	pushr	$0x3800
	movaf	-4(fp), r11
	movab	(fp), ap
	jsb	readReal
	popr	$0x3800
	divf3	$0f3.0, -4(fp), r0
	mulf2	$0f3.0, r0
	movb	$1, r1
	cmpf	r0, $0f1.0
	jeql	Lro_1
	movb	$0, r1
Lro_1:
	movb	r1, -4(fp)
	pushr	$0x3800
	movab	(fp), r11
	movab	-4(fp), ap
	jsb	writeBool
	popr	$0x3800
	movl	fp, sp
	rsb

