aexp:
	ocamlbuild -use-ocamlfind -package qcheck aexp.byte
	ocamlbuild -use-ocamlfind -package qcheck aexp.cma

stmtlang:
	ocamlbuild -use-ocamlfind -package qcheck stmtlang.byte
	ocamlbuild -use-ocamlfind -package qcheck stmtlang.cma

clean:
	rm -f tmp.bc output.txt
	ocamlbuild -clean
