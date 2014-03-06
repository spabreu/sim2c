/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   Compiler pass control and timing.					     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/

doPass(1, X) <-> T is cputime-T0, write(T), write(' seconds.'), nl
	     <=  write('yacc:          '), ttyflush, statistics(runtime, _),
	         make(stack, X).

doPass(2, X) <-> statistics(runtime, [_|T]), write(T), write(' msec.'), nl
	     <=  write('loading:       '), ttyflush, statistics(runtime, _),
	         load(X).

doPass(3, X) <-> try retract(apts0(X, _)), asserta(apts0(X, S)),
	         statistics(runtime, [_|T]), write(T), write(' msec.'), nl
	     <=  write('type check:    '), ttyflush, apt(X,A),
	         statistics(runtime, _),
	         initSymbols(S), tcStat(A,B,S).

doPass(4, X) <-> try retract(apts(X, _)), asserta(apts(X, S)),
	         statistics(runtime, [_|T]), write(T), write(' msec.'), nl
	     <=  write('size symbols:  '), ttyflush, apts0(X,S),
	         statistics(runtime, _),
	         sizeSymbols(S).

doPass(5, X) <-> statistics(runtime, [_|T]), write(T), write(' msec.'), nl
	     <=  write('generate code: '), ttyflush, apts(X,S),
	         name(X, as, NN), name(N,NN), tell(N), statistics(runtime, _),
		 resetLabels(guard), resetLabels(if), resetLabels(rel),
		 resetLabels(proc), resetLabels(lit),
	         cgSymbols(S),
	         told.

doPass(6, X) <-> statistics(runtime, [_|T]), write(T), write(' msec.'), nl
	     <=  write('assemble:      '), ttyflush,
	         name(X, as, AS), name(X, object, OBJ),
	         append("as -o ", OBJ, X1), append(X1, " ", X2),
	         append(X2, AS, Command), statistics(runtime, _),
	         unix(shell(Command)).

doPass(_, X) # <= told, tell(user), write(' failed.'), nl.


compile(X) <-> pass(1-6, X).


link(X) <-> name(X, object, OBJ), name(X, NX),
	    append("cc -o ", NX, X1),
	    append(X1, " ", X2),
	    append(X2, OBJ, X3),
	    append(X3, " srt0.o srt0-aux.o", Command),
	    unix(shell(Command)).


run(X) <-> name(X, Command),
	   unix(shell(Command)).


pass(N,   X) <-> pass(1, N, X) <= integer(N).
pass(N-M, X) <-> pass(N, M, X, []).

* * * * MUST FIX STUFF BELOW * * * * .
pass(N, M, X, _) ! <= N>M.
pass(N, M, X, _) ! <= M>6.
pass(N, N, X, Y) <-> doPass(N, X, Y).
pass(N, M, X, Z) <-> Np1 is N+1, pass(Np1, M, X) <= doPass(N, X, Y).
