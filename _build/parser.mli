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

val toplevel :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.exp
