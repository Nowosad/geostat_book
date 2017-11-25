#!/usr/bin/env Rscript
bookdown::render_book("index.Rmd")
bookdown::publish_book(name = "Geostatystyka", account = "nowosad", render = c("none"), server = "bookdown.org")
