%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

digit   [0-9]

%%

{digit}+(\.{digit}+)?   { yylval.val = atof(yytext); return NUMBER; }
[ \t]+                  ; // Ignore whitespace
\n                      { return '\n'; }
"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
.                       { return yytext[0]; }  // Return any other character as is

%%

int yywrap() {
    return 1;
}
