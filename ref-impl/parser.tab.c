/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison implementation for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.7"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
/* Line 371 of yacc.c  */
#line 18 "parser.y"


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

/* Line 371 of yacc.c  */
#line 120 "parser.tab.c"

# ifndef YY_NULL
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULL nullptr
#  else
#   define YY_NULL 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "parser.tab.h".  */
#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID = 258,
     INT = 259,
     REAL = 260,
     BOOL = 261,
     STRING = 262,
     MAP = 263,
     CLASS = 264,
     INT_LIT = 265,
     REAL_LIT = 266,
     BOOL_LIT = 267,
     STRING_LIT = 268,
     RETURN = 269,
     RECURSE = 270,
     BREAK = 271,
     SKIP = 272,
     RETRY = 273,
     ELSE = 274,
     COND = 275,
     WHILE = 276,
     IDENTICAL = 277,
     ASSIGN = 278,
     RETURNS = 279,
     AND = 280,
     OR = 281,
     NOT = 282,
     LT = 283,
     LE = 284,
     EQ = 285,
     NE = 286,
     GE = 287,
     GT = 288,
     UMINUS = 289
   };
#endif


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 387 of yacc.c  */
#line 70 "parser.y"

    UNION_DEFS();


/* Line 387 of yacc.c  */
#line 202 "parser.tab.c"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

