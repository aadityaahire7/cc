%{
#include <stdio.h>
#include <stdlib.h>
%}

%%

[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}  { printf("Valid\n"); }
\n                                               { /* Ignore newlines */ }
.*                                               { printf("Invalid\n"); }

%%

int main() {
    printf("Enter email addresses (one per line):\n");
    yylex();   // Start lexical analysis
    return 0;
}

int yywrap() {
    return 1;
}