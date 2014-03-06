_divert_(-1)  // -- For Emacs: this is -*-C-*- code. --------------------------

NOTE: diversions used:
  5 -> 

_define_(`_function_info_', `// (declarations for function $1)')

_divert_(0)_dnl_
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
	  _function_info_ (print_int);
	  _function_info_ (print_char);
	  _function_info_ (read_int);
	  _function_info_ (read_char);
	  _function_info_ (halt);
	  _function_info_ (dump_regs);
	  _function_info_ (dump_stack);
	  _function_info_ (stack_trace);
	}
