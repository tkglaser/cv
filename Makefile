TEX = cv.tex

all: pdf docx

pdf:
	latexmk $(TEX)

docx: pdf
	pandoc $(TEX) -o dist/cv.docx

watch:
	latexmk -pvc -e '$$success_cmd = "pandoc $(TEX) -o dist/cv.docx"' $(TEX)

clean:
	latexmk -c $(TEX)
	rm -f dist/cv.docx

.PHONY: all pdf docx watch clean
