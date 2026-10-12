# Style Guide for `dcpbib.bib`

This documents the conventions `dcpbib.bib` follows **as actually practiced**, including the legacy parts that do not yet follow them. It is the companion to `maibib-style-guide.md`. `dcpbib.bib` is the general bibliography (course readings, books, web pages, Wikipedia pages); it is loaded **before** `maibib.bib`, and keys must be unique across the two files.

These styles assume the `.tex` files include:
```tex
\usepackage[backend=biber,style=apa,annotation=false]{biblatex}
\usepackage{xurl}
\DeclareLanguageMapping{english}{english-apa}
```
Nothing in the file needs `hyperref` or `csquotes`; `xurl` must load *after* `biblatex`. `annotation=false` is required: `biblatex-apa` prints the `annotation` field by default, as a line under the reference.

## File organization

- A header comment states the required preamble ("Used with:" block, as above).
- Sections are introduced by one banner each: `%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NAME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%` (at least five `%` on each side). Current order: `6.S952`, `BOOKS`, `PAPERS`, `SOFTWARE`, `TEACHING`, `MATHEMATICS`, `WWW`, `WIKIPEDIA`.
- **Every entry belongs to the nearest banner above it**, so an entry sits where its banner puts it (`book:knr` is under `SOFTWARE`). To change an entry's section, move the entry.
- New course readings go under the `6.S952` banner in newest-last order. Other sections have no required order.
- **Comment lines directly above an entry belong to it and are kept** when the entry's code is edited or converted. Deleting an entry deletes its own comment line.
- Comments are never edited just to tidy them. Typical comments: a human-readable citation string (Wikipedia's "Cite this page" APA string, or an older APA line above a `web:` or `paper:` entry) and `TODO` notes.

## Citation keys

| Prefix | Used for | Shape |
|---|---|---|
| `wiki:` | Wikipedia and Wikibooks pages | topic slug: `wiki:carmichael-number` |
| `web:` | other web pages | slug: `web:ecs-v10` |
| `book:` | books | descriptive slug: `book:quantum-mechanics-and-experience`; a volume adds `-1` |
| `paper:` | papers and chapters | `paper:lastname_year`: `paper:bell_1992` |

- Tool-generated keys are replaced by the shapes above: DBLP's `DBLP:journals/corr/...` became `paper:gershenson_2003`; Wikipedia's `enwiki:<revision id>` became `wiki:<topic-slug>`.

## Entry types

- `@misc` for web pages; `@book`; `@article`; `@incollection` (a titled chapter in an edited volume, e.g. Everett 1973); `@inproceedings`. Entry types are lowercase.
- arXiv-only preprints are `@article` with `journal = {CoRR}`, the arXiv id as `volume`, and the abs page as `url`.
- **Roles stay distinct.** `author` / `editor` / `translator` are different fields: Euclid is the author, Densmore the editor, Heath the translator. A catalogue export that lists everyone as author is wrong; check the title page or a library (MARC) record.
- **Multi-volume works:** the whole set is one entry with `volumes = {1--2}` (prints "Vols. 1–2"). A single volume is `title` plus `subtitle = {Vol. 1. {T}wo-Spinor Calculus ...}`; the `maintitle` + `volume` form prints the volume number twice and leaves a stray space, so avoid it.
- **A part of an authored book** is cited through the volume: put the part in `note` (`Appendix: Diagrammatic notation, pp. 424--434`) and use the part's DOI if one exists.

## Names

- New entries use `Last, First`; corporate authors are braced (`{Center for Technology in Learning at SRI International}`). Legacy entries use `First Last` strings; both parse.
- English forms of ancient names (`Euclid`, not `Euclides`). Suffixes use the three-part form: `Everett, III, Hugh`.
- A name correction found in one entry is applied wherever that person appears.

## Titles

- Input in normal Title Case; `biblatex-apa` sentence-cases it. **A capital after a colon is automatic**; after a period, an em dash `---`, a `?` or a `;` the next word is lowercased, so protect it: `Vol. 1. {T}wo-Spinor ...`, `Quantum to Classical---{R}evisited`.
- Protect acronyms and proper nouns: `{IEEE}`, `{NAND}`, `{QED}`, `{F}eynman's`. When a Wikipedia topic moves into a title, protect its acronyms too (`{IEEE} 754`).
- **ASCII only** (the file has no non-ASCII characters). Apostrophes are plain `'` (never U+2019); an opening single quote is a backtick (`` `teacher copy' ``); dashes are `---`; page ranges use `--`. Accented letters use LaTeX escapes (`Cr\'epeau`).
- Typos in a source's own metadata are corrected, not copied.

## Dates

- `date` (ISO 8601, as precise as known) is preferred. Use `year` only when nothing more precise is known. All `wiki:` entries carry a full `date`.
- `urldate` is a **plain `YYYY-MM-DD`, never a time of day**: APA prints only the date, and hand-typed times proved unreliable. When a source stamps retrieval in UTC (Wikipedia), `urldate` is the date in that stamp. When adding an entry, use the date the user gives.
- **Chronology invariant:** a publication or revision date must not be later than `urldate`. A violation means a typo (it caught `wiki:plagiarism`: retrieved "June 27" before its July 22 revision).
- **`lastchecked` is not a biblatex field** (it comes from `urlbst`); biber ignores it and APA never prints it. Always use `urldate`.
- `version` is stored but not printed for `@misc`; do not use it to carry a date.

## URLs, DOIs and free copies

- Every `url` gets a `urldate`.
- **DOI plus free copy:** when a DOI exists, keep it *and* a `url` to a public copy with `urldate`. `biblatex-apa` prints only the DOI, so the free link is stored but hidden. Prefer free copies (arXiv, a university course page, an archive) over paywalled ones; never fabricate a DOI or a link.
- A `note` may explain a paywall (`Original publisher's copy is paywalled at \url{...}`).
- Books use `url = {https://isbn.nu/<isbn>}`, with an ISBN-10 or an ISBN-13 (`book:qed` uses the publisher's page).
- Wikipedia links are `https://en.wikipedia.org/w/index.php?title=X&oldid=N` permalinks; the `oldid` pins the exact revision.
- The place of publication is `location`.

## Wikipedia and Wikibooks entries (`wiki:`)

Source of truth is Wikipedia's own "Cite this page" APA string, kept as the comment above the entry. The entry is derived from it:

```bibtex
% Wikipedia contributors. (2019, February 18). Boolean algebra. In Wikipedia, The Free Encyclopedia. Retrieved 00:08, February 18, 2019, from https://en.wikipedia.org/w/index.php?title=Boolean_algebra&oldid=883953881
@misc{wiki:boolean-algebra,
    author  = {{Wikipedia contributors}},
    title   = {Boolean algebra --- {Wikipedia}{,} The Free Encyclopedia},
    date    = {2019-02-18},
    url     = {https://en.wikipedia.org/w/index.php?title=Boolean_algebra&oldid=883953881},
    urldate = {2019-02-18},
}
```

- `author` = `{Wikipedia contributors}`; `title` = `<topic> --- {Wikipedia}{,} The Free Encyclopedia`, where the topic is the article title **at that revision** (Nibble, not Nybble).
- `date` = the full revision date from the string's first parenthetical; `urldate` = the date of its "Retrieved" stamp; `url` = the https permalink from the string; no `month`, `day`, `lastchecked` or `year`.
- **Wikibooks pages** use `{Wikibooks contributors}` and `{Wikibooks}{,} The Free Textbook Project`, and may have an MLA-style comment:

```bibtex
% "Java Programming/Primitive Types." Wikibooks. 27 Nov 2018, 23:18 UTC. <https://en.wikibooks.org/w/index.php?title=Java_Programming/Primitive_Types&oldid=3491137> 18 Feb 2019, 00:40. 
@misc{wiki:java-primitive-types,
    author  = {{Wikibooks contributors}},
    title   = {Java Programming / Primitive Types --- {Wikibooks}{,} The Free Textbook Project},
    date    = {2018-11-27},
    url     = {https://en.wikibooks.org/w/index.php?title=Java_Programming/Primitive_Types&oldid=3491137},
    urldate = {2019-02-18},
}
```
- **Check:** every entry must agree with its own comment on date, `urldate`, URL and topic. The exceptions are `wiki:quantum-nonlocality` (no comment) and Wikibooks entries (their comments are MLA-style).
- Side effect: every entry shares the author "Wikipedia contributors", so entries cited together get year letters (2019a, 2019b ...) and in-text citations change.
- Verification is against the pasted comment strings, never against the live page.

## `note` and `annotation`

- `note` is reader-facing only. It prints in square brackets after the title. **No trailing period** (APA adds its own; a period inside prints as ".]."). Several sentences are joined with semicolons.
- Allowed in `note`: `\textcopyright{}`, `\url{...}` (biblatex always loads `url.sty`), `\emph{}`. Not allowed: `\href`, `\enquote` (they need `hyperref`/`csquotes`).
- Avoid `annotation`; it prints under APA unless `annotation=false`. Put provenance in a comment line above the entry instead. (Some entries could have annotations.)

## Formatting

The file has several legacy style families; **match the neighbouring entries** and do not reformat unrelated parts of an entry:

| Family | Style |
|---|---|
| `wiki:` | 4-space indent, `=` aligned |
| `web:` | 2-space indent |
| `paper:` | 2-space indent, mostly aligned |
| `book:` | 3-space indent, single space before `=` |

Field names and entry types are lowercase. Every value is brace-delimited (`{...}`, never double quotes), with one field per line and a closing brace on its own line. Indentation still differs by family, as above.

## Worked examples

```bibtex
@article{paper:deutsch_1985,
  author    = {Deutsch, David},
  title     = {Quantum Theory as a Universal Physical Theory},
  journal   = {International Journal of Theoretical Physics},
  volume    = {24},
  number    = {1},
  date      = {1985-01},
  pages     = {1--41},
  doi       = {10.1007/BF00670071},
  url       = {https://boulderschool.yale.edu/sites/default/files/files/Deutsch.pdf},
  urldate   = {2026-10-07},
}
```
```bibtex
@book{book:elements-one-volume,
   author = {Euclid},
   editor = {Densmore, Dana},
   translator = {Heath, Thomas Little},
   title = {Euclid's Elements: All Thirteen Books Complete in One Volume},
   edition = {2},
   publisher = {Green Lion Press},
   location = {Santa Fe, NM},
   date = {2003},
   isbn = {9781888009194},
   url = {https://isbn.nu/9781888009194},
}
```

## Workflow for a new or corrected entry

1. **Draft first; don't add until told.** Show the entry and how APA renders it (a test render with the preamble above).
2. Verify every field against a real source (publisher page, library/MARC record). **Report conflicts instead of choosing silently** (e.g. Google Books says 2002/2nd edition; the library record says the 2nd edition is 2003) and ask when the choice is the user's (which edition they hold).
3. Look for a free public copy and say what was and was not found.
4. Omit what cannot be verified (a DOI, a page range) and say so; never guess.
5. Insert where told ("ahead of X", "under the 6.S952 banner") with the user's `urldate`.
6. Change only what was asked; mention adjacent problems rather than fixing them.

## Access limitations

- `journals.aps.org`, `scientificamerican.com` and Wikipedia revision pages cannot be fetched; Google Books and other pages only when the user supplied the URL or it appeared in search results; image-only PDFs cannot be read.
- Document the limit and say what was inferred from where; do not work around it by guessing.

## Structural checks after every edit

- Entry count; braces balanced **outside comments** (count them there, so a stray brace in a comment cannot hide a real imbalance); stray text outside any entry; duplicate keys within the file and against `maibib.bib`.
- `biber --tool dcpbib.bib` with no warnings. A crash with exit code 25 and an empty `.blg` points to a corrupted biber cache, not the file: `rm -Rf "$(biber --cache)"`.
- Chronology (revision/publication date ≤ `urldate`); every `wiki:` entry versus its comment; ASCII only.
- A test render of each changed entry.

## Known gaps (not yet normalized)

- **Missing `urldate` on a `url`:** `paper:cornellhmm`, `paper:gershenson_2003`, `cacm:wing06`, and 8 books (`linear-algebra`, `middlemarch`, `stuck-in-the-shallow-end`, `elements-one-volume`, `grading-for-equity`, `standards-based-learning`, `ac`, `unfinished-game`).
- **No `url` at all:** 15 books.
- **Stray fields:** `abstract` (`cacm:wing06`), `howpublished` (`paper:sep-qm`), `version` (`web:ecs-v5` and `web:ecs-v10`, not printed), and one `annotation` (`paper:gershenson_2003`).
