# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
make          # build PDF and DOCX (default target)
make pdf      # build PDF only (runs latexmk using xelatex, as configured in .latexmkrc)
make docx     # build DOCX from the PDF via pandoc
make clean    # remove build artifacts (latexmk intermediates + cv.docx)
```

## Architecture

This is a single-file LaTeX CV using a custom document class:

- **`cv.tex`** — the CV content. Edited directly to update personal info, publications, projects, and awards.
- **`cv.cls`** — the `color-cv` document class (based on the upstream [color-cv](https://github.com/Teddy-van-Jerry/color-cv) project). Defines layout, fonts, colors, and all custom commands.
- **`.latexmkrc`** — sets `$pdf_mode = 5` (xelatex), `$default_files = ('cv.tex')`, `$aux_dir = 'build'`, `$out_dir = 'dist'`. Intermediary files (aux, log, fls, etc.) go to `build/`; final outputs (PDF, DOCX) go to `dist/`.

### Custom commands defined in `cv.cls`

| Command | Purpose |
|---|---|
| `\name`, `\email`, `\linkedin`, `\brief`, etc. | Header fields; set before `\maketitle` |
| `\Textbf{...}` | Bold text in `\ThemeColorDark` |
| `\Pub{...}` | Italic text in `\CiteColor` (purple) for publication venue names |
| `\RDate{...}` | Right-aligned gray date, appended to the current line |
| `\link{url}{label}` | Inline external link button with an arrow icon |
| `\ThemeColor` / `\ThemeColorDark` | UCSD blue / navy; override with `\renewcommand` in `cv.tex` to change the color scheme |

### Publication lists

Conference papers use `\label{C:key}` / `[C\arabic*]` counters; journal papers use `\label{J:key}` / `[J\arabic*]`. Cross-references between sections use `\ref{C:key}` or `\ref{J:key}`.
