	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	readReal
	.globl	writeReal
	.globl	readString
	.globl	writeString
	.globl	writeChar
	.globl	MAX
	.text
MAX:
	.long	100000
	.comm	array, 800000

	.globl	qsort
	.text
qsort:
Lp_1:
# args:   8 bytes
# result: 0 bytes
# locals: 24 bytes
# temps:  8 bytes
#
#     l:	argument (4 bytes)	at (ap)
#     r:	argument (4 bytes)	at 4(ap)
#     i:	local    (4 bytes)	at -4(fp)
#     j:	local    (4 bytes)	at -8(fp)
#     x:	local    (8 bytes)	at -16(fp)
#     t:	local    (8 bytes)	at -24(fp)
#
	movl	sp, fp
	subl2	$32, sp
	movl	(ap), -4(fp)
	movl	4(ap), -8(fp)
	movl	(ap), r0
	movl	4(ap), r1
	addl2	r1, r0
	divl2	$2, r0
	movab	array, r1
	mull2	$8, r0
	addl2	r0, r1
	movc3	$8, (r1), -16(fp)
Lbg_1:
Lbg_2:
	movl	-4(fp), r0
	mull2	$8, r0
	movab	array, r1
	addl2	r0, r1
	movab	(r1), r0
	addl2	$0, r0
	movl	(r0), r0
	movab	-16(fp), r2
	addl2	$0, r2
	movl	(r2), r2
	cmpl	r0, r2
	jgeq	Lel_2
	movl	-4(fp), r0
	addl3	$1, r0, -4(fp)
	jbr	Lbg_2
Lel_2:
Leg_2:
Lbg_3:
	movab	-16(fp), r0
	addl2	$0, r0
	movl	(r0), r0
	movl	-8(fp), r2
	mull2	$8, r2
	movab	array, r3
	addl2	r2, r3
	movab	(r3), r2
	addl2	$0, r2
	movl	(r2), r2
	cmpl	r0, r2
	jgeq	Lel_3
	movl	-8(fp), r0
	subl3	$1, r0, -8(fp)
	jbr	Lbg_3
Lel_3:
Leg_3:
Lbg_4:
	movl	-4(fp), r0
	movl	-8(fp), r2
	cmpl	r0, r2
	jgtr	Lel_4
	movl	-4(fp), r0
	movab	array, r2
	mull2	$8, r0
	addl2	r0, r2
	pushr	$0xA
	movc3	$8, (r2), -24(fp)
	popr	$0xA
	movl	-4(fp), r0
	mull2	$8, r0
	movab	array, r2
	addl2	r0, r2
	movl	-8(fp), r0
	movab	array, r4
	mull2	$8, r0
	addl2	r0, r4
	pushr	$0xE
	movc3	$8, (r4), (r2)
	popr	$0xE
	movl	-8(fp), r0
	mull2	$8, r0
	movab	array, r4
	addl2	r0, r4
	pushr	$0x1E
	movc3	$8, -24(fp), (r4)
	popr	$0x1E
	movl	-4(fp), r0
	addl3	$1, r0, -4(fp)
	movl	-8(fp), r0
	subl3	$1, r0, -8(fp)
	jbr	Leg_4
Lel_4:
Leg_4:
Lbg_5:
	movl	-4(fp), r0
	movl	-8(fp), r5
	cmpl	r0, r5
	jleq	Lel_5
	jbr	Leg_1
	jbr	Leg_5
Lel_5:
Leg_5:
	jbr	Lbg_1
Lel_1:
Leg_1:
Lbg_6:
	movl	(ap), r0
	movl	-8(fp), r5
	cmpl	r0, r5
	jgeq	Lel_6
	movl	(ap), -32(fp)
	movl	-8(fp), -28(fp)
	pushr	$0x381E
	movab	-32(fp), r11
	movab	-32(fp), ap
	jsb	Lp_1
	popr	$0x381E
	jbr	Leg_6
Lel_6:
Leg_6:
Lbg_7:
	movl	-4(fp), r0
	movl	4(ap), r5
	cmpl	r0, r5
	jgeq	Lel_7
	movl	-4(fp), -32(fp)
	movl	4(ap), -28(fp)
	pushr	$0x381E
	movab	-32(fp), r11
	movab	-32(fp), ap
	jsb	Lp_1
	popr	$0x381E
	jbr	Leg_7
Lel_7:
Leg_7:
	movl	fp, sp
	rsb

	.globl	initialize
	.text
initialize:
Lp_2:
# args:   0 bytes
# result: 0 bytes
# locals: 12 bytes
# temps:  12 bytes
#
#     i:	local    (4 bytes)	at -4(fp)
#     r:	local    (4 bytes)	at -8(fp)
#     j:	local    (4 bytes)	at -12(fp)
#
	movl	sp, fp
	subl2	$24, sp
	movl	$0, -24(fp)
	movl	$333, -20(fp)
	movl	$0f0.5, -16(fp)
	movl	-24(fp), -4(fp)
	movl	-20(fp), -8(fp)
	movl	-16(fp), -12(fp)
Lbg_8:
	movl	-4(fp), r0
	movl	MAX, r1
	cmpl	r0, r1
	jgeq	Lel_8
	movl	-8(fp), r0
	mull3	r0, $1317, r0
	divl3	$214748, r0, -8(fp)
	mull2	$214748, -8(fp)
	subl3	-8(fp), r0, -8(fp)
	movl	-4(fp), r0
	mull2	$8, r0
	movab	array, r1
	addl2	r0, r1
	movl	-8(fp), (r1)
	movl	-12(fp), r0
	mulf3	$0f3.0, r0, 4(r1)
	movl	-12(fp), r0
	addf3	$0f0.5, r0, -12(fp)
	movl	-4(fp), r0
	addl3	$1, r0, -4(fp)
	jbr	Lbg_8
Lel_8:
Leg_8:
	movl	fp, sp
	rsb

	.globl	program
	.text
program:
Lp_3:
# args:   0 bytes
# result: 0 bytes
# locals: 0 bytes
# temps:  8 bytes
#
#
	movl	sp, fp
	subl2	$8, sp
	pushr	$0x3800
	movab	(fp), r11
	movab	(fp), ap
	jsb	initialize
	popr	$0x3800
	movl	$0, -8(fp)
	movl	MAX, r0
	subl3	$1, r0, -4(fp)
	pushr	$0x3800
	movab	(fp), r11
	movab	-8(fp), ap
	jsb	qsort
	popr	$0x3800
	movl	fp, sp
	rsb