/* Line 390 of yacc.c  */
#line 230 "parser.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(N) (N)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (YYID (0))
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   507

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  51
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  33
/* YYNRULES -- Number of rules.  */
#define YYNRULES  126
/* YYNRULES -- Number of states.  */
#define YYNSTATES  229

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   289

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,    41,     2,     2,
      43,    44,    39,    37,    36,    38,    49,    40,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    34,    35,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    45,     2,    46,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    47,    50,    48,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    42
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     4,     7,    11,    15,    21,    27,    31,
      32,    34,    38,    40,    44,    46,    48,    50,    54,    58,
      60,    64,    66,    70,    72,    76,    80,    81,    83,    87,
      89,    93,    95,    99,   103,   109,   113,   119,   123,   127,
     129,   133,   134,   136,   140,   142,   146,   150,   152,   154,
     156,   158,   163,   167,   169,   171,   175,   177,   181,   183,
     187,   191,   195,   199,   202,   206,   210,   214,   218,   222,
     226,   230,   234,   238,   242,   246,   249,   253,   258,   263,
     267,   272,   276,   278,   280,   282,   284,   286,   288,   296,
     306,   308,   312,   314,   318,   322,   324,   328,   333,   334,
     336,   338,   341,   345,   347,   349,   351,   354,   356,   358,
     360,   363,   366,   369,   370,   376,   377,   383,   387,   391,
     397,   405,   408,   412,   416,   421,   425
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      52,     0,    -1,    -1,    53,    61,    -1,    64,    34,    68,
      -1,     3,    34,    68,    -1,     3,    34,    68,    23,    70,
      -1,     3,    34,    68,    30,    70,    -1,     3,    30,    70,
      -1,    -1,    57,    -1,    57,    35,    56,    -1,    57,    -1,
      57,    35,    56,    -1,     1,    -1,    64,    -1,     3,    -1,
      64,    34,    68,    -1,     3,    34,    68,    -1,    60,    -1,
      60,    35,    59,    -1,    60,    -1,    60,    35,    59,    -1,
       1,    -1,    64,    34,    68,    -1,     3,    34,    68,    -1,
      -1,    63,    -1,    63,    35,    62,    -1,    63,    -1,    63,
      35,    62,    -1,     1,    -1,    64,    34,    68,    -1,     3,
      34,    68,    -1,     3,    34,    68,    23,    70,    -1,     3,
      23,    70,    -1,     3,    34,    69,    30,    73,    -1,     3,
      30,    73,    -1,     3,    36,    65,    -1,     3,    -1,     3,
      36,    65,    -1,    -1,    68,    -1,    68,    36,    67,    -1,
      68,    -1,    68,    36,    67,    -1,    43,    66,    44,    -1,
       4,    -1,     5,    -1,     6,    -1,     7,    -1,    45,    70,
      46,    68,    -1,    47,    58,    48,    -1,     1,    -1,    68,
      -1,    68,    24,    68,    -1,    72,    -1,    72,    36,    71,
      -1,    72,    -1,    72,    36,    71,    -1,    43,    70,    44,
      -1,    72,    26,    72,    -1,    72,    25,    72,    -1,    27,
      72,    -1,    72,    28,    72,    -1,    72,    29,    72,    -1,
      72,    30,    72,    -1,    72,    31,    72,    -1,    72,    32,
      72,    -1,    72,    33,    72,    -1,    72,    37,    72,    -1,
      72,    38,    72,    -1,    72,    39,    72,    -1,    72,    40,
      72,    -1,    72,    41,    72,    -1,    38,    72,    -1,    72,
      49,     3,    -1,    72,    45,    70,    46,    -1,    72,    43,
      70,    44,    -1,    72,    43,    44,    -1,    15,    43,    70,
      44,    -1,    15,    43,    44,    -1,     3,    -1,    10,    -1,
      11,    -1,    12,    -1,    13,    -1,    72,    -1,     8,    43,
      55,    44,    45,    77,    46,    -1,     8,    43,    55,    44,
      24,    68,    45,    77,    46,    -1,    76,    -1,    76,    36,
      75,    -1,    76,    -1,    76,    36,    75,    -1,    43,    74,
      44,    -1,     3,    -1,    76,    49,    76,    -1,    76,    45,
      70,    46,    -1,    -1,    78,    -1,    79,    -1,    79,    35,
      -1,    79,    35,    78,    -1,     1,    -1,    54,    -1,    83,
      -1,    14,    70,    -1,    16,    -1,    17,    -1,    18,    -1,
      16,    10,    -1,    17,    10,    -1,    18,    10,    -1,    -1,
      20,    80,    45,    82,    46,    -1,    -1,    21,    81,    45,
      82,    46,    -1,    45,    77,    46,    -1,    70,    24,    77,
      -1,    70,    24,    77,    50,    82,    -1,    70,    24,    77,
      50,    19,    24,    77,    -1,     1,    46,    -1,    74,    23,
      70,    -1,    74,    43,    44,    -1,    74,    43,    70,    44,
      -1,    15,    43,    44,    -1,    15,    43,    70,    44,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   170,   170,   170,   182,   184,   186,   188,   190,   199,
     200,   202,   207,   209,   211,   218,   220,   222,   224,   231,
     233,   238,   240,   242,   249,   251,   258,   259,   261,   266,
     268,   270,   277,   279,   281,   283,   285,   287,   294,   298,
     300,   312,   313,   315,   321,   323,   328,   330,   332,   334,
     336,   338,   340,   342,   353,   355,   366,   368,   373,   375,
     380,   382,   384,   386,   388,   390,   392,   394,   396,   398,
     400,   402,   404,   406,   408,   410,   412,   414,   416,   418,
     420,   422,   424,   426,   428,   430,   432,   440,   442,   445,
     454,   456,   461,   463,   469,   471,   473,   475,   486,   487,
     492,   494,   496,   498,   505,   507,   509,   511,   513,   515,
     517,   519,   521,   524,   523,   528,   527,   531,   537,   539,
     541,   543,   550,   552,   554,   556,   558
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "ID", "INT", "REAL", "BOOL", "STRING",
  "MAP", "CLASS", "INT_LIT", "REAL_LIT", "BOOL_LIT", "STRING_LIT",
  "RETURN", "RECURSE", "BREAK", "SKIP", "RETRY", "ELSE", "COND", "WHILE",
  "IDENTICAL", "ASSIGN", "RETURNS", "AND", "OR", "NOT", "LT", "LE", "EQ",
  "NE", "GE", "GT", "':'", "';'", "','", "'+'", "'-'", "'*'", "'/'", "'%'",
  "UMINUS", "'('", "')'", "'['", "']'", "'{'", "'}'", "'.'", "'|'",
  "$accept", "program", "$@1", "decl", "formals", "formal_list", "formal",
  "fields", "field_list", "field", "globals", "global_list", "global",
  "ids", "ids_aux", "types", "type_list", "type", "global_type", "exp",
  "exp_list", "sexp", "global_exp", "primary", "prim_list", "prim",
  "stats", "stat_list", "stat", "$@2", "$@3", "clauses", "action", YY_NULL
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,    58,    59,    44,    43,    45,    42,
      47,    37,   289,    40,    41,    91,    93,   123,   125,    46,
     124
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    51,    53,    52,    54,    54,    54,    54,    54,    55,
      55,    55,    56,    56,    56,    57,    57,    57,    57,    58,
      58,    59,    59,    59,    60,    60,    61,    61,    61,    62,
      62,    62,    63,    63,    63,    63,    63,    63,    64,    65,
      65,    66,    66,    66,    67,    67,    68,    68,    68,    68,
      68,    68,    68,    68,    69,    69,    70,    70,    71,    71,
      72,    72,    72,    72,    72,    72,    72,    72,    72,    72,
      72,    72,    72,    72,    72,    72,    72,    72,    72,    72,
      72,    72,    72,    72,    72,    72,    72,    73,    73,    73,
      74,    74,    75,    75,    76,    76,    76,    76,    77,    77,
      78,    78,    78,    78,    79,    79,    79,    79,    79,    79,
      79,    79,    79,    80,    79,    81,    79,    79,    82,    82,
      82,    82,    83,    83,    83,    83,    83
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     2,     3,     3,     5,     5,     3,     0,
       1,     3,     1,     3,     1,     1,     1,     3,     3,     1,
       3,     1,     3,     1,     3,     3,     0,     1,     3,     1,
       3,     1,     3,     3,     5,     3,     5,     3,     3,     1,
       3,     0,     1,     3,     1,     3,     3,     1,     1,     1,
       1,     4,     3,     1,     1,     3,     1,     3,     1,     3,
       3,     3,     3,     2,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     2,     3,     4,     4,     3,
       4,     3,     1,     1,     1,     1,     1,     1,     7,     9,
       1,     3,     1,     3,     3,     1,     3,     4,     0,     1,
       1,     2,     3,     1,     1,     1,     2,     1,     1,     1,
       2,     2,     2,     0,     5,     0,     5,     3,     3,     5,
       7,     2,     3,     3,     4,     3,     4
};

