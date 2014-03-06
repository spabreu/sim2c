/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   Type checking and inference.					     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Each symbol/expression, etc has an associated type and a value. It's
% always in the form:
%
%	Name-[Attribute|...]
%
% Where each attribute can be one of:
%
%	(read)		(Implicit) says we can get this variable's value.
%	write		Says that we can assign values to this variable.
%	formal		Says it's a formal (input) parameter.
%	value(X)	Says the symbol's value is X (an expression).
%	type(X)		Says the symbol's type is X (a type expression).
%
% A type expression can be one of:
%
%	int				An integer value.
%	real				A real value.
%	bool				A boolean value.
%	map(ArgType, ResType, Body)	A function value.
%	class(TypeList)			A class(record) value.
%
% An expression (the X in value(X), for constants) can be one of:
%
%	[]		The nil expression list.
%	[E|Es]		An expression list.
%	id(I)		A reference to an identifier.
%	map(F,A)	The result of applying F to argument expression A.
%	array(A,I)	Reference to element I of array A.
%	name(A,N)	Reference to field N of class(record) A.
%	or(X,Y)		Operation on X and Y.
%	and(X,Y)	Operation on X and Y.
%	not(X)		Operation on X.
%	lt(X,Y)		Operation on X and Y.
%	le(X,Y)		Operation on X and Y.
%	eq(X,Y)		Operation on X and Y.
%	ne(X,Y)		Operation on X and Y.
%	ge(X,Y)		Operation on X and Y.
%	gt(X,Y)		Operation on X and Y.
%	add(X,Y)	Operation on X and Y.
%	sub(X,Y)	Operation on X and Y.
%	mul(X,Y)	Operation on X and Y.
%	div(X,Y)	Operation on X and Y.
%	mod(X,Y)	Operation on X and Y.
%	neg(X)		Operation on X.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Type checker for statements:
%	tcStat(Statement, Symbols).
%

% Statement List -------------------------------------------------------------

tcStat([],     [],     S) !.
tcStat([X|Xs], [Y|Ys], S) <-> tcStat(Xs, Ys, S)
			  <=  tcStat(X, Y, S).

% Declaration ----------------------------------------------------------------

% Note: const() declarations may introduce an extra level of scope in the
%	symbol table.
%
% Declarations generate a [] node in the output APT: their effect is
% useful only in the symbol table. In case of an initialized variable or a
% non-global constant, an assign() node is generated instead.

tcStat(decl(N,C,T),       NS, S) <-> mungDecl(decl(N,C,T),       NS, _, S).
tcStat(decl_list(Ns,C,T), NS, S) <-> mungDecl(decl_list(Ns,C,T), NS, _, S).


%	mungDecl/4: used by tc(lit(map()))...

mungDecl([], [], type(class([]), 0), S) !.

mungDecl(decl(N,C,T), NS, NT, S)
	<-> declType(decl(N,C,T), NS, [field(N,NT,O)], [], S).

mungDecl(Ds, NS, type(class(T), _),  S)
	<-> declType(Ds, NS, T, [], S).

declType([],     [],       X,  X,    S) !.
declType([D|Ds], [NS|NSs], Ts, Tsss, S)
	<-> declType(Ds, NSs, Tss, Tsss, S)
	<=  declType(D,  NS,  Ts,  Tss,  S).

declType(decl(N,C,T), NS, [field(N,NT,O)|Fs], Fs, S)
	<-> lookAtDecl(C, NS, N, NT, S)
	<=  mungType(T, NT, S).

declType(decl_list(Ns, C, T), NS, F, Fs, S)
	<-> declTypeFields(Ns, NS, C, NT, F, Fs, S)
	<=  mungType(T, NT, S).

declTypeFields([],     [],       C, T, X,                 X,   S) !.
declTypeFields([N|Ns], [NS|NSs], C, T, [field(N,T,O)|Ts], Tss, S)
	<-> declTypeFields(Ns, NSs, C, T, Ts, Tss, S)
	<=  lookAtDecl(C, NS, N, T, S).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% lookAtDecl/5: do what must be done about a declaration for a single
%		identifier of an already munged type.
%

lookAtDecl(var, [], N, T, S) !
	<=  enter(N-[T,write|_],  S).

lookAtDecl(var(X), NS, N, T, S)
	<-> tcStat(assign(N, X), NS, S)
	<=  enter(N-[T,write|_],  S).

lookAtDecl(formal, [], N, T, S) !
	<=  enter(N-[T,formal|_], S).

lookAtDecl(field, [], N, T, S) !
	<=  enter(N-[T,field|_],  S).

