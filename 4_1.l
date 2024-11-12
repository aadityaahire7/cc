%%
[A-Z] { printf("%c is an uppercase letter\n", *yytext); }
[a-z] { printf("%c is a lowercase letter\n", *yytext); }
[^a-zA-Z] { printf("%c is a non-alphabetic character\n", *yytext); }
%%

int main() {
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
