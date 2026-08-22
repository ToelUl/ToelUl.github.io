#!/usr/bin/env python3
"""Minimal publication metadata guard for the academic site."""
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
PUBS = ROOT / "_publications"
required = ["title", "authors", "year", "venue"]
errors = []

for path in sorted(PUBS.glob("*.md")):
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        errors.append(f"{path.name}: missing YAML front matter")
        continue
    front = text.split("---", 2)[1]
    for key in required:
        if not re.search(rf"(?m)^{re.escape(key)}:\s*", front):
            errors.append(f"{path.name}: missing {key}")
    if "scholar_index: true" in front:
        if not re.search(r"(?m)^citation_date:\s*", front):
            errors.append(f"{path.name}: Scholar-indexed page missing citation_date")
        if "pdf_local: true" in front:
            slug = path.stem
            pdf = ROOT / "publications" / slug / "paper.pdf"
            if not pdf.exists():
                errors.append(f"{path.name}: pdf_local=true but {pdf.relative_to(ROOT)} is missing")
            elif pdf.stat().st_size > 5 * 1024 * 1024:
                errors.append(f"{path.name}: local PDF exceeds Google Scholar's 5 MB guideline")

if errors:
    print("Publication validation failed:")
    for e in errors:
        print(f" - {e}")
    sys.exit(1)
print(f"Validated {len(list(PUBS.glob('*.md')))} publication records.")
