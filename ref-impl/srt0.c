/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ---------------------------------- VSPL        */
/*		                                        	 Level 0     */
/*		                                        		     */
/*   VSPL run-time library (C part).					     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/

main (argc, argv)
    int argc;
    char *argv[];
{
    sspl_main();
}


int writeInt(i)
    int i;
{
    printf("%d", i);
}

int writeReal(f)
    float f;
{
    printf ("%g", f);
}

int writeBool(i)
    int i;
{
    printf (i? "true": "false");
}

int writeChar (c)
    int c;
{
    putchar (c);
}

void writeString (l, p)
    register int l;
    register char *p;
{
    while (l-- > 0)
	putchar (*p++);
}


/* INPUT */

int readInt()
{
    char line[128];
    int i;

    do {
	gets(line);
	if (sscanf(line, "%d", &i))
	    return (i);
	printf ("integer expected -- retry.\n");
    } while (1);
}

float readReal()
{
    char line[128];
    float i;

    do {
	gets(line);
	if (sscanf(line, "%g", &i))
	    return (i);
	printf ("real expected -- retry.\n");
    } while (1);
}

int readBool()
{
    int i;
    char line[128];
    char s[100];

    do {
	gets(line);
	sscanf(line, "%s", s);
	if (!strcmp(s,"true"))
	    return (1);
	else if (!strcmp(s,"false"))
	    return (0);
	printf ("boolean expected -- retry.\n");
    } while (1);
}

void readString (l, s)
    register short *l;
    register char *s;
{
    if (gets(s))
	*l = strlen(s);
    else
	*l = 0;
}
