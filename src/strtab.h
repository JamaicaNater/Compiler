#include "tree.h"
#ifndef STRTAB_H
#define STRTAB_H
#define MAXIDS 1000

/* This data structure describes each element of the symbol table. */

// strEntry contains info on fucntion/ variable infomation in the form of the varible untility funtion
struct strEntry{
    char id[20];
    char scope[20];
    int   data_type;
    int   symbol_type;
    tree* treeptr;
    int   mempos;
    int   reg;
    int   calls;
};


//int num_entries = 0;

unsigned long hash(unsigned char *str);

/* id is a lexeme, scope is the scope of the symbol table, data_type is the data type of the lexeme, and symbol_type is one of the elements of symbolType declared in strtab.h. ST_insert should be called from the parser.y file whenever a scalar, array, or function is declared. Note that these types are declared above in symbolType enum. Hint: refer to the production rules varDecl and formalDecl. If you remove left recursion or apply left factoring, you may need to call ST_insert in other places as well. */
int ST_insert(char *id, char *scope, int data_type, int symbol_type, tree* treeptr);


/* ST_lookup should be called from the parser.y file whenever a reference to variable (id or array) or function call is made. Hint: refer to the production rules VAR and funcCallExpr. */
int ST_lookup(char *id, char *scope);

void ST_print();

int super_ST_lookup(char * id, char * scopeName);

int function_compare (tree* original, tree* given);

void get_children(tree* childlist[], tree* node, int node_kind, int * index);

void get_children_and_exclude(tree* childlist[], tree* node, int node_kind, int * index, int exclusions[], int num_exclusions);

int count_children(tree* node, int node_kind);

int is_array(tree* tree);

int get_type(tree * tree);

int index_in_bounds(tree * array, int requested_bounds);

int factorize(tree* node);

int is_global(int index);

int make_function(int func_type, char * func_name, int arg_type, char * arg_name, char * scope);
#endif
