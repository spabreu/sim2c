/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   Bison Parser Specification.					     */
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

#include <stdio.h>
#include <ctype.h>
#include <strings.h>
#include <ctype.h>

#include "types.h"

static int guardNo = 0;

#define APT(pop, push) \
{ \
    if (pop) \
	printf ("[%s|_Tail] ==> [", pop); \
    else \
	printf ("_Tail ==> ["); \
    printf push; \
    printf ("|_Tail].\n"); \
}
%}

%union {
    UNION_DEFS();
}

/*****************************************************************************/
/*									     */
/*                            Terminal declarations.  			     */
/*									     */
/*****************************************************************************/

%token ID				/* An identifier */

%token INT				/* The INT reserved word */
%token REAL				/* The REAL reserved word */
%token BOOL				/* The BOOL reserved word */
%token VOID				/* The VOID reserved word */

%token MAP				/* The MAP reserved word */
%token CLASS				/* The CLASS reserved word */
%token OP				/* The OP reserved word */

%token INT_LIT				/* An INT literal */
%token REAL_LIT				/* A REAL literal */
%token BOOL_LIT				/* A BOOL literal */

%token RETURN				/* The RETURN reserved word */
%token BREAK				/* The BREAK reserved word */
%token SKIP				/* The SKIP reserved word */
%token RETRY				/* The RETRY reserved word */
%token ELSE				/* The ELSE reserved word */

%token COND				/* The COND reserved word  (?) */
%token WHILE				/* The WHILE reserved word (*) */

%token IDENTICAL			/* The "==" token */
%token ASSIGN				/* The ":=" token */
%token RETURNS				/* The "->" token */

%token AND				/* The AND operator */
%token OR				/* The OR operator */
%token NOT				/* The NOT operator */

%token LT				/* The "<" operator */
%token LE				/* The "<=" operator */
%token EQ				/* The "=" operator */
%token NE				/* The "~=" operator */
%token GE				/* The ">=" operator */
%token GT				/* The ">" operator */

/*****************************************************************************/
/*									     */
/*                            Operator Precedences.  			     */
/*									     */
/*****************************************************************************/

%nonassoc ':' ';'			/* ID/type separator */
%nonassoc RETURN ASSIGN RETURNS		/* Must do it because of <exp> */

%right    ','				/* Tuple operator */

%left     OR
%left     AND
%right    NOT

%nonassoc LT LE EQ NE GE GT

%left     '+' '-'
%left     '*' '/' '%'
%nonassoc UMINUS

%nonassoc '(' ')' '[' ']' '{' '}'	/* Well, not really, but... */
					/* Have to list these after "->" */
%left     '.'				/* Qualified name constructor */

/*****************************************************************************/
/*									     */
/*                      Grammar symbol type declarations.		     */
/*									     */
/*****************************************************************************/

%type <id>       ID

%type <lit.ival> INT_LIT
%type <lit.rval> REAL_LIT
%type <lit.bval> BOOL_LIT

/*****************************************************************************/
/*									     */
/*                                Start Symbol.  			     */
/*									     */
/*****************************************************************************/

%start program

%%

program :
          globals			/* Global declarations */
	;

/*****************************************************************************/
/*									     */
/*                                Declarations.  			     */
/*									     */
/*****************************************************************************/


decl :					/* Name declaration: */
       ids ':' type			/* Variable, Explicit type, Undef */
		{ APT ("T,I", ("decl_list(I, var, T)")); }
     | ID  ':' type			/* Variable, Explicit type, Undef */
		{ APT ("T",   ("decl(id('%s'), var, T)", $1)); }
     | ID  ':' type ASSIGN exp		/* Variable, Explicit type, Init */
		{ APT ("V,T", ("V,decl(id('%s'), var, T)", $1));
		  APT ("V",   ("assign(id('%s'), V)", $1)); }
     | ID  ':' type EQ exp		/* Constant, Explicit type */
		{ APT ("V,T", ("decl(id('%s'), const(V), T)", $1)); }

     | ID           EQ exp		/* Constant, Implicit type */
		{ APT ("V",   ("decl(id('%s'), const(V), T)", $1)); }
     ;



