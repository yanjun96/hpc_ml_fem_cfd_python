PDF = main.pdf
LTX = main.tex
FIG = plot.pdf
DAT = data.txt

$(PDF):	$(LTX)	$(FIG) $(DAT)
	pdflatex $(LTX)

$(FIG):	$(FIG) $(DAT)
	python plot.py

