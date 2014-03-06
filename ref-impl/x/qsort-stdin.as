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
	.space	26000

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
# locals: 269 bytes
# temps:  1040 bytes
#
#     l:	argument (4 bytes)	at (ap)
#     r:	argument (4 bytes)	at 4(ap)
#     i:	local    (4 bytes)	at -4(fp)
#     j:	local    (4 bytes)	at -8(fp)
#     x:	local    (260 bytes)	at -268(fp)
#     more:	local    (1 bytes)	at -269(fp)
#
	movl	sp, fp
	subl2	$1309, sp
	movl	(ap), -277(fp)
	movl	4(ap), -273(fp)
	movl	-277(fp), -4(fp)
	movl	-273(fp), -8(fp)
	movl	(ap), r0
	movl	4(ap), r1
	addl2	r1, r0
	divl2	$2, r0
	movab	array, r1
	mull2	$260, r0
	addl2	r0, r1
	movc3	$260, (r1), -268(fp)
	movb	$1, -269(fp)
Lbg_1:
	movb	-269(fp), r0
	jlbc	r0, Lel_1
Lbg_2:
	movl	-4(fp), r0
	mull2	$260, r0
	movab	array, r1
	addl2	r0, r1
	movab	(r1), r0
	addl2	$0, r0
	pushr	$0x2
	movc3	$256, (r0), -533(fp)
	popr	$0x2
	movab	-268(fp), r0
	addl2	$0, r0
	pushr	$0x2
	movc3	$256, (r0), -789(fp)
	popr	$0x2
	movb	$1, r0
	pushr	$0x3
	cmpc5	-533(fp), -531(fp), $0, -789(fp), -787(fp)
	popr	$0x3
	jlss	Lro_1
	movb	$0, r0
Lro_1:
	jlbc	r0, Lel_2
	movl	-4(fp), r0
	addl3	$1, r0, -4(fp)
	jbr	Lbg_2
Lel_2:
Leg_2:
Lbg_3:
	movab	-268(fp), r0
	addl2	$0, r0
	pushr	$0x2
	movc3	$256, (r0), -533(fp)
	popr	$0x2
	movl	-8(fp), r0
	mull2	$260, r0
	movab	array, r2
	addl2	r0, r2
	movab	(r2), r0
	addl2	$0, r0
	pushr	$0x6
	movc3	$256, (r0), -789(fp)
	popr	$0x6
	movb	$1, r0
	pushr	$0x7
	cmpc5	-533(fp), -531(fp), $0, -789(fp), -787(fp)
	popr	$0x7
	jlss	Lro_2
	movb	$0, r0
Lro_2:
	jlbc	r0, Lel_3
	movl	-8(fp), r0
	subl3	$1, r0, -8(fp)
	jbr	Lbg_3
Lel_3:
Leg_3:
Lbg_4:
	movl	-4(fp), r0
	movl	-8(fp), r3
	movb	$1, r4
	cmpl	r0, r3
	jleq	Lro_3
	movb	$0, r4
Lro_3:
	jlbc	r4, Lel_4
	movl	-8(fp), r0
	movab	array, r3
	mull2	$260, r0
	addl2	r0, r3
	pushr	$0x6
	movc3	$260, (r3), -1309(fp)
	popr	$0x6
	movl	-4(fp), r0
	movab	array, r3
	mull2	$260, r0
	addl2	r0, r3
	pushr	$0x6
	movc3	$260, (r3), -1049(fp)
	popr	$0x6
	movl	-4(fp), r0
	mull2	$260, r0
	movab	array, r3
	addl2	r0, r3
	pushr	$0xE
	movc3	$260, -1309(fp), (r3)
	popr	$0xE
	movl	-8(fp), r0
	mull2	$260, r0
	movab	array, r4
	addl2	r0, r4
	pushr	$0x1E
	movc3	$260, -1049(fp), (r4)
	popr	$0x1E
	movl	-4(fp), r0
	addl3	$1, r0, -277(fp)
	movl	-8(fp), r0
	subl3	$1, r0, -273(fp)
	movl	-277(fp), -4(fp)
	movl	-273(fp), -8(fp)
	jbr	Leg_4
