---
title: "CV"
permalink: /cv/
description: "Web CV of Qian-Rui Lee, PhD student in physics at National Tsing Hua University."
---
# Curriculum vitae

## Current position

**PhD Student in Physics**  
Department of Physics, National Tsing Hua University, Hsinchu, Taiwan

## Research profile

Theoretical and computational many-body physics; critical phenomena; machine learning for physics; generative modeling and scientific sampling; quantum and geometric structures; lattice field theory; scientific computing.

## Academic profiles

- [Google Scholar]({{ site.data.profile.google_scholar }})
- [ORCID]({{ site.data.profile.orcid }})
- [GitHub]({{ site.data.profile.github }})
- [LinkedIn]({{ site.data.profile.linkedin }})

## Publications & preprints

{% assign research_outputs = site.publications | where_exp: 'pub', "pub.category != 'note'" | sort: 'year' | reverse %}
{% for pub in research_outputs %}
- **[{{ pub.title }}]({{ pub.url | relative_url }})** — {{ pub.authors | join: ', ' }}. {{ pub.type_label }}, {{ pub.venue }}, {{ pub.year }}.
{% endfor %}

## Technical & pedagogical notes

{% assign notes = site.publications | where: 'note', true | sort: 'year' | reverse %}
{% for pub in notes %}
- **[{{ pub.title }}]({{ pub.url | relative_url }})** — {{ pub.venue }}, {{ pub.year }}.
{% endfor %}

## Selected research software

{% assign software = site.data.software | where: 'selected', true %}
{% for item in software %}
- **[{{ item.name }}]({{ item.url }})** — {{ item.description }}
{% endfor %}

{% if site.data.profile.cv_pdf != '' %}[Download PDF CV]({{ site.data.profile.cv_pdf }}){% endif %}
