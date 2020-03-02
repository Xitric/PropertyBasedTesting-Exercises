hashtable: hashtable.ml
	ocamlbuild -use-ocamlfind -package qcheck,qcstm,ppx_deriving.show hashtable.native
	./hashtable.native

queuetest: queuetest.ml
	ocamlbuild -use-ocamlfind -package qcheck,qcstm,ppx_deriving.show queuetest.native
	./queuetest.native

queue: queue.ml
	ocamlbuild -use-ocamlfind -package qcheck,qcstm,ppx_deriving.show queue.native
	./queue.native

clean:
	ocamlbuild -clean
