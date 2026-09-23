#!/usr/bin/env python3
"""Publication metadata guard for the academic site."""
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
PUBS = ROOT / "_publications"
required = ["title", "authors", "year", "venue", "type_label", "category"]
allowed_categories = {"journal", "preprint", "note"}
errors = []
featured_records = []

for path in sorted(PUBS.glob("*.md")):
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        errors.append(f"{path.name}: missing YAML front matter")
        continue
    front = text.split("---", 2)[1]
    for key in required:
        if not re.search(rf"(?m)^{re.escape(key)}:\s*", front):
            errors.append(f"{path.name}: missing {key}")

    category_match = re.search(r'(?m)^category:\s*["\']?([^"\'\n]+)', front)
    if category_match and category_match.group(1).strip() not in allowed_categories:
        errors.append(f"{path.name}: unsupported category {category_match.group(1).strip()!r}")

    if "featured: true" in front:
        featured_records.append(path.name)

    if re.search(r"(?m)^arxiv_url:\s*", front) and not re.search(r"(?m)^arxiv_id:\s*", front):
        errors.append(f"{path.name}: arxiv_url requires arxiv_id")

    for key in ("code_url", "release_url"):
        match = re.search(rf'(?m)^{key}:\s*["\']?([^"\'\n]+)', front)
        if match and not match.group(1).strip().startswith("https://"):
            errors.append(f"{path.name}: {key} must use https://")

    if "scholar_index: true" in front:
        if not re.search(r"(?m)^citation_date:\s*", front):
            errors.append(f"{path.name}: Scholar-indexed page missing citation_date")
        if "pdf_local: true" in front:
            slug = path.stem
            pdf = ROOT / "publications" / slug / "paper.pdf"
            has_source = bool(re.search(r"(?m)^pdf_source_url:\s*\"?https?://", front))
            if pdf.exists():
                if pdf.stat().st_size > 5 * 1024 * 1024:
                    errors.append(f"{path.name}: local PDF exceeds Google Scholar's 5 MB guideline")
            elif not has_source:
                errors.append(
                    f"{path.name}: pdf_local=true requires either {pdf.relative_to(ROOT)} "
                    "or a pdf_source_url staged by the deployment workflow"
                )

if len(featured_records) > 1:
    errors.append(f"only one publication may be featured: {', '.join(featured_records)}")

if errors:
    print("Publication validation failed:")
    for e in errors:
        print(f" - {e}")
    sys.exit(1)
print(f"Validated {len(list(PUBS.glob('*.md')))} publication records.")
