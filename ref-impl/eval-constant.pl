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
% evalConst/3: evaluate a constant.
%

evalConst(exp(T, id(X)), EV, S)
	<-> evalConst(V, EV, S)
	<=  lookup(id(X)-A, S), lookup1(value(V), A).

evalConst(exp(T, id(X)), EV, S)
	<-> evalConst(V, EV, S), enter1(value(EV), A)
	<=  lookup(id(X)-A, S), lookup1(const(V), A).

evalConst(exp(T, lit(int(V))),  lit(int(V)),  S) !.
evalConst(exp(T, lit(real(V))), lit(real(V)), S) !.
evalConst(exp(T, lit(bool(V))), lit(bool(V)), S) !.

evalConst(exp(type(T,Sz), arithOp(bin(Op, X, Y))), lit(V), S)
	<-> VVx=..[_,Vx], VVy=..[_,Vy], evalOp(Op, T, V, Vx, Vy)
	<=  evalConst(X, lit(VVx), S), evalConst(Y, lit(VVy), S).

evalConst(exp(type(T,Sz), arithOp(un(Op, X))), lit(V), S)
	<-> VVx=..[_,Vx], evalOp(Op, T, V, Vx)
	<=  evalConst(X, lit(VVx), S).

evalConst(exp(type(T,Sz), relOp(Op, X, Y)), lit(V), S)
	<-> VVx=..[_,Vx], VVy=..[_,Vy], evalOp(Op, T, V, Vx, Vy)
	<=  evalConst(X, Vx, S), evalConst(Y, Vy, S).

evalConst(exp(type(T,Sz), boolOp(bin(Op, X, Y))), lit(V), S)
	<-> VVx=..[_,Vx], VVy=..[_,Vy], evalOp(Op, T, V, Vx, Vy)
	<=  evalConst(X, lit(VVx), S), evalConst(Y, lit(VVy), S).

evalConst(exp(type(T,Sz), boolOp(un(Op, X))), lit(V), S)
	<-> VVx=..[_,Vx], evalOp(Op, T, V, Vx)
	<=  evalConst(X, lit(VVx), S).


evalOp(add, T,    V, X, Y) <-> VV is X+Y,      V=..[T,VV].
evalOp(sub, T,    V, X, Y) <-> VV is X-Y,      V=..[T,VV].
evalOp(mul, T,    V, X, Y) <-> VV is X*Y,      V=..[T,VV].
evalOp(div, int,  V, X, Y) <-> VV is X//Y,     V=int(VV).
evalOp(div, real, V, X, Y) <-> VV is X/Y,      V=real(VV).
evalOp(mod, int,  V, X, Y) <-> VV is mod(X,Y), V=int(VV).

evalOp(neg, int,  V, X)    <-> VV is -X,       V=int(VV).

evalOp(le,  bool, V, X, Y) <-> boolEv(VV, X=<Y), V=bool(VV).
evalOp(lt,  bool, V, X, Y) <-> boolEv(VV, X<Y),  V=bool(VV).
evalOp(eq,  bool, V, X, Y) <-> boolEv(VV, X=Y),  V=bool(VV).
evalOp(ne,  bool, V, X, Y) <-> boolEv(VV, X\=Y), V=bool(VV).
evalOp(ge,  bool, V, X, Y) <-> boolEv(VV, X>=Y), V=bool(VV).
evalOp(gt,  bool, V, X, Y) <-> boolEv(VV, X>Y),  V=bool(VV).

evalOp(and, bool, bool(true),  true, true) !.
evalOp(and, bool, bool(false), _,    _)    !.
evalOp(or,  bool, bool(true),  true, _)    !.
evalOp(or,  bool, bool(true),  _,    true) !.
evalOp(or,  bool, bool(false), _,    _)    !.

evalOp(not, bool, bool(true),  false) !.
evalOp(not, bool, bool(false), true)  !.

boolEv(true,  G) ! <= G.
boolEv(false, _) !.
