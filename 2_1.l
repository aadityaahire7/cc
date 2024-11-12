%{
int char_count = 0;
int whitespace_count = 0;
int tab_count = 0;
%}

%%
[ \t\n] { 
    char_count++; 
    if (*yytext == ' ') whitespace_count++;
    else if (*yytext == '\t') tab_count++;
}
. { char_count++; }
%%

int main() {
    yylex();
    printf("Total Characters: %d\n", char_count);
    printf("White Spaces: %d\n", whitespace_count);
    printf("Tabs: %d\n", tab_count);
    return 0;
}

int yywrap() {
    return 1;
}
