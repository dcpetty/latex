# Style Guide for `maibib.bib`

This documents the conventions this bibliography follows, evolved over the course of building and reconciling it. Apply these when adding, correcting, or reconciling any future entry. These styles assume the .TEX files include:
```tex
\usepackage[backend=biber,style=apa,annotation=false]{biblatex}
\usepackage{xurl}
\DeclareLanguageMapping{english}{english-apa}
```
- `annotation=false` is **required**: `biblatex-apa` prints the `annotation` field by default, as a line under the reference. The file's own bookkeeping lives in `annotation`, so without the option it would appear in the printed bibliography.
- `xurl` must load *after* `biblatex`. Nothing in the file needs `csquotes` or `hyperref`.

## File organization

The file has two parts, in this order: the **research papers**, then the **books**. Each part opens with a header comment and is divided into sections by banner comments.

- **Header comment.** Each part opens with a 70-character banner naming it, the name centered between runs of `%` with a space on each side (the extra `%` on the right when the split is odd): `%%%%%%%%%%%%%%%%%%%%% MIT APP INVENTOR RESEARCH %%%%%%%%%%%%%%%%%%%%%%`, and for the second part `%%%%%%%%%%%%%%%%%%%%%%% MIT APP INVENTOR BOOKS %%%%%%%%%%%%%%%%%%%%%%%`. A blank line follows, then a `%%` description of what the part holds and which MIT page it was compiled from (the books description also says how the ISBNs were checked), then the required preamble as a "Used with:" block (the three lines above).
- **Research part: date sections.** Entries are grouped under one header per publication year, newest year first: `%% =====================  2026  =====================`. Every entry sits under the year of its own `date`.
- **Books part: language sections.** Entries are grouped under one header per language, in the same form with the language in capitals: `%% ===================  ENGLISH  ====================`. The sections follow the order of MIT's `explore/books` page: ENGLISH, GERMAN, SPANISH, PORTUGUESE, INDONESIAN, ITALIAN, JAPANESE, KOREAN, MALAY, and RESEARCH, which holds the research volumes that page lists last. A book goes under the language it is written in, so its `langid` names its section; ENGLISH and RESEARCH hold entries with no `langid`.
- **Section banners.** Every section banner, whether a year or a language, is exactly 53 characters: `%%`, a space, the label with two spaces on each side, and `=` fill split evenly on both sides, with the extra `=` on the right when the split is odd.
- Within a section, order follows MIT's own page for that part: `explore/research` within a year, `explore/books` within a language. It is not alphabetical and not by exact date.
- When an entry's *true* publication year differs from where the source page lists it (a preprint later published, a paper misfiled under the wrong year), the entry is dated correctly **and physically moved** to the correct year section — never left in the "wrong" section just because that's where the source put it.
- The same paper listed twice on MIT's own page (a "submitted"/"to appear" placeholder plus its final published version) becomes **one** entry using the final data, not two.
- Don't pull entries out of their correct year just to group them with thematically related ones elsewhere — grouping the ACM entries together broke this convention and had to be reverted.

## Citation keys

- All prefixed `mai:`. Keys are unique within the file **and across `dcpbib.bib`**, which is loaded before it.
- Pattern: `firstauthor-lastname` + `year` + a short keyword — **except theses**, where the keyword is replaced by the degree abbreviation (`meng`, `phd`, `ms`, `bah`, `minfo`) instead of a topic word.
- Renamed whenever: the true first author changed (author-order correction), the true year changed, or an existing thesis key was retrofitted to match the degree-suffix convention.

## Author names

- Full names preferred over bare initials wherever confirmed by a real source.
- A name correction found via one paper (e.g., "Fang" → "Frances" Zhang, "Nicole" → "H. Nicole" Pang) gets **propagated** to that person's other appearances in the file, not just the triggering entry.
- File-wide majority form wins over a single outlier source — "Abelson, Hal" everywhere, even when one source says "H. Abelson."
- Author *order* can legitimately differ between preprint and final publication — trust the published version.

## Titles

