/* solution of fast growing recursive function ackerman(mc,nc) */

#include <stdio.h>

#define MC 3
#define NC 8

int Ack (m, n)
{
    if      (m == 0) return (n+1);
    else if (n == 0) return (Ack (m-1, 1));
    else	     return (Ack (m-1, Ack (m, n-1)));
}

main()
{
    printf ("%d\n", Ack (MC, NC));
}