Lel_4:
Leg_4:
	movl	-4(fp), r0
	movl	-8(fp), r5
	movb	$1, -269(fp)
	cmpl	r0, r5
	jleq	Lro_4
	movb	$0, -269(fp)
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
	movl	(ap), -277(fp)
	movl	-8(fp), -273(fp)
	pushr	$0x381E
	movab	-1309(fp), r11
	movab	-277(fp), ap
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
	movl	-4(fp), -277(fp)
	movl	4(ap), -273(fp)
	pushr	$0x381E
	movab	-1309(fp), r11
	movab	-277(fp), ap
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
Lp_2:
# args:   0 bytes
# result: 0 bytes
# locals: 5 bytes
# temps:  512 bytes
#
#     i:	local    (4 bytes)	at -4(fp)
#     something:	local    (1 bytes)	at -5(fp)
#
	movl	sp, fp
	subl2	$517, sp
	movl	$0, -4(fp)
	movb	$1, -5(fp)
Lbg_7:
	movl	-4(fp), r0
	movb	$1, r1
	cmpl	r0, $100
	jlss	Lro_7
	movb	$0, r1
Lro_7:
	movb	-5(fp), r0
	mcomb	r1, r2
	bicb3	r2, r0, r2
	jlbc	r2, Lel_7
	movl	-4(fp), r0
	mull2	$260, r0
	movab	array, r1
	addl2	r0, r1
	movab	(r1), r0
	addl2	$0, r0
	pushr	$0x3803
	movab	(r0), r11
	movab	-5(fp), ap
	jsb	readString
	popr	$0x3803
	movl	-4(fp), r2
	mull2	$260, r2
	movab	array, r3
	addl2	r2, r3
	movab	(r3), r2
	addl2	$256, r2
	movl	-4(fp), (r2)
	movl	-4(fp), r4
	mull2	$260, r4
	movab	array, r5
	addl2	r4, r5
	movab	(r5), r4
	addl2	$0, r4
	pushr	$0x2F
	movc3	$256, (r4), -261(fp)
	popr	$0x2F
	pushr	$0x2F
	movc3	$256, Lstr_1, -517(fp)
	popr	$0x2F
	movb	$1, -5(fp)
	pushr	$0xF
	cmpc5	-261(fp), -259(fp), $0, -517(fp), -515(fp)
	popr	$0xF
	jneq	Lro_8
	movb	$0, -5(fp)
Lro_8:
	movl	-4(fp), r4
	addl3	$1, r4, -4(fp)
	jbr	Lbg_7
Lel_7:
Leg_7:
	movl	-4(fp), r4
	subl3	$1, r4, size
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
	movl	$0, -4(fp)
Lbg_8:
	movl	-4(fp), r0
	movl	size, r1
	movb	$1, r2
	cmpl	r0, r1
	jlss	Lro_9
	movb	$0, r2
Lro_9:
	jlbc	r2, Lel_8
	movl	-4(fp), r0
	mull2	$260, r0
	movab	array, r1
	addl2	r0, r1
	movab	(r1), r0
	addl2	$256, r0
	movl	(r0), r0
	movl	r0, -8(fp)
	pushr	$0x3802
	movab	-8(fp), r11
	moval	-8(fp), ap
	jsb	writeInt
	popr	$0x3802
	pushr	$0x2
	movc3	$256, Lstr_2, -264(fp)
	popr	$0x2
	pushr	$0x3802
	movab	-8(fp), r11
	movab	-264(fp), ap
	jsb	writeString
	popr	$0x3802
	movl	-4(fp), r0
	mull2	$260, r0
	movab	array, r2
	addl2	r0, r2
	movab	(r2), r0
	addl2	$0, r0
	pushr	$0x6
	movc3	$256, (r0), -264(fp)
	popr	$0x6
	pushr	$0x3806
	movab	-8(fp), r11
	movab	-264(fp), ap
	jsb	writeString
	popr	$0x3806
	movl	$10, -8(fp)
	pushr	$0x3806
	movab	-8(fp), r11
	moval	-8(fp), ap
	jsb	writeChar
	popr	$0x3806
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
	.word	0
	.space	254
	.text
Lstr_2:
	.word	1
	.byte	9
	.space	253
