	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	readReal
	.globl	writeReal
	.globl	writeChar
	.globl	fact
	.text
fact:
# args:   4 bytes
# result: 4 bytes
# locals: 0 bytes
# temps:  8 bytes
#
#     i:	argument (4 bytes)	at (ap)
#
	movl	sp, fp
	subl2	$8, sp
Lbg_1:
	movl	(ap), r0
	movb	$1, r1
	cmpl	r0, $0
	jlss	Lro_1
	movb	$0, r1
Lro_1:
	jlbc	r1, Lel_1
	movl	$0, (r11)
	jbr	Leg_1
Lel_1:
	movl	(ap), r0
	movb	$1, r1
	cmpl	r0, $0
	jeql	Lro_2
	movb	$0, r1
Lro_2:
	jlbc	r1, Lel_2
	movl	$1, (r11)
	jbr	Leg_1
Lel_2:
	movl	(ap), r0
	movl	(ap), r1
	subl2	$1, r1
	movl	r1, -4(fp)
	pushr	$0x3801
	moval	-8(fp), r11
	moval	-4(fp), ap
	jsb	fact
	popr	$0x3801
	mull3	-8(fp), r0, (r11)
Leg_1:
	movl	fp, sp
	rsb

	.globl	ifact
	.text
ifact:
# args:   4 bytes
# result: 4 bytes
# locals: 8 bytes
# temps:  0 bytes
#
#     i:	argument (4 bytes)	at (ap)
#     res:	local    (4 bytes)	at -4(fp)
#     k:	local    (4 bytes)	at -8(fp)
#
	movl	sp, fp
	subl2	$8, sp
	movl	$1, -4(fp)
	movl	(ap), -8(fp)
Lbg_2:
	movl	-8(fp), r0
	movb	$1, r1
	cmpl	r0, $0
	jgtr	Lro_3
	movb	$0, r1
Lro_3:
	jlbc	r1, Lel_3
	movl	-4(fp), r0
	movl	-8(fp), r1
	mull3	r1, r0, -4(fp)
	movl	-8(fp), r0
	subl3	$1, r0, -8(fp)
	jbr	Lbg_2
Lel_3:
Leg_2:
	movl	-4(fp), (r11)
	movl	fp, sp
	rsb

	.globl	program
	.text
program:
# args:   0 bytes
# result: 0 bytes
# locals: 4 bytes
# temps:  9 bytes
#
#     i:	local    (4 bytes)	at -4(fp)
#
	movl	sp, fp
	subl2	$13, sp
Lbg_3:
	pushr	$0x3800
	movab	-5(fp), r11
	movab	-4(fp), ap
	jsb	readBool
	popr	$0x3800
	jlbc	-5(fp), Lel_4
	pushr	$0x3800
	moval	-4(fp), r11
	movab	-4(fp), ap
	jsb	readInt
	popr	$0x3800
	movl	-4(fp), r0
	movl	r0, -9(fp)
	pushr	$0x3800
	movab	-4(fp), r11
	moval	-9(fp), ap
	jsb	writeInt
	popr	$0x3800
	movl	$10, -9(fp)
	pushr	$0x3800
	movab	-4(fp), r11
	moval	-9(fp), ap
	jsb	writeChar
	popr	$0x3800
	movl	-4(fp), r0
	movl	r0, -9(fp)
	pushr	$0x3800
	moval	-13(fp), r11
	moval	-9(fp), ap
	jsb	ifact
	popr	$0x3800
	pushr	$0x3800
	movab	-4(fp), r11
	moval	-13(fp), ap
	jsb	writeInt
	popr	$0x3800
	movl	$32, -9(fp)
	pushr	$0x3800
	movab	-4(fp), r11
	moval	-9(fp), ap
	jsb	writeChar
	popr	$0x3800
	movl	-4(fp), r0
	movl	r0, -9(fp)
	pushr	$0x3800
	moval	-13(fp), r11
	moval	-9(fp), ap
	jsb	fact
	popr	$0x3800
	pushr	$0x3800
	movab	-4(fp), r11
	moval	-13(fp), ap
	jsb	writeInt
	popr	$0x3800
	movl	$10, -9(fp)
	pushr	$0x3800
	movab	-4(fp), r11
	moval	-9(fp), ap
	jsb	writeChar
	popr	$0x3800
	jbr	Lbg_3
Lel_4:
Leg_3:
	movl	fp, sp
	rsb

