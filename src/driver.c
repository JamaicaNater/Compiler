#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<../src/tree.h>
#include<../src/strtab.h>

extern int errors;
extern int yyparse();
extern FILE* yyin;
extern tree * ast;

char * output_file_name;

void print_help() {
    printf("Usage: mcc [--ast] [--sym] [-h|--help] FILE\n");
    printf("\t--ast:\t\tPrint a textual representation of the constructed "
            "abstract syntax tree.\n");
    printf("\t--sym:\t\tPrint a textual representation of the constructed "
            "symbol table.\n");
    printf("\t-h,--help:\tPrint this help information and exit.\n\n");
}

int main(int argc, char *argv[]) {
    make_function(VOID_TYPE, "output", INT_TYPE, "i", "global");
    make_function(VOID_TYPE, "outputhexaschar", INT_TYPE, "c", "global");
    make_function(VOID_TYPE, "outputchar", CHAR_TYPE, "c", "global");
    make_function(CHAR_TYPE, "inputchar", 0, "", "global");
    make_function(CHAR_TYPE, "inputint", 0, "", "global");

    int p_ast = 0;
    int p_symtab = 0;

    // Skip first arg (program name), then check all but second to last and last for options.
    for (int i = 1; i < argc - 2; i++) {
        if (strcmp(argv[i], "-h") ==0 || strcmp(argv[i], "--help") == 0) {
            print_help();
            return 0;
        } else if (strcmp(argv[i], "--ast") == 0) {
            p_ast = 1;
        } else if (strcmp(argv[i], "--sym") == 0) {
            p_symtab = 1;
        } else {
            print_help();
            return 0;
        }
    }

    output_file_name = malloc(strlen(argv[argc - 1]) + 1);
    strcpy(output_file_name, argv[argc - 1]);
    yyin = fopen(argv[argc - 2], "r");
    printf("%s", argv[argc - 2]);
    if (!yyin) {
        printf("error: unable to read source file %s\n", argv[argc-1]);
        return -1;
    }

    if (!yyparse()) {
        if (p_ast) {
            printf("PRINTING TREE TABLE:\n");
            print_ast(ast, 1);
        }

        if (p_symtab) {
            printf("\nPRINTING SYMBOL TABLE:\n");
            ST_print();
        }

        if (!errors) {
            int * reg_no = NULL;
            assemble(ast, reg_no);
            printf("Compilation finished.\n");
        } else {
            printf("Compilation failed.\n");
        }
    }
    return 0;
}
