%{
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#ifndef YYSTYPE
#define YYSTYPE char*  
#endif
#include<string.h>
int yylex();
int yyparse();
FILE* yyin;
void yyerror(const char* s);
char NumSave[10];
%}


%token '+' '-' '*' '/' 
%token LPAREN RPAREN 
%token NUMBER 


%left '+' '-'
%left '*' '/'
%right UMINUS

%start lines
%%

lines   :       lines expr ';' { printf("%s\n", $2); }
        |       lines ';'
        |
        ;


expr    :       expr '+' expr   { $$ = (char*)malloc((strlen($1)+ strlen($3) + 3)*sizeof(char));strcpy($$, $1);strcat($$," ");strcat($$, $3);strcat($$, " +"); }
        |       expr '-' expr   { $$ = (char*)malloc((strlen($1)+ strlen($3) + 3)*sizeof(char));strcpy($$, $1);strcat($$," ");strcat($$, $3);strcat($$, " -"); }
        |       expr '*' expr   { $$ = (char*)malloc((strlen($1)+ strlen($3) + 3)*sizeof(char));strcpy($$, $1);strcat($$," ");strcat($$, $3);strcat($$, " *"); }
        |       expr '/' expr   { $$ = (char*)malloc((strlen($1)+ strlen($3) + 3)*sizeof(char));strcpy($$, $1);strcat($$," ");strcat($$, $3);strcat($$, " /"); }
        |       '-' expr %prec UMINUS   { $$ = (char*)malloc((strlen($2)+ strlen(" -"))*sizeof(char));strcpy($$, $2);strcat($$," -"); }
        |       NUMBER  { $$ = (char*)malloc((strlen($1)+1)*sizeof(char));strcpy($$, $1);strcat($$, " "); }
        |       LPAREN expr RPAREN  { $$ = (char*)malloc((strlen($2)+1)*sizeof(char));strcpy($$, $2);strcat($$, " "); }
        ;

%%


int yylex()
{
    int t;
    while (1) 
    {
        t = getchar();
        if (t == ' ' || t == '\t' || t == '\n') 
        {
            // 忽略空白符
        } 
        else if (t>='0' && t<='9') 
        {
            // 解析多位数字返回字符串 
            int num = 0;
            NumSave[num]=t;
            t = getchar();
            while (t>='0'&& t<='9') 
            {
                num++;
                NumSave[num]=t;
                t = getchar();
            }
            NumSave[num+1]='\0';
            ungetc(t, stdin);
            yylval = NumSave; // 将字符串存储在yylval中
            // printf("%s\n", NumSave);
            return NUMBER;
        } 
        else if (t == '+') 
        {
            return '+';
        }
        else if (t == '-') 
        {
            return '-';
        } 
        else if (t == '*') 
        {
            return '*';
        } 
        else if (t == '/') 
        {
            return '/';
        } 
        else if (t == '(') 
        {
            return LPAREN;
        } 
        else if (t == ')') 
        {
            return RPAREN;
        } 
        else 
        {
            return t;
        }
    }
}

int main(void)
{
    yyin = stdin;
    do 
    {
        yyparse();
    } while (!feof(yyin));
    return 0;
}

void yyerror(const char* s)
{
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}