lookAtDecl(const(X), [], N, T, S)
	<-> tc(X, exp(TX, VX), S),
	    compatTypes(T, TX)
	<=  enter(N-[T,const(exp(TX, VX))|_], S).


%		Process a class(record) type:

mungType(T,          U,                     S) <-> U=type(T,_) <= var(T).
mungType(int,        type(int,          _), S) !.
mungType(real,       type(real,         _), S) !.
mungType(bool,       type(bool,         _), S) !.
mungType(string,     type(string,       _), S) !.
mungType(array(T,B), type(array(NT,BX), _), S) <-> mungType(T, NT, S)
					       <=  tc(B, BX, S).
mungType(map(A,R),   type(map(NA,NR),   _), S) <-> mungType(A, NA, S),
						   mungType(R, NR, S).
mungType([],         type(class([]),    0), S) !.
mungType([T|Ts],     type(class(X),     _), S) <-> mungTuple([T|Ts],X,1,S).
mungType(class(F),   type(class(Fx),    _), S) <-> mungClass(F, Fx, [], S).


mungTuple([], [], _, S) !.
mungTuple([T|Ts], [field(id(ID),NT,Offset)|Fs], N, S)
	<-> mungType(T, NT, S), Np1 is N+1, mungTuple(Ts, Fs, Np1, S)
	<=  name(N,NN), append("el_", NN, EL_N), name(ID, EL_N).


mungClass([],     X, X, S) !.
mungClass([F|Fs], H, T, S) <-> mungClass(Fs, T1, T, S)
			   <=  mungClass(F, H, T1, S).

mungClass(field(I,T), [field(I, NT, Offset)|Ds], Ds, S) !
	<=  mungType(T, NT, S).
mungClass(field_list(Is,T), D, Ds, S)
	<-> mungClassFields(Is, NT, D, Ds, S)
	<=  mungType(T, NT, S).


mungClassFields([],     T, X, X, S) !.
mungClassFields([I|Is], T, [field(I, T, Offset)|Ds], Dss, S)
	<-> mungClassFields(Is, T, Ds, Dss, S).


% Assignment -----------------------------------------------------------------

tcStat(assign(V, E), assign(exp(TV, VV), exp(TE, VE)), S)
	<-> compatTypes(TV, TE), writable(V, S)
	<=  tc(E, exp(TE, VE), S), tc(V, exp(TV, VV), S).


% Function call --------------------------------------------------------------

tcStat(map(F, A), discard(exp(T, map(exp(TF, VF), exp(TA, VA)))), S)
	<-> compatTypes(TF, type(map(TA, T), Sz))
	<=  tc(F, exp(TF, VF), S), tc(A, exp(TA, VA), S).


% Return statement -----------------------------------------------------------

tcStat(return(E), return(exp(TE, VE)), S)
	<-> tc(E, exp(TE, VE), S), compatTypes(TF, TE)
	<=  local(result(TF), S).


% Recursion ------------------------------------------------------------------

tcStat(recurse(A), discard(exp(T, recurse(exp(TA, VA)))), S)
	<-> tc(A, exp(TA, VA), S), compatTypes(TF, TA)
	<=  local(formals(TF), S).


% Conditional guarded statement ----------------------------------------------

tcStat(cond(B, G), guard(G, cond, [label(Begin), Clauses], ControlPoints), S)
	<-> tcClauses(B, cond, Clauses, End, S)
	<=  enter(guard(G, ControlPoints), S),
	    enter1(begin(Begin), ControlPoints),
	    enter1(end(End), ControlPoints).


% Iterative guarded statement ------------------------------------------------

tcStat(while(B, G), guard(G, while, [label(Begin), Clauses], ControlPoints), S)
	<-> tcClauses(B, while(Begin), Clauses, End, S)
	<=  enter(guard(G, ControlPoints), S),
	    enter1(begin(Begin), ControlPoints),
	    enter1(end(End), ControlPoints).


% Guarded clauses ------------------------------------------------------------

tcClauses([], How, label(End), End, S) !.

tcClauses([else(B)], cond,
	  [Else, label(End)],
	  End, S) !
	<=  tcStat(B, Else, S).

tcClauses([else(B)], while(W),
	  [Else, goto(W), label(End)],
	  End, S) !
	<=  tcStat(B, Else, S).

tcClauses([clause(E,B)|Cs], cond,
	  if(exp(TE,VE), [NB,goto(End)], NCs),
	  End, S)
	<-> compatTypes(TE, type(bool, _)),
	    tcStat(B, NB, S),
	    tcClauses(Cs, cond, NCs, End, S)
	<=  tc(E, exp(TE, VE), S).

