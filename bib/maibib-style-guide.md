# Style Guide for `maibiber.bib`

This documents the conventions this bibliography follows, evolved over the course of building and reconciling it. Apply these when adding, correcting, or reconciling any future entry.

## File organization

- Entries are grouped under `%% =====================  YYYY  =====================` headers, newest year first.
- Within a year, order follows MIT's own `explore/research` page listing order — not alphabetical, not by exact date.
- When an entry's *true* publication year differs from where the source page lists it (a preprint later published, a paper misfiled under the wrong year), the entry is dated correctly **and physically moved** to the correct year section — never left in the "wrong" section just because that's where the source put it.
- The same paper listed twice on MIT's own page (a "submitted"/"to appear" placeholder plus its final published version) becomes **one** entry using the final data, not two.
- Don't pull entries out of their correct year just to group them with thematically related ones elsewhere — grouping the ACM entries together broke this convention and had to be reverted.

## Citation keys

- All prefixed `mai:`.
- Pattern: `firstauthor-lastname` + `year` + a short keyword — **except theses**, where the keyword is replaced by the degree abbreviation (`meng`, `phd`, `ms`, `bah`, `minfo`) instead of a topic word.
- Renamed whenever: the true first author changed (author-order correction), the true year changed, or an existing thesis key was retrofitted to match the degree-suffix convention.
- Every rename requires a matching update to the `\autocite{}` call in `biblatex.tex` — flag this whenever a key changes.

## Author names

- Full names preferred over bare initials wherever confirmed by a real source.
- A name correction found via one paper (e.g., "Fang" → "Frances" Zhang, "Nicole" → "H. Nicole" Pang) gets **propagated** to that person's other appearances in the file, not just the triggering entry.
- File-wide majority form wins over a single outlier source — "Abelson, Hal" everywhere, even when one source says "H. Abelson."
- Author *order* can legitimately differ between preprint and final publication — trust the published version.

## Titles

- Kept in normal Title Case, never ALL-CAPS or forced lowercase — `biblatex-apa`'s sentence-casing algorithm needs ordinary-case input to correctly tell proper nouns from common words.
- Every word of a multi-word proper noun gets individually brace-protected — `{MIT} {A}pp {I}nventor`, not just `{MIT} App Inventor`.
- CamelCase compounds only need their specific capitals protected: `{C}loud{DB}`, `{P}rivacy{I}nformer`.
- A title that genuinely changed between preprint and publication uses the published version.
- Typos in the *source's own* metadata (IEEE's "humman-computer," ACM's "Proceeding" missing an "s") are corrected, not propagated.

## Quoting

- `\enquote{...}` (via `csquotes`), never raw backtick-quotes or literal curly-quote characters.

## Dates and venues

- `date` = actual publication date, regardless of which year-heading a source filed it under.
- `eventdate` + `eventtitle` for the conference itself, kept **distinct** from `date` when a paper's actual publication came later (e.g., a book chapter appearing months after the conference).
- `location` = publisher's place (Springer's "Berlin, Heidelberg," ACM's "New York, NY, USA"); `venue` = where the event actually happened. Split these properly rather than picking one.
- When a source contradicts itself on dates, trust the more specific sub-field over the vaguer one.

## URLs

- Every entry gets `url` + `urldate`.
- **Free access beats "official" access** — a ResearchGate or arXiv mirror is preferred over a paywalled IEEE/Springer link, even when the paywalled one is more "canonical."
- A real `doi` is kept regardless of which `url` we point to.
- Published-but-arXiv-sourced papers keep **both** the `eprint`/`eprinttype` fields and the full venue data.
- Google Drive links standardized to `drive.google.com/open?id=...` (confirmed to also work for Google Docs IDs).

## `note` vs. `annotation`

- `note`: renders in the printed bibliography — reserved for content a reader would find meaningful (status like "Demo abstract," "Poster," advisor credit, special-issue context).
- `annotation`: never renders — reserved for our own bookkeeping (sourcing decisions, verification status, discrepancies with the source page, key-naming rationale).
- A sentence doing both jobs gets **split**, not merged or discarded.
- Anything that only makes sense with reference to the file itself ("above," "this file") belongs in `annotation`, phrased for a future maintainer reading raw source.

## Entry-type choices

- `@misc` has no rendered `publisher` field — use `organization`, or switch type if `publisher` is genuinely right.
- `@incollection` (titled chapter, distinct editor) vs. `@inbook` (untitled excerpt).
- `@report` for term papers and informal institutional reports, with `type={Term Paper}`.

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
- A "stray junk" scan for text sitting outside any `@entry{}` block.
- Watch for str_replace boundary mistakes (deleting an adjacent entry's header while using it as a unique anchor) — catch immediately via the checks above, fix and acknowledge rather than silently patch.

## Scope discipline

- "Changing nothing else" is honored literally, even when a known bug sits right there waiting for a later, explicitly requested fix.
- A new "base" file is adopted as given, with any gap from more recent work flagged rather than silently reintroduced.

## Completeness auditing

- "Confirm we've done everything" means actually counting items per section against the live source, not just checking formatting on what's already there.
