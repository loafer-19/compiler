#include "Ast.h"
#include "SymbolTable.h"
#include <string>
#include "Type.h"

extern FILE *yyout;
int Node::counter = 0;
//level是缩进
Node::Node()
{
    seq = counter++;
}
//以 "program" 为根节点输出AST。然后，它递归调用根节点的 output 方法，传递缩进级别 4 以便输出子节点
void Ast::output()
{
    fprintf(yyout, "program\n");
    if(root != nullptr)
        root->output(4);
}
//输出二元表达式节点的方法。
//它首先根据运算符类型输出运算符的字符串表示
//然后递归调用 output 方法输出操作数节点 expr1 和 expr2。
void BinaryExpr::output(int level)
{
    std::string op_str;
    switch(op)
    {
        case ADD:
            op_str = "add";
            break;
        case SUB:
            op_str = "sub";
            break;
        case AND:
            op_str = "and";
            break;
        case OR:
            op_str = "or";
            break;
        case LESS:
            op_str = "less";
            break;
    }
    fprintf(yyout, "%*cBinaryExpr\top: %s\n", level, ' ', op_str.c_str());
    expr1->output(level + 4);
    expr2->output(level + 4);
}
//输出常量节点
void Constant::output(int level)
{
    std::string type, value;
    type = symbolEntry->getType()->toStr();
    value = symbolEntry->toStr();
    fprintf(yyout, "%*cIntegerLiteral\tvalue: %s\ttype: %s\n", level, ' ',
            value.c_str(), type.c_str());
}
//获取标识符的名称、作用域和类型信息，然后输出这些信息。
void Id::output(int level)
{
    std::string name, type;
    int scope;
    name = symbolEntry->toStr();
    type = symbolEntry->getType()->toStr();
    scope = dynamic_cast<IdentifierSymbolEntry*>(symbolEntry)->getScope();
    fprintf(yyout, "%*cId\tname: %s\tscope: %d\ttype: %s\n", level, ' ',
            name.c_str(), scope, type.c_str());
}
//输出复合语句节点的方法。它输出 "CompoundStmt"
//然后递归调用 output 方法输出子语句 stmt。
void CompoundStmt::output(int level)
{
    fprintf(yyout, "%*cCompoundStmt\n", level, ' ');
    stmt->output(level + 4);
}
//用于输出顺序语句节点的方法。
//它输出 "Sequence"，然后递归调用 output 方法输出两个子语句 stmt1 和 stmt2。
void SeqNode::output(int level)
{
    fprintf(yyout, "%*cSequence\n", level, ' ');
    stmt1->output(level + 4);
    stmt2->output(level + 4);
}
//用于输出声明语句节点的方法。它输出 "DeclStmt"，然后递归调用 output 方法输出标识符 id。
void DeclStmt::output(int level)
{
    fprintf(yyout, "%*cDeclStmt\n", level, ' ');
    id->output(level + 4);
}
//用于输出条件语句节点的方法。
//它输出 "IfStmt"，然后递归调用 output 方法输出条件表达式 cond 和执行体 thenStmt。
void IfStmt::output(int level)
{
    fprintf(yyout, "%*cIfStmt\n", level, ' ');
    cond->output(level + 4);
    thenStmt->output(level + 4);
}
//if else
//它输出 "IfElseStmt"
//然后递归调用 output 方法输出条件表达式 cond、if 分支 thenStmt 和 else 分支 elseStmt。
void IfElseStmt::output(int level)
{
    fprintf(yyout, "%*cIfElseStmt\n", level, ' ');
    cond->output(level + 4);
    thenStmt->output(level + 4);
    elseStmt->output(level + 4);
}
//用于输出返回语句节点的方法。
//它输出 "ReturnStmt"，然后递归调用 output 方法输出返回值表达式 retValue。
void ReturnStmt::output(int level)
{
    fprintf(yyout, "%*cReturnStmt\n", level, ' ');
    retValue->output(level + 4);
}
//输出赋值语句节点的方法。
//它输出 "AssignStmt"，然后递归调用 output 方法输出左值表达式 lval 和右值表达式 expr。
void AssignStmt::output(int level)
{
    fprintf(yyout, "%*cAssignStmt\n", level, ' ');
    lval->output(level + 4);
    expr->output(level + 4);
}
//输出函数定义节点的方法。
//它获取函数的名称和类型信息，然后输出这些信息，并递归调用 output 方法输出函数体 stmt。
void FunctionDef::output(int level)
{
    std::string name, type;
    name = se->toStr();
    type = se->getType()->toStr();
    fprintf(yyout, "%*cFunctionDefine function name: %s, type: %s\n", level, ' ', 
            name.c_str(), type.c_str());
    stmt->output(level + 4);
}
