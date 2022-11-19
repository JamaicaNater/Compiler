%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<../src/tree.h>
#include<../src/strtab.h>
#include<../obj/y.tab.h>

extern int yylineno;
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
		            tree* progNode = maketree(PROGRAM);
                    addChild(progNode, $1);
                    ast = progNode;
                }
                ;

declList        : decl
                { 
                    tree* declListNode = maketree(DECLLIST);
                    addChild(declListNode, $1);
                    $$ = declListNode;
                }
                | declList decl
                {
                    tree* declListNode = maketree(DECLLIST);
                    addChild(declListNode, $1);
                    addChild(declListNode, $2);
                    $$ = declListNode;
                }
                ;
decl		: varDecl
            {
                tree* declNode = maketree(DECL);
                addChild(declNode, $1);
                $$ = declNode;
            }
            | funDecl
            {
                tree* declNode = maketree(DECL);
                addChild(declNode, $1);
                $$ = declNode;
            }
            ;
varDecl		: typeSpecifier ID LSQ_BRKT INTCONST RSQ_BRKT SEMICLN
		    {
                tree* varDeclNode = maketree(VARDECL);
                addChild(varDeclNode, $1);

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

                addChild(varDeclNode, maketreeWithVal(IDENTIFIER, index));
                addChild(varDeclNode, maketree(ARRAYSIZE));
                addChild(varDeclNode->children[2], maketreeWithVal(INT, $4));
                $$ = varDeclNode;
	 	    }
            |
            typeSpecifier ID SEMICLN
            {
                tree* varDeclNode = maketree(VARDECL);
                addChild(varDeclNode, $1);
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

                addChild(varDeclNode, maketreeWithVal(IDENTIFIER, index));
                $$ = varDeclNode;
            }
            ;
typeSpecifier   : KWD_INT
                {
                    $$ = maketreeWithVal(TYPESPECIFIER, INT_TYPE);
                }
                | KWD_CHAR
                {
                    $$ = maketreeWithVal(TYPESPECIFIER, CHAR_TYPE);
                }
                | KWD_VOID
                {
                    $$ = maketreeWithVal(TYPESPECIFIER, VOID_TYPE);
                }
                ;
