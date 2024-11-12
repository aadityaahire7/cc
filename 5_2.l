%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int hexToDecimal(const char *hex) {
    int decimalValue = 0;
    for (int i = 2; hex[i] != '\0'; i++) { // Skip "0x" or "0X"
        decimalValue *= 16;
        if (isdigit(hex[i])) {
            decimalValue += hex[i] - '0';
        } else {
            decimalValue += toupper(hex[i]) - 'A' + 10;
        }
    }
    return decimalValue;
}
%}

%%

0[xX][0-9a-fA-F]+ {
    int num = hexToDecimal(yytext);
    printf("Hexadecimal: %s, Decimal: %d\n", yytext, num);
}
\n { /* Ignore newlines */ }
.  { /* Ignore other characters */ }
%%

int main() {
    printf("Enter a hexadecimal number (start with 0x):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
