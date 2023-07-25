%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<../src/tree.h>
#include<../src/strtab.h>
#include<../obj/y.tab.h>

extern int yylineno;
extern tree * ast;
extern struct strEntry strTable[MAXIDS];

int yylex();

int scopeLevel = 0; // 0 if global, 1 if local
char scopeName[100] = "global"; //default scope
tree *funDeclNode;
int errors = 0;

char string_list[100][100];
int curr_string = 0;

%}

%union
{
    int value;
    struct treenode *node;
    char *strval;
}

%nonassoc LOWEST_PRECEDENCE
%nonassoc KWD_ELSE

//these are all of the possible tokens accepted by the parser
%token <value> KWD_IF KWD_ELSE
%token <value> KWD_WHILE
%token <value> KWD_INT KWD_STRING KWD_CHAR
%token <value> KWD_RETURN KWD_VOID
%token <value> OPER_ADD OPER_SUB
%token <value> OPER_MUL OPER_DIV
%token <value> OPER_LT OPER_GT
%token <value> OPER_GTE OPER_LTE
%token <value> OPER_EQ OPER_NEQ
%token <value> OPER_ASGN
%token <value> LSQ_BRKT RSQ_BRKT
%token <value> LCRLY_BRKT RCRLY_BRKT
%token <value> LPAREN RPAREN
%token <value> COMMA SEMICLN
%token <value> INTCONST
%token <value> CHARCONST
%token <strval> ID STRCONST
%token <value> ERROR
%token <value> ILLEGAL_TOK

//these are all of the possible nodes to be created for the AST
%type <node> program declList decl varDecl typeSpecifier funDecl
%type <node> formalDeclList formalDecl funBody localDeclList
%type <node> statementList statement compoundStmt assignStmt condStmt
%type <node> loopStmt returnStmt var expression relop addExpr addop
%type <node> term mulop factor funcCallExpr argList


%start program

%%

program         : declList
                {
		            tree* progNode = make_tree(PROGRAM);
                    add_child(progNode, $1);
                    ast = progNode;
                }
                ;

declList        : decl
                { 
                    tree* declListNode = make_tree(DECLLIST);
                    add_child(declListNode, $1);
                    $$ = declListNode;
                }
                | declList decl
                {
                    tree* declListNode = make_tree(DECLLIST);
                    add_child(declListNode, $1);
                    add_child(declListNode, $2);
                    $$ = declListNode;
                }
                ;
decl		: varDecl
            {
                tree* declNode = make_tree(DECL);
                add_child(declNode, $1);
                $$ = declNode;
            }
            | funDecl
            {
                tree* declNode = make_tree(DECL);
                add_child(declNode, $1);
                $$ = declNode;
            }
            ;
