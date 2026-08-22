# Qian-Rui Lee — Academic Homepage

Minimal academic GitHub Pages site designed around three goals:

1. a canonical academic identity page;
2. a maintainable research / publication / software hub;
3. Google Scholar-friendly landing pages for scholarly works.

## Deployment

The site is deployed from `main` with GitHub Actions to `https://toelul.github.io/`. The Pages workflow builds Jekyll, stages any deployment-managed scholarly PDFs, uploads the Pages artifact, and deploys it to the `github-pages` environment.

## Academic identity

Canonical public profile links are stored in `_data/profile.yml`. Google Scholar, ORCID, GitHub, and LinkedIn are currently linked. Contact email and a downloadable PDF CV remain intentionally unset until a public version is chosen.

## Publication model

Each record in `_publications/` is the single source of truth for its title, authors, date/year, publication status, venue, DOI/arXiv/Zenodo links, abstract, selection status, and Scholar-indexing flags.

Publication categories are intentionally explicit:

- `journal` — peer-reviewed journal articles;
- `preprint` — public preprints not represented as journal publications;
- `note` — technical or pedagogical notes.

The home page, publication index, note index, web CV, Highwire citation meta-tags, structured data, and sitemap are generated from these records.

Run the metadata guard before publication changes:

```bash
python scripts/validate_publications.py
```

## Google Scholar test case

`_publications/2026-adm-ashtekar.md` is the first dedicated Scholar-indexing test case. It uses the exact title, author, date, DOI, and author-written abstract from the source note.

The canonical source PDF remains in `ToelUl/adm-to-ashtekar-notes`. During Pages deployment the workflow stages that PDF into the generated artifact at:

`https://toelul.github.io/publications/2026-adm-ashtekar/paper.pdf`

The landing page therefore emits a same-site `citation_pdf_url` without requiring a second manually maintained PDF copy in this repository.

## Design constraints

- static HTML first; no client-side navigation dependency;
- one muted accent color and typography-led layout;
- every scholarly work has its own stable landing page;
- publication status is explicit rather than inferred;
- abstracts are visible without JavaScript or user interaction;
- no automatic citation counts or brittle third-party widgets;
- research software is curated by scientific purpose, not repository stars.
