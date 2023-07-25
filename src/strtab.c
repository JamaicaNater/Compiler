#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"strtab.h"
#include<assert.h>

extern int yylineno;


/* The symbolTable, which will be implemented as a hash table. */
struct strEntry strTable[MAXIDS];

// hash function for the symbol table
unsigned long hash(unsigned char *str)
{
    unsigned long hash = 5381;

    int c;

    while (c = *str++)
        hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
    return hash;
}

// function that inserts variables and function names into the symbol table.
int ST_insert(char *id, char *scope, int data_type, int symbol_type, tree* treeptr){
    char rawhash[1000];
    strcpy(rawhash, id);
	strcat(rawhash, scope);
    unsigned long index = hash(rawhash);
    //this checks to see if the variable is already within the symbol table
    if (ST_lookup(id, scope) != -1)
        return -1;
    
    //this goes through the symbol table to find the next empty spot to insert, implementation of linear probing
    int checks = 0;
    int flag = 0;
    while (checks <= MAXIDS && flag == 0){
        if (strlen(strTable[(index + checks) % MAXIDS].id) == 0) {
            index = index + checks;
            flag = 1;
        }
        checks++;
    }
    
    //this is where the symbol table slot is updated with the info passed to ST_insert
    strcpy(strTable[index % MAXIDS].id, id);
	strcpy(strTable[index % MAXIDS].scope, scope);
	strTable[index % MAXIDS].symbol_type = symbol_type;
	strTable[index % MAXIDS].data_type = data_type;
    strTable[index % MAXIDS].treeptr = treeptr;
    strTable[index % MAXIDS].calls = 0;
    strTable[index % MAXIDS].reg = -1;
    strTable[index % MAXIDS].mempos = -1;
    

	//this returns the index value for the symbol table to be stored in the syntax tree
	int returnValue = index % MAXIDS;
    return returnValue;
    
}

// function that looks in the symbol table to see if there is anything there
int ST_lookup(char *id, char *scope) {
    char rawhash[1000];
    strcpy(rawhash, id);
	strcat(rawhash, scope);
    unsigned long index = hash(rawhash);

	//this goes through the symbol table starting at the hashed value to see if there is anything there, and to see if it matches what was sent to the function
    int checks = 0;
    while (strlen(strTable[(index + checks) % MAXIDS].id) != 0){
        if (strcmp(strTable[(index + checks) % MAXIDS].id, id) == 0 && strcmp(strTable[(index + checks) % MAXIDS].scope, scope) == 0){
        	//if the value does exist we return it's index
            return ((index + checks) % MAXIDS);
    	}
    	checks++;
    }
    // If the value doesn't exist we return -1
    return -1;
}
/*
    Prints everthing in the symbool table including funtion argumnets if applicable
*/
void ST_print() {
    for (int i = 0; i < MAXIDS; i++) {
        if (strlen(strTable[i].id) == 0) {
            continue;
        }

        char * data_type = malloc(10);
        char * symbol_type = malloc(10);

        int raw_data_type = strTable[i].data_type;
        int raw_symbol_type = strTable[i].symbol_type;

        data_type = "error";
        if (raw_data_type == INT_TYPE)
            data_type = "int";
        if (raw_data_type == CHAR_TYPE)
            data_type = "char";
        if (raw_data_type == VOID_TYPE)
            data_type = "void";
        
        symbol_type = "error";
        if (raw_symbol_type == SCALAR)
            symbol_type = "scalar"; 
        if (raw_symbol_type == ARRAY)
            symbol_type = "array";
        if (raw_symbol_type == FUNCTION)
            symbol_type = "function";
        
        int count = 0;
        tree * function_args[12];
        if (raw_symbol_type == FUNCTION) { 
            get_children(function_args, strTable[i].treeptr, FORMALDECL, &count);      
        }

        for(int i = 0; i < count; i++) {
            if (i == 0 )
                printf("Function Arguments \n");

            print_ast(function_args[i], 1);
        }

        printf("id: %s, scope: %s, data type: %s, symbol type: %s\n", strTable[i].id, strTable[i].scope, data_type, symbol_type);
    }
}

