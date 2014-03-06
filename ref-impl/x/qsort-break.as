	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	readReal
	.globl	writeReal
	.globl	readString
	.globl	writeString
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
Lp_1:
# args:   8 bytes
# result: 0 bytes
# locals: 16 bytes
# temps:  24 bytes
#
#     l:	argument (4 bytes)	at (ap)
#     r:	argument (4 bytes)	at 4(ap)
#     i:	local    (4 bytes)	at -4(fp)
#     j:	local    (4 bytes)	at -8(fp)
#     x:	local    (8 bytes)	at -16(fp)
#
	movl	sp, fp
	subl2	$40, sp
	movl	(ap), -24(fp)
	movl	4(ap), -20(fp)
	movl	-24(fp), -4(fp)
	movl	-20(fp), -8(fp)
	movl	(ap), r0
	movl	4(ap), r1
	addl2	r1, r0
	divl2	$2, r0
	movab	array, r1
	mull2	$8, r0
	addl2	r0, r1
	movc3	$8, (r1), -16(fp)
Lbg_1:
	jlbc	$1, Lel_1
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
	pushr	$0xA
	movc3	$8, (r2), -40(fp)
	popr	$0xA
	movl	-4(fp), r0
	movab	array, r2
	mull2	$8, r0
	addl2	r0, r2
	pushr	$0xA
	movc3	$8, (r2), -32(fp)
	popr	$0xA
	movl	-4(fp), r0
	mull2	$8, r0
	movab	array, r2
	addl2	r0, r2
	pushr	$0xE
	movc3	$8, -40(fp), (r2)
	popr	$0xE
	movl	-8(fp), r0
	mull2	$8, r0
	movab	array, r4
	addl2	r0, r4
	pushr	$0x1E
	movc3	$8, -32(fp), (r4)
	popr	$0x1E
	movl	-4(fp), r0
	addl3	$1, r0, -24(fp)
	movl	-8(fp), r0
	subl3	$1, r0, -20(fp)
	movl	-24(fp), -4(fp)
	movl	-20(fp), -8(fp)
	jbr	Leg_4
Lel_4:
Leg_4:
Lbg_5:
	movl	-4(fp), r0
	movl	-8(fp), r5
	movb	$1, r6
	cmpl	r0, r5
	jgtr	Lro_4
	movb	$0, r6
Lro_4:
	jlbc	r6, Lel_5
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
	movb	$1, r6
	cmpl	r0, r5
	jlss	Lro_5
	movb	$0, r6
Lro_5:
	jlbc	r6, Lel_6
	movl	(ap), -24(fp)
	movl	-8(fp), -20(fp)
	pushr	$0x381E
	movab	-40(fp), r11
	movab	-24(fp), ap
	jsb	Lp_1
	popr	$0x381E
	jbr	Leg_6
Lel_6:
Leg_6:
Lbg_7:
	movl	-4(fp), r0
	movl	4(ap), r5
	movb	$1, r6
	cmpl	r0, r5
	jlss	Lro_6
	movb	$0, r6
Lro_6:
	jlbc	r6, Lel_7
	movl	-4(fp), -24(fp)
	movl	4(ap), -20(fp)
	pushr	$0x381E
	movab	-40(fp), r11
	movab	-24(fp), ap
	jsb	Lp_1
	popr	$0x381E
	jbr	Leg_7
Lel_7:
Leg_7:
	movl	fp, sp
	rsb

	.globl	readData
	.text
readData:
Lp_2:
# args:   0 bytes
# result: 0 bytes
# locals: 12 bytes
# temps:  280 bytes
#
#     i:	local    (4 bytes)	at -4(fp)
#     j:	local    (4 bytes)	at -8(fp)
#     k:	local    (4 bytes)	at -12(fp)
#
	movl	sp, fp
	subl2	$292, sp
	movc3	$256, Lstr_1, -268(fp)
	pushr	$0x3800
	movab	-268(fp), r11
	movab	-268(fp), ap
	jsb	writeString
	popr	$0x3800
	pushr	$0x3800
	moval	size, r11
	movab	-268(fp), ap
	jsb	readInt
	popr	$0x3800
	movl	$0, -4(fp)
Lbg_8:
	movl	-4(fp), r0
	movl	size, r1
	movb	$1, r2
	cmpl	r0, r1
	jlss	Lro_7
	movb	$0, r2
Lro_7:
	jlbc	r2, Lel_8
	movc3	$256, Lstr_2, -268(fp)
	pushr	$0x3800
	movab	-268(fp), r11
	movab	-268(fp), ap
	jsb	writeString
	popr	$0x3800
	movl	-4(fp), r0
	addl2	$1, r0
	movl	r0, -272(fp)
	pushr	$0x3800
	movab	-268(fp), r11
	moval	-272(fp), ap
	jsb	writeInt
	popr	$0x3800
	movc3	$256, Lstr_3, -268(fp)
	pushr	$0x3800
	movab	-268(fp), r11
	movab	-268(fp), ap
	jsb	writeString
	popr	$0x3800
	movl	-4(fp), r0
	mull2	$8, r0
	movab	array, r1
	addl2	r0, r1
	movab	(r1), r0
	addl2	$0, r0
	pushr	$0x3803
	moval	(r0), r11
	movab	-268(fp), ap
	jsb	readInt
	popr	$0x3803
	movl	-4(fp), r2
	addl3	$1, r2, -4(fp)
	jbr	Lbg_8
