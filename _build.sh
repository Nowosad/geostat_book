#!/usr/bin/env Rscript
if (!require(Cairo)) install.packages("Cairo")
if (!require(bookdown)) install.packages("bookdown")
bookdown::render_book("index.Rmd", output_format = "bookdown::pdf_book")
# bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook", clean = FALSE)
bookdown::render_book("index.Rmd", output_format = "bookdown::bs4_book", clean = FALSE)