/******************************************************************************/

formals :				/* Formal declarations: */
		{ APT (NULL,  ("[]")); }
	| formal_list
		{ }
	;

formal_list :				/* List of formal declarations */
	  formal
		{ APT ("X",   ("[X]")); }
        | formal ';' formal_list
		{ APT ("T,H", ("[H|T]")); }
        | error
		{ yyerrok; yyclearin;
		  error ("expected s formal declaration.");
		  APT (NULL, ("error(formals)")); }
        ;

formal :				/* Formal declaration: */
	 ids				/* Implicit type */
		{ APT ("I",   ("decl_list(I, formal, T)")); }
       | ID				/* Implicit type */
		{ APT (NULL,  ("decl(id('%s'), formal, T)", $1)); }
       | ids ':' type			/* Explicit type */
		{ APT ("T,I", ("decl_list(I, formal, T)")); }
       | ID ':' type			/* Explicit type */
		{ APT ("T",   ("decl(id('%s'), formal, T)", $1)); }
       ;

/******************************************************************************/

fields :				/* Field declarations: */
		{ APT (NULL, ("[]")); }
	| field_list
		{ }
	;

field_list :				/* List of field declarations */
	     field
		{ APT ("H", ("[H]")); }
	   | field ';' field_list
		{ APT ("T,H", ("[H|T]")); }
	   | error
		{ yyerrok; yyclearin;
		  error ("expected s field declaration.");
		  APT (NULL, ("error(fields)")); }
	   ;

field :				/* Field declaration: */
	ids ':' type			/* Explicit type */
		{ APT ("T,I", ("field_list(I, T)")); }
      | ID ':' type			/* Explicit type */
		{ APT ("T",   ("field(id('%s'), T)", $1)); }
      ;

/******************************************************************************/

globals :				/* Global declarations: */
		{ APT (NULL, ("[]")); }
	| global_list
		{ }
	;

global_list :
	      global
		{ APT ("T",   ("[T]")); }
	    | global ';' global_list
		{ APT ("T,H", ("[H|T]")); }
	    | error
		{ yyerrok; yyclearin;
		  error ("expected a global declaration.");
		  APT (NULL, ("error(decls)")); }
	    ;

global :				/* Global declaration: */
	 ids ':' type
		{ APT ("T,I", ("decl_list(I, var, T)")); }
       | ID  ':' type
		{ APT ("T",   ("decl(id('%s'), var, T)", $1)); }
       | ID  ':' type ASSIGN exp
		{ APT ("V,T", ("V,decl(id('%s'), var, T)", $1));
		  APT ("V",   ("assign(id('%s'), V)", $1)); }
       | ID           ASSIGN exp
		{ APT ("V",   ("decl(id('%s'), const(V), T)", $1)); }
       | ID  ':' global_type EQ global_exp
		{ APT ("V,T", ("decl(id('%s'), const(V), T)", $1)); }
       | ID           EQ global_exp
		{ APT ("V",   ("decl(id('%s'), const(V), T)", $1)); }
       ;


/******************************************************************************/

ids : ID ',' ids_aux
		{ APT ("X", ("[id('%s')|X]", $1)); }
    ;

ids_aux : ID
		{ APT (NULL, ("[id('%s')]", $1)); }
	| ID ',' ids_aux
		{ APT ("T",  ("[id('%s')|T]", $1)); }
	;

/*****************************************************************************/
/*									     */
/*                              Type signatures.  			     */
/*									     */
/*****************************************************************************/


types :					/* Type list */
	type				/* Single type (end of list) */
    		{ APT ("T", ("[T]")); }
      | type ',' types			/* Type tuple (list) */
		{ APT ("T,H", ("[H|T]")); }
      ;


