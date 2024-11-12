%{
#include <stdio.h>
#include <stdlib.h>

// Function to convert decimal to binary and print it
void decimal_to_binary(int num) {
    if (num > 1)
        decimal_to_binary(num / 2);
    printf("%d", num % 2);
}
%}

%%
[0-9]+      { int num = atoi(yytext); printf("Decimal: %d, Binary: ", num); decimal_to_binary(num); printf("\n"); }
\n          { /* Ignore newlines */ }
.           { /* Ignore other characters */ }
%%

int main() {
    printf("Enter a decimal number:\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
