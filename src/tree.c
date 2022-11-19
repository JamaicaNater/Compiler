#include"tree.h"
#include<strtab.h>
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<assert.h>

#define MAX_EXTERNS 15

tree * ast;

extern int yylineno;
extern int yyerror(char * msg);
extern struct strEntry strTable[MAXIDS];

char asm_scope[20];

char extern_fuctions[MAX_EXTERNS][256] = {  "initoutput:\n"
                                            "\taddi $sp, $sp, -36\n"
                                            "\tlw $a0, 0($sp)\n"
                                            "\tli $v0, 1\n"
                                            "\tsyscall\n"
                                            "\taddi $sp, $sp, 36\n"
                                            "\tjr $ra\n",
                                            
                                            "initoutputchar:\n"
                                            "\taddi $sp, $sp, -36\n"
                                            "\tlw $a0, 0($sp)\n"
                                            "\tli $v0, 11\n"
                                            "\tsyscall\n"
                                            "\taddi $sp, $sp, 36\n"
                                            "\tjr $ra\n"

                                            "initoutputhexaschar:\n"
                                            "\taddi $sp, $sp, -36\n"
                                            "\tlw $a0, 0($sp)\n"
                                            "\tli $v0, 11\n"
                                            "\tsyscall\n"
                                            "\taddi $sp, $sp, 36\n"
                                            "\tjr $ra\n" ,

                                            "initinputchar:\n"
                                            "\taddi $sp, $sp, -36\n"
                                            "\tli $v0, 12\n"
                                            "\tsyscall\n"
                                            "\taddi $sp, $sp, 36\n"
                                            "\tjr $ra\n",

                                            "initinputint:\n"
                                            "\taddi $sp, $sp, -36\n"
                                            "\tli $v0, 5\n"
                                            "\tsyscall\n"
                                            "\taddi $sp, $sp, 36\n"
                                            "\tjr $ra\n"                                         
                                            };

FILE * fileptr = NULL;

char *node_names[70] = {"program", "declList", "decl", "varDecl", "localVarDecl", "typeSpecifier",
                      "funDecl", "formalDeclList", "formalDecl", "funBody",
                      "localDeclList", "statementList", "statement", "compoundStmt",
                      "assignStmt", "condStmt", "loopStmt", "returnStmt", "var",
                      "expression", "relop", "addExpr", "addop", "term", "mulop",
                      "factor", "funcCallExpr", "argList", "identifier",
                      "scalar", "array", "function", "if", "else", "integer", "character", 
					  "string", "+", "-", "*", "/", "<=", "<", ">", ">=", "==", "!=", "int", "char", "void", "array size"};

char * reg_names[32] = {"$zero", "$at", "$v0", "$v1", "$a0", "$a1", "$a2", "$a3", "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7", 
                        "$s0", "$s1", "$s2", "$s3", "$s4", "$s5", "$s6", "$s7", "$t8", "$t9", "$k0", "$k1", "$gp", "$sp", "$fp", "$ra"};

struct reg_val reg_map[32] = {[0 ... 28] = {-1,0}, [29 ... 31] = {0,0}};

struct treenode * funtionNode;
int globalptr = 0;
int vars_declared = 0;
int num_ifs = 0;
int num_whiles = 0;

/* builds sub tree with zeor children  */
tree *maketree(int kind) {
    struct treenode *node = (struct treenode *)malloc(sizeof(tree));
    node->parent = NULL;

    node->num_children = 0;
    node->node_kind = kind;

    return node;
}

/* builds sub tree with leaf node. Leaf nodes typically hold a value. */
tree *maketreeWithVal(int kind, int val) {
    struct treenode *node = (struct treenode *)malloc(sizeof(tree));
    node->parent = NULL;

    node->num_children = 0;
    node->val = val;
    node->node_kind = kind;

    return node;
}

