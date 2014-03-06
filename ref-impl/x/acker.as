	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	readReal
	.globl	writeReal
	.globl	readString
	.globl	writeString
	.globl	writeChar
	.globl	MC
	.text
MC:
	.long	3
	.globl	NC
	.text
NC:
	.long	8
	.globl	acker
	.text
acker:
Lp_1:
# args:   8 bytes
# result: 4 bytes
# locals: 0 bytes
# temps:  16 bytes
#
#     m:	argument (4 bytes)	at (ap)
#     n:	argument (4 bytes)	at 4(ap)
#
	movl	sp, fp
	subl2	$16, sp
Lbg_1:
	movl	(ap), r0
	cmpl	r0, $0
	jneq	Lel_1
	movl	4(ap), r0
	addl3	$1, r0, (r11)
	jbr	Leg_1
Lel_1:
	movl	4(ap), r0
	cmpl	r0, $0
	jneq	Lel_2
	movl	(ap), r0
	subl3	$1, r0, -8(fp)
	movl	$1, -4(fp)
	pushr	$0x3800
	moval	(r11), r11
	movab	-8(fp), ap
	jsb	Lp_1
	popr	$0x3800
	jbr	Leg_1
Lel_2:
	movl	(ap), r0
	subl3	$1, r0, -8(fp)
	movl	(ap), -16(fp)
	movl	4(ap), r0
	subl3	$1, r0, -12(fp)
	pushr	$0x3800
	moval	-4(fp), r11
	movab	-16(fp), ap
	jsb	Lp_1
	popr	$0x3800
	pushr	$0x3800
	moval	(r11), r11
	movab	-8(fp), ap
	jsb	Lp_1
	popr	$0x3800
Leg_1:
	movl	fp, sp
	rsb

	.globl	program
	.text
program:
Lp_2:
# args:   0 bytes
# result: 0 bytes
# locals: 0 bytes
# temps:  12 bytes
#
#
	movl	sp, fp
	subl2	$12, sp
	movl	MC, -8(fp)
	movl	NC, -4(fp)
	pushr	$0x3800
	moval	-12(fp), r11
	movab	-8(fp), ap
	jsb	acker
	popr	$0x3800
	pushr	$0x3800
	movab	-12(fp), r11
	moval	-12(fp), ap
	jsb	writeInt
	popr	$0x3800
	movl	$10, -12(fp)
	pushr	$0x3800
	movab	-12(fp), r11
	moval	-12(fp), ap
	jsb	writeChar
	popr	$0x3800
	movl	fp, sp
	rsb

