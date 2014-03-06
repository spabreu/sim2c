	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	readReal
	.globl	writeReal
	.globl	writeChar
	.globl	rev
	.text
rev:
# args:   404 bytes
# result: 400 bytes
# locals: 4 bytes
# temps:  12 bytes
#
#     ar:	argument (400 bytes)	at (ap)
#     n:	argument (4 bytes)	at 400(ap)
#     i:	local    (4 bytes)	at -4(fp)
#
	movl	sp, fp
	subl2	$16, sp
	movl	$0, -4(fp)
Lbg_1:
	movl	-4(fp), r0
	movl	400(ap), r1
	divl2	$2, r1
	movb	$1, r2
	cmpl	r0, r1
	jlss	Lro_1
	movb	$0, r2
Lro_1:
	jlbc	r2, Lel_1
	movl	400(ap), r0
	movl	-4(fp), r1
	subl2	r1, r0
	subl2	$1, r0
	movab	(ap), r1
	mull2	$4, r0
	addl2	r0, r1
	movl	(r1), -12(fp)
	movl	-4(fp), r0
	movab	(ap), r1
	mull2	$4, r0
	addl2	r0, r1
	movl	(r1), -8(fp)
	movl	-4(fp), r0
	mull2	$4, r0
	movab	(ap), r1
	addl2	r0, r1
	movl	-12(fp), (r1)
	movl	400(ap), r0
	movl	-4(fp), r2
	subl2	r2, r0
	subl2	$1, r0
	mull2	$4, r0
	movab	(ap), r2
	addl2	r0, r2
	movl	-8(fp), (r2)
	movl	-4(fp), r0
	movl	r0, -16(fp)
	pushr	$0x3806
	movab	-16(fp), r11
	moval	-16(fp), ap
	jsb	writeInt
	popr	$0x3806
	movl	$10, -16(fp)
	pushr	$0x3806
	movab	-16(fp), r11
	moval	-16(fp), ap
	jsb	writeChar
	popr	$0x3806
	movl	-4(fp), r0
	addl3	$1, r0, -4(fp)
	jbr	Lbg_1
Lel_1:
Leg_1:
	movc3	$400, (ap), (r11)
	movl	fp, sp
	rsb

	.globl	program
	.text
program:
# args:   0 bytes
# result: 4 bytes
# locals: 408 bytes
# temps:  409 bytes
#
#     x:	local    (400 bytes)	at -400(fp)
#     n:	local    (4 bytes)	at -404(fp)
#     k:	local    (4 bytes)	at -408(fp)
#
	movl	sp, fp
	subl2	$817, sp
	pushr	$0x3800
	moval	-404(fp), r11
	movab	-408(fp), ap
	jsb	readInt
	popr	$0x3800
	movl	$0, -408(fp)
Lbg_2:
	movl	-408(fp), r0
	movl	-404(fp), r1
	movb	$1, r2
	cmpl	r0, r1
	jlss	Lro_2
	movb	$0, r2
Lro_2:
	jlbc	r2, Lel_2
	movl	-408(fp), r0
	mull2	$4, r0
	movab	-400(fp), r1
	addl2	r0, r1
	pushr	$0x3802
	moval	(r1), r11
	movab	-408(fp), ap
	jsb	readInt
	popr	$0x3802
	movl	-408(fp), r0
	addl3	$1, r0, -408(fp)
	jbr	Lbg_2
Lel_2:
Leg_2:
Lbg_3:
	pushr	$0x3802
	movab	-409(fp), r11
	movab	-408(fp), ap
	jsb	readBool
	popr	$0x3802
	jlbc	-409(fp), Lel_3
	movc3	$400, -400(fp), -813(fp)
	movl	-404(fp), -413(fp)
	pushr	$0x3802
	movab	-400(fp), r11
	movab	-813(fp), ap
	jsb	rev
	popr	$0x3802
	jbr	Leg_3
Lel_3:
Leg_3:
	movl	$0, -408(fp)
Lbg_4:
	movl	-408(fp), r0
	movl	-404(fp), r2
	movb	$1, r3
	cmpl	r0, r2
	jlss	Lro_3
	movb	$0, r3
Lro_3:
	jlbc	r3, Lel_4
	movl	-408(fp), r0
	movab	-400(fp), r2
	mull2	$4, r0
	addl2	r0, r2
	movl	(r2), r0
	movl	r0, -817(fp)
	pushr	$0x3802
	movab	-408(fp), r11
	moval	-817(fp), ap
	jsb	writeInt
	popr	$0x3802
	movl	$32, -817(fp)
	pushr	$0x3802
	movab	-408(fp), r11
	moval	-817(fp), ap
	jsb	writeChar
	popr	$0x3802
	movl	-408(fp), r0
	addl3	$1, r0, -408(fp)
	jbr	Lbg_4
Lel_4:
Leg_4:
	movl	$10, -817(fp)
	pushr	$0x3802
	movab	-408(fp), r11
	moval	-817(fp), ap
	jsb	writeChar
	popr	$0x3802
	movl	fp, sp
	rsb

