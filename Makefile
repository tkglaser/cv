TEX = cv.tex

all: pdf docx

pdf:
	latexmk $(TEX)

DOCX_SRC = build/cv-docx.tex

docx: pdf
	$(MAKE) docx-only

# Generates dist/cv.docx without forcing a PDF rebuild first (used by `watch`,
# which already has latexmk running its own PDF build loop).
docx-only:
	{ cat docx-preamble.tex; \
	  grep -E '^\\(name|title|phone|email|social)[\[{]' $(TEX); \
	  sed -n '/^\\begin{document}/,/^\\end{document}/p' $(TEX) \
	    | sed 's/\\cvskillentry\*/\\cvskillentrystar/g; s/\\cvskilllegend\*/\\cvskilllegendstar/g'; \
	} > $(DOCX_SRC)
	pandoc $(DOCX_SRC) -o dist/cv.docx

watch:
	latexmk -pvc -e '$$success_cmd = "$(MAKE) docx-only"' $(TEX)

clean:
	latexmk -c $(TEX)
	rm -f dist/cv.docx

.PHONY: all pdf docx docx-only watch clean
