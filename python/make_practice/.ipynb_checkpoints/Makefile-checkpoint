PDF = main.pdf
LTX = main.tex
FIG = figures/figure.pdf

$(PDF):$(LTX) $(FIG)
	pdflatex $(LTX)

$(FIG):figure.py
	python figure.py 
