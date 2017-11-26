#!/usr/bin/env Rscript
devtools::install_github("nowosad/geostatbook")
bookdown::render_book("index.Rmd")
