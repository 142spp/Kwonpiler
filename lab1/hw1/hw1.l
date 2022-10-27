%{
#include <ctype.h>
unsigned symbolCount=0, digitCount=0, identCount=0, lineCount=0;
char* oplist_n[] = {"EQ","NOTEQ","LT","GT","LE","GE","COLOEQ"};
char* oplist_o[] = {"=","<>","<",">","<=",">=",":="};
%}

digit [0-9]+
symbol [+\-*/();,\.]
operator [=><]|[<>:]=|<>
reserve const|var|function|begin|end|if|then|while|do|return|write|writeln|odd
ident [A-Za-z|_][A-Za-z0-9]*
blank [ \t]
eol \n

%%
{digit} {
  digitCount++;
  printf("Number : %s\n",yytext);}
{symbol} {
  symbolCount++;
  printf("Symbol : %s\n",yytext);}
{operator} {
  int i=0;
  for(; i<7;i++){
    if(!strcmp(yytext,oplist_o[i])) printf("%s",oplist_n[i]);}
  printf(" : %s\n",yytext); }
{reserve} {
  for(int i=0; i<strlen(yytext);i++){
    printf("%c",toupper(yytext[i]));
  } printf(" : %s\n",yytext);}
{ident} {
  identCount++;
  printf("Identifier : %s\n",yytext);}
{eol} {lineCount++;}
{blank} {}
%%

int main(int argc, char* argv[]){
  yylex();

  printf("symbolCount : %d\n",symbolCount);
  printf("digitCount : %d\n",digitCount);
  printf("identCount : %d\n",identCount);
  printf("lineCount : %d\n",lineCount);

  return 0;
}