tcClauses([clause(E,B)|Cs], while(W),
	  if(exp(TE,VE), [NB,goto(W)], NCs),
	  End, S)
	<-> compatTypes(TE, type(bool, _)),
	    tcStat(B, NB, S),
	    tcClauses(Cs, while(W), NCs, End, S)
	<=  tc(E, exp(TE, VE), S).


% Break statement ------------------------------------------------------------

tcStat(break(G), goto(E), S)
	<-> lookup1(end(E), ControlPoints)
	<=  local(guard(G, ControlPoints), S).


% Retry statement ------------------------------------------------------------

tcStat(retry(G), goto(B), S)
	<-> lookup1(begin(B), ControlPoints)
	<=  local(guard(G, ControlPoints), S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Type-check an expression:
%	tc(Expr, NewExpr, Symbols).


% Expression lists -----------------------------------------------------------

tc([],     exp(type(class([]), 0), class([])), S) !.
tc([E|Es], exp(type(class(CN), _), class(CV)), S)
	<-> tcTuple([E|Es], CN, CV, S).

tcTuple([],     [],                     [],            S) !.
tcTuple([E|Es], [field(id(ID),T,O)|Ts], [exp(T,V)|Vs], S)
	<-> tc(E, exp(T, V), S), tcTuple(Es, Ts, Vs, S).


% Literals -------------------------------------------------------------------

tc(lit(int,        V),          exp(type(int,        _), lit(int(V))),     S).
tc(lit(real,       V),          exp(type(real,       _), lit(real(V))),    S).
tc(lit(bool,       V),          exp(type(bool,       _), lit(bool(V))),    S).
tc(lit(string,     V),          exp(type(string,     _), lit(string(V))),  S).
tc(lit(map(TF,TR), map(F,B,_)), exp(type(map(NF,NR), _), lit(map(NB,LS))), S)
	<-> mungDecl(F, _, NF, SS),
	    mungType(TF, NTF, SS), compatTypes(NF, NTF),
	    mungType(TR, NTR, SS), compatTypes(NR, NTR),
	    enter1(result(NR), LS), enter1(formals(NF), LS),
	    tcStat(B, NB, SS)
	<=  SS = [LS|S].


% Identifiers ----------------------------------------------------------------

tc(id(X), exp(type(T, Sz), id(X)), S)
	<-> lookup1(type(T, Sz), A)
	<=  lookup(id(X)-A, S).
tc(id(X), exp(type(T, Sz), id(X)), S) !
	<=  enter(id(X)-[type(T, Sz), write|_], S).


% Map expressions ------------------------------------------------------------

tc(map(F, A), exp(T, map(exp(TF, VF), exp(TA, VA))), S)
	<-> compatTypes(TF, type(map(TA, T), Sz))
	<=  tc(F, exp(TF, VF), S), tc(A, exp(TA, VA), S).


% Recursion ------------------------------------------------------------------

tc(recurse(A), exp(T, recurse(exp(TA, VA))), S)
	<-> tc(A, exp(TA, VA), S), compatTypes(TA, TF)
	<=  local(formals(F), S).


% Array references -----------------------------------------------------------

tc(array(A, I), exp(T, array(exp(TA, VA), exp(TI, VI))), S)
	<-> compatTypes(TA, type(array(T, B), Sz))
	<=  tc(A, exp(TA, VA), S), tc(I, exp(TI, VI), S).


%	Qualified names.

tc(name(R, F), exp(T, name(exp(TR, VR), F, O)), S)
	<-> compatTypes(TR, type(class(Fs), Sz)),
	    lookup1(field(F, T, O), Fs)
	<=  tc(R, exp(TR, VR), S).


%	Logical operators.

tc(or(A, B), exp(T, boolOp(bin(or, exp(TA, VA), exp(TB, VB)))), S)
	<-> T=type(bool, Sz), compatTypes(TA, T), compatTypes(TB, T)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(and(A, B), exp(T, boolOp(bin(and, exp(TA, VA), exp(TB, VB)))), S)
	<-> T=type(bool, Sz), compatTypes(TA, T), compatTypes(TB, T)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(not(A), exp(T, boolOp(un(not, exp(TA, VA)))), S)
	<-> T=type(bool, Sz), compatTypes(TA, T)
	<=  tc(A, exp(TA, VA), S).


%	Relational operators.

tc(lt(A, B), exp(T, relOp(lt, exp(TA, VA), exp(TB, VB))), S)
	<-> compatTypes(TA, TB), orderedType(TA), T=type(bool,Sz)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(le(A, B), exp(T, relOp(le, exp(TA, VA), exp(TB, VB))), S)
	<-> compatTypes(TA, TB), orderedType(TA), T=type(bool,Sz)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(eq(A, B), exp(T, relOp(eq, exp(TA, VA), exp(TB, VB))), S)
	<-> compatTypes(TA, TB), T=type(bool,Sz)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(ne(A, B), exp(T, relOp(ne, exp(TA, VA), exp(TB, VB))), S)
	<-> compatTypes(TA, TB), T=type(bool,Sz)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(ge(A, B), exp(T, relOp(ge, exp(TA, VA), exp(TB, VB))), S)
	<-> compatTypes(TA, TB), orderedType(TA), T=type(bool,Sz)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(gt(A, B), exp(T, relOp(gt, exp(TA, VA), exp(TB, VB))), S)
	<-> compatTypes(TA, TB), orderedType(TA), T=type(bool,Sz)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).


