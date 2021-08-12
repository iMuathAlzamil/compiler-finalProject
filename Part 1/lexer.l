/*Definition Section*/
%{
	#include<stdio.h>
%}

/*Rule Section*/
%%	
^"(*"[^("*)")]*"*)\r\n" ;
"(*"[^("*)")]*"*)\r\n" { fprintf(yyout, "\r\n"); };
" "" "+ ;
" "*," "* { fprintf(yyout, ", "); };
" "*;" "* { fprintf(yyout, ";"); };
\'.*=.*\' { ECHO; };
" "[+\-\*\/=]" " { ECHO; };
[+\-\*\/=]" " { fprintf(yyout, " "); ECHO; };
" "[+\-\*\/=] { ECHO; fprintf(yyout, " "); };
[+\-\*\/=] { fprintf(yyout, " "); ECHO; fprintf(yyout, " "); };
"( " { fprintf(yyout, "("); };
" )" { fprintf(yyout, ")"); };
%%

/*call the yywrap function */
int yywrap()
{
	return 1;
}

int main()
{
	yyin = fopen("final.txt", "r");
	yyout = fopen("nowhitespace.txt", "w");
	yylex();
	return 0;
}