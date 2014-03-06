/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   VSPL run-time library (as part).					     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/

	.set	rp, %11

	.data
result:	.long	0

	.text
	.globl	_sspl_main
	.globl	program

_sspl_main:
	.word	0x0000
	pushr	$0xFFFF
	moval	0, ap
	moval	result, r11
	jsb	program
	popr	$0xFFFF
	movl	result, r0
	ret

# VSPL glue routines

	.globl	writeInt
writeInt:
	pushl	(ap)
	calls	$1, _writeInt
	rsb

	.globl	writeReal
writeReal:
	pushl	(ap)
	calls	$1, _writeReal
	rsb

	.globl	writeBool
writeBool:
	cvtbl	(ap), r0
	pushl	r0
	calls	$1, _writeBool
	rsb

	.globl	writeChar
writeChar:
	pushl	(ap)
	calls	$1, _writeChar
	rsb

	.globl	writeString
writeString:
	pushal	2(ap)
	cvtwl	(ap), -(sp)
	calls	$2, _writeString
	rsb


	.globl	readInt
readInt:
	calls	$0, _readInt
	movl	r0, (r11)
	rsb

	.globl	readReal
readReal:
	calls	$0, _readReal
	movl	r0, (r11)
	rsb

	.globl	readBool
readBool:
	calls	$0, _readBool
	movb	r0, (r11)
	rsb

	.globl	readString
readString:
	pushab	2(r11)
	pushaw	(r11)
	calls	$2, _readString
	rsb