varDecl		: typeSpecifier ID LSQ_BRKT INTCONST RSQ_BRKT SEMICLN
		    {
                tree* varDeclNode = make_tree(VARDECL);
                add_child(varDeclNode, $1);

                if ($4 == 0){
                    yyerror("Array variable declared with size of zero.");
                }
                if ($4 < 0){
                    yyerror("Array variable declared with negative value.");
                }
                
                int dataType = $1->val;
                
                char* scope = malloc(100);
                if(scopeLevel == 0){
                    scope = "global";
                }else{
                    scope = scopeName;
                }

                int index = ST_lookup($2, scopeName);
                if (index == -1) {
                    index = ST_insert($2, scope, dataType, ARRAY, varDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }

                add_child(varDeclNode, make_tree_with_val(IDENTIFIER, index));
                add_child(varDeclNode, make_tree(ARRAYSIZE));
                add_child(varDeclNode->children[2], make_tree_with_val(INT, $4));
                $$ = varDeclNode;
	 	    }
            |
            typeSpecifier ID SEMICLN
            {
                tree* varDeclNode = make_tree(VARDECL);
                add_child(varDeclNode, $1);
                int dataType = $1->val;

                char* scope = malloc(100);
                if(scopeLevel == 0){
                    scope = "global";
                }else{
                    scope = scopeName;
                }

                int index = ST_lookup($2, scopeName);
                if (index == -1) {
                    index = index = ST_insert($2, scope, dataType, SCALAR, varDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }

                add_child(varDeclNode, make_tree_with_val(IDENTIFIER, index));
                $$ = varDeclNode;
            }
            ;
typeSpecifier   : KWD_INT
                {
                    $$ = make_tree_with_val(TYPESPECIFIER, INT_TYPE);
                }
                | KWD_CHAR
                {
                    $$ = make_tree_with_val(TYPESPECIFIER, CHAR_TYPE);
                }
                | KWD_VOID
                {
                    $$ = make_tree_with_val(TYPESPECIFIER, VOID_TYPE);
                }
                ;
funDecl		: typeSpecifier ID LPAREN 
            {
                scopeLevel++;
                strcpy(scopeName, $2);
                funDeclNode = make_tree(FUNDECL);
                add_child(funDeclNode, $1);
            }
            formalDeclList RPAREN 
            {
                int dataType = $1->val;

                int index = ST_lookup($2, "global");
                if (index == -1) {
                    index = ST_insert($2, "global", dataType, FUNCTION, funDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }

                add_child(funDeclNode, make_tree_with_val(IDENTIFIER, index));
                add_child(funDeclNode, $5);
            }		
            funBody 
            {
                scopeLevel--;
                add_child(funDeclNode, $8);
                $$ = funDeclNode;
                
            }
            | typeSpecifier ID LPAREN
            { 
                scopeLevel++;
                strcpy(scopeName, $2);
                funDeclNode = make_tree(FUNDECL);
                add_child(funDeclNode, $1);
                int dataType= $1->val;

                int index = ST_lookup($2, "global");
                if (index == -1) {
                    index = index = ST_insert($2, "global", dataType, FUNCTION, funDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }

                add_child(funDeclNode, make_tree_with_val(IDENTIFIER, index));
            }
            RPAREN funBody
            { 
                scopeLevel--;
                add_child(funDeclNode, $6);
                $$ = funDeclNode;
                
            }
            ;
formalDeclList 	: formalDecl 
		{
            tree* formalDeclListNode = make_tree(FORMALDECLLIST);
            add_child(formalDeclListNode, $1);
            $$ = formalDeclListNode;            
		}
		| formalDecl COMMA formalDeclList
		{
            tree* formalDeclListNode = make_tree(FORMALDECLLIST);
            add_child(formalDeclListNode, $1);
            add_child(formalDeclListNode, $3);
            $$ = formalDeclListNode;
		}
		;
formalDecl 	: typeSpecifier ID
            {
                tree* formalDeclNode = make_tree(FORMALDECL);
                add_child(formalDeclNode, $1);
                int dataType = $1->val;

                char* scope = malloc(100);
                if(scopeLevel == 0){
                    scope = "global";
                }else{
                    scope = scopeName;
                }

                int index = ST_lookup($2, scopeName);
                if (index == -1) {
                    index = ST_insert($2, scope, dataType, SCALAR, formalDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }                

                add_child(formalDeclNode, make_tree_with_val(IDENTIFIER, index));
                $$ = formalDeclNode;
            }
            | typeSpecifier ID LSQ_BRKT RSQ_BRKT 
            {
                tree* formalDeclNode = make_tree(FORMALDECL);
                add_child(formalDeclNode, $1);
                int dataType = $1->val;
                               
                int index = ST_lookup($2, scopeName);
                if (index == -1) {
                    index = ST_insert($2, scopeName, dataType, ARRAY, formalDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }
                
                add_child(formalDeclNode, make_tree_with_val(IDENTIFIER, index));
                add_child(formalDeclNode, make_tree_with_val(ARRAYSIZE, 0));  
                $$ = formalDeclNode;
            }
            ;
funBody 	: LCRLY_BRKT localDeclList statementList RCRLY_BRKT
            {
                tree* funBodyNode = make_tree(FUNBODY);
                add_child(funBodyNode, $2);
                add_child(funBodyNode, $3);
                $$ = funBodyNode;
            }
            ;
localDeclList 	: 
                {
                    tree* localDeclListNode = make_tree_with_val(LOCALDECLLIST, -1);
                    $$ = localDeclListNode;
                }
                | varDecl localDeclList
                {
                    tree* localDeclListNode = make_tree(LOCALDECLLIST);
                    add_child(localDeclListNode, $1);
                    add_child(localDeclListNode, $2);
                    $$ = localDeclListNode;
                }
                ;
statementList 	:
		        {
                    tree* statementListNode = make_tree_with_val(STATEMENTLIST, -1);
                    $$ = statementListNode;
		        }
		        | statement statementList
		        {
                    tree* statementListNode = make_tree(STATEMENTLIST);
                    add_child(statementListNode, $1);
                    add_child(statementListNode, $2);
                    $$ = statementListNode;
		        }
		        ;   
statement 	: compoundStmt
		    {
                tree* statementNode = make_tree(STATEMENT);
                add_child(statementNode, $1);
                $$ = statementNode;
            }
		    | assignStmt
		    {
                tree* statementNode = make_tree(STATEMENT);
                add_child(statementNode, $1);
                $$ = statementNode;
            }
		    | condStmt
            {
                tree* statementNode = make_tree(STATEMENT);
                add_child(statementNode, $1);
                $$ = statementNode;
            }
		    | loopStmt
		    {
                tree* statementNode = make_tree(STATEMENT);
                add_child(statementNode, $1);
                $$ = statementNode;
            }
		    | returnStmt
		    {
                tree* statementNode = make_tree(STATEMENT);
                add_child(statementNode, $1);
                $$ = statementNode;
            }
            ;
compoundStmt 	: LCRLY_BRKT statementList RCRLY_BRKT
		        {
                    tree* CompoundStmtNode = make_tree(COMPOUNDSTMT);
                    add_child(CompoundStmtNode, $2);
                    $$ = CompoundStmtNode;
                }
                ;
assignStmt 	: var OPER_ASGN expression SEMICLN
		    {
                int valid_assignment = 0;
                int rval_type = get_type($3);
                int lval_type = get_type($1);
                //printf("lval_type : %d, rval_type : %d lineno : %d  int : %d, char : %d, void : %d\n",lval_type, rval_type, yylineno, INT_TYPE, CHAR_TYPE, VOID_TYPE);

                // if the type of the left hand side is an int the right side must be an int or a char
                if (lval_type == INT_TYPE) {
                    if (rval_type == INT_TYPE)
                        valid_assignment = 1;
                    if (rval_type == CHAR_TYPE)
                        valid_assignment = 1;  
                }
                // if the type of the left hand side is a char the right side must be a char NO EXEPTIONS
                if (lval_type == CHAR_TYPE) {
                    if (rval_type == CHAR_TYPE)
                        valid_assignment = 1;  
                }
                // if the type of the left hand side is a void the right side must be a void NO EXEPTIONS
                if (lval_type == VOID_TYPE) {
                    if (rval_type == VOID_TYPE)
                        valid_assignment = 1;  
                }

                if (!valid_assignment) {
                    yyerror("Type mismatch in assignment.");
                }
                
                tree* assignStmtNode = make_tree(ASSIGNSTMT);
                add_child(assignStmtNode, $1);
                add_child(assignStmtNode, $3);
                $$ = assignStmtNode;
            }
		    | expression SEMICLN
		    {
                tree* assignStmtNode = make_tree(ASSIGNSTMT);
                add_child(assignStmtNode, $1);
                $$ = assignStmtNode;
            }
            ;
condStmt 	: KWD_IF LPAREN expression RPAREN statement %prec LOWEST_PRECEDENCE
		    {
                tree* condStmtNode = make_tree(CONDSTMT);
                add_child(condStmtNode, $3);
                add_child(condStmtNode, $5);
                $$ = condStmtNode;
            }
		    | KWD_IF LPAREN expression RPAREN statement KWD_ELSE statement 
		    {
                tree* condStmtNode = make_tree(CONDSTMT);
                add_child(condStmtNode, $3);
                add_child(condStmtNode, $5);
                add_child(condStmtNode, $7);
                $$ = condStmtNode;
            }
            ;
loopStmt 	: KWD_WHILE LPAREN expression RPAREN statement
            {
                tree* loopStmtNode = make_tree(LOOPSTMT);
                add_child(loopStmtNode, $3);
                add_child(loopStmtNode, $5);
                $$ = loopStmtNode;
            }
            ;
returnStmt 	: KWD_RETURN SEMICLN
		    {
                $$ = make_tree_with_val(RETURNSTMT, KWD_RETURN);   
		    }
		    | KWD_RETURN expression SEMICLN
		    {
                tree* returnStmtNode = make_tree(RETURNSTMT);
                add_child(returnStmtNode, $2);
                $$ = returnStmtNode;
            }
            ;
var 		: ID
		    {
                tree* varNode = make_tree(VAR);
	 	        int index = super_ST_lookup($1, scopeName);
                if (index == -1) {
                    yyerror("Undeclared variable");
                } else {
                    strTable[index].calls++;
                }
		        add_child(varNode, make_tree_with_val(IDENTIFIER, index));
                $$ = varNode;
            }
		    | ID LSQ_BRKT addExpr RSQ_BRKT
		    {
                tree* varNode = make_tree(VAR);
		        int index = super_ST_lookup($1, scopeName);
                if (index == -1) {
                    yyerror("Undeclared variable");
                } else {
                    strTable[index].calls++;
                    
                    struct treenode *node = (struct treenode *)malloc(sizeof(struct treenode));
                    node = strTable[index].treeptr;

                    if (!is_array(node)){
                        yyerror("Non-array identifier used as an array");
                    }
                }

                if (get_type($3) != INT_TYPE){
                    yyerror("Array indexed using non-integer expression.");
                } else {
                    if (index != -1) {
                        int total = factorize($3);

                        if (!index_in_bounds(strTable[index].treeptr, total) && 
                        is_array(strTable[index].treeptr)  ){
                            yyerror("Statically sized array indexed with constant, out-of-bounds expression.");
                        }
                    }
                }
                add_child(varNode, make_tree_with_val(IDENTIFIER, index));
                add_child(varNode, make_tree(ARRAYSIZE));
                add_child(varNode->children[1], $3);
                $$ = varNode;
            }
		    ;
expression 	: addExpr
		    {
                tree* expressionNode = make_tree(EXPRESSION);
                add_child(expressionNode, $1);
                $$ = expressionNode;
            }
		    | expression relop addExpr
            {
                tree* expressionNode = make_tree(EXPRESSION);
                add_child($2, $1);
                add_child($2, $3);
                add_child(expressionNode, $2);
                $$ = expressionNode;
            }
            ;
relop 		: OPER_LTE
            {
                $$ = make_tree_with_val(RELOP, LTE);                
		    }
		    | OPER_LT
		    {
		        $$ = make_tree_with_val(RELOP, LT);     
            }
		    | OPER_GT
            {
                $$ = make_tree_with_val(RELOP, GT);     
            }
		    | OPER_GTE
		    {
                $$ = make_tree_with_val(RELOP, GTE);     
            }
		    | OPER_EQ
            {
                $$ = make_tree_with_val(RELOP, EQ);     
            }
		    | OPER_NEQ
            {   
                $$ = make_tree_with_val(RELOP, NEQ);     
            }
            ;
addExpr 	: term
            {
                tree* addExprNode = make_tree(ADDEXPR);
                add_child(addExprNode, $1);
                $$ = addExprNode;
            }
		    | addExpr addop term
		    {
                tree* addExprNode = make_tree(ADDEXPR);
                add_child($2, $1);
                add_child($2, $3);
                add_child(addExprNode, $2);
                $$ = addExprNode;
            }
            ;
addop 		: OPER_ADD
		    {
                $$ = make_tree_with_val(ADDOP, ADD);     
            }
		    | OPER_SUB
		    {
                $$ = make_tree_with_val(ADDOP, SUB);     
            }
            ;
term 		: factor
            {
                tree* termNode = make_tree(TERM);
                add_child(termNode, $1);
                $$ = termNode;
            }
		    | term mulop factor
		    {
                tree* termNode = make_tree(TERM);
                add_child($2, $1);
                add_child($2, $3);
                add_child(termNode, $2);
                $$ = termNode;
            }
            ;
mulop 		: OPER_MUL
            {
                $$ = make_tree_with_val(MULOP, MUL);     
            }
		    | OPER_DIV
		    {
                $$ = make_tree_with_val(MULOP, DIV);     
            }
            ;
factor 		: LPAREN expression RPAREN
		    {
                tree* factorNode = make_tree(FACTOR);
                add_child(factorNode, $2);
                $$ = factorNode;
            }
		    | var
		    {
                tree* factorNode = make_tree(FACTOR);
                add_child(factorNode, $1);
                $$ = factorNode;
            }
		    | funcCallExpr
		    {
                tree* factorNode = make_tree(FACTOR);
                add_child(factorNode, $1);
                $$ = factorNode;
            }
		    | INTCONST
		    {
		        tree* factorNode = make_tree(FACTOR);
		        add_child(factorNode, make_tree_with_val(INT, $1));
                $$ = factorNode;
            }
		    | CHARCONST
            {
		        tree* factorNode = make_tree(FACTOR);
		        add_child(factorNode, make_tree_with_val(CHAR, $1));
                $$ = factorNode;
            }
		    | STRCONST
		    {
		        tree* factorNode = make_tree(FACTOR);
		        add_child(factorNode, make_tree_with_val(STR, curr_string));
                strcpy(string_list[curr_string], $1);

                curr_string++;
                $$ = factorNode;
            }
            ;
funcCallExpr 	: ID LPAREN argList RPAREN
		        {
                    tree* funcCallExprNode = make_tree(FUNCCALLEXPR);
		            int index = super_ST_lookup($1, "global");
                    if (index == -1) {
                        yyerror("Undefined function");
                    } 
                    tree * child = make_tree_with_val(IDENTIFIER, index);
                    if (index != -1) {
                        // Dont make this an if else
                        int compareval = function_compare(strTable[index].treeptr, $3);
                        
                        switch (compareval) {
                            case -2:
                                yyerror("Argument type mismatch in function call.");
                                break;
                            case -1:
                                yyerror("Too few arguments provided in function call.");
                                break;
                            case 1:
                                yyerror("Too many arguments provided in function call.");
                                break;
                            case 0:
                                break;
                            default:
                                printf("Error in funtion matching\n");
                                break;
                        }
                    }

                    add_child(funcCallExprNode, child);
                    add_child(funcCallExprNode, $3);
                    $$ = funcCallExprNode;
                }
		        | ID LPAREN RPAREN
		        {
                    tree *funcCallExprNode = make_tree(FUNCCALLEXPR);
                    int index = super_ST_lookup($1, "global");
                    if (index == -1) {
                        yyerror("Undefined function");
                    }
                    tree * child = make_tree_with_val(IDENTIFIER, index);
                    if (index != -1) {
                         // Dont make this an if else
                        int compareval = function_compare(strTable[index].treeptr, NULL);
                        
                        switch (compareval) {
                            case -2:
                                yyerror("Argument type mismatch in function call.");
                                break;
                            case -1:
                                yyerror("Too few arguments provided in function call.");
                                break;
                            case 1:
                                yyerror("Too many arguments provided in function call.");
                                break;
                            case 0:
                                break;
                            default:
                                printf("Error in funtion matching\n");
                                break;
                        }
                    }
                    
                    add_child(funcCallExprNode, child);
                    $$ = funcCallExprNode;
                }
                ;
argList 	: expression
		    {
                tree* argListNode = make_tree(ARGLIST);
                add_child(argListNode, $1);
                $$ = argListNode;
            }
            | argList COMMA expression
            {
                tree* argListNode = make_tree(ARGLIST);
                add_child(argListNode, $1);
                add_child(argListNode, $3);
                $$ = argListNode;
            }
            ;
%%

int yyerror(char * msg){
    errors++;
    printf("error: line %d: %s\n", yylineno, msg);
    return 0;
}
