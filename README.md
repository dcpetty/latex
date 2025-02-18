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
| `Makefile` | [`gmake`](https://linux.die.net/man/1/gmake) file to build all .PDF files from LaTeX source using [`latexmk`](https://www.cantab.net/users/johncollins/latexmk/). |
| `README.md` | This file. |
| `clean.py` | A [Python](https://docs.python.org/3/) script to clean up LaTeX intermediate files. (Used by `clean` and `clean-pdf` `make` targets.) |

## Tools

`Makefile` (the single makefile in this project) uses [`latexmk`](https://www.cantab.net/users/johncollins/latexmk/) that '*&hellip;is a perl script for running LaTeX the correct number of times to resolve cross references, etc; it also runs auxiliary programs (bibtex, makeindex if necessary, and dvips and/or a previewer as requested).*' `Makefile` has standard targets `all`, `clean`, and `clean-pdf`. 

- The `all` target (default) will build all directories in `DIRS ?= doc/apcs doc/bhs doc/dlcs doc/gre doc/math doc/random doc/white-papers templates`. Each of these directories are also targets that can be built individually. 
- `make clean` removes all LaTeX intermediate files in `$(DIRS)`. `make clean-pdf` additionally removes all .PDF files in `$(DIRS)` so they can be rebuilt. 
- `make DIRS=example` will build any of the `example` directories in `$(DIRS)` (or `$(OTHER)`).
- `make` is equivalent to `make all`. `make -s` will only echo directories and files being built.

`Makefile` can also build other directories (not under source control).

- The `other` target will build all directories in <code>OTHER ?= apcs apcsp correspondence cv ga harvard-dce ia ig jobs pc1 princeton psb robotics stanford-logic uml wps MassBay</code>. Each of these directories are also targets that can be built individually.
- `make clean-all` removes all LaTeX intermediate files in `$(DIRS) $(OTHER)`. `make clean-all-pdf` additionally removes all .PDF files in `$(DIRS) $(OTHERS)` so they can be rebuilt. 


It is possible to clean up intermediate files after making with `latexmk -c -cd` or `latexmk -C -cd` (which includes 'dvi, postscript and pdf files'), but *files would all be rebuilt in the process*.

The `make clean*` targets use `clean.py`. The `clean.py` command-line options are listed below.

<pre>~ % <span style="color: green;">python3 clean.py -h</span>
usage: clean.py [-h] [-e EXT] [-n] [-v] [files ...]

Delete extraneous TeX files from subdirectories.

positional arguments:
  files              .TEX files to clean.

options:
  -h, --help         show this help message and exit
  -e EXT, --ext EXT  Extension(s) to add to .gitignore extension list.
  -n, --dry-run      Log file removal without actual file deletion.
  -v, --verbose      Print verbose output.</pre>

Removed intermediate files corresponding to the .TEX `files` are those `.gitignore` files listed in [https://www.toptal.com/&#8203;developers/&#8203;gitignore/&#8203;api/&#8203;latex](https://www.toptal.com/developers/gitignore/api/latex) and those added with (zero or more) `-e EXT` command-line options.

## TODO

- Update all documents to use `\input` files.

<hr>

[&#128279; permalink](https://dcpetty.dev/latex/) and [&#128297; repository](https://github.com/dcpetty/latex/) for this page.
