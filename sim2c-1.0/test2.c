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
  int mem[0];
  struct {
    int m_display[0];		// data label for "display"
    int a_0001;
    int a_0002;
    int a_0003;
    int m_htop[0];		// data label for "htop"
    int a_0004;
    int m_heap[0];		// data label for "heap"
  } named;
  struct {
    int z_data[DATA_SZ];
    int z_heap[HEAP_SZ];
    int z_stack[STACK_SZ];
  } zone;
} global;

#define M      global.mem
#define DATA   global.zone.z_data
#define HEAP   global.zone.z_heap
#define STACK  global.zone.z_stack

int SP = MEM_SZ;
int FP = 0;
int SR;
void *PC;				// (unused)

// -- Names for global variables ----------------------------------------------

#define GV_display ((int *) &global.named.m_display - (int *) &global.named)
#define GV_htop ((int *) &global.named.m_htop - (int *) &global.named)
#define GV_heap ((int *) &global.named.m_heap - (int *) &global.named)

// == Program =================================================================

int main (int argc, char *argv[])
{
  int i;

// -- Initialization ----------------------------------------------------------
  global.named.a_0001 = 0;
  global.named.a_0002 = 0;
  global.named.a_0003 = 0;
  global.named.a_0004 = GV_heap;

// -- Library -----------------------------------------------------------------

	goto lib_init;			// skip library code!

print_int:				// print_int (int) -> ()
	printf ("%d\n", M[SP+1]);
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
	  printf ("SP = 0x%x (%d)\n", (int) SP, (int) SP);
	  printf ("FP = 0x%x (%d)\n", (int) FP, (int) FP);
	  printf ("SR = 0x%x (%d)\n", (int) SR, (int) SR);
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
  M[--SP] = (int) &&L_exit_program; // Save return address for main program
  goto program;			// start kicking...
L_exit_program:			// Return here, and...
  exit (0);			// quit.
  

// -- Instructions ------------------------------------------------------------
	M[--SP] = (int) &&_let_0;	// PUSH _let_0
	goto * ((void *) M[SP++]);		// JUMP
nfactor_1:
	M[--SP] = 4;	// PUSH 4
	{ int N = M[SP]; M[SP]= FP; FP=SP+1; SP -= N; } // LINK
	M[--SP] = GV_display;	// PUSH display
	M[--SP] = 8;	// PUSH 8
	M[SP+1] = M[SP+1] + M[SP+0]; ++SP; // ADD
	M[SP-1] = M[SP]; --SP;		// DUP
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = -4;	// PUSH -4
	M[SP] = M[SP] + FP;		// LOCAL
	M[M[SP]] = M[SP+1]; SP += 2;	// STORE
	M[--SP] = 0;	// PUSH 0
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP-1] = M[SP]; M[SP] = M[SP+1]; M[SP+1]=M[SP-1]; // SWAP
	M[M[SP]] = M[SP+1]; SP += 2;	// STORE
	M[--SP] = (int) &&_then_1;	// PUSH _then_1
	M[--SP] = (int) &&_neq_3;	// PUSH _neq_3
	M[--SP] = 12;	// PUSH 12
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = 0;	// PUSH 0
	M[SP+1] = M[SP+1] - M[SP+0]; ++SP; // SUB
	if (! M[SP++]) goto P_26;	// SKIPZ
	goto * ((void *) M[SP++]);		// JUMP
P_26:	++SP;				// POP
	M[--SP] = 1;	// PUSH 1
	M[--SP] = (int) &&_fimeq_4;	// PUSH _fimeq_4
	goto * ((void *) M[SP++]);		// JUMP
_neq_3:
	M[--SP] = 0;	// PUSH 0
_fimeq_4:
	if (! M[SP++]) goto P_33;	// SKIPZ
	goto * ((void *) M[SP++]);		// JUMP
P_33:	++SP;				// POP
	M[--SP] = 12;	// PUSH 12
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = 12;	// PUSH 12
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = 1;	// PUSH 1
	M[SP+1] = M[SP+1] - M[SP+0]; ++SP; // SUB
	M[SP-1] = M[SP]; --SP;		// DUP
	M[--SP] = (int) &&nfactor_1;	// PUSH nfactor_1
	{ void *C = (void *) M[SP]; M[SP]=(int)&&P_45; goto *C; } // CALL
P_45:	M[SP-1] = M[SP]; M[SP] = M[SP+1]; M[SP+1]=M[SP-1]; // SWAP
	++SP;				// POP
	M[SP+1] = M[SP+1] * M[SP+0]; ++SP; // MUL
	M[--SP] = (int) &&_fimif_2;	// PUSH _fimif_2
	goto * ((void *) M[SP++]);		// JUMP
_then_1:
	M[--SP] = 1;	// PUSH 1
_fimif_2:
	M[--SP] = 8;	// PUSH 8
	M[SP] = M[SP] + FP;		// LOCAL
	M[M[SP]] = M[SP+1]; SP += 2;	// STORE
	M[--SP] = -4;	// PUSH -4
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = GV_display;	// PUSH display
	M[--SP] = 8;	// PUSH 8
	M[SP+1] = M[SP+1] + M[SP+0]; ++SP; // ADD
	M[M[SP]] = M[SP+1]; SP += 2;	// STORE
	SP=FP; FP=M[SP-1];		// UNLINK
	goto * ((void *) M[SP++]);		// JUMP
_let_0:
	M[--SP] = 0;	// PUSH 0
	M[--SP] = 4;	// PUSH 4
	{ int N = M[SP]; M[SP]= FP; FP=SP+1; SP -= N; } // LINK
	M[--SP] = GV_display;	// PUSH display
	M[--SP] = 4;	// PUSH 4
	M[SP+1] = M[SP+1] + M[SP+0]; ++SP; // ADD
	M[SP-1] = M[SP]; --SP;		// DUP
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = -4;	// PUSH -4
	M[SP] = M[SP] + FP;		// LOCAL
	M[M[SP]] = M[SP+1]; SP += 2;	// STORE
	M[--SP] = 0;	// PUSH 0
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP-1] = M[SP]; M[SP] = M[SP+1]; M[SP+1]=M[SP-1]; // SWAP
	M[M[SP]] = M[SP+1]; SP += 2;	// STORE
	M[--SP] = 10;	// PUSH 10
	M[SP-1] = M[SP]; --SP;		// DUP
	M[--SP] = (int) &&nfactor_1;	// PUSH nfactor_1
	{ void *C = (void *) M[SP]; M[SP]=(int)&&P_82; goto *C; } // CALL
P_82:	M[SP-1] = M[SP]; M[SP] = M[SP+1]; M[SP+1]=M[SP-1]; // SWAP
	++SP;				// POP
	M[--SP] = 4;	// PUSH 4
	M[SP] = M[SP] + FP;		// LOCAL
	M[M[SP]] = M[SP+1]; SP += 2;	// STORE
	M[--SP] = -4;	// PUSH -4
	M[SP] = M[SP] + FP;		// LOCAL
	M[SP] = M[M[SP]];		// LOAD
	M[--SP] = GV_display;	// PUSH display
	M[--SP] = 4;	// PUSH 4
	M[SP+1] = M[SP+1] + M[SP+0]; ++SP; // ADD
	M[M[SP]] = M[SP+1]; SP += 2;	// STORE
	SP=FP; FP=M[SP-1];		// UNLINK

}

