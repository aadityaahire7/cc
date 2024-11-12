%{
#include <stdio.h>
#include <stdlib.h>

int result = 0;
int current = 0;
char operator = '+';

void calculate() {
    if (operator == '+') result += current;
    else if (operator == '-') result -= current;
    else if (operator == '*') result *= current;
    else if (operator == '/') result /= current;
}

%}

%%
[0-9]+      { current = atoi(yytext); calculate(); }
\n         { printf("Result: %d\n", result); result = 0; operator = '+'; }
"[-+*/]"    { operator = yytext[0]; }
[ \t\n]     ; // Ignore whitespace
.           { }

%%

int main() {
    printf("Enter expressions (end with '=' to calculate):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
