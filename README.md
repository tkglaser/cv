# CV

A single-file LaTeX CV built with the [color-cv](https://github.com/Teddy-van-Jerry/color-cv) document class and compiled with XeLaTeX.

## Prerequisites

- A TeX distribution with XeLaTeX (e.g. TeX Live)
- [latexmk](https://ctan.org/pkg/latexmk)
- [pandoc](https://pandoc.org/) (for DOCX output)

## Usage

```bash
make          # build PDF and DOCX
make pdf      # build PDF only
make docx     # build DOCX from the PDF
make watch    # rebuild on save (PDF + DOCX)
make clean    # remove build artifacts
```

Output goes to `dist/`. Intermediate build files go to `build/`.

## Project Structure

- `cv.tex` — CV content
- `cv.cls` — document class defining layout, fonts, colors, and custom commands
- `.latexmkrc` — latexmk config (XeLaTeX, output to `dist/`, intermediates to `build/`)
- `Makefile` — build targets

## License

MIT
