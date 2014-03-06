	.stabs	"qsort-ints-p.p",0x30,0,0x1,0x1
	.stabs	"MAX",0x30,0,0x4,0x4
	.stabs	"index",0x30,0,0x5,0x6
	.stabs	"item",0x30,0,0x5,0x7
	.data
	.align 2
	.comm	_a,1200012
	.text
	.stabs	"a",0x30,0,0x6,0xc
	.text
	.align	1
	.globl	___initialize
	.globl	_initialize
_initialize:
	.word	L3
	.stabs	"initialize",0x30,0,0x8,0x12
L6:
	subl2	$LF2,sp
	cvtwl	$333,-56(fp)
	.data
	.align 2
L7:
	.double 0d5.00000000000000000000e-01
	.text
	movd	L7,-76(fp)
	movl	$1,-80(fp)
	movl	$100000,-84(fp)
	cmpl	-80(fp),-84(fp)
	jgtr	L8
	movl	-80(fp),r11
L9:
	movl	r11,-60(fp)
	cvtwl	$1317,r0
	mull2	-56(fp),r0
	divl3	$214748,r0,r1
	mull2	$214748,r1
	subl3	r1,r0,r1
	movl	r1,-56(fp)
	mull3	$12,r11,r0
	addl3	r0,$_a,r0
	movl	-56(fp),(r0)
	.data
	.align 2
L10:
	.double 0d3.00000000000000000000e+00
	.text
	muld3	L10,-76(fp),r0
	mull3	$12,r11,r2
	addl3	r2,$_a,r2
	movd	r0,4(r2)
	.data
	.align 2
L11:
	.double 0d5.00000000000000000000e-01
	.text
	addd3	L11,-76(fp),r0
	movd	r0,-76(fp)
	cmpl	r11,-84(fp)
	jgeq	L8
	addl3	$1,r11,r0
	movl	r0,r11
	jbr	L9
L8:
	.set	LF2,84
	ret
	.set	L3,0x800
	.align 1
___initialize:
	.word	L3
	pushl	4(ap)
	pushl	8(ap)
	movl	4(sp),r0
	movc3	4(r0),__disply+8,*(sp)+
	movl	(sp)+,r0
	movc3	4(r0),8(r0),__disply+8
	jbr	L6
	.text
	.align	1
	.globl	___qsort
	.globl	_qsort
_qsort:
	.word	L13
	.stabs	"qsort",0x30,0,0x8,0x1f
L16:
	subl2	$LF12,sp
	movl	4(ap),-56(fp)
	movl	8(ap),-60(fp)
	addl3	8(ap),4(ap),r0
	movl	$2,r1
	divl2	r1,r0
	mull2	$12,r0
	addl2	$_a,r0
	movc3	$12,(r0),-72(fp)
L17:
L18:
	mull3	$12,-56(fp),r0
	addl3	r0,$_a,r0
	cmpl	(r0),-72(fp)
	jgeq	L19
	movl	$1,r0
	addl2	-56(fp),r0
	movl	r0,-56(fp)
	jbr	L18
L19:
L20:
	mull3	$12,-60(fp),r0
	addl3	r0,$_a,r0
	cmpl	-72(fp),(r0)
	jgeq	L21
	movl	-60(fp),r0
	movl	$1,r1
	subl2	r1,r0
	movl	r0,-60(fp)
	jbr	L20
L21:
	cmpl	-56(fp),-60(fp)
	jgtr	L22
	mull3	$12,-56(fp),r0
	addl3	r0,$_a,r0
	movc3	$12,(r0),-84(fp)
	mull3	$12,-60(fp),r0
	addl3	r0,$_a,r0
	mull3	$12,-56(fp),r1
	addl3	r1,$_a,r1
	movc3	$12,(r0),(r1)
	subl3	$84,fp,r0
	mull3	$12,-60(fp),r1
	addl3	r1,$_a,r1
	movc3	$12,(r0),(r1)
	movl	$1,r0
	addl2	-56(fp),r0
	movl	r0,-56(fp)
	movl	-60(fp),r0
	movl	$1,r1
	subl2	r1,r0
	movl	r0,-60(fp)
L22:
	cmpl	-56(fp),-60(fp)
	jleq	L17
	cmpl	4(ap),-60(fp)
	jgeq	L23
	pushl	-60(fp)
	pushl	4(ap)
	calls	$2,_qsort
L23:
	cmpl	-56(fp),8(ap)
	jgeq	L24
	pushl	8(ap)
	pushl	-56(fp)
	calls	$2,_qsort
L24:
	.set	LF12,84
	ret
	.set	L13,0x0
	.align 1
___qsort:
	.word	L13
	pushl	12(ap)
	pushl	16(ap)
	movl	4(sp),r0
	movc3	4(r0),__disply+8,*(sp)+
	movl	(sp)+,r0
	movc3	4(r0),8(r0),__disply+8
	jbr	L16
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
	.word	L25
L28:
	subl2	$LF1,sp
	calls	$0,_initialize
	pushl	$100000
	pushl	$1
	calls	$2,_qsort
	.set	LF1,52
	ret
	.set	L25,0x0
