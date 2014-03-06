	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	program
	.text
program:
# args:   0 bytes
# result: 1 bytes
# locals: 8 bytes
# temps:  12 bytes
#
#     i:	local    (4 bytes)	at -4(fp)
#     j:	local    (4 bytes)	at -8(fp)
#
	movl	sp, fp
	subl2	$20, sp
	movl	$1, -16(fp)
	movl	$2, -12(fp)
	movl	-16(fp), -4(fp)
	movl	-12(fp), -8(fp)
	movl	-4(fp), r0
	movl	r0, -20(fp)
	pushr	$0x3800
	movab	-20(fp), r11
	moval	-20(fp), ap
	jsb	writeInt
	popr	$0x3800
	movl	-8(fp), r0
	movl	r0, -20(fp)
	pushr	$0x3800
	movab	-20(fp), r11
	moval	-20(fp), ap
	jsb	writeInt
	popr	$0x3800
	movl	-8(fp), -16(fp)
	movl	-4(fp), -12(fp)
	movl	-16(fp), -4(fp)
	movl	-12(fp), -8(fp)
	movl	-4(fp), r0
	movl	r0, -20(fp)
	pushr	$0x3800
	movab	-20(fp), r11
	moval	-20(fp), ap
	jsb	writeInt
	popr	$0x3800
	movl	-8(fp), r0
	movl	r0, -20(fp)
	pushr	$0x3800
	movab	-20(fp), r11
	moval	-20(fp), ap
	jsb	writeInt
	popr	$0x3800
	movl	fp, sp
	rsb