%	Arithmetic operators.

tc(add(A, B), exp(T, arithOp(bin(add, exp(TA, VA), exp(TB, VB)))), S)
	<-> compatTypes(TA, TB), T=TA, numericType(T)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(sub(A, B), exp(T, arithOp(bin(sub, exp(TA, VA), exp(TB, VB)))), S)
	<-> compatTypes(TA, TB), T=TA, numericType(T)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(mul(A, B), exp(T, arithOp(bin(mul, exp(TA, VA), exp(TB, VB)))), S)
	<-> compatTypes(TA, TB), T=TA, numericType(T)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(div(A, B), exp(T, arithOp(bin(div, exp(TA, VA), exp(TB, VB)))), S)
	<-> compatTypes(TA, TB), T=TA, numericType(T)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(mod(A, B), exp(T, arithOp(bin(mod, exp(TA, VA), exp(TB, VB)))), S)
	<-> compatTypes(TA, TB), T=TA, numericType(T)
	<=  tc(A, exp(TA, VA), S), tc(B, exp(TB, VB), S).

tc(neg(A), exp(T, arithOp(un(neg, exp(T, VA)))), S)
	<-> numericType(T)
	<=  tc(A, exp(TA, VA), S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Succeed if a type is ordered, generate all ordered types.
%

orderedType(type(int,    _)).
orderedType(type(real,   _)).
orderedType(type(bool,   _)).
orderedType(type(string, _)).

orderedType(T) # <= error(['ordered type needed, got ',T]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Succeed if a type is atomic, generate all atomic types.
%

atomicType(type(int,  _)).
atomicType(type(real, _)).
atomicType(type(bool, _)).

atomicType(T) # <= error(['atomic type needed, got ',T]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Succeed if a type is numeric, generate all numeric types.
%

numericType(type(int,  _)).
numericType(type(real, _)).

numericType(T) # <= error(['numeric type needed, got ',T]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Check that two types are compatible.
%

compatTypes(X, X) !.

compatTypes(X, Y) # <= error(['incompatible types: (',X,') and (',Y,')']).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Check that a node is writable.
%

writable([],          S) !.
writable([E|Es],      S) <-> writable(E, S), writable(Es, S).

writable(id(X),       S) <-> idWritable(A) <= lookup(id(X)-A, S).
writable(array(A, I), S) !                 <= writable(A, S).
writable(name(R, F),  S) !                 <= writable(R, S).

writable(_,           S) #                 <= error(['assign to read-only item']).

idWritable(A) ! <= lookup1(write,  A).
idWritable(A) ! <= lookup1(formal, A).

idWritable(A) # <= error(['attempt to write to a constant']).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% error/1: report an error message.
%

error([]) <-> write('.'), nl.
error([X|Xs]) <-> error(X), error(Xs).

error(type(X,Sz)) <-> typeError(type(X,Sz)).
error(X) <-> write(X).

typeError(type(T,      Sz)) <-> write('<unknown>') <= var(T).
typeError(type(int,    Sz)) <-> write(int).
typeError(type(real,   Sz)) <-> write(real).
typeError(type(bool,   Sz)) <-> write(bool).
typeError(type(string, Sz)) <-> write(string).
typeError(type(class(Cs),Sz)) <-> write('{'), fieldError(Cs), write('}').
typeError(type(array(T,I),Sz)) <-> write('[]'), typeError(T).
typeError(type(map(D,R),Sz)) <-> typeError(D), write(' -> '), typeError(R).

fieldError([]) !.
fieldError([F]) <-> fieldError(F).
fieldError([F|Fs]) <-> fieldError(F), write(', '), fieldError(Fs).

fieldError(field(V,T,_)) <-> write('_: '), typeError(T) <= var(V).
fieldError(field(id(X),T,_)) <-> write(X), write(': '), typeError(T).

