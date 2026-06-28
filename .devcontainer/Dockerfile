# FROM danteev/texlive

# # Install tools
# RUN pip install arxiv-latex-cleaner==0.1.* pdflinkchecker-cli==0.2.* --break-system-packages

# Installs Xelatex and all Google Web Fonts. A curated selection of the finest
# open fonts.

FROM ubuntu:resolute

WORKDIR /var/local

# combine into one run command to reduce image size
RUN apt-get update && apt-get install -y perl wget curl libfontconfig1 git pandoc make && \
    wget -qO- "https://yihui.name/gh/tinytex/tools/install-unx.sh" | sh  && \
    apt-get clean
RUN curl -fsSL https://claude.ai/install.sh | bash
ENV PATH="${PATH}:/root/bin:/root/.local/bin"
RUN tlmgr install xetex
RUN fmtutil-sys --all

# install only the packages you need
# this is the bit which fails for most other methods of installation
RUN tlmgr install xcolor pgf fancyhdr parskip babel-english units lastpage \
    mdwtools comment fontawesome libertine mathtools enumitem titlesec adjustbox
# genmisc