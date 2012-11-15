
#
# Exemple de fichier Makefile pour lancer le formattage
# des fichiers article.tex et resume.tex
#

CIBLES = article.pdf

PDFLATEX = pdflatex

all:	$(CIBLES)

article.pdf: article.tex article.bib
	$(PDFLATEX) article.tex
	bibtex article
	$(PDFLATEX) article.tex
	$(PDFLATEX) article.tex

clean:
	rm -f $(CIBLES) *.aux *.log *.blg *.bbl
