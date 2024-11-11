
%{
    int count = 0;
         FILE *file;

%}

alpha [a-zA-Z]
digit [0-9]
end (in|com|org|edu|eu|ru)

%%
({alpha}|{digit})+"@"{alpha}+"."{end} { count++; }
. {/* Do nothing */} // This will suppress the output of other characters

%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]){

FILE *file = fopen(argv[1],"r+");
    yyin = file;
    yylex();
    printf("count:- %d",count);
        fclose(file);

    return 0;
}
    