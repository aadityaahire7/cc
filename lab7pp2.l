%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

digit   [0-9]+
decimal {digit}"."{digit}  
%%
({digit}"."{digit})  { yylval = atof(yytext); return NUMBER; }
{digit}              { yylval = atof(yytext); return NUMBER; }
"+"                  { return PLUS; }
"-"                  { return MINUS; }
"*"                  { return MULTIPLY; }
"/"                  { return DIVIDE; }
\n                   { return EOL; }
[ \t]                ; /* ignore whitespace */
.                    ; /* ignore any other character */
%%

int yywrap() {
    return 1;
}
