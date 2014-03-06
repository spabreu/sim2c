	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	ex1
	.text
ex1:
# args:   8 bytes
# result: 4 bytes
# locals: 8 bytes
# temps:  8 bytes
#
#     a:	argument (4 bytes)	at (ap)
#     b:	argument (4 bytes)	at -4(ap)
#     i:	local    (4 bytes)	at -4(fp)
#     j:	local    (4 bytes)	at -8(fp)
#
	movl	sp, fp
	subl2	$16, sp
	movl	$1, -16(fp)
	movl	$2, -16(fp)
	movl	-16(fp), -4(fp)
	movl	-16(fp), -8(fp)
	movl	fp, sp
	rsb

