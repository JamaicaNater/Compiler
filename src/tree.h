#ifndef TREE_H
#define TREE_H

#define TREENODE_MAX_CHILDREN 12

typedef struct treenode tree;

typedef struct reg_val {
    int index;
    int offset;
} reg_val;


/* tree node - you may need to add more fields or change this file however you see fit. */
struct treenode {
    int node_kind;
    int num_children;
    int val;
    tree *parent;
    tree *children[TREENODE_MAX_CHILDREN];
};

/* builds sub tree with zeor children  */
tree *make_tree(int kind);

/* builds sub tree with leaf node. Leaf nodes typically hold a value. */
tree *make_tree_with_val(int kind, int val);

/* assigns the subtree rooted at 'child' as a child of the subtree rooted at 'parent'. Also assigns the 'parent' node as the 'child->parent'. */
void add_child(tree *parent, tree *child);

// prints the ast recursively starting from the root of the ast. 
void print_ast(tree *root, int nestLevel);

void assemble(tree * node, int * reg_no);

int asm_expr(tree * node, int * dest_reg_no);

int get_array_val(tree * array);

int get_offset(tree * node);

#endif