- Kept in normal Title Case, never ALL-CAPS or forced lowercase — `biblatex-apa`'s sentence-casing algorithm needs ordinary-case input to correctly tell proper nouns from common words.
- Every word of a multi-word proper noun gets individually brace-protected — `{MIT} {A}pp {I}nventor`, not just `{MIT} App Inventor`. This applies to "App Inventor" on its own too; unprotected, it prints as "app inventor".
- Single-word proper nouns need protecting as well (`{T}echnovation`, `{S}alesforce`), and so do acronyms (`{AI}`, `{JSON}`, `{K-12}`).
- CamelCase compounds only need their specific capitals protected: `{C}loud{DB}`, `{P}rivacy{I}nformer`.
- A capital after a **colon** is automatic. After a period, an em dash, a `?` or a `;` the next word is lowercased, so protect it if it must stay capital.
- A title that genuinely changed between preprint and publication uses the published version.
- Typos in the *source's own* metadata (IEEE's "humman-computer," ACM's "Proceeding" missing an "s") are corrected, not propagated.
- **Translation notes:** the English translation of a non-English title goes in `note`, prefixed `Translation: ` (`note = {Translation: My first apps}`); it prints in square brackets, as APA marks a translated title. Anything else the note says follows the translation, joined by a semicolon. A note that only states a language, such as `In Indonesian`, is not a translation and takes no prefix.
- **Non-Roman scripts:** a title, name or publisher in a non-Roman script is romanized, because APA transliterates such titles in the reference list and this file is ASCII-only; the original script is not stored. The system depends on the language: **Chinese**, Pinyin; **Japanese**, modified Hepburn, with a braced macron for each long vowel (`Sh{\=o}ya`, `hajimey{\=o}`); **Korean**, Revised Romanization, South Korea's official system and plain ASCII (the Library of Congress uses McCune-Reischauer instead, which needs breves and apostrophes); **any other script**, the ALA-LC Romanization Table for that language. A romanized title is typed in sentence case (the first word and proper nouns capitalized, as `30-pun de tsukureru {A}ndroid apuri`), takes a `langid`, and has a `Translation: ` note (see above). Non-English titles in the Roman alphabet keep the capitalization the language uses.

## Quoting and characters

