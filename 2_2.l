%{
int token_count = 0;
%}

%%
[^\n\t ]+ { token_count++; } // Match any token (non-whitespace sequence)
[\n\t ]   ; // Ignore white spaces and tabs
%%

int main() {
    yylex();
    printf("Total Tokens: %d\n", token_count);
    return 0;
}

int yywrap() {
    return 1;
}