/* assigns the subtree rooted at 'child' as a child of the subtree rooted at 'parent'. Also assigns the 'parent' node as the 'child->parent'. */
void addChild(tree *parent, tree *child) {
    if (parent->num_children + 1 > 12){
        printf("ERROR: max children exceeded");
        return;
    }

    parent->children[parent->num_children] = child;
    child->parent = parent;
    parent->num_children++;
}

// prints the ast recursively starting from the root of the ast.
void printAst(tree *node, int nestLevel){
   
   	int i, j,value;
   
   	//This prints the knid of the node
	printf("%s", node_names[node->node_kind]);
	
	//This section prints any extra information if needed
	
	//Extra information for identifiers, plus checks for whether the vairable was declared or not and displays a warning
    if(node->node_kind == IDENTIFIER){
    	int index = node->val;
    	if(index != -1){
    		printf(", %s", strTable[(node->val)].id);
		}else{
			printf(", Warning: Variable / Function name never declared");
		}
	}
	//Extra information for type specifiers, data types, operators
	if(node->node_kind == TYPESPECIFIER){
		printf(", %s", node_names[node->val]);
	}
	if(node->node_kind == INT){
		printf(", %d", node->val);
	}
	if(node->node_kind == CHAR){
		printf(", %c", node->val);
	}
	if(node->node_kind == STR){
		printf(", %s", node->val);
	}
	if(node->node_kind == ARRAYSIZE){
		printf(", %d", node->val);
	}
	if(node->node_kind == ADDOP){
		printf (", %s", node_names[node->val]);
	}
	if(node->node_kind == MULOP){
		printf (", %s", node_names[node->val]);	
	}
	if(node->node_kind == RELOP){
		printf (", %s", node_names[node->val]);	
	}
    printf(" %#010x", node);
	
	printf("\n");
	
	//Controls the spacing of the output as well as the recursive calling of the print function
    for (i = 0; i < node->num_children; i++) 
    {
        for (j = 0; j < nestLevel; j++){
            printf("  ");
        }
        printAst (node->children[i], nestLevel + 1);
    	
    }
}

