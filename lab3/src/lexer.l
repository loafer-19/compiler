%option noyywrap
%option nounput
%option noinput
%option yylineno
%top{
    #include <stdarg.h>
    #include "common.h"
}

%{
    #include <iostream>
    #include <string>
    using namespace std;
    //多个源文件中共享全局变量，dump_type在common.h中定义：TOKENS,AST,IR,ASM
    extern dump_type_t dump_type;

    //根据指定的格式字符串将可变参数列表的内容输出到文件流yyout中
    inline void dump_tokens(const char* format, ...){
        va_list args;
        va_start(args, format);
        if (dump_type == TOKENS)
            vfprintf(yyout, format, args);
        va_end(args);
    }
    /* Your code here, if desired (lab3). */
    #include <math.h>
    #include <cstring>
    #include <stack>
    #include <list>
    list<int> zero{0};
    stack<int,list<int>> ScopeStack(zero);

    //列号（偏移）
    int offset = 0;
    int tbnum = 0;
    int table_len[1000]={0};
    class symbol_entry{
        public:
            string idname;
    };
    symbol_entry symboltable[500][100];//500个作用域，100个变量。 
    stack<int> ScopeStacktemp;
%}

/* definitions section */
DECIMIAL ([1-9][0-9]*|0)
/*八进制*/
OCTAL (0[0-7]+)           
/*十六进制*/
HEXADECIMAL (0[xX][0-9A-Fa-f]+) 
ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]
HEXADECIMIALFLOAT 0[xX](([a-fA-F0-9]+)|(([a-fA-F0-9]+)?\.[a-fA-F0-9]*))[Pp][+\-]?[0-9]*[0-9]+
DECIMIALFLOAT (([0-9]*\.[0-9]*)([eE][+\-]?[0-9]+)?)|([0-9]+[eE][+\-]?[0-9]+)
%x COMMENT


blockcommentbegin "/*"
blockcommentelement1 .
blockcommentelement2 \n
blockcommentend "*/"

SINGLE_LINE_COMMENT "//"[^\n]*

%%
    /* rules section */
