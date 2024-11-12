%{
#include "y.tab.h"
#include <string.h>
%}

%%

"while"                 { return WHILE; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }
[0-9]+                  { yylval.str = strdup(yytext); return NUM; }
"("                     { return '('; }
")"                     { return ')'; }
"{"                     { return '{'; }
"}"                     { return '}'; }
"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }
"="                     { return '='; }
[ \t\n]+                ; // Ignore whitespace
.                       { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
