#include <stdio.h>
#include <ctype.h>

#define PARSER "y.tab.h"
#define MAX_LEN 10

#include "types.h"
#include "y.tab.h"

YYSTYPE yylval;
extern char yytext[];

char *pname = PARSER;
int max_len = MAX_LEN;

FILE *parser;

char *def[512];

main (argc, argv)
    int argc;
    char *argv[];
{
    register int i, t;
    char name[128];
    int value;

    for (i=1; i<argc; i++) {
	if (argv[i][0] == '-') {
	    switch (argv[i][1]) {
	      case 'l': max_len = atoi(argv[++i]); break;
	      case 'p': pname = argv[++i]; break;
	      default:
		fprintf (stderr, "usage: tokenize [-l len] [-p parser]\n");
		exit(1);
	    }
	}
	else {
	    fprintf (stderr, "usage: tokenize [-l len] [-p parser]\n");
	    exit (1);
	}
    }

    for (i=0; i<512; i++)
	def[i] = (char *) NULL;

    if ((parser = fopen (pname, "r")) == NULL) {
	perror (pname);
	exit (1);
    }

    while (getc(parser) != '#')
	;
    ungetc ('#', parser);

    while (fscanf (parser, "# define %s %d\n", name, &value) == 2) {
	def[value] = (char *) malloc (1+strlen(name));
	strcpy (def[value], name);
    }

    while ((t = yylex()) > 0) {
	if (strlen(yytext) > max_len)
	    printf ("%*.*s... ", max_len-3, max_len-3, yytext);
	else
	    printf ("%*s ", max_len, yytext);
	if (def[t])
	    printf ("<%s", def[t]);
	else if (isprint (t))
	    printf ("<'%c'", t);
	else
	    printf ("<'\\%03.3o'", t);
	switch (t) {
	  case INT_LIT:  printf (", %d", yylval.lit.ival); break;
	  case REAL_LIT: printf (", %g", yylval.lit.rval); break;
	  case BOOL_LIT: printf (", %d", yylval.lit.bval); break;
	  case STRING_LIT: printf (", '%s'", yylval.lit.sval); break;
	  case ID:       printf (", %s", yylval.id); break;
	  default: ;
	}
	printf (">\n");
    }
}
