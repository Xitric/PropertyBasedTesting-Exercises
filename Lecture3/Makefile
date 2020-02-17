arithmetic_expressions.byte: arithmetic_expressions.ml
	ocamlbuild -use-ocamlfind -package qcheck arithmetic_expressions.byte
	./arithmetic_expressions.byte

generators.byte: generators.ml
	ocamlbuild -use-ocamlfind -package qcheck generators.byte
	./generators.byte

dice.byte: dice.ml
	ocamlbuild -use-ocamlfind -package qcheck dice.byte
	./dice.byte

red_black_trees.byte: red_black_trees.ml
	ocamlbuild -use-ocamlfind -package qcheck red_black_trees.byte
	./red_black_trees.byte

clean:
	ocamlbuild -clean
