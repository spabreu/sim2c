	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	readReal
	.globl	writeReal
	.globl	writeChar
	.globl	array
	.data
array:
	.space	800

	.globl	size
	.data
size:
	.space	4

	.globl	qsort
	.text
qsort:
# args:   8 bytes
# result: 0 bytes
# locals: 17 bytes
# temps:  24 bytes
#
#     l:	argument (4 bytes)	at (ap)
#     r:	argument (4 bytes)	at 4(ap)
#     i:	local    (4 bytes)	at -4(fp)
#     j:	local    (4 bytes)	at -8(fp)
#     x:	local    (8 bytes)	at -16(fp)
#     more:	local    (1 bytes)	at -17(fp)
#
	movl	sp, fp
	subl2	$41, sp
	movl	(ap), -25(fp)
	movl	4(ap), -21(fp)
	movl	-25(fp), -4(fp)
	movl	-21(fp), -8(fp)
	movl	(ap), r0
	movl	4(ap), r1
	addl2	r1, r0
	divl2	$2, r0
	movab	array, r1
	mull2	$8, r0
	addl2	r0, r1
	movc3	$8, (r1), -16(fp)
	movb	$1, -17(fp)
Lbg_1:
	movb	-17(fp), r0
	jlbc	r0, Lel_1
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
	movb	$1, r3
	cmpl	r0, r2
	jlss	Lro_1
	movb	$0, r3
Lro_1:
	jlbc	r3, Lel_2
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
	movb	$1, r4
	cmpl	r0, r2
	jlss	Lro_2
	movb	$0, r4
Lro_2:
	jlbc	r4, Lel_3
	movl	-8(fp), r0
	subl3	$1, r0, -8(fp)
	jbr	Lbg_3
Lel_3:
Leg_3:
Lbg_4:
	movl	-4(fp), r0
	movl	-8(fp), r2
	movb	$1, r4
	cmpl	r0, r2
	jleq	Lro_3
	movb	$0, r4
Lro_3:
	jlbc	r4, Lel_4
	movl	-8(fp), r0
	movab	array, r2
	mull2	$8, r0
	addl2	r0, r2
	movc3	$8, (r2), -41(fp)
	movl	-4(fp), r0
	movab	array, r2
	mull2	$8, r0
	addl2	r0, r2
	movc3	$8, (r2), -33(fp)
	movl	-4(fp), r0
	mull2	$8, r0
	movab	array, r2
	addl2	r0, r2
	movc3	$8, -41(fp), (r2)
	movl	-8(fp), r0
	mull2	$8, r0
	movab	array, r4
	addl2	r0, r4
	movc3	$8, -33(fp), (r4)
	movl	-4(fp), r0
	addl3	$1, r0, -25(fp)
	movl	-8(fp), r0
	subl3	$1, r0, -21(fp)
	movl	-25(fp), -4(fp)
	movl	-21(fp), -8(fp)
	jbr	Leg_4
Lel_4:
Leg_4:
	movl	-4(fp), r0
	movl	-8(fp), r5
	movb	$1, -17(fp)
	cmpl	r0, r5
	jleq	Lro_4
	movb	$0, -17(fp)
Lro_4:
	jbr	Lbg_1
Lel_1:
Leg_1:
Lbg_5:
	movl	(ap), r0
	movl	-8(fp), r5
	movb	$1, r6
	cmpl	r0, r5
	jlss	Lro_5
	movb	$0, r6
Lro_5:
	jlbc	r6, Lel_5
	movl	(ap), -25(fp)
	movl	-8(fp), -21(fp)
	pushr	$0x381E
	movab	-41(fp), r11
	movab	-25(fp), ap
	jsb	qsort
	popr	$0x381E
	jbr	Leg_5
Lel_5:
Leg_5:
Lbg_6:
	movl	-4(fp), r0
	movl	4(ap), r5
	movb	$1, r6
	cmpl	r0, r5
	jlss	Lro_6
	movb	$0, r6
Lro_6:
	jlbc	r6, Lel_6
	movl	-4(fp), -25(fp)
	movl	4(ap), -21(fp)
	pushr	$0x381E
	movab	-41(fp), r11
	movab	-25(fp), ap
	jsb	qsort
	popr	$0x381E
	jbr	Leg_6
Lel_6:
Leg_6:
	movl	fp, sp
	rsb

	.globl	readData
	.text
readData:
# args:   0 bytes
# result: 0 bytes
# locals: 12 bytes
# temps:  20 bytes
#
#     i:	local    (4 bytes)	at -4(fp)
#     j:	local    (4 bytes)	at -8(fp)
#     k:	local    (4 bytes)	at -12(fp)
#
	movl	sp, fp
	subl2	$32, sp
	pushr	$0x3800
	moval	size, r11
	movab	-12(fp), ap
	jsb	readInt
	popr	$0x3800
	movl	$0, -4(fp)
