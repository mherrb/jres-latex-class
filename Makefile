
#
# Exemple de fichier Makefile pour lancer le formattage
# des fichiers article.tex et resume.tex
#

CIBLES = article.pdf resume.pdf

PDFLATEX = pdflatex

all:	$(CIBLES)

article.pdf: article.tex article.bib
	$(PDFLATEX) article.tex
	bibtex article
	$(PDFLATEX) article.tex
	$(PDFLATEX) article.tex

resume.pdf: resume.tex # pas de biblio pour le resume
	$(PDFLATEX) resume.tex
	$(PDFLATEX) resume.tex	# pour le cas ou il y a des ref dans le resume

clean:
	rm -f $(CIBLES) *.aux *.log *.blg *.bbl
