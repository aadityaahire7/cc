%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

int temp_count = -1; // Start from -1 to get t0 as the first temp variable
int stack[100]; // Stack for temporary variables
int top = -1;

void codegen(const char *op);
void codegen_umin();
void codegen_assign(char *id);
void push(char *text);
void push_temp(int t);
int pop_temp();

%}

%union {
    char *str;
}

%token <str> ID NUM

%left '+' '-'
%left '*' '/'

%%

S: ID '=' E { codegen_assign($1); }
 ;

E: E '+' T { codegen("+"); }
 | E '-' T { codegen("-"); }
 | T
 ;

T: T '*' F { codegen("*"); }
 | T '/' F { codegen("/"); }
 | F
 ;
F: '(' E ')' 
 | '-' F  { codegen_umin(); }
 | ID     { push($1); }
 | NUM    { push($1); }
 ;

%%

int main() {
    printf("Enter an arithmetic expression:\n");
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

void push(char *text) {
    temp_count++;
    printf("t%d = %s\n", temp_count, text);
    push_temp(temp_count);
}

void codegen(const char *op) {
    int right = pop_temp();
    int left = pop_temp();
    temp_count++;
    printf("t%d = t%d %s t%d\n", temp_count, left, op, right);
    push_temp(temp_count);
}

void codegen_umin() {
    int val = pop_temp();
    temp_count++;
    printf("t%d = -t%d\n", temp_count, val);
    push_temp(temp_count);
}

void codegen_assign(char *id) {
    int val = pop_temp();
    printf("%s = t%d\n", id, val);
}

void push_temp(int t) {
    stack[++top] = t;
}

int pop_temp() {
    if (top == -1) {
        yyerror("Stack underflow");
        exit(1);
    }
    return stack[top--];
}
