#ifndef TREE_H
#define TREE_H

#define MAXCHILDREN 12

typedef struct treenode tree;

typedef struct reg_val {
    int index;
    int offset;
} reg_val;

enum nodeTypes {PROGRAM, DECLLIST, DECL, VARDECL, LOCALVARDECL,
				TYPESPECIFIER, FUNDECL, FORMALDECLLIST, FORMALDECL, FUNBODY,
				LOCALDECLLIST, STATEMENTLIST, STATEMENT, COMPOUNDSTMT, ASSIGNSTMT,
		        CONDSTMT, LOOPSTMT, RETURNSTMT, VAR, EXPRESSION, RELOP,
		        ADDEXPR, ADDOP, TERM, MULOP, FACTOR, FUNCCALLEXPR, ARGLIST, IDENTIFIER, SCALAR, ARRAY, FUNCTION,
				IFDECL, ELSEDECL, INT, CHAR, STR, ADD, SUB, MUL, DIV, LTE, LT, GT, GTE, EQ, NEQ, 
				INT_TYPE, CHAR_TYPE, VOID_TYPE, ARRAYSIZE};

enum reg_types { zero, at, v0, v1, a0, a1, a2, a3, t0, t1, t2, t3, t4, t5, t6, t7, 
                s0, s1, s2, s3, s4, s5, s6, s7, t8, t9, k0, k1, gp, sp, fp, ra};


/* tree node - you may need to add more fields or change this file however you see fit. */
struct treenode {
    int node_kind;
    int num_children;
    int val;
    tree *parent;
    tree *children[MAXCHILDREN];
};

/* builds sub tree with zeor children  */
tree *maketree(int kind);

/* builds sub tree with leaf node. Leaf nodes typically hold a value. */
tree *maketreeWithVal(int kind, int val);

/* assigns the subtree rooted at 'child' as a child of the subtree rooted at 'parent'. Also assigns the 'parent' node as the 'child->parent'. */
void addChild(tree *parent, tree *child);

// prints the ast recursively starting from the root of the ast. 
void printAst(tree *root, int nestLevel);

void assemble(tree * node, int * reg_no);

int get_and_update_mempos(int index);

int get_next_temp();

int * get_and_update_reg(int index, int offset, int * needs_load);

int asm_expr(tree * node, int * dest_reg_no);

int * load_val(int index, int offset);

void store_val(int index, int offset);

void emit_pre_instructions();

void emit_post_instructions();

int get_array_val(tree * array);

int get_offset(tree * node);

#endif
