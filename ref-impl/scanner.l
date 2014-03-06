/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        		     */
/*   Lex Scanner Specification. 					     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/

/*****************************************************************************/
/*									     */
/*                           	     Prelude.   			     */
/*									     */
/*****************************************************************************/

%{

#include <ctype.h>
#include <strings.h>
#include <math.h>

#include "types.h"

#include "y.tab.h"

static char buffer[512];

#define ret(v) 		return(v)
#define	value(c,t,v)	yylval.t = v; ret (c)

#define T	yytext
#define	D(X,S)	(((yytext[X])-'0')<<S)
%}

letter	[a-zA-Z]
digit	[0-9]

id	{letter}({letter}|{digit}|_)*
exp	([eE][-+]?{digit}+)

%start ERROR

%p 5000
%a 3000

%%

<ERROR>[^ \t\n]*		{ setup_lc();
				  yyerror ("illegal character(s) in input");
				  BEGIN 0; }

"#".*				{ setup_lc(); }
[ \t]+				{ setup_lc(); }
\n				{ setup_lc(); }

{digit}*\.{digit}+{exp}?	{ value (REAL_LIT, lit.rval, atof(T)); }
{digit}+\.{digit}*{exp}?	{ value (REAL_LIT, lit.rval, atof(T)); }
{digit}+{exp}			{ value (REAL_LIT, lit.rval, atof(T)); }

{digit}+			{ value (INT_LIT,  lit.ival, atoi(T)); }

\"				{ register char *tx = buffer;
				  register int c;

				  while ((c = input()) && (c != '"')) {
				      if (c == '\\') {
					  c = input();
					  if (isdigit(c)) {
					      register int x = c-'0';
					      while (isdigit(c=input())) {
						  x <<= 3;
						  x += c-'0';
					      }
					      unput(c);
					      c = x;
					  }
					  else switch (c) {
					    case 'n': c = '\n'; break;
					    case 'r': c = '\r'; break;
					    case 't': c = '\t'; break;
					    case 'b': c = '\b'; break;
					    case 'f': c = '\f'; break;
					    default: break;
					  }
				      }
				      if ((*tx++ = c) == '\'')
					  *tx++ = c;
				  }
				  *tx = 0;

				  value (STRING_LIT, lit.sval, buffer); }

true				{ value (BOOL_LIT, lit.bval, true); }
false				{ value (BOOL_LIT, lit.bval, false); }

int				{ ret (INT); }
real				{ ret (REAL); }
bool				{ ret (BOOL); }
string				{ ret (STRING); }

map				{ ret (MAP); }
class				{ ret (CLASS); }

return				{ ret (RETURN); }
"^"				{ ret (RETURN); }

recurse				{ ret (RECURSE); }
"@"				{ ret (RECURSE); }

break				{ ret (BREAK); }
skip				{ ret (SKIP); }
retry				{ ret (RETRY); }

else				{ ret (ELSE); }
"_"				{ ret (ELSE); }
"*"/[ \t]*"->"			{ ret (ELSE); }

cond				{ ret (COND); }
"?"				{ ret (COND); }

while				{ ret (WHILE); }
"*"/[ \t]*"["			{ ret (WHILE); }

and				{ ret (AND); }
or				{ ret (OR); }
not				{ ret (NOT); }

{id}				{ value (ID, id, lookup(T)); }

"<"				{ ret (LT); }
"<="				{ ret (LE); }
"="				{ ret (EQ); }
"~="				{ ret (NE); }
"<>"				{ ret (NE); }
">="				{ ret (GE); }
">"				{ ret (GT); }

"+"				{ ret ('+'); }
"-"				{ ret ('-'); }
"*"				{ ret ('*'); }
"/"				{ ret ('/'); }
"%"				{ ret ('%'); }

";"				{ ret (';'); }
","				{ ret (','); }
"."				{ ret ('.'); }

":"				{ ret (':'); }

"|"				{ ret ('|'); }

"->"				{ ret (RETURNS); }

":="				{ ret (ASSIGN); }
"=="				{ ret (IDENTICAL); }

"("				{ ret ('('); }
")"				{ ret (')'); }

"["				{ ret ('['); }
"]"				{ ret (']'); }

"{"				{ ret ('{'); }
"}"				{ ret ('}'); }

"?"				{ ret ('?'); }

.				{ BEGIN ERROR; }

%%

error (msg)
    char *msg;
{
    fprintf (stderr, msg);
}
