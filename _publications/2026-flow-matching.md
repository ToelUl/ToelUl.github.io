---
title: "Efficient identification of critical regions via Flow Matching–based Monte Carlo initialization"
authors:
  - "Qian-Rui Lee"
  - "Daw-Wei Wang"
year: 2026
type_label: "Journal article"
venue: "Machine Learning: Science and Technology"
journal: "Machine Learning: Science and Technology"
doi: "10.1088/2632-2153/ae9690"
doi_url: "https://doi.org/10.1088/2632-2153/ae9690"
arxiv_url: "https://arxiv.org/abs/2508.15318"
github_url: "https://github.com/ToelUl/Flow-to-Field"
pdf_local: false
scholar_index: false
selected: true
---
Markov-chain Monte Carlo becomes costly when equilibration must be repeated across temperatures and lattice sizes, particularly near critical regions. This work develops a conditional Flow Matching model as a reusable, physically informed initializer for downstream Monte Carlo simulations. A single model trained on small 2D XY lattices is reused across unseen temperatures and lattice sizes, with the intended workflow being Flow Matching followed by equilibrium MCMC rather than replacement of MCMC.
