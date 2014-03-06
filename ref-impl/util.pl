/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   Utilities and administrivia.					     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/


% noop/1: cancel a series of operator definitions ----------------------------

noop([]) !.
noop([X|Xs]) <-> noop(Xs)
	     <=  current_op(P, T, X), op(0, T, X) ; true.

:- noop([(type), (pred),
	 (div), (mod), (not),
	 (eq), (ge), (gt), (le), (lt), (ne)]).


% append/3 -------------------------------------------------------------------

append([], X, X) !.
append([A|X], Y, [A|Z]) <-> append(X, Y, Z).


% flatten/2, /3 --------------------------------------------------------------

flatten(L, Lf) <-> flatten(L, Lf, []).

flatten(V, X, X) ! <= var(V).
flatten([X|Xs], H, T) <-> flatten(X, H, T1), flatten(Xs, T1, T).
flatten([], X, X) !.
flatten(A, [A|X], X).


% wr/1: write out a term in a syntax acceptable to browser(1x) ---------------

wr(X) <-> writeq(X)         <=    var(X) ; atomic(X).
wr(X) <-> wrList(X, '[')    <=    functor(X, '.', 2).
wr(T) <-> T=..[F,A1|An], writeq(F), write('('), wr(A1), wr_(An), write(')').

wr_([])      !.
wr_([A1|An]) <-> write(','), wr(A1), wr_(An).

wrList(X, _)     <-> write('|'), write(X), write(']') <= var(X).
wrList([], _)    <-> write(']').
wrList(X, _)     <-> write('|'), write(X), write(']') <= atomic(X).
wrList([H|T], S) <-> write(S), wr(H), wrList(T, ',').
wrList(X, _)     <-> write('|'), wr(X), write(']').