/*
    Funtion to print all assemble intructions for a given AST, this funtion takes inspiration from the the Print ast funtion.
    The funtion calls it self recursivly and only prints relevant instrctions.
    The funtion containes a handled flag, if that flag is set the program doesnt continue to handle the children of the node.
*/
void assemble(tree * node, int * reg_no) {
    if (fileptr == NULL) {
        fileptr = fopen("asm.asm", "w");
        fprintf(fileptr,    ".text\n"
                            "\tmove $fp, $sp\n"
                            "\tJAL initmain\n"
                            "\tli  $v0, 10\n"
                            "\tsyscall\n"
                            );

        // output all the external funtions
        for (int i = 0; i < MAX_EXTERNS; i++) {
            if (strlen(extern_fuctions[i])) {
                fprintf(fileptr, extern_fuctions[i]);
            }
        }

        //fclose(fp);
    }
    int handled = 0;

    int mempos;
    int temp_reg = t2;
    int op = 0;
    int is_loop = (node->node_kind == LOOPSTMT);
    int reg_to_load;

	switch(node->node_kind){
        case FORMALDECL:
        case VARDECL: // When we declare a variable; allocate memory for it
            handled = 1;
            // NOTE: node->children[1]->val gives the identifier which has the index for the index table
            get_and_update_mempos(node->children[1]->val);
            int size;
            
            if (is_array(node)) {
                size = -4 * get_array_val(node);
            } else {
                size = -4;
            }
            

            if (is_global(node->children[1]->val)){ 
                fprintf(fileptr, "\t# We dont allocate space for globals, %s will be stored at %d relative to the global pointer "
                 "when it needs to be saved\n",strTable[node->children[1]->val].id, strTable[node->children[1]->val].mempos);
            } else {
                fprintf(fileptr, "\tADDI $sp, $sp, %d # Allocate space for %s\n", size, strTable[node->children[1]->val].id);
                vars_declared++;
            }
            break;
        case ASSIGNSTMT:
            fprintf(fileptr, "#BEGIN ASSIGN STMT\n");
            if (node->num_children > 1) {
                fprintf(fileptr, "#BEGIN ACTUAL ASSIGN STMT\n");
                handled = 1;
                // NOTE: node->children[0]->children[0]->val gives the identifier of the left side of assign which has the index for the index table
                reg_no = load_val(node->children[0]->children[0]->val, get_offset(node->children[0]));

                for (int i = 0; i < node->num_children; i++) {
                    assemble(node->children[i], reg_no);
                }
                reg_no = NULL;
            }
            fprintf(fileptr, "#END ASSIGN STMT\n");
            break;
		case EXPRESSION: 
            fprintf(fileptr, "\t#BEGIN EXPR STMT\n");
            handled = 1;
            reg_to_load = asm_expr(node, reg_no);
            if (reg_no) {
                fprintf(fileptr, "\tmove %s, %s\n", reg_names[*reg_no], reg_names[reg_to_load]);
                store_val(reg_map[*reg_no].index, reg_map[*reg_no].offset);
            }
            reg_map[reg_to_load] = (struct reg_val){-1, 0};
            fprintf(fileptr, "\t#END EXPR STMT\n");
			break;
        case LOOPSTMT:
        case CONDSTMT:
            handled = 1;
            char label[10];

            if (is_loop){
                num_whiles++;
                snprintf(label, 9, "while%d", num_whiles);
            } else {
                num_ifs++;
                snprintf(label, 9, "if%d", num_ifs);
            }
            
            fprintf(fileptr, "\nbegin%s:\n", label);
            
            reg_to_load = asm_expr(node->children[0], reg_no);
            
            if (is_loop) 
                fprintf(fileptr, "\tBNE %s, 1, end%s\n", reg_names[reg_to_load], label);
            else
                fprintf(fileptr, "\tBNE %s, 1, beginelse%d\n", reg_names[reg_to_load], num_ifs);

            reg_map[reg_to_load] = (struct reg_val){-1, 0};
            
            int printed = 0;
            for (int i = 1; i < node->num_children; i++) {
                if (i == 2) { // if there is an else print this before else code
                    fprintf(fileptr, "\nbeginelse%d:\n", num_ifs);
                    printed = 1;
                }
                assemble(node->children[i], reg_no);
                if (!is_loop) {
                    fprintf(fileptr, "\tJ end%s\n", label);
                }
            }

            if (!printed && !is_loop) { // if there is no else print this anyways
                fprintf(fileptr, "\nbeginelse%d:\n", num_ifs);
            }

            if (is_loop) {
                fprintf(fileptr, "\tJ begin%s\n", label);
            }

            fprintf(fileptr, "end%s:\n\n", label);
            break;
        case FUNDECL:
            funtionNode = node;
            strcpy(asm_scope, strTable[node->children[1]->val].id);
            handled = 1;
            vars_declared=0;

            struct reg_val oldcontext[32];
            for (int i = zero; i <= ra; i++) {
                oldcontext[i] = reg_map[i];
                reg_map[i] = (struct reg_val){-1,0};
            }
            reg_map[ra] = (struct reg_val){0,0};
            reg_map[sp] = (struct reg_val){0,0};
            reg_map[fp] = (struct reg_val){0,0};

            fprintf(fileptr, "init%s: \n", strTable[node->children[1]->val].id);
            emit_pre_instructions();
            for (int i = 0; i < node->num_children; i++) {
                assemble(node->children[i], reg_no);
            }
            
            fprintf(fileptr, "end%s: \n", strTable[node->children[1]->val].id);

            while (vars_declared != 0) {
                fprintf(fileptr, "\tADDI $sp, $sp, 4\n");
                vars_declared--;
            }

            for (int i = zero; i <= ra; i++) {
                if (reg_map[i].index>0) strTable[reg_map[i].index].reg = -1;
                reg_map[i] = oldcontext[i];
            }
            funtionNode = NULL;
            memset(asm_scope, '\0', 20);
            //emit_post_instructions();
            break;
        case FUNCCALLEXPR:
            handled = 1;
            fprintf(fileptr,    "\tsw $ra, ($sp)\n"
                                "\tsubi $sp, $sp, 4\n");

            struct treenode * arguments[MAXCHILDREN];
            int num_args = 0;
            get_children(arguments, node->children[1], IDENTIFIER, &num_args);
            get_children(arguments, node->children[1], INT, &num_args);
            get_children(arguments, node->children[1], CHAR, &num_args);

            for (int i = 0; i < num_args; i++) {
                int * arg_reg;
                if (arguments[i]->node_kind == IDENTIFIER){
                    assert(arguments[i]->parent->node_kind == VAR);
                    tree * var_ptr = arguments[i]->parent;
                    arg_reg = load_val(arguments[i]->val, get_offset(var_ptr));

                    fprintf(fileptr,    "\tsw %s, %d($sp) # Store Argument\n", reg_names[*arg_reg], -1 * ( 36 + (4*i)) );
                } else { // if itt an immediate
                    fprintf(fileptr,    "\tli %s, %d # Load Immideiate Argument\n", reg_names[temp_reg], arguments[i]->val);
                    fprintf(fileptr,    "\tsw %s, %d($sp) # Store Immidiate Argument\n", reg_names[temp_reg], -1 * ( 36 + (4*i)) );
                }
            }

            fprintf(fileptr,    "\tjal init%s\n"
                                "\taddi $sp, $sp, 4\n"
                                "\tlw $ra, ($sp)\n", strTable[node->children[0]->val].id);
            break;
        case RETURNSTMT:
            handled = 1;
            struct treenode * return_vals[MAXCHILDREN];
            int num_vals = 0;
            get_children(return_vals, node, IDENTIFIER, &num_vals);
            get_children(return_vals, node, INT, &num_vals);
            get_children(return_vals, node, CHAR, &num_vals);

            if (num_vals != 0 && num_vals != 1){
                yyerror("Invalid number of return values\n");
            }

            fprintf(fileptr, "#Return\n", mempos);
            if (num_vals) {
                mempos = get_and_update_mempos(return_vals[0]->val);
                fprintf(fileptr, "\tLW $v0, %d($fp)\n # Save Return value", mempos);
            }
        
            emit_post_instructions();
            fprintf(fileptr, "\tjr $ra\n", mempos);
            break;
		default:
			break;
	}

    if (handled) return;
    
    for (int i = 0; i < node->num_children; i++) {
        assemble(node->children[i], reg_no);
    }
}