// Utilities //
/*
    If a variable does exits in the cuurent scope move up and check the global scope
*/
int super_ST_lookup (char * id, char * scopeName) {
    int index;
    index = ST_lookup(id, scopeName);
    if (index != -1)
        return index;

    index = ST_lookup(id, "global");
    if (index != -1)
        return index;

    return -1;
}

/*
    Takes two funtions and compares them 

    return -2 for type mismatch
    return -1 for too few argumnets passed 
    return 0 for funtion match
    return 1 for to many arguments passed
*/
int function_compare (tree* original, tree* given) {
    struct treenode * function_arguments[MAXCHILDREN];
    struct treenode * passed_arguments[MAXCHILDREN];

    int exclusions[1] = {ARRAYSIZE};
    int num_exclusions = 1;

    // get all arguments of funtion
    int arg_count = 0;
    get_children(function_arguments, original, FORMALDECL, &arg_count);
    int passed_count = 0;
    get_children_and_exclude(passed_arguments, given, VAR, &passed_count, exclusions, num_exclusions);
    get_children_and_exclude(passed_arguments, given, CHAR, &passed_count, exclusions, num_exclusions);
    get_children_and_exclude(passed_arguments, given, INT, &passed_count, exclusions, num_exclusions);

    if (arg_count > passed_count) {
        return -1;
    }
    if (arg_count < passed_count) {
        return 1;
    }

    for (int i = 0; i < arg_count; i++){
        if (get_type(function_arguments[i]) != get_type(passed_arguments[i]))
            return -2;
        if (is_array(function_arguments[i]) != is_array(passed_arguments[i]))
            return -2;
    }

    return 0;
}

/*
    All child of a kind for a given node
    ex if we want to find all the fundecls in a program node this is the funtion to do it
*/
void get_children(tree* childlist[], tree* node, int node_kind, int * index) {
    if (node == NULL)
        return;

    if (node->node_kind == node_kind){
        childlist[*index] = node;
        (*index)++;
        return;
    }
    for (int i = 0; i < node->num_children; i++) {
        get_children(childlist, node->children[i], node_kind, index);
    }
}

void get_children_and_exclude(tree* childlist[], tree* node, int node_kind, int * index, int exclusions[], int num_exclusions) {
    if (node == NULL)
        return;

    for (int i = 0; i < num_exclusions; i++) {
        if (node->node_kind == exclusions[i]) return;
    }

    if (node->node_kind == node_kind){
        childlist[*index] = node;
        (*index)++;
        return;
    }
    for (int i = 0; i < node->num_children; i++) {
        get_children_and_exclude(childlist, node->children[i], node_kind, index, exclusions, num_exclusions);
    }
}

int count_children(tree* node, int node_kind) {
    int index = 0;
    struct treenode * children[MAXCHILDREN];
    get_children(children, node, node_kind, &index);
    return index;
}

/*
    Says whether or not a tree is an array

    return 0 if its not.
    return 1 if it is.
*/
int is_array(tree* treeptr) {
    if (treeptr->node_kind != VAR && treeptr->node_kind != FORMALDECL && treeptr->node_kind != IDENTIFIER){
        //printf("Warning: behavoir of is_array is undefined for nodes not of type VAR and FORMALDECL or IDENTIFIER type give is : %d", tree->node_kind);
    }

    struct treenode *node = (struct treenode *)malloc(sizeof(struct treenode));
    node = treeptr;
    
    int num_identifiers = 0;
    struct treenode * ids[MAXCHILDREN];
    get_children(ids, treeptr, IDENTIFIER, &num_identifiers);
    assert(num_identifiers <= 1);

    if (num_identifiers == 1) {
        node = strTable[ids[0]->val].treeptr;
    }

    int count = 0;
    struct treenode * children[MAXCHILDREN];
    get_children(children, node, ARRAYSIZE, &count);
    assert(count <= 1);

    // if (count){
    //     if (children[0]->children[0]->node_kind == ADDEXPR) return 0; // arr[22] should return false
    // }

    return (count > 0);
}

