/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   Code generation (intermediate).					     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cgSymbols/1: scan the global symbol-table and generate code for each thing
%	       found therein.
%

cgSymbols(S) <-> abolish(strings, 2), cgSymbols(S, S), cgStrings.


cgSymbols(S,      G) ! <= var(S).
cgSymbols([],     G) !.
cgSymbols([S|Ss], G) <-> cgSymbols(Ss, G) <= cgSymbols(S, G).

cgSymbols(id(N)-Val, S) <-> cgSymbol(N, Val, S).
cgSymbols(_,         S) !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cgSymbol/3: generate the code associated with a given symbol.
%

cgSymbol(N, A, S)
	<-> global(N), label(text,N),
	    cgConstant(Exp, A, S)
	<=  lookup1(const(Exp), A).

cgSymbol(N, A, S)
	<-> global(N), label(data,N),
	    cgVariable(Exp, A, S)
	<=  lookup1(var(Exp), A).

cgSymbol(N, A, S)
	<-> extern(N)
	<=  lookup1(external, A).

cgSymbol(N, A, S)
	<-> cgSpace(N, type(T, Sz), S)
	<=  lookup1(type(T, Sz), A).

cgSymbol(N, _, S)
	<-> label(data,N),
	    write('# What is this?'), nl, nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cgConstant/2: generate the code for a constant expression.
%

cgConstant(exp(_, lit(map(X,LS))), A, S)
	<-> cgStat(X, [LS|S], CC, []),
	    label(L), prelude(LS, T),
	    flatten(CC, CCf), cg(CCf, T),
	    postlude(LS)
	<=  mkRegs(R, 0, 11), enter1(temps(R), LS),
	    newLabel(proc, N), genLabel(p, N, L), enter1(procLabel(L), LS).

cgConstant(exp(type(T, Sz), Value), A, S)
	<-> tab, data(V), nl
	<=  lookup1(value(V), A).

cgConstant(Value, A, S)
	<-> tab, data(V), nl
	<=  evalConst(Value, V, S).

cgConstant(exp(type(T, Sz), Value), A, S)
	<-> tab, write('.space'), tab, write(Sz), tab,
	    write('# Couldn''t be initialized (non-constant value).'), nl, nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cgVariable/2: generate the code for an initialized variable.
%

cgVariable(exp(type(_,Sz),V), S)
	<-> tab, write('.space'), tab, write(Sz),
	    tab, write('# Should be initialized.'), nl, nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cgSpace/2: generate the code for an un-initialized variable.
%

cgSpace(N, type(_,Sz), S)
	<-> tab, write('.comm'),
	    tab, write(N), write(', '), write(Sz), nl, nl.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% @cgStat/2: Code generator for statements.
%


% Statement list -------------------------------------------------------------

@cgStat([],     S) !.

@cgStat([X|Xs], S) <-> @cgStat(Xs, S) <= @cgStat(X, S).


% Assignment to class constructor --------------------------------------------

@cgStat(assign(exp(type(T,Sz), class(Cs)), E), S)
	<-> allocAddr(exp(type(T,Sz), class(Cs)), R, S),
	    @cgValue(E, R, S),
	    @cgClassAddr(Cs, R, 0, S),
	    freeAddr(R, S).

@cgClassAddr([], _, _, _) !.
@cgClassAddr([exp(type(T,Sz),E)|Es], R, O, S)
	<-> addOffset(O, Sz, R, Rx),
	    @cgAddr(exp(type(T,Sz),E), Ea, S),
	    @copy(Sz, Rx, Ea, S),
	    freeAddr(Ea, S),
	    NO is O+Sz, @cgClassAddr(Es, R, NO, S).


% Assignment -----------------------------------------------------------------

@cgStat(assign(V, E), S)
	<-> @cgAddr(V, Vr, S),
	    @cgValue(E, Vr, S),
	    freeAddr(Vr, S).


% Procedure call or other side effect ----------------------------------------

@cgStat(discard(E), S)
	<-> @cgValue(E, Ev, S),
	    freeAddr(Ev, S).


% Return statement -----------------------------------------------------------

@cgStat(return(E), S)
	<-> @cgValue(E, indirect(reg(rp)), S).


