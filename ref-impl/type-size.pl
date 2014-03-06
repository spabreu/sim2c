/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   Type sizing.							     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sizeType(T,S): given a type and a symbol table, complete the type
% terms, filling in the size and offset entries.

sizeType(type(int,      4), S).
sizeType(type(real,     4), S).
sizeType(type(bool,     1), S).
sizeType(type(string, 256), S).
sizeType(type(_,    Sz), S) ! <= nonvar(Sz).
sizeType(type(array(type(E,Se), B), Sz), S)
	<-> Sz is Bv*Se
	<=  sizeType(type(E,Se), S), iEval(B, Bv, S).
sizeType(type(class(C), Sz), S)
	<-> sizeClass(C, 0, Sz, S).
sizeType(type(map(type(A,ASz),type(R,RSz)), Sz), S) !
	<=  sizeType(type(A,ASz), S), sizeType(type(R,RSz), S).

sizeClass([], Sz, Sz, S) !.
sizeClass([field(N, type(E,Es), O)|Fs], O, Sz, S)
	<-> Sx is O+Es, sizeClass(Fs, Sx, Sz, S)
	<=  sizeType(type(E,Es), S).

iEval(exp(type(int, _), id(X)), EV, S)
	<-> iEval(V, EV, S)
	<=  lookup(id(X)-A, S), lookup1(const(V), A).

iEval(exp(type(int,_), lit(int(V))), V, S).

iEval(exp(type(int,_), arithOp(bin(add, X, Y))), V, S)
	<-> V is Vx+Vy
	<=  iEval(X, Vx, S), iEval(Y, Vy, S).
iEval(exp(type(int,_), arithOp(bin(sub, X, Y))), V, S)
	<-> V is Vx-Vy
	<=  iEval(X, Vx, S), iEval(Y, Vy, S).
iEval(exp(type(int,_), arithOp(bin(mul, X, Y))), V, S)
	<-> V is Vx*Vy
	<=  iEval(X, Vx, S), iEval(Y, Vy, S).
iEval(exp(type(int,_), arithOp(bin(div, X, Y))), V, S)
	<-> V is Vx//Vy
	<=  iEval(X, Vx, S), iEval(Y, Vy, S).
iEval(exp(type(int,_), arithOp(bin(mod, X, Y))), V, S)
	<-> V is mod(Vx,Vy)
	<=  iEval(X, Vx, S), iEval(Y, Vy, S).
iEval(exp(type(int,_), arithOp(un(neg, X))), V, S)
	<-> V is -Vx
	<=  iEval(X, Vx, S).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sizeSymbols(S): given a symbol table, traverse all its sub-symbol tables