Lel_8:
Leg_8:
	movl	$0, -284(fp)
	movl	$0f0.5, -280(fp)
	movl	$0f1.5, -276(fp)
	movl	-284(fp), -4(fp)
	movl	-280(fp), -8(fp)
	movl	-276(fp), -12(fp)
Lbg_9:
	movl	-4(fp), r2
	movl	size, r3
	movb	$1, r4
	cmpl	r2, r3
	jlss	Lro_8
	movb	$0, r4
Lro_8:
	jlbc	r4, Lel_9
	movl	-4(fp), r2
	mull2	$8, r2
	movab	array, r3
	addl2	r2, r3
	movab	(r3), r2
	addl2	$4, r2
	movl	-8(fp), r4
	movl	-12(fp), r5
	addf3	r5, r4, (r2)
	movl	-12(fp), -292(fp)
	movl	-8(fp), r4
	movl	-12(fp), r5
	addf3	r5, r4, -288(fp)
	movl	-292(fp), -8(fp)
	movl	-288(fp), -12(fp)
	movl	-4(fp), r4
	addl3	$1, r4, -4(fp)
	jbr	Lbg_9
Lel_9:
Leg_9:
	movl	fp, sp
	rsb

	.globl	writeData
	.text
writeData:
Lp_3:
# args:   0 bytes
# result: 0 bytes
# locals: 4 bytes
# temps:  260 bytes
#
#     i:	local    (4 bytes)	at -4(fp)
#
	movl	sp, fp
	subl2	$264, sp
	movl	$10, -8(fp)
	pushr	$0x3800
	movab	-8(fp), r11
	moval	-8(fp), ap
	jsb	writeChar
	popr	$0x3800
	movl	$0, -4(fp)
Lbg_10:
	movl	-4(fp), r0
	movl	size, r1
	movb	$1, r2
	cmpl	r0, r1
	jlss	Lro_9
	movb	$0, r2
Lro_9:
	jlbc	r2, Lel_10
	movc3	$256, Lstr_4, -264(fp)
	pushr	$0x3800
	movab	-8(fp), r11
	movab	-264(fp), ap
	jsb	writeString
	popr	$0x3800
	movl	-4(fp), r0
	addl2	$1, r0
	movl	r0, -8(fp)
	pushr	$0x3800
	movab	-8(fp), r11
	moval	-8(fp), ap
	jsb	writeInt
	popr	$0x3800
	movc3	$256, Lstr_5, -264(fp)
	pushr	$0x3800
	movab	-8(fp), r11
	movab	-264(fp), ap
	jsb	writeString
	popr	$0x3800
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
	pushr	$0x2
	movc3	$256, Lstr_6, -264(fp)
	popr	$0x2
	pushr	$0x3802
	movab	-8(fp), r11
	movab	-264(fp), ap
	jsb	writeString
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
	pushr	$0x6
	movc3	$256, Lstr_7, -264(fp)
	popr	$0x6
	pushr	$0x3806
	movab	-8(fp), r11
	movab	-264(fp), ap
	jsb	writeString
	popr	$0x3806
	movl	-4(fp), r0
	addl3	$1, r0, -4(fp)
	jbr	Lbg_10
Lel_10:
Leg_10:
	movl	fp, sp
	rsb

	.globl	program
	.text
program:
Lp_4:
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
	jsb	readData
	popr	$0x3800
	movl	$0, -8(fp)
	movl	size, r0
	subl3	$1, r0, -4(fp)
	pushr	$0x3800
	movab	(fp), r11
	movab	-8(fp), ap
	jsb	qsort
	popr	$0x3800
	pushr	$0x3800
	movab	(fp), r11
	movab	(fp), ap
	jsb	writeData
	popr	$0x3800
	movl	fp, sp
	rsb

	.text
Lstr_1:
	.word	17
	.byte	78,117,109,98,101,114,32,111,102,32,105,116,101,109,115
	.byte	63,32
	.space	237
	.text
Lstr_2:
	.word	5
	.byte	73,116,101,109,32
	.space	249
	.text
Lstr_3:
	.word	2
	.byte	63,32
	.space	252
	.text
Lstr_4:
	.word	12
	.byte	78,101,119,32,101,108,101,109,101,110,116,32
	.space	242
	.text
Lstr_5:
	.word	3
	.byte	58,32,40
	.space	251
	.text
Lstr_6:
	.word	2
	.byte	44,32
	.space	252
	.text
Lstr_7:
	.word	2
	.byte	41,10
	.space	252
