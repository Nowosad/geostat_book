#!/usr/bin/env Rscript
if (!require(bookdown)) install.packages("bookdown")
bookdown::render_book("index.Rmd")
