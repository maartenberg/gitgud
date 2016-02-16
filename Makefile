pdf: graphs
	pdflatex -shell-escape main.tex

diagrams:
	for file in graphs/branching*.gv; do\
		dot -Teps -o graphs/`basename $$file .gv`.eps $$file;\
	done
	for file in graphs/basis*.gv; do\
		dot -Teps -o graphs/`basename $$file .gv`.eps $$file;\
	done