/*
    Given an arithmatic expresion this funtion returns the type of that expression
*/
int get_type(tree * node) {
    struct treenode * factors[MAXCHILDREN];
    int count = 0;
    int expr_type = 0;
        
    //gett and the child nodes of type char int and identifier
    get_children(factors, node, IDENTIFIER, &count);
    get_children(factors, node, INT, &count);
    get_children(factors, node, CHAR, &count);

    for(int i = 0; i < count; i++) {
        int type;
        if (factors[i]->node_kind != IDENTIFIER) {
            type = factors[i]->node_kind;
            
            switch(type) {
                case INT:
                    type = INT_TYPE;
                    break;
                case CHAR:
                    type = CHAR_TYPE;
                    break;
                deafult:
                    type = 9999;
            }
        } else {
            type = strTable[factors[i]->val].treeptr->children[0]->val;
        }
        // set stype for the first time
        if (expr_type == 0){
            expr_type = type;
        } else if (expr_type == VOID_TYPE) { // once a type is void we will never change it 
            if (type == CHAR_TYPE){
                
            }
            if (type == INT_TYPE){
                
            }
        } else if (expr_type == CHAR_TYPE) { //if a type is char and a int does anything to it, it is an int
            if (type == VOID_TYPE){
                expr_type = VOID_TYPE;
            }
            if (type == INT_TYPE){
                expr_type = INT_TYPE;
            }
        } else if (expr_type == INT_TYPE) { // if a void does any operation on an int it becomes itself a void
            if (type == VOID_TYPE){
                expr_type = VOID_TYPE;
            }
            if (type == CHAR_TYPE){

            }
        }
    }

    return expr_type;
}

/*
    Given an array node this checks to see if the index is in bound 

    return 0 for out of bounds
    1 for in bound
*/
int index_in_bounds(tree * array, int requested_bounds) {
    int array_size = get_array_val(array);

    if (array_size == 0){ // We dont bounds check with fundeclarrays
        return 1;
    }

    if (requested_bounds < 0) {
        return 0;
    }

    return (requested_bounds < array_size);
}

int operate (int left, int right, int op) {
    int result;
    switch (op) {
        case ADD:
            result = left + right;
            break;
        case SUB:
            result = left - right;
            break;
        case MUL:
            result = left * right;
            break;
        case DIV:
            result = left / right;
            break;
        case LTE:
            result = left <= right;
            break;
        case LT:
            result = left < right;
            break;
        case GTE:
            result = left >= right;
            break;
        case GT:
            result = left > right;
            break;
        case EQ:
            result = left == right;
            break;
        case NEQ:
            result = left != right;
            break;
    }
    return result;
}

/*
    Given a node that contains a expresion int the form 3*5+4-3
    this funtions factorizes it to get the right answer
*/
int factorize(tree* node) {
    int left, right, result;
    switch(node->node_kind) {
        case MULOP:
        case ADDOP:
        case RELOP:
            left = factorize(node->children[0]);
            right = factorize(node->children[1]);
            result = operate(left, right, node->val);
            break;
        case INT:
            result = node->val;
            break;
        default:
            for (int i = 0; i < node->num_children; i++){
                assert(node->num_children == 1 || node->num_children == 0);
                result =  factorize(node->children[i]);
            }
            break;
    }
    return result;
}

int is_global(int index) {
    if (strcmp(strTable[index].scope, "global") == 0){
        return 1;
    } else {
        return 0;
    }
}

int make_function(int func_type, char * func_name, int arg_type, char * arg_name, char * scope) {
    int varpos = ST_insert(arg_name, func_name, arg_type, SCALAR, NULL);

    int pos = ST_insert(func_name, "global", func_type, FUNCTION, NULL);
    struct treenode * outputNode = make_tree(FUNDECL);
    add_child(outputNode, make_tree_with_val(TYPESPECIFIER, func_type));
    add_child(outputNode, make_tree_with_val(IDENTIFIER, pos));
    add_child(outputNode, make_tree(FORMALDECLLIST));
    if (arg_type != 0) {
        add_child(outputNode->children[2], make_tree(FORMALDECL));
        add_child(outputNode->children[2]->children[0], make_tree_with_val(TYPESPECIFIER, arg_type));
        add_child(outputNode->children[2]->children[0], make_tree_with_val(IDENTIFIER, varpos));
    }
    
    strTable[varpos].treeptr = outputNode->children[2]->children[0];
    strTable[pos].treeptr = outputNode;  

    return pos;
}