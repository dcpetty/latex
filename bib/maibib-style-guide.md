# Style Guide for `maibib.bib`

This documents the conventions this bibliography follows, evolved over the course of building and reconciling it. Apply these when adding, correcting, or reconciling any future entry. These styles assume the .TEX files include:
```tex
\usepackage[backend=biber,style=apa,annotation=false]{biblatex} 
\usepackage{xurl}
\DeclareLanguageMapping{english}{english-apa}
```
- `annotation=false` is **required**: `biblatex-apa` prints the `annotation` field by default, as a line under the reference. The file's own bookkeeping lives in `annotation`, so without the option it would appear in the printed bibliography.
- `xurl` must load *after* `biblatex`. Nothing in the file needs `csquotes` or `hyperref`.
- *Snapshot when this was written (re-run the checks to refresh):* 119 entries — 62 `@inproceedings`, 30 `@thesis`, 12 `@report`, 9 `@article`, 4 `@unpublished`, 2 `@incollection`.

## File organization

- A header comment opens the file: a banner (`%%%%%%%%% MIT APP INVENTOR %%%%%%%%%`), a description, and the required preamble as a "Used with:" block (the three lines above).
- Entries are grouped under `%% =====================  YYYY  =====================` headers, newest year first.
- Within a year, order follows MIT's own `explore/research` page listing order — not alphabetical, not by exact date.
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

## Quoting and characters

- **The file is ASCII-only and contains no embedded LaTeX** (the exceptions are four `\texttt{}` in annotations, which never print).
- Double quotes are plain ``` ``like this'' ```; an opening single quote is a backtick (`` `x' ``). **No `\enquote{}`**, so `csquotes` is not required, and never literal curly-quote characters or other Unicode lookalikes: they look identical in review but are different characters (they once broke a `listings` block and invalidated Racket syntax).
- **No `\url{}`.** URLs written into a `note` or `annotation` are plain text.
- Bare text is not protected by `\url{}`, so special characters in `note`/`annotation` must be escaped: `\_` for an underscore (an unescaped one raises "Missing $" wherever the text is typeset), and likewise `\%`, `\#`, `\&`. Imported BibTeX is normalized the same way: strip its LaTeX.

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

- `note`: renders in the printed bibliography (in brackets after the title) — reserved for content a reader would find meaningful (status like "Demo abstract," "Poster," advisor credit, special-issue context).
- **A `note` has no trailing period** — APA adds its own, and a period inside prints as ".]." Several sentences are joined with semicolons.
- `annotation`: never printed **provided `annotation=false` is loaded** — reserved for our own bookkeeping (sourcing decisions, verification status, discrepancies with the source page, key-naming rationale).
- Because annotations are not printed, URLs inside them are bare text and would not wrap if the option were ever turned off: keep them out of `note`.
- A sentence doing both jobs gets **split**, not merged or discarded.
- Anything that only makes sense with reference to the file itself ("above," "this file") belongs in `annotation`, phrased for a future maintainer reading raw source.

## Entry-type choices

- `@inproceedings` for conference papers; `@article`; `@unpublished` for preprints, submitted work, demos and posters (with a `note` giving the status).
- `@thesis` always carries `type`: `mathesis` (M.Eng./M.S.), `bathesis`, or `phdthesis`; it prints as `[Master's thesis, <institution>]`. The key's degree suffix and the `type` agree.
- `@report` for term papers, student research papers and informal institutional reports. A `type` prints in parentheses after the title: term papers carry `type = {Term Paper}`, and Research Science Institute papers carry `type = {Research Paper}`. A genuine institutional report (the Technovation analysis) carries no `type`, because `@report` already says so.
- `@incollection` (titled chapter, distinct editor) vs. `@inbook` (untitled excerpt). Only `@incollection` is currently used.
- `@misc` has no rendered `publisher` field — use `organization`, or switch type if `publisher` is genuinely right. (No `@misc` entries at present.)

## Formatting

- Field lines are indented **4 spaces**, with every `=` at **column 17**: the longest field name in the vocabulary (`journaltitle`, 12 characters) plus one space. This holds for every field of every entry, even entries that lack that field.
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
- `biber --tool maibib.bib` with no warnings. A crash with exit code 25 and an empty `.blg` points to a corrupted biber cache, **not** the file: `rm -Rf "$(biber --cache)"`.
- Practice scans: no `note` ends in a period; no non-ASCII characters; no `\enquote`/`\url{`; no unescaped `_` outside `url`/`doi`/`eprint`; every `=` at column 17; every `urldate` a plain date; every `@thesis` has a `type`.
- Watch for str_replace boundary mistakes (deleting an adjacent entry's header while using it as a unique anchor) — catch immediately via the checks above, fix and acknowledge rather than silently patch.

## Scope discipline

- "Changing nothing else" is honored literally, even when a known bug sits right there waiting for a later, explicitly requested fix.
- A new "base" file is adopted as given, with any gap from more recent work flagged rather than silently reintroduced — or reapplied as an explicit, listed set of edits.

## Completeness auditing

- "Confirm we've done everything" means actually counting items per section against the live source, not just checking formatting on what's already there.
