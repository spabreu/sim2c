	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	readReal
	.globl	writeReal
	.globl	readString
	.globl	writeString
	.globl	writeChar
	.globl	program
	.text
program:
Lp_1:
# args:   0 bytes
# result: 0 bytes
# locals: 257 bytes
# temps:  512 bytes
#
#     more:	local    (1 bytes)	at -1(fp)
#     s:	local    (256 bytes)	at -257(fp)
#
	movl	sp, fp
	subl2	$769, sp
	movc3	$256, Lstr_1, -513(fp)
	pushr	$0x3800
	movab	-513(fp), r11
	movab	-513(fp), ap
	jsb	writeString
	popr	$0x3800
	movb	$1, -1(fp)
Lbg_1:
	movb	-1(fp), r0
	jlbc	r0, Lel_1
	movc3	$256, Lstr_2, -513(fp)
	pushr	$0x3800
	movab	-513(fp), r11
	movab	-513(fp), ap
	jsb	writeString
	popr	$0x3800
	pushr	$0x3800
	movab	-257(fp), r11
	movab	-513(fp), ap
	jsb	readString
	popr	$0x3800
	movc3	$256, Lstr_3, -513(fp)
	pushr	$0x3800
	movab	-513(fp), r11
	movab	-513(fp), ap
	jsb	writeString
	popr	$0x3800
	movc3	$256, -257(fp), -513(fp)
	pushr	$0x3800
	movab	-513(fp), r11
	movab	-513(fp), ap
	jsb	writeString
	popr	$0x3800
	movc3	$256, Lstr_4, -513(fp)
	pushr	$0x3800
	movab	-513(fp), r11
	movab	-513(fp), ap
	jsb	writeString
	popr	$0x3800
	movc3	$256, -257(fp), -513(fp)
	movc3	$256, Lstr_5, -769(fp)
	movb	$1, -1(fp)
	cmpc5	-513(fp), -511(fp), $0, -769(fp), -767(fp)
	jneq	Lro_1
	movb	$0, -1(fp)
Lro_1:
	jbr	Lbg_1
Lel_1:
Leg_1:
	movc3	$256, Lstr_6, -513(fp)
	pushr	$0x3800
	movab	-513(fp), r11
	movab	-513(fp), ap
	jsb	writeString
	popr	$0x3800
	movl	fp, sp
	rsb

	.text
Lstr_1:
	.word	10
	.byte	72,105,32,116,104,101,114,101,46,10
	.space	244
	.text
Lstr_2:
	.word	2
	.byte	63,32
	.space	252
	.text
Lstr_3:
	.word	12
	.byte	89,111,117,32,116,121,112,101,100,58,32,34
	.space	242
	.text
Lstr_4:
	.word	3
	.byte	34,46,10
	.space	251
	.text
Lstr_5:
	.word	0
	.space	254
	.text
Lstr_6:
	.word	16
	.byte	83,101,101,32,121,111,117,32,97,114,111,117,110,100,46
	.byte	10
	.space	238