/* YYDEFACT[STATE-NAME] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       2,     0,    26,     1,     0,     3,    27,     0,     0,     0,
       0,     0,     0,     0,    82,    83,    84,    85,    86,     0,
       0,     0,     0,    35,    56,     0,    87,    37,    53,    47,
      48,    49,    50,     0,     0,     0,    33,     0,    39,    38,
      31,    28,    29,    32,     0,    63,    75,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     9,     0,    42,     0,     0,
       0,    19,     0,     0,     0,     0,     0,     0,    81,     0,
      60,    62,    61,    64,    65,    66,    67,    68,    69,    57,
      58,    70,    71,    72,    73,    74,    79,     0,     0,    76,
      16,     0,    10,    15,    46,     0,     0,     0,    52,     0,
       0,    34,    55,    36,    40,    30,    80,     0,    78,    77,
       0,     0,     0,     0,    43,    44,    51,    25,    23,    20,
      21,    24,    59,    18,     0,     0,    14,    11,    12,    17,
       0,     0,     0,   103,    95,     0,     0,   107,   108,   109,
     113,   115,     0,     0,   104,     0,     0,    90,     0,    99,
     100,   105,     0,    45,    22,     0,     0,     0,   106,     0,
     110,   111,   112,     0,     0,    95,     0,     0,     0,     0,
       0,     0,     0,     0,    88,     0,    13,     0,     8,     5,
     125,     0,     0,     0,    94,   117,     4,   122,   123,     0,
      91,    92,     0,    96,   102,    89,     0,     0,   126,     0,
       0,     0,     0,   124,     0,    97,     6,     7,   121,     0,
     114,   116,    93,   118,     0,     0,   119,     0,   120
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     1,     2,   154,   101,   137,   138,    70,   129,   130,
       5,    41,    42,   155,    39,    66,   124,   125,    37,   210,
      89,    24,    27,   156,   200,   157,   158,   159,   160,   173,
     174,   211,   161
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -191
static const yytype_int16 yypact[] =
{
    -191,    32,    12,  -191,    16,  -191,   -17,     1,   332,   314,
     180,    40,     9,   180,  -191,  -191,  -191,  -191,  -191,     6,
     332,   332,   332,  -191,   348,    10,   392,  -191,  -191,  -191,
    -191,  -191,  -191,    15,   332,    41,    50,    31,    35,  -191,
    -191,  -191,    33,  -191,   240,   436,    34,    37,   332,   332,
     332,   332,   332,   332,   332,   332,   332,   332,   332,   332,
     332,   332,   258,   332,    75,    96,    60,    77,    70,    30,
      69,    89,    97,   332,   180,   314,    40,     9,  -191,    88,
    -191,   436,   414,   458,   458,   458,   458,   458,   458,  -191,
     370,   -16,   -16,    34,    34,    34,  -191,    90,    92,  -191,
      64,    95,   101,   106,  -191,   180,   180,   180,  -191,   109,
     180,  -191,  -191,  -191,  -191,  -191,  -191,   332,  -191,  -191,
     180,   -15,   127,   180,  -191,   113,  -191,  -191,  -191,  -191,
     117,  -191,  -191,  -191,   180,   199,  -191,  -191,   119,  -191,
     180,   109,   111,  -191,    73,   332,    98,   147,   150,   154,
    -191,  -191,    -1,   199,  -191,   134,   -12,     2,   120,  -191,
     153,  -191,   127,  -191,  -191,   199,   332,   180,  -191,   276,
    -191,  -191,  -191,   124,   144,  -191,   146,   145,   180,   332,
     294,    -1,   332,    -1,  -191,   105,  -191,   148,  -191,    18,
    -191,   149,   132,   132,  -191,  -191,  -191,  -191,  -191,   151,
    -191,    27,   155,  -191,  -191,  -191,   332,   332,  -191,   157,
     168,   158,   160,  -191,    -1,  -191,  -191,  -191,  -191,   162,
    -191,  -191,  -191,   159,   221,   172,  -191,   199,  -191
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -191,  -191,  -191,  -191,  -191,    48,   156,  -191,    56,   176,
    -191,   141,   224,     5,   152,  -191,    99,    -5,  -191,    -8,
     112,    36,   163,    78,    21,  -177,  -152,    52,  -191,  -191,
    -191,  -190,  -191
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -102
static const yytype_int16 yytable[] =
{
      23,   177,   175,   212,   201,    36,   203,     7,    43,   134,
      40,   179,     4,   187,    47,     4,    28,     7,    12,    29,
      30,    31,    32,    59,    60,    61,    68,    62,    67,    63,
     135,   180,     3,    64,   226,    13,    79,   201,   181,     8,
      72,   206,   152,    38,    69,    26,     9,   182,   207,    44,
      10,   183,    11,    65,    97,    98,    45,    46,    33,   -41,
      34,    75,    35,   214,   107,   111,    11,   223,    77,   112,
     103,    76,   182,    73,    74,   228,   183,    62,    99,    63,
     -54,    80,     7,    64,    81,    82,    83,    84,    85,    86,
      87,    88,    90,    91,    92,    93,    94,    95,   120,   100,
      11,   126,   127,   166,   104,   131,   143,   167,   144,    11,
     128,    26,    69,   105,    72,   133,   106,   108,   139,   145,
     146,   147,   148,   149,   109,   150,   151,   103,   136,   142,
     100,   110,   116,   209,   118,    14,   122,   168,   119,   121,
     123,   169,    15,    16,    17,    18,    72,    19,   152,   140,
     153,  -101,   141,    90,   162,  -101,   165,   170,   188,    20,
     171,   191,   189,   143,   172,   144,   184,   103,   178,   192,
      21,   197,   199,   196,   202,    22,   145,   146,   147,   148,
     149,    28,   150,   151,    29,    30,    31,    32,   185,   193,
     194,   195,   219,   208,   205,   213,   227,   164,   216,   217,
     143,   215,   144,   218,   220,   152,   221,   153,   -98,   224,
     186,    71,   -98,   145,   146,   147,   148,   149,   115,   150,
     151,   102,   209,    33,    14,    34,     6,    35,   114,   132,
     176,    15,    16,    17,    18,   222,    19,   204,   113,   163,
     225,     0,   152,    14,   153,   -98,     0,     0,    20,     0,
      15,    16,    17,    18,     0,    19,     0,     0,     0,    21,
       0,    14,     0,     0,    22,     0,     0,    20,    15,    16,
      17,    18,     0,    19,     0,     0,     0,     0,    21,    14,
       0,     0,     0,    22,    78,    20,    15,    16,    17,    18,
       0,    19,     0,     0,     0,     0,    21,    14,     0,     0,
       0,    22,    96,    20,    15,    16,    17,    18,     0,    19,
       0,     0,     0,     0,    21,     0,     0,    14,     0,    22,
     190,    20,    25,     0,    15,    16,    17,    18,     0,    19,
       0,     0,    21,     0,     0,    14,     0,    22,   198,     0,
       0,    20,    15,    16,    17,    18,     0,    19,     0,     0,
       0,     0,    21,     0,     0,     0,     0,    22,     0,    20,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      21,     0,     0,    48,    49,    22,    50,    51,    52,    53,
      54,    55,     0,     0,    56,    57,    58,    59,    60,    61,
       0,    62,     0,    63,     0,    48,    49,    64,    50,    51,
      52,    53,    54,    55,     0,     0,   117,    57,    58,    59,
      60,    61,     0,    62,     0,    63,     0,    48,    49,    64,
      50,    51,    52,    53,    54,    55,     0,     0,     0,    57,
      58,    59,    60,    61,     0,    62,     0,    63,     0,    48,
       0,    64,    50,    51,    52,    53,    54,    55,     0,     0,
       0,    57,    58,    59,    60,    61,     0,    62,     0,    63,
       0,     0,     0,    64,    50,    51,    52,    53,    54,    55,
       0,     0,     0,    57,    58,    59,    60,    61,     0,    62,
       0,    63,     0,     0,     0,    64,  -102,  -102,  -102,  -102,
    -102,  -102,     0,     0,     0,    57,    58,    59,    60,    61,
       0,    62,     0,    63,     0,     0,     0,    64
};

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-191)))

#define yytable_value_is_error(Yytable_value) \
  (!!((Yytable_value) == (-102)))

static const yytype_int16 yycheck[] =
{
       8,   153,     3,   193,   181,    10,   183,     2,    13,    24,
       1,    23,     3,   165,    22,     3,     1,    12,    35,     4,
       5,     6,     7,    39,    40,    41,    34,    43,    33,    45,
      45,    43,     0,    49,   224,    34,    44,   214,    36,    23,
      35,    23,    43,     3,     3,     9,    30,    45,    30,    43,
      34,    49,    36,    43,    62,    63,    20,    21,    43,    44,
      45,    30,    47,    36,    34,    73,    36,   219,    35,    74,
      65,    36,    45,    23,    24,   227,    49,    43,     3,    45,
      30,    44,    77,    49,    48,    49,    50,    51,    52,    53,
      54,    55,    56,    57,    58,    59,    60,    61,    34,     3,
      36,   106,   107,    30,    44,   110,     1,    34,     3,    36,
       1,    75,     3,    36,   109,   120,    46,    48,   123,    14,
      15,    16,    17,    18,    35,    20,    21,   122,     1,   134,
       3,    34,    44,     1,    44,     3,    35,   145,    46,    44,
      34,    43,    10,    11,    12,    13,   141,    15,    43,    36,
      45,    46,    35,   117,    35,    50,    45,    10,   166,    27,
      10,   169,   167,     1,    10,     3,    46,   162,    34,    45,
      38,   179,   180,   178,   182,    43,    14,    15,    16,    17,
      18,     1,    20,    21,     4,     5,     6,     7,    35,    45,
      44,    46,    24,    44,    46,    44,    24,   141,   206,   207,
       1,    46,     3,    46,    46,    43,    46,    45,    46,    50,
     162,    35,    50,    14,    15,    16,    17,    18,    77,    20,
      21,    65,     1,    43,     3,    45,     2,    47,    76,   117,
     152,    10,    11,    12,    13,   214,    15,   185,    75,   140,
      19,    -1,    43,     3,    45,    46,    -1,    -1,    27,    -1,
      10,    11,    12,    13,    -1,    15,    -1,    -1,    -1,    38,
      -1,     3,    -1,    -1,    43,    -1,    -1,    27,    10,    11,
      12,    13,    -1,    15,    -1,    -1,    -1,    -1,    38,     3,
      -1,    -1,    -1,    43,    44,    27,    10,    11,    12,    13,
      -1,    15,    -1,    -1,    -1,    -1,    38,     3,    -1,    -1,
      -1,    43,    44,    27,    10,    11,    12,    13,    -1,    15,
      -1,    -1,    -1,    -1,    38,    -1,    -1,     3,    -1,    43,
      44,    27,     8,    -1,    10,    11,    12,    13,    -1,    15,
      -1,    -1,    38,    -1,    -1,     3,    -1,    43,    44,    -1,
      -1,    27,    10,    11,    12,    13,    -1,    15,    -1,    -1,
      -1,    -1,    38,    -1,    -1,    -1,    -1,    43,    -1,    27,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      38,    -1,    -1,    25,    26,    43,    28,    29,    30,    31,
      32,    33,    -1,    -1,    36,    37,    38,    39,    40,    41,
      -1,    43,    -1,    45,    -1,    25,    26,    49,    28,    29,
      30,    31,    32,    33,    -1,    -1,    36,    37,    38,    39,
      40,    41,    -1,    43,    -1,    45,    -1,    25,    26,    49,
      28,    29,    30,    31,    32,    33,    -1,    -1,    -1,    37,
      38,    39,    40,    41,    -1,    43,    -1,    45,    -1,    25,
      -1,    49,    28,    29,    30,    31,    32,    33,    -1,    -1,
      -1,    37,    38,    39,    40,    41,    -1,    43,    -1,    45,
      -1,    -1,    -1,    49,    28,    29,    30,    31,    32,    33,
      -1,    -1,    -1,    37,    38,    39,    40,    41,    -1,    43,
      -1,    45,    -1,    -1,    -1,    49,    28,    29,    30,    31,
      32,    33,    -1,    -1,    -1,    37,    38,    39,    40,    41,
      -1,    43,    -1,    45,    -1,    -1,    -1,    49
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    52,    53,     0,     3,    61,    63,    64,    23,    30,
      34,    36,    35,    34,     3,    10,    11,    12,    13,    15,
      27,    38,    43,    70,    72,     8,    72,    73,     1,     4,
       5,     6,     7,    43,    45,    47,    68,    69,     3,    65,
       1,    62,    63,    68,    43,    72,    72,    70,    25,    26,
      28,    29,    30,    31,    32,    33,    36,    37,    38,    39,
      40,    41,    43,    45,    49,    43,    66,    68,    70,     3,
      58,    60,    64,    23,    24,    30,    36,    35,    44,    70,
      44,    72,    72,    72,    72,    72,    72,    72,    72,    71,
      72,    72,    72,    72,    72,    72,    44,    70,    70,     3,
       3,    55,    57,    64,    44,    36,    46,    34,    48,    35,
      34,    70,    68,    73,    65,    62,    44,    36,    44,    46,
      34,    44,    35,    34,    67,    68,    68,    68,     1,    59,
      60,    68,    71,    68,    24,    45,     1,    56,    57,    68,
      36,    35,    68,     1,     3,    14,    15,    16,    17,    18,
      20,    21,    43,    45,    54,    64,    74,    76,    77,    78,
      79,    83,    35,    67,    59,    45,    30,    34,    70,    43,
      10,    10,    10,    80,    81,     3,    74,    77,    34,    23,
      43,    36,    45,    49,    46,    35,    56,    77,    70,    68,
      44,    70,    45,    45,    44,    46,    68,    70,    44,    70,
      75,    76,    70,    76,    78,    46,    23,    30,    44,     1,
      70,    82,    82,    44,    36,    46,    70,    70,    46,    24,
      46,    46,    75,    77,    50,    19,    82,    24,    77
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  However,
   YYFAIL appears to be in use.  Nevertheless, it is formally deprecated
   in Bison 2.4.2's NEWS entry, where a plan to phase it out is
   discussed.  */

