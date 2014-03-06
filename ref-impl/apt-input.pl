/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   APT construction (from yacc).					     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/

:- op(100, xfx, ('==>')).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% APTs are fed as a series of stack operations (Old ==> New), followed
% by an end-of-file.
%
% makeAPT(Term) returns a list of global declarations (hopefully) that
% corresponds to the program just read.
%

makeAPT(T) <-> makeAPT([] ==> [], [], T).

makeAPT(end_of_file, S, S) !.
makeAPT(O ==> C,     O, N) <-> makeAPT(X, C, N) <= read(X).


/******************************************************************************/

parser("~/aulas/pc/sspl/0/sspl").
browser("~/X/browser/browser").

type(source, ".s").
type(stack,  ".so").
type(as,     ".as").
type(object, ".o").
type(apt,    ".apt").
type(aptx,   ".aptx").

prefix("").

name(N, Type, Name) <->
	prefix(P),
	name(N, X0),
	append(P, X0, X1),
	type(Type, T),
	append(X1, T, Name).

make(stack,N) <-> name(N, source, S), name(N, stack, SO),
	parser(SSPL),
	append(SSPL, " <", X0),
	append(X0, S, X1),
	append(X1, " >", X2),
	append(X2, SO, Command),
	shell(Command).

load(N) <-> name(N, stack, SO), name(SOFile, SO),
	see(SOFile), try makeAPT(X), seen,
	( retract(apt(N,_)), fail ; true),
	assert(apt(N,X)).

make(apt,N) <-> name(N, apt, A), name(AFile, A),
	tell(AFile), apt(N,APT), wr(APT), nl, told.

make(aptx,N) <-> name(N, aptx, A), name(AFile, A),
	tell(AFile), aptx(N,APT), wr(APT), nl, told.

restart <-> save('sspl-pl'), write('VSPL Level 0.'), nl.
