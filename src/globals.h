#ifndef GLOBALS_H
#define GLOBALS_H
#include"strtab.h"
#include<stdio.h>

#define MAX_EXTERN_FUNC 15

enum nodeTypes {
    PROGRAM, DECLLIST, DECL, VARDECL, LOCALVARDECL, TYPESPECIFIER, FUNDECL, FORMALDECLLIST, FORMALDECL, FUNBODY,
    LOCALDECLLIST, STATEMENTLIST, STATEMENT, COMPOUNDSTMT, ASSIGNSTMT, CONDSTMT, LOOPSTMT, RETURNSTMT, VAR, EXPRESSION, RELOP,
    ADDEXPR, ADDOP, TERM, MULOP, FACTOR, FUNCCALLEXPR, ARGLIST, IDENTIFIER, SCALAR, ARRAY, FUNCTION,
    IFDECL, ELSEDECL, INT, CHAR, STR, ADD, SUB, MUL, DIV, LTE, LT, GT, GTE, EQ, NEQ, 
    INT_TYPE, CHAR_TYPE, VOID_TYPE, ARRAYSIZE
};

enum reg_types { 
    zero, at, v0, v1, a0, a1, a2, a3, t0, t1, t2, t3, t4, t5, t6, t7, 
    s0, s1, s2, s3, s4, s5, s6, s7, t8, t9, k0, k1, gp, sp, fp, ra
};

extern char * output_file_name;

extern tree *ast;
extern char asm_scope[20];
extern char extern_fuctions[MAX_EXTERN_FUNC][256];
extern FILE *fileptr;
extern char *node_names[70];
extern char *reg_names[32];
extern struct reg_val reg_map[32];
extern struct strEntry strTable[MAX_SYMBOLS];
extern int globalptr;

extern int vars_declared;
extern int num_ifs;
extern int num_whiles;

#endif