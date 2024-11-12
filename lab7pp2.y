%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);

void push(double);
double pop();
double stack[100];
int sp = 0;
%}

%token NUMBER
%token PLUS MINUS MULTIPLY DIVIDE EOL
%left PLUS MINUS
%left MULTIPLY DIVIDE
%%
S: expr EOL { printf("= %lf\n", pop()); }
      ;

expr: NUMBER          { push($1); }
    | expr expr PLUS    { double b = pop(); double a = pop(); push(a + b); }
    | expr expr MINUS   { double b = pop(); double a = pop(); push(a - b); }
    | expr expr MULTIPLY { double b = pop(); double a = pop(); push(a * b); }
    | expr expr DIVIDE  { double b = pop(); double a = pop(); push(a / b); }
    ;
%%

void push(double val) {
        stack[sp++] = val;
}

double pop() {
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
    printf("Enter postfix expressions with decimal numbers (e.g., 4.5 2.3 +):\n");
    return yyparse();
}
