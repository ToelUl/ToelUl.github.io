# Qian-Rui Lee — Academic Homepage

Minimal academic GitHub Pages site designed around three goals:

1. a canonical academic identity page;
2. a maintainable publication / research / software hub;
3. Google Scholar-friendly landing pages for scholarly works.

## Deployment

Create a public repository named `ToelUl.github.io`, upload this repository content to its `main` branch, then go to **Settings → Pages → Build and deployment → Source → GitHub Actions**. The included workflow builds the Jekyll site and deploys it to `https://toelul.github.io/`.

## Identity fields to fill

Edit `_data/profile.yml` and add your public Google Scholar URL, ORCID URL, email, and PDF CV URL when ready. Empty values are intentionally hidden from the rendered site.

## Google Scholar test case

`_publications/2026-adm-ashtekar.md` is configured as the first Scholar-indexing test case. It contains the exact title, author, date, DOI, and author-written abstract from the source note.

The site currently does **not** emit `citation_pdf_url` for this record because Google Scholar requires the PDF referenced by that tag to reside in the same subdirectory as the abstract page. To enable the strongest configuration:

1. copy the note PDF to `publications/2026-adm-ashtekar/paper.pdf`;
2. change `pdf_local: false` to `pdf_local: true` in `_publications/2026-adm-ashtekar.md`;
3. run `python scripts/validate_publications.py`;
4. commit and push.

The generated page will then expose an absolute `citation_pdf_url` pointing to:

`https://toelul.github.io/publications/2026-adm-ashtekar/paper.pdf`

## Publication data model

Each record in `_publications/` is the single source of truth for its title, authors, date/year, venue, DOI/arXiv/Zenodo links, abstract, selection status, and Scholar-indexing flags. The home page, publication index, note index, citation meta-tags, and sitemap are all generated from these records.

## Design constraints

- static HTML first; no client-side navigation dependency;
- one muted accent color and typography-led layout;
- every scholarly work has its own URL;
- abstracts are visible without JavaScript or user interaction;
- no automatic citation counts or brittle third-party widgets;
- research software is curated by scientific purpose, not repository stars.
