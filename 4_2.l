%{
int lowercase_count = 0;
int uppercase_count = 0;
%}

%%
[A-Z] { uppercase_count++; }
[a-z] { lowercase_count++; }
.|\n  ; // Ignore other characters
%%

int main() {
    yylex();
    printf("Total Uppercase Letters: %d\n", uppercase_count);
    printf("Total Lowercase Letters: %d\n", lowercase_count);
    return 0;
}

int yywrap() {
    return 1;
}
