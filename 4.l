
%{
#include <stdio.h>
%}

lower [a-z]
upper [A-Z]
space [ ]

%%

{lower} {printf("%c", yytext[0] - 32);}
{upper} {printf("%c", yytext[0] + 32);}

{space} {printf(" ");}
. ;

%%

int yywrap(){
    return 1;
}

int main(){

    yylex();

    return 0;
}
    