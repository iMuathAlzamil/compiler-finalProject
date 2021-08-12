/*Definition Section*/
%{
	#include <stdio.h>
	#include <string.h>
	#include "y.tab.h"
%}

letter [a-f]
digit [0-9]

/*Rule Section To Remove Spaces And Comments*/
%%
{letter}({letter}|{digit})+ { yylval.name = strdup(yytext); return ID; }
{digit}+ { yylval.index = atoi(yytext); return NUMBER; }
"'"({letter}|{digit}|[ =\+\-\/\*])+"'" { yylval.name = strdup(yytext); return STRING; }
PROGRAM	{ return PROG; }
INTEGER { strncpy(yylval.name, "int", 20); return INT; }
VAR { return VAR; }
BEGIN { return BEG; }
END { return END; }
PRINT { return PRNT; }
; { return SEMICOLON; }
: { return COLON; }
, { return COMMA; }
\. { return PERIOD; }
\( { return LPAREN; }
\) { return RPAREN; }
"'" { return QUOTE; }
\= { return EQUAL; }
\+|\- { yylval.name = strdup(yytext); return EXPRSIGN; }
\*|\/ { yylval.name = strdup(yytext); return FACTORSIGN; }
[ \n\r\t] ;
%%

/*call the yywrap function */
int yywrap()
{
	return 1;
}
