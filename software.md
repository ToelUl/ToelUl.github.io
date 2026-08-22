---
title: "Software"
permalink: /software/
---
# Research software

These repositories are presented by scientific purpose rather than by GitHub activity metrics.

{% for item in site.data.software %}
## [{{ item.name }}]({{ item.url }})

{{ item.description }}

<span class="tags">{{ item.tags | join: " · " }}</span>
{% endfor %}
