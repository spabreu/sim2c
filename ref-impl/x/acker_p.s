	.stabs	"acker_p.p",0x30,0,0x1,0x1
	.stabs	"MC",0x30,0,0x4,0x3
	.stabs	"NC",0x30,0,0x4,0x4
	.text
	.align	1
	.globl	___acker
	.globl	_acker
_acker:
	.word	L3
	.stabs	"acker",0x30,0,0x7,0x7
L6:
	subl2	$LF2,sp
	tstl	4(ap)
	jneq	L7
	movl	$1,r0
	addl2	8(ap),r0
	movl	r0,-56(fp)
	jbr	L8
L7:
	tstl	8(ap)
	jneq	L9
	pushl	$1
	movl	4(ap),r0
	movl	$1,r1
	subl2	r1,r0
	pushl	r0
	calls	$2,_acker
	movl	r0,-56(fp)
	jbr	L10
L9:
	movl	8(ap),r0
	movl	$1,r1
	subl2	r1,r0
	pushl	r0
	pushl	4(ap)
	calls	$2,_acker
	pushl	r0
	movl	4(ap),r0
	movl	$1,r1
	subl2	r1,r0
	pushl	r0
	calls	$2,_acker
	movl	r0,-56(fp)
L10:
L8:
	movl	-56(fp),r0
	.set	LF2,56
	ret
	.set	L3,0x0
	.align 1
___acker:
	.word	L3
	pushl	12(ap)
	pushl	16(ap)
	movl	4(sp),r0
	movc3	4(r0),__disply+8,*(sp)+
	movl	(sp)+,r0
	movc3	4(r0),8(r0),__disply+8
	jbr	L6
	.text
	.align	1
	.globl	_main
_main:
	.word	0
	pushl	$0
	calls	$1,_PCSTART
	movl	4(ap),__argc
	movl	8(ap),__argv
	calls	$0,_program
	pushl	$0
	calls	$1,_PCEXIT
	.text
	.align	1
	.globl	_program
_program:
	.word	L11
L14:
	subl2	$LF1,sp
	moval	_output,-12(fp)
	.data
L15:
	.byte	045,061,060,0104
	.byte	0
	.text
	cvtwl	$8,-(sp)
	cvtwl	$3,-(sp)
	calls	$2,_acker
	pushl	r0
	pushl	$L15
	pushl	-12(fp)
	movl	(sp)+,r1
	movl	12(r1),r0
	pushl	r0
	calls	$3,_fprintf
	pushl	-12(fp)
	movl	(sp)+,r1
	movl	12(r1),r0
	pushl	r0
	cvtbl	$10,-(sp)
	sobgeq	*4(sp),1f
	calls	$2,__flsbuf
	jbr	2f
1:
	popr	$0x3
	movb	r0,*4(r1)
	incl	4(r1)
2:
	.set	LF1,52
	ret
	.set	L11,0x0
