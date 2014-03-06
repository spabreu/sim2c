	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	sum
	.text
sum:
# args:   8 bytes
# result: 4 bytes
# locals: 0 bytes
# temps:  0 bytes
#
#     a:	argument (4 bytes)	at (ap)
#     b:	argument (4 bytes)	at -4(ap)
#
	movl	sp, fp
	subl2	$0, sp
	movl	(ap), r0
	movl	-4(ap), r1
	addl3	r1, r0, (r11)
	movl	fp, sp
	rsb