funDecl		: typeSpecifier ID LPAREN 
            {
                scopeLevel++;
                strcpy(scopeName, $2);
                funDeclNode = maketree(FUNDECL);
                addChild(funDeclNode, $1);
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

                addChild(funDeclNode, maketreeWithVal(IDENTIFIER, index));
                addChild(funDeclNode, $5);
            }		
            funBody 
            {
                scopeLevel--;
                addChild(funDeclNode, $8);
                $$ = funDeclNode;
                
            }
            | typeSpecifier ID LPAREN
            { 
                scopeLevel++;
                strcpy(scopeName, $2);
                funDeclNode = maketree(FUNDECL);
                addChild(funDeclNode, $1);
                int dataType= $1->val;

                int index = ST_lookup($2, "global");
                if (index == -1) {
                    index = index = ST_insert($2, "global", dataType, FUNCTION, funDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }

                addChild(funDeclNode, maketreeWithVal(IDENTIFIER, index));
            }
            RPAREN funBody
            { 
                scopeLevel--;
                addChild(funDeclNode, $6);
                $$ = funDeclNode;
                
            }
            ;
formalDeclList 	: formalDecl 
		{
            tree* formalDeclListNode = maketree(FORMALDECLLIST);
            addChild(formalDeclListNode, $1);
            $$ = formalDeclListNode;            
		}
		| formalDecl COMMA formalDeclList
		{
            tree* formalDeclListNode = maketree(FORMALDECLLIST);
            addChild(formalDeclListNode, $1);
            addChild(formalDeclListNode, $3);
            $$ = formalDeclListNode;
		}
		;
formalDecl 	: typeSpecifier ID
            {
                tree* formalDeclNode = maketree(FORMALDECL);
                addChild(formalDeclNode, $1);
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

                addChild(formalDeclNode, maketreeWithVal(IDENTIFIER, index));
                $$ = formalDeclNode;
            }
            | typeSpecifier ID LSQ_BRKT RSQ_BRKT 
            {
                tree* formalDeclNode = maketree(FORMALDECL);
                addChild(formalDeclNode, $1);
                int dataType = $1->val;
                               
                int index = ST_lookup($2, scopeName);
                if (index == -1) {
                    index = ST_insert($2, scopeName, dataType, ARRAY, formalDeclNode);
                } else {
                    yyerror("Symbol declared multiple times.");
                }
                
                addChild(formalDeclNode, maketreeWithVal(IDENTIFIER, index));
                addChild(formalDeclNode, maketreeWithVal(ARRAYSIZE, 0));  
                $$ = formalDeclNode;
            }
            ;
funBody 	: LCRLY_BRKT localDeclList statementList RCRLY_BRKT
            {
                tree* funBodyNode = maketree(FUNBODY);
                addChild(funBodyNode, $2);
                addChild(funBodyNode, $3);
                $$ = funBodyNode;
            }
            ;
localDeclList 	: 
                {
                    tree* localDeclListNode = maketreeWithVal(LOCALDECLLIST, -1);
                    $$ = localDeclListNode;
                }
                | varDecl localDeclList
                {
                    tree* localDeclListNode = maketree(LOCALDECLLIST);
                    addChild(localDeclListNode, $1);
                    addChild(localDeclListNode, $2);
                    $$ = localDeclListNode;
                }
                ;
statementList 	:
		        {
                    tree* statementListNode = maketreeWithVal(STATEMENTLIST, -1);
                    $$ = statementListNode;
		        }
		        | statement statementList
		        {
                    tree* statementListNode = maketree(STATEMENTLIST);
                    addChild(statementListNode, $1);
                    addChild(statementListNode, $2);
                    $$ = statementListNode;
		        }
		        ;   
statement 	: compoundStmt
		    {
                tree* statementNode = maketree(STATEMENT);
                addChild(statementNode, $1);
                $$ = statementNode;
            }
		    | assignStmt
		    {
                tree* statementNode = maketree(STATEMENT);
                addChild(statementNode, $1);
                $$ = statementNode;
            }
		    | condStmt
            {
                tree* statementNode = maketree(STATEMENT);
                addChild(statementNode, $1);
                $$ = statementNode;
            }
		    | loopStmt
		    {
                tree* statementNode = maketree(STATEMENT);
                addChild(statementNode, $1);
                $$ = statementNode;
            }
		    | returnStmt
		    {
                tree* statementNode = maketree(STATEMENT);
                addChild(statementNode, $1);
                $$ = statementNode;
            }
            ;
compoundStmt 	: LCRLY_BRKT statementList RCRLY_BRKT
		        {
                    tree* CompoundStmtNode = maketree(COMPOUNDSTMT);
                    addChild(CompoundStmtNode, $2);
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
                
                tree* assignStmtNode = maketree(ASSIGNSTMT);
                addChild(assignStmtNode, $1);
                addChild(assignStmtNode, $3);
                $$ = assignStmtNode;
            }
		    | expression SEMICLN
		    {
                tree* assignStmtNode = maketree(ASSIGNSTMT);
                addChild(assignStmtNode, $1);
                $$ = assignStmtNode;
            }
            ;
condStmt 	: KWD_IF LPAREN expression RPAREN statement %prec LOWEST_PRECEDENCE
		    {
                tree* condStmtNode = maketree(CONDSTMT);
                addChild(condStmtNode, $3);
                addChild(condStmtNode, $5);
                $$ = condStmtNode;
            }
		    | KWD_IF LPAREN expression RPAREN statement KWD_ELSE statement 
		    {
                tree* condStmtNode = maketree(CONDSTMT);
                addChild(condStmtNode, $3);
                addChild(condStmtNode, $5);
                addChild(condStmtNode, $7);
                $$ = condStmtNode;
            }
            ;
loopStmt 	: KWD_WHILE LPAREN expression RPAREN statement
            {
                tree* loopStmtNode = maketree(LOOPSTMT);
                addChild(loopStmtNode, $3);
                addChild(loopStmtNode, $5);
                $$ = loopStmtNode;
            }
            ;
returnStmt 	: KWD_RETURN SEMICLN
		    {
                $$ = maketreeWithVal(RETURNSTMT, KWD_RETURN);   
		    }
		    | KWD_RETURN expression SEMICLN
		    {
                tree* returnStmtNode = maketree(RETURNSTMT);
                addChild(returnStmtNode, $2);
                $$ = returnStmtNode;
            }
            ;
var 		: ID
		    {
                tree* varNode = maketree(VAR);
	 	        int index = super_ST_lookup($1, scopeName);
                if (index == -1) {
                    yyerror("Undeclared variable");
                } else {
                    strTable[index].calls++;
                }
		        addChild(varNode, maketreeWithVal(IDENTIFIER, index));
                $$ = varNode;
            }
		    | ID LSQ_BRKT addExpr RSQ_BRKT
		    {
                tree* varNode = maketree(VAR);
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
                addChild(varNode, maketreeWithVal(IDENTIFIER, index));
                addChild(varNode, maketree(ARRAYSIZE));
                addChild(varNode->children[1], $3);
                $$ = varNode;
            }
		    ;
expression 	: addExpr
		    {
                tree* expressionNode = maketree(EXPRESSION);
                addChild(expressionNode, $1);
                $$ = expressionNode;
            }
		    | expression relop addExpr
            {
                tree* expressionNode = maketree(EXPRESSION);
                addChild($2, $1);
                addChild($2, $3);
                addChild(expressionNode, $2);
                $$ = expressionNode;
            }
            ;
relop 		: OPER_LTE
            {
                $$ = maketreeWithVal(RELOP, LTE);                
		    }
		    | OPER_LT
		    {
		        $$ = maketreeWithVal(RELOP, LT);     
            }
		    | OPER_GT
            {
                $$ = maketreeWithVal(RELOP, GT);     
            }
		    | OPER_GTE
		    {
                $$ = maketreeWithVal(RELOP, GTE);     
            }
		    | OPER_EQ
            {
                $$ = maketreeWithVal(RELOP, EQ);     
            }
		    | OPER_NEQ
            {   
                $$ = maketreeWithVal(RELOP, NEQ);     
            }
            ;
addExpr 	: term
            {
                tree* addExprNode = maketree(ADDEXPR);
                addChild(addExprNode, $1);
                $$ = addExprNode;
            }
		    | addExpr addop term
		    {
                tree* addExprNode = maketree(ADDEXPR);
                addChild($2, $1);
                addChild($2, $3);
                addChild(addExprNode, $2);
                $$ = addExprNode;
            }
            ;
addop 		: OPER_ADD
		    {
                $$ = maketreeWithVal(ADDOP, ADD);     
            }
		    | OPER_SUB
		    {
                $$ = maketreeWithVal(ADDOP, SUB);     
            }
            ;
term 		: factor
            {
                tree* termNode = maketree(TERM);
                addChild(termNode, $1);
                $$ = termNode;
            }
		    | term mulop factor
		    {
                tree* termNode = maketree(TERM);
                addChild($2, $1);
                addChild($2, $3);
                addChild(termNode, $2);
                $$ = termNode;
            }
            ;
mulop 		: OPER_MUL
            {
                $$ = maketreeWithVal(MULOP, MUL);     
            }
		    | OPER_DIV
		    {
                $$ = maketreeWithVal(MULOP, DIV);     
            }
            ;
factor 		: LPAREN expression RPAREN
		    {
                tree* factorNode = maketree(FACTOR);
                addChild(factorNode, $2);
                $$ = factorNode;
            }
		    | var
		    {
                tree* factorNode = maketree(FACTOR);
                addChild(factorNode, $1);
                $$ = factorNode;
            }
		    | funcCallExpr
		    {
                tree* factorNode = maketree(FACTOR);
                addChild(factorNode, $1);
                $$ = factorNode;
            }
		    | INTCONST
		    {
		        tree* factorNode = maketree(FACTOR);
		        addChild(factorNode, maketreeWithVal(INT, $1));
                $$ = factorNode;
            }
		    | CHARCONST
            {
		        tree* factorNode = maketree(FACTOR);
		        addChild(factorNode, maketreeWithVal(CHAR, $1));
                $$ = factorNode;
            }
		    | STRCONST
		    {
		        tree* factorNode = maketree(FACTOR);
		        addChild(factorNode, maketreeWithVal(STR, curr_string));
                strcpy(string_list[curr_string], $1);

                curr_string++;
                $$ = factorNode;
            }
            ;
funcCallExpr 	: ID LPAREN argList RPAREN
		        {
                    tree* funcCallExprNode = maketree(FUNCCALLEXPR);
		            int index = super_ST_lookup($1, "global");
                    if (index == -1) {
                        yyerror("Undefined function");
                    } 
                    tree * child = maketreeWithVal(IDENTIFIER, index);
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

                    addChild(funcCallExprNode, child);
                    addChild(funcCallExprNode, $3);
                    $$ = funcCallExprNode;
                }
		        | ID LPAREN RPAREN
		        {
                    tree *funcCallExprNode = maketree(FUNCCALLEXPR);
                    int index = super_ST_lookup($1, "global");
                    if (index == -1) {
                        yyerror("Undefined function");
                    }
                    tree * child = maketreeWithVal(IDENTIFIER, index);
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
                    
                    addChild(funcCallExprNode, child);
                    $$ = funcCallExprNode;
                }
                ;
argList 	: expression
		    {
                tree* argListNode = maketree(ARGLIST);
                addChild(argListNode, $1);
                $$ = argListNode;
            }
            | argList COMMA expression
            {
                tree* argListNode = maketree(ARGLIST);
                addChild(argListNode, $1);
                addChild(argListNode, $3);
                $$ = argListNode;
            }
            ;
%%

int yyerror(char * msg){
    errors++;
    printf("error: line %d: %s\n", yylineno, msg);
    return 0;
}
