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
# locals: 412 bytes
# temps:  13 bytes
#
#     ar:	local    (400 bytes)	at -400(fp)
#     n:	local    (4 bytes)	at -404(fp)
#     k:	local    (4 bytes)	at -408(fp)
#     i:	local    (4 bytes)	at -412(fp)
#
	movl	sp, fp
	subl2	$425, sp
	pushr	$0x3800
	moval	-404(fp), r11
	movab	-412(fp), ap
	jsb	readInt
	popr	$0x3800
	movl	$0, -408(fp)
Lbg_1:
	movl	-408(fp), r0
	movl	-404(fp), r1
	movb	$1, r2
	cmpl	r0, r1
	jlss	Lro_1
	movb	$0, r2
Lro_1:
	jlbc	r2, Lel_1
	movl	-408(fp), r0
	mull2	$4, r0
	movab	-400(fp), r1
	addl2	r0, r1
	pushr	$0x3802
	moval	(r1), r11
	movab	-412(fp), ap
	jsb	readInt
	popr	$0x3802
	movl	-408(fp), r0
	addl3	$1, r0, -408(fp)
	jbr	Lbg_1
Lel_1:
Leg_1:
Lbg_2:
	pushr	$0x3802
	movab	-413(fp), r11
	movab	-412(fp), ap
	jsb	readBool
	popr	$0x3802
	jlbc	-413(fp), Lel_2
	movl	$0, -412(fp)
Lbg_3:
	movl	-412(fp), r0
	movl	-404(fp), r2
	divl2	$2, r2
	movb	$1, r3
	cmpl	r0, r2
	jlss	Lro_2
	movb	$0, r3
Lro_2:
	jlbc	r3, Lel_3
	movl	-404(fp), r0
	movl	-412(fp), r2
	subl2	r2, r0
	subl2	$1, r0
	movab	-400(fp), r2
	mull2	$4, r0
	addl2	r0, r2
	movl	(r2), -421(fp)
	movl	-412(fp), r0
	movab	-400(fp), r2
	mull2	$4, r0
	addl2	r0, r2
	movl	(r2), -417(fp)
	movl	-412(fp), r0
	mull2	$4, r0
	movab	-400(fp), r2
	addl2	r0, r2
	movl	-421(fp), (r2)
	movl	-404(fp), r0
	movl	-412(fp), r3
	subl2	r3, r0
	subl2	$1, r0
	mull2	$4, r0
	movab	-400(fp), r3
	addl2	r0, r3
	movl	-417(fp), (r3)
	movl	-412(fp), r0
	movl	r0, -425(fp)
	pushr	$0x380E
	movab	-412(fp), r11
	moval	-425(fp), ap
	jsb	writeInt
	popr	$0x380E
	movl	$10, -425(fp)
	pushr	$0x380E
	movab	-412(fp), r11
	moval	-425(fp), ap
	jsb	writeChar
	popr	$0x380E
	movl	-412(fp), r0
	addl3	$1, r0, -412(fp)
	jbr	Lbg_3
Lel_3:
Leg_3:
	jbr	Leg_2
Lel_2:
Leg_2:
	movl	$0, -408(fp)
Lbg_4:
	movl	-408(fp), r0
	movl	-404(fp), r4
	movb	$1, r5
	cmpl	r0, r4
	jlss	Lro_3
	movb	$0, r5
Lro_3:
	jlbc	r5, Lel_4
	movl	-408(fp), r0
	movab	-400(fp), r4
	mull2	$4, r0
	addl2	r0, r4
	movl	(r4), r0
	movl	r0, -425(fp)
	pushr	$0x380E
	movab	-412(fp), r11
	moval	-425(fp), ap
	jsb	writeInt
	popr	$0x380E
	movl	$32, -425(fp)
	pushr	$0x380E
	movab	-412(fp), r11
	moval	-425(fp), ap
	jsb	writeChar
	popr	$0x380E
	movl	-408(fp), r0
	addl3	$1, r0, -408(fp)
	jbr	Lbg_4
Lel_4:
Leg_4:
	movl	$10, -425(fp)
	pushr	$0x380E
	movab	-412(fp), r11
	moval	-425(fp), ap
	jsb	writeChar
	popr	$0x380E
	movl	fp, sp
	rsb

