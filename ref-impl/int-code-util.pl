%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% allocAddr/3: Allocate an address for the result of an expression.

allocAddr(_, Addr, S)			% Destination already known
	! <= nonvar(Addr).

allocAddr(exp(type(map(_,_), Sz), id(X)), address(X), S)
	! <= nonvar(X).

allocAddr(exp(_, id(X)), Addr, S)	% In case it's a named symbol
	<-> lookup1(address(Addr), A)
	<=  nonvar(X), lookup(id(X)-A, S).

allocAddr(exp(_, lit(X)), lit(X), S)	% A literal: take it as it is
	! <= nonvar(X).

allocAddr(exp(type(_,Sz), _), Addr, S)	% Anything else: need a temporary
	<-> allocTemp1(Sz, Addr, S).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% allocAddrNoReg/3: Allocate an address for the result of an expression.
%                   Don't allow registers.
%

allocAddrNoReg(_, Addr, S)		% Destination already known
	! <= nonvar(Addr).

allocAddrNoReg(exp(type(map(_,_), Sz), id(X)), address(X), S)
	! <= nonvar(X).

allocAddrNoReg(exp(_, id(X)), Addr, S)	% In case it's a named symbol
	<-> lookup1(address(Addr), A)
	<=  nonvar(X), lookup(id(X)-A, S).

allocAddrNoReg(exp(_, lit(X)), lit(X), S) % A literal: take it as it is
	! <= nonvar(X).

allocAddrNoReg(exp(type(_,Sz), _), Addr, S) % Anything else: need a temporary
	<-> allocTempNoReg1(Sz, Addr, S).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% freeAddr/2: Free an address in case it's a temporary.
%

freeAddr(t(Sz, A, L), S) ! <= freeTemp(t(Sz, A, L), S).
freeAddr(_,           S) !.

/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   Code generation (utilities).					     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% allocTemp1/3: allocate a temporary if it's not already chosen.
%

allocTemp1(Sz, Temp, S) ! <= nonvar(Temp).
allocTemp1(Sz, Temp, S) <-> allocTemp(Sz, Temp, S).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% allocTempNoReg1/3: allocate a temporary if it's not already chosen. Avoid
%		     registers.
%

allocTempNoReg1(Sz, Temp, S) ! <= nonvar(Temp).
allocTempNoReg1(Sz, Temp, S) <-> allocTempNoReg(Sz, Temp, S).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% getRelOpcode/2: Obtain VAX opcode for relationals.
%

getRelOpcode(le, jleq).
getRelOpcode(lt, jlss).
getRelOpcode(eq, jeql).
getRelOpcode(ne, jneq).
getRelOpcode(ge, jgeq).
getRelOpcode(gt, jgtr).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% getInvRelOpcode/2: Obtain inverse VAX opcode for relationals.
%

getInvRelOpcode(le, jgtr).
getInvRelOpcode(lt, jgeq).
getInvRelOpcode(eq, jneq).
getInvRelOpcode(ne, jeql).
getInvRelOpcode(ge, jlss).
getInvRelOpcode(gt, jleq).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% genLabel/1: Generate a unique label.
%

resetLabels(Root) <-> try retract(curLabel(Root,_)), asserta(curLabel(Root,0)).

newLabel(Root, N) <-> retract(curLabel(Root,M)), N is M+1,
		      assert(curLabel(Root,N)).

genLabel(R, N, L) <-> name(R, RN), name(N, NN),
		      append("L", RN, X0), append(X0, "_", X1),
		      append(X1, NN, X2), name(L, X2).
