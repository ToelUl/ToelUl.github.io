---
title: "CV"
permalink: /cv/
---
# Curriculum vitae

## Current position

**PhD Student in Physics**  
Department of Physics, National Tsing Hua University, Hsinchu, Taiwan

## Research areas

Quantum many-body physics; critical phenomena; machine learning for physics; generative modeling; lattice field theory; geometric and mathematical physics; scientific computing.

## Selected publications

{% assign selected = site.publications | where: 'selected', true | sort: 'year' | reverse %}
{% for pub in selected %}
- **{{ pub.title }}** — {{ pub.authors | join: ', ' }}. {{ pub.venue }}, {{ pub.year }}.
{% endfor %}

## Selected software

{% assign software = site.data.software | where: 'selected', true %}
{% for item in software %}
- **[{{ item.name }}]({{ item.url }})** — {{ item.description }}
{% endfor %}

{% if site.data.profile.cv_pdf != '' %}[Download PDF CV]({{ site.data.profile.cv_pdf }}){% endif %}