% Guarded statement shell ----------------------------------------------------

@cgStat(guard(G, How, Clauses, Control), S)
	<-> newLabel(guard, N),
	    lookup1(begin(BG), Control), genLabel(bg, N, BG),
	    lookup1(end(EG),   Control), genLabel(eg, N, EG),
	    @cgStat(Clauses, S).


% Label ----------------------------------------------------------------------

@cgStat(label(L), S) <-> [label(L)].


% Goto -----------------------------------------------------------------------

@cgStat(goto(L), S) <-> [op1(jbr, label(L))].


% If (conditional) -----------------------------------------------------------

@cgStat(if(C, T, Ss), S)
	<-> newLabel(if, N),
	    genLabel(el, N, EL),
	    @cgTest(C, EL, S),
	    @cgStat(T, S),
	    [label(EL)],
	    @cgStat(Ss, S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% @cgAddr/3: Code generation for expressions: compute operand address,
%	     leave address in result (2nd operand).  Allocate temporary
%	     for result if necessary.
%

% Variables ------------------------------------------------------------------

@cgAddr(exp(T, id(N)), Addr, S)
	<-> allocAddr(exp(T, id(N)), Addr, S).


% Class component ------------------------------------------------------------

@cgAddr(exp(T, name(C,F,O)), indirect(Addr), S)
	<-> @cgAddr(C, Cv, S),
	    freeAddr(Cv, S),
	    allocTemp1(4, Addr, S),
	    [op2(movab, Cv, Addr)],
	    [op2(addl2, lit(int(O)), Addr)].


% Array element --------------------------------------------------------------

@cgAddr(exp(type(T,Sz), array(A, I)), indirect(Addr), S)
	<-> @cgAddr(A, Aa, S),
	    @cgValue(I, Iv, S),
	    @cgArrayAddress(Iv, type(T,Sz), Offset, S),
	    allocTemp(4, Addr, S),
	    freeAddr(Aa, S), freeAddr(Iv, S),
	    [op2(movab, Aa, Addr)],
	    [op2(addl2, Offset, Addr)].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% @cgArrayAddress/4: compute the byte offset for an array element.
%

@cgArrayAddress(I, type(T,Sz), Offset, S) !
	<=  evalConst(exp(type(int,4),
			  arithOp(bin(mul, exp(type(int,4), I),
					   exp(type(int,4), lit(int(Sz)))))),
			  Offset, S).

@cgArrayAddress(I, type(T,Sz), I, S)
	<-> [op2(mull2, lit(int(Sz)), I)].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% @cgValue/3: Code generation for expressions: store operand value into
%	      result.  Allocate temporary for result if necessary.
%


% Variables ------------------------------------------------------------------

@cgValue(exp(type(T,Sz), id(N)), Addr, S)
	<-> allocAddr(exp(type(T,Sz), id(N)), From, S),
	    allocTemp1(Sz, Addr, S),
	    @copy(Sz, From, Addr, S).


% Literals -------------------------------------------------------------------

@cgValue(exp(type(T,Sz), lit(string(X))), R, S)
	<-> allocTemp1(Sz, R, S),
	    @copy(Sz, string(X), R, S).

@cgValue(exp(type(T,Sz), lit(V)), R, S)
	<-> @copy(Sz, lit(V), R, S)
	<=  nonvar(R).

@cgValue(exp(_, lit(V)), lit(V), S) !.


% Arithmetic operators -------------------------------------------------------

@cgValue(exp(type(int,Sz), arithOp(bin(mod, X, Y))), R, S)
	<-> @cgValue(X, Xv, S),
	    @cgValue(Y, Yv, S),
	    freeAddr(Xv, S), freeAddr(Yv, S), allocTemp1(Sz, R, S),
	    [op3(div, int, Xv, Yv, R)],
	    [op2(mul, int, Yv, R)],
	    [op3(sub, int, Xv, R, R)].

@cgValue(exp(type(T,Sz), arithOp(bin(Op, X, Y))), R, S)
	<-> @cgValue(X, Xv, S),
	    @cgValue(Y, Yv, S),
	    freeAddr(Xv, S), freeAddr(Yv, S), allocTemp1(Sz, R, S),
	    [op3(Op, T, Xv, Yv, R)].

@cgValue(exp(type(T,Sz), arithOp(un(Op, X))), R, S)
	<-> @cgValue(X, Xv, S),
	    freeAddr(Xv, S), allocTemp1(Sz, R, S),
	    [op2(Op, T, Xv, R)].


% Relational operators -------------------------------------------------------

@cgValue(exp(type(T,Sz), relOp(Op, X, Y)), R, S)
	<-> @cgValue(X, Xv, S),
	    @cgValue(Y, Yv, S),
	    allocTemp1(Sz, R, S), freeAddr(Xv, S), freeAddr(Yv, S),
	    X = exp(type(XT,_), _),
	    [op2(mov, bool, lit(bool(1)), R)],
	    [op2(cmp, XT, Xv, Yv)],
	    getRelOpcode(Op, Opc),
	    [op1(Opc, label(TrueLabel))],
	    [op2(mov, bool, lit(bool(0)), R)],
	    newLabel(rel, N), genLabel(ro, N, TrueLabel),
	    [label(TrueLabel)]
	<=  shortType(X).

@cgValue(exp(type(T,Sz), relOp(Op, X, Y)), R, S)
	<-> @cgValue(X, Xv, S),
	    @cgValue(Y, Yv, S),
	    allocTemp1(Sz, R, S),
	    freeAddr(Xv, S), freeAddr(Yv, S),
	    addOffset(2, 254, Xv, Xvs),
	    addOffset(2, 254, Yv, Yvs),
	    [op2(mov, bool, lit(bool(1)), R)],
	    @saveRegs(S, M, 3),
	    [op5(cmpc5, Xv, Xvs, lit(int(0)), Yv, Yvs)],
	    @restoreRegs(M),
	    getRelOpcode(Op, Opc),
	    [op1(Opc, label(TrueLabel))],
	    [op2(mov, bool, lit(bool(0)), R)],
	    newLabel(rel, N), genLabel(ro, N, TrueLabel),
	    [label(TrueLabel)]
	<=  X=exp(type(string,_),_).

@cgValue(exp(type(T,Sz), relOp(Op, X, Y)), R, S)
	<-> @cgValue(X, Xv, S),
	    @cgValue(Y, Yv, S),
	    allocTemp1(Sz, R, S), freeAddr(Xv, S), freeAddr(Yv, S),
	    X = exp(type(XT,_), _),
	    [op2(mov, bool, lit(bool(1)), R)],
	    @saveRegs(S, M, 3),
	    [op3(cmpc3, lit(int(Sz)), Xv, Yv)],
	    @restoreRegs(M),
	    getRelOpcode(Op, Opc),	% May only be 'eq' or 'ne'
	    [op1(Opc, label(TrueLabel))],
	    [op2(mov, bool, lit(bool(0)), R)],
	    newLabel(rel, N), genLabel(ro, N, TrueLabel),
	    [label(TrueLabel)].


shortType(exp(type(int,  _), _)) !.
shortType(exp(type(real, _), _)) !.
shortType(exp(type(bool, _), _)) !.


% Boolean operators ----------------------------------------------------------

@cgValue(exp(type(T,Sz), boolOp(bin(or, X, Y))), R, S)
	<-> @cgValue(X, Xv, S),
	    @cgValue(Y, Yv, S),
	    allocTemp1(Sz, R, S), freeAddr(Xv, S), freeAddr(Yv, S),
	    [op3(bis, T, Xv, Yv, R)].

@cgValue(exp(type(T,Sz), boolOp(bin(and, X, Y))), R, S)
	<-> @cgValue(X, Xv, S),
	    @cgValue(Y, Yv, S),
	    allocTemp1(Sz, R, S), freeAddr(Xv, S), freeAddr(Yv, S),
	    [op2(mcom, T, Xv, R)],
	    [op3(bic,  T, Yv, R, R)].

@cgValue(exp(type(T,Sz), boolOp(un(not, X))), R, S)
	<-> @cgValue(X, Xv, S),
	    freeAddr(Xv, S), allocTemp1(Sz, R, S),
	    [op2(mcom, T, Xv, R)],
	    [op2(bic,  T, lit(int('~1')), R)].


% Array references -----------------------------------------------------------

@cgValue(exp(type(T,Sz), array(A, I)), R, S)
	<-> @cgAddr(A, Aa, S),
	    @cgValue(I, Iv, S),
	    allocTemp(4, Addr, S), freeAddr(Aa, S), freeAddr(Iv, S),
	    [op2(movab, Aa, Addr)],
	    [op2(mull2, lit(int(Sz)), Iv)],
	    [op2(addl2, Iv, Addr)],
	    freeTemp(Addr, S), allocTemp1(Sz, R, S),
	    @copy(Sz, indirect(Addr), R, S).


% Class component references -------------------------------------------------

@cgValue(exp(type(T,Sz), name(E, F, O)), R, S)
	<-> @cgAddr(E, Ea, S),
	    freeAddr(Ea, S), allocTemp(4, Addr, S),
	    [op2(movab, Ea, Addr)],
	    [op2(addl2, lit(int(O)), Addr)],
	    freeTemp(Addr, S), allocTemp1(Sz, R, S),
	    @copy(Sz, indirect(Addr), R, S).


% Function calls -------------------------------------------------------------

@cgValue(exp(type(T,Sz), map(exp(TF,id(F)),A)), R, S)
	<-> @cgValue(A, Av, S),
	    freeAddr(Av,  S),
	    @giveAddress(A, Av, Ava, S),
	    @saveRegs(S, RM),
	    A=exp(type(TA,_),_),
	    allocAddrNoReg(exp(type(T,Sz),_), R, S),
	    [op2(mova, T,  R,   reg(rp))],
	    [op2(mova, TA, Ava, reg(ap))],
	    [op1(jsb, label(F))],
	    @restoreRegs(RM),
	    freeAddr(Ava, S).


% Recursion ------------------------------------------------------------------

@cgValue(exp(type(T,Sz), recurse(A)), R, S)
	<-> @cgValue(A, Av, S),
	    freeAddr(Av,  S),
	    @giveAddress(A, Av, Ava, S),
	    @saveRegs(S, RM),
	    A=exp(type(TA,_),_),
	    local(result(type(T,Sz)), S),
	    local(procLabel(F), S),
	    allocAddrNoReg(exp(type(T,Sz),_), R, S),
	    [op2(mova, T,  R,   reg(rp))],
	    [op2(mova, TA, Ava, reg(ap))],
	    [op1(jsb, label(F))],
	    @restoreRegs(RM),
	    freeAddr(Ava, S).


% Class constructor ----------------------------------------------------------

@cgValue(exp(type(T,Sz), class(Cs)), R, S)
	<-> allocAddr(exp(type(T,Sz), class(Cs)), R, S),
	    @cgClassValue(Cs, R, 0, S).

@cgClassValue([], _, _, _) !.
@cgClassValue([exp(type(T,Sz),E)|Es], R, O, S)
	<-> NO is O+Sz, @cgClassValue(Es, R, NO, S)
	<=  addOffset(O, Sz, R, Rx),
	    @cgValue(exp(type(T,Sz),E), Rx, S).

addOffset(0, _, R, R) !.
addOffset(N, _, offset(M, R), offset(NM, R)) <-> NM is M+N.
addOffset(N, S, t(A, X, Y), t(AA, S, Y)) <-> AA is A+N.
addOffset(N, S, indirect(t(r(R),X,Y)), offset(N, t(r(R),X,Y))).
addOffset(N, S, indirect(reg(R)), offset(N, reg(R))).
addOffset(N, _, label(X), label(X+N)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% @cgTest/3: Code generation for boolean expressions in the context of a
%	     conditional jump. Try to be smarter about it.
%


% Variables ------------------------------------------------------------------

@cgTest(exp(type(bool,Sz), id(N)), Else, S)
	<-> allocAddr(exp(type(bool,Sz), id(N)), Where, S),
	    freeAddr(Where, S),
	    [op2(jlbc, R, label(Else))].


% Literals -------------------------------------------------------------------

@cgTest(exp(type(bool,Sz), lit(bool(true))), Else, S) !.

@cgTest(exp(type(bool,Sz), lit(bool(false))), Else, S)
	<-> [op1(jmp, label(Else))].


% Relational operators -------------------------------------------------------

@cgTest(exp(type(T,Sz), relOp(Op, X, Y)), Else, S)
	<-> @cgValue(X, Xv, S),
	    @cgValue(Y, Yv, S),
	    freeAddr(Xv, S), freeAddr(Yv, S),
	    X = exp(type(XT,_), _),
	    [op2(cmp, XT, Xv, Yv)],
	    getInvRelOpcode(Op, Opc),
	    [op1(Opc, label(Else))]
	<=  shortType(X).

@cgTest(exp(type(T,Sz), relOp(Op, X, Y)), Else, S)
	<-> @cgValue(X, Xv, S),
	    @cgValue(Y, Yv, S),
	    freeAddr(Xv, S), freeAddr(Yv, S),
	    addOffset(2, 254, Xv, Xvs),
	    addOffset(2, 254, Yv, Yvs),
	    @saveRegs(S, M, 3),
	    [op5(cmpc5, Xv, Xvs, lit(int(0)), Yv, Yvs)],
	    @restoreRegs(M),
	    getInvRelOpcode(Op, Opc),
	    [op1(Opc, label(Else))]
	<=  X=exp(type(string,_),_).

@cgTest(exp(type(T,Sz), relOp(Op, X, Y)), Else, S)
	<-> @cgValue(X, Xv, S),
	    @cgValue(Y, Yv, S),
	    freeAddr(Xv, S), freeAddr(Yv, S),
	    X = exp(type(XT,_), _),
	    @saveRegs(S, M, 3),
	    [op3(cmpc3, lit(int(Sz)), Xv, Yv)],
	    @restoreRegs(M),
	    getInvRelOpcode(Op, Opc),	% May only be 'eq' or 'ne'
	    [op1(Opc, label(Else))].


% Boolean operators ----------------------------------------------------------

@cgTest(exp(type(T,Sz), boolOp(bin(or, X, Y))), Else, S)
	<-> newLabel(if, N),
	    genLabel(or, N, Else1), genLabel(tn, N, Then),
	    @cgTest(X, Else1, S),
	    [op1(jmp, label(Then)), label(Else1)],
	    @cgTest(Y, Else, S),
	    [label(Then)].

@cgTest(exp(type(T,Sz), boolOp(bin(and, X, Y))), Else, S)
	<-> @cgTest(X, Else, S),
	    @cgTest(Y, Else, S).

@cgTest(exp(type(T,Sz), boolOp(un(not, X))), Else, S)
	<-> newLabel(if, N),
	    genLabel(nt, N, Then),
	    @cgTest(X, Then, S),
	    [op1(jmp, label(Else)), label(Then)].


% Array references -----------------------------------------------------------

@cgTest(exp(type(T,Sz), array(A, I)), Else, S)
	<-> @cgAddr(A, Aa, S),
	    @cgValue(I, Iv, S),
	    allocTemp(4, Addr, S), freeAddr(Aa, S), freeAddr(Iv, S),
	    [op2(movab, Aa, Addr)],
	    [op2(mull2, lit(int(Sz)), Iv)],
	    [op2(addl2, Iv, Addr)],
	    freeTemp(Addr, S),
	    [op2(jlbc, indirect(Addr), Else)].


% Class component references -------------------------------------------------

@cgTest(exp(type(T,Sz), name(E, F, O)), Else, S)
	<-> @cgAddr(E, Ea, S),
	    freeAddr(Ea, S), allocTemp(4, Addr, S),
	    [op2(movab, Ea, Addr)],
	    [op2(addl2, lit(int(O)), Addr)],
	    freeTemp(Addr, S),
	    [op2(jlbc, indirect(Addr), Else)].


% Function calls -------------------------------------------------------------

@cgTest(exp(type(T,Sz), map(exp(TF,id(F)),A)), Else, S)
	<-> @cgValue(A, Av, S),
	    freeAddr(Av,  S),
	    @giveAddress(A, Av, Ava, S),
	    @saveRegs(S, RM),
	    A=exp(type(TA,_),_),
	    allocAddrNoReg(exp(type(T,Sz),_), R, S),
	    [op2(mova, T,  R,   reg(rp))],
	    [op2(mova, TA, Ava, reg(ap))],
	    [op1(jsb, label(F))],
	    @restoreRegs(RM),
	    freeAddr(Ava, S), freeAddr(R, S),
	    [op1(jlbc, R, label(Else))].


% Recursion ------------------------------------------------------------------

@cgTest(exp(type(T,Sz), recurse(A)), Else, S)
	<-> @cgValue(A, Av, S),
	    freeAddr(Av,  S),
	    @giveAddress(A, Av, Ava, S),
	    @saveRegs(S, RM),
	    A=exp(type(TA,_),_),
	    local(result(type(T,Sz)), S),
	    local(procLabel(F), S),
	    allocAddrNoReg(exp(type(T,Sz),_), R, S),
	    [op2(mova, T,  R,   reg(rp))],
	    [op2(mova, TA, Ava, reg(ap))],
	    [op1(jsb, label(F))],
	    @restoreRegs(RM),
	    freeAddr(Ava, S), freeAddr(R, S),
	    [op1(jlbc, R, label(Else))].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% @copy/4: Copy N bytes from an address to another one.
%

@copy(_, X, X, S) !.			% Already there.
@copy(1, X, Y, S) <-> [op2(mov, byte, X, Y)]. % Move byte.
@copy(2, X, Y, S) <-> [op2(mov, word, X, Y)]. % Move word.
@copy(4, X, Y, S) <-> [op2(mov, int,  X, Y)]. % Move longword.
@copy(N, X, Y, S) <-> @saveRegs(S, M, 5), % Arbitrary length.
		      [op3(movc3, lit(int(N)), X, Y)],
		      @restoreRegs(M).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% @giveAddress/4: Make sure a value has an address, possibly allocating
%		  a temporary and copying the (presumably accumulator) value
%		  into it.
%

@giveAddress(_, Addr, Addr, S) ! <= addressable(Addr).

@giveAddress(exp(type(_,Sz), _), R, A, S)
	<-> allocTempNoReg(Sz, A, S),
	    @copy(Sz, R, A, S).


addressable(ap) # .
addressable(rp) # .
addressable(fp) # .
addressable(t(r(_),_,_)) # .
addressable(lit(_)) # .
addressable(_) ! . 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% @saveRegs/2: save all active registers and return corresponding mask.
%

@saveRegs(S, M)
	<-> saveRegs1(RS, 2'0011100000000000, M),
	    [op1(pushr, lit(hex(M)))]
	<=  local(temps(RS), S).

@saveRegs(S, M, HI)
	<-> local(temps(RS), S), saveRegs1(RS, 0, XM), M is XM /\ ((2<<HI)-1),
	    @saveRegsIfNecessary(M, S).

@saveRegsIfNecessary(0, _) !.
@saveRegsIfNecessary(M, S) <-> [op1(pushr, lit(hex(M)))].


saveRegs1(X, M, M) ! <=  var(X).

saveRegs1([t(r(X),_,L)|Rs], N, M)
	<-> saveRegs1(Rs, NN, M)
	<=  saveIfActive(L, X, N, NN).

saveRegs1([_|Rs], N, M)
	<-> saveRegs1(Rs, N, M).


saveIfActive(L, R, N, M)
	<-> M is (N \/ (1<<R))
	<=  lookup1(t(Alive), L), var(Alive).

saveIfActive(_, _, M, M) !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% @restoreRegs/1: restore all active registers.
%

@restoreRegs(0) !.
@restoreRegs(M) <-> [op1(popr, lit(hex(M)))].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cgStrings/0: generate string literals.
%

cgStrings <-> cgString(L, X), cgStrings <= retract(strings(L, X)).
cgStrings !.


cgString(L, X)
	<-> label(text, L), name(X, S),
	    tab, write('.word'), tab, length(S, Length), write(Length),
	    dumpString(S, 0, 15),
	    Fill is 254-Length,
	    tab, write('.space'), tab, write(Fill), nl.

dumpString([],     _, _) <-> nl.
dumpString([X|Xs], 0, N) <-> nl, tab, write('.byte'), tab, write(X),
			     dumpString(Xs, 1, N).
dumpString(X,      N, N) <-> dumpString(X, 0, N).
dumpString([X|Xs], P, N) <-> write(','), write(X), Pp1 is P+1,
			     dumpString(Xs, Pp1, N).
