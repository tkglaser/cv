# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
make          # build PDF (default target)
make pdf      # build PDF (runs latexmk using xelatex, as configured in .latexmkrc)
make watch    # latexmk -pvc: continuously rebuild the PDF on save
make clean    # remove build artifacts (latexmk intermediates)
```

## Architecture

This is a single-file LaTeX CV built on the third-party [`moderncv`](https://github.com/moderncv/moderncv) document class (`contemporary` style, `cerulean` color) — there is no local `.cls` file.

- **`cv.tex`** — the CV content and all preamble configuration (fonts, color, margins, personal data). Edited directly to update everything.
- **`.latexmkrc`** — sets `$pdf_mode = 5` (xelatex), `$default_files = ('cv.tex')`, `$aux_dir = 'build'`, `$out_dir = 'dist'`. Intermediary files (aux, log, fls, etc.) go to `build/`; the final PDF goes to `dist/`.

### Fonts

Uses `fontspec` under xelatex with Latin Modern Roman/Sans/Mono/Math. Because fontconfig registers multiple ambiguous same-named optical-size variants of Latin Modern Sans/Roman, letting `\setmainfont`/`\setsansfont` resolve fonts by family name (even with an explicit `BoldFont={Family:style=...}` pattern) is unreliable: it can silently resolve to the *regular*-weight file with no warning and no error — `\textbf` then visibly does nothing. `build/cv.log` looks clean and `\tracingfonts`-free in this failure mode, so the only way to actually confirm bold is working is to check the embedded fonts in the built PDF, e.g. `pdffonts dist/cv.pdf` — a genuine `LMSans10-Bold-...` entry must be present, not just `LMSans10-Regular-...`.

The fix used here bypasses fontconfig family-name matching entirely and loads the exact `.otf` files by filename (resolved via kpathsea, so no hardcoded path): `\setmainfont{lmroman10-regular.otf}[...]` / `\setsansfont{lmsans10-regular.otf}[...]` with explicit `UprightFont`/`BoldFont`/`ItalicFont`/`BoldItalicFont` pointing at the sibling `lmroman10-*`/`lmsans10-*` filenames. Don't revert to bare family-name font loading (`\setsansfont{Latin Modern Sans}`) without re-verifying bold via `pdffonts`.

### moderncv commands used in `cv.tex`

| Command | Purpose |
|---|---|
| `\name`, `\title`, `\phone`, `\email`, `\social[platform]{handle}` | Header fields; set before `\makecvtitle` |
| `\cvitem{label}{text}` | Single-line label/value entry (e.g. Summary, Skills) |
| `\cventry{years}{title}{org}{location}{grade}{description}` | Experience/education entry |
| `\cvitemwithcomment{label}{value}{comment}` | Label/value/comment row (e.g. Languages) |
| `\cvskillentry*`/`\cvskillentry`, `\cvskillhead`, `\cvskilllegend*` | Skill matrix rows/header/legend |
| `\section[\faIcon{icon}]{Name}` | Section heading with a Font Awesome icon (via `fontawesome6`) |
| Plain `\textbf{...}` | Standard bold — `moderncv` doesn't define a custom bold command |

`\Csharp` is a locally-defined command (in `cv.tex`) that typesets a "C#" logo via `\resizebox`.
