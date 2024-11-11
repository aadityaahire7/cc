
%{
    int count =0;  
%}

alpha [a-zA-Z]
digit [0-9]
content ({alpha}|{digit})+".com"

%%
{content} {count += 1;}

%%
int yywrap(){
    return 1;
}
int main(int argc, char *argv[]){
    yylex();
    printf("Count:- %d  n",count); // remove space
    return 0;
}
    