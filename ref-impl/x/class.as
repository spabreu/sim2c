	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	readReal
	.globl	writeReal
	.globl	writeChar
	.globl	foo
	.text
foo:
# args:   0 bytes
# result: 0 bytes
# locals: 92 bytes
# temps:  0 bytes
#
#     r:	local    (8 bytes)	at -8(fp)
#     a:	local    (80 bytes)	at -88(fp)
#     x:	local    (4 bytes)	at -92(fp)
#
	movl	sp, fp
	subl2	$92, sp
	movab	-8(fp), r0
	addl2	$0, r0
	movl	$10, (r0)
	movab	-8(fp), r1
	addl2	$4, r1
	movl	$20, (r1)
	movab	-88(fp), r2
	addl2	$8, r2
	movab	(r2), r3
	addl2	$0, r3
	movl	$30, (r3)
	movab	-88(fp), r4
	addl2	$16, r4
	movab	(r4), r5
	addl2	$4, r5
	movl	$40, (r5)
	movab	-8(fp), r6
	addl2	$0, r6
	movl	(r6), -92(fp)
	movab	-8(fp), r6
	addl2	$4, r6
	movl	(r6), -92(fp)
	movab	-88(fp), r6
	addl2	$8, r6
	movab	(r6), r7
	addl2	$0, r7
	movl	(r7), -92(fp)
	movab	-88(fp), r7
	addl2	$16, r7
	movab	(r7), r8
	addl2	$4, r8
	movl	(r8), -92(fp)
	movl	fp, sp
	rsb

