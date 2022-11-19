/* definitions */

%{
#include <../obj/y.tab.h>

#include<stdio.h>
int processComment();
int processString();
extern int yyerror();

typedef enum {false, true} bool; // c does come with bool

int yycol = 0;
char errmsg[256];
char buffer[100];
char string[1000];
/* error text for illegal tokens
        (specific symbol is set at time of error) */
char illegaltoken[] = "Illegal Token '_'";
%}

newline     \n
CR          \r
whitespace  [ \t]+
yylineno = 1;
yycol = 0;

%%

 /* rules */

{whitespace}            {yycol += yyleng;}
{newline}               {yycol = 0; yylineno++;}
{CR}                    {/* ignore CR to handle windows newline */}

"if"                    {yycol += yyleng; return KWD_IF;}
"else"                  {yycol += yyleng; return KWD_ELSE;}
"while"                 {yycol += yyleng; return KWD_WHILE;}
"int"                   {yycol += yyleng; return KWD_INT;}
"string"                {yycol += yyleng; return KWD_STRING;}
"char"                  {yycol += yyleng; return KWD_CHAR;}
"return"                {yycol += yyleng; return KWD_RETURN;}
"void"                  {yycol += yyleng; return KWD_VOID;}

"+"                     {yycol++; return OPER_ADD;}
"-"                     {yycol++; return OPER_SUB;}
"*"                     {yycol++; return OPER_MUL;}
"/"                     {yycol++; return OPER_DIV;}
"<"                     {yycol++; return OPER_LT;}
">"                     {yycol++; return OPER_GT;}
">="                    {yycol += yyleng; return OPER_GTE;}
"<="                    {yycol += yyleng; return OPER_LTE;}
"=="                    {yycol += yyleng; return OPER_EQ;}
"!="                    {yycol += yyleng; return OPER_NEQ;}
"="                     {yycol++; return OPER_ASGN;}

"["                     {yycol++; return LSQ_BRKT;}
"]"                     {yycol++; return RSQ_BRKT;}
"{"                     {yycol++; return LCRLY_BRKT;}
"}"                     {yycol++; return RCRLY_BRKT;}
"("                     {yycol++; return LPAREN;}
")"                     {yycol++; return RPAREN;}
","                     {yycol++; return COMMA;}
";"                     {yycol++; return SEMICLN;}

0|[1-9][0-9]*           {yycol += yyleng; yylval.value = atoi(yytext); return INTCONST;} // cheanged from this {yycol += yyleng; yylval.strval = strdup(yytext); return INTCONST;}
[a-zA-Z][a-zA-Z0-9]*    {yycol += yyleng; yylval.strval = strdup(yytext); return ID;}
0[0-9]+                 {sprintf(errmsg, "(%d:%d): Integer has leading zeros", yylineno, yycol); printf("%s\n", errmsg); return ERROR;}
0[a-zA-Z][a-zA-Z0-9]*   {sprintf(errmsg, "(%d:%d): Id has leading zeros", yylineno, yycol); printf("%s\n", errmsg); return ERROR;}
\'\\[0abtnvfre]\'       {/* ignore control characters: null, carriage return, tab, newline, etc. */}
\'.\'                   {yycol += yyleng; yylval.value = yytext[1]; return CHARCONST;}
\"\"                    {/* ignore empty string */}

\"                      {processString();}

"/*"                    {processComment();}

.                       {yycol++; illegaltoken[15] = yytext[0]; yyerror(illegaltoken);}

%%
int processString() {
    int curr_pos = 0;
    int start_pos = yycol, start_line = yylineno;
    int curr_char = 0; // start position for the value we return to parser
    bool valid = true;

    yycol++; // for the character '"'
    char c = input(); // get next character
    curr_pos++;

    // Look through the string indefinitely
    while (1) {
        if (c == EOF){
            // Append the error to our error string which will be printed when we return
            sprintf(buffer, "(%d:%d): Unterminated string\n", start_line, start_pos);
            strcat(errmsg, buffer);
            memset(buffer, 0, sizeof(buffer));
            // print out all errors
            printf("%s\n", errmsg);
            return ERROR;
        }

        if (c == '\n'){
            // Append the error to our error string which will be printed when we return
            sprintf(buffer, "(%d:%d): String crossed line boundary\n", start_line, start_pos);
            strcat(errmsg, buffer);
            memset(buffer, 0, sizeof(buffer));

            yylineno++; // new line
            yycol = 0;
            curr_pos = 0; // reset position
            valid = false; // Instructions say comments cannot span multiple lines
        }
        // because we can have infinite '\' in succession and there are still valid but \b isnt
        while (c == '\\'){
            c = input();
            curr_pos++;
            // if its a valid escape char
            if (c == '\\' || c == 'n' || c == 't' || c == '"'){
                switch (c){
                    case 'n':
                        c = '\n';
                        break;
                    case 't':
                        c = '\t';
                        break;
                }
                string[curr_char] = c;
                curr_char++;

                string[curr_char] = '\0';
                c = input();
                curr_pos++;
            } else { // if its not a valid escape character
                // Append the error to our error string which will be printed when we return
                sprintf(buffer, "(%d:%d): Undefined escape character\n", yylineno, curr_pos);
                strcat(errmsg, buffer);
                memset(buffer, 0, sizeof(buffer));

                valid = false;
            }
        }
        // if we reach the end of the string
        if (c == '"'){
            yycol += curr_pos;
            // if its a valid string return that its a valid string
            if (valid){
                strcpy(yytext, string);
                yylval.strval = strdup(yytext);
                return STRCONST;
            } else { // otherwise its invalid
                // print out all errors
                printf("%s\n", errmsg);
                return ERROR;
            }
        }
        // get current char and add it to the string we return to the parser
        string[curr_char] = c;
        curr_char++;
        string[curr_char] = '\0';
        c = input();
        curr_pos++;
    }

}

int processComment() {
    int curr_pos = 0; // for updating yycol
    int start_pos = yycol, start_line = yylineno;
    bool valid = true;

    // move to comment position
    yycol += yyleng;

    // get next char
    int c1 = 0, c2 = input();
    curr_pos++;

    // go through the comment
    while (1) {
        // until we hit the end of the file
        if (c2 == EOF){
            // Append the error to our error string which will be printed when we return
            sprintf(errmsg, "(%d:%d): Unterminated comment", start_line, start_pos);
            // print out all errors
            printf("%s\n", errmsg);
            return ERROR;
        }
        if (c2 == '\n'){
            // Append the error to our error string which will be printed when we return
            sprintf(buffer, "(%d:%d): Comment crossed line boundary\n", start_line, start_pos);
            strcat(errmsg, buffer);
            memset(buffer, 0, sizeof(buffer));

            curr_pos = 0;
            yylineno++;
            yycol = 0;
            valid = false; // Instructions say comments cannot span multiple lines
        } // end when we hit the end of the comment
        if (c1 == '*' && c2 == '/'){
            yycol += curr_pos;
            break;
            if (!valid) {
                // print out all errors
                printf("%s\n", errmsg);
            }
        }
        c1 = c2;
        c2 = input();
        curr_pos++;
    }
}
// user routines

