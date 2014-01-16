all: build clean

build:
	ocamlc -a -o assertions.cma serializer.mli assertions.mli serializer.ml assertions.ml

clean:
	rm serializer.cmi serializer.cmo

uninstall:
	rm assertions.cma

