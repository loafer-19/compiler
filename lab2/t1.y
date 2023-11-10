%{
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#include<string.h>

#ifndef YYSTYPE
#define YYSTYPE double
#endif

int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);
%}

%token '+' '-' '*' '/'  

%token L_PAREN R_PAREN
%token NUMBER

%left '+' '-'           
%left '*' '/'
%right UMINUS
%left L_PAREN R_PAREN        

%%

lines   :       lines expr ';' { printf("%f\n", $2); }
        |       lines ';'
        |
        ;

expr    :       expr '+' expr   { $$ = $1 + $3;  }
        |       expr '-' expr   { $$ = $1 - $3; }
        |       expr '*' expr   { $$ = $1 * $3; }
        |       expr '/' expr   { $$ = $1 / $3; }
        |       L_PAREN expr R_PAREN   { $$ = $2; }
        |       NUMBER  { $$ = $1; }
        ;

%%

int yylex()
{
    int token;
    while(1)
    {
        token = getchar();
        if (token == ' ' || token == '\t' || token == '\n' || token == '\r')
        {
            continue;
        }
        else if (token >= '0' && token <= '9')
        {
            int temp = 0;
            while (token >= '0' && token <= '9')
            {
                temp = temp * 10 + (token - '0');
                token = getchar();
            }
            yylval = temp;
            ungetc(token, stdin);
            return NUMBER;
        }
        else if (token == '+')
        {
            return '+';
        }
        else if (token == '-')
        {
            return '-';
        }
        else if (token == '*')
        {
            return '*';
        }
        else if (token == '/')
        {
            return '/';
        }
        else if (token == '(')
        {
            return L_PAREN;
        }
        else if (token == ')')
        {
            return R_PAREN;
        }
        else
        {
            return token;
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

