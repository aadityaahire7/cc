%{
int word_count = 0;
#define TARGET_WORD "world"
%}

%%
"world" { word_count++; } // Match the specific word "world" directly as a string
.|\n    ; // Ignore other characters
%%

int main() {
    yylex();
    printf("Frequency of the word '%s': %d\n", TARGET_WORD, word_count);
    return 0;
}

int yywrap() {
    return 1;
}
