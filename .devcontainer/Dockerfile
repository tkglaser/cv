FROM mcr.microsoft.com/devcontainers/base:ubuntu26.04

RUN apt-get update && apt-get install -y perl wget curl libfontconfig1 fontconfig git pandoc make && \
    apt-get clean

# Install TinyTeX as the non-root "vscode" user (the devcontainer's runtime
# user) so its ~/.TinyTeX install dir is owned by and reachable by that user
# directly, without needing sudo for every latexmk/xelatex/tlmgr invocation.
USER vscode

RUN wget -qO- "https://yihui.name/gh/tinytex/tools/install-unx.sh" | sh

ENV PATH="${PATH}:/home/vscode/bin"

RUN tlmgr install xcolor pgf fancyhdr parskip babel-english units lastpage \
    mdwtools comment fontawesome fontawesome6 libertine mathtools enumitem \
    titlesec adjustbox moderncv qrcode tikzmark amsmath \
    lm lm-math unicode-math

USER root

# Make TinyTeX fonts visible to fontconfig (needed by XeTeX for font-by-name lookup)
# TinyTeX doesn't ship texlive-fontconfig.conf, so write one manually.
RUN printf '<?xml version="1.0"?>\n<!DOCTYPE fontconfig SYSTEM "fonts.dtd">\n<fontconfig>\n  <dir>/home/vscode/.TinyTeX/texmf-dist/fonts/opentype</dir>\n  <dir>/home/vscode/.TinyTeX/texmf-dist/fonts/truetype</dir>\n  <dir>/home/vscode/.TinyTeX/texmf-dist/fonts/type1</dir>\n</fontconfig>\n' > /etc/fonts/conf.d/09-texlive-fonts.conf && \
    fc-cache -fsv

USER vscode

# Install Claude Code as vscode too, for the same reason as TinyTeX above:
# the installer drops its binary/config under $HOME, which needs to be
# vscode's home for the CLI to be usable without sudo.
RUN curl -fsSL https://claude.ai/install.sh | bash
