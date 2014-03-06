	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	readReal
	.globl	writeReal
	.globl	writeChar
	.globl	program
	.text
program:
# args:   0 bytes
# result: 1 bytes
# locals: 0 bytes
# temps:  4 bytes
#
#
	movl	sp, fp
	subl2	$4, sp
	movl	$7, -4(fp)
	pushr	$0x3800
	movab	-4(fp), r11
	moval	-4(fp), ap
	jsb	writeChar
	popr	$0x3800
	movl	fp, sp
	rsb

