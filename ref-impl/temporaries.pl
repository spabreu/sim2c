/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   Temporary allocation.						     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Public predicates.
%

allocTemp(Sz, T, S)
	<-> allocTemp(Sz, T, Ts, S)
	<=  local(temps(Ts), S).

allocTempNoReg(Sz, T, S)
	<-> allocTempNoReg(Sz, T, Ts, S)
	<=  local(temps(Ts), S).

freeTemp(t(_,_,Life), S)
	<-> Alive=no
	<=  lookup1(t(Alive), Life), var(Alive).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Private predicates.
%


% allocTemp/4: find a temporary of a given size.

allocTemp(Sz, T, Ts, S)			% Grab an existing temporary
	<-> T=t(A,TSz,Life), grabTemp(Life)
	<=  lookup1(t(A,TSz,Life), Ts), compatSizes(Sz, TSz),
	    tempAvailable(Life).

allocTemp(Sz, T, Ts, S)			% Create a new temporary
	<-> grabTemp(Life)
	<=  T=t(A,Sz,Life), newTemp(Sz, T, Ts), enter1(T, Ts).


% allocTempNoReg/4: find a temporary (not a register) of a given size.

allocTempNoReg(Sz, T, Ts, S)		% Grab an existing temporary
	<-> T=t(A,TSz,Life), grabTemp(Life)
	<=  lookup1(t(A,TSz,Life), Ts), compatSizes(Sz, TSz),
	    not(A = r(_)),
	    tempAvailable(Life).

allocTempNoReg(Sz, T, Ts, S)		% Create a new temporary
	<-> grabTemp(Life)
	<=  T=t(A,Sz,Life), newTemp(Sz, T, Ts), enter1(T, Ts).


% tempAvailable/1: succeeds iff the life it's given describes an available
%		   temporary.

tempAvailable(Ts)           ! <= var(Ts).
tempAvailable([t(Dead)|Ts]) # <= var(Dead).
tempAvailable([t(Dead)|Ts]) ! <= tempAvailable(Ts).

% newTemp/3: 

newTemp(Sz, t(A,Sz,Life), Ts)
	<-> enter1(t(A,Sz,Life), Ts)
	<=  MSz is -Sz, getAddress(Ts, MSz, A).


grabTemp(Life)     <-> Life=[t(_)|_] <= var(Life).
grabTemp([L|Life]) <-> grabTemp(Life).


getAddress(Temps,            A, A) !                        <= var(Temps).
getAddress([t(r(_),_,_)|Ts], B, A) <-> getAddress(Ts, B, A).
getAddress([t(_,S,_)|Ts],    B, A) <-> getAddress(Ts, C, A) <= C is B-S.


compatSizes(X, X) !.
compatSizes(1, 4) !.
compatSizes(2, 4) !.


noTemps(L) <-> mkRegs(L, 0, 11).

mkRegs(Rs,                 N, N) !.
mkRegs([t(r(N), 4, _)|Rs], N, M) <-> mkRegs(Rs, Np1, M) <= Np1 is N+1.
