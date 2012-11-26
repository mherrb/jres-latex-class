
#
# Exemple de fichier Makefile pour lancer le formattage
# du fichier article.tex
#

CIBLES = article.pdf

PDFLATEX = pdflatex

all:	$(CIBLES)

# 3 passages de latex pour assurer une coherence de la
# bibliographie
article.pdf: article.tex article.bib
	$(PDFLATEX) article.tex
	bibtex article
	$(PDFLATEX) article.tex
	$(PDFLATEX) article.tex

clean:
	rm -f $(CIBLES) *.aux *.log *.blg *.bbl *.out
