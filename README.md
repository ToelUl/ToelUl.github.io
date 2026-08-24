# Qian-Rui Lee — Academic Homepage

[![Deploy academic site to GitHub Pages](https://github.com/ToelUl/ToelUl.github.io/actions/workflows/pages.yml/badge.svg)](https://github.com/ToelUl/ToelUl.github.io/actions/workflows/pages.yml)
[![Validate academic metadata](https://github.com/ToelUl/ToelUl.github.io/actions/workflows/validate.yml/badge.svg)](https://github.com/ToelUl/ToelUl.github.io/actions/workflows/validate.yml)

**Academic website:** https://toelul.github.io/

Source repository for my academic homepage. The site presents my research in theoretical and computational physics, quantum many-body systems, machine learning for physics, geometric and mathematical physics, and scientific computing.

**Academic profiles:** [Google Scholar](https://scholar.google.com/citations?user=0kikVlsAAAAJ) · [ORCID](https://orcid.org/0009-0009-2250-2419) · [GitHub](https://github.com/ToelUl)

## Research focus

My work centers on using physical and mathematical structure—symmetry, geometry, locality, constraints, and scaling—to make difficult problems more interpretable and computationally tractable. Current themes include:

- quantum many-body physics, critical phenomena, and quantum geometry;
- generative modeling and Flow Matching for physical systems;
- equivariant learning and lattice gauge structure;
- geometric formulations of field theory and gravity;
- GPU-accelerated simulation and scientific-computing tools.

## Site contents

| Section | Purpose |
| --- | --- |
| [Research](https://toelul.github.io/research/) | Research directions with links to related papers, notes, and software. |
| [Publications](https://toelul.github.io/publications/) | Peer-reviewed articles, preprints, and technical notes with stable landing pages. |
| [Notes](https://toelul.github.io/notes/) | Technical, pedagogical, and working lecture notes kept distinct from journal publications. |
| [Software](https://toelul.github.io/software/) | Selected research software organized by scientific purpose. |
| [CV](https://toelul.github.io/cv/) | Web-based academic CV generated from the same structured content. |

## Scholarly publishing and indexing

Publication pages are designed as stable scholarly landing pages rather than simple file listings. Each record can expose:

- explicit publication status (`journal`, `preprint`, or `note`);
- DOI, arXiv, Zenodo, and source-code links where applicable;
- Highwire-style `citation_*` metadata for scholarly crawlers;
- `ScholarlyArticle` structured data for general search engines;
- a directly visible abstract without client-side rendering;
- same-site full-text PDF URLs for selected works when appropriate.

For the ADM-to-Ashtekar technical note, the canonical PDF remains in [`ToelUl/adm-to-ashtekar-notes`](https://github.com/ToelUl/adm-to-ashtekar-notes). The Pages workflow stages that file into the deployed scholarly landing-page directory, avoiding a second manually maintained source copy while preserving a same-site PDF URL for indexing.

## Architecture

The site is deliberately lightweight and static:

- **Jekyll** for templating and content collections;
- **GitHub Pages** for hosting;
- **GitHub Actions** for validation, build, PDF staging, and deployment;
- **YAML front matter** as the publication metadata source of truth;
- **static HTML navigation** with no JavaScript dependency for discovering scholarly content.

The main content model is organized around `_publications/`, `_data/`, and reusable layouts/includes. Research pages, publication indexes, notes, the web CV, citation metadata, and the sitemap are generated from the same structured records.

## Maintaining publication records

Each scholarly work is represented by one file in `_publications/`. Publication status is explicit rather than inferred:

- `journal` — peer-reviewed journal article;
- `preprint` — public preprint not represented as a journal publication;
- `note` — technical or pedagogical note.

Before merging publication changes, run:

```bash
python scripts/validate_publications.py
```

The same check runs automatically in GitHub Actions. The validator checks required bibliographic fields, publication status, Scholar-facing metadata, and the configuration of deployment-managed PDFs.

## Repository structure

```text
_data/          Academic profile and software metadata
_includes/      Reusable site components
_layouts/       Page and publication layouts
_publications/  Structured scholarly records
assets/         Site styles and static assets
scripts/        Metadata validation utilities
.github/        Validation and GitHub Pages workflows
```

The implementation favors long-term maintainability, explicit scholarly metadata, and crawler-friendly static pages over dynamic widgets or presentation-heavy dependencies.
