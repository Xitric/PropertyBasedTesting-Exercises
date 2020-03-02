hashtable: hashtable.ml
	ocamlbuild -use-ocamlfind -package qcheck,qcstm,ppx_deriving.show hashtable.native
	./hashtable.native

queuetest: queuetest.ml
	ocamlbuild -use-ocamlfind -package qcheck,qcstm,ppx_deriving.show queuetest.native
	./queuetest.native

clean:
	ocamlbuild -clean
