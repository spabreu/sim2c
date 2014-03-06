divert(-1)
# -----------------------------------------------------------------------------
#
# Make m4 macros less obtrusive.
#
# -----------------------------------------------------------------------------

define(_define_,defn(`define'))undefine(`define')
_define_(_defn_,defn(`defn'))undefine(`defn')
_define_(_undefine_,_defn_(`undefine'))undefine(`undefine')
_define_(_prepend_,`_define_(_$1_,_defn_(`$1'))_undefine_(`$1')')
_prepend_(`builtin')
_prepend_(`changecom')dnl
_prepend_(`changequote')
_prepend_(`debugfile')
_prepend_(`debugmode')
_prepend_(`decr')
_prepend_(`divert')
_prepend_(`divnum')
_prepend_(`dnl')
_prepend_(`dumpdef')
_prepend_(`errprint')
_prepend_(`esyscmd')
_prepend_(`eval')
_prepend_(`format')
_prepend_(`ifdef')
_prepend_(`ifelse')
_prepend_(`include')
_prepend_(`incr')
_prepend_(`index')
_prepend_(`indir')
_prepend_(`len')
_prepend_(`m4exit')
_prepend_(`m4wrap')
_prepend_(`maketemp')
_prepend_(`patsubst')
_prepend_(`popdef')
_prepend_(`pushdef')
_prepend_(`regexp')
_prepend_(`shift')
_prepend_(`sinclude')
_prepend_(`substr')
_prepend_(`syscmd')
_prepend_(`sysval')
_prepend_(`traceoff')
_prepend_(`traceon')
_prepend_(`translit')
_prepend_(`undivert')

# -----------------------------------------------------------------------------

_define_(`_CURPC_', 0)
_define_(`_pc_at_', `P_`'_eval_(_CURPC_+$1)_define_(`_L_'_eval_(_CURPC_+$1))')
_define_(`_np_', `_define_(`_CURPC_',_incr_(_CURPC_))_dnl_
_ifdef_(`_L_'_CURPC_,P_`'_CURPC_:,)')


_define_(`push',  `_np_	M[--SP] = _refto_($1);	// PUSH $1')
_define_(`pop',   `_np_	++SP;				// POP')
_define_(`dup',   `_np_	M[SP-1] = M[SP]; --SP;		// DUP')
_define_(`swap',  `_np_	M[SP-1] = M[SP]; M[SP] = M[SP+1]; M[SP+1]=M[SP-1]; // SWAP')

_define_(`add',   `_np_	M[SP+1] = M[SP+1] + M[SP+0]; ++SP; // ADD')
_define_(`sub',   `_np_	M[SP+1] = M[SP+1] - M[SP+0]; ++SP; // SUB')
_define_(`mul',   `_np_	M[SP+1] = M[SP+1] * M[SP+0]; ++SP; // MUL')
_define_(`div',   `_np_	M[SP+1] = M[SP+1] / M[SP+0]; ++SP; // DIV')
_define_(`mod',   `_np_	M[SP+1] = M[SP+1] % M[SP+0]; ++SP; // MOD')
_define_(`slt',   `_np_	M[SP+1] = M[SP+1] < M[SP+0]; ++SP; // SLT')

_define_(`load',  `_np_	M[SP] = M[M[SP]];		// LOAD')
_define_(`store', `_np_	M[M[SP]] = M[SP+1]; SP += 2;	// STORE')

_define_(`skipz', `_np_	if (! M[SP++]) goto _pc_at_(2);	// SKIPZ')
_define_(`jump',  `_np_	goto * ((void *) M[SP++]);		// JUMP')
_define_(`call',  `_np_	{ void *C = (void *) M[SP]; M[SP]=(int)&&_pc_at_(1); goto *C; } // CALL')

_define_(`local', `_np_	M[SP] = M[SP] + FP;		// LOCAL')
_define_(`stack', `_np_ M[SP] = M[SP] + SP;		// STACK')

_define_(`link',  `_np_	{ int N = M[SP]; M[SP]= FP; FP=SP+1; SP -= N; } // LINK')
_define_(`unlink', `_np_	SP=FP; FP=M[SP-1];		// UNLINK')

_define_(`dup_sr', `_np_	SR = M[SP];			// DUP_SR')
_define_(`push_sr', `_np_	M[--SP] = SR;			// PUSH_SR')

_dnl_ -- labels ---------------------------------------------------------------

_define_(`_refto_', `_dnl_
_ifelse_(_regexp_($1,`^[-0-9]'), 0, `_dnl_
$1', `_dnl_				   -- Numbers go untouched ------------
_ifdef_(`_DATA_'$1,_dnl_
_DATA_`'$1,_dnl_			   -- (known) data labels -------------
(int) &&$1`'_dnl_			   -- code labels ---------------------
)')')

_define_(`label', `_dnl_
_ifelse_(_data_text_,__data__,_dnl_
`    int m_`'$1[0];		// data `label' for "$1"_dnl_
_define_(`_DATA_'$1,`GV_'$1)_global_var_($1)',_dnl_
`$1:')')

_define_(`_ac_',0)
_define_(`_anon_', `_define_(`_ac_',_incr_(_ac_))_format_(`a_%04.4d',_ac_)')

_define_(`_word_',`    int _anon_;_divert_(4)_dnl_
  global.named._format_(`a_%04.4d',_ac_) = _initializer_($1);
_divert_(1)')

_define_(`_def_word_',  `    int m_$1;_dnl_
_divert_(4)  global.named.m_$1 = _initializer_($2);
_define_(`_DATA_'$1,`GV_'$1)_global_var_($1)')

_define_(`_def_space_', `    int m_$1[$2];_dnl_
_divert_(4)  for (i=0; i<$2; ++i) global.named.m_$1[i] = 0;
_global_var_($1)')

_define_(`_initializer_',`_dnl_
_ifelse_(_regexp_($1,`^[-0-9]'), 0, `$1', `GV_`'$1')')

_define_(`_global_var_',`_divert_(3)_dnl_
#define GV_$1 ((int *) &global.named.m_$1 - (int *) &global.named)
_divert_(1)')

_define_(`_data_', `_divert_(1)_define_(`_data_text_', __data__)')
_define_(`_text_', `_divert_(2)_define_(`_data_text_', __text__)')

_define_(`_dumpdata_', `
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
  struct {_dnl_
_undivert_(1)_dnl_
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

_undivert_(3)_dnl_
')
_define_(`_dumptext_', `_dnl_
// == Program =================================================================

int main (int argc, char *argv[])
{
  int i;

// -- Initialization ----------------------------------------------------------
_undivert_(4)_dnl_

// -- Library -----------------------------------------------------------------

_include_(LIBDIR/library.m4)_dnl_

// -- Start execution ---------------------------------------------------------
  M[--SP] = (int) &&L_exit_program; // Save return address for main program
  goto program;			// start kicking...
L_exit_program:			// Return here, and...
  exit (0);			// quit.
  

// -- Instructions ------------------------------------------------------------_dnl_
_undivert_(2)
}
')
_divert_`'_dnl_
