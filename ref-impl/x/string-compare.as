	.globl	readInt
	.globl	writeInt
	.globl	readBool
	.globl	writeBool
	.globl	readReal
	.globl	writeReal
	.globl	readString
	.globl	writeString
	.globl	writeChar
	.globl	showString
	.text
showString:
Lp_1:
# args:   256 bytes
# result: 0 bytes
# locals: 0 bytes
# temps:  256 bytes
#
#     s:	argument (256 bytes)	at (ap)
#
	movl	sp, fp
	subl2	$256, sp
	movc3	$256, Lstr_1, -256(fp)
	pushr	$0x3800
	movab	-256(fp), r11
	movab	-256(fp), ap
	jsb	writeString
	popr	$0x3800
	movc3	$256, (ap), -256(fp)
	pushr	$0x3800
	movab	-256(fp), r11
	movab	-256(fp), ap
	jsb	writeString
	popr	$0x3800
	movc3	$256, Lstr_2, -256(fp)
	pushr	$0x3800
	movab	-256(fp), r11
	movab	-256(fp), ap
	jsb	writeString
	popr	$0x3800
	movl	fp, sp
	rsb

	.globl	compare
	.text
compare:
Lp_2:
# args:   769 bytes
# result: 0 bytes
# locals: 0 bytes
# temps:  257 bytes
#
#     s1:	argument (256 bytes)	at (ap)
#     s2:	argument (256 bytes)	at 256(ap)
#     op:	argument (256 bytes)	at 512(ap)
#     v:	argument (1 bytes)	at 768(ap)
#
	movl	sp, fp
	subl2	$257, sp
	movc3	$256, (ap), -256(fp)
	pushr	$0x3800
	movab	-256(fp), r11
	movab	-256(fp), ap
	jsb	showString
	popr	$0x3800
	movc3	$256, 512(ap), -256(fp)
	pushr	$0x3800
	movab	-256(fp), r11
	movab	-256(fp), ap
	jsb	writeString
	popr	$0x3800
	movc3	$256, 256(ap), -256(fp)
	pushr	$0x3800
	movab	-256(fp), r11
	movab	-256(fp), ap
	jsb	showString
	popr	$0x3800
	movc3	$256, Lstr_3, -256(fp)
	pushr	$0x3800
	movab	-256(fp), r11
	movab	-256(fp), ap
	jsb	writeString
	popr	$0x3800
	movb	768(ap), r0
	movb	r0, -257(fp)
	pushr	$0x3800
	movab	-256(fp), r11
	movab	-257(fp), ap
	jsb	writeBool
	popr	$0x3800
	movc3	$256, Lstr_4, -256(fp)
	pushr	$0x3800
	movab	-256(fp), r11
	movab	-256(fp), ap
	jsb	writeString
	popr	$0x3800
	movl	fp, sp
	rsb

	.globl	a
	.data
a:
	.space	256

	.globl	b
	.data
b:
	.space	256

	.globl	readStrings
	.text
readStrings:
Lp_3:
# args:   0 bytes
# result: 1 bytes
# locals: 0 bytes
# temps:  512 bytes
#
#
	movl	sp, fp
	subl2	$512, sp
	movc3	$256, Lstr_5, -256(fp)
	pushr	$0x3800
	movab	-256(fp), r11
	movab	-256(fp), ap
	jsb	writeString
	popr	$0x3800
	pushr	$0x3800
	movab	a, r11
	movab	-256(fp), ap
	jsb	readString
	popr	$0x3800
Lbg_1:
	movc3	$256, a, -256(fp)
	movc3	$256, Lstr_6, -512(fp)
	movb	$1, r0
	pushr	$0x1
	cmpc5	-256(fp), -254(fp), $0, -512(fp), -510(fp)
	popr	$0x1
	jeql	Lro_1
	movb	$0, r0
Lro_1:
	jlbc	r0, Lel_1
	movb	$0, (r11)
	jbr	Leg_1
Lel_1:
	movc3	$256, Lstr_7, -256(fp)
	pushr	$0x3800
	movab	-256(fp), r11
	movab	-256(fp), ap
	jsb	writeString
	popr	$0x3800
	pushr	$0x3800
	movab	b, r11
	movab	-256(fp), ap
	jsb	readString
	popr	$0x3800
	movb	$1, (r11)
Leg_1:
	movl	fp, sp
	rsb

	.globl	program
	.text
program:
Lp_4:
# args:   0 bytes
# result: 0 bytes
# locals: 0 bytes
# temps:  1282 bytes
#
#
	movl	sp, fp
	subl2	$1282, sp
Lbg_2:
	pushr	$0x3800
	movab	-1(fp), r11
	movab	(fp), ap
	jsb	readStrings
	popr	$0x3800
	jlbc	-1(fp), Lel_2
	movc3	$256, a, -770(fp)
	movc3	$256, b, -514(fp)
	movc3	$256, Lstr_8, -258(fp)
	movc3	$256, a, -1026(fp)
	movc3	$256, b, -1282(fp)
	movb	$1, -2(fp)
	cmpc5	-1026(fp), -1024(fp), $0, -1282(fp), -1280(fp)
	jlss	Lro_2
	movb	$0, -2(fp)
