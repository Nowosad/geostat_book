#!/usr/bin/env Rscript
if (!require(Cairo)) install.packages("Cairo")
if (!require(bookdown)) install.packages("bookdown")
bookdown::render_book("index.Rmd")
