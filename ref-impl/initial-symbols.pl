/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   Initial symbol-table (predefined maps).				     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/

initSymbols([[
    id(readInt)  - [type(map(type(class([]),0), type(int,4)), 0), external|_],
    id(writeInt) - [type(map(type(int,4), type(class([]),0)), 0), external|_],

    id(readBool)  - [type(map(type(class([]),0), type(bool,1)), 0), external|_],
    id(writeBool) - [type(map(type(bool,1), type(class([]),0)), 0), external|_],

    id(readReal)  - [type(map(type(class([]),0), type(real,4)), 0), external|_],
    id(writeReal) - [type(map(type(real,4), type(class([]),0)), 0), external|_],

    id(readString)  - [type(map(type(class([]),0), type(string,256)), 0), external|_],
    id(writeString) - [type(map(type(string,256), type(class([]),0)), 0), external|_],

    id(writeChar) - [type(map(type(int,4), type(class([]),0)), 0), external|_]
|_]
|_]).