#define YYFAIL		goto yyerrlab
#if defined YYFAIL
  /* This is here to suppress warnings from the GCC cpp's
     -Wunused-macros.  Normally we don't worry about that warning, but
     some users do, and we want to make it easy for users to remove
     YYFAIL uses, which will produce warnings from Bison 2.5.  */
#endif

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))

/* Error token number */
#define YYTERROR	1
#define YYERRCODE	256


/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */
#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
        break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULL, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULL;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - Assume YYFAIL is not used.  It's too flawed to consider.  See
       <http://lists.gnu.org/archive/html/bison-patches/2009-12/msg00024.html>
       for details.  YYERROR is fine as it does not invoke this
       function.
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULL, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
        break;
    }
}




/* The lookahead symbol.  */
int yychar;


#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval YY_INITIAL_VALUE(yyval_default);

/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
/* Line 1792 of yacc.c  */
#line 170 "parser.y"
    { *--guardSp = 0; }
    break;

  case 4:
/* Line 1792 of yacc.c  */
#line 183 "parser.y"
    { APT ("T,I", ("decl_list(I, var, T)")); }
    break;

  case 5:
/* Line 1792 of yacc.c  */
#line 185 "parser.y"
    { APT ("T",   ("decl(id('%s'), var, T)", (yyvsp[(1) - (3)].id))); }
    break;

  case 6:
