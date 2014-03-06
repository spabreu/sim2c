#include <stdio.h>

// == Global data =============================================================

#define W  * 4
#define KB * 1024
#define MB KB KB

#define DATA_SZ   1 MB
#define HEAP_SZ   1 MB
#define STACK_SZ  1 MB

#define MEM_SZ ((DATA_SZ) + (HEAP_SZ) + (STACK_SZ))

union {
  long mem[0];
  struct {
    long m_x;
    long m_xpto[20];
  } named;
  struct {
    long z_data[DATA_SZ];
    long z_heap[HEAP_SZ];
    long z_stack[STACK_SZ];
  } zone;
} global;

#define M      global.mem
#define DATA   global.zone.z_data
#define HEAP   global.zone.z_heap
#define STACK  global.zone.z_stack

long SP = MEM_SZ;
long FP = 0;
long SR;
void *PC;				// (unused)

// -- Names for global variables ----------------------------------------------

#define GV_x ((long *) &global.named.m_x - (long *) &global.named)
#define GV_xpto ((long *) &global.named.m_xpto - (long *) &global.named)

// == Program =================================================================

int main (int argc, char *argv[])
{
  long i;

// -- Initialization ----------------------------------------------------------
  global.named.m_x = 123;
  for (i=0; i<20; ++i) global.named.m_xpto[i] = 0;

// -- Library -----------------------------------------------------------------

	goto lib_init;			// skip library code!

print_int:				// print_int (int) -> ()
	printf ("%ld\n", M[SP+1]);
	goto * ((void *) M[SP++]);

print_char:				// print_char (int) -> ()
	putchar (M[SP+1]);
	goto * ((void *) M[SP++]);

read_int:				// read_int () -> int
	scanf ("%d", &M[SP+1]);
	goto * ((void *) M[SP++]);

read_char:				// read_char () -> int
	M[SP+1] = getchar ();
	goto * ((void *) M[SP++]);

halt:					// halt () -> ()
	return 0;

dump_regs:				// dump_regs () -> ()
	{
	  printf ("-- Register dump --\n");
	  printf ("SP = 0x%x (%d)\n", (long) SP, (long) SP);
	  printf ("FP = 0x%x (%d)\n", (long) FP, (long) FP);
	  printf ("SR = 0x%x (%d)\n", (long) SR, (long) SR);
	  printf ("PC = (unused)\n");
	}
	goto * ((void *) M[SP++]);

dump_stack:				// dump_stack () -> ()
	{
	  printf ("-- Stack dump --\n");
	}
	goto * ((void *) M[SP++]);

stack_trace:				// stack_trace () -> ()
	{
	  printf ("-- Stack trace --\n");
	}
	goto * ((void *) M[SP++]);

lib_init:
	{
	  // (declarations for function ) (print_int);
	  // (declarations for function ) (print_char);
	  // (declarations for function ) (read_int);
	  // (declarations for function ) (read_char);
	  // (declarations for function ) (halt);
	  // (declarations for function ) (dump_regs);
	  // (declarations for function ) (dump_stack);
	  // (declarations for function ) (stack_trace);
	}

// -- Start execution ---------------------------------------------------------
  M[--SP] = (long) &&L_exit_program; // Save return address for main program
  goto program;			// start kicking...
L_exit_program:			// Return here, and...
  exit (0);			// quit.
  

// -- Instructions ------------------------------------------------------------
program:
	M[--SP] = 0;	// PUSH 0
	{ long N = M[SP]; M[SP]= FP; FP=SP+1; SP -= N; } // LINK
	M[--SP] = 12;	// PUSH 12
	M[--SP] = (long) &&print_int;	// PUSH print_int
	{ void *C = (void *) M[SP]; M[SP]=(long)&&P_6; goto *C; } // CALL
P_6:	SP=FP; FP=M[SP-1];		// UNLINK
	goto * ((void *) M[SP++]);		// JUMP

}