int get_and_update_mempos(int index) {
    int mempos = -1;

    struct treenode * functionNode = strTable[ST_lookup(strTable[index].scope, "global")].treeptr;

    if(strTable[index].mempos != -1) { // if the variable already has a location in memory return it
        mempos = strTable[index].mempos;
    } else { // otherwise, allocate the next free block of memory relative to the stack pointer
        if (!is_global(index)){
            mempos = functionNode->val; // mempos =  next availiable block
            strTable[index].mempos = mempos;

            if (is_array(strTable[index].treeptr))
                functionNode->val -= 4 * get_array_val(strTable[index].treeptr);
            else 
                functionNode->val -= 4;
        } else {
            mempos = globalptr;
            strTable[index].mempos = mempos;
            if (is_array(strTable[index].treeptr))
                globalptr -= 4 * get_array_val(strTable[index].treeptr);
            else 
                globalptr -= 4;
        }
    }    

    return mempos;
}

int get_next_temp() {
    int i;
    for (i = t0; i <= t7; i++) {
        if (reg_map[i].index == -1) {
            reg_map[i].index = 0;
            return i;
        }
    }
    assert(0);
    return 0;
}

int * get_and_update_reg(int index, int offset, int * needs_load) {
    *needs_load = 1;
    int reg = -1;
    // NOTE: reg_map maps register values to indexes in the sybol table.

    int lowest_priority = s0;
    int i = s0;
    // if the value already has a register return that
    if (strTable[index].reg != -1 && offset == reg_map[strTable[index].reg].offset){
        *needs_load = 0;
        reg = strTable[index].reg;
    } else {
        // otherwise get the next availiable register
        for (i = s0; i <= s7; i++) {
            if (reg_map[i].index == -1) { // if the register not not mapped to a vlue in the symbol table
                reg = i;
                break;
            }

            if (strTable[reg_map[i].index].calls < strTable[reg_map[lowest_priority].index].calls){
                lowest_priority = i;
            }
        }
    }
    
    strTable[index].calls--; // the more times is called in assmebling the fewer calls left and the lower the priority

    if (reg == -1) {
        reg = lowest_priority;
        // if all registers are full boot lowest priority
        strTable[reg_map[reg].index].reg = -1;
        fprintf(fileptr, "\t# Value '%s' booted from %s due to call to '%s'\n", strTable[reg_map[reg].index].id, reg_names[reg], strTable[index].id);
    }

    if (*needs_load) {
        reg_map[reg].index = index;
        reg_map[reg].offset = offset;
        strTable[index].reg = reg;
        fprintf(fileptr, "\t# Map %s to register %s\n", strTable[index].id, reg_names[reg]);
    }

    return &strTable[index].reg;
}