type :					/* Type signature (type expression) */
       '(' types ')'			/* Type list */
		{ }
     | INT				/* Integer */
		{ APT (NULL, ("int")); }
     | REAL				/* Real */
		{ APT (NULL, ("real")); }
     | BOOL				/* Boolean */
		{ APT (NULL, ("bool")); }
     | '[' exp ']' type			/* Array type */
		{ APT ("T,B", ("array(T, B)")); }
     | '{' fields '}'			/* Record/Class type */
		{ APT ("F",   ("class(F)")); }
     | error
		{ yyerrok; yyclearin;
		  error ("expected a type.");
		  APT (NULL, ("error(type)")); }
     ;



/******************************************************************************/

global_type :				/* Type signature valid only at top */
	      '(' types ')'		/* Type list */
		{ }
	    | INT			/* Integer */
		{ APT (NULL, ("int")); }
	    | REAL			/* Real */
		{ APT (NULL, ("real")); }
	    | BOOL			/* Boolean */
		{ APT (NULL, ("bool")); }
	    | type RETURNS type		/* Function type */
		{ APT ("R,D", ("map(D, R)")); }
	    | '[' exp ']' type		/* Array type */
		{ APT ("T,B", ("array(T, B)")); }
	    | '{' fields '}'		/* Record/Class type */
		{ APT ("F",   ("class(F)")); }
	    | error
		{ yyerrok; yyclearin;
		  error ("expected a type.");
		  APT (NULL, ("error(type)")); }
	    ;

/*****************************************************************************/
/*									     */
/*                                  Expressions.   			     */
/*									     */
/*****************************************************************************/

exp :					/* Generic expression */
      sexp
		{ }
    | sexp ',' exp_list
		{ APT ("T,H", ("[H|T]")); }
    ;

exp_list :
	   sexp
		{ APT ("E", ("[E]")); }
	 | sexp ',' exp_list
		{ APT ("T,H", ("[H|T]")); }
	 ;

sexp :
      '(' exp ')'
		{ }
     | sexp OR sexp			/* Boolean operators */
		{ APT ("R,L", ("or(L, R)")); }
     | sexp AND sexp
		{ APT ("R,L", ("and(L, R)")); }
     | NOT sexp
		{ APT ("A",   ("not(A)")); }
     | sexp LT sexp			/* Relational operators */
		{ APT ("R,L", ("lt(L, R)")); }
     | sexp LE sexp
		{ APT ("R,L", ("le(L, R)")); }
     | sexp EQ sexp
		{ APT ("R,L", ("eq(L, R)")); }
     | sexp NE sexp
		{ APT ("R,L", ("ne(L, R)")); }
     | sexp GE sexp
		{ APT ("R,L", ("ge(L, R)")); }
     | sexp GT sexp
		{ APT ("R,L", ("gt(L, R)")); }
     | sexp '+' sexp			/* Arithmetic operators */
		{ APT ("R,L", ("add(L, R)")); }
     | sexp '-' sexp
		{ APT ("R,L", ("sub(L, R)")); }
     | sexp '*' sexp
		{ APT ("R,L", ("mul(L, R)")); }
     | sexp '/' sexp
		{ APT ("R,L", ("div(L, R)")); }
     | sexp '%' sexp
		{ APT ("R,L", ("mod(L, R)")); }
     | '-' sexp		%prec UMINUS
		{ APT ("A",   ("neg(A)")); }
     | sexp '.' ID			/* Qualified names */
		{ APT ("L", ("name(L, id('%s'))", $3)); }
     | sexp '[' exp ']'			/* Array references */
		{ APT ("R,L", ("array(L, R)")); }
     | sexp '(' exp ')'			/* Function references */
		{ APT ("R,L", ("map(L, R)")); }
     | ID				/* Simple names */
		{ APT (NULL,  ("id('%s')", $1)); }
     | INT_LIT				/* Integer constant */
		{ APT (NULL,  ("lit(int, %d)", $1)); }
     | REAL_LIT				/* Real constant */
		{ APT (NULL,  ("lit(real, %g)", $1)); }
     | BOOL_LIT				/* Boolean constant */
		{ APT (NULL,  ("lit(bool, %s)", $1? "true": "false")); }
     ;


