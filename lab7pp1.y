%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

%}

/* Define YYSTYPE as a union to handle string tokens */
%union {
    char *str;
}

%token <str> NUMBER
%token PLUS MINUS MULTIPLY DIVIDE LPAREN RPAREN
%left PLUS MINUS
%left MULTIPLY DIVIDE
%right UMINUS
%%
lines: expr { printf("\n"); }
      ;

expr: expr PLUS expr      { printf("+ "); }
    | expr MINUS expr     { printf("- "); }
    | expr MULTIPLY expr  { printf("* "); }
    | expr DIVIDE expr    { printf("/ "); }
    | LPAREN expr RPAREN  { /* do nothing, parentheses are discarded */ }
    | MINUS expr %prec UMINUS { printf("-"); }
    | NUMBER              { printf("%s ", $1); free($1); }
    ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter an infix expression (e.g., (3 + 4) * 5):\n");
    return yyparse();
}