void emit(char * instr, int rd, int rs, int rt, int * imm ) {

}

int asm_expr(tree * node, int * dest_reg_no) {
    int return_reg = 0;

    int left_reg, right_reg;

    switch(node->node_kind) {
        case FUNCCALLEXPR:
            assemble(node, dest_reg_no);
            return v0;
            break;
        case MULOP:
        case ADDOP:
        case RELOP:
            left_reg = asm_expr(node->children[0], dest_reg_no);
            right_reg = asm_expr(node->children[1], dest_reg_no);
            return_reg = get_next_temp();
            switch (node->val) {
                case ADD:
                    fprintf(fileptr, "\tADD %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case SUB:
                    fprintf(fileptr, "\tSUB %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case MUL:
                    fprintf(fileptr, "\tMULT %s, %s \n", reg_names[left_reg], reg_names[right_reg]);
                    fprintf(fileptr, "\tMFLO %s\n", reg_names[return_reg]);
                    break;
                case DIV:
                    fprintf(fileptr, "\tDIV %s, %s\n", reg_names[left_reg], reg_names[right_reg]);
                    fprintf(fileptr, "\tMFHI %s\n", reg_names[return_reg]);
                    break;
                case LTE:
                    fprintf(fileptr, "\tSLT $t8, %s, %s \n", reg_names[left_reg], reg_names[right_reg]);
                    fprintf(fileptr, "\tSEQ $t9, %s, %s \n", reg_names[left_reg], reg_names[right_reg]);
                    fprintf(fileptr, "\tOR %s, $t8, $t9 \n", reg_names[return_reg]);
                    break;
                case LT:
                    fprintf(fileptr, "\tSLT %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case GTE:
                    fprintf(fileptr, "\tSGT $t8, %s, %s \n", reg_names[left_reg], reg_names[right_reg]);
                    fprintf(fileptr, "\tSEQ $t9, %s, %s \n", reg_names[left_reg], reg_names[right_reg]);
                    fprintf(fileptr, "\tOR %s, $t8, $t9 \n", reg_names[return_reg]);
                    break;
                case GT:
                    fprintf(fileptr, "\tSGT %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case EQ:
                    fprintf(fileptr, "\tSEQ %s, %s, %s \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
                case NEQ:
                    fprintf(fileptr, "\tSEQ $t8, %s, %s \n", reg_names[left_reg], reg_names[right_reg]);
                    fprintf(fileptr, "\tSEQ %s, $t8, $zero \n", reg_names[return_reg], reg_names[left_reg], reg_names[right_reg]);
                    break;
            }
            //Retire registers
            reg_map[left_reg] = (struct reg_val){-1, 0};
            reg_map[right_reg] = (struct reg_val){-1, 0};
            break;
        case IDENTIFIER:
            return_reg = *load_val(node->val, get_offset(node->parent));
            break;
        case INT:
        case CHAR:
            return_reg = get_next_temp();
            fprintf(fileptr, "\tLI, %s, %d\n", reg_names[return_reg], node->val);
            break;
        default:
            for (int i = 0; i < node->num_children; i++){
                //assert(node->num_children == 1 || node->num_children == 0);
                if (node->children[i]->node_kind != ARRAYSIZE) return_reg = asm_expr(node->children[i], dest_reg_no);
                if (return_reg != 0) break;
            }
            break;
    }
    return return_reg;
}

int * load_val(int index, int offset) {
    int needs_load;
    int mempos = get_and_update_mempos(index) + offset;
    int * reg = get_and_update_reg(index, offset, &needs_load);
    char * name = malloc(20);
    strcpy(name, strTable[index].id);

    if (needs_load) {
        if (is_global(index)){
            fprintf(fileptr, "\tlw %s, %d($gp) # %s will be used in the future and must be loaded into a register\n", reg_names[*reg], mempos, name);
        } else {
            fprintf(fileptr, "\tlw %s, %d($fp) # %s will be used in the future and must be loaded into a register\n", reg_names[*reg], mempos, name);
        }
    } else {
        fprintf(fileptr, "\t#Value %s is already stored in register %s and doesnt need to be loaded\n", name, reg_names[*reg]);
    }

    return reg;
}

void store_val(int index, int offset) {
    int needs_load;
    int mempos = get_and_update_mempos(index) + offset;
    int reg = *get_and_update_reg(index, offset, &needs_load);
    char * name = malloc(20);
    strcpy(name, strTable[index].id);

    if (is_global(index)){
        fprintf(fileptr, "\tsw %s, %d($gp) # %s was updated and must be saved\n", reg_names[reg], mempos, name);
    } else {
        fprintf(fileptr, "\tsw %s, %d($fp) # %s was updated and must be saved\n", reg_names[reg], mempos, name);
    }
}

void emit_pre_instructions() {
    fprintf(fileptr,    "\t# Setting up FP\n"
                        "\tsw $fp, ($sp)\n"
                        "\tmove $fp, $sp\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\t# Saving registers\n"
                        "\tsw $s0, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s1, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s2, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s3, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s4, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s5, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s6, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tsw $s7, ($sp)\n"
                        "\tsubi $sp, $sp, 4\n"
                        "\tmove $fp, $sp\n"
                        "\t# Allocate space for local variables.\n");
}

void emit_post_instructions() {
    fprintf(fileptr, "\t# Deallocate space for %d, local variables\n", vars_declared);
    
    while (vars_declared > 0) {
        fprintf(fileptr, "\taddi $sp, $sp, 4\n");
        vars_declared--;
    }

    fprintf(fileptr,    "\t# Reloading registers\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s7, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s6, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s5, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s4, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s3, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s2, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s1, ($sp)\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $s0, ($sp)\n"
                        "\t# Setting FP back to old value\n"
                        "\taddi $sp, $sp, 4\n"
                        "\tlw $fp, ($sp)\n"
                        "\t# Return to caller\n");
}

int get_array_val(tree * array) {
    //if ((array->node_kind != VAR && array->node_kind != VARDECL)) return 0;
    assert(array->node_kind == VAR || array->node_kind == VARDECL || array->node_kind == FORMALDECL);
    if (!is_array(array)) return 0;

    struct treenode * size_node;
    if (array->node_kind == VARDECL) {
        size_node = array->children[2]->children[0];
        // size_node is integer node
        return size_node->val;
        
    } else if (array->node_kind == FORMALDECL){
        size_node = array->children[2];
        // size_node is integer node
        return size_node->val;
    }
    else {
        size_node = array->children[1]->children[0];
        // size_node is addExpr and must be factorized
        int total = factorize(size_node);
        return total;
    }
}

int get_offset(tree * node) {
    assert(node->node_kind == VAR);

    if (!is_array(node)) {
        return 0;
    }

    return get_array_val(node) * -4;;
}