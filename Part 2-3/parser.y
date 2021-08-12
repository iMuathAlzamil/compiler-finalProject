%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	extern int yyparse();
	extern int yylex();
	extern int yylineno, yychar;
	extern FILE *yyin, *yyout;
	int size = 0;
	char vars[20][20];
	
	int findVar(char *var)
	{
		int i;
		for(i = 0; i < size; i++) {
			if(strcmp(vars[i], var) == 0) {
				return i;
			}
		}
		return -1;
	}

	void addVar(char *var)
	{
		strncpy(vars[size], var, 20);
		size++;
	}

	void yyerror(const char *s)
	{
		if(strstr(s, "PROG\0") != NULL)
			fprintf(stderr, "PROGRAM is expected");
		else if(strstr(s, "VAR\0") != NULL)
			fprintf(stderr, "VAR is expected");
		else if(strstr(s, "BEGIN\0") != NULL)
			fprintf(stderr, "BEGIN is expected");
		else if(strstr(s, "SEMICOLON\0") != NULL)
			fprintf(stderr, "; is missing");
		else if(strstr(s, "PERIOD\0") != NULL)
			fprintf(stderr, ". is missing");
		else if(strstr(s, "LPAREN\0") != NULL)
			fprintf(stderr, "( is missing");
		else if(strstr(s, "RPAREN\0") != NULL)
			fprintf(stderr, ") is missing");
		else if(strstr(s, "COMMA\0") != NULL)
			fprintf(stderr, ", is missing");
		else if(strstr(s, "EQUAL\0") != NULL)
			fprintf(stderr, "= is missing");
		else if(strstr(s, "END\0") != NULL)
			fprintf(stderr, "END is expected");
		else
			fprintf(stderr, "%s", s);

		fclose(yyout);
		yyout = fopen("abc123.cpp", "w");
		fprintf(yyout, "");
		exit(1);
	}

	void replaceSingleQuote(char *str)
	{
		int i;
		for(i = 0; i < strlen(str); i++) {
			if(str[i] == '\'') {
				str[i] = '\"';
			}
		}
	}
%}

%union {
	char *name;
	int index;
}

%start start
%token <name> ID
%token NUMBER INT PROG VAR BEG END PRNT STRING SEMICOLON COLON PERIOD COMMA LPAREN RPAREN QUOTE EQUAL EXPRSIGN FACTORSIGN
%type <index> NUMBER
%type <name> expr term factor output dec type INT STRING EXPRSIGN FACTORSIGN

%error-verbose

%%
start: PROG pname SEMICOLON VAR dec_list SEMICOLON BEG stat_list END PERIOD ;

pname: ID { fprintf(yyout, "#include <iostream>\nusing namespace std;\nint main()\n{\n"); };

dec_list: dec COLON type { fprintf(yyout, "%s %s;\n", $<name>3, $<name>1); } ;

dec: dec COMMA ID { addVar($<name>3); 
					char line[50]; 
					strncpy(line, $1, 50);
					strcat(line, ", ");
					strcat(line, $<name>3);
					$$ = line; }
	 | ID { addVar($<name>1); $$ = $<name>1; };

stat_list: stat SEMICOLON { fprintf(yyout, "return 0;\n}"); }
           | stat SEMICOLON stat_list;

stat: print 
      | assign ;

print: PRNT LPAREN output RPAREN { fprintf(yyout, "cout << %s;\n", $3); };

output: STRING COMMA ID { if(findVar($<name>3) == -1) { yyerror("UNKNOWN IDENTIFIER"); } 
						  else { char line[50]; 
								 replaceSingleQuote($1);
								 strncpy(line, $1, 50); 
								 strcat(line, " << ");
								 strcat(line, $<name>3);
								 $$ = line; }}
        | ID { if(findVar($<name>1) == -1) { yyerror("UNKNOWN IDENTIFIER"); } else { $$ = $<name>1; } };

assign: ID EQUAL expr { if(findVar($<name>1) == -1) { yyerror("UNKNOWN IDENTIFIER"); } 
						else { fprintf(yyout, "%s = %s;\n", $<name>1, $3); }};

expr: expr EXPRSIGN term { char line[50]; 
						   strncpy(line, $1, 50); 
						   strcat(line, " "); 
						   strcat(line, $2); 
						   strcat(line, " "); 
						   strcat(line, $3); 
						   $$ = line; }
	  | term { $$ = $1; };

term: term FACTORSIGN factor { char line[50]; 
							   strncpy(line, $1, 50); 
							   strcat(line, " "); 
							   strcat(line, $2); 
							   strcat(line, " "); 
							   strcat(line, $3); 
							   $$ = line; }
	  | factor { $$ = $1; };

factor: ID { if(findVar($<name>1) == -1) { yyerror("UNKNOWN IDENTIFIER"); } 
			 else { $$ = $<name>1; } }
		| NUMBER { sprintf($$, "%d", $1); }
		| LPAREN expr RPAREN { char line[50]; 
							   strncpy(line, "( ", 50); 
							   strcat(line, $2); 
							   strcat(line, " )"); 
							   $$ = line; } ;

type: INT { $$ = $1; };
%%

int main()
{
	yyin = fopen("nowhitespace.txt", "r");
	yyout = fopen("abc123.cpp", "w");
	yyparse();
}