Lro_2:
	pushr	$0x3800
	movab	(fp), r11
	movab	-770(fp), ap
	jsb	compare
	popr	$0x3800
	movc3	$256, a, -770(fp)
	movc3	$256, b, -514(fp)
	movc3	$256, Lstr_9, -258(fp)
	movc3	$256, a, -1026(fp)
	movc3	$256, b, -1282(fp)
	movb	$1, -2(fp)
	cmpc5	-1026(fp), -1024(fp), $0, -1282(fp), -1280(fp)
	jleq	Lro_3
	movb	$0, -2(fp)
Lro_3:
	pushr	$0x3800
	movab	(fp), r11
	movab	-770(fp), ap
	jsb	compare
	popr	$0x3800
	movc3	$256, a, -770(fp)
	movc3	$256, b, -514(fp)
	movc3	$256, Lstr_10, -258(fp)
	movc3	$256, a, -1026(fp)
	movc3	$256, b, -1282(fp)
	movb	$1, -2(fp)
	cmpc5	-1026(fp), -1024(fp), $0, -1282(fp), -1280(fp)
	jeql	Lro_4
	movb	$0, -2(fp)
Lro_4:
	pushr	$0x3800
	movab	(fp), r11
	movab	-770(fp), ap
	jsb	compare
	popr	$0x3800
	movc3	$256, a, -770(fp)
	movc3	$256, b, -514(fp)
	movc3	$256, Lstr_11, -258(fp)
	movc3	$256, a, -1026(fp)
	movc3	$256, b, -1282(fp)
	movb	$1, -2(fp)
	cmpc5	-1026(fp), -1024(fp), $0, -1282(fp), -1280(fp)
	jneq	Lro_5
	movb	$0, -2(fp)
Lro_5:
	pushr	$0x3800
	movab	(fp), r11
	movab	-770(fp), ap
	jsb	compare
	popr	$0x3800
	movc3	$256, a, -770(fp)
	movc3	$256, b, -514(fp)
	movc3	$256, Lstr_12, -258(fp)
	movc3	$256, a, -1026(fp)
	movc3	$256, b, -1282(fp)
	movb	$1, -2(fp)
	cmpc5	-1026(fp), -1024(fp), $0, -1282(fp), -1280(fp)
	jgeq	Lro_6
	movb	$0, -2(fp)
Lro_6:
	pushr	$0x3800
	movab	(fp), r11
	movab	-770(fp), ap
	jsb	compare
	popr	$0x3800
	movc3	$256, a, -770(fp)
	movc3	$256, b, -514(fp)
	movc3	$256, Lstr_13, -258(fp)
	movc3	$256, a, -1026(fp)
	movc3	$256, b, -1282(fp)
	movb	$1, -2(fp)
	cmpc5	-1026(fp), -1024(fp), $0, -1282(fp), -1280(fp)
	jgtr	Lro_7
	movb	$0, -2(fp)
Lro_7:
	pushr	$0x3800
	movab	(fp), r11
	movab	-770(fp), ap
	jsb	compare
	popr	$0x3800
	movc3	$256, Lstr_14, -1026(fp)
	pushr	$0x3800
	movab	(fp), r11
	movab	-1026(fp), ap
	jsb	writeString
	popr	$0x3800
	jbr	Lbg_2
Lel_2:
Leg_2:
	movl	fp, sp
	rsb

	.text
Lstr_1:
	.word	1
	.byte	34
	.space	253
	.text
Lstr_2:
	.word	1
	.byte	34
	.space	253
	.text
Lstr_3:
	.word	5
	.byte	32,60,61,62,32
	.space	249
	.text
Lstr_4:
	.word	2
	.byte	46,10
	.space	252
	.text
Lstr_5:
	.word	10
	.byte	83,116,114,105,110,103,32,49,58,32
	.space	244
	.text
Lstr_6:
	.word	0
	.space	254
	.text
Lstr_7:
	.word	10
	.byte	83,116,114,105,110,103,32,50,58,32
	.space	244
	.text
Lstr_8:
	.word	4
	.byte	32,60,32,32
	.space	250
	.text
Lstr_9:
	.word	4
	.byte	32,60,61,32
	.space	250
	.text
Lstr_10:
	.word	4
	.byte	32,61,32,32
	.space	250
	.text
Lstr_11:
	.word	4
	.byte	32,126,61,32
	.space	250
	.text
Lstr_12:
	.word	4
	.byte	32,62,61,32
	.space	250
	.text
Lstr_13:
	.word	4
	.byte	32,62,32,32
	.space	250
	.text
Lstr_14:
	.word	1
	.byte	10
	.space	253
