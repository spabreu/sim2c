#include <stdio.h>
#include "types.h"

char *lookup (s)
    register char *s;
{
    register char *p = (char *) malloc (1+strlen(s));
    strcpy (p, s);
    return (p);
}

yywrap ()
{
    return (1);
}

setup_lc()
{}
