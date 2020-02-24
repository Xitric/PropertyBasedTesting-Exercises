shrinkers.byte: shrinkers.ml
	ocamlbuild -use-ocamlfind -package qcheck shrinkers.byte
	./shrinkers.byte

arithmetic_expressions.byte: arithmetic_expressions.ml
	ocamlbuild -use-ocamlfind -package qcheck arithmetics.byte arithmetic_expressions.byte
	./arithmetic_expressions.byte

clean:
	ocamlbuild -clean
