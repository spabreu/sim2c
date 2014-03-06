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


#define	GUARD_STACK_SIZE 16

static int guardStack[GUARD_STACK_SIZE];
static int *guardSp = guardStack+GUARD_STACK_SIZE;

static int guardNo = 0;

#define	ENTER_GUARD()	(*--guardSp = ++guardNo)
#define EXIT_GUARD()	(*guardSp++)
#define	GUARD(N)	(guardSp[N])


#define APT(pop, push) \
{ \
    if (pop) \
	printf ("[%s|_Tail] ==> [", pop); \
    else \
	printf ("_Tail ==> ["); \
    printf push; \
    printf ("|_Tail].\n"); \
}

#define PUSH(x)	\
{ \
    printf ("_Tail ==> ["); \
    printf x; \
    printf ("|_Tail].\n"); \
}

#define	CONS()	APT ("T,H", ("[H|T]"))
#define	CONS_SWAPPED()	APT ("H,T", ("[H|T]"))

#define	TAIL()	APT ("T",   ("[T]"))
#define	NIL()	PUSH (("[]"))

#define	TAIL_OPEN()	APT ("T",   ("[T|_]"))
#define	NIL_OPEN()	PUSH (("_"))

#define	BINARY(op)	APT ("B,A", ("op(A,B)"))
#define	UNARY(op)	APT ("X",   ("op(X)"))
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
%token STRING				/* The VOID reserved word */

%token MAP				/* The MAP reserved word */
%token CLASS				/* The CLASS reserved word */

%token INT_LIT				/* An INT literal */
%token REAL_LIT				/* A REAL literal */
%token BOOL_LIT				/* A BOOL literal */
%token STRING_LIT			/* A STRING literal */

%token RETURN				/* The RETURN reserved word */
%token RECURSE				/* The RECURSE reserved word */

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
%type <lit.sval> STRING_LIT

/*****************************************************************************/
/*									     */
/*                                Start Symbol.  			     */
/*									     */
/*****************************************************************************/

%start program

%%

program :
		{ *--guardSp = 0; }
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
		{ APT ("V,T", ("decl(id('%s'), var(V), T)", $1)); }
     | ID  ':' type EQ exp		/* Constant, Explicit type */
		{ APT ("V,T", ("decl(id('%s'), const(V), T)", $1)); }
     | ID           EQ exp		/* Constant, Implicit type */
		{ APT ("V",   ("decl(id('%s'), const(V), T)", $1)); }
     ;



/******************************************************************************/

formals :				/* Formal declarations: */
		{ NIL (); }
	| formal
		{ }
	| formal ';' formal_list
		{ CONS (); }
	;

formal_list :				/* List of formal declarations */
	  formal
		{ TAIL (); }
        | formal ';' formal_list
		{ CONS (); }
        | error
		{ yyerrok; yyclearin;
		  yyerror ("expected a formal declaration.");
		  PUSH (("error(formals)")); }
        ;

formal :				/* Formal declaration: */
	 ids				/* Implicit type */
		{ APT ("I",   ("decl_list(I, formal, T)")); }
       | ID				/* Implicit type */
		{ PUSH (("decl(id('%s'), formal, T)", $1)); }
       | ids ':' type			/* Explicit type */
		{ APT ("T,I", ("decl_list(I, formal, T)")); }
       | ID ':' type			/* Explicit type */
		{ APT ("T",   ("decl(id('%s'), formal, T)", $1)); }
       ;

/******************************************************************************/

fields :				/* Field declarations: */
	 field
		{ }
       | field ';' field_list
		{ CONS (); }
       ;

field_list :				/* List of field declarations */
	     field
		{ TAIL (); }
	   | field ';' field_list
		{ CONS (); }
	   | error
		{ yyerrok; yyclearin;
		  yyerror ("expected s field declaration.");
		  PUSH (("error(fields)")); }
	   ;

field :				/* Field declaration: */
	ids ':' type			/* Explicit type */
		{ APT ("T,I", ("field_list(I, T)")); }
      | ID ':' type			/* Explicit type */
		{ APT ("T",   ("field(id('%s'), T)", $1)); }
      ;

