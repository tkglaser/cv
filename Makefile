TEX = cv.tex

all: pdf

pdf:
	latexmk $(TEX)

watch:
	latexmk -pvc $(TEX)

clean:
	latexmk -c $(TEX)

.PHONY: all pdf watch clean
