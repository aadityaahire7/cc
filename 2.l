%{
    int c=0, k=0, l=0, i=0, s=0;
    FILE *file;
%}

alpha [a-zA-Z]
digit [0-9]
comment "//".*
keyword (if|else|for|while|switch|case|break|continue|return|int|float|double|string|boolean)
identifier {alpha}({alpha}|{digit})*
line \n+
space [ ]+

%%

{comment} {c++;}
{keyword} {k++;}
{identifier} {i++;}
{line} {l++;}
{space} {s++;}

. ;

%%

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) {
    file = fopen("2.txt", "r");
    if (!file) {
        perror("Unable to open file");
        return 1;
    }
    yyin = file;
    yylex();
    fclose(file);

    printf("\n comments %d", c);
    printf("\n keywords %d", k);
    printf("\n identifiers %d", i);
    printf("\n lines %d", l + 1);
    printf("\n space %d", s);
    
    return 0;   
}
