# Dit bestand is een Makefile, en kan worden gebruikt met GNU Make
# (https://www.gnu.org/software/make/).
# Om dit bestand te gebruiken om de slides van de presentatie te genereren open
# je een terminal in deze map, en voer je het `make` commando uit.

# Hieronder volgt de uitleg over hoe dit bestand is opgebouwd.


tex_sources := $(wildcard sections/*.tex)
# Deze variabele bevat alle .tex-bestanden onder sections.

# Het eerste `target` in het bestand wordt standaard uitgevoerd wanneer `make`
# wordt gestart zonder argumenten. Hier geef ik aan dat ik wil dat dan
# `main.pdf` en `exercises/oefeningen.pdf` worden gemaakt.
all: main.pdf exercises/oefeningen.pdf

# 'main.pdf' moet worden bijgewerkt als een of meer van de volgende bestanden veranderd zijn,
# met het commando dat hieronder ingesprongen staat:
main.pdf: main.tex $(tex_sources) diagrams
	latexmk -pdf -pdflatex="pdflatex -shell-escape -interaction=nonstopmode" main.tex

# Helpercommando om automatisch bij te werken bij veranderingen in de .tex-bestanden.
watch: diagrams
	latexmk -pdf -pdflatex="pdflatex -shell-escape -interaction=nonstopmode" -pvc main.tex

diagram_sources: $(wildcard graphs/*.gv)
# Deze variabele bevat alle bronbestanden voor de verschillende diagrammen in de presentatie.

# De diagrammen worden allemaal opnieuw gegenereerd wanneer er een of meerdere zijn veranderd:
diagrams: $(diagram_sources)
	for file in graphs/branching*.gv; do\
		dot -Teps -o graphs/`basename $$file .gv`.eps $$file;\
	done
	for file in graphs/basis*.gv; do\
		dot -Teps -o graphs/`basename $$file .gv`.eps $$file;\
	done
	dot -Teps -o graphs/dagview.eps graphs/dagview.gv

EX_TEX_SOURCES := $(wildcard exercises/*.tex)
# .tex-bestanden in de map exercises
exercises/oefeningen.pdf: exercises/main.tex $(EX_TEX_SOURCES)
	cd exercises; \
		latexmk -pdf -jobname=oefeningen -shell-escape main.tex