/******************************************************************************/

globals :				/* Global declarations: */
		{ NIL (); }
	| global
		{ }
	| global ';' global_list
		{ CONS (); }
	;

global_list :
	      global
		{ TAIL (); }
	    | global ';' global_list
		{ CONS (); }
	    | error
		{ yyerrok; yyclearin;
		  yyerror ("expected a global declaration.");
		  PUSH (("error(decls)")); }
	    ;

global :				/* Global declaration: */
	 ids ':' type
		{ APT ("T,I", ("decl_list(I, var, T)")); }
       | ID  ':' type
		{ APT ("T",   ("decl(id('%s'), var, T)", $1)); }
       | ID  ':' type ASSIGN exp
		{ APT ("V,T", ("decl(id('%s'), var(V), T)", $1)); }
       | ID           ASSIGN exp
		{ APT ("V",   ("decl(id('%s'), const(V), T)", $1)); }
       | ID  ':' global_type EQ global_exp
		{ APT ("V,T", ("decl(id('%s'), const(V), T)", $1)); }
       | ID           EQ global_exp
		{ APT ("V",   ("decl(id('%s'), const(V), T)", $1)); }
       ;


/******************************************************************************/

ids : ID ',' ids_aux
		{ PUSH (("id('%s')", $1)); CONS_SWAPPED (); }
    ;

ids_aux : ID
		{ PUSH (("id('%s')", $1)); TAIL (); }
	| ID ',' ids_aux
		{ PUSH (("id('%s')", $1)); CONS_SWAPPED (); }
	;

/*****************************************************************************/
/*									     */
/*                              Type signatures.  			     */
/*									     */
/*****************************************************************************/


types :					/* Type list */
		{ NIL (); }
      | type				/* Single type (end of list) */
    		{ }
      | type ',' type_list		/* Type tuple (list) */
		{ CONS (); }
      ;


type_list :
	    type
		{ TAIL (); }
	  | type ',' type_list
		{ CONS (); }
	  ;

type :					/* Type signature (type expression) */
       '(' types ')'			/* Bracketing */
		{ }
     | INT				/* Integer */
		{ PUSH (("int")); }
     | REAL				/* Real */
		{ PUSH (("real")); }
     | BOOL				/* Boolean */
		{ PUSH (("bool")); }
     | STRING				/* String */
		{ PUSH (("string")); }
     | '[' exp ']' type			/* Array type */
		{ APT ("T,B", ("array(T, B)")); }
     | '{' fields '}'			/* Record/Class type */
		{ APT ("F",   ("class(F)")); }
     | error
		{ yyerrok; yyclearin;
		  yyerror ("expected a type.");
		  PUSH (("error(type)")); }
     ;



/******************************************************************************/

global_type :				/* Type signature valid only at top */
	      type			/* An ordinary type */
		{ }
	    | type RETURNS type		/* Function type */
		{ APT ("R,D", ("map(D, R)")); }
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
		{ CONS (); }
    ;

exp_list :
	   sexp
		{ TAIL (); }
	 | sexp ',' exp_list
		{ CONS (); }
	 ;

