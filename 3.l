
%{
    int count =0;
%}

alpha [a-zA-Z]*
start (A|a){alpha}

%%
{start} {count+=1;}
.  ;
%%

int yywrap(){
    return 1;
}

int main(int argc, char *argv[]){
 
    yylex();

    printf("\n Words start with A:- %d \n",count);

    return 0;
}
    