/******************************************************************************/

global_exp :
	      sexp			/* An ordinary expression */
		{ }
	    | MAP '(' formals ')'	/* Function literal */
	      '[' stats ']'
		{ APT ("S,F", ("lit(map(TF,TR), map(F,S,Symbols))")); }
	    | MAP '(' formals ')' RETURNS type /* Function literal */
	      '[' stats ']'
		{ APT ("S,TR,F", ("lit(map(TF,TR), map(F,S,Symbols))")); }
	    ;


/******************************************************************************/

primary :				/* Restricted expression */
	  prim
		{ }
	| prim ',' prim_list
		{ APT ("T,H", ("[H|T]")); }
	;

prim_list :
	    prim
		{ APT ("P", ("[P]")); }
	  | prim ',' prim_list
		{ APT ("T,H", ("[H|T]")); }
	  ;


prim :
       '(' primary ')'
		{ }
     | ID
		{ APT (NULL,  ("id('%s')", $1)); }
     | prim '.' prim
		{ APT ("R,L", ("name(L, R)")); }
     | prim '[' exp ']'
		{ APT ("R,L", ("array(L, R)")); }
     ;

/*****************************************************************************/
/*									     */
/*                                  Statements.   			     */
/*									     */
/*****************************************************************************/

stats :	/* EMPTY */
		{ APT (NULL, ("[]")); }
      | stat_list
		{ }
      ;

stat_list :
	    stat
		{ APT ("S", ("[S]")); }
	  | stat ';' stat_list
		{ APT ("Ss,S", ("[S|Ss]")); }
	  | error
		{ yyerrok; yyclearin;
		  error ("expected a valid statement.");
		  APT (NULL, ("error(stats)")); }
	  ;

stat :					/* A statement: */
       decl				/* Declaration */
		{ }
     | action				/* Assignment or call */
		{ }
     | RETURN exp
		{ APT ("E", ("return(E)")); }
     | BREAK
		{ APT (NULL, ("break(S)")); }
     | SKIP
		{ APT (NULL, ("skip(S)")); }
     | RETRY
		{ APT (NULL, ("retry(S)")); }
     | COND
		{ APT (NULL, ("%d", ++guardNo)); }
       '[' clauses ']'
		{ APT ("B,G", ("cond(B, G)")); }
     | WHILE
		{ APT (NULL, ("%d", ++guardNo)); }
       '[' clauses ']'
		{ APT ("B,G", ("while(B, G)")); }
     | '[' stats ']'
		{ }
     ;


clauses :
	  exp RETURNS stats
		{ APT ("S,E", ("[clause(E, S)]")); }
	| exp RETURNS stats '|' clauses
		{ APT ("Cs,S,E", ("[clause(E, S)|Cs]")); }
	| exp RETURNS stats '|' ELSE RETURNS stats
		{ APT ("ES,S,E", ("[clause(E, S),else(ES)]")); }
	| error ']'
		{ yyerrok; yyclearin;
		  error ("syntax error in guarded clause.");
		  APT (NULL, ("error(clause)")); }
	;

action :
         primary ASSIGN exp		/* Assignment */
		{ APT ("V,P", ("assign(P, V)")); }
       | primary '(' exp ')'	/* Function call */
		{ APT ("R,L", ("map(L, R)")); }
       ;

%%

yyerror(s)
    char *s;
{
    if (strcmp(s, "parse error")) {
	error (s);
    }
}