/* Line 1792 of yacc.c  */
#line 187 "parser.y"
    { APT ("V,T", ("decl(id('%s'), var(V), T)", (yyvsp[(1) - (5)].id))); }
    break;

  case 7:
/* Line 1792 of yacc.c  */
#line 189 "parser.y"
    { APT ("V,T", ("decl(id('%s'), const(V), T)", (yyvsp[(1) - (5)].id))); }
    break;

  case 8:
/* Line 1792 of yacc.c  */
#line 191 "parser.y"
    { APT ("V",   ("decl(id('%s'), const(V), T)", (yyvsp[(1) - (3)].id))); }
    break;

  case 9:
/* Line 1792 of yacc.c  */
#line 199 "parser.y"
    { NIL (); }
    break;

  case 10:
/* Line 1792 of yacc.c  */
#line 201 "parser.y"
    { }
    break;

  case 11:
/* Line 1792 of yacc.c  */
#line 203 "parser.y"
    { CONS (); }
    break;

  case 12:
/* Line 1792 of yacc.c  */
#line 208 "parser.y"
    { TAIL (); }
    break;

  case 13:
/* Line 1792 of yacc.c  */
#line 210 "parser.y"
    { CONS (); }
    break;

  case 14:
/* Line 1792 of yacc.c  */
#line 212 "parser.y"
    { yyerrok; yyclearin;
		  yyerror ("expected a formal declaration.");
		  PUSH (("error(formals)")); }
    break;

  case 15:
/* Line 1792 of yacc.c  */
#line 219 "parser.y"
    { APT ("I",   ("decl_list(I, formal, T)")); }
    break;

  case 16:
