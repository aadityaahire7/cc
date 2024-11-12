%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

%}

%token ID NUM FOR INCR

%%



for_loop: FOR '(' initialization ';' condition ';' increment ')' '{' body '}'
        {
            printf("Parsed a simple FOR loop.\n");
        }
        ;

initialization: ID '=' NUM
              ;

condition: ID '<' NUM
         ;

increment: ID INCR
         ;
body: ID '=' ID '+' NUM ';';

%%

int main() {
    printf("Enter a simple FOR loop to parse:\n");
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
