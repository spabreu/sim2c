/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   Code generation (Unix VAX assembler).				     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

cgInit <-> header, resetLabels(guard), resetLabels(if), resetLabels(rel).

header <-> tab, write('.set'), tab, write('rp, %11'), nl, nl.

global(N) <-> tab, write('.globl'), tab, write(N), nl.
extern(N) <-> tab, write('.globl'), tab, write(N), nl.
label(N) <-> write(N), write(':'), nl.
label(X,N) <-> tab, write('.'), write(X), nl, label(N).


prelude(LS, L)
	<-> write('# args:   '), write(A), write(' bytes'), nl,
	    write('# result: '), write(R), write(' bytes'), nl,
	    write('# locals: '), write(L), write(' bytes'), nl,
	    write('# temps:  '), write(T), write(' bytes'), nl,
	    write('#'), nl,
	    dumpLocals(LS),
	    write('#'), nl,
	    tab, write(movl),  tab, write('sp, fp'), nl,
	    tab, write(subl2), tab, write('$'), write(Sz), write(', sp'), nl
	<=  lookup1(sizes(args(A), result(R), locals(L), temps(T)), LS),
	    lookup1(temps(Ts), LS), computeTempSize(Ts, 0, T),
	    Sz is L+T.

postlude(LS)
	<-> tab, write(movl),  tab, write('fp, sp'), nl,
	    tab, write(rsb), nl, nl.


dumpLocals(X) ! <= var(X).
dumpLocals([id(I)-A|LS])
	<-> lookup1(address(X), A), lookup1(type(_,Sz), A),
	    write('#     '), write(I), write(':'), tab,
	    dumpClass(A),
	    write(' ('), write(Sz), write(' bytes)'), tab,
	    write('at '), arg(X,_), nl,
	    dumpLocals(LS).
dumpLocals([_|LS]) <-> dumpLocals(LS).

dumpClass(A) <-> write('local   ')	<= lookup1(write, A).
dumpClass(A) <-> write('argument')	<= lookup1(formal, A).
dumpClass(A) <-> write('constant')	<= lookup1(const(_), A).

computeTempSize(X, N, N) ! <= var(X).
computeTempSize([t(r(_),_,_)|Ts], A, B) <-> computeTempSize(Ts, A, B).
computeTempSize([t(_,S,_)|Ts], A, B) <-> computeTempSize(Ts, C, B) <= C is A+S.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cg/2: Emit the final assembly code. Attempt to make some peephole
%       optimizations as well.
%


% Through with this code -----------------------------------------------------

cg([], T) !.


% Redundant push/pop registers -----------------------------------------------

cg([op1(pushr,X), op1(popr, X) | Os], T) <-> cg(Os, T).


% Generic opcode stream stuff ------------------------------------------------

cg([O|Os], T) <-> cg(O, T), cg(Os, T).


% Now the individual opcodes -------------------------------------------------

cg(label(X), T) <-> label(X).

cg(op5(Op, A1, A2, A3, A4, A5), T)
	<-> tab, opcode(Op), tab,
	    arg(A1, T), coma,
	    arg(A2, T), coma,
	    arg(A3, T), coma,
	    arg(A4, T), coma,
	    arg(A5, T), nl.

cg(op3(Op, Len, A,  A2, A), T)
	<-> cg(op2(Op, Len, A2, A), T).

cg(op3(Op, Len, A1, A2, A3), T)
	<-> tab, opcode(Op, 3, Len), tab,
	    arg(A2, T), coma,
	    arg(A1, T), coma,
	    arg(A3, T), nl.

cg(op3(Op, A1, A2, A3), T)
	<-> tab, opcode(Op), tab,
	    arg(A1, T), coma,
	    arg(A2, T), coma,
	    arg(A3, T), nl.

cg(op2(Op, Len, A1, A2), T)
	<-> tab, opcode(Op, 2, Len), tab,
	    arg(A1, T), coma,
	    arg(A2, T), nl.

cg(op2(Op, A1, A2), T)
	<-> tab, opcode(Op), tab,
	    arg(A1, T), coma,
	    arg(A2, T), nl.

cg(op1(Op, Len, A), T)
	<-> tab, opcode(Op, Len), tab,
	    arg(A, T), nl.

cg(op1(Op, A), T)
	<-> tab, opcode(Op), tab,
	    arg(A, T), nl.


opcode(Op) <-> write(Op).

opcode(Op, L) <-> write(Op), length(L).

opcode(cmp, 2, L) <-> write(cmp), length(L).
opcode(mcom, 2, L) <-> write(mcom), length(L).
opcode(mov, 2, L) <-> write(mov), length(L).
opcode(mova, 2, L) <-> write(mova), (length(L) ; write('b')).
opcode(Op, N, L) <-> write(Op), length(L), write(N).

	length(int)  <-> write('l').
	length(real) <-> write('f').
	length(bool) <-> write('b').
	length(byte) <-> write('b').
	length(char) <-> write('c').

arg(label(X),     T)          <-> write(X).
arg(offset(0, R), T)          <-> write('('), arg(R, T), write(')').
arg(offset(N, R), T)          <-> write(N), write('('), arg(R, T), write(')').
arg(autodec(R),   T)          <-> write('-('), reg(R), write(')').
arg(autoinc(R),   T)          <-> write('('), reg(R), write(')+').
arg(lit(X),       T)          <-> write('$'), arg(X, T).
arg(int(X),       T)          <-> write(X).
arg(byte(X),      T)          <-> write(X).
arg(bool(true),   T)          <-> write(1).
arg(bool(false),  T)          <-> write(0).
arg(bool(X),      T)          <-> write(X).
arg(real(X),      T)          <-> write('0f'), wfloat(X).
arg(string(X),    T)	      <-> stringArg(X).
arg(hex(X),       T)          <-> write('0x'), hex(X).
arg(reg(X),       T)          <-> reg(X).
arg(t(r(N),_,_),  T)          <-> reg(r(N)).
arg(t(N,S,_),     T)          <-> M is N-T, arg(offset(M,fp), T).
arg(indirect(reg(R)), T)      <-> write('('), reg(R), write(')').
arg(indirect(t(r(N),_,_)), T) <-> write('('), reg(r(N)), write(')').
arg(indirect(X),  T)          <-> write('*'), arg(X, T).
arg(R,            T)          <-> reg(R).

hex(0) <-> write(0).
hex(N) <-> hexDigit(N) <= N < 16.
hex(N) <-> hex(M), hexDigit(D) <= M is N//16, D is mod(N,16).

hexDigit(N) <-> write(N) <= N < 10.
hexDigit(N) <-> "A"=[X], Y is X+N-10, put(Y).

reg(reg(X)) <-> reg(X).
reg(r(N))   <-> write(r), write(N).
reg(rp)     <-> write(r11).
reg(X)      <-> write(X).

wfloat(X) <-> write(X), write('.0') <= integer(X).
wfloat(X) <-> write(X).

stringArg(X)
	<-> assertz(strings(L, X))
	<=  newLabel(lit, N), genLabel(str, N, L), write(L).

data(lit(int(V)))  <-> write('.long'),  tab, arg(int(V),  S).
data(lit(real(V))) <-> write('.float'), tab, arg(real(V), S).
data(lit(bool(V))) <-> write('.byte'),  tab, arg(bool(V), S).

tab <-> put(9).
coma <-> put(44), put(32).