/* Line 1792 of yacc.c  */
#line 221 "parser.y"
    { PUSH (("decl(id('%s'), formal, T)", (yyvsp[(1) - (1)].id))); }
    break;

  case 17:
/* Line 1792 of yacc.c  */
#line 223 "parser.y"
    { APT ("T,I", ("decl_list(I, formal, T)")); }
    break;

  case 18:
/* Line 1792 of yacc.c  */
#line 225 "parser.y"
    { APT ("T",   ("decl(id('%s'), formal, T)", (yyvsp[(1) - (3)].id))); }
    break;

  case 19:
/* Line 1792 of yacc.c  */
#line 232 "parser.y"
    { }
    break;

  case 20:
/* Line 1792 of yacc.c  */
#line 234 "parser.y"
    { CONS (); }
    break;

  case 21:
/* Line 1792 of yacc.c  */
#line 239 "parser.y"
    { TAIL (); }
    break;

  case 22:
/* Line 1792 of yacc.c  */
#line 241 "parser.y"
    { CONS (); }
    break;

  case 23:
/* Line 1792 of yacc.c  */
#line 243 "parser.y"
    { yyerrok; yyclearin;
		  yyerror ("expected s field declaration.");
		  PUSH (("error(fields)")); }
    break;

  case 24:
/* Line 1792 of yacc.c  */
#line 250 "parser.y"
    { APT ("T,I", ("field_list(I, T)")); }
    break;

  case 25:
/* Line 1792 of yacc.c  */
#line 252 "parser.y"
    { APT ("T",   ("field(id('%s'), T)", (yyvsp[(1) - (3)].id))); }
    break;

  case 26:
/* Line 1792 of yacc.c  */
#line 258 "parser.y"
    { NIL (); }
    break;

  case 27:
/* Line 1792 of yacc.c  */
#line 260 "parser.y"
    { }
    break;

  case 28:
/* Line 1792 of yacc.c  */
#line 262 "parser.y"
    { CONS (); }
    break;

  case 29:
/* Line 1792 of yacc.c  */
#line 267 "parser.y"
    { TAIL (); }
    break;

  case 30:
/* Line 1792 of yacc.c  */
#line 269 "parser.y"
    { CONS (); }
    break;

  case 31:
/* Line 1792 of yacc.c  */
#line 271 "parser.y"
    { yyerrok; yyclearin;
		  yyerror ("expected a global declaration.");
		  PUSH (("error(decls)")); }
    break;

  case 32:
/* Line 1792 of yacc.c  */
#line 278 "parser.y"
    { APT ("T,I", ("decl_list(I, var, T)")); }
    break;

  case 33:
/* Line 1792 of yacc.c  */
#line 280 "parser.y"
    { APT ("T",   ("decl(id('%s'), var, T)", (yyvsp[(1) - (3)].id))); }
    break;

  case 34:
/* Line 1792 of yacc.c  */
#line 282 "parser.y"
    { APT ("V,T", ("decl(id('%s'), var(V), T)", (yyvsp[(1) - (5)].id))); }
    break;

  case 35:
/* Line 1792 of yacc.c  */
#line 284 "parser.y"
    { APT ("V",   ("decl(id('%s'), const(V), T)", (yyvsp[(1) - (3)].id))); }
    break;

  case 36:
/* Line 1792 of yacc.c  */
#line 286 "parser.y"
    { APT ("V,T", ("decl(id('%s'), const(V), T)", (yyvsp[(1) - (5)].id))); }
    break;

  case 37:
/* Line 1792 of yacc.c  */
#line 288 "parser.y"
    { APT ("V",   ("decl(id('%s'), const(V), T)", (yyvsp[(1) - (3)].id))); }
    break;

  case 38:
/* Line 1792 of yacc.c  */
#line 295 "parser.y"
    { PUSH (("id('%s')", (yyvsp[(1) - (3)].id))); CONS_SWAPPED (); }
    break;

  case 39:
/* Line 1792 of yacc.c  */
#line 299 "parser.y"
    { PUSH (("id('%s')", (yyvsp[(1) - (1)].id))); TAIL (); }
    break;

  case 40:
/* Line 1792 of yacc.c  */
#line 301 "parser.y"
    { PUSH (("id('%s')", (yyvsp[(1) - (3)].id))); CONS_SWAPPED (); }
    break;

  case 41:
/* Line 1792 of yacc.c  */
#line 312 "parser.y"
    { NIL (); }
    break;

  case 42:
/* Line 1792 of yacc.c  */
#line 314 "parser.y"
    { }
    break;

  case 43:
/* Line 1792 of yacc.c  */
#line 316 "parser.y"
    { CONS (); }
    break;

  case 44:
/* Line 1792 of yacc.c  */
#line 322 "parser.y"
    { TAIL (); }
    break;

  case 45:
/* Line 1792 of yacc.c  */
#line 324 "parser.y"
    { CONS (); }
    break;

  case 46:
/* Line 1792 of yacc.c  */
#line 329 "parser.y"
    { }
    break;

  case 47:
/* Line 1792 of yacc.c  */
#line 331 "parser.y"
    { PUSH (("int")); }
    break;

  case 48:
/* Line 1792 of yacc.c  */
#line 333 "parser.y"
    { PUSH (("real")); }
    break;

  case 49:
/* Line 1792 of yacc.c  */
#line 335 "parser.y"
    { PUSH (("bool")); }
    break;

  case 50:
/* Line 1792 of yacc.c  */
#line 337 "parser.y"
    { PUSH (("string")); }
    break;

  case 51:
/* Line 1792 of yacc.c  */
#line 339 "parser.y"
    { APT ("T,B", ("array(T, B)")); }
    break;

  case 52:
