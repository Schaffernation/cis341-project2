%{
open Ast;;
%}

/* Declare your tokens here. */
%token EOF
%token <Range.t * int32> INT
%token <Range.t> X        /* X  */
%token <Range.t> ADD      /* +  */
%token <Range.t> SUB			/* -  */
%token <Range.t> MUL			/* *  */
%token <Range.t> EQ				/* == */
%token <Range.t> SLA			/* << */
%token <Range.t> SRA			/* >> */
%token <Range.t> SRL			/* >>> */
%token <Range.t> NEQ			/* != */
%token <Range.t> LT				/* <  */
%token <Range.t> LTEQ     /* <= */
%token <Range.t> GT				/* >  */
%token <Range.t> GTEQ			/* >= */
%token <Range.t> NOT			/* !  */
%token <Range.t> BNOT			/* ~	*/
%token <Range.t> BAND			/* &	*/
%token <Range.t> BOR			/* |  */
%token <Range.t> LPAR			/* (	*/
%token <Range.t> RPAR			/* )  */


/* ---------------------------------------------------------------------- */
%start toplevel
%type <Ast.exp> toplevel
%type <Ast.exp> exp
%%

toplevel:
  | exp EOF { $1 }

/* Declare your productions here, starting with 'exp'. */

exp:
  | X   { Arg }
