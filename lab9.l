%{
#include "y.tab.h"
%}

%%

"for"         { return FOR; }
"("                 { return '('; }
")"                 { return ')'; }
";"                 { return ';'; }
"{"  { return '{'; }
"}"                 { return '}'; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }      // Identifier
[0-9]+              { yylval = atoi(yytext); return NUM; } // Numbers
"="                 { return '='; }
"<"                 { return '<'; }
"++"                { return INCR; }
"+"                 { return '+'; }
[ \t\n]+            ; // Ignore whitespace
.                   { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
