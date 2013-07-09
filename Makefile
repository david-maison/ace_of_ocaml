
FLAGS = -bin-annot -g -annot
JSPKGS = -package js_of_ocaml,js_of_ocaml.syntax \
	 -syntax camlp4o -linkpkg
CAMLC = ocamlc
CAMLFIND = ocamlfind
CAMLJS = $(CAMLFIND) $(CAMLC) $(JSPKGS) $(FLAGS) 

all: 
	$(CAMLJS) -c ace.mli
	$(CAMLJS) -c ace.ml
	$(CAMLJS) -o main.byte ace.cmo main.ml
	js_of_ocaml main.byte

clean:
	rm -rf *~ *.cm[ioat] *.byte