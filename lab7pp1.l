%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

%}

digit   [0-9]+
%%
{digit}    { yylval.str = strdup(yytext); return NUMBER; }
"("        { return LPAREN; }
")"        { return RPAREN; }
"+"        { return PLUS; }
"-"        { return MINUS; }
"*"        { return MULTIPLY; }
"/"        { return DIVIDE; }
[ \t\n]    ; /* ignore whitespace including newline */
.          ; /* ignore any other character */
%%

int yywrap() {
    return 1;
}


