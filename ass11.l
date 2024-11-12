%{
#include <stdio.h>
#include <stdlib.h>

int num;           // Store the current number
int result = 0;    // Store the result of the entire expression
char operator = 0; // Store the last operator
%}

%%

[0-9]+ {
    num = atoi(yytext);  // Convert number to integer
    if (operator == 0) {
        result = num;  // Initialize result with the first number
    } else {
        switch(operator) {
            case '+': result += num; break;
            case '-': result -= num; break;
            case '*': result *= num; break;
            case '/':
                if (num == 0) {
                    printf("Error: Division by zero\n");
                    exit(1);
                }
                result /= num;
                break;
        }
    }
}

"+"     { operator = '+'; }   // Set operator to addition
"-"     { operator = '-'; }   // Set operator to subtraction
"*"     { operator = '*'; }   // Set operator to multiplication
"/"     { operator = '/'; }   // Set operator to division

"="     {                     // When '=' is encountered, print the result
    printf("Result: %d\n", result);
    return 0;
}

[ \t\n]+    ;                 // Ignore whitespace
.       { printf("Invalid character: %s\n", yytext); }  // Handle invalid input

%%

int main() {
    printf("Enter an expression (use +, -, *, /, and end with =):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
