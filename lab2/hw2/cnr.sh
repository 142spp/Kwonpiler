bison -d hw2.y --debug
flex hw2.l
gcc -o hw2 hw2.tab.c lex.yy.c -lfl 
./hw2 < test.txt
