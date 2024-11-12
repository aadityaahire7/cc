%{
int count = 0;
%}
alpha [a-zA-Z]+
start (A|a)*{alpha}(A|a)

%%
{start} {count+=1;}
.|\n                ; // Ignore other characters
%%

int main() {
    yylex();
    printf("Total words beginning and ending with 'a': %d\n", count);
    return 0;
}

int yywrap() {
    return 1;
}