- **The file is ASCII-only and contains almost no embedded LaTeX**: the only commands allowed are `\url{...}` in a `note` or `annotation` (see below), braced accent escapes (see the next point), and four `\texttt{}` in annotations, which never print.
- **Accents:** accented letters are written as LaTeX escapes with the accent braced, the traditional BibTeX form: `G{\'o}mez`, `Sh{\=o}ya`, `Edi{\c{c}}{\~o}es Acad{\^e}micas`. Each escape sits in its own brace group, with its letter inside it. It is never left bare (`G\'omez`) and never replaced by a literal accented character, because the file is ASCII-only. The rule covers every field: author and publisher names, titles and notes, and the macrons of a Hepburn romanization.
- Double quotes are plain ``` ``like this'' ```; an opening single quote is a backtick (`` `x' ``). **No `\enquote{}`**, so `csquotes` is not required, and never literal curly-quote characters or other Unicode lookalikes: they look identical in review but are different characters (they once broke a `listings` block and invalidated Racket syntax).
- **`\url{...}` is allowed** in a `note` or `annotation`: biblatex always loads `url.sty`, so it needs no extra package. In a `note`, which prints, prefer it: with `xurl` loaded it breaks across lines where a bare URL does not. A bare URL in an `annotation` is also fine. Commands that need another package (`\href` needs `hyperref`, `\enquote` needs `csquotes`) stay forbidden.
- Bare text in a `note` or `annotation` is not protected, so its special characters must be escaped: `\_` for an underscore (an unescaped one raises "Missing $" wherever the text is typeset), and likewise `\%`, `\#`, `\&`. Inside `\url{...}` only `%` and `#` still need the backslash (`\%`, `\#`; unescaped they stop the build); `_`, `&`, `~`, `?` and `=` work as typed. Imported BibTeX is normalized the same way: strip its LaTeX, keeping only `\url{}` and the braced accent escapes (a bare escape such as `\'e` is braced, and a literal accented letter is replaced by its escape).

## Dates and venues

- `date` = actual publication date, regardless of which year-heading a source filed it under.
- `urldate` is a **plain ISO date (`YYYY-MM-DD`), never a time of day**: APA prints only the date, and hand-typed times proved unreliable.
- `eventdate` + `eventtitle` for the conference itself, kept **distinct** from `date` when a paper's actual publication came later (e.g., a book chapter appearing months after the conference).
- `location` = publisher's place (Springer's "Berlin, Heidelberg," ACM's "New York, NY, USA"); `venue` = where the event actually happened. Split these properly rather than picking one.
- When a source contradicts itself on dates, trust the more specific sub-field over the vaguer one.
- A publication date must never be later than `urldate`.

## URLs

- Every entry gets `url` + `urldate`. The few with no public link at all (6) carry an `annotation` explaining why.
- **Free access beats "official" access** — a ResearchGate or arXiv mirror is preferred over a paywalled IEEE/Springer link, even when the paywalled one is more "canonical."
- A real `doi` is kept regardless of which `url` we point to. **When both are present APA prints only the DOI**, so the free link is stored but hidden; it is visible only on entries with no DOI.
- Published-but-arXiv-sourced papers keep **both** the `eprint`/`eprinttype` fields and the full venue data.
- Google Drive links standardized to `drive.google.com/open?id=...` (confirmed to also work for Google Docs IDs). The old `/file/d/...` form appears only inside annotations that document MIT's own links.
- `lastchecked` is a `urlbst` field that biblatex does not know: never use it; `urldate` is the field.

## `note` vs. `annotation`

- `note`: renders in the printed bibliography (in brackets after the title) — reserved for content a reader would find meaningful (status like "Demo abstract," "Poster," "Invited talk," advisor credit, special-issue context).
- **A `note` has no trailing period** — APA adds its own, and a period inside prints as ".]." Several sentences are joined with semicolons.
- `annotation`: never printed **provided `annotation=false` is loaded** — reserved for our own bookkeeping (sourcing decisions, verification status, discrepancies with the source page, key-naming rationale).
- Keep URLs that only document sourcing in `annotation`, not `note`; a `note` takes a URL only when a reader would find it meaningful. Because annotations are not printed, a bare URL there is harmless, but writing it `\url{...}` keeps it correct and wrapping if the option is ever turned off.
- A sentence doing both jobs gets **split**, not merged or discarded.
- Anything that only makes sense with reference to the file itself ("above," "this file") belongs in `annotation`, phrased for a future maintainer reading raw source.

## Entry-type choices

The file uses eight entry types. Choose by what the work is, not by where MIT lists it. Fields are described in the next section.

- `@inproceedings`: a paper, abstract, poster or talk in conference proceedings. It carries `booktitle` (the proceedings) and, as the source gives them, `editor`, `series`, `volume`, `pages` and `doi`.
- `@article`: a journal article, with `journaltitle` and usually `volume`, `number` and `pages`.
- `@incollection`: a titled chapter in a book with a distinct editor, with `booktitle` (the book), `editor` and `publisher`. (`@inbook`, an untitled excerpt, is not used.)
- `@book`: an authored book, including books in other languages and self-published ones. It carries `publisher`, `isbn` and, when the book has one, `subtitle`. `date` is the year only, because APA prints only the year for a book. A non-English book also carries `langid` and a `Translation:` note (see Titles).
- `@collection`: an edited volume cited as a whole. It takes `editor` in place of `author` and is otherwise like `@book`, plus a `doi` when it has one.
- `@thesis`: always carries `type`: `mathesis` (M.Eng./M.S.), `bathesis`, or `phdthesis`, together with `institution`; it prints as `[Master's thesis, <institution>]`. The key's degree suffix and the `type` agree.
- `@report`: term papers, student research papers and informal institutional reports. A `type` prints in parentheses after the title: term papers carry `type = {Term Paper}`, and Research Science Institute papers carry `type = {Research Paper}`. A genuine institutional report (the Technovation analysis) carries no `type`, because `@report` already says so.
- `@unpublished`: preprints, submitted work, demos and posters, with a `note` giving the status.
- Not used: `@inbook`, and `@misc`, which has no rendered `publisher` field (use `organization`, or switch type if `publisher` is genuinely right).

## Fields

Thirty-two fields are in use. "Printed" says what `biblatex-apa` does with the field in the reference list (tested by removing the field from a real entry). Values are always brace-delimited, and field names are lowercase.

| Field | Used by | What it holds, and how it is written | Printed |
|---|---|---|---|
| `title` | every type | The title, in Title Case with proper nouns and acronyms braced (see Titles). | Yes, in sentence case |
| `subtitle` | `@book`, `@collection` | The part after the colon, under the same rules as `title`. | Yes, after a colon |
| `author` | every type except `@collection` | Names as `Last, First and Last, First`, full given names where a source confirms them. A whole-name or corporate author is double-braced: `{Wahana Komputer}`. | Yes |
| `editor` | `@collection`; `@incollection`, `@inproceedings` | Names in the same form as `author`. For a `@collection` it is the main credit; for a chapter or paper it is the volume's editor. | Yes, with "(Eds.)" |
| `date` | every type | Publication date as `YYYY`, `YYYY-MM`, `YYYY-MM-DD`, or a range `YYYY-MM-DD/YYYY-MM-DD`. Books carry the year only. | Yes |
| `booktitle` | `@inproceedings`, `@incollection` | The proceedings or book that contains the work. Acronyms are braced: `({ISLS} 2026)`. | Yes, after "In" |
| `journaltitle` | `@article` | The journal's name. The biblatex field is `journaltitle`, never `journal`. | Yes |
| `volume` | `@article`; some `@inproceedings`, `@incollection` | The volume number, including a series volume such as an LNCS number. | Yes |
| `number` | `@article`; one `@inproceedings` | The issue number. | Yes |
| `pages` | `@inproceedings`, `@article`, `@incollection` | A page range with a single hyphen (`375-387`), which biblatex prints as an en dash. An ACM article-and-page form is kept as the source gives it (`239:1-239:12`). | Yes |
| `articleno` | `@inproceedings` | The article number an ACM source gives. | No |
| `numpages` | `@inproceedings`, `@article` | The page count a source gives, as a whole number. | No |
| `publisher` | `@book`, `@collection`, `@incollection`, `@inproceedings`, `@article` | The publisher's name as the source gives it. | Only for `@book`, `@collection`, `@incollection` |
| `location` | `@thesis`, `@inproceedings`, `@report`, `@book`, `@collection`, `@article`, `@incollection` | The publisher's or institution's place (see Dates and venues). | Only for `@report` |
| `institution` | `@thesis`, `@report` | The degree-granting or issuing institution. | Yes: inside the thesis bracket, and as the publisher of a report |
| `type` | `@thesis`, `@report` | A thesis: `mathesis`, `bathesis` or `phdthesis`. A report: `Term Paper` or `Research Paper`, or none. | Yes: the thesis bracket, or parentheses after a report's title |
| `series` | `@inproceedings`, `@incollection`, `@book` | The book series (`Lecture Notes in Computer Science`, `Dummies Junior`) or the series label an ACM source gives (`{SIGCSE} 2023`). | No |
| `isbn` | `@book`, `@collection`, `@incollection`, `@inproceedings` | The ISBN-13, written as digits only. | No |
| `issn` | `@article`, `@inproceedings`, `@incollection` | The journal's or series' ISSN, as `NNNN-NNNN`. | No |
| `doi` | `@inproceedings`, `@article`, `@incollection`, `@collection` | A bare DOI without `https://doi.org/`. When present, APA prints it in place of the `url` (see URLs). | Yes |
| `eprint` | `@inproceedings`, `@unpublished` | The arXiv identifier, such as `2604.07601`. Always paired with `eprinttype`. | No |
| `eprinttype` | `@inproceedings`, `@unpublished` | Always `arxiv`. | No |
| `url` | every type except the six with no public link | The public link, free access preferred (see URLs). | Yes, as "Retrieved ... from" |
| `urldate` | every entry that has a `url` | The date the link was checked, as a plain ISO date. | Yes, as the retrieval date |
| `venue` | `@inproceedings`, `@incollection` | Where the event took place, as a city (see Dates and venues). | No |
| `eventtitle` | `@incollection` | The event's name (`{HCI} International 2026`), paired with `eventdate`. | No |
| `eventdate` | `@incollection` | The event's dates, as a range, when they differ from `date`. | No |
| `addendum` | `@thesis` | Text appended to the end of the reference; the one use is a thesis supervisor credit. | Yes, at the very end |
| `note` | any type | Reader-facing text (see `note` vs. `annotation`). | Yes, in brackets after the title |
| `annotation` | any type | Our own bookkeeping (see `note` vs. `annotation`). | Never, with `annotation=false` |
| `keywords` | `@inproceedings`, `@article` | The source's own keywords, copied as the source writes them (comma- or semicolon-separated). | No |
| `langid` | `@book` | The language of a non-English entry: `german`, `spanish`, `portuguese`, `indonesian`, `italian`, `japanese`, `korean`, `malay`. It is not printed, but it stops APA from re-casing the title (without it "Meine ersten Apps" prints as "Meine ersten apps"). It goes with a `Translation:` note. | No, but it protects the title's capitals |

## Formatting

- Field lines are indented **2 spaces**, with every `=` at **column 15**: the longest field name in the vocabulary (`journaltitle`, 12 characters) plus one space. This holds for every field of every entry, even entries that lack that field.
- Values use `{braces}`, field names are lowercase, and the closing brace is on its own line.

## Reconciliation workflow (when a real external citation turns up)

- Check *every* field against the existing entry — this is how missing co-authors, wrong given names, and wrong titles get caught, not just missing fields.
- Correct the source's own errors rather than copy them forward.
- Mark a genuine merge with `} % URI has BibTeX citation adapted here` on the closing brace — a standing instruction once established, not asked each time.
- Never add that marker for a citation-check that failed or just confirmed existing data.

## Access limitations — documented, never worked around by guessing

- `dl.acm.org`, `ieeexplore.ieee.org`, `cacm.acm.org` block automated fetches outright.
- Springer, arXiv, and most OJS "Cite" buttons are JS-rendered and invisible to a static fetch.
- Some downloads resolve but return unreadable binary — entry built from page metadata instead, documented either way.
- Never fabricate a citation when verification fails.

## Structural integrity checks, after *every* edit

- Entry count and brace balance (`{` = `}`) — catches accidental entry loss instantly.
- A "stray junk" scan for text sitting outside any `@entry{}` block, and no `@` in the header comment.
- Duplicate keys within the file and against `dcpbib.bib`.
- Section comments: both header banners are 70 characters and every section banner is exactly 53; the research years descend and each research entry's `date` year matches its banner; the books sections follow MIT's page order and each book's `langid` matches its section (none for ENGLISH and RESEARCH).
- `biber --tool maibib.bib` with no warnings. A crash with exit code 25 and an empty `.blg` points to a corrupted biber cache, **not** the file: `rm -Rf "$(biber --cache)"`.
- Practice scans: no `note` ends in a period; no non-ASCII characters; every accent escape braced (`{\'e}`, never `\'e`); no `\enquote`, and no LaTeX command in a `note` or `annotation` other than `\url{}`, braced accent escapes and the four `\texttt{}`; no unescaped `_` outside the `url`/`doi`/`eprint` fields and `\url{}`; no unescaped `%` or `#` anywhere outside those fields; every field line indented 2 spaces with its `=` at column 15; every `urldate` a plain date; every `note` that translates a title starts with `Translation: `; every title with a `langid` of `japanese`, `korean` or `chinese` is in sentence case; no line ends in whitespace; every `@thesis` has a `type`.
- Watch for str_replace boundary mistakes (deleting an adjacent entry's header while using it as a unique anchor) — catch immediately via the checks above, fix and acknowledge rather than silently patch.

## Scope discipline

- "Changing nothing else" is honored literally, even when a known bug sits right there waiting for a later, explicitly requested fix.
- A new "base" file is adopted as given, with any gap from more recent work flagged rather than silently reintroduced — or reapplied as an explicit, listed set of edits.

## Completeness auditing

- "Confirm we've done everything" means actually counting items per section against the live source, not just checking formatting on what's already there.
