
%{ 
    int num, r, hex_index = 0, i;
    char a[20];
     FILE *file;
%} 

DIGIT [0-9]+
NON_DIGIT [^0-9]+

%% 

{DIGIT} { 
    num = atoi(yytext);

    hex_index = 0;
    do {
        r = num % 16;
        if (r < 10) {
            a[hex_index++] = '0' + r;
        } else {
            a[hex_index++] = 'A' + (r - 10);
        }
        num = num / 16;
    } while (num != 0);

    
    for (i = hex_index - 1; i >= 0; i--) {
        printf("%c", a[i]);
    }
}

{NON_DIGIT} { 
    printf("%s", yytext);
}

%% 

int yywrap() {
    return 1;
}

int main(int argc, char *argv[]) { 
    FILE *file = fopen("5.txt", "r");
    yyin = file;
    yylex(); 
    fclose(file);
    return 0; 
}
    