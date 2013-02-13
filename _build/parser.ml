type token =
  | EOF
  | INT of (Range.t * int32)
  | X of (Range.t)
  | ADD of (Range.t)
  | SUB of (Range.t)
  | MUL of (Range.t)
  | EQ of (Range.t)
  | SLA of (Range.t)
  | SRA of (Range.t)
  | SRL of (Range.t)
  | NEQ of (Range.t)
  | LT of (Range.t)
  | LTEQ of (Range.t)
  | GT of (Range.t)
  | GTEQ of (Range.t)
  | NOT of (Range.t)
  | BNOT of (Range.t)
  | BAND of (Range.t)
  | BOR of (Range.t)
  | LPAR of (Range.t)
  | RPAR of (Range.t)

open Parsing;;
# 2 "parser.mly"
open Ast;;
# 28 "parser.ml"
let yytransl_const = [|
    0 (* EOF *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* X *);
  259 (* ADD *);
  260 (* SUB *);
  261 (* MUL *);
  262 (* EQ *);
  263 (* SLA *);
  264 (* SRA *);
  265 (* SRL *);
  266 (* NEQ *);
  267 (* LT *);
  268 (* LTEQ *);
  269 (* GT *);
  270 (* GTEQ *);
  271 (* NOT *);
  272 (* BNOT *);
  273 (* BAND *);
  274 (* BOR *);
  275 (* LPAR *);
  276 (* RPAR *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\003\000\000\000\001\000"

let yydgoto = "\002\000\
\004\000\005\000"

let yysindex = "\255\255\
\255\254\000\000\000\000\000\000\002\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\000\000"

let yytablesize = 2
let yytable = "\001\000\
\003\000\006\000"

let yycheck = "\001\000\
\002\001\000\000"

let yynames_const = "\
  EOF\000\
  "

let yynames_block = "\
  INT\000\
  X\000\
  ADD\000\
  SUB\000\
  MUL\000\
  EQ\000\
  SLA\000\
  SRA\000\
  SRL\000\
  NEQ\000\
  LT\000\
  LTEQ\000\
  GT\000\
  GTEQ\000\
  NOT\000\
  BNOT\000\
  BAND\000\
  BOR\000\
  LPAR\000\
  RPAR\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Ast.exp) in
    Obj.repr(
# 36 "parser.mly"
            ( _1 )
# 118 "parser.ml"
               : Ast.exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Range.t) in
    Obj.repr(
# 41 "parser.mly"
        ( Arg )
# 125 "parser.ml"
               : Ast.exp))
(* Entry toplevel *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let toplevel (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.exp)