/* Line 1792 of yacc.c  */
#line 341 "parser.y"
    { APT ("F",   ("class(F)")); }
    break;

  case 53:
/* Line 1792 of yacc.c  */
#line 343 "parser.y"
    { yyerrok; yyclearin;
		  yyerror ("expected a type.");
		  PUSH (("error(type)")); }
    break;

  case 54:
/* Line 1792 of yacc.c  */
#line 354 "parser.y"
    { }
    break;

  case 55:
/* Line 1792 of yacc.c  */
#line 356 "parser.y"
    { APT ("R,D", ("map(D, R)")); }
    break;

  case 56:
/* Line 1792 of yacc.c  */
#line 367 "parser.y"
    { }
    break;

  case 57:
/* Line 1792 of yacc.c  */
#line 369 "parser.y"
    { CONS (); }
    break;

  case 58:
/* Line 1792 of yacc.c  */
#line 374 "parser.y"
    { TAIL (); }
    break;

  case 59:
/* Line 1792 of yacc.c  */
#line 376 "parser.y"
    { CONS (); }
    break;

  case 60:
/* Line 1792 of yacc.c  */
#line 381 "parser.y"
    { }
    break;

  case 61:
/* Line 1792 of yacc.c  */
#line 383 "parser.y"
    { BINARY (or); }
    break;

  case 62:
/* Line 1792 of yacc.c  */
#line 385 "parser.y"
    { BINARY (and); }
    break;

  case 63:
/* Line 1792 of yacc.c  */
#line 387 "parser.y"
    { UNARY  (not); }
    break;

  case 64:
/* Line 1792 of yacc.c  */
#line 389 "parser.y"
    { BINARY (lt); }
    break;

  case 65:
/* Line 1792 of yacc.c  */
#line 391 "parser.y"
    { BINARY (le); }
    break;

  case 66:
/* Line 1792 of yacc.c  */
#line 393 "parser.y"
    { BINARY (eq); }
    break;

  case 67:
/* Line 1792 of yacc.c  */
#line 395 "parser.y"
    { BINARY (ne); }
    break;

  case 68:
/* Line 1792 of yacc.c  */
#line 397 "parser.y"
    { BINARY (ge); }
    break;

  case 69:
/* Line 1792 of yacc.c  */
#line 399 "parser.y"
    { BINARY (gt); }
    break;

  case 70:
/* Line 1792 of yacc.c  */
#line 401 "parser.y"
    { BINARY (add); }
    break;

  case 71:
/* Line 1792 of yacc.c  */
#line 403 "parser.y"
    { BINARY (sub); }
    break;

  case 72:
/* Line 1792 of yacc.c  */
#line 405 "parser.y"
    { BINARY (mul); }
    break;

  case 73:
/* Line 1792 of yacc.c  */
#line 407 "parser.y"
    { BINARY (div); }
    break;

  case 74:
/* Line 1792 of yacc.c  */
#line 409 "parser.y"
    { BINARY (mod); }
    break;

  case 75:
/* Line 1792 of yacc.c  */
#line 411 "parser.y"
    { UNARY  (neg); }
    break;

  case 76:
/* Line 1792 of yacc.c  */
#line 413 "parser.y"
    { PUSH (("id('%s')", (yyvsp[(3) - (3)].id))); BINARY (name); }
    break;

  case 77:
/* Line 1792 of yacc.c  */
#line 415 "parser.y"
    { BINARY (array); }
    break;

  case 78:
/* Line 1792 of yacc.c  */
#line 417 "parser.y"
    { BINARY (map); }
    break;

  case 79:
/* Line 1792 of yacc.c  */
#line 419 "parser.y"
    { NIL (); BINARY (map); }
    break;

  case 80:
/* Line 1792 of yacc.c  */
#line 421 "parser.y"
    { UNARY (recurse); }
    break;

  case 81:
/* Line 1792 of yacc.c  */
#line 423 "parser.y"
    { NIL (); UNARY (recurse); }
    break;

  case 82:
/* Line 1792 of yacc.c  */
#line 425 "parser.y"
    { PUSH (("id('%s')", (yyvsp[(1) - (1)].id))); }
    break;

  case 83:
/* Line 1792 of yacc.c  */
#line 427 "parser.y"
    { PUSH (("lit(int, %d)", (yyvsp[(1) - (1)].lit.ival))); }
    break;

  case 84:
/* Line 1792 of yacc.c  */
#line 429 "parser.y"
    { PUSH (("lit(real, %g)", (yyvsp[(1) - (1)].lit.rval))); }
    break;

  case 85:
/* Line 1792 of yacc.c  */
#line 431 "parser.y"
    { PUSH (("lit(bool, %s)", (yyvsp[(1) - (1)].lit.bval)? "true": "false")); }
    break;

  case 86:
/* Line 1792 of yacc.c  */
#line 433 "parser.y"
    { PUSH (("lit(string, '%s')", (yyvsp[(1) - (1)].lit.sval))); }
    break;

  case 87:
/* Line 1792 of yacc.c  */
#line 441 "parser.y"
    { }
    break;

  case 88:
/* Line 1792 of yacc.c  */
#line 444 "parser.y"
    { APT ("S,F", ("lit(map(TF,TR), map(F,S,Symbols))")); }
    break;

  case 89:
/* Line 1792 of yacc.c  */
#line 447 "parser.y"
    { APT ("S,TR,F", ("lit(map(TF,TR), map(F,S,Symbols))")); }
    break;

  case 90:
/* Line 1792 of yacc.c  */
#line 455 "parser.y"
    { }
    break;

  case 91:
