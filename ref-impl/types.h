/*****************************************************************************/
/*      								     */
/*   Projecto de Compiladores ----------------------------------- SPL'87     */
/*      								     */
/*		                                        		     */
/*		        						     */
/*						    Salvador Pinto Abreu     */
/*									     */
/*****************************************************************************/


/*****************************************************************************/
/*									     */
/*                                 Types	    			     */
/*									     */
/*****************************************************************************/

typedef enum { false, true } bool;

typedef union {
    int   ival;
    float rval;
    bool  bval;
    char *sval;
} lit_token;

typedef char *id_token;

typedef long apt_node;

#define UNION_DEFS() \
    lit_token	lit; \
    id_token	id; \
    apt_node	node
