arithmetic_expressions.byte: arithmetic_expressions.ml
	ocamlbuild -use-ocamlfind -package qcheck arithmetic_expressions.byte
	./arithmetic_expressions.byte

generators.byte: generators.ml
	ocamlbuild -use-ocamlfind -package qcheck generators.byte
	./generators.byte

clean:
	ocamlbuild -clean
