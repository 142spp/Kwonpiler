%{
%}

commentSingle "//"
commentMultBegin "/*"
commentMultEnd "*/"


%x CMNT

%%
{commentSingle}(.*) {printf("Single line comment\n");}
{commentMultBegin} BEGIN CMNT;

<CMNT>. |
<CMNT>\n;
<CMNT>{commentMultEnd} BEGIN INITIAL; {printf("Multi line command\n");}
%%

int main(int argc, char *argv){
   yylex();
   return 0;
}
