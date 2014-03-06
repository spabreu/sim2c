	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	swap
	.text
swap:
# args:   8 bytes
# result: 8 bytes
# locals: 0 bytes
# temps:  0 bytes
#
#     a:	argument (4 bytes)	at (ap)
#     b:	argument (4 bytes)	at 4(ap)
#
	movl	sp, fp
	subl2	$0, sp
	movl	4(ap), (r11)
	movl	(ap), 4(r11)
	movl	fp, sp
	rsb

	.globl	program
	.text
program:
# args:   0 bytes
# result: 1 bytes
# locals: 8 bytes
# temps:  20 bytes
#
#     i:	local    (4 bytes)	at -4(fp)
#     j:	local    (4 bytes)	at -8(fp)
#
	movl	sp, fp
	subl2	$28, sp
	movl	$1, -24(fp)
	movl	$2, -20(fp)
	pushr	$0x3800
	movab	-16(fp), r11
	movab	-24(fp), ap
	jsb	swap
	popr	$0x3800
	movl	-16(fp), -4(fp)
	movl	-12(fp), -8(fp)
	movl	-4(fp), r0
	movl	r0, -28(fp)
	pushr	$0x3800
	movab	-28(fp), r11
	moval	-28(fp), ap
	jsb	writeInt
	popr	$0x3800
	movl	-8(fp), r0
	movl	r0, -28(fp)
	pushr	$0x3800
	movab	-28(fp), r11
	moval	-28(fp), ap
	jsb	writeInt
	popr	$0x3800
	movl	fp, sp
	rsb

