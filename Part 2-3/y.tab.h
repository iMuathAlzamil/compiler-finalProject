/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    NUMBER = 259,
    INT = 260,
    PROG = 261,
    VAR = 262,
    BEG = 263,
    END = 264,
    PRNT = 265,
    STRING = 266,
    SEMICOLON = 267,
    COLON = 268,
    PERIOD = 269,
    COMMA = 270,
    LPAREN = 271,
    RPAREN = 272,
    QUOTE = 273,
    EQUAL = 274,
    EXPRSIGN = 275,
    FACTORSIGN = 276
  };
#endif
/* Tokens.  */
#define ID 258
#define NUMBER 259
#define INT 260
#define PROG 261
#define VAR 262
#define BEG 263
#define END 264
#define PRNT 265
#define STRING 266
#define SEMICOLON 267
#define COLON 268
#define PERIOD 269
#define COMMA 270
#define LPAREN 271
#define RPAREN 272
#define QUOTE 273
#define EQUAL 274
#define EXPRSIGN 275
#define FACTORSIGN 276

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 71 "parser.y" /* yacc.c:1909  */

	char *name;
	int index;

#line 101 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