"int" {
    dump_tokens("INT\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

"float" {
    dump_tokens("FLOAT\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"void" {
    dump_tokens("VOID\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

"main" {
    dump_tokens("MAIN\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

"double" {
    dump_tokens("DOUBLE\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"if" {
    dump_tokens("IF\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

"else" {
    dump_tokens("ELSE\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

"return" {
    dump_tokens("RETURN\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}
"const" {
    dump_tokens("CONST\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

"while" {
    dump_tokens("WHILE\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

"break" {
    dump_tokens("BREAK\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

"continue" {
    dump_tokens("CONTINUE\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}
 
"=" {
    dump_tokens("ASSIGN\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

"==" {
    dump_tokens("EQUAL\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

"!=" {
    dump_tokens("NOTEQUAL\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

"<=" {
    dump_tokens("LESSEQUAL\t\t%s\t%d\t%d\n", yytext,yylineno,offset);
    offset += strlen(yytext);
}

">=" {
    dump_tokens("GREATEREQUAL\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"<" {
    dump_tokens("LESS\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

">" {
    dump_tokens("GREATER\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"+" {
    dump_tokens("ADD\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"-" {
    dump_tokens("MINUS\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"*" {
    dump_tokens("PLUS\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"/" {
    dump_tokens("DIVIDE\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"%" {
    dump_tokens("MOD\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"&&" {
    dump_tokens("AND\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"||" {
    dump_tokens("OR\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"!" {
    dump_tokens("NOT\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

";" {
    dump_tokens("SEMICOLON\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"(" {
    dump_tokens("LPAREN\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

")" {
    dump_tokens("RPAREN\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"{" {
    dump_tokens("LBRACE\t\t%s\t%d\t%d\n", yytext, yylineno, offset);
    offset += strlen(yytext);
    ScopeStack.push(tbnum++);
}

"}" {
    dump_tokens("RBRACE\t\t%s\t%d\t%d\n", yytext, yylineno, offset);
    offset += strlen(yytext);
    ScopeStack.pop();
}

"[" {
    dump_tokens("LBRACET\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"]" {
    dump_tokens("RBRACET\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

"," {
    dump_tokens("COMMA\t\t%s\t%d\t%d\n",yytext,yylineno,offset);
    offset += strlen(yytext);
}

{DECIMIAL} {
    int decimal;
    decimal = atoi(yytext);//转换成int型
    dump_tokens("DECIMAL\t%s\t%d\t%d\t%d\n", yytext,yylineno,offset ,decimal);
    offset += strlen(yytext);
}

{OCTAL} {
    int octal;
    octal = atoi(yytext);
    dump_tokens("OCTAL\t\t%s\t%d\t%d\t%o\n",yytext,yylineno,offset,octal);
    offset += strlen(yytext);
}

{HEXADECIMAL} {
    int hex;
    hex = atoi(yytext);
    dump_tokens("HEXADECIMAL\t%s\t%d\t%d\t%x\n",yytext,yylineno,offset,hex);
    offset += strlen(yytext);
}

{HEXADECIMIALFLOAT} {
    int pointindex = -1;
    int len = strlen(yytext);
    for(int i = 0;i < len;i++)
    {
        if(yytext[i] == '.')
        {
            pointindex = i;
            break;
        }
    }

    float result = 0;
    int cur = 0;

    if(pointindex != -1){
        cur += 2;
        for(;cur < pointindex;cur++){
            if(yytext[cur] >= '0' && yytext[cur] <= '9')
            result = result * 16 + yytext[cur] - '0';
            else if(yytext[cur] >= 'a' && yytext[cur] <= 'f')
            result = result * 16 + yytext[cur] - 'a' + 10;
            else
            result = result * 16 + yytext[cur] - 'A' + 10;
        }

        cur++;

        float temp = 0;

        while(yytext[cur] != 'p' && yytext[cur] != 'P' && cur != len)
        {
            if(yytext[cur] >= '0' && yytext[cur] <= '9')

            temp = temp * 16 + yytext[cur] - '0';

            else if(yytext[cur] >= 'a' && yytext[cur] <= 'f')
            temp = temp * 16 + yytext[cur] - 'a' + 10;
            else
            temp = temp * 16 + yytext[cur] - 'A' + 10;
            cur++;
        }

        while(temp > 1)
        temp = temp / 16;
        result = result + temp;
        cur++;

        int flag = 1;

        if(yytext[cur] == '+' || yytext[cur] == '-')
        {
            if(yytext[cur] == '-')
            flag = 0;
            cur++;
        }

        int exponent = 0;
        for(int i = cur;i < len;i++)
        exponent = yytext[i] - '0' + exponent * 10;
        if(flag)
        result = result * pow(2,exponent);
        else
        result = result * pow(2,-exponent);
        }
    else{
        cur += 2;
        while(yytext[cur] != 'p' && yytext[cur] != 'P')
        {
            result = result * 16 + yytext[cur] - '0';
            cur++;
        }
        cur++;
        int flag = 1;
        if(yytext[cur] == '+' || yytext[cur] == '-')
        {
            if(yytext[cur] == '-')
            flag = 0;
            cur++;
        }
        int exponent = 0;
        for(int i = cur;i < len;i++)
        exponent = yytext[i] - '0' + exponent * 10;
        if(flag)
        result = result * pow(2,exponent);
        else
        result = result * pow(2,-exponent);
        }
    dump_tokens("HEXADECIMALFLOAT\t\t%s\t%d\t%d\t%f\n",yytext,yylineno,offset,result);
}

{DECIMIALFLOAT} {
    int pointindex = -1;
    int len = strlen(yytext);
    for(int i = 0;i < len;i++)
    {
        if(yytext[i] == '.')
        {
            pointindex = i;
            break;
        }
    }
    float result = 0;
    int cur = 0;
    if(pointindex != -1)//有.
    {
        for(;cur < pointindex;cur++){
        result += result * 10 + yytext[cur] - '0';
        }
        cur++;
        float temp = 0;
        while(yytext[cur] != 'e' && yytext[cur] != 'E' && cur != len)
        {
            temp = temp * 10 + yytext[cur] - '0';
            cur++;
        }
        while(temp > 1)
        temp = temp / 10;
        result = result + temp;
        if(cur != len){
        cur++;
        int flag = 1;
        if(yytext[cur] == '+' || yytext[cur] == '-')
        {
            if(yytext[cur] == '-')
            flag = 0;
            cur++;
        }
        int exponent = 0;
        for(int i = cur;i < len;i++)
        exponent = yytext[i] - '0' + exponent * 10;
        if(flag)
        {
            for(int i = 0;i < exponent;i++)
            result *= 10;
        }
        else
        {
            for(int i = 0;i < exponent;i++)
            result /= 10;
        }
        }
    }
    else//无.
    {
        while(yytext[cur] != 'e' && yytext[cur] != 'E' && cur != len)
        {
            result = result * 10 + yytext[cur] - '0';
            cur++;
        }
        if(cur != len){
        cur++;
        int flag = 1;
        if(yytext[cur] == '+' || yytext[cur] == '-')
        {
            if(yytext[cur] == '-')
            flag = 0;
            cur++;
        }
        int exponent = 0;
        for(int i = cur;i < len;i++)
        exponent = yytext[i] - '0' + exponent * 10;
        if(flag)
        {
            for(int i = 0;i < exponent;i++)
            result *= 10;
        }
        else
        {
            for(int i = 0;i < exponent;i++)
            result /= 10;
        }
        }
    }
    dump_tokens("DECIMALFLOAT\t\t%s\t%d\t%d\t%f\n",yytext,yylineno,offset,result);
}



{ID} {
    bool identifierFound = false;
    while(!ScopeStack.empty()){
        int cur = ScopeStack.top();
        ScopeStack.pop();
        ScopeStacktemp.push(cur);
        for(int i=0;i<table_len[cur];i++){
            if (symboltable[cur][i].idname == string(yytext)) {
            // 输出标识符信息
            dump_tokens("ID\t\t%s\t%d\t%d\t%p\n", yytext, yylineno, offset, &(symboltable[cur][i])); // %p输出指针的值
            identifierFound = true; // 找到了
            offset += strlen(yytext); // 偏移增加
            break;
            }
        }
        if(identifierFound){
            break;
        }
    }
    while (!ScopeStacktemp.empty()) {
        ScopeStack.push(ScopeStacktemp.top());
        ScopeStacktemp.pop();   
    }
    if (!identifierFound) {
        int cur = ScopeStack.top(); // 当前作用域
        // 添加到当前作用域的末尾
        int currentLength = table_len[cur];
        symboltable[cur][currentLength].idname = string(yytext);
        dump_tokens("ID\t\t%s\t%d\t%d\t%p\n", yytext, yylineno, offset, &(symboltable[cur][currentLength])); 
        table_len[cur]++;
        offset += strlen(yytext);
    }
}

{EOL} {
    /*yylineno++;*/
    offset = 0;
}

{WHITE} {
    offset += strlen(yytext);
}

{SINGLE_LINE_COMMENT} {
    /* Ignore it */
}

{blockcommentbegin} {BEGIN COMMENT;}//通过定义好的宏BEGIN切换状态，初始状态默认为INITIAL，因此在结束该状态时需要切换回初始状态。
<COMMENT>{blockcommentelement1} {}
<COMMENT>{blockcommentelement2} {/*yylineno++;*/}
<COMMENT>{blockcommentend} {BEGIN INITIAL;}



%%
/* user code section */
