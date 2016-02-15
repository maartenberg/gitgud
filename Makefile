pdf: graphs
	pdflatex -shell-escape main.tex

branchings:
	for file in graphs/branching*.gv; do\
		dot -Teps -o graphs/`basename $$file .gv`.eps $$file;\
	done
