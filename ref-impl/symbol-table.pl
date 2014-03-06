/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   Symbol table.							     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% symbol table primitives: lookup(Entry, Table) and enter(Entry, Table).
%


lookup(V, S) # <= var(S).
lookup(V, [S|Ss]) <- lookup1(V, S).
lookup(V, [S|Ss]) <- lookup(V, Ss).

    lookup1(V, S) # <= var(S).
    lookup1(V, [V|_]).
    lookup1(V, [_|S]) <-> lookup1(V, S).


local(V, [S|_]) <- lookup1(V, S).


enter(V, [S|_]) <-> S=[V|_] <= var(S).
enter(V, [S|Ss]) <-> enter1(V, S).

    enter1(V, [V|_]) !.
    enter1(V, [_|S]) <-> enter1(V, S).
