# latex

LaTeX public documents, templates, [Biber](https://biblatex-biber.sourceforge.net/) files, and inputs.

## Directories

| Directories | Description |
| --- | --- |
| `bib` | Directory for [BibTeX](http://www.bibtex.org/) and [BibLaTeX](https://mirror.mwt.me/ctan/macros/latex/contrib/biblatex/doc/biblatex.pdf) files |
| `doc` | Directory for [my](https://github.com/dcpetty) working LaTeX documents |
| `images` | Directory for images used in LaTeX documents. |
| `input` | Directory for `\input` files used in LaTeX documents. |
| `templates` | Directory for template LaTeX documents of various kinds in various formats. |

## Files

| Files | Description |
| --- | --- |
| `Makefile` | [`gmake`](https://linux.die.net/man/1/gmake) file to build all .PDF files from LaTeX source. |
| `README.md` | This file. |
| `clean.sh` | A [`sh`](https://linux.die.net/man/1/sh) script to clean up LaTeX intermediate files. (Used by `clean` and `clean-pdf` `make` targets.) |
| `clean.bat` | A simple [`DOS`](https://www.lifewire.com/dos-commands-4070427) script to clean up LaTeX intermediate files. |

## Tools

`Makefile` (the single makefile in this project) has standard targets `all`, `clean`, and `clean-pdf`. The `all` target will build all `TEX_DIRS := doc/bhs doc/dlcs doc/gre doc/math doc/random doc/white-papers templates`. Each of these directories are also targets that can be built individually. `make clean` removes all LaTeX intermediate files in `$(TEX_DIRS)`. `make clean-pdf` additionally removes all .PDF files in `$(TEX_DIRS)` so they can be rebuilt. `make` is equivalent to `make all`. `make -s` will only echo directories and files being built.

`clean.sh` can be used standalone. Run by itself (`sh clean.sh`) it removes all LaTeX intermediate files in the current working directory (`.`) and below. Invoked with command-line arguments (*e.g.* `sh clean.sh -d templates pdf txt -v`) it starts at the directory specified by `-d` (*i.e.* `templates`), includes any additional globs (*i.e.* `*.pdf` &amp; `*.txt`), and (with `-v`) echoes all globs, whether or not there are matching files. The standard LaTeX intermediate files removed by `clean.sh` (and `clean.bat`) are those listed in [https://www.toptal.com/developers/gitignore/api/latex](https://www.toptal.com/developers/gitignore/api/latex).

## TODO

- Update all documents to use `\input` files.

<hr>

[&#128279; permalink](https://dcpetty.github.io/latex/) and [&#128297; repository](https://github.com/dcpetty/latex/) for this page.