sexp :
       '(' exp ')'
		{ }
     | sexp OR sexp			/* Boolean operators */
		{ BINARY (or); }
     | sexp AND sexp
		{ BINARY (and); }
     | NOT sexp
		{ UNARY  (not); }
     | sexp LT sexp			/* Relational operators */
		{ BINARY (lt); }
     | sexp LE sexp
		{ BINARY (le); }
     | sexp EQ sexp
		{ BINARY (eq); }
     | sexp NE sexp
		{ BINARY (ne); }
     | sexp GE sexp
		{ BINARY (ge); }
     | sexp GT sexp
		{ BINARY (gt); }
     | sexp '+' sexp			/* Arithmetic operators */
		{ BINARY (add); }
     | sexp '-' sexp
		{ BINARY (sub); }
     | sexp '*' sexp
		{ BINARY (mul); }
     | sexp '/' sexp
		{ BINARY (div); }
     | sexp '%' sexp
		{ BINARY (mod); }
     | '-' sexp		%prec UMINUS
		{ UNARY  (neg); }
     | sexp '.' ID			/* Qualified names */
		{ PUSH (("id('%s')", $3)); BINARY (name); }
     | sexp '[' exp ']'			/* Array references */
		{ BINARY (array); }
     | sexp '(' exp ')'			/* Function references */
		{ BINARY (map); }
     | sexp '(' ')'			/* Function references */
		{ NIL (); BINARY (map); }
     | RECURSE '(' exp ')'		/* Recursion */
		{ UNARY (recurse); }
     | RECURSE '(' ')'			/* Recursion */
		{ NIL (); UNARY (recurse); }
     | ID				/* Simple names */
		{ PUSH (("id('%s')", $1)); }
     | INT_LIT				/* Integer constant */
		{ PUSH (("lit(int, %d)", $1)); }
     | REAL_LIT				/* Real constant */
		{ PUSH (("lit(real, %g)", $1)); }
     | BOOL_LIT				/* Boolean constant */
		{ PUSH (("lit(bool, %s)", $1? "true": "false")); }
     | STRING_LIT			/* String constant */
		{ PUSH (("lit(string, '%s')", $1)); }
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
		{ CONS (); }
	;

prim_list :
	    prim
		{ TAIL (); }
	  | prim ',' prim_list
		{ CONS (); }
	  ;


prim :
       '(' primary ')'
		{ }
     | ID
		{ PUSH (("id('%s')", $1)); }
     | prim '.' prim
		{ BINARY (name); }
     | prim '[' exp ']'
		{ BINARY (array); }
     ;

/*****************************************************************************/
/*									     */
/*                                  Statements.   			     */
/*									     */
/*****************************************************************************/

stats :	/* EMPTY */
		{ NIL (); }
      | stat_list
		{ }
      ;

stat_list :
	    stat
		{ TAIL (); }
	  | stat ';'
		{ TAIL (); }
	  | stat ';' stat_list
		{ CONS (); }
	  | error
		{ yyerrok; yyclearin;
		  yyerror ("expected a valid statement.");
		  PUSH (("error(stats)")); }
	  ;

stat :					/* A statement: */
       decl				/* Declaration */
		{ }
     | action				/* Assignment or call */
		{ }
     | RETURN exp
		{ APT ("E", ("return(E)")); }
     | BREAK
		{ PUSH (("break(%d)", GUARD(0))); }
     | SKIP
		{ PUSH (("skip(%d)", GUARD(0))); }
     | RETRY
		{ PUSH (("retry(%d)", GUARD(0))); }
     | BREAK INT_LIT
		{ PUSH (("break(%d)", GUARD($2))); }
     | SKIP INT_LIT
		{ PUSH (("skip(%d)", GUARD($2))); }
     | RETRY INT_LIT
		{ PUSH (("retry(%d)", GUARD($2))); }
     | COND
		{ ENTER_GUARD(); }
       '[' clauses ']'
		{ APT ("B", ("cond(B, %d)", EXIT_GUARD())); }
     | WHILE
		{ ENTER_GUARD(); }
       '[' clauses ']'
		{ APT ("B", ("while(B, %d)", EXIT_GUARD())); }
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
		  yyerror ("syntax error in guarded clause.");
		  PUSH (("error(clause)")); }
	;

action :
         primary ASSIGN exp		/* Assignment */
		{ BINARY (assign); }
       | primary '(' ')'		/* Function references */
		{ NIL (); BINARY (map); }
       | primary '(' exp ')'		/* Function call */
		{ BINARY (map); }
       | RECURSE '(' ')'		/* Recursion */
		{ NIL (); UNARY (recurse); }
       | RECURSE '(' exp ')'		/* Recursion */
		{ UNARY (recurse); }
       ;

%%

yyerror(s)
    char *s;
{
    if (strcmp(s, "syntax error")) {
	fprintf (stderr, "%s\n", s);
    }
}
