%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex();

int temp_count = -1;
int label_count = 0;
int stack[100];
int top = -1;

void codegen(const char *op);
void codegen_assign(char *id);
void push(char *text);
void push_temp(int t);
int pop_temp();
int new_label();
void backpatch(int label);

%}

%union {
    char *str;
}

%token <str> ID NUM WHILE
%token '<' '>' EQ NE LE GE

%left '+' '-'
%left '*' '/'

%%

// Start symbol that derives statements
S: Stmt
 ;

Stmt: WHILE '(' Cond ')' '{' StmtList '}' {
        int start_label = new_label();
        int end_label = new_label();
      }
    | ID '=' E { codegen_assign($1); }
 ;

StmtList: Stmt
        
 ;

Cond: E '<' E  { codegen("<"); }
    | E '>' E  { codegen(">"); }
    | E EQ E   { codegen("=="); }
    | E NE E   { codegen("!="); }
    | E LE E   { codegen("<="); }
    | E GE E   { codegen(">="); }
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
 | ID     { push($1); }
 | NUM    { push($1); }
 ;

%%

int main() {
    printf("Enter a WHILE loop or assignment statement:\n");
    return yyparse();
}

void yyerror(const char *s) {
    printf( "Error: %s\n", s);
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
    printf(" t%d = t%d %s t%d\n", temp_count, left, op, right);
    printf(" while t%d \n", temp_count);

    push_temp(temp_count);
}

void codegen_assign(char *id) {
    int val = pop_temp();
    printf("%s = t%d\n", id, val);
}

int new_label() {
    return label_count++;
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
