merge.byte: merge.ml
	ocamlbuild -use-ocamlfind -package qcheck merge.byte
	./merge.byte

integers.byte: integers.ml
	ocamlbuild -use-ocamlfind -package qcheck integers.byte
	./integers.byte

euclid.byte: euclid.ml
	ocamlbuild -use-ocamlfind -package qcheck euclid.byte
	./euclid.byte

fibonacci.byte: fibonacci.ml
	ocamlbuild -use-ocamlfind -package qcheck fibonacci.byte
	./fibonacci.byte

clean:
	ocamlbuild -clean