% and for each symbol in each sub-table, apply sizeType to all types seen
% in there.
%
% Naturally, all symbols with a type(X,Y) attribute are traversed directly.
% Additionally, all symbols with a const(lit(map(A,R),map(A,B,S)) attribute
% get the symbol table S traversed as well. Actually, these are those we're
% looking for. Also, all expressions found within the body B are also checked
% out so we can catch class-expressions to size them.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sizeSymbols/1: traverse the global symbol table.
%

sizeSymbols(S) ! <= var(S).
sizeSymbols([]) !.
sizeSymbols([S|Ss]) <-> sizeSymbols(S, 0, [S|Ss]), sizeSymbols(Ss).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sizeSymbols/2: traverse each local symbol table.
%

sizeSymbols(S, X, G) ! <= var(S).
sizeSymbols([], X, G) !.
sizeSymbols([D|Ds], X, G) <-> sizeSymbol(D, X, Y, G), sizeSymbols(Ds, Y, G).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sizeSymbol/4: evaluate the size for a given symbol.
%

sizeSymbol(id(N)-A, X, Y, G)
	<-> sizeConstant(V, A, X, Y, G)
	<=  lookup1(const(V), A), enter1(address(label(N)), A).

sizeSymbol(id(N)-A, X, Y, G)
	<-> sizeType(type(T,Sz), G)
	<=  lookup1(type(T,Sz), A), enter1(address(label(N)), A).

sizeSymbol(_,   X, X, G).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sizeConstant/5: figure out the size of a constant (map or other).
%

sizeConstant(exp(_, lit(map(B,LS))), A, X, Y, G)
	<-> enter1(Sizes, LS), sizeStats(B, G)
	<=  sizeMap(LS, 0,0,0, Sizes, G).

sizeConstant(exp(_, lit(_)), A, X, Y, G)
	<-> sizeType(type(T,Sz), G)
	<=  lookup1(type(T,Sz), A).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sizeMap/6: freeze all locations within a map constant.
%

sizeMap(D,      A,R,L, S, G) <-> S=sizes(args(A),result(R),locals(L),temps(_))
			     <=  var(D).
sizeMap([D|Ds], A,R,L, S, G) <-> sizeMap(Ds, AA,RR,LL, S, G)
			     <=  sizeMaps(D, A,R,L, AA,RR,LL, G).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sizeMaps/8: figure out the size and location of a local symbol.
%

sizeMaps(N-[T, formal, address(offset(A,ap)) | As], A,R,L, AA,R,L, G)
	<-> T=type(_,Sz), AA is A+Sz
	<=  sizeType(T, G).

sizeMaps(N-[T, write, address(offset(O,fp)) | As], A,R,L, A,R,LL, G)
	<-> T=type(_,Sz), LL is L+Sz, O is -LL
	<=  sizeType(T, G).

sizeMaps(N-[T, const(V), address(offset(O,fp)) | As], A,R,L, A,R,LL, G)
	<-> T=type(_,Sz), LL is L+Sz, O is -LL
	<=  sizeType(T, G).

sizeMaps(result(T), A,R,L, A,RR,L, G)
	<-> T=type(_,Sz), RR is R+Sz
	<=  sizeType(T, G).

sizeMaps(_, A,R,L, A,R,L, G) !.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sizeStats/2: size all necessary class-expressions within a map constant.
%

sizeStats([], S) !.
sizeStats([X|Xs], S) <-> sizeStats(X, S), sizeStats(Xs, S).

sizeStats(assign(V, E),   S) <-> size(V, S), size(E, S).
sizeStats(discard(E),     S) <-> size(E, S).
sizeStats(return(E),      S) <-> size(E, S).
sizeStats(guard(_,_,X,_), S) <-> sizeStats(X, S).
sizeStats(label(_),       S) !.
sizeStats(goto(_),        S) !.
sizeStats(if(C,T,E),      S) <-> size(C, S), sizeStats(T, S), sizeStats(E, S).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% size/2: size an expression.
%

size(exp(T, []),                       S) !.
size(exp(type(class(T),Sz), class(C)), S) <-> sizeClassType(T, C, 0, Sz, S).
size(exp(T, map(F,A)),                 S) <-> size(F, S), size(A, S).
size(exp(T, recurse(A)),               S) <-> size(A, S).
size(exp(T, array(A,I)),               S) <-> size(A, S), size(I, S).
size(exp(T, name(C,F)),                S) <-> size(C, S), size(F, S).
size(exp(T, id(X)),                    S) <-> sizeType(T, S).
size(exp(T, lit(X)),                   S) <-> sizeType(T, S).
size(exp(T, arithOp(bin(Op,A,B))),     S) <-> size(A, S), size(B, S).
size(exp(T, arithOp(un(Op,A))),        S) <-> size(A, S).
size(exp(T, boolOp(bin(Op,A,B))),      S) <-> size(A, S), size(B, S).
size(exp(T, boolOp(un(Op,A))),         S) <-> size(A, S).
size(exp(T, relOp(Op,A,B)),            S) <-> size(A, S), size(B, S).

size(exp(T, V),                        S) <-> sizeType(T, S).


sizeClassType([],                         [],     X, X, S) !.
sizeClassType([field(N,type(T,Sz),X)|Fs], [E|Es], X, Y, S)
	<-> XX is X+Sz, sizeClassType(Fs, Es, XX, Y, S)
	<=  sizeType(type(T,Sz), S), size(E, S).
