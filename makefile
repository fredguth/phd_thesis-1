.PHONY: diss.pdf all clean clean-all

pdf: main.pdf

again: clean pdf

main.pdf: main.tex
	latexmk -pdf -pdflatex="pdflatex -file-line-error -interaction=nonstopmode" main.tex 2>&1 | grep "^.*:[0-9]*: .*$ "

diss.pdf: diss.tex
	latexmk -pdf -shell-escape -file-line-error -f diss.tex

fast: main.tex
	pdflatex main.tex
	open main.pdf

slow: clean-purge main.tex
	latexmk -pdf -pdflatex="pdflatex -file-line-error -interaction=batchmode" -halt-on-error main.tex 2>&1 | grep "^.*:[0-9]*: .*$ "
	open main.pdf

clean:
	latexmk -c
	$(RM) -f *.auxlock
	$(RM) -f *.aux
	$(RM) -f *.log
	$(RM) -f *.unq
	$(RM) -f *.run.xml
	$(RM) *.pdf
	$(RM) __latex*.*
	$(RM) Chapters/__latex*.*
	$(RM) frontbackmatter/__latex*.*


clean-all: clean
	$(RM) -f *.bbl

clean-purge: clean-all
	latexmk -C