Lbg_7:
	movl	-4(fp), r0
	movl	size, r1
	movb	$1, r2
	cmpl	r0, r1
	jlss	Lro_7
	movb	$0, r2
Lro_7:
	jlbc	r2, Lel_7
	movl	-4(fp), r0
	mull2	$8, r0
	movab	array, r1
	addl2	r0, r1
	movab	(r1), r0
	addl2	$0, r0
	pushr	$0x3803
	moval	(r0), r11
	movab	-12(fp), ap
	jsb	readInt
	popr	$0x3803
	movl	-4(fp), r2
	addl3	$1, r2, -4(fp)
	jbr	Lbg_7
Lel_7:
Leg_7:
	movl	$0, -24(fp)
	movl	$0f0.5, -20(fp)
	movl	$0f1.5, -16(fp)
	movl	-24(fp), -4(fp)
	movl	-20(fp), -8(fp)
	movl	-16(fp), -12(fp)
Lbg_8:
	movl	-4(fp), r2
	movl	size, r3
	movb	$1, r4
	cmpl	r2, r3
	jlss	Lro_8
	movb	$0, r4
Lro_8:
	jlbc	r4, Lel_8
	movl	-4(fp), r2
	mull2	$8, r2
	movab	array, r3
	addl2	r2, r3
	movab	(r3), r2
	addl2	$4, r2
	movl	-8(fp), r4
	movl	-12(fp), r5
	addf3	r5, r4, (r2)
	movl	-12(fp), -32(fp)
	movl	-8(fp), r4
	movl	-12(fp), r5
	addf3	r5, r4, -28(fp)
	movl	-32(fp), -8(fp)
	movl	-28(fp), -12(fp)
	movl	-4(fp), r4
	addl3	$1, r4, -4(fp)
	jbr	Lbg_8
Lel_8:
Leg_8:
	movl	fp, sp
	rsb

	.globl	writeData
	.text
writeData:
# args:   0 bytes
# result: 0 bytes
# locals: 4 bytes
# temps:  4 bytes
#
#     i:	local    (4 bytes)	at -4(fp)
#
	movl	sp, fp
	subl2	$8, sp
	movl	$10, -8(fp)
	pushr	$0x3800
	movab	-8(fp), r11
	moval	-8(fp), ap
	jsb	writeChar
	popr	$0x3800
	movl	$0, -4(fp)
Lbg_9:
	movl	-4(fp), r0
	movl	size, r1
	movb	$1, r2
	cmpl	r0, r1
	jlss	Lro_9
	movb	$0, r2
Lro_9:
	jlbc	r2, Lel_9
	movl	-4(fp), r0
	mull2	$8, r0
	movab	array, r1
	addl2	r0, r1
	movab	(r1), r0
	addl2	$0, r0
	movl	(r0), r0
	movl	r0, -8(fp)
	pushr	$0x3802
	movab	-8(fp), r11
	moval	-8(fp), ap
	jsb	writeInt
	popr	$0x3802
	movl	$32, -8(fp)
	pushr	$0x3802
	movab	-8(fp), r11
	moval	-8(fp), ap
	jsb	writeChar
	popr	$0x3802
	movl	-4(fp), r0
	mull2	$8, r0
	movab	array, r2
	addl2	r0, r2
	movab	(r2), r0
	addl2	$4, r0
	movl	(r0), r0
	movl	r0, -8(fp)
	pushr	$0x3806
	movab	-8(fp), r11
	movaf	-8(fp), ap
	jsb	writeReal
	popr	$0x3806
	movl	$10, -8(fp)
	pushr	$0x3806
	movab	-8(fp), r11
	moval	-8(fp), ap
	jsb	writeChar
	popr	$0x3806
	movl	-4(fp), r0
	addl3	$1, r0, -4(fp)
	jbr	Lbg_9
Lel_9:
Leg_9:
	movl	fp, sp
	rsb

	.globl	program
	.text
program:
# args:   0 bytes
# result: 0 bytes
# locals: 0 bytes
# temps:  9 bytes
#
#
	movl	sp, fp
	subl2	$9, sp
	pushr	$0x3800
	movab	(fp), r11
	movab	(fp), ap
	jsb	readData
	popr	$0x3800
Lbg_10:
	pushr	$0x3800
	movab	-1(fp), r11
	movab	(fp), ap
	jsb	readBool
	popr	$0x3800
	jlbc	-1(fp), Lel_10
	movl	$0, -9(fp)
	movl	size, r0
	subl3	$1, r0, -5(fp)
	pushr	$0x3800
	movab	(fp), r11
	movab	-9(fp), ap
	jsb	qsort
	popr	$0x3800
	jbr	Leg_10
Lel_10:
Leg_10:
	pushr	$0x3800
	movab	(fp), r11
	movab	(fp), ap
	jsb	writeData
	popr	$0x3800
	movl	fp, sp
	rsb

