{
  open Lexing
  open Parser
  open Range
  
  exception Lexer_error of Range.t * string

  let pos_of_lexpos (p:Lexing.position) : pos =
    mk_pos (p.pos_lnum) (p.pos_cnum - p.pos_bol)
    
  let mk_lex_range (p1:Lexing.position) (p2:Lexing.position) : Range.t =
    mk_range p1.pos_fname (pos_of_lexpos p1) (pos_of_lexpos p2)

  let lex_range lexbuf : Range.t = mk_lex_range (lexeme_start_p lexbuf)
      (lexeme_end_p lexbuf)

  let reset_lexbuf (filename:string) lexbuf : unit =
    lexbuf.lex_curr_p <- {
      pos_fname = filename;
      pos_cnum = 0;
      pos_bol = 0;
      pos_lnum = 1;
    }
    
  (* Boilerplate to define exceptional cases in the lexer. *)
  let unexpected_char lexbuf (c:char) : 'a =
    raise (Lexer_error (lex_range lexbuf,
        Printf.sprintf "Unexpected character: '%c'" c))

}

(* Declare your aliases (let foo = regex) and rules here. *)


let whitespace = ['\t' ' ' '\r' '\n']
let digit = ['0'-'9']


rule token = parse
  | eof { EOF }
	| whitespace+ { (token lexbuf) }
	| digit+ { let rng = (lex_range lexbuf) in
						 try 
							 let str = (lexeme lexbuf) in
							 let i32 = Int32.of_string str in
							 INT (rng, i32)
						 with
						   Lexer_error (r,s) -> 
				raise (Lexer_error (rng, (string_of_range rng)))
					  }

  | 'X'  { X (lex_range lexbuf) }
	| '+'  { ADD  (lex_range lexbuf) }
	| '-'  { SUB  (lex_range lexbuf) }
	| '*'  { MUL  (lex_range lexbuf) }

	| "==" { EQ   (lex_range lexbuf) }
	| "<<" { SLA  (lex_range lexbuf) }
	| ">>" { SRA  (lex_range lexbuf) }
	| ">>>"{ SRL  (lex_range lexbuf) }
	| "!=" { NEQ  (lex_range lexbuf) }
	| '<'	 { LT   (lex_range lexbuf) }
	| "<=" { LTEQ (lex_range lexbuf) }
	| '>'	 { GT   (lex_range lexbuf) }
	| ">=" { GTEQ (lex_range lexbuf) }
	| '!'	 { NOT  (lex_range lexbuf) }
	| '~'  { BNOT (lex_range lexbuf) }
	| '&'	 { BAND (lex_range lexbuf) }
	| '|'  { BOR  (lex_range lexbuf) }
	| '('  { LPAR (lex_range lexbuf) }
	| ')'  { RPAR (lex_range lexbuf) }

  | _ as c { unexpected_char lexbuf c }
