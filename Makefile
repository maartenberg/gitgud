tex_sources := $(wildcard sections/*.tex)
all: main.pdf exercises/oefeningen.pdf
main.pdf: main.tex $(tex_sources) diagrams
main.pdf: diagrams
	latexmk -pdf -pdflatex="pdflatex -shell-escape -interaction=nonstopmode" main.tex

diagram_sources: $(wildcard graphs/*.gv)
diagrams: $(diagram_sources)
	for file in graphs/branching*.gv; do\
		dot -Teps -o graphs/`basename $$file .gv`.eps $$file;\
	done
	for file in graphs/basis*.gv; do\
		dot -Teps -o graphs/`basename $$file .gv`.eps $$file;\
	done
	dot -Teps -o graphs/dagview.eps graphs/dagview.gv

EX_TEX_SOURCES := $(wildcard exercises/*.tex)
exercises/oefeningen.pdf: exercises/main.tex $(EX_TEX_SOURCES)
	cd exercises; \
		latexmk -pdf -jobname=oefeningen -shell-escape main.tex
