%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char *s);
int yylex();
%}

%union {
    double val;
}

%token <val> NUMBER
%type <val> expr

%left '+' '-'
%left '*' '/'
%right UMINUS

%%
E:
    '\n'
    | expr '\n' { printf("Result: %f\n", $1); }
    | error '\n' { yyerror("Invalid expression, try again."); yyerrok; }
    ;

expr:
    NUMBER         { $$ = $1; }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { if ($3 == 0) { yyerror("Division by zero"); $$ = 0; } else { $$ = $1 / $3; } }
    | '-' expr %prec UMINUS { $$ = -$2; }
    | '(' expr ')' { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
    printf("Enter expressions for evaluation:\n");
    yyparse();
    return 0;
}
