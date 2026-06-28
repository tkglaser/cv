all: pdf docx

pdf:
	latexmk

docx: pdf
	pandoc cv.tex -o dist/cv.docx

clean:
	latexmk -c
	rm -f dist/cv.docx

.PHONY: all pdf docx clean
