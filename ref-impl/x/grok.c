#include <stdio.h>

float fact (n, v)
	register int n, *v;
{
	if (n < 2) return;
	*v *= n;
	fact (n-1, v);
}

main (argc, argv)
	int argc;
	char *argv[];
{
	int v;
	fact (atoi (argv[1]), &v);
	printf ("%d\n", v);
}
