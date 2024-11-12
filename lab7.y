%{
#include <stdio.h>
#include <stdlib.h>

int yylex();  // Declare yylex function
void yyerror(const char *s);

void push(int);
int pop();
int stack[100], sp = 0;
%}

%token NUMBER
%token PLUS MINUS MULTIPLY DIVIDE EOL
%left PLUS MINUS  // Lower precedence for addition and subtraction
%left MULTIPLY DIVIDE // Higher precedence for multiplication and division
%%
S: expr EOL { printf("= %d\n", pop()); }
      ;

expr: NUMBER          { push($1); }
    | expr expr PLUS    { int b = pop(); int a = pop(); push(a + b); }
    | expr expr MINUS   { int b = pop(); int a = pop(); push(a - b); }
    | expr expr MULTIPLY { int b = pop(); int a = pop(); push(a * b); }
    | expr expr DIVIDE  { int b = pop(); int a = pop(); push(a / b); }
    ;
%%

void push(int val) {
        stack[sp++] = val;
}

int pop() {
    if (sp > 0) {
        return stack[--sp];
    } else {
        yyerror("Error: Stack underflow\n");
        exit(1);
    }
}

void yyerror(const char *s) {
    printf("Error: %s\n", s);
}

int main() {
    printf("Enter postfix expressions (e.g., 4 4 -):\n");
    return yyparse();
}
