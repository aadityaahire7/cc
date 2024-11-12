%{
#include <stdio.h>
FILE *yyin, *yyout;
%}

lower [a-z]
upper [A-Z]
space [ ]

%%

{lower} { fprintf(yyout, "%c", yytext[0] - 32); }
{upper} { fprintf(yyout, "%c", yytext[0] + 32); }
{space} { fprintf(yyout, " "); }
.       ;

%%

int yywrap() {
    return 1;
}

int main() {
    yyin = fopen("4_3.txt", "r");
    yyout = fopen("output.txt", "w");

    if (yyin == NULL || yyout == NULL) {
        printf("Error opening file.\n");
        return 1;
    }

    yylex();

    fclose(yyin);
    fclose(yyout);

    printf("Processing completed. Check 'output.txt' for results.\n");
    return 0;
}
