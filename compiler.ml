(* compiler.ml *)
(* A compiler for simple arithmetic expressions. *)

(******************************************************************************)

open Printf
open Ast
open X86   (* Note that Ast has similarly named constructors that must be 
              disambiguated.  For example: Ast.Shl vs. X86.Shl *)

(* Parse an AST from a preexisting lexbuf. 
 * The filename is used to generate error messages.
*)
let parse (filename : string) (buf : Lexing.lexbuf) : exp =
  try
    Lexer.reset_lexbuf filename buf;
    Parser.toplevel Lexer.token buf
  with Parsing.Parse_error ->
    failwith (sprintf "Parse error at %s."
        (Range.string_of_range (Lexer.lex_range buf)))


let (>::) x y = y :: x
let (>@ ) x y = y @  x
(* Builds a globally-visible X86 instruction block that acts like the C fuction:

   int program(int X) { return <expression>; }

   Follows cdecl calling conventions and platform-specific name mangling policy. *)
let compile_exp (ast:exp) : Cunit.cunit =
  let block_name = (Platform.decorate_cdecl "program") in
	let tmploc = stack_offset 0l in
	
	
	let rec emit_exp (e:exp) (str : insn list) : insn list = 
		begin match e with
		| Cint  i -> (Mov (eax, Imm i)) :: str
		| Arg 		-> (Mov (eax, edx)) :: str (* edx is the specified X container *)
		| Binop (b,e1,e2)	-> (proc_binop b e1 e2 str) @ str
		| Unop  (u, e1)	  -> (proc_uop u e1 str) @ str
	  end
	
	and proc_binop (b : binop) (e1 : exp) (e2 : exp) (str : insn list) : insn list = 
		let str_l =	(emit_exp e1 str) >:: (Push eax) in
		
		(emit_exp e2 str_l) >::
		begin match b with
		| Plus  -> (Add  (eax, tmploc)) 
		| Times -> (Imul (Eax, tmploc))
		| Minus -> (Sub  (eax, tmploc))
		| Ast.Eq-> (Cmp  (eax, tmploc)) >:: (Mov (eax, Imm 0l)) >:: (Setb (eax, Eq))
		| Neq   -> (Cmp  (eax, tmploc)) >:: (Mov (eax, Imm 0l)) >:: (Setb (eax, NotEq))
			
		end
		>:: (Add (esp, Imm 4l)) 
		
	and proc_uop (u : unop) (e1 : exp) (str : insn list) : insn list =
		failwith "blah"
	in
		
		
	
	failwith "implementing" (* dont forget to handle X into edx *)