/* Line 1792 of yacc.c  */
#line 457 "parser.y"
    { CONS (); }
    break;

  case 92:
/* Line 1792 of yacc.c  */
#line 462 "parser.y"
    { TAIL (); }
    break;

  case 93:
/* Line 1792 of yacc.c  */
#line 464 "parser.y"
    { CONS (); }
    break;

  case 94:
/* Line 1792 of yacc.c  */
#line 470 "parser.y"
    { }
    break;

  case 95:
/* Line 1792 of yacc.c  */
#line 472 "parser.y"
    { PUSH (("id('%s')", (yyvsp[(1) - (1)].id))); }
    break;

  case 96:
/* Line 1792 of yacc.c  */
#line 474 "parser.y"
    { BINARY (name); }
    break;

  case 97:
/* Line 1792 of yacc.c  */
#line 476 "parser.y"
    { BINARY (array); }
    break;

  case 98:
/* Line 1792 of yacc.c  */
#line 486 "parser.y"
    { NIL (); }
    break;

  case 99:
/* Line 1792 of yacc.c  */
#line 488 "parser.y"
    { }
    break;

  case 100:
/* Line 1792 of yacc.c  */
#line 493 "parser.y"
    { TAIL (); }
    break;

  case 101:
/* Line 1792 of yacc.c  */
#line 495 "parser.y"
    { TAIL (); }
    break;

  case 102:
/* Line 1792 of yacc.c  */
#line 497 "parser.y"
    { CONS (); }
    break;

  case 103:
/* Line 1792 of yacc.c  */
#line 499 "parser.y"
    { yyerrok; yyclearin;
		  yyerror ("expected a valid statement.");
		  PUSH (("error(stats)")); }
    break;

  case 104:
/* Line 1792 of yacc.c  */
#line 506 "parser.y"
    { }
    break;

  case 105:
/* Line 1792 of yacc.c  */
#line 508 "parser.y"
    { }
    break;

  case 106:
/* Line 1792 of yacc.c  */
#line 510 "parser.y"
    { APT ("E", ("return(E)")); }
    break;

  case 107:
/* Line 1792 of yacc.c  */
#line 512 "parser.y"
    { PUSH (("break(%d)", GUARD(0))); }
    break;

  case 108:
/* Line 1792 of yacc.c  */
#line 514 "parser.y"
    { PUSH (("skip(%d)", GUARD(0))); }
    break;

  case 109:
/* Line 1792 of yacc.c  */
#line 516 "parser.y"
    { PUSH (("retry(%d)", GUARD(0))); }
    break;

  case 110:
/* Line 1792 of yacc.c  */
#line 518 "parser.y"
    { PUSH (("break(%d)", GUARD((yyvsp[(2) - (2)].lit.ival)))); }
    break;

  case 111:
/* Line 1792 of yacc.c  */
#line 520 "parser.y"
    { PUSH (("skip(%d)", GUARD((yyvsp[(2) - (2)].lit.ival)))); }
    break;

  case 112:
/* Line 1792 of yacc.c  */
#line 522 "parser.y"
    { PUSH (("retry(%d)", GUARD((yyvsp[(2) - (2)].lit.ival)))); }
    break;

  case 113:
/* Line 1792 of yacc.c  */
#line 524 "parser.y"
    { ENTER_GUARD(); }
    break;

  case 114:
/* Line 1792 of yacc.c  */
#line 526 "parser.y"
    { APT ("B", ("cond(B, %d)", EXIT_GUARD())); }
    break;

  case 115:
/* Line 1792 of yacc.c  */
#line 528 "parser.y"
    { ENTER_GUARD(); }
    break;

  case 116:
/* Line 1792 of yacc.c  */
#line 530 "parser.y"
    { APT ("B", ("while(B, %d)", EXIT_GUARD())); }
    break;

  case 117:
/* Line 1792 of yacc.c  */
#line 532 "parser.y"
    { }
    break;

  case 118:
/* Line 1792 of yacc.c  */
#line 538 "parser.y"
    { APT ("S,E", ("[clause(E, S)]")); }
    break;

  case 119:
/* Line 1792 of yacc.c  */
#line 540 "parser.y"
    { APT ("Cs,S,E", ("[clause(E, S)|Cs]")); }
    break;

  case 120:
/* Line 1792 of yacc.c  */
#line 542 "parser.y"
    { APT ("ES,S,E", ("[clause(E, S),else(ES)]")); }
    break;

  case 121:
/* Line 1792 of yacc.c  */
#line 544 "parser.y"
    { yyerrok; yyclearin;
		  yyerror ("syntax error in guarded clause.");
		  PUSH (("error(clause)")); }
    break;

  case 122:
/* Line 1792 of yacc.c  */
#line 551 "parser.y"
    { BINARY (assign); }
    break;

  case 123:
/* Line 1792 of yacc.c  */
#line 553 "parser.y"
    { NIL (); BINARY (map); }
    break;

  case 124:
/* Line 1792 of yacc.c  */
#line 555 "parser.y"
    { BINARY (map); }
    break;

  case 125:
/* Line 1792 of yacc.c  */
#line 557 "parser.y"
    { NIL (); UNARY (recurse); }
    break;

  case 126:
/* Line 1792 of yacc.c  */
#line 559 "parser.y"
    { UNARY (recurse); }
    break;


/* Line 1792 of yacc.c  */
#line 2440 "parser.tab.c"
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


/* Line 2055 of yacc.c  */
#line 562 "parser.y"


yyerror(s)
    char *s;
{
    if (strcmp(s, "syntax error")) {
	fprintf (stderr, "%s\n", s);
    }
}
