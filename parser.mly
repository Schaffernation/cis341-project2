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
	| exp BOR  exp50 { Binop (Or, $1, $3) }
	| exp50 { $1 }

exp50:
	| exp50 BAND exp60 { Binop (And, $1, $3) }
	| exp60 { $1 }

exp60:
	| exp60 EQ  exp70 { Binop (Eq , $1, $3) }
	| exp60 NEQ exp70 { Binop (Neq, $1, $3) } 
	| exp70 { $1 }

exp70:
	| exp70 LT   exp80 {Binop (Lt , $1, $3) }
	| exp70 LTEQ exp80 {Binop (Lte, $1, $3) }
	| exp70 GT   exp80 {Binop (Gt , $1, $3) }
	| exp70 GTEQ exp80 {Binop (Gte, $1, $3) }
	| exp80 { $1 }

exp80:
	| exp80 SLA exp90 {Binop (Shl, $1, $3) } 
	| exp80 SRA exp90 {Binop (Sar, $1, $3) }
	| exp80 SRL exp90 {Binop (Shr, $1, $3) }
	| exp90 { $1 }

exp90:
	| exp90 ADD exp100 {Binop (Plus , $1, $3) }
	| exp90 SUB exp100 {Binop (Minus, $1, $3) }
	| exp100 { $1 }

exp100:
	| exp100 MUL exp110 {Binop (Times, $1, $3) }
	| exp110 { $1 }

exp110:
	| NOT  exp110 { Unop (Lognot, $2) }
	| BNOT exp110 { Unop (Not	 , $2) }
	| SUB  exp110 { Unop (Neg	 , $2) }
	| exp120 { $1 }

exp120:
	| LPAR exp RPAR { $2 }
	| exp130 { $1 }

exp130:
  | X   { Arg }
	| INT { Cint (snd $1) } 

