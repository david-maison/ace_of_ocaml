
PKG_ACE= ace_of_ocaml
PKG_TEST= test_ace

LIBS= ace_of_ocaml.a ace_of_ocaml.cma ace_of_ocaml.cmxa
TEST= test/main.js

all: $(LIBS) $(TEST)

$(LIBS): $(wildcard src/*.ml src/*.mli)
	ocp-build build ace_of_ocaml
	cp _obuild/ace_of_ocaml/ace_of_ocaml.* .

$(TEST): $(wildcard test/*.ml test/*.mli)
	ocp-build build $(PKG_TEST)
	js_of_ocaml _obuild/$(PKG_TEST)/$(PKG_TEST).byte
	cp _obuild/$(PKG_TEST)/$(PKG_TEST).js $@

clean:
	ocp-build clean
	rm -f ace_of_ocaml.*
	rm -f test/main.js
