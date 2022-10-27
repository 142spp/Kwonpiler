%{
#include <stdio.h>
%}
%token IDENT
%token NUMBER
%token COLOEQ EQ NOTEQ LT GT LE GE
%token CONST VAR FUNCTION
%token BEGINN END IF THEN WHILE DO RETURN
%token WRITE WRITELN ODD

%union{
  char* name;
  int val;
}

%%
program : block '.' {printf("program -> block .\n");} 
;
block : decList statement {printf("block -> decList statement\n");}
;
decList : decList decl {printf("decList -> decList decl\n");}
| {printf("decList -> EMPTY\n");}
;
decl : constDecl {printf("decl -> constDecl\n");}
| varDecl {printf("decl -> varDecl\n");}
| funcDecl {printf("decl -> funcDecl\n");}
;
constDecl : CONST numberList ';' {printf("constDecl -> CONST numberList ;\n");}
;
numberList : IDENT EQ NUMBER {printf("numberList -> IDENT EQ NUMBER\n");}
| numberList COMMA IDENT EQ NUMBER {printf("numberList -> COMMA IDENT EQ NUMBER\n");}
;
varDecl : VAR identList ';' {printf("varDecl -> VAR identList ;\n");}
;
identList : IDENT {printf("identList -> IDENT\n");}
| identList COMMA IDENT {printf("identList -> identList COMMA IDENT\n");}
;
optParList : parList  {printf("optParList -> parList\n");}
| {printf("optParList -> EMPTY\n");}
;
parList : IDENT {printf("parList -> IDENT\n");}
| parList COMMA IDENT {printf("parList -> parList COMMA IDENT\n");}
;
funcDecl : FUNCTION IDENT '('optParList')' block ';' {printf("funcDecl -> FUNCTION IDENT (optParList) block ;\n");}
;
statement : IDENT COLOEQ expression {printf("statement -> IDENT COLOEQ expression\n");}
| BEGINN statement stateList END {printf("statement -> BEGINN statement stateList END\n");}
| IF condition THEN statement {printf("statement -> IF condition THEN statement\n");}
| WHILE condition DO statement {printf("statement -> WHILE condition DO statement\n");}
| RETURN expression {printf("statement -> RETURN expression\n");}
| WRITE expression {printf("statement -> WRITE expression\n");}
| WRITELN {printf("statement -> WRITELN\n");}
| {printf("statement -> EMPTY\n");}
;
stateList : stateList ';' statement {printf("stateList -> stateList ; statement\n");}
| {printf("stateList -> EMPTY\n");}
;
condition : ODD expression {printf("condition -> ODD expression\n");}
| expression EQ expression {printf("condition -> expression EQ expression\n");}
| expression NOTEQ expression {printf("condition -> expression NOTEQ expression\n");}
| expression LT expression {printf("condition -> expression LT expression\n");}
| expression GT expression {printf("condition -> expression GT expression\n");}
| expression LE expression {printf("condition -> expression LE expression\n");}
| expression GE expression {printf("condition -> expression GE expression\n");}
;
expression : '-' term termList {printf("expression -> - term termList\n");}
| term termList {printf("expression -> term termList\n");}
;
termList : termList '+' term {printf("termList -> termList + term\n");}
| termList '-' term {printf("termList -> termList - term\n");}
| {printf("termList -> EMPTY\n");}
;
term : factor factList {printf("term -> factor factList\n");}
;
factList : factList '*' factor {printf("factList -> factList * factor\n");}
| factList '/' factor {printf("factList -> factList / factor\n");}
| {printf("factList -> EMPTY\n");}
;
factor : IDENT {printf("factor -> IDENT\n");}
| NUMBER {printf("factor -> NUMBER\n");}
| IDENT '('expList')' {printf("factor -> IDENT (expList)\n");}
| '('expression')' {printf("factor -> (expression)\n");}
;
expList : expression {printf("expList -> expression\n");}
| expList COMMA expression {printf("expList -> expList COMMA expression\n");}
;
COMMA : ',' {printf("COMMA -> ,\n");}
;
%%

int main (int argc, char *argv[]){
  
  #ifdef YYDEBUG
    yydebug = 1;
  #endif
  
  yyparse();
}
yyerror(char *s){
  fprintf(stderr, "erros : %s\n", s);
}

