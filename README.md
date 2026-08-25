# CV

A single-file LaTeX CV built with the [color-cv](https://github.com/Teddy-van-Jerry/color-cv) document class and compiled with XeLaTeX.

## Prerequisites

- A TeX distribution with XeLaTeX (e.g. TeX Live)
- [latexmk](https://ctan.org/pkg/latexmk)

## Usage

```bash
make          # build PDF
make pdf      # build PDF
make watch    # rebuild on save
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
